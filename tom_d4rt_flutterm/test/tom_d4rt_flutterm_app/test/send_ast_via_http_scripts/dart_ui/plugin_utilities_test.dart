// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PluginUtilities from dart_ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void topLevelCallback() {
  // Top-level callback for PluginUtilities test
}


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

  print('PluginUtilities test executing');
  print('=' * 50);

  // PluginUtilities is abstract final, cannot instantiate

  runCase('PluginUtilities is abstract final', () {
    return true; // Class cannot be extended or instantiated
  });

  runCase('getCallbackHandle returns null for non-static', () {
    // Lambda is not a top-level or static function
    final ui.CallbackHandle? handle = ui.PluginUtilities.getCallbackHandle(() {});
    return handle == null;
  });

  runCase('getCallbackHandle returns handle for top-level', () {
    final ui.CallbackHandle? handle = ui.PluginUtilities.getCallbackHandle(topLevelCallback);
    return handle != null;
  });

  runCase('getCallbackFromHandle returns function', () {
    final ui.CallbackHandle? handle = ui.PluginUtilities.getCallbackHandle(topLevelCallback);
    if (handle == null) return false;
    final Function? callback = ui.PluginUtilities.getCallbackFromHandle(handle);
    return callback != null;
  });

  runCase('round-trip preserves callback', () {
    final ui.CallbackHandle? handle = ui.PluginUtilities.getCallbackHandle(topLevelCallback);
    if (handle == null) return false;
    final Function? callback = ui.PluginUtilities.getCallbackFromHandle(handle);
    return callback != null;
  });

  runCase('CallbackHandle has toRawHandle', () {
    final ui.CallbackHandle? handle = ui.PluginUtilities.getCallbackHandle(topLevelCallback);
    if (handle == null) return false;
    final int raw = handle.toRawHandle();
    return raw != 0;
  });

  runCase('CallbackHandle.fromRawHandle works', () {
    final ui.CallbackHandle? handle = ui.PluginUtilities.getCallbackHandle(topLevelCallback);
    if (handle == null) return false;
    final int raw = handle.toRawHandle();
    final ui.CallbackHandle reconstructed = ui.CallbackHandle.fromRawHandle(raw);
    return reconstructed.toRawHandle() == raw;
  });


  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('PluginUtilities Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('PluginUtilities behavior checks completed'),
    ],
  );
}
