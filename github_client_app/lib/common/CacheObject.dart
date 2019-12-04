import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';

class CacheObject {
  Response response;
  int timeStamp;
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) async {
    //no cache
    if (!Global.profile.cache.enable) return options;

    bool refresh = options.extra["refresh"] = true;

    if (refresh) {
      if (options.extra["list"] == true) {
        //remove cache when refresh and it is a list
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        _delete(options.uri.toString());
      }
    }

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //try return caceh
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          cache.remove(key);
        }
      }
    }
  }

  @override
  Future onResponse(Response response) async {
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
  }

//tool method
  void _delete(String key) {
    cache.remove(key);
  }

  void _saveCache(Response response) {
    RequestOptions options = response.request;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(response);
    }
  }
}
