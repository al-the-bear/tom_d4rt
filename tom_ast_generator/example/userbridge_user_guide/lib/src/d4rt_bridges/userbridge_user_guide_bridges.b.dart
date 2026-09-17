// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-09-17T23:27:32.209357 by tom_d4rt_generator 1.26.2

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, non_const_argument_for_const_parameter, unnecessary_import

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

import 'package:userbridge_user_guide_example/src/matrix2x2.dart' as $userbridge_user_guide_example_1;
import 'package:userbridge_user_guide_example/src/matrix2x2_user_bridge.dart' as $userbridge_user_guide_example_2;
import 'package:userbridge_user_guide_example/src/vector2d.dart' as $userbridge_user_guide_example_3;
import 'package:userbridge_user_guide_example/src/vector2d_user_bridge.dart' as $userbridge_user_guide_example_4;

/// Bridge class for all module.
class AllBridge {
  /// Returns all bridge class definitions.
  ///
  /// Eager — building every class. Prefer [bridgeClassThunks] +
  /// [bridgeClassTypes] for lazy registration (Step #17); this remains
  /// for diagnostics and callers that need the full list.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createVector2DBridge(),
      _createMatrix2x2Bridge(),
    ];
  }

  /// Returns deferred factory thunks keyed by class name.
  ///
  /// Each thunk builds one class's [BridgedClass] on demand. Plugs into
  /// the interpreter's lazy registry via [registerBridges] (Step #17).
  static Map<String, BridgedClass Function()> bridgeClassThunks() {
    return {
      'Vector2D': _createVector2DBridge,
      'Matrix2x2': _createMatrix2x2Bridge,
    };
  }

  /// Returns native [Type]s keyed by class name, parallel to
  /// [bridgeClassThunks] (Step #17). Used to register the native-type
  /// lookup thunk without building the BridgedClass.
  static Map<String, Type> bridgeClassTypes() {
    return {
      'Vector2D': $userbridge_user_guide_example_3.Vector2D,
      'Matrix2x2': $userbridge_user_guide_example_1.Matrix2x2,
    };
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Vector2D': 'package:userbridge_user_guide_example/src/vector2d.dart',
      'Matrix2x2': 'package:userbridge_user_guide_example/src/matrix2x2.dart',
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
      (source: 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart', target: 'package:userbridge_user_guide_example/src/vector2d.dart', show: null, hide: null),
      (source: 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart', target: 'package:userbridge_user_guide_example/src/matrix2x2.dart', show: null, hide: null),
      (source: 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart', target: 'package:userbridge_user_guide_example/src/vector2d_user_bridge.dart', show: null, hide: null),
      (source: 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart', target: 'package:userbridge_user_guide_example/src/matrix2x2_user_bridge.dart', show: null, hide: null),
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

    // GEN-107: Register library re-exports
    for (final r in bridgeReExports()) {
      interpreter.registerLibraryReExport(r.source, r.target, show: r.show, hide: r.hide);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {};
  }

  /// Returns a map of global function names to their canonical source URIs.
  static Map<String, String> globalFunctionSourceUris() {
    return {};
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {};
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:userbridge_user_guide_example/src/matrix2x2.dart',
      'package:userbridge_user_guide_example/src/vector2d.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart';";
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
// Vector2D Bridge
// =============================================================================

BridgedClass _createVector2DBridge() {
  return BridgedClass(
    nativeType: $userbridge_user_guide_example_3.Vector2D,
    name: 'Vector2D',
    isAssignable: (v) => v is $userbridge_user_guide_example_3.Vector2D,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2D');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return $userbridge_user_guide_example_3.Vector2D(x, y);
      },
      'zero': (visitor, positional, named) {
        return $userbridge_user_guide_example_3.Vector2D.zero();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D').y,
      'hashCode': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D').hashCode,
      'magnitude': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D').magnitude,
      'normalized': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D').normalized,
    },
    methods: {
      'dot': $userbridge_user_guide_example_4.Vector2DUserBridge.overrideMethodDot,
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D');
        return t.toString();
      },
      '+': $userbridge_user_guide_example_4.Vector2DUserBridge.overrideOperatorPlus,
      '-': $userbridge_user_guide_example_4.Vector2DUserBridge.overrideOperatorMinus,
      '*': $userbridge_user_guide_example_4.Vector2DUserBridge.overrideOperatorMultiply,
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_3.Vector2D>(target, 'Vector2D');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'Vector2D(double x, double y)',
      'zero': 'Vector2D.zero()',
    },
    methodSignatures: {
      'dot': 'double dot(Vector2D other)',
      'scale': 'Vector2D scale(double factor)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
      'hashCode': 'int get hashCode',
      'magnitude': 'double get magnitude',
      'normalized': 'Vector2D get normalized',
    },
  );
}

// =============================================================================
// Matrix2x2 Bridge
// =============================================================================

BridgedClass _createMatrix2x2Bridge() {
  return BridgedClass(
    nativeType: $userbridge_user_guide_example_1.Matrix2x2,
    name: 'Matrix2x2',
    isAssignable: (v) => v is $userbridge_user_guide_example_1.Matrix2x2,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Matrix2x2');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'Matrix2x2');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'Matrix2x2');
        final c = D4.getRequiredArg<double>(positional, 2, 'c', 'Matrix2x2');
        final d = D4.getRequiredArg<double>(positional, 3, 'd', 'Matrix2x2');
        return $userbridge_user_guide_example_1.Matrix2x2(a, b, c, d);
      },
      'identity': (visitor, positional, named) {
        return $userbridge_user_guide_example_1.Matrix2x2.identity();
      },
    },
    getters: {
      'determinant': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Matrix2x2>(target, 'Matrix2x2').determinant,
      'trace': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Matrix2x2>(target, 'Matrix2x2').trace,
    },
    methods: {
      'row': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Matrix2x2>(target, 'Matrix2x2');
        D4.requireMinArgs(positional, 1, 'row');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'row');
        return t.row(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Matrix2x2>(target, 'Matrix2x2');
        return t.toString();
      },
      '[]': $userbridge_user_guide_example_2.Matrix2x2UserBridge.overrideOperatorIndex,
      '[]=': $userbridge_user_guide_example_2.Matrix2x2UserBridge.overrideOperatorIndexAssign,
    },
    constructorSignatures: {
      '': 'Matrix2x2(double a, double b, double c, double d)',
      'identity': 'Matrix2x2.identity()',
    },
    methodSignatures: {
      'row': 'List<double> row(int index)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'determinant': 'double get determinant',
      'trace': 'double get trace',
    },
  );
}

