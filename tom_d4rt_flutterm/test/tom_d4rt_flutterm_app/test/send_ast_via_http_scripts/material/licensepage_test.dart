// D4rt test script: Tests LicensePage from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LicensePage test executing');

  // Variation 1: Basic LicensePage with applicationName
  final widget1 = LicensePage(
    applicationName: 'Test App',
  );
  print('LicensePage(applicationName) created');

  // Variation 2: LicensePage with applicationVersion
  final widget2 = LicensePage(
    applicationName: 'Test App',
    applicationVersion: '1.0.0',
  );
  print('LicensePage(applicationName, applicationVersion) created');

  // Variation 3: LicensePage with applicationIcon
  final widget3 = LicensePage(
    applicationName: 'Icon App',
    applicationVersion: '2.0.0',
    applicationIcon: Padding(
      padding: EdgeInsets.all(8.0),
      child: FlutterLogo(size: 48),
    ),
  );
  print('LicensePage(applicationIcon: FlutterLogo) created');

  // Variation 4: LicensePage with applicationLegalese
  final widget4 = LicensePage(
    applicationName: 'Legal App',
    applicationVersion: '3.0.0',
    applicationLegalese: 'Copyright 2025 Test Corp. All rights reserved.',
  );
  print('LicensePage(applicationLegalese) created');

  // Variation 5: LicensePage with all properties
  final widget5 = LicensePage(
    applicationName: 'Full App',
    applicationVersion: '4.0.0',
    applicationIcon: Padding(
      padding: EdgeInsets.all(12.0),
      child: FlutterLogo(size: 64),
    ),
    applicationLegalese: 'Copyright 2025 Full Corp.\nBuilt with Flutter and D4rt.',
  );
  print('LicensePage(all properties) created');

  print('LicensePage test completed');
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
