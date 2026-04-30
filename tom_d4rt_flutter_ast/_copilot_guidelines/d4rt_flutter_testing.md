# D4rt Flutter Bridge Testing Architecture

This document describes the test infrastructure for validating D4rt Flutter bridges - the generated code that allows D4rt scripts to use Flutter widgets and APIs.

## Overview

The tom_d4rt_flutterm package provides bridge classes that expose Flutter's widget tree, painting, animation, and other APIs to the D4rt interpreter. Testing these bridges requires:

1. A running Flutter application that can receive and execute D4rt scripts
2. An AST bundler that compiles test scripts into execution bundles
3. HTTP-based communication between test runner and app
4. Validation of script output and built widgets

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      Test Runner Process                         │
│  ┌──────────────────┐    ┌───────────────┐    ┌──────────────┐ │
│  │ SendTestRunner   │───▶│ FlutterD4rt   │───▶│ AST Bundle   │ │
│  │ (flutter_test)   │    │ (AST bundler) │    │ (JSON)       │ │
│  └──────────────────┘    └───────────────┘    └──────────────┘ │
│           │                                          │          │
│           │         HTTP POST /build                 │          │
│           ▼──────────────────────────────────────────▼          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│              tom_d4rt_flutterm_app (Flutter App)                 │
│  ┌──────────────────┐    ┌───────────────┐    ┌──────────────┐ │
│  │ HTTP Server      │───▶│ D4rtExecutor  │───▶│ Widget Tree  │ │
│  │ (port 4247)      │    │ + Bridges     │    │              │ │
│  └──────────────────┘    └───────────────┘    └──────────────┘ │
│           │                     │                               │
│           │                     ▼                               │
│           │              Print Capture                          │
│           │              (runZoned)                             │
│           ▼                                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ JSON Response: {success, widgetType, output[], error}    │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Components

### 1. Test Scripts

Located in: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/`

Each test script is a Dart file that will be executed by D4rt. Scripts follow this pattern:

```dart
// D4rt test script: Tests <what is being tested>
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Test output message');
  
  return Container(
    // Widget configuration using bridged APIs
  );
}
```

**Requirements:**
- Must contain a `build(BuildContext context)` function
- The function must return a Widget (or widget-like object)
- Use `print()` to output test assertions/markers
- Import statements are parsed but actual imports come from app's environment

### 2. SendTestRunner Class

Located in: `test/send_test_runner.dart`

Provides reusable test infrastructure:

| Method | Purpose |
|--------|---------|
| `setUp()` | Initialize FlutterD4rt and HTTP client (call in setUpAll) |
| `tearDown()` | Clean up resources (call in tearDownAll) |
| `send(scriptPath)` | Send a single script and return SendResult |
| `isAppRunning()` | Check if test app is responsive |
| `clearApp()` | Clear the app's widget display |
| `getAppLogs()` | Retrieve app-side logs |
| `findAllScripts()` | Discover all test scripts recursively |
| `getRelativePath()` | Convert absolute to relative script path |

### 3. SendResult Class

Result object from script execution:

| Field | Type | Description |
|-------|------|-------------|
| `success` | `bool` | Whether script executed without errors |
| `widgetType` | `String?` | Runtime type of the built widget |
| `error` | `String?` | Error message if failed |
| `output` | `List<String>` | Captured print() output from script |
| `statusCode` | `int` | HTTP status code from app |

### 4. Test App (tom_d4rt_flutterm_app)

Located in: `test/tom_d4rt_flutterm_app/`

A Flutter application that:
- Runs an HTTP server on port 4247
- Receives AST bundles via POST /build
- Executes bundles using D4rtExecutor with all Flutter bridges registered
- Captures print() output via Zone
- Returns JSON response with results

## Bridged Flutter Modules

The package bridges 13 Flutter modules:

| Module | Barrel Import | Description |
|--------|---------------|-------------|
| `dart_ui` | `dart:ui` | Core rendering: Color, Offset, Size, Rect, Paint |
| `flutter_painting` | `package:flutter/painting.dart` | EdgeInsets, BorderRadius, BoxDecoration |
| `flutter_foundation` | `package:flutter/foundation.dart` | ChangeNotifier, ValueNotifier |
| `flutter_animation` | `package:flutter/animation.dart` | Curves, Tween, AnimationController |
| `flutter_physics` | `package:flutter/physics.dart` | SpringSimulation, physics simulations |
| `flutter_scheduler` | `package:flutter/scheduler.dart` | SchedulerBinding utilities |
| `flutter_semantics` | `package:flutter/semantics.dart` | Accessibility semantics |
| `flutter_services` | `package:flutter/services.dart` | Platform channels, clipboard |
| `flutter_gestures` | `package:flutter/gestures.dart` | Gesture recognizers, hit testing |
| `flutter_rendering` | `package:flutter/rendering.dart` | RenderObject, layout protocols |
| `flutter_widgets` | `package:flutter/widgets.dart` | StatelessWidget, Container, Text, etc. |
| `flutter_material` | `package:flutter/material.dart` | Material Design widgets |
| `flutter_cupertino` | `package:flutter/cupertino.dart` | iOS-style Cupertino widgets |

## Test Folder Structure

Scripts are organized by module:

```
send_ast_via_http_scripts/
├── dart_ui/
│   ├── color_test.dart
│   ├── offset_test.dart
│   ├── size_test.dart
│   └── rect_test.dart
├── painting/
│   ├── edge_insets_test.dart
│   ├── border_radius_test.dart
│   ├── box_decoration_test.dart
│   └── text_style_test.dart
├── foundation/
│   └── change_notifier_test.dart
├── animation/
│   ├── curves_test.dart
│   └── tween_test.dart
├── physics/
│   └── spring_simulation_test.dart
├── widgets/
│   ├── container_test.dart
│   ├── text_test.dart
│   ├── column_row_test.dart
│   ├── padding_test.dart
│   └── center_test.dart
├── material/
│   ├── scaffold_test.dart
│   ├── app_bar_test.dart
│   ├── elevated_button_test.dart
│   ├── text_button_test.dart
│   └── card_test.dart
└── cupertino/
    ├── cupertino_button_test.dart
    └── cupertino_page_scaffold_test.dart
```

## Running Tests

### Prerequisites

1. Start the test app in a separate terminal:
   ```bash
   cd test/tom_d4rt_flutterm_app
   flutter run -d linux  # or macos/windows
   ```

2. Or use chrome for web testing:
   ```bash
   flutter run -d chrome --web-port=8080
   ```

### Execute Tests

Run all send tests:
```bash
cd tom_d4rt_flutterm
flutter test test/send_test_runner.dart
```

### Writing New Tests

Example test file:

```dart
// test/my_feature_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'send_test_runner.dart';

void main() {
  setUpAll(() => SendTestRunner.setUp());
  tearDownAll(() => SendTestRunner.tearDown());

  group('EdgeInsets', () {
    test('EdgeInsets.all creates uniform padding', () async {
      final result = await SendTestRunner.send('painting/edge_insets_test.dart');
      
      expect(result.success, isTrue, reason: result.error);
      expect(result.widgetType, contains('Container'));
      expect(result.output, contains('EdgeInsets.all works'));
    });
  });
}
```

## Test Categories

### Basic Validation Tests
- Verify class is accessible and instantiable
- Test primary constructors
- Validate common method calls

### Integration Tests
- Combine multiple bridged classes
- Test widget composition
- Verify parent-child relationships

### Edge Case Tests
- Null handling
- Boundary values
- Invalid input handling

## Test Result Interpretation

| Result | Meaning |
|--------|---------|
| success=true, widgetType set | Script executed, widget built successfully |
| success=false, error set | Script or execution failed |
| output contains markers | Print statements captured from script |
| statusCode=200 | HTTP communication successful |
| statusCode=500 | Server-side error |

## Adding New Bridges to Tests

When new bridges are added to buildkit.yaml:

1. Regenerate bridges: `buildkit run build`
2. Create test script in appropriate folder
3. Add test case using SendTestRunner.send()
4. Run test to validate bridge works

## Known Limitations

- Tests require the Flutter app to be running
- HTTP-based testing has slight latency
- Cannot test widgets requiring user interaction
- Print capture limited to script execution scope
