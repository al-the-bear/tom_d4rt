# tom_d4rt_flutterm — Test Run Issue Analysis

**Run ID:** `20260426-0002-issue-analysis`
**Captured:** 2026-04-26 00:02 → 01:30 CEST (~88 min wall-clock)
**Git revision at run time:** `b64ec056` (`test(tom_d4rt_flutterm): reactivate 34 'moved to timeout_tests' skips in secondary suite`)
**Environment:** `D4RT_SKIP_BRIDGE_REGEN=1` (no regen during run; pre-existing `*.b.dart` used as committed)

> **Follow-up runs** (2026-04-26):
> - **Run 2** (`hardly_relevant_classes_1_test_run2.log.txt`) — `isolate_name_server_test.dart` skipped.
>   Result: `+79 ~1 -125`. New cascade trigger: `image_sampler_slot_test.dart`.
> - **Run 3** (`hardly_relevant_classes_1_test_run3.log.txt`) — both `isolate_name_server_test.dart` and
>   `image_sampler_slot_test.dart` skipped.
>   Result: `+86 ~2 -117`. New cascade trigger: `callback_handle_test.dart` slow-build backlog.
>   See §7 for full analysis of run 2/3.

Each suite was executed serially (never in parallel — the test app's
local HTTP server is shared and concurrent runs corrupt results).
Per-suite artefacts in this folder:

- `<suite>.result.json` — `--file-reporter json` test events
- `<suite>.log.txt` — full stdout/stderr (includes `[METRIC]` and `FRAMEWORK ERROR` lines)
- `run_summary.tsv` — high-level pass/fail counts

---

## 1. Run summary

| Suite | Status | Elapsed | Passed | Failed | Skipped | Framework errors |
|-------|--------|---------|--------|--------|---------|------------------|
| `essential_classes_test`              | PASS | 75 s    | 108 | 0   | 0  | 1 |
| `important_classes_test`              | PASS | 97 s    | 169 | 0   | 5  | 1 |
| `secondary_classes_test`              | PASS | 415 s   | 654 | 0   | 5  | 33 |
| `hardly_relevant_classes_1_test`      | **FAIL** | **3816 s (64 min)** | 80  | **125** | 0  | 0 |
| `hardly_relevant_classes_2_test`      | PASS | 153 s   | 203 | 0   | 0  | 1 |
| `hardly_relevant_classes_3_test`      | PASS | 133 s   | 201 | 0   | 2  | 0 |
| `hardly_relevant_classes_4_test`      | PASS | 161 s   | 227 | 0   | 0  | 5 |
| `hardly_relevant_classes_5_test`      | PASS | 180 s   | 230 | 0   | 0  | 72 |
| `interactive_tests_test`              | PASS | 36 s    | 6   | 0   | 0  | 0 |
| `generator_interpreter_issues_test`   | FAIL | 94 s    | 65  | 18  | 1  | 18 (expected) |
| `generator_interpreter_retest_test`   | FAIL | 53 s    | 50  | 8   | 11 | 7 (expected) |
| **TOTAL**                             |      | ~88 min | **2 003** | **151** | **23** | **138** |

The `generator_interpreter_*_test` suites are designed to fail until
their constituent clusters land — they reproduce known
generator/interpreter gaps from `doc/interpreter_issues.md` and serve
as the regression net for those clusters. Only the
**`hardly_relevant_classes_1_test`** failures are a real regression.

---

## 2. Critical regression — `hardly_relevant_classes_1_test` cascade

### 2.1 Symptom

- Suite runs 80 tests successfully (animation, dart_async, dart_collection, dart_convert, dart_typed_data, beginning of dart_ui), then every subsequent test times out at exactly 30 seconds.
- 125 timeouts × 30 s ≈ 62.5 min, matching the observed 64-minute total runtime.
- Every failed test reports the same first-line error:

  ```
  TimeoutException after 0:00:30.000000: Test timed out after 30 seconds.
    dart:isolate  _RawReceivePort._handleMessage
  ```

### 2.2 Root cause — `dart_ui/isolate_name_server_test.dart` crashes the test app

The boundary in the log is unambiguous
(`hardly_relevant_classes_1_test.log.txt:158-167`):

```
00:55 +78: dart_ui/ image_filter_engine_layer_test.dart
[METRIC] script=…image_filter_engine_layer_test.dart … status=success
00:56 +79: dart_ui/ image_sampler_slot_test.dart
[METRIC] script=…image_sampler_slot_test.dart … status=success
00:57 +80: dart_ui/ isolate_name_server_test.dart
01:27 +80 -1: dart_ui/ isolate_name_server_test.dart [E]   ← first failure, no [METRIC] line
01:27 +80 -1: dart_ui/ key_event_device_type_test.dart
01:57 +80 -2: dart_ui/ key_event_device_type_test.dart [E]
…
```

`isolate_name_server_test.dart` was sent to the test app at 00:57 but
**no `[METRIC]` line ever followed** — the HTTP request never
returned. From then on every subsequent script timed out at exactly
30 s waiting for the test app's `/build` endpoint.

A focused 3-script reproduction (`flutter test --name
'image_sampler_slot|isolate_name_server|key_event_device_type'`)
confirms the cause:

```
00:13 +1: dart_ui/ isolate_name_server_test.dart
00:43 +1 -1: dart_ui/ isolate_name_server_test.dart [E]
…
01:14 +1 -2: dart_ui/ key_event_device_type_test.dart
[METRIC] script=…/key_event_device_type_test.dart … status=clear_failed httpStatus=-1
  Error: HttpException: Connection reset by peer, uri = http://localhost:4247/clear
    Application finished.                                ← test app process terminated
```

The test app **process exits** after `isolate_name_server_test.dart`
runs in the suite context. All subsequent `/clear` calls hit a closed
socket ("Connection reset by peer"), leaving 125 tests with nothing
to talk to.

### 2.3 Why does it pass in isolation?

`flutter test --plain-name 'isolate_name_server_test.dart'` runs the
suite, hits the `setUpAll` build, sends one script, and tears down.
The test app is freshly built and has no prior state. The script
completes in 1.7 s with `status=success` and the suite exits cleanly.

When chained (image_sampler_slot → isolate_name_server →
key_event_device_type), the test app survives the first script,
crashes during or after handling the second, and `/clear` for the
third fails. So the bug is *not* simple timeout — it is a
**resource leak / crash triggered by interaction with the previous
test's state**, surfacing only in a multi-test sequence.

### 2.4 What the script does

`test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/isolate_name_server_test.dart`
(844 lines) drives a `_IsolateNameServerDeepDemo` widget that:

- Allocates three `ReceivePort` instances (`_alphaPort`, `_betaPort`, `_gammaPort`).
- Registers their send ports under named channels via `IsolateNameServer.registerPortWithName(...)`.
- Drives a flow animation with periodic `setState` calls.
- Two other scripts in the same directory also use `dart:isolate`:
  - `dart_ui/dart_ui_misc_adv_test.dart`
  - `dart_ui/root_isolate_token_test.dart`

The probable trigger is that the script's `dispose()` does not
release `IsolateNameServer` registrations and/or `ReceivePort`s, so
when the test app rebuilds for the next request, the lingering
isolate-side resources eventually destabilise the process. (The test
app's `/clear` rebuilds the widget tree but does not restart the
embedder.)

### 2.5 Recommended fix

Two layers, in order of preference:

1. **Script-side (`isolate_name_server_test.dart`):** ensure the demo
   widget's `dispose()` calls
   `IsolateNameServer.removePortNameMapping(_channelA)` for each
   registered name and closes every `ReceivePort`. Mirror this in any
   `_IsolateNameServerDeepDemo*` derivative. This is a script bug, not an
   interpreter or bridge gap.
2. **Test-app-side (`tom_d4rt_flutterm_app`):** harden the build
   handler so a script that crashes the binding does not take the
   whole process down. Options: capture and log the failure on the
   handler, then perform a hard reset of the binding before
   responding. This is defence-in-depth — without it, *any* future
   script with a similar leak will cascade-kill the whole suite.

A minimal pre-fix ad-hoc recovery would be to skip
`isolate_name_server_test.dart` in
`hardly_relevant_classes_1_test.dart` (matching the pattern used for
`timeout_tests_test.dart` in earlier triage). That keeps the suite
green while the script-side fix lands but masks the underlying app
fragility.

---

## 3. `generator_interpreter_issues_test` failures (18 — all expected)

Cluster breakdown:

| Cluster | Count | Scripts | Existing reference |
|---------|------:|---------|---------------------|
| Section E — Widget coercion of an interpreted instance | 1 | `rendering/render_box_container_defaults_mixin_test.dart` | `interpreter_issues.md` Section E |
| RenderObject coercion | 3 | `rendering/relayout_when_system_fonts_change_mixin_test.dart`, `rendering/render_absorb_pointer_test.dart`, `rendering/render_aligning_shifted_box_test.dart` | Same family as Section E (createRenderObject) |
| RenderBox coercion | 1 | `rendering/box_hit_test_result_test.dart` | New variant (BoxHitTestEntry constructor) |
| Function-typed callback coercion | 1 | `rendering/custom_painter_semantics_test.dart` | Section E variant |
| InheritedWidget proxy gap | 3 | `widgets/window_scope_test.dart`, `widgets/inherited_theme_test.dart`, `widgets/inherited_widget_test.dart` | Section Q closure (2026-04-26) — escalated cluster |
| Layout/overflow (cosmetic + RenderFlex infinite) | 4 | `widgets/animated_switcher_test.dart`, `widgets/html_element_view_test.dart`, `widgets/layout_builder_adv_test.dart`, `widgets/magnifier_decoration_test.dart` | Mostly script-side (overflow) + GEN-094 close family |
| ScrollController state precondition | 2 | `widgets/list_wheel_scroll_view_test.dart`, `widgets/list_wheel_viewport_test.dart` | New |
| `setState` during frame | 1 | `rendering/render_custom_paint_test.dart` | Script-side scheduling bug |
| Interpreter operator gap (`null * int`) | 1 | `rendering/render_custom_multi_child_layout_box_test.dart` | New |
| Other (Container children list) | 1 | `widgets/render_object_element_test.dart` | Section E variant |

The dominant patterns are **Section E coercion** (interpreted
subclass of `Widget` / `RenderObject` / function-typed parameter not
recognised by the bridged supertype) and the **`InheritedWidget`
proxy gap** (already documented as escalated in the Section Q
closure note in `interpreter_issues.md`). Five of the rendering/
scripts (`render_box_container_defaults_mixin_test.dart`,
`render_absorb_pointer_test.dart`,
`relayout_when_system_fonts_change_mixin_test.dart`,
`render_aligning_shifted_box_test.dart`,
`box_hit_test_result_test.dart`) point at the same gap from the
`RenderObject` side: there is no proxy generator for `RenderObject`
analogous to the existing `StatelessWidget` / `StatefulWidget`
proxies, so an interpreted subclass cannot satisfy a native
`RenderObject` parameter.

These are tracked as expected red rows in
`generator_interpreter_issues_test.dart`; they will close when the
matching cluster fix lands.

## 4. `generator_interpreter_retest_test` failures (8 — all expected)

These are tests where workarounds were intentionally reverted to
keep them red. Per the Section Q closure note in
`doc/interpreter_issues.md`:

| Script | Cluster |
|--------|---------|
| `material/button_bar_theme_test.dart` | Section E coercion (re-routed) |
| `material/gapped_range_slider_track_shape_test.dart` | Section E coercion (re-routed); 18 `Null check operator used on a null value` framework errors |
| `material/theme_extension_test.dart` | `ThemeData.copyWith.extensions` generic coercion (Section P descendant) |
| `painting/axis_direction_test.dart` | RenderFlex overflow (cosmetic; documented closed) |
| `widgets/default_text_editing_shortcuts_test.dart` | `Map<ShortcutActivator, Intent>` coercion |
| `widgets/next_focus_intent_test.dart` | `Actions.maybeFind<T>` type forwarding |
| `widgets/raw_keyboard_listener_test.dart` | Deprecated API (`RawKeyboardListener` removed) |
| `widgets/raw_radio_test.dart` | Section B generic constructor factory |

No new clusters; consistent with `interpreter_issues.md` Section Q
closure (2026-04-26).

---

## 5. Framework errors in passing suites (138 captured)

These do **not** cause test failures — the test wrapper accepts
scripts that complete with non-zero `frameworkErrors` as long as
the binding does not crash. They surface real runtime issues the
bridge / interpreter is silently tolerating:

### 5.1 Top noisy scripts (passing-but-loud)

| Errors | Script | Suite |
|------:|--------|-------|
| 29 | `widgets/widget_test.dart` | various |
| 24 | `widgets/scroll_start_notification_test.dart` | hardly_relevant_5 |
| 20 | `widgets/root_element_mixin_test.dart` | hardly_relevant_5 |
| 19 | `widgets/scrollable_details_test.dart` | (TBD — appears in tally) |
| 18 | `widgets/img_element_platform_view_test.dart` | hardly_relevant_4 |
| 18 | `retest/material/gapped_range_slider_track_shape_test.dart` | retest |
| 17 | `widgets/weak_map_test.dart` | various |
| 17 | `widgets/standard_component_type_test.dart` | various |
| 12 | `widgets/slotted_multi_child_render_object_widget_test.dart` | various |
| 11 | `widgets/unfocus_disposition_test.dart` | various |

### 5.2 Dominant error patterns

| Pattern | Cause | Action |
|---------|-------|--------|
| `Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_…)` | Section E — interpreted Widget subclass not coerced to bridged `Widget` supertype during constructor arg binding | Already escalated; tracked in `interpreter_issues.md` |
| `Argument Error: Invalid parameter "appBar": expected PreferredSizeWidget?` | Same family — `PreferredSize`-derived interpreted subclass missing in coercion | Section E variant; same fix path |
| `RenderFlex overflowed by N pixels` | Layout in test scripts is too tight for the test viewport | Script-side (cosmetic); no interpreter action |
| `Null check operator used on a null value` (in `gapped_range_slider_track_shape_test.dart`) | Theme extension lookup returns null because of generic-coercion gap | Section P descendant — fix when ThemeExtension generic coercion lands |
| `BoxConstraints forces an infinite height` | Script puts an unbounded child in a Column without a SizedBox | Script-side |
| `Bridged superclass 'TwoDimensionalScrollView' does not have a constructor named ''` | Generator did not emit a default-constructor adapter for an abstract bridged base | Generator side; new mini-cluster |
| `Cannot access property 'pixelsPerSecond' on null` | Interpreter null-aware access on a member that is `Velocity?` | Interpreter or script null-aware emission |
| `Runtime Error: Unsupported binary operator "&"` | Interpreter is missing `int & int` over a particular type code path | Interpreter operator extension (unrelated to bitwise typing in core) |
| `Runtime Error: Unsupported operator (*)` for `null * int` | Same family — null-propagation through arithmetic | Interpreter operator gap |
| `Late variable '…' without initializer is accessed before being assigned` (`_value`, `_builder`) | Order-of-initialisation bug in interpreted classes with `late` fields | Interpreter `late` field codegen |

The same Section E coercion error class appears in roughly 30+
distinct framework-error lines (one per interpreted Widget subclass
name `_FooBar`, `_Card`, `_Panel`, …). This single pattern
dominates the passing-but-noisy noise and is the highest-leverage
fix once Section E lands.

---

## 6. Recommendations (in priority order)

1. **Fix `isolate_name_server_test.dart` script** — add proper
   `dispose()` cleanup of `ReceivePort`s and
   `IsolateNameServer.removePortNameMapping`. Verify with the
   3-script reproduction from §2.2. Without this fix
   `hardly_relevant_classes_1_test` is a 64-minute red suite, masking
   any actual regression on the other 205 tests in that file.
2. **Harden the test app build handler** to survive a script that
   destabilises the binding — defence-in-depth so the next leaky
   script does not also cascade-kill the suite.
3. **Land Section E coercion fix** — primary lever for clearing the
   30+ "Invalid parameter 'build': expected Widget" framework
   errors *and* most of the 18 `generator_interpreter_issues`
   failures.
4. **`RenderObject` proxy generator** (5 of the 18
   generator_interpreter failures) — analogous to the existing
   `StatelessWidget` / `StatefulWidget` proxies, generate a proxy
   `RenderObject` subclass per interpreted class extending
   `RenderObject` so a native `RenderObject` parameter accepts it.
5. **`InheritedWidget` proxy gap** (`window_scope_test`,
   `inherited_theme_test`, `inherited_widget_test`) — already
   captured in `interpreter_issues.md` Section Q closure as an
   escalated cluster; same proxy-generation strategy.
6. **Mini-clusters for follow-up triage**, low-priority:
   - Default-constructor adapter for abstract bridged
     `TwoDimensionalScrollView` (and audit other abstract bridged bases
     for the same gap).
   - Interpreter `null * int` / `null & int` operator gaps.
   - `late` field initialisation order in interpreted classes.

The test app fragility (Recommendation 2) is the only structural
hazard surfaced by this run; everything else is either an existing
known cluster or a script-side cleanup.

---

## 7. Follow-up runs on `hardly_relevant_classes_1_test` (2026-04-26)

### 7.1 Objective

Skip `isolate_name_server_test.dart` (confirmed crash trigger from §2),
document the isolate limitation, and re-run to obtain a correct baseline.

### 7.2 Run 2 — `isolate_name_server_test.dart` skipped

**Log:** `hardly_relevant_classes_1_test_run2.log.txt`

| Metric | Value |
|--------|-------|
| Result | `+79 ~1 -125` |
| Elapsed | ~7 min |
| Cascade trigger | `dart_ui/image_sampler_slot_test.dart` |
| Cascade type | App process crash (same as §2) |

**Root cause:** `image_sampler_slot_test.dart` calls
`ui.FragmentProgram.fromAsset('shaders/not_existing_sampler_demo.frag')`
inside a widget `initState()` async callback. On the Linux desktop test runner
the platform channel for this call sometimes never returns — the test times out
after 30 s and the test app dies. In the original run this call completed
quickly (timing luck); in run 2 it hung.

The `image_sampler_slot_test.dart` script was updated with a
`Future.any(<[fromAsset, Future.delayed(2s)]>)` timeout race and
**also skipped** in the test file with the patch noted.

**Why image_sampler_slot passed in run 1 but crashed in run 2:** Non-deterministic
platform channel response time for missing asset loads on Linux. The script is
inherently flaky without the 2-second timeout race.

### 7.3 Run 3 — both `isolate_name_server_test.dart` and `image_sampler_slot_test.dart` skipped

**Log:** `hardly_relevant_classes_1_test_run3.log.txt`

| Metric | Value |
|--------|-------|
| Result | `+86 ~2 -117` |
| Elapsed | ~4 min |
| Cascade trigger | `dart_ui/callback_handle_test.dart` slow-build backlog |
| Cascade type | HTTP build-handler deadlock → eventual app crash |

**Root cause:** `callback_handle_test.dart` is a slow-build script. Its `build`
HTTP request takes 30 272 ms — just over the 30-second response timeout — so the
test app returns `400 Timeout` while the build is still running in the background.

```
[METRIC] script=dart_ui/callback_handle_test.dart …
         httpMs=30272 status=error httpStatus=400 outputLines=34 frameworkErrors=0
```

The script *did* execute (34 output lines), but the test-app server's response
arrived too late. After the 400 is returned, the background build continues. When
subsequent tests call `/clear` they must wait for the still-running build to
complete. Each accumulated `/clear` wait pushes the next test over the 30-second
threshold:

| Script | clearMs | Cascade position |
|--------|--------:|-----------------|
| `pixel_format_test.dart` | 152 633 ms | 2nd failure |
| `placeholder_alignment_test.dart` | 122 631 ms | 3rd |
| `plugin_utilities_test.dart` | 92 634 ms | 4th |
| `point_mode_test.dart` | 62 635 ms | 5th |
| `pointer_change_test.dart` | 32 637 ms | 6th |
| `target_pixel_format_test.dart` | 11 ms — **connection refused** | App dead |

After six accumulated slow-clear operations, the test app process terminates.
All subsequent tests fail with `SocketException: Connection refused`.

**What's different from the §2 cascade:** The §2 cascade (isolate_name_server)
was an immediate app crash — the process died while handling the script. The
run-3 cascade is a *slow-build backlog* that accumulates over six tests and
causes a deferred crash. The mechanism is the same test-app fragility flagged in
Recommendation 2 (§6), but the trigger is a slow widget build rather than an
isolate-API crash.

**Why `callback_handle_test.dart` is slow:** The script's widget calls
`ui.CallbackHandle.fromRawHandle(12345)` and accesses several dart:ui APIs that
may involve platform channel round-trips on Linux, making the widget build take
just over 30 seconds on slower machines/runs.

### 7.4 Pending — next steps for a clean baseline

To get `hardly_relevant_classes_1_test` to pass cleanly, two independent fixes
are needed:

1. **Test-app hardening (Recommendation 2 from §6):** The `/build` endpoint must
   be able to *cancel* a running build when a `/clear` request arrives, rather
   than waiting indefinitely. Without this, any script whose build exceeds 30 s
   will create a clearMs backlog that cascades.

2. **`callback_handle_test.dart` speed fix:** The widget should not require
   platform-channel round-trips during build. Move any async API calls to
   `initState()` and use a `FutureBuilder` / `setState` pattern so the initial
   build is fast. Once the build completes in <30 s, the slow-backlog cascade
   will not trigger even before the test-app hardening is in place.

Until these two items land, the best achievable baseline with skips only is
`+86 ~2 -117` (run 3). Skipping all six slow-build scripts would move the
failure count to `+92 ~8 -111+` but would not reveal the *true* quality of the
remaining test coverage.

**Recommendation:** Fix the test app's build handler cancellation first (it is a
one-time structural fix that benefits every future slow script) and then remove
the `callback_handle_test` skip and re-run to close this section.
