// D4rt Bridge - Generated file, do not edit
<<<<<<< Updated upstream
// Sources: 26 files
// Generated: 2026-02-26T16:02:14.604610
=======
// Sources: 28 files
// Generated: 2026-03-12T17:05:03.348155
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      interpreter.registerGlobalVariable('kMaxUnsignedSMI', $flutter_5.kMaxUnsignedSMI, importPath, sourceUri: 'package:flutter/src/foundation/bitfield.dart');
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      interpreter.registerGlobalVariable('debugInstrumentationEnabled', $flutter_11.debugInstrumentationEnabled, importPath, sourceUri: 'package:flutter/src/foundation/debug.dart');
=======
      interpreter.registerGlobalVariable('debugPrint', debugPrint, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\print.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrint": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugInstrumentationEnabled', debugInstrumentationEnabled, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\debug.dart');
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    interpreter.registerGlobalGetter('isCanvasKit', () => $flutter_6.isCanvasKit, importPath, sourceUri: 'package:flutter/src/foundation/capabilities.dart');
    interpreter.registerGlobalGetter('isSkwasm', () => $flutter_6.isSkwasm, importPath, sourceUri: 'package:flutter/src/foundation/capabilities.dart');
    interpreter.registerGlobalGetter('isSkiaWeb', () => $flutter_6.isSkiaWeb, importPath, sourceUri: 'package:flutter/src/foundation/capabilities.dart');
    interpreter.registerGlobalGetter('defaultTargetPlatform', () => $flutter_20.defaultTargetPlatform, importPath, sourceUri: 'package:flutter/src/foundation/platform.dart');
    interpreter.registerGlobalGetter('debugDefaultTargetPlatformOverride', () => $flutter_20.debugDefaultTargetPlatformOverride, importPath, sourceUri: 'package:flutter/src/foundation/platform.dart');
    interpreter.registerGlobalSetter('debugDefaultTargetPlatformOverride', (v) => $flutter_20.debugDefaultTargetPlatformOverride = v as $flutter_20.TargetPlatform?, importPath, sourceUri: 'package:flutter/src/foundation/platform.dart');
=======
    interpreter.registerGlobalGetter('isCanvasKit', () => isCanvasKit, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart');
    interpreter.registerGlobalGetter('isSkwasm', () => isSkwasm, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart');
    interpreter.registerGlobalGetter('isSkiaWeb', () => isSkiaWeb, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\capabilities.dart');
    interpreter.registerGlobalGetter('debugPrintDone', () => debugPrintDone, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\print.dart');
    interpreter.registerGlobalGetter('defaultTargetPlatform', () => defaultTargetPlatform, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart');
    interpreter.registerGlobalGetter('debugDefaultTargetPlatformOverride', () => debugDefaultTargetPlatformOverride, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart');
    interpreter.registerGlobalSetter('debugDefaultTargetPlatformOverride', (v) => debugDefaultTargetPlatformOverride = v as $aux_flutter.TargetPlatform?, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\foundation\platform.dart');
>>>>>>> Stashed changes

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_foundation):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
<<<<<<< Updated upstream
=======
      'lerpDuration': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpDuration');
        final a = D4.getRequiredArg<Duration>(positional, 0, 'a', 'lerpDuration');
        final b = D4.getRequiredArg<Duration>(positional, 1, 'b', 'lerpDuration');
        final t = D4.getRequiredArg<double>(positional, 2, 't', 'lerpDuration');
        return lerpDuration(a, b, t);
      },
      'shortHash': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'shortHash');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'shortHash');
        return shortHash(object);
      },
      'describeIdentity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'describeIdentity');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'describeIdentity');
        return describeIdentity(object);
      },
>>>>>>> Stashed changes
      'debugPrintStack': (visitor, positional, named, typeArgs) {
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final maxFrames = D4.getOptionalNamedArg<int?>(named, 'maxFrames');
        return debugPrintStack(stackTrace: stackTrace, label: label, maxFrames: maxFrames);
      },
      'setEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setEquals');
        final a = D4.getRequiredArg<Set<dynamic>?>(positional, 0, 'a', 'setEquals');
        final b = D4.getRequiredArg<Set<dynamic>?>(positional, 1, 'b', 'setEquals');
        return setEquals<dynamic>(a, b);
      },
      'listEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'listEquals');
        final a = D4.getRequiredArg<List<dynamic>?>(positional, 0, 'a', 'listEquals');
        final b = D4.getRequiredArg<List<dynamic>?>(positional, 1, 'b', 'listEquals');
        return listEquals<dynamic>(a, b);
      },
      'mapEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapEquals');
        final a = D4.getRequiredArg<Map<dynamic, dynamic>?>(positional, 0, 'a', 'mapEquals');
        final b = D4.getRequiredArg<Map<dynamic, dynamic>?>(positional, 1, 'b', 'mapEquals');
        return mapEquals<dynamic, dynamic>(a, b);
      },
      'binarySearch': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'binarySearch');
        final sortedList = D4.getRequiredArg<List<Comparable<Object>>>(positional, 0, 'sortedList', 'binarySearch');
        final value = D4.getRequiredArg<Comparable<Object>>(positional, 1, 'value', 'binarySearch');
        return binarySearch(sortedList, value);
      },
      'mergeSort': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'mergeSort');
        final list = D4.getRequiredArg<List<dynamic>>(positional, 0, 'list', 'mergeSort');
        final start = D4.getNamedArgWithDefault<int>(named, 'start', 0);
        final end = D4.getOptionalNamedArg<int?>(named, 'end');
        final compareRaw = named['compare'];
<<<<<<< Updated upstream
        final compare = compareRaw == null ? null : (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, compareRaw, [p0, p1]) as int; };
        return $flutter_8.mergeSort<dynamic>(list, start: start, end: end, compare: compare);
=======
        final compare = compareRaw == null ? null : (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor!, compareRaw, [p0, p1]) as int; };
        return mergeSort<dynamic>(list, start: start, end: end, compare: compare);
>>>>>>> Stashed changes
      },
      'consolidateHttpClientResponseBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'consolidateHttpClientResponseBytes');
        final response = D4.getRequiredArg<HttpClientResponse>(positional, 0, 'response', 'consolidateHttpClientResponseBytes');
        final autoUncompress = D4.getNamedArgWithDefault<bool>(named, 'autoUncompress', true);
        final onBytesReceivedRaw = named['onBytesReceived'];
<<<<<<< Updated upstream
        final onBytesReceived = onBytesReceivedRaw == null ? null : (int p0, int? p1) { D4.callInterpreterCallback(visitor, onBytesReceivedRaw, [p0, p1]); };
        return $flutter_9.consolidateHttpClientResponseBytes(response, autoUncompress: autoUncompress, onBytesReceived: onBytesReceived);
      },
=======
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
>>>>>>> Stashed changes
      'debugAssertAllFoundationVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllFoundationVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllFoundationVarsUnset');
        if (!named.containsKey('debugPrintOverride')) {
          return debugAssertAllFoundationVarsUnset(reason);
        }
        if (named.containsKey('debugPrintOverride')) {
          final debugPrintOverrideRaw = named['debugPrintOverride'];
<<<<<<< Updated upstream
          final debugPrintOverride = (String? p0, {int? wrapWidth}) { D4.callInterpreterCallback(visitor, debugPrintOverrideRaw, [p0], {'wrapWidth': wrapWidth}); };
          return $flutter_11.debugAssertAllFoundationVarsUnset(reason, debugPrintOverride: debugPrintOverride);
=======
          final debugPrintOverride = (String? p0, {int? wrapWidth}) { D4.callInterpreterCallback(visitor!, debugPrintOverrideRaw, [p0], {'wrapWidth': wrapWidth}); };
          return debugAssertAllFoundationVarsUnset(reason, debugPrintOverride: debugPrintOverride);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        final action = () { return D4.callInterpreterCallback(visitor, actionRaw, []) as Future<dynamic>; };
        return $flutter_11.debugInstrumentAction<dynamic>(description, action);
=======
        final action = () { return D4.callInterpreterCallback(visitor!, actionRaw, []) as Future<dynamic>; };
        return debugInstrumentAction<dynamic>(description, action);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Category,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Category');
        if (positional.isEmpty) {
          throw ArgumentError('Category: Missing required argument "sections" at position 0');
        }
        final sections = D4.coerceList<String>(positional[0], 'sections');
        return Category(sections);
      },
    },
    getters: {
      'sections': (visitor, target) => D4.validateTarget<Category>(target, 'Category').sections,
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
    nativeType: DocumentationIcon,
    name: 'DocumentationIcon',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is DocumentationIcon,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Summary,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Summary');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'Summary');
        return Summary(text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<Summary>(target, 'Summary').text,
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
<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes
// DiagnosticsNode Bridge
// =============================================================================

BridgedClass _createDiagnosticsNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_6.DiagnosticsNode,
    name: 'DiagnosticsNode',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_6.DiagnosticsNode,
>>>>>>> Stashed changes
    constructors: {
      'message': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsNode');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DiagnosticsNode');
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        return $flutter_6.DiagnosticsNode.message(message, style: style, level: level, allowWrap: allowWrap);
      },
    },
    getters: {
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
// MessageProperty Bridge
// =============================================================================

BridgedClass _createMessagePropertyBridge() {
  return BridgedClass(
    nativeType: MessageProperty,
    name: 'MessageProperty',
    isAssignable: (v) => v is MessageProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'MessageProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MessageProperty');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'MessageProperty');
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        return MessageProperty(name, message, style: style, level: level);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').level,
      'showName': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').value,
      'style': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<MessageProperty>(target, 'MessageProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MessageProperty>(target, 'MessageProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: StringProperty,
    name: 'StringProperty',
    isAssignable: (v) => v is StringProperty,
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
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return StringProperty(name, value, description: description, tooltip: tooltip, showName: showName, quoted: quoted, ifEmpty: ifEmpty, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'StringProperty');
          return StringProperty(name, value, description: description, tooltip: tooltip, showName: showName, quoted: quoted, ifEmpty: ifEmpty, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').level,
      'showName': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').value,
      'style': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').isInteresting,
      'quoted': (visitor, target) => D4.validateTarget<StringProperty>(target, 'StringProperty').quoted,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StringProperty>(target, 'StringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: DoubleProperty,
    name: 'DoubleProperty',
    isAssignable: (v) => v is DoubleProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DoubleProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DoubleProperty');
        final value = D4.getRequiredArg<double?>(positional, 1, 'value', 'DoubleProperty');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return DoubleProperty(name, value, ifNull: ifNull, unit: unit, tooltip: tooltip, showName: showName, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DoubleProperty');
          return DoubleProperty(name, value, ifNull: ifNull, unit: unit, tooltip: tooltip, showName: showName, style: style, level: level, defaultValue: defaultValue);
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
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return DoubleProperty.lazy(name, () { return D4.callInterpreterCallback(visitor!, computeValueRaw, []) as double?; }, ifNull: ifNull, showName: showName, unit: unit, tooltip: tooltip, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DoubleProperty');
          return DoubleProperty.lazy(name, () { return D4.callInterpreterCallback(visitor!, computeValueRaw, []) as double?; }, ifNull: ifNull, showName: showName, unit: unit, tooltip: tooltip, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'unit': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').unit,
      'expandableValue': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').value,
      'exception': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').level,
      'name': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<DoubleProperty>(target, 'DoubleProperty').textTreeConfiguration,
    },
    methods: {
      'numberToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        return t.numberToString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DoubleProperty>(target, 'DoubleProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: IntProperty,
    name: 'IntProperty',
    isAssignable: (v) => v is IntProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'IntProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'IntProperty');
        final value = D4.getRequiredArg<int?>(positional, 1, 'value', 'IntProperty');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return IntProperty(name, value, ifNull: ifNull, showName: showName, unit: unit, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'IntProperty');
          return IntProperty(name, value, ifNull: ifNull, showName: showName, unit: unit, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'unit': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').unit,
      'expandableValue': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').value,
      'exception': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').level,
      'name': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<IntProperty>(target, 'IntProperty').textTreeConfiguration,
    },
    methods: {
      'numberToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        return t.numberToString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntProperty>(target, 'IntProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: PercentProperty,
    name: 'PercentProperty',
    isAssignable: (v) => v is PercentProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PercentProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PercentProperty');
        final fraction = D4.getRequiredArg<double?>(positional, 1, 'fraction', 'PercentProperty');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final unit = D4.getOptionalNamedArg<String?>(named, 'unit');
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        return PercentProperty(name, fraction, ifNull: ifNull, showName: showName, tooltip: tooltip, unit: unit, level: level);
      },
    },
    getters: {
      'unit': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').unit,
      'expandableValue': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').value,
      'exception': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').level,
      'name': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<PercentProperty>(target, 'PercentProperty').textTreeConfiguration,
    },
    methods: {
      'numberToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        return t.numberToString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PercentProperty>(target, 'PercentProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: FlagProperty,
    name: 'FlagProperty',
    isAssignable: (v) => v is FlagProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlagProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'FlagProperty');
        final value = D4.getRequiredNamedArg<bool?>(named, 'value', 'FlagProperty');
        final ifTrue = D4.getOptionalNamedArg<String?>(named, 'ifTrue');
        final ifFalse = D4.getOptionalNamedArg<String?>(named, 'ifFalse');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', false);
        final defaultValue = D4.getOptionalNamedArg<Object?>(named, 'defaultValue');
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        return FlagProperty(name, value: value, ifTrue: ifTrue, ifFalse: ifFalse, showName: showName, defaultValue: defaultValue, level: level);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').level,
      'showName': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').value,
      'style': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').isInteresting,
      'ifTrue': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').ifTrue,
      'ifFalse': (visitor, target) => D4.validateTarget<FlagProperty>(target, 'FlagProperty').ifFalse,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagProperty>(target, 'FlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: IterableProperty,
    name: 'IterableProperty',
    isAssignable: (v) => v is IterableProperty,
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
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return IterableProperty(name, value, ifNull: ifNull, ifEmpty: ifEmpty, style: style, showName: showName, showSeparator: showSeparator, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'IterableProperty');
          return IterableProperty(name, value, ifNull: ifNull, ifEmpty: ifEmpty, style: style, showName: showName, showSeparator: showSeparator, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').level,
      'showName': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').value,
      'style': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<IterableProperty>(target, 'IterableProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IterableProperty>(target, 'IterableProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: EnumProperty,
    name: 'EnumProperty',
    isAssignable: (v) => v is EnumProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EnumProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'EnumProperty');
        final value = D4.getRequiredArg<Enum?>(positional, 1, 'value', 'EnumProperty');
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return EnumProperty(name, value, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'EnumProperty');
          return EnumProperty(name, value, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').level,
      'showName': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').value,
      'style': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<EnumProperty>(target, 'EnumProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EnumProperty>(target, 'EnumProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: ObjectFlagProperty,
    name: 'ObjectFlagProperty',
    isAssignable: (v) => v is ObjectFlagProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ObjectFlagProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ObjectFlagProperty');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'ObjectFlagProperty');
        final ifPresent = D4.getOptionalNamedArg<String?>(named, 'ifPresent');
        final ifNull = D4.getOptionalNamedArg<String?>(named, 'ifNull');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', false);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return ObjectFlagProperty<double>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case int _: return ObjectFlagProperty<int>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case String _: return ObjectFlagProperty<String>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case bool _: return ObjectFlagProperty<bool>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $aux_meta.Immutable _: return ObjectFlagProperty<$aux_meta.Immutable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case RecordUse _: return ObjectFlagProperty<RecordUse>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $aux_meta.UseResult _: return ObjectFlagProperty<$aux_meta.UseResult>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case Category _: return ObjectFlagProperty<Category>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DocumentationIcon _: return ObjectFlagProperty<DocumentationIcon>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case Summary _: return ObjectFlagProperty<Summary>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case CachingIterable _: return ObjectFlagProperty<CachingIterable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case Factory _: return ObjectFlagProperty<Factory>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_6.TextTreeConfiguration _: return ObjectFlagProperty<$flutter_6.TextTreeConfiguration>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case TextTreeRenderer _: return ObjectFlagProperty<TextTreeRenderer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_6.DiagnosticsNode _: return ObjectFlagProperty<$flutter_6.DiagnosticsNode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case MessageProperty _: return ObjectFlagProperty<MessageProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case StringProperty _: return ObjectFlagProperty<StringProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DoubleProperty _: return ObjectFlagProperty<DoubleProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case IntProperty _: return ObjectFlagProperty<IntProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case PercentProperty _: return ObjectFlagProperty<PercentProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case FlagProperty _: return ObjectFlagProperty<FlagProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case IterableProperty _: return ObjectFlagProperty<IterableProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case EnumProperty _: return ObjectFlagProperty<EnumProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case FlagsSummary _: return ObjectFlagProperty<FlagsSummary>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DiagnosticsProperty _: return ObjectFlagProperty<DiagnosticsProperty>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DiagnosticableNode _: return ObjectFlagProperty<DiagnosticableNode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DiagnosticableTreeNode _: return ObjectFlagProperty<DiagnosticableTreeNode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_6.DiagnosticPropertiesBuilder _: return ObjectFlagProperty<$flutter_6.DiagnosticPropertiesBuilder>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_6.Diagnosticable _: return ObjectFlagProperty<$flutter_6.Diagnosticable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_6.DiagnosticableTree _: return ObjectFlagProperty<$flutter_6.DiagnosticableTree>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DiagnosticableTreeMixin _: return ObjectFlagProperty<DiagnosticableTreeMixin>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DiagnosticsBlock _: return ObjectFlagProperty<DiagnosticsBlock>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_6.DiagnosticsSerializationDelegate _: return ObjectFlagProperty<$flutter_6.DiagnosticsSerializationDelegate>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_12.StackFrame _: return ObjectFlagProperty<$flutter_12.StackFrame>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_1.PartialStackFrame _: return ObjectFlagProperty<$flutter_1.PartialStackFrame>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_1.StackFilter _: return ObjectFlagProperty<$flutter_1.StackFilter>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case RepetitiveStackFrameFilter _: return ObjectFlagProperty<RepetitiveStackFrameFilter>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ErrorDescription _: return ObjectFlagProperty<ErrorDescription>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ErrorSummary _: return ObjectFlagProperty<ErrorSummary>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ErrorHint _: return ObjectFlagProperty<ErrorHint>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ErrorSpacer _: return ObjectFlagProperty<ErrorSpacer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_1.FlutterErrorDetails _: return ObjectFlagProperty<$flutter_1.FlutterErrorDetails>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case FlutterError _: return ObjectFlagProperty<FlutterError>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case DiagnosticsStackTrace _: return ObjectFlagProperty<DiagnosticsStackTrace>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case BindingBase _: return ObjectFlagProperty<BindingBase>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case BitField _: return ObjectFlagProperty<BitField>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_4.Listenable _: return ObjectFlagProperty<$flutter_4.Listenable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ValueListenable _: return ObjectFlagProperty<ValueListenable>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_4.ChangeNotifier _: return ObjectFlagProperty<$flutter_4.ChangeNotifier>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ValueNotifier _: return ObjectFlagProperty<ValueNotifier>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case Key _: return ObjectFlagProperty<Key>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case LocalKey _: return ObjectFlagProperty<LocalKey>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case UniqueKey _: return ObjectFlagProperty<UniqueKey>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ValueKey _: return ObjectFlagProperty<ValueKey>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_8.LicenseParagraph _: return ObjectFlagProperty<$flutter_8.LicenseParagraph>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_8.LicenseEntry _: return ObjectFlagProperty<$flutter_8.LicenseEntry>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case LicenseEntryWithLineBreaks _: return ObjectFlagProperty<LicenseEntryWithLineBreaks>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case LicenseRegistry _: return ObjectFlagProperty<LicenseRegistry>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_9.ObjectEvent _: return ObjectFlagProperty<$flutter_9.ObjectEvent>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ObjectCreated _: return ObjectFlagProperty<ObjectCreated>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ObjectDisposed _: return ObjectFlagProperty<ObjectDisposed>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_9.FlutterMemoryAllocations _: return ObjectFlagProperty<$flutter_9.FlutterMemoryAllocations>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ObserverList _: return ObjectFlagProperty<ObserverList>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case HashedObserverList _: return ObjectFlagProperty<HashedObserverList>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_10.PersistentHashMap _: return ObjectFlagProperty<$flutter_10.PersistentHashMap>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case WriteBuffer _: return ObjectFlagProperty<WriteBuffer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case ReadBuffer _: return ObjectFlagProperty<ReadBuffer>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case SynchronousFuture _: return ObjectFlagProperty<SynchronousFuture>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case FlutterTimeline _: return ObjectFlagProperty<FlutterTimeline>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_13.TimedBlock _: return ObjectFlagProperty<$flutter_13.TimedBlock>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_13.AggregatedTimings _: return ObjectFlagProperty<$flutter_13.AggregatedTimings>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case $flutter_13.AggregatedTimedBlock _: return ObjectFlagProperty<$flutter_13.AggregatedTimedBlock>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          case Unicode _: return ObjectFlagProperty<Unicode>(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
          default: return ObjectFlagProperty(name, value, ifPresent: ifPresent, ifNull: ifNull, showName: showName, level: level);
        }
      },
      'has': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ObjectFlagProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ObjectFlagProperty');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'ObjectFlagProperty');
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return ObjectFlagProperty<double>.has(name, value, level: level);
          case int _: return ObjectFlagProperty<int>.has(name, value, level: level);
          case String _: return ObjectFlagProperty<String>.has(name, value, level: level);
          case bool _: return ObjectFlagProperty<bool>.has(name, value, level: level);
          case $aux_meta.Immutable _: return ObjectFlagProperty<$aux_meta.Immutable>.has(name, value, level: level);
          case RecordUse _: return ObjectFlagProperty<RecordUse>.has(name, value, level: level);
          case $aux_meta.UseResult _: return ObjectFlagProperty<$aux_meta.UseResult>.has(name, value, level: level);
          case Category _: return ObjectFlagProperty<Category>.has(name, value, level: level);
          case DocumentationIcon _: return ObjectFlagProperty<DocumentationIcon>.has(name, value, level: level);
          case Summary _: return ObjectFlagProperty<Summary>.has(name, value, level: level);
          case CachingIterable _: return ObjectFlagProperty<CachingIterable>.has(name, value, level: level);
          case Factory _: return ObjectFlagProperty<Factory>.has(name, value, level: level);
          case $flutter_6.TextTreeConfiguration _: return ObjectFlagProperty<$flutter_6.TextTreeConfiguration>.has(name, value, level: level);
          case TextTreeRenderer _: return ObjectFlagProperty<TextTreeRenderer>.has(name, value, level: level);
          case $flutter_6.DiagnosticsNode _: return ObjectFlagProperty<$flutter_6.DiagnosticsNode>.has(name, value, level: level);
          case MessageProperty _: return ObjectFlagProperty<MessageProperty>.has(name, value, level: level);
          case StringProperty _: return ObjectFlagProperty<StringProperty>.has(name, value, level: level);
          case DoubleProperty _: return ObjectFlagProperty<DoubleProperty>.has(name, value, level: level);
          case IntProperty _: return ObjectFlagProperty<IntProperty>.has(name, value, level: level);
          case PercentProperty _: return ObjectFlagProperty<PercentProperty>.has(name, value, level: level);
          case FlagProperty _: return ObjectFlagProperty<FlagProperty>.has(name, value, level: level);
          case IterableProperty _: return ObjectFlagProperty<IterableProperty>.has(name, value, level: level);
          case EnumProperty _: return ObjectFlagProperty<EnumProperty>.has(name, value, level: level);
          case FlagsSummary _: return ObjectFlagProperty<FlagsSummary>.has(name, value, level: level);
          case DiagnosticsProperty _: return ObjectFlagProperty<DiagnosticsProperty>.has(name, value, level: level);
          case DiagnosticableNode _: return ObjectFlagProperty<DiagnosticableNode>.has(name, value, level: level);
          case DiagnosticableTreeNode _: return ObjectFlagProperty<DiagnosticableTreeNode>.has(name, value, level: level);
          case $flutter_6.DiagnosticPropertiesBuilder _: return ObjectFlagProperty<$flutter_6.DiagnosticPropertiesBuilder>.has(name, value, level: level);
          case $flutter_6.Diagnosticable _: return ObjectFlagProperty<$flutter_6.Diagnosticable>.has(name, value, level: level);
          case $flutter_6.DiagnosticableTree _: return ObjectFlagProperty<$flutter_6.DiagnosticableTree>.has(name, value, level: level);
          case DiagnosticableTreeMixin _: return ObjectFlagProperty<DiagnosticableTreeMixin>.has(name, value, level: level);
          case DiagnosticsBlock _: return ObjectFlagProperty<DiagnosticsBlock>.has(name, value, level: level);
          case $flutter_6.DiagnosticsSerializationDelegate _: return ObjectFlagProperty<$flutter_6.DiagnosticsSerializationDelegate>.has(name, value, level: level);
          case $flutter_12.StackFrame _: return ObjectFlagProperty<$flutter_12.StackFrame>.has(name, value, level: level);
          case $flutter_1.PartialStackFrame _: return ObjectFlagProperty<$flutter_1.PartialStackFrame>.has(name, value, level: level);
          case $flutter_1.StackFilter _: return ObjectFlagProperty<$flutter_1.StackFilter>.has(name, value, level: level);
          case RepetitiveStackFrameFilter _: return ObjectFlagProperty<RepetitiveStackFrameFilter>.has(name, value, level: level);
          case ErrorDescription _: return ObjectFlagProperty<ErrorDescription>.has(name, value, level: level);
          case ErrorSummary _: return ObjectFlagProperty<ErrorSummary>.has(name, value, level: level);
          case ErrorHint _: return ObjectFlagProperty<ErrorHint>.has(name, value, level: level);
          case ErrorSpacer _: return ObjectFlagProperty<ErrorSpacer>.has(name, value, level: level);
          case $flutter_1.FlutterErrorDetails _: return ObjectFlagProperty<$flutter_1.FlutterErrorDetails>.has(name, value, level: level);
          case FlutterError _: return ObjectFlagProperty<FlutterError>.has(name, value, level: level);
          case DiagnosticsStackTrace _: return ObjectFlagProperty<DiagnosticsStackTrace>.has(name, value, level: level);
          case BindingBase _: return ObjectFlagProperty<BindingBase>.has(name, value, level: level);
          case BitField _: return ObjectFlagProperty<BitField>.has(name, value, level: level);
          case $flutter_4.Listenable _: return ObjectFlagProperty<$flutter_4.Listenable>.has(name, value, level: level);
          case ValueListenable _: return ObjectFlagProperty<ValueListenable>.has(name, value, level: level);
          case $flutter_4.ChangeNotifier _: return ObjectFlagProperty<$flutter_4.ChangeNotifier>.has(name, value, level: level);
          case ValueNotifier _: return ObjectFlagProperty<ValueNotifier>.has(name, value, level: level);
          case Key _: return ObjectFlagProperty<Key>.has(name, value, level: level);
          case LocalKey _: return ObjectFlagProperty<LocalKey>.has(name, value, level: level);
          case UniqueKey _: return ObjectFlagProperty<UniqueKey>.has(name, value, level: level);
          case ValueKey _: return ObjectFlagProperty<ValueKey>.has(name, value, level: level);
          case $flutter_8.LicenseParagraph _: return ObjectFlagProperty<$flutter_8.LicenseParagraph>.has(name, value, level: level);
          case $flutter_8.LicenseEntry _: return ObjectFlagProperty<$flutter_8.LicenseEntry>.has(name, value, level: level);
          case LicenseEntryWithLineBreaks _: return ObjectFlagProperty<LicenseEntryWithLineBreaks>.has(name, value, level: level);
          case LicenseRegistry _: return ObjectFlagProperty<LicenseRegistry>.has(name, value, level: level);
          case $flutter_9.ObjectEvent _: return ObjectFlagProperty<$flutter_9.ObjectEvent>.has(name, value, level: level);
          case ObjectCreated _: return ObjectFlagProperty<ObjectCreated>.has(name, value, level: level);
          case ObjectDisposed _: return ObjectFlagProperty<ObjectDisposed>.has(name, value, level: level);
          case $flutter_9.FlutterMemoryAllocations _: return ObjectFlagProperty<$flutter_9.FlutterMemoryAllocations>.has(name, value, level: level);
          case ObserverList _: return ObjectFlagProperty<ObserverList>.has(name, value, level: level);
          case HashedObserverList _: return ObjectFlagProperty<HashedObserverList>.has(name, value, level: level);
          case $flutter_10.PersistentHashMap _: return ObjectFlagProperty<$flutter_10.PersistentHashMap>.has(name, value, level: level);
          case WriteBuffer _: return ObjectFlagProperty<WriteBuffer>.has(name, value, level: level);
          case ReadBuffer _: return ObjectFlagProperty<ReadBuffer>.has(name, value, level: level);
          case SynchronousFuture _: return ObjectFlagProperty<SynchronousFuture>.has(name, value, level: level);
          case FlutterTimeline _: return ObjectFlagProperty<FlutterTimeline>.has(name, value, level: level);
          case $flutter_13.TimedBlock _: return ObjectFlagProperty<$flutter_13.TimedBlock>.has(name, value, level: level);
          case $flutter_13.AggregatedTimings _: return ObjectFlagProperty<$flutter_13.AggregatedTimings>.has(name, value, level: level);
          case $flutter_13.AggregatedTimedBlock _: return ObjectFlagProperty<$flutter_13.AggregatedTimedBlock>.has(name, value, level: level);
          case Unicode _: return ObjectFlagProperty<Unicode>.has(name, value, level: level);
          default: return ObjectFlagProperty.has(name, value, level: level);
        }
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').level,
      'showName': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').value,
      'style': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').isInteresting,
      'ifPresent': (visitor, target) => D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty').ifPresent,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectFlagProperty>(target, 'ObjectFlagProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: FlagsSummary,
    name: 'FlagsSummary',
    isAssignable: (v) => v is FlagsSummary,
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
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        return FlagsSummary(name, value, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, level: level);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').name,
      'showSeparator': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').showSeparator,
      'level': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').level,
      'showName': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').value,
      'style': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').style,
      'allowWrap': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').propertyType,
      'exception': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<FlagsSummary>(target, 'FlagsSummary').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlagsSummary>(target, 'FlagsSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: DiagnosticsProperty,
    name: 'DiagnosticsProperty',
    isAssignable: (v) => v is DiagnosticsProperty,
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
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return DiagnosticsProperty(name, value, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, linePrefix: linePrefix, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DiagnosticsProperty');
          return DiagnosticsProperty(name, value, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, linePrefix: linePrefix, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level, defaultValue: defaultValue);
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
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return DiagnosticsProperty.lazy(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, computeValueRaw, [])); }, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'DiagnosticsProperty');
          return DiagnosticsProperty.lazy(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, computeValueRaw, [])); }, description: description, ifNull: ifNull, ifEmpty: ifEmpty, showName: showName, showSeparator: showSeparator, tooltip: tooltip, missingIfNull: missingIfNull, expandableValue: expandableValue, allowWrap: allowWrap, allowNameWrap: allowNameWrap, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').showSeparator,
      'level': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').level,
      'showName': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').value,
      'style': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').style,
      'allowWrap': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').textTreeConfiguration,
      'expandableValue': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').expandableValue,
      'ifNull': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').propertyType,
      'exception': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty').isInteresting,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsProperty>(target, 'DiagnosticsProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
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
    nativeType: DiagnosticableNode,
    name: 'DiagnosticableNode',
    isAssignable: (v) => v is DiagnosticableNode,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final value = D4.getRequiredNamedArg<$flutter_6.Diagnosticable>(named, 'value', 'DiagnosticableNode');
        final style = D4.getRequiredNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style', 'DiagnosticableNode');
        return DiagnosticableNode(name: name, value: value, style: style);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').level,
      'showName': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').value,
      'style': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').textTreeConfiguration,
      'builder': (visitor, target) => D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode').builder,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableNode>(target, 'DiagnosticableNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: DiagnosticableTreeNode,
    name: 'DiagnosticableTreeNode',
    isAssignable: (v) => v is DiagnosticableTreeNode,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final value = D4.getRequiredNamedArg<$flutter_6.DiagnosticableTree>(named, 'value', 'DiagnosticableTreeNode');
        final style = D4.getRequiredNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style', 'DiagnosticableTreeNode');
        return DiagnosticableTreeNode(name: name, value: value, style: style);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').level,
      'showName': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').value,
      'style': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').textTreeConfiguration,
      'builder': (visitor, target) => D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode').builder,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeNode>(target, 'DiagnosticableTreeNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
>>>>>>> Stashed changes
// DiagnosticPropertiesBuilder Bridge
// =============================================================================

BridgedClass _createDiagnosticPropertiesBuilderBridge() {
  return BridgedClass(
    nativeType: $flutter_6.DiagnosticPropertiesBuilder,
    name: 'DiagnosticPropertiesBuilder',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_6.DiagnosticPropertiesBuilder,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = value as $flutter_12.DiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = value as String?,
=======
        D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = D4.extractBridgedArg<$flutter_6.DiagnosticsTreeStyle>(value, 'defaultDiagnosticsTreeStyle'),
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = D4.extractBridgedArgOrNull<String>(value, 'emptyBodyDescription'),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
// Diagnosticable Bridge
// =============================================================================

BridgedClass _createDiagnosticableBridge() {
  return BridgedClass(
    nativeType: $flutter_6.Diagnosticable,
    name: 'Diagnosticable',
    isAssignable: (v) => v is $flutter_6.Diagnosticable,
    constructors: {
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Diagnosticable>(target, 'Diagnosticable');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Diagnosticable>(target, 'Diagnosticable');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Diagnosticable>(target, 'Diagnosticable');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Diagnosticable>(target, 'Diagnosticable');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
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
    nativeType: $flutter_6.DiagnosticableTree,
    name: 'DiagnosticableTree',
    isAssignable: (v) => v is $flutter_6.DiagnosticableTree,
    constructors: {
    },
    methods: {
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticableTree>(target, 'DiagnosticableTree');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
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
    nativeType: DiagnosticableTreeMixin,
    name: 'DiagnosticableTreeMixin',
    isAssignable: (v) => v is DiagnosticableTreeMixin,
    constructors: {
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_6.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        return t.debugDescribeChildren();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticableTreeMixin>(target, 'DiagnosticableTreeMixin');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
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
    nativeType: DiagnosticsBlock,
    name: 'DiagnosticsBlock',
    isAssignable: (v) => v is DiagnosticsBlock,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getNamedArgWithDefault<$flutter_6.DiagnosticsTreeStyle>(named, 'style', $flutter_6.DiagnosticsTreeStyle.whitespace);
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
        final linePrefix = D4.getOptionalNamedArg<String?>(named, 'linePrefix');
        final value = D4.getOptionalNamedArg<Object?>(named, 'value');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final level = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'level', $flutter_6.DiagnosticLevel.info);
        final allowTruncate = D4.getNamedArgWithDefault<bool>(named, 'allowTruncate', false);
        final children = named.containsKey('children') && named['children'] != null
            ? D4.coerceList<$flutter_6.DiagnosticsNode>(named['children'], 'children')
            : const <$flutter_6.DiagnosticsNode>[];
        final properties = named.containsKey('properties') && named['properties'] != null
            ? D4.coerceList<$flutter_6.DiagnosticsNode>(named['properties'], 'properties')
            : const <$flutter_6.DiagnosticsNode>[];
        return DiagnosticsBlock(name: name, style: style, showName: showName, showSeparator: showSeparator, linePrefix: linePrefix, value: value, description: description, level: level, allowTruncate: allowTruncate, children: children, properties: properties);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').name,
      'showSeparator': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').showSeparator,
      'level': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').level,
      'showName': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').value,
      'style': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').style,
      'allowWrap': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock').textTreeConfiguration,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsBlock>(target, 'DiagnosticsBlock');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: $flutter_6.DiagnosticsSerializationDelegate,
    name: 'DiagnosticsSerializationDelegate',
    isAssignable: (v) => v is $flutter_6.DiagnosticsSerializationDelegate,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('subtreeDepth') && !named.containsKey('includeProperties')) {
          return $flutter_6.DiagnosticsSerializationDelegate();
        }
        if (named.containsKey('subtreeDepth') && !named.containsKey('includeProperties')) {
          final subtreeDepth = D4.getRequiredNamedArg<int>(named, 'subtreeDepth', 'DiagnosticsSerializationDelegate');
          return $flutter_6.DiagnosticsSerializationDelegate(subtreeDepth: subtreeDepth);
        }
        if (!named.containsKey('subtreeDepth') && named.containsKey('includeProperties')) {
          final includeProperties = D4.getRequiredNamedArg<bool>(named, 'includeProperties', 'DiagnosticsSerializationDelegate');
          return $flutter_6.DiagnosticsSerializationDelegate(includeProperties: includeProperties);
        }
        if (named.containsKey('subtreeDepth') && named.containsKey('includeProperties')) {
          final subtreeDepth = D4.getRequiredNamedArg<int>(named, 'subtreeDepth', 'DiagnosticsSerializationDelegate');
          final includeProperties = D4.getRequiredNamedArg<bool>(named, 'includeProperties', 'DiagnosticsSerializationDelegate');
          return $flutter_6.DiagnosticsSerializationDelegate(subtreeDepth: subtreeDepth, includeProperties: includeProperties);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'subtreeDepth': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate').subtreeDepth,
      'includeProperties': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate').includeProperties,
      'expandPropertyValues': (visitor, target) => D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate').expandPropertyValues,
    },
    methods: {
      'additionalNodeProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 1, 'additionalNodeProperties');
        final node = D4.getRequiredArg<$flutter_6.DiagnosticsNode>(positional, 0, 'node', 'additionalNodeProperties');
        final fullDetails = D4.getNamedArgWithDefault<bool>(named, 'fullDetails', true);
        return t.additionalNodeProperties(node, fullDetails: fullDetails);
      },
      'filterChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 2, 'filterChildren');
        if (positional.isEmpty) {
          throw ArgumentError('filterChildren: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceList<$flutter_6.DiagnosticsNode>(positional[0], 'nodes');
        final owner = D4.getRequiredArg<$flutter_6.DiagnosticsNode>(positional, 1, 'owner', 'filterChildren');
        return t.filterChildren(nodes, owner);
      },
      'filterProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 2, 'filterProperties');
        if (positional.isEmpty) {
          throw ArgumentError('filterProperties: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceList<$flutter_6.DiagnosticsNode>(positional[0], 'nodes');
        final owner = D4.getRequiredArg<$flutter_6.DiagnosticsNode>(positional, 1, 'owner', 'filterProperties');
        return t.filterProperties(nodes, owner);
      },
      'truncateNodesList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 2, 'truncateNodesList');
        if (positional.isEmpty) {
          throw ArgumentError('truncateNodesList: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceList<$flutter_6.DiagnosticsNode>(positional[0], 'nodes');
        final owner = D4.getRequiredArg<$flutter_6.DiagnosticsNode?>(positional, 1, 'owner', 'truncateNodesList');
        return t.truncateNodesList(nodes, owner);
      },
      'delegateForNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
        D4.requireMinArgs(positional, 1, 'delegateForNode');
        final node = D4.getRequiredArg<$flutter_6.DiagnosticsNode>(positional, 0, 'node', 'delegateForNode');
        return t.delegateForNode(node);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.DiagnosticsSerializationDelegate>(target, 'DiagnosticsSerializationDelegate');
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
>>>>>>> Stashed changes
// StackFrame Bridge
// =============================================================================

BridgedClass _createStackFrameBridge() {
  return BridgedClass(
    nativeType: $flutter_12.StackFrame,
    name: 'StackFrame',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_12.StackFrame,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_1.PartialStackFrame,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        final package = D4.getRequiredNamedArg<Pattern>(named, 'package', 'PartialStackFrame');
        final className = D4.getRequiredNamedArg<String>(named, 'className', 'PartialStackFrame');
        final method = D4.getRequiredNamedArg<String>(named, 'method', 'PartialStackFrame');
        return $flutter_1.PartialStackFrame(package: package, className: className, method: method);
      },
    },
    getters: {
      'package': (visitor, target) => D4.validateTarget<$flutter_1.PartialStackFrame>(target, 'PartialStackFrame').package,
      'className': (visitor, target) => D4.validateTarget<$flutter_1.PartialStackFrame>(target, 'PartialStackFrame').className,
      'method': (visitor, target) => D4.validateTarget<$flutter_1.PartialStackFrame>(target, 'PartialStackFrame').method,
    },
    methods: {
      'matches': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.PartialStackFrame>(target, 'PartialStackFrame');
        D4.requireMinArgs(positional, 1, 'matches');
        final stackFrame = D4.getRequiredArg<$flutter_12.StackFrame>(positional, 0, 'stackFrame', 'matches');
        return t.matches(stackFrame);
      },
    },
    staticGetters: {
      'asynchronousSuspension': (visitor) => $flutter_1.PartialStackFrame.asynchronousSuspension,
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
    nativeType: $flutter_1.StackFilter,
    name: 'StackFilter',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_1.StackFilter,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is RepetitiveStackFrameFilter,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('frames') || named['frames'] == null) {
          throw ArgumentError('RepetitiveStackFrameFilter: Missing required named argument "frames"');
        }
        final frames = D4.coerceList<$flutter_1.PartialStackFrame>(named['frames'], 'frames');
        final replacement = D4.getRequiredNamedArg<String>(named, 'replacement', 'RepetitiveStackFrameFilter');
        return RepetitiveStackFrameFilter(frames: frames, replacement: replacement);
      },
    },
    getters: {
      'frames': (visitor, target) => D4.validateTarget<RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter').frames,
      'numFrames': (visitor, target) => D4.validateTarget<RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter').numFrames,
      'replacement': (visitor, target) => D4.validateTarget<RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter').replacement,
    },
    methods: {
      'filter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RepetitiveStackFrameFilter>(target, 'RepetitiveStackFrameFilter');
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
    nativeType: ErrorDescription,
    name: 'ErrorDescription',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ErrorDescription,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ErrorSummary,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ErrorSummary');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ErrorSummary');
        return ErrorSummary(message);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').value,
      'expandableValue': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').propertyType,
      'exception': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').isInteresting,
      'level': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').level,
      'name': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').name,
      'showSeparator': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<ErrorSummary>(target, 'ErrorSummary').textTreeConfiguration,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSummary>(target, 'ErrorSummary');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
    nativeType: ErrorHint,
    name: 'ErrorHint',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ErrorHint,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ErrorSpacer,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return ErrorSpacer();
      },
    },
    getters: {
<<<<<<< Updated upstream
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
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer').textTreeConfiguration,
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_6.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
>>>>>>> Stashed changes
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_12.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        return t.toTimelineArguments();
      },
<<<<<<< Updated upstream
=======
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ErrorSpacer>(target, 'ErrorSpacer');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
>>>>>>> Stashed changes
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// FlutterErrorDetails Bridge
// =============================================================================

BridgedClass _createFlutterErrorDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_1.FlutterErrorDetails,
    name: 'FlutterErrorDetails',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_1.FlutterErrorDetails,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'FlutterErrorDetails');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final library = D4.getNamedArgWithDefault<String?>(named, 'library', 'Flutter framework');
        final context = D4.getOptionalNamedArg<$flutter_6.DiagnosticsNode?>(named, 'context');
        final stackFilterRaw = named['stackFilter'];
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
<<<<<<< Updated upstream
        return $flutter_2.FlutterErrorDetails(exception: exception, stack: stack, library: library, context: context, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; }, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_12.DiagnosticsNode>; }, silent: silent);
=======
        return $flutter_1.FlutterErrorDetails(exception: exception, stack: stack, library: library, context: context, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; }, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, informationCollectorRaw, []) as Iterable<$flutter_6.DiagnosticsNode>; }, silent: silent);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_12.DiagnosticsNode>; }, library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; });
=======
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, informationCollectorRaw, []) as Iterable<$flutter_6.DiagnosticsNode>; }, library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; });
>>>>>>> Stashed changes
      },
      'exceptionAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        return t.exceptionAsString();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.FlutterErrorDetails>(target, 'FlutterErrorDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
<<<<<<< Updated upstream
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        t.debugFillProperties(properties);
=======
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is FlutterError,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlutterError');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'FlutterError');
        return FlutterError(message);
      },
      'fromParts': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlutterError');
        if (positional.isEmpty) {
          throw ArgumentError('FlutterError: Missing required argument "diagnostics" at position 0');
        }
        final diagnostics = D4.coerceList<$flutter_6.DiagnosticsNode>(positional[0], 'diagnostics');
        return FlutterError.fromParts(diagnostics);
      },
    },
    getters: {
      'diagnostics': (visitor, target) => D4.validateTarget<FlutterError>(target, 'FlutterError').diagnostics,
      'message': (visitor, target) => D4.validateTarget<FlutterError>(target, 'FlutterError').message,
      'stackTrace': (visitor, target) => D4.validateTarget<FlutterError>(target, 'FlutterError').stackTrace,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlutterError>(target, 'FlutterError');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
<<<<<<< Updated upstream
        final properties = D4.getRequiredArg<$flutter_12.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        t.debugFillProperties(properties);
=======
        final properties = D4.getRequiredArg<$flutter_6.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        final frames = D4.getRequiredArg<Iterable<String>>(positional, 0, 'frames', 'defaultStackFilter');
        return $flutter_2.FlutterError.defaultStackFilter(frames);
=======
        if (positional.isEmpty) {
          throw ArgumentError('defaultStackFilter: Missing required argument "frames" at position 0');
        }
        final frames = D4.coerceList<String>(positional[0], 'frames');
        return FlutterError.defaultStackFilter(frames);
>>>>>>> Stashed changes
      },
      'reportError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'reportError');
        final details = D4.getRequiredArg<$flutter_1.FlutterErrorDetails>(positional, 0, 'details', 'reportError');
        return FlutterError.reportError(details);
      },
    },
    staticSetters: {
<<<<<<< Updated upstream
      'onError': (visitor, value) => 
        $flutter_2.FlutterError.onError = value as $flutter_2.FlutterExceptionHandler?,
      'demangleStackTrace': (visitor, value) => 
        $flutter_2.FlutterError.demangleStackTrace = value as $flutter_2.StackTraceDemangler,
      'presentError': (visitor, value) => 
        $flutter_2.FlutterError.presentError = value as $flutter_2.FlutterExceptionHandler,
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is DiagnosticsStackTrace,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DiagnosticsStackTrace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DiagnosticsStackTrace');
        final stack = D4.getRequiredArg<StackTrace?>(positional, 1, 'stack', 'DiagnosticsStackTrace');
        final stackFilterRaw = named['stackFilter'];
        final showSeparator = D4.getNamedArgWithDefault<bool>(named, 'showSeparator', true);
<<<<<<< Updated upstream
        return $flutter_2.DiagnosticsStackTrace(name, stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; }, showSeparator: showSeparator);
=======
        return DiagnosticsStackTrace(name, stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]) as Iterable<String>; }, showSeparator: showSeparator);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace').textTreeConfiguration,
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.getChildren();
      },
>>>>>>> Stashed changes
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_6.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DiagnosticsStackTrace>(target, 'DiagnosticsStackTrace');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_6.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_6.DiagnosticLevel>(named, 'minLevel', $flutter_6.DiagnosticLevel.debug);
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// BindingBase Bridge
// =============================================================================

BridgedClass _createBindingBaseBridge() {
  return BridgedClass(
    nativeType: BindingBase,
    name: 'BindingBase',
<<<<<<< Updated upstream
    constructors: {
    },
    getters: {
      'window': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_4.BindingBase>(target, 'BindingBase').platformDispatcher,
    },
    methods: {
=======
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
>>>>>>> Stashed changes
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
<<<<<<< Updated upstream
=======
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents(() { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        (t as dynamic).unlocked();
        return null;
      },
>>>>>>> Stashed changes
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        return t.reassembleApplication();
      },
<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BindingBase>(target, 'BindingBase');
        return t.toString();
      },
    },
    staticGetters: {
      'debugZoneErrorsAreFatal': (visitor) => BindingBase.debugZoneErrorsAreFatal,
    },
    staticMethods: {
<<<<<<< Updated upstream
=======
      'checkInstance': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'checkInstance');
        final instance = D4.getRequiredArg<dynamic?>(positional, 0, 'instance', 'checkInstance');
        return BindingBase.checkInstance(instance);
      },
>>>>>>> Stashed changes
      'debugBindingType': (visitor, positional, named, typeArgs) {
        return BindingBase.debugBindingType();
      },
    },
    staticSetters: {
      'debugZoneErrorsAreFatal': (visitor, value) => 
<<<<<<< Updated upstream
        $flutter_4.BindingBase.debugZoneErrorsAreFatal = value as bool,
=======
        BindingBase.debugZoneErrorsAreFatal = D4.extractBridgedArg<bool>(value, 'debugZoneErrorsAreFatal'),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is BitField,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BitField');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'BitField');
        return BitField(length);
      },
      'filled': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BitField');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'BitField');
        final value = D4.getRequiredArg<bool>(positional, 1, 'value', 'BitField');
        return BitField.filled(length, value);
      },
    },
    methods: {
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BitField>(target, 'BitField');
        final value = D4.getOptionalArgWithDefault<bool>(positional, 0, 'value', false);
        t.reset(value);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BitField>(target, 'BitField');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BitField>(target, 'BitField');
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
    nativeType: $flutter_4.Listenable,
    name: 'Listenable',
<<<<<<< Updated upstream
    constructors: {
      'merge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Listenable');
        final listenables = D4.getRequiredArg<Iterable<$flutter_7.Listenable>>(positional, 0, 'listenables', 'Listenable');
        return $flutter_7.Listenable.merge(listenables);
=======
    isAssignable: (v) => v is $flutter_4.Listenable,
    constructors: {
      'merge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Listenable');
        if (positional.isEmpty) {
          throw ArgumentError('Listenable: Missing required argument "listenables" at position 0');
        }
        final listenables = D4.coerceList<$flutter_4.Listenable?>(positional[0], 'listenables');
        return $flutter_4.Listenable.merge(listenables);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ValueListenable,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<ValueListenable>(target, 'ValueListenable').value,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueListenable>(target, 'ValueListenable');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ValueListenable>(target, 'ValueListenable');
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
    nativeType: $flutter_4.ChangeNotifier,
    name: 'ChangeNotifier',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_4.ChangeNotifier,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_4.ChangeNotifier();
      },
    },
<<<<<<< Updated upstream
=======
    getters: {
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_4.ChangeNotifier>(target, 'ChangeNotifier').hasListeners,
    },
>>>>>>> Stashed changes
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ChangeNotifier>(target, 'ChangeNotifier');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ChangeNotifier>(target, 'ChangeNotifier');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
<<<<<<< Updated upstream
        final t = D4.validateTarget<$flutter_7.ChangeNotifier>(target, 'ChangeNotifier');
        t.dispose();
=======
        final t = D4.validateTarget<$flutter_4.ChangeNotifier>(target, 'ChangeNotifier');
        (t as dynamic).dispose();
>>>>>>> Stashed changes
        return null;
      },
    },
    staticMethods: {
      'debugAssertNotDisposed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertNotDisposed');
        final notifier = D4.getRequiredArg<$flutter_4.ChangeNotifier>(positional, 0, 'notifier', 'debugAssertNotDisposed');
        return $flutter_4.ChangeNotifier.debugAssertNotDisposed(notifier);
      },
<<<<<<< Updated upstream
=======
      'maybeDispatchObjectCreation': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'maybeDispatchObjectCreation');
        final object = D4.getRequiredArg<$flutter_4.ChangeNotifier>(positional, 0, 'object', 'maybeDispatchObjectCreation');
        return $flutter_4.ChangeNotifier.maybeDispatchObjectCreation(object);
      },
>>>>>>> Stashed changes
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
    nativeType: ValueNotifier,
    name: 'ValueNotifier',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ValueNotifier,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueNotifier');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'ValueNotifier');
<<<<<<< Updated upstream
        return $flutter_7.ValueNotifier(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier').value,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier').hasListeners,
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        final t = D4.validateTarget<$flutter_7.ValueNotifier>(target, 'ValueNotifier');
        t.dispose();
=======
        final t = D4.validateTarget<ValueNotifier>(target, 'ValueNotifier');
        (t as dynamic).dispose();
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Key,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Key');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'Key');
        return Key(value);
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
    nativeType: LocalKey,
    name: 'LocalKey',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LocalKey,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is UniqueKey,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return UniqueKey();
      },
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<UniqueKey>(target, 'UniqueKey');
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
    nativeType: ValueKey,
    name: 'ValueKey',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ValueKey,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ValueKey');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'ValueKey');
<<<<<<< Updated upstream
        return $flutter_14.ValueKey(value);
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_8.LicenseParagraph,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'LicenseParagraph');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'LicenseParagraph');
        final indent = D4.getRequiredArg<int>(positional, 1, 'indent', 'LicenseParagraph');
        return $flutter_8.LicenseParagraph(text, indent);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_8.LicenseParagraph>(target, 'LicenseParagraph').text,
      'indent': (visitor, target) => D4.validateTarget<$flutter_8.LicenseParagraph>(target, 'LicenseParagraph').indent,
    },
    staticGetters: {
      'centeredIndent': (visitor) => $flutter_8.LicenseParagraph.centeredIndent,
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
    nativeType: $flutter_8.LicenseEntry,
    name: 'LicenseEntry',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_8.LicenseEntry,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LicenseEntryWithLineBreaks,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'LicenseEntryWithLineBreaks');
        if (positional.isEmpty) {
          throw ArgumentError('LicenseEntryWithLineBreaks: Missing required argument "packages" at position 0');
        }
        final packages = D4.coerceList<String>(positional[0], 'packages');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'LicenseEntryWithLineBreaks');
        return LicenseEntryWithLineBreaks(packages, text);
      },
    },
    getters: {
      'packages': (visitor, target) => D4.validateTarget<LicenseEntryWithLineBreaks>(target, 'LicenseEntryWithLineBreaks').packages,
      'paragraphs': (visitor, target) => D4.validateTarget<LicenseEntryWithLineBreaks>(target, 'LicenseEntryWithLineBreaks').paragraphs,
      'text': (visitor, target) => D4.validateTarget<LicenseEntryWithLineBreaks>(target, 'LicenseEntryWithLineBreaks').text,
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
    nativeType: LicenseRegistry,
    name: 'LicenseRegistry',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LicenseRegistry,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        final collector = () { return D4.callInterpreterCallback(visitor, collectorRaw, []) as Stream<$flutter_15.LicenseEntry>; };
        return $flutter_15.LicenseRegistry.addLicense(collector);
=======
        final collector = () { return D4.callInterpreterCallback(visitor!, collectorRaw, []) as Stream<$flutter_8.LicenseEntry>; };
        return LicenseRegistry.addLicense(collector);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_9.ObjectEvent,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'object': (visitor, target) => D4.validateTarget<$flutter_9.ObjectEvent>(target, 'ObjectEvent').object,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.ObjectEvent>(target, 'ObjectEvent');
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
    nativeType: ObjectCreated,
    name: 'ObjectCreated',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ObjectCreated,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ObjectDisposed,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        final object = D4.getRequiredNamedArg<Object>(named, 'object', 'ObjectDisposed');
        return ObjectDisposed(object: object);
      },
    },
    getters: {
      'object': (visitor, target) => D4.validateTarget<ObjectDisposed>(target, 'ObjectDisposed').object,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObjectDisposed>(target, 'ObjectDisposed');
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
    nativeType: $flutter_9.FlutterMemoryAllocations,
    name: 'FlutterMemoryAllocations',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_9.FlutterMemoryAllocations,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        t.addListener(($flutter_16.ObjectEvent p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
=======
        t.addListener(($flutter_9.ObjectEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
>>>>>>> Stashed changes
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.FlutterMemoryAllocations>(target, 'FlutterMemoryAllocations');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
<<<<<<< Updated upstream
        t.removeListener(($flutter_16.ObjectEvent p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
=======
        t.removeListener(($flutter_9.ObjectEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ObserverList,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return ObserverList();
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').iterator,
      'isEmpty': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').isNotEmpty,
      'length': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').length,
      'first': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').first,
      'last': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').last,
      'single': (visitor, target) => D4.validateTarget<ObserverList>(target, 'ObserverList').single,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'remove');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'remove');
        return t.remove(item);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        t.clear();
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<dynamic>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        return t.whereType();
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        return t.toSet();
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ObserverList>(target, 'ObserverList');
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
// HashedObserverList Bridge
// =============================================================================

BridgedClass _createHashedObserverListBridge() {
  return BridgedClass(
    nativeType: HashedObserverList,
    name: 'HashedObserverList',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is HashedObserverList,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_10.PersistentHashMap,
>>>>>>> Stashed changes
    constructors: {
      'empty': (visitor, positional, named) {
        return $flutter_10.PersistentHashMap.empty();
      },
    },
    methods: {
      'put': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PersistentHashMap>(target, 'PersistentHashMap');
        D4.requireMinArgs(positional, 2, 'put');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'put');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'put');
        return t.put(key, value);
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PersistentHashMap>(target, 'PersistentHashMap');
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
    nativeType: WriteBuffer,
    name: 'WriteBuffer',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is WriteBuffer,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ReadBuffer,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReadBuffer');
        final data = D4.getRequiredArg<ByteData>(positional, 0, 'data', 'ReadBuffer');
        return ReadBuffer(data);
      },
    },
    getters: {
      'data': (visitor, target) => D4.validateTarget<ReadBuffer>(target, 'ReadBuffer').data,
      'hasRemaining': (visitor, target) => D4.validateTarget<ReadBuffer>(target, 'ReadBuffer').hasRemaining,
    },
    methods: {
      'getUint8': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        return t.getUint8();
      },
      'getUint16': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getUint16(endian: endian);
      },
      'getUint32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getUint32(endian: endian);
      },
      'getInt32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getInt32(endian: endian);
      },
      'getInt64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getInt64(endian: endian);
      },
      'getFloat64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getFloat64(endian: endian);
      },
      'getUint8List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getUint8List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getUint8List');
        return t.getUint8List(length);
      },
      'getInt32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getInt32List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getInt32List');
        return t.getInt32List(length);
      },
      'getInt64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getInt64List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getInt64List');
        return t.getInt64List(length);
      },
      'getFloat32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getFloat32List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getFloat32List');
        return t.getFloat32List(length);
      },
      'getFloat64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReadBuffer>(target, 'ReadBuffer');
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
    nativeType: SynchronousFuture,
    name: 'SynchronousFuture',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SynchronousFuture,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SynchronousFuture');
        final value = D4.getRequiredArg<dynamic>(positional, 0, '_value', 'SynchronousFuture');
<<<<<<< Updated upstream
        return $flutter_25.SynchronousFuture(value);
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is FlutterTimeline,
>>>>>>> Stashed changes
    constructors: {
    },
    staticGetters: {
      'debugCollectionEnabled': (visitor) => FlutterTimeline.debugCollectionEnabled,
      'now': (visitor) => FlutterTimeline.now,
    },
    staticMethods: {
      'startSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'startSync');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'startSync');
        final arguments = D4.coerceMapOrNull<String, Object?>(named['arguments'], 'arguments');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return FlutterTimeline.startSync(name, arguments: arguments, flow: flow);
      },
      'finishSync': (visitor, positional, named, typeArgs) {
        return FlutterTimeline.finishSync();
      },
      'instantSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'instantSync');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'instantSync');
        final arguments = D4.coerceMapOrNull<String, Object?>(named['arguments'], 'arguments');
        return FlutterTimeline.instantSync(name, arguments: arguments);
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
        return FlutterTimeline.timeSync(name, function, arguments: arguments, flow: flow);
      },
      'debugCollect': (visitor, positional, named, typeArgs) {
        return FlutterTimeline.debugCollect();
      },
      'debugReset': (visitor, positional, named, typeArgs) {
        return FlutterTimeline.debugReset();
      },
    },
    staticSetters: {
      'debugCollectionEnabled': (visitor, value) => 
<<<<<<< Updated upstream
        $flutter_26.FlutterTimeline.debugCollectionEnabled = value as dynamic,
=======
        FlutterTimeline.debugCollectionEnabled = D4.extractBridgedArg<bool>(value, 'debugCollectionEnabled'),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_13.TimedBlock,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'TimedBlock');
        final start = D4.getRequiredNamedArg<double>(named, 'start', 'TimedBlock');
        final end = D4.getRequiredNamedArg<double>(named, 'end', 'TimedBlock');
        return $flutter_13.TimedBlock(name: name, start: start, end: end);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_13.TimedBlock>(target, 'TimedBlock').name,
      'start': (visitor, target) => D4.validateTarget<$flutter_13.TimedBlock>(target, 'TimedBlock').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_13.TimedBlock>(target, 'TimedBlock').end,
      'duration': (visitor, target) => D4.validateTarget<$flutter_13.TimedBlock>(target, 'TimedBlock').duration,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.TimedBlock>(target, 'TimedBlock');
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
    nativeType: $flutter_13.AggregatedTimings,
    name: 'AggregatedTimings',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_13.AggregatedTimings,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $flutter_13.AggregatedTimedBlock,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'AggregatedTimedBlock');
        final duration = D4.getRequiredNamedArg<double>(named, 'duration', 'AggregatedTimedBlock');
        final count = D4.getRequiredNamedArg<int>(named, 'count', 'AggregatedTimedBlock');
        return $flutter_13.AggregatedTimedBlock(name: name, duration: duration, count: count);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_13.AggregatedTimedBlock>(target, 'AggregatedTimedBlock').name,
      'duration': (visitor, target) => D4.validateTarget<$flutter_13.AggregatedTimedBlock>(target, 'AggregatedTimedBlock').duration,
      'count': (visitor, target) => D4.validateTarget<$flutter_13.AggregatedTimedBlock>(target, 'AggregatedTimedBlock').count,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.AggregatedTimedBlock>(target, 'AggregatedTimedBlock');
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
    nativeType: Unicode,
    name: 'Unicode',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Unicode,
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
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

=======
>>>>>>> Stashed changes
