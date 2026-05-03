# Error Analysis — tom_d4rt_flutter_ast

- **Fix ID**: `20260503-0948-issue-analysis`
- **Date**: 2026-05-03 09:48
- **Git revision**: `067692f2` (`fix(d4rt-flutter-ast): clear framework errors in last 3 suspicious scripts`)
- **Project**: `tom_d4rt_flutter_ast`
- **Run mode**: 14 test files, serial (`flutter test … --file-reporter json:doc/testlog_<id>/<file>.result.json`),
  `D4RT_SKIP_BRIDGE_REGEN=1`
- **Total wall time**: ≈ 73 min (09:49 → 11:02)

## 1. Suite results (per file)

| # | File | Result | Counts | FE blocks | Failed tests | Wall |
|---|------|--------|--------|-----------|--------------|------|
| 1 | `essential_classes_test.dart` | ❌ | +107 −1 | 0 | 1 | 02:49 |
| 2 | `important_classes_test.dart` | ✅ | +164 | 0 | 0 | 04:16 |
| 3 | `secondary_classes_test.dart` | ❌ | +652 ~1 −1 | 0 | 1 | 20:51 |
| 4 | `hardly_relevant_classes_1_test.dart` | ❌ | +201 ~2 −2 | 0 | 2 | 05:51 |
| 5 | `hardly_relevant_classes_2_test.dart` | ❌ | +198 −5 | 2 | 5 | 06:33 |
| 6 | `hardly_relevant_classes_3_test.dart` | ❌ | +199 −2 | 0 | 2 | 07:19 |
| 7 | `hardly_relevant_classes_4_test.dart` | ❌ | +225 −2 | 6 | 2 (+1 phantom)* | 07:43 |
| 8 | `hardly_relevant_classes_5_test.dart` | ❌ | +229 −1 | 7 | 1 | 07:31 |
| 9 | `crashing_tests_test.dart` | ✅ | +4 | 0 | 0 | 00:19 |
| 10 | `timeout_tests_test.dart` | ✅ | +51 | 0 | 0 | 01:50 |
| 11 | `blocking_tests_test.dart` | ✅ | +5 | 0 | 0 | 00:43 |
| 12 | `generator_interpreter_issues_test.dart` | ❌ | +79 ~2 −2 | 2 | 2 | 02:54 |
| 13 | `generator_interpreter_retest_test.dart` | ✅ | +53 ~5 | 0 | 0 | 02:00 |
| 14 | `interactive_tests_test.dart` | ✅ | +6 | 0 | 0 | 00:34 |

Legend — `+`: passed, `~`: skipped, `−`: failed. **FE blocks** = number of scripts that emitted a `⚠️  FRAMEWORK ERROR` panel during that suite (the script's d4rt build still returned 200 to the test runner; the panel reports widget-tree-side runtime/layout errors).

\* `hardly_relevant_classes_4` shows two `[E]` lines for `automatic_keep_alive_client_mixin_test.dart`: the test fired its 30 s timeout, the runner recycled the wedged app, then the same script reported a transport failure on retry — both attributed to the same underlying timeout. Only 2 distinct test failures.

**Aggregate**: 14 files run, 8 failed, 6 passed; 17 distinct test failures, 1 documented skip (`spell_check_service` follow-on widget skip in secondary), 17 framework-error blocks (some duplicated across suites — `tooltip_window_controller_delegate`, `windowing_owner_mac_o_s` appear in both `gii` and `hardly_5`).

## 2. Test failures (file by file)

Each entry below is a hard test failure (`-1` in the suite tally). All but one were triggered through `expectSuccess(...)` — i.e. d4rt accepted and ran the script, but the rendered widget tree raised an exception, so the wrapper test asserted false.

### 2.1 `essential_classes_test.dart` — 1 failure

| Test | Failure |
|------|---------|
| `cupertino/textfield_test.dart` | `Native error during default bridged constructor for 'CupertinoTextField': Failed assertion: line 320 pos 10: '(maxLines == null) || (minLines == null) || (maxLines >= minLines)': minLines can't be greater than maxLines` |

Pre-existing baseline failure; the test script provides a `minLines > maxLines` combination that flutter's `CupertinoTextField` rejects in `assert`. Likely a script-side fixture issue (the script chose constraints that violate the widget contract).

### 2.2 `generator_interpreter_issues_test.dart` — 2 failures

| Test | Failure |
|------|---------|
| `widgets/tooltip_window_controller_delegate_test.dart` | `Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null` |
| `widgets/windowing_owner_mac_o_s_test.dart` | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>` |

Both are documented pre-existing failures (gii baseline = 79+/2~/2−).

### 2.3 `hardly_relevant_classes_1_test.dart` — 2 failures

| Test | Failure |
|------|---------|
| `cupertino/cupertino_text_selection_handle_controls_test.dart` | Same `CupertinoTextField` `minLines > maxLines` assertion as in 2.1 |
| `foundation/target_platform_test.dart` | `Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null` |

### 2.4 `hardly_relevant_classes_2_test.dart` — 5 failures

| Test | Failure |
|------|---------|
| `material/button_bar_layout_behavior_test.dart` | `Undefined variable: ButtonBarThemeData` |
| `material/button_bar_theme_test.dart` | `Type 'ButtonBarThemeData' not found for instantiation.` |
| `material/button_text_theme_test.dart` | `Undefined variable: ButtonBarThemeData` |
| `material/time_of_day_format_test.dart` | `Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null` |
| `painting/axis_test.dart` | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>` |

The three `ButtonBar*` failures share a single root cause: `ButtonBarThemeData` was removed from modern Flutter (along with `ButtonBar`); the bridge no longer registers the symbol, so any script referencing it fails at d4rt resolve-time. This is a script-side issue (scripts should be rewritten to use the modern equivalents).

### 2.5 `hardly_relevant_classes_3_test.dart` — 2 failures

| Test | Failure |
|------|---------|
| `services/message_codec_test.dart` | `Native error during bridged method call 'encodeMessage' on StandardMessageCodec: Invalid argument: Instance of 'BridgedInstance<Object>'` |
| `services/method_codec_test.dart` | `Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(BOOT_FAIL, unable to start, {attempt: 1}, null)` |

Both relate to the bridge passing `BridgedInstance<Object>` where a strongly-typed Dart object is expected (the script is constructing a payload via interpreted code, then calling the native codec on it).

### 2.6 `hardly_relevant_classes_4_test.dart` — 2 distinct failures

| Test | Failure |
|------|---------|
| `widgets/automatic_keep_alive_client_mixin_test.dart` | `TimeoutException after 0:00:30.000000: Test timed out after 30 seconds` — script wedged the test-app `/build`; runner recycled the app; retry surfaced as a transport-failure `[E]` for the same script |
| `widgets/i_o_s_system_context_menu_item_cut_test.dart` | `Runtime Error: Positional arguments cannot follow named arguments.` — d4rt parse-time error in the script source |

### 2.7 `hardly_relevant_classes_5_test.dart` — 1 failure

| Test | Failure |
|------|---------|
| `widgets/regular_window_test.dart` | `Cannot instantiate abstract class 'RegularWindowController'.` |

The script tries to construct an abstract class directly — script-side issue.

### 2.8 `secondary_classes_test.dart` — 1 failure

| Test | Failure |
|------|---------|
| `services/spell_check_service_test.dart` | `Native error during default bridged constructor for 'SpellCheckConfiguration': Argument Error: Invalid parameter "spellCheckService": expected SpellCheckService?, got InterpretedInstance(_MockSpellCheckService)` |

Bridge does not unwrap `_MockSpellCheckService` (a script-defined `SpellCheckService` subclass) when forwarded to `SpellCheckConfiguration`. Same family as the `_Planet`/`AnimatedWidget` issue we just fixed in `align_transition_test.dart`: bridged constructors don't accept `InterpretedInstance` for typed positional/named parameters that demand a Flutter abstract.

## 3. Framework errors (rendered widgets reported issues but the suite test still passed)

These are emitted by `SendTestRunner` when the d4rt-rendered widget tree raises a Flutter framework error after the build succeeded (200). The runner does NOT fail the test for these — they are reported for diagnostic purposes.

### 3.1 `generator_interpreter_issues_test.dart` (2)

| Script | Error |
|--------|-------|
| `widgets/tooltip_window_controller_delegate_test.dart` | `Native error during default bridged constructor for 'Text': … "data": expected String, got Null` |
| `widgets/windowing_owner_mac_o_s_test.dart` | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>` |

Same payload as the failed tests in §2.2 — surfaced both as a hard `[E]` and as a framework-error panel.

### 3.2 `hardly_relevant_classes_2_test.dart` (2)

| Script | Error |
|--------|-------|
| `material/theme_extension_test.dart` | `Undefined property or method 'surfaceTint' on bridged instance of 'ThemeExtension'.` |
| `material/thumb_test.dart` | `Native error during default bridged constructor for 'SliderThemeData': … "thumbShape": expected SliderComponentShape?, got InterpretedInstance(_DiamondTh…)` (×2) |

`thumb_test` is the same coercion family as `_Planet` and `_MockSpellCheckService`: `SliderComponentShape` subclass defined in the script is not unwrapped by the bridge.

### 3.3 `hardly_relevant_classes_4_test.dart` (6)

| Script | Error |
|--------|-------|
| `widgets/backdrop_group_test.dart` | `Undefined property or method 'value' on bridged instance of 'AnimationWithParentMixin'` + `RenderFlex overflowed by 25 pixels on the bottom` |
| `widgets/box_scroll_view_test.dart` | `RenderFlex overflowed by 138 pixels on the bottom` |
| `widgets/constrained_layout_builder_test.dart` | `RenderFlex overflowed by 49 pixels on the bottom` |
| `widgets/constraints_transform_box_test.dart` | `RenderConstraintsTransformBox overflowed by 372 pixels on the right` |
| `widgets/do_nothing_action_test.dart` | `BoxConstraints forces an infinite height.` |
| `widgets/drag_target_details_test.dart` | `Runtime Error: Index out of range: 5` (×5) |

The four `RenderFlex…overflowed` and `BoxConstraints forces an infinite height` errors are *layout-only* problems in the rendered widget tree — clear script-side fixture issues (column too tall, scroll missing, etc.). The `AnimationWithParentMixin.value` error is the same bridge gap we hit in `align_transition_test.dart` (Tween.animate(...) chain not exposing `.value`). The `Index out of range: 5` (×5) is interpreter-level — d4rt indexing past a list; needs investigation in the `drag_target_details` script.

### 3.4 `hardly_relevant_classes_5_test.dart` (7)

| Script | Error |
|--------|-------|
| `widgets/regular_window_controller_test.dart` | `LateInitializationError: Late variable '_primary' without initializer is accessed before being assigned.` |
| `widgets/route_transition_record_test.dart` | `Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation.` |
| `widgets/scroll_increment_type_test.dart` | `BoxConstraints forces an infinite height.` |
| `widgets/snapshot_mode_test.dart` | `Native error during default bridged constructor for 'Scaffold': … "appBar": expected PreferredSizeWidget?, got _InterpretedStatelessWidget` |
| `widgets/tooltip_window_controller_delegate_test.dart` | (same as §3.1) |
| `widgets/web_browser_detection_test.dart` | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>` |
| `widgets/windowing_owner_mac_o_s_test.dart` | (same as §3.1) |

Three coercion/bridge gaps (`PreferredSizeWidget?`, `for-in` over BridgedInstance, `Text.data: null`), three script-side issues (LateInit, null `withValues`, infinite-height layout).

## 4. Documented skips

| Suite | Test | Reason |
|-------|------|--------|
| `secondary_classes_test.dart` | `widgets/individual android_view_test.dart` | "AndroidView only renders on Android" |
| `gii_test.dart` | `widgets/android_view_test.dart` | same |
| `gii_test.dart` | `widgets/animated_switcher_test.dart` | "W5 (2026-04-28): wedges test app /build for ~60s then 'Lost connection to device'; cascades 34 subsequent gii tests" |
| `retest_test.dart` | `dart_ui/system_color_palette_test.dart` | "SystemColor not supported on Linux" |
| `retest_test.dart` | `widgets/context_action_test.dart` | "W1: script passes in isolation but wedges app /clear afterward" |
| `retest_test.dart` | `widgets/default_text_editing_shortcuts_test.dart` | "W2: /build hangs 30s, wedges app /clear afterward" |
| `retest_test.dart` | `widgets/live_text_input_status_test.dart` | "W3: cascade victim of W2 in retest runs" |
| `retest_test.dart` | `widgets/lock_state_test.dart` | "W4 (2026-04-28): wedges test app /build, dies and cascades 19 subsequent retests" |
| `hardly_relevant_classes_1_test.dart` | `dart_ui/image_sampler_slot_test.dart` | "D1 — destabilises the test app for subsequent dart_ui/gestures scripts on Linux" |
| `hardly_relevant_classes_1_test.dart` | `dart_ui/isolate_name_server_test.dart` | "IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)" |

## 5. Metric / transport rollup

`[METRIC]` lines emitted by the runner aggregate the 1 989 successful sends + 13 errors + 1 transport_error across the 14 suites:

| Status | Count |
|--------|-------|
| `success` | 2 015 |
| `error` (HTTP 4xx with d4rt-side runtime/parse error) | 13 |
| `transport_error` (HTTP/timeout — wedged app) | 1 |

Per-suite breakdown lives next to the headline counts in `*.log.txt` (`status=…`).

## 6. Failure clusters / themes

Grouped across files, the 17 hard failures + 17 framework errors fall into these classes:

| Cluster | Count | Symptom | Owner |
|--------|-------|---------|-------|
| **Bridge: `InterpretedInstance` not coerced for typed Flutter param** | ≥ 4 | `SliderThemeData.thumbShape`, `SpellCheckConfiguration.spellCheckService`, `Scaffold.appBar`, plus the just-fixed `_Planet` case in `align_transition_test` | bridge generator (mirror in `tom_d4rt`/`tom_d4rt_ast`) — extend the proxy/relaxer pipeline so user subclasses of bridged abstracts coerce automatically |
| **Bridge: `for-in` over `BridgedInstance<Object>`** | 3 (`windowing_owner_mac_o_s`, `painting/axis`, `web_browser_detection`) | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>` | interpreter `tom_d4rt_ast`/`tom_d4rt` — extend `for-in` iteration to recognise bridged `Iterable` instances — **Fixed (partial)**: collection-literal `ForElement` non-pattern branch now unwraps `BridgedInstance<Iterable>` in both interpreters; `painting/axis_test.dart` + `widgets/web_browser_detection_test.dart` pass; `widgets/windowing_owner_mac_o_s_test.dart` still fails on a downstream Priority-1 sub-case (`AnimatedBuilder.animation` rejects `InterpretedInstance(RegularWindowControllerMacOS)` — out of cluster scope). See §10 in the `tom_d4rt_flutter_test` analysis for full details. |
| **Bridge: `Text.data: null`** | 3 (`tooltip_window_controller_delegate`, `target_platform`, `time_of_day_format`) | `Text` constructor rejects `data: null` — script passes `null` from interpolation | script-side or interpreter null-check; verify the script prepares the value correctly before passing it to `Text(...)` |
| **Bridge: `Animation.value` on `AnimationWithParentMixin`** | 2 (`backdrop_group_test`, the just-fixed `align_transition_test`) | `Undefined property or method 'value' on bridged instance of 'AnimationWithParentMixin'` | bridge generator — mixin chain composition needs to expose `value` getter through `AnimationWithParentMixin` like it does for `Animation<T>` directly |
| **Removed Flutter API references** | 3 (`ButtonBar*` cluster) | `Undefined variable: ButtonBarThemeData` / `Type 'ButtonBarThemeData' not found for instantiation` | scripts — rewrite to use the modern Flutter equivalents |
| **Removed Flutter API references (CupertinoTextField asserts)** | 2 (`cupertino/textfield`, `cupertino_text_selection_handle_controls`) | `minLines can't be greater than maxLines` | scripts — fix `minLines/maxLines` fixture values |
| **Layout overflow / infinite-height** | 5 (`box_scroll_view`, `constrained_layout_builder`, `constraints_transform_box`, `do_nothing_action`, `scroll_increment_type`) | `RenderFlex overflowed by N pixels` / `BoxConstraints forces an infinite height` | scripts — bound the column / wrap in `SingleChildScrollView` / use `Expanded` correctly. These do not block the test but pollute the framework-error rollup. |
| **Interpreter — index-out-of-range, late init, null-aware on bridged null** | 4 (`drag_target_details` ×5, `regular_window_controller`, `route_transition_record`, `i_o_s_system_context_menu_item_cut`, `regular_window`) | various d4rt-side runtime errors | scripts — investigate per-script |
| **Codec bridge: `BridgedInstance<Object>` payload, PlatformException** | 2 (`message_codec`, `method_codec`) | bridge passes `BridgedInstance<Object>` instead of native object | bridge generator + script — codec round-trip for interpreted payloads |
| **Transport / wedge** | 1 (`automatic_keep_alive_client_mixin`) | 30 s `/build` timeout → recycle → 25 s POST timeout on retry | quest-level META watchdog (already documented in `interpreter_issues.md`) — script-side or test-app heartbeat |

## 7. Comparison vs prior testlogs

- gii baseline `79+/2~/2−` matches `testlog_20260501-0823-issue-analysis` and prior runs — no regression introduced by today's fixes (`raw_key_up_event`, `smart_quotes_type`, `align_transition`).
- `essential` `−1` cupertino/textfield is the documented pre-existing failure.
- `secondary` `~1 −1` (skip = AndroidView, fail = `spell_check_service`) matches the prior baseline; the three previously flaky scripts (`spell_check_service`, `animated_modal_barrier`, `animated_physical_model`) we observed in the `!continue` regression run only one of those (spell_check_service) hard-failed this time. `animated_modal_barrier` and `animated_physical_model` passed — they were transient infrastructure flakes.
- `important`, `crashing`, `timeout`, `blocking`, `retest`, `interactive` continue to pass green.

## 8. Suggested next actions

1. **Bridge: `InterpretedInstance` coercion for abstract Flutter superclasses.** Driver: 4 distinct symptoms today plus the `_Planet` case we worked around yesterday. Lands in `tom_d4rt_generator` (proxy/relaxer wrappers) + mirror in `tom_d4rt_ast` runtime.
2. **Interpreter: `for-in` over bridged `Iterable` instances.** 3 scripts blocked.
3. **Bridge: `AnimationWithParentMixin.value` getter.** 2 scripts blocked; pattern is `Tween().animate(…)` and `CurvedAnimation(parent: …)` chains.
4. **Bridge: `Text.data` null-coercion or null-rejection plumbing.** 3 scripts blocked; verify scripts and decide whether the bridge should pass `''` instead of `null`.
5. **Scripts: `ButtonBar*` removal sweep.** 3 hard failures; rewrite to modern `OverflowBar` / `Row.spaceBetween` patterns.
6. **Scripts: layout-overflow cleanup.** 5 framework-error blocks; trivial wrapping fixes; reduces noise.
7. **META: test-app watchdog.** `automatic_keep_alive_client_mixin` and the 5 documented W1–W5 wedges share root cause; centralise the watchdog before chasing per-script.
