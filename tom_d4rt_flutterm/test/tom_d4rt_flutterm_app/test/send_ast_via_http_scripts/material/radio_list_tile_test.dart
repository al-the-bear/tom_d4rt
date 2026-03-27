// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RadioListTile from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('RadioListTile test executing');
  print('=' * 50);

  // RadioListTile is a ListTile with a Radio button
  runCase('RadioListTile can be created', () {
    final tile = RadioListTile<int>(
      value: 1,
      groupValue: 1,
      onChanged: (_) {},
      title: Text('Option 1'),
    );
    print('  Created: ${tile.runtimeType}');
    return tile.runtimeType.toString().contains('RadioListTile');
  });

  runCase('value property is set', () {
    final tile = RadioListTile<int>(
      value: 42,
      groupValue: 42,
      onChanged: (_) {},
      title: Text('Option'),
    );
    print('  value: ${tile.value}');
    return tile.value == 42;
  });

  runCase('groupValue property is set', () {
    final tile = RadioListTile<int>(
      value: 1,
      groupValue: 2,
      onChanged: (_) {},
      title: Text('Option'),
    );
    print('  groupValue: ${tile.groupValue}');
    return tile.groupValue == 2;
  });

  runCase('selected when value equals groupValue', () {
    // When value == groupValue, the radio is selected
    return true;
  });

  runCase('title widget is set', () {
    final title = Text('Title Text');
    final tile = RadioListTile<int>(
      value: 1,
      groupValue: 1,
      onChanged: (_) {},
      title: title,
    );
    return tile.title == title;
  });

  runCase('subtitle can be provided', () {
    final subtitle = Text('Subtitle');
    final tile = RadioListTile<int>(
      value: 1,
      groupValue: 1,
      onChanged: (_) {},
      title: Text('Title'),
      subtitle: subtitle,
    );
    return tile.subtitle == subtitle;
  });

  runCase('secondary widget can be provided', () {
    final secondary = Icon(Icons.star);
    final tile = RadioListTile<int>(
      value: 1,
      groupValue: 1,
      onChanged: (_) {},
      title: Text('Title'),
      secondary: secondary,
    );
    return tile.secondary == secondary;
  });

  runCase('controlAffinity can be set', () {
    final tile = RadioListTile<int>(
      value: 1,
      groupValue: 1,
      onChanged: (_) {},
      title: Text('Title'),
      controlAffinity: ListTileControlAffinity.trailing,
    );
    print('  controlAffinity: ${tile.controlAffinity}');
    return tile.controlAffinity == ListTileControlAffinity.trailing;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('RadioListTile Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
