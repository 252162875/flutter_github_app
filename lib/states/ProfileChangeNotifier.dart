import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_github_app/common/Global.dart';
import 'package:flutter_github_app/models/Profile.dart';
import 'package:flutter_github_app/models/User.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  bool get isLogin => user != null;

  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  ColorSwatch get theme =>
      Global.themes.firstWhere((e) => e.value == _profile.theme,
          orElse: () =>
              Colors.blue); //.firstWhere满足条件的第一个元素,这个orElse:不知道什么意思~~~后面再看
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  Locale getLocale() {
    if (_profile.locale == null || _profile.locale.isEmpty) {
      return null;
    }
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  set locale(String locale) {
    _profile.locale = locale;
    notifyListeners();
  }
}
