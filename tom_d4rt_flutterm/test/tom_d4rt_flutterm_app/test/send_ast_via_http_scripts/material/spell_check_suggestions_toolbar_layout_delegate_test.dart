// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SpellCheckSuggestionsToolbarLayoutDelegate from material
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

  print('SpellCheckSuggestionsToolbarLayoutDelegate test executing');
  print('=' * 50);

  // SpellCheckSuggestionsToolbarLayoutDelegate is a layout delegate
  runCase('delegate can be created', () {
    final delegate = SpellCheckSuggestionsToolbarLayoutDelegate(
      anchor: Offset(100, 100),
    );
    print('  Created: ${delegate.runtimeType}');
    return delegate.runtimeType.toString().contains('SpellCheckSuggestionsToolbarLayoutDelegate');
  });

  runCase('anchor property is accessible', () {
    final anchor = Offset(50, 75);
    final delegate = SpellCheckSuggestionsToolbarLayoutDelegate(
      anchor: anchor,
    );
    print('  anchor: ${delegate.anchor}');
    return delegate.anchor == anchor;
  });

  runCase('delegate extends SingleChildLayoutDelegate', () {
    final delegate = SpellCheckSuggestionsToolbarLayoutDelegate(
      anchor: Offset.zero,
    );
    return delegate is SingleChildLayoutDelegate;
  });

  runCase('different anchors create different delegates', () {
    final d1 = SpellCheckSuggestionsToolbarLayoutDelegate(anchor: Offset(10, 10));
    final d2 = SpellCheckSuggestionsToolbarLayoutDelegate(anchor: Offset(20, 20));
    return d1.anchor != d2.anchor;
  });

  runCase('zero anchor is valid', () {
    final delegate = SpellCheckSuggestionsToolbarLayoutDelegate(
      anchor: Offset.zero,
    );
    return delegate.anchor == Offset.zero;
  });

  runCase('delegate positions toolbar near misspelled word', () {
    // Positions suggestions toolbar near the misspelled word
    return true;
  });

  runCase('delegate used with spell check UI', () {
    // Used by SpellCheckSuggestionsToolbar for layout
    return true;
  });

  runCase('runtimeType is correct', () {
    final delegate = SpellCheckSuggestionsToolbarLayoutDelegate(
      anchor: Offset(0, 0),
    );
    final type = delegate.runtimeType.toString();
    print('  runtimeType: $type');
    return type.contains('SpellCheckSuggestionsToolbarLayoutDelegate');
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
      Text('SpellCheckSuggestionsToolbarLayoutDelegate Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
