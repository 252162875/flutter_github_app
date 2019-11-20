import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_github_app/common/Global.dart';
import 'package:flutter_github_app/models/Repo.dart';
import 'package:flutter_github_app/models/User.dart';

class Git {
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio =
      new Dio(BaseOptions(baseUrl: 'https://api.github.com/', headers: {
    HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
        "application/vnd.github.symmetra-preview+json",
  }));

  static void init() {
    dio.interceptors.add(Global.netCache);
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
//    if (!Global.isRelease) {
//      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//          (client) {
//        client.findProxy = (uri) {
//          return "PROXY 10.95.241.180:8888";
//        };
//        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
//        client.badCertificateCallback =
//            (X509Certificate cert, String host, int port) => true;
//      };
//    }
  }

  Future<User> login(String login, String pwd) async {
    String basic = "Basic " + base64.encode(utf8.encode("$login:$pwd"));
    var r = await dio.get(
      "/users/$login",
      options: _options.merge(
          headers: {HttpHeaders.authorizationHeader: basic},
          extra: {"noCache": true}),
    );
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.netCache.cache.clear();
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  Future<List<Repo>> getRepo(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>("user/repos",
        queryParameters: queryParameters, options: _options);
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }
}
