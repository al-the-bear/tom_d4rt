// D4rt test script: Tests AboutDialog from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AboutDialog test executing');

  // Variation 1: AboutDialog with name and version
  final widget1 = AboutDialog(
    applicationName: 'Test App',
    applicationVersion: '1.0.0',
  );
  print('AboutDialog(applicationName, applicationVersion) created');

  // Variation 2: AboutDialog with icon
  final widget2 = AboutDialog(
    applicationName: 'Test',
    applicationIcon: FlutterLogo(size: 40),
  );
  print('AboutDialog(applicationName, applicationIcon: FlutterLogo) created');

  // Variation 3: AboutDialog with legalese
  final widget3 = AboutDialog(
    applicationName: 'Legal App',
    applicationVersion: '2.0.0',
    applicationLegalese: 'Copyright 2025',
  );
  print('AboutDialog(applicationLegalese) created');

  // Variation 4: AboutDialog with children
  final widget4 = AboutDialog(
    applicationName: 'Extended App',
    applicationVersion: '3.0.0',
    children: [
      Text('Extra info'),
      SizedBox(height: 8),
      Text('More details about the application'),
    ],
  );
  print('AboutDialog(with children) created');

  // Variation 5: AboutDialog with all properties
  final widget5 = AboutDialog(
    applicationName: 'Full App',
    applicationVersion: '4.0.0',
    applicationIcon: FlutterLogo(size: 48),
    applicationLegalese: 'Copyright 2025 Test Corp',
    children: [SizedBox(height: 16), Text('Built with Flutter and D4rt')],
  );
  print('AboutDialog(all properties) created');

  print('AboutDialog test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget2),
      Expanded(child: widget3),
      Expanded(child: widget4),
      Expanded(child: widget5),
    ],
  );
}
