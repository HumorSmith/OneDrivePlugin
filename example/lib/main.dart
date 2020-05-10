import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:onedriveplugin/onedrive_plugin.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Onedriveplugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Container(
            child: new Column(
              children: [
                Text('Running on: $_platformVersion\n'),
                RaisedButton(
                  child: Text("初始化"),
                  onPressed: () {
                    init();
                  },
                ),
                RaisedButton(
                  child: Text("登录"),
                  onPressed: () {
                    signIn();
                  },
                ),
                RaisedButton(
                  child: Text("下载"),
                  onPressed: () {
                    download();
                  },
                ),
                RaisedButton(
                  child: Text("上传"),
                  onPressed: () {
                    upload();
                  },
                ),
                RaisedButton(
                  child: Text("获取根目录"),
                  onPressed: () {
                    if (Onedriveplugin.accessToken == null) {
                      print("请先登录");
                      return;
                    }
                    getRoot();
                  },
                ),
                RaisedButton(
                  child: Text("获取文件列表"),
                  onPressed: () {
                    if (Onedriveplugin.accessToken == null) {
                      print("请先登录");
                      return;
                    }
                    listFile();
                  },
                ),
              ],
            )),
      ),
    );
  }

  Future<void> init() async {
    var init = await Onedriveplugin.initMSAL;
    print("init result $init");
  }

  Future<void> download() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var localPath = appDocDir.path+'/a.zip';
    var init = await Onedriveplugin.download(localPath,'note2020-04-25-21-01-10.zip');
    print("download result $init");
  }

  Future<void> upload() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var localPath = appDocDir.path+'/a.zip';
    var init = await Onedriveplugin.upload(localPath,"a.zip");
    print("upload result $init");
  }


  Future<void> signIn() async {
    var init = await Onedriveplugin.signIn(
        '00bdbcc6-f08f-47c1-bdba-acc9381c362c', (signInfo) => {
        print("signInfo accessToken= "+signInfo.accessToken+"    userName = "+signInfo.userName)
    });
    print("upload result $init");
  }

  Future<void> getRoot() async {
    var init = await Onedriveplugin.getRoot;
    print("upload result $init");
  }

  Future<void> listFile() async {
    var init = await Onedriveplugin.listFile;
    print("listFile result $init");
  }
}
