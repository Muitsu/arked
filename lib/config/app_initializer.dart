import 'package:flutter/services.dart';

class AppInitializer {
  static Future<void> init() async {
    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]),
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive)
    ]);
  }
}
