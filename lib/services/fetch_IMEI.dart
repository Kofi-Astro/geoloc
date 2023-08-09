import 'dart:io';

import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';

Future<List<String>> getDeviceDetails() async {
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  final _androidIdPlugin = AndroidId();

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString(); // UUID for android

      try {
        identifier = await _androidIdPlugin.getId() ?? 'UNKNOWN ID';
      } on PlatformException {
        identifier = 'Failed to get Android Id.';
      }
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name ?? '';
      deviceVersion = data.systemVersion ?? '';
      identifier = data.identifierForVendor ?? ''; //UUID for ios
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

  return [deviceName, deviceVersion, identifier];
}
