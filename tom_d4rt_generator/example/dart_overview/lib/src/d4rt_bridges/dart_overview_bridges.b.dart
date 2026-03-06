// D4rt Bridge - Generated file, do not edit
// Sources: 16 files
// Generated: 2026-03-06T18:40:38.280554

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart' as $dart_overview_1;
import 'package:dart_overview/classes/constructors/run_constructors.dart' as $dart_overview_2;
import 'package:dart_overview/classes/declarations/run_declarations.dart' as $dart_overview_3;
import 'package:dart_overview/classes/inheritance/run_inheritance.dart' as $dart_overview_4;
import 'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart' as $dart_overview_5;
import 'package:dart_overview/classes/test_support/run_test_support.dart' as $dart_overview_6;
import 'package:dart_overview/enums/basics/run_basics.dart' as $dart_overview_7;
import 'package:dart_overview/functions/declarations/run_declarations.dart' as $dart_overview_8;
import 'package:dart_overview/functions/generators/run_generators.dart' as $dart_overview_9;
import 'package:dart_overview/functions/parameters/run_parameters.dart' as $dart_overview_10;
import 'package:dart_overview/generics/generic_classes/run_generic_classes.dart' as $dart_overview_11;
import 'package:dart_overview/generics/type_bounds/run_type_bounds.dart' as $dart_overview_12;
import 'package:dart_overview/globals/basics/run_basics.dart' as $dart_overview_13;
import 'package:dart_overview/mixins/basics/run_basics.dart' as $dart_overview_14;
import 'package:dart_overview/records/basics/run_basics.dart' as $dart_overview_15;
import 'package:dart_overview/run_dart_overview.dart' as $dart_overview_16;

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
      _createLoggableMixinBridge(),
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
      _createShapeBridge(),
      _createCircleShapeBridge(),
      _createSquareShapeBridge(),
      _createDatabaseBridge(),
      _createPersonBaseBridge(),
      _createEmployeeBridge(),
      _createManagerBridge(),
      _createAnimalBridge(),
      _createCatBridge(),
      _createElectricCarBridge(),
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
      _createNumberWrapperBridge(),
      _createBitFlagsBridge(),
      _createNullableFieldsBridge(),
      _createLateFieldDemoBridge(),
      _createMultiplierBridge(),
      _createPrintableBridge(),
      _createSerializableBridge(),
      _createSerializablePrintableBridge(),
      _createTrackableBridge(),
      _createTrackedItemBridge(),
      _createDataProcessorBridge(),
      _createStatisticsBridge(),
      _createSortedListBridge(),
      _createPriorityQueueBridge(),
      _createRangeBridge(),
      _createBinarySearchTreeBridge(),
      _createCacheBridge(),
      _createTreeNodeBridge(),
      _createMusicalBridge(),
      _createDancingBridge(),
      _createMusicianBridge(),
      _createProfessionalDancerBridge(),
      _createEntertainerBridge(),
      _createCountableItemBridge(),
      _createFlyingBridge(),
      _createWalkingBridge(),
      _createBirdBridge(),
      _createEagleBridge(),
      _createPenguinBridge(),
      _createLoggingBridge(),
      _createConsoleLoggerBridge(),
      _createGreeter1Bridge(),
      _createGreeter2Bridge(),
      _createMultiMixedBridge(),
      _createHelperBridge(),
      _createHelpfulServiceBridge(),
      _createEventEmitterBridge(),
      _createButtonBridge(),
      _createComparableMixinBridge(),
      _createSortableItemBridge(),
      _createJsonSerializableBridge(),
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
      'LoggableMixin': 'package:dart_overview/enums/basics/run_basics.dart',
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
      'Shape': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'CircleShape': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'SquareShape': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Database': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'PersonBase': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Employee': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Manager': 'package:dart_overview/classes/constructors/run_constructors.dart',
      'Animal': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'Cat': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'ElectricCar': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
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
      'NumberWrapper': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'BitFlags': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'NullableFields': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'LateFieldDemo': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'Multiplier': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'Printable': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'Serializable': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'SerializablePrintable': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'Trackable': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'TrackedItem': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'DataProcessor': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'Statistics': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'SortedList': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'PriorityQueue': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'Range': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'BinarySearchTree': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'Cache': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'TreeNode': 'package:dart_overview/functions/generators/run_generators.dart',
      'Musical': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Dancing': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Musician': 'package:dart_overview/mixins/basics/run_basics.dart',
      'ProfessionalDancer': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Entertainer': 'package:dart_overview/mixins/basics/run_basics.dart',
      'CountableItem': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Flying': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Walking': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Bird': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Eagle': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Penguin': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Logging': 'package:dart_overview/mixins/basics/run_basics.dart',
      'ConsoleLogger': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Greeter1': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Greeter2': 'package:dart_overview/mixins/basics/run_basics.dart',
      'MultiMixed': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Helper': 'package:dart_overview/mixins/basics/run_basics.dart',
      'HelpfulService': 'package:dart_overview/mixins/basics/run_basics.dart',
      'EventEmitter': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Button': 'package:dart_overview/mixins/basics/run_basics.dart',
      'ComparableMixin': 'package:dart_overview/mixins/basics/run_basics.dart',
      'SortableItem': 'package:dart_overview/mixins/basics/run_basics.dart',
      'JsonSerializable': 'package:dart_overview/mixins/basics/run_basics.dart',
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
      'JsonMap': 'Map',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$dart_overview_7.Day>(
        name: 'Day',
        values: $dart_overview_7.Day.values,
      ),
      BridgedEnumDefinition<$dart_overview_7.Season>(
        name: 'Season',
        values: $dart_overview_7.Season.values,
        getters: {
          'months': (visitor, target) => (target as $dart_overview_7.Season).months,
          'avgTemperature': (visitor, target) => (target as $dart_overview_7.Season).avgTemperature,
        },
      ),
      BridgedEnumDefinition<$dart_overview_7.HttpStatus>(
        name: 'HttpStatus',
        values: $dart_overview_7.HttpStatus.values,
        getters: {
          'code': (visitor, target) => (target as $dart_overview_7.HttpStatus).code,
          'message': (visitor, target) => (target as $dart_overview_7.HttpStatus).message,
          'isSuccess': (visitor, target) => (target as $dart_overview_7.HttpStatus).isSuccess,
          'isError': (visitor, target) => (target as $dart_overview_7.HttpStatus).isError,
        },
      ),
      BridgedEnumDefinition<$dart_overview_7.Operation>(
        name: 'Operation',
        values: $dart_overview_7.Operation.values,
        getters: {
          'symbol': (visitor, target) => (target as $dart_overview_7.Operation).symbol,
        },
        methods: {
          'execute': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_overview_7.Operation;
            return Function.apply(t.execute, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$dart_overview_7.LogLevel>(
        name: 'LogLevel',
        values: $dart_overview_7.LogLevel.values,
        getters: {
          'severity': (visitor, target) => (target as $dart_overview_7.LogLevel).severity,
        },
        methods: {
          'shouldLog': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_overview_7.LogLevel;
            return Function.apply(t.shouldLog, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$dart_overview_7.Priority>(
        name: 'Priority',
        values: $dart_overview_7.Priority.values,
      ),
      BridgedEnumDefinition<$dart_overview_7.Role>(
        name: 'Role',
        values: $dart_overview_7.Role.values,
      ),
      BridgedEnumDefinition<$dart_overview_13.LogSeverity>(
        name: 'LogSeverity',
        values: $dart_overview_13.LogSeverity.values,
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
      'LogSeverity': 'package:dart_overview/globals/basics/run_basics.dart',
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

    // Register class aliases (typedef type aliases)
    final aliases = classAliases();
    for (final entry in aliases.entries) {
      interpreter.registerClassAlias(entry.key, entry.value, importPath);
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
      interpreter.registerGlobalVariable('globalCounter', $dart_overview_13.globalCounter, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "globalCounter": $e');
    }
    try {
      interpreter.registerGlobalVariable('appName', $dart_overview_13.appName, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxRetries', $dart_overview_13.maxRetries, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxRetries": $e');
    }
    try {
      interpreter.registerGlobalVariable('currentUser', $dart_overview_13.currentUser, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "currentUser": $e');
    }
    try {
      interpreter.registerGlobalVariable('lastProcessedId', $dart_overview_13.lastProcessedId, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "lastProcessedId": $e');
    }
    try {
      interpreter.registerGlobalVariable('appStartTime', $dart_overview_13.appStartTime, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "appStartTime": $e');
    }
    try {
      interpreter.registerGlobalVariable('sessionId', $dart_overview_13.sessionId, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "sessionId": $e');
    }
    try {
      interpreter.registerGlobalVariable('pi', $dart_overview_13.pi, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "pi": $e');
    }
    try {
      interpreter.registerGlobalVariable('apiUrl', $dart_overview_13.apiUrl, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "apiUrl": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxConnections', $dart_overview_13.maxConnections, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxConnections": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTimeout', $dart_overview_13.defaultTimeout, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('validStatuses', $dart_overview_13.validStatuses, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "validStatuses": $e');
    }
    try {
      interpreter.registerGlobalVariable('priorities', $dart_overview_13.priorities, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "priorities": $e');
    }
    try {
      interpreter.registerGlobalVariable('reservedIds', $dart_overview_13.reservedIds, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "reservedIds": $e');
    }
    try {
      interpreter.registerGlobalVariable('lazyConfig', $dart_overview_13.lazyConfig, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "lazyConfig": $e');
    }
    interpreter.registerGlobalGetter('now', () => $dart_overview_13.now, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    interpreter.registerGlobalGetter('connectionCount', () => $dart_overview_13.connectionCount, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    interpreter.registerGlobalGetter('cachedValue', () => $dart_overview_13.cachedValue, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    interpreter.registerGlobalGetter('logLevel', () => $dart_overview_13.logLevel, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
    interpreter.registerGlobalSetter('logLevel', (v) => $dart_overview_13.logLevel = v as $dart_overview_13.LogSeverity, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (all):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'main': (visitor, positional, named, typeArgs) {
        return $dart_overview_16.main();
      },
      'printShape': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'printShape');
        final shape = D4.getRequiredArg<$dart_overview_1.SealedShape>(positional, 0, 'shape', 'printShape');
        return $dart_overview_1.printShape(shape);
      },
      'sendNotification': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'sendNotification');
        final service = D4.getRequiredArg<$dart_overview_4.NotificationService>(positional, 0, 'service', 'sendNotification');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'sendNotification');
        return $dart_overview_4.sendNotification(service, message);
      },
      'add': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return $dart_overview_8.add(a, b);
      },
      'multiply': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
        return $dart_overview_8.multiply(a, b);
      },
      'greet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'greet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
        return $dart_overview_8.greet(name);
      },
      'printSeparator': (visitor, positional, named, typeArgs) {
        return $dart_overview_8.printSeparator();
      },
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'square');
        return $dart_overview_8.square(n);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'cube');
        return $dart_overview_8.cube(n);
      },
      'isEven': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEven');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'isEven');
        return $dart_overview_8.isEven(n);
      },
      'getNumbers': (visitor, positional, named, typeArgs) {
        return $dart_overview_8.getNumbers();
      },
      'createUser': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'createUser');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createUser');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'createUser');
        return $dart_overview_8.createUser(name, age);
      },
      'inferredReturn': (visitor, positional, named, typeArgs) {
        return $dart_overview_8.inferredReturn();
      },
      'dynamicReturn': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dynamicReturn');
        final choice = D4.getRequiredArg<int>(positional, 0, 'choice', 'dynamicReturn');
        return $dart_overview_8.dynamicReturn(choice);
      },
      'alwaysThrows': (visitor, positional, named, typeArgs) {
        return $dart_overview_8.alwaysThrows();
      },
      'fullName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'fullName');
        final first = D4.getRequiredArg<String>(positional, 0, 'first', 'fullName');
        final last = D4.getRequiredArg<String>(positional, 1, 'last', 'fullName');
        return $dart_overview_10.fullName(first, last);
      },
      'describe': (visitor, positional, named, typeArgs) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'describe');
        final age = D4.getOptionalNamedArg<int?>(named, 'age');
        final city = D4.getOptionalNamedArg<String?>(named, 'city');
        return $dart_overview_10.describe(name: name, age: age, city: city);
      },
      'sayHello': (visitor, positional, named, typeArgs) {
        final name = D4.getOptionalArgWithDefault<String>(positional, 0, 'name', 'World');
        final greeting = D4.getOptionalArgWithDefault<String>(positional, 1, 'greeting', 'Hello');
        return $dart_overview_10.sayHello(name, greeting);
      },
      'power': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'power');
        final base = D4.getRequiredArg<int>(positional, 0, 'base', 'power');
        final exponent = D4.getOptionalArgWithDefault<int>(positional, 1, 'exponent', 2);
        return $dart_overview_10.power(base, exponent);
      },
      'makeRequest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'makeRequest');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'makeRequest');
        final method = D4.getNamedArgWithDefault<String>(named, 'method', 'GET');
        final timeout = D4.getNamedArgWithDefault<int>(named, 'timeout', 30);
        final headers = D4.getOptionalNamedArg<Map<String, String>?>(named, 'headers');
        return $dart_overview_10.makeRequest(url, method: method, timeout: timeout, headers: headers);
      },
      'processOrder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processOrder');
        final orderId = D4.getRequiredArg<String>(positional, 0, 'orderId', 'processOrder');
        final product = D4.getRequiredArg<String>(positional, 1, 'product', 'processOrder');
        final quantity = D4.getRequiredNamedArg<int>(named, 'quantity', 'processOrder');
        final priority = D4.getNamedArgWithDefault<String>(named, 'priority', 'normal');
        return $dart_overview_10.processOrder(orderId, product, quantity: quantity, priority: priority);
      },
      'transform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transform');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'transform');
        if (positional.length <= 1) {
          throw ArgumentError('transform: Missing required argument "transformer" at position 1');
        }
        final transformerRaw = positional[1];
        final transformer = (int p0) { return D4.callInterpreterCallback(visitor!, transformerRaw, [p0]) as int; };
        return $dart_overview_10.transform(numbers, transformer);
      },
      'fetchData': (visitor, positional, named, typeArgs) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'fetchData');
        final onSuccessRaw = named['onSuccess'];
        if (onSuccessRaw == null) {
          throw ArgumentError('fetchData: Missing required named argument "onSuccess"');
        }
        final onSuccess = (String p0) { D4.callInterpreterCallback(visitor!, onSuccessRaw, [p0]); };
        final onErrorRaw = named['onError'];
        if (onErrorRaw == null) {
          throw ArgumentError('fetchData: Missing required named argument "onError"');
        }
        final onError = (String p0) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0]); };
        return $dart_overview_10.fetchData(url: url, onSuccess: onSuccess, onError: onError);
      },
      'log': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        return $dart_overview_13.log(message);
      },
      'firstOrNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'firstOrNull');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'firstOrNull');
        return $dart_overview_13.firstOrNull<dynamic>(items);
      },
      'fetchGreeting': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fetchGreeting');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'fetchGreeting');
        return $dart_overview_6.fetchGreeting(name);
      },
      'computeSum': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'computeSum');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'computeSum');
        return $dart_overview_6.computeSum(numbers);
      },
      'findMin': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findMin');
        final sample = positional[0] as List;
        if (sample.isEmpty) return <dynamic>[];
        final firstElem = sample.first;
        if (firstElem is num) {
          return $dart_overview_12.findMin<num>((positional[0] as List).cast<num>());
        }
        if (firstElem is String) {
          return $dart_overview_12.findMin<String>((positional[0] as List).cast<String>());
        }
        if (firstElem is DateTime) {
          return $dart_overview_12.findMin<DateTime>((positional[0] as List).cast<DateTime>());
        }
        if (firstElem is Duration) {
          return $dart_overview_12.findMin<Duration>((positional[0] as List).cast<Duration>());
        }
        if (firstElem is BigInt) {
          return $dart_overview_12.findMin<BigInt>((positional[0] as List).cast<BigInt>());
        }
        throw ArgumentError('findMin: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'findMax': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findMax');
        final sample = positional[0] as List;
        if (sample.isEmpty) return <dynamic>[];
        final firstElem = sample.first;
        if (firstElem is num) {
          return $dart_overview_12.findMax<num>((positional[0] as List).cast<num>());
        }
        if (firstElem is String) {
          return $dart_overview_12.findMax<String>((positional[0] as List).cast<String>());
        }
        if (firstElem is DateTime) {
          return $dart_overview_12.findMax<DateTime>((positional[0] as List).cast<DateTime>());
        }
        if (firstElem is Duration) {
          return $dart_overview_12.findMax<Duration>((positional[0] as List).cast<Duration>());
        }
        if (firstElem is BigInt) {
          return $dart_overview_12.findMax<BigInt>((positional[0] as List).cast<BigInt>());
        }
        throw ArgumentError('findMax: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'clamp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'clamp');
        final sample = positional[0];
        if (sample is num) {
          return $dart_overview_12.clamp<num>(positional[0] as num, positional[1] as num, positional[2] as num);
        }
        if (sample is String) {
          return $dart_overview_12.clamp<String>(positional[0] as String, positional[1] as String, positional[2] as String);
        }
        if (sample is DateTime) {
          return $dart_overview_12.clamp<DateTime>(positional[0] as DateTime, positional[1] as DateTime, positional[2] as DateTime);
        }
        if (sample is Duration) {
          return $dart_overview_12.clamp<Duration>(positional[0] as Duration, positional[1] as Duration, positional[2] as Duration);
        }
        if (sample is BigInt) {
          return $dart_overview_12.clamp<BigInt>(positional[0] as BigInt, positional[1] as BigInt, positional[2] as BigInt);
        }
        throw ArgumentError('clamp: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'findMinMax': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findMinMax');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'findMinMax');
        final $result = $dart_overview_15.findMinMax(numbers);
        return InterpretedRecord([], {'min': $result.min, 'max': $result.max});
      },
      'swap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'swap');
        final pair$raw = positional[0];
        final pair = pair$raw is InterpretedRecord
            ? (pair$raw.positionalFields[0] as int, pair$raw.positionalFields[1] as int)
            : pair$raw as (int, int);
        final $result = $dart_overview_15.swap(pair);
        return InterpretedRecord([$result.$1, $result.$2], {});
      },
      'parseUserString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parseUserString');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'parseUserString');
        final $result = $dart_overview_15.parseUserString(input);
        return InterpretedRecord([$result.$1, $result.$2], {});
      },
      'divideWithRemainder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'divideWithRemainder');
        final dividend = D4.getRequiredArg<int>(positional, 0, 'dividend', 'divideWithRemainder');
        final divisor = D4.getRequiredArg<int>(positional, 1, 'divisor', 'divideWithRemainder');
        final $result = $dart_overview_15.divideWithRemainder(dividend, divisor);
        return InterpretedRecord([], {'quotient': $result.quotient, 'remainder': $result.remainder});
      },
      'calculateStats': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'calculateStats');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'calculateStats');
        final $result = $dart_overview_15.calculateStats(numbers);
        return InterpretedRecord([], {'sum': $result.sum, 'average': $result.average, 'count': $result.count});
      },
      'countTo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'countTo');
        final max = D4.getRequiredArg<int>(positional, 0, 'max', 'countTo');
        return $dart_overview_9.countTo(max);
      },
      'range': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'range');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'range');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'range');
        final step = D4.getOptionalArgWithDefault<int>(positional, 2, 'step', 1);
        return $dart_overview_9.range(start, end, step);
      },
      'naturalNumbers': (visitor, positional, named, typeArgs) {
        return $dart_overview_9.naturalNumbers();
      },
      'fibonacci': (visitor, positional, named, typeArgs) {
        return $dart_overview_9.fibonacci();
      },
      'nestedRanges': (visitor, positional, named, typeArgs) {
        return $dart_overview_9.nestedRanges();
      },
      'flatten': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'flatten');
        final nested = D4.getRequiredArg<Iterable<Iterable<dynamic>>>(positional, 0, 'nested', 'flatten');
        return $dart_overview_9.flatten<dynamic>(nested);
      },
      'traverseTree': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'traverseTree');
        final node = D4.getRequiredArg<$dart_overview_9.TreeNode<dynamic>>(positional, 0, 'node', 'traverseTree');
        return $dart_overview_9.traverseTree<dynamic>(node);
      },
      'countAsyncTo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'countAsyncTo');
        final max = D4.getRequiredArg<int>(positional, 0, 'max', 'countAsyncTo');
        return $dart_overview_9.countAsyncTo(max);
      },
      'timedEvents': (visitor, positional, named, typeArgs) {
        return $dart_overview_9.timedEvents();
      },
      'combinedAsyncStreams': (visitor, positional, named, typeArgs) {
        return $dart_overview_9.combinedAsyncStreams();
      },
      'fetchAllPages': (visitor, positional, named, typeArgs) {
        return $dart_overview_9.fetchAllPages();
      },
      'primesUpTo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'primesUpTo');
        final max = D4.getRequiredArg<int>(positional, 0, 'max', 'primesUpTo');
        return $dart_overview_9.primesUpTo(max);
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
      'printShape': 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart',
      'sendNotification': 'package:dart_overview/classes/inheritance/run_inheritance.dart',
      'add': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'multiply': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'greet': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'printSeparator': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'square': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'cube': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'isEven': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'getNumbers': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'createUser': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'inferredReturn': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'dynamicReturn': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'alwaysThrows': 'package:dart_overview/functions/declarations/run_declarations.dart',
      'fullName': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'describe': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'sayHello': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'power': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'makeRequest': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'processOrder': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'transform': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'fetchData': 'package:dart_overview/functions/parameters/run_parameters.dart',
      'log': 'package:dart_overview/globals/basics/run_basics.dart',
      'firstOrNull': 'package:dart_overview/globals/basics/run_basics.dart',
      'fetchGreeting': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'computeSum': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'findMin': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'findMax': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'clamp': 'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'findMinMax': 'package:dart_overview/records/basics/run_basics.dart',
      'swap': 'package:dart_overview/records/basics/run_basics.dart',
      'parseUserString': 'package:dart_overview/records/basics/run_basics.dart',
      'divideWithRemainder': 'package:dart_overview/records/basics/run_basics.dart',
      'calculateStats': 'package:dart_overview/records/basics/run_basics.dart',
      'countTo': 'package:dart_overview/functions/generators/run_generators.dart',
      'range': 'package:dart_overview/functions/generators/run_generators.dart',
      'naturalNumbers': 'package:dart_overview/functions/generators/run_generators.dart',
      'fibonacci': 'package:dart_overview/functions/generators/run_generators.dart',
      'nestedRanges': 'package:dart_overview/functions/generators/run_generators.dart',
      'flatten': 'package:dart_overview/functions/generators/run_generators.dart',
      'traverseTree': 'package:dart_overview/functions/generators/run_generators.dart',
      'countAsyncTo': 'package:dart_overview/functions/generators/run_generators.dart',
      'timedEvents': 'package:dart_overview/functions/generators/run_generators.dart',
      'combinedAsyncStreams': 'package:dart_overview/functions/generators/run_generators.dart',
      'fetchAllPages': 'package:dart_overview/functions/generators/run_generators.dart',
      'primesUpTo': 'package:dart_overview/functions/generators/run_generators.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'main': 'Future<void> main()',
      'printShape': 'void printShape(SealedShape shape)',
      'sendNotification': 'void sendNotification(NotificationService service, String message)',
      'add': 'int add(int a, int b)',
      'multiply': 'int multiply(int a, int b)',
      'greet': 'void greet(String name)',
      'printSeparator': 'void printSeparator()',
      'square': 'int square(int n)',
      'cube': 'int cube(int n)',
      'isEven': 'bool isEven(int n)',
      'getNumbers': 'List<int> getNumbers()',
      'createUser': 'Map<String, dynamic> createUser(String name, int age)',
      'inferredReturn': 'dynamic inferredReturn()',
      'dynamicReturn': 'dynamic dynamicReturn(int choice)',
      'alwaysThrows': 'Never alwaysThrows()',
      'fullName': 'String fullName(String first, String last)',
      'describe': 'void describe({required String name, int? age, String? city})',
      'sayHello': 'String sayHello([String name = \'World\', String greeting = \'Hello\'])',
      'power': 'int power(int base, [int exponent = 2])',
      'makeRequest': 'void makeRequest(String url, {String method = \'GET\', int timeout = 30, Map<String, String>? headers})',
      'processOrder': 'void processOrder(String orderId, String product, {required int quantity, String priority = \'normal\'})',
      'transform': 'List<int> transform(List<int> numbers, int Function(int) transformer)',
      'fetchData': 'void fetchData({required String url, required void Function(String) onSuccess, required void Function(String) onError})',
      'log': 'void log(String message)',
      'firstOrNull': 'T? firstOrNull(List<T> items)',
      'fetchGreeting': 'Future<String> fetchGreeting(String name)',
      'computeSum': 'Future<int> computeSum(List<int> numbers)',
      'findMin': 'T findMin(List<T> items)',
      'findMax': 'T findMax(List<T> items)',
      'clamp': 'T clamp(T value, T min, T max)',
      'findMinMax': '({int min, int max}) findMinMax(List<int> numbers)',
      'swap': '(int, int) swap((int, int) pair)',
      'parseUserString': '(String, int) parseUserString(String input)',
      'divideWithRemainder': '({int quotient, int remainder}) divideWithRemainder(int dividend, int divisor)',
      'calculateStats': '({int sum, double average, int count}) calculateStats(List<int> numbers)',
      'countTo': 'Iterable<int> countTo(int max)',
      'range': 'Iterable<int> range(int start, int end, [int step = 1])',
      'naturalNumbers': 'Iterable<int> naturalNumbers()',
      'fibonacci': 'Iterable<int> fibonacci()',
      'nestedRanges': 'Iterable<int> nestedRanges()',
      'flatten': 'Iterable<T> flatten(Iterable<Iterable<T>> nested)',
      'traverseTree': 'Iterable<T> traverseTree(TreeNode<T> node)',
      'countAsyncTo': 'Stream<int> countAsyncTo(int max)',
      'timedEvents': 'Stream<String> timedEvents()',
      'combinedAsyncStreams': 'Stream<String> combinedAsyncStreams()',
      'fetchAllPages': 'Stream<String> fetchAllPages()',
      'primesUpTo': 'Iterable<int> primesUpTo(int max)',
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
      'package:dart_overview/classes/test_support/run_test_support.dart',
      'package:dart_overview/enums/basics/run_basics.dart',
      'package:dart_overview/functions/declarations/run_declarations.dart',
      'package:dart_overview/functions/generators/run_generators.dart',
      'package:dart_overview/functions/parameters/run_parameters.dart',
      'package:dart_overview/generics/generic_classes/run_generic_classes.dart',
      'package:dart_overview/generics/type_bounds/run_type_bounds.dart',
      'package:dart_overview/globals/basics/run_basics.dart',
      'package:dart_overview/mixins/basics/run_basics.dart',
      'package:dart_overview/records/basics/run_basics.dart',
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
    'Day',
    'Season',
    'HttpStatus',
    'Operation',
    'LogLevel',
    'Priority',
    'Role',
    'LogSeverity',
  ];

}

// =============================================================================
// Person Bridge
// =============================================================================

BridgedClass _createPersonBridge() {
  return BridgedClass(
    nativeType: $dart_overview_3.Person,
    name: 'Person',
    isAssignable: (v) => v is $dart_overview_3.Person,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_3.Person();
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_3.Person>(target, 'Person').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_3.Person>(target, 'Person').age,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Person>(target, 'Person').name = D4.extractBridgedArg<String>(value, 'name'),
      'age': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Person>(target, 'Person').age = D4.extractBridgedArg<int>(value, 'age'),
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.Person>(target, 'Person');
        t.greet();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Person()',
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
    nativeType: $dart_overview_3.Dog,
    name: 'Dog',
    isAssignable: (v) => v is $dart_overview_3.Dog,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Dog');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Dog');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Dog');
        return $dart_overview_3.Dog(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog').age,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog').name = D4.extractBridgedArg<String>(value, 'name'),
      'age': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog').age = D4.extractBridgedArg<int>(value, 'age'),
    },
    methods: {
      'bark': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog');
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
    nativeType: $dart_overview_3.User,
    name: 'User',
    isAssignable: (v) => v is $dart_overview_3.User,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'User');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'User');
        final email = D4.getRequiredArg<String>(positional, 1, 'email', 'User');
        return $dart_overview_3.User(name, email);
      },
      'guest': (visitor, positional, named) {
        return $dart_overview_3.User.guest();
      },
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'User');
        if (positional.isEmpty) {
          throw ArgumentError('User: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return $dart_overview_3.User.fromMap(map);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_3.User>(target, 'User').name,
      'email': (visitor, target) => D4.validateTarget<$dart_overview_3.User>(target, 'User').email,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.User>(target, 'User').name = D4.extractBridgedArg<String>(value, 'name'),
      'email': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.User>(target, 'User').email = D4.extractBridgedArg<String>(value, 'email'),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.User>(target, 'User');
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
    nativeType: $dart_overview_3.Calculator,
    name: 'Calculator',
    isAssignable: (v) => v is $dart_overview_3.Calculator,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_3.Calculator();
      },
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return t.add(a, b);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'subtract');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'subtract');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'subtract');
        return t.subtract(a, b);
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
        return t.multiply(a, b);
      },
      'divide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'divide');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'divide');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'divide');
        return t.divide(a, b);
      },
    },
    constructorSignatures: {
      '': 'Calculator()',
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
    nativeType: $dart_overview_3.Rectangle,
    name: 'Rectangle',
    isAssignable: (v) => v is $dart_overview_3.Rectangle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return $dart_overview_3.Rectangle(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').height,
      'area': (visitor, target) => D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').area,
      'perimeter': (visitor, target) => D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').perimeter,
    },
    setters: {
      'width': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').width = D4.extractBridgedArg<double>(value, 'width'),
      'height': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').height = D4.extractBridgedArg<double>(value, 'height'),
      'scale': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').scale = D4.extractBridgedArg<double>(value, 'scale'),
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
    nativeType: $dart_overview_3.BankAccount,
    name: 'BankAccount',
    isAssignable: (v) => v is $dart_overview_3.BankAccount,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BankAccount');
        final accountNumber = D4.getRequiredArg<String>(positional, 0, 'accountNumber', 'BankAccount');
        final balance = D4.getRequiredArg<double>(positional, 1, '_balance', 'BankAccount');
        return $dart_overview_3.BankAccount(accountNumber, balance);
      },
    },
    getters: {
      'accountNumber': (visitor, target) => D4.validateTarget<$dart_overview_3.BankAccount>(target, 'BankAccount').accountNumber,
      'balance': (visitor, target) => D4.validateTarget<$dart_overview_3.BankAccount>(target, 'BankAccount').balance,
    },
    methods: {
      'deposit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BankAccount>(target, 'BankAccount');
        D4.requireMinArgs(positional, 1, 'deposit');
        final amount = D4.getRequiredArg<double>(positional, 0, 'amount', 'deposit');
        t.deposit(amount);
        return null;
      },
      'withdraw': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BankAccount>(target, 'BankAccount');
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
    nativeType: $dart_overview_3.Circle,
    name: 'Circle',
    isAssignable: (v) => v is $dart_overview_3.Circle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return $dart_overview_3.Circle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$dart_overview_3.Circle>(target, 'Circle').radius,
      'diameter': (visitor, target) => D4.validateTarget<$dart_overview_3.Circle>(target, 'Circle').diameter,
      'circumference': (visitor, target) => D4.validateTarget<$dart_overview_3.Circle>(target, 'Circle').circumference,
      'circleArea': (visitor, target) => D4.validateTarget<$dart_overview_3.Circle>(target, 'Circle').circleArea,
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
    nativeType: $dart_overview_11.Box,
    name: 'Box',
    isAssignable: (v) => v is $dart_overview_11.Box,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Box');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Box');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $dart_overview_11.Box<double>(value);
          case int _: return $dart_overview_11.Box<int>(value);
          case String _: return $dart_overview_11.Box<String>(value);
          case bool _: return $dart_overview_11.Box<bool>(value);
          default: return $dart_overview_11.Box(value);
        }
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_11.Box>(target, 'Box').value,
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
    nativeType: $dart_overview_11.Wrapper,
    name: 'Wrapper',
    isAssignable: (v) => v is $dart_overview_11.Wrapper,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Wrapper');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Wrapper');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $dart_overview_11.Wrapper<double>(value);
          case int _: return $dart_overview_11.Wrapper<int>(value);
          case String _: return $dart_overview_11.Wrapper<String>(value);
          case bool _: return $dart_overview_11.Wrapper<bool>(value);
          default: return $dart_overview_11.Wrapper(value);
        }
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_11.Wrapper>(target, 'Wrapper').value,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_11.Wrapper>(target, 'Wrapper').value = value as dynamic,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Wrapper>(target, 'Wrapper');
        D4.requireMinArgs(positional, 1, 'transform');
        if (positional.isEmpty) {
          throw ArgumentError('transform: Missing required argument "f" at position 0');
        }
        final fRaw = positional[0];
        return t.transform((dynamic p0) { return D4.callInterpreterCallback(visitor!, fRaw, [p0]) as dynamic; });
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
    nativeType: $dart_overview_11.Pair,
    name: 'Pair',
    isAssignable: (v) => v is $dart_overview_11.Pair,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'Pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'Pair');
        return $dart_overview_11.Pair(first, second);
      },
    },
    getters: {
      'first': (visitor, target) => D4.validateTarget<$dart_overview_11.Pair>(target, 'Pair').first,
      'second': (visitor, target) => D4.validateTarget<$dart_overview_11.Pair>(target, 'Pair').second,
    },
    methods: {
      'swap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Pair>(target, 'Pair');
        return t.swap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Pair>(target, 'Pair');
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
    nativeType: $dart_overview_11.Stack,
    name: 'Stack',
    isAssignable: (v) => v is $dart_overview_11.Stack,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_11.Stack();
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_overview_11.Stack>(target, 'Stack').isEmpty,
      'length': (visitor, target) => D4.validateTarget<$dart_overview_11.Stack>(target, 'Stack').length,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Stack>(target, 'Stack');
        D4.requireMinArgs(positional, 1, 'push');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'push');
        t.push(item);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Stack>(target, 'Stack');
        return t.pop();
      },
      'peek': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Stack>(target, 'Stack');
        return t.peek();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Stack>(target, 'Stack');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Stack()',
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
    nativeType: $dart_overview_11.Queue,
    name: 'Queue',
    isAssignable: (v) => v is $dart_overview_11.Queue,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_11.Queue();
      },
    },
    getters: {
      'front': (visitor, target) => D4.validateTarget<$dart_overview_11.Queue>(target, 'Queue').front,
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_overview_11.Queue>(target, 'Queue').isEmpty,
      'length': (visitor, target) => D4.validateTarget<$dart_overview_11.Queue>(target, 'Queue').length,
    },
    methods: {
      'enqueue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Queue>(target, 'Queue');
        D4.requireMinArgs(positional, 1, 'enqueue');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'enqueue');
        t.enqueue(item);
        return null;
      },
      'dequeue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Queue>(target, 'Queue');
        return t.dequeue();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Queue>(target, 'Queue');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Queue()',
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
    nativeType: $dart_overview_11.Maybe,
    name: 'Maybe',
    isAssignable: (v) => v is $dart_overview_11.Maybe,
    constructors: {
      'some': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Maybe');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Maybe');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $dart_overview_11.Maybe<double>.some(value);
          case int _: return $dart_overview_11.Maybe<int>.some(value);
          case String _: return $dart_overview_11.Maybe<String>.some(value);
          case bool _: return $dart_overview_11.Maybe<bool>.some(value);
          default: return $dart_overview_11.Maybe.some(value);
        }
      },
      'none': (visitor, positional, named) {
        return $dart_overview_11.Maybe.none();
      },
    },
    getters: {
      'hasValue': (visitor, target) => D4.validateTarget<$dart_overview_11.Maybe>(target, 'Maybe').hasValue,
      'value': (visitor, target) => D4.validateTarget<$dart_overview_11.Maybe>(target, 'Maybe').value,
    },
    methods: {
      'getOrElse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Maybe>(target, 'Maybe');
        D4.requireMinArgs(positional, 1, 'getOrElse');
        final defaultValue = D4.getRequiredArg<dynamic>(positional, 0, 'defaultValue', 'getOrElse');
        return t.getOrElse(defaultValue);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Maybe>(target, 'Maybe');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "f" at position 0');
        }
        final fRaw = positional[0];
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor!, fRaw, [p0]) as dynamic; });
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
    nativeType: $dart_overview_11.Result,
    name: 'Result',
    isAssignable: (v) => v is $dart_overview_11.Result,
    constructors: {
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Result');
        return $dart_overview_11.Result.success(value);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final error = D4.getRequiredArg<dynamic>(positional, 0, 'error', 'Result');
        return $dart_overview_11.Result.failure(error);
      },
    },
    getters: {
      'isSuccess': (visitor, target) => D4.validateTarget<$dart_overview_11.Result>(target, 'Result').isSuccess,
    },
    methods: {
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_11.Result>(target, 'Result');
        D4.requireMinArgs(positional, 2, 'fold');
        if (positional.isEmpty) {
          throw ArgumentError('fold: Missing required argument "onSuccess" at position 0');
        }
        final onSuccessRaw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "onFailure" at position 1');
        }
        final onFailureRaw = positional[1];
        return t.fold((dynamic p0) { return D4.callInterpreterCallback(visitor!, onSuccessRaw, [p0]) as dynamic; }, (dynamic p0) { return D4.callInterpreterCallback(visitor!, onFailureRaw, [p0]) as dynamic; });
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
// LoggableMixin Bridge
// =============================================================================

BridgedClass _createLoggableMixinBridge() {
  return BridgedClass(
    nativeType: $dart_overview_7.LoggableMixin,
    name: 'LoggableMixin',
    isAssignable: (v) => v is $dart_overview_7.LoggableMixin,
    constructors: {
    },
    getters: {
      'severity': (visitor, target) => D4.validateTarget<$dart_overview_7.LoggableMixin>(target, 'LoggableMixin').severity,
    },
    methods: {
      'shouldLog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_7.LoggableMixin>(target, 'LoggableMixin');
        D4.requireMinArgs(positional, 1, 'shouldLog');
        final minLevel = D4.getRequiredArg<$dart_overview_7.LogLevel>(positional, 0, 'minLevel', 'shouldLog');
        return t.shouldLog(minLevel);
      },
    },
    methodSignatures: {
      'shouldLog': 'bool shouldLog(LogLevel minLevel)',
    },
    getterSignatures: {
      'severity': 'int get severity',
    },
  );
}

// =============================================================================
// Vehicle Bridge
// =============================================================================

BridgedClass _createVehicleBridge() {
  return BridgedClass(
    nativeType: $dart_overview_1.Vehicle,
    name: 'Vehicle',
    isAssignable: (v) => v is $dart_overview_1.Vehicle,
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.Vehicle>(target, 'Vehicle');
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
    nativeType: $dart_overview_1.Car,
    name: 'Car',
    isAssignable: (v) => v is $dart_overview_1.Car,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.Car();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.Car>(target, 'Car');
        return t.move();
      },
    },
    constructorSignatures: {
      '': 'Car()',
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
    nativeType: $dart_overview_1.Motorcycle,
    name: 'Motorcycle',
    isAssignable: (v) => v is $dart_overview_1.Motorcycle,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.Motorcycle();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.Motorcycle>(target, 'Motorcycle');
        return t.move();
      },
    },
    constructorSignatures: {
      '': 'Motorcycle()',
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
    nativeType: $dart_overview_1.BaseAnimal,
    name: 'BaseAnimal',
    isAssignable: (v) => v is $dart_overview_1.BaseAnimal,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BaseAnimal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'BaseAnimal');
        return $dart_overview_1.BaseAnimal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_1.BaseAnimal>(target, 'BaseAnimal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.BaseAnimal>(target, 'BaseAnimal');
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
    nativeType: $dart_overview_1.DogAnimal,
    name: 'DogAnimal',
    isAssignable: (v) => v is $dart_overview_1.DogAnimal,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DogAnimal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DogAnimal');
        return $dart_overview_1.DogAnimal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_1.DogAnimal>(target, 'DogAnimal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.DogAnimal>(target, 'DogAnimal');
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
    nativeType: $dart_overview_1.DataSource,
    name: 'DataSource',
    isAssignable: (v) => v is $dart_overview_1.DataSource,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.DataSource();
      },
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.DataSource>(target, 'DataSource');
        return t.fetch();
      },
    },
    constructorSignatures: {
      '': 'DataSource()',
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
    nativeType: $dart_overview_1.JsonDataSource,
    name: 'JsonDataSource',
    isAssignable: (v) => v is $dart_overview_1.JsonDataSource,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.JsonDataSource();
      },
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.JsonDataSource>(target, 'JsonDataSource');
        return t.fetch();
      },
    },
    constructorSignatures: {
      '': 'JsonDataSource()',
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
    nativeType: $dart_overview_1.XmlDataSource,
    name: 'XmlDataSource',
    isAssignable: (v) => v is $dart_overview_1.XmlDataSource,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.XmlDataSource();
      },
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.XmlDataSource>(target, 'XmlDataSource');
        return t.fetch();
      },
    },
    constructorSignatures: {
      '': 'XmlDataSource()',
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
    nativeType: $dart_overview_1.AppConfig,
    name: 'AppConfig',
    isAssignable: (v) => v is $dart_overview_1.AppConfig,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AppConfig');
        final environment = D4.getRequiredArg<String>(positional, 0, 'environment', 'AppConfig');
        final debug = D4.getRequiredArg<bool>(positional, 1, 'debug', 'AppConfig');
        return $dart_overview_1.AppConfig(environment, debug);
      },
    },
    getters: {
      'environment': (visitor, target) => D4.validateTarget<$dart_overview_1.AppConfig>(target, 'AppConfig').environment,
      'debug': (visitor, target) => D4.validateTarget<$dart_overview_1.AppConfig>(target, 'AppConfig').debug,
    },
    methods: {
      'getSetting': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.AppConfig>(target, 'AppConfig');
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
    nativeType: $dart_overview_1.SealedShape,
    name: 'SealedShape',
    isAssignable: (v) => v is $dart_overview_1.SealedShape,
    constructors: {
    },
    constructorSignatures: {
      '': 'SealedShape()',
    },
  );
}

// =============================================================================
// SealedCircle Bridge
// =============================================================================

BridgedClass _createSealedCircleBridge() {
  return BridgedClass(
    nativeType: $dart_overview_1.SealedCircle,
    name: 'SealedCircle',
    isAssignable: (v) => v is $dart_overview_1.SealedCircle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SealedCircle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'SealedCircle');
        return $dart_overview_1.SealedCircle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$dart_overview_1.SealedCircle>(target, 'SealedCircle').radius,
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
    nativeType: $dart_overview_1.SealedSquare,
    name: 'SealedSquare',
    isAssignable: (v) => v is $dart_overview_1.SealedSquare,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SealedSquare');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'SealedSquare');
        return $dart_overview_1.SealedSquare(side);
      },
    },
    getters: {
      'side': (visitor, target) => D4.validateTarget<$dart_overview_1.SealedSquare>(target, 'SealedSquare').side,
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
    nativeType: $dart_overview_1.SealedTriangle,
    name: 'SealedTriangle',
    isAssignable: (v) => v is $dart_overview_1.SealedTriangle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SealedTriangle');
        final base = D4.getRequiredArg<double>(positional, 0, 'base', 'SealedTriangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'SealedTriangle');
        return $dart_overview_1.SealedTriangle(base, height);
      },
    },
    getters: {
      'base': (visitor, target) => D4.validateTarget<$dart_overview_1.SealedTriangle>(target, 'SealedTriangle').base,
      'height': (visitor, target) => D4.validateTarget<$dart_overview_1.SealedTriangle>(target, 'SealedTriangle').height,
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
    nativeType: $dart_overview_1.LoggerMixin,
    name: 'LoggerMixin',
    isAssignable: (v) => v is $dart_overview_1.LoggerMixin,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.LoggerMixin();
      },
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.LoggerMixin>(target, 'LoggerMixin');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        t.log(message);
        return null;
      },
    },
    constructorSignatures: {
      '': 'LoggerMixin()',
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
    nativeType: $dart_overview_1.LoggingService,
    name: 'LoggingService',
    isAssignable: (v) => v is $dart_overview_1.LoggingService,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.LoggingService();
      },
    },
    methods: {
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.LoggingService>(target, 'LoggingService');
        t.performAction();
        return null;
      },
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.LoggingService>(target, 'LoggingService');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        t.log(message);
        return null;
      },
    },
    constructorSignatures: {
      '': 'LoggingService()',
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
    nativeType: $dart_overview_1.AbstractBaseClass,
    name: 'AbstractBaseClass',
    isAssignable: (v) => v is $dart_overview_1.AbstractBaseClass,
    constructors: {
    },
    methods: {
      'doSomething': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.AbstractBaseClass>(target, 'AbstractBaseClass');
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
    nativeType: $dart_overview_1.DerivedFromAbstractBase,
    name: 'DerivedFromAbstractBase',
    isAssignable: (v) => v is $dart_overview_1.DerivedFromAbstractBase,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.DerivedFromAbstractBase();
      },
    },
    methods: {
      'doSomething': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.DerivedFromAbstractBase>(target, 'DerivedFromAbstractBase');
        t.doSomething();
        return null;
      },
    },
    constructorSignatures: {
      '': 'DerivedFromAbstractBase()',
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
    nativeType: $dart_overview_1.ApiClient,
    name: 'ApiClient',
    isAssignable: (v) => v is $dart_overview_1.ApiClient,
    constructors: {
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.ApiClient>(target, 'ApiClient');
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
    nativeType: $dart_overview_1.RestApiClient,
    name: 'RestApiClient',
    isAssignable: (v) => v is $dart_overview_1.RestApiClient,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.RestApiClient();
      },
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.RestApiClient>(target, 'RestApiClient');
        D4.requireMinArgs(positional, 1, 'request');
        final endpoint = D4.getRequiredArg<String>(positional, 0, 'endpoint', 'request');
        return t.request(endpoint);
      },
    },
    constructorSignatures: {
      '': 'RestApiClient()',
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
    nativeType: $dart_overview_1.GraphqlApiClient,
    name: 'GraphqlApiClient',
    isAssignable: (v) => v is $dart_overview_1.GraphqlApiClient,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_1.GraphqlApiClient();
      },
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_1.GraphqlApiClient>(target, 'GraphqlApiClient');
        D4.requireMinArgs(positional, 1, 'request');
        final endpoint = D4.getRequiredArg<String>(positional, 0, 'endpoint', 'request');
        return t.request(endpoint);
      },
    },
    constructorSignatures: {
      '': 'GraphqlApiClient()',
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
    nativeType: $dart_overview_1.AbstractFinalClass,
    name: 'AbstractFinalClass',
    isAssignable: (v) => v is $dart_overview_1.AbstractFinalClass,
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_1.AbstractFinalClass>(target, 'AbstractFinalClass').value,
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
    nativeType: $dart_overview_1.SingletonHolder,
    name: 'SingletonHolder',
    isAssignable: (v) => v is $dart_overview_1.SingletonHolder,
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_1.SingletonHolder>(target, 'SingletonHolder').value,
    },
    staticGetters: {
      'instance': (visitor) => $dart_overview_1.SingletonHolder.instance,
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
    nativeType: $dart_overview_2.SimplePoint,
    name: 'SimplePoint',
    isAssignable: (v) => v is $dart_overview_2.SimplePoint,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_2.SimplePoint();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$dart_overview_2.SimplePoint>(target, 'SimplePoint').x,
      'y': (visitor, target) => D4.validateTarget<$dart_overview_2.SimplePoint>(target, 'SimplePoint').y,
    },
    setters: {
      'x': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_2.SimplePoint>(target, 'SimplePoint').x = D4.extractBridgedArg<int>(value, 'x'),
      'y': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_2.SimplePoint>(target, 'SimplePoint').y = D4.extractBridgedArg<int>(value, 'y'),
    },
    constructorSignatures: {
      '': 'SimplePoint()',
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
    nativeType: $dart_overview_2.Point,
    name: 'Point',
    isAssignable: (v) => v is $dart_overview_2.Point,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Point');
        final x = D4.getRequiredArg<int>(positional, 0, 'x', 'Point');
        final y = D4.getRequiredArg<int>(positional, 1, 'y', 'Point');
        return $dart_overview_2.Point(x, y);
      },
      'origin': (visitor, positional, named) {
        return $dart_overview_2.Point.origin();
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Point');
        if (positional.isEmpty) {
          throw ArgumentError('Point: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $dart_overview_2.Point.fromJson(json);
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$dart_overview_2.Point>(target, 'Point').x,
      'y': (visitor, target) => D4.validateTarget<$dart_overview_2.Point>(target, 'Point').y,
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
    nativeType: $dart_overview_2.RectangleArea,
    name: 'RectangleArea',
    isAssignable: (v) => v is $dart_overview_2.RectangleArea,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'RectangleArea');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'RectangleArea');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'RectangleArea');
        return $dart_overview_2.RectangleArea(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_overview_2.RectangleArea>(target, 'RectangleArea').width,
      'height': (visitor, target) => D4.validateTarget<$dart_overview_2.RectangleArea>(target, 'RectangleArea').height,
      'area': (visitor, target) => D4.validateTarget<$dart_overview_2.RectangleArea>(target, 'RectangleArea').area,
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
    nativeType: $dart_overview_2.PositiveNumber,
    name: 'PositiveNumber',
    isAssignable: (v) => v is $dart_overview_2.PositiveNumber,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PositiveNumber');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'PositiveNumber');
        return $dart_overview_2.PositiveNumber(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_2.PositiveNumber>(target, 'PositiveNumber').value,
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
    nativeType: $dart_overview_2.Vector,
    name: 'Vector',
    isAssignable: (v) => v is $dart_overview_2.Vector,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector');
        return $dart_overview_2.Vector(x, y);
      },
      'zero': (visitor, positional, named) {
        return $dart_overview_2.Vector.zero();
      },
      'unit': (visitor, positional, named) {
        return $dart_overview_2.Vector.unit();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$dart_overview_2.Vector>(target, 'Vector').x,
      'y': (visitor, target) => D4.validateTarget<$dart_overview_2.Vector>(target, 'Vector').y,
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
    nativeType: $dart_overview_2.Color,
    name: 'Color',
    isAssignable: (v) => v is $dart_overview_2.Color,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Color');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'Color');
        final g = D4.getRequiredArg<int>(positional, 1, 'g', 'Color');
        final b = D4.getRequiredArg<int>(positional, 2, 'b', 'Color');
        return $dart_overview_2.Color(r, g, b);
      },
    },
    getters: {
      'r': (visitor, target) => D4.validateTarget<$dart_overview_2.Color>(target, 'Color').r,
      'g': (visitor, target) => D4.validateTarget<$dart_overview_2.Color>(target, 'Color').g,
      'b': (visitor, target) => D4.validateTarget<$dart_overview_2.Color>(target, 'Color').b,
    },
    staticGetters: {
      'red': (visitor) => $dart_overview_2.Color.red,
      'green': (visitor) => $dart_overview_2.Color.green,
      'blue': (visitor) => $dart_overview_2.Color.blue,
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
    nativeType: $dart_overview_2.Logger,
    name: 'Logger',
    isAssignable: (v) => v is $dart_overview_2.Logger,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Logger');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Logger');
        return $dart_overview_2.Logger(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_2.Logger>(target, 'Logger').name,
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
// Shape Bridge
// =============================================================================

BridgedClass _createShapeBridge() {
  return BridgedClass(
    nativeType: $dart_overview_2.Shape,
    name: 'Shape',
    isAssignable: (v) => v is $dart_overview_2.Shape,
    constructors: {
      'create': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Shape');
        final type = D4.getRequiredArg<String>(positional, 0, 'type', 'Shape');
        final dimension = D4.getRequiredArg<double>(positional, 1, 'dimension', 'Shape');
        return $dart_overview_2.Shape.create(type, dimension);
      },
    },
    getters: {
      'area': (visitor, target) => D4.validateTarget<$dart_overview_2.Shape>(target, 'Shape').area,
    },
    constructorSignatures: {
      'create': 'factory Shape.create(String type, double dimension)',
    },
    getterSignatures: {
      'area': 'double get area',
    },
  );
}

// =============================================================================
// CircleShape Bridge
// =============================================================================

BridgedClass _createCircleShapeBridge() {
  return BridgedClass(
    nativeType: $dart_overview_2.CircleShape,
    name: 'CircleShape',
    isAssignable: (v) => v is $dart_overview_2.CircleShape,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CircleShape');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'CircleShape');
        return $dart_overview_2.CircleShape(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$dart_overview_2.CircleShape>(target, 'CircleShape').radius,
      'area': (visitor, target) => D4.validateTarget<$dart_overview_2.CircleShape>(target, 'CircleShape').area,
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
    nativeType: $dart_overview_2.SquareShape,
    name: 'SquareShape',
    isAssignable: (v) => v is $dart_overview_2.SquareShape,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SquareShape');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'SquareShape');
        return $dart_overview_2.SquareShape(side);
      },
    },
    getters: {
      'side': (visitor, target) => D4.validateTarget<$dart_overview_2.SquareShape>(target, 'SquareShape').side,
      'area': (visitor, target) => D4.validateTarget<$dart_overview_2.SquareShape>(target, 'SquareShape').area,
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
    nativeType: $dart_overview_2.Database,
    name: 'Database',
    isAssignable: (v) => v is $dart_overview_2.Database,
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_2.Database>(target, 'Database').name,
    },
    staticGetters: {
      'instance': (visitor) => $dart_overview_2.Database.instance,
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
    nativeType: $dart_overview_2.PersonBase,
    name: 'PersonBase',
    isAssignable: (v) => v is $dart_overview_2.PersonBase,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PersonBase');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PersonBase');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'PersonBase');
        return $dart_overview_2.PersonBase(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_2.PersonBase>(target, 'PersonBase').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_2.PersonBase>(target, 'PersonBase').age,
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
    nativeType: $dart_overview_2.Employee,
    name: 'Employee',
    isAssignable: (v) => v is $dart_overview_2.Employee,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Employee');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Employee');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Employee');
        final department = D4.getRequiredArg<String>(positional, 2, 'department', 'Employee');
        return $dart_overview_2.Employee(name, age, department);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_2.Employee>(target, 'Employee').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_2.Employee>(target, 'Employee').age,
      'department': (visitor, target) => D4.validateTarget<$dart_overview_2.Employee>(target, 'Employee').department,
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
    nativeType: $dart_overview_2.Manager,
    name: 'Manager',
    isAssignable: (v) => v is $dart_overview_2.Manager,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Manager');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Manager');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Manager');
        final department = D4.getRequiredArg<String>(positional, 2, 'department', 'Manager');
        final teamSize = D4.getRequiredArg<int>(positional, 3, 'teamSize', 'Manager');
        return $dart_overview_2.Manager(name, age, department, teamSize);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_2.Manager>(target, 'Manager').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_2.Manager>(target, 'Manager').age,
      'teamSize': (visitor, target) => D4.validateTarget<$dart_overview_2.Manager>(target, 'Manager').teamSize,
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
    nativeType: $dart_overview_4.Animal,
    name: 'Animal',
    isAssignable: (v) => v is $dart_overview_4.Animal,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Animal');
        return $dart_overview_4.Animal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_4.Animal>(target, 'Animal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Animal>(target, 'Animal');
        t.eat();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Animal>(target, 'Animal');
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
    nativeType: $dart_overview_4.Cat,
    name: 'Cat',
    isAssignable: (v) => v is $dart_overview_4.Cat,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Cat');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Cat');
        return $dart_overview_4.Cat(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_4.Cat>(target, 'Cat').name,
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Cat>(target, 'Cat');
        t.move();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Cat>(target, 'Cat');
        return t.speak();
      },
      'meow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Cat>(target, 'Cat');
        t.meow();
        return null;
      },
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Cat>(target, 'Cat');
        t.eat();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Cat(String name)',
    },
    methodSignatures: {
      'move': 'void move()',
      'speak': 'String speak()',
      'meow': 'void meow()',
      'eat': 'void eat()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// ElectricCar Bridge
// =============================================================================

BridgedClass _createElectricCarBridge() {
  return BridgedClass(
    nativeType: $dart_overview_4.ElectricCar,
    name: 'ElectricCar',
    isAssignable: (v) => v is $dart_overview_4.ElectricCar,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ElectricCar');
        final brand = D4.getRequiredArg<String>(positional, 0, 'brand', 'ElectricCar');
        final model = D4.getRequiredArg<String>(positional, 1, 'model', 'ElectricCar');
        final batteryCapacity = D4.getRequiredArg<int>(positional, 2, 'batteryCapacity', 'ElectricCar');
        return $dart_overview_4.ElectricCar(brand, model, batteryCapacity);
      },
    },
    getters: {
      'brand': (visitor, target) => D4.validateTarget<$dart_overview_4.ElectricCar>(target, 'ElectricCar').brand,
      'model': (visitor, target) => D4.validateTarget<$dart_overview_4.ElectricCar>(target, 'ElectricCar').model,
      'batteryCapacity': (visitor, target) => D4.validateTarget<$dart_overview_4.ElectricCar>(target, 'ElectricCar').batteryCapacity,
    },
    methods: {
      'displayInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.ElectricCar>(target, 'ElectricCar');
        t.displayInfo();
        return null;
      },
      'charge': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.ElectricCar>(target, 'ElectricCar');
        t.charge();
        return null;
      },
    },
    constructorSignatures: {
      '': 'ElectricCar(String brand, String model, int batteryCapacity)',
    },
    methodSignatures: {
      'displayInfo': 'void displayInfo()',
      'charge': 'void charge()',
    },
    getterSignatures: {
      'brand': 'String get brand',
      'model': 'String get model',
      'batteryCapacity': 'int get batteryCapacity',
    },
  );
}

// =============================================================================
// NotificationService Bridge
// =============================================================================

BridgedClass _createNotificationServiceBridge() {
  return BridgedClass(
    nativeType: $dart_overview_4.NotificationService,
    name: 'NotificationService',
    isAssignable: (v) => v is $dart_overview_4.NotificationService,
    constructors: {
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.NotificationService>(target, 'NotificationService');
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
    nativeType: $dart_overview_4.EmailNotificationService,
    name: 'EmailNotificationService',
    isAssignable: (v) => v is $dart_overview_4.EmailNotificationService,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_4.EmailNotificationService();
      },
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.EmailNotificationService>(target, 'EmailNotificationService');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'send');
        t.send(message);
        return null;
      },
    },
    constructorSignatures: {
      '': 'EmailNotificationService()',
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
    nativeType: $dart_overview_4.SmsNotificationService,
    name: 'SmsNotificationService',
    isAssignable: (v) => v is $dart_overview_4.SmsNotificationService,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_4.SmsNotificationService();
      },
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.SmsNotificationService>(target, 'SmsNotificationService');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'send');
        t.send(message);
        return null;
      },
    },
    constructorSignatures: {
      '': 'SmsNotificationService()',
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
    nativeType: $dart_overview_4.Switchable,
    name: 'Switchable',
    isAssignable: (v) => v is $dart_overview_4.Switchable,
    constructors: {
    },
    methods: {
      'turnOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Switchable>(target, 'Switchable');
        t.turnOn();
        return null;
      },
      'turnOff': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Switchable>(target, 'Switchable');
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
    nativeType: $dart_overview_4.TemperatureControl,
    name: 'TemperatureControl',
    isAssignable: (v) => v is $dart_overview_4.TemperatureControl,
    constructors: {
    },
    methods: {
      'setTemperature': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.TemperatureControl>(target, 'TemperatureControl');
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
    nativeType: $dart_overview_4.Connectable,
    name: 'Connectable',
    isAssignable: (v) => v is $dart_overview_4.Connectable,
    constructors: {
    },
    methods: {
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Connectable>(target, 'Connectable');
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
    nativeType: $dart_overview_4.SmartThermostat,
    name: 'SmartThermostat',
    isAssignable: (v) => v is $dart_overview_4.SmartThermostat,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_4.SmartThermostat();
      },
    },
    methods: {
      'turnOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.SmartThermostat>(target, 'SmartThermostat');
        t.turnOn();
        return null;
      },
      'turnOff': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.SmartThermostat>(target, 'SmartThermostat');
        t.turnOff();
        return null;
      },
      'setTemperature': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.SmartThermostat>(target, 'SmartThermostat');
        D4.requireMinArgs(positional, 1, 'setTemperature');
        final temp = D4.getRequiredArg<int>(positional, 0, 'temp', 'setTemperature');
        t.setTemperature(temp);
        return null;
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.SmartThermostat>(target, 'SmartThermostat');
        t.connect();
        return null;
      },
    },
    constructorSignatures: {
      '': 'SmartThermostat()',
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
    nativeType: $dart_overview_4.Machine,
    name: 'Machine',
    isAssignable: (v) => v is $dart_overview_4.Machine,
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Machine>(target, 'Machine');
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
    nativeType: $dart_overview_4.Speakable,
    name: 'Speakable',
    isAssignable: (v) => v is $dart_overview_4.Speakable,
    constructors: {
    },
    methods: {
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Speakable>(target, 'Speakable');
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
    nativeType: $dart_overview_4.Robot,
    name: 'Robot',
    isAssignable: (v) => v is $dart_overview_4.Robot,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_4.Robot();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.Robot>(target, 'Robot');
        t.move();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Robot()',
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
    nativeType: $dart_overview_4.AdvancedRobot,
    name: 'AdvancedRobot',
    isAssignable: (v) => v is $dart_overview_4.AdvancedRobot,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_4.AdvancedRobot();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.AdvancedRobot>(target, 'AdvancedRobot');
        t.move();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.AdvancedRobot>(target, 'AdvancedRobot');
        t.speak();
        return null;
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_4.AdvancedRobot>(target, 'AdvancedRobot');
        t.connect();
        return null;
      },
    },
    constructorSignatures: {
      '': 'AdvancedRobot()',
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
    nativeType: $dart_overview_5.MathUtils,
    name: 'MathUtils',
    isAssignable: (v) => v is $dart_overview_5.MathUtils,
    constructors: {
    },
    staticGetters: {
      'pi': (visitor) => $dart_overview_5.MathUtils.pi,
      'e': (visitor) => $dart_overview_5.MathUtils.e,
    },
    staticMethods: {
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'square');
        return $dart_overview_5.MathUtils.square(n);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'cube');
        return $dart_overview_5.MathUtils.cube(n);
      },
      'isEven': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEven');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'isEven');
        return $dart_overview_5.MathUtils.isEven(n);
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
    nativeType: $dart_overview_5.Counter,
    name: 'Counter',
    isAssignable: (v) => v is $dart_overview_5.Counter,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_5.Counter();
      },
    },
    staticGetters: {
      'instanceCount': (visitor) => $dart_overview_5.Counter.instanceCount,
      'label': (visitor) => $dart_overview_5.Counter.label,
    },
    staticSetters: {
      'instanceCount': (visitor, value) => 
        $dart_overview_5.Counter.instanceCount = D4.extractBridgedArg<int>(value, 'instanceCount'),
      'label': (visitor, value) => 
        $dart_overview_5.Counter.label = D4.extractBridgedArg<String>(value, 'label'),
    },
    constructorSignatures: {
      '': 'Counter()',
    },
    staticGetterSignatures: {
      'instanceCount': 'int get instanceCount',
      'label': 'String get label',
    },
    staticSetterSignatures: {
      'instanceCount': 'set instanceCount(dynamic value)',
      'label': 'set label(String value)',
    },
  );
}

// =============================================================================
// FlexibleObject Bridge
// =============================================================================

BridgedClass _createFlexibleObjectBridge() {
  return BridgedClass(
    nativeType: $dart_overview_5.FlexibleObject,
    name: 'FlexibleObject',
    isAssignable: (v) => v is $dart_overview_5.FlexibleObject,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_5.FlexibleObject();
      },
    },
    methods: {
      'noSuchMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.FlexibleObject>(target, 'FlexibleObject');
        D4.requireMinArgs(positional, 1, 'noSuchMethod');
        final invocation = D4.getRequiredArg<Invocation>(positional, 0, 'invocation', 'noSuchMethod');
        return t.noSuchMethod(invocation);
      },
    },
    constructorSignatures: {
      '': 'FlexibleObject()',
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
    nativeType: $dart_overview_5.SortablePerson,
    name: 'SortablePerson',
    isAssignable: (v) => v is $dart_overview_5.SortablePerson,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SortablePerson');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'SortablePerson');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'SortablePerson');
        return $dart_overview_5.SortablePerson(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_5.SortablePerson>(target, 'SortablePerson').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_5.SortablePerson>(target, 'SortablePerson').age,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.SortablePerson>(target, 'SortablePerson');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dart_overview_5.SortablePerson>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.SortablePerson>(target, 'SortablePerson');
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
// NumberWrapper Bridge
// =============================================================================

BridgedClass _createNumberWrapperBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.NumberWrapper,
    name: 'NumberWrapper',
    isAssignable: (v) => v is $dart_overview_6.NumberWrapper,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NumberWrapper');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'NumberWrapper');
        return $dart_overview_6.NumberWrapper(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper').value,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_6.NumberWrapper>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$dart_overview_6.NumberWrapper>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_6.NumberWrapper>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_6.NumberWrapper>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_6.NumberWrapper>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_6.NumberWrapper>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const NumberWrapper(double value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'value': 'double get value',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// BitFlags Bridge
// =============================================================================

BridgedClass _createBitFlagsBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.BitFlags,
    name: 'BitFlags',
    isAssignable: (v) => v is $dart_overview_6.BitFlags,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BitFlags');
        final bits = D4.getRequiredArg<int>(positional, 0, 'bits', 'BitFlags');
        return $dart_overview_6.BitFlags(bits);
      },
    },
    getters: {
      'bits': (visitor, target) => D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags').bits,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags').hashCode,
    },
    methods: {
      'hasFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        D4.requireMinArgs(positional, 1, 'hasFlag');
        final flag = D4.getRequiredArg<int>(positional, 0, 'flag', 'hasFlag');
        return t.hasFlag(flag);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        return t.toString();
      },
      '&': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<$dart_overview_6.BitFlags>(positional, 0, 'other', 'operator&');
        return t & other;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<$dart_overview_6.BitFlags>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '^': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<$dart_overview_6.BitFlags>(positional, 0, 'other', 'operator^');
        return t ^ other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        return ~t;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const BitFlags(int bits)',
    },
    methodSignatures: {
      'hasFlag': 'bool hasFlag(int flag)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bits': 'int get bits',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// NullableFields Bridge
// =============================================================================

BridgedClass _createNullableFieldsBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.NullableFields,
    name: 'NullableFields',
    isAssignable: (v) => v is $dart_overview_6.NullableFields,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final age = D4.getOptionalNamedArg<int?>(named, 'age');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        return $dart_overview_6.NullableFields(name: name, age: age, tags: tags);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').age,
      'tags': (visitor, target) => D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').tags,
    },
    setters: {
      'name': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').name = D4.extractBridgedArgOrNull<String>(value, 'name'),
      'age': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').age = D4.extractBridgedArgOrNull<int>(value, 'age'),
      'tags': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').tags = value == null ? null : (value as List).cast<String>().toList(),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'NullableFields({String? name, int? age, List<String>? tags})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String? get name',
      'age': 'int? get age',
      'tags': 'List<String>? get tags',
    },
    setterSignatures: {
      'name': 'set name(dynamic value)',
      'age': 'set age(dynamic value)',
      'tags': 'set tags(dynamic value)',
    },
  );
}

// =============================================================================
// LateFieldDemo Bridge
// =============================================================================

BridgedClass _createLateFieldDemoBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.LateFieldDemo,
    name: 'LateFieldDemo',
    isAssignable: (v) => v is $dart_overview_6.LateFieldDemo,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_6.LateFieldDemo();
      },
      'withValues': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'LateFieldDemo');
        final config = D4.getRequiredArg<String>(positional, 0, 'config', 'LateFieldDemo');
        final id = D4.getRequiredArg<int>(positional, 1, 'id', 'LateFieldDemo');
        return $dart_overview_6.LateFieldDemo.withValues(config, id);
      },
    },
    getters: {
      'config': (visitor, target) => D4.validateTarget<$dart_overview_6.LateFieldDemo>(target, 'LateFieldDemo').config,
      'id': (visitor, target) => D4.validateTarget<$dart_overview_6.LateFieldDemo>(target, 'LateFieldDemo').id,
    },
    setters: {
      'config': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.LateFieldDemo>(target, 'LateFieldDemo').config = D4.extractBridgedArg<String>(value, 'config'),
      'id': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.LateFieldDemo>(target, 'LateFieldDemo').id = D4.extractBridgedArg<int>(value, 'id'),
    },
    constructorSignatures: {
      '': 'LateFieldDemo()',
      'withValues': 'LateFieldDemo.withValues(String config, int id)',
    },
    getterSignatures: {
      'config': 'String get config',
      'id': 'int get id',
    },
    setterSignatures: {
      'config': 'set config(dynamic value)',
      'id': 'set id(dynamic value)',
    },
  );
}

// =============================================================================
// Multiplier Bridge
// =============================================================================

BridgedClass _createMultiplierBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.Multiplier,
    name: 'Multiplier',
    isAssignable: (v) => v is $dart_overview_6.Multiplier,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Multiplier');
        final factor = D4.getRequiredArg<int>(positional, 0, 'factor', 'Multiplier');
        return $dart_overview_6.Multiplier(factor);
      },
    },
    getters: {
      'factor': (visitor, target) => D4.validateTarget<$dart_overview_6.Multiplier>(target, 'Multiplier').factor,
    },
    methods: {
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Multiplier>(target, 'Multiplier');
        D4.requireMinArgs(positional, 1, 'call');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'call');
        return t.call(value);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Multiplier>(target, 'Multiplier');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Multiplier(int factor)',
    },
    methodSignatures: {
      'call': 'int call(int value)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'factor': 'int get factor',
    },
  );
}

// =============================================================================
// Printable Bridge
// =============================================================================

BridgedClass _createPrintableBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.Printable,
    name: 'Printable',
    isAssignable: (v) => v is $dart_overview_6.Printable,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_6.Printable();
      },
    },
    methods: {
      'printInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Printable>(target, 'Printable');
        t.printInfo();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Printable()',
    },
    methodSignatures: {
      'printInfo': 'void printInfo()',
    },
  );
}

// =============================================================================
// Serializable Bridge
// =============================================================================

BridgedClass _createSerializableBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.Serializable,
    name: 'Serializable',
    isAssignable: (v) => v is $dart_overview_6.Serializable,
    constructors: {
    },
    methods: {
      'serialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Serializable>(target, 'Serializable');
        return t.serialize();
      },
    },
    methodSignatures: {
      'serialize': 'String serialize()',
    },
  );
}

// =============================================================================
// SerializablePrintable Bridge
// =============================================================================

BridgedClass _createSerializablePrintableBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.SerializablePrintable,
    name: 'SerializablePrintable',
    isAssignable: (v) => v is $dart_overview_6.SerializablePrintable,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_6.SerializablePrintable();
      },
    },
    methods: {
      'printInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.SerializablePrintable>(target, 'SerializablePrintable');
        t.printInfo();
        return null;
      },
      'serialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.SerializablePrintable>(target, 'SerializablePrintable');
        return t.serialize();
      },
    },
    constructorSignatures: {
      '': 'SerializablePrintable()',
    },
    methodSignatures: {
      'printInfo': 'void printInfo()',
      'serialize': 'String serialize()',
    },
  );
}

// =============================================================================
// Trackable Bridge
// =============================================================================

BridgedClass _createTrackableBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.Trackable,
    name: 'Trackable',
    isAssignable: (v) => v is $dart_overview_6.Trackable,
    constructors: {
    },
    getters: {
      'trackCount': (visitor, target) => D4.validateTarget<$dart_overview_6.Trackable>(target, 'Trackable').trackCount,
    },
    methods: {
      'track': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Trackable>(target, 'Trackable');
        t.track();
        return null;
      },
    },
    methodSignatures: {
      'track': 'void track()',
    },
    getterSignatures: {
      'trackCount': 'int get trackCount',
    },
  );
}

// =============================================================================
// TrackedItem Bridge
// =============================================================================

BridgedClass _createTrackedItemBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.TrackedItem,
    name: 'TrackedItem',
    isAssignable: (v) => v is $dart_overview_6.TrackedItem,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TrackedItem');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TrackedItem');
        return $dart_overview_6.TrackedItem(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_6.TrackedItem>(target, 'TrackedItem').name,
      'trackCount': (visitor, target) => D4.validateTarget<$dart_overview_6.TrackedItem>(target, 'TrackedItem').trackCount,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.TrackedItem>(target, 'TrackedItem');
        return t.toString();
      },
      'track': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.TrackedItem>(target, 'TrackedItem');
        t.track();
        return null;
      },
    },
    constructorSignatures: {
      '': 'TrackedItem(String name)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'track': 'void track()',
    },
    getterSignatures: {
      'name': 'String get name',
      'trackCount': 'int get trackCount',
    },
  );
}

// =============================================================================
// DataProcessor Bridge
// =============================================================================

BridgedClass _createDataProcessorBridge() {
  return BridgedClass(
    nativeType: $dart_overview_6.DataProcessor,
    name: 'DataProcessor',
    isAssignable: (v) => v is $dart_overview_6.DataProcessor,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DataProcessor');
        final prefix = D4.getRequiredArg<String>(positional, 0, 'prefix', 'DataProcessor');
        return $dart_overview_6.DataProcessor(prefix);
      },
    },
    getters: {
      'prefix': (visitor, target) => D4.validateTarget<$dart_overview_6.DataProcessor>(target, 'DataProcessor').prefix,
    },
    methods: {
      'processAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.DataProcessor>(target, 'DataProcessor');
        D4.requireMinArgs(positional, 1, 'processAsync');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'processAsync');
        return t.processAsync(input);
      },
      'generateRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.DataProcessor>(target, 'DataProcessor');
        D4.requireMinArgs(positional, 2, 'generateRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'generateRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'generateRange');
        return t.generateRange(start, end);
      },
      'streamItems': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.DataProcessor>(target, 'DataProcessor');
        D4.requireMinArgs(positional, 1, 'streamItems');
        if (positional.isEmpty) {
          throw ArgumentError('streamItems: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        return t.streamItems(items);
      },
    },
    staticMethods: {
      'staticRange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'staticRange');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'staticRange');
        return $dart_overview_6.DataProcessor.staticRange(count);
      },
      'staticCountdown': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'staticCountdown');
        final from = D4.getRequiredArg<int>(positional, 0, 'from', 'staticCountdown');
        return $dart_overview_6.DataProcessor.staticCountdown(from);
      },
    },
    constructorSignatures: {
      '': 'DataProcessor(String prefix)',
    },
    methodSignatures: {
      'processAsync': 'Future<String> processAsync(String input)',
      'generateRange': 'Iterable<int> generateRange(int start, int end)',
      'streamItems': 'Stream<String> streamItems(List<String> items)',
    },
    getterSignatures: {
      'prefix': 'String get prefix',
    },
    staticMethodSignatures: {
      'staticRange': 'Iterable<int> staticRange(int count)',
      'staticCountdown': 'Stream<int> staticCountdown(int from)',
    },
  );
}

// =============================================================================
// Statistics Bridge
// =============================================================================

BridgedClass _createStatisticsBridge() {
  return BridgedClass(
    nativeType: $dart_overview_12.Statistics,
    name: 'Statistics',
    isAssignable: (v) => v is $dart_overview_12.Statistics,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Statistics');
        if (positional.isEmpty) {
          throw ArgumentError('Statistics: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<num>(positional[0], 'values');
        return $dart_overview_12.Statistics(values);
      },
    },
    getters: {
      'values': (visitor, target) => D4.validateTarget<$dart_overview_12.Statistics>(target, 'Statistics').values,
      'min': (visitor, target) => D4.validateTarget<$dart_overview_12.Statistics>(target, 'Statistics').min,
      'max': (visitor, target) => D4.validateTarget<$dart_overview_12.Statistics>(target, 'Statistics').max,
      'average': (visitor, target) => D4.validateTarget<$dart_overview_12.Statistics>(target, 'Statistics').average,
    },
    constructorSignatures: {
      '': 'Statistics(List<T> values)',
    },
    getterSignatures: {
      'values': 'List<T> get values',
      'min': 'T get min',
      'max': 'T get max',
      'average': 'double get average',
    },
  );
}

// =============================================================================
// SortedList Bridge
// =============================================================================

BridgedClass _createSortedListBridge() {
  return BridgedClass(
    nativeType: $dart_overview_12.SortedList,
    name: 'SortedList',
    isAssignable: (v) => v is $dart_overview_12.SortedList,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_12.SortedList();
      },
    },
    getters: {
      'items': (visitor, target) => D4.validateTarget<$dart_overview_12.SortedList>(target, 'SortedList').items,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.SortedList>(target, 'SortedList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<Comparable<dynamic>>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.SortedList>(target, 'SortedList');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<Comparable<dynamic>>(positional[0], 'items');
        t.addAll(items);
        return null;
      },
    },
    constructorSignatures: {
      '': 'SortedList()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'addAll': 'void addAll(Iterable<T> items)',
    },
    getterSignatures: {
      'items': 'List<T> get items',
    },
  );
}

// =============================================================================
// PriorityQueue Bridge
// =============================================================================

BridgedClass _createPriorityQueueBridge() {
  return BridgedClass(
    nativeType: $dart_overview_12.PriorityQueue,
    name: 'PriorityQueue',
    isAssignable: (v) => v is $dart_overview_12.PriorityQueue,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_12.PriorityQueue();
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_overview_12.PriorityQueue>(target, 'PriorityQueue').isEmpty,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.PriorityQueue>(target, 'PriorityQueue');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<Comparable<dynamic>>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'removeMin': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.PriorityQueue>(target, 'PriorityQueue');
        return t.removeMin();
      },
    },
    constructorSignatures: {
      '': 'PriorityQueue()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'removeMin': 'T removeMin()',
    },
    getterSignatures: {
      'isEmpty': 'bool get isEmpty',
    },
  );
}

// =============================================================================
// Range Bridge
// =============================================================================

BridgedClass _createRangeBridge() {
  return BridgedClass(
    nativeType: $dart_overview_12.Range,
    name: 'Range',
    isAssignable: (v) => v is $dart_overview_12.Range,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Range');
        final start = D4.getRequiredArg<Comparable<dynamic>>(positional, 0, 'start', 'Range');
        final end = D4.getRequiredArg<Comparable<dynamic>>(positional, 1, 'end', 'Range');
        return $dart_overview_12.Range(start, end);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$dart_overview_12.Range>(target, 'Range').start,
      'end': (visitor, target) => D4.validateTarget<$dart_overview_12.Range>(target, 'Range').end,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.Range>(target, 'Range');
        D4.requireMinArgs(positional, 1, 'contains');
        final value = D4.getRequiredArg<Comparable<dynamic>>(positional, 0, 'value', 'contains');
        return t.contains(value);
      },
    },
    constructorSignatures: {
      '': 'Range(T start, T end)',
    },
    methodSignatures: {
      'contains': 'bool contains(T value)',
    },
    getterSignatures: {
      'start': 'T get start',
      'end': 'T get end',
    },
  );
}

// =============================================================================
// BinarySearchTree Bridge
// =============================================================================

BridgedClass _createBinarySearchTreeBridge() {
  return BridgedClass(
    nativeType: $dart_overview_12.BinarySearchTree,
    name: 'BinarySearchTree',
    isAssignable: (v) => v is $dart_overview_12.BinarySearchTree,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_12.BinarySearchTree();
      },
    },
    methods: {
      'insert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.BinarySearchTree>(target, 'BinarySearchTree');
        D4.requireMinArgs(positional, 1, 'insert');
        final value = D4.getRequiredArg<Comparable<dynamic>>(positional, 0, 'value', 'insert');
        t.insert(value);
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.BinarySearchTree>(target, 'BinarySearchTree');
        D4.requireMinArgs(positional, 1, 'contains');
        final value = D4.getRequiredArg<Comparable<dynamic>>(positional, 0, 'value', 'contains');
        return t.contains(value);
      },
      'inOrder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.BinarySearchTree>(target, 'BinarySearchTree');
        return t.inOrder();
      },
    },
    constructorSignatures: {
      '': 'BinarySearchTree()',
    },
    methodSignatures: {
      'insert': 'void insert(T value)',
      'contains': 'bool contains(T value)',
      'inOrder': 'List<T> inOrder()',
    },
  );
}

// =============================================================================
// Cache Bridge
// =============================================================================

BridgedClass _createCacheBridge() {
  return BridgedClass(
    nativeType: $dart_overview_12.Cache,
    name: 'Cache',
    isAssignable: (v) => v is $dart_overview_12.Cache,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_12.Cache();
      },
    },
    methods: {
      'put': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.Cache>(target, 'Cache');
        D4.requireMinArgs(positional, 2, 'put');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'put');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'put');
        t.put(key, value);
        return null;
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.Cache>(target, 'Cache');
        D4.requireMinArgs(positional, 1, 'get');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'get');
        return t.get(key);
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_12.Cache>(target, 'Cache');
        D4.requireMinArgs(positional, 1, 'contains');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'contains');
        return t.contains(key);
      },
    },
    constructorSignatures: {
      '': 'Cache()',
    },
    methodSignatures: {
      'put': 'void put(K key, V value)',
      'get': 'V? get(K key)',
      'contains': 'bool contains(K key)',
    },
  );
}

// =============================================================================
// TreeNode Bridge
// =============================================================================

BridgedClass _createTreeNodeBridge() {
  return BridgedClass(
    nativeType: $dart_overview_9.TreeNode,
    name: 'TreeNode',
    isAssignable: (v) => v is $dart_overview_9.TreeNode,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TreeNode');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'TreeNode');
        final children = positional.length > 1 && positional[1] != null
            ? D4.coerceList<$dart_overview_9.TreeNode<dynamic>>(positional[1], 'children')
            : const <$dart_overview_9.TreeNode<dynamic>>[];
        return $dart_overview_9.TreeNode(value, children);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_9.TreeNode>(target, 'TreeNode').value,
      'children': (visitor, target) => D4.validateTarget<$dart_overview_9.TreeNode>(target, 'TreeNode').children,
    },
    constructorSignatures: {
      '': 'TreeNode(T value, [List<TreeNode<T>> children = const []])',
    },
    getterSignatures: {
      'value': 'T get value',
      'children': 'List<TreeNode<T>> get children',
    },
  );
}

// =============================================================================
// Musical Bridge
// =============================================================================

BridgedClass _createMusicalBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Musical,
    name: 'Musical',
    isAssignable: (v) => v is $dart_overview_14.Musical,
    constructors: {
    },
    methods: {
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Musical>(target, 'Musical');
        t.playInstrument();
        return null;
      },
    },
    methodSignatures: {
      'playInstrument': 'void playInstrument()',
    },
  );
}

// =============================================================================
// Dancing Bridge
// =============================================================================

BridgedClass _createDancingBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Dancing,
    name: 'Dancing',
    isAssignable: (v) => v is $dart_overview_14.Dancing,
    constructors: {
    },
    methods: {
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Dancing>(target, 'Dancing');
        t.dance();
        return null;
      },
    },
    methodSignatures: {
      'dance': 'void dance()',
    },
  );
}

// =============================================================================
// Musician Bridge
// =============================================================================

BridgedClass _createMusicianBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Musician,
    name: 'Musician',
    isAssignable: (v) => v is $dart_overview_14.Musician,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Musician');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Musician');
        return $dart_overview_14.Musician(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Musician>(target, 'Musician').name,
    },
    methods: {
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Musician>(target, 'Musician');
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
    nativeType: $dart_overview_14.ProfessionalDancer,
    name: 'ProfessionalDancer',
    isAssignable: (v) => v is $dart_overview_14.ProfessionalDancer,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProfessionalDancer');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ProfessionalDancer');
        return $dart_overview_14.ProfessionalDancer(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.ProfessionalDancer>(target, 'ProfessionalDancer').name,
    },
    methods: {
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.ProfessionalDancer>(target, 'ProfessionalDancer');
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
    nativeType: $dart_overview_14.Entertainer,
    name: 'Entertainer',
    isAssignable: (v) => v is $dart_overview_14.Entertainer,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Entertainer');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Entertainer');
        return $dart_overview_14.Entertainer(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Entertainer>(target, 'Entertainer').name,
    },
    methods: {
      'perform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Entertainer>(target, 'Entertainer');
        t.perform();
        return null;
      },
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Entertainer>(target, 'Entertainer');
        t.playInstrument();
        return null;
      },
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Entertainer>(target, 'Entertainer');
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
    nativeType: $dart_overview_14.CountableItem,
    name: 'CountableItem',
    isAssignable: (v) => v is $dart_overview_14.CountableItem,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_14.CountableItem();
      },
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<$dart_overview_14.CountableItem>(target, 'CountableItem').count,
    },
    methods: {
      'increment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.CountableItem>(target, 'CountableItem');
        t.increment();
        return null;
      },
      'decrement': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.CountableItem>(target, 'CountableItem');
        t.decrement();
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.CountableItem>(target, 'CountableItem');
        t.reset();
        return null;
      },
    },
    constructorSignatures: {
      '': 'CountableItem()',
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
// Flying Bridge
// =============================================================================

BridgedClass _createFlyingBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Flying,
    name: 'Flying',
    isAssignable: (v) => v is $dart_overview_14.Flying,
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Flying>(target, 'Flying').name,
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Flying>(target, 'Flying');
        t.move();
        return null;
      },
      'fly': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Flying>(target, 'Flying');
        t.fly();
        return null;
      },
    },
    methodSignatures: {
      'move': 'void move()',
      'fly': 'void fly()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Walking Bridge
// =============================================================================

BridgedClass _createWalkingBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Walking,
    name: 'Walking',
    isAssignable: (v) => v is $dart_overview_14.Walking,
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Walking>(target, 'Walking').name,
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Walking>(target, 'Walking');
        t.move();
        return null;
      },
      'walk': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Walking>(target, 'Walking');
        t.walk();
        return null;
      },
    },
    methodSignatures: {
      'move': 'void move()',
      'walk': 'void walk()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Bird Bridge
// =============================================================================

BridgedClass _createBirdBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Bird,
    name: 'Bird',
    isAssignable: (v) => v is $dart_overview_14.Bird,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Bird');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Bird');
        return $dart_overview_14.Bird(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Bird>(target, 'Bird').name,
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Bird>(target, 'Bird');
        t.move();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Bird(String name)',
    },
    methodSignatures: {
      'move': 'void move()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Eagle Bridge
// =============================================================================

BridgedClass _createEagleBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Eagle,
    name: 'Eagle',
    isAssignable: (v) => v is $dart_overview_14.Eagle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Eagle');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Eagle');
        return $dart_overview_14.Eagle(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Eagle>(target, 'Eagle').name,
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Eagle>(target, 'Eagle');
        t.move();
        return null;
      },
      'fly': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Eagle>(target, 'Eagle');
        t.fly();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Eagle(String name)',
    },
    methodSignatures: {
      'move': 'void move()',
      'fly': 'void fly()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Penguin Bridge
// =============================================================================

BridgedClass _createPenguinBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Penguin,
    name: 'Penguin',
    isAssignable: (v) => v is $dart_overview_14.Penguin,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Penguin');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Penguin');
        return $dart_overview_14.Penguin(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_14.Penguin>(target, 'Penguin').name,
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Penguin>(target, 'Penguin');
        t.move();
        return null;
      },
      'walk': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Penguin>(target, 'Penguin');
        t.walk();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Penguin(String name)',
    },
    methodSignatures: {
      'move': 'void move()',
      'walk': 'void walk()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Logging Bridge
// =============================================================================

BridgedClass _createLoggingBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Logging,
    name: 'Logging',
    isAssignable: (v) => v is $dart_overview_14.Logging,
    constructors: {
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Logging>(target, 'Logging');
        D4.requireMinArgs(positional, 2, 'log');
        final level = D4.getRequiredArg<String>(positional, 0, 'level', 'log');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'log');
        t.log(level, message);
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Logging>(target, 'Logging');
        D4.requireMinArgs(positional, 1, 'info');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'info');
        t.info(message);
        return null;
      },
      'warning': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Logging>(target, 'Logging');
        D4.requireMinArgs(positional, 1, 'warning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'warning');
        t.warning(message);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Logging>(target, 'Logging');
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
// ConsoleLogger Bridge
// =============================================================================

BridgedClass _createConsoleLoggerBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.ConsoleLogger,
    name: 'ConsoleLogger',
    isAssignable: (v) => v is $dart_overview_14.ConsoleLogger,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_14.ConsoleLogger();
      },
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 2, 'log');
        final level = D4.getRequiredArg<String>(positional, 0, 'level', 'log');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'log');
        t.log(level, message);
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'info');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'info');
        t.info(message);
        return null;
      },
      'warning': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'warning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'warning');
        t.warning(message);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        t.error(message);
        return null;
      },
    },
    constructorSignatures: {
      '': 'ConsoleLogger()',
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
// Greeter1 Bridge
// =============================================================================

BridgedClass _createGreeter1Bridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Greeter1,
    name: 'Greeter1',
    isAssignable: (v) => v is $dart_overview_14.Greeter1,
    constructors: {
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Greeter1>(target, 'Greeter1');
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
// Greeter2 Bridge
// =============================================================================

BridgedClass _createGreeter2Bridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Greeter2,
    name: 'Greeter2',
    isAssignable: (v) => v is $dart_overview_14.Greeter2,
    constructors: {
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Greeter2>(target, 'Greeter2');
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
// MultiMixed Bridge
// =============================================================================

BridgedClass _createMultiMixedBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.MultiMixed,
    name: 'MultiMixed',
    isAssignable: (v) => v is $dart_overview_14.MultiMixed,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_14.MultiMixed();
      },
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.MultiMixed>(target, 'MultiMixed');
        t.greet();
        return null;
      },
    },
    constructorSignatures: {
      '': 'MultiMixed()',
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
    nativeType: $dart_overview_14.Helper,
    name: 'Helper',
    isAssignable: (v) => v is $dart_overview_14.Helper,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_14.Helper();
      },
    },
    methods: {
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Helper>(target, 'Helper');
        t.help();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Helper()',
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
    nativeType: $dart_overview_14.HelpfulService,
    name: 'HelpfulService',
    isAssignable: (v) => v is $dart_overview_14.HelpfulService,
    constructors: {
      '': (visitor, positional, named) {
        return $dart_overview_14.HelpfulService();
      },
    },
    methods: {
      'serve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.HelpfulService>(target, 'HelpfulService');
        t.serve();
        return null;
      },
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.HelpfulService>(target, 'HelpfulService');
        t.help();
        return null;
      },
    },
    constructorSignatures: {
      '': 'HelpfulService()',
    },
    methodSignatures: {
      'serve': 'void serve()',
      'help': 'void help()',
    },
  );
}

// =============================================================================
// EventEmitter Bridge
// =============================================================================

BridgedClass _createEventEmitterBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.EventEmitter,
    name: 'EventEmitter',
    isAssignable: (v) => v is $dart_overview_14.EventEmitter,
    constructors: {
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((String p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((String p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'emit');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'emit');
        t.emit(event);
        return null;
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(EventListener listener)',
      'removeListener': 'void removeListener(EventListener listener)',
      'emit': 'void emit(String event)',
    },
  );
}

// =============================================================================
// Button Bridge
// =============================================================================

BridgedClass _createButtonBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.Button,
    name: 'Button',
    isAssignable: (v) => v is $dart_overview_14.Button,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Button');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'Button');
        return $dart_overview_14.Button(label);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$dart_overview_14.Button>(target, 'Button').label,
    },
    methods: {
      'click': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Button>(target, 'Button');
        t.click();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((String p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((String p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.Button>(target, 'Button');
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
// ComparableMixin Bridge
// =============================================================================

BridgedClass _createComparableMixinBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.ComparableMixin,
    name: 'ComparableMixin',
    isAssignable: (v) => v is $dart_overview_14.ComparableMixin,
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_14.ComparableMixin>(target, 'ComparableMixin').value,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.ComparableMixin>(target, 'ComparableMixin');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dart_overview_14.SortableItem>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SortableItem other)',
    },
    getterSignatures: {
      'value': 'int get value',
    },
  );
}

// =============================================================================
// SortableItem Bridge
// =============================================================================

BridgedClass _createSortableItemBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.SortableItem,
    name: 'SortableItem',
    isAssignable: (v) => v is $dart_overview_14.SortableItem,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SortableItem');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'SortableItem');
        return $dart_overview_14.SortableItem(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_14.SortableItem>(target, 'SortableItem').value,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.SortableItem>(target, 'SortableItem');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dart_overview_14.SortableItem>(positional, 0, 'other', 'compareTo');
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

// =============================================================================
// JsonSerializable Bridge
// =============================================================================

BridgedClass _createJsonSerializableBridge() {
  return BridgedClass(
    nativeType: $dart_overview_14.JsonSerializable,
    name: 'JsonSerializable',
    isAssignable: (v) => v is $dart_overview_14.JsonSerializable,
    constructors: {
    },
    methods: {
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.JsonSerializable>(target, 'JsonSerializable');
        return t.toJsonMap();
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_14.JsonSerializable>(target, 'JsonSerializable');
        return t.toJson();
      },
    },
    methodSignatures: {
      'toJsonMap': 'Map<String, dynamic> toJsonMap()',
      'toJson': 'String toJson()',
    },
  );
}

