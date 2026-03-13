// D4rt Bridge - Generated file, do not edit
// Sources: 28 files
// Generated: 2026-03-12T17:05:03.348155

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/src/foundation/assertions.dart' as $flutter_1;
import 'package:flutter/src/foundation/basic_types.dart' as $flutter_2;
import 'package:flutter/src/foundation/binding.dart' as $flutter_3;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_4;
import 'package:flutter/src/foundation/consolidate_response.dart' as $flutter_5;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_6;
import 'package:flutter/src/foundation/isolates.dart' as $flutter_7;
import 'package:flutter/src/foundation/licenses.dart' as $flutter_8;
import 'package:flutter/src/foundation/memory_allocations.dart' as $flutter_9;
import 'package:flutter/src/foundation/persistent_hash_map.dart' as $flutter_10;
import 'package:flutter/src/foundation/print.dart' as $flutter_11;
import 'package:flutter/src/foundation/stack_frame.dart' as $flutter_12;
import 'package:flutter/src/foundation/timeline.dart' as $flutter_13;
import 'package:flutter/src/foundation/key.dart' as $aux_flutter_4;
import 'package:flutter/src/foundation/platform.dart' as $aux_flutter;
import 'package:meta/meta.dart' as $aux_meta;

/// Bridge class for flutter_foundation module.
class FlutterFoundationBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createImmutableBridge(),
      _createRecordUseBridge(),
      _createUseResultBridge(),
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
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Immutable': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart',
      'RecordUse': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart',
      'UseResult': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart',
      'Category': 'C:\flutter\packages\flutter\lib\src\foundation\annotations.dart',
      'DocumentationIcon': 'C:\flutter\packages\flutter\lib\src\foundation\annotations.dart',
      'Summary': 'C:\flutter\packages\flutter\lib\src\foundation\annotations.dart',
      'CachingIterable': 'C:\flutter\packages\flutter\lib\src\foundation\basic_types.dart',
      'Factory': 'C:\flutter\packages\flutter\lib\src\foundation\basic_types.dart',
      'TextTreeConfiguration': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'TextTreeRenderer': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticsNode': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'MessageProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'StringProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DoubleProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'IntProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'PercentProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'FlagProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'IterableProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'EnumProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'ObjectFlagProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'FlagsSummary': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticsProperty': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticableNode': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticableTreeNode': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticPropertiesBuilder': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'Diagnosticable': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticableTree': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticableTreeMixin': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticsBlock': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticsSerializationDelegate': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'StackFrame': 'C:\flutter\packages\flutter\lib\src\foundation\stack_frame.dart',
      'PartialStackFrame': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'StackFilter': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'RepetitiveStackFrameFilter': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'ErrorDescription': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'ErrorSummary': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'ErrorHint': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'ErrorSpacer': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'FlutterErrorDetails': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'FlutterError': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'DiagnosticsStackTrace': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'BindingBase': 'C:\flutter\packages\flutter\lib\src\foundation\binding.dart',
      'BitField': 'C:\flutter\packages\flutter\lib\src\foundation\bitfield.dart',
      'Listenable': 'C:\flutter\packages\flutter\lib\src\foundation\change_notifier.dart',
      'ValueListenable': 'C:\flutter\packages\flutter\lib\src\foundation\change_notifier.dart',
      'ChangeNotifier': 'C:\flutter\packages\flutter\lib\src\foundation\change_notifier.dart',
      'ValueNotifier': 'C:\flutter\packages\flutter\lib\src\foundation\change_notifier.dart',
      'Key': 'C:\flutter\packages\flutter\lib\src\foundation\key.dart',
      'LocalKey': 'C:\flutter\packages\flutter\lib\src\foundation\key.dart',
      'UniqueKey': 'C:\flutter\packages\flutter\lib\src\foundation\key.dart',
      'ValueKey': 'C:\flutter\packages\flutter\lib\src\foundation\key.dart',
      'LicenseParagraph': 'C:\flutter\packages\flutter\lib\src\foundation\licenses.dart',
      'LicenseEntry': 'C:\flutter\packages\flutter\lib\src\foundation\licenses.dart',
      'LicenseEntryWithLineBreaks': 'C:\flutter\packages\flutter\lib\src\foundation\licenses.dart',
      'LicenseRegistry': 'C:\flutter\packages\flutter\lib\src\foundation\licenses.dart',
      'ObjectEvent': 'C:\flutter\packages\flutter\lib\src\foundation\memory_allocations.dart',
      'ObjectCreated': 'C:\flutter\packages\flutter\lib\src\foundation\memory_allocations.dart',
      'ObjectDisposed': 'C:\flutter\packages\flutter\lib\src\foundation\memory_allocations.dart',
      'FlutterMemoryAllocations': 'C:\flutter\packages\flutter\lib\src\foundation\memory_allocations.dart',
      'ObserverList': 'C:\flutter\packages\flutter\lib\src\foundation\observer_list.dart',
      'HashedObserverList': 'C:\flutter\packages\flutter\lib\src\foundation\observer_list.dart',
      'PersistentHashMap': 'C:\flutter\packages\flutter\lib\src\foundation\persistent_hash_map.dart',
      'WriteBuffer': 'C:\flutter\packages\flutter\lib\src\foundation\serialization.dart',
      'ReadBuffer': 'C:\flutter\packages\flutter\lib\src\foundation\serialization.dart',
      'SynchronousFuture': 'C:\flutter\packages\flutter\lib\src\foundation\synchronous_future.dart',
      'FlutterTimeline': 'C:\flutter\packages\flutter\lib\src\foundation\timeline.dart',
      'TimedBlock': 'C:\flutter\packages\flutter\lib\src\foundation\timeline.dart',
      'AggregatedTimings': 'C:\flutter\packages\flutter\lib\src\foundation\timeline.dart',
      'AggregatedTimedBlock': 'C:\flutter\packages\flutter\lib\src\foundation\timeline.dart',
      'Unicode': 'C:\flutter\packages\flutter\lib\src\foundation\unicode.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_6.DiagnosticLevel>(
        name: 'DiagnosticLevel',
        values: $flutter_6.DiagnosticLevel.values,
      ),
      BridgedEnumDefinition<$flutter_6.DiagnosticsTreeStyle>(
        name: 'DiagnosticsTreeStyle',
        values: $flutter_6.DiagnosticsTreeStyle.values,
      ),
      BridgedEnumDefinition<$aux_flutter.TargetPlatform>(
        name: 'TargetPlatform',
        values: $aux_flutter.TargetPlatform.values,
      ),
      BridgedEnumDefinition<FoundationServiceExtensions>(
        name: 'FoundationServiceExtensions',
        values: FoundationServiceExtensions.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'DiagnosticLevel': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'DiagnosticsTreeStyle': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'TargetPlatform': 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart',
      'FoundationServiceExtensions': 'C:\flutter\packages\flutter\lib\src\foundation\service_extensions.dart',
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
      interpreter.registerGlobalVariable('awaitNotRequired', awaitNotRequired, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "awaitNotRequired": $e');
    }
    try {
      interpreter.registerGlobalVariable('doNotStore', doNotStore, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "doNotStore": $e');
    }
    try {
      interpreter.registerGlobalVariable('doNotSubmit', doNotSubmit, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "doNotSubmit": $e');
    }
    try {
      interpreter.registerGlobalVariable('experimental', experimental, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "experimental": $e');
    }
    try {
      interpreter.registerGlobalVariable('factory', factory, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "factory": $e');
    }
    try {
      interpreter.registerGlobalVariable('immutable', immutable, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "immutable": $e');
    }
    try {
      interpreter.registerGlobalVariable('internal', internal, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "internal": $e');
    }
    try {
      interpreter.registerGlobalVariable('isTest', isTest, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "isTest": $e');
    }
    try {
      interpreter.registerGlobalVariable('isTestGroup', isTestGroup, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "isTestGroup": $e');
    }
    try {
      interpreter.registerGlobalVariable('literal', literal, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "literal": $e');
    }
    try {
      interpreter.registerGlobalVariable('mustBeConst', mustBeConst, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "mustBeConst": $e');
    }
    try {
      interpreter.registerGlobalVariable('mustBeOverridden', mustBeOverridden, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "mustBeOverridden": $e');
    }
    try {
      interpreter.registerGlobalVariable('mustCallSuper', mustCallSuper, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "mustCallSuper": $e');
    }
    try {
      interpreter.registerGlobalVariable('nonVirtual', nonVirtual, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "nonVirtual": $e');
    }
    try {
      interpreter.registerGlobalVariable('optionalTypeArgs', optionalTypeArgs, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "optionalTypeArgs": $e');
    }
    try {
      interpreter.registerGlobalVariable('protected', protected, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "protected": $e');
    }
    try {
      interpreter.registerGlobalVariable('redeclare', redeclare, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "redeclare": $e');
    }
    try {
      interpreter.registerGlobalVariable('reopen', reopen, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "reopen": $e');
    }
    try {
      interpreter.registerGlobalVariable('sealed', sealed, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "sealed": $e');
    }
    try {
      interpreter.registerGlobalVariable('useResult', useResult, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "useResult": $e');
    }
    try {
      interpreter.registerGlobalVariable('visibleForOverriding', visibleForOverriding, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "visibleForOverriding": $e');
    }
    try {
      interpreter.registerGlobalVariable('visibleForTesting', visibleForTesting, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart');
    } catch (e) {
      errors.add('Failed to register variable "visibleForTesting": $e');
    }
    try {
      interpreter.registerGlobalVariable('sparseTextConfiguration', sparseTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "sparseTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('dashedTextConfiguration', dashedTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "dashedTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('denseTextConfiguration', denseTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "denseTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('transitionTextConfiguration', transitionTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "transitionTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('errorTextConfiguration', errorTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "errorTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('whitespaceTextConfiguration', whitespaceTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "whitespaceTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('flatTextConfiguration', flatTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "flatTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('singleLineTextConfiguration', singleLineTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "singleLineTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('errorPropertyTextConfiguration', errorPropertyTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "errorPropertyTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('shallowTextConfiguration', shallowTextConfiguration, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "shallowTextConfiguration": $e');
    }
    try {
      interpreter.registerGlobalVariable('kNoDefaultValue', kNoDefaultValue, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart');
    } catch (e) {
      errors.add('Failed to register variable "kNoDefaultValue": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMaxUnsignedSMI', kMaxUnsignedSMI, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\bitfield.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMaxUnsignedSMI": $e');
    }
    try {
      interpreter.registerGlobalVariable('kReleaseMode', kReleaseMode, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kReleaseMode": $e');
    }
    try {
      interpreter.registerGlobalVariable('kProfileMode', kProfileMode, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kProfileMode": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDebugMode', kDebugMode, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDebugMode": $e');
    }
    try {
      interpreter.registerGlobalVariable('precisionErrorTolerance', precisionErrorTolerance, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "precisionErrorTolerance": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIsWeb', kIsWeb, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIsWeb": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIsWasm', kIsWasm, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIsWasm": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrint', debugPrint, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\print.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrint": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugInstrumentationEnabled', debugInstrumentationEnabled, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugInstrumentationEnabled": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugDoublePrecision', debugDoublePrecision, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugDoublePrecision": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugBrightnessOverride', debugBrightnessOverride, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugBrightnessOverride": $e');
    }
    try {
      interpreter.registerGlobalVariable('activeDevToolsServerAddress', activeDevToolsServerAddress, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "activeDevToolsServerAddress": $e');
    }
    try {
      interpreter.registerGlobalVariable('connectedVmServiceUri', connectedVmServiceUri, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "connectedVmServiceUri": $e');
    }
    try {
      interpreter.registerGlobalVariable('kFlutterMemoryAllocationsEnabled', kFlutterMemoryAllocationsEnabled, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\memory_allocations.dart');
    } catch (e) {
      errors.add('Failed to register variable "kFlutterMemoryAllocationsEnabled": $e');
    }
    interpreter.registerGlobalGetter('isCanvasKit', () => isCanvasKit, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart');
    interpreter.registerGlobalGetter('isSkwasm', () => isSkwasm, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart');
    interpreter.registerGlobalGetter('isSkiaWeb', () => isSkiaWeb, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart');
    interpreter.registerGlobalGetter('debugPrintDone', () => debugPrintDone, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\print.dart');
    interpreter.registerGlobalGetter('defaultTargetPlatform', () => defaultTargetPlatform, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart');
    interpreter.registerGlobalGetter('debugDefaultTargetPlatformOverride', () => debugDefaultTargetPlatformOverride, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart');
    interpreter.registerGlobalSetter('debugDefaultTargetPlatformOverride', (v) => debugDefaultTargetPlatformOverride = v as $aux_flutter.TargetPlatform?, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_foundation):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
        final compare = compareRaw == null ? null : (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor!, compareRaw, [p0, p1]) as int; };
        return mergeSort<dynamic>(list, start: start, end: end, compare: compare);
      },
      'consolidateHttpClientResponseBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'consolidateHttpClientResponseBytes');
        final response = D4.getRequiredArg<HttpClientResponse>(positional, 0, 'response', 'consolidateHttpClientResponseBytes');
        final autoUncompress = D4.getNamedArgWithDefault<bool>(named, 'autoUncompress', true);
        final onBytesReceivedRaw = named['onBytesReceived'];
        final onBytesReceived = onBytesReceivedRaw == null ? null : (int p0, int? p1) { D4.callInterpreterCallback(visitor!, onBytesReceivedRaw, [p0, p1]); };
        return consolidateHttpClientResponseBytes(response, autoUncompress: autoUncompress, onBytesReceived: onBytesReceived);
      },
      'debugPrintSynchronously': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugPrintSynchronously');
        final message = D4.getRequiredArg<String?>(positional, 0, 'message', 'debugPrintSynchronously');
        final wrapWidth = D4.getOptionalNamedArg<int?>(named, 'wrapWidth');
        return debugPrintSynchronously(message, wrapWidth: wrapWidth);
      },
      'debugPrintThrottled': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugPrintThrottled');
        final message = D4.getRequiredArg<String?>(positional, 0, 'message', 'debugPrintThrottled');
        final wrapWidth = D4.getOptionalNamedArg<int?>(named, 'wrapWidth');
        return debugPrintThrottled(message, wrapWidth: wrapWidth);
      },
      'debugWordWrap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'debugWordWrap');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'debugWordWrap');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'debugWordWrap');
        final wrapIndent = D4.getNamedArgWithDefault<String>(named, 'wrapIndent', '');
        return debugWordWrap(message, width, wrapIndent: wrapIndent);
      },
      'debugAssertAllFoundationVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllFoundationVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllFoundationVarsUnset');
        if (!named.containsKey('debugPrintOverride')) {
          return debugAssertAllFoundationVarsUnset(reason);
        }
        if (named.containsKey('debugPrintOverride')) {
          final debugPrintOverrideRaw = named['debugPrintOverride'];
          final debugPrintOverride = (String? p0, {int? wrapWidth}) { D4.callInterpreterCallback(visitor!, debugPrintOverrideRaw, [p0], {'wrapWidth': wrapWidth}); };
          return debugAssertAllFoundationVarsUnset(reason, debugPrintOverride: debugPrintOverride);
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
        return debugInstrumentAction<dynamic>(description, action);
      },
      'debugFormatDouble': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugFormatDouble');
        final value = D4.getRequiredArg<double?>(positional, 0, 'value', 'debugFormatDouble');
        return debugFormatDouble(value);
      },
      'debugMaybeDispatchCreated': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'debugMaybeDispatchCreated');
        final flutterLibrary = D4.getRequiredArg<String>(positional, 0, 'flutterLibrary', 'debugMaybeDispatchCreated');
        final className = D4.getRequiredArg<String>(positional, 1, 'className', 'debugMaybeDispatchCreated');
        final object = D4.getRequiredArg<Object>(positional, 2, 'object', 'debugMaybeDispatchCreated');
        return debugMaybeDispatchCreated(flutterLibrary, className, object);
      },
      'debugMaybeDispatchDisposed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugMaybeDispatchDisposed');
        final object = D4.getRequiredArg<Object>(positional, 0, 'object', 'debugMaybeDispatchDisposed');
        return debugMaybeDispatchDisposed(object);
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
        return compute<dynamic, dynamic>(callback, message, debugLabel: debugLabel);
      },
      'objectRuntimeType': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'objectRuntimeType');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'objectRuntimeType');
        final optimizedValue = D4.getRequiredArg<String>(positional, 1, 'optimizedValue', 'objectRuntimeType');
        return objectRuntimeType(object, optimizedValue);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'lerpDuration': 'C:\flutter\packages\flutter\lib\src\foundation\basic_types.dart',
      'shortHash': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'describeIdentity': 'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'debugPrintStack': 'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'setEquals': 'C:\flutter\packages\flutter\lib\src\foundation\collections.dart',
      'listEquals': 'C:\flutter\packages\flutter\lib\src\foundation\collections.dart',
      'mapEquals': 'C:\flutter\packages\flutter\lib\src\foundation\collections.dart',
      'binarySearch': 'C:\flutter\packages\flutter\lib\src\foundation\collections.dart',
      'mergeSort': 'C:\flutter\packages\flutter\lib\src\foundation\collections.dart',
      'consolidateHttpClientResponseBytes': 'C:\flutter\packages\flutter\lib\src\foundation\consolidate_response.dart',
      'debugPrintSynchronously': 'C:\flutter\packages\flutter\lib\src\foundation\print.dart',
      'debugPrintThrottled': 'C:\flutter\packages\flutter\lib\src\foundation\print.dart',
      'debugWordWrap': 'C:\flutter\packages\flutter\lib\src\foundation\print.dart',
      'debugAssertAllFoundationVarsUnset': 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart',
      'debugInstrumentAction': 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart',
      'debugFormatDouble': 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart',
      'debugMaybeDispatchCreated': 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart',
      'debugMaybeDispatchDisposed': 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart',
      'compute': 'C:\flutter\packages\flutter\lib\src\foundation\isolates.dart',
      'objectRuntimeType': 'C:\flutter\packages\flutter\lib\src\foundation\object.dart',
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
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\meta-1.17.0\lib\meta.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\annotations.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\assertions.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\basic_types.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\binding.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\bitfield.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\change_notifier.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\collections.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\consolidate_response.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\constants.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\debug.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\diagnostics.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\isolates.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\key.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\licenses.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\memory_allocations.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\object.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\observer_list.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\persistent_hash_map.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\platform.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\print.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\serialization.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\service_extensions.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\stack_frame.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\synchronous_future.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\timeline.dart',
      'C:\flutter\packages\flutter\lib\src\foundation\unicode.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter/foundation.dart';";
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [];
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
// Immutable Bridge
// =============================================================================

BridgedClass _createImmutableBridge() {
  return BridgedClass(
    nativeType: $aux_meta.Immutable,
    name: 'Immutable',
    isAssignable: (v) => v is $aux_meta.Immutable,
    constructors: {
      '': (visitor, positional, named) {
        final reason = D4.getOptionalArgWithDefault<String>(positional, 0, 'reason', '');
        return $aux_meta.Immutable(reason);
      },
    },
    getters: {
      'reason': (visitor, target) => D4.validateTarget<$aux_meta.Immutable>(target, 'Immutable').reason,
    },
    constructorSignatures: {
      '': 'const Immutable([String reason = \'\'])',
    },
    getterSignatures: {
      'reason': 'String get reason',
    },
  );
}

// =============================================================================
// RecordUse Bridge
// =============================================================================

BridgedClass _createRecordUseBridge() {
  return BridgedClass(
    nativeType: RecordUse,
    name: 'RecordUse',
    isAssignable: (v) => v is RecordUse,
    constructors: {
      '': (visitor, positional, named) {
        return RecordUse();
      },
    },
    constructorSignatures: {
      '': 'const RecordUse()',
    },
  );
}

// =============================================================================
// UseResult Bridge
// =============================================================================

BridgedClass _createUseResultBridge() {
  return BridgedClass(
    nativeType: $aux_meta.UseResult,
    name: 'UseResult',
    isAssignable: (v) => v is $aux_meta.UseResult,
    constructors: {
      '': (visitor, positional, named) {
        final reason = D4.getOptionalArgWithDefault<String>(positional, 0, 'reason', '');
        return $aux_meta.UseResult(reason);
      },
      'unless': (visitor, positional, named) {
        final parameterDefined = D4.getRequiredNamedArg<String?>(named, 'parameterDefined', 'UseResult');
        final reason = D4.getNamedArgWithDefault<String>(named, 'reason', '');
        return $aux_meta.UseResult.unless(parameterDefined: parameterDefined, reason: reason);
      },
    },
    getters: {
      'reason': (visitor, target) => D4.validateTarget<$aux_meta.UseResult>(target, 'UseResult').reason,
      'parameterDefined': (visitor, target) => D4.validateTarget<$aux_meta.UseResult>(target, 'UseResult').parameterDefined,
    },
    constructorSignatures: {
      '': 'const UseResult([String reason = \'\'])',
      'unless': 'const UseResult.unless({required String? parameterDefined, String reason = \'\'})',
    },
    getterSignatures: {
      'reason': 'String get reason',
      'parameterDefined': 'String? get parameterDefined',
    },
  );
}

// =============================================================================
// Category Bridge
// =============================================================================

BridgedClass _createCategoryBridge() {
  return BridgedClass(
    nativeType: Category,
    name: 'Category',
    isAssignable: (v) => v is DocumentationIcon,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentationIcon');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'DocumentationIcon');
        return DocumentationIcon(url);
      },
    },
    getters: {
      'url': (visitor, target) => D4.validateTarget<DocumentationIcon>(target, 'DocumentationIcon').url,
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
    nativeType: Summary,
    name: 'Summary',
// CachingIterable Bridge
// =============================================================================

BridgedClass _createCachingIterableBridge() {
  return BridgedClass(
    nativeType: CachingIterable,
    name: 'CachingIterable',
    isAssignable: (v) => v is CachingIterable,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CachingIterable');
        final prefillIterator = D4.getRequiredArg<Iterator<dynamic>>(positional, 0, '_prefillIterator', 'CachingIterable');
        return CachingIterable(prefillIterator);
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').iterator,
      'length': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').length,
      'isEmpty': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').isNotEmpty,
      'first': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').first,
      'last': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').last,
      'single': (visitor, target) => D4.validateTarget<CachingIterable>(target, 'CachingIterable').single,
    },
    methods: {
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, toElementRaw, [p0])); });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor!, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'followedBy');
        if (positional.isEmpty) {
          throw ArgumentError('followedBy: Missing required argument "other" at position 0');
        }
        final other = D4.coerceList<dynamic>(positional[0], 'other');
        return t.followedBy(other);
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        return t.whereType();
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor!, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        return t.toSet();
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, orElseRaw, [])); });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CachingIterable>(target, 'CachingIterable');
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
    nativeType: Factory,
    name: 'Factory',
    isAssignable: (v) => v is Factory,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Factory');
        if (positional.isEmpty) {
          throw ArgumentError('Factory: Missing required argument "constructor" at position 0');
        }
        final constructorRaw = positional[0];
        return Factory(() { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, constructorRaw, [])); });
      },
    },
    getters: {
      'constructor': (visitor, target) => D4.validateTarget<Factory>(target, 'Factory').constructor,
      'type': (visitor, target) => D4.validateTarget<Factory>(target, 'Factory').type,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Factory>(target, 'Factory');
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
    nativeType: $flutter_6.TextTreeConfiguration,
    name: 'TextTreeConfiguration',
    isAssignable: (v) => v is $flutter_6.TextTreeConfiguration,
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
        return $flutter_6.TextTreeConfiguration(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, prefixLastChildLineOne: prefixLastChildLineOne, prefixOtherLinesRootNode: prefixOtherLinesRootNode, linkCharacter: linkCharacter, propertyPrefixIfChildren: propertyPrefixIfChildren, propertyPrefixNoChildren: propertyPrefixNoChildren, lineBreak: lineBreak, lineBreakProperties: lineBreakProperties, afterName: afterName, afterDescriptionIfBody: afterDescriptionIfBody, afterDescription: afterDescription, beforeProperties: beforeProperties, afterProperties: afterProperties, mandatoryAfterProperties: mandatoryAfterProperties, propertySeparator: propertySeparator, bodyIndent: bodyIndent, footer: footer, showChildren: showChildren, addBlankLineIfNoChildren: addBlankLineIfNoChildren, isNameOnOwnLine: isNameOnOwnLine, isBlankLineBetweenPropertiesAndChildren: isBlankLineBetweenPropertiesAndChildren, beforeName: beforeName, suffixLineOne: suffixLineOne, mandatoryFooter: mandatoryFooter);
      },
    },
    getters: {
      'prefixLineOne': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixLineOne,
      'suffixLineOne': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').suffixLineOne,
      'prefixOtherLines': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixOtherLines,
      'prefixLastChildLineOne': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixLastChildLineOne,
      'prefixOtherLinesRootNode': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').prefixOtherLinesRootNode,
      'propertyPrefixIfChildren': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').propertyPrefixIfChildren,
      'propertyPrefixNoChildren': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').propertyPrefixNoChildren,
      'linkCharacter': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').linkCharacter,
      'childLinkSpace': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').childLinkSpace,
      'lineBreak': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').lineBreak,
      'lineBreakProperties': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').lineBreakProperties,
      'beforeName': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').beforeName,
      'afterName': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterName,
      'afterDescriptionIfBody': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterDescriptionIfBody,
      'afterDescription': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterDescription,
      'beforeProperties': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').beforeProperties,
      'afterProperties': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').afterProperties,
      'mandatoryAfterProperties': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').mandatoryAfterProperties,
      'propertySeparator': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').propertySeparator,
      'bodyIndent': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').bodyIndent,
      'showChildren': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').showChildren,
      'addBlankLineIfNoChildren': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').addBlankLineIfNoChildren,
      'isNameOnOwnLine': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').isNameOnOwnLine,
      'footer': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').footer,
      'mandatoryFooter': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').mandatoryFooter,
      'isBlankLineBetweenPropertiesAndChildren': (visitor, target) => D4.validateTarget<$flutter_6.TextTreeConfiguration>(target, 'TextTreeConfiguration').isBlankLineBetweenPropertiesAndChildren,
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
    nativeType: TextTreeRenderer,
    name: 'TextTreeRenderer',
    isAssignable: (v) => v is TextTreeRenderer,
    constructors: {
      '': (visitor, positional, named) {
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 100);
        final wrapWidthProperties = D4.getNamedArgWithDefault<int>(named, 'wrapWidthProperties', 65);
        final maxDescendentsTruncatableNode = D4.getNamedArgWithDefault<int>(named, 'maxDescendentsTruncatableNode', -1);
        return TextTreeRenderer(minLevel: minLevel, wrapWidth: wrapWidth, wrapWidthProperties: wrapWidthProperties, maxDescendentsTruncatableNode: maxDescendentsTruncatableNode);
      },
    },
    methods: {
      'render': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TextTreeRenderer>(target, 'TextTreeRenderer');
        D4.requireMinArgs(positional, 1, 'render');
        final node = D4.getRequiredArg<$flutter_6.DiagnosticsNode>(positional, 0, 'node', 'render');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: $flutter_6.DiagnosticsNode,
    name: 'DiagnosticsNode',
      'name': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode').textTreeConfiguration,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsNode>(target, 'DiagnosticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
        final nodes = D4.coerceListOrNull<$flutter_6.DiagnosticsNode>(positional[0], 'nodes');
        final parent = D4.getRequiredArg<$flutter_6.DiagnosticsNode?>(positional, 1, 'parent', 'toJsonList');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 2, 'delegate', 'toJsonList');
        return $flutter_6.DiagnosticsNode.toJsonList(nodes, parent, delegate);
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
    isAssignable: (v) => v is $flutter_6.DiagnosticPropertiesBuilder,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_6.DiagnosticPropertiesBuilder();
      },
      'fromProperties': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticPropertiesBuilder');
        if (positional.isEmpty) {
          throw ArgumentError('DiagnosticPropertiesBuilder: Missing required argument "properties" at position 0');
        }
        final properties = D4.coerceList<$flutter_6.DiagnosticsNode>(positional[0], 'properties');
        return $flutter_6.DiagnosticPropertiesBuilder.fromProperties(properties);
      },
    },
    getters: {
      'properties': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').properties,
      'defaultDiagnosticsTreeStyle': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription,
    },
    setters: {
      'defaultDiagnosticsTreeStyle': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = D4.extractBridgedArg<$flutter_6.DiagnosticsTreeStyle>(value, 'defaultDiagnosticsTreeStyle'),
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = D4.extractBridgedArgOrNull<String>(value, 'emptyBodyDescription'),
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder');
        D4.requireMinArgs(positional, 1, 'add');
        final property = D4.getRequiredArg<$flutter_6.DiagnosticsNode>(positional, 0, 'property', 'add');
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
    isAssignable: (v) => v is $flutter_12.StackFrame,
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
        return $flutter_12.StackFrame(number: number, column: column, line: line, packageScheme: packageScheme, package: package, packagePath: packagePath, className: className, method: method, isConstructor: isConstructor, source: source);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').source,
      'number': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').number,
      'packageScheme': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').packageScheme,
      'package': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').package,
      'packagePath': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').packagePath,
      'line': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').line,
      'column': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').column,
      'className': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').className,
      'method': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').method,
      'isConstructor': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').isConstructor,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.StackFrame>(target, 'StackFrame');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'asynchronousSuspension': (visitor) => $flutter_12.StackFrame.asynchronousSuspension,
      'stackOverFlowElision': (visitor) => $flutter_12.StackFrame.stackOverFlowElision,
    },
    staticMethods: {
      'fromStackTrace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromStackTrace');
        final stack = D4.getRequiredArg<StackTrace>(positional, 0, 'stack', 'fromStackTrace');
        return $flutter_12.StackFrame.fromStackTrace(stack);
      },
      'fromStackString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromStackString');
        final stack = D4.getRequiredArg<String>(positional, 0, 'stack', 'fromStackString');
        return $flutter_12.StackFrame.fromStackString(stack);
      },
      'fromStackTraceLine': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromStackTraceLine');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'fromStackTraceLine');
        return $flutter_12.StackFrame.fromStackTraceLine(line);
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
    nativeType: $flutter_1.PartialStackFrame,
    name: 'PartialStackFrame',
    isAssignable: (v) => v is $flutter_1.StackFilter,
    constructors: {
    },
    methods: {
      'filter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.StackFilter>(target, 'StackFilter');
        D4.requireMinArgs(positional, 2, 'filter');
        if (positional.isEmpty) {
          throw ArgumentError('filter: Missing required argument "stackFrames" at position 0');
        }
        final stackFrames = D4.coerceList<$flutter_12.StackFrame>(positional[0], 'stackFrames');
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
    nativeType: RepetitiveStackFrameFilter,
    name: 'RepetitiveStackFrameFilter',
    isAssignable: (v) => v is ErrorDescription,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ErrorDescription');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ErrorDescription');
        return ErrorDescription(message);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').value,
      'expandableValue': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').propertyType,
      'exception': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').isInteresting,
      'level': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').level,
      'name': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').name,
      'showSeparator': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<ErrorDescription>(target, 'ErrorDescription').textTreeConfiguration,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorDescription>(target, 'ErrorDescription');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: ErrorSummary,
    name: 'ErrorSummary',
    isAssignable: (v) => v is ErrorHint,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ErrorHint');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ErrorHint');
        return ErrorHint(message);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').value,
      'expandableValue': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').propertyType,
      'exception': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').isInteresting,
      'level': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').level,
      'name': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').name,
      'showSeparator': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<ErrorHint>(target, 'ErrorHint').textTreeConfiguration,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorHint>(target, 'ErrorHint');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: ErrorSpacer,
    name: 'ErrorSpacer',
      'name': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').name,
      'showSeparator': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').showSeparator,
      'level': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').level,
      'showName': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').value,
      'style': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').style,
      'allowWrap': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').propertyType,
      'exception': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer').isInteresting,
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
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    isAssignable: (v) => v is $flutter_1.FlutterErrorDetails,
    constructors: {
      '': (visitor, positional, named) {
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'FlutterErrorDetails');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final library = D4.getNamedArgWithDefault<String?>(named, 'library', 'Flutter framework');
        final context = D4.getOptionalNamedArg<$flutter_6.DiagnosticsNode?>(named, 'context');
        final stackFilterRaw = named['stackFilter'];
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        return $flutter_1.FlutterErrorDetails(exception: exception, stack: stack, library: library, context: context, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; }, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, informationCollectorRaw, []) as Iterable<$flutter_6.DiagnosticsNode>; }, silent: silent);
      },
    },
    getters: {
      'exception': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').exception,
      'stack': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').stack,
      'library': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').library,
      'context': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').context,
      'stackFilter': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').stackFilter,
      'informationCollector': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').informationCollector,
      'silent': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').silent,
      'summary': (visitor, target) => D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails').summary,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        final context = D4.getOptionalNamedArg<$flutter_6.DiagnosticsNode?>(named, 'context');
        final exception = D4.getOptionalNamedArg<Object?>(named, 'exception');
        final informationCollectorRaw = named['informationCollector'];
        final library = D4.getOptionalNamedArg<String?>(named, 'library');
        final silent = D4.getOptionalNamedArg<bool?>(named, 'silent');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final stackFilterRaw = named['stackFilter'];
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, informationCollectorRaw, []) as Iterable<$flutter_6.DiagnosticsNode>; }, library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; });
      },
      'exceptionAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        return t.exceptionAsString();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    staticGetters: {
      'propertiesTransformers': (visitor) => $flutter_1.FlutterErrorDetails.propertiesTransformers,
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
    nativeType: FlutterError,
    name: 'FlutterError',
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        return t.debugDescribeChildren();
      },
    },
    staticGetters: {
      'onError': (visitor) => FlutterError.onError,
      'demangleStackTrace': (visitor) => FlutterError.demangleStackTrace,
      'presentError': (visitor) => FlutterError.presentError,
      'wrapWidth': (visitor) => FlutterError.wrapWidth,
    },
    staticMethods: {
      'resetErrorCount': (visitor, positional, named, typeArgs) {
        return FlutterError.resetErrorCount();
      },
      'dumpErrorToConsole': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dumpErrorToConsole');
        final details = D4.getRequiredArg<$flutter_1.FlutterErrorDetails>(positional, 0, 'details', 'dumpErrorToConsole');
        final forceReport = D4.getNamedArgWithDefault<bool>(named, 'forceReport', false);
        return FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
      },
      'addDefaultStackFilter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addDefaultStackFilter');
        final filter = D4.getRequiredArg<$flutter_1.StackFilter>(positional, 0, 'filter', 'addDefaultStackFilter');
        return FlutterError.addDefaultStackFilter(filter);
      },
      'defaultStackFilter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'defaultStackFilter');
        if (positional.isEmpty) {
          throw ArgumentError('defaultStackFilter: Missing required argument "frames" at position 0');
        }
        final frames = D4.coerceList<String>(positional[0], 'frames');
        return FlutterError.defaultStackFilter(frames);
      },
      'reportError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'reportError');
        final details = D4.getRequiredArg<$flutter_1.FlutterErrorDetails>(positional, 0, 'details', 'reportError');
        return FlutterError.reportError(details);
      },
    },
    staticSetters: {
      'onError': (visitor, value) {
        final onErrorRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onError');
        FlutterError.onError = onErrorRaw == null ? null : ($flutter_1.FlutterErrorDetails p0) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0]); };
      },
      'demangleStackTrace': (visitor, value) {
        final demangleStackTraceRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'demangleStackTrace');
        FlutterError.demangleStackTrace = (StackTrace p0) { return D4.callInterpreterCallback(visitor!, demangleStackTraceRaw, [p0]) as StackTrace; };
      },
      'presentError': (visitor, value) {
        final presentErrorRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'presentError');
        FlutterError.presentError = ($flutter_1.FlutterErrorDetails p0) { D4.callInterpreterCallback(visitor!, presentErrorRaw, [p0]); };
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
    nativeType: DiagnosticsStackTrace,
    name: 'DiagnosticsStackTrace',
        return DiagnosticsStackTrace(name, stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; }, showSeparator: showSeparator);
      },
      'singleFrame': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsStackTrace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DiagnosticsStackTrace');
        final frame = D4.getRequiredNamedArg<String>(named, 'frame', 'DiagnosticsStackTrace');
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        return DiagnosticsStackTrace.singleFrame(name, frame: frame, showSeparator: showSeparator);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').name,
      'showSeparator': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').showSeparator,
      'level': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').level,
      'showName': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').value,
      'style': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').style,
      'allowWrap': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').textTreeConfiguration,
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
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
    isAssignable: (v) => v is BindingBase,
    constructors: {
    },
    getters: {
      'window': (visitor, target) => D4.validateTarget<BindingBase>(target, 'BindingBase').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<BindingBase>(target, 'BindingBase').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<BindingBase>(target, 'BindingBase').locked,
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        t.initInstances();
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: () { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
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
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
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
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
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
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
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
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: (Map<String, String> p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<Map<String, dynamic>>; });
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        return t.toString();
      },
    },
    staticGetters: {
      'debugZoneErrorsAreFatal': (visitor) => BindingBase.debugZoneErrorsAreFatal,
    },
    staticMethods: {
        BindingBase.debugZoneErrorsAreFatal = D4.extractBridgedArg<bool>(value, 'debugZoneErrorsAreFatal'),
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
    nativeType: BitField,
    name: 'BitField',
    isAssignable: (v) => v is $flutter_4.Listenable,
    constructors: {
      'merge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Listenable');
        if (positional.isEmpty) {
          throw ArgumentError('Listenable: Missing required argument "listenables" at position 0');
        }
        final listenables = D4.coerceList<$flutter_4.Listenable?>(positional[0], 'listenables');
        return $flutter_4.Listenable.merge(listenables);
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Listenable>(target, 'Listenable');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Listenable>(target, 'Listenable');
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
    nativeType: ValueListenable,
    name: 'ValueListenable',
    isAssignable: (v) => v is $flutter_4.ChangeNotifier,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_4.ChangeNotifier();
      },
    },
        final t = D4.validateTarget<$flutter_4.ChangeNotifier>(target, 'ChangeNotifier');
        (t as dynamic).dispose();
        return null;
      },
    },
    staticMethods: {
      'debugAssertNotDisposed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertNotDisposed');
        final notifier = D4.getRequiredArg<$flutter_4.ChangeNotifier>(positional, 0, 'notifier', 'debugAssertNotDisposed');
        return $flutter_4.ChangeNotifier.debugAssertNotDisposed(notifier);
      },
    isAssignable: (v) => v is ValueNotifier,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueNotifier');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'ValueNotifier');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return ValueNotifier<double>(value);
          case int _: return ValueNotifier<int>(value);
          case String _: return ValueNotifier<String>(value);
          case bool _: return ValueNotifier<bool>(value);
          case $aux_meta.Immutable _: return ValueNotifier<$aux_meta.Immutable>(value);
          case RecordUse _: return ValueNotifier<RecordUse>(value);
          case $aux_meta.UseResult _: return ValueNotifier<$aux_meta.UseResult>(value);
          case Category _: return ValueNotifier<Category>(value);
          case DocumentationIcon _: return ValueNotifier<DocumentationIcon>(value);
          case Summary _: return ValueNotifier<Summary>(value);
          case CachingIterable _: return ValueNotifier<CachingIterable>(value);
          case Factory _: return ValueNotifier<Factory>(value);
          case $flutter_6.TextTreeConfiguration _: return ValueNotifier<$flutter_6.TextTreeConfiguration>(value);
          case TextTreeRenderer _: return ValueNotifier<TextTreeRenderer>(value);
          case $flutter_6.DiagnosticsNode _: return ValueNotifier<$flutter_6.DiagnosticsNode>(value);
          case MessageProperty _: return ValueNotifier<MessageProperty>(value);
          case StringProperty _: return ValueNotifier<StringProperty>(value);
          case DoubleProperty _: return ValueNotifier<DoubleProperty>(value);
          case IntProperty _: return ValueNotifier<IntProperty>(value);
          case PercentProperty _: return ValueNotifier<PercentProperty>(value);
          case FlagProperty _: return ValueNotifier<FlagProperty>(value);
          case IterableProperty _: return ValueNotifier<IterableProperty>(value);
          case EnumProperty _: return ValueNotifier<EnumProperty>(value);
          case ObjectFlagProperty _: return ValueNotifier<ObjectFlagProperty>(value);
          case FlagsSummary _: return ValueNotifier<FlagsSummary>(value);
          case DiagnosticsProperty _: return ValueNotifier<DiagnosticsProperty>(value);
          case DiagnosticableNode _: return ValueNotifier<DiagnosticableNode>(value);
          case DiagnosticableTreeNode _: return ValueNotifier<DiagnosticableTreeNode>(value);
          case $flutter_6.DiagnosticPropertiesBuilder _: return ValueNotifier<$flutter_6.DiagnosticPropertiesBuilder>(value);
          case $flutter_6.Diagnosticable _: return ValueNotifier<$flutter_6.Diagnosticable>(value);
          case $flutter_6.DiagnosticableTree _: return ValueNotifier<$flutter_6.DiagnosticableTree>(value);
          case DiagnosticableTreeMixin _: return ValueNotifier<DiagnosticableTreeMixin>(value);
          case DiagnosticsBlock _: return ValueNotifier<DiagnosticsBlock>(value);
          case $flutter_6.DiagnosticsSerializationDelegate _: return ValueNotifier<$flutter_6.DiagnosticsSerializationDelegate>(value);
          case $flutter_12.StackFrame _: return ValueNotifier<$flutter_12.StackFrame>(value);
          case $flutter_1.PartialStackFrame _: return ValueNotifier<$flutter_1.PartialStackFrame>(value);
          case $flutter_1.StackFilter _: return ValueNotifier<$flutter_1.StackFilter>(value);
          case RepetitiveStackFrameFilter _: return ValueNotifier<RepetitiveStackFrameFilter>(value);
          case ErrorDescription _: return ValueNotifier<ErrorDescription>(value);
          case ErrorSummary _: return ValueNotifier<ErrorSummary>(value);
          case ErrorHint _: return ValueNotifier<ErrorHint>(value);
          case ErrorSpacer _: return ValueNotifier<ErrorSpacer>(value);
          case $flutter_1.FlutterErrorDetails _: return ValueNotifier<$flutter_1.FlutterErrorDetails>(value);
          case FlutterError _: return ValueNotifier<FlutterError>(value);
          case DiagnosticsStackTrace _: return ValueNotifier<DiagnosticsStackTrace>(value);
          case BindingBase _: return ValueNotifier<BindingBase>(value);
          case BitField _: return ValueNotifier<BitField>(value);
          case $flutter_4.Listenable _: return ValueNotifier<$flutter_4.Listenable>(value);
          case ValueListenable _: return ValueNotifier<ValueListenable>(value);
          case $flutter_4.ChangeNotifier _: return ValueNotifier<$flutter_4.ChangeNotifier>(value);
          case Key _: return ValueNotifier<Key>(value);
          case LocalKey _: return ValueNotifier<LocalKey>(value);
          case UniqueKey _: return ValueNotifier<UniqueKey>(value);
          case ValueKey _: return ValueNotifier<ValueKey>(value);
          case $flutter_8.LicenseParagraph _: return ValueNotifier<$flutter_8.LicenseParagraph>(value);
          case $flutter_8.LicenseEntry _: return ValueNotifier<$flutter_8.LicenseEntry>(value);
          case LicenseEntryWithLineBreaks _: return ValueNotifier<LicenseEntryWithLineBreaks>(value);
          case LicenseRegistry _: return ValueNotifier<LicenseRegistry>(value);
          case $flutter_9.ObjectEvent _: return ValueNotifier<$flutter_9.ObjectEvent>(value);
          case ObjectCreated _: return ValueNotifier<ObjectCreated>(value);
          case ObjectDisposed _: return ValueNotifier<ObjectDisposed>(value);
          case $flutter_9.FlutterMemoryAllocations _: return ValueNotifier<$flutter_9.FlutterMemoryAllocations>(value);
          case ObserverList _: return ValueNotifier<ObserverList>(value);
          case HashedObserverList _: return ValueNotifier<HashedObserverList>(value);
          case $flutter_10.PersistentHashMap _: return ValueNotifier<$flutter_10.PersistentHashMap>(value);
          case WriteBuffer _: return ValueNotifier<WriteBuffer>(value);
          case ReadBuffer _: return ValueNotifier<ReadBuffer>(value);
          case SynchronousFuture _: return ValueNotifier<SynchronousFuture>(value);
          case FlutterTimeline _: return ValueNotifier<FlutterTimeline>(value);
          case $flutter_13.TimedBlock _: return ValueNotifier<$flutter_13.TimedBlock>(value);
          case $flutter_13.AggregatedTimings _: return ValueNotifier<$flutter_13.AggregatedTimings>(value);
          case $flutter_13.AggregatedTimedBlock _: return ValueNotifier<$flutter_13.AggregatedTimedBlock>(value);
          case Unicode _: return ValueNotifier<Unicode>(value);
          default: return ValueNotifier(value);
        }
      },
    },
    getters: {
      'hasListeners': (visitor, target) => D4.validateTarget<ValueNotifier>(target, 'ValueNotifier').hasListeners,
      'value': (visitor, target) => D4.validateTarget<ValueNotifier>(target, 'ValueNotifier').value,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<ValueNotifier>(target, 'ValueNotifier').value = value as dynamic,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueNotifier>(target, 'ValueNotifier');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueNotifier>(target, 'ValueNotifier');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueNotifier>(target, 'ValueNotifier');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueNotifier>(target, 'ValueNotifier');
        return t.toString();
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        t.notifyListeners();
        return null;
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
      'notifyListeners': 'void notifyListeners()',
    },
    getterSignatures: {
      'value': 'T get value',
      'hasListeners': 'bool get hasListeners',
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
    nativeType: Key,
    name: 'Key',
    isAssignable: (v) => v is LocalKey,
    constructors: {
    },
  );
}

// =============================================================================
// UniqueKey Bridge
// =============================================================================

BridgedClass _createUniqueKeyBridge() {
  return BridgedClass(
    nativeType: UniqueKey,
    name: 'UniqueKey',
    isAssignable: (v) => v is ValueKey,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueKey');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'ValueKey');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return ValueKey<double>(value);
          case int _: return ValueKey<int>(value);
          case String _: return ValueKey<String>(value);
          case bool _: return ValueKey<bool>(value);
          case $aux_meta.Immutable _: return ValueKey<$aux_meta.Immutable>(value);
          case RecordUse _: return ValueKey<RecordUse>(value);
          case $aux_meta.UseResult _: return ValueKey<$aux_meta.UseResult>(value);
          case Category _: return ValueKey<Category>(value);
          case DocumentationIcon _: return ValueKey<DocumentationIcon>(value);
          case Summary _: return ValueKey<Summary>(value);
          case CachingIterable _: return ValueKey<CachingIterable>(value);
          case Factory _: return ValueKey<Factory>(value);
          case $flutter_6.TextTreeConfiguration _: return ValueKey<$flutter_6.TextTreeConfiguration>(value);
          case TextTreeRenderer _: return ValueKey<TextTreeRenderer>(value);
          case $flutter_6.DiagnosticsNode _: return ValueKey<$flutter_6.DiagnosticsNode>(value);
          case MessageProperty _: return ValueKey<MessageProperty>(value);
          case StringProperty _: return ValueKey<StringProperty>(value);
          case DoubleProperty _: return ValueKey<DoubleProperty>(value);
          case IntProperty _: return ValueKey<IntProperty>(value);
          case PercentProperty _: return ValueKey<PercentProperty>(value);
          case FlagProperty _: return ValueKey<FlagProperty>(value);
          case IterableProperty _: return ValueKey<IterableProperty>(value);
          case EnumProperty _: return ValueKey<EnumProperty>(value);
          case ObjectFlagProperty _: return ValueKey<ObjectFlagProperty>(value);
          case FlagsSummary _: return ValueKey<FlagsSummary>(value);
          case DiagnosticsProperty _: return ValueKey<DiagnosticsProperty>(value);
          case DiagnosticableNode _: return ValueKey<DiagnosticableNode>(value);
          case DiagnosticableTreeNode _: return ValueKey<DiagnosticableTreeNode>(value);
          case $flutter_6.DiagnosticPropertiesBuilder _: return ValueKey<$flutter_6.DiagnosticPropertiesBuilder>(value);
          case $flutter_6.Diagnosticable _: return ValueKey<$flutter_6.Diagnosticable>(value);
          case $flutter_6.DiagnosticableTree _: return ValueKey<$flutter_6.DiagnosticableTree>(value);
          case DiagnosticableTreeMixin _: return ValueKey<DiagnosticableTreeMixin>(value);
          case DiagnosticsBlock _: return ValueKey<DiagnosticsBlock>(value);
          case $flutter_6.DiagnosticsSerializationDelegate _: return ValueKey<$flutter_6.DiagnosticsSerializationDelegate>(value);
          case $flutter_12.StackFrame _: return ValueKey<$flutter_12.StackFrame>(value);
          case $flutter_1.PartialStackFrame _: return ValueKey<$flutter_1.PartialStackFrame>(value);
          case $flutter_1.StackFilter _: return ValueKey<$flutter_1.StackFilter>(value);
          case RepetitiveStackFrameFilter _: return ValueKey<RepetitiveStackFrameFilter>(value);
          case ErrorDescription _: return ValueKey<ErrorDescription>(value);
          case ErrorSummary _: return ValueKey<ErrorSummary>(value);
          case ErrorHint _: return ValueKey<ErrorHint>(value);
          case ErrorSpacer _: return ValueKey<ErrorSpacer>(value);
          case $flutter_1.FlutterErrorDetails _: return ValueKey<$flutter_1.FlutterErrorDetails>(value);
          case FlutterError _: return ValueKey<FlutterError>(value);
          case DiagnosticsStackTrace _: return ValueKey<DiagnosticsStackTrace>(value);
          case BindingBase _: return ValueKey<BindingBase>(value);
          case BitField _: return ValueKey<BitField>(value);
          case $flutter_4.Listenable _: return ValueKey<$flutter_4.Listenable>(value);
          case ValueListenable _: return ValueKey<ValueListenable>(value);
          case $flutter_4.ChangeNotifier _: return ValueKey<$flutter_4.ChangeNotifier>(value);
          case ValueNotifier _: return ValueKey<ValueNotifier>(value);
          case Key _: return ValueKey<Key>(value);
          case LocalKey _: return ValueKey<LocalKey>(value);
          case UniqueKey _: return ValueKey<UniqueKey>(value);
          case $flutter_8.LicenseParagraph _: return ValueKey<$flutter_8.LicenseParagraph>(value);
          case $flutter_8.LicenseEntry _: return ValueKey<$flutter_8.LicenseEntry>(value);
          case LicenseEntryWithLineBreaks _: return ValueKey<LicenseEntryWithLineBreaks>(value);
          case LicenseRegistry _: return ValueKey<LicenseRegistry>(value);
          case $flutter_9.ObjectEvent _: return ValueKey<$flutter_9.ObjectEvent>(value);
          case ObjectCreated _: return ValueKey<ObjectCreated>(value);
          case ObjectDisposed _: return ValueKey<ObjectDisposed>(value);
          case $flutter_9.FlutterMemoryAllocations _: return ValueKey<$flutter_9.FlutterMemoryAllocations>(value);
          case ObserverList _: return ValueKey<ObserverList>(value);
          case HashedObserverList _: return ValueKey<HashedObserverList>(value);
          case $flutter_10.PersistentHashMap _: return ValueKey<$flutter_10.PersistentHashMap>(value);
          case WriteBuffer _: return ValueKey<WriteBuffer>(value);
          case ReadBuffer _: return ValueKey<ReadBuffer>(value);
          case SynchronousFuture _: return ValueKey<SynchronousFuture>(value);
          case FlutterTimeline _: return ValueKey<FlutterTimeline>(value);
          case $flutter_13.TimedBlock _: return ValueKey<$flutter_13.TimedBlock>(value);
          case $flutter_13.AggregatedTimings _: return ValueKey<$flutter_13.AggregatedTimings>(value);
          case $flutter_13.AggregatedTimedBlock _: return ValueKey<$flutter_13.AggregatedTimedBlock>(value);
          case Unicode _: return ValueKey<Unicode>(value);
          default: return ValueKey(value);
        }
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<ValueKey>(target, 'ValueKey').value,
      'hashCode': (visitor, target) => D4.validateTarget<ValueKey>(target, 'ValueKey').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueKey>(target, 'ValueKey');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueKey>(target, 'ValueKey');
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
    nativeType: $flutter_8.LicenseParagraph,
    name: 'LicenseParagraph',
    isAssignable: (v) => v is $flutter_8.LicenseEntry,
    constructors: {
    },
    getters: {
      'packages': (visitor, target) => D4.validateTarget<$flutter_8.LicenseEntry>(target, 'LicenseEntry').packages,
      'paragraphs': (visitor, target) => D4.validateTarget<$flutter_8.LicenseEntry>(target, 'LicenseEntry').paragraphs,
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
    nativeType: LicenseEntryWithLineBreaks,
    name: 'LicenseEntryWithLineBreaks',
    isAssignable: (v) => v is LicenseRegistry,
    constructors: {
    },
    staticGetters: {
      'licenses': (visitor) => LicenseRegistry.licenses,
    },
    staticMethods: {
      'addLicense': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addLicense');
        if (positional.isEmpty) {
          throw ArgumentError('addLicense: Missing required argument "collector" at position 0');
        }
        final collectorRaw = positional[0];
        final collector = () { return D4.callInterpreterCallback(visitor!, collectorRaw, []) as Stream<$flutter_8.LicenseEntry>; };
        return LicenseRegistry.addLicense(collector);
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
    nativeType: $flutter_9.ObjectEvent,
    name: 'ObjectEvent',
    isAssignable: (v) => v is ObjectCreated,
    constructors: {
      '': (visitor, positional, named) {
        final library = D4.getRequiredNamedArg<String>(named, 'library', 'ObjectCreated');
        final className = D4.getRequiredNamedArg<String>(named, 'className', 'ObjectCreated');
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'ObjectCreated');
        return ObjectCreated(library: library, className: className, object: object);
      },
    },
    getters: {
      'object': (visitor, target) => D4.validateTarget<ObjectCreated>(target, 'ObjectCreated').object,
      'library': (visitor, target) => D4.validateTarget<ObjectCreated>(target, 'ObjectCreated').library,
      'className': (visitor, target) => D4.validateTarget<ObjectCreated>(target, 'ObjectCreated').className,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectCreated>(target, 'ObjectCreated');
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
    nativeType: ObjectDisposed,
    name: 'ObjectDisposed',
    isAssignable: (v) => v is $flutter_9.FlutterMemoryAllocations,
    constructors: {
    },
    getters: {
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations').hasListeners,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(($flutter_9.ObjectEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(($flutter_9.ObjectEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'dispatchObjectEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'dispatchObjectEvent');
        final event = D4.getRequiredArg<$flutter_9.ObjectEvent>(positional, 0, 'event', 'dispatchObjectEvent');
        t.dispatchObjectEvent(event);
        return null;
      },
      'dispatchObjectCreated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        final library = D4.getRequiredNamedArg<String>(named, 'library', 'dispatchObjectCreated');
        final className = D4.getRequiredNamedArg<String>(named, 'className', 'dispatchObjectCreated');
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'dispatchObjectCreated');
        t.dispatchObjectCreated(library: library, className: className, object: object);
        return null;
      },
      'dispatchObjectDisposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'dispatchObjectDisposed');
        t.dispatchObjectDisposed(object: object);
        return null;
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_9.FlutterMemoryAllocations.instance,
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
    nativeType: ObserverList,
    name: 'ObserverList',
    isAssignable: (v) => v is HashedObserverList,
    constructors: {
      '': (visitor, positional, named) {
        return HashedObserverList();
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').iterator,
      'isEmpty': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').isNotEmpty,
      'length': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').length,
      'first': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').first,
      'last': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').last,
      'single': (visitor, target) => D4.validateTarget<HashedObserverList>(target, 'HashedObserverList').single,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'remove');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'remove');
        return t.remove(item);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        t.clear();
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<dynamic>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        return t.whereType();
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        return t.toSet();
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HashedObserverList>(target, 'HashedObserverList');
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
      'cast': 'Iterable<dynamic> cast()',
      'followedBy': 'Iterable<T> followedBy(Iterable<T> other)',
      'map': 'Iterable<dynamic> map(dynamic Function(T e) toElement)',
      'where': 'Iterable<T> where(bool Function(T element) test)',
      'whereType': 'Iterable<dynamic> whereType()',
      'expand': 'Iterable<dynamic> expand(Iterable<dynamic> Function(T element) toElements)',
      'forEach': 'void forEach(void Function(T element) action)',
      'reduce': 'T reduce(T Function(T value, T element) combine)',
      'fold': 'dynamic fold(dynamic initialValue, dynamic Function(dynamic previousValue, T element) combine)',
      'every': 'bool every(bool Function(T element) test)',
      'join': 'String join([String separator = ""])',
      'any': 'bool any(bool Function(T element) test)',
      'toSet': 'Set<T> toSet()',
      'take': 'Iterable<T> take(int count)',
      'takeWhile': 'Iterable<T> takeWhile(bool Function(T value) test)',
      'skip': 'Iterable<T> skip(int count)',
      'skipWhile': 'Iterable<T> skipWhile(bool Function(T value) test)',
      'firstWhere': 'T firstWhere(bool Function(T element) test, {T Function() orElse})',
      'lastWhere': 'T lastWhere(bool Function(T element) test, {T Function() orElse})',
      'singleWhere': 'T singleWhere(bool Function(T element) test, {T Function() orElse})',
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
    nativeType: $flutter_10.PersistentHashMap,
    name: 'PersistentHashMap',
    isAssignable: (v) => v is WriteBuffer,
    constructors: {
      '': (visitor, positional, named) {
        final startCapacity = D4.getNamedArgWithDefault<int>(named, 'startCapacity', 8);
        return WriteBuffer(startCapacity: startCapacity);
      },
    },
    methods: {
      'putUint8': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint8');
        final byte = D4.getRequiredArg<int>(positional, 0, 'byte', 'putUint8');
        t.putUint8(byte);
        return null;
      },
      'putUint16': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint16');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putUint16');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putUint16(value, endian: endian);
        return null;
      },
      'putUint32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint32');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putUint32');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putUint32(value, endian: endian);
        return null;
      },
      'putInt32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt32');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putInt32');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putInt32(value, endian: endian);
        return null;
      },
      'putInt64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt64');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putInt64');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putInt64(value, endian: endian);
        return null;
      },
      'putFloat64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat64');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'putFloat64');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putFloat64(value, endian: endian);
        return null;
      },
      'putUint8List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint8List');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'putUint8List');
        t.putUint8List(list);
        return null;
      },
      'putInt32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt32List');
        final list = D4.getRequiredArg<Int32List>(positional, 0, 'list', 'putInt32List');
        t.putInt32List(list);
        return null;
      },
      'putInt64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt64List');
        final list = D4.getRequiredArg<Int64List>(positional, 0, 'list', 'putInt64List');
        t.putInt64List(list);
        return null;
      },
      'putFloat32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat32List');
        final list = D4.getRequiredArg<Float32List>(positional, 0, 'list', 'putFloat32List');
        t.putFloat32List(list);
        return null;
      },
      'putFloat64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat64List');
        final list = D4.getRequiredArg<Float64List>(positional, 0, 'list', 'putFloat64List');
        t.putFloat64List(list);
        return null;
      },
      'done': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<WriteBuffer>(target, 'WriteBuffer');
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
    nativeType: ReadBuffer,
    name: 'ReadBuffer',
    isAssignable: (v) => v is SynchronousFuture,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SynchronousFuture');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'SynchronousFuture');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return SynchronousFuture<double>(value);
          case int _: return SynchronousFuture<int>(value);
          case String _: return SynchronousFuture<String>(value);
          case bool _: return SynchronousFuture<bool>(value);
          case $aux_meta.Immutable _: return SynchronousFuture<$aux_meta.Immutable>(value);
          case RecordUse _: return SynchronousFuture<RecordUse>(value);
          case $aux_meta.UseResult _: return SynchronousFuture<$aux_meta.UseResult>(value);
          case Category _: return SynchronousFuture<Category>(value);
          case DocumentationIcon _: return SynchronousFuture<DocumentationIcon>(value);
          case Summary _: return SynchronousFuture<Summary>(value);
          case CachingIterable _: return SynchronousFuture<CachingIterable>(value);
          case Factory _: return SynchronousFuture<Factory>(value);
          case $flutter_6.TextTreeConfiguration _: return SynchronousFuture<$flutter_6.TextTreeConfiguration>(value);
          case TextTreeRenderer _: return SynchronousFuture<TextTreeRenderer>(value);
          case $flutter_6.DiagnosticsNode _: return SynchronousFuture<$flutter_6.DiagnosticsNode>(value);
          case MessageProperty _: return SynchronousFuture<MessageProperty>(value);
          case StringProperty _: return SynchronousFuture<StringProperty>(value);
          case DoubleProperty _: return SynchronousFuture<DoubleProperty>(value);
          case IntProperty _: return SynchronousFuture<IntProperty>(value);
          case PercentProperty _: return SynchronousFuture<PercentProperty>(value);
          case FlagProperty _: return SynchronousFuture<FlagProperty>(value);
          case IterableProperty _: return SynchronousFuture<IterableProperty>(value);
          case EnumProperty _: return SynchronousFuture<EnumProperty>(value);
          case ObjectFlagProperty _: return SynchronousFuture<ObjectFlagProperty>(value);
          case FlagsSummary _: return SynchronousFuture<FlagsSummary>(value);
          case DiagnosticsProperty _: return SynchronousFuture<DiagnosticsProperty>(value);
          case DiagnosticableNode _: return SynchronousFuture<DiagnosticableNode>(value);
          case DiagnosticableTreeNode _: return SynchronousFuture<DiagnosticableTreeNode>(value);
          case $flutter_6.DiagnosticPropertiesBuilder _: return SynchronousFuture<$flutter_6.DiagnosticPropertiesBuilder>(value);
          case $flutter_6.Diagnosticable _: return SynchronousFuture<$flutter_6.Diagnosticable>(value);
          case $flutter_6.DiagnosticableTree _: return SynchronousFuture<$flutter_6.DiagnosticableTree>(value);
          case DiagnosticableTreeMixin _: return SynchronousFuture<DiagnosticableTreeMixin>(value);
          case DiagnosticsBlock _: return SynchronousFuture<DiagnosticsBlock>(value);
          case $flutter_6.DiagnosticsSerializationDelegate _: return SynchronousFuture<$flutter_6.DiagnosticsSerializationDelegate>(value);
          case $flutter_12.StackFrame _: return SynchronousFuture<$flutter_12.StackFrame>(value);
          case $flutter_1.PartialStackFrame _: return SynchronousFuture<$flutter_1.PartialStackFrame>(value);
          case $flutter_1.StackFilter _: return SynchronousFuture<$flutter_1.StackFilter>(value);
          case RepetitiveStackFrameFilter _: return SynchronousFuture<RepetitiveStackFrameFilter>(value);
          case ErrorDescription _: return SynchronousFuture<ErrorDescription>(value);
          case ErrorSummary _: return SynchronousFuture<ErrorSummary>(value);
          case ErrorHint _: return SynchronousFuture<ErrorHint>(value);
          case ErrorSpacer _: return SynchronousFuture<ErrorSpacer>(value);
          case $flutter_1.FlutterErrorDetails _: return SynchronousFuture<$flutter_1.FlutterErrorDetails>(value);
          case FlutterError _: return SynchronousFuture<FlutterError>(value);
          case DiagnosticsStackTrace _: return SynchronousFuture<DiagnosticsStackTrace>(value);
          case BindingBase _: return SynchronousFuture<BindingBase>(value);
          case BitField _: return SynchronousFuture<BitField>(value);
          case $flutter_4.Listenable _: return SynchronousFuture<$flutter_4.Listenable>(value);
          case ValueListenable _: return SynchronousFuture<ValueListenable>(value);
          case $flutter_4.ChangeNotifier _: return SynchronousFuture<$flutter_4.ChangeNotifier>(value);
          case ValueNotifier _: return SynchronousFuture<ValueNotifier>(value);
          case Key _: return SynchronousFuture<Key>(value);
          case LocalKey _: return SynchronousFuture<LocalKey>(value);
          case UniqueKey _: return SynchronousFuture<UniqueKey>(value);
          case ValueKey _: return SynchronousFuture<ValueKey>(value);
          case $flutter_8.LicenseParagraph _: return SynchronousFuture<$flutter_8.LicenseParagraph>(value);
          case $flutter_8.LicenseEntry _: return SynchronousFuture<$flutter_8.LicenseEntry>(value);
          case LicenseEntryWithLineBreaks _: return SynchronousFuture<LicenseEntryWithLineBreaks>(value);
          case LicenseRegistry _: return SynchronousFuture<LicenseRegistry>(value);
          case $flutter_9.ObjectEvent _: return SynchronousFuture<$flutter_9.ObjectEvent>(value);
          case ObjectCreated _: return SynchronousFuture<ObjectCreated>(value);
          case ObjectDisposed _: return SynchronousFuture<ObjectDisposed>(value);
          case $flutter_9.FlutterMemoryAllocations _: return SynchronousFuture<$flutter_9.FlutterMemoryAllocations>(value);
          case ObserverList _: return SynchronousFuture<ObserverList>(value);
          case HashedObserverList _: return SynchronousFuture<HashedObserverList>(value);
          case $flutter_10.PersistentHashMap _: return SynchronousFuture<$flutter_10.PersistentHashMap>(value);
          case WriteBuffer _: return SynchronousFuture<WriteBuffer>(value);
          case ReadBuffer _: return SynchronousFuture<ReadBuffer>(value);
          case FlutterTimeline _: return SynchronousFuture<FlutterTimeline>(value);
          case $flutter_13.TimedBlock _: return SynchronousFuture<$flutter_13.TimedBlock>(value);
          case $flutter_13.AggregatedTimings _: return SynchronousFuture<$flutter_13.AggregatedTimings>(value);
          case $flutter_13.AggregatedTimedBlock _: return SynchronousFuture<$flutter_13.AggregatedTimedBlock>(value);
          case Unicode _: return SynchronousFuture<Unicode>(value);
          default: return SynchronousFuture(value);
        }
      },
    },
    methods: {
      'asStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SynchronousFuture>(target, 'SynchronousFuture');
        return t.asStream();
      },
      'catchError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'catchError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'catchError');
        final testRaw = named['test'];
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((dynamic p0) { return D4.callInterpreterCallback(visitor, onValueRaw, [p0]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SynchronousFuture>(target, 'SynchronousFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onTimeoutRaw, []) as FutureOr<Object>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SynchronousFuture>(target, 'SynchronousFuture');
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
    nativeType: FlutterTimeline,
    name: 'FlutterTimeline',
        FlutterTimeline.debugCollectionEnabled = D4.extractBridgedArg<bool>(value, 'debugCollectionEnabled'),
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
    nativeType: $flutter_13.TimedBlock,
    name: 'TimedBlock',
    isAssignable: (v) => v is $flutter_13.AggregatedTimings,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AggregatedTimings');
        if (positional.isEmpty) {
          throw ArgumentError('AggregatedTimings: Missing required argument "timedBlocks" at position 0');
        }
        final timedBlocks = D4.coerceList<$flutter_13.TimedBlock>(positional[0], 'timedBlocks');
        return $flutter_13.AggregatedTimings(timedBlocks);
      },
    },
    getters: {
      'timedBlocks': (visitor, target) => D4.validateTarget<$flutter_13.AggregatedTimings>(target, 'AggregatedTimings').timedBlocks,
      'aggregatedBlocks': (visitor, target) => D4.validateTarget<$flutter_13.AggregatedTimings>(target, 'AggregatedTimings').aggregatedBlocks,
    },
    methods: {
      'getAggregated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.AggregatedTimings>(target, 'AggregatedTimings');
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
    nativeType: $flutter_13.AggregatedTimedBlock,
    name: 'AggregatedTimedBlock',
    isAssignable: (v) => v is Unicode,
    constructors: {
    },
    staticGetters: {
      'LRE': (visitor) => Unicode.LRE,
      'RLE': (visitor) => Unicode.RLE,
      'PDF': (visitor) => Unicode.PDF,
      'LRO': (visitor) => Unicode.LRO,
      'RLO': (visitor) => Unicode.RLO,
      'LRI': (visitor) => Unicode.LRI,
      'RLI': (visitor) => Unicode.RLI,
      'FSI': (visitor) => Unicode.FSI,
      'PDI': (visitor) => Unicode.PDI,
      'LRM': (visitor) => Unicode.LRM,
      'RLM': (visitor) => Unicode.RLM,
      'ALM': (visitor) => Unicode.ALM,
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

