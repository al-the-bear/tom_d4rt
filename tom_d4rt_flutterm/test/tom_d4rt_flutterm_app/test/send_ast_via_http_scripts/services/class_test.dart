// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const String targetName = 'Class';
  const String targetSection = 'services';
  const String targetToken = 'Class';
  const String targetRole = 'metadata';

  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String id, bool Function() body) {
    try {
      final bool ok = body();
      if (ok) {
        passed.add(id);
        print('PASS [' + id + ']');
      } else {
        failed.add(id);
        print('FAIL [' + id + ']');
      }
    } catch (error, stackTrace) {
      failed.add(id + ':exception');
      print('FAIL [' + id + '] exception: ' + error.toString());
      print(stackTrace.toString());
    }
  }

  String normalize(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  bool roleMatchesName(String role, String name) {
    final String n = name.toLowerCase();
    if (role == 'controller') return n.contains('controller') || n.contains('manager') || n.contains('session');
    if (role == 'event') return n.contains('event') || n.contains('key');
    if (role == 'layout') return n.contains('wrap') || n.contains('parent') || n.contains('semantics');
    if (role == 'platform') return n.contains('ios') || n.contains('mac') || n.contains('gtk') || n.contains('kit');
    return true;
  }

  print('=== TEST SUITE START ===');
  print('targetName=' + targetName);
  print('targetSection=' + targetSection);
  print('targetToken=' + targetToken);
  print('targetRole=' + targetRole);

  runCase('name_non_empty', () => targetName.isNotEmpty);
  runCase('section_non_empty', () => targetSection.isNotEmpty);
  runCase('token_non_empty', () => targetToken.isNotEmpty);
  runCase('role_non_empty', () => targetRole.isNotEmpty);
  runCase('name_contains_token', () => normalize(targetName).contains(normalize(targetToken)));
  runCase('section_is_known_bucket', () {
    return targetSection == 'rendering' || targetSection == 'semantics' || targetSection == 'services';
  });
  runCase('role_heuristic_matches_name', () => roleMatchesName(targetRole, targetName));
  runCase('context_widget_type_available', () => context.widget.runtimeType.toString().isNotEmpty);
  runCase('summary_string_format', () {
    final String summary = targetName + ':' + targetSection + ':' + targetRole;
    return summary.split(':').length == 3;
  });
  runCase('token_not_longer_than_name', () => targetToken.length <= targetName.length);

  final int total = passed.length + failed.length;
  final String status = failed.isEmpty ? 'PASS' : 'FAIL';

  print('--- TEST RESULTS ---');
  print('total=' + total.toString());
  print('passed=' + passed.length.toString());
  print('failed=' + failed.length.toString());
  print('status=' + status);
  if (failed.isNotEmpty) {
    print('failed_cases=' + failed.join(','));
  }
  print('=== TEST SUITE END ===');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(targetName + ' Test', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 6),
      Text('Section: ' + targetSection),
      Text('Role: ' + targetRole),
      Text('Token: ' + targetToken),
      Text('Total Cases: ' + total.toString()),
      Text('Passed: ' + passed.length.toString()),
      Text('Failed: ' + failed.length.toString()),
      Text('Status: ' + status),
      const SizedBox(height: 8),
      const Text('See console for full per-case output.'),
    ],
  );
}
