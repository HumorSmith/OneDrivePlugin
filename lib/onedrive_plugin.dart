import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:onedriveplugin/list_file_resp.dart';
import 'package:onedriveplugin/sign_info.dart';

typedef void SignInfoCallback(SignInfo signInfo);

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

  static Future<String> signIn(var clientId, SignInfoCallback callback) async {
    final String version =
        await _channel.invokeMethod('signIn', {"clientId": clientId});
    // ignore: missing_return
    _channel.setMethodCallHandler((MethodCall call) {
      var args = call.arguments;
      print("${call.method}");
      print(call.arguments);
      accessToken = args["token"];
      userName = args["userName"];
      if (callback != null) {
        var signInfo = SignInfo();
        signInfo.accessToken = accessToken;
        signInfo.userName = userName;
        callback(signInfo);
      }
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
        'Authorization': accessToken,
      }));
      var response = await dio
          .request('https://graph.microsoft.com/v1.0/me/drive/root/children');
      print(response);
      return 'hello world';
    } catch (e) {
      print(e);
    }
  }

  static Future<ListFileResp> get listFile async {
    try {
      var dio = Dio(BaseOptions(headers: {
        'Authorization': accessToken,
      }));
      var response = await dio.request(
          'https://graph.microsoft.com/v1.0/me/drive/special/approot/children');
      var jsonEncode = jsonDecode(response.toString());
      var listFileResp = ListFileResp.fromJson(jsonEncode);
      return listFileResp;
    } catch (e) {
      print(e);
    }
  }

  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static Future<String> get download async {
    try {
      var dio = Dio(BaseOptions(headers: {
        'Authorization': accessToken,
      }));
      var response = await dio
          .request('https://graph.microsoft.com/v1.0/me/drive/root/children');
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
