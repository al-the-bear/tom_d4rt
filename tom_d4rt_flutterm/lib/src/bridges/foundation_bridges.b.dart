// D4rt Bridge - Generated file, do not edit
// Sources: 28 files
// Generated: 2026-03-08T21:01:58.455727

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
      _createCachingIterableBridge(),
      _createFactoryBridge(),
      _createTextTreeConfigurationBridge(),
      _createTextTreeRendererBridge(),
      _createDiagnosticsNodeBridge(),
      _createMessagePropertyBridge(),
      _createStringPropertyBridge(),
      _createDoublePropertyBridge(),
      _createIntPropertyBridge(),
      _createPercentPropertyBridge(),
      _createFlagPropertyBridge(),
      _createIterablePropertyBridge(),
      _createEnumPropertyBridge(),
      _createObjectFlagPropertyBridge(),
      _createFlagsSummaryBridge(),
      _createDiagnosticsPropertyBridge(),
      _createDiagnosticableNodeBridge(),
      _createDiagnosticableTreeNodeBridge(),
      _createDiagnosticPropertiesBuilderBridge(),
      _createDiagnosticableBridge(),
      _createDiagnosticableTreeBridge(),
      _createDiagnosticableTreeMixinBridge(),
      _createDiagnosticsBlockBridge(),
      _createDiagnosticsSerializationDelegateBridge(),
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
      'CachingIterable': 'package:flutter/src/foundation/basic_types.dart',
      'Factory': 'package:flutter/src/foundation/basic_types.dart',
      'TextTreeConfiguration': 'package:flutter/src/foundation/diagnostics.dart',
      'TextTreeRenderer': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticsNode': 'package:flutter/src/foundation/diagnostics.dart',
      'MessageProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'StringProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'DoubleProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'IntProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'PercentProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'FlagProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'IterableProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'EnumProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'FlagsSummary': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticsProperty': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticableNode': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticableTreeNode': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticPropertiesBuilder': 'package:flutter/src/foundation/diagnostics.dart',
      'Diagnosticable': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticableTree': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticableTreeMixin': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticsBlock': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticsSerializationDelegate': 'package:flutter/src/foundation/diagnostics.dart',
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

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
      'MemoryAllocations': 'FlutterMemoryAllocations',
    };
  }

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
      'ValueChanged',
      'ValueSetter',
      'ValueGetter',
      'IterableFilter',
      'AsyncCallback',
      'AsyncValueSetter',
      'AsyncValueGetter',
      'ComputePropertyValueCallback',
      'FlutterExceptionHandler',
      'DiagnosticPropertiesTransformer',
      'InformationCollector',
      'StackTraceDemangler',
      'ServiceExtensionCallback',
      'VoidCallback',
      'BytesReceivedCallback',
      'DebugPrintCallback',
      'ComputeCallback',
      'ComputeImpl',
      'LicenseEntryCollector',
      'ObjectEventListener',
      'TimelineSyncFunction',
    ];
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

    // Register class aliases (typedef type aliases)
    final aliases = classAliases();
    for (final entry in aliases.entries) {
      interpreter.registerClassAlias(entry.key, entry.value, importPath);
    }

    // Register function typedefs for type resolution
    final typedefs = functionTypedefs();
    for (final name in typedefs) {
      interpreter.registerFunctionTypedef(name, importPath);
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
      interpreter.registerGlobalVariable('sparseTextConfiguration', $flutter_12.sparseTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "sparseTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('dashedTextConfiguration', $flutter_12.dashedTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "dashedTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('denseTextConfiguration', $flutter_12.denseTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "denseTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('transitionTextConfiguration', $flutter_12.transitionTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "transitionTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('errorTextConfiguration', $flutter_12.errorTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "errorTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('whitespaceTextConfiguration', $flutter_12.whitespaceTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "whitespaceTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('flatTextConfiguration', $flutter_12.flatTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "flatTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('singleLineTextConfiguration', $flutter_12.singleLineTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "singleLineTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('errorPropertyTextConfiguration', $flutter_12.errorPropertyTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "errorPropertyTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('shallowTextConfiguration', $flutter_12.shallowTextConfiguration, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "shallowTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('kNoDefaultValue', $flutter_12.kNoDefaultValue, importPath, sourceUri: 'package:flutter/src/foundation/diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "kNoDefaultValue": $e');
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
      interpreter.registerGlobalVariable('debugPrint', $flutter_21.debugPrint, importPath, sourceUri: 'package:flutter/src/foundation/print.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrint": $e');
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
    interpreter.registerGlobalGetter('debugPrintDone', () => $flutter_21.debugPrintDone, importPath, sourceUri: 'package:flutter/src/foundation/print.dart');
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
      'lerpDuration': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpDuration');
        final a = D4.getRequiredArg<Duration>(positional, 0, 'a', 'lerpDuration');
        final b = D4.getRequiredArg<Duration>(positional, 1, 'b', 'lerpDuration');
        final t = D4.getRequiredArg<double>(positional, 2, 't', 'lerpDuration');
        return $flutter_3.lerpDuration(a, b, t);
      },
      'shortHash': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'shortHash');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'shortHash');
        return $flutter_12.shortHash(object);
      },
      'describeIdentity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'describeIdentity');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'describeIdentity');
        return $flutter_12.describeIdentity(object);
      },
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
        final compare = compareRaw == null ? null : (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor!, compareRaw, [p0, p1]) as int; };
        return $flutter_8.mergeSort<dynamic>(list, start: start, end: end, compare: compare);
      },
      'consolidateHttpClientResponseBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'consolidateHttpClientResponseBytes');
        final response = D4.getRequiredArg<HttpClientResponse>(positional, 0, 'response', 'consolidateHttpClientResponseBytes');
        final autoUncompress = D4.getNamedArgWithDefault<bool>(named, 'autoUncompress', true);
        final onBytesReceivedRaw = named['onBytesReceived'];
        final onBytesReceived = onBytesReceivedRaw == null ? null : (int p0, int? p1) { D4.callInterpreterCallback(visitor!, onBytesReceivedRaw, [p0, p1]); };
        return $flutter_9.consolidateHttpClientResponseBytes(response, autoUncompress: autoUncompress, onBytesReceived: onBytesReceived);
      },
      'debugPrintSynchronously': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugPrintSynchronously');
        final message = D4.getRequiredArg<String?>(positional, 0, 'message', 'debugPrintSynchronously');
        final wrapWidth = D4.getOptionalNamedArg<int?>(named, 'wrapWidth');
        return $flutter_21.debugPrintSynchronously(message, wrapWidth: wrapWidth);
      },
      'debugPrintThrottled': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugPrintThrottled');
        final message = D4.getRequiredArg<String?>(positional, 0, 'message', 'debugPrintThrottled');
        final wrapWidth = D4.getOptionalNamedArg<int?>(named, 'wrapWidth');
        return $flutter_21.debugPrintThrottled(message, wrapWidth: wrapWidth);
      },
      'debugWordWrap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'debugWordWrap');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'debugWordWrap');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'debugWordWrap');
        final wrapIndent = D4.getNamedArgWithDefault<String>(named, 'wrapIndent', '');
        return $flutter_21.debugWordWrap(message, width, wrapIndent: wrapIndent);
      },
      'debugAssertAllFoundationVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllFoundationVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllFoundationVarsUnset');
        if (!named.containsKey('debugPrintOverride')) {
          return $flutter_11.debugAssertAllFoundationVarsUnset(reason);
        }
        if (named.containsKey('debugPrintOverride')) {
          final debugPrintOverrideRaw = named['debugPrintOverride'];
          final debugPrintOverride = (String? p0, {int? wrapWidth}) { D4.callInterpreterCallback(visitor!, debugPrintOverrideRaw, [p0], {'wrapWidth': wrapWidth}); };
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
        final action = () { return D4.callInterpreterCallback(visitor!, actionRaw, []) as Future<dynamic>; };
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
        final callback = (dynamic p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as FutureOr<Object>; };
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
      'lerpDuration': 'package:flutter/src/foundation/basic_types.dart',
      'shortHash': 'package:flutter/src/foundation/diagnostics.dart',
      'describeIdentity': 'package:flutter/src/foundation/diagnostics.dart',
      'debugPrintStack': 'package:flutter/src/foundation/assertions.dart',
      'setEquals': 'package:flutter/src/foundation/collections.dart',
      'listEquals': 'package:flutter/src/foundation/collections.dart',
      'mapEquals': 'package:flutter/src/foundation/collections.dart',
      'binarySearch': 'package:flutter/src/foundation/collections.dart',
      'mergeSort': 'package:flutter/src/foundation/collections.dart',
      'consolidateHttpClientResponseBytes': 'package:flutter/src/foundation/consolidate_response.dart',
      'debugPrintSynchronously': 'package:flutter/src/foundation/print.dart',
      'debugPrintThrottled': 'package:flutter/src/foundation/print.dart',
      'debugWordWrap': 'package:flutter/src/foundation/print.dart',
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
      'lerpDuration': 'Duration lerpDuration(Duration a, Duration b, double t)',
      'shortHash': 'String shortHash(Object? object)',
      'describeIdentity': 'String describeIdentity(Object? object)',
      'debugPrintStack': 'void debugPrintStack({StackTrace? stackTrace, String? label, int? maxFrames})',
      'setEquals': 'bool setEquals(Set<T>? a, Set<T>? b)',
      'listEquals': 'bool listEquals(List<T>? a, List<T>? b)',
      'mapEquals': 'bool mapEquals(Map<T, U>? a, Map<T, U>? b)',
      'binarySearch': 'int binarySearch(List<T> sortedList, T value)',
      'mergeSort': 'void mergeSort(List<T> list, {int start = 0, int? end, int Function(T, T)? compare})',
      'consolidateHttpClientResponseBytes': 'Future<Uint8List> consolidateHttpClientResponseBytes(HttpClientResponse response, {bool autoUncompress = true, BytesReceivedCallback? onBytesReceived})',
      'debugPrintSynchronously': 'void debugPrintSynchronously(String? message, {int? wrapWidth})',
      'debugPrintThrottled': 'void debugPrintThrottled(String? message, {int? wrapWidth})',
      'debugWordWrap': 'Iterable<String> debugWordWrap(String message, int width, {String wrapIndent = \'\'})',
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
      'package:flutter/src/foundation/basic_types.dart',
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
      'package:flutter/src/foundation/print.dart',
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
    isAssignable: (v) => v is $flutter_1.Category,
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
    isAssignable: (v) => v is $flutter_1.DocumentationIcon,
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
    isAssignable: (v) => v is $flutter_1.Summary,
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
// CachingIterable Bridge
// =============================================================================

BridgedClass _createCachingIterableBridge() {
  return BridgedClass(
    nativeType: $flutter_3.CachingIterable,
    name: 'CachingIterable',
    isAssignable: (v) => v is $flutter_3.CachingIterable,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CachingIterable');
        final prefillIterator = D4.getRequiredArg<Iterator<dynamic>>(positional, 0, '_prefillIterator', 'CachingIterable');
        return $flutter_3.CachingIterable(prefillIterator);
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').iterator,
      'length': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').length,
      'isEmpty': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').isNotEmpty,
      'first': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').first,
      'last': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').last,
      'single': (visitor, target) => D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable').single,
    },
    methods: {
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, toElementRaw, [p0])); });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor!, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'followedBy');
        if (positional.isEmpty) {
          throw ArgumentError('followedBy: Missing required argument "other" at position 0');
        }
        final other = D4.coerceList<dynamic>(positional[0], 'other');
        return t.followedBy(other);
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        return t.whereType();
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor!, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        return t.toSet();
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.CachingIterable>(target, 'CachingIterable');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'CachingIterable(Iterator<E> _prefillIterator)',
    },
    methodSignatures: {
      'map': 'Iterable<T> map(T Function(E e) toElement)',
      'where': 'Iterable<E> where(bool Function(E element) test)',
      'expand': 'Iterable<T> expand(Iterable<T> Function(E element) toElements)',
      'take': 'Iterable<E> take(int count)',
      'takeWhile': 'Iterable<E> takeWhile(bool Function(E value) test)',
      'skip': 'Iterable<E> skip(int count)',
      'skipWhile': 'Iterable<E> skipWhile(bool Function(E value) test)',
      'elementAt': 'E elementAt(int index)',
      'toList': 'List<E> toList({bool growable = true})',
      'cast': 'Iterable<R> cast()',
      'followedBy': 'Iterable<E> followedBy(Iterable<E> other)',
      'whereType': 'Iterable<T> whereType()',
      'contains': 'bool contains(Object? element)',
      'forEach': 'void forEach(void Function(E) action)',
      'reduce': 'E reduce(E Function(E, E) combine)',
      'fold': 'T fold(T initialValue, T Function(T, E) combine)',
      'every': 'bool every(bool Function(E) test)',
      'join': 'String join([String separator = ""])',
      'any': 'bool any(bool Function(E) test)',
      'toSet': 'Set<E> toSet()',
      'firstWhere': 'E firstWhere(bool Function(E) test, {E Function()? orElse})',
      'lastWhere': 'E lastWhere(bool Function(E) test, {E Function()? orElse})',
      'singleWhere': 'E singleWhere(bool Function(E) test, {E Function()? orElse})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'iterator': 'Iterator<E> get iterator',
      'length': 'int get length',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'first': 'E get first',
      'last': 'E get last',
      'single': 'E get single',
    },
  );
}

// =============================================================================
// Factory Bridge
// =============================================================================

BridgedClass _createFactoryBridge() {
  return BridgedClass(
    nativeType: $flutter_3.Factory,
    name: 'Factory',
    isAssignable: (v) => v is $flutter_3.Factory,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Factory');
        if (positional.isEmpty) {
          throw ArgumentError('Factory: Missing required argument "constructor" at position 0');
        }
        final constructorRaw = positional[0];
        return $flutter_3.Factory(() { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, constructorRaw, [])); });
      },
    },
    getters: {
      'constructor': (visitor, target) => D4.validateTarget<$flutter_3.Factory>(target, 'Factory').constructor,
      'type': (visitor, target) => D4.validateTarget<$flutter_3.Factory>(target, 'Factory').type,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.Factory>(target, 'Factory');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Factory(T Function() constructor)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'constructor': 'ValueGetter<T> get constructor',
      'type': 'Type get type',
    },
  );
}

// =============================================================================
// TextTreeConfiguration Bridge
// =============================================================================

BridgedClass _createTextTreeConfigurationBridge() {
  return BridgedClass(
    nativeType: $flutter_12.TextTreeConfiguration,
    name: 'TextTreeConfiguration',
    isAssignable: (v) => v is $flutter_12.TextTreeConfiguration,
    constructors: {
      '': (visitor, positional, named) {
        final prefixLineOne = D4.getRequiredNamedArg<String>(named, 'prefixLineOne', 'TextTreeConfiguration');
        final prefixOtherLines = D4.getRequiredNamedArg<String>(named, 'prefixOtherLines', 'TextTreeConfiguration');
        final prefixLastChildLineOne = D4.getRequiredNamedArg<String>(named, 'prefixLastChildLineOne', 'TextTreeConfiguration');
        final prefixOtherLinesRootNode = D4.getRequiredNamedArg<String>(named, 'prefixOtherLinesRootNode', 'TextTreeConfiguration');
        final linkCharacter = D4.getRequiredNamedArg<String>(named, 'linkCharacter', 'TextTreeConfiguration');
        final propertyPrefixIfChildren = D4.getRequiredNamedArg<String>(named, 'propertyPrefixIfChildren', 'TextTreeConfiguration');
        final propertyPrefixNoChildren = D4.getRequiredNamedArg<String>(named, 'propertyPrefixNoChildren', 'TextTreeConfiguration');
        final lineBreak = D4.getNamedArgWithDefault<String>(named, 'lineBreak', '\n');
        final lineBreakProperties = D4.getNamedArgWithDefault<bool>(named, 'lineBreakProperties', true);
        final afterName = D4.getNamedArgWithDefault<String>(named, 'afterName', ':');
        final afterDescriptionIfBody = D4.getNamedArgWithDefault<String>(named, 'afterDescriptionIfBody', '');
        final afterDescription = D4.getNamedArgWithDefault<String>(named, 'afterDescription', '');
        final beforeProperties = D4.getNamedArgWithDefault<String>(named, 'beforeProperties', '');
        final afterProperties = D4.getNamedArgWithDefault<String>(named, 'afterProperties', '');
        final mandatoryAfterProperties = D4.getNamedArgWithDefault<String>(named, 'mandatoryAfterProperties', '');
        final propertySeparator = D4.getNamedArgWithDefault<String>(named, 'propertySeparator', '');
        final bodyIndent = D4.getNamedArgWithDefault<String>(named, 'bodyIndent', '');
        final footer = D4.getNamedArgWithDefault<String>(named, 'footer', '');
        final showChildren = D4.getNamedArgWithDefault<bool>(named, 'showChildren', true);
        final addBlankLineIfNoChildren = D4.getNamedArgWithDefault<bool>(named, 'addBlankLineIfNoChildren', true);
        final isNameOnOwnLine = D4.getNamedArgWithDefault<bool>(named, 'isNameOnOwnLine', false);
        final isBlankLineBetweenPropertiesAndChildren = D4.getNamedArgWithDefault<bool>(named, 'isBlankLineBetweenPropertiesAndChildren', true);
        final beforeName = D4.getNamedArgWithDefault<String>(named, 'beforeName', '');
        final suffixLineOne = D4.getNamedArgWithDefault<String>(named, 'suffixLineOne', '');
        final mandatoryFooter = D4.getNamedArgWithDefault<String>(named, 'mandatoryFooter', '');
        return $flutter_12.TextTreeConfiguration(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, prefixLastChildLineOne: prefixLastChildLineOne, prefixOtherLinesRootNode: prefixOtherLinesRootNode, linkCharacter: linkCharacter, propertyPrefixIfChildren: propertyPrefixIfChildren, propertyPrefixNoChildren: propertyPrefixNoChildren, lineBreak: lineBreak, lineBreakProperties: lineBreakProperties, afterName: afterName, afterDescriptionIfBody: afterDescriptionIfBody, afterDescription: afterDescription, beforeProperties: beforeProperties, afterProperties: afterProperties, mandatoryAfterProperties: mandatoryAfterProperties, propertySeparator: propertySeparator, bodyIndent: bodyIndent, footer: footer, showChildren: showChildren, addBlankLineIfNoChildren: addBlankLineIfNoChildren, isNameOnOwnLine: isNameOnOwnLine, isBlankLineBetweenPropertiesAndChildren: isBlankLineBetweenPropertiesAndChildren, beforeName: beforeName, suffixLineOne: suffixLineOne, mandatoryFooter: mandatoryFooter);
      },
    },
    getters: {
      'prefixLineOne': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixLineOne,
      'suffixLineOne': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').suffixLineOne,
      'prefixOtherLines': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixOtherLines,
      'prefixLastChildLineOne': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixLastChildLineOne,
      'prefixOtherLinesRootNode': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixOtherLinesRootNode,
      'propertyPrefixIfChildren': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').propertyPrefixIfChildren,
      'propertyPrefixNoChildren': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').propertyPrefixNoChildren,
      'linkCharacter': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').linkCharacter,
      'childLinkSpace': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').childLinkSpace,
      'lineBreak': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').lineBreak,
      'lineBreakProperties': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').lineBreakProperties,
      'beforeName': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').beforeName,
      'afterName': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterName,
      'afterDescriptionIfBody': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterDescriptionIfBody,
      'afterDescription': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterDescription,
      'beforeProperties': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').beforeProperties,
      'afterProperties': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterProperties,
      'mandatoryAfterProperties': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').mandatoryAfterProperties,
      'propertySeparator': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').propertySeparator,
      'bodyIndent': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').bodyIndent,
      'showChildren': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').showChildren,
      'addBlankLineIfNoChildren': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').addBlankLineIfNoChildren,
      'isNameOnOwnLine': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').isNameOnOwnLine,
      'footer': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').footer,
      'mandatoryFooter': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').mandatoryFooter,
      'isBlankLineBetweenPropertiesAndChildren': (visitor, target) => D4.validateTarget<$flutter_12.TextTreeConfiguration>(target, 'TextTreeConfiguration').isBlankLineBetweenPropertiesAndChildren,
    },
    constructorSignatures: {
      '': 'TextTreeConfiguration({required String prefixLineOne, required String prefixOtherLines, required String prefixLastChildLineOne, required String prefixOtherLinesRootNode, required String linkCharacter, required String propertyPrefixIfChildren, required String propertyPrefixNoChildren, String lineBreak = \'\\n\', bool lineBreakProperties = true, String afterName = \':\', String afterDescriptionIfBody = \'\', String afterDescription = \'\', String beforeProperties = \'\', String afterProperties = \'\', String mandatoryAfterProperties = \'\', String propertySeparator = \'\', String bodyIndent = \'\', String footer = \'\', bool showChildren = true, bool addBlankLineIfNoChildren = true, bool isNameOnOwnLine = false, bool isBlankLineBetweenPropertiesAndChildren = true, String beforeName = \'\', String suffixLineOne = \'\', String mandatoryFooter = \'\'})',
    },
    getterSignatures: {
      'prefixLineOne': 'String get prefixLineOne',
      'suffixLineOne': 'String get suffixLineOne',
      'prefixOtherLines': 'String get prefixOtherLines',
      'prefixLastChildLineOne': 'String get prefixLastChildLineOne',
      'prefixOtherLinesRootNode': 'String get prefixOtherLinesRootNode',
      'propertyPrefixIfChildren': 'String get propertyPrefixIfChildren',
      'propertyPrefixNoChildren': 'String get propertyPrefixNoChildren',
      'linkCharacter': 'String get linkCharacter',
      'childLinkSpace': 'String get childLinkSpace',
      'lineBreak': 'String get lineBreak',
      'lineBreakProperties': 'bool get lineBreakProperties',
      'beforeName': 'String get beforeName',
      'afterName': 'String get afterName',
      'afterDescriptionIfBody': 'String get afterDescriptionIfBody',
      'afterDescription': 'String get afterDescription',
      'beforeProperties': 'String get beforeProperties',
      'afterProperties': 'String get afterProperties',
      'mandatoryAfterProperties': 'String get mandatoryAfterProperties',
      'propertySeparator': 'String get propertySeparator',
      'bodyIndent': 'String get bodyIndent',
      'showChildren': 'bool get showChildren',
      'addBlankLineIfNoChildren': 'bool get addBlankLineIfNoChildren',
      'isNameOnOwnLine': 'bool get isNameOnOwnLine',
      'footer': 'String get footer',
      'mandatoryFooter': 'String get mandatoryFooter',
      'isBlankLineBetweenPropertiesAndChildren': 'bool get isBlankLineBetweenPropertiesAndChildren',
    },
  );
}

// =============================================================================
// TextTreeRenderer Bridge
// =============================================================================

BridgedClass _createTextTreeRendererBridge() {
  return BridgedClass(
    nativeType: $flutter_12.TextTreeRenderer,
    name: 'TextTreeRenderer',
    isAssignable: (v) => v is $flutter_12.TextTreeRenderer,
    constructors: {
      '': (visitor, positional, named) {
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 100);
        final wrapWidthProperties = D4.getNamedArgWithDefault<int>(named, 'wrapWidthProperties', 65);
        final maxDescendentsTruncatableNode = D4.getNamedArgWithDefault<int>(named, 'maxDescendentsTruncatableNode', -1);
        return $flutter_12.TextTreeRenderer(minLevel: minLevel, wrapWidth: wrapWidth, wrapWidthProperties: wrapWidthProperties, maxDescendentsTruncatableNode: maxDescendentsTruncatableNode);
      },
    },
    methods: {
      'render': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TextTreeRenderer>(target, 'TextTreeRenderer');
        D4.requireMinArgs(positional, 1, 'render');
        final node = D4.getRequiredArg<$flutter_12.DiagnosticsNode>(positional, 0, 'node', 'render');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.render(node, prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'TextTreeRenderer({DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 100, int wrapWidthProperties = 65, int maxDescendentsTruncatableNode = -1})',
    },
    methodSignatures: {
      'render': 'String render(DiagnosticsNode node, {String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration})',
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
    isAssignable: (v) => v is $flutter_12.DiagnosticsNode,
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
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsNode>(target, 'DiagnosticsNode').textTreeConfiguration,
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
    staticMethodSignatures: {
      'toJsonList': 'List<Map<String, Object?>> toJsonList(List<DiagnosticsNode>? nodes, DiagnosticsNode? parent, DiagnosticsSerializationDelegate delegate)',
    },
  );
}

// =============================================================================
// MessageProperty Bridge
// =============================================================================

BridgedClass _createMessagePropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.MessageProperty,
    name: 'MessageProperty',
    isAssignable: (v) => v is $flutter_12.MessageProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'MessageProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MessageProperty');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'MessageProperty');
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        return $flutter_12.MessageProperty(name, message, style: style, level: level);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.MessageProperty>(target, 'MessageProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'MessageProperty(String name, String message, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'void get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
    },
  );
}

// =============================================================================
// StringProperty Bridge
// =============================================================================

BridgedClass _createStringPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.StringProperty,
    name: 'StringProperty',
    isAssignable: (v) => v is $flutter_12.StringProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'StringProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'StringProperty');
        final value = D4.getRequiredArg<String?>(positional, 1, 'value', 'StringProperty');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final quoted = D4.getNamedArgWithDefault<bool>(named, 'quoted', true);
        final ifEmpty = D4.getOptionalNamedArg<String?>(named, 'ifEmpty');
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.StringProperty(name, value, description: description, tooltip: tooltip, showName: showName, quoted: quoted, ifEmpty: ifEmpty, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'StringProperty');
          return $flutter_12.StringProperty(name, value, description: description, tooltip: tooltip, showName: showName, quoted: quoted, ifEmpty: ifEmpty, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').isInteresting,
      'quoted': (visitor, target) => D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty').quoted,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StringProperty>(target, 'StringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'StringProperty(String name, String? value, {String? description, String? tooltip, bool showName = true, Object? defaultValue = kNoDefaultValue, bool quoted = true, String? ifEmpty, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'String get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'quoted': 'bool get quoted',
    },
  );
}

// =============================================================================
// DoubleProperty Bridge
// =============================================================================

BridgedClass _createDoublePropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DoubleProperty,
    name: 'DoubleProperty',
    isAssignable: (v) => v is $flutter_12.DoubleProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DoubleProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DoubleProperty');
        final value = D4.getRequiredArg<double?>(positional, 1, 'value', 'DoubleProperty');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.DoubleProperty(name, value, ifNull: ifNull, unit: unit, tooltip: tooltip, showName: showName, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DoubleProperty');
          return $flutter_12.DoubleProperty(name, value, ifNull: ifNull, unit: unit, tooltip: tooltip, showName: showName, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'lazy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DoubleProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DoubleProperty');
        if (positional.length <= 1) {
          throw ArgumentError('DoubleProperty: Missing required argument "computeValue" at position 1');
        }
        final computeValueRaw = positional[1];
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.DoubleProperty.lazy(name, () { return D4.callInterpreterCallback(visitor!, computeValueRaw, []) as double?; }, ifNull: ifNull, showName: showName, unit: unit, tooltip: tooltip, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DoubleProperty');
          return $flutter_12.DoubleProperty.lazy(name, () { return D4.callInterpreterCallback(visitor!, computeValueRaw, []) as double?; }, ifNull: ifNull, showName: showName, unit: unit, tooltip: tooltip, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'unit': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').unit,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty').textTreeConfiguration,
    },
    methods: {
      'numberToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        return t.numberToString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DoubleProperty>(target, 'DoubleProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'DoubleProperty(String name, double? value, {String? ifNull, String? unit, String? tooltip, Object? defaultValue = kNoDefaultValue, bool showName = true, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
      'lazy': 'DoubleProperty.lazy(String name, double? Function() computeValue, {String? ifNull, bool showName = true, String? unit, String? tooltip, Object? defaultValue = kNoDefaultValue, DiagnosticLevel level = DiagnosticLevel.info})',
    },
    methodSignatures: {
      'numberToString': 'String numberToString()',
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
      'unit': 'String? get unit',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'double get value',
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// IntProperty Bridge
// =============================================================================

BridgedClass _createIntPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.IntProperty,
    name: 'IntProperty',
    isAssignable: (v) => v is $flutter_12.IntProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'IntProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'IntProperty');
        final value = D4.getRequiredArg<int?>(positional, 1, 'value', 'IntProperty');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.IntProperty(name, value, ifNull: ifNull, showName: showName, unit: unit, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'IntProperty');
          return $flutter_12.IntProperty(name, value, ifNull: ifNull, showName: showName, unit: unit, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'unit': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').unit,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty').textTreeConfiguration,
    },
    methods: {
      'numberToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        return t.numberToString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IntProperty>(target, 'IntProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'IntProperty(String name, int? value, {String? ifNull, bool showName = true, String? unit, Object? defaultValue = kNoDefaultValue, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
    },
    methodSignatures: {
      'numberToString': 'String numberToString()',
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
      'unit': 'String? get unit',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'int get value',
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// PercentProperty Bridge
// =============================================================================

BridgedClass _createPercentPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PercentProperty,
    name: 'PercentProperty',
    isAssignable: (v) => v is $flutter_12.PercentProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PercentProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PercentProperty');
        final fraction = D4.getRequiredArg<double?>(positional, 1, 'fraction', 'PercentProperty');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        return $flutter_12.PercentProperty(name, fraction, ifNull: ifNull, showName: showName, tooltip: tooltip, unit: unit, level: level);
      },
    },
    getters: {
      'unit': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').unit,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty').textTreeConfiguration,
    },
    methods: {
      'numberToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        return t.numberToString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PercentProperty>(target, 'PercentProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'PercentProperty(String name, double? fraction, {String? ifNull, bool showName = true, String? tooltip, String? unit, DiagnosticLevel level = DiagnosticLevel.info})',
    },
    methodSignatures: {
      'numberToString': 'String numberToString()',
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
      'unit': 'String? get unit',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'double get value',
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// FlagProperty Bridge
// =============================================================================

BridgedClass _createFlagPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.FlagProperty,
    name: 'FlagProperty',
    isAssignable: (v) => v is $flutter_12.FlagProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlagProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'FlagProperty');
        final value = D4.getRequiredNamedArg<bool?>(named, 'value', 'FlagProperty');
        final ifTrue = D4.getOptionalNamedArg<String?>(named, 'ifTrue');
        final ifFalse = D4.getOptionalNamedArg<String?>(named, 'ifFalse');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', false);
        final defaultValue = D4.getOptionalNamedArg<Object?>(named, 'defaultValue');
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        return $flutter_12.FlagProperty(name, value: value, ifTrue: ifTrue, ifFalse: ifFalse, showName: showName, defaultValue: defaultValue, level: level);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').isInteresting,
      'ifTrue': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').ifTrue,
      'ifFalse': (visitor, target) => D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty').ifFalse,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagProperty>(target, 'FlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'FlagProperty(String name, {required bool? value, String? ifTrue, String? ifFalse, bool showName = false, Object? defaultValue, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'bool get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'ifTrue': 'String? get ifTrue',
      'ifFalse': 'String? get ifFalse',
    },
  );
}

// =============================================================================
// IterableProperty Bridge
// =============================================================================

BridgedClass _createIterablePropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.IterableProperty,
    name: 'IterableProperty',
    isAssignable: (v) => v is $flutter_12.IterableProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'IterableProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'IterableProperty');
        if (positional.length <= 1) {
          throw ArgumentError('IterableProperty: Missing required argument "value" at position 1');
        }
        final value = D4.coerceListOrNull<dynamic>(positional[1], 'value');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final ifEmpty = D4.getNamedArgWithDefault<String?>(named, 'ifEmpty', '[]');
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.IterableProperty(name, value, ifNull: ifNull, ifEmpty: ifEmpty, style: style, showName: showName, showSeparator: showSeparator, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'IterableProperty');
          return $flutter_12.IterableProperty(name, value, ifNull: ifNull, ifEmpty: ifEmpty, style: style, showName: showName, showSeparator: showSeparator, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.IterableProperty>(target, 'IterableProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'IterableProperty(String name, Iterable<T>? value, {Object? defaultValue = kNoDefaultValue, String? ifNull, String? ifEmpty = \'[]\', DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, bool showName = true, bool showSeparator = true, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'Iterable<T> get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
    },
  );
}

// =============================================================================
// EnumProperty Bridge
// =============================================================================

BridgedClass _createEnumPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.EnumProperty,
    name: 'EnumProperty',
    isAssignable: (v) => v is $flutter_12.EnumProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EnumProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'EnumProperty');
        final value = D4.getRequiredArg<Enum?>(positional, 1, 'value', 'EnumProperty');
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.EnumProperty(name, value, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'EnumProperty');
          return $flutter_12.EnumProperty(name, value, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EnumProperty>(target, 'EnumProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'EnumProperty(String name, T? value, {Object? defaultValue = kNoDefaultValue, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'T get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
    },
  );
}

// =============================================================================
// ObjectFlagProperty Bridge
// =============================================================================

BridgedClass _createObjectFlagPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.ObjectFlagProperty,
    name: 'ObjectFlagProperty',
    isAssignable: (v) => v is $flutter_12.ObjectFlagProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ObjectFlagProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ObjectFlagProperty');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'ObjectFlagProperty');
        final ifPresent = D4.getOptionalNamedArg<String?>(named, 'ifPresent');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', false);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_12.ObjectFlagProperty<double>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case int _: return $flutter_12.ObjectFlagProperty<int>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case String _: return $flutter_12.ObjectFlagProperty<String>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case bool _: return $flutter_12.ObjectFlagProperty<bool>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_1.Category _: return $flutter_12.ObjectFlagProperty<$flutter_1.Category>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_1.DocumentationIcon _: return $flutter_12.ObjectFlagProperty<$flutter_1.DocumentationIcon>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_1.Summary _: return $flutter_12.ObjectFlagProperty<$flutter_1.Summary>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_3.CachingIterable _: return $flutter_12.ObjectFlagProperty<$flutter_3.CachingIterable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_3.Factory _: return $flutter_12.ObjectFlagProperty<$flutter_3.Factory>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.TextTreeConfiguration _: return $flutter_12.ObjectFlagProperty<$flutter_12.TextTreeConfiguration>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.TextTreeRenderer _: return $flutter_12.ObjectFlagProperty<$flutter_12.TextTreeRenderer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticsNode _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsNode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.MessageProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.MessageProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.StringProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.StringProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DoubleProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.DoubleProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.IntProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.IntProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.PercentProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.PercentProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.FlagProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.FlagProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.IterableProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.IterableProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.EnumProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.EnumProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.FlagsSummary _: return $flutter_12.ObjectFlagProperty<$flutter_12.FlagsSummary>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticsProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticableNode _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableNode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticableTreeNode _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableTreeNode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticPropertiesBuilder _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticPropertiesBuilder>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.Diagnosticable _: return $flutter_12.ObjectFlagProperty<$flutter_12.Diagnosticable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticableTree _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableTree>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticableTreeMixin _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableTreeMixin>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticsBlock _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsBlock>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.DiagnosticsSerializationDelegate _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsSerializationDelegate>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_24.StackFrame _: return $flutter_12.ObjectFlagProperty<$flutter_24.StackFrame>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.PartialStackFrame _: return $flutter_12.ObjectFlagProperty<$flutter_2.PartialStackFrame>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.StackFilter _: return $flutter_12.ObjectFlagProperty<$flutter_2.StackFilter>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.RepetitiveStackFrameFilter _: return $flutter_12.ObjectFlagProperty<$flutter_2.RepetitiveStackFrameFilter>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.ErrorDescription _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorDescription>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.ErrorSummary _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorSummary>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.ErrorHint _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorHint>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.ErrorSpacer _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorSpacer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.FlutterErrorDetails _: return $flutter_12.ObjectFlagProperty<$flutter_2.FlutterErrorDetails>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.FlutterError _: return $flutter_12.ObjectFlagProperty<$flutter_2.FlutterError>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_2.DiagnosticsStackTrace _: return $flutter_12.ObjectFlagProperty<$flutter_2.DiagnosticsStackTrace>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_4.BindingBase _: return $flutter_12.ObjectFlagProperty<$flutter_4.BindingBase>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_5.BitField _: return $flutter_12.ObjectFlagProperty<$flutter_5.BitField>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_7.Listenable _: return $flutter_12.ObjectFlagProperty<$flutter_7.Listenable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_7.ValueListenable _: return $flutter_12.ObjectFlagProperty<$flutter_7.ValueListenable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_7.ChangeNotifier _: return $flutter_12.ObjectFlagProperty<$flutter_7.ChangeNotifier>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_7.ValueNotifier _: return $flutter_12.ObjectFlagProperty<$flutter_7.ValueNotifier>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_14.Key _: return $flutter_12.ObjectFlagProperty<$flutter_14.Key>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_14.LocalKey _: return $flutter_12.ObjectFlagProperty<$flutter_14.LocalKey>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_14.UniqueKey _: return $flutter_12.ObjectFlagProperty<$flutter_14.UniqueKey>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_14.ValueKey _: return $flutter_12.ObjectFlagProperty<$flutter_14.ValueKey>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_15.LicenseParagraph _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseParagraph>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_15.LicenseEntry _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseEntry>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_15.LicenseEntryWithLineBreaks _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseEntryWithLineBreaks>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_15.LicenseRegistry _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseRegistry>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_16.ObjectEvent _: return $flutter_12.ObjectFlagProperty<$flutter_16.ObjectEvent>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_16.ObjectCreated _: return $flutter_12.ObjectFlagProperty<$flutter_16.ObjectCreated>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_16.ObjectDisposed _: return $flutter_12.ObjectFlagProperty<$flutter_16.ObjectDisposed>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_16.FlutterMemoryAllocations _: return $flutter_12.ObjectFlagProperty<$flutter_16.FlutterMemoryAllocations>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_18.ObserverList _: return $flutter_12.ObjectFlagProperty<$flutter_18.ObserverList>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_18.HashedObserverList _: return $flutter_12.ObjectFlagProperty<$flutter_18.HashedObserverList>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_19.PersistentHashMap _: return $flutter_12.ObjectFlagProperty<$flutter_19.PersistentHashMap>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_22.WriteBuffer _: return $flutter_12.ObjectFlagProperty<$flutter_22.WriteBuffer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_22.ReadBuffer _: return $flutter_12.ObjectFlagProperty<$flutter_22.ReadBuffer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_25.SynchronousFuture _: return $flutter_12.ObjectFlagProperty<$flutter_25.SynchronousFuture>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_26.FlutterTimeline _: return $flutter_12.ObjectFlagProperty<$flutter_26.FlutterTimeline>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_26.TimedBlock _: return $flutter_12.ObjectFlagProperty<$flutter_26.TimedBlock>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_26.AggregatedTimings _: return $flutter_12.ObjectFlagProperty<$flutter_26.AggregatedTimings>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_26.AggregatedTimedBlock _: return $flutter_12.ObjectFlagProperty<$flutter_26.AggregatedTimedBlock>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_27.Unicode _: return $flutter_12.ObjectFlagProperty<$flutter_27.Unicode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $meta_1.Immutable _: return $flutter_12.ObjectFlagProperty<$meta_1.Immutable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          default: return $flutter_12.ObjectFlagProperty(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
        }
      },
      'has': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ObjectFlagProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ObjectFlagProperty');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'ObjectFlagProperty');
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_12.ObjectFlagProperty<double>.has(name, value, level: level);
          case int _: return $flutter_12.ObjectFlagProperty<int>.has(name, value, level: level);
          case String _: return $flutter_12.ObjectFlagProperty<String>.has(name, value, level: level);
          case bool _: return $flutter_12.ObjectFlagProperty<bool>.has(name, value, level: level);
          case $flutter_1.Category _: return $flutter_12.ObjectFlagProperty<$flutter_1.Category>.has(name, value, level: level);
          case $flutter_1.DocumentationIcon _: return $flutter_12.ObjectFlagProperty<$flutter_1.DocumentationIcon>.has(name, value, level: level);
          case $flutter_1.Summary _: return $flutter_12.ObjectFlagProperty<$flutter_1.Summary>.has(name, value, level: level);
          case $flutter_3.CachingIterable _: return $flutter_12.ObjectFlagProperty<$flutter_3.CachingIterable>.has(name, value, level: level);
          case $flutter_3.Factory _: return $flutter_12.ObjectFlagProperty<$flutter_3.Factory>.has(name, value, level: level);
          case $flutter_12.TextTreeConfiguration _: return $flutter_12.ObjectFlagProperty<$flutter_12.TextTreeConfiguration>.has(name, value, level: level);
          case $flutter_12.TextTreeRenderer _: return $flutter_12.ObjectFlagProperty<$flutter_12.TextTreeRenderer>.has(name, value, level: level);
          case $flutter_12.DiagnosticsNode _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsNode>.has(name, value, level: level);
          case $flutter_12.MessageProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.MessageProperty>.has(name, value, level: level);
          case $flutter_12.StringProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.StringProperty>.has(name, value, level: level);
          case $flutter_12.DoubleProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.DoubleProperty>.has(name, value, level: level);
          case $flutter_12.IntProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.IntProperty>.has(name, value, level: level);
          case $flutter_12.PercentProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.PercentProperty>.has(name, value, level: level);
          case $flutter_12.FlagProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.FlagProperty>.has(name, value, level: level);
          case $flutter_12.IterableProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.IterableProperty>.has(name, value, level: level);
          case $flutter_12.EnumProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.EnumProperty>.has(name, value, level: level);
          case $flutter_12.FlagsSummary _: return $flutter_12.ObjectFlagProperty<$flutter_12.FlagsSummary>.has(name, value, level: level);
          case $flutter_12.DiagnosticsProperty _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsProperty>.has(name, value, level: level);
          case $flutter_12.DiagnosticableNode _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableNode>.has(name, value, level: level);
          case $flutter_12.DiagnosticableTreeNode _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableTreeNode>.has(name, value, level: level);
          case $flutter_12.DiagnosticPropertiesBuilder _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticPropertiesBuilder>.has(name, value, level: level);
          case $flutter_12.Diagnosticable _: return $flutter_12.ObjectFlagProperty<$flutter_12.Diagnosticable>.has(name, value, level: level);
          case $flutter_12.DiagnosticableTree _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableTree>.has(name, value, level: level);
          case $flutter_12.DiagnosticableTreeMixin _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticableTreeMixin>.has(name, value, level: level);
          case $flutter_12.DiagnosticsBlock _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsBlock>.has(name, value, level: level);
          case $flutter_12.DiagnosticsSerializationDelegate _: return $flutter_12.ObjectFlagProperty<$flutter_12.DiagnosticsSerializationDelegate>.has(name, value, level: level);
          case $flutter_24.StackFrame _: return $flutter_12.ObjectFlagProperty<$flutter_24.StackFrame>.has(name, value, level: level);
          case $flutter_2.PartialStackFrame _: return $flutter_12.ObjectFlagProperty<$flutter_2.PartialStackFrame>.has(name, value, level: level);
          case $flutter_2.StackFilter _: return $flutter_12.ObjectFlagProperty<$flutter_2.StackFilter>.has(name, value, level: level);
          case $flutter_2.RepetitiveStackFrameFilter _: return $flutter_12.ObjectFlagProperty<$flutter_2.RepetitiveStackFrameFilter>.has(name, value, level: level);
          case $flutter_2.ErrorDescription _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorDescription>.has(name, value, level: level);
          case $flutter_2.ErrorSummary _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorSummary>.has(name, value, level: level);
          case $flutter_2.ErrorHint _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorHint>.has(name, value, level: level);
          case $flutter_2.ErrorSpacer _: return $flutter_12.ObjectFlagProperty<$flutter_2.ErrorSpacer>.has(name, value, level: level);
          case $flutter_2.FlutterErrorDetails _: return $flutter_12.ObjectFlagProperty<$flutter_2.FlutterErrorDetails>.has(name, value, level: level);
          case $flutter_2.FlutterError _: return $flutter_12.ObjectFlagProperty<$flutter_2.FlutterError>.has(name, value, level: level);
          case $flutter_2.DiagnosticsStackTrace _: return $flutter_12.ObjectFlagProperty<$flutter_2.DiagnosticsStackTrace>.has(name, value, level: level);
          case $flutter_4.BindingBase _: return $flutter_12.ObjectFlagProperty<$flutter_4.BindingBase>.has(name, value, level: level);
          case $flutter_5.BitField _: return $flutter_12.ObjectFlagProperty<$flutter_5.BitField>.has(name, value, level: level);
          case $flutter_7.Listenable _: return $flutter_12.ObjectFlagProperty<$flutter_7.Listenable>.has(name, value, level: level);
          case $flutter_7.ValueListenable _: return $flutter_12.ObjectFlagProperty<$flutter_7.ValueListenable>.has(name, value, level: level);
          case $flutter_7.ChangeNotifier _: return $flutter_12.ObjectFlagProperty<$flutter_7.ChangeNotifier>.has(name, value, level: level);
          case $flutter_7.ValueNotifier _: return $flutter_12.ObjectFlagProperty<$flutter_7.ValueNotifier>.has(name, value, level: level);
          case $flutter_14.Key _: return $flutter_12.ObjectFlagProperty<$flutter_14.Key>.has(name, value, level: level);
          case $flutter_14.LocalKey _: return $flutter_12.ObjectFlagProperty<$flutter_14.LocalKey>.has(name, value, level: level);
          case $flutter_14.UniqueKey _: return $flutter_12.ObjectFlagProperty<$flutter_14.UniqueKey>.has(name, value, level: level);
          case $flutter_14.ValueKey _: return $flutter_12.ObjectFlagProperty<$flutter_14.ValueKey>.has(name, value, level: level);
          case $flutter_15.LicenseParagraph _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseParagraph>.has(name, value, level: level);
          case $flutter_15.LicenseEntry _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseEntry>.has(name, value, level: level);
          case $flutter_15.LicenseEntryWithLineBreaks _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseEntryWithLineBreaks>.has(name, value, level: level);
          case $flutter_15.LicenseRegistry _: return $flutter_12.ObjectFlagProperty<$flutter_15.LicenseRegistry>.has(name, value, level: level);
          case $flutter_16.ObjectEvent _: return $flutter_12.ObjectFlagProperty<$flutter_16.ObjectEvent>.has(name, value, level: level);
          case $flutter_16.ObjectCreated _: return $flutter_12.ObjectFlagProperty<$flutter_16.ObjectCreated>.has(name, value, level: level);
          case $flutter_16.ObjectDisposed _: return $flutter_12.ObjectFlagProperty<$flutter_16.ObjectDisposed>.has(name, value, level: level);
          case $flutter_16.FlutterMemoryAllocations _: return $flutter_12.ObjectFlagProperty<$flutter_16.FlutterMemoryAllocations>.has(name, value, level: level);
          case $flutter_18.ObserverList _: return $flutter_12.ObjectFlagProperty<$flutter_18.ObserverList>.has(name, value, level: level);
          case $flutter_18.HashedObserverList _: return $flutter_12.ObjectFlagProperty<$flutter_18.HashedObserverList>.has(name, value, level: level);
          case $flutter_19.PersistentHashMap _: return $flutter_12.ObjectFlagProperty<$flutter_19.PersistentHashMap>.has(name, value, level: level);
          case $flutter_22.WriteBuffer _: return $flutter_12.ObjectFlagProperty<$flutter_22.WriteBuffer>.has(name, value, level: level);
          case $flutter_22.ReadBuffer _: return $flutter_12.ObjectFlagProperty<$flutter_22.ReadBuffer>.has(name, value, level: level);
          case $flutter_25.SynchronousFuture _: return $flutter_12.ObjectFlagProperty<$flutter_25.SynchronousFuture>.has(name, value, level: level);
          case $flutter_26.FlutterTimeline _: return $flutter_12.ObjectFlagProperty<$flutter_26.FlutterTimeline>.has(name, value, level: level);
          case $flutter_26.TimedBlock _: return $flutter_12.ObjectFlagProperty<$flutter_26.TimedBlock>.has(name, value, level: level);
          case $flutter_26.AggregatedTimings _: return $flutter_12.ObjectFlagProperty<$flutter_26.AggregatedTimings>.has(name, value, level: level);
          case $flutter_26.AggregatedTimedBlock _: return $flutter_12.ObjectFlagProperty<$flutter_26.AggregatedTimedBlock>.has(name, value, level: level);
          case $flutter_27.Unicode _: return $flutter_12.ObjectFlagProperty<$flutter_27.Unicode>.has(name, value, level: level);
          case $meta_1.Immutable _: return $flutter_12.ObjectFlagProperty<$meta_1.Immutable>.has(name, value, level: level);
          default: return $flutter_12.ObjectFlagProperty.has(name, value, level: level);
        }
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').isInteresting,
      'ifPresent': (visitor, target) => D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty').ifPresent,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'ObjectFlagProperty(String name, T? value, {String? ifPresent, String? ifNull, bool showName = false, DiagnosticLevel level = DiagnosticLevel.info})',
      'has': 'ObjectFlagProperty.has(String name, T? value, {DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'T get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
      'ifPresent': 'String? get ifPresent',
    },
  );
}

// =============================================================================
// FlagsSummary Bridge
// =============================================================================

BridgedClass _createFlagsSummaryBridge() {
  return BridgedClass(
    nativeType: $flutter_12.FlagsSummary,
    name: 'FlagsSummary',
    isAssignable: (v) => v is $flutter_12.FlagsSummary,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FlagsSummary');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'FlagsSummary');
        if (positional.length <= 1) {
          throw ArgumentError('FlagsSummary: Missing required argument "value" at position 1');
        }
        final value = D4.coerceMap<String, dynamic>(positional[1], 'value');
        final ifEmpty = D4.getOptionalNamedArg<String?>(named, 'ifEmpty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        return $flutter_12.FlagsSummary(name, value, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, level: level);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.FlagsSummary>(target, 'FlagsSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'FlagsSummary(String name, Map<String, T?> value, {String? ifEmpty, bool showName = true, bool showSeparator = true, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'Map<String, T?> get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
    },
  );
}

// =============================================================================
// DiagnosticsProperty Bridge
// =============================================================================

BridgedClass _createDiagnosticsPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticsProperty,
    name: 'DiagnosticsProperty',
    isAssignable: (v) => v is $flutter_12.DiagnosticsProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DiagnosticsProperty');
        final name = D4.getRequiredArg<String?>(positional, 0, 'name', 'DiagnosticsProperty');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'DiagnosticsProperty');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final ifEmpty = D4.getOptionalNamedArg<String?>(named, 'ifEmpty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final missingIfNull = D4.getNamedArgWithDefault<bool>(named, 'missingIfNull', false);
        final linePrefix = D4.getOptionalNamedArg<String?>(named, 'linePrefix');
        final expandableValue = D4.getNamedArgWithDefault<bool>(named, 'expandableValue', false);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        final allowNameWrap = D4.getNamedArgWithDefault<bool>(named, 'allowNameWrap', true);
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.DiagnosticsProperty(name, value, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, linePrefix: linePrefix, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DiagnosticsProperty');
          return $flutter_12.DiagnosticsProperty(name, value, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, linePrefix: linePrefix, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'lazy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DiagnosticsProperty');
        final name = D4.getRequiredArg<String?>(positional, 0, 'name', 'DiagnosticsProperty');
        if (positional.length <= 1) {
          throw ArgumentError('DiagnosticsProperty: Missing required argument "computeValue" at position 1');
        }
        final computeValueRaw = positional[1];
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final ifEmpty = D4.getOptionalNamedArg<String?>(named, 'ifEmpty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final missingIfNull = D4.getNamedArgWithDefault<bool>(named, 'missingIfNull', false);
        final expandableValue = D4.getNamedArgWithDefault<bool>(named, 'expandableValue', false);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        final allowNameWrap = D4.getNamedArgWithDefault<bool>(named, 'allowNameWrap', true);
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_12.DiagnosticsProperty.lazy(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, computeValueRaw, [])); }, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DiagnosticsProperty');
          return $flutter_12.DiagnosticsProperty.lazy(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, computeValueRaw, [])); }, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'DiagnosticsProperty(String? name, T? value, {String? description, String? ifNull, String? ifEmpty, bool showName = true, bool showSeparator = true, Object? defaultValue = kNoDefaultValue, String? tooltip, bool missingIfNull = false, String? linePrefix, bool expandableValue = false, bool allowWrap = true, bool allowNameWrap = true, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
      'lazy': 'DiagnosticsProperty.lazy(String? name, ComputePropertyValueCallback<T> computeValue, {String? description, String? ifNull, String? ifEmpty, bool showName = true, bool showSeparator = true, Object? defaultValue = kNoDefaultValue, String? tooltip, bool missingIfNull = false, bool expandableValue = false, bool allowWrap = true, bool allowNameWrap = true, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'T? get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
    },
  );
}

// =============================================================================
// DiagnosticableNode Bridge
// =============================================================================

BridgedClass _createDiagnosticableNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticableNode,
    name: 'DiagnosticableNode',
    isAssignable: (v) => v is $flutter_12.DiagnosticableNode,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final value = D4.getRequiredNamedArg<$flutter_12.Diagnosticable>(named, 'value', 'DiagnosticableNode');
        final style = D4.getRequiredNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style', 'DiagnosticableNode');
        return $flutter_12.DiagnosticableNode(name: name, value: value, style: style);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').textTreeConfiguration,
      'builder': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode').builder,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableNode>(target, 'DiagnosticableNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'DiagnosticableNode({String? name, required T value, required DiagnosticsTreeStyle? style})',
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
      'value': 'T get value',
      'style': 'DiagnosticsTreeStyle get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'builder': 'DiagnosticPropertiesBuilder? get builder',
    },
  );
}

// =============================================================================
// DiagnosticableTreeNode Bridge
// =============================================================================

BridgedClass _createDiagnosticableTreeNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticableTreeNode,
    name: 'DiagnosticableTreeNode',
    isAssignable: (v) => v is $flutter_12.DiagnosticableTreeNode,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final value = D4.getRequiredNamedArg<$flutter_12.DiagnosticableTree>(named, 'value', 'DiagnosticableTreeNode');
        final style = D4.getRequiredNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style', 'DiagnosticableTreeNode');
        return $flutter_12.DiagnosticableTreeNode(name: name, value: value, style: style);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').textTreeConfiguration,
      'builder': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').builder,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'DiagnosticableTreeNode({String? name, required DiagnosticableTree value, required DiagnosticsTreeStyle? style})',
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
      'value': 'DiagnosticableTree get value',
      'style': 'DiagnosticsTreeStyle get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'builder': 'DiagnosticPropertiesBuilder? get builder',
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
    isAssignable: (v) => v is $flutter_12.DiagnosticPropertiesBuilder,
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
        D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = D4.extractBridgedArg<$flutter_12.DiagnosticsTreeStyle>(value, 'defaultDiagnosticsTreeStyle'),
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = D4.extractBridgedArgOrNull<String>(value, 'emptyBodyDescription'),
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
// Diagnosticable Bridge
// =============================================================================

BridgedClass _createDiagnosticableBridge() {
  return BridgedClass(
    nativeType: $flutter_12.Diagnosticable,
    name: 'Diagnosticable',
    isAssignable: (v) => v is $flutter_12.Diagnosticable,
    constructors: {
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.Diagnosticable>(target, 'Diagnosticable');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.Diagnosticable>(target, 'Diagnosticable');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.Diagnosticable>(target, 'Diagnosticable');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.Diagnosticable>(target, 'Diagnosticable');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
  );
}

// =============================================================================
// DiagnosticableTree Bridge
// =============================================================================

BridgedClass _createDiagnosticableTreeBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticableTree,
    name: 'DiagnosticableTree',
    isAssignable: (v) => v is $flutter_12.DiagnosticableTree,
    constructors: {
    },
    methods: {
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTree>(target, 'DiagnosticableTree');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    methodSignatures: {
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
  );
}

// =============================================================================
// DiagnosticableTreeMixin Bridge
// =============================================================================

BridgedClass _createDiagnosticableTreeMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticableTreeMixin,
    name: 'DiagnosticableTreeMixin',
    isAssignable: (v) => v is $flutter_12.DiagnosticableTreeMixin,
    constructors: {
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_12.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        return t.debugDescribeChildren();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    methodSignatures: {
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
  );
}

// =============================================================================
// DiagnosticsBlock Bridge
// =============================================================================

BridgedClass _createDiagnosticsBlockBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticsBlock,
    name: 'DiagnosticsBlock',
    isAssignable: (v) => v is $flutter_12.DiagnosticsBlock,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getNamedArgWithDefault<$flutter_12.DiagnosticsTreeStyle>(named, 'style', $flutter_12.DiagnosticsTreeStyle.whitespace);
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final linePrefix = D4.getOptionalNamedArg<String?>(named, 'linePrefix');
        final value = D4.getOptionalNamedArg<Object?>(named, 'value');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final level = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'level', $flutter_12.DiagnosticLevel.info);
        final allowTruncate = D4.getNamedArgWithDefault<bool>(named, 'allowTruncate', false);
        final children = named.containsKey('children') && named['children'] != null
            ? D4.coerceList<$flutter_12.DiagnosticsNode>(named['children'], 'children')
            : const <$flutter_12.DiagnosticsNode>[];
        final properties = named.containsKey('properties') && named['properties'] != null
            ? D4.coerceList<$flutter_12.DiagnosticsNode>(named['properties'], 'properties')
            : const <$flutter_12.DiagnosticsNode>[];
        return $flutter_12.DiagnosticsBlock(name: name, style: style, showName: showName, showSeparator: showSeparator, linePrefix: linePrefix, value: value, description: description, level: level, allowTruncate: allowTruncate, children: children, properties: properties);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock').textTreeConfiguration,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsBlock>(target, 'DiagnosticsBlock');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_12.DiagnosticLevel>(named, 'minLevel', $flutter_12.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'DiagnosticsBlock({String? name, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.whitespace, bool showName = true, bool showSeparator = true, String? linePrefix, Object? value, String? description, DiagnosticLevel level = DiagnosticLevel.info, bool allowTruncate = false, List<DiagnosticsNode> children = const <DiagnosticsNode>[], List<DiagnosticsNode> properties = const <DiagnosticsNode>[]})',
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// DiagnosticsSerializationDelegate Bridge
// =============================================================================

BridgedClass _createDiagnosticsSerializationDelegateBridge() {
  return BridgedClass(
    nativeType: $flutter_12.DiagnosticsSerializationDelegate,
    name: 'DiagnosticsSerializationDelegate',
    isAssignable: (v) => v is $flutter_12.DiagnosticsSerializationDelegate,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('subtreeDepth') && !named.containsKey('includeProperties')) {
          return $flutter_12.DiagnosticsSerializationDelegate();
        }
        if (named.containsKey('subtreeDepth') && !named.containsKey('includeProperties')) {
          final subtreeDepth = D4.getRequiredNamedArg<int>(named, 'subtreeDepth', 'DiagnosticsSerializationDelegate');
          return $flutter_12.DiagnosticsSerializationDelegate(subtreeDepth: subtreeDepth);
        }
        if (!named.containsKey('subtreeDepth') && named.containsKey('includeProperties')) {
          final includeProperties = D4.getRequiredNamedArg<bool>(named, 'includeProperties', 'DiagnosticsSerializationDelegate');
          return $flutter_12.DiagnosticsSerializationDelegate(includeProperties: includeProperties);
        }
        if (named.containsKey('subtreeDepth') && named.containsKey('includeProperties')) {
          final subtreeDepth = D4.getRequiredNamedArg<int>(named, 'subtreeDepth', 'DiagnosticsSerializationDelegate');
          final includeProperties = D4.getRequiredNamedArg<bool>(named, 'includeProperties', 'DiagnosticsSerializationDelegate');
          return $flutter_12.DiagnosticsSerializationDelegate(subtreeDepth: subtreeDepth, includeProperties: includeProperties);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'subtreeDepth': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate').subtreeDepth,
      'includeProperties': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate').includeProperties,
      'expandPropertyValues': (visitor, target) => D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate').expandPropertyValues,
    },
    methods: {
      'additionalNodeProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 1, 'additionalNodeProperties');
        final node = D4.getRequiredArg<$flutter_12.DiagnosticsNode>(positional, 0, 'node', 'additionalNodeProperties');
        final fullDetails = D4.getNamedArgWithDefault<bool>(named, 'fullDetails', true);
        return t.additionalNodeProperties(node, fullDetails: fullDetails);
      },
      'filterChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 2, 'filterChildren');
        if (positional.isEmpty) {
          throw ArgumentError('filterChildren: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceList<$flutter_12.DiagnosticsNode>(positional[0], 'nodes');
        final owner = D4.getRequiredArg<$flutter_12.DiagnosticsNode>(positional, 1, 'owner', 'filterChildren');
        return t.filterChildren(nodes, owner);
      },
      'filterProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 2, 'filterProperties');
        if (positional.isEmpty) {
          throw ArgumentError('filterProperties: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceList<$flutter_12.DiagnosticsNode>(positional[0], 'nodes');
        final owner = D4.getRequiredArg<$flutter_12.DiagnosticsNode>(positional, 1, 'owner', 'filterProperties');
        return t.filterProperties(nodes, owner);
      },
      'truncateNodesList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 2, 'truncateNodesList');
        if (positional.isEmpty) {
          throw ArgumentError('truncateNodesList: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceList<$flutter_12.DiagnosticsNode>(positional[0], 'nodes');
        final owner = D4.getRequiredArg<$flutter_12.DiagnosticsNode?>(positional, 1, 'owner', 'truncateNodesList');
        return t.truncateNodesList(nodes, owner);
      },
      'delegateForNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 1, 'delegateForNode');
        final node = D4.getRequiredArg<$flutter_12.DiagnosticsNode>(positional, 0, 'node', 'delegateForNode');
        return t.delegateForNode(node);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        if (!named.containsKey('subtreeDepth') && !named.containsKey('includeProperties')) {
          return t.copyWith();
        }
        if (named.containsKey('subtreeDepth') && !named.containsKey('includeProperties')) {
          final subtreeDepth = D4.getRequiredNamedArg<int>(named, 'subtreeDepth', 'copyWith');
          return t.copyWith(subtreeDepth: subtreeDepth);
        }
        if (!named.containsKey('subtreeDepth') && named.containsKey('includeProperties')) {
          final includeProperties = D4.getRequiredNamedArg<bool>(named, 'includeProperties', 'copyWith');
          return t.copyWith(includeProperties: includeProperties);
        }
        if (named.containsKey('subtreeDepth') && named.containsKey('includeProperties')) {
          final subtreeDepth = D4.getRequiredNamedArg<int>(named, 'subtreeDepth', 'copyWith');
          final includeProperties = D4.getRequiredNamedArg<bool>(named, 'includeProperties', 'copyWith');
          return t.copyWith(subtreeDepth: subtreeDepth, includeProperties: includeProperties);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    constructorSignatures: {
      '': 'const factory DiagnosticsSerializationDelegate({int subtreeDepth, bool includeProperties})',
    },
    methodSignatures: {
      'additionalNodeProperties': 'Map<String, Object?> additionalNodeProperties(DiagnosticsNode node, {bool fullDetails = true})',
      'filterChildren': 'List<DiagnosticsNode> filterChildren(List<DiagnosticsNode> nodes, DiagnosticsNode owner)',
      'filterProperties': 'List<DiagnosticsNode> filterProperties(List<DiagnosticsNode> nodes, DiagnosticsNode owner)',
      'truncateNodesList': 'List<DiagnosticsNode> truncateNodesList(List<DiagnosticsNode> nodes, DiagnosticsNode? owner)',
      'delegateForNode': 'DiagnosticsSerializationDelegate delegateForNode(DiagnosticsNode node)',
      'copyWith': 'DiagnosticsSerializationDelegate copyWith({int subtreeDepth, bool includeProperties})',
    },
    getterSignatures: {
      'subtreeDepth': 'int get subtreeDepth',
      'includeProperties': 'bool get includeProperties',
      'expandPropertyValues': 'bool get expandPropertyValues',
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
    isAssignable: (v) => v is $flutter_24.StackFrame,
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
    isAssignable: (v) => v is $flutter_2.PartialStackFrame,
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
    isAssignable: (v) => v is $flutter_2.StackFilter,
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
    isAssignable: (v) => v is $flutter_2.RepetitiveStackFrameFilter,
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
    isAssignable: (v) => v is $flutter_2.ErrorDescription,
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
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.ErrorDescription>(target, 'ErrorDescription').textTreeConfiguration,
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
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
    isAssignable: (v) => v is $flutter_2.ErrorSummary,
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
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSummary>(target, 'ErrorSummary').textTreeConfiguration,
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
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
    isAssignable: (v) => v is $flutter_2.ErrorHint,
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
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.ErrorHint>(target, 'ErrorHint').textTreeConfiguration,
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
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
    isAssignable: (v) => v is $flutter_2.ErrorSpacer,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_2.ErrorSpacer();
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').propertyType,
      'exception': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_12.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
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
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_12.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
    },
    constructorSignatures: {
      '': 'ErrorSpacer()',
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
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'void get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
      'expandableValue': 'bool get expandableValue',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
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
    isAssignable: (v) => v is $flutter_2.FlutterErrorDetails,
    constructors: {
      '': (visitor, positional, named) {
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'FlutterErrorDetails');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final library = D4.getNamedArgWithDefault<String?>(named, 'library', 'Flutter framework');
        final context = D4.getOptionalNamedArg<$flutter_12.DiagnosticsNode?>(named, 'context');
        final stackFilterRaw = named['stackFilter'];
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        return $flutter_2.FlutterErrorDetails(exception: exception, stack: stack, library: library, context: context, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; }, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, informationCollectorRaw, []) as Iterable<$flutter_12.DiagnosticsNode>; }, silent: silent);
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
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, informationCollectorRaw, []) as Iterable<$flutter_12.DiagnosticsNode>; }, library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; });
      },
      'exceptionAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        return t.exceptionAsString();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
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
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    isAssignable: (v) => v is $flutter_2.FlutterError,
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
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FlutterError>(target, 'FlutterError');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
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
        if (positional.isEmpty) {
          throw ArgumentError('defaultStackFilter: Missing required argument "frames" at position 0');
        }
        final frames = D4.coerceList<String>(positional[0], 'frames');
        return $flutter_2.FlutterError.defaultStackFilter(frames);
      },
      'reportError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'reportError');
        final details = D4.getRequiredArg<$flutter_2.FlutterErrorDetails>(positional, 0, 'details', 'reportError');
        return $flutter_2.FlutterError.reportError(details);
      },
    },
    staticSetters: {
      'onError': (visitor, value) {
        final onErrorRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onError');
        $flutter_2.FlutterError.onError = onErrorRaw == null ? null : ($flutter_2.FlutterErrorDetails p0) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0]); };
      },
      'demangleStackTrace': (visitor, value) {
        final demangleStackTraceRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'demangleStackTrace');
        $flutter_2.FlutterError.demangleStackTrace = (StackTrace p0) { return D4.callInterpreterCallback(visitor!, demangleStackTraceRaw, [p0]) as StackTrace; };
      },
      'presentError': (visitor, value) {
        final presentErrorRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'presentError');
        $flutter_2.FlutterError.presentError = ($flutter_2.FlutterErrorDetails p0) { D4.callInterpreterCallback(visitor!, presentErrorRaw, [p0]); };
      },
    },
    constructorSignatures: {
      '': 'factory FlutterError(String message)',
      'fromParts': 'FlutterError.fromParts(List<DiagnosticsNode> diagnostics)',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
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
    isAssignable: (v) => v is $flutter_2.DiagnosticsStackTrace,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DiagnosticsStackTrace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DiagnosticsStackTrace');
        final stack = D4.getRequiredArg<StackTrace?>(positional, 1, 'stack', 'DiagnosticsStackTrace');
        final stackFilterRaw = named['stackFilter'];
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        return $flutter_2.DiagnosticsStackTrace(name, stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; }, showSeparator: showSeparator);
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
      'name': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').textTreeConfiguration,
    },
    methods: {
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
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.getChildren();
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
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
    isAssignable: (v) => v is $flutter_4.BindingBase,
    constructors: {
    },
    getters: {
      'window': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').locked,
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        t.initInstances();
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents(() { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        (t as dynamic).unlocked();
        return null;
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        return t.reassembleApplication();
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: () { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerBoolServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerBoolServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerBoolServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerBoolServiceExtension(name: name, getter: () { return D4.callInterpreterCallback(visitor!, getterRaw, []) as Future<bool>; }, setter: (bool p0) { return D4.callInterpreterCallback(visitor!, setterRaw, [p0]) as Future<void>; });
        return null;
      },
      'registerNumericServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerNumericServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerNumericServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerNumericServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerNumericServiceExtension(name: name, getter: () { return D4.callInterpreterCallback(visitor!, getterRaw, []) as Future<double>; }, setter: (double p0) { return D4.callInterpreterCallback(visitor!, setterRaw, [p0]) as Future<void>; });
        return null;
      },
      'postEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 2, 'postEvent');
        final eventKind = D4.getRequiredArg<String>(positional, 0, 'eventKind', 'postEvent');
        if (positional.length <= 1) {
          throw ArgumentError('postEvent: Missing required argument "eventData" at position 1');
        }
        final eventData = D4.coerceMap<String, dynamic>(positional[1], 'eventData');
        t.postEvent(eventKind, eventData);
        return null;
      },
      'registerStringServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerStringServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerStringServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerStringServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerStringServiceExtension(name: name, getter: () { return D4.callInterpreterCallback(visitor!, getterRaw, []) as Future<String>; }, setter: (String p0) { return D4.callInterpreterCallback(visitor!, setterRaw, [p0]) as Future<void>; });
        return null;
      },
      'registerServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: (Map<String, String> p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<Map<String, dynamic>>; });
        return null;
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
      'checkInstance': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'checkInstance');
        final instance = D4.getRequiredArg<$flutter_4.BindingBase?>(positional, 0, 'instance', 'checkInstance');
        return $flutter_4.BindingBase.checkInstance(instance);
      },
      'debugBindingType': (visitor, positional, named, typeArgs) {
        return $flutter_4.BindingBase.debugBindingType();
      },
    },
    staticSetters: {
      'debugZoneErrorsAreFatal': (visitor, value) => 
        $flutter_4.BindingBase.debugZoneErrorsAreFatal = D4.extractBridgedArg<bool>(value, 'debugZoneErrorsAreFatal'),
    },
    methodSignatures: {
      'initInstances': 'void initInstances()',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'initServiceExtensions': 'void initServiceExtensions()',
      'lockEvents': 'Future<void> lockEvents(Future<void> Function() callback)',
      'unlocked': 'void unlocked()',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'performReassemble': 'Future<void> performReassemble()',
      'registerSignalServiceExtension': 'void registerSignalServiceExtension({required String name, required AsyncCallback callback})',
      'registerBoolServiceExtension': 'void registerBoolServiceExtension({required String name, required AsyncValueGetter<bool> getter, required AsyncValueSetter<bool> setter})',
      'registerNumericServiceExtension': 'void registerNumericServiceExtension({required String name, required AsyncValueGetter<double> getter, required AsyncValueSetter<double> setter})',
      'postEvent': 'void postEvent(String eventKind, Map<String, dynamic> eventData)',
      'registerStringServiceExtension': 'void registerStringServiceExtension({required String name, required AsyncValueGetter<String> getter, required AsyncValueSetter<String> setter})',
      'registerServiceExtension': 'void registerServiceExtension({required String name, required ServiceExtensionCallback callback})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'window': 'ui.SingletonFlutterWindow get window',
      'platformDispatcher': 'ui.PlatformDispatcher get platformDispatcher',
      'locked': 'bool get locked',
    },
    staticMethodSignatures: {
      'checkInstance': 'T checkInstance(T? instance)',
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
    isAssignable: (v) => v is $flutter_5.BitField,
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
    isAssignable: (v) => v is $flutter_7.Listenable,
    constructors: {
      'merge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Listenable');
        if (positional.isEmpty) {
          throw ArgumentError('Listenable: Missing required argument "listenables" at position 0');
        }
        final listenables = D4.coerceList<$flutter_7.Listenable?>(positional[0], 'listenables');
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Listenable>(target, 'Listenable');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
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
    isAssignable: (v) => v is $flutter_7.ValueListenable,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueListenable>(target, 'ValueListenable');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
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
    isAssignable: (v) => v is $flutter_7.ChangeNotifier,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_7.ChangeNotifier();
      },
    },
    getters: {
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier').hasListeners,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
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
      'maybeDispatchObjectCreation': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'maybeDispatchObjectCreation');
        final object = D4.getRequiredArg<$flutter_7.ChangeNotifier>(positional, 0, 'object', 'maybeDispatchObjectCreation');
        return $flutter_7.ChangeNotifier.maybeDispatchObjectCreation(object);
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
    getterSignatures: {
      'hasListeners': 'bool get hasListeners',
    },
    staticMethodSignatures: {
      'debugAssertNotDisposed': 'bool debugAssertNotDisposed(ChangeNotifier notifier)',
      'maybeDispatchObjectCreation': 'void maybeDispatchObjectCreation(ChangeNotifier object)',
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
    isAssignable: (v) => v is $flutter_7.ValueNotifier,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueNotifier');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'ValueNotifier');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_7.ValueNotifier<double>(value);
          case int _: return $flutter_7.ValueNotifier<int>(value);
          case String _: return $flutter_7.ValueNotifier<String>(value);
          case bool _: return $flutter_7.ValueNotifier<bool>(value);
          case $flutter_1.Category _: return $flutter_7.ValueNotifier<$flutter_1.Category>(value);
          case $flutter_1.DocumentationIcon _: return $flutter_7.ValueNotifier<$flutter_1.DocumentationIcon>(value);
          case $flutter_1.Summary _: return $flutter_7.ValueNotifier<$flutter_1.Summary>(value);
          case $flutter_3.CachingIterable _: return $flutter_7.ValueNotifier<$flutter_3.CachingIterable>(value);
          case $flutter_3.Factory _: return $flutter_7.ValueNotifier<$flutter_3.Factory>(value);
          case $flutter_12.TextTreeConfiguration _: return $flutter_7.ValueNotifier<$flutter_12.TextTreeConfiguration>(value);
          case $flutter_12.TextTreeRenderer _: return $flutter_7.ValueNotifier<$flutter_12.TextTreeRenderer>(value);
          case $flutter_12.DiagnosticsNode _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticsNode>(value);
          case $flutter_12.MessageProperty _: return $flutter_7.ValueNotifier<$flutter_12.MessageProperty>(value);
          case $flutter_12.StringProperty _: return $flutter_7.ValueNotifier<$flutter_12.StringProperty>(value);
          case $flutter_12.DoubleProperty _: return $flutter_7.ValueNotifier<$flutter_12.DoubleProperty>(value);
          case $flutter_12.IntProperty _: return $flutter_7.ValueNotifier<$flutter_12.IntProperty>(value);
          case $flutter_12.PercentProperty _: return $flutter_7.ValueNotifier<$flutter_12.PercentProperty>(value);
          case $flutter_12.FlagProperty _: return $flutter_7.ValueNotifier<$flutter_12.FlagProperty>(value);
          case $flutter_12.IterableProperty _: return $flutter_7.ValueNotifier<$flutter_12.IterableProperty>(value);
          case $flutter_12.EnumProperty _: return $flutter_7.ValueNotifier<$flutter_12.EnumProperty>(value);
          case $flutter_12.ObjectFlagProperty _: return $flutter_7.ValueNotifier<$flutter_12.ObjectFlagProperty>(value);
          case $flutter_12.FlagsSummary _: return $flutter_7.ValueNotifier<$flutter_12.FlagsSummary>(value);
          case $flutter_12.DiagnosticsProperty _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticsProperty>(value);
          case $flutter_12.DiagnosticableNode _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticableNode>(value);
          case $flutter_12.DiagnosticableTreeNode _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticableTreeNode>(value);
          case $flutter_12.DiagnosticPropertiesBuilder _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticPropertiesBuilder>(value);
          case $flutter_12.Diagnosticable _: return $flutter_7.ValueNotifier<$flutter_12.Diagnosticable>(value);
          case $flutter_12.DiagnosticableTree _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticableTree>(value);
          case $flutter_12.DiagnosticableTreeMixin _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticableTreeMixin>(value);
          case $flutter_12.DiagnosticsBlock _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticsBlock>(value);
          case $flutter_12.DiagnosticsSerializationDelegate _: return $flutter_7.ValueNotifier<$flutter_12.DiagnosticsSerializationDelegate>(value);
          case $flutter_24.StackFrame _: return $flutter_7.ValueNotifier<$flutter_24.StackFrame>(value);
          case $flutter_2.PartialStackFrame _: return $flutter_7.ValueNotifier<$flutter_2.PartialStackFrame>(value);
          case $flutter_2.StackFilter _: return $flutter_7.ValueNotifier<$flutter_2.StackFilter>(value);
          case $flutter_2.RepetitiveStackFrameFilter _: return $flutter_7.ValueNotifier<$flutter_2.RepetitiveStackFrameFilter>(value);
          case $flutter_2.ErrorDescription _: return $flutter_7.ValueNotifier<$flutter_2.ErrorDescription>(value);
          case $flutter_2.ErrorSummary _: return $flutter_7.ValueNotifier<$flutter_2.ErrorSummary>(value);
          case $flutter_2.ErrorHint _: return $flutter_7.ValueNotifier<$flutter_2.ErrorHint>(value);
          case $flutter_2.ErrorSpacer _: return $flutter_7.ValueNotifier<$flutter_2.ErrorSpacer>(value);
          case $flutter_2.FlutterErrorDetails _: return $flutter_7.ValueNotifier<$flutter_2.FlutterErrorDetails>(value);
          case $flutter_2.FlutterError _: return $flutter_7.ValueNotifier<$flutter_2.FlutterError>(value);
          case $flutter_2.DiagnosticsStackTrace _: return $flutter_7.ValueNotifier<$flutter_2.DiagnosticsStackTrace>(value);
          case $flutter_4.BindingBase _: return $flutter_7.ValueNotifier<$flutter_4.BindingBase>(value);
          case $flutter_5.BitField _: return $flutter_7.ValueNotifier<$flutter_5.BitField>(value);
          case $flutter_7.Listenable _: return $flutter_7.ValueNotifier<$flutter_7.Listenable>(value);
          case $flutter_7.ValueListenable _: return $flutter_7.ValueNotifier<$flutter_7.ValueListenable>(value);
          case $flutter_7.ChangeNotifier _: return $flutter_7.ValueNotifier<$flutter_7.ChangeNotifier>(value);
          case $flutter_14.Key _: return $flutter_7.ValueNotifier<$flutter_14.Key>(value);
          case $flutter_14.LocalKey _: return $flutter_7.ValueNotifier<$flutter_14.LocalKey>(value);
          case $flutter_14.UniqueKey _: return $flutter_7.ValueNotifier<$flutter_14.UniqueKey>(value);
          case $flutter_14.ValueKey _: return $flutter_7.ValueNotifier<$flutter_14.ValueKey>(value);
          case $flutter_15.LicenseParagraph _: return $flutter_7.ValueNotifier<$flutter_15.LicenseParagraph>(value);
          case $flutter_15.LicenseEntry _: return $flutter_7.ValueNotifier<$flutter_15.LicenseEntry>(value);
          case $flutter_15.LicenseEntryWithLineBreaks _: return $flutter_7.ValueNotifier<$flutter_15.LicenseEntryWithLineBreaks>(value);
          case $flutter_15.LicenseRegistry _: return $flutter_7.ValueNotifier<$flutter_15.LicenseRegistry>(value);
          case $flutter_16.ObjectEvent _: return $flutter_7.ValueNotifier<$flutter_16.ObjectEvent>(value);
          case $flutter_16.ObjectCreated _: return $flutter_7.ValueNotifier<$flutter_16.ObjectCreated>(value);
          case $flutter_16.ObjectDisposed _: return $flutter_7.ValueNotifier<$flutter_16.ObjectDisposed>(value);
          case $flutter_16.FlutterMemoryAllocations _: return $flutter_7.ValueNotifier<$flutter_16.FlutterMemoryAllocations>(value);
          case $flutter_18.ObserverList _: return $flutter_7.ValueNotifier<$flutter_18.ObserverList>(value);
          case $flutter_18.HashedObserverList _: return $flutter_7.ValueNotifier<$flutter_18.HashedObserverList>(value);
          case $flutter_19.PersistentHashMap _: return $flutter_7.ValueNotifier<$flutter_19.PersistentHashMap>(value);
          case $flutter_22.WriteBuffer _: return $flutter_7.ValueNotifier<$flutter_22.WriteBuffer>(value);
          case $flutter_22.ReadBuffer _: return $flutter_7.ValueNotifier<$flutter_22.ReadBuffer>(value);
          case $flutter_25.SynchronousFuture _: return $flutter_7.ValueNotifier<$flutter_25.SynchronousFuture>(value);
          case $flutter_26.FlutterTimeline _: return $flutter_7.ValueNotifier<$flutter_26.FlutterTimeline>(value);
          case $flutter_26.TimedBlock _: return $flutter_7.ValueNotifier<$flutter_26.TimedBlock>(value);
          case $flutter_26.AggregatedTimings _: return $flutter_7.ValueNotifier<$flutter_26.AggregatedTimings>(value);
          case $flutter_26.AggregatedTimedBlock _: return $flutter_7.ValueNotifier<$flutter_26.AggregatedTimedBlock>(value);
          case $flutter_27.Unicode _: return $flutter_7.ValueNotifier<$flutter_27.Unicode>(value);
          case $meta_1.Immutable _: return $flutter_7.ValueNotifier<$meta_1.Immutable>(value);
          default: return $flutter_7.ValueNotifier(value);
        }
      },
    },
    getters: {
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier').hasListeners,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
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
      'hasListeners': 'bool get hasListeners',
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
    isAssignable: (v) => v is $flutter_14.Key,
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
    isAssignable: (v) => v is $flutter_14.LocalKey,
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
    isAssignable: (v) => v is $flutter_14.UniqueKey,
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
    isAssignable: (v) => v is $flutter_14.ValueKey,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueKey');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'ValueKey');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_14.ValueKey<double>(value);
          case int _: return $flutter_14.ValueKey<int>(value);
          case String _: return $flutter_14.ValueKey<String>(value);
          case bool _: return $flutter_14.ValueKey<bool>(value);
          case $flutter_1.Category _: return $flutter_14.ValueKey<$flutter_1.Category>(value);
          case $flutter_1.DocumentationIcon _: return $flutter_14.ValueKey<$flutter_1.DocumentationIcon>(value);
          case $flutter_1.Summary _: return $flutter_14.ValueKey<$flutter_1.Summary>(value);
          case $flutter_3.CachingIterable _: return $flutter_14.ValueKey<$flutter_3.CachingIterable>(value);
          case $flutter_3.Factory _: return $flutter_14.ValueKey<$flutter_3.Factory>(value);
          case $flutter_12.TextTreeConfiguration _: return $flutter_14.ValueKey<$flutter_12.TextTreeConfiguration>(value);
          case $flutter_12.TextTreeRenderer _: return $flutter_14.ValueKey<$flutter_12.TextTreeRenderer>(value);
          case $flutter_12.DiagnosticsNode _: return $flutter_14.ValueKey<$flutter_12.DiagnosticsNode>(value);
          case $flutter_12.MessageProperty _: return $flutter_14.ValueKey<$flutter_12.MessageProperty>(value);
          case $flutter_12.StringProperty _: return $flutter_14.ValueKey<$flutter_12.StringProperty>(value);
          case $flutter_12.DoubleProperty _: return $flutter_14.ValueKey<$flutter_12.DoubleProperty>(value);
          case $flutter_12.IntProperty _: return $flutter_14.ValueKey<$flutter_12.IntProperty>(value);
          case $flutter_12.PercentProperty _: return $flutter_14.ValueKey<$flutter_12.PercentProperty>(value);
          case $flutter_12.FlagProperty _: return $flutter_14.ValueKey<$flutter_12.FlagProperty>(value);
          case $flutter_12.IterableProperty _: return $flutter_14.ValueKey<$flutter_12.IterableProperty>(value);
          case $flutter_12.EnumProperty _: return $flutter_14.ValueKey<$flutter_12.EnumProperty>(value);
          case $flutter_12.ObjectFlagProperty _: return $flutter_14.ValueKey<$flutter_12.ObjectFlagProperty>(value);
          case $flutter_12.FlagsSummary _: return $flutter_14.ValueKey<$flutter_12.FlagsSummary>(value);
          case $flutter_12.DiagnosticsProperty _: return $flutter_14.ValueKey<$flutter_12.DiagnosticsProperty>(value);
          case $flutter_12.DiagnosticableNode _: return $flutter_14.ValueKey<$flutter_12.DiagnosticableNode>(value);
          case $flutter_12.DiagnosticableTreeNode _: return $flutter_14.ValueKey<$flutter_12.DiagnosticableTreeNode>(value);
          case $flutter_12.DiagnosticPropertiesBuilder _: return $flutter_14.ValueKey<$flutter_12.DiagnosticPropertiesBuilder>(value);
          case $flutter_12.Diagnosticable _: return $flutter_14.ValueKey<$flutter_12.Diagnosticable>(value);
          case $flutter_12.DiagnosticableTree _: return $flutter_14.ValueKey<$flutter_12.DiagnosticableTree>(value);
          case $flutter_12.DiagnosticableTreeMixin _: return $flutter_14.ValueKey<$flutter_12.DiagnosticableTreeMixin>(value);
          case $flutter_12.DiagnosticsBlock _: return $flutter_14.ValueKey<$flutter_12.DiagnosticsBlock>(value);
          case $flutter_12.DiagnosticsSerializationDelegate _: return $flutter_14.ValueKey<$flutter_12.DiagnosticsSerializationDelegate>(value);
          case $flutter_24.StackFrame _: return $flutter_14.ValueKey<$flutter_24.StackFrame>(value);
          case $flutter_2.PartialStackFrame _: return $flutter_14.ValueKey<$flutter_2.PartialStackFrame>(value);
          case $flutter_2.StackFilter _: return $flutter_14.ValueKey<$flutter_2.StackFilter>(value);
          case $flutter_2.RepetitiveStackFrameFilter _: return $flutter_14.ValueKey<$flutter_2.RepetitiveStackFrameFilter>(value);
          case $flutter_2.ErrorDescription _: return $flutter_14.ValueKey<$flutter_2.ErrorDescription>(value);
          case $flutter_2.ErrorSummary _: return $flutter_14.ValueKey<$flutter_2.ErrorSummary>(value);
          case $flutter_2.ErrorHint _: return $flutter_14.ValueKey<$flutter_2.ErrorHint>(value);
          case $flutter_2.ErrorSpacer _: return $flutter_14.ValueKey<$flutter_2.ErrorSpacer>(value);
          case $flutter_2.FlutterErrorDetails _: return $flutter_14.ValueKey<$flutter_2.FlutterErrorDetails>(value);
          case $flutter_2.FlutterError _: return $flutter_14.ValueKey<$flutter_2.FlutterError>(value);
          case $flutter_2.DiagnosticsStackTrace _: return $flutter_14.ValueKey<$flutter_2.DiagnosticsStackTrace>(value);
          case $flutter_4.BindingBase _: return $flutter_14.ValueKey<$flutter_4.BindingBase>(value);
          case $flutter_5.BitField _: return $flutter_14.ValueKey<$flutter_5.BitField>(value);
          case $flutter_7.Listenable _: return $flutter_14.ValueKey<$flutter_7.Listenable>(value);
          case $flutter_7.ValueListenable _: return $flutter_14.ValueKey<$flutter_7.ValueListenable>(value);
          case $flutter_7.ChangeNotifier _: return $flutter_14.ValueKey<$flutter_7.ChangeNotifier>(value);
          case $flutter_7.ValueNotifier _: return $flutter_14.ValueKey<$flutter_7.ValueNotifier>(value);
          case $flutter_14.Key _: return $flutter_14.ValueKey<$flutter_14.Key>(value);
          case $flutter_14.LocalKey _: return $flutter_14.ValueKey<$flutter_14.LocalKey>(value);
          case $flutter_14.UniqueKey _: return $flutter_14.ValueKey<$flutter_14.UniqueKey>(value);
          case $flutter_15.LicenseParagraph _: return $flutter_14.ValueKey<$flutter_15.LicenseParagraph>(value);
          case $flutter_15.LicenseEntry _: return $flutter_14.ValueKey<$flutter_15.LicenseEntry>(value);
          case $flutter_15.LicenseEntryWithLineBreaks _: return $flutter_14.ValueKey<$flutter_15.LicenseEntryWithLineBreaks>(value);
          case $flutter_15.LicenseRegistry _: return $flutter_14.ValueKey<$flutter_15.LicenseRegistry>(value);
          case $flutter_16.ObjectEvent _: return $flutter_14.ValueKey<$flutter_16.ObjectEvent>(value);
          case $flutter_16.ObjectCreated _: return $flutter_14.ValueKey<$flutter_16.ObjectCreated>(value);
          case $flutter_16.ObjectDisposed _: return $flutter_14.ValueKey<$flutter_16.ObjectDisposed>(value);
          case $flutter_16.FlutterMemoryAllocations _: return $flutter_14.ValueKey<$flutter_16.FlutterMemoryAllocations>(value);
          case $flutter_18.ObserverList _: return $flutter_14.ValueKey<$flutter_18.ObserverList>(value);
          case $flutter_18.HashedObserverList _: return $flutter_14.ValueKey<$flutter_18.HashedObserverList>(value);
          case $flutter_19.PersistentHashMap _: return $flutter_14.ValueKey<$flutter_19.PersistentHashMap>(value);
          case $flutter_22.WriteBuffer _: return $flutter_14.ValueKey<$flutter_22.WriteBuffer>(value);
          case $flutter_22.ReadBuffer _: return $flutter_14.ValueKey<$flutter_22.ReadBuffer>(value);
          case $flutter_25.SynchronousFuture _: return $flutter_14.ValueKey<$flutter_25.SynchronousFuture>(value);
          case $flutter_26.FlutterTimeline _: return $flutter_14.ValueKey<$flutter_26.FlutterTimeline>(value);
          case $flutter_26.TimedBlock _: return $flutter_14.ValueKey<$flutter_26.TimedBlock>(value);
          case $flutter_26.AggregatedTimings _: return $flutter_14.ValueKey<$flutter_26.AggregatedTimings>(value);
          case $flutter_26.AggregatedTimedBlock _: return $flutter_14.ValueKey<$flutter_26.AggregatedTimedBlock>(value);
          case $flutter_27.Unicode _: return $flutter_14.ValueKey<$flutter_27.Unicode>(value);
          case $meta_1.Immutable _: return $flutter_14.ValueKey<$meta_1.Immutable>(value);
          default: return $flutter_14.ValueKey(value);
        }
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
    isAssignable: (v) => v is $flutter_15.LicenseParagraph,
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
    isAssignable: (v) => v is $flutter_15.LicenseEntry,
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
    isAssignable: (v) => v is $flutter_15.LicenseEntryWithLineBreaks,
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
    isAssignable: (v) => v is $flutter_15.LicenseRegistry,
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
        final collector = () { return D4.callInterpreterCallback(visitor!, collectorRaw, []) as Stream<$flutter_15.LicenseEntry>; };
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
    isAssignable: (v) => v is $flutter_16.ObjectEvent,
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
    isAssignable: (v) => v is $flutter_16.ObjectCreated,
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
    isAssignable: (v) => v is $flutter_16.ObjectDisposed,
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
    isAssignable: (v) => v is $flutter_16.FlutterMemoryAllocations,
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
        t.addListener(($flutter_16.ObjectEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(($flutter_16.ObjectEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
    isAssignable: (v) => v is $flutter_18.ObserverList,
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
        if (positional.isEmpty) {
          throw ArgumentError('followedBy: Missing required argument "other" at position 0');
        }
        final other = D4.coerceList<dynamic>(positional[0], 'other');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, toElementRaw, [p0])); });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor!, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor!, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
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
    isAssignable: (v) => v is $flutter_18.HashedObserverList,
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
        if (positional.isEmpty) {
          throw ArgumentError('followedBy: Missing required argument "other" at position 0');
        }
        final other = D4.coerceList<dynamic>(positional[0], 'other');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, toElementRaw, [p0])); });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor!, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor!, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
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
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
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
    isAssignable: (v) => v is $flutter_19.PersistentHashMap,
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
    isAssignable: (v) => v is $flutter_22.WriteBuffer,
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
    isAssignable: (v) => v is $flutter_22.ReadBuffer,
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
    isAssignable: (v) => v is $flutter_25.SynchronousFuture,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SynchronousFuture');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'SynchronousFuture');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_25.SynchronousFuture<double>(value);
          case int _: return $flutter_25.SynchronousFuture<int>(value);
          case String _: return $flutter_25.SynchronousFuture<String>(value);
          case bool _: return $flutter_25.SynchronousFuture<bool>(value);
          case $flutter_1.Category _: return $flutter_25.SynchronousFuture<$flutter_1.Category>(value);
          case $flutter_1.DocumentationIcon _: return $flutter_25.SynchronousFuture<$flutter_1.DocumentationIcon>(value);
          case $flutter_1.Summary _: return $flutter_25.SynchronousFuture<$flutter_1.Summary>(value);
          case $flutter_3.CachingIterable _: return $flutter_25.SynchronousFuture<$flutter_3.CachingIterable>(value);
          case $flutter_3.Factory _: return $flutter_25.SynchronousFuture<$flutter_3.Factory>(value);
          case $flutter_12.TextTreeConfiguration _: return $flutter_25.SynchronousFuture<$flutter_12.TextTreeConfiguration>(value);
          case $flutter_12.TextTreeRenderer _: return $flutter_25.SynchronousFuture<$flutter_12.TextTreeRenderer>(value);
          case $flutter_12.DiagnosticsNode _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticsNode>(value);
          case $flutter_12.MessageProperty _: return $flutter_25.SynchronousFuture<$flutter_12.MessageProperty>(value);
          case $flutter_12.StringProperty _: return $flutter_25.SynchronousFuture<$flutter_12.StringProperty>(value);
          case $flutter_12.DoubleProperty _: return $flutter_25.SynchronousFuture<$flutter_12.DoubleProperty>(value);
          case $flutter_12.IntProperty _: return $flutter_25.SynchronousFuture<$flutter_12.IntProperty>(value);
          case $flutter_12.PercentProperty _: return $flutter_25.SynchronousFuture<$flutter_12.PercentProperty>(value);
          case $flutter_12.FlagProperty _: return $flutter_25.SynchronousFuture<$flutter_12.FlagProperty>(value);
          case $flutter_12.IterableProperty _: return $flutter_25.SynchronousFuture<$flutter_12.IterableProperty>(value);
          case $flutter_12.EnumProperty _: return $flutter_25.SynchronousFuture<$flutter_12.EnumProperty>(value);
          case $flutter_12.ObjectFlagProperty _: return $flutter_25.SynchronousFuture<$flutter_12.ObjectFlagProperty>(value);
          case $flutter_12.FlagsSummary _: return $flutter_25.SynchronousFuture<$flutter_12.FlagsSummary>(value);
          case $flutter_12.DiagnosticsProperty _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticsProperty>(value);
          case $flutter_12.DiagnosticableNode _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticableNode>(value);
          case $flutter_12.DiagnosticableTreeNode _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticableTreeNode>(value);
          case $flutter_12.DiagnosticPropertiesBuilder _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticPropertiesBuilder>(value);
          case $flutter_12.Diagnosticable _: return $flutter_25.SynchronousFuture<$flutter_12.Diagnosticable>(value);
          case $flutter_12.DiagnosticableTree _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticableTree>(value);
          case $flutter_12.DiagnosticableTreeMixin _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticableTreeMixin>(value);
          case $flutter_12.DiagnosticsBlock _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticsBlock>(value);
          case $flutter_12.DiagnosticsSerializationDelegate _: return $flutter_25.SynchronousFuture<$flutter_12.DiagnosticsSerializationDelegate>(value);
          case $flutter_24.StackFrame _: return $flutter_25.SynchronousFuture<$flutter_24.StackFrame>(value);
          case $flutter_2.PartialStackFrame _: return $flutter_25.SynchronousFuture<$flutter_2.PartialStackFrame>(value);
          case $flutter_2.StackFilter _: return $flutter_25.SynchronousFuture<$flutter_2.StackFilter>(value);
          case $flutter_2.RepetitiveStackFrameFilter _: return $flutter_25.SynchronousFuture<$flutter_2.RepetitiveStackFrameFilter>(value);
          case $flutter_2.ErrorDescription _: return $flutter_25.SynchronousFuture<$flutter_2.ErrorDescription>(value);
          case $flutter_2.ErrorSummary _: return $flutter_25.SynchronousFuture<$flutter_2.ErrorSummary>(value);
          case $flutter_2.ErrorHint _: return $flutter_25.SynchronousFuture<$flutter_2.ErrorHint>(value);
          case $flutter_2.ErrorSpacer _: return $flutter_25.SynchronousFuture<$flutter_2.ErrorSpacer>(value);
          case $flutter_2.FlutterErrorDetails _: return $flutter_25.SynchronousFuture<$flutter_2.FlutterErrorDetails>(value);
          case $flutter_2.FlutterError _: return $flutter_25.SynchronousFuture<$flutter_2.FlutterError>(value);
          case $flutter_2.DiagnosticsStackTrace _: return $flutter_25.SynchronousFuture<$flutter_2.DiagnosticsStackTrace>(value);
          case $flutter_4.BindingBase _: return $flutter_25.SynchronousFuture<$flutter_4.BindingBase>(value);
          case $flutter_5.BitField _: return $flutter_25.SynchronousFuture<$flutter_5.BitField>(value);
          case $flutter_7.Listenable _: return $flutter_25.SynchronousFuture<$flutter_7.Listenable>(value);
          case $flutter_7.ValueListenable _: return $flutter_25.SynchronousFuture<$flutter_7.ValueListenable>(value);
          case $flutter_7.ChangeNotifier _: return $flutter_25.SynchronousFuture<$flutter_7.ChangeNotifier>(value);
          case $flutter_7.ValueNotifier _: return $flutter_25.SynchronousFuture<$flutter_7.ValueNotifier>(value);
          case $flutter_14.Key _: return $flutter_25.SynchronousFuture<$flutter_14.Key>(value);
          case $flutter_14.LocalKey _: return $flutter_25.SynchronousFuture<$flutter_14.LocalKey>(value);
          case $flutter_14.UniqueKey _: return $flutter_25.SynchronousFuture<$flutter_14.UniqueKey>(value);
          case $flutter_14.ValueKey _: return $flutter_25.SynchronousFuture<$flutter_14.ValueKey>(value);
          case $flutter_15.LicenseParagraph _: return $flutter_25.SynchronousFuture<$flutter_15.LicenseParagraph>(value);
          case $flutter_15.LicenseEntry _: return $flutter_25.SynchronousFuture<$flutter_15.LicenseEntry>(value);
          case $flutter_15.LicenseEntryWithLineBreaks _: return $flutter_25.SynchronousFuture<$flutter_15.LicenseEntryWithLineBreaks>(value);
          case $flutter_15.LicenseRegistry _: return $flutter_25.SynchronousFuture<$flutter_15.LicenseRegistry>(value);
          case $flutter_16.ObjectEvent _: return $flutter_25.SynchronousFuture<$flutter_16.ObjectEvent>(value);
          case $flutter_16.ObjectCreated _: return $flutter_25.SynchronousFuture<$flutter_16.ObjectCreated>(value);
          case $flutter_16.ObjectDisposed _: return $flutter_25.SynchronousFuture<$flutter_16.ObjectDisposed>(value);
          case $flutter_16.FlutterMemoryAllocations _: return $flutter_25.SynchronousFuture<$flutter_16.FlutterMemoryAllocations>(value);
          case $flutter_18.ObserverList _: return $flutter_25.SynchronousFuture<$flutter_18.ObserverList>(value);
          case $flutter_18.HashedObserverList _: return $flutter_25.SynchronousFuture<$flutter_18.HashedObserverList>(value);
          case $flutter_19.PersistentHashMap _: return $flutter_25.SynchronousFuture<$flutter_19.PersistentHashMap>(value);
          case $flutter_22.WriteBuffer _: return $flutter_25.SynchronousFuture<$flutter_22.WriteBuffer>(value);
          case $flutter_22.ReadBuffer _: return $flutter_25.SynchronousFuture<$flutter_22.ReadBuffer>(value);
          case $flutter_26.FlutterTimeline _: return $flutter_25.SynchronousFuture<$flutter_26.FlutterTimeline>(value);
          case $flutter_26.TimedBlock _: return $flutter_25.SynchronousFuture<$flutter_26.TimedBlock>(value);
          case $flutter_26.AggregatedTimings _: return $flutter_25.SynchronousFuture<$flutter_26.AggregatedTimings>(value);
          case $flutter_26.AggregatedTimedBlock _: return $flutter_25.SynchronousFuture<$flutter_26.AggregatedTimedBlock>(value);
          case $flutter_27.Unicode _: return $flutter_25.SynchronousFuture<$flutter_27.Unicode>(value);
          case $meta_1.Immutable _: return $flutter_25.SynchronousFuture<$meta_1.Immutable>(value);
          default: return $flutter_25.SynchronousFuture(value);
        }
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
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((dynamic p0) { return D4.callInterpreterCallback(visitor!, onValueRaw, [p0]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, onTimeoutRaw, []) as FutureOr<Object>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.callInterpreterCallback(visitor!, actionRaw, []) as FutureOr<Object>; });
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
    isAssignable: (v) => v is $flutter_26.FlutterTimeline,
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
        final function = () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, functionRaw, [])); };
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
        $flutter_26.FlutterTimeline.debugCollectionEnabled = D4.extractBridgedArg<bool>(value, 'debugCollectionEnabled'),
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
    isAssignable: (v) => v is $flutter_26.TimedBlock,
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
    isAssignable: (v) => v is $flutter_26.AggregatedTimings,
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
    isAssignable: (v) => v is $flutter_26.AggregatedTimedBlock,
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
    isAssignable: (v) => v is $flutter_27.Unicode,
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
    isAssignable: (v) => v is $meta_1.Immutable,
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

