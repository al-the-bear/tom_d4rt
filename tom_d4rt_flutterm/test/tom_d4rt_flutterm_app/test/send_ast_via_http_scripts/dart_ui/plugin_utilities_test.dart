// D4rt test script: Tests PluginUtilities from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PluginUtilities test executing');

  // PluginUtilities has static methods only, no constructor
  print('PluginUtilities type: ${ui.PluginUtilities}');

  // getCallbackHandle — works with top-level functions
  print('PluginUtilities.getCallbackHandle: CallbackHandle? Function(Function)');
  print('PluginUtilities.getCallbackFromHandle: Function? Function(CallbackHandle)');

  // Test CallbackHandle roundtrip with a well-known raw value
  final handle = ui.CallbackHandle.fromRawHandle(42);
  print('CallbackHandle(42): toRaw=${handle.toRawHandle()}');

  // getCallbackFromHandle with a handle
  // Note: getCallbackFromHandle returns null for handles not registered via getCallbackHandle
  final callback = ui.PluginUtilities.getCallbackFromHandle(handle);
  print('getCallbackFromHandle(42): ${callback != null ? "found" : "null"}');

  // Test with another handle
  final handle2 = ui.CallbackHandle.fromRawHandle(0);
  final callback2 = ui.PluginUtilities.getCallbackFromHandle(handle2);
  print('getCallbackFromHandle(0): ${callback2 != null ? "found" : "null"}');

  print('PluginUtilities test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PluginUtilities Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Static-only class (no constructor)'),
      Text('getCallbackHandle: Function -> CallbackHandle?'),
      Text('getCallbackFromHandle: CallbackHandle -> Function?'),
      Text('CallbackHandle roundtrip: ${handle.toRawHandle()}'),
    ],
  );
}
