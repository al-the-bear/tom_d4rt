// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/basic_classes.dart
// Generated: 2026-01-28T12:35:49.537458

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Basic module.
class BasicBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPersonBridge(),
      _createCalculatorBridge(),
      _createMathUtilsBridge(),
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
// Person Bridge
// =============================================================================

BridgedClass _createPersonBridge() {
  return BridgedClass(
    nativeType: $pkg.Person,
    name: 'Person',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Person');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Person');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Person');
        return $pkg.Person(name, age);
      },
      'guest': (visitor, positional, named) {
        return $pkg.Person.guest();
      },
      'withAge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Person');
        final age = D4.getRequiredArg<int>(positional, 0, 'age', 'Person');
        return $pkg.Person.withAge(age);
      },
      'fromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Person');
        final data = D4.getRequiredArg<String>(positional, 0, 'data', 'Person');
        return $pkg.Person.fromString(data);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Person>(target, 'Person').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.Person>(target, 'Person').age,
    },
    setters: {
      'age': (visitor, target, value) => 
        D4.validateTarget<$pkg.Person>(target, 'Person').age = value as int,
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Person>(target, 'Person');
        return t.greet();
      },
      'greetWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Person>(target, 'Person');
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', 'Hi');
        return t.greetWith(prefix: prefix);
      },
    },
    staticGetters: {
      'instanceCount': (visitor) => $pkg.Person.instanceCount,
    },
    staticMethods: {
      'createDefault': (visitor, positional, named, typeArgs) {
        return $pkg.Person.createDefault();
      },
    },
  );
}

// =============================================================================
// Calculator Bridge
// =============================================================================

BridgedClass _createCalculatorBridge() {
  return BridgedClass(
    nativeType: $pkg.Calculator,
    name: 'Calculator',
    constructors: {
      '': (visitor, positional, named) {
        final precision = D4.getOptionalArgWithDefault<int>(positional, 0, 'precision', 2);
        return $pkg.Calculator(precision);
      },
    },
    getters: {
      'precision': (visitor, target) => D4.validateTarget<$pkg.Calculator>(target, 'Calculator').precision,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return t.add(a, b);
      },
      'addOptional': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 1, 'addOptional');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'addOptional');
        final b = D4.getOptionalArgWithDefault<int>(positional, 1, 'b', 0);
        final c = D4.getOptionalArgWithDefault<int>(positional, 2, 'c', 0);
        return t.addOptional(a, b, c);
      },
      'calculate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        final value = D4.getRequiredNamedArg<double>(named, 'value', 'calculate');
        final multiplier = D4.getNamedArgWithDefault<double>(named, 'multiplier', 1.0);
        return t.calculate(value: value, multiplier: multiplier);
      },
    },
    staticMethods: {
      'format': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'format');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'format');
        final decimals = D4.getOptionalNamedArg<int?>(named, 'decimals');
        return $pkg.Calculator.format(value, decimals: decimals);
      },
    },
  );
}

// =============================================================================
// MathUtils Bridge
// =============================================================================

BridgedClass _createMathUtilsBridge() {
  return BridgedClass(
    nativeType: $pkg.MathUtils,
    name: 'MathUtils',
    constructors: {
    },
    staticGetters: {
      'pi': (visitor) => $pkg.MathUtils.pi,
      'e': (visitor) => $pkg.MathUtils.e,
    },
    staticMethods: {
      'circleArea': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'circleArea');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'circleArea');
        return $pkg.MathUtils.circleArea(radius);
      },
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'square');
        return $pkg.MathUtils.square(x);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'cube');
        return $pkg.MathUtils.cube(x);
      },
    },
  );
}

