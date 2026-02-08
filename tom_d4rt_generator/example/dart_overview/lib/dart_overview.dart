/// Dart Language Overview Library
///
/// Exports the main demonstration runner and selected sub-modules.
library dart_overview;

// Main runner
export 'run_dart_overview.dart';

// ── Core declarations (classes, generics, enums) ──────────────────
export 'classes/declarations/run_declarations.dart' hide main;
export 'generics/generic_classes/run_generic_classes.dart' hide main;
export 'enums/basics/run_basics.dart' hide main;

// ── Class modifiers (abstract, sealed, base, interface, final, mixin class) ──
export 'class_modifiers/modifiers/run_modifiers.dart' show
    Vehicle, Car, Motorcycle,
    BaseAnimal, DogAnimal,
    DataSource, JsonDataSource, XmlDataSource,
    AppConfig,
    SealedShape, SealedCircle, SealedSquare, SealedTriangle,
    LoggerMixin, LoggingService,
    AbstractBaseClass, DerivedFromAbstractBase,
    ApiClient, RestApiClient, GraphqlApiClient,
    AbstractFinalClass, SingletonHolder;

// ── Constructors (named, factory, const, redirecting, private, super params) ──
export 'classes/constructors/run_constructors.dart' show
    SimplePoint, Point, RectangleArea, PositiveNumber, Vector, Color,
    Logger, CircleShape, SquareShape, Database, PersonBase, Employee, Manager;

// ── Inheritance (extends, implements, multi-level, method override) ──
export 'classes/inheritance/run_inheritance.dart' show
    Animal, Cat,
    NotificationService, EmailNotificationService, SmsNotificationService,
    Switchable, TemperatureControl, Connectable, SmartThermostat,
    Machine, Speakable, Robot, AdvancedRobot;

// ── Static methods and object methods ──
export 'classes/static_object_methods/run_static_object_methods.dart' show
    MathUtils, Counter, FlexibleObject, SortablePerson;

// ── Top-level functions ──
export 'functions/declarations/run_declarations.dart' show
    multiply, printSeparator, square, cube, isEven, getNumbers, createUser,
    inferredReturn, dynamicReturn;

// ── Function parameter styles ──
export 'functions/parameters/run_parameters.dart' show
    describe, sayHello, power, makeRequest, processOrder,
    transform, fetchData;

// ── Globals (variables, getters, setters) ──
export 'globals/basics/run_basics.dart' show
    globalCounter, appName, maxRetries, currentUser, lastProcessedId,
    appStartTime, sessionId, apiUrl, maxConnections, defaultTimeout,
    validStatuses, priorities, reservedIds, lazyConfig,
    log, firstOrNull, now, connectionCount, cachedValue;

// ── Mixins ──
export 'mixins/basics/run_basics.dart' show
    Musical, Dancing, Logging,
    Greeter1, Greeter2, EventEmitter, ComparableMixin, JsonSerializable,
    Helper, Musician, ProfessionalDancer, Entertainer, CountableItem,
    ConsoleLogger, MultiMixed, HelpfulService,
    Button, SortableItem;
