# Test Run Error Analysis — 2026-04-16 10:54 (rev `478ec6c1`)

Test run ID: `20260416-1054-478ec6c1`  
Date: 2026-04-16  
Generated from: `doc/testlog_20260416-1054-478ec6c1/`

## Summary

- Total unique scripts with issues: **129**
  - Test failures only: **65**
  - Test failures with framework errors: **8**
  - Framework errors only (test passed but logged errors): **56**
  - Scripts with timeouts: **62**

## Resolution checkboxes legend

- **[ ] Fixed in script** — fix is in the demo file itself (e.g. avoiding interpreter-incompatible patterns)
- **[ ] Fix in interpreter/generator** — bug must be fixed in d4rt interpreter or bridge generator
- **[ ] Workaround** — temporary workaround applied (note in commit)
- **[ ] added custom code** — custom code added to bridge or runtime
- **[ ] Timeout** — test timed out (already pre-checked below for timeout entries)

---

## 1. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_box_container_defaults_mixin_test.dart

**Test Failure** — **Framework Errors** (1) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_DefaultsContainer)
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_issues_test.dart 23:3    expectSuccess
test/generator_interpreter_issues_test.dart 369:7   main.<fn>.<fn>
```

### Log error output

```
01:48 +0 -43: Section 2 - Bridge Generator Issues (80) rendering/render_box_container_defaults_mixin_test.dart
[METRIC] script=rendering/render_box_container_defaults_mixin_test.dart sourceBytes=64831 sourceChars=64831 bundleJsonBytes=1002530 clearMs=24 readMs=0 bundleMs=52 httpMs=86303 totalMs=86381 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/render_box_container_defaults_mixin_test.dart (1 error(s)):
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_DefaultsContainer)
```

---

## 2. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_custom_multi_child_layout_box_test.dart

**Test Failure** — **Framework Errors** (1) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Runtime Error: Native error during default bridged constructor for 'CustomMultiChildLayout': Argument Error: Invalid parameter "delegate": expected MultiChildLayoutDelegate, got InterpretedInstance(_DashboardDelegate)
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_issues_test.dart 23:3    expectSuccess
test/generator_interpreter_issues_test.dart 377:7   main.<fn>.<fn>
```

### Log error output

```
03:03 +0 -46: Section 2 - Bridge Generator Issues (80) rendering/render_custom_multi_child_layout_box_test.dart
[METRIC] script=rendering/render_custom_multi_child_layout_box_test.dart sourceBytes=66763 sourceChars=66763 bundleJsonBytes=1071676 clearMs=56400 readMs=2 bundleMs=79 httpMs=75525 totalMs=132007 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/render_custom_multi_child_layout_box_test.dart (1 error(s)):
       Runtime Error: Native error during default bridged constructor for 'CustomMultiChildLayout': Argument Error: Invalid parameter "delegate": expected MultiChildLayoutDelegate, got InterpretedInstance(_D…
```

---

## 3. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_custom_paint_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_issues_test.dart 23:3    expectSuccess
test/generator_interpreter_issues_test.dart 385:7   main.<fn>.<fn>
```

### Log error output

```
08:11 +369 ~4 -15: rendering/ individual render_custom_paint_test.dart
[METRIC] script=rendering/render_custom_paint_test.dart sourceBytes=59708 sourceChars=59708 bundleJsonBytes=957290 clearMs=87431 readMs=166 bundleMs=29 httpMs=10567 totalMs=98195 status=error httpStatus=400 outputLines=84 frameworkErrors=0
```

---

## 4. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_custom_single_child_layout_box_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_issues_test.dart 23:3    expectSuccess
test/generator_interpreter_issues_test.dart 393:7   main.<fn>.<fn>
```

### Log error output

```
08:11 +369 ~4 -15: rendering/ individual render_custom_single_child_layout_box_test.dart
[METRIC] script=rendering/render_custom_single_child_layout_box_test.dart sourceBytes=71483 sourceChars=71483 bundleJsonBytes=1147113 clearMs=57428 readMs=199 bundleMs=36 httpMs=10529 totalMs=68194 status=error httpStatus=400 outputLines=84 frameworkErrors=0
```

---

## 5. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_physical_shape_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_issues_test.dart 23:3    expectSuccess
test/generator_interpreter_issues_test.dart 401:7   main.<fn>.<fn>
```

### Log error output

```
12:07 +370 ~4 -22: rendering/ individual render_physical_shape_test.dart
[METRIC] script=rendering/render_physical_shape_test.dart sourceBytes=63808 sourceChars=63808 bundleJsonBytes=1024037 clearMs=81768 readMs=2 bundleMs=44 httpMs=123580 totalMs=205396 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

---

## 6. generator_interpreter_issues_test.dart : widgets/scrollbar_orientation_test.dart

**Test Failure** — **Framework Errors** (4) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
00:36 +78 -22: widgets/ scrollbar_orientation_test.dart
[METRIC] script=widgets/scrollbar_orientation_test.dart sourceBytes=31402 sourceChars=30200 bundleJsonBytes=353074 clearMs=2 readMs=0 bundleMs=16 httpMs=453 totalMs=473 status=success httpStatus=200 outputLines=4 frameworkErrors=4

  ⚠️  FRAMEWORK ERROR in widgets/scrollbar_orientation_test.dart (4 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _OrientedPanelState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _OrientedPanelState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _OrientedPanelState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _OrientedPanelState.)
```

---

## 7. generator_interpreter_issues_test.dart : widgets/sliver_animated_list_state_test.dart

**Test Failure** — **Framework Errors** (1) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
00:41 +102 -26: widgets/ sliver_animated_list_state_test.dart
[METRIC] script=widgets/sliver_animated_list_state_test.dart sourceBytes=32173 sourceChars=31069 bundleJsonBytes=412431 clearMs=30 readMs=0 bundleMs=13 httpMs=271 totalMs=315 status=success httpStatus=200 outputLines=4 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/sliver_animated_list_state_test.dart (1 error(s)):
       Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _InteractivePageState.)
```

---

## 8. generator_interpreter_issues_test.dart : widgets/sliver_child_builder_delegate_test.dart

**Test Failure** — **Framework Errors** (1) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
00:41 +103 -26: widgets/ sliver_child_builder_delegate_test.dart
[METRIC] script=widgets/sliver_child_builder_delegate_test.dart sourceBytes=32659 sourceChars=31167 bundleJsonBytes=361232 clearMs=48 readMs=1 bundleMs=17 httpMs=150 totalMs=218 status=success httpStatus=200 outputLines=4 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/sliver_child_builder_delegate_test.dart (1 error(s)):
       Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _InteractivePageState.)
```

---

## 9. generator_interpreter_issues_test.dart : widgets/stateless_element_test.dart

**Test Failure** — **Framework Errors** (2) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Bad state: Transport failure while running "widgets/stateless_element_test.dart"
Operation: POST /build?filename=widgets%2Fstateless_element_test.dart
Error: HttpException: Connection closed before full header was received, uri = http://localhost:4247/build?filename=widgets%2Fstateless_element_test.dart

Stack trace:
dart:async/future_impl.dart 21:26                              _interceptError
dart:async/future_impl.dart 52:23                              _interceptUserError
dart:async/stream_controller.dart 624:39                       _StreamController.addError
dart:_http/http_parser.dart 1255:17                            _HttpParser._reportHttpError
dart:_http/http_parser.dart 952:9                              _HttpParser._onDone
package:stack_trace/src/stack_zone_specification.dart 207:15   StackZoneSpecification._run
package:stack_trace/src/stack_zone_specification.dart 114:48   StackZoneSpecification._registerCallback.<fn>
dart:async/zone_root.dart 27:47                                _rootRun
dart:async/zone.dart 726:19                                    _CustomZone.run
dart:async/zone.dart 625:7                                     _CustomZone.runGuarded
dart:async/stream_impl.dart 434:13                             _BufferingStreamSubscription._sendDone.sendDone
dart:async/stream_impl.dart 444:7                              _BufferingStreamSubscription._sendDone
dart:async/stream_impl.dart 333:7                              _BufferingStreamSubscription._close
dart:
... (truncated, 33580 more chars)
```

### Exception

```
test/send_test_runner.dart 772:7  SendTestRunner.send
```

### Log error output

```
33:34 +553 ~4 -67: widgets/ individual stateless_element_test.dart
[METRIC] script=widgets/stateless_element_test.dart sourceBytes=28085 sourceChars=28085 bundleJsonBytes=387057 clearMs=70 readMs=0 bundleMs=16 httpMs=2540 totalMs=2629 status=success httpStatus=200 outputLines=0 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in widgets/stateless_element_test.dart (2 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _TrackedChildState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _CounterChildState.)
```

---

## 10. generator_interpreter_retest_test.dart : : rendering/render_animated_size_state_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Runtime Error: Native error during default bridged constructor for 'ConstrainedBox': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_MeasureBox); A RenderFlex overflowed by 2.0 pixels on the bottom.
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 231:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 11. generator_interpreter_retest_test.dart : : rendering/render_sliver_box_child_manager_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 238:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 12. generator_interpreter_retest_test.dart : : services/message_codec_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 246:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 13. generator_interpreter_retest_test.dart : : services/method_codec_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 253:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 14. generator_interpreter_retest_test.dart : : widgets/android_view_surface_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 261:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 15. generator_interpreter_retest_test.dart : : widgets/app_kit_view_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 268:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 16. generator_interpreter_retest_test.dart : : widgets/back_button_listener_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 275:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 17. generator_interpreter_retest_test.dart : : widgets/box_scroll_view_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 282:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 18. generator_interpreter_retest_test.dart : : widgets/context_action_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 289:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 19. generator_interpreter_retest_test.dart : : widgets/default_selection_style_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/generator_interpreter_retest_test.dart 26:3    expectSuccess
test/generator_interpreter_retest_test.dart 296:7   main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 20. hardly_relevant_classes_1_test.dart : dart_ui/opacity_engine_layer_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
05:12 +77 -8: dart_ui/ opacity_engine_layer_test.dart
[METRIC] script=dart_ui/opacity_engine_layer_test.dart sourceBytes=37603 sourceChars=35462 bundleJsonBytes=465112 clearMs=2 readMs=1 bundleMs=25 httpMs=35727 totalMs=35756 status=success httpStatus=200 outputLines=29 frameworkErrors=0
```

---

## 21. hardly_relevant_classes_1_test.dart : dart_ui/point_mode_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 618:35   AstConverter._convertForStatement
package:tom_ast_generator/src/converter/ast_converter.dart 87:47    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 561:19   AstConverter._convertBlock
package:tom_ast_generator/src/converter/ast_converter.dart 78:40    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 1419:14  AstConverter._convertBlockFunctionBody
package:tom_ast_generator/src/converter/ast_converter.dart 189:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 382:13   AstConverter._convertMethodDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 52:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 402:16   AstConverter._convertClassDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 54:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 28:25    AstConverter.convertCompilationUnit
package:tom_ast_generator/src/bundler/ast_bundler.dart 497:23       AstBundler._pars
... (truncated, 291 more chars)
```

### Log error output

_(no log block found)_

---

## 22. hardly_relevant_classes_2_test.dart : material/list_tile_style_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
Bad state: Cannot resolve import "package:flutter_test/flutter_test.dart" from main.dart: Package import "package:flutter_test/flutter_test.dart" is not bridged and not in the same package. Either add it to bridgedLibraries or provide it via explicitSources.
```

### Exception

```
package:tom_ast_generator/src/bundler/ast_bundler.dart 335:11  AstBundler._resolveImports
```

### Log error output

_(no log block found)_

---

## 23. hardly_relevant_classes_2_test.dart : painting/asset_bundle_image_provider_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
Bad state: Script not found: /srv/repos/al_the_bear/inhouse/second_wind/enterprise_flutter/tom_agent_container/tom_ai/d4rt/tom_d4rt_flutterm/test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/painting/asset_bundle_image_provider_test.dart
```

### Exception

```
test/send_test_runner.dart 673:7                  SendTestRunner.send
test/hardly_relevant_classes_2_test.dart 1211:43  main.<fn>.<fn>
```

### Log error output

_(no log block found)_

---

## 24. hardly_relevant_classes_3_test.dart : rendering/child_layout_helper_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 618:35   AstConverter._convertForStatement
package:tom_ast_generator/src/converter/ast_converter.dart 87:47    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 561:19   AstConverter._convertBlock
package:tom_ast_generator/src/converter/ast_converter.dart 78:40    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 1419:14  AstConverter._convertBlockFunctionBody
package:tom_ast_generator/src/converter/ast_converter.dart 189:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 382:13   AstConverter._convertMethodDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 52:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 402:16   AstConverter._convertClassDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 54:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 28:25    AstConverter.convertCompilationUnit
package:tom_ast_generator/src/bundler/ast_bundler.dart 497:23       AstBundler._pars
... (truncated, 291 more chars)
```

### Log error output

_(no log block found)_

---

## 25. hardly_relevant_classes_3_test.dart : rendering/diagnostics_debug_creator_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
Bad state: Cannot resolve import "package:flutter_test/flutter_test.dart" from main.dart: Package import "package:flutter_test/flutter_test.dart" is not bridged and not in the same package. Either add it to bridgedLibraries or provide it via explicitSources.
```

### Exception

```
package:tom_ast_generator/src/bundler/ast_bundler.dart 335:11  AstBundler._resolveImports
```

### Log error output

_(no log block found)_

---

## 26. hardly_relevant_classes_3_test.dart : rendering/render_darwin_platform_view_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
01:44 +46 -4: rendering/ render_darwin_platform_view_test.dart
[METRIC] script=rendering/render_darwin_platform_view_test.dart sourceBytes=58055 sourceChars=58055 bundleJsonBytes=868067 clearMs=51 readMs=0 bundleMs=87 httpMs=76523 totalMs=76663 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

---

## 27. hardly_relevant_classes_3_test.dart : rendering/render_decorated_sliver_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/hardly_relevant_classes_3_test.dart 381:7      main.<fn>.<fn>
```

### Log error output

```
01:55 +80 -4: rendering/ render_decorated_sliver_test.dart
[METRIC] script=rendering/render_decorated_sliver_test.dart sourceBytes=52898 sourceChars=52896 bundleJsonBytes=786333 clearMs=46682 readMs=2 bundleMs=50 httpMs=10354 totalMs=57090 status=error httpStatus=400 outputLines=2 frameworkErrors=0
```

---

## 28. hardly_relevant_classes_4_test.dart : widgets/expansible_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1096:21  AstConverter._convertForElement
package:tom_ast_generator/src/converter/ast_converter.dart 143:45   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1189:17  AstConverter._convertListLiteral
package:tom_ast_generator/src/converter/ast_converter.dart 155:46   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1061:19  AstConverter._convertNamedExpression
package:tom_ast_generator/src/converter/ast_converter.dart 138:50   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1531:18  AstConverter._convertArgumentList
package:tom_ast_generator/src/converter/ast_converter.dart 206:47   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 926:21   AstConverter._convertMethodInvocation
package:tom_ast_generator/src/converter/ast_converter.dart 117:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1061:19  AstConverter._convertNamedExpression
p
... (truncated, 3113 more chars)
```

### Log error output

_(no log block found)_

---

## 29. hardly_relevant_classes_4_test.dart : widgets/fractional_translation_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1096:21  AstConverter._convertForElement
package:tom_ast_generator/src/converter/ast_converter.dart 143:45   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1189:17  AstConverter._convertListLiteral
package:tom_ast_generator/src/converter/ast_converter.dart 155:46   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1061:19  AstConverter._convertNamedExpression
package:tom_ast_generator/src/converter/ast_converter.dart 138:50   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1531:18  AstConverter._convertArgumentList
package:tom_ast_generator/src/converter/ast_converter.dart 206:47   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 926:21   AstConverter._convertMethodInvocation
package:tom_ast_generator/src/converter/ast_converter.dart 117:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 601:19   AstConverter._convertReturnStatement
p
... (truncated, 1603 more chars)
```

### Log error output

_(no log block found)_

---

## 30. hardly_relevant_classes_4_test.dart : widgets/matrix_transition_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1096:21  AstConverter._convertForElement
package:tom_ast_generator/src/converter/ast_converter.dart 143:45   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1189:17  AstConverter._convertListLiteral
package:tom_ast_generator/src/converter/ast_converter.dart 155:46   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1061:19  AstConverter._convertNamedExpression
package:tom_ast_generator/src/converter/ast_converter.dart 138:50   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1531:18  AstConverter._convertArgumentList
package:tom_ast_generator/src/converter/ast_converter.dart 206:47   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 926:21   AstConverter._convertMethodInvocation
package:tom_ast_generator/src/converter/ast_converter.dart 117:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1189:17  AstConverter._convertListLiteral

... (truncated, 3393 more chars)
```

### Log error output

_(no log block found)_

---

## 31. hardly_relevant_classes_5_test.dart : widgets/raw_menu_overlay_info_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 618:35   AstConverter._convertForStatement
package:tom_ast_generator/src/converter/ast_converter.dart 87:47    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 561:19   AstConverter._convertBlock
package:tom_ast_generator/src/converter/ast_converter.dart 78:40    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 1419:14  AstConverter._convertBlockFunctionBody
package:tom_ast_generator/src/converter/ast_converter.dart 189:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 382:13   AstConverter._convertMethodDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 52:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 402:16   AstConverter._convertClassDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 54:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 28:25    AstConverter.convertCompilationUnit
package:tom_ast_generator/src/bundler/ast_bundler.dart 497:23       AstBundler._pars
... (truncated, 291 more chars)
```

### Log error output

_(no log block found)_

---

## 32. hardly_relevant_classes_5_test.dart : widgets/raw_radio_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1096:21  AstConverter._convertForElement
package:tom_ast_generator/src/converter/ast_converter.dart 143:45   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1189:17  AstConverter._convertListLiteral
package:tom_ast_generator/src/converter/ast_converter.dart 155:46   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 1061:19  AstConverter._convertNamedExpression
package:tom_ast_generator/src/converter/ast_converter.dart 138:50   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 1531:18  AstConverter._convertArgumentList
package:tom_ast_generator/src/converter/ast_converter.dart 206:47   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 926:21   AstConverter._convertMethodInvocation
package:tom_ast_generator/src/converter/ast_converter.dart 117:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 601:19   AstConverter._convertReturnStatement
p
... (truncated, 1603 more chars)
```

### Log error output

_(no log block found)_

---

## 33. hardly_relevant_classes_5_test.dart : widgets/render_two_dimensional_viewport_test.dart

**Test Failure**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
```

### Exception

```
package:tom_ast_generator/src/converter/ast_converter.dart 2044:71  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 618:35   AstConverter._convertForStatement
package:tom_ast_generator/src/converter/ast_converter.dart 87:47    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 561:19   AstConverter._convertBlock
package:tom_ast_generator/src/converter/ast_converter.dart 78:40    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 1419:14  AstConverter._convertBlockFunctionBody
package:tom_ast_generator/src/converter/ast_converter.dart 189:14   AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2044:57  AstConverter._as
package:tom_ast_generator/src/converter/ast_converter.dart 382:13   AstConverter._convertMethodDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 52:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 2050:13  AstConverter._nodesAs
package:tom_ast_generator/src/converter/ast_converter.dart 402:16   AstConverter._convertClassDeclaration
package:tom_ast_generator/src/converter/ast_converter.dart 54:14    AstConverter.convert
package:tom_ast_generator/src/converter/ast_converter.dart 28:25    AstConverter.convertCompilationUnit
package:tom_ast_generator/src/bundler/ast_bundler.dart 497:23       AstBundler._pars
... (truncated, 291 more chars)
```

### Log error output

_(no log block found)_

---

## 34. secondary_classes_test.dart : rendering/layer_types_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 650:7              main.<fn>.<fn>
```

### Log error output

```
02:00 +132 ~4 -4: rendering/ layer_types_test.dart
[METRIC] script=rendering/layer_types_test.dart sourceBytes=3265 sourceChars=3265 bundleJsonBytes=38119 clearMs=52498 readMs=1 bundleMs=3 httpMs=10036 totalMs=62540 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

---

## 35. secondary_classes_test.dart : rendering/render_backdrop_filter_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
08:00 +353 ~4 -15: rendering/ individual render_backdrop_filter_test.dart
[METRIC] script=rendering/render_backdrop_filter_test.dart sourceBytes=67388 sourceChars=67388 bundleJsonBytes=930126 clearMs=22 readMs=0 bundleMs=45 httpMs=297365 totalMs=297433 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

---

## 36. secondary_classes_test.dart : rendering/render_baseline_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2669:7             main.<fn>.<fn>
```

### Log error output

```
08:11 +369 ~4 -15: rendering/ individual render_baseline_test.dart
[METRIC] script=rendering/render_baseline_test.dart sourceBytes=56176 sourceChars=56115 bundleJsonBytes=783483 clearMs=267453 readMs=8 bundleMs=40 httpMs=10724 totalMs=278227 status=error httpStatus=400 outputLines=84 frameworkErrors=0
```

---

## 37. secondary_classes_test.dart : rendering/render_block_semantics_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2676:7             main.<fn>.<fn>
```

### Log error output

```
08:11 +369 ~4 -15: rendering/ individual render_block_semantics_test.dart
[METRIC] script=rendering/render_block_semantics_test.dart sourceBytes=932 sourceChars=930 bundleJsonBytes=10376 clearMs=237451 readMs=53 bundleMs=1 httpMs=10721 totalMs=248227 status=error httpStatus=400 outputLines=84 frameworkErrors=0
```

---

## 38. secondary_classes_test.dart : rendering/render_constrained_overflow_box_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2690:7             main.<fn>.<fn>
```

### Log error output

```
08:11 +369 ~4 -15: rendering/ individual render_constrained_overflow_box_test.dart
[METRIC] script=rendering/render_constrained_overflow_box_test.dart sourceBytes=63570 sourceChars=63570 bundleJsonBytes=950694 clearMs=177444 readMs=89 bundleMs=25 httpMs=10665 totalMs=188225 status=error httpStatus=400 outputLines=84 frameworkErrors=0
```

---

## 39. secondary_classes_test.dart : rendering/render_constraints_transform_box_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2697:7             main.<fn>.<fn>
```

### Log error output

```
08:11 +369 ~4 -15: rendering/ individual render_constraints_transform_box_test.dart
[METRIC] script=rendering/render_constraints_transform_box_test.dart sourceBytes=2421 sourceChars=2421 bundleJsonBytes=22021 clearMs=147440 readMs=118 bundleMs=1 httpMs=10637 totalMs=158197 status=error httpStatus=400 outputLines=84 frameworkErrors=0
```

---

## 40. secondary_classes_test.dart : rendering/render_physical_model_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
10:04 +370 ~4 -18: rendering/ individual render_physical_model_test.dart
[METRIC] script=rendering/render_physical_model_test.dart sourceBytes=55054 sourceChars=55054 bundleJsonBytes=847870 clearMs=30 readMs=0 bundleMs=23 httpMs=111691 totalMs=111746 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

---

## 41. secondary_classes_test.dart : rendering/render_pointer_listener_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2858:7             main.<fn>.<fn>
```

### Log error output

```
12:07 +370 ~4 -22: rendering/ individual render_pointer_listener_test.dart
[METRIC] script=rendering/render_pointer_listener_test.dart sourceBytes=71341 sourceChars=71341 bundleJsonBytes=1135627 clearMs=51765 readMs=51 bundleMs=29 httpMs=123542 totalMs=175389 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

---

## 42. secondary_classes_test.dart : rendering/render_pointer_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
01:50 +74 ~3 -2: rendering/ render_pointer_test.dart
[METRIC] script=rendering/render_pointer_test.dart sourceBytes=76241 sourceChars=76241 bundleJsonBytes=1138759 clearMs=2 readMs=1 bundleMs=99 httpMs=82375 totalMs=82479 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

---

## 43. secondary_classes_test.dart : rendering/render_proxy_box_mixin_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
12:07 +370 ~4 -22: rendering/ individual render_proxy_box_mixin_test.dart
[METRIC] script=rendering/render_proxy_box_mixin_test.dart sourceBytes=67099 sourceChars=67099 bundleJsonBytes=1024162 clearMs=21762 readMs=85 bundleMs=26 httpMs=123483 totalMs=145357 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

---

## 44. secondary_classes_test.dart : rendering/render_proxy_box_with_hit_test_behavior_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2872:7             main.<fn>.<fn>
```

### Log error output

```
12:18 +383 ~4 -22: rendering/ individual render_proxy_box_with_hit_test_behavior_test.dart
[METRIC] script=rendering/render_proxy_box_with_hit_test_behavior_test.dart sourceBytes=65726 sourceChars=65726 bundleJsonBytes=1052381 clearMs=115388 readMs=4 bundleMs=44 httpMs=10896 totalMs=126333 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

---

## 45. secondary_classes_test.dart : rendering/render_repaint_boundary_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2879:7             main.<fn>.<fn>
```

### Log error output

```
12:18 +383 ~4 -22: rendering/ individual render_repaint_boundary_test.dart
[METRIC] script=rendering/render_repaint_boundary_test.dart sourceBytes=71441 sourceChars=71441 bundleJsonBytes=1100964 clearMs=85385 readMs=52 bundleMs=27 httpMs=10867 totalMs=96332 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

---

## 46. secondary_classes_test.dart : rendering/render_rotated_box_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 2886:7             main.<fn>.<fn>
```

### Log error output

```
12:18 +383 ~4 -22: rendering/ individual render_rotated_box_test.dart
[METRIC] script=rendering/render_rotated_box_test.dart sourceBytes=68746 sourceChars=68743 bundleJsonBytes=1054313 clearMs=55381 readMs=83 bundleMs=26 httpMs=10830 totalMs=66322 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

---

## 47. secondary_classes_test.dart : services/text_layout_metrics_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 3479:7             main.<fn>.<fn>
```

### Log error output

```
15:17 +447 ~4 -29: services/ individual text_layout_metrics_test.dart
[METRIC] script=services/text_layout_metrics_test.dart sourceBytes=37913 sourceChars=37681 bundleJsonBytes=397812 clearMs=2 readMs=1 bundleMs=22 httpMs=42122 totalMs=42149 status=error httpStatus=400 outputLines=29 frameworkErrors=0
```

---

## 48. secondary_classes_test.dart : widgets/scrollable_test.dart

**Test Failure** — **Framework Errors** (2) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
33:14 +549 ~4 -66: widgets/ individual scrollable_test.dart
[METRIC] script=widgets/scrollable_test.dart sourceBytes=45067 sourceChars=41981 bundleJsonBytes=485403 clearMs=2 readMs=0 bundleMs=23 httpMs=790581 totalMs=790608 status=success httpStatus=200 outputLines=0 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in widgets/scrollable_test.dart (2 error(s)):
       Stack Overflow
       Stack Overflow
```

---

## 49. secondary_classes_test.dart : widgets/selectable_region_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4277:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual selectable_region_test.dart
[METRIC] script=widgets/selectable_region_test.dart sourceBytes=54524 sourceChars=54500 bundleJsonBytes=606867 clearMs=760608 readMs=19 bundleMs=27 httpMs=10864 totalMs=771520 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 50. secondary_classes_test.dart : widgets/selection_container_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4284:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual selection_container_test.dart
[METRIC] script=widgets/selection_container_test.dart sourceBytes=48287 sourceChars=48269 bundleJsonBytes=514460 clearMs=730604 readMs=51 bundleMs=20 httpMs=10919 totalMs=741597 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 51. secondary_classes_test.dart : widgets/selection_listener_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4291:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual selection_listener_test.dart
[METRIC] script=widgets/selection_listener_test.dart sourceBytes=44656 sourceChars=44640 bundleJsonBytes=508667 clearMs=700601 readMs=75 bundleMs=12 httpMs=11009 totalMs=711700 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 52. secondary_classes_test.dart : widgets/selection_overlay_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4298:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual selection_overlay_test.dart
[METRIC] script=widgets/selection_overlay_test.dart sourceBytes=46130 sourceChars=46116 bundleJsonBytes=495651 clearMs=670598 readMs=91 bundleMs=15 httpMs=10993 totalMs=681698 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 53. secondary_classes_test.dart : widgets/shader_mask_test.dart

**Test Failure** — **Framework Errors** (1) — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4303:7             main.<fn>.<fn>
```

### Log error output

```
03:13 +0 -75: Section 2 - Bridge Generator Issues (80) widgets/shader_mask_test.dart
[METRIC] script=widgets/shader_mask_test.dart sourceBytes=46753 sourceChars=42225 bundleJsonBytes=504143 clearMs=20 readMs=1 bundleMs=24 httpMs=107 totalMs=153 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/shader_mask_test.dart (1 error(s)):
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
```

---

## 54. secondary_classes_test.dart : widgets/shared_app_data_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4310:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual shared_app_data_test.dart
[METRIC] script=widgets/shared_app_data_test.dart sourceBytes=48728 sourceChars=48718 bundleJsonBytes=569323 clearMs=610592 readMs=124 bundleMs=17 httpMs=11075 totalMs=621810 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 55. secondary_classes_test.dart : widgets/shrink_wrapping_viewport_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4317:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual shrink_wrapping_viewport_test.dart
[METRIC] script=widgets/shrink_wrapping_viewport_test.dart sourceBytes=73919 sourceChars=73860 bundleJsonBytes=854951 clearMs=580588 readMs=144 bundleMs=23 httpMs=11114 totalMs=591870 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 56. secondary_classes_test.dart : widgets/single_child_render_object_element_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4324:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual single_child_render_object_element_test.dart
[METRIC] script=widgets/single_child_render_object_element_test.dart sourceBytes=56828 sourceChars=55393 bundleJsonBytes=587974 clearMs=550585 readMs=170 bundleMs=14 httpMs=11099 totalMs=561869 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 57. secondary_classes_test.dart : widgets/single_child_render_object_widget_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4331:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual single_child_render_object_widget_test.dart
[METRIC] script=widgets/single_child_render_object_widget_test.dart sourceBytes=55271 sourceChars=53857 bundleJsonBytes=545331 clearMs=520582 readMs=187 bundleMs=15 httpMs=11083 totalMs=531868 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 58. secondary_classes_test.dart : widgets/single_ticker_provider_state_mixin_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4338:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual single_ticker_provider_state_mixin_test.dart
[METRIC] script=widgets/single_ticker_provider_state_mixin_test.dart sourceBytes=933 sourceChars=931 bundleJsonBytes=10377 clearMs=490578 readMs=205 bundleMs=0 httpMs=11082 totalMs=501866 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 59. secondary_classes_test.dart : widgets/sliver_animated_grid_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4345:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_animated_grid_test.dart
[METRIC] script=widgets/sliver_animated_grid_test.dart sourceBytes=72430 sourceChars=72349 bundleJsonBytes=805038 clearMs=460575 readMs=205 bundleMs=23 httpMs=11061 totalMs=471866 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 60. secondary_classes_test.dart : widgets/sliver_animated_list_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4352:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_animated_list_test.dart
[METRIC] script=widgets/sliver_animated_list_test.dart sourceBytes=64989 sourceChars=64920 bundleJsonBytes=738562 clearMs=430570 readMs=232 bundleMs=17 httpMs=11042 totalMs=441863 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 61. secondary_classes_test.dart : widgets/sliver_animated_opacity_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4359:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_animated_opacity_test.dart
[METRIC] script=widgets/sliver_animated_opacity_test.dart sourceBytes=67890 sourceChars=67837 bundleJsonBytes=779290 clearMs=400568 readMs=253 bundleMs=38 httpMs=11002 totalMs=411863 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 62. secondary_classes_test.dart : widgets/sliver_constrained_cross_axis_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4366:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_constrained_cross_axis_test.dart
[METRIC] script=widgets/sliver_constrained_cross_axis_test.dart sourceBytes=105155 sourceChars=104989 bundleJsonBytes=996738 clearMs=370564 readMs=302 bundleMs=57 httpMs=10937 totalMs=381861 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 63. secondary_classes_test.dart : widgets/sliver_cross_axis_expanded_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4373:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_cross_axis_expanded_test.dart
[METRIC] script=widgets/sliver_cross_axis_expanded_test.dart sourceBytes=81612 sourceChars=81480 bundleJsonBytes=780713 clearMs=340564 readMs=361 bundleMs=25 httpMs=10910 totalMs=351861 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 64. secondary_classes_test.dart : widgets/sliver_cross_axis_group_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4380:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_cross_axis_group_test.dart
[METRIC] script=widgets/sliver_cross_axis_group_test.dart sourceBytes=78184 sourceChars=78108 bundleJsonBytes=794690 clearMs=310561 readMs=389 bundleMs=18 httpMs=10890 totalMs=321861 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 65. secondary_classes_test.dart : widgets/sliver_floating_header_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4387:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -67: widgets/ individual sliver_floating_header_test.dart
[METRIC] script=widgets/sliver_floating_header_test.dart sourceBytes=59773 sourceChars=59749 bundleJsonBytes=614200 clearMs=280558 readMs=411 bundleMs=16 httpMs=10873 totalMs=291859 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 66. secondary_classes_test.dart : widgets/sliver_ignore_pointer_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4394:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_ignore_pointer_test.dart
[METRIC] script=widgets/sliver_ignore_pointer_test.dart sourceBytes=51217 sourceChars=51165 bundleJsonBytes=495549 clearMs=250555 readMs=430 bundleMs=12 httpMs=10806 totalMs=261805 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 67. secondary_classes_test.dart : widgets/sliver_layout_builder_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4401:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_layout_builder_test.dart
[METRIC] script=widgets/sliver_layout_builder_test.dart sourceBytes=56353 sourceChars=56331 bundleJsonBytes=584018 clearMs=220552 readMs=444 bundleMs=16 httpMs=10790 totalMs=231804 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 68. secondary_classes_test.dart : widgets/sliver_main_axis_group_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4408:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_main_axis_group_test.dart
[METRIC] script=widgets/sliver_main_axis_group_test.dart sourceBytes=47566 sourceChars=47550 bundleJsonBytes=524926 clearMs=190549 readMs=463 bundleMs=12 httpMs=10778 totalMs=201804 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 69. secondary_classes_test.dart : widgets/sliver_offstage_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4415:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_offstage_test.dart
[METRIC] script=widgets/sliver_offstage_test.dart sourceBytes=54000 sourceChars=53940 bundleJsonBytes=580897 clearMs=160546 readMs=478 bundleMs=16 httpMs=10762 totalMs=171803 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 70. secondary_classes_test.dart : widgets/sliver_prototype_extent_list_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4422:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_prototype_extent_list_test.dart
[METRIC] script=widgets/sliver_prototype_extent_list_test.dart sourceBytes=43024 sourceChars=42992 bundleJsonBytes=472267 clearMs=130543 readMs=510 bundleMs=13 httpMs=10739 totalMs=141806 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 71. secondary_classes_test.dart : widgets/sliver_reorderable_list_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

### Exception

```
dart:isolate  _RawReceivePort._handleMessage
```

### Log error output

```
33:18 +549 ~4 -66: widgets/ individual sliver_reorderable_list_test.dart
[METRIC] script=widgets/sliver_reorderable_list_test.dart sourceBytes=44070 sourceChars=44054 bundleJsonBytes=503428 clearMs=100541 readMs=549 bundleMs=13 httpMs=2880 totalMs=103984 status=success httpStatus=200 outputLines=44 frameworkErrors=0
```

---

## 72. secondary_classes_test.dart : widgets/sliver_resizing_header_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4436:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_resizing_header_test.dart
[METRIC] script=widgets/sliver_resizing_header_test.dart sourceBytes=37962 sourceChars=37936 bundleJsonBytes=423114 clearMs=70537 readMs=495 bundleMs=10 httpMs=10752 totalMs=81795 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 73. secondary_classes_test.dart : widgets/sliver_safe_area_test.dart

**Test Failure** — ⏱️ **Timeout**

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [X] Timeout

### Error message

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts
```

```
Expected: true
  Actual: <false>
Build timed out after 10 seconds
```

### Exception

```
package:matcher                                     expect
package:flutter_test/src/widget_tester.dart 473:18  expect
test/secondary_classes_test.dart 4443:7             main.<fn>.<fn>
```

### Log error output

```
33:25 +549 ~4 -66: widgets/ individual sliver_safe_area_test.dart
[METRIC] script=widgets/sliver_safe_area_test.dart sourceBytes=41112 sourceChars=41104 bundleJsonBytes=435617 clearMs=40534 readMs=523 bundleMs=10 httpMs=10729 totalMs=51798 status=error httpStatus=400 outputLines=44 frameworkErrors=0
```

---

## 74. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/custom_painter_semantics_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Argument Error: Invalid parameter "semanticsBuilder": expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction
       A RenderFlex overflowed by 3.0 pixels on the bottom.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
02:56 +333 ~4 -6: rendering/ individual custom_painter_semantics_test.dart
[METRIC] script=rendering/custom_painter_semantics_test.dart sourceBytes=40868 sourceChars=39562 bundleJsonBytes=464735 clearMs=2 readMs=1 bundleMs=22 httpMs=280 totalMs=306 status=success httpStatus=200 outputLines=10 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in rendering/custom_painter_semantics_test.dart (2 error(s)):
       Argument Error: Invalid parameter "semanticsBuilder": expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction
       A RenderFlex overflowed by 3.0 pixels on the bottom.
```

---

## 75. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/relayout_when_system_fonts_change_mixin_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_RelayoutHostWidget)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
03:00 +347 ~4 -6: rendering/ individual relayout_when_system_fonts_change_mixin_test.dart
[METRIC] script=rendering/relayout_when_system_fonts_change_mixin_test.dart sourceBytes=59802 sourceChars=59796 bundleJsonBytes=831593 clearMs=21 readMs=1 bundleMs=84 httpMs=287 totalMs=394 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/relayout_when_system_fonts_change_mixin_test.dart (1 error(s)):
       Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_RelayoutHostWidget)
```

---

## 76. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_absorb_pointer_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_AbsorbGateHost)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
03:00 +348 ~4 -6: rendering/ individual render_absorb_pointer_test.dart
[METRIC] script=rendering/render_absorb_pointer_test.dart sourceBytes=57872 sourceChars=57866 bundleJsonBytes=841188 clearMs=29 readMs=1 bundleMs=45 httpMs=217 totalMs=293 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/render_absorb_pointer_test.dart (1 error(s)):
       Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_AbsorbGateHost)
```

---

## 77. generator_interpreter_issues_test.dart, secondary_classes_test.dart : rendering/render_aligning_shifted_box_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Undefined property or method 'characters' on bridged instance of 'String'.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
03:01 +349 ~4 -6: rendering/ individual render_aligning_shifted_box_test.dart
[METRIC] script=rendering/render_aligning_shifted_box_test.dart sourceBytes=50968 sourceChars=50968 bundleJsonBytes=738529 clearMs=2 readMs=0 bundleMs=40 httpMs=114 totalMs=157 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/render_aligning_shifted_box_test.dart (1 error(s)):
       Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Undefined property or method 'characters' on bridged instance of 'String'.
```

---

## 78. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : rendering/render_shrink_wrapping_viewport_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Error during constructor execution for class '_SizeReporter': Bridged superclass 'SingleChildRenderObjectWidget' does not have a constructor named ''. Check bridge definition.
12:10 +374 ~4 -22: rendering/ individual render_sized_overflow_box_test.dart
[METRIC] script=rendering/render_sized_overflow_box_test.dart sourceBytes=67500 sourceChars=67485 bundleJsonBytes=804265 clearMs=31 readMs=1 bundleMs=51 httpMs=791 totalMs=875 status=success httpStatus=200 outputLines=0 frameworkErrors=0
12:10 +375 ~4 -22: rendering/ individual render_sliver_animated_opacity_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
12:09 +373 ~4 -22: rendering/ individual render_shrink_wrapping_viewport_test.dart
[METRIC] script=rendering/render_shrink_wrapping_viewport_test.dart sourceBytes=64567 sourceChars=64561 bundleJsonBytes=757690 clearMs=24 readMs=0 bundleMs=37 httpMs=375 totalMs=438 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/render_shrink_wrapping_viewport_test.dart (1 error(s)):
       Runtime Error: Error during constructor execution for class '_SizeReporter': Bridged superclass 'SingleChildRenderObjectWidget' does not have a constructor named ''. Check bridge definition.
```

---

## 79. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/android_view_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.
15:49 +451 ~4 -31: widgets/ individual animated_align_test.dart
[METRIC] script=widgets/animated_align_test.dart sourceBytes=56405 sourceChars=51065 bundleJsonBytes=571953 clearMs=22 readMs=1 bundleMs=28 httpMs=875 totalMs=928 status=success httpStatus=200 outputLines=0 frameworkErrors=0
15:50 +452 ~4 -31: widgets/ individual animated_cross_fade_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
15:49 +450 ~4 -31: widgets/ individual android_view_test.dart
[METRIC] script=widgets/android_view_test.dart sourceBytes=62158 sourceChars=62158 bundleJsonBytes=822698 clearMs=24 readMs=0 bundleMs=45 httpMs=432 totalMs=502 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/android_view_test.dart (1 error(s)):
       Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.
```

---

## 80. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/animated_cross_fade_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
15:51 +453 ~4 -31: widgets/ individual animated_fractionally_sized_box_test.dart
[METRIC] script=widgets/animated_fractionally_sized_box_test.dart sourceBytes=937 sourceChars=935 bundleJsonBytes=10381 clearMs=3 readMs=0 bundleMs=1 httpMs=116 totalMs=122 status=success httpStatus=200 outputLines=0 frameworkErrors=0
15:51 +454 ~4 -31: widgets/ individual animated_modal_barrier_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
15:50 +452 ~4 -31: widgets/ individual animated_cross_fade_test.dart
[METRIC] script=widgets/animated_cross_fade_test.dart sourceBytes=58164 sourceChars=53052 bundleJsonBytes=606175 clearMs=24 readMs=1 bundleMs=31 httpMs=270 totalMs=327 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/animated_cross_fade_test.dart (1 error(s)):
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
```

---

## 81. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/animated_switcher_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
16:27 +459 ~4 -32: widgets/ individual autofill_group_test.dart
[METRIC] script=widgets/autofill_group_test.dart sourceBytes=66941 sourceChars=66941 bundleJsonBytes=926938 clearMs=25 readMs=0 bundleMs=29 httpMs=747 totalMs=803 status=success httpStatus=200 outputLines=0 frameworkErrors=2
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
16:27 +458 ~4 -32: widgets/ individual animated_switcher_test.dart
[METRIC] script=widgets/animated_switcher_test.dart sourceBytes=59624 sourceChars=54504 bundleJsonBytes=631989 clearMs=22 readMs=0 bundleMs=18 httpMs=238 totalMs=280 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/animated_switcher_test.dart (1 error(s)):
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
```

---

## 82. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/autofill_group_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillGroupLaneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillGroupLaneState.)
16:28 +460 ~4 -32: widgets/ individual backdrop_filter_test.dart
[METRIC] script=widgets/backdrop_filter_test.dart sourceBytes=49472 sourceChars=44654 bundleJsonBytes=483475 clearMs=2 readMs=1 bundleMs=23 httpMs=402 totalMs=430 status=success httpStatus=200 outputLines=0 frameworkErrors=1
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
16:27 +459 ~4 -32: widgets/ individual autofill_group_test.dart
[METRIC] script=widgets/autofill_group_test.dart sourceBytes=66941 sourceChars=66941 bundleJsonBytes=926938 clearMs=25 readMs=0 bundleMs=29 httpMs=747 totalMs=803 status=success httpStatus=200 outputLines=0 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in widgets/autofill_group_test.dart (2 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillGroupLaneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillGroupLaneState.)
```

---

## 83. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/backdrop_filter_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
16:28 +461 ~4 -32: widgets/ individual bouncing_scroll_physics_test.dart
[METRIC] script=widgets/bouncing_scroll_physics_test.dart sourceBytes=40856 sourceChars=40836 bundleJsonBytes=448487 clearMs=23 readMs=0 bundleMs=18 httpMs=1355 totalMs=1398 status=success httpStatus=200 outputLines=12 frameworkErrors=0
16:30 +462 ~4 -32: widgets/ individual build_owner_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
16:28 +460 ~4 -32: widgets/ individual backdrop_filter_test.dart
[METRIC] script=widgets/backdrop_filter_test.dart sourceBytes=49472 sourceChars=44654 bundleJsonBytes=483475 clearMs=2 readMs=1 bundleMs=23 httpMs=402 totalMs=430 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/backdrop_filter_test.dart (1 error(s)):
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
```

---

## 84. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/composited_transform_follower_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _LinkPrimerState.)
16:49 +468 ~4 -33: widgets/ individual composited_transform_target_test.dart
[METRIC] script=widgets/composited_transform_target_test.dart sourceBytes=78586 sourceChars=77782 bundleJsonBytes=972460 clearMs=2 readMs=1 bundleMs=48 httpMs=2371 totalMs=2423 status=success httpStatus=200 outputLines=37 frameworkErrors=0
16:51 +469 ~4 -33: widgets/ individual content_insertion_configuration_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
16:48 +467 ~4 -33: widgets/ individual composited_transform_follower_test.dart
[METRIC] script=widgets/composited_transform_follower_test.dart sourceBytes=66306 sourceChars=63812 bundleJsonBytes=745737 clearMs=23 readMs=0 bundleMs=23 httpMs=343 totalMs=390 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/composited_transform_follower_test.dart (1 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _LinkPrimerState.)
```

---

## 85. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/glowing_overscroll_indicator_test.dart

**Framework Errors** (7) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Native error during bridged operator '==' on Color: Argument Error: Invalid parameter "other": expected Obje…
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BaselineDualSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _NotificationControlSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _NestedDepthSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalCompositionSceneState.)
       type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast
       type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast
17:19 +480 ~4 -35: widgets/ individual html_element_view_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
17:17 +479 ~4 -35: widgets/ individual glowing_overscroll_indicator_test.dart
[METRIC] script=widgets/glowing_overscroll_indicator_test.dart sourceBytes=52718 sourceChars=52718 bundleJsonBytes=675666 clearMs=22 readMs=0 bundleMs=38 httpMs=1240 totalMs=1302 status=success httpStatus=200 outputLines=0 frameworkErrors=7

  ⚠️  FRAMEWORK ERROR in widgets/glowing_overscroll_indicator_test.dart (7 error(s)):
       Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Native error during bridged operator '==' on Color: Argument Error: Invalid parameter "other": expected Obje…
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BaselineDualSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _NotificationControlSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _NestedDepthSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalCompositionSceneState.)
       type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast
       type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast
```

---

## 86. generator_interpreter_issues_test.dart : widgets/html_element_view_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FromTagNamePlaygroundState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ElementCreatedSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _HitTestOverlaySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _VisibilityStrategySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalWorkspaceSceneState.)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
03:06 +0 -55: Section 2 - Bridge Generator Issues (80) widgets/html_element_view_test.dart
[METRIC] script=widgets/html_element_view_test.dart sourceBytes=59436 sourceChars=59436 bundleJsonBytes=787239 clearMs=3 readMs=0 bundleMs=78 httpMs=393 totalMs=475 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/html_element_view_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FromTagNamePlaygroundState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ElementCreatedSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _HitTestOverlaySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _VisibilityStrategySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalWorkspaceSceneState.)
```

---

## 87. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/image_filtered_test.dart

**Framework Errors** (6) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BlurMatrixSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _MorphologySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ComposeAnimationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ScopePatternSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalBoardSceneState.)
17:33 +481 ~4 -36: widgets/ individual implicitly_animated_widget_state_test.dart
[METRIC] script=widgets/implicitly_animated_widget_state_test.dart sourceBytes=29727 sourceChars=29162 bundleJsonBytes=230891 clearMs=21 readMs=0 bundleMs=11 httpMs=1767 totalMs=1800 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
17:32 +480 ~4 -36: widgets/ individual image_filtered_test.dart
[METRIC] script=widgets/image_filtered_test.dart sourceBytes=88772 sourceChars=88772 bundleJsonBytes=1282899 clearMs=3 readMs=0 bundleMs=49 httpMs=1585 totalMs=1639 status=success httpStatus=200 outputLines=0 frameworkErrors=6

  ⚠️  FRAMEWORK ERROR in widgets/image_filtered_test.dart (6 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BlurMatrixSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _MorphologySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ComposeAnimationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ScopePatternSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalBoardSceneState.)
```

---

## 88. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/indexed_stack_test.dart

**Framework Errors** (6) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _SelectionPatternsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _StatePersistenceSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BackgroundActivitySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ResponsiveRtlSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalWorkspaceSceneState.)
17:38 +484 ~4 -36: widgets/ individual inherited_element_test.dart
[METRIC] script=widgets/inherited_element_test.dart sourceBytes=29306 sourceChars=28647 bundleJsonBytes=231219 clearMs=2 readMs=0 bundleMs=12 httpMs=1888 totalMs=1904 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
17:37 +483 ~4 -36: widgets/ individual indexed_stack_test.dart
[METRIC] script=widgets/indexed_stack_test.dart sourceBytes=82895 sourceChars=82895 bundleJsonBytes=1197133 clearMs=22 readMs=0 bundleMs=52 httpMs=1254 totalMs=1329 status=success httpStatus=200 outputLines=0 frameworkErrors=6

  ⚠️  FRAMEWORK ERROR in widgets/indexed_stack_test.dart (6 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _SelectionPatternsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _StatePersistenceSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BackgroundActivitySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ResponsiveRtlSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalWorkspaceSceneState.)
```

---

## 89. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/inherited_theme_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during default bridged constructor for 'Directionality': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(PanelTheme)
17:42 +487 ~4 -36: widgets/ individual inherited_widget_test.dart
[METRIC] script=gestures/tap_and_drag_gesture_recognizer_test.dart sourceBytes=2531 sourceChars=2531 bundleJsonBytes=29790 clearMs=15 readMs=0 bundleMs=2 httpMs=10520 totalMs=10539 status=error httpStatus=400 outputLines=0 frameworkErrors=0
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
17:41 +486 ~4 -36: widgets/ individual inherited_theme_test.dart
[METRIC] script=widgets/inherited_theme_test.dart sourceBytes=93998 sourceChars=93998 bundleJsonBytes=1418191 clearMs=78 readMs=0 bundleMs=101 httpMs=578 totalMs=758 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/inherited_theme_test.dart (1 error(s)):
       Runtime Error: Native error during default bridged constructor for 'Directionality': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(PanelTheme)
```

---

## 90. generator_interpreter_issues_test.dart : widgets/inherited_widget_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during default bridged constructor for 'Directionality': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(AppStateScope)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
03:08 +0 -59: Section 2 - Bridge Generator Issues (80) widgets/inherited_widget_test.dart
[METRIC] script=widgets/inherited_widget_test.dart sourceBytes=88375 sourceChars=88375 bundleJsonBytes=1335922 clearMs=3 readMs=0 bundleMs=64 httpMs=126 totalMs=195 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/inherited_widget_test.dart (1 error(s)):
       Runtime Error: Native error during default bridged constructor for 'Directionality': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(AppStateScope)
```

---

## 91. generator_interpreter_issues_test.dart, secondary_classes_test.dart : widgets/layout_builder_adv_test.dart

**Framework Errors** (7) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)
       RenderCustomSingleChildLayoutBox object was given an infinite size during layout.
This probably means that it is a render object that tries to be as big as possible, but it was put inside another rend…
       RenderConstrainedOverflowBox object was given an infinite size during layout.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
01:59 +126 ~3 -4: widgets/ layout_builder_adv_test.dart
[METRIC] script=widgets/layout_builder_adv_test.dart sourceBytes=6748 sourceChars=6748 bundleJsonBytes=103329 clearMs=3 readMs=0 bundleMs=5 httpMs=210 totalMs=219 status=success httpStatus=200 outputLines=26 frameworkErrors=7

  ⚠️  FRAMEWORK ERROR in widgets/layout_builder_adv_test.dart (7 error(s)):
       Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)
       RenderCustomSingleChildLayoutBox object was given an infinite size during layout.
This probably means that it is a render object that tries to be as big as possible, but it was put inside another rend…
       RenderConstrainedOverflowBox object was given an infinite size during layout.
This probably means that it is a render object that tries to be as big as possible, but it was put inside another render o…
       RenderConstrainedOverflowBox object was given an infinite size during layout.
This probably means that it is a render object that tries to be as big as possible, but it was put inside another render o…
       RenderFlex object was given an infinite size during layout.
This probably means that it is a render object that tries to be as big as possible, but it was put inside another render object that allows …
       Rect argument contained a NaN value.
'dart:ui/painting.dart':
Failed assertion: line 26 pos 10: '<optimized out>'
       'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.
```

---

## 92. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/list_wheel_scroll_view_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _GeometrySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DelegateSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PhysicsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
18:09 +495 ~4 -37: widgets/ individual list_wheel_viewport_test.dart
[METRIC] script=widgets/list_wheel_viewport_test.dart sourceBytes=64231 sourceChars=64231 bundleJsonBytes=869353 clearMs=2 readMs=0 bundleMs=44 httpMs=1229 totalMs=1277 status=success httpStatus=200 outputLines=0 frameworkErrors=5
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:08 +494 ~4 -37: widgets/ individual list_wheel_scroll_view_test.dart
[METRIC] script=widgets/list_wheel_scroll_view_test.dart sourceBytes=62015 sourceChars=62015 bundleJsonBytes=846065 clearMs=22 readMs=0 bundleMs=45 httpMs=1210 totalMs=1279 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/list_wheel_scroll_view_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _GeometrySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DelegateSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PhysicsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
```

---

## 93. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/list_wheel_viewport_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _RawFoundationsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _GeometryForgeSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DelegateWorkshopSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ScrollPipelineSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalConsoleSceneState.)
18:11 +496 ~4 -37: widgets/ individual magnifier_controller_test.dart
[METRIC] script=widgets/magnifier_controller_test.dart sourceBytes=51171 sourceChars=49417 bundleJsonBytes=500637 clearMs=22 readMs=0 bundleMs=12 httpMs=2831 totalMs=2867 status=success httpStatus=200 outputLines=15 frameworkErrors=0
18:14 +497 ~4 -37: widgets/ individual magnifier_decoration_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:09 +495 ~4 -37: widgets/ individual list_wheel_viewport_test.dart
[METRIC] script=widgets/list_wheel_viewport_test.dart sourceBytes=64231 sourceChars=64231 bundleJsonBytes=869353 clearMs=2 readMs=0 bundleMs=44 httpMs=1229 totalMs=1277 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/list_wheel_viewport_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _RawFoundationsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _GeometryForgeSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DelegateWorkshopSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ScrollPipelineSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalConsoleSceneState.)
```

---

## 94. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/magnifier_decoration_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ShapeGallerySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ShadowSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _GeometrySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
18:15 +498 ~4 -37: widgets/ individual magnifier_info_test.dart
[METRIC] script=widgets/magnifier_info_test.dart sourceBytes=53014 sourceChars=51416 bundleJsonBytes=525828 clearMs=2 readMs=1 bundleMs=23 httpMs=2908 totalMs=2936 status=success httpStatus=200 outputLines=19 frameworkErrors=0
18:18 +499 ~4 -37: widgets/ individual multi_child_render_object_element_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:14 +497 ~4 -37: widgets/ individual magnifier_decoration_test.dart
[METRIC] script=widgets/magnifier_decoration_test.dart sourceBytes=58505 sourceChars=58505 bundleJsonBytes=827377 clearMs=23 readMs=0 bundleMs=25 httpMs=1086 totalMs=1135 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/magnifier_decoration_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ShapeGallerySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ShadowSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _GeometrySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
```

---

## 95. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/navigation_toolbar_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ComparisonSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ResponsiveSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DirectionalitySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
18:24 +502 ~4 -37: widgets/ individual never_scrollable_scroll_physics_test.dart
[METRIC] script=widgets/never_scrollable_scroll_physics_test.dart sourceBytes=50737 sourceChars=49231 bundleJsonBytes=476856 clearMs=2 readMs=0 bundleMs=20 httpMs=3459 totalMs=3484 status=success httpStatus=200 outputLines=21 frameworkErrors=0
18:28 +503 ~4 -37: widgets/ individual overflow_bar_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:23 +501 ~4 -37: widgets/ individual navigation_toolbar_test.dart
[METRIC] script=widgets/navigation_toolbar_test.dart sourceBytes=64095 sourceChars=64012 bundleJsonBytes=827922 clearMs=23 readMs=0 bundleMs=22 httpMs=1007 totalMs=1053 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/navigation_toolbar_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ComparisonSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ResponsiveSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DirectionalitySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
```

---

## 96. generator_interpreter_issues_test.dart, important_classes_test.dart : widgets/nestedscrollview_test.dart

**Framework Errors** (4) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:20 +46: widgets/ nestedscrollview_test.dart
[METRIC] script=widgets/nestedscrollview_test.dart sourceBytes=2795 sourceChars=2795 bundleJsonBytes=40206 clearMs=33 readMs=0 bundleMs=3 httpMs=151 totalMs=190 status=success httpStatus=200 outputLines=6 frameworkErrors=4

  ⚠️  FRAMEWORK ERROR in widgets/nestedscrollview_test.dart (4 error(s)):
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

---

## 97. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/overflow_bar_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _MechanicsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AlignmentSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DialogSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DirectionalitySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
18:29 +504 ~4 -37: widgets/ individual overflow_box_test.dart
[METRIC] script=widgets/overflow_box_test.dart sourceBytes=75480 sourceChars=75480 bundleJsonBytes=1017545 clearMs=2 readMs=0 bundleMs=45 httpMs=1165 totalMs=1214 status=success httpStatus=200 outputLines=0 frameworkErrors=5
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:28 +503 ~4 -37: widgets/ individual overflow_bar_test.dart
[METRIC] script=widgets/overflow_bar_test.dart sourceBytes=70015 sourceChars=70015 bundleJsonBytes=924812 clearMs=22 readMs=0 bundleMs=23 httpMs=1278 totalMs=1325 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/overflow_bar_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _MechanicsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AlignmentSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DialogSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _DirectionalitySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
```

---

## 98. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/overflow_box_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AlignmentMatrixSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _NegotiationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AnnotationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
18:30 +505 ~4 -37: widgets/ individual page_scroll_physics_test.dart
[METRIC] script=widgets/page_scroll_physics_test.dart sourceBytes=63928 sourceChars=62172 bundleJsonBytes=617694 clearMs=22 readMs=1 bundleMs=36 httpMs=13477 totalMs=13537 status=success httpStatus=200 outputLines=22 frameworkErrors=0
18:44 +506 ~4 -37: widgets/ individual page_storage_bucket_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:29 +504 ~4 -37: widgets/ individual overflow_box_test.dart
[METRIC] script=widgets/overflow_box_test.dart sourceBytes=75480 sourceChars=75480 bundleJsonBytes=1017545 clearMs=2 readMs=0 bundleMs=45 httpMs=1165 totalMs=1214 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/overflow_box_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _FundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AlignmentMatrixSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _NegotiationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AnnotationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalSceneState.)
```

---

## 99. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/page_storage_bucket_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BucketFundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ReadWriteConsoleSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _MultiBucketIsolationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _RouteLikePersistenceSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalModulesSceneState.)
18:45 +507 ~4 -37: widgets/ individual page_storage_key_test.dart
[METRIC] script=widgets/page_storage_key_test.dart sourceBytes=58677 sourceChars=44729 bundleJsonBytes=443377 clearMs=3 readMs=1 bundleMs=19 httpMs=644 totalMs=668 status=success httpStatus=200 outputLines=614 frameworkErrors=0
18:46 +508 ~4 -37: widgets/ individual page_storage_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:44 +506 ~4 -37: widgets/ individual page_storage_bucket_test.dart
[METRIC] script=widgets/page_storage_bucket_test.dart sourceBytes=84402 sourceChars=84402 bundleJsonBytes=1074109 clearMs=22 readMs=0 bundleMs=79 httpMs=1110 totalMs=1213 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/page_storage_bucket_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _BucketFundamentalsSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ReadWriteConsoleSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _MultiBucketIsolationSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _RouteLikePersistenceSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalModulesSceneState.)
```

---

## 100. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/page_storage_test.dart

**Framework Errors** (5) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ScopeStudioSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AccessLabSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _KeyedScrollGallerySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _LifecycleSwapSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalBoardSceneState.)
18:47 +509 ~4 -37: widgets/ individual parent_data_element_test.dart
[METRIC] script=widgets/parent_data_element_test.dart sourceBytes=57926 sourceChars=45016 bundleJsonBytes=435851 clearMs=2 readMs=1 bundleMs=21 httpMs=1203 totalMs=1228 status=success httpStatus=200 outputLines=525 frameworkErrors=0
18:48 +510 ~4 -37: widgets/ individual parent_data_widget_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:46 +508 ~4 -37: widgets/ individual page_storage_test.dart
[METRIC] script=widgets/page_storage_test.dart sourceBytes=77358 sourceChars=77358 bundleJsonBytes=1086776 clearMs=3 readMs=1 bundleMs=51 httpMs=1057 totalMs=1114 status=success httpStatus=200 outputLines=0 frameworkErrors=5

  ⚠️  FRAMEWORK ERROR in widgets/page_storage_test.dart (5 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ScopeStudioSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AccessLabSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _KeyedScrollGallerySceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _LifecycleSwapSceneState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PracticalBoardSceneState.)
```

---

## 101. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/parent_data_widget_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on _DemoLayoutDelegate.)
       'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.
18:50 +511 ~4 -37: widgets/ individual performance_overlay_test.dart
[METRIC] script=widgets/performance_overlay_test.dart sourceBytes=86061 sourceChars=85981 bundleJsonBytes=1094825 clearMs=3 readMs=1 bundleMs=61 httpMs=745 totalMs=811 status=success httpStatus=200 outputLines=0 frameworkErrors=0
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:48 +510 ~4 -37: widgets/ individual parent_data_widget_test.dart
[METRIC] script=widgets/parent_data_widget_test.dart sourceBytes=62828 sourceChars=51226 bundleJsonBytes=496635 clearMs=3 readMs=1 bundleMs=23 httpMs=1400 totalMs=1428 status=success httpStatus=200 outputLines=456 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in widgets/parent_data_widget_test.dart (2 error(s)):
       Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on _DemoLayoutDelegate.)
       'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.
```

---

## 102. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/physical_model_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
18:51 +513 ~4 -37: widgets/ individual physical_shape_test.dart
[METRIC] script=widgets/physical_shape_test.dart sourceBytes=43500 sourceChars=43460 bundleJsonBytes=513319 clearMs=2 readMs=1 bundleMs=22 httpMs=2213 totalMs=2240 status=success httpStatus=200 outputLines=25 frameworkErrors=0
18:53 +514 ~4 -37: widgets/ individual pinned_header_sliver_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
18:50 +512 ~4 -37: widgets/ individual physical_model_test.dart
[METRIC] script=widgets/physical_model_test.dart sourceBytes=53034 sourceChars=47920 bundleJsonBytes=540955 clearMs=3 readMs=1 bundleMs=26 httpMs=383 totalMs=414 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/physical_model_test.dart (1 error(s)):
       Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
```

---

## 103. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/render_object_element_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during default bridged constructor for 'Container': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_DemoInsetWidget)
19:42 +532 ~4 -37: widgets/ individual render_object_widget_test.dart
[METRIC] script=widgets/render_object_widget_test.dart sourceBytes=33947 sourceChars=32809 bundleJsonBytes=419827 clearMs=23 readMs=0 bundleMs=22 httpMs=1254 totalMs=1300 status=success httpStatus=200 outputLines=4 frameworkErrors=1
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
19:39 +531 ~4 -37: widgets/ individual render_object_element_test.dart
[METRIC] script=widgets/render_object_element_test.dart sourceBytes=37302 sourceChars=36294 bundleJsonBytes=381705 clearMs=22 readMs=0 bundleMs=17 httpMs=3011 totalMs=3051 status=success httpStatus=200 outputLines=4 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/render_object_element_test.dart (1 error(s)):
       Runtime Error: Native error during default bridged constructor for 'Container': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_DemoInsetWidget)
```

---

## 104. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/render_object_widget_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during default bridged constructor for 'Center': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_DemoColorSwatch)
19:44 +533 ~4 -37: widgets/ individual restorable_bool_test.dart
[METRIC] script=widgets/restorable_bool_test.dart sourceBytes=928 sourceChars=926 bundleJsonBytes=10372 clearMs=3 readMs=0 bundleMs=2 httpMs=158 totalMs=164 status=success httpStatus=200 outputLines=0 frameworkErrors=0
19:44 +534 ~4 -37: widgets/ individual restorable_date_time_test.dart
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
19:42 +532 ~4 -37: widgets/ individual render_object_widget_test.dart
[METRIC] script=widgets/render_object_widget_test.dart sourceBytes=33947 sourceChars=32809 bundleJsonBytes=419827 clearMs=23 readMs=0 bundleMs=22 httpMs=1254 totalMs=1300 status=success httpStatus=200 outputLines=4 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/render_object_widget_test.dart (1 error(s)):
       Runtime Error: Native error during default bridged constructor for 'Center': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_DemoColorSwatch)
```

---

## 105. generator_interpreter_issues_test.dart, hardly_relevant_classes_5_test.dart : widgets/render_tree_root_element_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged method call 'visitAncestorElements' on StatelessElement: LateInitializationError: Field '_children@28042623' has not been initialized.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:27 +35 -11: widgets/ render_tree_root_element_test.dart
[METRIC] script=widgets/render_tree_root_element_test.dart sourceBytes=11889 sourceChars=11889 bundleJsonBytes=114775 clearMs=3 readMs=1 bundleMs=8 httpMs=280 totalMs=293 status=success httpStatus=200 outputLines=11 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/render_tree_root_element_test.dart (1 error(s)):
       Runtime Error: Native error during bridged method call 'visitAncestorElements' on StatelessElement: LateInitializationError: Field '_children@28042623' has not been initialized.
```

---

## 106. generator_interpreter_issues_test.dart, important_classes_test.dart : widgets/slidetransition_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments.
Receiver: Instance of '$RelaxedAnimation<Offset>'
Tried calling: addListener(Closure:…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:17 +27: widgets/ slidetransition_test.dart
[METRIC] script=widgets/slidetransition_test.dart sourceBytes=6068 sourceChars=6058 bundleJsonBytes=83546 clearMs=4 readMs=0 bundleMs=5 httpMs=163 totalMs=173 status=success httpStatus=200 outputLines=11 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/slidetransition_test.dart (1 error(s)):
       NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments.
Receiver: Instance of '$RelaxedAnimation<Offset>'
Tried calling: addListener(Closure:…
```

---

## 107. generator_interpreter_issues_test.dart, hardly_relevant_classes_1_test.dart, secondary_classes_test.dart : widgets/stateful_element_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _TrackedChildState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _CounterChildState.)
33:34 +553 ~4 -67: widgets/ individual stateless_element_test.dart
[METRIC] script=widgets/stateless_element_test.dart sourceBytes=28085 sourceChars=28085 bundleJsonBytes=387057 clearMs=70 readMs=0 bundleMs=16 httpMs=2540 totalMs=2629 status=success httpStatus=200 outputLines=0 frameworkErrors=2
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
33:31 +552 ~4 -67: widgets/ individual stateful_element_test.dart
[METRIC] script=widgets/stateful_element_test.dart sourceBytes=35605 sourceChars=34474 bundleJsonBytes=421913 clearMs=24 readMs=0 bundleMs=20 httpMs=3158 totalMs=3204 status=success httpStatus=200 outputLines=4 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in widgets/stateful_element_test.dart (2 error(s)):
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _TrackedChildState.)
       Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _CounterChildState.)
```

---

## 108. generator_interpreter_issues_test.dart, hardly_relevant_classes_5_test.dart : widgets/transition_delegate_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _DefaultDemoPageState.)
       Runtime Error: Native error during default bridged constructor for 'Navigator': Argument Error: Invalid parameter "transitionDelegate": expected TransitionDelegate<dynamic>, got InterpretedInstance(_I…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:50 +144 -31: widgets/ transition_delegate_test.dart
[METRIC] script=widgets/transition_delegate_test.dart sourceBytes=34960 sourceChars=33755 bundleJsonBytes=396518 clearMs=3 readMs=1 bundleMs=21 httpMs=469 totalMs=494 status=success httpStatus=200 outputLines=4 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in widgets/transition_delegate_test.dart (2 error(s)):
       Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _DefaultDemoPageState.)
       Runtime Error: Native error during default bridged constructor for 'Navigator': Argument Error: Invalid parameter "transitionDelegate": expected TransitionDelegate<dynamic>, got InterpretedInstance(_I…
```

---

## 109. generator_interpreter_issues_test.dart, hardly_relevant_classes_5_test.dart : widgets/window_scope_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       type 'InterpretedInstance' is not a subtype of type 'Widget' in type cast
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:57 +189 -36: widgets/ window_scope_test.dart
[METRIC] script=widgets/window_scope_test.dart sourceBytes=27119 sourceChars=27119 bundleJsonBytes=367296 clearMs=26 readMs=0 bundleMs=30 httpMs=77 totalMs=136 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/window_scope_test.dart (1 error(s)):
       type 'InterpretedInstance' is not a subtype of type 'Widget' in type cast
```

---

## 110. generator_interpreter_retest_test.dart : retest/dart_ui/key_event_type_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined property or method 'label' on bridged instance of 'Key'.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:12 +0 -1: Section 1 - Tests with workarounds reverted retest: dart_ui/key_event_type_test.dart
[METRIC] script=retest/dart_ui/key_event_type_test.dart sourceBytes=36897 sourceChars=36897 bundleJsonBytes=612822 clearMs=30 readMs=1 bundleMs=126 httpMs=431 totalMs=590 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/dart_ui/key_event_type_test.dart (1 error(s)):
       Runtime Error: Undefined property or method 'label' on bridged instance of 'Key'.
```

---

## 111. generator_interpreter_retest_test.dart : retest/material/button_bar_theme_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme)
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:14 +5 ~1 -3: Section 1 - Tests with workarounds reverted retest: material/button_bar_theme_test.dart
[METRIC] script=retest/material/button_bar_theme_test.dart sourceBytes=26697 sourceChars=26697 bundleJsonBytes=344429 clearMs=44 readMs=0 bundleMs=32 httpMs=371 totalMs=448 status=success httpStatus=200 outputLines=0 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in retest/material/button_bar_theme_test.dart (2 error(s)):
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme)
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme)
```

---

## 112. generator_interpreter_retest_test.dart : retest/material/gapped_range_slider_track_shape_test.dart

**Framework Errors** (18) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:16 +8 ~1 -4: Section 1 - Tests with workarounds reverted retest: material/gapped_range_slider_track_shape_test.dart
[METRIC] script=retest/material/gapped_range_slider_track_shape_test.dart sourceBytes=35597 sourceChars=35597 bundleJsonBytes=433180 clearMs=26 readMs=0 bundleMs=39 httpMs=488 totalMs=555 status=success httpStatus=200 outputLines=42 frameworkErrors=18

  ⚠️  FRAMEWORK ERROR in retest/material/gapped_range_slider_track_shape_test.dart (18 error(s)):
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
       Null check operator used on a null value
```

---

## 113. generator_interpreter_retest_test.dart : retest/material/theme_extension_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged method call 'copyWith' on ThemeData: Argument Error: Invalid parameter "extensions": cannot convert List to List<ThemeExtension<dynamic>> - type 'Interpreted…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:20 +12 ~1 -6: Section 1 - Tests with workarounds reverted retest: material/theme_extension_test.dart
[METRIC] script=retest/material/theme_extension_test.dart sourceBytes=48728 sourceChars=48728 bundleJsonBytes=765174 clearMs=3 readMs=1 bundleMs=74 httpMs=233 totalMs=312 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/material/theme_extension_test.dart (1 error(s)):
       Runtime Error: Native error during bridged method call 'copyWith' on ThemeData: Argument Error: Invalid parameter "extensions": cannot convert List to List<ThemeExtension<dynamic>> - type 'Interpreted…
```

---

## 114. generator_interpreter_retest_test.dart : retest/material/toggle_buttons_theme_data_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:20 +12 ~1 -7: Section 1 - Tests with workarounds reverted retest: material/toggle_buttons_theme_data_test.dart
[METRIC] script=retest/material/toggle_buttons_theme_data_test.dart sourceBytes=48130 sourceChars=48130 bundleJsonBytes=703543 clearMs=50 readMs=1 bundleMs=49 httpMs=120 totalMs=221 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/material/toggle_buttons_theme_data_test.dart (1 error(s)):
       Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null
```

---

## 115. generator_interpreter_retest_test.dart : retest/material/toggle_buttons_theme_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:21 +12 ~1 -8: Section 1 - Tests with workarounds reverted retest: material/toggle_buttons_theme_test.dart
[METRIC] script=retest/material/toggle_buttons_theme_test.dart sourceBytes=56958 sourceChars=56958 bundleJsonBytes=766828 clearMs=19 readMs=0 bundleMs=45 httpMs=102 totalMs=168 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/material/toggle_buttons_theme_test.dart (1 error(s)):
       Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null
```

---

## 116. generator_interpreter_retest_test.dart : retest/painting/axis_direction_test.dart

**Framework Errors** (4) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       A RenderFlex overflowed by 13 pixels on the bottom.
       A RenderFlex overflowed by 51 pixels on the right.
       A RenderFlex overflowed by 13 pixels on the bottom.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:21 +12 ~1 -9: Section 1 - Tests with workarounds reverted retest: painting/axis_direction_test.dart
[METRIC] script=retest/painting/axis_direction_test.dart sourceBytes=44143 sourceChars=43905 bundleJsonBytes=629268 clearMs=3 readMs=1 bundleMs=48 httpMs=689 totalMs=742 status=success httpStatus=200 outputLines=29 frameworkErrors=4

  ⚠️  FRAMEWORK ERROR in retest/painting/axis_direction_test.dart (4 error(s)):
       A RenderFlex overflowed by 13 pixels on the bottom.
       A RenderFlex overflowed by 51 pixels on the right.
       A RenderFlex overflowed by 13 pixels on the bottom.
       A RenderFlex overflowed by 51 pixels on the right.
```

---

## 117. generator_interpreter_retest_test.dart : retest/rendering/render_animated_size_state_test.dart

**Framework Errors** (2) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during default bridged constructor for 'ConstrainedBox': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_MeasureBox)
       A RenderFlex overflowed by 2.0 pixels on the bottom.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:37 +14 ~1 -21: Section 1 - Tests with workarounds reverted retest: rendering/render_animated_size_state_test.dart
[METRIC] script=retest/rendering/render_animated_size_state_test.dart sourceBytes=62304 sourceChars=62304 bundleJsonBytes=876175 clearMs=3 readMs=0 bundleMs=78 httpMs=313446 totalMs=313529 status=success httpStatus=200 outputLines=0 frameworkErrors=2

  ⚠️  FRAMEWORK ERROR in retest/rendering/render_animated_size_state_test.dart (2 error(s)):
       Runtime Error: Native error during default bridged constructor for 'ConstrainedBox': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_MeasureBox)
       A RenderFlex overflowed by 2.0 pixels on the bottom.
```

---

## 118. generator_interpreter_retest_test.dart : retest/widgets/app_kit_view_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:37 +14 ~1 -21: Section 1 - Tests with workarounds reverted retest: widgets/app_kit_view_test.dart
[METRIC] script=retest/widgets/app_kit_view_test.dart sourceBytes=69754 sourceChars=69754 bundleJsonBytes=955514 clearMs=163533 readMs=92 bundleMs=38 httpMs=349 totalMs=164012 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/widgets/app_kit_view_test.dart (1 error(s)):
       Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.
```

---

## 119. generator_interpreter_retest_test.dart : retest/widgets/default_text_editing_shortcuts_test.dart

**Framework Errors** (4) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:38 +14 ~1 -21: Section 1 - Tests with workarounds reverted retest: widgets/default_text_editing_shortcuts_test.dart
[METRIC] script=retest/widgets/default_text_editing_shortcuts_test.dart sourceBytes=38581 sourceChars=38581 bundleJsonBytes=467959 clearMs=13511 readMs=263 bundleMs=15 httpMs=854 totalMs=14644 status=success httpStatus=200 outputLines=0 frameworkErrors=4

  ⚠️  FRAMEWORK ERROR in retest/widgets/default_text_editing_shortcuts_test.dart (4 error(s)):
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
       Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…
```

---

## 120. generator_interpreter_retest_test.dart : retest/widgets/nested_scroll_view_state_test.dart

**Framework Errors** (3) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:40 +16 ~1 -22: Section 1 - Tests with workarounds reverted retest: widgets/nested_scroll_view_state_test.dart
[METRIC] script=retest/widgets/nested_scroll_view_state_test.dart sourceBytes=55662 sourceChars=54210 bundleJsonBytes=525141 clearMs=92 readMs=1 bundleMs=34 httpMs=512 totalMs=640 status=success httpStatus=200 outputLines=19 frameworkErrors=3

  ⚠️  FRAMEWORK ERROR in retest/widgets/nested_scroll_view_state_test.dart (3 error(s)):
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

---

## 121. generator_interpreter_retest_test.dart : retest/widgets/next_focus_intent_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during static bridged method call 'maybeFind' on Actions: 'package:flutter/src/widgets/actions.dart': Failed assertion: line 866 pos 7: 'type != Intent': The type passed to…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:41 +16 ~1 -23: Section 1 - Tests with workarounds reverted retest: widgets/next_focus_intent_test.dart
[METRIC] script=retest/widgets/next_focus_intent_test.dart sourceBytes=50650 sourceChars=49030 bundleJsonBytes=470957 clearMs=80 readMs=1 bundleMs=32 httpMs=517 totalMs=631 status=success httpStatus=200 outputLines=17 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/widgets/next_focus_intent_test.dart (1 error(s)):
       Runtime Error: Native error during static bridged method call 'maybeFind' on Actions: 'package:flutter/src/widgets/actions.dart': Failed assertion: line 866 pos 7: 'type != Intent': The type passed to…
```

---

## 122. generator_interpreter_retest_test.dart : retest/widgets/object_key_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Undefined variable: identityHashCode
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:41 +16 ~1 -24: Section 1 - Tests with workarounds reverted retest: widgets/object_key_test.dart
[METRIC] script=retest/widgets/object_key_test.dart sourceBytes=49180 sourceChars=47530 bundleJsonBytes=472940 clearMs=3 readMs=1 bundleMs=41 httpMs=713 totalMs=759 status=success httpStatus=200 outputLines=26 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/widgets/object_key_test.dart (1 error(s)):
       Runtime Error: Undefined variable: identityHashCode
```

---

## 123. generator_interpreter_retest_test.dart : retest/widgets/raw_dialog_route_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Error in generic constructor factory for 'RawDialogRoute': type 'InterpretedFunction' is not a subtype of type '((BuildContext, Animation<double>, Animation<double>) => Widget)?' in typ…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:42 +16 ~1 -25: Section 1 - Tests with workarounds reverted retest: widgets/raw_dialog_route_test.dart
[METRIC] script=retest/widgets/raw_dialog_route_test.dart sourceBytes=59662 sourceChars=59630 bundleJsonBytes=615746 clearMs=18 readMs=1 bundleMs=38 httpMs=716 totalMs=774 status=success httpStatus=200 outputLines=21 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/widgets/raw_dialog_route_test.dart (1 error(s)):
       Runtime Error: Error in generic constructor factory for 'RawDialogRoute': type 'InterpretedFunction' is not a subtype of type '((BuildContext, Animation<double>, Animation<double>) => Widget)?' in typ…
```

---

## 124. generator_interpreter_retest_test.dart : retest/widgets/raw_radio_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Error in generic constructor factory for 'RawRadio': 'package:flutter/src/widgets/raw_radio.dart': Failed as…
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:44 +17 ~1 -27: Section 1 - Tests with workarounds reverted retest: widgets/raw_radio_test.dart
[METRIC] script=retest/widgets/raw_radio_test.dart sourceBytes=46987 sourceChars=46879 bundleJsonBytes=488712 clearMs=3 readMs=1 bundleMs=53 httpMs=642 totalMs=699 status=success httpStatus=200 outputLines=11 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/widgets/raw_radio_test.dart (1 error(s)):
       Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Error in generic constructor factory for 'RawRadio': 'package:flutter/src/widgets/raw_radio.dart': Failed as…
```

---

## 125. generator_interpreter_retest_test.dart : retest/widgets/render_nested_scroll_view_viewport_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
05:46 +17 ~1 -36: Section 1 - Tests with workarounds reverted retest: widgets/render_nested_scroll_view_viewport_test.dart
[METRIC] script=retest/widgets/render_nested_scroll_view_viewport_test.dart sourceBytes=10006 sourceChars=10006 bundleJsonBytes=91599 clearMs=19 readMs=0 bundleMs=6 httpMs=154 totalMs=181 status=success httpStatus=200 outputLines=8 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in retest/widgets/render_nested_scroll_view_viewport_test.dart (1 error(s)):
       type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

---

## 126. hardly_relevant_classes_4_test.dart : widgets/flex_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_Section)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:58 +129 -1: widgets/ flex_test.dart
[METRIC] script=widgets/flex_test.dart sourceBytes=95263 sourceChars=90907 bundleJsonBytes=1161458 clearMs=2 readMs=1 bundleMs=59 httpMs=148 totalMs=212 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/flex_test.dart (1 error(s)):
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_Section)
```

---

## 127. hardly_relevant_classes_4_test.dart : widgets/img_element_platform_view_test.dart

**Framework Errors** (18) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       BoxConstraints forces an infinite height.
These invalid constraints were provided to RenderConstrainedBox's layout() function by the following function, which probably computed the invalid constraints…
       RenderBox was not laid out: RenderFlex#ca85d relayoutBoundary=up4 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
01:08 +160 -2: widgets/ img_element_platform_view_test.dart
[METRIC] script=widgets/img_element_platform_view_test.dart sourceBytes=110527 sourceChars=110401 bundleJsonBytes=1351795 clearMs=30 readMs=4 bundleMs=64 httpMs=612 totalMs=711 status=success httpStatus=200 outputLines=0 frameworkErrors=18

  ⚠️  FRAMEWORK ERROR in widgets/img_element_platform_view_test.dart (18 error(s)):
       BoxConstraints forces an infinite height.
These invalid constraints were provided to RenderConstrainedBox's layout() function by the following function, which probably computed the invalid constraints…
       RenderBox was not laid out: RenderFlex#ca85d relayoutBoundary=up4 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: _RenderLayoutBuilder#5db47 relayoutBoundary=up3 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'has…
       RenderBox was not laid out: RenderFlex#d0731 relayoutBoundary=up2 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: RenderPadding#f4c4a relayoutBoundary=up1 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: _RenderSingleChildViewport#8d01f NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: RenderIgnorePointer#8c2fb NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: RenderSemanticsAnnotations#e854f NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: RenderPointerListener#66128 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: RenderSemanticsGestureHandler#8f5a2 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 2251 pos 12: 'hasSize'
       RenderBox was not laid out: RenderPointerListener#a1a50 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
... (truncated, 412 more chars)
```

---

## 128. hardly_relevant_classes_5_test.dart : widgets/repeat_mode_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_Card)
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
00:29 +41 -12: widgets/ repeat_mode_test.dart
[METRIC] script=widgets/repeat_mode_test.dart sourceBytes=86241 sourceChars=86034 bundleJsonBytes=1134023 clearMs=24 readMs=1 bundleMs=54 httpMs=141 totalMs=221 status=success httpStatus=200 outputLines=0 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in widgets/repeat_mode_test.dart (1 error(s)):
       Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_Card)
```

---

## 129. secondary_classes_test.dart : rendering/render_composite_test.dart

**Framework Errors** (1) — _(test passed despite framework errors)_

### [ ] Fixed in script  [ ] Fix in interpreter/generator  [ ] Workaround  [ ] added custom code  [ ] Timeout

### Error message

```
       'package:flutter/src/widgets/framework.dart': Failed assertion: line 1335 pos 12: '_debugLifecycleState == _StateLifecycle.ready': is not true.
```

### Exception

_(framework error - no stack trace captured in test result JSON)_

### Log error output

```
01:50 +74 ~3 -2: rendering/ render_composite_test.dart
[METRIC] script=rendering/render_composite_test.dart sourceBytes=3729 sourceChars=3729 bundleJsonBytes=44096 clearMs=22494 readMs=5 bundleMs=4 httpMs=173 totalMs=22677 status=success httpStatus=200 outputLines=24 frameworkErrors=1

  ⚠️  FRAMEWORK ERROR in rendering/render_composite_test.dart (1 error(s)):
       'package:flutter/src/widgets/framework.dart': Failed assertion: line 1335 pos 12: '_debugLifecycleState == _StateLifecycle.ready': is not true.
```

---

