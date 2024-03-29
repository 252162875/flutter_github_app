import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github_app/common/CacheObject.dart';
import 'package:flutter_github_app/common/GitApi.dart';
import 'package:flutter_github_app/models/CacheConfig.dart';
import 'package:flutter_github_app/models/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile(null, "", 0xFF1E88E5, null, "", "");

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.get("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig(true, 3600, 100);
    Git.init();
  }

  static saveProfile() {
    _prefs.setString("profile", jsonEncode(profile.toJson()));
  }
}
