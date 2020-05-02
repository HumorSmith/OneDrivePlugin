import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onedriveplugin/onedriveplugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('onedriveplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Onedriveplugin.platformVersion, '42');
  });
}
