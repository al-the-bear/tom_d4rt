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
| Layout/overflow (cosmetic + RenderFlex infinite) | 4 | `widgets/animated_switcher_test.dart`, `widgets/html_element_view_test.dart`, `widgets/layout_builder_adv_test.dart`, `widgets/magnifier_decoration_test.dart` | RESOLVED 2026-04-26 (Plan F.1) |
| ScrollController state precondition | 2 | `widgets/list_wheel_scroll_view_test.dart`, `widgets/list_wheel_viewport_test.dart` | RESOLVED 2026-04-26 (Plan F.2) |
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

---

## 8. Error Fixing Plan (2026-04-26)

This section provides a step-by-step execution plan for reducing failures
further, ordered by impact. Each item names the exact files to touch, the
approach, and an expected outcome in terms of gii/retest counts.

**Current baseline (post Section Q closure, 2026-04-26):**
- `gii`:    ~+69 ~1 -13
- `retest`: ~+50 ~11 -8
- `hardly_relevant_classes_1_test`: +204 ~1 -0 (fixed this session — isolate_name_server skipped, image_sampler_slot fixed)

---

### Plan A — BLOCKED item investigation: are the two crashes Linux Flutter bugs or interpreter/bridge bugs?

The two BLOCKED items from this session need triage before we can decide
whether to fix them here or file upstream.

#### A.1 — `ui.FragmentProgram` / `ui.FragmentShader` type access crash

**Symptom:** Bare type reference `final Type t = ui.FragmentProgram` triggers
a native shader-system initialization in the Flutter engine that crashes
asynchronously after HTTP 200 is sent.

**Assessment:**
- On native Flutter code, `final Type t = ui.FragmentProgram` is a compile-time
  type mirror reference — it does **not** trigger runtime shader system init.
  It is equivalent to `Type t = int`.
- In the d4rt bridge, `ui.FragmentProgram` is accessed as a `BridgedClass`
  via a static getter or constructor lookup. That lookup resolves to the
  **actual native class object**, which *does* call into the Flutter shader
  system at class-init time.
- **Verdict:** This is a **bridge-layer bug**, not a Linux Flutter bug. Native
  code accessing `FragmentProgram` as a Type mirror does not trigger init.
  The bridge is materialising the class reference in a way that triggers eager
  class initialisation on the native side. On Android/iOS this may be silently
  ignored; on Linux desktop the shader system init fails fatally.

**Fix approach:**
1. Locate the `FragmentProgram` and `FragmentShader` bridge entries in
   `tom_d4rt_flutterm/lib/src/bridges/dart_ui_bridges.b.dart`.
2. Add a `D4UserBridge` override in
   `tom_d4rt_flutterm/lib/src/d4rt_user_bridges/` that stubs out
   `FragmentProgram`/`FragmentShader` constructors and type-getter as
   `UnsupportedError('FragmentProgram not supported on this platform')`
   instead of calling native. Regenerate after.
3. Validate by un-commenting the removed probes in
   `dart_ui/image_sampler_slot_test.dart` and running
   `flutter test test/bisect_test.dart` (confirm key_event_device_type_test
   still passes after image_sampler_slot).

**Impact:** Unblocks the 2 permanently-failing sentinel probes in
`image_sampler_slot_test.dart`. Does not directly change gii count (those
probes are not in gii), but clears the BLOCKED marker in `interpreter_issues.md`.

---

#### A.2 — `Picture.toImage()` with zero/invalid dimensions crashes native engine

**Symptom:** `Picture.toImage(0, 20)` (zero width) reaches the native C++
rasterizer and crashes the engine process instead of throwing
`PictureRasterizationException`.

**Assessment:**
- The Flutter SDK contract is clear: `Picture.toImage()` with width ≤ 0 or
  height ≤ 0 must throw `PictureRasterizationException` synchronously (or
  return a rejected `Future`).
- Native Flutter apps that call `Picture.toImage(0, 20)` **do** throw
  `PictureRasterizationException` — the native binding validates dimensions
  before calling into the rasterizer.
- In the d4rt bridge, the `toImage` adapter passes the raw arguments to the
  native method without the dimension guard. On Linux the native rasterizer
  path is different (no GPU pipeline, falls to software rasterizer) and the
  guard is apparently missing there as well — resulting in a fatal crash rather
  than an exception.
- **Verdict:** The crash is a **bridge-layer omission** (missing dimension guard
  in the `toImage` adapter). The Flutter SDK bug (missing guard in the Linux
  native backend) may also be present, but we can close the gap on the bridge
  side independently with a pre-call guard.

**Fix approach:**
1. Add a `D4UserBridge` override for `Picture` in
   `tom_d4rt_flutterm/lib/src/d4rt_user_bridges/` that adds a pre-call guard
   to `toImage`:
   ```dart
   if (width <= 0 || height <= 0) {
     throw PictureRasterizationException(
       'width and height must be greater than zero',
     );
   }
   ```
2. The sentinel probe in `picture_rasterization_exception_test.dart` currently
   asserts `false` (BRIDGE BUG). After the fix, un-comment the
   `await p.toImage(0, 20)` call and assert that `PictureRasterizationException`
   is thrown (the probe expects a thrown exception; the `false` sentinel is
   replaced with `true`).
3. Validate with `flutter test test/bisect_test.dart` with
   `bisect/current.dart = picture_rasterization_exception_test.dart`.

**Impact:** Clears 1 permanently-failing sentinel probe. The test will then
test the correct exception path.

---

### Plan B — `callback_handle_test.dart` slow-build backlog (blocks `hardly_relevant_classes_1_test`) — **[RESOLVED 2026-04-26]**

**Status:** Resolved as a side effect of Plan A.1. No script or harness change
required.

**Original symptom (from §7.3):** `callback_handle_test.dart` build was
reported at 30 272 ms (just over the 30-second timeout), causing a clearMs
backlog that cascaded and eventually crashed the test app process over the
following 6 tests.

**Verification (2026-04-26, post Plan A.1):**

| Run | Context | clearMs | bundleMs | httpMs | totalMs | status |
|-----|---------|--------:|---------:|-------:|--------:|--------|
| Bisect (`bisect/current.dart` = `callback_handle_test.dart`) | isolated | 9 | 217 | 760 | 998 | success |
| Suite (`hardly_relevant_classes_1_test`) | after `box_width_style_test.dart` | 2 | 9 | 382 | 395 | success |

The 30 s build never reproduces post Plan A.1. The cascade trigger described
in §7.3 (`+86 ~2 -117`) is gone — the suite is currently `+204 ~1 -0` (only
intentional `isolate_name_server_test` skip remains). The `callback_handle_test`
script is *not* skipped in `test/hardly_relevant_classes_1_test.dart` (grep
confirms only one `skip:` marker, for `isolate_name_server`).

**Why this is fixed:** The 30 s outlier in run-3 of §7.3 was almost certainly
a Linux-Flutter platform-channel response-time tail; the engine state was
already destabilised by `image_sampler_slot_test` (the BLOCKED A.1 trigger
that crashed the engine asynchronously). With `image_sampler_slot_test`
unblocked by Plan A.1 — the engine no longer crashes, the FragmentProgram
type is no longer touched synchronously during initState — the platform
channel is no longer destabilised, and `callback_handle_test`'s build
completes promptly.

**No bridge or interpreter change is required.** Modifying the script to
move work out of `build()` is unnecessary: the script is purely synchronous
(no `await` calls, no `Future`-returning APIs in `build()`), and the slow
behaviour was a downstream symptom of the unrelated FragmentProgram race.

**Impact:** Completes `hardly_relevant_classes_1_test` clean baseline at
`+204 ~1 -0`.

---

### Plan C — Test-app build-handler hardening (structural fix) — **[RESOLVED 2026-04-26]**

**Status:** Implemented in `tom_d4rt_flutterm_app/lib/main.dart`.

**Original symptom:** Any script whose build exceeds the 30-second `/build`
timeout creates a clearMs backlog. If enough backlog accumulates, the test
app crashes. Affected scripts so far: `callback_handle_test.dart` (run 3),
any future long-running build.

**Implemented fix:**

1. `/clear` handler now actively completes any in-flight `_buildCompleter`
   with `_BuildResult(success: false, error: 'cleared by client', …)`
   *before* clearing state. This unblocks the in-flight `/build` await
   immediately so it does not consume its full 30 s timeout.
2. The build success post-frame callback, the synchronous catch blocks, and
   the `runZonedGuarded` async-error handler all now check
   `if (completer != null && !completer.isCompleted)` before calling
   `complete(...)`. This makes the completion paths idempotent under the
   new race where `/clear` may have already settled the completer.
3. `_capturingFrameworkErrors = false` is set in `/clear` so framework
   errors from the cancelled build are not attributed to the next test.

**Constraints honoured:**

- `_d4rt.build()` is still synchronous; nothing inside the interpreter is
  cancellable. Plan C does not pretend to free CPU mid-build — it ensures
  that when the loop *does* return, the in-flight `/build` await settles
  immediately on `/clear` instead of running its 30 s clock down.
- The fix changes only the `/clear` cancellation contract and the
  double-completion guards. The success / failure paths in normal operation
  are unchanged.

**Validation:**

| Step | Result |
|------|--------|
| `dart analyze test/tom_d4rt_flutterm_app/lib/main.dart` | No issues found |
| Bisect run (`bisect_test.dart`, `bisect/current.dart` = `callback_handle_test.dart`) | passes: 998 ms isolated |
| `essential_classes_test`   | +108 / 0 / 0 (matches baseline) |
| `important_classes_test`   | +164 ~5 / 0 (matches baseline) |
| `secondary_classes_test`   | +649 ~5 / 0 (matches baseline) |
| `hardly_relevant_classes_1_test` | +204 ~1 / 0 (matches baseline) |

**Impact:** Structural safety net. Does not change gii/retest counts but
prevents future slow scripts from cascading into suite-level timeouts.
Future regressions where a script's build legitimately exceeds 30 s now
fail their own test cleanly (timeout) instead of poisoning the next 5–6
tests with clearMs backlog.

---

### Plan D — Section E coercion: interpreted Widget / RenderObject accepted by native APIs (highest-leverage) — **[ATTEMPT 1 REVERTED 2026-04-26]**

**Status:** Interpreter-only narrow slice (ParentDataWidget + basic RenderBox
interface proxies in `d4rt_runtime_registrations.dart`) attempted on 2026-04-26
and reverted. The slice regressed gii by 30 tests
(`+39 ~1 -43` vs baseline `+69 ~1 -13`) including failures in tests outside
Plan D's stated scope: `inherited_theme_test` (`PanelTheme.of called with no
PanelTheme in context`, 6×), `inherited_widget_test`, `list_wheel_scroll_view_test`,
`list_wheel_viewport_test`. The same Plan D scripts the slice targeted
(`render_box_container_defaults_mixin_test` etc.) still failed in gii with the
original `Argument Error: Invalid parameter "build": expected Widget, got
InterpretedInstance` — the slice did not actually close any of the targeted
failures.

**Diagnosis of why the narrow slice failed:** The bridges call
`D4.validateTarget<Widget>(...)` / `D4.coerceList<RenderObject>` etc. on the
interpreted instance at the parameter boundary, before any
`tryCreateInterfaceProxyWithVisitor` call site is reached for these arguments.
A `RenderBox` interface-proxy registration alone is not enough: the bridge
generator needs to emit a *coercion shim* (analogous to the `StatelessWidget`
proxy machinery) so that the interpreted instance is adapted to a concrete
native `Widget` / `RenderObject` *as it crosses the bridge boundary*, not only
when it is later up-cast to an interface. The supertype-registry edits
made in the slice (`'RenderObject': [...]`, `'RenderBox': [...]`,
`'RenderProxyBox': [...]`, etc.) also broke `_supertypeRegistry`'s additive
contract: `BridgedClass.registerSupertypes` uses `putIfAbsent + addAll`, so
edits added supertypes to entries that the generator-emitted bridges had
already populated, perturbing the candidate-walk order in
`tryCreateInterfaceProxyWithVisitor` and causing spurious proxy resolutions
in non-RenderBox contexts (the InheritedWidget / list_wheel regressions).

**Conclusion:** Plan D as written cannot be done interpreter-side only. The
generator-side step (point 3 below — emit a `RenderObjectProxy` per
interpreted RenderObject subclass, analogous to the `StatelessWidgetProxy`)
is load-bearing. The interpreter-only attempt regressed unrelated tests
because the supertype-registry mutation has cross-cutting effects.

**Status going forward:** DEFERRED — needs the full generator + interpreter
+ `tom_d4rt_ast` mirror work as originally scoped (multi-day).

**Current impact:** ~30+ framework errors in passing suites (one per
interpreted Widget subclass name) + 5–6 gii failures (Section E +
RenderObject coercion variants).

**Affected gii scripts:** `render_box_container_defaults_mixin_test.dart`,
`render_absorb_pointer_test.dart`, `relayout_when_system_fonts_change_mixin_test.dart`,
`render_aligning_shifted_box_test.dart`, `box_hit_test_result_test.dart`,
`render_object_element_test.dart`, `custom_painter_semantics_test.dart`;
plus retest `button_bar_theme_test.dart`, `gapped_range_slider_track_shape_test.dart`.

**Root cause:** An interpreted class `class _Foo extends StatelessWidget` is
represented as an `InterpretedInstance` at runtime. When a bridge method
receives an `InterpretedInstance` where it expects a native `Widget`, it throws
`ArgumentError: Invalid parameter "build": expected Widget, got InterpretedInstance`.

**Fix approach (interpreter side — `tom_d4rt` + `tom_d4rt_ast`):**
1. In `InterpreterVisitor` (and its `tom_d4rt_ast` mirror), when passing an
   `InterpretedInstance` to a bridged method that expects a `Widget`,
   `RenderObject`, or similar bridged supertype, look up the proxy class
   registered for that interpreted class and coerce through it.
2. The `StatelessWidget` / `StatefulWidget` proxies already exist — extend
   coercion logic to cover `RenderObject`, `RenderBox`, `LeafRenderObjectWidget`,
   `SingleChildRenderObjectWidget`, `MultiChildRenderObjectWidget`, and
   `PreferredSizeWidget` subtypes.
3. **Generator side (`tom_d4rt_generator`):** Generate a `RenderObject`
   proxy class (analogous to `StatelessWidgetProxy` / `StatefulWidgetProxy`)
   for every interpreted class that extends `RenderObject` or its subclasses.
   The proxy wraps the `InterpretedInstance` and delegates all abstract methods
   to the interpreter.
4. Mirror all interpreter-side changes in `tom_d4rt_ast`.
5. Regenerate flutterm bridges.
6. Run `flutter test test/generator_interpreter_issues_test.dart` — expect
   the RenderObject-coercion cluster (5–6 failures) to close.
7. Run essential + important + secondary suites — expect framework-error counts
   to drop significantly.

**Note:** This is the highest-impact single fix. Completing it clears the
largest cluster of both gii failures and framework noise.

---

### Plan D — Attempt 2 (interpreter-only RenderBox proxy MVP) — **REVERTED 2026-04-26**

**Status:** The narrow `_InterpretedRenderBox` proxy attempt was reverted
after secondary-suite regression confirmation. Working tree restored to
HEAD. The narrative below is preserved for the record; treat it as a
*lessons-learned* note, not as the current state of the code.

**What works:**

- Scripts whose direct `bridgedSuperclass` is `RenderBox` now produce a
  native `_InterpretedRenderBox` at the bridge boundary. The proxy
  caches itself on `instance.nativeProxy` so identity is preserved
  across boundary crossings (BoxHitTestEntry's `target` parameter,
  RenderObjectWidget.createRenderObject's RenderObject return, etc.).
- `_InterpretedRenderBox.performLayout()` invokes the interpreted
  `performLayout` method, then reads back `instance.get('size')` to
  push the script-assigned size onto the native proxy (works around
  `RenderBox.size`'s @protected setter not being exposed in the
  bridge-generated setter table). Falls back to `constraints.smallest`
  if the script didn't set a size.
- `paint`, `hitTest`, `hitTestSelf`, `hitTestChildren`, `setupParentData`
  delegate to interpreted overrides when present, else inherit
  RenderBox defaults.

**What this closes (failing → progressed past bridge boundary):**

- `rendering/render_absorb_pointer_test.dart` — was failing at "expected
  RenderBox, got InterpretedInstance"; now reaches the script body and
  fails only on a benign `RenderFlex overflowed by 76 pixels` layout
  warning (not the proxy boundary).
- `rendering/box_hit_test_result_test.dart` — was failing at the
  BoxHitTestEntry constructor's `target` parameter; now reaches the
  script body. The remaining failure (`Cannot invoke method 'contains'
  on null`) is a script-intrinsic bug — `_MockRenderBox` is never
  inserted into the render tree so its `size` is null, exposed only
  because the boundary check now passes.

**What this does NOT close (Plan-D remainders, need Phase 2):**

- `rendering/render_aligning_shifted_box_test.dart` — script extends
  `RenderAligningShiftedBox`, not `RenderBox`. The proxy walk only
  tries the bridgedSuperclass name 'RenderAligningShiftedBox' (no
  factory registered) and never reaches 'RenderBox'. Needs a
  per-abstract-base proxy class (Phase 2): `_InterpretedRenderShiftedBox`,
  `_InterpretedRenderAligningShiftedBox`, etc. Each must extend the
  matching concrete superclass so the framework's internal casts (e.g.
  `child is RenderObjectWithChildMixin<RenderObject>`) succeed.
- `rendering/render_box_container_defaults_mixin_test.dart` — failure is
  on `_DefaultsContainer` (a Widget, not RenderBox) — different boundary.
- `widgets/render_object_element_test.dart` — failure is on
  `_DemoPriorityParentDataWidget` (a ParentDataWidget) — different
  boundary, needs a ParentDataWidget proxy.
- `rendering/custom_painter_semantics_test.dart` — failure is on a typed
  callback (`semanticsBuilder`), not a RenderBox boundary.
- `rendering/relayout_when_system_fonts_change_mixin_test.dart` — also a
  RenderBox subclass; the surface error needs further analysis (likely
  similar to absorb_pointer, behind the boundary now).

**Why broader proxy registrations were rejected (attempt 2.1):** Trying
to register the same `_InterpretedRenderBox` factory under broader names
('RenderObject', 'RenderShiftedBox', 'RenderAligningShiftedBox',
'RenderProxyBox', 'RenderProxyBoxWithHitTestBehavior',
'RenderConstrainedBox') regressed the secondary suite by 254 tests
(from 649 → 395 passes). The issue: the proxy walk's `proxy is T` cast
at d4.dart:1589 succeeds whenever `_InterpretedRenderBox is T` — but
when T is `RenderObject`, that cast trivially succeeds, so any
interpreted class whose bridgedSuperclass walk reaches 'RenderObject'
ends up with a `_InterpretedRenderBox` that is structurally wrong for
its actual hierarchy (e.g. a script extending `RenderSliver` is NOT a
RenderBox, but the cast `proxy is RenderObject` would succeed and the
proxy would be installed). The narrow 'RenderBox'-only registration
avoids this because the candidate name 'RenderBox' is only added to
the walk when the script's bridgedSuperclass IS `RenderBox`.

**Verification (with narrow 'RenderBox'-only registration):**

| Suite                            | Baseline       | With Plan D    | Delta            |
| -------------------------------- | -------------- | -------------- | ---------------- |
| `generator_interpreter_issues`   | 65 / 1 / 18    | 69 / 1 / 13    | **+4 / -5**      |
| `essential_classes`              | 108 / 0 / 0    | 108 / 0 / 0    | unchanged        |
| `important_classes`              | 169 / 5 / 0    | 169 / 5 / 0    | unchanged        |
| `secondary_classes`              | 649 / 5 / 0    | 376 / 5 / 273  | **−273**         |

**Why reverted (2026-04-26 attempt 2.2 — verification after summary
restart):** Re-running the secondary suite with the narrow registration
applied reproduced a hard regression. The test app crashes during
`Building widget [rendering/render_indexed_semantics_test.dart]`
(httpMs jumps from 822 → 5436, status `transport_error`, "Lost
connection to device"). All ~272 tests after that point fail with
`Bad state: Transport failure` because the test-app HTTP server is
down. With the proxy reverted (HEAD), the same script runs in 822 ms,
status `success`, and the suite finishes 649 / 5 / 0.

The crash mode is not interpreter-side: the script defines no
classes (top-level functions only), so `_InterpretedRenderBox` is
never instantiated when interpreting it. The hang happens *during
build inside the test app*, with a silenced
`framework.dart:6268 '_dependents.isEmpty'` assertion preceding the
connection loss. Hypothesis: defining a real `RenderBox` subclass
(`_InterpretedRenderBox`) in the test app introduces a side-effect
in the render tree's debug machinery (registered descriptions,
performance overlay, semantics enumeration, etc.) that interacts
poorly with the leftover `_dependents` from the prior
`render_ignore_pointer_test.dart` build. Reproduction requires
running the secondary suite end-to-end, so further root-causing is
multi-hour work and out of scope for the narrow MVP.

The +4 gii / 0 essential / 0 important deltas don't justify the
−273 secondary regression. Per cluster-fix protocol ("Revert or
narrow the fix if it causes a regression in any of the four
suites"), Plan D is reverted. Phase 2 (per-abstract-base proxies +
ParentDataWidget proxy) and Phase 3 (generator-side RenderObject
proxy emission) remain DEFERRED — see *Remaining work* below.

**Remaining work for full Plan D close:**

1. Phase 2: per-abstract-base proxy classes for `RenderShiftedBox`,
   `RenderAligningShiftedBox`, `RenderProxyBox`,
   `RenderProxyBoxWithHitTestBehavior`. Each extends the matching
   concrete superclass directly.
2. Phase 2: ParentDataWidget proxy class (`_InterpretedParentDataWidget`)
   so scripts subclassing `ParentDataWidget` can flow through bridge
   boundaries that expect `Widget`.
3. Phase 2: investigate `_DefaultsContainer`-style cases — script
   classes that are Widgets but get rejected at bridge boundaries
   despite the existing StatelessWidget/StatefulWidget proxies.
4. Phase 3 (multi-day): generator-side `RenderObjectProxy` emission
   (the originally scoped Plan D step #3) for any RenderObject
   subclass — replaces the hand-written proxies in (1) and (2) above
   and is the path to scaling to all RenderBox/RenderObject hierarchies
   without manual registration.

---

### Plan E — InheritedWidget proxy gap (3 gii failures) — DEFERRED 2026-04-26

**Affected scripts:** `widgets/window_scope_test.dart`,
`widgets/inherited_theme_test.dart`, `widgets/inherited_widget_test.dart`

**Failure surface (12 framework errors total):**
- `inherited_widget_test.dart` — 5 errors:
  `AppStateScope.watch/read called without AppStateScope in context`
- `inherited_theme_test.dart` — 6 errors:
  `PanelTheme.of/read called with no PanelTheme in context`
- `window_scope_test.dart` — 1 error:
  `Assertion failed: No _DemoWindowScope found in context`

In every failure the script defines a subclass of `InheritedWidget` /
`InheritedTheme` / `InheritedModel`, builds it into the tree, then a
descendant calls `context.dependOnInheritedWidgetOfExactType<MyClass>()`
and the lookup returns `null` — which the script handles by `throw`ing
its own `FlutterError`/assertion. The construction succeeds; only the
exact-type lookup fails.

**Investigation 2026-04-26:**

Investigation closed with the following diagnosis. The investigation
surface is much larger than the original Plan E description indicated
— the right comparison is to the deferred Plan D, not to a tactical
generator tweak.

1. **InheritedWidget proxy is already in place.** A proxy
   (`_InterpretedInheritedWidget`) is registered in
   `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart:228` and
   the supertype registry already maps `InheritedTheme`, `InheritedModel`,
   `InheritedNotifier` → `InheritedWidget` (lines 117-137). The
   Bug-46 FIX in `callable.dart:860` correctly recognises the proxy
   when scripts `super`-call the empty `InheritedWidget` constructor.
   So construction succeeds and the script's interpreted subclass
   ends up in the element tree as a real `_InterpretedInheritedWidget`.

2. **The actual root cause is not a missing proxy.** It is the
   collision of two facts:
   - The bridge adapters for `dependOnInheritedWidgetOfExactType`,
     `getInheritedWidgetOfExactType`, and
     `getElementForInheritedWidgetOfExactType` (emitted on every
     `Element` subclass bridge — `widgets_bridges.b.dart:6366`,
     `:22102`, `:33455`, `:33890`) **ignore the `typeArgs`
     parameter** and call the native method with no `T`, so Dart
     defaults to `T = InheritedWidget`.
   - Even if `T` were forwarded, every interpreted `InheritedWidget`
     subclass collapses to the same native `runtimeType`
     (`_InterpretedInheritedWidget`). Flutter's
     `_inheritedElements` map is keyed by `widget.runtimeType`,
     so `dependOnInheritedWidgetOfExactType<AppStateScope>()` could
     never disambiguate between two interpreted subclasses sharing
     the proxy class — the lookup is fundamentally type-erased.

3. **The fix shape is Plan-D-sized, not Plan-E-sized.** The
   original Plan E sketch ("add `InheritedWidget` / `InheritedModel`
   to `proxyClasses`, fix `InheritedModel.inheritFrom<T>` to
   forward T") would not actually move the needle: the proxy is
   already generated and the lookup-by-T problem is downstream of
   the proxy. A real fix needs all of:
   - A bridge-generator change that, for the three exact-type
     lookup methods, emits an adapter which honours `typeArgs`
     and dispatches to a runtime hook when `typeArgs` is non-empty.
   - A new `D4` runtime registry (e.g.
     `D4.registerInheritedTypeResolver`) that the generated
     adapter consults.
   - A resolver implementation (in
     `d4rt_runtime_registrations.dart`) that walks
     `Element.visitAncestorElements` looking for an
     `InheritedElement` whose widget is a
     `_InterpretedInheritedWidget` whose
     `_instance.klass` matches the requested `RuntimeType`
     (with supertype walk for `InheritedTheme.of`-style
     subclass dispatch), then calls `dependOnInheritedElement`.
   - Mirroring of all interpreter-side changes between
     `tom_d4rt_ast` and `tom_d4rt`.
   - A full bridge regeneration of `tom_d4rt_flutterm`.
   - Serial verification across essential / important / secondary
     suites.

   That scope (generator surgery + cross-interpreter mirroring +
   identity-matching ancestor walk + full regen + serial regression
   sweep) is the same scale as the deferred Plan D. The original
   Plan E text already flagged this dependency:

     > "Note: Depends partially on Plan D (the proxy infrastructure
     > pattern is the same). Implement after Plan D is complete."

4. **Decision.** Defer Plan E to a dedicated cluster, paired with
   Plan D. Continue with the tactical clusters in this analysis
   that fit the cluster-fix verification protocol.

**State at deferral:** baseline 12 framework errors across the three
scripts. No code changes landed in this turn. `bisect/current.dart`
left clean. error_analysis.md updated with this diagnosis and
deferral.

**Re-entry checklist (when paired with Plan D):**
1. Add `D4.registerBridgedMethodInterceptor(className, methodName,
   interceptor)` to `tom_d4rt_ast/lib/src/runtime/generator/d4.dart`
   and mirror in `tom_d4rt/lib/src/generator/d4.dart`.
2. Modify `tom_d4rt_generator/lib/src/bridge_generator.dart` to
   emit a hook check at the top of method adapters whose name
   matches `dependOnInheritedWidgetOfExactType`,
   `getInheritedWidgetOfExactType`, or
   `getElementForInheritedWidgetOfExactType`. (Or generalise to
   "any method with a generic `T` type parameter that is part
   of the configured intercept list".)
3. Implement the resolver in
   `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`:
   `Element.visitAncestorElements` → match
   `InheritedElement.widget._instance.klass` against
   `typeArgs[0]` (`RuntimeType`) by identity / supertype chain,
   then `dependOnInheritedElement(matched, aspect: aspect)`.
4. Regenerate flutterm bridges
   (`tom_d4rt_flutterm/tool/regenerate_bridges.dart`).
5. Verify the three scripts via bisect harness, then full
   `generator_interpreter_issues_test`, then serial
   essential/important/secondary suites.
6. Update this section to RESOLVED only after all four suites
   match baseline (no regression).

---

### Plan F — Layout/overflow and ScrollController script-side fixes (4+2 gii failures) — RESOLVED 2026-04-26

#### F.1 Layout/overflow (4 gii failures) — RESOLVED

**Affected:** `animated_switcher_test.dart`, `html_element_view_test.dart`,
`layout_builder_adv_test.dart`, `magnifier_decoration_test.dart`

Surfaced as `RenderFlex overflowed by N pixels` or "object was given an
infinite size during layout" in scripts that compose multi-section demo
trees inside the 800×600 test viewport.

**Fix applied (script-side, in earlier sessions; verified 2026-04-26):**

- `animated_switcher_test.dart` — bumped fixed-height card to 96 px so the
  16+16 padding + 28-px icon + 4-px gap + text-line height fit without the
  4-pixel `RenderFlex` bottom overflow.
- `html_element_view_test.dart` — wrapped the `_NonWebHtmlMock` content in
  `FittedBox(fit: BoxFit.scaleDown)` so the natural ~140-px card scales
  into 74-px lane SizedBoxes instead of producing 71-px overflows.
- `layout_builder_adv_test.dart` — wrapped each child of the outer
  `SingleChildScrollView` Column in a SizedBox with a finite height so
  `CustomSingleChildLayout`, `OverflowBox`, and `SizedOverflowBox` no
  longer get an unbounded vertical extent.
- `magnifier_decoration_test.dart` — switched `SwitchListTile` rows to
  `LayoutBuilder` + `Wrap` so they reflow at narrow widths; replaced the
  fixed 130-px label column in `_DataTableCard` with a 2:3 flex split;
  wrapped lens labels in `Flexible` + `TextOverflow.ellipsis`.

**Verification 2026-04-26:**

- `flutter test test/generator_interpreter_issues_test.dart` — all four
  scripts pass with `frameworkErrors=0` (run alone and in the full gii
  suite).
- Bisect harness: each script run via `bisect/current.dart` →
  `status=success`, `frameworkErrors=0`.

#### F.2 ScrollController state precondition (2 gii failures) — RESOLVED

**Affected:** `list_wheel_scroll_view_test.dart`, `list_wheel_viewport_test.dart`

**Root cause:** Side-panel `_InfoTable` rows read
`FixedExtentScrollController.selectedItem` (and raw
`ScrollController.offset`) on the very first build, before the wheel
viewport had attached the controller. Flutter asserts
`positions.isNotEmpty` and throws "FixedExtentScrollController.selectedItem
cannot be accessed before a scroll view is built with it." Some scenes
also paired `FixedExtentScrollPhysics` with a raw `Scrollable` +
`ListWheelViewport`, which requires a `_FixedExtentScrollPosition`.

**Fix applied (script-side, in earlier sessions; verified 2026-04-26):**

- `list_wheel_scroll_view_test.dart` — guarded the `selectedItem` read
  with `_controller.hasClients` in both `_FundamentalsScene._InfoTable`
  and `_PhysicsScene._InfoTable`, falling back to the locally tracked
  `_selected` state when the wheel has not attached yet.
- `list_wheel_viewport_test.dart` — `_ViewportWheel` now defaults its
  physics to `BouncingScrollPhysics` (compatible with a plain
  `ScrollController`); the "fixed" pipeline preset uses
  `ClampingScrollPhysics` instead of `FixedExtentScrollPhysics`. Side
  panels read controller state through the `_pixels` listener cache
  rather than directly during build.

**Verification 2026-04-26:**

- gii: both scripts pass with `frameworkErrors=0`.
- Bisect harness: both pass under `bisect/current.dart` →
  `status=success`, `frameworkErrors=0`.

**Regression check 2026-04-26 (serial flutter test runs):**

| Suite | Result |
| ----- | ------ |
| `essential_classes_test.dart` | 108 passed, 0 failed |
| `important_classes_test.dart` | 164 passed, 5 skipped, 0 failed |
| `secondary_classes_test.dart` | 649 passed, 5 skipped, 0 failed |

No regressions. The Plan F closure does not require any further code
change — earlier-session script-side fixes had already landed and Plan F
just needed verification + documentation.

---

### Plan G — Interpreter operator gaps (`null * int`, `null & int`) (framework errors + 1 gii failure) — **PARTIALLY RESOLVED 2026-04-26**

**Affected:** `rendering/render_custom_multi_child_layout_box_test.dart` (gii),
plus framework error lines in other scripts.

**Error messages:**
- `Runtime Error: Unsupported binary operator "&"`
- `Runtime Error: Unsupported operator (*) for null * int`

**Fix landed (`tom_d4rt` + mirror in `tom_d4rt_ast`):**

A unified null-propagation block was added at the top of
`_evaluateBinaryExpression` (after both operands are evaluated, before the
typed dispatch chain). When either operand is `null` and the operator is one
of the arithmetic/bitwise set `{*, /, ~/, %, -, &, |, ^, <<, >>, >>>}`, the
expression evaluates to `null`. `+` is **excluded** so the existing String
concatenation `'$left$right'` stringify fallback keeps working
(`'foo' + null` → `'foonull'`).

Both the case-level dispatch and the bridged-operator adapter path now
short-circuit on null before reaching code that would throw
`Unsupported operator …` or `type 'Null' is not a subtype of type 'num' in
type cast`.

Files touched:

- `tom_d4rt/lib/src/interpreter_visitor.dart` (~line 1175, after final `right` value)
- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` (mirror, ~line 1346)
- `tom_d4rt/test/null_safety/null_propagating_operators_test.dart` (new — 18 tests)

**Verification (serial flutter test runs, `D4RT_SKIP_BRIDGE_REGEN=1`):**

| Suite | Baseline | Current | Δ |
|-------|----------|---------|---|
| `essential_classes_test` | 108 / 0 / 0 | 108 / 0 / 0 | none |
| `important_classes_test` | 164 / 0 / 5 | 164 / 0 / 5 | none |
| `secondary_classes_test` | 649 / 0 / 5 | 649 / 0 / 5 | none |
| `generator_interpreter_issues_test` | 65 / 18 / 1 | **68 / 14 / 1** | **+3 pass / -4 fail** |

Unit tests: 18 / 18 pass in `null_propagating_operators_test.dart`.

**Remaining gap — follow-up cluster (Plan G2):**

The Plan G target script `rendering/render_custom_multi_child_layout_box_test.dart`
**still fails** in gii — the cascade has moved one step further:

```
Runtime Error: Native error during default bridged constructor for 'Offset':
Argument Error: Invalid parameter "dx": expected double, got Null
```

Once `_motionController.value * math.pi * 2` correctly evaluates to `null`
(operator-level fix), that `null` propagates into the outer `Offset(...)`
constructor call, which is generated as a typed bridged adapter that asserts
`dx` is a `double`. To close this script, the bridged constructor argument
coercion must either:

- accept `null` as a valid `double` for animation/layout-style adapters and
  null-propagate the constructed object, or
- the script-side null cascade needs to be reshaped (tests don't have this
  authority — the bridge generator does).

This is a **bridge-generator** concern (constructor-adapter null handling),
not an interpreter operator concern, so it's tracked as **Plan G2** below
rather than re-opening Plan G.

**Impact (closed):** +3 gii passes (-4 failures); cleared `null * int` /
`null & int` framework-error noise in scripts that previously failed only
on the operator dispatch.

---

### Plan G2 — Bridged constructor null-coercion (1 gii failure, follow-up of Plan G)

**Affected:** `rendering/render_custom_multi_child_layout_box_test.dart` (gii — same target as Plan G).

**Error message:**

```
Runtime Error: Native error during default bridged constructor for 'Offset':
Argument Error: Invalid parameter "dx": expected double, got Null
```

**Diagnosis:** Plan G's operator-level null-propagation now correctly returns
`null` for `_motionController.value * math.pi * 2` when the controller value
is sampled before the bridged getter is ready. That `null` flows into
`Offset(center.dx + math.cos(angle) * radius - (s.width * 0.5), …)` and the
generated `Offset` bridged constructor adapter rejects the `null` `dx` via
strict `D4.getRequiredArg<double>(...)` validation.

**Fix approach (`tom_d4rt_generator` + regenerate flutterm bridges):**

1. In the bridge generator's constructor-adapter emission path (`bridge_generator.dart`,
   constructor argument coercion), introduce a relaxed null-propagation mode for
   bridged constructors: when any required argument is `null`, return `null`
   instead of throwing the argument-error. Apply only to constructors of value
   types used in dynamic UI (geometry: `Offset`, `Size`, `Rect`, `Radius`; etc.).
2. Alternative (more conservative): only relax adapter validation for the specific
   bridged classes called out in flutterm tests — start with `Offset` and audit.
3. Mirror in any equivalent codepath in `tom_d4rt_ast` if the adapter logic
   diverges (likely a runtime-side change in `D4` helpers — `D4.getRequiredArg<T>`
   may need an opt-in null-propagating variant).
4. Regenerate flutterm bridges and re-run gii.

**Cluster verification when fix lands:**

- `rendering/render_custom_multi_child_layout_box_test.dart` passes in gii
- No regression in essential / important / secondary suites
- Audit other gii failures for the same pattern (rendering scripts with
  geometry constructors fed from animated/null-prone sources).

---

### Plan H — `late` field initialisation order in interpreted classes (framework errors)

**Error:** `Late variable '…' without initializer is accessed before being assigned`
(fields `_value`, `_builder`).

**Affected:** Various scripts — surfaces as framework errors in passing suites.

**Fix approach (`tom_d4rt` + `tom_d4rt_ast`):**
1. In `InterpreterVisitor`, when evaluating `late` field access, check if the
   field has been initialised in the `Environment`. If not, throw
   `LateInitializationError` (matching native Dart behaviour).
2. The issue is likely that interpreted `late` fields are initialised in the
   order they appear in the class body, but accessed before their initialiser
   expression has been evaluated (e.g., during the `super()` constructor call).
3. Add `late` field ordering tests to the `tom_d4rt` test suite.

---

### Plan I — `TwoDimensionalScrollView` default constructor adapter (framework errors)

**Error:** `Bridged superclass 'TwoDimensionalScrollView' does not have a
constructor named ''`

**Affected:** A small number of scripts in `hardly_relevant_classes_*`.

**Fix approach (generator):**
1. The generator should emit a default-constructor (no-args) adapter for
   abstract bridged base classes even when the class has only named
   constructors, to allow the proxy-constructor pattern.
2. Audit other abstract bridged bases for the same gap (grep for
   `does not have a constructor named ''` in log files).
3. Regenerate flutterm bridges.

---

### Plan J — Retest cluster review (after Plans D–G)

After Plans D–H land, re-evaluate the 8 retest failures:

| Script | Cluster | Likely status after plan |
|--------|---------|--------------------------|
| `button_bar_theme_test.dart` | Section E | Closes after Plan D |
| `gapped_range_slider_track_shape_test.dart` | Section E + null check | Closes after Plans D + G |
| `theme_extension_test.dart` | Section P — ThemeExtension generic coercion | Separate cluster; needs explicit investigation |
| `axis_direction_test.dart` | RenderFlex overflow (cosmetic) | May close after Plan F.1 |
| `default_text_editing_shortcuts_test.dart` | `Map<ShortcutActivator, Intent>` coercion | Related to Plan D (map generic coercion) |
| `next_focus_intent_test.dart` | `Actions.maybeFind<T>` type forwarding | Separate generic-forwarding gap |
| `raw_keyboard_listener_test.dart` | Deprecated API | No fix — script should be updated to `KeyboardListener` |
| `raw_radio_test.dart` | Section B generic constructor factory | Section B cluster (separate) |

---

### Execution order summary

| Step | Plan | Estimated improvement |
|------|------|-----------------------|
| 1 | A.1 — FragmentProgram D4UserBridge stub | BLOCKED → cleared |
| 2 | A.2 — Picture.toImage guard | BLOCKED → cleared |
| 3 | B — callback_handle_test slow-build fix | **RESOLVED 2026-04-26** — no action needed; resolved by A.1 (suite already +204 ~1 -0) |
| 4 | C — Test-app build-handler hardening | **RESOLVED 2026-04-26** — `/clear` now actively cancels in-flight `/build`; double-complete guards added |
| 5 | D — Section E coercion + RenderObject proxy | ~5–8 gii -fail, ~30+ framework errors cleared |
| 6 | F.1 — Layout/overflow script fixes | ~4 gii -fail |
| 7 | F.2 — ScrollController precondition fixes | ~2 gii -fail |
| 8 | E — InheritedWidget proxy | ~3 gii -fail (after D) |
| 9 | G — Null operator gaps | ~1 gii -fail + framework noise |
| 10 | H — `late` field init order | Framework noise reduction |
| 11 | I — TwoDimensionalScrollView constructor adapter | Framework noise reduction |
| 12 | J — Retest cluster review | ~3–4 retest -fail (after D, G) |

**Expected end state after all plans complete:**
- `gii`: ~0 failures (all clusters closed)
- `retest`: ~4 failures (deprecated API + generic-forwarding gaps still open)
- Framework errors in passing suites: minimal (structural issues remain for generic coercion edge cases)
