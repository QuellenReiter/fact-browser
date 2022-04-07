import 'dart:io';

import 'package:flutter/material.dart';

/// Utility class to provide information about the current display size
/// and facilitate responsive design with [MediaQuery].
class DeviceType {
  /// Checks if device is a mobile and not wider than 700px.
  static bool isHandset(BuildContext context) {
    return (Platform.isAndroid || Platform.isIOS) &&
        MediaQuery.of(context).size.width < 700;
  }

  /// Returns true if display is so narrow to use a one column layout.
  static bool oneColumn(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  /// Returns the width of the browser window.
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Returns the height of the browser window.
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
