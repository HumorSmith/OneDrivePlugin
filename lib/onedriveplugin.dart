import 'dart:async';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
class Onedriveplugin {
  static const MethodChannel _channel = const MethodChannel('onedriveplugin');
  static var accessToken;
  static var userName;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get initMSAL async {
    final String version = await _channel.invokeMethod('initOnedrive');
    return version;
  }

  static Future<String> get signIn async {
    final String version = await _channel.invokeMethod('signIn');
    // ignore: missing_return
    _channel.setMethodCallHandler((MethodCall call) {
      var args = call.arguments;
      print("${call.method}");
      print(call.arguments);
      accessToken = args["token"];
      userName = args["userName"];
    });
    return version;
  }

  static Future<String> get signOut async {
    final String version = await _channel.invokeMethod('signOut');
    return version;
  }

  static Future<String> get getRoot async {
    try {
      var dio = Dio(BaseOptions(headers: {
        'Authorization':accessToken,
      }));
      var response =await dio.request('https://graph.microsoft.com/v1.0/me/drive/root/children');
      print(response);
      return 'hello world';
    } catch (e) {
      print(e);
    }
  }


  static Future<String> get listFile async {
    try {
      var dio = Dio(BaseOptions(headers: {
        'Authorization':accessToken,
      }));
      var response =await dio.request('https://graph.microsoft.com/v1.0/me/drive/special/approot/children');
      print("listFile $response");
      return response.toString();
    } catch (e) {
      print(e);
    }
  }

  static Future<String> get download async {
    try {
      var dio = Dio(BaseOptions(headers: {
        'Authorization':accessToken,
      }));
      var response =await dio.request('https://graph.microsoft.com/v1.0/me/drive/root/children');
      print(response);
      return 'hello world';
    } catch (e) {
      print(e);
    }
    return "";
  }

  static Future<String> get upload async {
    final String version = await _channel.invokeMethod('upload');
    return version;
  }
}
