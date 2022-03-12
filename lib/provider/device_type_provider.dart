import 'dart:io';

import 'package:flutter/material.dart';

class DeviceType {
  static bool isHandset(BuildContext context) {
    return (Platform.isAndroid || Platform.isIOS) &&
        MediaQuery.of(context).size.width < 700;
  }

  static bool oneColumn(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
