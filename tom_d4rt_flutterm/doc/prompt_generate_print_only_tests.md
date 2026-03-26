# Prompt: Generate Print-Only D4rt Test Files

> **Usage:** Copy this prompt into Copilot Chat. Replace `BATCH_LIST` at the bottom with the next batch of 10 files from the master list. Repeat until all batches are done.
>
> **Batch size:** 10 files per prompt invocation. Expect 80–300 lines per file.
>
> **After each batch:** Run `dart analyze` on the project, fix any issues, then update `doc/testplan_status_report.md` — change each generated entry from `No | No | Print-only` to `No | Yes | No | Created on <date> at <time>`.

---

## Task

Generate print-only D4rt test scripts for the Flutter interpreter project `tom_d4rt_flutterm`. These test files verify that Flutter classes can be instantiated and used correctly from the D4rt interpreter. They use `print()` statements as implicit assertions and return a minimal widget for visual output.

**Project root:** `/home/alexis/tac/tom_ai/d4rt/tom_d4rt_flutterm/`
**Test files location:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/{section}/`

Each file already exists as a placeholder/dummy (< 80 lines). You must **replace the entire content** of each file with a proper print-only test. A test is considered implemented when it has **≥ 80 lines**.

---

## File Structure Template

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests {ClassName} from {section}
import 'package:flutter/{library}.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('{ClassName} test executing');
  print('=' * 50);

  // === Test code here ===

  print('\n' + '=' * 50);
  print('{ClassName} test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '{ClassName} Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      // Summary widget items here
    ],
  );
}
```

---

## Import Rules by Section

| Section | Primary Import | Always Also Import |
|---------|---------------|--------------------|
| animation | `package:flutter/animation.dart` | `package:flutter/material.dart` |
| cupertino | `package:flutter/cupertino.dart` | `package:flutter/material.dart` |
| dart_ui | `dart:ui` | `package:flutter/material.dart` |
| foundation | `package:flutter/foundation.dart` | `package:flutter/material.dart` |
| gestures | `package:flutter/gestures.dart` | `package:flutter/material.dart` |
| material | `package:flutter/material.dart` | (already included) |
| painting | `package:flutter/painting.dart` | `package:flutter/material.dart` |
| physics | `package:flutter/physics.dart` | `package:flutter/material.dart` |
| rendering | `package:flutter/rendering.dart` | `package:flutter/material.dart` |
| scheduler | `package:flutter/scheduler.dart` | `package:flutter/material.dart` |
| semantics | `package:flutter/semantics.dart` | `package:flutter/material.dart` |
| services | `package:flutter/services.dart` | `package:flutter/material.dart` |
| widgets | `package:flutter/widgets.dart` | `package:flutter/material.dart` |

**Note:** For widgets/ and material/ sections, `package:flutter/material.dart` alone is usually sufficient since it re-exports widgets. Add the specific import only if needed for non-re-exported symbols.

---

## Testing Patterns by Class Type

### Enums

For enum classes, test ALL values, indices, name, and any properties:

```dart
// Enumerate all values
print('{EnumName} values:');
for (final value in {EnumName}.values) {
  print('  ${value.name}: index=${value.index}');
}
print('{EnumName} has ${{EnumName}.values.length} values');

// First and last
final first = {EnumName}.values.first;
final last = {EnumName}.values.last;
print('First: $first (index ${first.index})');
print('Last: $last (index ${last.index})');

// Test specific properties if the enum has them
// e.g., AnimationStatus has isDismissed, isCompleted, isAnimating
```

### Data Classes / Value Objects

Test construction, property access, equality, toString, copying:

```dart
// Construct with various parameter combinations
final obj1 = {ClassName}(param1: value1, param2: value2);
print('Created: $obj1');
print('runtimeType: ${obj1.runtimeType}');
print('param1: ${obj1.param1}');
print('param2: ${obj1.param2}');

// Test with different values
final obj2 = {ClassName}(param1: otherValue1, param2: otherValue2);
print('obj1 == obj2: ${obj1 == obj2}');

// Edge cases
print('Empty/default construction: ...');

// If it has copyWith:
// final copy = obj1.copyWith(param1: newValue);
// print('Copy: $copy');
```

### Abstract Classes / Interfaces

Test via concrete implementations or verify type hierarchy:

```dart
// If abstract, explain purpose and test known subclasses
print('{ClassName} is abstract');
print('Purpose: {describe what it does}');

// Test via a concrete implementation if available
final impl = Concrete{ClassName}(...);
print('Concrete implementation: ${impl.runtimeType}');
print('is {ClassName}: ${impl is {ClassName}}');

// Or if it's an interface used by Flutter widgets:
print('Used by: [list known users]');
```

### Mixins

Test that the mixin's contract is understood:

```dart
print('{MixinName} is a mixin');
print('Purpose: {describe what it provides}');
print('Typically used with: {what classes use this}');
// If possible, create a simple test class that uses the mixin
```

### State Objects

Test the state class properties and lifecycle:

```dart
print('{StateName} is a State class for {WidgetName}');
print('Purpose: Manages state for {WidgetName}');
print('Key methods: {list important methods}');
// Cannot instantiate directly, but document the API
```

### Intent / Action Classes

Test creation and properties:

```dart
// Create the intent
final intent = {IntentName}();
print('{IntentName} created');
print('runtimeType: ${intent.runtimeType}');
print('is Intent: ${intent is Intent}');

// If it has properties, print them
// If it takes parameters:
// final intent2 = {IntentName}(param: value);
// print('param: ${intent2.param}');
```

### Controller Classes

Test creation, initial state, and available API:

```dart
final controller = {ControllerName}();
print('{ControllerName} created');
print('runtimeType: ${controller.runtimeType}');
// Print available properties
// Dispose if needed
controller.dispose();
print('Disposed successfully');
```

### Delegate / Builder Classes

Document the contract and test if concrete:

```dart
print('{DelegateName} purpose: {what it does}');
// If concrete, instantiate and test
// If abstract, document the contract
```

### Restorable Properties (widgets/restorable_*.dart)

```dart
final prop = {RestorableName}(defaultValue);
print('{RestorableName} created with default: ${prop.value}');
prop.value = newValue;
print('After set: ${prop.value}');
print('is RestorableProperty: ${prop is RestorableProperty}');
prop.dispose();
print('Disposed');
```

### Scroll Physics

```dart
final physics = {PhysicsName}();
print('{PhysicsName} created');
print('runtimeType: ${physics.runtimeType}');
print('is ScrollPhysics: ${physics is ScrollPhysics}');
// Test with parent
final withParent = {PhysicsName}(parent: ClampingScrollPhysics());
print('With parent: ${withParent.parent}');
```

### Notification Classes

```dart
final notification = {NotificationName}(...);
print('{NotificationName} created');
print('runtimeType: ${notification.runtimeType}');
print('is Notification: ${notification is Notification}');
// Print properties
```

### Tween Classes

```dart
final tween = {TweenName}(begin: startVal, end: endVal);
print('{TweenName} created');
print('begin: ${tween.begin}');
print('end: ${tween.end}');
print('lerp(0.0): ${tween.lerp(0.0)}');
print('lerp(0.5): ${tween.lerp(0.5)}');
print('lerp(1.0): ${tween.lerp(1.0)}');
```

### Window Controller Classes (desktop)

```dart
print('{WindowControllerName} purpose: Desktop window management');
print('Platform: {Linux/MacOS/Win32/cross-platform}');
// These are typically abstract or require platform, so document API
print('Key API: {list methods}');
```

### Key Classes

```dart
final key = {KeyName}(value);
print('{KeyName} created: $key');
print('value: ${key.value}');
// Test equality
final key2 = {KeyName}(value);
print('key1 == key2: ${key == key2}');
```

### Render Object / Element Classes

```dart
print('{ClassName} purpose: {describe role in rendering/element tree}');
print('is RenderObject/Element: true');
// These typically cannot be instantiated standalone
// Document the API and typical usage
```

---

## Quality Requirements

1. **Minimum 80 lines** — Every file must have ≥ 80 lines of meaningful code
2. **Exercise the real API** — Don't just print static strings. Actually create instances, call methods, access properties
3. **Print assertions** — Use print statements that demonstrate correct behavior. If a value should be `true`, print it so the output proves it
4. **Edge cases** — Test boundary conditions, empty/null-like values, different constructor overloads
5. **Type hierarchy** — Print `is` checks to verify inheritance: `print('is ScrollPhysics: ${obj is ScrollPhysics}')`
6. **Must compile** — Code must pass `dart analyze` with no errors. Be careful with:
   - Abstract classes that can't be directly instantiated
   - Platform-specific APIs that may not be available
   - Deprecated APIs (use `deprecated_member_use` ignore)
7. **Return a widget** — Always return a Column or similar widget summarizing the test results
8. **No helpers outside build** — Everything must be inside the `build` function (local functions are OK)

---

## Compile Safety Rules

- If a class is **abstract and has no public concrete subclass**, document its API with print statements rather than trying to instantiate it
- If a class requires a **BuildContext or Element** that can't be obtained in the build function, use the passed `context` parameter or document the limitation
- If a class is **platform-specific** (e.g., WindowControllerLinux), wrap in a try-catch or document what it does
- **Never import `dart:io`** — these are Flutter scripts, not standalone Dart
- Use `try { ... } catch (e) { print('Expected: $e'); }` for operations that may throw in the test environment

---

## Example: Simple Enum (services/device_orientation_test.dart)

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DeviceOrientation from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DeviceOrientation test executing');

  // Enumerate all DeviceOrientation values
  print('DeviceOrientation values:');
  for (final value in DeviceOrientation.values) {
    print('  ${value.name}: $value');
  }
  print('DeviceOrientation has ${DeviceOrientation.values.length} values');

  final first = DeviceOrientation.values.first;
  final last = DeviceOrientation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DeviceOrientation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeviceOrientation Tests'),
      Text('Values: ${DeviceOrientation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
```

## Example: Data Class (foundation/object_created_test.dart)

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObjectCreated event from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectCreated test executing');
  print('=' * 50);

  final testObj = Object();
  final event1 = ObjectCreated(
    library: 'package:test/test.dart',
    className: 'MyClass',
    object: testObj,
  );
  print('\nObjectCreated created:');
  print('runtimeType: ${event1.runtimeType}');
  print('library: ${event1.library}');
  print('className: ${event1.className}');
  print('object: ${event1.object}');
  print('object.runtimeType: ${event1.object.runtimeType}');

  final container = Container(width: 100, height: 100);
  final event2 = ObjectCreated(
    library: 'package:flutter/widgets.dart',
    className: 'Container',
    object: container,
  );
  print('\nWith Flutter widget:');
  print('library: ${event2.library}');
  print('className: ${event2.className}');
  print('object type: ${event2.object.runtimeType}');

  print('\nType hierarchy:');
  print('is ObjectEvent: true');
  print('is Object: true');

  print('\nVarious library formats:');
  final dartCore = ObjectCreated(library: 'dart:core', className: 'List', object: <int>[]);
  final packageLib = ObjectCreated(library: 'package:my_app/src/models/user.dart', className: 'User', object: Object());
  print('dart:core - ${dartCore.library}');
  print('package: - ${packageLib.library}');

  print('\nEdge cases:');
  final emptyLib = ObjectCreated(library: '', className: 'Unknown', object: Object());
  final emptyClass = ObjectCreated(library: 'test', className: '', object: Object());
  print('Empty library: "${emptyLib.library}"');
  print('Empty className: "${emptyClass.className}"');

  print('\nEvent comparison:');
  final sameObj = Object();
  final eventA = ObjectCreated(library: 'test', className: 'Test', object: sameObj);
  final eventB = ObjectCreated(library: 'test', className: 'Test', object: sameObj);
  print('eventA == eventB: ${eventA == eventB}');
  print('identical: ${identical(eventA, eventB)}');
  print('Same object: ${identical(eventA.object, eventB.object)}');

  print('\nObjectCreated purpose:');
  print('- Event fired when a tracked object is created');
  print('- Part of FlutterMemoryAllocations system');
  print('- Used for memory leak detection');
  print('- Carries library, className, and object reference');

  print('\n' + '=' * 50);
  print('ObjectCreated test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectCreated Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: ${event1.runtimeType}'),
      Text('library: ${event1.library}'),
      Text('className: ${event1.className}'),
      Text('Purpose: Memory allocation tracking'),
    ],
  );
}
```

## Example: Painting Enum (painting/alignment_test.dart)

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Alignment from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Alignment test executing');

  final custom = Alignment(0.5, -0.5);
  print('Alignment(0.5, -0.5): x=${custom.x}, y=${custom.y}');

  print('Alignment.topLeft: x=${Alignment.topLeft.x}, y=${Alignment.topLeft.y}');
  print('Alignment.topCenter: x=${Alignment.topCenter.x}, y=${Alignment.topCenter.y}');
  print('Alignment.topRight: x=${Alignment.topRight.x}, y=${Alignment.topRight.y}');
  print('Alignment.centerLeft: x=${Alignment.centerLeft.x}, y=${Alignment.centerLeft.y}');
  print('Alignment.center: x=${Alignment.center.x}, y=${Alignment.center.y}');
  print('Alignment.centerRight: x=${Alignment.centerRight.x}, y=${Alignment.centerRight.y}');
  print('Alignment.bottomLeft: x=${Alignment.bottomLeft.x}, y=${Alignment.bottomLeft.y}');
  print('Alignment.bottomCenter: x=${Alignment.bottomCenter.x}, y=${Alignment.bottomCenter.y}');
  print('Alignment.bottomRight: x=${Alignment.bottomRight.x}, y=${Alignment.bottomRight.y}');

  print('Alignment test completed');

  return Container(
    width: 250.0, height: 250.0,
    color: Colors.grey.shade300,
    child: Stack(
      children: [
        Align(alignment: Alignment.topLeft, child: Container(width: 40.0, height: 40.0, color: Colors.red)),
        Align(alignment: Alignment.topRight, child: Container(width: 40.0, height: 40.0, color: Colors.green)),
        Align(alignment: Alignment.center, child: Container(width: 40.0, height: 40.0, color: Colors.blue)),
        Align(alignment: Alignment.bottomLeft, child: Container(width: 40.0, height: 40.0, color: Colors.yellow)),
        Align(alignment: Alignment.bottomRight, child: Container(width: 40.0, height: 40.0, color: Colors.purple)),
        Align(alignment: custom, child: Container(
          width: 60.0, height: 30.0, color: Colors.orange,
          child: Center(child: Text('custom', style: TextStyle(fontSize: 12.0))),
        )),
      ],
    ),
  );
}
```

---

## Post-Generation Checklist (per batch)

1. Run `dart analyze` from project root — fix all errors
2. Verify each file has ≥ 80 lines: `wc -l {file}`
3. Update `doc/testplan_status_report.md` — change each entry from:
   `| No | No | Print-only |` to `| No | Yes | No | Created on {YYYY-MM-DD} at {HH:MM} |`
4. Commit: `git add -A && git commit -m "print-only tests: {section} batch {N}"`

---

## Batch Template

Copy the following into a new Copilot Chat prompt, replacing the BATCH_LIST:

```
Using the prompt in doc/prompt_generate_print_only_tests.md, generate print-only test files for the following 10 files. Replace the entire content of each existing placeholder file. Each file must have ≥ 80 lines. After generating all 10, run `dart analyze` and fix issues, then update testplan_status_report.md.

BATCH_LIST:
1. {section}/{filename} -> {ClassName}
2. {section}/{filename} -> {ClassName}
3. {section}/{filename} -> {ClassName}
4. {section}/{filename} -> {ClassName}
5. {section}/{filename} -> {ClassName}
6. {section}/{filename} -> {ClassName}
7. {section}/{filename} -> {ClassName}
8. {section}/{filename} -> {ClassName}
9. {section}/{filename} -> {ClassName}
10. {section}/{filename} -> {ClassName}
```

### Suggested batch order

Start with the **smaller sections** first (complete whole sections in one batch), then move to widgets/:

| Batch | Section(s) | Count | Notes |
|-------|-----------|-------|-------|
| 1 | cupertino + dart_ui + foundation + gestures | 9 | Complete 4 small sections |
| 2 | painting + physics + scheduler | 16 | Complete 3 sections (may need 2 sub-batches) |
| 3 | material (1/3) | 7 | First 7 material |
| 4 | material (2/3) | 7 | Next 7 material |
| 5 | material (3/3) | 7 | Last 7 material |
| 6 | semantics + services (1/6) | 10 | semantics(6) + services(4) |
| 7-11 | services (2-6) | 52 | ~10 per batch |
| 12 | rendering (1/7) | 10 | |
| 13-17 | rendering (2-7) | 54 | ~10 per batch |
| 18-59 | widgets (1-42) | 414 | ~10 per batch |

**Total: ~59 batches of 10 files each.**
