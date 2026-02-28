// D4rt Bridge - Generated file, do not edit
// Sources: 26 files
// Generated: 2026-02-28T12:38:37.209844

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/annotations.dart' as $flutter_1;
import 'package:flutter/src/foundation/assertions.dart' as $flutter_2;
import 'package:flutter/src/foundation/basic_types.dart' as $flutter_3;
import 'package:flutter/src/foundation/binding.dart' as $flutter_4;
import 'package:flutter/src/foundation/bitfield.dart' as $flutter_5;
import 'package:flutter/src/foundation/capabilities.dart' as $flutter_6;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_7;
import 'package:flutter/src/foundation/collections.dart' as $flutter_8;
import 'package:flutter/src/foundation/consolidate_response.dart' as $flutter_9;
import 'package:flutter/src/foundation/constants.dart' as $flutter_10;
import 'package:flutter/src/foundation/debug.dart' as $flutter_11;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_12;
import 'package:flutter/src/foundation/isolates.dart' as $flutter_13;
import 'package:flutter/src/foundation/key.dart' as $flutter_14;
import 'package:flutter/src/foundation/licenses.dart' as $flutter_15;
import 'package:flutter/src/foundation/memory_allocations.dart' as $flutter_16;
import 'package:flutter/src/foundation/object.dart' as $flutter_17;
import 'package:flutter/src/foundation/observer_list.dart' as $flutter_18;
import 'package:flutter/src/foundation/persistent_hash_map.dart' as $flutter_19;
import 'package:flutter/src/foundation/platform.dart' as $flutter_20;
import 'package:flutter/src/foundation/print.dart' as $flutter_21;
import 'package:flutter/src/foundation/serialization.dart' as $flutter_22;
import 'package:flutter/src/foundation/service_extensions.dart' as $flutter_23;
import 'package:flutter/src/foundation/stack_frame.dart' as $flutter_24;
import 'package:flutter/src/foundation/synchronous_future.dart' as $flutter_25;
import 'package:flutter/src/foundation/timeline.dart' as $flutter_26;
import 'package:flutter/src/foundation/unicode.dart' as $flutter_27;
import 'package:meta/meta.dart' as $meta_1;

/// Bridge class for flutter_foundation module.
class FlutterFoundationBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createCategoryBridge(),
      _createDocumentationIconBridge(),
      _createSummaryBridge(),
      _createDiagnosticsNodeBridge(),
      _createDiagnosticPropertiesBuilderBridge(),
      _createStackFrameBridge(),
      _createPartialStackFrameBridge(),
      _createStackFilterBridge(),
      _createRepetitiveStackFrameFilterBridge(),
      _createErrorDescriptionBridge(),
      _createErrorSummaryBridge(),
      _createErrorHintBridge(),
      _createErrorSpacerBridge(),
      _createFlutterErrorDetailsBridge(),
      _createFlutterErrorBridge(),
      _createDiagnosticsStackTraceBridge(),
      _createBindingBaseBridge(),
      _createBitFieldBridge(),
      _createListenableBridge(),
      _createValueListenableBridge(),
      _createChangeNotifierBridge(),
      _createValueNotifierBridge(),
      _createKeyBridge(),
      _createLocalKeyBridge(),
      _createUniqueKeyBridge(),
      _createValueKeyBridge(),
      _createLicenseParagraphBridge(),
      _createLicenseEntryBridge(),
      _createLicenseEntryWithLineBreaksBridge(),
      _createLicenseRegistryBridge(),
      _createObjectEventBridge(),
      _createObjectCreatedBridge(),
      _createObjectDisposedBridge(),
      _createFlutterMemoryAllocationsBridge(),
      _createObserverListBridge(),
      _createHashedObserverListBridge(),
      _createPersistentHashMapBridge(),
      _createWriteBufferBridge(),
      _createReadBufferBridge(),
      _createSynchronousFutureBridge(),
      _createFlutterTimelineBridge(),
      _createTimedBlockBridge(),
      _createAggregatedTimingsBridge(),
      _createAggregatedTimedBlockBridge(),
      _createUnicodeBridge(),
      _createImmutableBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Category': 'package:flutter/src/foundation/annotations.dart',
      'DocumentationIcon': 'package:flutter/src/foundation/annotations.dart',
      'Summary': 'package:flutter/src/foundation/annotations.dart',
      'DiagnosticsNode': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticPropertiesBuilder': 'package:flutter/src/foundation/diagnostics.dart',
      'StackFrame': 'package:flutter/src/foundation/stack_frame.dart',
      'PartialStackFrame': 'package:flutter/src/foundation/assertions.dart',
      'StackFilter': 'package:flutter/src/foundation/assertions.dart',
      'RepetitiveStackFrameFilter': 'package:flutter/src/foundation/assertions.dart',
      'ErrorDescription': 'package:flutter/src/foundation/assertions.dart',
      'ErrorSummary': 'package:flutter/src/foundation/assertions.dart',
      'ErrorHint': 'package:flutter/src/foundation/assertions.dart',
      'ErrorSpacer': 'package:flutter/src/foundation/assertions.dart',
      'FlutterErrorDetails': 'package:flutter/src/foundation/assertions.dart',
      'FlutterError': 'package:flutter/src/foundation/assertions.dart',
      'DiagnosticsStackTrace': 'package:flutter/src/foundation/assertions.dart',
      'BindingBase': 'package:flutter/src/foundation/binding.dart',
      'BitField': 'package:flutter/src/foundation/bitfield.dart',
      'Listenable': 'package:flutter/src/foundation/change_notifier.dart',
      'ValueListenable': 'package:flutter/src/foundation/change_notifier.dart',
      'ChangeNotifier': 'package:flutter/src/foundation/change_notifier.dart',
      'ValueNotifier': 'package:flutter/src/foundation/change_notifier.dart',
      'Key': 'package:flutter/src/foundation/key.dart',
      'LocalKey': 'package:flutter/src/foundation/key.dart',
      'UniqueKey': 'package:flutter/src/foundation/key.dart',
      'ValueKey': 'package:flutter/src/foundation/key.dart',
      'LicenseParagraph': 'package:flutter/src/foundation/licenses.dart',
      'LicenseEntry': 'package:flutter/src/foundation/licenses.dart',
      'LicenseEntryWithLineBreaks': 'package:flutter/src/foundation/licenses.dart',
      'LicenseRegistry': 'package:flutter/src/foundation/licenses.dart',
      'ObjectEvent': 'package:flutter/src/foundation/memory_allocations.dart',
      'ObjectCreated': 'package:flutter/src/foundation/memory_allocations.dart',
      'ObjectDisposed': 'package:flutter/src/foundation/memory_allocations.dart',
      'FlutterMemoryAllocations': 'package:flutter/src/foundation/memory_allocations.dart',
      'ObserverList': 'package:flutter/src/foundation/observer_list.dart',
      'HashedObserverList': 'package:flutter/src/foundation/observer_list.dart',
      'PersistentHashMap': 'package:flutter/src/foundation/persistent_hash_map.dart',
      'WriteBuffer': 'package:flutter/src/foundation/serialization.dart',
      'ReadBuffer': 'package:flutter/src/foundation/serialization.dart',
      'SynchronousFuture': 'package:flutter/src/foundation/synchronous_future.dart',
      'FlutterTimeline': 'package:flutter/src/foundation/timeline.dart',
      'TimedBlock': 'package:flutter/src/foundation/timeline.dart',
      'AggregatedTimings': 'package:flutter/src/foundation/timeline.dart',
      'AggregatedTimedBlock': 'package:flutter/src/foundation/timeline.dart',
      'Unicode': 'package:flutter/src/foundation/unicode.dart',
      'Immutable': 'package:meta/meta.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_12.DiagnosticLevel>(
        name: 'DiagnosticLevel',
        values: $flutter_12.DiagnosticLevel.values,
      ),
      BridgedEnumDefinition<$flutter_12.DiagnosticsTreeStyle>(
        name: 'DiagnosticsTreeStyle',
        values: $flutter_12.DiagnosticsTreeStyle.values,
      ),
      BridgedEnumDefinition<$flutter_20.TargetPlatform>(
        name: 'TargetPlatform',
        values: $flutter_20.TargetPlatform.values,
      ),
      BridgedEnumDefinition<$flutter_23.FoundationServiceExtensions>(
        name: 'FoundationServiceExtensions',
        values: $flutter_23.FoundationServiceExtensions.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'DiagnosticLevel': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticsTreeStyle': 'package:flutter/src/foundation/diagnostics.dart',
      'TargetPlatform': 'package:flutter/src/foundation/platform.dart',
      'FoundationServiceExtensions': 'package:flutter/src/foundation/service_extensions.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('factory', $meta_1.factory, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "factory": $e');
    }
    try {
      interpreter.registerGlobalVariable('immutable', $meta_1.immutable, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "immutable": $e');
    }
    try {
      interpreter.registerGlobalVariable('internal', $meta_1.internal, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "internal": $e');
    }
    try {
      interpreter.registerGlobalVariable('mustCallSuper', $meta_1.mustCallSuper, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "mustCallSuper": $e');
    }
    try {
      interpreter.registerGlobalVariable('nonVirtual', $meta_1.nonVirtual, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "nonVirtual": $e');
    }
    try {
      interpreter.registerGlobalVariable('optionalTypeArgs', $meta_1.optionalTypeArgs, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "optionalTypeArgs": $e');
    }
    try {
      interpreter.registerGlobalVariable('protected', $meta_1.protected, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "protected": $e');
    }
    try {
      interpreter.registerGlobalVariable('visibleForOverriding', $meta_1.visibleForOverriding, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "visibleForOverriding": $e');
    }
    try {
      interpreter.registerGlobalVariable('visibleForTesting', $meta_1.visibleForTesting, importPath, sourceUri: 'package:meta/meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "visibleForTesting": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMaxUnsignedSMI', $flutter_5.kMaxUnsignedSMI, importPath, sourceUri: 'package:flutter/src/foundation/bitfield.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMaxUnsignedSMI": $e');
    }
    try {
      interpreter.registerGlobalVariable('kReleaseMode', $flutter_10.kReleaseMode, importPath, sourceUri: 'package:flutter/src/foundation/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kReleaseMode": $e');
    }
    try {
      interpreter.registerGlobalVariable('kProfileMode', $flutter_10.kProfileMode, importPath, sourceUri: 'package:flutter/src/foundation/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kProfileMode": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDebugMode', $flutter_10.kDebugMode, importPath, sourceUri: 'package:flutter/src/foundation/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDebugMode": $e');
    }
    try {
      interpreter.registerGlobalVariable('precisionErrorTolerance', $flutter_10.precisionErrorTolerance, importPath, sourceUri: 'package:flutter/src/foundation/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "precisionErrorTolerance": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIsWeb', $flutter_10.kIsWeb, importPath, sourceUri: 'package:flutter/src/foundation/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIsWeb": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIsWasm', $flutter_10.kIsWasm, importPath, sourceUri: 'package:flutter/src/foundation/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIsWasm": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugInstrumentationEnabled', $flutter_11.debugInstrumentationEnabled, importPath, sourceUri: 'package:flutter/src/foundation/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugInstrumentationEnabled": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugDoublePrecision', $flutter_11.debugDoublePrecision, importPath, sourceUri: 'package:flutter/src/foundation/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugDoublePrecision": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugBrightnessOverride', $flutter_11.debugBrightnessOverride, importPath, sourceUri: 'package:flutter/src/foundation/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugBrightnessOverride": $e');
    }
    try {
      interpreter.registerGlobalVariable('activeDevToolsServerAddress', $flutter_11.activeDevToolsServerAddress, importPath, sourceUri: 'package:flutter/src/foundation/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "activeDevToolsServerAddress": $e');
    }
    try {
      interpreter.registerGlobalVariable('connectedVmServiceUri', $flutter_11.connectedVmServiceUri, importPath, sourceUri: 'package:flutter/src/foundation/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "connectedVmServiceUri": $e');
    }
    try {
      interpreter.registerGlobalVariable('kFlutterMemoryAllocationsEnabled', $flutter_16.kFlutterMemoryAllocationsEnabled, importPath, sourceUri: 'package:flutter/src/foundation/memory_allocations.dart');
    } catch (e) {
      errors.add('Failed to register variable "kFlutterMemoryAllocationsEnabled": $e');
    }
    interpreter.registerGlobalGetter('isCanvasKit', () => $flutter_6.isCanvasKit, importPath, sourceUri: 'package:flutter/src/foundation/capabilities.dart');
    interpreter.registerGlobalGetter('isSkwasm', () => $flutter_6.isSkwasm, importPath, sourceUri: 'package:flutter/src/foundation/capabilities.dart');
    interpreter.registerGlobalGetter('isSkiaWeb', () => $flutter_6.isSkiaWeb, importPath, sourceUri: 'package:flutter/src/foundation/capabilities.dart');
    interpreter.registerGlobalGetter('defaultTargetPlatform', () => $flutter_20.defaultTargetPlatform, importPath, sourceUri: 'package:flutter/src/foundation/platform.dart');
    interpreter.registerGlobalGetter('debugDefaultTargetPlatformOverride', () => $flutter_20.debugDefaultTargetPlatformOverride, importPath, sourceUri: 'package:flutter/src/foundation/platform.dart');
    interpreter.registerGlobalSetter('debugDefaultTargetPlatformOverride', (v) => $flutter_20.debugDefaultTargetPlatformOverride = v as $flutter_20.TargetPlatform?, importPath, sourceUri: 'package:flutter/src/foundation/platform.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_foundation):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'debugPrintStack': (visitor, positional, named, typeArgs) {
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final maxFrames = D4.getOptionalNamedArg<int?>(named, 'maxFrames');
        return $flutter_2.debugPrintStack(stackTrace: stackTrace, label: label, maxFrames: maxFrames);
      },
      'setEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setEquals');
        final a = D4.getRequiredArg<Set<dynamic>?>(positional, 0, 'a', 'setEquals');
        final b = D4.getRequiredArg<Set<dynamic>?>(positional, 1, 'b', 'setEquals');
        return $flutter_8.setEquals<dynamic>(a, b);
      },
      'listEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'listEquals');
        final a = D4.getRequiredArg<List<dynamic>?>(positional, 0, 'a', 'listEquals');
        final b = D4.getRequiredArg<List<dynamic>?>(positional, 1, 'b', 'listEquals');
        return $flutter_8.listEquals<dynamic>(a, b);
      },
      'mapEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapEquals');
        final a = D4.getRequiredArg<Map<dynamic, dynamic>?>(positional, 0, 'a', 'mapEquals');
        final b = D4.getRequiredArg<Map<dynamic, dynamic>?>(positional, 1, 'b', 'mapEquals');
        return $flutter_8.mapEquals<dynamic, dynamic>(a, b);
      },
      'binarySearch': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'binarySearch');
        final sortedList = D4.getRequiredArg<List<Comparable<Object>>>(positional, 0, 'sortedList', 'binarySearch');
        final value = D4.getRequiredArg<Comparable<Object>>(positional, 1, 'value', 'binarySearch');
        return $flutter_8.binarySearch(sortedList, value);
      },
      'mergeSort': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'mergeSort');
        final list = D4.getRequiredArg<List<dynamic>>(positional, 0, 'list', 'mergeSort');
        final start = D4.getNamedArgWithDefault<int>(named, 'start', 0);
        final end = D4.getOptionalNamedArg<int?>(named, 'end');
        final compareRaw = named['compare'];
        final compare = compareRaw == null ? null : (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, compareRaw, [p0, p1]) as int; };
        return $flutter_8.mergeSort<dynamic>(list, start: start, end: end, compare: compare);
      },
      'consolidateHttpClientResponseBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'consolidateHttpClientResponseBytes');
        final response = D4.getRequiredArg<HttpClientResponse>(positional, 0, 'response', 'consolidateHttpClientResponseBytes');
        final autoUncompress = D4.getNamedArgWithDefault<bool>(named, 'autoUncompress', true);
        final onBytesReceivedRaw = named['onBytesReceived'];
        final onBytesReceived = onBytesReceivedRaw == null ? null : (int p0, int? p1) { D4.callInterpreterCallback(visitor, onBytesReceivedRaw, [p0, p1]); };
        return $flutter_9.consolidateHttpClientResponseBytes(response, autoUncompress: autoUncompress, onBytesReceived: onBytesReceived);
      },
      'debugAssertAllFoundationVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllFoundationVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllFoundationVarsUnset');
        if (!named.containsKey('debugPrintOverride')) {
          return $flutter_11.debugAssertAllFoundationVarsUnset(reason);
        }
        if (named.containsKey('debugPrintOverride')) {
          final debugPrintOverrideRaw = named['debugPrintOverride'];
          final debugPrintOverride = (String? p0, {int? wrapWidth}) { D4.callInterpreterCallback(visitor, debugPrintOverrideRaw, [p0], {'wrapWidth': wrapWidth}); };
          return $flutter_11.debugAssertAllFoundationVarsUnset(reason, debugPrintOverride: debugPrintOverride);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'debugInstrumentAction': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'debugInstrumentAction');
        final description = D4.getRequiredArg<String>(positional, 0, 'description', 'debugInstrumentAction');
        if (positional.length <= 1) {
          throw ArgumentError('debugInstrumentAction: Missing required argument "action" at position 1');
        }
        final actionRaw = positional[1];
        final action = () { return D4.callInterpreterCallback(visitor, actionRaw, []) as Future<dynamic>; };
        return $flutter_11.debugInstrumentAction<dynamic>(description, action);
      },
      'debugFormatDouble': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugFormatDouble');
        final value = D4.getRequiredArg<double?>(positional, 0, 'value', 'debugFormatDouble');
        return $flutter_11.debugFormatDouble(value);
      },
      'debugMaybeDispatchCreated': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'debugMaybeDispatchCreated');
        final flutterLibrary = D4.getRequiredArg<String>(positional, 0, 'flutterLibrary', 'debugMaybeDispatchCreated');
        final className = D4.getRequiredArg<String>(positional, 1, 'className', 'debugMaybeDispatchCreated');
        final object = D4.getRequiredArg<Object>(positional, 2, 'object', 'debugMaybeDispatchCreated');
        return $flutter_11.debugMaybeDispatchCreated(flutterLibrary, className, object);
      },
      'debugMaybeDispatchDisposed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugMaybeDispatchDisposed');
        final object = D4.getRequiredArg<Object>(positional, 0, 'object', 'debugMaybeDispatchDisposed');
        return $flutter_11.debugMaybeDispatchDisposed(object);
      },
      'compute': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'compute');
        if (positional.isEmpty) {
          throw ArgumentError('compute: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = (dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; };
        final message = D4.getRequiredArg<dynamic>(positional, 1, 'message', 'compute');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        return $flutter_13.compute<dynamic, dynamic>(callback, message, debugLabel: debugLabel);
      },
      'objectRuntimeType': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'objectRuntimeType');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'objectRuntimeType');
        final optimizedValue = D4.getRequiredArg<String>(positional, 1, 'optimizedValue', 'objectRuntimeType');
        return $flutter_17.objectRuntimeType(object, optimizedValue);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'debugPrintStack': 'package:flutter/src/foundation/assertions.dart',
      'setEquals': 'package:flutter/src/foundation/collections.dart',
      'listEquals': 'package:flutter/src/foundation/collections.dart',
      'mapEquals': 'package:flutter/src/foundation/collections.dart',
      'binarySearch': 'package:flutter/src/foundation/collections.dart',
      'mergeSort': 'package:flutter/src/foundation/collections.dart',
      'consolidateHttpClientResponseBytes': 'package:flutter/src/foundation/consolidate_response.dart',
      'debugAssertAllFoundationVarsUnset': 'package:flutter/src/foundation/debug.dart',
      'debugInstrumentAction': 'package:flutter/src/foundation/debug.dart',
      'debugFormatDouble': 'package:flutter/src/foundation/debug.dart',
      'debugMaybeDispatchCreated': 'package:flutter/src/foundation/debug.dart',
      'debugMaybeDispatchDisposed': 'package:flutter/src/foundation/debug.dart',
      'compute': 'package:flutter/src/foundation/isolates.dart',
      'objectRuntimeType': 'package:flutter/src/foundation/object.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'debugPrintStack': 'void debugPrintStack({StackTrace? stackTrace, String? label, int? maxFrames})',
      'setEquals': 'bool setEquals(Set<T>? a, Set<T>? b)',
      'listEquals': 'bool listEquals(List<T>? a, List<T>? b)',
      'mapEquals': 'bool mapEquals(Map<T, U>? a, Map<T, U>? b)',
      'binarySearch': 'int binarySearch(List<T> sortedList, T value)',
      'mergeSort': 'void mergeSort(List<T> list, {int start = 0, int? end, int Function(T, T)? compare})',
      'consolidateHttpClientResponseBytes': 'Future<Uint8List> consolidateHttpClientResponseBytes(HttpClientResponse response, {bool autoUncompress = true, BytesReceivedCallback? onBytesReceived})',
      'debugAssertAllFoundationVarsUnset': 'bool debugAssertAllFoundationVarsUnset(String reason, {DebugPrintCallback debugPrintOverride = debugPrintThrottled})',
      'debugInstrumentAction': 'Future<T> debugInstrumentAction(String description, Future<T> Function() action)',
      'debugFormatDouble': 'String debugFormatDouble(double? value)',
      'debugMaybeDispatchCreated': 'bool debugMaybeDispatchCreated(String flutterLibrary, String className, Object object)',
      'debugMaybeDispatchDisposed': 'bool debugMaybeDispatchDisposed(Object object)',
      'compute': 'Future<R> compute(ComputeCallback<M, R> callback, M message, {String? debugLabel})',
      'objectRuntimeType': 'String objectRuntimeType(Object? object, String optimizedValue)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:flutter/src/foundation/annotations.dart',
      'package:flutter/src/foundation/assertions.dart',
      'package:flutter/src/foundation/binding.dart',
      'package:flutter/src/foundation/bitfield.dart',
      'package:flutter/src/foundation/capabilities.dart',
      'package:flutter/src/foundation/change_notifier.dart',
      'package:flutter/src/foundation/collections.dart',
      'package:flutter/src/foundation/consolidate_response.dart',
      'package:flutter/src/foundation/constants.dart',
      'package:flutter/src/foundation/debug.dart',
      'package:flutter/src/foundation/diagnostics.dart',
      'package:flutter/src/foundation/isolates.dart',
      'package:flutter/src/foundation/key.dart',
      'package:flutter/src/foundation/licenses.dart',
      'package:flutter/src/foundation/memory_allocations.dart',
      'package:flutter/src/foundation/object.dart',
      'package:flutter/src/foundation/observer_list.dart',
      'package:flutter/src/foundation/persistent_hash_map.dart',
      'package:flutter/src/foundation/platform.dart',
      'package:flutter/src/foundation/serialization.dart',
      'package:flutter/src/foundation/service_extensions.dart',
      'package:flutter/src/foundation/stack_frame.dart',
      'package:flutter/src/foundation/synchronous_future.dart',
      'package:flutter/src/foundation/timeline.dart',
      'package:flutter/src/foundation/unicode.dart',
      'package:meta/meta.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    final imports = StringBuffer();
    imports.writeln("import 'package:flutter/foundation.dart';");
    imports.writeln("import 'package:meta/meta.dart';");
    return imports.toString();
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [
      'package:meta/meta.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'DiagnosticLevel',
    'DiagnosticsTreeStyle',
    'TargetPlatform',
    'FoundationServiceExtensions',
  ];

}

// =============================================================================
// Category Bridge
// =============================================================================

BridgedClass _createCategoryBridge() {
  return BridgedClass(
    nativeType: $flutter_1.Category,
    name: 'Category',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Category');
        if (positional.isEmpty) {
          throw ArgumentError('Category: Missing required argument "sections" at position 0');
        }
        final sections = D4.coerceList<String>(positional[0], 'sections');
        return $flutter_1.Category(sections);
      },
    },
    getters: {
      'sections': (visitor, target) => D4.validateTarget<$flutter_1.Category>(target, 'Category').sections,
    },
    constructorSignatures: {
      '': 'const Category(List<String> sections)',
    },
    getterSignatures: {
      'sections': 'List<String> get sections',
    },
  );
}

// =============================================================================
// DocumentationIcon Bridge
// =============================================================================

BridgedClass _createDocumentationIconBridge() {
  return BridgedClass(
    nativeType: $flutter_1.DocumentationIcon,
    name: 'DocumentationIcon',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentationIcon');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'DocumentationIcon');
        return $flutter_1.DocumentationIcon(url);
      },
    },
    getters: {
      'url': (visitor, target) => D4.validateTarget<$flutter_1.DocumentationIcon>(target, 'DocumentationIcon').url,
    },
    constructorSignatures: {
      '': 'const DocumentationIcon(String url)',
    },
    getterSignatures: {
      'url': 'String get url',
    },
  );
}

// =============================================================================
// Summary Bridge
// =============================================================================

BridgedClass _createSummaryBridge() {
  return BridgedClass(
    nativeType: $flutter_1.Summary,
    name: 'Summary',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Summary');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'Summary');
        return $flutter_1.Summary(text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_1.Summary>(target, 'Summary').text,
    },
    constructorSignatures: {
      '': 'const Summary(String text)',
    },
    getterSignatures: {
      'text': 'String get text',
    },
  );
}

// =============================================================================
// DiagnosticsNode Bridge
// =============================================================================

BridgedClass _createDiagnosticsNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticsNode,
    name: 'DiagnosticsNode',
    constructors: {
      'message': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsNode');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DiagnosticsNode');
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        return $flutter_12.DiagnosticsNode.message(message, style: style, level: level, allowWrap: allowWrap);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').allowTruncate,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    staticMethods: {
      'toJsonList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'toJsonList');
        if (positional.isEmpty) {
          throw ArgumentError('toJsonList: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceListOrNull<$flutter_12.DiagnosticsNode>(positional[0], 'nodes');
        final parent = D4.getRequiredArg<$flutter_12.DiagnosticsNode?>(positional, 1, 'parent', 'toJsonList');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 2, 'delegate', 'toJsonList');
        return $flutter_12.DiagnosticsNode.toJsonList(nodes, parent, delegate);
      },
    },
    constructorSignatures: {
      'message': 'factory DiagnosticsNode.message(String message, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info, bool allowWrap = true})',
    },
    methodSignatures: {
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'Object? get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
    },
    staticMethodSignatures: {
      'toJsonList': 'List<Map<String, Object?>> toJsonList(List<DiagnosticsNode>? nodes, DiagnosticsNode? parent, DiagnosticsSerializationDelegate delegate)',
    },
  );
}

// =============================================================================
// DiagnosticPropertiesBuilder Bridge
// =============================================================================

BridgedClass _createDiagnosticPropertiesBuilderBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticPropertiesBuilder,
    name: 'DiagnosticPropertiesBuilder',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_12.DiagnosticPropertiesBuilder();
      },
      'fromProperties': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticPropertiesBuilder');
        if (positional.isEmpty) {
          throw ArgumentError('DiagnosticPropertiesBuilder: Missing required argument "properties" at position 0');
        }
        final properties = D4.coerceList<$flutter_12.DiagnosticsNode>(positional[0], 'properties');
        return $flutter_12.DiagnosticPropertiesBuilder.fromProperties(properties);
      },
    },
    getters: {
      'properties': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').properties,
      'defaultDiagnosticsTreeStyle': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription,
    },
    setters: {
      'defaultDiagnosticsTreeStyle': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = value as $flutter_12.DiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = value as String?,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder');
        D4.requireMinArgs(positional, 1, 'add');
        final property = D4.getRequiredArg<$flutter_12.DiagnosticsNode>(positional, 0, 'property', 'add');
        t.add(property);
        return null;
      },
    },
    constructorSignatures: {
      '': 'DiagnosticPropertiesBuilder()',
      'fromProperties': 'DiagnosticPropertiesBuilder.fromProperties(List<DiagnosticsNode> properties)',
    },
    methodSignatures: {
      'add': 'void add(DiagnosticsNode property)',
    },
    getterSignatures: {
      'properties': 'List<DiagnosticsNode> get properties',
      'defaultDiagnosticsTreeStyle': 'DiagnosticsTreeStyle get defaultDiagnosticsTreeStyle',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
    },
    setterSignatures: {
      'defaultDiagnosticsTreeStyle': 'set defaultDiagnosticsTreeStyle(dynamic value)',
      'emptyBodyDescription': 'set emptyBodyDescription(dynamic value)',
    },
  );
}

// =============================================================================
// StackFrame Bridge
// =============================================================================

BridgedClass _createStackFrameBridge() {
  return BridgedClass(
    nativeType: $flutter_24.StackFrame,
    name: 'StackFrame',
    constructors: {
      '': (visitor, positional, named) {
        final number = D4.getRequiredNamedArg<int>(named, 'number', 'StackFrame');
        final column = D4.getRequiredNamedArg<int>(named, 'column', 'StackFrame');
        final line = D4.getRequiredNamedArg<int>(named, 'line', 'StackFrame');
        final packageScheme = D4.getRequiredNamedArg<String>(named, 'packageScheme', 'StackFrame');
        final package = D4.getRequiredNamedArg<String>(named, 'package', 'StackFrame');
        final packagePath = D4.getRequiredNamedArg<String>(named, 'packagePath', 'StackFrame');
        final className = D4.getNamedArgWithDefault<String>(named, 'className', '');
        final method = D4.getRequiredNamedArg<String>(named, 'method', 'StackFrame');
        final isConstructor = D4.getNamedArgWithDefault<bool>(named, 'isConstructor', false);
        final source = D4.getRequiredNamedArg<String>(named, 'source', 'StackFrame');
        return $flutter_24.StackFrame(number: number, column: column, line: line, packageScheme: packageScheme, package: package, packagePath: packagePath, className: className, method: method, isConstructor: isConstructor, source: source);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').source,
      'number': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').number,
      'packageScheme': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').packageScheme,
      'package': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').package,
      'packagePath': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').packagePath,
      'line': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').line,
      'column': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').column,
      'className': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').className,
      'method': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').method,
      'isConstructor': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').isConstructor,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.StackFrame>(target, 'StackFrame');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'asynchronousSuspension': (visitor) => $flutter_24.StackFrame.asynchronousSuspension,
      'stackOverFlowElision': (visitor) => $flutter_24.StackFrame.stackOverFlowElision,
    },
    staticMethods: {
      'fromStackTrace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromStackTrace');
        final stack = D4.getRequiredArg<StackTrace>(positional, 0, 'stack', 'fromStackTrace');
        return $flutter_24.StackFrame.fromStackTrace(stack);
      },
      'fromStackString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromStackString');
        final stack = D4.getRequiredArg<String>(positional, 0, 'stack', 'fromStackString');
        return $flutter_24.StackFrame.fromStackString(stack);
      },
      'fromStackTraceLine': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromStackTraceLine');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'fromStackTraceLine');
        return $flutter_24.StackFrame.fromStackTraceLine(line);
      },
    },
    constructorSignatures: {
      '': 'const StackFrame({required int number, required int column, required int line, required String packageScheme, required String package, required String packagePath, String className = \'\', required String method, bool isConstructor = false, required String source})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'source': 'String get source',
      'number': 'int get number',
      'packageScheme': 'String get packageScheme',
      'package': 'String get package',
      'packagePath': 'String get packagePath',
      'line': 'int get line',
      'column': 'int get column',
      'className': 'String get className',
      'method': 'String get method',
      'isConstructor': 'bool get isConstructor',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'fromStackTrace': 'List<StackFrame> fromStackTrace(StackTrace stack)',
      'fromStackString': 'List<StackFrame> fromStackString(String stack)',
      'fromStackTraceLine': 'StackFrame? fromStackTraceLine(String line)',
    },
    staticGetterSignatures: {
      'asynchronousSuspension': 'StackFrame get asynchronousSuspension',
      'stackOverFlowElision': 'StackFrame get stackOverFlowElision',
    },
  );
}

// =============================================================================
// PartialStackFrame Bridge
// =============================================================================

BridgedClass _createPartialStackFrameBridge() {
  return BridgedClass(
    nativeType: $flutter_2.PartialStackFrame,
    name: 'PartialStackFrame',
    constructors: {
      '': (visitor, positional, named) {
        final package = D4.getRequiredNamedArg<Pattern>(named, 'package', 'PartialStackFrame');
        final className = D4.getRequiredNamedArg<String>(named, 'className', 'PartialStackFrame');
        final method = D4.getRequiredNamedArg<String>(named, 'method', 'PartialStackFrame');
        return $flutter_2.PartialStackFrame(package: package, className: className, method: method);
      },
    },
    getters: {
      'package': (visitor, target) => D4.validateTarget<$flutter_2.PartialStackFrame>(target, 'PartialStackFrame').package,
      'className': (visitor, target) => D4.validateTarget<$flutter_2.PartialStackFrame>(target, 'PartialStackFrame').className,
      'method': (visitor, target) => D4.validateTarget<$flutter_2.PartialStackFrame>(target, 'PartialStackFrame').method,
    },
    methods: {
      'matches': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.PartialStackFrame>(target, 'PartialStackFrame');
        D4.requireMinArgs(positional, 1, 'matches');
        final stackFrame = D4.getRequiredArg<$flutter_24.StackFrame>(positional, 0, 'stackFrame', 'matches');
        return t.matches(stackFrame);
      },
    },
    staticGetters: {
      'asynchronousSuspension': (visitor) => $flutter_2.PartialStackFrame.asynchronousSuspension,
    },
    constructorSignatures: {
      '': 'const PartialStackFrame({required Pattern package, required String className, required String method})',
    },
    methodSignatures: {
      'matches': 'bool matches(StackFrame stackFrame)',
    },
    getterSignatures: {
      'package': 'Pattern get package',
      'className': 'String get className',
      'method': 'String get method',
    },
    staticGetterSignatures: {
      'asynchronousSuspension': 'PartialStackFrame get asynchronousSuspension',
    },
  );
}

// =============================================================================
// StackFilter Bridge
// =============================================================================

BridgedClass _createStackFilterBridge() {
  return BridgedClass(
    nativeType: $flutter_2.StackFilter,
    name: 'StackFilter',
    constructors: {
    },
    methods: {
      'filter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.StackFilter>(target, 'StackFilter');
        D4.requireMinArgs(positional, 2, 'filter');
        if (positional.isEmpty) {
          throw ArgumentError('filter: Missing required argument "stackFrames" at position 0');
        }
        final stackFrames = D4.coerceList<$flutter_24.StackFrame>(positional[0], 'stackFrames');
        if (positional.length <= 1) {
          throw ArgumentError('filter: Missing required argument "reasons" at position 1');
        }
        final reasons = D4.coerceList<String?>(positional[1], 'reasons');
        t.filter(stackFrames, reasons);
        return null;
      },
    },
    methodSignatures: {
      'filter': 'void filter(List<StackFrame> stackFrames, List<String?> reasons)',
    },
  );
}

// =============================================================================
// RepetitiveStackFrameFilter Bridge
// =============================================================================

BridgedClass _createRepetitiveStackFrameFilterBridge() {
  return BridgedClass(
    nativeType: $flutter_2.RepetitiveStackFrameFilter,
    name: 'RepetitiveStackFrameFilter',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('frames') || named['frames'] == null) {
          throw ArgumentError('RepetitiveStackFrameFilter: Missing required named argument "frames"');
        }
        final frames = D4.coerceList<$flutter_2.PartialStackFrame>(named['frames'], 'frames');
        final replacement = D4.getRequiredNamedArg<String>(named, 'replacement', 'RepetitiveStackFrameFilter');
        return $flutter_2.RepetitiveStackFrameFilter(frames: frames, replacement: replacement);
      },
    },
    getters: {
      'frames': (visitor, target) => D4.validateTarget<$flutter_2.RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter').frames,
      'numFrames': (visitor, target) => D4.validateTarget<$flutter_2.RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter').numFrames,
      'replacement': (visitor, target) => D4.validateTarget<$flutter_2.RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter').replacement,
    },
    methods: {
      'filter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter');
        D4.requireMinArgs(positional, 2, 'filter');
        if (positional.isEmpty) {
          throw ArgumentError('filter: Missing required argument "stackFrames" at position 0');
        }
        final stackFrames = D4.coerceList<$flutter_24.StackFrame>(positional[0], 'stackFrames');
        if (positional.length <= 1) {
          throw ArgumentError('filter: Missing required argument "reasons" at position 1');
        }
        final reasons = D4.coerceList<String?>(positional[1], 'reasons');
        t.filter(stackFrames, reasons);
        return null;
      },
    },
    constructorSignatures: {
      '': 'const RepetitiveStackFrameFilter({required List<PartialStackFrame> frames, required String replacement})',
    },
    methodSignatures: {
      'filter': 'void filter(List<StackFrame> stackFrames, List<String?> reasons)',
    },
    getterSignatures: {
      'frames': 'List<PartialStackFrame> get frames',
      'numFrames': 'int get numFrames',
      'replacement': 'String get replacement',
    },
  );
}

// =============================================================================
// ErrorDescription Bridge
// =============================================================================

BridgedClass _createErrorDescriptionBridge() {
  return BridgedClass(
    nativeType: $flutter_2.ErrorDescription,
    name: 'ErrorDescription',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ErrorDescription');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ErrorDescription');
        return $flutter_2.ErrorDescription(message);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').value,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').allowTruncate,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'ErrorDescription(String message)',
    },
    methodSignatures: {
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'value': 'List<Object> get value',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'level': 'DiagnosticLevel get level',
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowTruncate': 'bool get allowTruncate',
    },
  );
}

// =============================================================================
// ErrorSummary Bridge
// =============================================================================

BridgedClass _createErrorSummaryBridge() {
  return BridgedClass(
    nativeType: $flutter_2.ErrorSummary,
    name: 'ErrorSummary',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ErrorSummary');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ErrorSummary');
        return $flutter_2.ErrorSummary(message);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').value,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').allowTruncate,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'ErrorSummary(String message)',
    },
    methodSignatures: {
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'value': 'List<Object> get value',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'level': 'DiagnosticLevel get level',
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowTruncate': 'bool get allowTruncate',
    },
  );
}

// =============================================================================
// ErrorHint Bridge
// =============================================================================

BridgedClass _createErrorHintBridge() {
  return BridgedClass(
    nativeType: $flutter_2.ErrorHint,
    name: 'ErrorHint',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ErrorHint');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ErrorHint');
        return $flutter_2.ErrorHint(message);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').value,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').allowTruncate,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'ErrorHint(String message)',
    },
    methodSignatures: {
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'value': 'List<Object> get value',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'level': 'DiagnosticLevel get level',
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowTruncate': 'bool get allowTruncate',
    },
  );
}

// =============================================================================
// ErrorSpacer Bridge
// =============================================================================

BridgedClass _createErrorSpacerBridge() {
  return BridgedClass(
    nativeType: $flutter_2.ErrorSpacer,
    name: 'ErrorSpacer',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_2.ErrorSpacer();
      },
    },
    getters: {
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').allowTruncate,
    },
    methods: {
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'ErrorSpacer()',
    },
    methodSignatures: {
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'void get value',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'level': 'DiagnosticLevel get level',
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowTruncate': 'bool get allowTruncate',
    },
  );
}

// =============================================================================
// FlutterErrorDetails Bridge
// =============================================================================

BridgedClass _createFlutterErrorDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_2.FlutterErrorDetails,
    name: 'FlutterErrorDetails',
    constructors: {
      '': (visitor, positional, named) {
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'FlutterErrorDetails');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final library = D4.getNamedArgWithDefault<String?>(named, 'library', 'Flutter framework');
        final context = D4.getOptionalNamedArg<$flutter_12.DiagnosticsNode?>(named, 'context');
        final stackFilterRaw = named['stackFilter'];
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        return $flutter_2.FlutterErrorDetails(exception: exception, stack: stack, library: library, context: context, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; }, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_12.DiagnosticsNode>; }, silent: silent);
      },
    },
    getters: {
      'exception': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').exception,
      'stack': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').stack,
      'library': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').library,
      'context': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').context,
      'stackFilter': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').stackFilter,
      'informationCollector': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').informationCollector,
      'silent': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').silent,
      'summary': (visitor, target) => D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails').summary,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        final context = D4.getOptionalNamedArg<$flutter_12.DiagnosticsNode?>(named, 'context');
        final exception = D4.getOptionalNamedArg<Object?>(named, 'exception');
        final informationCollectorRaw = named['informationCollector'];
        final library = D4.getOptionalNamedArg<String?>(named, 'library');
        final silent = D4.getOptionalNamedArg<bool?>(named, 'silent');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final stackFilterRaw = named['stackFilter'];
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_12.DiagnosticsNode>; }, library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; });
      },
      'exceptionAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        return t.exceptionAsString();
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    staticGetters: {
      'propertiesTransformers': (visitor) => $flutter_2.FlutterErrorDetails.propertiesTransformers,
    },
    constructorSignatures: {
      '': 'const FlutterErrorDetails({required Object exception, StackTrace? stack, String? library = \'Flutter framework\', DiagnosticsNode? context, Iterable<String> Function(Iterable<String>)? stackFilter, Iterable<DiagnosticsNode> Function()? informationCollector, bool silent = false})',
    },
    methodSignatures: {
      'copyWith': 'FlutterErrorDetails copyWith({DiagnosticsNode? context, Object? exception, InformationCollector? informationCollector, String? library, bool? silent, StackTrace? stack, IterableFilter<String>? stackFilter})',
      'exceptionAsString': 'String exceptionAsString()',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'exception': 'Object get exception',
      'stack': 'StackTrace? get stack',
      'library': 'String? get library',
      'context': 'DiagnosticsNode? get context',
      'stackFilter': 'IterableFilter<String>? get stackFilter',
      'informationCollector': 'InformationCollector? get informationCollector',
      'silent': 'bool get silent',
      'summary': 'DiagnosticsNode get summary',
    },
    staticGetterSignatures: {
      'propertiesTransformers': 'List<DiagnosticPropertiesTransformer> get propertiesTransformers',
    },
  );
}

// =============================================================================
// FlutterError Bridge
// =============================================================================

BridgedClass _createFlutterErrorBridge() {
  return BridgedClass(
    nativeType: $flutter_2.FlutterError,
    name: 'FlutterError',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlutterError');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'FlutterError');
        return $flutter_2.FlutterError(message);
      },
      'fromParts': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlutterError');
        if (positional.isEmpty) {
          throw ArgumentError('FlutterError: Missing required argument "diagnostics" at position 0');
        }
        final diagnostics = D4.coerceList<$flutter_12.DiagnosticsNode>(positional[0], 'diagnostics');
        return $flutter_2.FlutterError.fromParts(diagnostics);
      },
    },
    getters: {
      'diagnostics': (visitor, target) => D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError').diagnostics,
      'message': (visitor, target) => D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError').message,
      'stackTrace': (visitor, target) => D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError').stackTrace,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        return t.debugDescribeChildren();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    staticGetters: {
      'onError': (visitor) => $flutter_2.FlutterError.onError,
      'demangleStackTrace': (visitor) => $flutter_2.FlutterError.demangleStackTrace,
      'presentError': (visitor) => $flutter_2.FlutterError.presentError,
      'wrapWidth': (visitor) => $flutter_2.FlutterError.wrapWidth,
    },
    staticMethods: {
      'resetErrorCount': (visitor, positional, named, typeArgs) {
        return $flutter_2.FlutterError.resetErrorCount();
      },
      'dumpErrorToConsole': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dumpErrorToConsole');
        final details = D4.getRequiredArg<$flutter_2.FlutterErrorDetails>(positional, 0, 'details', 'dumpErrorToConsole');
        final forceReport = D4.getNamedArgWithDefault<bool>(named, 'forceReport', false);
        return $flutter_2.FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
      },
      'addDefaultStackFilter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addDefaultStackFilter');
        final filter = D4.getRequiredArg<$flutter_2.StackFilter>(positional, 0, 'filter', 'addDefaultStackFilter');
        return $flutter_2.FlutterError.addDefaultStackFilter(filter);
      },
      'defaultStackFilter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'defaultStackFilter');
        final frames = D4.getRequiredArg<Iterable<String>>(positional, 0, 'frames', 'defaultStackFilter');
        return $flutter_2.FlutterError.defaultStackFilter(frames);
      },
      'reportError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'reportError');
        final details = D4.getRequiredArg<$flutter_2.FlutterErrorDetails>(positional, 0, 'details', 'reportError');
        return $flutter_2.FlutterError.reportError(details);
      },
    },
    staticSetters: {
      'onError': (visitor, value) => 
        $flutter_2.FlutterError.onError = value as $flutter_2.FlutterExceptionHandler?,
      'demangleStackTrace': (visitor, value) => 
        $flutter_2.FlutterError.demangleStackTrace = value as $flutter_2.StackTraceDemangler,
      'presentError': (visitor, value) => 
        $flutter_2.FlutterError.presentError = value as $flutter_2.FlutterExceptionHandler,
    },
    constructorSignatures: {
      '': 'factory FlutterError(String message)',
      'fromParts': 'FlutterError.fromParts(List<DiagnosticsNode> diagnostics)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'diagnostics': 'List<DiagnosticsNode> get diagnostics',
      'message': 'String get message',
      'stackTrace': 'StackTrace? get stackTrace',
    },
    staticMethodSignatures: {
      'resetErrorCount': 'void resetErrorCount()',
      'dumpErrorToConsole': 'void dumpErrorToConsole(FlutterErrorDetails details, {bool forceReport = false})',
      'addDefaultStackFilter': 'void addDefaultStackFilter(StackFilter filter)',
      'defaultStackFilter': 'Iterable<String> defaultStackFilter(Iterable<String> frames)',
      'reportError': 'void reportError(FlutterErrorDetails details)',
    },
    staticGetterSignatures: {
      'onError': 'FlutterExceptionHandler? get onError',
      'demangleStackTrace': 'StackTraceDemangler get demangleStackTrace',
      'presentError': 'FlutterExceptionHandler get presentError',
      'wrapWidth': 'int get wrapWidth',
    },
    staticSetterSignatures: {
      'onError': 'set onError(dynamic value)',
      'demangleStackTrace': 'set demangleStackTrace(dynamic value)',
      'presentError': 'set presentError(dynamic value)',
    },
  );
}

// =============================================================================
// DiagnosticsStackTrace Bridge
// =============================================================================

BridgedClass _createDiagnosticsStackTraceBridge() {
  return BridgedClass(
    nativeType: $flutter_2.DiagnosticsStackTrace,
    name: 'DiagnosticsStackTrace',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DiagnosticsStackTrace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DiagnosticsStackTrace');
        final stack = D4.getRequiredArg<StackTrace?>(positional, 1, 'stack', 'DiagnosticsStackTrace');
        final stackFilterRaw = named['stackFilter'];
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        return $flutter_2.DiagnosticsStackTrace(name, stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; }, showSeparator: showSeparator);
      },
      'singleFrame': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsStackTrace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DiagnosticsStackTrace');
        final frame = D4.getRequiredNamedArg<String>(named, 'frame', 'DiagnosticsStackTrace');
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        return $flutter_2.DiagnosticsStackTrace.singleFrame(name, frame: frame, showSeparator: showSeparator);
      },
    },
    getters: {
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowTruncate,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').level,
      'value': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').value,
      'name': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowNameWrap,
    },
    methods: {
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.getChildren();
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.getProperties();
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'DiagnosticsStackTrace(String name, StackTrace? stack, {IterableFilter<String>? stackFilter, bool showSeparator = true})',
      'singleFrame': 'DiagnosticsStackTrace.singleFrame(String name, {required String frame, bool showSeparator = true})',
    },
    methodSignatures: {
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'allowTruncate': 'bool get allowTruncate',
      'level': 'DiagnosticLevel get level',
      'value': 'Object? get value',
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
    },
  );
}

// =============================================================================
// BindingBase Bridge
// =============================================================================

BridgedClass _createBindingBaseBridge() {
  return BridgedClass(
    nativeType: $flutter_4.BindingBase,
    name: 'BindingBase',
    constructors: {
    },
    getters: {
      'window': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').platformDispatcher,
    },
    methods: {
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        return t.reassembleApplication();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        return t.toString();
      },
    },
    staticGetters: {
      'debugZoneErrorsAreFatal': (visitor) => $flutter_4.BindingBase.debugZoneErrorsAreFatal,
    },
    staticMethods: {
      'debugBindingType': (visitor, positional, named, typeArgs) {
        return $flutter_4.BindingBase.debugBindingType();
      },
    },
    staticSetters: {
      'debugZoneErrorsAreFatal': (visitor, value) => 
        $flutter_4.BindingBase.debugZoneErrorsAreFatal = value as bool,
    },
    methodSignatures: {
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'window': 'ui.SingletonFlutterWindow get window',
      'platformDispatcher': 'ui.PlatformDispatcher get platformDispatcher',
    },
    staticMethodSignatures: {
      'debugBindingType': 'Type? debugBindingType()',
    },
    staticGetterSignatures: {
      'debugZoneErrorsAreFatal': 'bool get debugZoneErrorsAreFatal',
    },
    staticSetterSignatures: {
      'debugZoneErrorsAreFatal': 'set debugZoneErrorsAreFatal(dynamic value)',
    },
  );
}

// =============================================================================
// BitField Bridge
// =============================================================================

BridgedClass _createBitFieldBridge() {
  return BridgedClass(
    nativeType: $flutter_5.BitField,
    name: 'BitField',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BitField');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'BitField');
        return $flutter_5.BitField(length);
      },
      'filled': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BitField');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'BitField');
        final value = D4.getRequiredArg<bool>(positional, 1, 'value', 'BitField');
        return $flutter_5.BitField.filled(length, value);
      },
    },
    methods: {
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.BitField>(target, 'BitField');
        final value = D4.getOptionalArgWithDefault<bool>(positional, 0, 'value', false);
        t.reset(value);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.BitField>(target, 'BitField');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.BitField>(target, 'BitField');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<bool>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    constructorSignatures: {
      '': 'factory BitField(int length)',
      'filled': 'factory BitField.filled(int length, bool value)',
    },
    methodSignatures: {
      'reset': 'void reset([bool value = false])',
    },
  );
}

// =============================================================================
// Listenable Bridge
// =============================================================================

BridgedClass _createListenableBridge() {
  return BridgedClass(
    nativeType: $flutter_7.Listenable,
    name: 'Listenable',
    constructors: {
      'merge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Listenable');
        final listenables = D4.getRequiredArg<Iterable<$flutter_7.Listenable>>(positional, 0, 'listenables', 'Listenable');
        return $flutter_7.Listenable.merge(listenables);
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Listenable>(target, 'Listenable');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Listenable>(target, 'Listenable');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
    },
    constructorSignatures: {
      'merge': 'factory Listenable.merge(Iterable<Listenable?> listenables)',
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
    },
  );
}

// =============================================================================
// ValueListenable Bridge
// =============================================================================

BridgedClass _createValueListenableBridge() {
  return BridgedClass(
    nativeType: $flutter_7.ValueListenable,
    name: 'ValueListenable',
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_7.ValueListenable>(target, 'ValueListenable').value,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueListenable>(target, 'ValueListenable');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueListenable>(target, 'ValueListenable');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
    },
    getterSignatures: {
      'value': 'T get value',
    },
  );
}

// =============================================================================
// ChangeNotifier Bridge
// =============================================================================

BridgedClass _createChangeNotifierBridge() {
  return BridgedClass(
    nativeType: $flutter_7.ChangeNotifier,
    name: 'ChangeNotifier',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_7.ChangeNotifier();
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier');
        (t as dynamic).dispose();
        return null;
      },
    },
    staticMethods: {
      'debugAssertNotDisposed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertNotDisposed');
        final notifier = D4.getRequiredArg<$flutter_7.ChangeNotifier>(positional, 0, 'notifier', 'debugAssertNotDisposed');
        return $flutter_7.ChangeNotifier.debugAssertNotDisposed(notifier);
      },
    },
    constructorSignatures: {
      '': 'ChangeNotifier()',
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'dispose': 'void dispose()',
    },
    staticMethodSignatures: {
      'debugAssertNotDisposed': 'bool debugAssertNotDisposed(ChangeNotifier notifier)',
    },
  );
}

// =============================================================================
// ValueNotifier Bridge
// =============================================================================

BridgedClass _createValueNotifierBridge() {
  return BridgedClass(
    nativeType: $flutter_7.ValueNotifier,
    name: 'ValueNotifier',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueNotifier');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'ValueNotifier');
        return $flutter_7.ValueNotifier(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier').value,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier').value = value as dynamic,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ValueNotifier(T _value)',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'dispose': 'void dispose()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'value': 'T get value',
    },
    setterSignatures: {
      'value': 'set value(T value)',
    },
  );
}

// =============================================================================
// Key Bridge
// =============================================================================

BridgedClass _createKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_14.Key,
    name: 'Key',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Key');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'Key');
        return $flutter_14.Key(value);
      },
    },
    constructorSignatures: {
      '': 'const factory Key(String value)',
    },
  );
}

// =============================================================================
// LocalKey Bridge
// =============================================================================

BridgedClass _createLocalKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_14.LocalKey,
    name: 'LocalKey',
    constructors: {
    },
  );
}

// =============================================================================
// UniqueKey Bridge
// =============================================================================

BridgedClass _createUniqueKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_14.UniqueKey,
    name: 'UniqueKey',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_14.UniqueKey();
      },
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.UniqueKey>(target, 'UniqueKey');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'UniqueKey()',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// ValueKey Bridge
// =============================================================================

BridgedClass _createValueKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_14.ValueKey,
    name: 'ValueKey',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueKey');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'ValueKey');
        return $flutter_14.ValueKey(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_14.ValueKey>(target, 'ValueKey').value,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_14.ValueKey>(target, 'ValueKey').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ValueKey>(target, 'ValueKey');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ValueKey>(target, 'ValueKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ValueKey(T value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'value': 'T get value',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// LicenseParagraph Bridge
// =============================================================================

BridgedClass _createLicenseParagraphBridge() {
  return BridgedClass(
    nativeType: $flutter_15.LicenseParagraph,
    name: 'LicenseParagraph',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'LicenseParagraph');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'LicenseParagraph');
        final indent = D4.getRequiredArg<int>(positional, 1, 'indent', 'LicenseParagraph');
        return $flutter_15.LicenseParagraph(text, indent);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_15.LicenseParagraph>(target, 'LicenseParagraph').text,
      'indent': (visitor, target) => D4.validateTarget<$flutter_15.LicenseParagraph>(target, 'LicenseParagraph').indent,
    },
    staticGetters: {
      'centeredIndent': (visitor) => $flutter_15.LicenseParagraph.centeredIndent,
    },
    constructorSignatures: {
      '': 'const LicenseParagraph(String text, int indent)',
    },
    getterSignatures: {
      'text': 'String get text',
      'indent': 'int get indent',
    },
    staticGetterSignatures: {
      'centeredIndent': 'int get centeredIndent',
    },
  );
}

// =============================================================================
// LicenseEntry Bridge
// =============================================================================

BridgedClass _createLicenseEntryBridge() {
  return BridgedClass(
    nativeType: $flutter_15.LicenseEntry,
    name: 'LicenseEntry',
    constructors: {
    },
    getters: {
      'packages': (visitor, target) => D4.validateTarget<$flutter_15.LicenseEntry>(target, 'LicenseEntry').packages,
      'paragraphs': (visitor, target) => D4.validateTarget<$flutter_15.LicenseEntry>(target, 'LicenseEntry').paragraphs,
    },
    getterSignatures: {
      'packages': 'Iterable<String> get packages',
      'paragraphs': 'Iterable<LicenseParagraph> get paragraphs',
    },
  );
}

// =============================================================================
// LicenseEntryWithLineBreaks Bridge
// =============================================================================

BridgedClass _createLicenseEntryWithLineBreaksBridge() {
  return BridgedClass(
    nativeType: $flutter_15.LicenseEntryWithLineBreaks,
    name: 'LicenseEntryWithLineBreaks',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'LicenseEntryWithLineBreaks');
        if (positional.isEmpty) {
          throw ArgumentError('LicenseEntryWithLineBreaks: Missing required argument "packages" at position 0');
        }
        final packages = D4.coerceList<String>(positional[0], 'packages');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'LicenseEntryWithLineBreaks');
        return $flutter_15.LicenseEntryWithLineBreaks(packages, text);
      },
    },
    getters: {
      'packages': (visitor, target) => D4.validateTarget<$flutter_15.LicenseEntryWithLineBreaks>(target, 'LicenseEntryWithLineBreaks').packages,
      'paragraphs': (visitor, target) => D4.validateTarget<$flutter_15.LicenseEntryWithLineBreaks>(target, 'LicenseEntryWithLineBreaks').paragraphs,
      'text': (visitor, target) => D4.validateTarget<$flutter_15.LicenseEntryWithLineBreaks>(target, 'LicenseEntryWithLineBreaks').text,
    },
    constructorSignatures: {
      '': 'const LicenseEntryWithLineBreaks(List<String> packages, String text)',
    },
    getterSignatures: {
      'packages': 'List<String> get packages',
      'paragraphs': 'Iterable<LicenseParagraph> get paragraphs',
      'text': 'String get text',
    },
  );
}

// =============================================================================
// LicenseRegistry Bridge
// =============================================================================

BridgedClass _createLicenseRegistryBridge() {
  return BridgedClass(
    nativeType: $flutter_15.LicenseRegistry,
    name: 'LicenseRegistry',
    constructors: {
    },
    staticGetters: {
      'licenses': (visitor) => $flutter_15.LicenseRegistry.licenses,
    },
    staticMethods: {
      'addLicense': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addLicense');
        if (positional.isEmpty) {
          throw ArgumentError('addLicense: Missing required argument "collector" at position 0');
        }
        final collectorRaw = positional[0];
        final collector = () { return D4.callInterpreterCallback(visitor, collectorRaw, []) as Stream<$flutter_15.LicenseEntry>; };
        return $flutter_15.LicenseRegistry.addLicense(collector);
      },
    },
    staticMethodSignatures: {
      'addLicense': 'void addLicense(LicenseEntryCollector collector)',
    },
    staticGetterSignatures: {
      'licenses': 'Stream<LicenseEntry> get licenses',
    },
  );
}

// =============================================================================
// ObjectEvent Bridge
// =============================================================================

BridgedClass _createObjectEventBridge() {
  return BridgedClass(
    nativeType: $flutter_16.ObjectEvent,
    name: 'ObjectEvent',
    constructors: {
    },
    getters: {
      'object': (visitor, target) => D4.validateTarget<$flutter_16.ObjectEvent>(target, 'ObjectEvent').object,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.ObjectEvent>(target, 'ObjectEvent');
        return t.toMap();
      },
    },
    methodSignatures: {
      'toMap': 'Map<Object, Map<String, Object>> toMap()',
    },
    getterSignatures: {
      'object': 'Object get object',
    },
  );
}

// =============================================================================
// ObjectCreated Bridge
// =============================================================================

BridgedClass _createObjectCreatedBridge() {
  return BridgedClass(
    nativeType: $flutter_16.ObjectCreated,
    name: 'ObjectCreated',
    constructors: {
      '': (visitor, positional, named) {
        final library = D4.getRequiredNamedArg<String>(named, 'library', 'ObjectCreated');
        final className = D4.getRequiredNamedArg<String>(named, 'className', 'ObjectCreated');
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'ObjectCreated');
        return $flutter_16.ObjectCreated(library: library, className: className, object: object);
      },
    },
    getters: {
      'object': (visitor, target) => D4.validateTarget<$flutter_16.ObjectCreated>(target, 'ObjectCreated').object,
      'library': (visitor, target) => D4.validateTarget<$flutter_16.ObjectCreated>(target, 'ObjectCreated').library,
      'className': (visitor, target) => D4.validateTarget<$flutter_16.ObjectCreated>(target, 'ObjectCreated').className,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.ObjectCreated>(target, 'ObjectCreated');
        return t.toMap();
      },
    },
    constructorSignatures: {
      '': 'ObjectCreated({required String library, required String className, required Object object})',
    },
    methodSignatures: {
      'toMap': 'Map<Object, Map<String, Object>> toMap()',
    },
    getterSignatures: {
      'object': 'Object get object',
      'library': 'String get library',
      'className': 'String get className',
    },
  );
}

// =============================================================================
// ObjectDisposed Bridge
// =============================================================================

BridgedClass _createObjectDisposedBridge() {
  return BridgedClass(
    nativeType: $flutter_16.ObjectDisposed,
    name: 'ObjectDisposed',
    constructors: {
      '': (visitor, positional, named) {
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'ObjectDisposed');
        return $flutter_16.ObjectDisposed(object: object);
      },
    },
    getters: {
      'object': (visitor, target) => D4.validateTarget<$flutter_16.ObjectDisposed>(target, 'ObjectDisposed').object,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.ObjectDisposed>(target, 'ObjectDisposed');
        return t.toMap();
      },
    },
    constructorSignatures: {
      '': 'ObjectDisposed({required Object object})',
    },
    methodSignatures: {
      'toMap': 'Map<Object, Map<String, Object>> toMap()',
    },
    getterSignatures: {
      'object': 'Object get object',
    },
  );
}

// =============================================================================
// FlutterMemoryAllocations Bridge
// =============================================================================

BridgedClass _createFlutterMemoryAllocationsBridge() {
  return BridgedClass(
    nativeType: $flutter_16.FlutterMemoryAllocations,
    name: 'FlutterMemoryAllocations',
    constructors: {
    },
    getters: {
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations').hasListeners,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(($flutter_16.ObjectEvent p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(($flutter_16.ObjectEvent p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'dispatchObjectEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'dispatchObjectEvent');
        final event = D4.getRequiredArg<$flutter_16.ObjectEvent>(positional, 0, 'event', 'dispatchObjectEvent');
        t.dispatchObjectEvent(event);
        return null;
      },
      'dispatchObjectCreated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        final library = D4.getRequiredNamedArg<String>(named, 'library', 'dispatchObjectCreated');
        final className = D4.getRequiredNamedArg<String>(named, 'className', 'dispatchObjectCreated');
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'dispatchObjectCreated');
        t.dispatchObjectCreated(library: library, className: className, object: object);
        return null;
      },
      'dispatchObjectDisposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'dispatchObjectDisposed');
        t.dispatchObjectDisposed(object: object);
        return null;
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_16.FlutterMemoryAllocations.instance,
    },
    methodSignatures: {
      'addListener': 'void addListener(ObjectEventListener listener)',
      'removeListener': 'void removeListener(ObjectEventListener listener)',
      'dispatchObjectEvent': 'void dispatchObjectEvent(ObjectEvent event)',
      'dispatchObjectCreated': 'void dispatchObjectCreated({required String library, required String className, required Object object})',
      'dispatchObjectDisposed': 'void dispatchObjectDisposed({required Object object})',
    },
    getterSignatures: {
      'hasListeners': 'bool get hasListeners',
    },
    staticGetterSignatures: {
      'instance': 'FlutterMemoryAllocations get instance',
    },
  );
}

// =============================================================================
// ObserverList Bridge
// =============================================================================

BridgedClass _createObserverListBridge() {
  return BridgedClass(
    nativeType: $flutter_18.ObserverList,
    name: 'ObserverList',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_18.ObserverList();
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').iterator,
      'isEmpty': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').isNotEmpty,
      'length': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').length,
      'first': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').first,
      'last': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').last,
      'single': (visitor, target) => D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList').single,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'remove');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'remove');
        return t.remove(item);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        t.clear();
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<dynamic>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        return t.whereType();
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        return t.toSet();
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ObserverList()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'remove': 'bool remove(T item)',
      'clear': 'void clear()',
      'contains': 'bool contains(Object? element)',
      'toList': 'List<T> toList({bool growable = true})',
      'cast': 'Iterable<R> cast()',
      'followedBy': 'Iterable<T> followedBy(Iterable<T> other)',
      'map': 'Iterable<T> map(T Function(T) toElement)',
      'where': 'Iterable<T> where(bool Function(T) test)',
      'whereType': 'Iterable<T> whereType()',
      'expand': 'Iterable<T> expand(Iterable<T> Function(T) toElements)',
      'forEach': 'void forEach(void Function(T) action)',
      'reduce': 'T reduce(T Function(T, T) combine)',
      'fold': 'T fold(T initialValue, T Function(T, T) combine)',
      'every': 'bool every(bool Function(T) test)',
      'join': 'String join([String separator = ""])',
      'any': 'bool any(bool Function(T) test)',
      'toSet': 'Set<T> toSet()',
      'take': 'Iterable<T> take(int count)',
      'takeWhile': 'Iterable<T> takeWhile(bool Function(T) test)',
      'skip': 'Iterable<T> skip(int count)',
      'skipWhile': 'Iterable<T> skipWhile(bool Function(T) test)',
      'firstWhere': 'T firstWhere(bool Function(T) test, {T Function()? orElse})',
      'lastWhere': 'T lastWhere(bool Function(T) test, {T Function()? orElse})',
      'singleWhere': 'T singleWhere(bool Function(T) test, {T Function()? orElse})',
      'elementAt': 'T elementAt(int index)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'iterator': 'Iterator<T> get iterator',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'length': 'int get length',
      'first': 'T get first',
      'last': 'T get last',
      'single': 'T get single',
    },
  );
}

// =============================================================================
// HashedObserverList Bridge
// =============================================================================

BridgedClass _createHashedObserverListBridge() {
  return BridgedClass(
    nativeType: $flutter_18.HashedObserverList,
    name: 'HashedObserverList',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_18.HashedObserverList();
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').iterator,
      'isEmpty': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').isNotEmpty,
      'length': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').length,
      'first': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').first,
      'last': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').last,
      'single': (visitor, target) => D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList').single,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'remove');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'remove');
        return t.remove(item);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        t.clear();
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<dynamic>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        return t.whereType();
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        return t.toSet();
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'HashedObserverList()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'remove': 'bool remove(T item)',
      'clear': 'void clear()',
      'contains': 'bool contains(Object? element)',
      'toList': 'List<T> toList({bool growable = true})',
      'cast': 'Iterable<R> cast()',
      'followedBy': 'Iterable<T> followedBy(Iterable<T> other)',
      'map': 'Iterable<T> map(T Function(T) toElement)',
      'where': 'Iterable<T> where(bool Function(T) test)',
      'whereType': 'Iterable<T> whereType()',
      'expand': 'Iterable<T> expand(Iterable<T> Function(T) toElements)',
      'forEach': 'void forEach(void Function(T) action)',
      'reduce': 'T reduce(T Function(T, T) combine)',
      'fold': 'T fold(T initialValue, T Function(T, T) combine)',
      'every': 'bool every(bool Function(T) test)',
      'join': 'String join([String separator = ""])',
      'any': 'bool any(bool Function(T) test)',
      'toSet': 'Set<T> toSet()',
      'take': 'Iterable<T> take(int count)',
      'takeWhile': 'Iterable<T> takeWhile(bool Function(T) test)',
      'skip': 'Iterable<T> skip(int count)',
      'skipWhile': 'Iterable<T> skipWhile(bool Function(T) test)',
      'firstWhere': 'T firstWhere(bool Function(T) test, {T Function()? orElse})',
      'lastWhere': 'T lastWhere(bool Function(T) test, {T Function()? orElse})',
      'singleWhere': 'T singleWhere(bool Function(T) test, {T Function()? orElse})',
      'elementAt': 'T elementAt(int index)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'iterator': 'Iterator<T> get iterator',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'length': 'int get length',
      'first': 'T get first',
      'last': 'T get last',
      'single': 'T get single',
    },
  );
}

// =============================================================================
// PersistentHashMap Bridge
// =============================================================================

BridgedClass _createPersistentHashMapBridge() {
  return BridgedClass(
    nativeType: $flutter_19.PersistentHashMap,
    name: 'PersistentHashMap',
    constructors: {
      'empty': (visitor, positional, named) {
        return $flutter_19.PersistentHashMap.empty();
      },
    },
    methods: {
      'put': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PersistentHashMap>(target, 'PersistentHashMap');
        D4.requireMinArgs(positional, 2, 'put');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'put');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'put');
        return t.put(key, value);
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PersistentHashMap>(target, 'PersistentHashMap');
        final index = D4.getRequiredArg<Object>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
    },
    constructorSignatures: {
      'empty': 'const PersistentHashMap.empty()',
    },
    methodSignatures: {
      'put': 'PersistentHashMap<K, V> put(K key, V value)',
    },
  );
}

// =============================================================================
// WriteBuffer Bridge
// =============================================================================

BridgedClass _createWriteBufferBridge() {
  return BridgedClass(
    nativeType: $flutter_22.WriteBuffer,
    name: 'WriteBuffer',
    constructors: {
      '': (visitor, positional, named) {
        final startCapacity = D4.getNamedArgWithDefault<int>(named, 'startCapacity', 8);
        return $flutter_22.WriteBuffer(startCapacity: startCapacity);
      },
    },
    methods: {
      'putUint8': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint8');
        final byte = D4.getRequiredArg<int>(positional, 0, 'byte', 'putUint8');
        t.putUint8(byte);
        return null;
      },
      'putUint16': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint16');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putUint16');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putUint16(value, endian: endian);
        return null;
      },
      'putUint32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint32');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putUint32');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putUint32(value, endian: endian);
        return null;
      },
      'putInt32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt32');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putInt32');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putInt32(value, endian: endian);
        return null;
      },
      'putInt64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt64');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putInt64');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putInt64(value, endian: endian);
        return null;
      },
      'putFloat64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat64');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'putFloat64');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putFloat64(value, endian: endian);
        return null;
      },
      'putUint8List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint8List');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'putUint8List');
        t.putUint8List(list);
        return null;
      },
      'putInt32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt32List');
        final list = D4.getRequiredArg<Int32List>(positional, 0, 'list', 'putInt32List');
        t.putInt32List(list);
        return null;
      },
      'putInt64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt64List');
        final list = D4.getRequiredArg<Int64List>(positional, 0, 'list', 'putInt64List');
        t.putInt64List(list);
        return null;
      },
      'putFloat32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat32List');
        final list = D4.getRequiredArg<Float32List>(positional, 0, 'list', 'putFloat32List');
        t.putFloat32List(list);
        return null;
      },
      'putFloat64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat64List');
        final list = D4.getRequiredArg<Float64List>(positional, 0, 'list', 'putFloat64List');
        t.putFloat64List(list);
        return null;
      },
      'done': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.WriteBuffer>(target, 'WriteBuffer');
        return t.done();
      },
    },
    constructorSignatures: {
      '': 'factory WriteBuffer({int startCapacity = 8})',
    },
    methodSignatures: {
      'putUint8': 'void putUint8(int byte)',
      'putUint16': 'void putUint16(int value, {Endian? endian})',
      'putUint32': 'void putUint32(int value, {Endian? endian})',
      'putInt32': 'void putInt32(int value, {Endian? endian})',
      'putInt64': 'void putInt64(int value, {Endian? endian})',
      'putFloat64': 'void putFloat64(double value, {Endian? endian})',
      'putUint8List': 'void putUint8List(Uint8List list)',
      'putInt32List': 'void putInt32List(Int32List list)',
      'putInt64List': 'void putInt64List(Int64List list)',
      'putFloat32List': 'void putFloat32List(Float32List list)',
      'putFloat64List': 'void putFloat64List(Float64List list)',
      'done': 'ByteData done()',
    },
  );
}

// =============================================================================
// ReadBuffer Bridge
// =============================================================================

BridgedClass _createReadBufferBridge() {
  return BridgedClass(
    nativeType: $flutter_22.ReadBuffer,
    name: 'ReadBuffer',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReadBuffer');
        final data = D4.getRequiredArg<ByteData>(positional, 0, 'data', 'ReadBuffer');
        return $flutter_22.ReadBuffer(data);
      },
    },
    getters: {
      'data': (visitor, target) => D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer').data,
      'hasRemaining': (visitor, target) => D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer').hasRemaining,
    },
    methods: {
      'getUint8': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        return t.getUint8();
      },
      'getUint16': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getUint16(endian: endian);
      },
      'getUint32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getUint32(endian: endian);
      },
      'getInt32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getInt32(endian: endian);
      },
      'getInt64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getInt64(endian: endian);
      },
      'getFloat64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getFloat64(endian: endian);
      },
      'getUint8List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getUint8List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getUint8List');
        return t.getUint8List(length);
      },
      'getInt32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getInt32List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getInt32List');
        return t.getInt32List(length);
      },
      'getInt64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getInt64List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getInt64List');
        return t.getInt64List(length);
      },
      'getFloat32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getFloat32List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getFloat32List');
        return t.getFloat32List(length);
      },
      'getFloat64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getFloat64List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getFloat64List');
        return t.getFloat64List(length);
      },
    },
    constructorSignatures: {
      '': 'ReadBuffer(ByteData data)',
    },
    methodSignatures: {
      'getUint8': 'int getUint8()',
      'getUint16': 'int getUint16({Endian? endian})',
      'getUint32': 'int getUint32({Endian? endian})',
      'getInt32': 'int getInt32({Endian? endian})',
      'getInt64': 'int getInt64({Endian? endian})',
      'getFloat64': 'double getFloat64({Endian? endian})',
      'getUint8List': 'Uint8List getUint8List(int length)',
      'getInt32List': 'Int32List getInt32List(int length)',
      'getInt64List': 'Int64List getInt64List(int length)',
      'getFloat32List': 'Float32List getFloat32List(int length)',
      'getFloat64List': 'Float64List getFloat64List(int length)',
    },
    getterSignatures: {
      'data': 'ByteData get data',
      'hasRemaining': 'bool get hasRemaining',
    },
  );
}

// =============================================================================
// SynchronousFuture Bridge
// =============================================================================

BridgedClass _createSynchronousFutureBridge() {
  return BridgedClass(
    nativeType: $flutter_25.SynchronousFuture,
    name: 'SynchronousFuture',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SynchronousFuture');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'SynchronousFuture');
        return $flutter_25.SynchronousFuture(value);
      },
    },
    methods: {
      'asStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        return t.asStream();
      },
      'catchError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'catchError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'catchError');
        final testRaw = named['test'];
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((dynamic p0) { return D4.callInterpreterCallback(visitor, onValueRaw, [p0]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onTimeoutRaw, []) as FutureOr<Object>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.callInterpreterCallback(visitor, actionRaw, []) as FutureOr<Object>; });
      },
    },
    constructorSignatures: {
      '': 'SynchronousFuture(T _value)',
    },
    methodSignatures: {
      'asStream': 'Stream<T> asStream()',
      'catchError': 'Future<T> catchError(Function onError, {bool Function(Object error)? test})',
      'then': 'Future<R> then(FutureOr<R> Function(T value) onValue, {Function? onError})',
      'timeout': 'Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout})',
      'whenComplete': 'Future<T> whenComplete(FutureOr<dynamic> Function() action)',
    },
  );
}

// =============================================================================
// FlutterTimeline Bridge
// =============================================================================

BridgedClass _createFlutterTimelineBridge() {
  return BridgedClass(
    nativeType: $flutter_26.FlutterTimeline,
    name: 'FlutterTimeline',
    constructors: {
    },
    staticGetters: {
      'debugCollectionEnabled': (visitor) => $flutter_26.FlutterTimeline.debugCollectionEnabled,
      'now': (visitor) => $flutter_26.FlutterTimeline.now,
    },
    staticMethods: {
      'startSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'startSync');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'startSync');
        final arguments = D4.coerceMapOrNull<String, Object?>(named['arguments'], 'arguments');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return $flutter_26.FlutterTimeline.startSync(name, arguments: arguments, flow: flow);
      },
      'finishSync': (visitor, positional, named, typeArgs) {
        return $flutter_26.FlutterTimeline.finishSync();
      },
      'instantSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'instantSync');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'instantSync');
        final arguments = D4.coerceMapOrNull<String, Object?>(named['arguments'], 'arguments');
        return $flutter_26.FlutterTimeline.instantSync(name, arguments: arguments);
      },
      'timeSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'timeSync');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'timeSync');
        if (positional.length <= 1) {
          throw ArgumentError('timeSync: Missing required argument "function" at position 1');
        }
        final functionRaw = positional[1];
        final function = () { return D4.callInterpreterCallback(visitor, functionRaw, []) as dynamic; };
        final arguments = D4.coerceMapOrNull<String, Object?>(named['arguments'], 'arguments');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return $flutter_26.FlutterTimeline.timeSync(name, function, arguments: arguments, flow: flow);
      },
      'debugCollect': (visitor, positional, named, typeArgs) {
        return $flutter_26.FlutterTimeline.debugCollect();
      },
      'debugReset': (visitor, positional, named, typeArgs) {
        return $flutter_26.FlutterTimeline.debugReset();
      },
    },
    staticSetters: {
      'debugCollectionEnabled': (visitor, value) => 
        $flutter_26.FlutterTimeline.debugCollectionEnabled = value as dynamic,
    },
    staticMethodSignatures: {
      'startSync': 'void startSync(String name, {Map<String, Object?>? arguments, Flow? flow})',
      'finishSync': 'void finishSync()',
      'instantSync': 'void instantSync(String name, {Map<String, Object?>? arguments})',
      'timeSync': 'T timeSync(String name, TimelineSyncFunction<T> function, {Map<String, Object?>? arguments, Flow? flow})',
      'debugCollect': 'AggregatedTimings debugCollect()',
      'debugReset': 'void debugReset()',
    },
    staticGetterSignatures: {
      'debugCollectionEnabled': 'bool get debugCollectionEnabled',
      'now': 'int get now',
    },
    staticSetterSignatures: {
      'debugCollectionEnabled': 'set debugCollectionEnabled(bool value)',
    },
  );
}

// =============================================================================
// TimedBlock Bridge
// =============================================================================

BridgedClass _createTimedBlockBridge() {
  return BridgedClass(
    nativeType: $flutter_26.TimedBlock,
    name: 'TimedBlock',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'TimedBlock');
        final start = D4.getRequiredNamedArg<double>(named, 'start', 'TimedBlock');
        final end = D4.getRequiredNamedArg<double>(named, 'end', 'TimedBlock');
        return $flutter_26.TimedBlock(name: name, start: start, end: end);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_26.TimedBlock>(target, 'TimedBlock').name,
      'start': (visitor, target) => D4.validateTarget<$flutter_26.TimedBlock>(target, 'TimedBlock').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_26.TimedBlock>(target, 'TimedBlock').end,
      'duration': (visitor, target) => D4.validateTarget<$flutter_26.TimedBlock>(target, 'TimedBlock').duration,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.TimedBlock>(target, 'TimedBlock');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TimedBlock({required String name, required double start, required double end})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'start': 'double get start',
      'end': 'double get end',
      'duration': 'double get duration',
    },
  );
}

// =============================================================================
// AggregatedTimings Bridge
// =============================================================================

BridgedClass _createAggregatedTimingsBridge() {
  return BridgedClass(
    nativeType: $flutter_26.AggregatedTimings,
    name: 'AggregatedTimings',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AggregatedTimings');
        if (positional.isEmpty) {
          throw ArgumentError('AggregatedTimings: Missing required argument "timedBlocks" at position 0');
        }
        final timedBlocks = D4.coerceList<$flutter_26.TimedBlock>(positional[0], 'timedBlocks');
        return $flutter_26.AggregatedTimings(timedBlocks);
      },
    },
    getters: {
      'timedBlocks': (visitor, target) => D4.validateTarget<$flutter_26.AggregatedTimings>(target, 'AggregatedTimings').timedBlocks,
      'aggregatedBlocks': (visitor, target) => D4.validateTarget<$flutter_26.AggregatedTimings>(target, 'AggregatedTimings').aggregatedBlocks,
    },
    methods: {
      'getAggregated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.AggregatedTimings>(target, 'AggregatedTimings');
        D4.requireMinArgs(positional, 1, 'getAggregated');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getAggregated');
        return t.getAggregated(name);
      },
    },
    constructorSignatures: {
      '': 'AggregatedTimings(List<TimedBlock> timedBlocks)',
    },
    methodSignatures: {
      'getAggregated': 'AggregatedTimedBlock getAggregated(String name)',
    },
    getterSignatures: {
      'timedBlocks': 'List<TimedBlock> get timedBlocks',
      'aggregatedBlocks': 'List<AggregatedTimedBlock> get aggregatedBlocks',
    },
  );
}

// =============================================================================
// AggregatedTimedBlock Bridge
// =============================================================================

BridgedClass _createAggregatedTimedBlockBridge() {
  return BridgedClass(
    nativeType: $flutter_26.AggregatedTimedBlock,
    name: 'AggregatedTimedBlock',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'AggregatedTimedBlock');
        final duration = D4.getRequiredNamedArg<double>(named, 'duration', 'AggregatedTimedBlock');
        final count = D4.getRequiredNamedArg<int>(named, 'count', 'AggregatedTimedBlock');
        return $flutter_26.AggregatedTimedBlock(name: name, duration: duration, count: count);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_26.AggregatedTimedBlock>(target, 'AggregatedTimedBlock').name,
      'duration': (visitor, target) => D4.validateTarget<$flutter_26.AggregatedTimedBlock>(target, 'AggregatedTimedBlock').duration,
      'count': (visitor, target) => D4.validateTarget<$flutter_26.AggregatedTimedBlock>(target, 'AggregatedTimedBlock').count,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.AggregatedTimedBlock>(target, 'AggregatedTimedBlock');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const AggregatedTimedBlock({required String name, required double duration, required int count})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'duration': 'double get duration',
      'count': 'int get count',
    },
  );
}

// =============================================================================
// Unicode Bridge
// =============================================================================

BridgedClass _createUnicodeBridge() {
  return BridgedClass(
    nativeType: $flutter_27.Unicode,
    name: 'Unicode',
    constructors: {
    },
    staticGetters: {
      'LRE': (visitor) => $flutter_27.Unicode.LRE,
      'RLE': (visitor) => $flutter_27.Unicode.RLE,
      'PDF': (visitor) => $flutter_27.Unicode.PDF,
      'LRO': (visitor) => $flutter_27.Unicode.LRO,
      'RLO': (visitor) => $flutter_27.Unicode.RLO,
      'LRI': (visitor) => $flutter_27.Unicode.LRI,
      'RLI': (visitor) => $flutter_27.Unicode.RLI,
      'FSI': (visitor) => $flutter_27.Unicode.FSI,
      'PDI': (visitor) => $flutter_27.Unicode.PDI,
      'LRM': (visitor) => $flutter_27.Unicode.LRM,
      'RLM': (visitor) => $flutter_27.Unicode.RLM,
      'ALM': (visitor) => $flutter_27.Unicode.ALM,
    },
    staticGetterSignatures: {
      'LRE': 'String get LRE',
      'RLE': 'String get RLE',
      'PDF': 'String get PDF',
      'LRO': 'String get LRO',
      'RLO': 'String get RLO',
      'LRI': 'String get LRI',
      'RLI': 'String get RLI',
      'FSI': 'String get FSI',
      'PDI': 'String get PDI',
      'LRM': 'String get LRM',
      'RLM': 'String get RLM',
      'ALM': 'String get ALM',
    },
  );
}

// =============================================================================
// Immutable Bridge
// =============================================================================

BridgedClass _createImmutableBridge() {
  return BridgedClass(
    nativeType: $meta_1.Immutable,
    name: 'Immutable',
    constructors: {
      '': (visitor, positional, named) {
        final reason = D4.getOptionalArgWithDefault<String>(positional, 0, 'reason', '');
        return $meta_1.Immutable(reason);
      },
    },
    getters: {
      'reason': (visitor, target) => D4.validateTarget<$meta_1.Immutable>(target, 'Immutable').reason,
    },
    constructorSignatures: {
      '': 'const Immutable([String reason = \'\'])',
    },
    getterSignatures: {
      'reason': 'String get reason',
    },
  );
}

