// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-03-12T17:02:31.409130

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';


/// Bridge class for user_guide module.
class UserGuideBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createCalculatorBridge(),
      _createGreeterBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Calculator': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\user_guide\calculator.dart',
      'Greeter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\user_guide\greeter.dart',
    };
  }

    isAssignable: (v) => v is Calculator,
    constructors: {
      '': (visitor, positional, named) {
        return Calculator();
      },
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return t.add(a, b);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'subtract');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'subtract');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'subtract');
        return t.subtract(a, b);
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
        return t.multiply(a, b);
      },
      'divide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'divide');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'divide');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'divide');
        final precision = D4.getNamedArgWithDefault<int>(named, 'precision', 2);
        return t.divide(a, b, precision: precision);
      },
    },
    staticMethods: {
      'quickAdd': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'quickAdd');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'quickAdd');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'quickAdd');
        return Calculator.quickAdd(a, b);
      },
    },
    constructorSignatures: {
      '': 'Calculator()',
    },
    methodSignatures: {
      'add': 'int add(int a, int b)',
      'subtract': 'int subtract(int a, int b)',
      'multiply': 'int multiply(int a, int b)',
      'divide': 'double divide(double a, double b, {int precision = 2})',
    },
    staticMethodSignatures: {
      'quickAdd': 'int quickAdd(int a, int b)',
    },
  );
}

// =============================================================================
// Greeter Bridge
// =============================================================================

BridgedClass _createGreeterBridge() {
  return BridgedClass(
    nativeType: Greeter,
    name: 'Greeter',
    isAssignable: (v) => v is Greeter,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Greeter');
        final greeting = D4.getRequiredArg<String>(positional, 0, 'greeting', 'Greeter');
        return Greeter(greeting);
      },
      'defaultGreeting': (visitor, positional, named) {
        return Greeter.defaultGreeting();
      },
    },
    getters: {
      'greeting': (visitor, target) => D4.validateTarget<Greeter>(target, 'Greeter').greeting,
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Greeter>(target, 'Greeter');
        D4.requireMinArgs(positional, 1, 'greet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
        return t.greet(name);
      },
      'greetAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Greeter>(target, 'Greeter');
        D4.requireMinArgs(positional, 1, 'greetAll');
        if (positional.isEmpty) {
          throw ArgumentError('greetAll: Missing required argument "names" at position 0');
        }
        final names = D4.coerceList<String>(positional[0], 'names');
        return t.greetAll(names);
      },
    },
    constructorSignatures: {
      '': 'Greeter(String greeting)',
      'defaultGreeting': 'Greeter.defaultGreeting()',
    },
    methodSignatures: {
      'greet': 'String greet(String name)',
      'greetAll': 'String greetAll(List<String> names)',
    },
    getterSignatures: {
      'greeting': 'String get greeting',
    },
  );
}

