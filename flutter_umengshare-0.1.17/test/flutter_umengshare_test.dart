import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_umengshare/flutter_umengshare.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_umengshare');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterUmengshare.platformVersion, '42');
  });
}
