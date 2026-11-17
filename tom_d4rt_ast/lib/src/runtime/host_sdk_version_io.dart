import 'dart:io' show Platform;

/// The Dart SDK version of the host, where it can be told (ghissues70):
/// `Platform.version`, e.g. `3.13.7 (stable) (...) on "macos_arm64"`.
String? hostDartSdkVersion() => Platform.version;
