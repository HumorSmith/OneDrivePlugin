import 'dart:async';

import 'package:flutter/services.dart';

class Onedriveplugin {
  static const MethodChannel _channel =
      const MethodChannel('onedriveplugin');

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
    return version;
  }

  static Future<String> get signOut async {
    final String version = await _channel.invokeMethod('signOut');
    return version;
  }



  static Future<String> get download async {
    final String version = await _channel.invokeMethod('download');
    return version;
  }


  static Future<String> get upload async {
    final String version = await _channel.invokeMethod('upload');
    return version;
  }
}
