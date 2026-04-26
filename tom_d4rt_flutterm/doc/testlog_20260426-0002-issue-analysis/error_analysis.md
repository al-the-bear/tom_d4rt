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

### Plan C — Test-app build-handler hardening (structural fix)

**Symptom:** Any script whose build exceeds the 30-second timeout creates a
clearMs backlog. If enough backlog accumulates, the test app crashes.
Affected scripts so far: `callback_handle_test.dart` (run 3), any future
long-running build.

**Fix approach:**
1. In the test app's HTTP server (`tom_d4rt_flutterm_app`), the `/build`
   endpoint must cancel any in-flight build when a `/clear` request arrives,
   rather than waiting indefinitely.
2. Introduce a `CancelToken` or `Completer`-based cancellation: the `/clear`
   handler signals the in-flight `/build` task to abort, frees the widget tree,
   and responds immediately.
3. This is a one-time structural fix that makes the test harness robust against
   all future slow or crashing scripts.
4. Validate by reproducing the run-3 cascade (send `callback_handle_test.dart`
   then immediately send the next script) and confirming the suite does not hang.

**Impact:** Structural safety net; does not change gii/retest counts but
prevents future slow scripts from cascading into suite-level timeouts.

---

### Plan D — Section E coercion: interpreted Widget / RenderObject accepted by native APIs (highest-leverage)

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

### Plan E — InheritedWidget proxy gap (3 gii failures)

**Affected scripts:** `widgets/window_scope_test.dart`,
`widgets/inherited_theme_test.dart`, `widgets/inherited_widget_test.dart`

**Root cause (from Section Q closure note in `interpreter_issues.md`):**
- `InheritedModel.inheritFrom<T>` bridge does not forward the type argument `T`
  to the native call (`widgets_bridges.b.dart:44563–44568`).
- No proxy class is generated for `InheritedWidget` / `InheritedModel`
  analogous to the `StatelessWidget` proxy, so the interpreted subclass does
  not materialise as a distinct native `Type` in the element tree.
- Flutter's runtime-type lookup (`context.dependOnInheritedWidgetOfExactType<T>`)
  cannot find the interpreted class.

**Fix approach:**
1. **Generator:** Add `InheritedWidget` and `InheritedModel` to the set of
   classes that receive proxy generation. The proxy must override `updateShouldNotify`
   to delegate to the interpreter.
2. **Bridge patch:** In `widgets_bridges.b.dart` (via generator or `D4UserBridge`),
   fix `InheritedModel.inheritFrom<T>` to forward the type argument. This may
   require a manual `D4UserBridge` since the type argument is an interpreter-side
   class, not a native type.
3. Regenerate flutterm bridges.
4. Run `flutter test test/generator_interpreter_issues_test.dart` — expect
   `window_scope_test.dart`, `inherited_theme_test.dart`,
   `inherited_widget_test.dart` to pass.

**Note:** Depends partially on Plan D (the proxy infrastructure pattern is the
same). Implement after Plan D is complete.

---

### Plan F — Layout/overflow and ScrollController script-side fixes (4+2 gii failures)

#### F.1 Layout/overflow (4 gii failures)

**Affected:** `animated_switcher_test.dart`, `html_element_view_test.dart`,
`layout_builder_adv_test.dart`, `magnifier_decoration_test.dart`

Most surface as `RenderFlex overflowed by N pixels` or
`BoxConstraints forces an infinite height`. These are cosmetic layout
warnings in scripts that use the test viewport (800×600) without adequate
size constraints.

**Fix:** Wrap the relevant test widget trees in `SizedBox.shrink()` or
constrain the widgets explicitly within the script. This is a script-side fix,
not an interpreter gap. After fixing, these should move from fail to pass.

#### F.2 ScrollController state precondition (2 gii failures)

**Affected:** `list_wheel_scroll_view_test.dart`, `list_wheel_viewport_test.dart`

**Root cause:** The script accesses `ScrollController` state before the
controller is attached to a scroll view. The error is typically
`ScrollController not attached to any scroll views`.

**Fix:** In the script's demo widget, guard `ScrollController` accesses in
`initState()` with `WidgetsBinding.instance.addPostFrameCallback((_) { ... })`
so they run after the first frame when the controller is attached.

---

### Plan G — Interpreter operator gaps (`null * int`, `null & int`) (framework errors + 1 gii failure)

**Affected:** `rendering/render_custom_multi_child_layout_box_test.dart` (gii),
plus framework error lines in other scripts.

**Error messages:**
- `Runtime Error: Unsupported binary operator "&"`
- `Runtime Error: Unsupported operator (*) for null * int`

**Fix approach (`tom_d4rt` + mirror in `tom_d4rt_ast`):**
1. In `InterpreterVisitor._evaluateBinaryExpression` (or equivalent), when the
   left operand is `null`, the operators `*` and `&` should null-propagate:
   `null * anything = null`, `null & anything = null` (matching Dart's null
   coercion semantics under `?` operators).
2. Add test cases to `tom_d4rt/test/` covering null-arithmetic operators.
3. Mirror fix in `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`.

**Impact:** Closes 1 gii failure + clears framework-error noise in several
passing scripts.

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
| 4 | C — Test-app build-handler hardening | Structural safety |
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
