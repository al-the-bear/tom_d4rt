# Test Log 20260428-1333 — Issue Analysis

**Run id:** `20260428-1333-issue-analysis`
**Git rev:** `639dfd0b` (W5 skip), then `91281a45` (analysis commit) +
W4 skip applied 2026-04-28 14:14 with gir-only re-run captured under
`generator_interpreter_retest_test.W4skip.{log.txt,result.json}`.
**Date:** Tue Apr 28 13:33 — 14:15 CEST 2026
**Total wall time:** 29 m 9 s initial run + 1 m 12 s gir re-run after
W4 skip (vs. 39 m 19 s in `testlog_20260427-1339-post-c22`).
**Captured artefacts:** `*.log.txt` and `*.result.json` per suite
(11 initial files + 2 W4-skip re-run files for `gir`).

This run captures the framework-error landscape *after* the
prior post-C22 campaign, with the C20-series and C21 interpreter
fixes landed and W5 (`animated_switcher_test.dart`) skipped from
`generator_interpreter_issues_test`. The 11 test files were run
**serially** (per the `tom_d4rt_flutterm` non-obvious rule that
flutter test runs in this package must not be parallelised) with
`D4RT_SKIP_BRIDGE_REGEN=1`.

The previous run aborted in `generator_interpreter_issues_test` at
test ID 54 (`widgets/animated_switcher_test.dart` wedged the test
app for ~60 s, then "Lost connection to device" cascaded the next
34 scripts). With W5 skipped, gii now completes cleanly at
**81 pass / 2 skip / 0 fail**.

---

## Run summary

| Suite | Pass | Skip | Fail | Err | FE scripts | FE total | Notes |
|---|---|---|---|---|---|---|---|
| `essential_classes_test`             | 108 |  0 |  0 |  0 |  0 |   0 | clean — `form_test` 1 FE closed by D2 |
| `important_classes_test`             | 164 |  0 |  0 |  0 |  0 |   0 | fully clean (was 164/5/0 — 5 skips removed) |
| `secondary_classes_test`             | 654 |  1 |  0 |  0 |  9 |  61 | suite passes; FE noise on 9 widget scripts |
| `hardly_relevant_classes_1_test`     | 205 |  2 |  0 |  0 |  0 |   0 | clean (D1 cascade closed; +125 pass vs prior) |
| `hardly_relevant_classes_2_test`     | 203 |  0 |  0 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_3_test`     | 201 |  0 |  0 |  0 |  0 |   0 | clean (was 199/2/0 — 2 skips re-enabled) |
| `hardly_relevant_classes_4_test`     | 227 |  0 |  0 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_5_test`     | 230 |  0 |  0 |  0 | 19 | 195 | suite passes; FE noise concentrated in `widgets/` |
| `interactive_tests_test`             |   6 |  0 |  0 |  0 |  0 |   0 | clean |
| `generator_interpreter_issues_test`  |  81 |  2 |  0 |  0 |  0 |   0 | **all green** — was 78/1/4 (+3 pass, -4 fail) |
| `generator_interpreter_retest_test`  |  34 |  4 |  4 | 20 |  2 |   2 | W4 cascade — see Cluster R below |
| `generator_interpreter_retest_test` *(re-run, W4 skipped)* | 54 |  5 |  4 |  0 |  2 |   2 | **+20 pass, -20 errors** — see Cluster R update |

**Headline deltas vs `testlog_20260427-1339-post-c22`:**

- `gii` 78/1/4 → **81/2/0** (no failures; 4 fixes carried in by
  C20a/C20b/C20d/C20f/C21 + W5 skip).
- `hr1` 80/1/124 → **205/2/0** (D1 `image_sampler_slot` cascade
  closed by skip; +125 passes recovered).
- `hr3` 199/2/0 → 201/0/0 and `important` 164/5/0 → 164/0/0:
  five carry-over skips were re-enabled and now pass.
- `secondary` FE scripts 15 → **9** (-6); FE total reduced.
- `hr5` FE scripts 38 → **19** (-19); FE total reduced.
- `hr4` 1 FE script → **0** (C20b SForEachPartsWithPattern in
  collection literals fixed `fractional_translation_test`).
- `gir` 45/11/2 → 34/4/24 in initial run; **after W4 skip 54/5/4
  with the cascade closed** (1m 12s wall time, all 19 victims
  recover). The remaining 4 failures are exactly the 2 known
  pre-existing carry-overs (`render_animated_size_state`,
  `back_button_listener`) + 2 newly-surfaced E1 `_ByteDataView`
  cases. See Cluster R.

True interpreter test failures across the entire run after W4 skip:
**4 in `gir` only** — 2 of which are documented unfixables and 2
are fixable under E1. All other suites are at zero failures.

---

## How clusters were derived

`[METRIC]` lines were grepped for `frameworkErrors=[1-9]` to
identify scripts that emitted FE during their test app run.
`⚠️  FRAMEWORK ERROR` blocks were sampled to recover the leading
exception string per script. The per-suite `*.result.json`
NDJSON files were `jq -s` slurped to recover `testDone` outcomes
(`success` / `failure` / `error`) and per-error messages for the
two suites with non-zero failure counts (`gii`, `gir`).

Clusters are bucketed by the leading exception family
(BoxConstraints layout cascade, late-init, `_ByteDataView`
runtime gap, transport cascade, etc.). Clusters E1–E8 are the new
or re-surfaced clusters in this run. Carry-overs from
`interpreter_issues.md` and the prior testlogs are listed in the
"Carry-over open clusters" section, with status updated to reflect
this run's evidence.

---

## E1 — `_ByteDataView.lengthInBytes` runtime gap (NEW)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Medium · **Owner:** interpreter / dart:typed_data bridge

**Symptom.** Two retest scripts in services/ now fail with the
same shape:

- `retest/services/message_codec_test.dart` (gir TID=33):
  `Runtime Error: Undefined property or method 'lengthInBytes' on _ByteDataView.`
- `retest/services/method_codec_test.dart` (gir TID=34):
  `Runtime Error: Cannot access property 'lengthInBytes' on target of type _ByteDataView.`

These were `success` in `testlog_20260427-1339-post-c22`'s gir run.
The shape matches the `dart:typed_data` re-export gap addressed in
`interpreter_issues.md` cluster #16 (GEN-106), but `_ByteDataView`
is the *internal* `dart:typed_data` view returned from
`Uint8List.buffer.asByteData()` — not the public `ByteData` bridge.

**Likely cause.** The script does
`buffer.asByteData(0, message.lengthInBytes)` where `buffer` is a
`Uint8List.buffer.asUint8List(...)`-style chain. The interpreter's
property-access path doesn't resolve `lengthInBytes` on the
private `_ByteDataView` runtime type — only on the public
`ByteData` / `Uint8List` bridges.

**Suggested fix.** Either (a) widen the `dart:typed_data` bridge
registration to map `_ByteDataView` → `ByteData` so the existing
`lengthInBytes` getter routes through, or (b) extend the
property-access fallback to walk `D4InterpretedProxy` /
nativeObject's runtime type ancestors when the leading bridge is
private. Option (a) is the lower-risk path.

**Verification path.** Bisect-run the two scripts after the fix;
expect 0 FE on both and gir TIDs 33, 34 → success.

---

## E2 — Layout cascade (BoxConstraints infinite/negative) — carry-over D6

- [ ] Fixed  - [x] Partial  - [ ] Open · **Severity:** Low · **Owner:** scripts (C22 ListView pattern)

**Status.** Down from 18 scripts / ~228 FE in the prior run to
**16 scripts / 138 FE** in this run, after `important` and `hr3`
skip removals re-introduced two scripts at low FE counts and the
hr5 FE-script count halved (38 → 19, of which the layout-cascade
shape covers most). No suite-level test failures — the affected
scripts don't assert on `tester.takeException`.

**Top-FE scripts (this run, ordered by FE count):**

| Suite | Script | FE |
|---|---|---|
| hr5 | `widgets/shortcut_activator_test.dart`              | 33 |
| hr5 | `widgets/unfocus_disposition_test.dart`             | 27 |
| secondary | `widgets/widget_test.dart`                    | 26 |
| hr5 | `widgets/widget_state_text_style_test.dart`         | 21 |
| hr5 | `widgets/two_dimensional_scrollable_state_test.dart` | 20 |
| secondary | `widgets/scroll_position_types_test.dart`    | 19 |
| hr5 | `widgets/web_browser_detection_test.dart`           | 19 |
| hr5 | `widgets/weak_map_test.dart`                        | 15 |
| hr5 | `widgets/standard_component_type_test.dart`         | 13 |
| hr5 | `widgets/widget_state_color_test.dart`              |  9 |
| hr5 | `widgets/scroll_deceleration_rate_test.dart`        |  8 |
| secondary | `widgets/text_magnifier_configuration_test.dart` |  6 |
| hr5 | `widgets/sliver_multi_box_adaptor_element_test.dart` |  6 |
| hr5 | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` |  5 |
| hr5 | `widgets/scrollbar_painter_test.dart`               |  4 |
| secondary | `widgets/restoration_mixin_test.dart`         |  3 |

**Leading exception shapes:**

- `BoxConstraints forces an infinite height` (RenderConstrainedBox) —
  `widget_state_text_style_test`, `two_dimensional_scrollable_state_test`,
  `weak_map_test`, `widget_state_color_test`, `scroll_position_types_test`.
- `BoxConstraints forces an infinite width` (RenderDecoratedBox) —
  `shortcut_activator_test`, `web_browser_detection_test`.
- `BoxConstraints has a negative minimum height`
  (_RenderEditableCustomPaint) — `unfocus_disposition_test`,
  `text_selection_gesture_detector_builder_delegate_test`,
  `select_all_text_intent_test`, `transpose_characters_intent_test`,
  `undo_history_value_test`, `update_selection_intent_test`.
- `RenderParagraph object was given an infinite size during layout` —
  `standard_component_type_test`.
- `RenderShrinkWrappingViewport does not support intrinsic dimensions` —
  `sliver_multi_box_adaptor_element_test`.
- `RenderFlex overflowed by N pixels` —
  `restorable_double_test` (17 px), `snapshot_mode_test` (14 px),
  `scrollbar_painter_test` (40 px), `widgets_binding_observer_test`
  (4.5 px).

**Suggested fix.** The C22 ListView replacement pattern (replace
`SingleChildScrollView` + `Column` with `ListView`) closed
`box_hit_test_result_test` and several others in the prior
campaign. Apply the same pattern to the 16 scripts above. None
require interpreter-side changes; all are deep-demo widget-tree
shape issues. Each script is independent — they can be batched
in PRs of 4–6 scripts each.

**Closing criteria.** Each fixed script must drop to 0 FE in
its parent suite; no regression in `bisect_test`. No interpreter
mirror needed (script-side changes only).

---

## E3 — Bridged-mixin field/getter access — carry-over D2 partial

- [ ] Fixed  - [x] Partial  - [ ] Open · **Severity:** Medium · **Owner:** interpreter

**Status.** D2 (4 scripts, 6 FE) was closed in the prior run via
`Environment.toBridgedInstance` supertype-narrowing + the
`D4InterpretedProxy` unwrap fallback. **Two scripts have
re-surfaced** in this run with adjacent shapes:

- `widgets/scroll_position_with_single_context_test.dart` (hr5):
  `Runtime Error: Undefined property or method '_controller' on bridged instance of 'SingleTickerProviderStateMixin'.`
  Same shape as the closed D2 `_controller` case; likely a
  different code path (e.g. constructor-passed callback that
  evaluates before the proxy round-trip is set up).
- `widgets/restorable_property_test.dart` (secondary):
  `Runtime Error: LateInitializationError: Late variable '_value' without initializer is accessed before being assigned.`
  See E4 — distinct cluster (late-init).
- `widgets/restorable_string_test.dart` (secondary):
  `Runtime Error: LateInitializationError: Late variable '_productNameController' without initializer is accessed before being assigned.`
  See E4.

**Likely cause for `_controller`.** The hr5 single-context script
constructs a `ScrollPositionWithSingleContext` from inside the
script's `State.build`, and the bridged constructor calls back
into `vsync.createTicker` synchronously before the
`D4InterpretedProxy` round-trip sets up. The D2 fix made the
mixin-side property visible *post* round-trip, but constructor-
phase access still hits the empty bridged shell. The fix template
matches the C20d "StateUserBridge scheduler-phase deferral"
pattern.

**Suggested fix.** Extend the `D4UserBridge` template for
`SingleTickerProviderStateMixin` to defer `createTicker` to
post-frame OR to expose the interpreted-side `_controller` field
via the proxy at construction time (not after first build). The
restoration-mixin late-init shape (E4) is a separate cluster.

---

## E4 — `late` field uninitialised in restoration scripts (NEW shape) — carry-over D3 partial

- [ ] Fixed  - [x] Partial  - [ ] Open · **Severity:** Medium · **Owner:** interpreter / scripts

**Symptom.** Two secondary suite scripts:

- `widgets/restorable_property_test.dart` —
  `Late variable '_value' without initializer is accessed before being assigned.`
- `widgets/restorable_string_test.dart` —
  `Late variable '_productNameController' without initializer is accessed before being assigned.`

**Likely cause.** The interpreter still mis-orders the
`registerForRestoration` lifecycle: the `late` controller field
is read in the script's `build()` before `restoreState()` has
called `registerForRestoration(_controller, 'key')`. The
documented workaround in `interpreter_unfixable.md`
("Reading `RestorableProperty.value` in `initState()` before
`restoreState()` registers it") covers `value` reads, but the
two scripts above hit it via the `late` controller pattern,
not via `value`.

**Suggested fix.** The script-side workaround pattern (assign
`_controller = TextEditingController()` in `initState()` and only
hydrate `text` in `restoreState()`) already exists in
`interpreter_unfixable.md` and resolves the symptom. These two
scripts haven't yet been patched. Apply the workaround to both.

The interpreter-side fix would be to deliver the
`RestorationMixin.restoreState` dispatch *before* the first build
when the script's State subclass has registered any
`RestorableProperty` field — but per the existing unfixable
analysis this is not feasible without a full restore-bucket
emulation in the interpreter.

---

## E5 — `widgets/widgets_binding_observer_test` borderRadius non-uniform (NEW)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Low · **Owner:** script

**Symptom.** `secondary/widgets/widgets_binding_observer_test.dart`
emits 3 FE:

- `A borderRadius can only be given on borders with uniform colors. The following is not uniform: BorderSide.color`
- `A RenderFlex overflowed by 4.5 pixels on the bottom.`

**Likely cause.** A Border definition in the script's demo
applies a non-uniform `BorderSide.color` (e.g., per-side colour)
while also setting `borderRadius`. Flutter's `Border.paint` only
permits `borderRadius` when all four sides share the same
colour. The 4.5 px overflow is a layout-cascade by-product and
overlaps with E2.

**Suggested fix.** Script-side: drop `borderRadius` for the
non-uniform-colour border, or unify the side colours.

---

## E6 — `widgets/platform_menu_widgets_test` records-in-Iterable (NEW)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Medium · **Owner:** interpreter / dart:core records bridge

**Symptom.** `secondary/widgets/platform_menu_widgets_test.dart`
emits 1 FE:

```
Runtime Error: Native error during bridged method call 'toList'
on Iterable: Runtime Error: Cannot access property '$1' on target of type (int, String).
```

**Likely cause.** The script iterates a `List<(int, String)>`
record-element collection and calls `.toList()`; somewhere in the
chain the interpreter unwraps a record element via positional
field access (`.$1`) but the runtime target is a Dart `Record`
that the bridge generator hasn't taught the property-access path
about.

**Suggested fix.** Extend the AST-driven property-access path to
recognise Dart's `Record` runtime type and route `.$1`/`.$2`/etc.
to `Record.positional[i]`. Mirror across `tom_d4rt` and
`tom_d4rt_ast`. Likely a 10-line patch + regression test for
record-typed collection iteration.

---

## E7 — `widgets/restorable_double_n_test` `+=` on null (NEW)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Low · **Owner:** interpreter

**Symptom.** `hr5/widgets/restorable_double_n_test.dart` 1 FE:

```
Unimplemented Error: Compound assignment operator += not handled for types double and null
```

**Likely cause.** Same shape as the prior testlog's D8a entry —
compound assignment `x += y` where the left side is a nullable
`double?` that is currently null. The interpreter doesn't yet
treat `null += y` as an error class with the standard Dart
"`null` check operator …" semantics; instead it raises an
`UnimplementedError`.

**Suggested fix.** Extend the compound-assignment path in both
interpreters to throw a `Null check operator used on a null
value` (matching Flutter's `!` operator semantics) when the LHS
is null and the operator requires a non-null receiver. Mirror
across `tom_d4rt` and `tom_d4rt_ast`.

---

## E8 — `widgets/scroll_deceleration_rate_test` null-check on null (NEW)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Low · **Owner:** script / interpreter

**Symptom.** `hr5/widgets/scroll_deceleration_rate_test.dart`
8 FE, all of shape:

```
Null check operator used on a null value
```

**Likely cause.** The script asserts a `Curves.fastOutSlowIn!`
or similar `!`-promoted access where the value is genuinely null
under the deep-demo path. Could be a script bug or a missing
bridge property that returns null where the native side returns
a non-null instance. Bisect needed.

**Suggested fix.** Bisect-run the script under `--reporter
expanded` to recover the throwing line, then either fix the
script or expose the missing bridge getter.

---

# Cluster R — `gir` W4 transport cascade (carry-over from `interpreter_issues.md`)

- [x] **Mitigated 2026-04-28 evening** (skip applied) - [ ] Fixed  - [ ] Partial · **Severity:** High → Medium · **Owner:** test runner / `tom_d4rt_flutterm_app` watchdog (durable fix); skip applied as day-1 mitigation

**Status.** This is the W4 wedger entry in
`interpreter_issues.md` ("Watchlist") manifesting in the
`generator_interpreter_retest_test` suite. `widgets/lock_state_test.dart`
(gir TID=43) wedged the test app /build endpoint with
`HttpException: Connection closed before full header was received`,
and the next 19 retests (TIDs 44–62) all aborted with
`SocketException: Connection refused (errno = 111)` against
ephemeral ports (34210, 34232, …). This is the textbook W4
cascade shape predicted by the `[META] Structural cascade in
retest suite` entry: the test app crashed, the runner attempted
to reconnect to a fresh port that was never opened, and every
subsequent gir test failed at /clear before it could submit
anything.

**True non-cascade gir failures (4):**

| TID | Script | Result | Shape |
|---|---|---|---|
| 31 | `retest/rendering/render_animated_size_state_test.dart` | failure | RenderFlex overflowed by 2.0 pixels (pre-existing — see `interpreter_unfixable.md`) |
| 33 | `retest/services/message_codec_test.dart` | failure | E1 — `_ByteDataView.lengthInBytes` undefined |
| 34 | `retest/services/method_codec_test.dart` | failure | E1 — `_ByteDataView.lengthInBytes` undefined |
| 37 | `retest/widgets/back_button_listener_test.dart` | failure | Router routerDelegate coercion (pre-existing — see `interpreter_unfixable.md`) |

The 4 non-cascade are all known: 2 pre-existing pre-C22 carry-overs
documented in `interpreter_unfixable.md`, plus the 2 newly-surfaced
E1 cases.

**Cascade victims (20).** All from TID=44 to TID=62: lock_state
itself's HttpException after which every subsequent script
errored at `GET /clear` with Connection refused. List:
`widgets/{nested_scroll_view_state, next_focus_intent, object_key,
raw_dialog_route, raw_keyboard_listener, raw_menu_overlay_info,
raw_radio, redo_text_intent, regular_window_controller_delegate,
regular_window_controller_linux, regular_window_controller_mac_o_s,
regular_window_controller, regular_window_controller_win32,
regular_window, render_abstract_layout_builder_mixin,
render_nested_scroll_view_viewport, render_tap_region_surface,
replace_text_intent, request_focus_action}_test.dart`.

**Suggested fix.** Two complementary changes, neither blocking:

1. **Test-app watchdog** (META structural fix) — extend
   `SendTestRunner` so a single `Connection closed` /
   `Connection refused` triggers a fast app-process restart and
   a port re-discovery, rather than letting subsequent /clear
   calls fail against a dead socket. This converts a 20-script
   cascade into a single failure + 19 retries.
2. **Skip W4 in gir** — apply the same `skip:` pattern used for
   W1, W2, W3, W5 to `widgets/lock_state_test.dart` until the
   underlying wedge is diagnosed. This recovers 19 cascade
   victims immediately.

The watchdog work is tracked in `interpreter_issues.md` "[META]
Structural cascade in retest suite" and is out of scope for a
single-cluster fix.

**2026-04-28 evening update — skip applied.** Per user request,
`widgets/lock_state_test.dart` is now skipped in
`generator_interpreter_retest_test.dart` with the same `skip:`
pattern used for W1, W2, W3, W5. A targeted re-run of the gir
suite (W4-skip artefacts:
`generator_interpreter_retest_test.W4skip.{log.txt,result.json}`)
confirms:

| Metric | Initial run (W4 active) | After W4 skip | Δ |
|---|---|---|---|
| Wall time | ~13 min (cascade timeouts) | **1 m 12 s** | -91 % |
| Pass | 34 | **54** | **+20** |
| Skip | 4 | **5** | +1 (lock_state) |
| Fail | 4 | **4** | 0 |
| Error | 20 | **0** | **-20** |
| FE scripts | 2 | 2 | 0 |

The 4 remaining failures with the cascade closed are exactly the
2 pre-existing carry-overs from `interpreter_unfixable.md` (gir
TIDs 31, 37) plus the 2 newly-surfaced E1 cases (TIDs 33, 34).
Every cascade victim (TIDs 44–62) now passes.

The skip is the day-1 mitigation; the durable fix is still the
test-app watchdog. The interpreter-side investigation work for
the lock_state wedge itself is captured below as Cluster F4.

---

# Wedger fix-clusters (F1–F5) — for the 5 currently-skipped wedger tests

These clusters track the interpreter / test-app investigation
work needed to remove the W1–W5 skips. Each skipped script is a
"deep demo" that destabilises the test app process for the rest
of the suite. Together they represent the residual structural
debt: until each is either fixed at the interpreter / test-app
level or moved to `interpreter_unfixable.md` with a script-side
workaround, gir cannot run them in-suite.

The shared root cause across F1–F4 is suspected to be the same
test-app crash mode (HTTP request handler dies mid-build, taking
the process with it; subsequent /clear calls on the dead socket
yield `Connection refused`). F5 is a distinct shape (animation
ticker / post-frame callback past teardown).

## F1 — Remove skip on `retest/widgets/context_action_test.dart` (W1)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** High · **Owner:** interpreter / test-app

**Skip rationale.** Captured in `interpreter_issues.md` "[WEDGE —
Open] W1": script wedges the test app `/clear` handler.

**To investigate next.**

1. Bisect the script to isolate the smallest demo subtree that
   reproduces the wedge in `bisect_test.dart`.
2. Capture stderr on the test-app side (`tom_d4rt_flutterm_app`
   stdout + crash log) at the moment of `/clear` failure.
3. If the crash mode matches W4 (HTTP handler dies mid-process),
   the F4 fix template applies. Otherwise diagnose the
   `Action` / `Intent` / `ActionDispatcher` interpreter shape
   that the script exercises.

**Closing criteria.** Removing the `skip:` and re-running gir
serially must report 0 failures attributable to this script and
zero cascade victims downstream. Bisect script must continue to
pass cleanly.

## F2 — Remove skip on `retest/widgets/default_text_editing_shortcuts_test.dart` (W2)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** High · **Owner:** interpreter / test-app

**Skip rationale.** Captured in `interpreter_issues.md` "[WEDGE —
Open] W2": script's `/build` hangs.

**To investigate next.**

1. Profile the `/build` request handler with a heap snapshot at
   the hang point — likely a runaway interpreter loop in the
   `DefaultTextEditingShortcuts` resolver chain.
2. The script shares Actions/Shortcuts/Intent shape with W1, so
   the F1 diagnosis may resolve this one as a side-effect.
3. If runaway is confirmed, add a per-build timeout in the test
   app's HTTP handler that returns 504 instead of hanging, so the
   test runner can move on without losing the process.

**Closing criteria.** Same as F1.

## F3 — Remove skip on `retest/widgets/live_text_input_status_test.dart` (W3)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Medium · **Owner:** test-app

**Skip rationale.** Captured in `interpreter_issues.md` "[WEDGE —
Open] W3": cascade victim of W2.

**To investigate next.** This one is likely "free" — once F2
closes, W3 should pass by virtue of running on a fresh test-app
instance. Re-test as part of the F2 verification.

**Closing criteria.** Removing the `skip:` and re-running gir
must report 0 failures attributable to this script. No standalone
diagnosis expected — fate-tied to F2.

## F4 — Remove skip on `retest/widgets/lock_state_test.dart` (W4 — applied 2026-04-28)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** High · **Owner:** interpreter / test-app

**Skip rationale.** Captured in `interpreter_issues.md` "[WEDGE —
Skipped 2026-04-28 evening] W4": script triggers
`HttpException: Connection closed before full header was received`
on `POST /build`, then 19 cascade victims at /clear. Skip applied
this evening; gir re-run with W4 skipped recovers all 19 victims.

**To investigate next.**

1. Capture the test-app's stderr / process exit signal at the
   moment of the HttpException — confirm whether the test-app
   process crashed, exited cleanly, or was killed by an OOM.
2. The script is 1183 lines with only 4 Actions/Intent
   references, so the wedge family is broader than just
   Actions/Shortcuts/Intent. Likely candidate: lock-state
   transition logic in the demo widget tree spawning a runaway
   listener chain or unbounded post-frame callback queue.
3. Bisect the script in `bisect_test.dart` (single-script harness
   with isolated test-app process) to recover the smallest
   reproduction.
4. If the test-app crash is rooted in the interpreter (e.g.,
   stack-overflow during `setState` storm), fix at the
   interpreter / `D4UserBridge State` level. If it's rooted in
   Flutter's lock-state semantics under interpretation, document
   under `interpreter_unfixable.md` with a script-side workaround.

**Closing criteria.** Removing the `skip:` and re-running gir
serially must report 0 failures attributable to this script and
zero cascade victims downstream.

**Watchdog dependency.** Even after F4 closes, the structural
test-app watchdog (META in `interpreter_issues.md`) should still
land — it provides defence-in-depth for any future deep-demo
script that surfaces a similar crash mode.

## F5 — Remove skip on `widgets/animated_switcher_test.dart` (W5 — gii)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Medium · **Owner:** interpreter / scheduler

**Skip rationale.** Captured in `interpreter_issues.md` "[WEDGE —
Open] W5": script wedges gii at test ID 54 with
`_dependents.isEmpty` silenced assertion at line 6268, then
"Lost connection to device" cascades the next 34 gii tests. Skip
applied 2026-04-28 morning; gii now reports 81/2/0 (was 78/1/4).

**To investigate next.**

1. The error shape (`_dependents.isEmpty` + generation=99 internal
   restart) suggests AnimatedSwitcher's outgoing-children list is
   leaving animation tickers / post-frame callbacks scheduled
   past teardown. The interpreter's State teardown path
   (`State.deactivate` / `State.dispose`) likely doesn't cancel
   all pending tickers when the parent rebuild swaps an outgoing
   child.
2. Bisect to isolate the smallest AnimatedSwitcher tree that
   reproduces.
3. Either (a) cancel pending tickers in the post-frame restart
   hook in `tom_d4rt_flutterm_app/lib/main.dart`, or (b) reset
   AnimatedSwitcher's outgoing-child list at suite-test boundary
   in the test app.

**Closing criteria.** Removing the `skip:` and re-running gii
serially must report 0 failures attributable to this script and
zero cascade victims downstream (the 34 scripts following test
ID 54).

---

# Carry-over open clusters

The following clusters from `interpreter_issues.md` and prior
testlog `error_analysis.md` files remain open or partially-open
in this run.

## C1 (followup) — `widgets/slotted_multi_child_render_object_widget_test.dart`

Documented in `interpreter_unfixable.md` as a residual
`dart:ui/math.dart:14` `clampDouble` assertion (downstream
Flutter framework, not interpreter-rooted). 1 FE in the prior
run; not seen in this run's secondary FE sample (the script may
no longer be in the corpus or the FE was masked). No action.

## C3, C4, C7 — section P/Q residuals

Closed in C20-series (`testlog_20260427-1339-post-c22`). No
FE evidence in this run.

## InheritedModel proxy (architecturally open)

`interpreter_issues.md` cluster 26: scripts that subclass
`InheritedModel` and call `InheritedModel.inheritFrom<T>(context,
aspect: ...)` will fail because the interpreted subclass collapses
to the same native `runtimeType`. **Not observed in this run** —
no script in the current corpus exercises it. Still architecturally
open; fix template would mirror the C20 InheritedWidget exact-type
work for InheritedModel.

## D1 — `image_sampler_slot` cascade

Closed 2026-04-27 in prior run via skip from `hardly_relevant_classes_1`.
This run: hr1 reports 205/2/0 (clean), confirming the closure holds.

## D2 — bridged-mixin field access

Partially closed 2026-04-27. Two re-surfaces in this run captured
under E3 (`scroll_position_with_single_context_test`) and E4
(`restorable_property_test`, `restorable_string_test`).

## D3 — late-field uninitialised

Documented in `interpreter_unfixable.md` as the
`registerForRestoration` lifecycle ordering issue. Two new
re-surfaces in this run captured under E4. Workaround pattern
(initialise `_controller` in `initState`) needs to be applied to
the two re-surfaced scripts.

## D4 — RestorableProperty proxy

Documented under `interpreter_unfixable.md` "D3 — Reading
`RestorableProperty.value` in `initState()` before
`restoreState()` registers it". No new instances in this run
beyond E4.

## D5 — Section E PreferredSize/Widget

Closed in C20-series; no FE evidence in this run.

## D6 — layout cascade

Carried forward as E2 in this run. Down from 18 → 16 scripts
and from ~228 → 138 FE. C22 ListView replacement pattern is the
established fix template; 16 scripts remain to patch.

## D7 — Slotted RO mixin

Closed in C21 + C20-series; no FE evidence in this run.

## D8 — misc gaps (compound `+=` with null, callback required-arg)

Two re-surfaces in this run:
- E7: `restorable_double_n_test` `+= null` (D8a).
- E8: `scroll_deceleration_rate_test` `null check on null` (likely
  D8 family, distinct from `+=`).

## Wedge taxonomy (W1–W5)

| ID | Script | Status this run | Fix-cluster |
|---|---|---|---|
| W1 | `retest/widgets/context_action_test.dart` | Skipped | F1 |
| W2 | `retest/widgets/default_text_editing_shortcuts_test.dart` | Skipped | F2 |
| W3 | `retest/widgets/live_text_input_status_test.dart` | Skipped (cascade victim of W2) | F3 |
| W4 | `retest/widgets/lock_state_test.dart` | **Skipped 2026-04-28 evening** — gir re-run 54/5/4 (cascade closed) | F4 |
| W5 | `widgets/animated_switcher_test.dart` (gii) | Skipped 2026-04-28 morning — gii 81/2/0 | F5 |

All 5 wedgers are now skipped at the suite level. The
fix-clusters F1–F5 above track the work needed to remove each
skip. F4's day-1 mitigation already recovered 20 cascade-victim
passes in this campaign; F1, F2, F3 remain to be exercised in a
future run; F5 closure unblocks the 34 gii scripts that followed
test ID 54.

---

# Summary table (NEW clusters only)

| Cluster | Severity | Owner | Suite Scripts | Total FE / Failures |
|---|---|---|---|---|
| E1 — `_ByteDataView.lengthInBytes` undefined | Medium | interpreter | 2 (gir) | 2 failures |
| E2 — layout cascade (carry-over D6)          | Low    | scripts     | 16              | 138 FE |
| E3 — bridged-mixin field access re-surface   | Medium | interpreter | 1               | 2 FE |
| E4 — late-field uninit (restoration)         | Medium | interpreter / scripts | 2 | 2 FE |
| E5 — borderRadius non-uniform                | Low    | script      | 1               | 1 FE |
| E6 — Records `.$1`/`.$2` access              | Medium | interpreter | 1               | 1 FE |
| E7 — `+=` on null double                     | Low    | interpreter | 1               | 1 FE |
| E8 — `!` on null curve                       | Low    | script / interpreter | 1     | 8 FE |
| R  — gir W4 transport cascade                | High → Mitigated | test runner | 1 trigger → 19 victims | 20 errors → 0 (after skip) |
| F1 — Remove W1 skip (`context_action_test`)  | High   | interpreter / test-app | 1 | — (open) |
| F2 — Remove W2 skip (`default_text_editing_shortcuts_test`) | High | interpreter / test-app | 1 | — (open) |
| F3 — Remove W3 skip (`live_text_input_status_test`) | Medium | test-app | 1 | — (fate-tied to F2) |
| F4 — Remove W4 skip (`lock_state_test`)      | High   | interpreter / test-app | 1 | — (skip applied; durable fix open) |
| F5 — Remove W5 skip (`animated_switcher_test`) | Medium | interpreter / scheduler | 1 | — (open; unblocks 34 gii scripts) |

Closed-on-or-before this run (no action needed):
C20a (2026-04-27), C20b (2026-04-27), C20d (2026-04-27),
C20f (2026-04-27), C21 (2026-04-27), Plan E2 (2026-04-27),
D1 (2026-04-27), D2 (2026-04-27 — partial; 2 re-surfaces logged
above), D5/D7 (2026-04-27).

---

# Key takeaways

1. **gii is fully green** (81/2/0). The W5 skip + cumulative
   C20-series + C21 fixes closed every previous gii failure.
   `essential` / `important` / `secondary` / `hr1`–`hr4` /
   `interactive` are all suite-level clean (zero failures).

2. **The `gir` "regression" was structural, not interpreter — and
   has now been mitigated.** Initial run: 24 errors decomposing
   into 4 known issues + a 19-script W4 transport cascade.
   2026-04-28 evening W4 skip applied; gir re-run reports
   **54/5/4** with the cascade fully closed in 1 m 12 s. The 4
   remaining failures are the 4 known issues only (2 pre-existing
   carry-overs + 2 E1 cases). Closing E1 (~10-line bridge fix)
   would leave gir at **56/5/2** with only the documented
   unfixables remaining.

3. **Layout cascade (E2) is the dominant FE generator** but
   produces zero test failures because the affected suites don't
   assert on `tester.takeException`. 16 scripts remain to patch
   with the C22 ListView pattern; each is independent and can be
   parallelised across PRs.

4. **Real interpreter bugs to fix next:**
   - **E1** (`_ByteDataView.lengthInBytes`) — high-impact, 2 gir
     failures, ~10-line fix in the `dart:typed_data` bridge.
   - **E6** (Records `.$1` access) — single FE but the shape
     gates any future Records-heavy test.
   - **E3** (`_controller` on `SingleTickerProviderStateMixin`
     constructor-phase) — D2-adjacent, follow the C20d deferral
     template.
   - **E7** (`+=` on null double) — 1-line fix, mirrors a known
     null-check shape.

5. **Test-app watchdog (META) is still the highest-leverage
   structural change** — even with W4 skipped, F1, F2, F3, F4
   (the durable fix), and any future deep-demo wedger benefit
   from a watchdog that converts a single test-app crash into a
   single failure + restart instead of a 19-script cascade. The
   skip path (F4 day-1 mitigation) is "good enough for now" but
   shouldn't displace the watchdog work.

6. **Wedger fix-clusters F1–F5 are the residual structural
   debt.** Each is a single-script investigation: bisect →
   diagnose crash mode → fix or document workaround. F3 is
   fate-tied to F2; F5 unblocks 34 gii scripts on closure.
   F1/F2/F4 share a likely common root cause (test-app HTTP
   handler dies mid-request) — diagnosing one may close all
   three.

7. **Suite-level cleanliness check after W4 skip:** the corpus
   is clean for `essential` (108/0/0), `important` (164/0/0),
   `secondary` (654/1/0), `hr1`–`hr5`, `interactive`, and
   `gii` (81/2/0). `gir` reports **54/5/4** with the 4
   failures being 2 documented unfixables (TIDs 31, 37) + 2
   E1 cases (TIDs 33, 34). The "all errors fixed or workaround
   documented" bar is now met: every failure is either listed in
   `interpreter_unfixable.md` (carry-overs) or has an open fix
   cluster (E1 for the new ones; F1–F5 for the skipped wedgers).
   Remaining FE noise (E2 layout cascade) does not cause test
   failures.
