// D4rt Bridge - Generated file, do not edit
// Sources: 4 files
// Generated: 2026-02-08T13:45:37.749871

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:dart_overview/dart_overview.dart' as $pkg;

/// Bridge class for all module.
class AllBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPersonBridge(),
      _createDogBridge(),
      _createUserBridge(),
      _createCalculatorBridge(),
      _createRectangleBridge(),
      _createBankAccountBridge(),
      _createCircleBridge(),
      _createBoxBridge(),
      _createWrapperBridge(),
      _createPairBridge(),
      _createStackBridge(),
      _createQueueBridge(),
      _createMaybeBridge(),
      _createResultBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Person': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'Dog': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'User': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'Calculator': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'Rectangle': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'BankAccount': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'Circle': 'package:dart_overview/classes/declarations/run_declarations.dart',
      'Box': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'Wrapper': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'Pair': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'Stack': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'Queue': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'Maybe': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'Result': 'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$pkg.Day>(
        name: 'Day',
        values: $pkg.Day.values,
      ),
      BridgedEnumDefinition<$pkg.Season>(
        name: 'Season',
        values: $pkg.Season.values,
      ),
      BridgedEnumDefinition<$pkg.HttpStatus>(
        name: 'HttpStatus',
        values: $pkg.HttpStatus.values,
      ),
      BridgedEnumDefinition<$pkg.Operation>(
        name: 'Operation',
        values: $pkg.Operation.values,
      ),
      BridgedEnumDefinition<$pkg.LogLevel>(
        name: 'LogLevel',
        values: $pkg.LogLevel.values,
      ),
      BridgedEnumDefinition<$pkg.Priority>(
        name: 'Priority',
        values: $pkg.Priority.values,
      ),
      BridgedEnumDefinition<$pkg.Role>(
        name: 'Role',
        values: $pkg.Role.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'Day': 'package:dart_overview/enums/basics/run_basics.dart',
      'Season': 'package:dart_overview/enums/basics/run_basics.dart',
      'HttpStatus': 'package:dart_overview/enums/basics/run_basics.dart',
      'Operation': 'package:dart_overview/enums/basics/run_basics.dart',
      'LogLevel': 'package:dart_overview/enums/basics/run_basics.dart',
      'Priority': 'package:dart_overview/enums/basics/run_basics.dart',
      'Role': 'package:dart_overview/enums/basics/run_basics.dart',
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

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'main': (visitor, positional, named, typeArgs) {
        return $pkg.main();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'main': 'package:dart_overview/run_dart_overview.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'main': 'Future<void> main()',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:dart_overview/classes/declarations/run_declarations.dart',
      'package:dart_overview/enums/basics/run_basics.dart',
      'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'package:dart_overview/run_dart_overview.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:dart_overview/dart_overview.dart';";
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'Day',
    'Season',
    'HttpStatus',
    'Operation',
    'LogLevel',
    'Priority',
    'Role',
  ];

}

// =============================================================================
// Person Bridge
// =============================================================================

BridgedClass _createPersonBridge() {
  return BridgedClass(
    nativeType: $pkg.Person,
    name: 'Person',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Person>(target, 'Person').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.Person>(target, 'Person').age,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$pkg.Person>(target, 'Person').name = value as String,
      'age': (visitor, target, value) => 
        D4.validateTarget<$pkg.Person>(target, 'Person').age = value as int,
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Person>(target, 'Person');
        t.greet();
        return null;
      },
    },
    methodSignatures: {
      'greet': 'void greet()',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
    },
    setterSignatures: {
      'name': 'set name(dynamic value)',
      'age': 'set age(dynamic value)',
    },
  );
}

// =============================================================================
// Dog Bridge
// =============================================================================

BridgedClass _createDogBridge() {
  return BridgedClass(
    nativeType: $pkg.Dog,
    name: 'Dog',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Dog');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Dog');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Dog');
        return $pkg.Dog(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Dog>(target, 'Dog').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.Dog>(target, 'Dog').age,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$pkg.Dog>(target, 'Dog').name = value as String,
      'age': (visitor, target, value) => 
        D4.validateTarget<$pkg.Dog>(target, 'Dog').age = value as int,
    },
    methods: {
      'bark': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dog>(target, 'Dog');
        t.bark();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Dog(String name, int age)',
    },
    methodSignatures: {
      'bark': 'void bark()',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
    },
    setterSignatures: {
      'name': 'set name(dynamic value)',
      'age': 'set age(dynamic value)',
    },
  );
}

// =============================================================================
// User Bridge
// =============================================================================

BridgedClass _createUserBridge() {
  return BridgedClass(
    nativeType: $pkg.User,
    name: 'User',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'User');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'User');
        final email = D4.getRequiredArg<String>(positional, 1, 'email', 'User');
        return $pkg.User(name, email);
      },
      'guest': (visitor, positional, named) {
        return $pkg.User.guest();
      },
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'User');
        if (positional.isEmpty) {
          throw ArgumentError('User: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return $pkg.User.fromMap(map);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.User>(target, 'User').name,
      'email': (visitor, target) => D4.validateTarget<$pkg.User>(target, 'User').email,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$pkg.User>(target, 'User').name = value as String,
      'email': (visitor, target, value) => 
        D4.validateTarget<$pkg.User>(target, 'User').email = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.User>(target, 'User');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'User(String name, String email)',
      'guest': 'User.guest()',
      'fromMap': 'User.fromMap(Map<String, dynamic> map)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'email': 'String get email',
    },
    setterSignatures: {
      'name': 'set name(dynamic value)',
      'email': 'set email(dynamic value)',
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
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return t.add(a, b);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'subtract');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'subtract');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'subtract');
        return t.subtract(a, b);
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
        return t.multiply(a, b);
      },
      'divide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'divide');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'divide');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'divide');
        return t.divide(a, b);
      },
    },
    methodSignatures: {
      'add': 'int add(int a, int b)',
      'subtract': 'int subtract(int a, int b)',
      'multiply': 'int multiply(int a, int b)',
      'divide': 'double divide(int a, int b)',
    },
  );
}

// =============================================================================
// Rectangle Bridge
// =============================================================================

BridgedClass _createRectangleBridge() {
  return BridgedClass(
    nativeType: $pkg.Rectangle,
    name: 'Rectangle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return $pkg.Rectangle(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').height,
      'area': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').area,
      'perimeter': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').perimeter,
    },
    setters: {
      'width': (visitor, target, value) => 
        D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').width = value as double,
      'height': (visitor, target, value) => 
        D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').height = value as double,
      'scale': (visitor, target, value) => 
        D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').scale = value as dynamic,
    },
    constructorSignatures: {
      '': 'Rectangle(double width, double height)',
    },
    getterSignatures: {
      'width': 'double get width',
      'height': 'double get height',
      'area': 'double get area',
      'perimeter': 'double get perimeter',
    },
    setterSignatures: {
      'width': 'set width(dynamic value)',
      'height': 'set height(dynamic value)',
      'scale': 'set scale(double value)',
    },
  );
}

// =============================================================================
// BankAccount Bridge
// =============================================================================

BridgedClass _createBankAccountBridge() {
  return BridgedClass(
    nativeType: $pkg.BankAccount,
    name: 'BankAccount',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BankAccount');
        final accountNumber = D4.getRequiredArg<String>(positional, 0, 'accountNumber', 'BankAccount');
        final balance = D4.getRequiredArg<double>(positional, 1, '_balance', 'BankAccount');
        return $pkg.BankAccount(accountNumber, balance);
      },
    },
    getters: {
      'accountNumber': (visitor, target) => D4.validateTarget<$pkg.BankAccount>(target, 'BankAccount').accountNumber,
      'balance': (visitor, target) => D4.validateTarget<$pkg.BankAccount>(target, 'BankAccount').balance,
    },
    methods: {
      'deposit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BankAccount>(target, 'BankAccount');
        D4.requireMinArgs(positional, 1, 'deposit');
        final amount = D4.getRequiredArg<double>(positional, 0, 'amount', 'deposit');
        t.deposit(amount);
        return null;
      },
      'withdraw': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BankAccount>(target, 'BankAccount');
        D4.requireMinArgs(positional, 1, 'withdraw');
        final amount = D4.getRequiredArg<double>(positional, 0, 'amount', 'withdraw');
        return t.withdraw(amount);
      },
    },
    constructorSignatures: {
      '': 'BankAccount(String accountNumber, double _balance)',
    },
    methodSignatures: {
      'deposit': 'void deposit(double amount)',
      'withdraw': 'bool withdraw(double amount)',
    },
    getterSignatures: {
      'accountNumber': 'String get accountNumber',
      'balance': 'double get balance',
    },
  );
}

// =============================================================================
// Circle Bridge
// =============================================================================

BridgedClass _createCircleBridge() {
  return BridgedClass(
    nativeType: $pkg.Circle,
    name: 'Circle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return $pkg.Circle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').radius,
      'diameter': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').diameter,
      'circumference': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').circumference,
      'circleArea': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').circleArea,
    },
    constructorSignatures: {
      '': 'Circle(double radius)',
    },
    getterSignatures: {
      'radius': 'double get radius',
      'diameter': 'double get diameter',
      'circumference': 'double get circumference',
      'circleArea': 'double get circleArea',
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
        D4.requireMinArgs(positional, 1, 'Box');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Box');
        return $pkg.Box(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.Box>(target, 'Box').value,
    },
    constructorSignatures: {
      '': 'Box(T value)',
    },
    getterSignatures: {
      'value': 'T get value',
    },
  );
}

// =============================================================================
// Wrapper Bridge
// =============================================================================

BridgedClass _createWrapperBridge() {
  return BridgedClass(
    nativeType: $pkg.Wrapper,
    name: 'Wrapper',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Wrapper');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Wrapper');
        return $pkg.Wrapper(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.Wrapper>(target, 'Wrapper').value,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$pkg.Wrapper>(target, 'Wrapper').value = value as dynamic,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Wrapper>(target, 'Wrapper');
        D4.requireMinArgs(positional, 1, 'transform');
        if (positional.isEmpty) {
          throw ArgumentError('transform: Missing required argument "f" at position 0');
        }
        final fRaw = positional[0];
        return t.transform((dynamic p0) { return (fRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; });
      },
    },
    constructorSignatures: {
      '': 'Wrapper(T value)',
    },
    methodSignatures: {
      'transform': 'Wrapper<R> transform(R Function(T) f)',
    },
    getterSignatures: {
      'value': 'T get value',
    },
    setterSignatures: {
      'value': 'set value(dynamic value)',
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
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Pair>(target, 'Pair');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Pair(F first, S second)',
    },
    methodSignatures: {
      'swap': 'Pair<S, F> swap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'first': 'F get first',
      'second': 'S get second',
    },
  );
}

// =============================================================================
// Stack Bridge
// =============================================================================

BridgedClass _createStackBridge() {
  return BridgedClass(
    nativeType: $pkg.Stack,
    name: 'Stack',
    constructors: {
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$pkg.Stack>(target, 'Stack').isEmpty,
      'length': (visitor, target) => D4.validateTarget<$pkg.Stack>(target, 'Stack').length,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Stack>(target, 'Stack');
        D4.requireMinArgs(positional, 1, 'push');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'push');
        t.push(item);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Stack>(target, 'Stack');
        return t.pop();
      },
      'peek': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Stack>(target, 'Stack');
        return t.peek();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Stack>(target, 'Stack');
        return t.toString();
      },
    },
    methodSignatures: {
      'push': 'void push(T item)',
      'pop': 'T pop()',
      'peek': 'T peek()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isEmpty': 'bool get isEmpty',
      'length': 'int get length',
    },
  );
}

// =============================================================================
// Queue Bridge
// =============================================================================

BridgedClass _createQueueBridge() {
  return BridgedClass(
    nativeType: $pkg.Queue,
    name: 'Queue',
    constructors: {
    },
    getters: {
      'front': (visitor, target) => D4.validateTarget<$pkg.Queue>(target, 'Queue').front,
      'isEmpty': (visitor, target) => D4.validateTarget<$pkg.Queue>(target, 'Queue').isEmpty,
      'length': (visitor, target) => D4.validateTarget<$pkg.Queue>(target, 'Queue').length,
    },
    methods: {
      'enqueue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Queue>(target, 'Queue');
        D4.requireMinArgs(positional, 1, 'enqueue');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'enqueue');
        t.enqueue(item);
        return null;
      },
      'dequeue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Queue>(target, 'Queue');
        return t.dequeue();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Queue>(target, 'Queue');
        return t.toString();
      },
    },
    methodSignatures: {
      'enqueue': 'void enqueue(T item)',
      'dequeue': 'T dequeue()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'front': 'T get front',
      'isEmpty': 'bool get isEmpty',
      'length': 'int get length',
    },
  );
}

// =============================================================================
// Maybe Bridge
// =============================================================================

BridgedClass _createMaybeBridge() {
  return BridgedClass(
    nativeType: $pkg.Maybe,
    name: 'Maybe',
    constructors: {
      'some': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Maybe');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Maybe');
        return $pkg.Maybe.some(value);
      },
      'none': (visitor, positional, named) {
        return $pkg.Maybe.none();
      },
    },
    getters: {
      'hasValue': (visitor, target) => D4.validateTarget<$pkg.Maybe>(target, 'Maybe').hasValue,
      'value': (visitor, target) => D4.validateTarget<$pkg.Maybe>(target, 'Maybe').value,
    },
    methods: {
      'getOrElse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Maybe>(target, 'Maybe');
        D4.requireMinArgs(positional, 1, 'getOrElse');
        final defaultValue = D4.getRequiredArg<dynamic>(positional, 0, 'defaultValue', 'getOrElse');
        return t.getOrElse(defaultValue);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Maybe>(target, 'Maybe');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "f" at position 0');
        }
        final fRaw = positional[0];
        return t.map((dynamic p0) { return (fRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; });
      },
    },
    constructorSignatures: {
      'some': 'Maybe.some(T value)',
      'none': 'Maybe.none()',
    },
    methodSignatures: {
      'getOrElse': 'T getOrElse(T defaultValue)',
      'map': 'Maybe<R> map(R Function(T) f)',
    },
    getterSignatures: {
      'hasValue': 'bool get hasValue',
      'value': 'T get value',
    },
  );
}

// =============================================================================
// Result Bridge
// =============================================================================

BridgedClass _createResultBridge() {
  return BridgedClass(
    nativeType: $pkg.Result,
    name: 'Result',
    constructors: {
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Result');
        return $pkg.Result.success(value);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final error = D4.getRequiredArg<dynamic>(positional, 0, 'error', 'Result');
        return $pkg.Result.failure(error);
      },
    },
    getters: {
      'isSuccess': (visitor, target) => D4.validateTarget<$pkg.Result>(target, 'Result').isSuccess,
    },
    methods: {
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Result>(target, 'Result');
        D4.requireMinArgs(positional, 2, 'fold');
        if (positional.isEmpty) {
          throw ArgumentError('fold: Missing required argument "onSuccess" at position 0');
        }
        final onSuccessRaw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "onFailure" at position 1');
        }
        final onFailureRaw = positional[1];
        return t.fold((dynamic p0) { return (onSuccessRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; }, (dynamic p0) { return (onFailureRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; });
      },
    },
    constructorSignatures: {
      'success': 'Result.success(T value)',
      'failure': 'Result.failure(E error)',
    },
    methodSignatures: {
      'fold': 'R fold(R Function(T) onSuccess, R Function(E) onFailure)',
    },
    getterSignatures: {
      'isSuccess': 'bool get isSuccess',
    },
  );
}

