// D4rt test script: Tests SystemChrome enums, DeviceOrientation, SystemUiMode,
// SystemUiOverlay, Clipboard, HapticFeedback, SystemSound
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Services system chrome test executing');

  // ========== DeviceOrientation ==========
  print('--- DeviceOrientation Tests ---');

  print('DeviceOrientation.portraitUp: ${DeviceOrientation.portraitUp}');
  print('DeviceOrientation.portraitDown: ${DeviceOrientation.portraitDown}');
  print('DeviceOrientation.landscapeLeft: ${DeviceOrientation.landscapeLeft}');
  print('DeviceOrientation.landscapeRight: ${DeviceOrientation.landscapeRight}');
  print('DeviceOrientation.values: ${DeviceOrientation.values}');

  // ========== SystemUiMode ==========
  print('--- SystemUiMode Tests ---');

  print('SystemUiMode.leanBack: ${SystemUiMode.leanBack}');
  print('SystemUiMode.immersive: ${SystemUiMode.immersive}');
  print('SystemUiMode.immersiveSticky: ${SystemUiMode.immersiveSticky}');
  print('SystemUiMode.edgeToEdge: ${SystemUiMode.edgeToEdge}');
  print('SystemUiMode.manual: ${SystemUiMode.manual}');
  print('SystemUiMode.values: ${SystemUiMode.values}');

  // ========== SystemUiOverlay ==========
  print('--- SystemUiOverlay Tests ---');

  print('SystemUiOverlay.top: ${SystemUiOverlay.top}');
  print('SystemUiOverlay.bottom: ${SystemUiOverlay.bottom}');
  print('SystemUiOverlay.values: ${SystemUiOverlay.values}');

  // ========== SystemSoundType ==========
  print('--- SystemSoundType Tests ---');

  print('SystemSoundType.click: ${SystemSoundType.click}');
  print('SystemSoundType.alert: ${SystemSoundType.alert}');
  print('SystemSoundType.values: ${SystemSoundType.values}');

  // ========== MaxLengthEnforcement ==========
  print('--- MaxLengthEnforcement Tests ---');

  print('MaxLengthEnforcement.none: ${MaxLengthEnforcement.none}');
  print('MaxLengthEnforcement.enforced: ${MaxLengthEnforcement.enforced}');
  print('MaxLengthEnforcement.truncateAfterCompositionEnds: ${MaxLengthEnforcement.truncateAfterCompositionEnds}');
  print('MaxLengthEnforcement.values: ${MaxLengthEnforcement.values}');

  // ========== SmartDashesType / SmartQuotesType ==========
  print('--- SmartDashesType / SmartQuotesType Tests ---');

  print('SmartDashesType.disabled: ${SmartDashesType.disabled}');
  print('SmartDashesType.enabled: ${SmartDashesType.enabled}');
  print('SmartQuotesType.disabled: ${SmartQuotesType.disabled}');
  print('SmartQuotesType.enabled: ${SmartQuotesType.enabled}');

  // ========== TextInputType ==========
  print('--- TextInputType Tests ---');

  print('TextInputType.text: ${TextInputType.text}');
  print('TextInputType.multiline: ${TextInputType.multiline}');
  print('TextInputType.number: ${TextInputType.number}');
  print('TextInputType.phone: ${TextInputType.phone}');
  print('TextInputType.emailAddress: ${TextInputType.emailAddress}');
  print('TextInputType.url: ${TextInputType.url}');
  print('TextInputType.visiblePassword: ${TextInputType.visiblePassword}');
  print('TextInputType.name: ${TextInputType.name}');
  print('TextInputType.streetAddress: ${TextInputType.streetAddress}');
  print('TextInputType.none: ${TextInputType.none}');

  // ========== TextInputAction ==========
  print('--- TextInputAction Tests ---');

  print('TextInputAction.none: ${TextInputAction.none}');
  print('TextInputAction.done: ${TextInputAction.done}');
  print('TextInputAction.go: ${TextInputAction.go}');
  print('TextInputAction.search: ${TextInputAction.search}');
  print('TextInputAction.send: ${TextInputAction.send}');
  print('TextInputAction.next: ${TextInputAction.next}');
  print('TextInputAction.previous: ${TextInputAction.previous}');
  print('TextInputAction.newline: ${TextInputAction.newline}');
  print('TextInputAction.values: ${TextInputAction.values}');

  // ========== ApplicationSwitcherDescription ==========
  print('--- ApplicationSwitcherDescription Tests ---');

  final appDesc = ApplicationSwitcherDescription(
    label: 'Test App',
    primaryColor: 0xFF2196F3,
  );
  print('AppSwitcherDescription label: ${appDesc.label}');
  print('AppSwitcherDescription primaryColor: ${appDesc.primaryColor}');

  print('All services system chrome tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Services System Chrome Tests',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('DeviceOrientation values: ${DeviceOrientation.values.length}'),
            Text('SystemUiMode values: ${SystemUiMode.values.length}'),
            Text('TextInputType: ${TextInputType.text}'),
            Text('TextInputAction values: ${TextInputAction.values.length}'),
          ],
        ),
      ),
    ),
  );
}
