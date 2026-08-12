// D4rt Bridge - Generated file, do not edit
// Sources: 3 files
// Generated: 2026-08-12T10:17:10.834715

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, non_const_argument_for_const_parameter, unnecessary_import

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_advanced_sample/src/geometry/physics_world.dart' as $d4rt_advanced_sample_1;
import 'package:d4rt_advanced_sample/src/geometry/shapes.dart' as $d4rt_advanced_sample_2;
import 'package:d4rt_advanced_sample/src/geometry/vector2.dart' as $d4rt_advanced_sample_3;

/// Bridge class for geometry module.
class GeometryBridge {
  /// Returns all bridge class definitions.
  ///
  /// Eager — building every class. Prefer [bridgeClassThunks] +
  /// [bridgeClassTypes] for lazy registration (Step #17); this remains
  /// for diagnostics and callers that need the full list.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createVector2Bridge(),
      _createShapeBridge(),
      _createCircleBridge(),
      _createRectBridge(),
      _createBodyBridge(),
      _createPhysicsWorldBridge(),
    ];
  }

  /// Returns deferred factory thunks keyed by class name.
  ///
  /// Each thunk builds one class's [BridgedClass] on demand. Plugs into
  /// the interpreter's lazy registry via [registerBridges] (Step #17).
  static Map<String, BridgedClass Function()> bridgeClassThunks() {
    return {
      'Vector2': _createVector2Bridge,
      'Shape': _createShapeBridge,
      'Circle': _createCircleBridge,
      'Rect': _createRectBridge,
      'Body': _createBodyBridge,
      'PhysicsWorld': _createPhysicsWorldBridge,
    };
  }

  /// Returns native [Type]s keyed by class name, parallel to
  /// [bridgeClassThunks] (Step #17). Used to register the native-type
  /// lookup thunk without building the BridgedClass.
  static Map<String, Type> bridgeClassTypes() {
    return {
      'Vector2': $d4rt_advanced_sample_3.Vector2,
      'Shape': $d4rt_advanced_sample_2.Shape,
      'Circle': $d4rt_advanced_sample_2.Circle,
      'Rect': $d4rt_advanced_sample_2.Rect,
      'Body': $d4rt_advanced_sample_1.Body,
      'PhysicsWorld': $d4rt_advanced_sample_1.PhysicsWorld,
    };
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Vector2': 'package:d4rt_advanced_sample/src/geometry/vector2.dart',
      'Shape': 'package:d4rt_advanced_sample/src/geometry/shapes.dart',
      'Circle': 'package:d4rt_advanced_sample/src/geometry/shapes.dart',
      'Rect': 'package:d4rt_advanced_sample/src/geometry/shapes.dart',
      'Body': 'package:d4rt_advanced_sample/src/geometry/physics_world.dart',
      'PhysicsWorld': 'package:d4rt_advanced_sample/src/geometry/physics_world.dart',
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
      'Circle': ['Shape'],
      'Rect': ['Shape'],
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
      (source: 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart', target: 'package:d4rt_advanced_sample/src/geometry/vector2.dart', show: null, hide: null),
      (source: 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart', target: 'package:d4rt_advanced_sample/src/geometry/shapes.dart', show: null, hide: null),
      (source: 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart', target: 'package:d4rt_advanced_sample/src/geometry/physics_world.dart', show: null, hide: null),
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
      'package:d4rt_advanced_sample/src/geometry/physics_world.dart',
      'package:d4rt_advanced_sample/src/geometry/shapes.dart',
      'package:d4rt_advanced_sample/src/geometry/vector2.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';";
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
// Vector2 Bridge
// =============================================================================

BridgedClass _createVector2Bridge() {
  return BridgedClass(
    nativeType: $d4rt_advanced_sample_3.Vector2,
    name: 'Vector2',
    isAssignable: (v) => v is $d4rt_advanced_sample_3.Vector2,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2');
        return $d4rt_advanced_sample_3.Vector2(x, y);
      },
      'zero': (visitor, positional, named) {
        return $d4rt_advanced_sample_3.Vector2.zero();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2').x,
      'y': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2').y,
      'magnitude': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2').magnitude,
    },
    methods: {
      'normalized': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2');
        return t.normalized();
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'other', 'operator-');
        return t - other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_3.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
    },
    constructorSignatures: {
      '': 'const Vector2(double x, double y)',
      'zero': 'const Vector2.zero()',
    },
    methodSignatures: {
      'normalized': 'Vector2 normalized()',
      'dot': 'double dot(Vector2 other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
      'magnitude': 'double get magnitude',
    },
  );
}

// =============================================================================
// Shape Bridge
// =============================================================================

BridgedClass _createShapeBridge() {
  return BridgedClass(
    nativeType: $d4rt_advanced_sample_2.Shape,
    name: 'Shape',
    isAssignable: (v) => v is $d4rt_advanced_sample_2.Shape,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'center': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Shape>(target, 'Shape').center,
      'area': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Shape>(target, 'Shape').area,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_2.Shape>(target, 'Shape');
        D4.requireMinArgs(positional, 1, 'contains');
        final point = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'point', 'contains');
        return t.contains(point);
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_2.Shape>(target, 'Shape');
        return t.describe();
      },
    },
    methodSignatures: {
      'contains': 'bool contains(Vector2 point)',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'center': 'Vector2 get center',
      'area': 'double get area',
    },
  );
}

// =============================================================================
// Circle Bridge
// =============================================================================

BridgedClass _createCircleBridge() {
  return BridgedClass(
    nativeType: $d4rt_advanced_sample_2.Circle,
    name: 'Circle',
    isAssignable: (v) => v is $d4rt_advanced_sample_2.Circle,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Circle');
        final center = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'center', 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 1, 'radius', 'Circle');
        return $d4rt_advanced_sample_2.Circle(center, radius);
      },
    },
    getters: {
      'center': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Circle>(target, 'Circle').center,
      'area': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Circle>(target, 'Circle').area,
      'radius': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Circle>(target, 'Circle').radius,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_2.Circle>(target, 'Circle');
        D4.requireMinArgs(positional, 1, 'contains');
        final point = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'point', 'contains');
        return t.contains(point);
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_2.Circle>(target, 'Circle');
        return t.describe();
      },
    },
    constructorSignatures: {
      '': 'const Circle(Vector2 center, double radius)',
    },
    methodSignatures: {
      'contains': 'bool contains(Vector2 point)',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'center': 'Vector2 get center',
      'area': 'double get area',
      'radius': 'double get radius',
    },
  );
}

// =============================================================================
// Rect Bridge
// =============================================================================

BridgedClass _createRectBridge() {
  return BridgedClass(
    nativeType: $d4rt_advanced_sample_2.Rect,
    name: 'Rect',
    isAssignable: (v) => v is $d4rt_advanced_sample_2.Rect,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Rect');
        final center = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'center', 'Rect');
        final width = D4.getRequiredArg<double>(positional, 1, 'width', 'Rect');
        final height = D4.getRequiredArg<double>(positional, 2, 'height', 'Rect');
        return $d4rt_advanced_sample_2.Rect(center, width, height);
      },
    },
    getters: {
      'center': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Rect>(target, 'Rect').center,
      'area': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Rect>(target, 'Rect').area,
      'width': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Rect>(target, 'Rect').width,
      'height': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_2.Rect>(target, 'Rect').height,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_2.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'contains');
        final point = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'point', 'contains');
        return t.contains(point);
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_2.Rect>(target, 'Rect');
        return t.describe();
      },
    },
    constructorSignatures: {
      '': 'const Rect(Vector2 center, double width, double height)',
    },
    methodSignatures: {
      'contains': 'bool contains(Vector2 point)',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'center': 'Vector2 get center',
      'area': 'double get area',
      'width': 'double get width',
      'height': 'double get height',
    },
  );
}

// =============================================================================
// Body Bridge
// =============================================================================

BridgedClass _createBodyBridge() {
  return BridgedClass(
    nativeType: $d4rt_advanced_sample_1.Body,
    name: 'Body',
    isAssignable: (v) => v is $d4rt_advanced_sample_1.Body,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Body');
        final position = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'position', 'Body');
        final velocity = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 1, 'velocity', 'Body');
        final mass = D4.getRequiredArg<double>(positional, 2, 'mass', 'Body');
        return $d4rt_advanced_sample_1.Body(position, velocity, mass);
      },
    },
    getters: {
      'position': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_1.Body>(target, 'Body').position,
      'velocity': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_1.Body>(target, 'Body').velocity,
      'mass': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_1.Body>(target, 'Body').mass,
    },
    setters: {
      'position': (visitor, target, value) => 
        D4.validateTarget<$d4rt_advanced_sample_1.Body>(target, 'Body').position = D4.extractBridgedArg<$d4rt_advanced_sample_3.Vector2>(value, 'position'),
      'velocity': (visitor, target, value) => 
        D4.validateTarget<$d4rt_advanced_sample_1.Body>(target, 'Body').velocity = D4.extractBridgedArg<$d4rt_advanced_sample_3.Vector2>(value, 'velocity'),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_1.Body>(target, 'Body');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Body(Vector2 position, Vector2 velocity, double mass)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'position': 'Vector2 get position',
      'velocity': 'Vector2 get velocity',
      'mass': 'double get mass',
    },
    setterSignatures: {
      'position': 'set position(dynamic value)',
      'velocity': 'set velocity(dynamic value)',
    },
  );
}

// =============================================================================
// PhysicsWorld Bridge
// =============================================================================

BridgedClass _createPhysicsWorldBridge() {
  return BridgedClass(
    nativeType: $d4rt_advanced_sample_1.PhysicsWorld,
    name: 'PhysicsWorld',
    isAssignable: (v) => v is $d4rt_advanced_sample_1.PhysicsWorld,
    constructors: {
      '': (visitor, positional, named) {
        final gravity = D4.getNamedArgWithDefault<$d4rt_advanced_sample_3.Vector2>(named, 'gravity', const $d4rt_advanced_sample_3.Vector2(0, -9.81));
        return $d4rt_advanced_sample_1.PhysicsWorld(gravity: gravity);
      },
    },
    getters: {
      'gravity': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_1.PhysicsWorld>(target, 'PhysicsWorld').gravity,
      'bodyCount': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_1.PhysicsWorld>(target, 'PhysicsWorld').bodyCount,
      'bodies': (visitor, target) => D4.validateTarget<$d4rt_advanced_sample_1.PhysicsWorld>(target, 'PhysicsWorld').bodies,
    },
    setters: {
      'gravity': (visitor, target, value) => 
        D4.validateTarget<$d4rt_advanced_sample_1.PhysicsWorld>(target, 'PhysicsWorld').gravity = D4.extractBridgedArg<$d4rt_advanced_sample_3.Vector2>(value, 'gravity'),
    },
    methods: {
      'addBody': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_1.PhysicsWorld>(target, 'PhysicsWorld');
        D4.requireMinArgs(positional, 2, 'addBody');
        final position = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 0, 'position', 'addBody');
        final velocity = D4.getRequiredArg<$d4rt_advanced_sample_3.Vector2>(positional, 1, 'velocity', 'addBody');
        final mass = D4.getNamedArgWithDefault<double>(named, 'mass', 1.0);
        return t.addBody(position, velocity, mass: mass);
      },
      'step': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_advanced_sample_1.PhysicsWorld>(target, 'PhysicsWorld');
        D4.requireMinArgs(positional, 1, 'step');
        final dt = D4.getRequiredArg<double>(positional, 0, 'dt', 'step');
        t.step(dt);
        return null;
      },
    },
    constructorSignatures: {
      '': 'PhysicsWorld({Vector2 gravity = const Vector2(0, -9.81)})',
    },
    methodSignatures: {
      'addBody': 'Body addBody(Vector2 position, Vector2 velocity, {double mass = 1.0})',
      'step': 'void step(double dt)',
    },
    getterSignatures: {
      'gravity': 'Vector2 get gravity',
      'bodyCount': 'int get bodyCount',
      'bodies': 'List<Body> get bodies',
    },
    setterSignatures: {
      'gravity': 'set gravity(dynamic value)',
    },
  );
}

