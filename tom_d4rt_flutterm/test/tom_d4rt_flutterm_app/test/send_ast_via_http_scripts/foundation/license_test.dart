// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LicenseEntry, LicenseEntryWithLineBreaks, LicenseRegistry, LicenseParagraph from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation license test executing');

  // ========== LICENSEENTRYWITHLINEBREAKS ==========
  print('--- LicenseEntryWithLineBreaks Tests ---');

  final license1 = LicenseEntryWithLineBreaks(
    ['my_package'],
    'MIT License\n\nCopyright (c) 2024 Test Author\n\nPermission is hereby granted...',
  );
  print('LicenseEntryWithLineBreaks created');
  print('  runtimeType: ${license1.runtimeType}');
  print('  packages: ${license1.packages.toList()}');

  // Access paragraphs
  final paragraphs1 = license1.paragraphs.toList();
  print('  paragraphs count: ${paragraphs1.length}');
  for (int i = 0; i < paragraphs1.length; i++) {
    print(
      '  paragraph[$i]: indent=${paragraphs1[i].indent}, text="${paragraphs1[i].text}"',
    );
  }

  // Multiple packages
  final license2 = LicenseEntryWithLineBreaks(
    ['package_a', 'package_b', 'package_c'],
    'BSD 3-Clause License\n\nRedistribution and use in source and binary forms...',
  );
  print('Multi-package license:');
  print('  packages: ${license2.packages.toList()}');
  final paragraphs2 = license2.paragraphs.toList();
  print('  paragraphs count: ${paragraphs2.length}');

  // License with indentation
  final license3 = LicenseEntryWithLineBreaks(
    ['indented_package'],
    'License Header\n\n  1. First clause\n  2. Second clause\n  3. Third clause\n\nEnd of license.',
  );
  print('Indented license:');
  print('  packages: ${license3.packages.toList()}');
  final paragraphs3 = license3.paragraphs.toList();
  print('  paragraphs count: ${paragraphs3.length}');
  for (int i = 0; i < paragraphs3.length; i++) {
    print(
      '  paragraph[$i]: indent=${paragraphs3[i].indent}, text="${paragraphs3[i].text}"',
    );
  }

  // Empty license text
  final emptyLicense = LicenseEntryWithLineBreaks(['empty_pkg'], '');
  print('Empty license:');
  print('  packages: ${emptyLicense.packages.toList()}');
  final emptyParagraphs = emptyLicense.paragraphs.toList();
  print('  paragraphs count: ${emptyParagraphs.length}');

  // ========== LICENSEPARAGRAPH ==========
  print('--- LicenseParagraph Tests ---');

  // LicenseParagraph is returned by LicenseEntry.paragraphs
  // It has .text and .indent properties
  // LicenseParagraph.centeredIndent is a constant
  print('LicenseParagraph.centeredIndent: ${LicenseParagraph.centeredIndent}');

  // Access paragraphs from our first license
  if (paragraphs1.isNotEmpty) {
    final firstParagraph = paragraphs1[0];
    print('First paragraph:');
    print('  text: "${firstParagraph.text}"');
    print('  indent: ${firstParagraph.indent}');
    print('  runtimeType: ${firstParagraph.runtimeType}');
  }

  // ========== LICENSEREGISTRY ==========
  print('--- LicenseRegistry Tests ---');

  // LicenseRegistry is a static class for registering licenses
  print('LicenseRegistry.licenses is a Stream<LicenseEntry>');
  print('LicenseRegistry.addLicense() registers a license');

  // Register a test license
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'd4rt_test_package',
    ], 'Test license registered via LicenseRegistry');
  });
  print('Test license registered with LicenseRegistry.addLicense()');

  // ========== LICENSEENTRY ==========
  print('--- LicenseEntry Tests ---');

  // LicenseEntry is abstract, tested via LicenseEntryWithLineBreaks
  print('LicenseEntry is abstract - tested via LicenseEntryWithLineBreaks');
  print('LicenseEntry properties:');
  print('  - packages: Iterable<String>');
  print('  - paragraphs: Iterable<LicenseParagraph>');

  // ========== RETURN WIDGET ==========
  print('Foundation license test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation License Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• LicenseEntryWithLineBreaks - license with text'),
          Text('• LicenseParagraph - license text paragraph'),
          Text('• LicenseRegistry - static license registration'),
          Text('• LicenseEntry - abstract base class'),
          SizedBox(height: 16.0),

          Text('License Info:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF3E5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Package: ${license1.packages.first}'),
                Text('Paragraphs: ${paragraphs1.length}'),
                Text('CenteredIndent: ${LicenseParagraph.centeredIndent}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
