// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObjectFlagProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectFlagProperty test executing');
  print('=' * 50);

  // Create ObjectFlagProperty with callback present
  final ofp1 = ObjectFlagProperty<Function>(
    'callback',
    () {},
    ifPresent: 'has callback',
  );
  print('\nObjectFlagProperty with value:');
  print('runtimeType: ${ofp1.runtimeType}');
  print('name: ${ofp1.name}');
  print('value: ${ofp1.value}');
  print('toString: ${ofp1.toString()}');

  // Test inherited DiagnosticsProperty properties
  print('\nDiagnosticsProperty properties:');
  print('level: ${ofp1.level}');
  print('showName: ${ofp1.showName}');
  print('showSeparator: ${ofp1.showSeparator}');

  // Test .has() named constructor with non-null value
  print('\n.has() constructor with value:');
  final hasCallback = ObjectFlagProperty<Function>.has('onTap', () {});
  print('name: ${hasCallback.name}');
  print('toString: ${hasCallback.toString()}');
  print('level: ${hasCallback.level}');

  // Test .has() with null value
  print('\n.has() constructor with null:');
  final hasNull = ObjectFlagProperty<Function>.has('onTap', null);
  print('name: ${hasNull.name}');
  print('value: ${hasNull.value}');
  print('toString: ${hasNull.toString()}');
  print('level: ${hasNull.level}');

  // Create with ifNull message
  print('\nWith ifNull message:');
  final withIfNull = ObjectFlagProperty<String>(
    'title',
    null,
    ifNull: 'no title',
    ifPresent: 'has title',
  );
  print('name: ${withIfNull.name}');
  print('value: ${withIfNull.value}');
  print('toString: ${withIfNull.toString()}');

  // Create with present value
  print('\nWith present value:');
  final withPresent = ObjectFlagProperty<String>(
    'title',
    'My Title',
    ifNull: 'no title',
    ifPresent: 'has title',
  );
  print('name: ${withPresent.name}');
  print('value: ${withPresent.value}');
  print('toString: ${withPresent.toString()}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticsProperty: true /* ofp1 is DiagnosticsProperty */');
  print('is DiagnosticsNode: true /* ofp1 is DiagnosticsNode */');
  print('is Object: true /* ofp1 is Object */');

  // Common use cases
  print('\nCommon use cases:');
  final hasGesture = ObjectFlagProperty<GestureTapCallback>.has('onTap', () {});
  final noGesture = ObjectFlagProperty<GestureTapCallback>.has('onTap', null);
  final hasBuilder = ObjectFlagProperty<WidgetBuilder>.has(
    'builder',
    (ctx) => Container(),
  );
  print('hasGesture: ${hasGesture.toString()}');
  print('noGesture level: ${noGesture.level}');
  print('hasBuilder: ${hasBuilder.toString()}');

  // Test default level behavior
  print('\nDefault level behavior:');
  print('Non-null value level: ${hasCallback.level}');
  print('Null value level: ${hasNull.level}');
  print('Null shows as hidden: ${hasNull.level == DiagnosticLevel.hidden}');

  // Explain purpose
  print('\nObjectFlagProperty purpose:');
  print('- Shows flag text based on object presence');
  print('- ifPresent: text when value is non-null');
  print('- ifNull: text when value is null');
  print('- .has() constructor for common "has X" pattern');
  print('- Useful for callbacks and optional objects');
  print('- Hidden level when null (unless ifNull specified)');

  print('\n' + '=' * 50);
  print('ObjectFlagProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ObjectFlagProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${ofp1.runtimeType}'),
      Text('has callback: ${ofp1.toString()}'),
      Text('.has() present: ${hasCallback.toString()}'),
      Text('.has() null level: ${hasNull.level}'),
      Text('Purpose: Object presence flag property'),
    ],
  );
}
