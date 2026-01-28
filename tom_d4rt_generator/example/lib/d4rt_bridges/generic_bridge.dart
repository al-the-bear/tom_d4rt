// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/generic_classes.dart
// Generated: 2026-01-28T16:26:31.634646

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Generic module.
class GenericBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createEntityBridge(),
      _createBoxBridge(),
      _createRepositoryBridge(),
      _createPairBridge(),
      _createTransformerBridge(),
    ];
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_generator_example/test_classes.dart';";
  }

}

// =============================================================================
// Entity Bridge
// =============================================================================

BridgedClass _createEntityBridge() {
  return BridgedClass(
    nativeType: $pkg.Entity,
    name: 'Entity',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Entity');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'Entity');
        final name = D4.getRequiredArg<String>(positional, 1, 'name', 'Entity');
        return $pkg.Entity(id, name);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$pkg.Entity>(target, 'Entity').id,
      'name': (visitor, target) => D4.validateTarget<$pkg.Entity>(target, 'Entity').name,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Entity>(target, 'Entity');
        return t.toString();
      },
    },
  );
}

// =============================================================================
// Box Bridge
// =============================================================================

BridgedClass _createBoxBridge() {
  return BridgedClass(
    nativeType: $pkg.Box,
    name: 'Box',
    constructors: {
      '': (visitor, positional, named) {
        final _value = D4.getOptionalArg<dynamic>(positional, 0, '_value');
        return $pkg.Box(_value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.Box>(target, 'Box').value,
      'isEmpty': (visitor, target) => D4.validateTarget<$pkg.Box>(target, 'Box').isEmpty,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$pkg.Box>(target, 'Box').value = value as dynamic,
    },
    methods: {
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Box>(target, 'Box');
        t.clear();
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Box>(target, 'Box');
        D4.requireMinArgs(positional, 1, 'transform');
        if (positional.length <= 0) {
          throw ArgumentError('transform: Missing required argument "transformer" at position 0');
        }
        final transformer_raw = positional[0];
        return t.transform((dynamic p0) { return (transformer_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as dynamic; });
      },
    },
    staticMethods: {
      'filled': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'filled');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'filled');
        return $pkg.Box.filled(value);
      },
      'identity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return $pkg.Box.identity(value);
      },
    },
  );
}

// =============================================================================
// Repository Bridge
// =============================================================================

BridgedClass _createRepositoryBridge() {
  return BridgedClass(
    nativeType: $pkg.Repository,
    name: 'Repository',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Repository();
      },
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<$pkg.Repository>(target, 'Repository').count,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<$pkg.Identifiable>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'getById': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'getById');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'getById');
        return t.getById(id);
      },
      'getAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Repository>(target, 'Repository');
        return t.getAll();
      },
      'findWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'findWhere');
        if (positional.length <= 0) {
          throw ArgumentError('findWhere: Missing required argument "predicate" at position 0');
        }
        final predicate_raw = positional[0];
        return t.findWhere(($pkg.Identifiable p0) { return (predicate_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as bool; });
      },
      'mapAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'mapAll');
        if (positional.length <= 0) {
          throw ArgumentError('mapAll: Missing required argument "mapper" at position 0');
        }
        final mapper_raw = positional[0];
        return t.mapAll(($pkg.Identifiable p0) { return (mapper_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as dynamic; });
      },
    },
    staticMethods: {
      'fromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromList');
        if (positional.length <= 0) {
          throw ArgumentError('fromList: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$pkg.Identifiable>(positional[0], 'items');
        return $pkg.Repository.fromList(items);
      },
    },
  );
}

// =============================================================================
// Pair Bridge
// =============================================================================

BridgedClass _createPairBridge() {
  return BridgedClass(
    nativeType: $pkg.Pair,
    name: 'Pair',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'Pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'Pair');
        return $pkg.Pair(first, second);
      },
    },
    getters: {
      'first': (visitor, target) => D4.validateTarget<$pkg.Pair>(target, 'Pair').first,
      'second': (visitor, target) => D4.validateTarget<$pkg.Pair>(target, 'Pair').second,
    },
    methods: {
      'swap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Pair>(target, 'Pair');
        return t.swap();
      },
      'mapBoth': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 2, 'mapBoth');
        if (positional.length <= 0) {
          throw ArgumentError('mapBoth: Missing required argument "mapFirst" at position 0');
        }
        final mapFirst_raw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('mapBoth: Missing required argument "mapSecond" at position 1');
        }
        final mapSecond_raw = positional[1];
        return t.mapBoth((dynamic p0) { return (mapFirst_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as dynamic; }, (dynamic p0) { return (mapSecond_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as dynamic; });
      },
      'withFirst': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 1, 'withFirst');
        final newFirst = D4.getRequiredArg<dynamic>(positional, 0, 'newFirst', 'withFirst');
        return t.withFirst(newFirst);
      },
      'withSecond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 1, 'withSecond');
        final newSecond = D4.getRequiredArg<dynamic>(positional, 0, 'newSecond', 'withSecond');
        return t.withSecond(newSecond);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Pair>(target, 'Pair');
        return t.toString();
      },
    },
  );
}

// =============================================================================
// Transformer Bridge
// =============================================================================

BridgedClass _createTransformerBridge() {
  return BridgedClass(
    nativeType: $pkg.Transformer,
    name: 'Transformer',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Transformer();
      },
    },
    methods: {
      'identity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return t.identity(value);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'cast');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'cast');
        return t.cast(value);
      },
      'singleton': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'singleton');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'singleton');
        return t.singleton(value);
      },
      'pair': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 2, 'pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'pair');
        return t.pair(first, second);
      },
      'idOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'idOf');
        final item = D4.getRequiredArg<$pkg.Identifiable>(positional, 0, 'item', 'idOf');
        return t.idOf(item);
      },
    },
    staticMethods: {
      'repeat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'repeat');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'repeat');
        final count = D4.getRequiredArg<int>(positional, 1, 'count', 'repeat');
        return $pkg.Transformer.repeat(value, count);
      },
    },
  );
}

