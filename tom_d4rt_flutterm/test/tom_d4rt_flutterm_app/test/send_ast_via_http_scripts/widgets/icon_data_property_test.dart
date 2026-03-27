// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IconDataProperty from widgets
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('IconDataProperty test executing');
  print('=' * 50);

  // === IconDataProperty class tests ===
  // IconDataProperty is a DiagnosticsProperty subclass specifically
  // for IconData values. It adds special JSON serialization support
  // including the codePoint in valueProperties.

  // Test 1: Create IconDataProperty with standard icon
  print('\nTest 1: Create with standard icon');
  final iconData = Icons.home;
  final prop1 = IconDataProperty('icon', iconData);
  print('Created IconDataProperty for Icons.home');
  print('name: ${prop1.name}');
  print('value: ${prop1.value}');
  print('value.codePoint: ${prop1.value?.codePoint}');

  // Test 2: Create with null value
  print('\nTest 2: Create with null value');
  final prop2 = IconDataProperty('emptyIcon', null, ifNull: 'no icon');
  print('Created with null value');
  print('value: ${prop2.value}');
  print('ifNull message applied');

  // Test 3: Test various icons
  print('\nTest 3: Various icons');
  final icons = [
    (Icons.star, 'star'),
    (Icons.settings, 'settings'),
    (Icons.person, 'person'),
    (Icons.favorite, 'favorite'),
  ];
  for (final (icon, name) in icons) {
    final prop = IconDataProperty(name, icon);
    print('$name codePoint: ${prop.value?.codePoint}');
  }

  // Test 4: DiagnosticsProperty hierarchy
  print('\nTest 4: DiagnosticsProperty hierarchy');
  print('prop1 is DiagnosticsProperty: ${prop1 is DiagnosticsProperty}');
  print('prop1 is DiagnosticsProperty<IconData>: ${prop1 is DiagnosticsProperty<IconData>}');

  // Test 5: JSON serialization
  print('\nTest 5: JSON serialization');
  final delegate = _TestSerializationDelegate();
  final json = prop1.toJsonMap(delegate);
  print('JSON map keys: ${json.keys.toList()}');
  print('Has valueProperties: ${json.containsKey("valueProperties")}');
  if (json['valueProperties'] != null) {
    print('valueProperties: ${json["valueProperties"]}');
  }

  // Test 6: showName and style options
  print('\nTest 6: Property options');
  final prop3 = IconDataProperty(
    'styledIcon',
    Icons.check,
    showName: false,
    style: DiagnosticsTreeStyle.singleLine,
  );
  print('showName: ${prop3.showName}');
  print('style: ${prop3.style}');

  // Test 7: DiagnosticLevel
  print('\nTest 7: DiagnosticLevel');
  final prop4 = IconDataProperty(
    'debugIcon',
    Icons.bug_report,
    level: DiagnosticLevel.debug,
  );
  print('level: ${prop4.level}');

  // Test 8: Different IconData types
  print('\nTest 8: Different IconData types');
  final materialIcon = IconDataProperty('material', Icons.add);
  print('Material icon codePoint: ${materialIcon.value?.codePoint}');
  print('Font family: ${materialIcon.value?.fontFamily}');

  print('\n' + '=' * 50);
  print('IconDataProperty test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IconDataProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 8 categories executed'),
      Text('Type: DiagnosticsProperty<IconData>'),
      Text('Purpose: Icon diagnostics'),
    ],
  );
}

class _TestSerializationDelegate implements DiagnosticsSerializationDelegate {
  @override
  Map<String, Object?> additionalNodeProperties(DiagnosticsNode node, {bool fullDetails = true}) => {};
  @override
  DiagnosticsSerializationDelegate delegateForNode(DiagnosticsNode node) => this;
  @override
  bool get expandPropertyValues => true;
  @override
  List<DiagnosticsNode> filterChildren(List<DiagnosticsNode> children, DiagnosticsNode parent) => children;
  @override
  List<DiagnosticsNode> filterProperties(List<DiagnosticsNode> properties, DiagnosticsNode parent) => properties;
  @override
  bool get includeProperties => true;
  @override
  int get subtreeDepth => 1;
  @override
  DiagnosticsSerializationDelegate copyWith({int? subtreeDepth, bool? includeProperties}) => this;
  @override
  List<DiagnosticsNode> truncateNodesList(List<DiagnosticsNode> nodes, DiagnosticsNode? owner) => nodes;
}
