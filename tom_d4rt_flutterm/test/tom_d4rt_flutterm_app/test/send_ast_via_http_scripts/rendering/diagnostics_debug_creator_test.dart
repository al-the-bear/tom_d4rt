// D4rt test script: Tests DiagnosticsDebugCreator from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsDebugCreator test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  // DiagnosticsDebugCreator wraps an Element for debug information
  // We'll use context which is an Element (BuildContext is implemented by Element)
  final element = context as Element;

  final debugCreator = DiagnosticsDebugCreator(element);
  print('Created DiagnosticsDebugCreator');
  print('Value type: ${debugCreator.value.runtimeType}');
  results.add('Created with element type: ${element.runtimeType}');

  // ========== Section 2: Value Property ==========
  print('--- Section 2: Value Property ---');

  final value = debugCreator.value;
  print('Value: $value');
  print('Value is Element: ${value is Element}');
  results.add('Value is Element: ${value is Element}');

  // ========== Section 3: DiagnosticsProperty Base ==========
  print('--- Section 3: DiagnosticsProperty Base ---');

  // DiagnosticsDebugCreator extends DiagnosticsProperty<Element>
  print('Is DiagnosticsProperty: ${debugCreator is DiagnosticsProperty}');
  print('Name: ${debugCreator.name}');
  print('Level: ${debugCreator.level}');
  results.add('Name: ${debugCreator.name}, Level: ${debugCreator.level}');

  // ========== Section 4: ToString Methods ==========
  print('--- Section 4: ToString Methods ---');

  final str = debugCreator.toString();
  print('toString: $str');

  final jsonStr = debugCreator.toJsonMap(DiagnosticsSerializationDelegate());
  print('toJsonMap keys: ${jsonStr.keys.join(", ")}');
  results.add('Has toString: ${str.isNotEmpty}');

  // ========== Section 5: Description ==========
  print('--- Section 5: Description ---');

  final description = debugCreator.toDescription();
  print('Description: $description');
  results.add('Description available: ${description.isNotEmpty}');

  // ========== Section 6: With Different Elements ==========
  print('--- Section 6: With Different Elements ---');

  // Get widget from context
  final widget = context.widget;
  print('Widget type: ${widget.runtimeType}');
  print('Element widget: ${element.widget.runtimeType}');
  results.add('Widget type: ${widget.runtimeType}');

  // ========== Section 7: Property Features ==========
  print('--- Section 7: Property Features ---');

  // Check diagnostic property features
  print('isFiltered: ${debugCreator.isFiltered(DiagnosticLevel.info)}');
  print('allowWrap: ${debugCreator.allowWrap}');
  print('allowNameWrap: ${debugCreator.allowNameWrap}');
  results.add('allowWrap: ${debugCreator.allowWrap}');

  // ========== Section 8: Expandable Children ==========
  print('--- Section 8: Expandable Children ---');

  final children = debugCreator.getChildren();
  print('Children count: ${children.length}');
  for (var child in children.take(3)) {
    print('  Child: ${child.name}');
  }
  results.add('Children count: ${children.length}');

  // ========== Section 9: Properties ==========
  print('--- Section 9: Properties ---');

  final properties = debugCreator.getProperties();
  print('Properties count: ${properties.length}');
  for (var prop in properties.take(3)) {
    print('  Property: ${prop.name}');
  }
  results.add('Properties count: ${properties.length}');

  // ========== Section 10: Style ==========
  print('--- Section 10: Style ---');

  print('Style: ${debugCreator.style}');
  print('ShowName: ${debugCreator.showName}');
  print('ShowSeparator: ${debugCreator.showSeparator}');
  results.add('Style: ${debugCreator.style}');

  print('DiagnosticsDebugCreator test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'DiagnosticsDebugCreator Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
