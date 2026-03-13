// D4rt Bridge - Generated file, do not edit
// Source: C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_part_of_files.dart
// Generated: 2026-03-12T17:07:02.178952

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4_example/test_part_of_files.dart' as $d4_example_1;

/// Bridge class for test_part_of_files module.
class TestPartOfFilesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPartOfTestServiceBridge(),
      _createPartCallbackBridge(),
      _createPartDataBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'PartOfTestService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_part_of_files.dart',
      'PartCallback': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_part_of_files.dart',
      'PartData': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_part_of_files.dart',
    };
  }

    isAssignable: (v) => v is PartOfTestService,
    constructors: {
      '': (visitor, positional, named) {
        final callback = D4.getOptionalNamedArg<$d4_example_1.PartCallback?>(named, 'callback');
        final data = D4.getRequiredNamedArg<$d4_example_1.PartData>(named, 'data', 'PartOfTestService');
        return PartOfTestService(callback: callback, data: data);
      },
    },
    getters: {
      'callback': (visitor, target) => D4.validateTarget<PartOfTestService>(target, 'PartOfTestService').callback,
      'data': (visitor, target) => D4.validateTarget<PartOfTestService>(target, 'PartOfTestService').data,
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PartOfTestService>(target, 'PartOfTestService');
        t.execute();
        return null;
      },
    },
    constructorSignatures: {
      '': 'PartOfTestService({PartCallback? callback, required PartData data})',
    },
    methodSignatures: {
      'execute': 'void execute()',
    },
    getterSignatures: {
      'callback': 'PartCallback? get callback',
      'data': 'PartData get data',
    },
  );
}

// =============================================================================
// PartCallback Bridge
// =============================================================================

BridgedClass _createPartCallbackBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.PartCallback,
    name: 'PartCallback',
    constructors: {
      '': (visitor, positional, named) {
        final onDataRaw = named['onData'];
        final onErrorRaw = named['onError'];
        return $d4_example_1.PartCallback(onData: onDataRaw == null ? null : ($d4_example_1.PartData p0) { D4.callInterpreterCallback(visitor, onDataRaw, [p0]); }, onError: onErrorRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0]); });
      },
      'dataOnly': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PartCallback');
        if (positional.isEmpty) {
          throw ArgumentError('PartCallback: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        return $d4_example_1.PartCallback.dataOnly(($d4_example_1.PartData p0) { D4.callInterpreterCallback(visitor, handlerRaw, [p0]); });
      },
    },
    getters: {
      'onData': (visitor, target) => D4.validateTarget<$d4_example_1.PartCallback>(target, 'PartCallback').onData,
      'onError': (visitor, target) => D4.validateTarget<$d4_example_1.PartCallback>(target, 'PartCallback').onError,
    },
    constructorSignatures: {
      '': 'const PartCallback({void Function(PartData)? onData, void Function(String)? onError})',
      'dataOnly': 'factory PartCallback.dataOnly(void Function(PartData data) handler)',
    },
    getterSignatures: {
      'onData': 'void Function(PartData data)? get onData',
      'onError': 'void Function(String error)? get onError',
    },
  );
}

// =============================================================================
// PartData Bridge
// =============================================================================

BridgedClass _createPartDataBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.PartData,
    name: 'PartData',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PartData');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PartData');
        final value = D4.getRequiredArg<int>(positional, 1, 'value', 'PartData');
        return $d4_example_1.PartData(name, value);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_1.PartData>(target, 'PartData').name,
      'value': (visitor, target) => D4.validateTarget<$d4_example_1.PartData>(target, 'PartData').value,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.PartData>(target, 'PartData');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const PartData(String name, int value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'value': 'int get value',
    },
  );
}

