import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:built_value/json_object.dart';
import 'CacheObject.dart';

//枚举变量
const _themes = <MaterialColor> [
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];


class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  //便捷方法？ =>
  static List<MaterialColor> get themes => _themes;

  //debug or release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();

    var _profile = _prefs.getString('profile');

    if(_profile != null){
      try {
        //jsonDecode not found
        profile = Profile.fromJson(jsonDecode(_profile));

      } catch (e) {
        print(e);
      }
    }
    // if not the cache strategy.set the default file path  
    profile.cache = profile.cache ?? CacheConfig()
    ..enable = true
    ..maxAge = 3600
    ..maxCount = 100;

    //init network; but it dosenot work now
    //  Git.init();
  }

  //local data access info. save profile info 
  static saveProfile() =>
    _prefs.setString("profile", jsonEncode(profile.toJson()));
}

class ProfileChangeNotifier extends ChangeNotifier {
    Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    //save profile info
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  bool get login => user != null;

  set user(User user){
    if (user?.login != _profile.user?.login){
      _profile.lastLogin = _profile.user?.location;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier{
  ColorSwatch get theme => Global.themes
  .firstWhere(
    (e) => e.value == _profile.theme,
    orElse: () => Colors.blue
  );

  set theme(ColorSwatch color){
    if(color != theme){
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

class LocalModel extends ProfileChangeNotifier{
  Locale getLocal() {
    if(_profile.locale == null) return null;
    var t = _profile.locale.split("-");
    return Locale(t[0],t[1]);
  }

  String get local => _profile.locale;

  set local(String locale){
    if(locale != _profile.locale){
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
