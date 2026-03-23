// ignore_for_file: avoid_print
// D4rt test script: Tests Clipboard, SystemChrome, HapticFeedback, SystemNavigator from services
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Platform services test executing');

  // ========== CLIPBOARD ==========
  print('--- Clipboard Tests ---');

  // Set clipboard data
  Clipboard.setData(ClipboardData(text: 'D4rt test clipboard data'));
  print('Clipboard.setData called');

  // Get clipboard data (async — schedule after build)
  Future.microtask(() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      print('Clipboard.getData result: ${data?.text}');
    } catch (e) {
      print('Clipboard.getData error: $e');
    }

    try {
      final hasStrings = await Clipboard.hasStrings();
      print('Clipboard.hasStrings: $hasStrings');
    } catch (e) {
      print('Clipboard.hasStrings error: $e');
    }
  });

  // Test ClipboardData
  final clipData = ClipboardData(text: 'Hello clipboard');
  print('ClipboardData.text: ${clipData.text}');
  print('ClipboardData runtimeType: ${clipData.runtimeType}');
  print('Clipboard.kTextPlain: ${Clipboard.kTextPlain}');

  // ========== SYSTEMCHROME ==========
  print('--- SystemChrome Tests ---');

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  print('SystemChrome.setSystemUIOverlayStyle(dark) called');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  print('SystemChrome.setSystemUIOverlayStyle(light) called');

  // Test SystemUiOverlayStyle properties
  final darkStyle = SystemUiOverlayStyle.dark;
  print('SystemUiOverlayStyle.dark:');
  print('  statusBarBrightness: ${darkStyle.statusBarBrightness}');
  print('  statusBarIconBrightness: ${darkStyle.statusBarIconBrightness}');

  final lightStyle = SystemUiOverlayStyle.light;
  print('SystemUiOverlayStyle.light:');
  print('  statusBarBrightness: ${lightStyle.statusBarBrightness}');
  print('  statusBarIconBrightness: ${lightStyle.statusBarIconBrightness}');

  // Custom overlay style
  final customStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.light,
  );
  print('Custom SystemUiOverlayStyle created');
  print('  statusBarColor: ${customStyle.statusBarColor}');
  SystemChrome.setSystemUIOverlayStyle(customStyle);
  print('Custom overlay style applied');

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  print('setPreferredOrientations called (portrait only)');

  // Set enabled system UI overlays
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  print('setEnabledSystemUIMode(edgeToEdge) called');

  // ========== HAPTICFEEDBACK ==========
  print('--- HapticFeedback Tests ---');

  HapticFeedback.lightImpact();
  print('HapticFeedback.lightImpact called');

  HapticFeedback.mediumImpact();
  print('HapticFeedback.mediumImpact called');

  HapticFeedback.heavyImpact();
  print('HapticFeedback.heavyImpact called');

  HapticFeedback.selectionClick();
  print('HapticFeedback.selectionClick called');

  HapticFeedback.vibrate();
  print('HapticFeedback.vibrate called');

  // ========== SYSTEMNAVIGATOR ==========
  print('--- SystemNavigator Tests ---');
  // Don't call SystemNavigator.pop() — it would close the app!
  print('SystemNavigator.pop() available but not called (would close app)');

  // ========== SYSTEMUIMODE ENUM ==========
  print('--- SystemUiMode values ---');
  for (final mode in SystemUiMode.values) {
    print('SystemUiMode.$mode');
  }

  // ========== DEVICEORIENTATION ENUM ==========
  print('--- DeviceOrientation values ---');
  for (final orientation in DeviceOrientation.values) {
    print('DeviceOrientation.$orientation');
  }

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform services test'),
        SizedBox(height: 8.0),
        Text('Clipboard: setData called'),
        Text('SystemChrome: overlay styles set'),
        Text('HapticFeedback: all impacts called'),
        Text('SystemNavigator: available (not called)'),
      ],
    ),
  );
}
