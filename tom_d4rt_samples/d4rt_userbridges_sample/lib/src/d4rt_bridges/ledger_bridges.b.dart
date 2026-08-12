// D4rt Bridge - Generated file, do not edit
// Sources: 4 files
// Generated: 2026-08-12T10:17:39.711280

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, non_const_argument_for_const_parameter, unnecessary_import

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_userbridges_sample/src/box/box.dart' as $d4rt_userbridges_sample_1;
import 'package:d4rt_userbridges_sample/src/config/app_config.dart' as $d4rt_userbridges_sample_2;
import 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/app_config_user_bridge.dart' as $d4rt_userbridges_sample_3;
import 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/box_user_bridge.dart' as $d4rt_userbridges_sample_4;
import 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/grid_user_bridge.dart' as $d4rt_userbridges_sample_5;
import 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/money_user_bridge.dart' as $d4rt_userbridges_sample_6;
import 'package:d4rt_userbridges_sample/src/grid/grid.dart' as $d4rt_userbridges_sample_7;
import 'package:d4rt_userbridges_sample/src/money/money.dart' as $d4rt_userbridges_sample_8;

/// Bridge class for ledger module.
class LedgerBridge {
  /// Returns all bridge class definitions.
  ///
  /// Eager — building every class. Prefer [bridgeClassThunks] +
  /// [bridgeClassTypes] for lazy registration (Step #17); this remains
  /// for diagnostics and callers that need the full list.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createMoneyBridge(),
      _createGridBridge(),
      _createBoxBridge(),
    ];
  }

  /// Returns deferred factory thunks keyed by class name.
  ///
  /// Each thunk builds one class's [BridgedClass] on demand. Plugs into
  /// the interpreter's lazy registry via [registerBridges] (Step #17).
  static Map<String, BridgedClass Function()> bridgeClassThunks() {
    return {
      'Money': _createMoneyBridge,
      'Grid': _createGridBridge,
      'Box': _createBoxBridge,
    };
  }

  /// Returns native [Type]s keyed by class name, parallel to
  /// [bridgeClassThunks] (Step #17). Used to register the native-type
  /// lookup thunk without building the BridgedClass.
  static Map<String, Type> bridgeClassTypes() {
    return {
      'Money': $d4rt_userbridges_sample_8.Money,
      'Grid': $d4rt_userbridges_sample_7.Grid,
      'Box': $d4rt_userbridges_sample_1.Box,
    };
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Money': 'package:d4rt_userbridges_sample/src/money/money.dart',
      'Grid': 'package:d4rt_userbridges_sample/src/grid/grid.dart',
      'Box': 'package:d4rt_userbridges_sample/src/box/box.dart',
    };
  }

  /// Returns a map of class names to their flattened (transitive)
  /// native supertype names (superclasses, interfaces and mixins).
  ///
  /// Fed to `BridgedClass.registerSupertypes` so interpreted subclasses
  /// of bridged classes pass `is`/subtype checks against bridged
  /// ancestors and the interface-proxy supertype walk resolves up the
  /// chain.
  static Map<String, List<String>> classSupertypes() {
    return {
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
    };
  }

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
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

  /// GEN-107: Library re-exports declared by the bridged source
  /// libraries. Each tuple mirrors a Dart `export '…'` directive.
  /// Consumed by `registerBridges` via `D4rt.registerLibraryReExport`
  /// (mirrored on `D4rtRunner` in tom_d4rt_ast).
  static List<({String source, String target, Set<String>? show, Set<String>? hide})>
  bridgeReExports() {
    return [
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/money/money.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/grid/grid.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/box/box.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/config/app_config.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/money_user_bridge.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/grid_user_bridge.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/box_user_bridge.dart', show: null, hide: null),
      (source: 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart', target: 'package:d4rt_userbridges_sample/src/d4rt_user_bridges/app_config_user_bridge.dart', show: null, hide: null),
    ];
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Step #17 — register deferred factory thunks (not pre-built
    // BridgedClass objects): a script touching N of the M classes
    // materializes ≈N (each thunk builds its class on first resolve).
    final classThunks = bridgeClassThunks();
    final classTypes = bridgeClassTypes();
    final classSources = classSourceUris();
    for (final entry in classThunks.entries) {
      interpreter.registerBridgedClassLazy(
        entry.key,
        classTypes[entry.key]!,
        entry.value,
        importPath,
        sourceUri: classSources[entry.key],
      );
    }

    // Register the flattened native supertype table so
    // interpreted subclasses pass subtype checks against bridged
    // ancestors. Idempotent — safe to call per barrel.
    BridgedClass.registerSupertypes(classSupertypes());

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }

    // GEN-107: Register library re-exports
    for (final r in bridgeReExports()) {
      interpreter.registerLibraryReExport(r.source, r.target, show: r.show, hide: r.hide);
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
      interpreter.registerGlobalVariable('appName', $d4rt_userbridges_sample_3.AppConfigUserBridge.overrideGlobalVariableAppName(), importPath, sourceUri: 'package:d4rt_userbridges_sample/src/config/app_config.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxItems', $d4rt_userbridges_sample_3.AppConfigUserBridge.overrideGlobalVariableMaxItems(), importPath, sourceUri: 'package:d4rt_userbridges_sample/src/config/app_config.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxItems": $e');
    }
    interpreter.registerGlobalGetter('currentTime', $d4rt_userbridges_sample_3.AppConfigUserBridge.overrideGlobalGetterCurrentTime(), importPath, sourceUri: 'package:d4rt_userbridges_sample/src/config/app_config.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (ledger):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'describe': $d4rt_userbridges_sample_3.AppConfigUserBridge.overrideGlobalFunctionDescribe,
      'taxCents': $d4rt_userbridges_sample_3.AppConfigUserBridge.overrideGlobalFunctionTaxCents,
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'describe': 'package:d4rt_userbridges_sample/src/config/app_config.dart',
      'taxCents': 'package:d4rt_userbridges_sample/src/config/app_config.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'describe': 'String describe(String what)',
      'taxCents': 'int taxCents(int cents, {double rate = 0.0})',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:d4rt_userbridges_sample/src/box/box.dart',
      'package:d4rt_userbridges_sample/src/config/app_config.dart',
      'package:d4rt_userbridges_sample/src/grid/grid.dart',
      'package:d4rt_userbridges_sample/src/money/money.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';";
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

}

// =============================================================================
// Money Bridge
// =============================================================================

BridgedClass _createMoneyBridge() {
  return BridgedClass(
    nativeType: $d4rt_userbridges_sample_8.Money,
    name: 'Money',
    isAssignable: (v) => v is $d4rt_userbridges_sample_8.Money,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Money');
        final cents = D4.getRequiredArg<int>(positional, 0, 'cents', 'Money');
        final currency = D4.getOptionalArgWithDefault<String>(positional, 1, 'currency', 'USD');
        return $d4rt_userbridges_sample_8.Money(cents, currency);
      },
      'amount': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Money');
        final amount = D4.getRequiredArg<double>(positional, 0, 'amount', 'Money');
        final currency = D4.getOptionalArgWithDefault<String>(positional, 1, 'currency', 'USD');
        return $d4rt_userbridges_sample_8.Money.amount(amount, currency);
      },
    },
    getters: {
      'cents': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money').cents,
      'currency': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money').currency,
      'hashCode': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money').hashCode,
      'majorUnits': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money').majorUnits,
      'isNegative': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money').isNegative,
    },
    methods: {
      'format': $d4rt_userbridges_sample_6.MoneyUserBridge.overrideMethodFormat,
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money');
        return t.toString();
      },
      '+': $d4rt_userbridges_sample_6.MoneyUserBridge.overrideOperatorPlus,
      '-': $d4rt_userbridges_sample_6.MoneyUserBridge.overrideOperatorMinus,
      '*': $d4rt_userbridges_sample_6.MoneyUserBridge.overrideOperatorMultiply,
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_userbridges_sample_8.Money>(target, 'Money');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const Money(int cents, [String currency = \'USD\'])',
      'amount': 'Money.amount(double amount, [String currency = \'USD\'])',
    },
    methodSignatures: {
      'format': 'String format()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'cents': 'int get cents',
      'currency': 'String get currency',
      'hashCode': 'int get hashCode',
      'majorUnits': 'double get majorUnits',
      'isNegative': 'bool get isNegative',
    },
  );
}

// =============================================================================
// Grid Bridge
// =============================================================================

BridgedClass _createGridBridge() {
  return BridgedClass(
    nativeType: $d4rt_userbridges_sample_7.Grid,
    name: 'Grid',
    isAssignable: (v) => v is $d4rt_userbridges_sample_7.Grid,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Grid');
        final rows = D4.getRequiredArg<int>(positional, 0, 'rows', 'Grid');
        final cols = D4.getRequiredArg<int>(positional, 1, 'cols', 'Grid');
        return $d4rt_userbridges_sample_7.Grid(rows, cols);
      },
    },
    getters: {
      'rows': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_7.Grid>(target, 'Grid').rows,
      'cols': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_7.Grid>(target, 'Grid').cols,
      'sum': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_7.Grid>(target, 'Grid').sum,
    },
    methods: {
      'fill': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_userbridges_sample_7.Grid>(target, 'Grid');
        D4.requireMinArgs(positional, 1, 'fill');
        final value = D4.getRequiredArg<num>(positional, 0, 'value', 'fill');
        t.fill(value);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_userbridges_sample_7.Grid>(target, 'Grid');
        return t.toString();
      },
      '[]': $d4rt_userbridges_sample_5.GridUserBridge.overrideOperatorIndex,
      '[]=': $d4rt_userbridges_sample_5.GridUserBridge.overrideOperatorIndexAssign,
    },
    constructorSignatures: {
      '': 'Grid(int rows, int cols)',
    },
    methodSignatures: {
      'fill': 'void fill(num value)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'rows': 'int get rows',
      'cols': 'int get cols',
      'sum': 'num get sum',
    },
  );
}

// =============================================================================
// Box Bridge
// =============================================================================

BridgedClass _createBoxBridge() {
  return BridgedClass(
    nativeType: $d4rt_userbridges_sample_1.Box,
    name: 'Box',
    isAssignable: (v) => v is $d4rt_userbridges_sample_1.Box,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Box');
        final size = D4.getRequiredArg<int>(positional, 0, 'size', 'Box');
        return $d4rt_userbridges_sample_1.Box(size);
      },
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_1.Box>(target, 'Box').size,
      'isEmpty': (visitor, target) => D4.validateTarget<$d4rt_userbridges_sample_1.Box>(target, 'Box').isEmpty,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_userbridges_sample_1.Box>(target, 'Box');
        return t.toString();
      },
      '[]': $d4rt_userbridges_sample_4.BoxUserBridge.overrideOperatorIndex,
      '[]=': $d4rt_userbridges_sample_4.BoxUserBridge.overrideOperatorIndexAssign,
    },
    constructorSignatures: {
      '': 'Box(int size)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'size': 'int get size',
      'isEmpty': 'bool get isEmpty',
    },
  );
}

