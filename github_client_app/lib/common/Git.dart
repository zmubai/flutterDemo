import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'Global.dart';

class Git {
  BuildContext context;
  Options _options;

//构造方法
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://api.github.com/',
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {
    //添加缓存插件
    dio.interceptors.add(Global.netCache);
    //设置用户token
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    //调试模式抓包，并禁用https证书校验
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.1.10.250.8888";
        };

        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验。 存在疑问！！！！
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  //发起异步请求
  Future<User> login(String name, String pwd) async {
    String basic = 'Basic' + base64.encode(utf8.encode('$name:$pwd'));
    var r = await dio.get(
      ///设置get请求， 路径，参数
      "/users/$name",
      options: _options.merge(headers: {
        HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true,
      }),
    );

    //await 后是异步等待回调。
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //remove cache
    Global.netCache.cache.clear();
    Global.profile.token = basic;
    //返回 user object 
    return User.fromJson(r.data);
  }

  //{Map<String, dynamic> queryParameters, refresh = false} //false 为默认值
  Future<List<Repo>> getRepos({Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({"refresh":true,"list":true});
    }
    var r = await  dio.get<List>(
      "user/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    //return  List<Repo>
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }
}
