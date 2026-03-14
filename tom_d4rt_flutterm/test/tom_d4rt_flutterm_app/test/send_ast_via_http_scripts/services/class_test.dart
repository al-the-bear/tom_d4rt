// D4rt test script: Tests multiple service classes from Flutter services package
// Covers: Clipboard, SystemChannels, HapticFeedback, SystemChrome, TextInput, PlatformViews
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Services class overview test executing');

  // ========== CLIPBOARD ==========
  print('--- Clipboard Tests ---');
  final clipData = ClipboardData(text: 'Services test clipboard');
  print('ClipboardData text: ${clipData.text}');
  print('Clipboard.kTextPlain: ${Clipboard.kTextPlain}');

  // Set clipboard (async, won't block)
  Clipboard.setData(clipData);
  print('Clipboard.setData called');

  // ========== SYSTEMCHANNELS ==========
  print('--- SystemChannels Tests ---');
  print('SystemChannels.navigation: ${SystemChannels.navigation}');
  print('SystemChannels.platform: ${SystemChannels.platform}');
  print('SystemChannels.textInput: ${SystemChannels.textInput}');
  print('SystemChannels.keyEvent: ${SystemChannels.keyEvent}');
  print('SystemChannels.lifecycle: ${SystemChannels.lifecycle}');
  print('SystemChannels.system: ${SystemChannels.system}');
  print('SystemChannels.accessibility: ${SystemChannels.accessibility}');
  print('SystemChannels.platform_views: ${SystemChannels.platform_views}');
  print('SystemChannels.skia: ${SystemChannels.skia}');
  print('SystemChannels.menu: ${SystemChannels.menu}');

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

  // ========== SYSTEMCHROME ==========
  print('--- SystemChrome Tests ---');
  final darkStyle = SystemUiOverlayStyle.dark;
  final lightStyle = SystemUiOverlayStyle.light;
  print(
    'SystemUiOverlayStyle.dark statusBarBrightness: ${darkStyle.statusBarBrightness}',
  );
  print(
    'SystemUiOverlayStyle.light statusBarBrightness: ${lightStyle.statusBarBrightness}',
  );

  final customStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black87,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.grey,
  );
  print('Custom SystemUiOverlayStyle created');
  print('  statusBarColor: ${customStyle.statusBarColor}');
  print('  systemNavigationBarColor: ${customStyle.systemNavigationBarColor}');

  // ========== SYSTEMUIMODE ==========
  print('--- SystemUiMode Tests ---');
  for (final mode in SystemUiMode.values) {
    print('SystemUiMode.${mode.name}');
  }

  // ========== DEVICEORIENTATION ==========
  print('--- DeviceOrientation Tests ---');
  for (final orientation in DeviceOrientation.values) {
    print('DeviceOrientation.${orientation.name}');
  }

  // ========== LOGICALKEYBOARDKEY ==========
  print('--- LogicalKeyboardKey Tests ---');
  final keyMap = {
    'space': LogicalKeyboardKey.space,
    'enter': LogicalKeyboardKey.enter,
    'escape': LogicalKeyboardKey.escape,
    'tab': LogicalKeyboardKey.tab,
    'backspace': LogicalKeyboardKey.backspace,
    'delete': LogicalKeyboardKey.delete,
    'arrowUp': LogicalKeyboardKey.arrowUp,
    'arrowDown': LogicalKeyboardKey.arrowDown,
    'arrowLeft': LogicalKeyboardKey.arrowLeft,
    'arrowRight': LogicalKeyboardKey.arrowRight,
    'home': LogicalKeyboardKey.home,
    'end': LogicalKeyboardKey.end,
    'pageUp': LogicalKeyboardKey.pageUp,
    'pageDown': LogicalKeyboardKey.pageDown,
  };
  for (final entry in keyMap.entries) {
    print('LogicalKeyboardKey.${entry.key}: keyId=${entry.value.keyId}');
  }

  // ========== PHYSICALKEYBOARDKEY ==========
  print('--- PhysicalKeyboardKey Tests ---');
  final physKeys = {
    'keyA': PhysicalKeyboardKey.keyA,
    'keyZ': PhysicalKeyboardKey.keyZ,
    'digit0': PhysicalKeyboardKey.digit0,
    'digit9': PhysicalKeyboardKey.digit9,
    'f1': PhysicalKeyboardKey.f1,
    'controlLeft': PhysicalKeyboardKey.controlLeft,
    'shiftLeft': PhysicalKeyboardKey.shiftLeft,
    'altLeft': PhysicalKeyboardKey.altLeft,
  };
  for (final entry in physKeys.entries) {
    print(
      'PhysicalKeyboardKey.${entry.key}: usbHidUsage=${entry.value.usbHidUsage}',
    );
  }

  // ========== TEXTINPUTTYPE ==========
  print('--- TextInputType Tests ---');
  print('TextInputType.text: ${TextInputType.text}');
  print('TextInputType.number: ${TextInputType.number}');
  print('TextInputType.phone: ${TextInputType.phone}');
  print('TextInputType.emailAddress: ${TextInputType.emailAddress}');
  print('TextInputType.url: ${TextInputType.url}');
  print('TextInputType.multiline: ${TextInputType.multiline}');
  print('TextInputType.datetime: ${TextInputType.datetime}');
  print('TextInputType.visiblePassword: ${TextInputType.visiblePassword}');

  // ========== TEXTINPUTACTION ==========
  print('--- TextInputAction Tests ---');
  for (final action in TextInputAction.values) {
    print('TextInputAction.${action.name}');
  }

  // ========== TEXTINPUTFORMATTER ==========
  print('--- TextInputFormatter Tests ---');
  final lengthFormatter = LengthLimitingTextInputFormatter(50);
  print('LengthLimitingTextInputFormatter maxLength: 50');

  final digitsOnly = FilteringTextInputFormatter.digitsOnly;
  print('FilteringTextInputFormatter.digitsOnly available');

  final allowPattern = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9]'),
  );
  print('FilteringTextInputFormatter.allow alphanumeric');

  FilteringTextInputFormatter.deny(RegExp(r'[<>]'));
  print('FilteringTextInputFormatter.deny angle brackets');

  // ========== TEXTCAPITALIZATION ==========
  print('--- TextCapitalization Tests ---');
  for (final cap in TextCapitalization.values) {
    print('TextCapitalization.${cap.name}');
  }

  // ========== SMARTDASHESTYPE / SMARTQUOTESTYPE ==========
  print('--- SmartDashesType/SmartQuotesType Tests ---');
  for (final dash in SmartDashesType.values) {
    print('SmartDashesType.${dash.name}');
  }
  for (final quote in SmartQuotesType.values) {
    print('SmartQuotesType.${quote.name}');
  }

  print('Services class overview test completed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: AnnotatedRegion<SystemUiOverlayStyle>(
      value: customStyle,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Services Classes Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Clipboard section
              Text(
                'Clipboard',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text('kTextPlain: ${Clipboard.kTextPlain}'),
              Text('ClipboardData: "${clipData.text}"'),
              SizedBox(height: 12),

              // HapticFeedback section
              Text(
                'HapticFeedback',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => HapticFeedback.lightImpact(),
                    child: Text('Light'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => HapticFeedback.mediumImpact(),
                    child: Text('Medium'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => HapticFeedback.heavyImpact(),
                    child: Text('Heavy'),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // SystemChannels section
              Text(
                'SystemChannels',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text('navigation, platform, textInput, keyEvent'),
              Text('lifecycle, system, accessibility, platform_views'),
              SizedBox(height: 12),

              // TextInputFormatter section
              Text(
                'TextInputFormatter',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              TextField(
                inputFormatters: [lengthFormatter, allowPattern],
                decoration: InputDecoration(
                  hintText: 'Alphanumeric only, max 50',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                inputFormatters: [digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Digits only',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),

              // Keyboard keys section
              Text(
                'LogicalKeyboardKey',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('Enter: ${LogicalKeyboardKey.enter.keyId}')),
                  Chip(label: Text('Space: ${LogicalKeyboardKey.space.keyId}')),
                  Chip(
                    label: Text('Escape: ${LogicalKeyboardKey.escape.keyId}'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
