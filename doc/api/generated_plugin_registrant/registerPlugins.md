


# registerPlugins function






    *[<Null safety>](https://dart.dev/null-safety)*




void registerPlugins
([Registrar](https://api.flutter.dev/flutter/flutter_web_plugins/Registrar-class.html) registrar)






## Implementation

```dart
void registerPlugins(Registrar registrar) {
  ConnectivityPlusPlugin.registerWith(registrar);
  FlutterDropzonePlugin.registerWith(registrar);
  FlutterNativeSplashWeb.registerWith(registrar);
  FlutterSecureStorageWeb.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
```







