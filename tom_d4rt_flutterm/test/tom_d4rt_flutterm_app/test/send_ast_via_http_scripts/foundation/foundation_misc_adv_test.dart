// D4rt test script: Tests TargetPlatformVariant, TargetPlatform, DiagnosticsNode, DiagnosticsProperty, DiagnosticPropertiesBuilder
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Foundation misc advanced tests executing');

  // ========== TargetPlatform ==========
  print('--- TargetPlatform Tests ---');
  print('TargetPlatform values:');
  for (final platform in TargetPlatform.values) {
    print('  TargetPlatform.${platform.name} (index: ${platform.index})');
  }
  print('defaultTargetPlatform: $defaultTargetPlatform');
  print('debugDefaultTargetPlatformOverride: $debugDefaultTargetPlatformOverride');
  print('TargetPlatform tests passed');

  // ========== TargetPlatformVariant ==========
  print('--- TargetPlatformVariant Tests ---');
  print('TargetPlatformVariant is a flutter_test utility class');
  print('It is NOT available via foundation.dart imports');
  print('It requires: import package:flutter_test/flutter_test.dart');
  print('Usage: TargetPlatformVariant.all() or TargetPlatformVariant({TargetPlatform.iOS})');
  print('It extends TestVariant<TargetPlatform> for parameterized testing');
  print('Since we cannot import flutter_test in a D4rt script,');
  print('we reference TargetPlatform enum values instead');
  print('TargetPlatformVariant reference passed');

  // ========== DiagnosticsNode ==========
  print('--- DiagnosticsNode Tests ---');
  final messageNode = DiagnosticsNode.message('Test diagnostic message');
  print('DiagnosticsNode.message type: ${messageNode.runtimeType}');
  print('name: ${messageNode.name}');
  print('toString: ${messageNode.toString()}');
  print('toDescription: ${messageNode.toDescription()}');
  print('style: ${messageNode.style}');
  print('level: ${messageNode.level}');
  print('DiagnosticsNode tests passed');

  // ========== DiagnosticsProperty ==========
  print('--- DiagnosticsProperty Tests ---');
  final stringProp = DiagnosticsProperty<String>('label', 'hello');
  print('DiagnosticsProperty type: ${stringProp.runtimeType}');
  print('name: ${stringProp.name}');
  print('value: ${stringProp.value}');
  print('toString: ${stringProp.toString()}');

  final intProp = IntProperty('count', 42);
  print('IntProperty type: ${intProp.runtimeType}');
  print('IntProperty value: ${intProp.value}');

  final doubleProp = DoubleProperty('ratio', 3.14);
  print('DoubleProperty type: ${doubleProp.runtimeType}');
  print('DoubleProperty value: ${doubleProp.value}');

  final flagProp = FlagProperty('visible', value: true, ifTrue: 'VISIBLE', ifFalse: 'HIDDEN');
  print('FlagProperty type: ${flagProp.runtimeType}');
  print('FlagProperty toString: ${flagProp.toString()}');

  final enumProp = EnumProperty<TargetPlatform>('platform', TargetPlatform.android);
  print('EnumProperty type: ${enumProp.runtimeType}');
  print('EnumProperty value: ${enumProp.value}');

  final colorProp = ColorProperty('color', const Color(0xFFFF0000));
  print('ColorProperty type: ${colorProp.runtimeType}');
  print('ColorProperty value: ${colorProp.value}');
  print('DiagnosticsProperty tests passed');

  // ========== DiagnosticPropertiesBuilder ==========
  print('--- DiagnosticPropertiesBuilder Tests ---');
  final builder = DiagnosticPropertiesBuilder();
  print('DiagnosticPropertiesBuilder type: ${builder.runtimeType}');
  builder.add(DiagnosticsProperty<String>('name', 'TestWidget'));
  builder.add(IntProperty('width', 100));
  builder.add(DoubleProperty('opacity', 0.75));
  builder.add(FlagProperty('enabled', value: true, ifTrue: 'ON'));
  builder.add(EnumProperty<TargetPlatform>('platform', TargetPlatform.iOS));
  print('properties count: ${builder.properties.length}');
  for (final prop in builder.properties) {
    print('  property: ${prop.toString()}');
  }
  print('DiagnosticPropertiesBuilder tests passed');

  print('All Foundation misc advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Foundation Misc Advanced Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('TargetPlatform: OK (${TargetPlatform.values.length} values)'),
            Text('TargetPlatformVariant: test-only reference'),
            Text('DiagnosticsNode: OK'),
            Text('DiagnosticsProperty: OK'),
            Text('DiagnosticPropertiesBuilder: OK'),
          ],
        ),
      ),
    ),
  );
}
