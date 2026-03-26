// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/semantics.dart';
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

  print('ChildSemanticsConfigurationsResult test executing');
  print('=' * 50);

  final Type symbol = ChildSemanticsConfigurationsResult;
  runCase('symbol type resolves', () => symbol.toString().contains('ChildSemanticsConfigurationsResult'));

  runCase('SemanticsConfiguration stores value', () {
    final SemanticsConfiguration conf = SemanticsConfiguration();
    conf.value = '42';
    return conf.value == '42';
  });

  runCase('SemanticsSortKey ordering numeric', () {
    const OrdinalSortKey a = OrdinalSortKey(1);
    const OrdinalSortKey b = OrdinalSortKey(2);
    return a.order < b.order;
  });

  runCase('SemanticsValidationResult has values', () {
    return SemanticsValidationResult.values.isNotEmpty;
  });

  runCase('AnnounceSemanticsEvent type available', () {
    final Type t = AnnounceSemanticsEvent;
    return t.toString().contains('AnnounceSemanticsEvent');
  });

  runCase('TapSemanticEvent type available', () {
    final Type t = TapSemanticEvent;
    return t.toString().contains('TapSemanticEvent');
  });

  runCase('TooltipSemanticsEvent type available', () {
    final Type t = TooltipSemanticsEvent;
    return t.toString().contains('TooltipSemanticsEvent');
  });

  runCase('Summary string generated', () {
    final String summary = '${symbol.toString()}:${SemanticsValidationResult.values.length}';
    return summary.contains(':');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ChildSemanticsConfigurationsResult Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Semantics result checks executed'),
    ],
  );
}
