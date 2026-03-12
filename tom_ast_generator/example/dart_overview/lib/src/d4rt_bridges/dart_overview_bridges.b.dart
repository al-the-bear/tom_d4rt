// D4rt Bridge - Generated file, do not edit
// Sources: 16 files
<<<<<<< Updated upstream
// Generated: 2026-02-14T12:48:56.935549
=======
// Generated: 2026-03-12T17:02:50.202260
>>>>>>> Stashed changes

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';
import 'dart:async';

import 'package:dart_overview/classes/constructors/run_constructors.dart' as $dart_overview_1;
import 'package:dart_overview/classes/static_object_methods/run_static_object_methods.dart' as $dart_overview_2;
import 'package:dart_overview/classes/test_support/run_test_support.dart' as $dart_overview_3;
import 'package:dart_overview/enums/basics/run_basics.dart' as $dart_overview_4;
import 'package:dart_overview/generics/generic_classes/run_generic_classes.dart' as $dart_overview_5;
import 'package:dart_overview/mixins/basics/run_basics.dart' as $dart_overview_6;
import 'package:dart_overview/class_modifiers/modifiers/run_modifiers.dart' as $aux_dart_overview_2;
import 'package:dart_overview/classes/inheritance/run_inheritance.dart' as $aux_dart_overview_3;
import 'package:dart_overview/globals/basics/run_basics.dart' as $aux_dart_overview;

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
      _createMusicalBridge(),
      _createDancingBridge(),
      _createMusicianBridge(),
      _createProfessionalDancerBridge(),
      _createEntertainerBridge(),
      _createCountableItemBridge(),
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
<<<<<<< Updated upstream
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
      'Musical': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Dancing': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Musician': 'package:dart_overview/mixins/basics/run_basics.dart',
      'ProfessionalDancer': 'package:dart_overview/mixins/basics/run_basics.dart',
      'Entertainer': 'package:dart_overview/mixins/basics/run_basics.dart',
      'CountableItem': 'package:dart_overview/mixins/basics/run_basics.dart',
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

=======
      'Person': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'Dog': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'User': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'Calculator': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'Rectangle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'BankAccount': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'Circle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'Box': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'Wrapper': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'Pair': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'Stack': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'Queue': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'Maybe': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'Result': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'LoggableMixin': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'Vehicle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'Car': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'Motorcycle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'BaseAnimal': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'DogAnimal': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'DataSource': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'JsonDataSource': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'XmlDataSource': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'AppConfig': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'SealedShape': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'SealedCircle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'SealedSquare': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'SealedTriangle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'LoggerMixin': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'LoggingService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'AbstractBaseClass': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'DerivedFromAbstractBase': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'ApiClient': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'RestApiClient': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'GraphqlApiClient': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'AbstractFinalClass': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'SingletonHolder': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'SimplePoint': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Point': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'RectangleArea': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'PositiveNumber': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Vector': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Color': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Logger': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'CircleShape': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'SquareShape': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Database': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'PersonBase': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Employee': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Manager': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'Animal': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'Cat': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'NotificationService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'EmailNotificationService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'SmsNotificationService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'Switchable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'TemperatureControl': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'Connectable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'SmartThermostat': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'Machine': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'Speakable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'Robot': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'AdvancedRobot': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'MathUtils': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\static_object_methods\run_static_object_methods.dart',
      'Counter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\static_object_methods\run_static_object_methods.dart',
      'FlexibleObject': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\static_object_methods\run_static_object_methods.dart',
      'SortablePerson': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\static_object_methods\run_static_object_methods.dart',
      'NumberWrapper': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'BitFlags': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'NullableFields': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'LateFieldDemo': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'Multiplier': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'Printable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'Serializable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'SerializablePrintable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'Trackable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'TrackedItem': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'DataProcessor': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'Statistics': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\type_bounds\run_type_bounds.dart',
      'Musical': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Dancing': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Musician': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'ProfessionalDancer': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Entertainer': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'CountableItem': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Logging': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'ConsoleLogger': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Greeter1': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Greeter2': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'MultiMixed': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Helper': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'HelpfulService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'EventEmitter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'Button': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'ComparableMixin': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'SortableItem': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'JsonSerializable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
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

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
      'IntOperation',
      'Predicate',
      'VoidCallback',
      'EventListener',
    ];
  }

>>>>>>> Stashed changes
  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<Day>(
        name: 'Day',
        values: Day.values,
      ),
      BridgedEnumDefinition<Season>(
        name: 'Season',
        values: Season.values,
        getters: {
          'months': (visitor, target) => (target as Season).months,
          'avgTemperature': (visitor, target) => (target as Season).avgTemperature,
        },
      ),
      BridgedEnumDefinition<HttpStatus>(
        name: 'HttpStatus',
        values: HttpStatus.values,
        getters: {
          'code': (visitor, target) => (target as HttpStatus).code,
          'message': (visitor, target) => (target as HttpStatus).message,
          'isSuccess': (visitor, target) => (target as HttpStatus).isSuccess,
          'isError': (visitor, target) => (target as HttpStatus).isError,
        },
      ),
      BridgedEnumDefinition<Operation>(
        name: 'Operation',
        values: Operation.values,
        getters: {
          'symbol': (visitor, target) => (target as Operation).symbol,
        },
        methods: {
          'execute': (visitor, target, positional, named, typeArgs) {
            final t = target as Operation;
            return Function.apply(t.execute, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$dart_overview_4.LogLevel>(
        name: 'LogLevel',
        values: $dart_overview_4.LogLevel.values,
        getters: {
          'severity': (visitor, target) => (target as $dart_overview_4.LogLevel).severity,
        },
        methods: {
          'shouldLog': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_overview_4.LogLevel;
            return Function.apply(t.shouldLog, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<Priority>(
        name: 'Priority',
        values: Priority.values,
      ),
      BridgedEnumDefinition<Role>(
        name: 'Role',
        values: Role.values,
      ),
      BridgedEnumDefinition<$aux_dart_overview.LogSeverity>(
        name: 'LogSeverity',
        values: $aux_dart_overview.LogSeverity.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'Day': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'Season': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'HttpStatus': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'Operation': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'LogLevel': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'Priority': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'Role': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'LogSeverity': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart',
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
<<<<<<< Updated upstream
=======

    // Register class aliases (typedef type aliases)
    final aliases = classAliases();
    for (final entry in aliases.entries) {
      interpreter.registerClassAlias(entry.key, entry.value, importPath);
    }

    // Register function typedefs for type resolution
    final typedefs = functionTypedefs();
    for (final name in typedefs) {
      interpreter.registerFunctionTypedef(name, importPath);
    }
>>>>>>> Stashed changes
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('globalCounter', globalCounter, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "globalCounter": $e');
    }
    try {
      interpreter.registerGlobalVariable('appName', appName, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxRetries', maxRetries, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxRetries": $e');
    }
    try {
      interpreter.registerGlobalVariable('currentUser', currentUser, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "currentUser": $e');
    }
    try {
      interpreter.registerGlobalVariable('lastProcessedId', lastProcessedId, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "lastProcessedId": $e');
    }
    try {
      interpreter.registerGlobalVariable('appStartTime', appStartTime, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "appStartTime": $e');
    }
    try {
      interpreter.registerGlobalVariable('sessionId', sessionId, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "sessionId": $e');
    }
    try {
<<<<<<< Updated upstream
      interpreter.registerGlobalVariable('apiUrl', $dart_overview_13.apiUrl, importPath, sourceUri: 'package:dart_overview/globals/basics/run_basics.dart');
=======
      interpreter.registerGlobalVariable('apiUrl', apiUrl, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
>>>>>>> Stashed changes
    } catch (e) {
      errors.add('Failed to register variable "apiUrl": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxConnections', maxConnections, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxConnections": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTimeout', defaultTimeout, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('validStatuses', validStatuses, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "validStatuses": $e');
    }
    try {
      interpreter.registerGlobalVariable('priorities', priorities, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "priorities": $e');
    }
    try {
      interpreter.registerGlobalVariable('reservedIds', reservedIds, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "reservedIds": $e');
    }
    try {
      interpreter.registerGlobalVariable('lazyConfig', lazyConfig, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    } catch (e) {
      errors.add('Failed to register variable "lazyConfig": $e');
    }
    interpreter.registerGlobalGetter('now', () => now, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    interpreter.registerGlobalGetter('connectionCount', () => connectionCount, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    interpreter.registerGlobalGetter('cachedValue', () => cachedValue, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    interpreter.registerGlobalGetter('logLevel', () => logLevel, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');
    interpreter.registerGlobalSetter('logLevel', (v) => logLevel = v as $aux_dart_overview.LogSeverity, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (all):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'main': (visitor, positional, named, typeArgs) {
<<<<<<< Updated upstream
        return $dart_overview_16.main();
=======
        return main();
>>>>>>> Stashed changes
      },
      'multiply': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
<<<<<<< Updated upstream
        return $dart_overview_8.multiply(a, b);
=======
        return multiply(a, b);
>>>>>>> Stashed changes
      },
      'printSeparator': (visitor, positional, named, typeArgs) {
        return printSeparator();
      },
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'square');
        return square(n);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'cube');
        return cube(n);
      },
      'isEven': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEven');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'isEven');
        return isEven(n);
      },
      'getNumbers': (visitor, positional, named, typeArgs) {
        return getNumbers();
      },
      'createUser': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'createUser');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createUser');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'createUser');
        return createUser(name, age);
      },
      'inferredReturn': (visitor, positional, named, typeArgs) {
        return inferredReturn();
      },
      'dynamicReturn': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dynamicReturn');
        final choice = D4.getRequiredArg<int>(positional, 0, 'choice', 'dynamicReturn');
<<<<<<< Updated upstream
        return $dart_overview_8.dynamicReturn(choice);
=======
        return dynamicReturn(choice);
>>>>>>> Stashed changes
      },
      'describe': (visitor, positional, named, typeArgs) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'describe');
        final age = D4.getOptionalNamedArg<int?>(named, 'age');
        final city = D4.getOptionalNamedArg<String?>(named, 'city');
        return describe(name: name, age: age, city: city);
      },
      'sayHello': (visitor, positional, named, typeArgs) {
        final name = D4.getOptionalArgWithDefault<String>(positional, 0, 'name', 'World');
        final greeting = D4.getOptionalArgWithDefault<String>(positional, 1, 'greeting', 'Hello');
        return sayHello(name, greeting);
      },
      'power': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'power');
        final base = D4.getRequiredArg<int>(positional, 0, 'base', 'power');
        final exponent = D4.getOptionalArgWithDefault<int>(positional, 1, 'exponent', 2);
        return power(base, exponent);
      },
      'makeRequest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'makeRequest');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'makeRequest');
        final method = D4.getNamedArgWithDefault<String>(named, 'method', 'GET');
        final timeout = D4.getNamedArgWithDefault<int>(named, 'timeout', 30);
        final headers = D4.getOptionalNamedArg<Map<String, String>?>(named, 'headers');
        return makeRequest(url, method: method, timeout: timeout, headers: headers);
      },
      'processOrder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processOrder');
        final orderId = D4.getRequiredArg<String>(positional, 0, 'orderId', 'processOrder');
        final product = D4.getRequiredArg<String>(positional, 1, 'product', 'processOrder');
        final quantity = D4.getRequiredNamedArg<int>(named, 'quantity', 'processOrder');
        final priority = D4.getNamedArgWithDefault<String>(named, 'priority', 'normal');
        return processOrder(orderId, product, quantity: quantity, priority: priority);
      },
      'transform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transform');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'transform');
        if (positional.length <= 1) {
          throw ArgumentError('transform: Missing required argument "transformer" at position 1');
        }
        final transformerRaw = positional[1];
<<<<<<< Updated upstream
        final transformer = (int p0) { return D4.callInterpreterCallback(visitor, transformerRaw, [p0]) as int; };
        return $dart_overview_10.transform(numbers, transformer);
=======
        final transformer = (int p0) { return D4.callInterpreterCallback(visitor!, transformerRaw, [p0]) as int; };
        return transform(numbers, transformer);
>>>>>>> Stashed changes
      },
      'fetchData': (visitor, positional, named, typeArgs) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'fetchData');
        final onSuccessRaw = named['onSuccess'];
        if (onSuccessRaw == null) {
          throw ArgumentError('fetchData: Missing required named argument "onSuccess"');
        }
        final onSuccess = (String p0) { D4.callInterpreterCallback(visitor, onSuccessRaw, [p0]); };
        final onErrorRaw = named['onError'];
        if (onErrorRaw == null) {
          throw ArgumentError('fetchData: Missing required named argument "onError"');
        }
<<<<<<< Updated upstream
        final onError = (String p0) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0]); };
        return $dart_overview_10.fetchData(url: url, onSuccess: onSuccess, onError: onError);
=======
        final onError = (String p0) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0]); };
        return fetchData(url: url, onSuccess: onSuccess, onError: onError);
>>>>>>> Stashed changes
      },
      'log': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        return log(message);
      },
      'firstOrNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'firstOrNull');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'firstOrNull');
        return firstOrNull<dynamic>(items);
      },
      'fetchGreeting': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fetchGreeting');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'fetchGreeting');
        return fetchGreeting(name);
      },
      'computeSum': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'computeSum');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'computeSum');
<<<<<<< Updated upstream
        return $dart_overview_6.computeSum(numbers);
=======
        return computeSum(numbers);
>>>>>>> Stashed changes
      },
      'findMinMax': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findMinMax');
        final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'findMinMax');
        final $result = findMinMax(numbers);
        return InterpretedRecord([], {'min': $result.min, 'max': $result.max});
      },
      'swap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'swap');
        final pair$raw = positional[0];
        final pair = pair$raw is InterpretedRecord
            ? (pair$raw.positionalFields[0] as int, pair$raw.positionalFields[1] as int)
            : pair$raw as (int, int);
        final $result = swap(pair);
        return InterpretedRecord([$result.$1, $result.$2], {});
      },
      'parseUserString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parseUserString');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'parseUserString');
        final $result = parseUserString(input);
        return InterpretedRecord([$result.$1, $result.$2], {});
      },
      'divideWithRemainder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'divideWithRemainder');
        final dividend = D4.getRequiredArg<int>(positional, 0, 'dividend', 'divideWithRemainder');
        final divisor = D4.getRequiredArg<int>(positional, 1, 'divisor', 'divideWithRemainder');
        final $result = divideWithRemainder(dividend, divisor);
        return InterpretedRecord([], {'quotient': $result.quotient, 'remainder': $result.remainder});
      },
      'countTo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'countTo');
        final max = D4.getRequiredArg<int>(positional, 0, 'max', 'countTo');
        return countTo(max);
      },
      'range': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'range');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'range');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'range');
        final step = D4.getOptionalArgWithDefault<int>(positional, 2, 'step', 1);
        return range(start, end, step);
      },
      'naturalNumbers': (visitor, positional, named, typeArgs) {
        return naturalNumbers();
      },
      'fibonacci': (visitor, positional, named, typeArgs) {
<<<<<<< Updated upstream
        return $dart_overview_9.fibonacci();
=======
        return fibonacci();
>>>>>>> Stashed changes
      },
      'countAsyncTo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'countAsyncTo');
        final max = D4.getRequiredArg<int>(positional, 0, 'max', 'countAsyncTo');
<<<<<<< Updated upstream
        return $dart_overview_9.countAsyncTo(max);
=======
        return countAsyncTo(max);
>>>>>>> Stashed changes
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
      'fetchGreeting': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'computeSum': 'package:dart_overview/classes/test_support/run_test_support.dart',
      'findMinMax': 'package:dart_overview/records/basics/run_basics.dart',
      'swap': 'package:dart_overview/records/basics/run_basics.dart',
      'parseUserString': 'package:dart_overview/records/basics/run_basics.dart',
      'divideWithRemainder': 'package:dart_overview/records/basics/run_basics.dart',
      'countTo': 'package:dart_overview/functions/generators/run_generators.dart',
      'range': 'package:dart_overview/functions/generators/run_generators.dart',
      'naturalNumbers': 'package:dart_overview/functions/generators/run_generators.dart',
      'fibonacci': 'package:dart_overview/functions/generators/run_generators.dart',
      'countAsyncTo': 'package:dart_overview/functions/generators/run_generators.dart',
=======
      'main': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\run_dart_overview.dart',
      'multiply': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'printSeparator': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'square': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'cube': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'isEven': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'getNumbers': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'createUser': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'inferredReturn': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'dynamicReturn': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'describe': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'sayHello': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'power': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'makeRequest': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'processOrder': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'transform': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'fetchData': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'log': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart',
      'firstOrNull': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart',
      'fetchGreeting': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'computeSum': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'findMinMax': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\records\basics\run_basics.dart',
      'swap': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\records\basics\run_basics.dart',
      'parseUserString': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\records\basics\run_basics.dart',
      'divideWithRemainder': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\records\basics\run_basics.dart',
      'countTo': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\generators\run_generators.dart',
      'range': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\generators\run_generators.dart',
      'naturalNumbers': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\generators\run_generators.dart',
      'fibonacci': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\generators\run_generators.dart',
      'countAsyncTo': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\generators\run_generators.dart',
>>>>>>> Stashed changes
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
      'fetchGreeting': 'Future<String> fetchGreeting(String name)',
      'computeSum': 'Future<int> computeSum(List<int> numbers)',
      'findMinMax': '({int min, int max}) findMinMax(List<int> numbers)',
      'swap': '(int, int) swap((int, int) pair)',
      'parseUserString': '(String, int) parseUserString(String input)',
      'divideWithRemainder': '({int quotient, int remainder}) divideWithRemainder(int dividend, int divisor)',
      'countTo': 'Iterable<int> countTo(int max)',
      'range': 'Iterable<int> range(int start, int end, [int step = 1])',
      'naturalNumbers': 'Iterable<int> naturalNumbers()',
      'fibonacci': 'Iterable<int> fibonacci()',
      'countAsyncTo': 'Stream<int> countAsyncTo(int max)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\class_modifiers\modifiers\run_modifiers.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\constructors\run_constructors.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\declarations\run_declarations.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\inheritance\run_inheritance.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\static_object_methods\run_static_object_methods.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\classes\test_support\run_test_support.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\enums\basics\run_basics.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\declarations\run_declarations.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\generators\run_generators.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\functions\parameters\run_parameters.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\generic_classes\run_generic_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\generics\type_bounds\run_type_bounds.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\globals\basics\run_basics.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\mixins\basics\run_basics.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\records\basics\run_basics.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\dart_overview\lib\run_dart_overview.dart',
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
    nativeType: Person,
    name: 'Person',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Person,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Person();
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Person>(target, 'Person').name,
      'age': (visitor, target) => D4.validateTarget<Person>(target, 'Person').age,
    },
    setters: {
      'name': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_3.Person>(target, 'Person').name = value as String,
      'age': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Person>(target, 'Person').age = value as int,
=======
        D4.validateTarget<Person>(target, 'Person').name = D4.extractBridgedArg<String>(value, 'name'),
      'age': (visitor, target, value) => 
        D4.validateTarget<Person>(target, 'Person').age = D4.extractBridgedArg<int>(value, 'age'),
>>>>>>> Stashed changes
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Person>(target, 'Person');
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
    nativeType: Dog,
    name: 'Dog',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Dog,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Dog');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Dog');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Dog');
        return Dog(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Dog>(target, 'Dog').name,
      'age': (visitor, target) => D4.validateTarget<Dog>(target, 'Dog').age,
    },
    setters: {
      'name': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog').name = value as String,
      'age': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Dog>(target, 'Dog').age = value as int,
=======
        D4.validateTarget<Dog>(target, 'Dog').name = D4.extractBridgedArg<String>(value, 'name'),
      'age': (visitor, target, value) => 
        D4.validateTarget<Dog>(target, 'Dog').age = D4.extractBridgedArg<int>(value, 'age'),
>>>>>>> Stashed changes
    },
    methods: {
      'bark': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dog>(target, 'Dog');
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
    nativeType: User,
    name: 'User',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is User,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'User');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'User');
        final email = D4.getRequiredArg<String>(positional, 1, 'email', 'User');
        return User(name, email);
      },
      'guest': (visitor, positional, named) {
        return User.guest();
      },
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'User');
        if (positional.isEmpty) {
          throw ArgumentError('User: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return User.fromMap(map);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<User>(target, 'User').name,
      'email': (visitor, target) => D4.validateTarget<User>(target, 'User').email,
    },
    setters: {
      'name': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_3.User>(target, 'User').name = value as String,
      'email': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.User>(target, 'User').email = value as String,
=======
        D4.validateTarget<User>(target, 'User').name = D4.extractBridgedArg<String>(value, 'name'),
      'email': (visitor, target, value) => 
        D4.validateTarget<User>(target, 'User').email = D4.extractBridgedArg<String>(value, 'email'),
>>>>>>> Stashed changes
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<User>(target, 'User');
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
    nativeType: Calculator,
    name: 'Calculator',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Calculator,
>>>>>>> Stashed changes
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
    nativeType: Rectangle,
    name: 'Rectangle',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Rectangle,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return Rectangle(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').height,
      'area': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').area,
      'perimeter': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').perimeter,
    },
    setters: {
      'width': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').width = value as double,
      'height': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').height = value as double,
      'scale': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_3.Rectangle>(target, 'Rectangle').scale = value as dynamic,
=======
        D4.validateTarget<Rectangle>(target, 'Rectangle').width = D4.extractBridgedArg<double>(value, 'width'),
      'height': (visitor, target, value) => 
        D4.validateTarget<Rectangle>(target, 'Rectangle').height = D4.extractBridgedArg<double>(value, 'height'),
      'scale': (visitor, target, value) => 
        D4.validateTarget<Rectangle>(target, 'Rectangle').scale = D4.extractBridgedArg<double>(value, 'scale'),
>>>>>>> Stashed changes
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
    nativeType: BankAccount,
    name: 'BankAccount',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is BankAccount,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BankAccount');
        final accountNumber = D4.getRequiredArg<String>(positional, 0, 'accountNumber', 'BankAccount');
        final balance = D4.getRequiredArg<double>(positional, 1, '_balance', 'BankAccount');
        return BankAccount(accountNumber, balance);
      },
    },
    getters: {
      'accountNumber': (visitor, target) => D4.validateTarget<BankAccount>(target, 'BankAccount').accountNumber,
      'balance': (visitor, target) => D4.validateTarget<BankAccount>(target, 'BankAccount').balance,
    },
    methods: {
      'deposit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BankAccount>(target, 'BankAccount');
        D4.requireMinArgs(positional, 1, 'deposit');
        final amount = D4.getRequiredArg<double>(positional, 0, 'amount', 'deposit');
        t.deposit(amount);
        return null;
      },
      'withdraw': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BankAccount>(target, 'BankAccount');
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
    nativeType: Circle,
    name: 'Circle',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Circle,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return Circle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').radius,
      'diameter': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').diameter,
      'circumference': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').circumference,
      'circleArea': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').circleArea,
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
    nativeType: Box,
    name: 'Box',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Box,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Box');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Box');
<<<<<<< Updated upstream
        return $dart_overview_11.Box(value);
=======
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return Box<double>(value);
          case int _: return Box<int>(value);
          case String _: return Box<String>(value);
          case bool _: return Box<bool>(value);
          case Person _: return Box<Person>(value);
          case Dog _: return Box<Dog>(value);
          case User _: return Box<User>(value);
          case Calculator _: return Box<Calculator>(value);
          case Rectangle _: return Box<Rectangle>(value);
          case BankAccount _: return Box<BankAccount>(value);
          case Circle _: return Box<Circle>(value);
          case $dart_overview_5.Wrapper _: return Box<$dart_overview_5.Wrapper>(value);
          case $dart_overview_5.Pair _: return Box<$dart_overview_5.Pair>(value);
          case Stack _: return Box<Stack>(value);
          case Queue _: return Box<Queue>(value);
          case $dart_overview_5.Maybe _: return Box<$dart_overview_5.Maybe>(value);
          case Result _: return Box<Result>(value);
          case LoggableMixin _: return Box<LoggableMixin>(value);
          case Vehicle _: return Box<Vehicle>(value);
          case Car _: return Box<Car>(value);
          case Motorcycle _: return Box<Motorcycle>(value);
          case BaseAnimal _: return Box<BaseAnimal>(value);
          case DogAnimal _: return Box<DogAnimal>(value);
          case DataSource _: return Box<DataSource>(value);
          case JsonDataSource _: return Box<JsonDataSource>(value);
          case XmlDataSource _: return Box<XmlDataSource>(value);
          case AppConfig _: return Box<AppConfig>(value);
          case $aux_dart_overview_2.SealedShape _: return Box<$aux_dart_overview_2.SealedShape>(value);
          case SealedCircle _: return Box<SealedCircle>(value);
          case SealedSquare _: return Box<SealedSquare>(value);
          case SealedTriangle _: return Box<SealedTriangle>(value);
          case LoggerMixin _: return Box<LoggerMixin>(value);
          case LoggingService _: return Box<LoggingService>(value);
          case AbstractBaseClass _: return Box<AbstractBaseClass>(value);
          case DerivedFromAbstractBase _: return Box<DerivedFromAbstractBase>(value);
          case ApiClient _: return Box<ApiClient>(value);
          case RestApiClient _: return Box<RestApiClient>(value);
          case GraphqlApiClient _: return Box<GraphqlApiClient>(value);
          case AbstractFinalClass _: return Box<AbstractFinalClass>(value);
          case SingletonHolder _: return Box<SingletonHolder>(value);
          case SimplePoint _: return Box<SimplePoint>(value);
          case Point _: return Box<Point>(value);
          case RectangleArea _: return Box<RectangleArea>(value);
          case PositiveNumber _: return Box<PositiveNumber>(value);
          case Vector _: return Box<Vector>(value);
          case $dart_overview_1.Color _: return Box<$dart_overview_1.Color>(value);
          case $dart_overview_1.Logger _: return Box<$dart_overview_1.Logger>(value);
          case CircleShape _: return Box<CircleShape>(value);
          case SquareShape _: return Box<SquareShape>(value);
          case $dart_overview_1.Database _: return Box<$dart_overview_1.Database>(value);
          case PersonBase _: return Box<PersonBase>(value);
          case Employee _: return Box<Employee>(value);
          case Manager _: return Box<Manager>(value);
          case $dart_overview_6.Animal _: return Box<$dart_overview_6.Animal>(value);
          case Cat _: return Box<Cat>(value);
          case $aux_dart_overview_3.NotificationService _: return Box<$aux_dart_overview_3.NotificationService>(value);
          case EmailNotificationService _: return Box<EmailNotificationService>(value);
          case SmsNotificationService _: return Box<SmsNotificationService>(value);
          case Switchable _: return Box<Switchable>(value);
          case TemperatureControl _: return Box<TemperatureControl>(value);
          case Connectable _: return Box<Connectable>(value);
          case SmartThermostat _: return Box<SmartThermostat>(value);
          case Machine _: return Box<Machine>(value);
          case Speakable _: return Box<Speakable>(value);
          case Robot _: return Box<Robot>(value);
          case AdvancedRobot _: return Box<AdvancedRobot>(value);
          case MathUtils _: return Box<MathUtils>(value);
          case Counter _: return Box<Counter>(value);
          case FlexibleObject _: return Box<FlexibleObject>(value);
          case $dart_overview_2.SortablePerson _: return Box<$dart_overview_2.SortablePerson>(value);
          case $dart_overview_3.NumberWrapper _: return Box<$dart_overview_3.NumberWrapper>(value);
          case $dart_overview_3.BitFlags _: return Box<$dart_overview_3.BitFlags>(value);
          case NullableFields _: return Box<NullableFields>(value);
          case LateFieldDemo _: return Box<LateFieldDemo>(value);
          case Multiplier _: return Box<Multiplier>(value);
          case Printable _: return Box<Printable>(value);
          case Serializable _: return Box<Serializable>(value);
          case SerializablePrintable _: return Box<SerializablePrintable>(value);
          case Trackable _: return Box<Trackable>(value);
          case TrackedItem _: return Box<TrackedItem>(value);
          case DataProcessor _: return Box<DataProcessor>(value);
          case Statistics _: return Box<Statistics>(value);
          case Musical _: return Box<Musical>(value);
          case Dancing _: return Box<Dancing>(value);
          case Musician _: return Box<Musician>(value);
          case ProfessionalDancer _: return Box<ProfessionalDancer>(value);
          case Entertainer _: return Box<Entertainer>(value);
          case CountableItem _: return Box<CountableItem>(value);
          case Logging _: return Box<Logging>(value);
          case ConsoleLogger _: return Box<ConsoleLogger>(value);
          case Greeter1 _: return Box<Greeter1>(value);
          case Greeter2 _: return Box<Greeter2>(value);
          case MultiMixed _: return Box<MultiMixed>(value);
          case Helper _: return Box<Helper>(value);
          case HelpfulService _: return Box<HelpfulService>(value);
          case EventEmitter _: return Box<EventEmitter>(value);
          case Button _: return Box<Button>(value);
          case ComparableMixin _: return Box<ComparableMixin>(value);
          case $dart_overview_6.SortableItem _: return Box<$dart_overview_6.SortableItem>(value);
          case JsonSerializable _: return Box<JsonSerializable>(value);
          default: return Box(value);
        }
>>>>>>> Stashed changes
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<Box>(target, 'Box').value,
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
    nativeType: $dart_overview_5.Wrapper,
    name: 'Wrapper',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_5.Wrapper,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Wrapper');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Wrapper');
<<<<<<< Updated upstream
        return $dart_overview_11.Wrapper(value);
=======
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $dart_overview_5.Wrapper<double>(value);
          case int _: return $dart_overview_5.Wrapper<int>(value);
          case String _: return $dart_overview_5.Wrapper<String>(value);
          case bool _: return $dart_overview_5.Wrapper<bool>(value);
          case Person _: return $dart_overview_5.Wrapper<Person>(value);
          case Dog _: return $dart_overview_5.Wrapper<Dog>(value);
          case User _: return $dart_overview_5.Wrapper<User>(value);
          case Calculator _: return $dart_overview_5.Wrapper<Calculator>(value);
          case Rectangle _: return $dart_overview_5.Wrapper<Rectangle>(value);
          case BankAccount _: return $dart_overview_5.Wrapper<BankAccount>(value);
          case Circle _: return $dart_overview_5.Wrapper<Circle>(value);
          case Box _: return $dart_overview_5.Wrapper<Box>(value);
          case $dart_overview_5.Pair _: return $dart_overview_5.Wrapper<$dart_overview_5.Pair>(value);
          case Stack _: return $dart_overview_5.Wrapper<Stack>(value);
          case Queue _: return $dart_overview_5.Wrapper<Queue>(value);
          case $dart_overview_5.Maybe _: return $dart_overview_5.Wrapper<$dart_overview_5.Maybe>(value);
          case Result _: return $dart_overview_5.Wrapper<Result>(value);
          case LoggableMixin _: return $dart_overview_5.Wrapper<LoggableMixin>(value);
          case Vehicle _: return $dart_overview_5.Wrapper<Vehicle>(value);
          case Car _: return $dart_overview_5.Wrapper<Car>(value);
          case Motorcycle _: return $dart_overview_5.Wrapper<Motorcycle>(value);
          case BaseAnimal _: return $dart_overview_5.Wrapper<BaseAnimal>(value);
          case DogAnimal _: return $dart_overview_5.Wrapper<DogAnimal>(value);
          case DataSource _: return $dart_overview_5.Wrapper<DataSource>(value);
          case JsonDataSource _: return $dart_overview_5.Wrapper<JsonDataSource>(value);
          case XmlDataSource _: return $dart_overview_5.Wrapper<XmlDataSource>(value);
          case AppConfig _: return $dart_overview_5.Wrapper<AppConfig>(value);
          case $aux_dart_overview_2.SealedShape _: return $dart_overview_5.Wrapper<$aux_dart_overview_2.SealedShape>(value);
          case SealedCircle _: return $dart_overview_5.Wrapper<SealedCircle>(value);
          case SealedSquare _: return $dart_overview_5.Wrapper<SealedSquare>(value);
          case SealedTriangle _: return $dart_overview_5.Wrapper<SealedTriangle>(value);
          case LoggerMixin _: return $dart_overview_5.Wrapper<LoggerMixin>(value);
          case LoggingService _: return $dart_overview_5.Wrapper<LoggingService>(value);
          case AbstractBaseClass _: return $dart_overview_5.Wrapper<AbstractBaseClass>(value);
          case DerivedFromAbstractBase _: return $dart_overview_5.Wrapper<DerivedFromAbstractBase>(value);
          case ApiClient _: return $dart_overview_5.Wrapper<ApiClient>(value);
          case RestApiClient _: return $dart_overview_5.Wrapper<RestApiClient>(value);
          case GraphqlApiClient _: return $dart_overview_5.Wrapper<GraphqlApiClient>(value);
          case AbstractFinalClass _: return $dart_overview_5.Wrapper<AbstractFinalClass>(value);
          case SingletonHolder _: return $dart_overview_5.Wrapper<SingletonHolder>(value);
          case SimplePoint _: return $dart_overview_5.Wrapper<SimplePoint>(value);
          case Point _: return $dart_overview_5.Wrapper<Point>(value);
          case RectangleArea _: return $dart_overview_5.Wrapper<RectangleArea>(value);
          case PositiveNumber _: return $dart_overview_5.Wrapper<PositiveNumber>(value);
          case Vector _: return $dart_overview_5.Wrapper<Vector>(value);
          case $dart_overview_1.Color _: return $dart_overview_5.Wrapper<$dart_overview_1.Color>(value);
          case $dart_overview_1.Logger _: return $dart_overview_5.Wrapper<$dart_overview_1.Logger>(value);
          case CircleShape _: return $dart_overview_5.Wrapper<CircleShape>(value);
          case SquareShape _: return $dart_overview_5.Wrapper<SquareShape>(value);
          case $dart_overview_1.Database _: return $dart_overview_5.Wrapper<$dart_overview_1.Database>(value);
          case PersonBase _: return $dart_overview_5.Wrapper<PersonBase>(value);
          case Employee _: return $dart_overview_5.Wrapper<Employee>(value);
          case Manager _: return $dart_overview_5.Wrapper<Manager>(value);
          case $dart_overview_6.Animal _: return $dart_overview_5.Wrapper<$dart_overview_6.Animal>(value);
          case Cat _: return $dart_overview_5.Wrapper<Cat>(value);
          case $aux_dart_overview_3.NotificationService _: return $dart_overview_5.Wrapper<$aux_dart_overview_3.NotificationService>(value);
          case EmailNotificationService _: return $dart_overview_5.Wrapper<EmailNotificationService>(value);
          case SmsNotificationService _: return $dart_overview_5.Wrapper<SmsNotificationService>(value);
          case Switchable _: return $dart_overview_5.Wrapper<Switchable>(value);
          case TemperatureControl _: return $dart_overview_5.Wrapper<TemperatureControl>(value);
          case Connectable _: return $dart_overview_5.Wrapper<Connectable>(value);
          case SmartThermostat _: return $dart_overview_5.Wrapper<SmartThermostat>(value);
          case Machine _: return $dart_overview_5.Wrapper<Machine>(value);
          case Speakable _: return $dart_overview_5.Wrapper<Speakable>(value);
          case Robot _: return $dart_overview_5.Wrapper<Robot>(value);
          case AdvancedRobot _: return $dart_overview_5.Wrapper<AdvancedRobot>(value);
          case MathUtils _: return $dart_overview_5.Wrapper<MathUtils>(value);
          case Counter _: return $dart_overview_5.Wrapper<Counter>(value);
          case FlexibleObject _: return $dart_overview_5.Wrapper<FlexibleObject>(value);
          case $dart_overview_2.SortablePerson _: return $dart_overview_5.Wrapper<$dart_overview_2.SortablePerson>(value);
          case $dart_overview_3.NumberWrapper _: return $dart_overview_5.Wrapper<$dart_overview_3.NumberWrapper>(value);
          case $dart_overview_3.BitFlags _: return $dart_overview_5.Wrapper<$dart_overview_3.BitFlags>(value);
          case NullableFields _: return $dart_overview_5.Wrapper<NullableFields>(value);
          case LateFieldDemo _: return $dart_overview_5.Wrapper<LateFieldDemo>(value);
          case Multiplier _: return $dart_overview_5.Wrapper<Multiplier>(value);
          case Printable _: return $dart_overview_5.Wrapper<Printable>(value);
          case Serializable _: return $dart_overview_5.Wrapper<Serializable>(value);
          case SerializablePrintable _: return $dart_overview_5.Wrapper<SerializablePrintable>(value);
          case Trackable _: return $dart_overview_5.Wrapper<Trackable>(value);
          case TrackedItem _: return $dart_overview_5.Wrapper<TrackedItem>(value);
          case DataProcessor _: return $dart_overview_5.Wrapper<DataProcessor>(value);
          case Statistics _: return $dart_overview_5.Wrapper<Statistics>(value);
          case Musical _: return $dart_overview_5.Wrapper<Musical>(value);
          case Dancing _: return $dart_overview_5.Wrapper<Dancing>(value);
          case Musician _: return $dart_overview_5.Wrapper<Musician>(value);
          case ProfessionalDancer _: return $dart_overview_5.Wrapper<ProfessionalDancer>(value);
          case Entertainer _: return $dart_overview_5.Wrapper<Entertainer>(value);
          case CountableItem _: return $dart_overview_5.Wrapper<CountableItem>(value);
          case Logging _: return $dart_overview_5.Wrapper<Logging>(value);
          case ConsoleLogger _: return $dart_overview_5.Wrapper<ConsoleLogger>(value);
          case Greeter1 _: return $dart_overview_5.Wrapper<Greeter1>(value);
          case Greeter2 _: return $dart_overview_5.Wrapper<Greeter2>(value);
          case MultiMixed _: return $dart_overview_5.Wrapper<MultiMixed>(value);
          case Helper _: return $dart_overview_5.Wrapper<Helper>(value);
          case HelpfulService _: return $dart_overview_5.Wrapper<HelpfulService>(value);
          case EventEmitter _: return $dart_overview_5.Wrapper<EventEmitter>(value);
          case Button _: return $dart_overview_5.Wrapper<Button>(value);
          case ComparableMixin _: return $dart_overview_5.Wrapper<ComparableMixin>(value);
          case $dart_overview_6.SortableItem _: return $dart_overview_5.Wrapper<$dart_overview_6.SortableItem>(value);
          case JsonSerializable _: return $dart_overview_5.Wrapper<JsonSerializable>(value);
          default: return $dart_overview_5.Wrapper(value);
        }
>>>>>>> Stashed changes
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_5.Wrapper>(target, 'Wrapper').value,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_5.Wrapper>(target, 'Wrapper').value = value as dynamic,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.Wrapper>(target, 'Wrapper');
        D4.requireMinArgs(positional, 1, 'transform');
        if (positional.isEmpty) {
          throw ArgumentError('transform: Missing required argument "f" at position 0');
        }
        final fRaw = positional[0];
<<<<<<< Updated upstream
        return t.transform((dynamic p0) { return D4.callInterpreterCallback(visitor, fRaw, [p0]) as dynamic; });
=======
        return t.transform((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, fRaw, [p0])); });
>>>>>>> Stashed changes
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
    nativeType: $dart_overview_5.Pair,
    name: 'Pair',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_5.Pair,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'Pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'Pair');
        return $dart_overview_5.Pair(first, second);
      },
    },
    getters: {
      'first': (visitor, target) => D4.validateTarget<$dart_overview_5.Pair>(target, 'Pair').first,
      'second': (visitor, target) => D4.validateTarget<$dart_overview_5.Pair>(target, 'Pair').second,
    },
    methods: {
      'swap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.Pair>(target, 'Pair');
        return t.swap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.Pair>(target, 'Pair');
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
    nativeType: Stack,
    name: 'Stack',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Stack,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Stack();
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<Stack>(target, 'Stack').isEmpty,
      'length': (visitor, target) => D4.validateTarget<Stack>(target, 'Stack').length,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Stack>(target, 'Stack');
        D4.requireMinArgs(positional, 1, 'push');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'push');
        t.push(item);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Stack>(target, 'Stack');
        return t.pop();
      },
      'peek': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Stack>(target, 'Stack');
        return t.peek();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Stack>(target, 'Stack');
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
    nativeType: Queue,
    name: 'Queue',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Queue,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Queue();
      },
    },
    getters: {
      'front': (visitor, target) => D4.validateTarget<Queue>(target, 'Queue').front,
      'isEmpty': (visitor, target) => D4.validateTarget<Queue>(target, 'Queue').isEmpty,
      'length': (visitor, target) => D4.validateTarget<Queue>(target, 'Queue').length,
    },
    methods: {
      'enqueue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Queue>(target, 'Queue');
        D4.requireMinArgs(positional, 1, 'enqueue');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'enqueue');
        t.enqueue(item);
        return null;
      },
      'dequeue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Queue>(target, 'Queue');
        return t.dequeue();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Queue>(target, 'Queue');
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
    nativeType: $dart_overview_5.Maybe,
    name: 'Maybe',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_5.Maybe,
>>>>>>> Stashed changes
    constructors: {
      'some': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Maybe');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Maybe');
<<<<<<< Updated upstream
        return $dart_overview_11.Maybe.some(value);
=======
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $dart_overview_5.Maybe<double>.some(value);
          case int _: return $dart_overview_5.Maybe<int>.some(value);
          case String _: return $dart_overview_5.Maybe<String>.some(value);
          case bool _: return $dart_overview_5.Maybe<bool>.some(value);
          case Person _: return $dart_overview_5.Maybe<Person>.some(value);
          case Dog _: return $dart_overview_5.Maybe<Dog>.some(value);
          case User _: return $dart_overview_5.Maybe<User>.some(value);
          case Calculator _: return $dart_overview_5.Maybe<Calculator>.some(value);
          case Rectangle _: return $dart_overview_5.Maybe<Rectangle>.some(value);
          case BankAccount _: return $dart_overview_5.Maybe<BankAccount>.some(value);
          case Circle _: return $dart_overview_5.Maybe<Circle>.some(value);
          case Box _: return $dart_overview_5.Maybe<Box>.some(value);
          case $dart_overview_5.Wrapper _: return $dart_overview_5.Maybe<$dart_overview_5.Wrapper>.some(value);
          case $dart_overview_5.Pair _: return $dart_overview_5.Maybe<$dart_overview_5.Pair>.some(value);
          case Stack _: return $dart_overview_5.Maybe<Stack>.some(value);
          case Queue _: return $dart_overview_5.Maybe<Queue>.some(value);
          case Result _: return $dart_overview_5.Maybe<Result>.some(value);
          case LoggableMixin _: return $dart_overview_5.Maybe<LoggableMixin>.some(value);
          case Vehicle _: return $dart_overview_5.Maybe<Vehicle>.some(value);
          case Car _: return $dart_overview_5.Maybe<Car>.some(value);
          case Motorcycle _: return $dart_overview_5.Maybe<Motorcycle>.some(value);
          case BaseAnimal _: return $dart_overview_5.Maybe<BaseAnimal>.some(value);
          case DogAnimal _: return $dart_overview_5.Maybe<DogAnimal>.some(value);
          case DataSource _: return $dart_overview_5.Maybe<DataSource>.some(value);
          case JsonDataSource _: return $dart_overview_5.Maybe<JsonDataSource>.some(value);
          case XmlDataSource _: return $dart_overview_5.Maybe<XmlDataSource>.some(value);
          case AppConfig _: return $dart_overview_5.Maybe<AppConfig>.some(value);
          case $aux_dart_overview_2.SealedShape _: return $dart_overview_5.Maybe<$aux_dart_overview_2.SealedShape>.some(value);
          case SealedCircle _: return $dart_overview_5.Maybe<SealedCircle>.some(value);
          case SealedSquare _: return $dart_overview_5.Maybe<SealedSquare>.some(value);
          case SealedTriangle _: return $dart_overview_5.Maybe<SealedTriangle>.some(value);
          case LoggerMixin _: return $dart_overview_5.Maybe<LoggerMixin>.some(value);
          case LoggingService _: return $dart_overview_5.Maybe<LoggingService>.some(value);
          case AbstractBaseClass _: return $dart_overview_5.Maybe<AbstractBaseClass>.some(value);
          case DerivedFromAbstractBase _: return $dart_overview_5.Maybe<DerivedFromAbstractBase>.some(value);
          case ApiClient _: return $dart_overview_5.Maybe<ApiClient>.some(value);
          case RestApiClient _: return $dart_overview_5.Maybe<RestApiClient>.some(value);
          case GraphqlApiClient _: return $dart_overview_5.Maybe<GraphqlApiClient>.some(value);
          case AbstractFinalClass _: return $dart_overview_5.Maybe<AbstractFinalClass>.some(value);
          case SingletonHolder _: return $dart_overview_5.Maybe<SingletonHolder>.some(value);
          case SimplePoint _: return $dart_overview_5.Maybe<SimplePoint>.some(value);
          case Point _: return $dart_overview_5.Maybe<Point>.some(value);
          case RectangleArea _: return $dart_overview_5.Maybe<RectangleArea>.some(value);
          case PositiveNumber _: return $dart_overview_5.Maybe<PositiveNumber>.some(value);
          case Vector _: return $dart_overview_5.Maybe<Vector>.some(value);
          case $dart_overview_1.Color _: return $dart_overview_5.Maybe<$dart_overview_1.Color>.some(value);
          case $dart_overview_1.Logger _: return $dart_overview_5.Maybe<$dart_overview_1.Logger>.some(value);
          case CircleShape _: return $dart_overview_5.Maybe<CircleShape>.some(value);
          case SquareShape _: return $dart_overview_5.Maybe<SquareShape>.some(value);
          case $dart_overview_1.Database _: return $dart_overview_5.Maybe<$dart_overview_1.Database>.some(value);
          case PersonBase _: return $dart_overview_5.Maybe<PersonBase>.some(value);
          case Employee _: return $dart_overview_5.Maybe<Employee>.some(value);
          case Manager _: return $dart_overview_5.Maybe<Manager>.some(value);
          case $dart_overview_6.Animal _: return $dart_overview_5.Maybe<$dart_overview_6.Animal>.some(value);
          case Cat _: return $dart_overview_5.Maybe<Cat>.some(value);
          case $aux_dart_overview_3.NotificationService _: return $dart_overview_5.Maybe<$aux_dart_overview_3.NotificationService>.some(value);
          case EmailNotificationService _: return $dart_overview_5.Maybe<EmailNotificationService>.some(value);
          case SmsNotificationService _: return $dart_overview_5.Maybe<SmsNotificationService>.some(value);
          case Switchable _: return $dart_overview_5.Maybe<Switchable>.some(value);
          case TemperatureControl _: return $dart_overview_5.Maybe<TemperatureControl>.some(value);
          case Connectable _: return $dart_overview_5.Maybe<Connectable>.some(value);
          case SmartThermostat _: return $dart_overview_5.Maybe<SmartThermostat>.some(value);
          case Machine _: return $dart_overview_5.Maybe<Machine>.some(value);
          case Speakable _: return $dart_overview_5.Maybe<Speakable>.some(value);
          case Robot _: return $dart_overview_5.Maybe<Robot>.some(value);
          case AdvancedRobot _: return $dart_overview_5.Maybe<AdvancedRobot>.some(value);
          case MathUtils _: return $dart_overview_5.Maybe<MathUtils>.some(value);
          case Counter _: return $dart_overview_5.Maybe<Counter>.some(value);
          case FlexibleObject _: return $dart_overview_5.Maybe<FlexibleObject>.some(value);
          case $dart_overview_2.SortablePerson _: return $dart_overview_5.Maybe<$dart_overview_2.SortablePerson>.some(value);
          case $dart_overview_3.NumberWrapper _: return $dart_overview_5.Maybe<$dart_overview_3.NumberWrapper>.some(value);
          case $dart_overview_3.BitFlags _: return $dart_overview_5.Maybe<$dart_overview_3.BitFlags>.some(value);
          case NullableFields _: return $dart_overview_5.Maybe<NullableFields>.some(value);
          case LateFieldDemo _: return $dart_overview_5.Maybe<LateFieldDemo>.some(value);
          case Multiplier _: return $dart_overview_5.Maybe<Multiplier>.some(value);
          case Printable _: return $dart_overview_5.Maybe<Printable>.some(value);
          case Serializable _: return $dart_overview_5.Maybe<Serializable>.some(value);
          case SerializablePrintable _: return $dart_overview_5.Maybe<SerializablePrintable>.some(value);
          case Trackable _: return $dart_overview_5.Maybe<Trackable>.some(value);
          case TrackedItem _: return $dart_overview_5.Maybe<TrackedItem>.some(value);
          case DataProcessor _: return $dart_overview_5.Maybe<DataProcessor>.some(value);
          case Statistics _: return $dart_overview_5.Maybe<Statistics>.some(value);
          case Musical _: return $dart_overview_5.Maybe<Musical>.some(value);
          case Dancing _: return $dart_overview_5.Maybe<Dancing>.some(value);
          case Musician _: return $dart_overview_5.Maybe<Musician>.some(value);
          case ProfessionalDancer _: return $dart_overview_5.Maybe<ProfessionalDancer>.some(value);
          case Entertainer _: return $dart_overview_5.Maybe<Entertainer>.some(value);
          case CountableItem _: return $dart_overview_5.Maybe<CountableItem>.some(value);
          case Logging _: return $dart_overview_5.Maybe<Logging>.some(value);
          case ConsoleLogger _: return $dart_overview_5.Maybe<ConsoleLogger>.some(value);
          case Greeter1 _: return $dart_overview_5.Maybe<Greeter1>.some(value);
          case Greeter2 _: return $dart_overview_5.Maybe<Greeter2>.some(value);
          case MultiMixed _: return $dart_overview_5.Maybe<MultiMixed>.some(value);
          case Helper _: return $dart_overview_5.Maybe<Helper>.some(value);
          case HelpfulService _: return $dart_overview_5.Maybe<HelpfulService>.some(value);
          case EventEmitter _: return $dart_overview_5.Maybe<EventEmitter>.some(value);
          case Button _: return $dart_overview_5.Maybe<Button>.some(value);
          case ComparableMixin _: return $dart_overview_5.Maybe<ComparableMixin>.some(value);
          case $dart_overview_6.SortableItem _: return $dart_overview_5.Maybe<$dart_overview_6.SortableItem>.some(value);
          case JsonSerializable _: return $dart_overview_5.Maybe<JsonSerializable>.some(value);
          default: return $dart_overview_5.Maybe.some(value);
        }
>>>>>>> Stashed changes
      },
      'none': (visitor, positional, named) {
        return $dart_overview_5.Maybe.none();
      },
    },
    getters: {
      'hasValue': (visitor, target) => D4.validateTarget<$dart_overview_5.Maybe>(target, 'Maybe').hasValue,
      'value': (visitor, target) => D4.validateTarget<$dart_overview_5.Maybe>(target, 'Maybe').value,
    },
    methods: {
      'getOrElse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.Maybe>(target, 'Maybe');
        D4.requireMinArgs(positional, 1, 'getOrElse');
        final defaultValue = D4.getRequiredArg<dynamic>(positional, 0, 'defaultValue', 'getOrElse');
        return t.getOrElse(defaultValue);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_5.Maybe>(target, 'Maybe');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "f" at position 0');
        }
        final fRaw = positional[0];
<<<<<<< Updated upstream
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor, fRaw, [p0]) as dynamic; });
=======
        return t.map((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, fRaw, [p0])); });
>>>>>>> Stashed changes
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
    nativeType: Result,
    name: 'Result',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Result,
>>>>>>> Stashed changes
    constructors: {
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Result');
        return Result.success(value);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final error = D4.getRequiredArg<dynamic>(positional, 0, 'error', 'Result');
        return Result.failure(error);
      },
    },
    getters: {
      'isSuccess': (visitor, target) => D4.validateTarget<Result>(target, 'Result').isSuccess,
    },
    methods: {
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Result>(target, 'Result');
        D4.requireMinArgs(positional, 2, 'fold');
        if (positional.isEmpty) {
          throw ArgumentError('fold: Missing required argument "onSuccess" at position 0');
        }
        final onSuccessRaw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "onFailure" at position 1');
        }
        final onFailureRaw = positional[1];
<<<<<<< Updated upstream
        return t.fold((dynamic p0) { return D4.callInterpreterCallback(visitor, onSuccessRaw, [p0]) as dynamic; }, (dynamic p0) { return D4.callInterpreterCallback(visitor, onFailureRaw, [p0]) as dynamic; });
=======
        return t.fold((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, onSuccessRaw, [p0])); }, (dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, onFailureRaw, [p0])); });
>>>>>>> Stashed changes
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
    nativeType: LoggableMixin,
    name: 'LoggableMixin',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LoggableMixin,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'severity': (visitor, target) => D4.validateTarget<LoggableMixin>(target, 'LoggableMixin').severity,
    },
    methods: {
      'shouldLog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LoggableMixin>(target, 'LoggableMixin');
        D4.requireMinArgs(positional, 1, 'shouldLog');
        final minLevel = D4.getRequiredArg<$dart_overview_4.LogLevel>(positional, 0, 'minLevel', 'shouldLog');
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
    nativeType: Vehicle,
    name: 'Vehicle',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Vehicle,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Vehicle>(target, 'Vehicle');
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
    nativeType: Car,
    name: 'Car',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Car,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Car();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Car>(target, 'Car');
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
    nativeType: Motorcycle,
    name: 'Motorcycle',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Motorcycle,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Motorcycle();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Motorcycle>(target, 'Motorcycle');
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
    nativeType: BaseAnimal,
    name: 'BaseAnimal',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is BaseAnimal,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BaseAnimal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'BaseAnimal');
        return BaseAnimal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<BaseAnimal>(target, 'BaseAnimal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<BaseAnimal>(target, 'BaseAnimal');
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
    nativeType: DogAnimal,
    name: 'DogAnimal',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is DogAnimal,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DogAnimal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DogAnimal');
        return DogAnimal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<DogAnimal>(target, 'DogAnimal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DogAnimal>(target, 'DogAnimal');
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
    nativeType: DataSource,
    name: 'DataSource',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is DataSource,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return DataSource();
      },
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DataSource>(target, 'DataSource');
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
    nativeType: JsonDataSource,
    name: 'JsonDataSource',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is JsonDataSource,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return JsonDataSource();
      },
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<JsonDataSource>(target, 'JsonDataSource');
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
    nativeType: XmlDataSource,
    name: 'XmlDataSource',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is XmlDataSource,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return XmlDataSource();
      },
    },
    methods: {
      'fetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<XmlDataSource>(target, 'XmlDataSource');
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
    nativeType: AppConfig,
    name: 'AppConfig',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is AppConfig,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AppConfig');
        final environment = D4.getRequiredArg<String>(positional, 0, 'environment', 'AppConfig');
        final debug = D4.getRequiredArg<bool>(positional, 1, 'debug', 'AppConfig');
        return AppConfig(environment, debug);
      },
    },
    getters: {
      'environment': (visitor, target) => D4.validateTarget<AppConfig>(target, 'AppConfig').environment,
      'debug': (visitor, target) => D4.validateTarget<AppConfig>(target, 'AppConfig').debug,
    },
    methods: {
      'getSetting': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AppConfig>(target, 'AppConfig');
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
    nativeType: $aux_dart_overview_2.SealedShape,
    name: 'SealedShape',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $aux_dart_overview_2.SealedShape,
>>>>>>> Stashed changes
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
    nativeType: SealedCircle,
    name: 'SealedCircle',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SealedCircle,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SealedCircle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'SealedCircle');
        return SealedCircle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<SealedCircle>(target, 'SealedCircle').radius,
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
    nativeType: SealedSquare,
    name: 'SealedSquare',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SealedSquare,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SealedSquare');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'SealedSquare');
        return SealedSquare(side);
      },
    },
    getters: {
      'side': (visitor, target) => D4.validateTarget<SealedSquare>(target, 'SealedSquare').side,
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
    nativeType: SealedTriangle,
    name: 'SealedTriangle',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SealedTriangle,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SealedTriangle');
        final base = D4.getRequiredArg<double>(positional, 0, 'base', 'SealedTriangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'SealedTriangle');
        return SealedTriangle(base, height);
      },
    },
    getters: {
      'base': (visitor, target) => D4.validateTarget<SealedTriangle>(target, 'SealedTriangle').base,
      'height': (visitor, target) => D4.validateTarget<SealedTriangle>(target, 'SealedTriangle').height,
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
    nativeType: LoggerMixin,
    name: 'LoggerMixin',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LoggerMixin,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return LoggerMixin();
      },
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LoggerMixin>(target, 'LoggerMixin');
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
    nativeType: LoggingService,
    name: 'LoggingService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LoggingService,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return LoggingService();
      },
    },
    methods: {
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LoggingService>(target, 'LoggingService');
        t.performAction();
        return null;
      },
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LoggingService>(target, 'LoggingService');
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
    nativeType: AbstractBaseClass,
    name: 'AbstractBaseClass',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is AbstractBaseClass,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'doSomething': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AbstractBaseClass>(target, 'AbstractBaseClass');
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
    nativeType: DerivedFromAbstractBase,
    name: 'DerivedFromAbstractBase',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is DerivedFromAbstractBase,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return DerivedFromAbstractBase();
      },
    },
    methods: {
      'doSomething': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DerivedFromAbstractBase>(target, 'DerivedFromAbstractBase');
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
    nativeType: ApiClient,
    name: 'ApiClient',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ApiClient,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ApiClient>(target, 'ApiClient');
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
    nativeType: RestApiClient,
    name: 'RestApiClient',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is RestApiClient,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return RestApiClient();
      },
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RestApiClient>(target, 'RestApiClient');
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
    nativeType: GraphqlApiClient,
    name: 'GraphqlApiClient',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is GraphqlApiClient,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return GraphqlApiClient();
      },
    },
    methods: {
      'request': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GraphqlApiClient>(target, 'GraphqlApiClient');
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
    nativeType: AbstractFinalClass,
    name: 'AbstractFinalClass',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is AbstractFinalClass,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<AbstractFinalClass>(target, 'AbstractFinalClass').value,
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
    nativeType: SingletonHolder,
    name: 'SingletonHolder',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SingletonHolder,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<SingletonHolder>(target, 'SingletonHolder').value,
    },
    staticGetters: {
      'instance': (visitor) => SingletonHolder.instance,
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
    nativeType: SimplePoint,
    name: 'SimplePoint',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SimplePoint,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return SimplePoint();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<SimplePoint>(target, 'SimplePoint').x,
      'y': (visitor, target) => D4.validateTarget<SimplePoint>(target, 'SimplePoint').y,
    },
    setters: {
      'x': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_2.SimplePoint>(target, 'SimplePoint').x = value as int,
      'y': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_2.SimplePoint>(target, 'SimplePoint').y = value as int,
=======
        D4.validateTarget<SimplePoint>(target, 'SimplePoint').x = D4.extractBridgedArg<int>(value, 'x'),
      'y': (visitor, target, value) => 
        D4.validateTarget<SimplePoint>(target, 'SimplePoint').y = D4.extractBridgedArg<int>(value, 'y'),
>>>>>>> Stashed changes
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
    nativeType: Point,
    name: 'Point',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Point,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Point');
        final x = D4.getRequiredArg<int>(positional, 0, 'x', 'Point');
        final y = D4.getRequiredArg<int>(positional, 1, 'y', 'Point');
        return Point(x, y);
      },
      'origin': (visitor, positional, named) {
        return Point.origin();
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Point');
        if (positional.isEmpty) {
          throw ArgumentError('Point: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return Point.fromJson(json);
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<Point>(target, 'Point').x,
      'y': (visitor, target) => D4.validateTarget<Point>(target, 'Point').y,
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
    nativeType: RectangleArea,
    name: 'RectangleArea',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is RectangleArea,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'RectangleArea');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'RectangleArea');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'RectangleArea');
        return RectangleArea(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<RectangleArea>(target, 'RectangleArea').width,
      'height': (visitor, target) => D4.validateTarget<RectangleArea>(target, 'RectangleArea').height,
      'area': (visitor, target) => D4.validateTarget<RectangleArea>(target, 'RectangleArea').area,
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
    nativeType: PositiveNumber,
    name: 'PositiveNumber',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is PositiveNumber,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PositiveNumber');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'PositiveNumber');
        return PositiveNumber(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<PositiveNumber>(target, 'PositiveNumber').value,
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
    nativeType: Vector,
    name: 'Vector',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Vector,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector');
        return Vector(x, y);
      },
      'zero': (visitor, positional, named) {
        return Vector.zero();
      },
      'unit': (visitor, positional, named) {
        return Vector.unit();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<Vector>(target, 'Vector').x,
      'y': (visitor, target) => D4.validateTarget<Vector>(target, 'Vector').y,
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
    nativeType: $dart_overview_1.Color,
    name: 'Color',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_1.Color,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Color');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'Color');
        final g = D4.getRequiredArg<int>(positional, 1, 'g', 'Color');
        final b = D4.getRequiredArg<int>(positional, 2, 'b', 'Color');
        return $dart_overview_1.Color(r, g, b);
      },
    },
    getters: {
      'r': (visitor, target) => D4.validateTarget<$dart_overview_1.Color>(target, 'Color').r,
      'g': (visitor, target) => D4.validateTarget<$dart_overview_1.Color>(target, 'Color').g,
      'b': (visitor, target) => D4.validateTarget<$dart_overview_1.Color>(target, 'Color').b,
    },
    staticGetters: {
      'red': (visitor) => $dart_overview_1.Color.red,
      'green': (visitor) => $dart_overview_1.Color.green,
      'blue': (visitor) => $dart_overview_1.Color.blue,
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
    nativeType: $dart_overview_1.Logger,
    name: 'Logger',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_1.Logger,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Logger');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Logger');
        return $dart_overview_1.Logger(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_1.Logger>(target, 'Logger').name,
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
    nativeType: CircleShape,
    name: 'CircleShape',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is CircleShape,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CircleShape');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'CircleShape');
        return CircleShape(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<CircleShape>(target, 'CircleShape').radius,
      'area': (visitor, target) => D4.validateTarget<CircleShape>(target, 'CircleShape').area,
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
    nativeType: SquareShape,
    name: 'SquareShape',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SquareShape,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SquareShape');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'SquareShape');
        return SquareShape(side);
      },
    },
    getters: {
      'side': (visitor, target) => D4.validateTarget<SquareShape>(target, 'SquareShape').side,
      'area': (visitor, target) => D4.validateTarget<SquareShape>(target, 'SquareShape').area,
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
    nativeType: $dart_overview_1.Database,
    name: 'Database',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_1.Database,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_1.Database>(target, 'Database').name,
    },
    staticGetters: {
      'instance': (visitor) => $dart_overview_1.Database.instance,
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
    nativeType: PersonBase,
    name: 'PersonBase',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is PersonBase,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PersonBase');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PersonBase');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'PersonBase');
        return PersonBase(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<PersonBase>(target, 'PersonBase').name,
      'age': (visitor, target) => D4.validateTarget<PersonBase>(target, 'PersonBase').age,
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
    nativeType: Employee,
    name: 'Employee',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Employee,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Employee');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Employee');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Employee');
        final department = D4.getRequiredArg<String>(positional, 2, 'department', 'Employee');
        return Employee(name, age, department);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Employee>(target, 'Employee').name,
      'age': (visitor, target) => D4.validateTarget<Employee>(target, 'Employee').age,
      'department': (visitor, target) => D4.validateTarget<Employee>(target, 'Employee').department,
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
    nativeType: Manager,
    name: 'Manager',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Manager,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Manager');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Manager');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Manager');
        final department = D4.getRequiredArg<String>(positional, 2, 'department', 'Manager');
        final teamSize = D4.getRequiredArg<int>(positional, 3, 'teamSize', 'Manager');
        return Manager(name, age, department, teamSize);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Manager>(target, 'Manager').name,
      'age': (visitor, target) => D4.validateTarget<Manager>(target, 'Manager').age,
      'teamSize': (visitor, target) => D4.validateTarget<Manager>(target, 'Manager').teamSize,
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
    nativeType: $dart_overview_6.Animal,
    name: 'Animal',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_6.Animal,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animal');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Animal');
        return $dart_overview_6.Animal(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_6.Animal>(target, 'Animal').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Animal>(target, 'Animal');
        t.eat();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.Animal>(target, 'Animal');
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
    nativeType: Cat,
    name: 'Cat',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Cat,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Cat');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Cat');
        return Cat(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Cat>(target, 'Cat').name,
    },
    methods: {
      'eat': (visitor, target, positional, named, typeArgs) {
<<<<<<< Updated upstream
        final t = D4.validateTarget<$dart_overview_4.Cat>(target, 'Cat');
=======
        final t = D4.validateTarget<Cat>(target, 'Cat');
>>>>>>> Stashed changes
        t.eat();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Cat>(target, 'Cat');
        return t.speak();
      },
      'meow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Cat>(target, 'Cat');
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
    nativeType: $aux_dart_overview_3.NotificationService,
    name: 'NotificationService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $aux_dart_overview_3.NotificationService,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_dart_overview_3.NotificationService>(target, 'NotificationService');
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
    nativeType: EmailNotificationService,
    name: 'EmailNotificationService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is EmailNotificationService,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return EmailNotificationService();
      },
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EmailNotificationService>(target, 'EmailNotificationService');
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
    nativeType: SmsNotificationService,
    name: 'SmsNotificationService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SmsNotificationService,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return SmsNotificationService();
      },
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SmsNotificationService>(target, 'SmsNotificationService');
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
    nativeType: Switchable,
    name: 'Switchable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Switchable,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'turnOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Switchable>(target, 'Switchable');
        t.turnOn();
        return null;
      },
      'turnOff': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Switchable>(target, 'Switchable');
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
    nativeType: TemperatureControl,
    name: 'TemperatureControl',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is TemperatureControl,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'setTemperature': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TemperatureControl>(target, 'TemperatureControl');
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
    nativeType: Connectable,
    name: 'Connectable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Connectable,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Connectable>(target, 'Connectable');
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
    nativeType: SmartThermostat,
    name: 'SmartThermostat',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SmartThermostat,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return SmartThermostat();
      },
    },
    methods: {
      'turnOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SmartThermostat>(target, 'SmartThermostat');
        t.turnOn();
        return null;
      },
      'turnOff': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SmartThermostat>(target, 'SmartThermostat');
        t.turnOff();
        return null;
      },
      'setTemperature': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SmartThermostat>(target, 'SmartThermostat');
        D4.requireMinArgs(positional, 1, 'setTemperature');
        final temp = D4.getRequiredArg<int>(positional, 0, 'temp', 'setTemperature');
        t.setTemperature(temp);
        return null;
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SmartThermostat>(target, 'SmartThermostat');
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
    nativeType: Machine,
    name: 'Machine',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Machine,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Machine>(target, 'Machine');
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
    nativeType: Speakable,
    name: 'Speakable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Speakable,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Speakable>(target, 'Speakable');
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
    nativeType: Robot,
    name: 'Robot',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Robot,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Robot();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Robot>(target, 'Robot');
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
    nativeType: AdvancedRobot,
    name: 'AdvancedRobot',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is AdvancedRobot,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return AdvancedRobot();
      },
    },
    methods: {
      'move': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AdvancedRobot>(target, 'AdvancedRobot');
        t.move();
        return null;
      },
      'speak': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AdvancedRobot>(target, 'AdvancedRobot');
        t.speak();
        return null;
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AdvancedRobot>(target, 'AdvancedRobot');
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
    nativeType: MathUtils,
    name: 'MathUtils',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is MathUtils,
>>>>>>> Stashed changes
    constructors: {
    },
    staticGetters: {
      'pi': (visitor) => MathUtils.pi,
      'e': (visitor) => MathUtils.e,
    },
    staticMethods: {
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'square');
        return MathUtils.square(n);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'cube');
        return MathUtils.cube(n);
      },
      'isEven': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEven');
        final n = D4.getRequiredArg<int>(positional, 0, 'n', 'isEven');
        return MathUtils.isEven(n);
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
    nativeType: Counter,
    name: 'Counter',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Counter,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Counter();
      },
    },
    staticGetters: {
      'instanceCount': (visitor) => Counter.instanceCount,
      'label': (visitor) => Counter.label,
    },
    staticSetters: {
      'instanceCount': (visitor, value) => 
<<<<<<< Updated upstream
        $dart_overview_5.Counter.instanceCount = value as int,
      'label': (visitor, value) => 
        $dart_overview_5.Counter.label = value as dynamic,
=======
        Counter.instanceCount = D4.extractBridgedArg<int>(value, 'instanceCount'),
      'label': (visitor, value) => 
        Counter.label = D4.extractBridgedArg<String>(value, 'label'),
>>>>>>> Stashed changes
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
    nativeType: FlexibleObject,
    name: 'FlexibleObject',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is FlexibleObject,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return FlexibleObject();
      },
    },
    methods: {
      'noSuchMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlexibleObject>(target, 'FlexibleObject');
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
    nativeType: $dart_overview_2.SortablePerson,
    name: 'SortablePerson',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_2.SortablePerson,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SortablePerson');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'SortablePerson');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'SortablePerson');
        return $dart_overview_2.SortablePerson(name, age);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_overview_2.SortablePerson>(target, 'SortablePerson').name,
      'age': (visitor, target) => D4.validateTarget<$dart_overview_2.SortablePerson>(target, 'SortablePerson').age,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_2.SortablePerson>(target, 'SortablePerson');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dart_overview_2.SortablePerson>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_2.SortablePerson>(target, 'SortablePerson');
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
    nativeType: $dart_overview_3.NumberWrapper,
    name: 'NumberWrapper',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_3.NumberWrapper,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NumberWrapper');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'NumberWrapper');
        return $dart_overview_3.NumberWrapper(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper').value,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_3.NumberWrapper>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$dart_overview_3.NumberWrapper>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_3.NumberWrapper>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_3.NumberWrapper>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_3.NumberWrapper>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
        final other = D4.getRequiredArg<$dart_overview_3.NumberWrapper>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.NumberWrapper>(target, 'NumberWrapper');
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
    nativeType: $dart_overview_3.BitFlags,
    name: 'BitFlags',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_3.BitFlags,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BitFlags');
        final bits = D4.getRequiredArg<int>(positional, 0, 'bits', 'BitFlags');
        return $dart_overview_3.BitFlags(bits);
      },
    },
    getters: {
      'bits': (visitor, target) => D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags').bits,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags').hashCode,
    },
    methods: {
      'hasFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        D4.requireMinArgs(positional, 1, 'hasFlag');
        final flag = D4.getRequiredArg<int>(positional, 0, 'flag', 'hasFlag');
        return t.hasFlag(flag);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        return t.toString();
      },
      '&': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<$dart_overview_3.BitFlags>(positional, 0, 'other', 'operator&');
        return t & other;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<$dart_overview_3.BitFlags>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '^': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<$dart_overview_3.BitFlags>(positional, 0, 'other', 'operator^');
        return t ^ other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        return ~t;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_3.BitFlags>(target, 'BitFlags');
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
    nativeType: NullableFields,
    name: 'NullableFields',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is NullableFields,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final age = D4.getOptionalNamedArg<int?>(named, 'age');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        return NullableFields(name: name, age: age, tags: tags);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<NullableFields>(target, 'NullableFields').name,
      'age': (visitor, target) => D4.validateTarget<NullableFields>(target, 'NullableFields').age,
      'tags': (visitor, target) => D4.validateTarget<NullableFields>(target, 'NullableFields').tags,
    },
    setters: {
      'name': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').name = value as String?,
      'age': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.NullableFields>(target, 'NullableFields').age = value as int?,
=======
        D4.validateTarget<NullableFields>(target, 'NullableFields').name = D4.extractBridgedArgOrNull<String>(value, 'name'),
      'age': (visitor, target, value) => 
        D4.validateTarget<NullableFields>(target, 'NullableFields').age = D4.extractBridgedArgOrNull<int>(value, 'age'),
>>>>>>> Stashed changes
      'tags': (visitor, target, value) => 
        D4.validateTarget<NullableFields>(target, 'NullableFields').tags = value == null ? null : (value as List).cast<String>().toList(),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<NullableFields>(target, 'NullableFields');
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
    nativeType: LateFieldDemo,
    name: 'LateFieldDemo',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is LateFieldDemo,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return LateFieldDemo();
      },
      'withValues': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'LateFieldDemo');
        final config = D4.getRequiredArg<String>(positional, 0, 'config', 'LateFieldDemo');
        final id = D4.getRequiredArg<int>(positional, 1, 'id', 'LateFieldDemo');
        return LateFieldDemo.withValues(config, id);
      },
    },
    getters: {
      'config': (visitor, target) => D4.validateTarget<LateFieldDemo>(target, 'LateFieldDemo').config,
      'id': (visitor, target) => D4.validateTarget<LateFieldDemo>(target, 'LateFieldDemo').id,
    },
    setters: {
      'config': (visitor, target, value) => 
<<<<<<< Updated upstream
        D4.validateTarget<$dart_overview_6.LateFieldDemo>(target, 'LateFieldDemo').config = value as String,
      'id': (visitor, target, value) => 
        D4.validateTarget<$dart_overview_6.LateFieldDemo>(target, 'LateFieldDemo').id = value as int,
=======
        D4.validateTarget<LateFieldDemo>(target, 'LateFieldDemo').config = D4.extractBridgedArg<String>(value, 'config'),
      'id': (visitor, target, value) => 
        D4.validateTarget<LateFieldDemo>(target, 'LateFieldDemo').id = D4.extractBridgedArg<int>(value, 'id'),
>>>>>>> Stashed changes
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
    nativeType: Multiplier,
    name: 'Multiplier',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Multiplier,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Multiplier');
        final factor = D4.getRequiredArg<int>(positional, 0, 'factor', 'Multiplier');
        return Multiplier(factor);
      },
    },
    getters: {
      'factor': (visitor, target) => D4.validateTarget<Multiplier>(target, 'Multiplier').factor,
    },
    methods: {
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Multiplier>(target, 'Multiplier');
        D4.requireMinArgs(positional, 1, 'call');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'call');
        return t.call(value);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Multiplier>(target, 'Multiplier');
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
    nativeType: Printable,
    name: 'Printable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Printable,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Printable();
      },
    },
    methods: {
      'printInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Printable>(target, 'Printable');
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
    nativeType: Serializable,
    name: 'Serializable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Serializable,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'serialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Serializable>(target, 'Serializable');
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
    nativeType: SerializablePrintable,
    name: 'SerializablePrintable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is SerializablePrintable,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return SerializablePrintable();
      },
    },
    methods: {
      'printInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SerializablePrintable>(target, 'SerializablePrintable');
        t.printInfo();
        return null;
      },
      'serialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SerializablePrintable>(target, 'SerializablePrintable');
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
    nativeType: Trackable,
    name: 'Trackable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Trackable,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'trackCount': (visitor, target) => D4.validateTarget<Trackable>(target, 'Trackable').trackCount,
    },
    methods: {
      'track': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Trackable>(target, 'Trackable');
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
    nativeType: TrackedItem,
    name: 'TrackedItem',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is TrackedItem,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TrackedItem');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TrackedItem');
        return TrackedItem(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<TrackedItem>(target, 'TrackedItem').name,
      'trackCount': (visitor, target) => D4.validateTarget<TrackedItem>(target, 'TrackedItem').trackCount,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrackedItem>(target, 'TrackedItem');
        return t.toString();
      },
      'track': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrackedItem>(target, 'TrackedItem');
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
    nativeType: DataProcessor,
    name: 'DataProcessor',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is DataProcessor,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DataProcessor');
        final prefix = D4.getRequiredArg<String>(positional, 0, 'prefix', 'DataProcessor');
        return DataProcessor(prefix);
      },
    },
    getters: {
      'prefix': (visitor, target) => D4.validateTarget<DataProcessor>(target, 'DataProcessor').prefix,
    },
    methods: {
      'processAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DataProcessor>(target, 'DataProcessor');
        D4.requireMinArgs(positional, 1, 'processAsync');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'processAsync');
        return t.processAsync(input);
      },
      'generateRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DataProcessor>(target, 'DataProcessor');
        D4.requireMinArgs(positional, 2, 'generateRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'generateRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'generateRange');
        return t.generateRange(start, end);
      },
      'streamItems': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<DataProcessor>(target, 'DataProcessor');
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
        return DataProcessor.staticRange(count);
      },
      'staticCountdown': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'staticCountdown');
        final from = D4.getRequiredArg<int>(positional, 0, 'from', 'staticCountdown');
        return DataProcessor.staticCountdown(from);
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
    nativeType: Statistics,
    name: 'Statistics',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Statistics,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Statistics');
        if (positional.isEmpty) {
          throw ArgumentError('Statistics: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<num>(positional[0], 'values');
        return Statistics(values);
      },
    },
    getters: {
      'values': (visitor, target) => D4.validateTarget<Statistics>(target, 'Statistics').values,
      'min': (visitor, target) => D4.validateTarget<Statistics>(target, 'Statistics').min,
      'max': (visitor, target) => D4.validateTarget<Statistics>(target, 'Statistics').max,
      'average': (visitor, target) => D4.validateTarget<Statistics>(target, 'Statistics').average,
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
// Musical Bridge
// =============================================================================

BridgedClass _createMusicalBridge() {
  return BridgedClass(
    nativeType: Musical,
    name: 'Musical',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Musical,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Musical>(target, 'Musical');
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
    nativeType: Dancing,
    name: 'Dancing',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Dancing,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dancing>(target, 'Dancing');
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
    nativeType: Musician,
    name: 'Musician',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Musician,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Musician');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Musician');
        return Musician(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Musician>(target, 'Musician').name,
    },
    methods: {
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Musician>(target, 'Musician');
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
    nativeType: ProfessionalDancer,
    name: 'ProfessionalDancer',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ProfessionalDancer,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProfessionalDancer');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ProfessionalDancer');
        return ProfessionalDancer(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<ProfessionalDancer>(target, 'ProfessionalDancer').name,
    },
    methods: {
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProfessionalDancer>(target, 'ProfessionalDancer');
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
    nativeType: Entertainer,
    name: 'Entertainer',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Entertainer,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Entertainer');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Entertainer');
        return Entertainer(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Entertainer>(target, 'Entertainer').name,
    },
    methods: {
      'perform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Entertainer>(target, 'Entertainer');
        t.perform();
        return null;
      },
      'playInstrument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Entertainer>(target, 'Entertainer');
        t.playInstrument();
        return null;
      },
      'dance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Entertainer>(target, 'Entertainer');
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
    nativeType: CountableItem,
    name: 'CountableItem',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is CountableItem,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return CountableItem();
      },
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<CountableItem>(target, 'CountableItem').count,
    },
    methods: {
      'increment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CountableItem>(target, 'CountableItem');
        t.increment();
        return null;
      },
      'decrement': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CountableItem>(target, 'CountableItem');
        t.decrement();
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CountableItem>(target, 'CountableItem');
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
// Logging Bridge
// =============================================================================

BridgedClass _createLoggingBridge() {
  return BridgedClass(
    nativeType: Logging,
    name: 'Logging',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Logging,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Logging>(target, 'Logging');
        D4.requireMinArgs(positional, 2, 'log');
        final level = D4.getRequiredArg<String>(positional, 0, 'level', 'log');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'log');
        t.log(level, message);
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Logging>(target, 'Logging');
        D4.requireMinArgs(positional, 1, 'info');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'info');
        t.info(message);
        return null;
      },
      'warning': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Logging>(target, 'Logging');
        D4.requireMinArgs(positional, 1, 'warning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'warning');
        t.warning(message);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Logging>(target, 'Logging');
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
    nativeType: ConsoleLogger,
    name: 'ConsoleLogger',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ConsoleLogger,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return ConsoleLogger();
      },
    },
    methods: {
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 2, 'log');
        final level = D4.getRequiredArg<String>(positional, 0, 'level', 'log');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'log');
        t.log(level, message);
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'info');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'info');
        t.info(message);
        return null;
      },
      'warning': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConsoleLogger>(target, 'ConsoleLogger');
        D4.requireMinArgs(positional, 1, 'warning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'warning');
        t.warning(message);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConsoleLogger>(target, 'ConsoleLogger');
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
    nativeType: Greeter1,
    name: 'Greeter1',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Greeter1,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Greeter1>(target, 'Greeter1');
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
    nativeType: Greeter2,
    name: 'Greeter2',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Greeter2,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Greeter2>(target, 'Greeter2');
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
    nativeType: MultiMixed,
    name: 'MultiMixed',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is MultiMixed,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return MultiMixed();
      },
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<MultiMixed>(target, 'MultiMixed');
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
    nativeType: Helper,
    name: 'Helper',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Helper,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return Helper();
      },
    },
    methods: {
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Helper>(target, 'Helper');
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
    nativeType: HelpfulService,
    name: 'HelpfulService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is HelpfulService,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return HelpfulService();
      },
    },
    methods: {
      'serve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HelpfulService>(target, 'HelpfulService');
        t.serve();
        return null;
      },
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<HelpfulService>(target, 'HelpfulService');
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
    nativeType: EventEmitter,
    name: 'EventEmitter',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is EventEmitter,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((String p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((String p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<EventEmitter>(target, 'EventEmitter');
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
    nativeType: Button,
    name: 'Button',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is Button,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Button');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'Button');
        return Button(label);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<Button>(target, 'Button').label,
    },
    methods: {
      'click': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Button>(target, 'Button');
        t.click();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener((String p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Button>(target, 'Button');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener((String p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Button>(target, 'Button');
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
    nativeType: ComparableMixin,
    name: 'ComparableMixin',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is ComparableMixin,
>>>>>>> Stashed changes
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<ComparableMixin>(target, 'ComparableMixin').value,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ComparableMixin>(target, 'ComparableMixin');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dart_overview_6.SortableItem>(positional, 0, 'other', 'compareTo');
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
    nativeType: $dart_overview_6.SortableItem,
    name: 'SortableItem',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $dart_overview_6.SortableItem,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SortableItem');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'SortableItem');
        return $dart_overview_6.SortableItem(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$dart_overview_6.SortableItem>(target, 'SortableItem').value,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_overview_6.SortableItem>(target, 'SortableItem');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dart_overview_6.SortableItem>(positional, 0, 'other', 'compareTo');
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
    nativeType: JsonSerializable,
    name: 'JsonSerializable',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is JsonSerializable,
>>>>>>> Stashed changes
    constructors: {
    },
    methods: {
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<JsonSerializable>(target, 'JsonSerializable');
        return t.toJsonMap();
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<JsonSerializable>(target, 'JsonSerializable');
        return t.toJson();
      },
    },
    methodSignatures: {
      'toJsonMap': 'Map<String, dynamic> toJsonMap()',
      'toJson': 'String toJson()',
    },
  );
}

