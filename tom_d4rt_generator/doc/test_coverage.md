# D4rt Bridge Generator — Test Coverage

This document tracks bridge generator features and the tests that verify them. It serves as a living inventory to identify coverage gaps and guide future test development.

**Test infrastructure:** See `_copilot_guidelines/testing_d4rt_bridges.md` for the D4rtTester architecture and test conventions.

**Test file:** `test/d4rt_tester_test.dart` — end-to-end tests using D4rtTester.

---

## Overview Table

Each row represents a bridge generator feature. The **Status** column indicates:

- ✅ — Tested and passing
- ⚠️ — Tested but failing (known bug, see issue ID)
- ❌ — Not yet tested (no example project exercises this feature)
- 🔲 — Not yet relevant (D4rt interpreter support may be needed first)

### Top-Level Exportables

| # | Feature | Status | Test Project | Issue | [Details](#1-top-level-exportables) |
|---|---------|--------|--------------|-------|---------|
| 1.1 | Class (concrete) | ✅ | example_project, user_guide, user_reference, dart_overview, userbridge_user_guide | | [→](#11-class-concrete) |
| 1.2 | Abstract class | ❌ | — | | [→](#12-abstract-class) |
| 1.3 | Sealed class | ❌ | — | | [→](#13-sealed-class) |
| 1.4 | Base class | ❌ | — | | [→](#14-base-class) |
| 1.5 | Interface class | ❌ | — | | [→](#15-interface-class) |
| 1.6 | Final class | ❌ | — | | [→](#16-final-class) |
| 1.7 | Mixin class | ❌ | — | | [→](#17-mixin-class) |
| 1.8 | Simple enum | ✅ | example_project, dart_overview | | [→](#18-simple-enum) |
| 1.9 | Enhanced enum (fields) | ⚠️ | example_project, dart_overview | GEN-041 | [→](#19-enhanced-enum-fields) |
| 1.10 | Enhanced enum (methods) | ⚠️ | dart_overview | GEN-041 | [→](#110-enhanced-enum-methods) |
| 1.11 | Enhanced enum (implements) | ⚠️ | dart_overview | GEN-041 | [→](#111-enhanced-enum-implements) |
| 1.12 | Enhanced enum (with mixin) | ⚠️ | dart_overview | GEN-041 | [→](#112-enhanced-enum-with-mixin) |
| 1.13 | Generic enum | ❌ | — | | [→](#113-generic-enum) |
| 1.14 | Mixin | ❌ | — | | [→](#114-mixin) |
| 1.15 | Base mixin | ❌ | — | | [→](#115-base-mixin) |
| 1.16 | Named extension | ❌ | — | | [→](#116-named-extension) |
| 1.17 | Anonymous extension | ❌ | — | | [→](#117-anonymous-extension) |
| 1.18 | Extension type | ❌ | — | | [→](#118-extension-type) |
| 1.19 | Typedef (function) | ❌ | — | | [→](#119-typedef-function) |
| 1.20 | Typedef (type alias) | ❌ | — | | [→](#120-typedef-type-alias) |
| 1.21 | Typedef (generic) | ❌ | — | | [→](#121-typedef-generic) |
| 1.22 | Top-level function | ✅ | userbridge_override | | [→](#122-top-level-function) |
| 1.23 | Top-level generic function | ❌ | — | | [→](#123-top-level-generic-function) |
| 1.24 | Top-level async function | ❌ | — | | [→](#124-top-level-async-function) |
| 1.25 | Top-level variable (var/final) | ✅ | userbridge_override | | [→](#125-top-level-variable) |
| 1.26 | Top-level const | ✅ | userbridge_override | | [→](#126-top-level-const) |
| 1.27 | Top-level getter | ❌ | — | | [→](#127-top-level-getter) |
| 1.28 | Top-level setter | ❌ | — | | [→](#128-top-level-setter) |
| 1.29 | Mixin application (`class = with`) | ❌ | — | | [→](#129-mixin-application) |

### Class Members

| # | Feature | Status | Test Project | Issue | [Details](#2-class-members) |
|---|---------|--------|--------------|-------|---------|
| 2.1 | Instance field (getter) | ✅ | example_project, user_guide, user_reference, dart_overview, userbridge_user_guide | | [→](#21-instance-field-getter) |
| 2.2 | Instance field (setter) | ⚠️ | dart_overview | GEN-042 | [→](#22-instance-field-setter) |
| 2.3 | Final field | ✅ | user_guide, userbridge_user_guide | | [→](#23-final-field) |
| 2.4 | Private field with public getter | ❌ | — | | [→](#24-private-field-with-public-getter) |
| 2.5 | Nullable field | ❌ | — | | [→](#25-nullable-field) |
| 2.6 | Late field | ❌ | — | | [→](#26-late-field) |
| 2.7 | Static field (mutable) | ❌ | — | | [→](#27-static-field-mutable) |
| 2.8 | Static const field | ✅ | example_project | | [→](#28-static-const-field) |
| 2.9 | Computed getter | ✅ | user_reference, dart_overview, userbridge_user_guide | | [→](#29-computed-getter) |
| 2.10 | Explicit setter (`set x`) | ❌ | — | | [→](#210-explicit-setter) |
| 2.11 | Static method | ✅ | example_project, user_guide, user_reference | | [→](#211-static-method) |
| 2.12 | Static getter | ❌ | — | | [→](#212-static-getter) |
| 2.13 | Static setter | ❌ | — | | [→](#213-static-setter) |
| 2.14 | Instance method | ✅ | all projects | | [→](#214-instance-method) |
| 2.15 | Abstract method | ❌ | — | | [→](#215-abstract-method) |
| 2.16 | `toString()` override | ✅ | userbridge_user_guide | | [→](#216-tostring-override) |
| 2.17 | `call()` method | ❌ | — | | [→](#217-call-method) |

### Constructors

| # | Feature | Status | Test Project | Issue | [Details](#3-constructors) |
|---|---------|--------|--------------|-------|---------|
| 3.1 | Unnamed (default, explicit) | ✅ | example_project, user_guide, dart_overview, userbridge_user_guide | | [→](#31-unnamed-constructor) |
| 3.2 | Implicit default (no ctor) | ⚠️ | dart_overview | GEN-042 | [→](#32-implicit-default-constructor) |
| 3.3 | Named constructor | ✅ | example_project, user_guide, userbridge_user_guide | | [→](#33-named-constructor) |
| 3.4 | Factory constructor | ❌ | — | | [→](#34-factory-constructor) |
| 3.5 | Const constructor | ❌ | — | | [→](#35-const-constructor) |
| 3.6 | Redirecting constructor | ❌ | — | | [→](#36-redirecting-constructor) |
| 3.7 | Private constructor | ❌ | — | | [→](#37-private-constructor) |
| 3.8 | Super parameters (`super.x`) | ❌ | — | | [→](#38-super-parameters) |

### Operators

| # | Feature | Status | Test Project | Issue | [Details](#4-operators) |
|---|---------|--------|--------------|-------|---------|
| 4.1 | `operator +` | ✅ | userbridge_user_guide (user bridge) | | [→](#41-operator-plus) |
| 4.2 | `operator -` (binary) | ✅ | userbridge_user_guide (user bridge) | | [→](#42-operator-minus-binary) |
| 4.3 | `operator -` (unary) | ✅ | userbridge_user_guide (user bridge) | | [→](#43-operator-minus-unary) |
| 4.4 | `operator *` | ✅ | userbridge_user_guide (user bridge) | | [→](#44-operator-multiply) |
| 4.5 | `operator /` | ❌ | — | | [→](#45-operator-divide) |
| 4.6 | `operator ~/` | ❌ | — | | [→](#46-operator-integer-divide) |
| 4.7 | `operator %` | ❌ | — | | [→](#47-operator-modulo) |
| 4.8 | `operator ==` | ❌ | — | | [→](#48-operator-equals) |
| 4.9 | `operator <` / `>` / `<=` / `>=` | ❌ | — | | [→](#49-comparison-operators) |
| 4.10 | `operator []` | ✅ | userbridge_user_guide (user bridge) | | [→](#410-operator-index) |
| 4.11 | `operator []=` | ✅ | userbridge_user_guide (user bridge) | | [→](#411-operator-index-assign) |
| 4.12 | Bitwise operators (`&`, `\|`, `^`, `~`, `<<`, `>>`, `>>>`) | ❌ | — | | [→](#412-bitwise-operators) |

### Parameters

| # | Feature | Status | Test Project | Issue | [Details](#5-parameters) |
|---|---------|--------|--------------|-------|---------|
| 5.1 | Required positional | ✅ | example_project, user_guide, dart_overview | | [→](#51-required-positional) |
| 5.2 | Optional positional | ✅ | example_project | | [→](#52-optional-positional) |
| 5.3 | Named parameters | ✅ | user_reference, userbridge_override | | [→](#53-named-parameters) |
| 5.4 | Required named (`required`) | ✅ | user_reference | | [→](#54-required-named) |
| 5.5 | Default values | ✅ | example_project, userbridge_override | | [→](#55-default-values) |
| 5.6 | Function-typed parameter | ❌ | — | | [→](#56-function-typed-parameter) |

### Generics

| # | Feature | Status | Test Project | Issue | [Details](#6-generics) |
|---|---------|--------|--------------|-------|---------|
| 6.1 | Generic class (single type param) | ✅ | dart_overview, userbridge_override | | [→](#61-generic-class-single) |
| 6.2 | Generic class (two type params) | ✅ | dart_overview | | [→](#62-generic-class-two-params) |
| 6.3 | Upper bound (`T extends X`) | ❌ | — | | [→](#63-upper-bound) |
| 6.4 | Generic method | ❌ | — | | [→](#64-generic-method) |
| 6.5 | Generic static factory | ❌ | — | | [→](#65-generic-static-factory) |
| 6.6 | F-bounded polymorphism | ❌ | — | | [→](#66-f-bounded-polymorphism) |

### Inheritance

| # | Feature | Status | Test Project | Issue | [Details](#7-inheritance) |
|---|---------|--------|--------------|-------|---------|
| 7.1 | Single inheritance (`extends`) | ❌ | — | | [→](#71-single-inheritance) |
| 7.2 | Interface implementation (`implements`) | ❌ | — | | [→](#72-interface-implementation) |
| 7.3 | Multiple `implements` | ❌ | — | | [→](#73-multiple-implements) |
| 7.4 | Mixin application (`with`) | ❌ | — | | [→](#74-mixin-application) |
| 7.5 | `covariant` parameter | ❌ | — | | [→](#75-covariant-parameter) |

### User Bridges

| # | Feature | Status | Test Project | Issue | [Details](#8-user-bridges) |
|---|---------|--------|--------------|-------|---------|
| 8.1 | User bridge operator override | ✅ | userbridge_user_guide, userbridge_override | | [→](#81-user-bridge-operator-override) |
| 8.2 | User bridge method override | ✅ | userbridge_user_guide | | [→](#82-user-bridge-method-override) |
| 8.3 | User bridge global override | ✅ | userbridge_override | | [→](#83-user-bridge-global-override) |
| 8.4 | User bridge constructor override | ❌ | — | | [→](#84-user-bridge-constructor-override) |
| 8.5 | User bridge getter override | ❌ | — | | [→](#85-user-bridge-getter-override) |
| 8.6 | User bridge import prefix (GEN-043 fix) | ✅ | userbridge_user_guide | GEN-043 (fixed) | [→](#86-user-bridge-import-prefix) |
| 8.7 | Print marker verification | ✅ | userbridge_user_guide | | [→](#87-print-marker-verification) |

### Async & Streams

| # | Feature | Status | Test Project | Issue | [Details](#9-async--streams) |
|---|---------|--------|--------------|-------|---------|
| 9.1 | Async method (`Future<T>`) | ❌ | — | | [→](#91-async-method) |
| 9.2 | Stream method (`Stream<T>`) | ❌ | — | | [→](#92-stream-method) |
| 9.3 | Sync generator (`Iterable<T>`) | ❌ | — | | [→](#93-sync-generator) |

### Special Types

| # | Feature | Status | Test Project | Issue | [Details](#10-special-types) |
|---|---------|--------|--------------|-------|---------|
| 10.1 | Return type `Map<String, dynamic>` | ✅ | user_reference | | [→](#101-return-type-map) |
| 10.2 | Parameter type `List<T>` | ✅ | userbridge_user_guide | | [→](#102-parameter-type-list) |
| 10.3 | Record types | ❌ | — | | [→](#103-record-types) |
| 10.4 | Function types as parameters | ❌ | — | | [→](#104-function-types-as-parameters) |
| 10.5 | `Iterable<T>` return | ❌ | — | | [→](#105-iterable-return) |

### Visibility & Exports

| # | Feature | Status | Test Project | Issue | [Details](#11-visibility--exports) |
|---|---------|--------|--------------|-------|---------|
| 11.1 | Public members | ✅ | all | | [→](#111-public-members) |
| 11.2 | Private members excluded | ✅ | (implicit) | | [→](#112-private-members-excluded) |
| 11.3 | Barrel file exports | ✅ | all | | [→](#113-barrel-file-exports) |
| 11.4 | `export show` / `export hide` | ❌ | — | | [→](#114-export-show--hide) |
| 11.5 | `part` / `part of` | ❌ | — | | [→](#115-part--part-of) |

---

## Detailed Feature Descriptions

### 1. Top-Level Exportables

#### 1.1 Class (concrete)

Standard Dart class with public API. The most fundamental bridging target.

**Tested in:** example_project (`Person`, `Calculator`, `MathUtils`), user_guide (`Calculator`, `Greeter`), user_reference (`User`, `Product`), dart_overview (`Dog`, `User`, `Rectangle`, `Circle`), userbridge_user_guide (`Vector2D`, `Matrix2x2`)

**What's verified:** Construction, field access, method invocation.

#### 1.2 Abstract class

`abstract class Name { }` — cannot be instantiated directly, serves as base type.

**Not tested.** Bridge generator must handle abstract classes by registering them without a default constructor callable, while still providing access to static members and serving as a type in the type system.

#### 1.3 Sealed class

`sealed class Shape { }` — abstract, subtypes exhaustive within same library.

**Not tested.** Bridge must register the sealed type and all its subtypes. Pattern matching exhaustiveness is an interpreter concern, but the generator must export all subtypes.

#### 1.4 Base class

`base class Name { }` — can be extended but not implemented outside its library.

**Not tested.** Modifier affects what D4rt scripts can do (extend vs implement), but the bridge generator's code generation should be the same as a regular class.

#### 1.5 Interface class

`interface class Name { }` — can be implemented but not extended outside its library.

**Not tested.** Similar to base class: the modifier restricts D4rt script usage patterns.

#### 1.6 Final class

`final class Name { }` — cannot be extended or implemented outside its library.

**Not tested.** The bridge should still allow construction and member access.

#### 1.7 Mixin class

`mixin class Name { }` — usable as both a class and a mixin.

**Not tested.** Bridge must register both as a class and make it usable with `with`.

#### 1.8 Simple enum

`enum Color { red, green, blue }` — basic enum with `.values`, `.index`, `.name`.

**Tested in:** example_project (`Status`), dart_overview (`Day`, `Priority`, `Role`)

**What's verified:** Value access (`Status.active`), `.name` getter, `.index` getter.

#### 1.9 Enhanced enum (fields)

Enhanced enum with data fields: `enum E { a(1); final int x; const E(this.x); }`

**Tested in:** example_project (`Priority`, `Color`, `HttpMethod`, `DayOfWeek`), dart_overview (`Season`, `HttpStatus`)

**Status:** ⚠️ **GEN-041** — Enhanced enum custom fields are not accessible through generated bridges.

#### 1.10 Enhanced enum (methods)

Enhanced enum with instance methods.

**Tested in:** dart_overview (`Operation.execute()`)

**Status:** ⚠️ **GEN-041** — Part of the enhanced enum field access issue.

#### 1.11 Enhanced enum (implements)

Enhanced enum implementing an interface: `enum E implements I { }`

**Tested in:** dart_overview (`Operation implements MathOperation`)

**Status:** ⚠️ **GEN-041**

#### 1.12 Enhanced enum (with mixin)

Enhanced enum using a mixin: `enum E with M { }`

**Tested in:** dart_overview (`LogLevel with Comparable`)

**Status:** ⚠️ **GEN-041**

#### 1.13 Generic enum

Type-parameterized enum values: `enum JsonType<T> { string<String>(); }`

**Not tested.** Advanced feature — may require D4rt interpreter support first.

#### 1.14 Mixin

`mixin Flyable on Animal { }` — standalone mixin declaration.

**Not tested.** Bridge must register mixin members and respect `on` constraints.

#### 1.15 Base mixin

`base mixin M { }` — mixin requiring inheritance chain.

**Not tested.**

#### 1.16 Named extension

`extension StringExt on String { }` — named extension adding members to existing types.

**Not tested.** Bridge generator must decide whether to register extension methods as additional methods on the target type or as standalone utilities.

#### 1.17 Anonymous extension

`extension on String { }` — unnamed extension.

**Not tested.** Cannot be import-controlled, so may have different bridging semantics.

#### 1.18 Extension type

`extension type UserId(int id) { }` — compile-time wrapper (Dart 3.3+).

**Not tested.** Zero-cost abstraction at compile time; at D4rt runtime, may need explicit representation handling.

#### 1.19 Typedef (function)

`typedef Callback = void Function(String);` — function type alias.

**Not tested.** Bridge generator must register the typedef so D4rt scripts can reference it as a type.

#### 1.20 Typedef (type alias)

`typedef JsonMap = Map<String, dynamic>;` — general type alias.

**Not tested.**

#### 1.21 Typedef (generic)

`typedef Mapper<T, R> = R Function(T);` — generic function type alias.

**Not tested.**

#### 1.22 Top-level function

Free functions at library level.

**Tested in:** userbridge_override (`greet()`, `calculate()`)

**What's verified:** Positional and named parameter passing, return values.

#### 1.23 Top-level generic function

`T first<T>(List<T> items) { }` — generic free function.

**Not tested.**

#### 1.24 Top-level async function

`Future<T> fetch() async { }` — async free function.

**Not tested.**

#### 1.25 Top-level variable

`var x = 1;` / `String name = 'App';` — mutable globals.

**Tested in:** userbridge_override

**What's verified:** Reading global variable values.

#### 1.26 Top-level const

`const pi = 3.14159;` — compile-time constant globals.

**Tested in:** userbridge_override (`appName`, `maxRetries`, `version`)

**What's verified:** Const value access from D4rt script.

#### 1.27 Top-level getter

`DateTime get now => DateTime.now();` — computed top-level property.

**Not tested.** Source exists in userbridge_override (`currentTime`) but not exercised by the test script.

#### 1.28 Top-level setter

`set logLevel(Level l) { }` — top-level write accessor.

**Not tested.**

#### 1.29 Mixin application

`class WalkingAnimal = Animal with Walker;` — named mixin application.

**Not tested.**

### 2. Class Members

#### 2.1 Instance field (getter)

Reading instance fields via generated getters.

**Tested in:** All projects — `person.name`, `v1.x`, `product.sku`, etc.

#### 2.2 Instance field (setter)

Writing to mutable instance fields.

**Tested in:** dart_overview — `person.name = 'Alice'`

**Status:** ⚠️ **GEN-042** — Setting fields on implicitly-constructed objects fails because the implicit default constructor isn't bridged.

#### 2.3 Final field

`final` fields accessible via getter but not settable.

**Tested in:** user_guide (`Greeter.greeting`), userbridge_user_guide (`Vector2D.x`, `Vector2D.y`)

#### 2.4 Private field with public getter

`int _balance;` with `int get balance => _balance;`

**Not tested.** `BankAccount` exists in dart_overview source but is not exercised.

#### 2.5 Nullable field

`String? name;` — nullable instance field.

**Not tested.**

#### 2.6 Late field

`late final x = compute();` — lazily initialized field.

**Not tested.**

#### 2.7 Static field (mutable)

`static int count = 0;` — mutable static field.

**Not tested.**

#### 2.8 Static const field

`static const pi = 3.14159;`

**Tested in:** example_project (`MathUtils.pi`)

#### 2.9 Computed getter

`Type get x => expression;`

**Tested in:** user_reference (`product.isInStock`, `product.formattedPrice`), dart_overview (`rect.area`, `circle.diameter`), userbridge_user_guide (`m.determinant`, `m.trace`)

#### 2.10 Explicit setter

`set scale(double value) { }` — explicit setter method.

**Not tested.** `Rectangle.scale` setter exists in dart_overview source but is not exercised.

#### 2.11 Static method

`static Type method() { }`

**Tested in:** example_project (`Calculator.format`, `MathUtils.circleArea`), user_guide (`Calculator.quickAdd`), user_reference (`Product.placeholder`)

#### 2.12 Static getter

`static Type get name => ...;`

**Not tested.**

#### 2.13 Static setter

`static set name(Type v) { }`

**Not tested.**

#### 2.14 Instance method

Regular instance methods with parameters and return values.

**Tested in:** All projects.

#### 2.15 Abstract method

`void method();` — method without body.

**Not tested.** Exists implicitly in abstract classes.

#### 2.16 toString() override

`@override String toString() => ...;`

**Tested in:** userbridge_user_guide (`v1.toString()`)

#### 2.17 call() method

`ReturnType call(args)` — makes class callable as function.

**Not tested.**

### 3. Constructors

#### 3.1 Unnamed constructor

`ClassName(params)` — explicit unnamed constructor.

**Tested in:** Multiple projects.

#### 3.2 Implicit default constructor

Classes with no explicit constructor definition.

**Tested in:** dart_overview (`Person()`, `Calculator()`)

**Status:** ⚠️ **GEN-042** — Bridge generator doesn't emit a constructor callable for classes with no explicit constructor.

#### 3.3 Named constructor

`ClassName.named(params)`

**Tested in:** example_project (`Person.guest()`), user_guide (`Greeter.defaultGreeting()`), userbridge_user_guide (`Vector2D.zero()`, `Matrix2x2.identity()`)

#### 3.4 Factory constructor

`factory ClassName() { return ...; }`

**Not tested.** `Person.fromString` and `User.fromMap` exist in source but are never called from test scripts.

#### 3.5 Const constructor

`const ClassName(this.x)` — compile-time constant construction.

**Not tested.**

#### 3.6 Redirecting constructor

`ClassName.a() : this()` — delegates to another constructor.

**Not tested.**

#### 3.7 Private constructor

`ClassName._()` — prevents external instantiation.

**Not tested.** `MathUtils._()` exists but private constructors shouldn't be bridged.

#### 3.8 Super parameters

`Child(super.name)` — forward params to parent constructor (Dart 2.17+).

**Not tested.**

### 4. Operators

#### 4.1 Operator plus

`T operator +(T other)`

**Tested in:** userbridge_user_guide — `v1 + v2` via user bridge.

#### 4.2 Operator minus (binary)

`T operator -(T other)`

**Tested in:** userbridge_user_guide — `v1 - v2` via user bridge.

#### 4.3 Operator minus (unary)

`T operator -()`

**Tested in:** userbridge_user_guide — `-v1` via user bridge.

#### 4.4 Operator multiply

`T operator *(T other)`

**Tested in:** userbridge_user_guide — `v1 * 2.0` via user bridge.

#### 4.5 Operator divide

`double operator /(T other)`

**Not tested.**

#### 4.6 Operator integer divide

`int operator ~/(T other)`

**Not tested.**

#### 4.7 Operator modulo

`T operator %(T other)`

**Not tested.**

#### 4.8 Operator equals

`bool operator ==(Object other)`

**Not tested.** `Vector2D` defines `==` but it's not tested from D4rt.

#### 4.9 Comparison operators

`<`, `>`, `<=`, `>=`

**Not tested.**

#### 4.10 Operator index

`T operator [](K key)`

**Tested in:** userbridge_user_guide — `m[[0, 1]]` via user bridge.

#### 4.11 Operator index assign

`void operator []=(K key, T value)`

**Tested in:** userbridge_user_guide — `m[[0, 1]] = 99.0` via user bridge.

#### 4.12 Bitwise operators

`&`, `|`, `^`, `~`, `<<`, `>>`, `>>>`

**Not tested.**

### 5. Parameters

#### 5.1 Required positional

`fn(Type a, Type b)`

**Tested in:** example_project, user_guide, dart_overview.

#### 5.2 Optional positional

`fn(a, [b, c = 0])`

**Tested in:** example_project (`calc.addOptional(10, 20)`)

#### 5.3 Named parameters

`fn({Type? a, b = 0})`

**Tested in:** user_reference (`User(id: 1, name: 'Alice')`), userbridge_override (`calculate(5, 3, operation: "subtract")`)

#### 5.4 Required named

`fn({required Type a})`

**Tested in:** user_reference (`User(id: ..., name: ...)`)

#### 5.5 Default values

`fn({int x = 0})`

**Tested in:** example_project (Calculator precision default), userbridge_override (calculate operation default).

#### 5.6 Function-typed parameter

`fn(int Function(int) f)` — callback parameter.

**Not tested.** `UserService.findUsers` accepts a predicate callback but is not tested.

### 6. Generics

#### 6.1 Generic class (single)

`class Box<T> { }`

**Tested in:** dart_overview (`Box(42)`), userbridge_override (`MyList<T>`)

#### 6.2 Generic class (two params)

`class Pair<F, S> { }`

**Tested in:** dart_overview (`Pair('Hello', 42)`)

#### 6.3 Upper bound

`class C<T extends num> { }`

**Not tested.**

#### 6.4 Generic method

`T transform<R>(R Function(T) f)` — method-level type parameters.

**Not tested.** `Wrapper.transform<R>` exists in dart_overview source.

#### 6.5 Generic static factory

`static MyList<T> empty<T>()` — generic static factory method.

**Not tested.** `MyList.empty<T>()` and `MyList.from<T>()` exist in userbridge_override source.

#### 6.6 F-bounded polymorphism

`T extends Comparable<T>` — self-referential type bound.

**Not tested.**

### 7. Inheritance

#### 7.1 Single inheritance

`class B extends A { }`

**Not tested.** `inheritance_classes.dart` exists in example_project source but no test exercises it.

#### 7.2 Interface implementation

`class B implements A { }`

**Not tested.**

#### 7.3 Multiple implements

`class C implements A, B { }`

**Not tested.**

#### 7.4 Mixin application

`class D extends A with M1, M2 { }`

**Not tested.**

#### 7.5 Covariant parameter

`void chase(covariant Dog d)`

**Not tested.**

### 8. User Bridges

#### 8.1 User bridge operator override

Overriding generated operator bridges with custom user bridge implementations.

**Tested in:** userbridge_user_guide (`Vector2DUserBridge` overrides `+`, `-`, `*`; `Matrix2x2UserBridge` overrides `[]`, `[]=`), userbridge_override (`MyListUserBridge` overrides `[]`, `[]=`)

**What's verified:** User bridge code executes instead of generated code, verified via print markers.

#### 8.2 User bridge method override

Overriding a generated method bridge.

**Tested in:** userbridge_user_guide (`Vector2DUserBridge.overrideMethodDot`)

**What's verified:** `v1.dot(v2)` prints `[Vector2DUserBridge] dot() called`.

#### 8.3 User bridge global override

Overriding global variables and top-level functions.

**Tested in:** userbridge_override (`GlobalsUserBridge` overrides `appName`, `maxRetries`, `version`, `currentTime`, `greet()`, `calculate()`)

#### 8.4 User bridge constructor override

Overriding a generated constructor bridge.

**Not tested.**

#### 8.5 User bridge getter override

Overriding a generated instance getter bridge.

**Not tested.**

#### 8.6 User bridge import prefix

Generated code must use `$pkg.UserBridgeClassName` prefix for user bridge references.

**Tested in:** userbridge_user_guide — **GEN-043** was found and fixed through this test.

#### 8.7 Print marker verification

Test assertions verify that user bridge print markers appear in subprocess output.

**Tested in:** userbridge_user_guide — 7 print markers checked: `[Vector2DUserBridge] operator+ called`, `binary operator- called`, `unary operator- called`, `operator* called`, `dot() called`, `[Matrix2x2UserBridge] operator[] called`, `operator[]= called`.

### 9. Async & Streams

#### 9.1 Async method

`Future<T> method() async { }`

**Not tested.** `UserService.fetchUser()` exists in user_reference source.

#### 9.2 Stream method

`Stream<T> method() async* { }`

**Not tested.**

#### 9.3 Sync generator

`Iterable<T> method() sync* { }`

**Not tested.**

### 10. Special Types

#### 10.1 Return type Map

Method returning `Map<String, dynamic>`.

**Tested in:** user_reference (`user.toMap()`)

#### 10.2 Parameter type List

Method parameter accepting `List<T>`.

**Tested in:** userbridge_user_guide (`m[[0, 1]]` passes `List<int>` to `operator[]`)

#### 10.3 Record types

`(int, String)` / `({String name, int age})` — structural types.

**Not tested.** May require D4rt interpreter support first.

#### 10.4 Function types as parameters

`void Function(int)` as a parameter type.

**Not tested.**

#### 10.5 Iterable return

Method returning `Iterable<T>`.

**Not tested.**

### 11. Visibility & Exports

#### 11.1 Public members

All public members are bridged.

**Tested in:** All projects.

#### 11.2 Private members excluded

Members starting with `_` are not bridged.

**Tested in:** Implicitly verified — private constructors and fields are never referenced.

#### 11.3 Barrel file exports

Bridge generation reads barrel file `export` directives.

**Tested in:** All projects use barrel files.

#### 11.4 Export show / hide

`export 'file.dart' show X;` / `export 'file.dart' hide Y;`

**Not tested.**

#### 11.5 Part / part of

`part 'file.dart';` / `part of 'library.dart';`

**Not tested.**

---

## Known Issues

| Issue | Description | Status | Affected Tests |
|-------|-------------|--------|----------------|
| GEN-041 | Enhanced enum custom fields/getters/methods not accessible through bridges | Open | example_project/enum_fields, dart_overview/enhanced_enums |
| GEN-042 | Implicit default constructors not bridged | Open | dart_overview/overview, dart_overview/implicit_ctors |
| GEN-043 | User bridge references lacked import prefix ($pkg.) | Fixed | userbridge_user_guide |

---

## Coverage Statistics

| Category | Total Features | ✅ Tested | ⚠️ Known Bug | ❌ Not Tested |
|----------|---------------|-----------|-------------|--------------|
| Top-Level Exportables | 29 | 5 | 4 | 20 |
| Class Members | 17 | 9 | 1 | 7 |
| Constructors | 8 | 3 | 1 | 4 |
| Operators | 12 | 6 | 0 | 6 |
| Parameters | 6 | 5 | 0 | 1 |
| Generics | 6 | 2 | 0 | 4 |
| Inheritance | 5 | 0 | 0 | 5 |
| User Bridges | 7 | 5 | 0 | 2 |
| Async & Streams | 3 | 0 | 0 | 3 |
| Special Types | 5 | 2 | 0 | 3 |
| Visibility & Exports | 5 | 3 | 0 | 2 |
| **Total** | **103** | **40** | **6** | **57** |
