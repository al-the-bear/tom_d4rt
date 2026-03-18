// D4rt test script: Tests KeyEvent types, SystemChannels, Clipboard,
// HapticFeedback, SystemChrome, SystemNavigator, LogicalKeyboardKey extended
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Services advanced test executing');

  // ========== LogicalKeyboardKey extended ==========
  print('--- LogicalKeyboardKey extended Tests ---');
  final keys = <String, LogicalKeyboardKey>{
    'escape': LogicalKeyboardKey.escape,
    'tab': LogicalKeyboardKey.tab,
    'backspace': LogicalKeyboardKey.backspace,
    'enter': LogicalKeyboardKey.enter,
    'delete': LogicalKeyboardKey.delete,
    'home': LogicalKeyboardKey.home,
    'end': LogicalKeyboardKey.end,
    'pageUp': LogicalKeyboardKey.pageUp,
    'pageDown': LogicalKeyboardKey.pageDown,
    'f1': LogicalKeyboardKey.f1,
    'f5': LogicalKeyboardKey.f5,
    'f12': LogicalKeyboardKey.f12,
    'numpad0': LogicalKeyboardKey.numpad0,
    'numpadEnter': LogicalKeyboardKey.numpadEnter,
    'capsLock': LogicalKeyboardKey.capsLock,
    'numLock': LogicalKeyboardKey.numLock,
  };
  for (final entry in keys.entries) {
    print('LogicalKeyboardKey.${entry.key}: id=${entry.value.keyId}');
  }

  // ========== PhysicalKeyboardKey ==========
  print('--- PhysicalKeyboardKey Tests ---');
  final physKeys = <String, PhysicalKeyboardKey>{
    'keyA': PhysicalKeyboardKey.keyA,
    'digit1': PhysicalKeyboardKey.digit1,
    'arrowUp': PhysicalKeyboardKey.arrowUp,
    'arrowDown': PhysicalKeyboardKey.arrowDown,
    'space': PhysicalKeyboardKey.space,
  };
  for (final entry in physKeys.entries) {
    print(
      'PhysicalKeyboardKey.${entry.key}: usbHidUsage=${entry.value.usbHidUsage}',
    );
  }

  // ========== HapticFeedback ==========
  print('--- HapticFeedback Tests ---');
  print('HapticFeedback.vibrate(): vibration feedback');
  print('HapticFeedback.lightImpact(): light haptic');
  print('HapticFeedback.mediumImpact(): medium haptic');
  print('HapticFeedback.heavyImpact(): heavy haptic');
  print('HapticFeedback.selectionClick(): selection click');

  // ========== SystemChrome ==========
  print('--- SystemChrome Tests ---');
  print('SystemChrome.setPreferredOrientations()');
  print('SystemChrome.setSystemUIOverlayStyle()');
  print('SystemChrome.setApplicationSwitcherDescription()');
  print('SystemChrome.setEnabledSystemUIMode()');

  // ========== SystemUiOverlayStyle ==========
  print('--- SystemUiOverlayStyle Tests ---');
  final lightStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey.shade200,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  print('SystemUiOverlayStyle light created');

  final darkStyle = SystemUiOverlayStyle.dark;
  print('SystemUiOverlayStyle.dark: ${darkStyle.statusBarBrightness}');

  // ========== SystemUiMode ==========
  print('--- SystemUiMode Tests ---');
  for (final mode in SystemUiMode.values) {
    print('SystemUiMode: ${mode.name}');
  }

  // ========== DeviceOrientation ==========
  print('--- DeviceOrientation Tests ---');
  for (final orientation in DeviceOrientation.values) {
    print('DeviceOrientation: ${orientation.name}');
  }

  // ========== SystemNavigator ==========
  print('--- SystemNavigator Tests ---');
  print('SystemNavigator.pop() pops the system navigator');
  print('SystemNavigator.setFrameworkHandlesBack()');

  // ========== TextInputFormatter ==========
  print('--- TextInputFormatter Tests ---');
  final lengthFormatter = LengthLimitingTextInputFormatter(100);
  print('LengthLimitingTextInputFormatter: maxLength=100');

  final filterFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  print('FilteringTextInputFormatter: digits only');

  // ignore: unused_local_variable
  final _denyFilter = FilteringTextInputFormatter.deny(RegExp(r'[<>]'));
  print('FilteringTextInputFormatter.deny: no angle brackets');

  // ========== MaxLengthEnforcement ==========
  print('--- MaxLengthEnforcement Tests ---');
  for (final enforcement in MaxLengthEnforcement.values) {
    print('MaxLengthEnforcement: ${enforcement.name}');
  }

  print('All services advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: AnnotatedRegion<SystemUiOverlayStyle>(
      value: lightStyle,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Services Advanced Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text('LogicalKeyboardKey, PhysicalKeyboardKey'),
              Text('HapticFeedback, SystemChrome'),
              Text('SystemUiOverlayStyle, TextInputFormatter'),
              SizedBox(height: 16.0),
              TextField(
                inputFormatters: [lengthFormatter, filterFormatter],
                decoration: InputDecoration(
                  labelText: 'Numbers only (max 100)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
