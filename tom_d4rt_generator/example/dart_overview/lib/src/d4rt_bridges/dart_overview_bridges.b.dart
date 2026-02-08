// D4rt Bridge - Generated file, do not edit
// Sources: 12 files
// Generated: 2026-02-08T15:00:18.536716

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
      _createVehicleBridge(),
      _createCarBridge(),
      _createMotorcycleBridge(),
      _createBaseAnimalBridge(),
      _createDogAnimalBridge(),
      _createDataSourceBridge(),
      _createJsonDataSourceBridge(),
      _createXmlDataSourceBridge(),
      _createAppConfigBridge(),
      _createSealedShapeBridge(),
      _createSealedCircleBridge(),
      _createSealedSquareBridge(),
      _createSealedTriangleBridge(),
      _createLoggerMixinBridge(),
      _createLoggingServiceBridge(),
      _createAbstractBaseClassBridge(),
      _createDerivedFromAbstractBaseBridge(),
      _createApiClientBridge(),
      _createRestApiClientBridge(),
      _createGraphqlApiClientBridge(),
      _createAbstractFinalClassBridge(),
      _createSingletonHolderBridge(),
      _createSimplePointBridge(),
      _createPointBridge(),
      _createRectangleAreaBridge(),
      _createPositiveNumberBridge(),
      _createVectorBridge(),
      _createColorBridge(),
      _createLoggerBridge(),
      _createCircleShapeBridge(),
      _createSquareShapeBridge(),
      _createDatabaseBridge(),
      _createPersonBaseBridge(),
      _createEmployeeBridge(),
      _createManagerBridge(),
      _createAnimalBridge(),
      _createCatBridge(),
      _createNotificationServiceBridge(),
      _createEmailNotificationServiceBridge(),
      _createSmsNotificationServiceBridge(),
      _createSwitchableBridge(),
      _createTemperatureControlBridge(),
      _createConnectableBridge(),
      _createSmartThermostatBridge(),
      _createMachineBridge(),
      _createSpeakableBridge(),
      _createRobotBridge(),
      _createAdvancedRobotBridge(),
      _createMathUtilsBridge(),
      _createCounterBridge(),
      _createFlexibleObjectBridge(),
      _createSortablePersonBridge(),
      _createMusicianBridge(),
      _createProfessionalDancerBridge(),
      _createEntertainerBridge(),
      _createCountableItemBridge(),
      _createConsoleLoggerBridge(),
      _createMultiMixedBridge(),
      _createHelperBridge(),
      _createHelpfulServiceBridge(),
      _createButtonBridge(),
      _createSortableItemBridge(),
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
      'Vehicle': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'Car': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'Motorcycle': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'BaseAnimal': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'DogAnimal': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'DataSource': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'JsonDataSource': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'XmlDataSource': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'AppConfig': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'SealedShape': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'SealedCircle': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'SealedSquare': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'SealedTriangle': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'LoggerMixin': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'LoggingService': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'AbstractBaseClass': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'DerivedFromAbstractBase': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'ApiClient': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'RestApiClient': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'GraphqlApiClient': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'AbstractFinalClass': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'SingletonHolder': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'SimplePoint': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Point': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'RectangleArea': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'PositiveNumber': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Vector': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Color': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Logger': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'CircleShape': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'SquareShape': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Database': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'PersonBase': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Employee': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Manager': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Animal': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Cat': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'NotificationService': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'EmailNotificationService': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'SmsNotificationService': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Switchable': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'TemperatureControl': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Connectable': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'SmartThermostat': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Machine': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Speakable': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Robot': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'AdvancedRobot': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'MathUtils': 'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart',
      'Counter': 'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart',
      'FlexibleObject': 'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart',
      'SortablePerson': 'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart',
      'Musician': 'package:dart_overview/mixins/basics/run_basics.dart',
      'ProfessionalDancer': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Entertainer': 'package:dart_overview/mixins/basics/run_basics.dart',
      'CountableItem': 'package:dart_overview/mixins/basics/run_basics.dart',
      'ConsoleLogger': 'package:dart_overview/mixins/basics/run_basics.dart',
      'MultiMixed': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Helper': 'package:dart_overview/mixins/basics/run_basics.dart',
      'HelpfulService': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Button': 'package:dart_overview/mixins/basics/run_basics.dart',
      'SortableItem': 'package:dart_overview/mixins/basics/run_basics.dart',
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
      interpreter.registerGlobalVariable('globalCounter', $pkg.globalCounter, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "globalCounter": $e');
    }
    try {
      interpreter.registerGlobalVariable('appName', $pkg.appName, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxRetries', $pkg.maxRetries, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxRetries": $e');
    }
    try {
      interpreter.registerGlobalVariable('currentUser', $pkg.currentUser, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "currentUser": $e');
    }
    try {
      interpreter.registerGlobalVariable('lastProcessedId', $pkg.lastProcessedId, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "lastProcessedId": $e');
    }
    try {
      interpreter.registerGlobalVariable('appStartTime', $pkg.appStartTime, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "appStartTime": $e');
    }
    try {
      interpreter.registerGlobalVariable('sessionId', $pkg.sessionId, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "sessionId": $e');
    }
    try {
      interpreter.registerGlobalVariable('apiUrl', $pkg.apiUrl, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "apiUrl": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxConnections', $pkg.maxConnections, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxConnections": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTimeout', $pkg.defaultTimeout, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('validStatuses', $pkg.validStatuses, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "validStatuses": $e');
    }
    try {
      interpreter.registerGlobalVariable('priorities', $pkg.priorities, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "priorities": $e');
    }
    try {
      interpreter.registerGlobalVariable('reservedIds', $pkg.reservedIds, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "reservedIds": $e');
    }
    try {
      interpreter.registerGlobalVariable('lazyConfig', $pkg.lazyConfig, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "lazyConfig": $e');
    }
    interpreter.registerGlobalGetter('now', () => $pkg.now, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    interpreter.registerGlobalGetter('connectionCount', () => $pkg.connectionCount, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    interpreter.registerGlobalGetter('cachedValue', () => $pkg.cachedValue, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (all):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'main': (visitor, positional, named, typeArgs) {
        return $pkg.main();
      },
      'multiply': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
        return $pkg.multiply(a, b);
      },
      'printSeparator': (visitor, positional, named, typeArgs) {
        return $pkg.printSeparator();
      },
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'square');
        return $pkg.square(n);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'cube');
        return $pkg.cube(n);
      },
      'isEven': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEven');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'isEven');
        return $pkg.isEven(n);
      },
      'getNumbers': (visitor, positional, named, typeArgs) {
        return $pkg.getNumbers();
      },
      'createUser': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'createUser');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createUser');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'createUser');
        return $pkg.createUser(name, age);
      },
      'inferredReturn': (visitor, positional, named, typeArgs) {
        return $pkg.inferredReturn();
      },
      'dynamicReturn': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dynamicReturn');
        final choice = D4.getRequiredArg<int>(positional, 0, 'choice', 'dynamicReturn');
        return $pkg.dynamicReturn(choice);
      },
      'describe': (visitor, positional, named, typeArgs) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'describe');
        final age = D4.getOptionalNamedArg<int?>(named, 'age');
        final city = D4.getOptionalNamedArg<String?>(named, 'city');
        return $pkg.describe(name: name, age: age, city: city);
      },
      'sayHello': (visitor, positional, named, typeArgs) {
        final name = D4.getOptionalArgWithDefault<String>(positional, 0, 'name', 'World');
        final greeting = D4.getOptionalArgWithDefault<String>(positional, 1, 'greeting', 'Hello');
        return $pkg.sayHello(name, greeting);
      },
      'power': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'power');
        final base = D4.getRequiredArg<int>(positional, 0, 'base', 'power');
        final exponent = D4.getOptionalArgWithDefault<int>(positional, 1, 'exponent', 2);
        return $pkg.power(base, exponent);
      },
      'makeRequest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'makeRequest');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'makeRequest');
        final method = D4.getNamedArgWithDefault<String>(named, 'method', 'GET');
        final timeout = D4.getNamedArgWithDefault<int>(named, 'timeout', 30);
        final headers = D4.getOptionalNamedArg<Map<String, String>?>(named, 'headers');
        return $pkg.makeRequest(url, method: method, timeout: timeout, headers: headers);
      },
      'processOrder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processOrder');
        final orderId = D4.getRequiredArg<String>(positional, 0, 'orderId', 'processOrder');
        final product = D4.getRequiredArg<String>(positional, 1, 'product', 'processOrder');
        final quantity = D4.getRequiredNamedArg<int>(named, 'quantity', 'processOrder');
        final priority = D4.getNamedArgWithDefault<String>(named, 'priority', 'normal');
        return $pkg.processOrder(orderId, product, quantity: quantity, priority: priority);
      },
      'transform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transform');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'transform');
        final transformer = D4.getRequiredArg<int Function(int)>(positional, 1, 'transformer', 'transform');
        return $pkg.transform(numbers, transformer);
      },
      'fetchData': (visitor, positional, named, typeArgs) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'fetchData');
        final onSuccess = D4.getRequiredNamedArg<void Function(String)>(named, 'onSuccess', 'fetchData');
        final onError = D4.getRequiredNamedArg<void Function(String)>(named, 'onError', 'fetchData');
        return $pkg.fetchData(url: url, onSuccess: onSuccess, onError: onError);
      },
      'log': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        return $pkg.log(message);
      },
      'firstOrNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'firstOrNull');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'firstOrNull');
        return $pkg.firstOrNull<dynamic>(items);
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
      'multiply': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'printSeparator': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'square': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'cube': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'isEven': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'getNumbers': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'createUser': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'inferredReturn': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'dynamicReturn': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'describe': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'sayHello': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'power': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'makeRequest': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'processOrder': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'transform': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'fetchData': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'log': 'package:dart_overview/globals/basics/run_basics.dart',
      'firstOrNull': 'package:dart_overview/globals/basics/run_basics.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'main': 'Future<void> main()',
      'multiply': 'int multiply(int a, int b)',
      'printSeparator': 'void printSeparator()',
      'square': 'int square(int n)',
      'cube': 'int cube(int n)',
      'isEven': 'bool isEven(int n)',
      'getNumbers': 'List<int> getNumbers()',
      'createUser': 'Map<String, dynamic> createUser(String name, int age)',
      'inferredReturn': 'dynamic inferredReturn()',
      'dynamicReturn': 'dynamic dynamicReturn(int choice)',
      'describe': 'void describe({required String name, int? age, String? city})',
      'sayHello': 'String sayHello([String name = \'World\', String greeting = \'Hello\'])',
      'power': 'int power(int base, [int exponent = 2])',
      'makeRequest': 'void makeRequest(String url, {String method = \'GET\', int timeout = 30, Map<String, String>? headers})',
      'processOrder': 'void processOrder(String orderId, String product, {required int quantity, String priority = \'normal\'})',
      'transform': 'List<int> transform(List<int> numbers, int Function(int) transformer)',
      'fetchData': 'void fetchData({required String url, required void Function(String) onSuccess, required void Function(String) onError})',
      'log': 'void log(String message)',
      'firstOrNull': 'T? firstOrNull(List<T> items)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'package:dart_overview/classes/constructors/run_constructors.dart',
      'package:dart_overview/classes/declarations/run_declarations.dart',
      'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart',
      'package:dart_overview/enums/basics/run_basics.dart',
      'package:dart_overview/functions/declarations/run_declarations.dart',
      'package:dart_overview/functions/parameters/run_parameters.dart',
      'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'package:dart_overview/globals/basics/run_basics.dart',
      'package:dart_overview/mixins/basics/run_basics.dart',
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

// =============================================================================
// Vehicle Bridge
// =============================================================================

BridgedClass _createVehicleBridge() {
  return BridgedClass(
    nativeType: $pkg.Vehicle,
    name: 'Vehicle',
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vehicle>(target, 'Vehicle');
        return t.move();
      },
    },
    methodSignatures: {
      'move': 'String move()',
    },
  );
}

// =============================================================================
// Car Bridge
// =============================================================================

BridgedClass _createCarBridge() {
  return BridgedClass(
    nativeType: $pkg.Car,
    name: 'Car',
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Car>(target, 'Car');
        return t.move();
      },
    },
    methodSignatures: {
      'move': 'String move()',
    },
  );
}

// =============================================================================
// Motorcycle Bridge
// =============================================================================

BridgedClass _createMotorcycleBridge() {
  return BridgedClass(
    nativeType: $pkg.Motorcycle,
    name: 'Motorcycle',
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Motorcycle>(target, 'Motorcycle');
        return t.move();
      },
    },
    methodSignatures: {
      'move': 'String move()',
    },
  );
}

// =============================================================================
// BaseAnimal Bridge
// =============================================================================

BridgedClass _createBaseAnimalBridge() {
  return BridgedClass(
    nativeType: $pkg.BaseAnimal,
    name: 'BaseAnimal',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BaseAnimal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'BaseAnimal');
        return $pkg.BaseAnimal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.BaseAnimal>(target, 'BaseAnimal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BaseAnimal>(target, 'BaseAnimal');
        t.eat();
        return null;
      },
    },
    constructorSignatures: {
      '': 'BaseAnimal(String name)',
    },
    methodSignatures: {
      'eat': 'void eat()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// DogAnimal Bridge
// =============================================================================

BridgedClass _createDogAnimalBridge() {
  return BridgedClass(
    nativeType: $pkg.DogAnimal,
    name: 'DogAnimal',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DogAnimal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DogAnimal');
        return $pkg.DogAnimal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.DogAnimal>(target, 'DogAnimal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DogAnimal>(target, 'DogAnimal');
        t.eat();
        return null;
      },
    },
    constructorSignatures: {
      '': 'DogAnimal(String name)',
    },
    methodSignatures: {
      'eat': 'void eat()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// DataSource Bridge
// =============================================================================

BridgedClass _createDataSourceBridge() {
  return BridgedClass(
    nativeType: $pkg.DataSource,
    name: 'DataSource',
    constructors: {
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DataSource>(target, 'DataSource');
        return t.fetch();
      },
    },
    methodSignatures: {
      'fetch': 'String fetch()',
    },
  );
}

// =============================================================================
// JsonDataSource Bridge
// =============================================================================

BridgedClass _createJsonDataSourceBridge() {
  return BridgedClass(
    nativeType: $pkg.JsonDataSource,
    name: 'JsonDataSource',
    constructors: {
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.JsonDataSource>(target, 'JsonDataSource');
        return t.fetch();
      },
    },
    methodSignatures: {
      'fetch': 'String fetch()',
    },
  );
}

// =============================================================================
// XmlDataSource Bridge
// =============================================================================

BridgedClass _createXmlDataSourceBridge() {
  return BridgedClass(
    nativeType: $pkg.XmlDataSource,
    name: 'XmlDataSource',
    constructors: {
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.XmlDataSource>(target, 'XmlDataSource');
        return t.fetch();
      },
    },
    methodSignatures: {
      'fetch': 'String fetch()',
    },
  );
}

// =============================================================================
// AppConfig Bridge
// =============================================================================

BridgedClass _createAppConfigBridge() {
  return BridgedClass(
    nativeType: $pkg.AppConfig,
    name: 'AppConfig',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AppConfig');
        final environment = D4.getRequiredArg<String>(positional, 0, 'environment', 'AppConfig');
        final debug = D4.getRequiredArg<bool>(positional, 1, 'debug', 'AppConfig');
        return $pkg.AppConfig(environment, debug);
      },
    },
    getters: {
      'environment': (visitor, target) => D4.validateTarget<$pkg.AppConfig>(target, 'AppConfig').environment,
      'debug': (visitor, target) => D4.validateTarget<$pkg.AppConfig>(target, 'AppConfig').debug,
    },
    methods: {
      'getSetting': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AppConfig>(target, 'AppConfig');
        return t.getSetting();
      },
    },
    constructorSignatures: {
      '': 'AppConfig(String environment, bool debug)',
    },
    methodSignatures: {
      'getSetting': 'String getSetting()',
    },
    getterSignatures: {
      'environment': 'String get environment',
      'debug': 'bool get debug',
    },
  );
}

// =============================================================================
// SealedShape Bridge
// =============================================================================

BridgedClass _createSealedShapeBridge() {
  return BridgedClass(
    nativeType: $pkg.SealedShape,
    name: 'SealedShape',
    constructors: {
    },
  );
}

// =============================================================================
// SealedCircle Bridge
// =============================================================================

BridgedClass _createSealedCircleBridge() {
  return BridgedClass(
    nativeType: $pkg.SealedCircle,
    name: 'SealedCircle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SealedCircle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'SealedCircle');
        return $pkg.SealedCircle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$pkg.SealedCircle>(target, 'SealedCircle').radius,
    },
    constructorSignatures: {
      '': 'SealedCircle(double radius)',
    },
    getterSignatures: {
      'radius': 'double get radius',
    },
  );
}

// =============================================================================
// SealedSquare Bridge
// =============================================================================

BridgedClass _createSealedSquareBridge() {
  return BridgedClass(
    nativeType: $pkg.SealedSquare,
    name: 'SealedSquare',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SealedSquare');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'SealedSquare');
        return $pkg.SealedSquare(side);
      },
    },
    getters: {
      'side': (visitor, target) => D4.validateTarget<$pkg.SealedSquare>(target, 'SealedSquare').side,
    },
    constructorSignatures: {
      '': 'SealedSquare(double side)',
    },
    getterSignatures: {
      'side': 'double get side',
    },
  );
}

// =============================================================================
// SealedTriangle Bridge
// =============================================================================

BridgedClass _createSealedTriangleBridge() {
  return BridgedClass(
    nativeType: $pkg.SealedTriangle,
    name: 'SealedTriangle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SealedTriangle');
        final base = D4.getRequiredArg<double>(positional, 0, 'base', 'SealedTriangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'SealedTriangle');
        return $pkg.SealedTriangle(base, height);
      },
    },
    getters: {
      'base': (visitor, target) => D4.validateTarget<$pkg.SealedTriangle>(target, 'SealedTriangle').base,
      'height': (visitor, target) => D4.validateTarget<$pkg.SealedTriangle>(target, 'SealedTriangle').height,
    },
    constructorSignatures: {
      '': 'SealedTriangle(double base, double height)',
    },
    getterSignatures: {
      'base': 'double get base',
      'height': 'double get height',
    },
  );
}

// =============================================================================
// LoggerMixin Bridge
// =============================================================================

BridgedClass _createLoggerMixinBridge() {
  return BridgedClass(
    nativeType: $pkg.LoggerMixin,
    name: 'LoggerMixin',
    constructors: {
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LoggerMixin>(target, 'LoggerMixin');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        t.log(message);
        return null;
      },
    },
    methodSignatures: {
      'log': 'void log(String message)',
    },
  );
}

// =============================================================================
// LoggingService Bridge
// =============================================================================

BridgedClass _createLoggingServiceBridge() {
  return BridgedClass(
    nativeType: $pkg.LoggingService,
    name: 'LoggingService',
    constructors: {
    },
    methods: {
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LoggingService>(target, 'LoggingService');
        t.performAction();
        return null;
      },
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LoggingService>(target, 'LoggingService');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        t.log(message);
        return null;
      },
    },
    methodSignatures: {
      'performAction': 'void performAction()',
      'log': 'void log(String message)',
    },
  );
}

// =============================================================================
// AbstractBaseClass Bridge
// =============================================================================

BridgedClass _createAbstractBaseClassBridge() {
  return BridgedClass(
    nativeType: $pkg.AbstractBaseClass,
    name: 'AbstractBaseClass',
    constructors: {
    },
    methods: {
      'doSomething': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AbstractBaseClass>(target, 'AbstractBaseClass');
        t.doSomething();
        return null;
      },
    },
    methodSignatures: {
      'doSomething': 'void doSomething()',
    },
  );
}

// =============================================================================
// DerivedFromAbstractBase Bridge
// =============================================================================

BridgedClass _createDerivedFromAbstractBaseBridge() {
  return BridgedClass(
    nativeType: $pkg.DerivedFromAbstractBase,
    name: 'DerivedFromAbstractBase',
    constructors: {
    },
    methods: {
      'doSomething': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DerivedFromAbstractBase>(target, 'DerivedFromAbstractBase');
        t.doSomething();
        return null;
      },
    },
    methodSignatures: {
      'doSomething': 'void doSomething()',
    },
  );
}

// =============================================================================
// ApiClient Bridge
// =============================================================================

BridgedClass _createApiClientBridge() {
  return BridgedClass(
    nativeType: $pkg.ApiClient,
    name: 'ApiClient',
    constructors: {
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ApiClient>(target, 'ApiClient');
        D4.requireMinArgs(positional, 1, 'request');
        final endpoint = D4.getRequiredArg<String>(positional, 0, 'endpoint', 'request');
        return t.request(endpoint);
      },
    },
    methodSignatures: {
      'request': 'String request(String endpoint)',
    },
  );
}

// =============================================================================
// RestApiClient Bridge
// =============================================================================

BridgedClass _createRestApiClientBridge() {
  return BridgedClass(
    nativeType: $pkg.RestApiClient,
    name: 'RestApiClient',
    constructors: {
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RestApiClient>(target, 'RestApiClient');
        D4.requireMinArgs(positional, 1, 'request');
        final endpoint = D4.getRequiredArg<String>(positional, 0, 'endpoint', 'request');
        return t.request(endpoint);
      },
    },
    methodSignatures: {
      'request': 'String request(String endpoint)',
    },
  );
}

// =============================================================================
// GraphqlApiClient Bridge
// =============================================================================

BridgedClass _createGraphqlApiClientBridge() {
  return BridgedClass(
    nativeType: $pkg.GraphqlApiClient,
    name: 'GraphqlApiClient',
    constructors: {
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.GraphqlApiClient>(target, 'GraphqlApiClient');
        D4.requireMinArgs(positional, 1, 'request');
        final endpoint = D4.getRequiredArg<String>(positional, 0, 'endpoint', 'request');
        return t.request(endpoint);
      },
    },
    methodSignatures: {
      'request': 'String request(String endpoint)',
    },
  );
}

// =============================================================================
// AbstractFinalClass Bridge
// =============================================================================

BridgedClass _createAbstractFinalClassBridge() {
  return BridgedClass(
    nativeType: $pkg.AbstractFinalClass,
    name: 'AbstractFinalClass',
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.AbstractFinalClass>(target, 'AbstractFinalClass').value,
    },
    getterSignatures: {
      'value': 'int get value',
    },
  );
}

// =============================================================================
// SingletonHolder Bridge
// =============================================================================

BridgedClass _createSingletonHolderBridge() {
  return BridgedClass(
    nativeType: $pkg.SingletonHolder,
    name: 'SingletonHolder',
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.SingletonHolder>(target, 'SingletonHolder').value,
    },
    staticGetters: {
      'instance': (visitor) => $pkg.SingletonHolder.instance,
    },
    getterSignatures: {
      'value': 'int get value',
    },
    staticGetterSignatures: {
      'instance': 'dynamic get instance',
    },
  );
}

// =============================================================================
// SimplePoint Bridge
// =============================================================================

BridgedClass _createSimplePointBridge() {
  return BridgedClass(
    nativeType: $pkg.SimplePoint,
    name: 'SimplePoint',
    constructors: {
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$pkg.SimplePoint>(target, 'SimplePoint').x,
      'y': (visitor, target) => D4.validateTarget<$pkg.SimplePoint>(target, 'SimplePoint').y,
    },
    setters: {
      'x': (visitor, target, value) => 
        D4.validateTarget<$pkg.SimplePoint>(target, 'SimplePoint').x = value as int,
      'y': (visitor, target, value) => 
        D4.validateTarget<$pkg.SimplePoint>(target, 'SimplePoint').y = value as int,
    },
    getterSignatures: {
      'x': 'int get x',
      'y': 'int get y',
    },
    setterSignatures: {
      'x': 'set x(dynamic value)',
      'y': 'set y(dynamic value)',
    },
  );
}

// =============================================================================
// Point Bridge
// =============================================================================

BridgedClass _createPointBridge() {
  return BridgedClass(
    nativeType: $pkg.Point,
    name: 'Point',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Point');
        final x = D4.getRequiredArg<int>(positional, 0, 'x', 'Point');
        final y = D4.getRequiredArg<int>(positional, 1, 'y', 'Point');
        return $pkg.Point(x, y);
      },
      'origin': (visitor, positional, named) {
        return $pkg.Point.origin();
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Point');
        if (positional.isEmpty) {
          throw ArgumentError('Point: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Point.fromJson(json);
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$pkg.Point>(target, 'Point').x,
      'y': (visitor, target) => D4.validateTarget<$pkg.Point>(target, 'Point').y,
    },
    constructorSignatures: {
      '': 'Point(int x, int y)',
      'origin': 'Point.origin()',
      'fromJson': 'Point.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'x': 'int get x',
      'y': 'int get y',
    },
  );
}

// =============================================================================
// RectangleArea Bridge
// =============================================================================

BridgedClass _createRectangleAreaBridge() {
  return BridgedClass(
    nativeType: $pkg.RectangleArea,
    name: 'RectangleArea',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'RectangleArea');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'RectangleArea');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'RectangleArea');
        return $pkg.RectangleArea(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$pkg.RectangleArea>(target, 'RectangleArea').width,
      'height': (visitor, target) => D4.validateTarget<$pkg.RectangleArea>(target, 'RectangleArea').height,
      'area': (visitor, target) => D4.validateTarget<$pkg.RectangleArea>(target, 'RectangleArea').area,
    },
    constructorSignatures: {
      '': 'RectangleArea(int width, int height)',
    },
    getterSignatures: {
      'width': 'int get width',
      'height': 'int get height',
      'area': 'int get area',
    },
  );
}

// =============================================================================
// PositiveNumber Bridge
// =============================================================================

BridgedClass _createPositiveNumberBridge() {
  return BridgedClass(
    nativeType: $pkg.PositiveNumber,
    name: 'PositiveNumber',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PositiveNumber');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'PositiveNumber');
        return $pkg.PositiveNumber(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.PositiveNumber>(target, 'PositiveNumber').value,
    },
    constructorSignatures: {
      '': 'PositiveNumber(int value)',
    },
    getterSignatures: {
      'value': 'int get value',
    },
  );
}

// =============================================================================
// Vector Bridge
// =============================================================================

BridgedClass _createVectorBridge() {
  return BridgedClass(
    nativeType: $pkg.Vector,
    name: 'Vector',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector');
        return $pkg.Vector(x, y);
      },
      'zero': (visitor, positional, named) {
        return $pkg.Vector.zero();
      },
      'unit': (visitor, positional, named) {
        return $pkg.Vector.unit();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$pkg.Vector>(target, 'Vector').x,
      'y': (visitor, target) => D4.validateTarget<$pkg.Vector>(target, 'Vector').y,
    },
    constructorSignatures: {
      '': 'Vector(double x, double y)',
      'zero': 'Vector.zero()',
      'unit': 'Vector.unit()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
    },
  );
}

// =============================================================================
// Color Bridge
// =============================================================================

BridgedClass _createColorBridge() {
  return BridgedClass(
    nativeType: $pkg.Color,
    name: 'Color',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Color');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'Color');
        final g = D4.getRequiredArg<int>(positional, 1, 'g', 'Color');
        final b = D4.getRequiredArg<int>(positional, 2, 'b', 'Color');
        return $pkg.Color(r, g, b);
      },
    },
    getters: {
      'r': (visitor, target) => D4.validateTarget<$pkg.Color>(target, 'Color').r,
      'g': (visitor, target) => D4.validateTarget<$pkg.Color>(target, 'Color').g,
      'b': (visitor, target) => D4.validateTarget<$pkg.Color>(target, 'Color').b,
    },
    staticGetters: {
      'red': (visitor) => $pkg.Color.red,
      'green': (visitor) => $pkg.Color.green,
      'blue': (visitor) => $pkg.Color.blue,
    },
    constructorSignatures: {
      '': 'const Color(int r, int g, int b)',
    },
    getterSignatures: {
      'r': 'int get r',
      'g': 'int get g',
      'b': 'int get b',
    },
    staticGetterSignatures: {
      'red': 'Color get red',
      'green': 'Color get green',
      'blue': 'Color get blue',
    },
  );
}

// =============================================================================
// Logger Bridge
// =============================================================================

BridgedClass _createLoggerBridge() {
  return BridgedClass(
    nativeType: $pkg.Logger,
    name: 'Logger',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Logger');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Logger');
        return $pkg.Logger(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Logger>(target, 'Logger').name,
    },
    constructorSignatures: {
      '': 'factory Logger(String name)',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// CircleShape Bridge
// =============================================================================

BridgedClass _createCircleShapeBridge() {
  return BridgedClass(
    nativeType: $pkg.CircleShape,
    name: 'CircleShape',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CircleShape');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'CircleShape');
        return $pkg.CircleShape(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$pkg.CircleShape>(target, 'CircleShape').radius,
      'area': (visitor, target) => D4.validateTarget<$pkg.CircleShape>(target, 'CircleShape').area,
    },
    constructorSignatures: {
      '': 'CircleShape(double radius)',
    },
    getterSignatures: {
      'radius': 'double get radius',
      'area': 'double get area',
    },
  );
}

// =============================================================================
// SquareShape Bridge
// =============================================================================

BridgedClass _createSquareShapeBridge() {
  return BridgedClass(
    nativeType: $pkg.SquareShape,
    name: 'SquareShape',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SquareShape');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'SquareShape');
        return $pkg.SquareShape(side);
      },
    },
    getters: {
      'side': (visitor, target) => D4.validateTarget<$pkg.SquareShape>(target, 'SquareShape').side,
      'area': (visitor, target) => D4.validateTarget<$pkg.SquareShape>(target, 'SquareShape').area,
    },
    constructorSignatures: {
      '': 'SquareShape(double side)',
    },
    getterSignatures: {
      'side': 'double get side',
      'area': 'double get area',
    },
  );
}

// =============================================================================
// Database Bridge
// =============================================================================

BridgedClass _createDatabaseBridge() {
  return BridgedClass(
    nativeType: $pkg.Database,
    name: 'Database',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Database>(target, 'Database').name,
    },
    staticGetters: {
      'instance': (visitor) => $pkg.Database.instance,
    },
    getterSignatures: {
      'name': 'String get name',
    },
    staticGetterSignatures: {
      'instance': 'Database get instance',
    },
  );
}

// =============================================================================
// PersonBase Bridge
// =============================================================================

BridgedClass _createPersonBaseBridge() {
  return BridgedClass(
    nativeType: $pkg.PersonBase,
    name: 'PersonBase',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PersonBase');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PersonBase');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'PersonBase');
        return $pkg.PersonBase(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.PersonBase>(target, 'PersonBase').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.PersonBase>(target, 'PersonBase').age,
    },
    constructorSignatures: {
      '': 'PersonBase(String name, int age)',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
    },
  );
}

// =============================================================================
// Employee Bridge
// =============================================================================

BridgedClass _createEmployeeBridge() {
  return BridgedClass(
    nativeType: $pkg.Employee,
    name: 'Employee',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Employee');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Employee');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Employee');
        final department = D4.getRequiredArg<String>(positional, 2, 'department', 'Employee');
        return $pkg.Employee(name, age, department);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Employee>(target, 'Employee').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.Employee>(target, 'Employee').age,
      'department': (visitor, target) => D4.validateTarget<$pkg.Employee>(target, 'Employee').department,
    },
    constructorSignatures: {
      '': 'Employee(String name, int age, String department)',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
      'department': 'String get department',
    },
  );
}

// =============================================================================
// Manager Bridge
// =============================================================================

BridgedClass _createManagerBridge() {
  return BridgedClass(
    nativeType: $pkg.Manager,
    name: 'Manager',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Manager');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Manager');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Manager');
        final department = D4.getRequiredArg<String>(positional, 2, 'department', 'Manager');
        final teamSize = D4.getRequiredArg<int>(positional, 3, 'teamSize', 'Manager');
        return $pkg.Manager(name, age, department, teamSize);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Manager>(target, 'Manager').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.Manager>(target, 'Manager').age,
      'teamSize': (visitor, target) => D4.validateTarget<$pkg.Manager>(target, 'Manager').teamSize,
    },
    constructorSignatures: {
      '': 'Manager(String name, int age, String department, int teamSize)',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
      'teamSize': 'int get teamSize',
    },
  );
}

// =============================================================================
// Animal Bridge
// =============================================================================

BridgedClass _createAnimalBridge() {
  return BridgedClass(
    nativeType: $pkg.Animal,
    name: 'Animal',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Animal');
        return $pkg.Animal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Animal>(target, 'Animal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Animal>(target, 'Animal');
        t.eat();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Animal>(target, 'Animal');
        return t.speak();
      },
    },
    constructorSignatures: {
      '': 'Animal(String name)',
    },
    methodSignatures: {
      'eat': 'void eat()',
      'speak': 'String speak()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Cat Bridge
// =============================================================================

BridgedClass _createCatBridge() {
  return BridgedClass(
    nativeType: $pkg.Cat,
    name: 'Cat',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Cat');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Cat');
        return $pkg.Cat(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Cat>(target, 'Cat').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Cat>(target, 'Cat');
        t.eat();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Cat>(target, 'Cat');
        return t.speak();
      },
      'meow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Cat>(target, 'Cat');
        t.meow();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Cat(String name)',
    },
    methodSignatures: {
      'eat': 'void eat()',
      'speak': 'String speak()',
      'meow': 'void meow()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// NotificationService Bridge
// =============================================================================

BridgedClass _createNotificationServiceBridge() {
  return BridgedClass(
    nativeType: $pkg.NotificationService,
    name: 'NotificationService',
    constructors: {
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NotificationService>(target, 'NotificationService');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'send');
        t.send(message);
        return null;
      },
    },
    methodSignatures: {
      'send': 'void send(String message)',
    },
  );
}

// =============================================================================
// EmailNotificationService Bridge
// =============================================================================

BridgedClass _createEmailNotificationServiceBridge() {
  return BridgedClass(
    nativeType: $pkg.EmailNotificationService,
    name: 'EmailNotificationService',
    constructors: {
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EmailNotificationService>(target, 'EmailNotificationService');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'send');
        t.send(message);
        return null;
      },
    },
    methodSignatures: {
      'send': 'void send(String message)',
    },
  );
}

// =============================================================================
// SmsNotificationService Bridge
// =============================================================================

BridgedClass _createSmsNotificationServiceBridge() {
  return BridgedClass(
    nativeType: $pkg.SmsNotificationService,
    name: 'SmsNotificationService',
    constructors: {
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SmsNotificationService>(target, 'SmsNotificationService');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'send');
        t.send(message);
        return null;
      },
    },
    methodSignatures: {
      'send': 'void send(String message)',
    },
  );
}

// =============================================================================
// Switchable Bridge
// =============================================================================

BridgedClass _createSwitchableBridge() {
  return BridgedClass(
    nativeType: $pkg.Switchable,
    name: 'Switchable',
    constructors: {
    },
    methods: {
      'turnOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Switchable>(target, 'Switchable');
        t.turnOn();
        return null;
      },
      'turnOff': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Switchable>(target, 'Switchable');
        t.turnOff();
        return null;
      },
    },
    methodSignatures: {
      'turnOn': 'void turnOn()',
      'turnOff': 'void turnOff()',
    },
  );
}

// =============================================================================
// TemperatureControl Bridge
// =============================================================================

BridgedClass _createTemperatureControlBridge() {
  return BridgedClass(
    nativeType: $pkg.TemperatureControl,
    name: 'TemperatureControl',
    constructors: {
    },
    methods: {
      'setTemperature': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TemperatureControl>(target, 'TemperatureControl');
        D4.requireMinArgs(positional, 1, 'setTemperature');
        final temp = D4.getRequiredArg<int>(positional, 0, 'temp', 'setTemperature');
        t.setTemperature(temp);
        return null;
      },
    },
    methodSignatures: {
      'setTemperature': 'void setTemperature(int temp)',
    },
  );
}

// =============================================================================
// Connectable Bridge
// =============================================================================

BridgedClass _createConnectableBridge() {
  return BridgedClass(
    nativeType: $pkg.Connectable,
    name: 'Connectable',
    constructors: {
    },
    methods: {
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Connectable>(target, 'Connectable');
        t.connect();
        return null;
      },
    },
    methodSignatures: {
      'connect': 'void connect()',
    },
  );
}

// =============================================================================
// SmartThermostat Bridge
// =============================================================================

BridgedClass _createSmartThermostatBridge() {
  return BridgedClass(
    nativeType: $pkg.SmartThermostat,
    name: 'SmartThermostat',
    constructors: {
    },
    methods: {
      'turnOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SmartThermostat>(target, 'SmartThermostat');
        t.turnOn();
        return null;
      },
      'turnOff': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SmartThermostat>(target, 'SmartThermostat');
        t.turnOff();
        return null;
      },
      'setTemperature': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SmartThermostat>(target, 'SmartThermostat');
        D4.requireMinArgs(positional, 1, 'setTemperature');
        final temp = D4.getRequiredArg<int>(positional, 0, 'temp', 'setTemperature');
        t.setTemperature(temp);
        return null;
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SmartThermostat>(target, 'SmartThermostat');
        t.connect();
        return null;
      },
    },
    methodSignatures: {
      'turnOn': 'void turnOn()',
      'turnOff': 'void turnOff()',
      'setTemperature': 'void setTemperature(int temp)',
      'connect': 'void connect()',
    },
  );
}

// =============================================================================
// Machine Bridge
// =============================================================================

BridgedClass _createMachineBridge() {
  return BridgedClass(
    nativeType: $pkg.Machine,
    name: 'Machine',
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Machine>(target, 'Machine');
        t.move();
        return null;
      },
    },
    methodSignatures: {
      'move': 'void move()',
    },
  );
}

// =============================================================================
// Speakable Bridge
// =============================================================================

BridgedClass _createSpeakableBridge() {
  return BridgedClass(
    nativeType: $pkg.Speakable,
    name: 'Speakable',
    constructors: {
    },
    methods: {
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Speakable>(target, 'Speakable');
        t.speak();
        return null;
      },
    },
    methodSignatures: {
      'speak': 'void speak()',
    },
  );
}

// =============================================================================
// Robot Bridge
// =============================================================================

BridgedClass _createRobotBridge() {
  return BridgedClass(
    nativeType: $pkg.Robot,
    name: 'Robot',
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Robot>(target, 'Robot');
        t.move();
        return null;
      },
    },
    methodSignatures: {
      'move': 'void move()',
    },
  );
}

// =============================================================================
// AdvancedRobot Bridge
// =============================================================================

BridgedClass _createAdvancedRobotBridge() {
  return BridgedClass(
    nativeType: $pkg.AdvancedRobot,
    name: 'AdvancedRobot',
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AdvancedRobot>(target, 'AdvancedRobot');
        t.move();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AdvancedRobot>(target, 'AdvancedRobot');
        t.speak();
        return null;
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AdvancedRobot>(target, 'AdvancedRobot');
        t.connect();
        return null;
      },
    },
    methodSignatures: {
      'move': 'void move()',
      'speak': 'void speak()',
      'connect': 'void connect()',
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
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'square');
        return $pkg.MathUtils.square(n);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'cube');
        return $pkg.MathUtils.cube(n);
      },
      'isEven': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEven');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'isEven');
        return $pkg.MathUtils.isEven(n);
      },
    },
    staticMethodSignatures: {
      'square': 'int square(int n)',
      'cube': 'int cube(int n)',
      'isEven': 'bool isEven(int n)',
    },
    staticGetterSignatures: {
      'pi': 'double get pi',
      'e': 'double get e',
    },
  );
}

// =============================================================================
// Counter Bridge
// =============================================================================

BridgedClass _createCounterBridge() {
  return BridgedClass(
    nativeType: $pkg.Counter,
    name: 'Counter',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Counter();
      },
    },
    staticGetters: {
      'instanceCount': (visitor) => $pkg.Counter.instanceCount,
    },
    constructorSignatures: {
      '': 'Counter()',
    },
    staticGetterSignatures: {
      'instanceCount': 'int get instanceCount',
    },
    staticSetterSignatures: {
      'instanceCount': 'set instanceCount(dynamic value)',
    },
  );
}

// =============================================================================
// FlexibleObject Bridge
// =============================================================================

BridgedClass _createFlexibleObjectBridge() {
  return BridgedClass(
    nativeType: $pkg.FlexibleObject,
    name: 'FlexibleObject',
    constructors: {
    },
    methods: {
      'noSuchMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FlexibleObject>(target, 'FlexibleObject');
        D4.requireMinArgs(positional, 1, 'noSuchMethod');
        final invocation = D4.getRequiredArg<dynamic>(positional, 0, 'invocation', 'noSuchMethod');
        return t.noSuchMethod(invocation);
      },
    },
    methodSignatures: {
      'noSuchMethod': 'dynamic noSuchMethod(Invocation invocation)',
    },
  );
}

// =============================================================================
// SortablePerson Bridge
// =============================================================================

BridgedClass _createSortablePersonBridge() {
  return BridgedClass(
    nativeType: $pkg.SortablePerson,
    name: 'SortablePerson',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SortablePerson');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'SortablePerson');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'SortablePerson');
        return $pkg.SortablePerson(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.SortablePerson>(target, 'SortablePerson').name,
      'age': (visitor, target) => D4.validateTarget<$pkg.SortablePerson>(target, 'SortablePerson').age,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SortablePerson>(target, 'SortablePerson');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$pkg.SortablePerson>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SortablePerson>(target, 'SortablePerson');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SortablePerson(String name, int age)',
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SortablePerson other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
    },
  );
}

// =============================================================================
// Musician Bridge
// =============================================================================

BridgedClass _createMusicianBridge() {
  return BridgedClass(
    nativeType: $pkg.Musician,
    name: 'Musician',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Musician');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Musician');
        return $pkg.Musician(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Musician>(target, 'Musician').name,
    },
    methods: {
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Musician>(target, 'Musician');
        t.playInstrument();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Musician(String name)',
    },
    methodSignatures: {
      'playInstrument': 'void playInstrument()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// ProfessionalDancer Bridge
// =============================================================================

BridgedClass _createProfessionalDancerBridge() {
  return BridgedClass(
    nativeType: $pkg.ProfessionalDancer,
    name: 'ProfessionalDancer',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProfessionalDancer');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ProfessionalDancer');
        return $pkg.ProfessionalDancer(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.ProfessionalDancer>(target, 'ProfessionalDancer').name,
    },
    methods: {
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProfessionalDancer>(target, 'ProfessionalDancer');
        t.dance();
        return null;
      },
    },
    constructorSignatures: {
      '': 'ProfessionalDancer(String name)',
    },
    methodSignatures: {
      'dance': 'void dance()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Entertainer Bridge
// =============================================================================

BridgedClass _createEntertainerBridge() {
  return BridgedClass(
    nativeType: $pkg.Entertainer,
    name: 'Entertainer',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Entertainer');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Entertainer');
        return $pkg.Entertainer(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Entertainer>(target, 'Entertainer').name,
    },
    methods: {
      'perform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Entertainer>(target, 'Entertainer');
        t.perform();
        return null;
      },
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Entertainer>(target, 'Entertainer');
        t.playInstrument();
        return null;
      },
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Entertainer>(target, 'Entertainer');
        t.dance();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Entertainer(String name)',
    },
    methodSignatures: {
      'perform': 'void perform()',
      'playInstrument': 'void playInstrument()',
      'dance': 'void dance()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// CountableItem Bridge
// =============================================================================

BridgedClass _createCountableItemBridge() {
  return BridgedClass(
    nativeType: $pkg.CountableItem,
    name: 'CountableItem',
    constructors: {
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<$pkg.CountableItem>(target, 'CountableItem').count,
    },
    methods: {
      'increment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CountableItem>(target, 'CountableItem');
        t.increment();
        return null;
      },
      'decrement': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CountableItem>(target, 'CountableItem');
        t.decrement();
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CountableItem>(target, 'CountableItem');
        t.reset();
        return null;
      },
    },
    methodSignatures: {
      'increment': 'void increment()',
      'decrement': 'void decrement()',
      'reset': 'void reset()',
    },
    getterSignatures: {
      'count': 'int get count',
    },
  );
}

// =============================================================================
// ConsoleLogger Bridge
// =============================================================================

BridgedClass _createConsoleLoggerBridge() {
  return BridgedClass(
    nativeType: $pkg.ConsoleLogger,
    name: 'ConsoleLogger',
    constructors: {
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 2, 'log');
        final level = D4.getRequiredArg<String>(positional, 0, 'level', 'log');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'log');
        t.log(level, message);
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'info');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'info');
        t.info(message);
        return null;
      },
      'warning': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'warning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'warning');
        t.warning(message);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        t.error(message);
        return null;
      },
    },
    methodSignatures: {
      'log': 'void log(String level, String message)',
      'info': 'void info(String message)',
      'warning': 'void warning(String message)',
      'error': 'void error(String message)',
    },
  );
}

// =============================================================================
// MultiMixed Bridge
// =============================================================================

BridgedClass _createMultiMixedBridge() {
  return BridgedClass(
    nativeType: $pkg.MultiMixed,
    name: 'MultiMixed',
    constructors: {
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MultiMixed>(target, 'MultiMixed');
        t.greet();
        return null;
      },
    },
    methodSignatures: {
      'greet': 'void greet()',
    },
  );
}

// =============================================================================
// Helper Bridge
// =============================================================================

BridgedClass _createHelperBridge() {
  return BridgedClass(
    nativeType: $pkg.Helper,
    name: 'Helper',
    constructors: {
    },
    methods: {
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Helper>(target, 'Helper');
        t.help();
        return null;
      },
    },
    methodSignatures: {
      'help': 'void help()',
    },
  );
}

// =============================================================================
// HelpfulService Bridge
// =============================================================================

BridgedClass _createHelpfulServiceBridge() {
  return BridgedClass(
    nativeType: $pkg.HelpfulService,
    name: 'HelpfulService',
    constructors: {
    },
    methods: {
      'serve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.HelpfulService>(target, 'HelpfulService');
        t.serve();
        return null;
      },
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.HelpfulService>(target, 'HelpfulService');
        t.help();
        return null;
      },
    },
    methodSignatures: {
      'serve': 'void serve()',
      'help': 'void help()',
    },
  );
}

// =============================================================================
// Button Bridge
// =============================================================================

BridgedClass _createButtonBridge() {
  return BridgedClass(
    nativeType: $pkg.Button,
    name: 'Button',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Button');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'Button');
        return $pkg.Button(label);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$pkg.Button>(target, 'Button').label,
    },
    methods: {
      'click': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Button>(target, 'Button');
        t.click();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((String p0) { (listenerRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((String p0) { (listenerRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'emit');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'emit');
        t.emit(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'Button(String label)',
    },
    methodSignatures: {
      'click': 'void click()',
      'addListener': 'void addListener(void Function(String) listener)',
      'removeListener': 'void removeListener(void Function(String) listener)',
      'emit': 'void emit(String event)',
    },
    getterSignatures: {
      'label': 'String get label',
    },
  );
}

// =============================================================================
// SortableItem Bridge
// =============================================================================

BridgedClass _createSortableItemBridge() {
  return BridgedClass(
    nativeType: $pkg.SortableItem,
    name: 'SortableItem',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SortableItem');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'SortableItem');
        return $pkg.SortableItem(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.SortableItem>(target, 'SortableItem').value,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SortableItem>(target, 'SortableItem');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$pkg.SortableItem>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
    },
    constructorSignatures: {
      '': 'SortableItem(int value)',
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SortableItem other)',
    },
    getterSignatures: {
      'value': 'int get value',
    },
  );
}

