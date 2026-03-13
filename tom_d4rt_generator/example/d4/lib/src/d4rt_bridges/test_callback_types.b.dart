// D4rt Bridge - Generated file, do not edit
// Source: C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_callback_types.dart
// Generated: 2026-03-12T17:07:02.672871

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';


/// Bridge class for test_callback_types module.
class TestCallbackTypesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createGenericCallbackServiceBridge(),
      _createCallbackTypeServiceBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'GenericCallbackService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_callback_types.dart',
      'CallbackTypeService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_callback_types.dart',
    };
  }

    isAssignable: (v) => v is GenericCallbackService,
    constructors: {
      '': (visitor, positional, named) {
        return GenericCallbackService();
      },
    },
    methods: {
      'withConnection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GenericCallbackService>(target, 'GenericCallbackService');
        D4.requireMinArgs(positional, 1, 'withConnection');
        if (positional.isEmpty) {
          throw ArgumentError('withConnection: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.withConnection((dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
      'transactional': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GenericCallbackService>(target, 'GenericCallbackService');
        D4.requireMinArgs(positional, 1, 'transactional');
        if (positional.isEmpty) {
          throw ArgumentError('transactional: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.transactional((String p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
      'withBoundedType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GenericCallbackService>(target, 'GenericCallbackService');
        D4.requireMinArgs(positional, 1, 'withBoundedType');
        if (positional.isEmpty) {
          throw ArgumentError('withBoundedType: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.withBoundedType((dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
    },
    constructorSignatures: {
      '': 'GenericCallbackService()',
    },
    methodSignatures: {
      'withConnection': 'FutureOr<T> withConnection(FutureOr<T> Function(dynamic connection) callback)',
      'transactional': 'Future<T> transactional(FutureOr<T> Function(String input) callback)',
      'withBoundedType': 'FutureOr<T> withBoundedType(FutureOr<T> Function(dynamic conn) callback)',
    },
  );
}

// =============================================================================
// CallbackTypeService Bridge
// =============================================================================

BridgedClass _createCallbackTypeServiceBridge() {
  return BridgedClass(
    nativeType: CallbackTypeService,
    name: 'CallbackTypeService',
    isAssignable: (v) => v is CallbackTypeService,
    constructors: {
      '': (visitor, positional, named) {
        return CallbackTypeService();
      },
    },
    methods: {
      'withConnection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CallbackTypeService>(target, 'CallbackTypeService');
        D4.requireMinArgs(positional, 1, 'withConnection');
        if (positional.isEmpty) {
          throw ArgumentError('withConnection: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.withConnection((dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
    },
    constructorSignatures: {
      '': 'CallbackTypeService()',
    },
    methodSignatures: {
      'withConnection': 'Future<String> withConnection(FutureOr<Object> Function(dynamic connection) callback)',
    },
  );
}

