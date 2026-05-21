# Example App Plan

A backlog of 25 multi-file sample apps for `tom_d4rt_flutter_test/example/`.
Each one is meant to be a small, runnable application — non-trivial, either
visually pleasing or actually useful at the desk — that exercises a
distinct corner of Flutter's dynamic / callback surface through the d4rt
interpreter.

Two samples already live in `example/` today and are used as smoke tests
by `test/sample_apps_in_tester_test.dart`:

- `counter_app/` — minimal `StatefulWidget` + `State<T>` + `setState`
  multi-file plumbing. Covers GEN-110 / GEN-112 dispatch and the
  cross-file class-resolution path.
- `sudoku_app/` — gesture-driven grid, user-defined state, side-panel
  layout via `LayoutBuilder`. Covers nested `for`-loop closure capture
  (GEN-111).

The 25 entries below are intentionally additive. Status is tracked
inline so this file doubles as a todo list — pick any `[ ]` row, build
the sample under `example/<folder>/`, add a tester test to
`sample_apps_in_tester_test.dart`, then flip the status to `[x]`.

## Conventions

- **Multi-file:** every sample splits into 3–7 files joined with
  relative imports, exercising the `resolveImportsRecursively` →
  sources-map → `D4rt.execute(library:, sources:, name: 'build')`
  pipeline that `SourceFlutterD4rt.buildMultiFile` drives.
- **Entry shape:** `main.dart` must export `Widget build(BuildContext)`
  that returns the top-level widget (typically a `MaterialApp`).
- **State management:** prefer the canonical pattern that worked
  end-to-end after the GEN-110/111/112 fixes — script-defined
  `StatefulWidget` + `State<T>` + `setState`. Fall back to
  `StatefulBuilder` only when a small in-line state holder is
  genuinely cleaner.
- **No external services.** Anything that needs network, audio, or
  filesystem I/O is out of scope so the sample runs in CI's
  `WidgetTester` and on the user's desktop without setup.
- **Tester coverage.** Every shipped sample gets at least one
  `testWidgets` case in `sample_apps_in_tester_test.dart` asserting
  the headline interaction (tap → state update visible). The
  WidgetTester viewport (1200×1200) is configured per test as
  needed.

## Coverage matrix

A rough map of which Flutter primitives each numbered entry exercises.
"Primary" = the entry is the canonical place to look for that
primitive; "incidental" appearances are not listed here.

| Primitive / callback                                | Entries (primary) |
|-----------------------------------------------------|-------------------|
| `AnimationController` + `TickerProvider`            | 2, 9, 17, 20, 25  |
| `Tween` / `CurvedAnimation` / `TweenSequence`       | 11, 17, 24, 25    |
| `AnimatedBuilder` / `AnimatedWidget`                | 9, 25             |
| `TweenAnimationBuilder` (implicit anim)             | 6, 23             |
| `AnimatedContainer` / `AnimatedAlign` / `AnimatedOpacity` / `AnimatedPositioned` | 1, 24, 17 |
| `AnimatedSwitcher`                                  | 1, 23             |
| `AnimatedList`                                      | 22                |
| `CustomPainter` + `Canvas`                          | 5, 7, 8, 10, 19, 25 |
| `Ticker` (raw)                                      | 10                |
| `Timer.periodic` / `Timer.run`                      | 2, 3, 7, 8, 17    |
| `Future` / `async`-`await`                          | 4, 14, 15         |
| `Stream` / `StreamBuilder`                          | 22, 25            |
| `Form` + `FormState` + `TextFormField` validators   | 15                |
| `TextEditingController` + `FocusNode`               | 12, 14, 22        |
| `GestureDetector` (tap/pan/scale)                   | 5, 7, 19          |
| `Draggable` + `DragTarget`                          | 17, 18            |
| `Dismissible`                                       | 13                |
| `ReorderableListView`                               | 13, 18            |
| `Navigator.push` / named routes / `Hero`            | 14, 16            |
| `showDialog` / `showModalBottomSheet` / `SnackBar`  | 14                |
| `PageView` + `PageController`                       | 23                |
| `TabController` / `TabBar` / `TabBarView`           | 20                |
| `BottomNavigationBar` + `IndexedStack`              | 21                |
| `ChangeNotifier` + `ListenableBuilder`              | 3, 13             |
| `ValueNotifier` + `ValueListenableBuilder`          | 11                |
| `InheritedWidget` / `InheritedNotifier`             | 21                |
| `FocusableActionDetector` / `Actions` / `Shortcuts` | 7, 24             |
| `RawKeyboardListener` / `Focus` / `KeyEvent`        | 7                 |
| `InteractiveViewer` (pan / zoom)                    | 16, 19            |
| `MediaQuery` / `LayoutBuilder`                      | every wide layout |
| `Theme.of` + `ChangeNotifier`-driven theme swap     | 3                 |

---

## The 25 sample apps

### 1. [x] `tic_tac_toe` — classic turn-based grid

A 3×3 board where two local players take turns. Each placed mark
fades+scales in via `AnimatedSwitcher`. On win, the connecting line
draws across the board with an `AnimationController` + `CustomPainter`.

**Exercises:** turn state in script `State<T>`, `AnimatedSwitcher` for
new marks, `CustomPainter` for the win line, `AnimationController` for
the line draw, `setState` after every tap. Reset button rebuilds.

**Files:** `main.dart`, `app.dart`, `home.dart` (state + board),
`cell.dart`, `win_line_painter.dart`, `result_banner.dart`.

**Shipped:** [commit pending] — two tester cases in
`sample_apps_in_tester_test.dart` (top-row X win + 9-cell draw)
play out scripted sequences and assert headline + score updates.
Found two open interpreter clusters along the way and logged them
in `tom_d4rt_flutter_ast/doc/interpreter_issues.md`:

- generic-constructor type inference doesn't reach `ValueKey(x)`
  → resolves to `ValueKey<dynamic>` instead of `ValueKey<String>`.
  Workaround: write the type explicitly,
  e.g. `ValueKey<String>('cell-$id')`.
- AnimatedSwitcher's inner Stack accumulates duplicate-keyed
  children across user-State `setState` rebuilds. Workaround:
  use plain `Text` in headline-style swap sites; per-cell
  AnimatedSwitchers (independent State per cell) still work.

---

### 2. [x] `stopwatch_laps` — running-clock with lap history

A digital stopwatch counting at 50 ms resolution, Start / Stop /
Reset buttons, plus a Lap button that appends to a scrolling
`ListView` with FAST / SLOW chips on the best / worst split.
The running indicator dot animates in/out via `AnimatedContainer`
(implicit animation — no continuous-frame `AnimationController`
because the d4rt interpreter can't keep up with a `repeat()` at
60 fps).

**Exercises:** `Timer.periodic` keeping millisecond state,
`DateTime.now()` deltas across pauses, `ListView.builder` for
laps, `AnimatedContainer` for the indicator pulse, formatted
elapsed/split times, buttons enabled by state.

**Files:** `main.dart`, `app.dart`, `home.dart` (state + Scaffold),
`time_display.dart`, `format.dart`, `lap.dart`, `lap_list.dart`.

**Shipped:** two tester cases in `sample_apps_in_tester_test.dart`
— "Start → wait → Stop accumulates elapsed time" pumps simulated
time via repeated `tester.pump(60ms)` so the FakeTimer fires and
the elapsed display advances; "Lap button appends entries" +
Reset clears them.

Found and fixed three d4rt interpreter bugs along the way (all
documented in `tom_d4rt_flutter_ast/doc/interpreter_issues.md`):

- **GEN-113** — `ValueKey('foo')` resolved to `ValueKey<dynamic>`
  instead of inferring `T` from the argument's runtime type. The
  custom factory in `d4rt_runtime_registrations.dart`'s `_`
  wildcard returned `ValueKey(value)` unconditionally, masking
  the runtime-value-aware factories underneath. Wildcard now
  returns `null` to fall through.
- **GEN-114** — Timer bridge had no `isAssignable` callback, so
  `FakeTimer` (flutter_test's `runAsync` clock) failed every
  method lookup. Added `isAssignable: (v) => v is Timer` to the
  Timer bridge in d4rt's stdlib.
- (Performance note, not a bug.) A `AnimationController.repeat()`
  whose listener calls `setState(() {})` at 60 fps creates more
  work than the script interpreter can do in real time, locking
  the test runner. Use `AnimatedContainer` /
  `AnimatedSwitcher` for implicit animations in script samples
  instead of `addListener`-driven explicit ticks; the framework
  amortises those across one transition rather than per-frame
  interpretation.

---

### 3. [x] `pomodoro_timer` — work / break cycle with theme transitions

A 25-min work session followed by a 5-min break, cycling. Theme
seed colour swaps between red (work) and green (break) and the
swap is animated. Notification chip pops in via
`AnimatedSlide`/`AnimatedOpacity` when a phase ends.

**Exercises:** `Timer.periodic`, `ChangeNotifier` for the session
state, `ListenableBuilder`, dynamic `Theme.of` via
`ColorScheme.fromSeed`, implicit animations on theme-derived
colours, phase-end UI nudge.

**Files:** `main.dart`, `app.dart`, `session.dart` (notifier),
`home.dart`, `phase_chip.dart`.

**Shipped:** four tester cases in `sample_apps_in_tester_test.dart`
exercise (a) boot into the 25:00 focus phase, (b) Start → 1-second
FakeTimer pump → `24:59`, then Pause freezes the countdown, (c)
Skip flips phase to BREAK (`05:00`), surfaces the phase-end chip,
counts the cycle, auto-dismisses after the notice window, and a
second Skip returns to FOCUS with a "Back to work" notice, (d)
Reset returns to the initial state.

The sample is the first one in this suite to script-define a
`ChangeNotifier` subclass driving a `ListenableBuilder` — both
ran cleanly under d4rt without any new interpreter fixes (the
existing GEN-112 setState-via-`nativeStateProxy` routing and the
GEN-114 Timer.isAssignable for FakeTimer were the only ones
exercised, and both held). The notifier holds a 1 Hz
`Timer.periodic` for the countdown plus a one-shot `Timer` for
the chip auto-dismiss; both fire correctly under the
flutter_test FakeTimer.

---

### 4. [x] `calculator` — desk calculator with history

Classic 4-operation calculator. A `GridView` of buttons, expression
display at the top, scrollable history list at the bottom. Buttons
animate on tap (`InkWell`); long-press repeats backspace.

**Exercises:** `GridView.count` button layout, `setState` after
every input, expression parser (script-side), `Future.microtask`
deferred clears, `LongPressGestureRecognizer` via `GestureDetector`.

**Files:** `main.dart`, `home.dart`, `engine.dart` (parser),
`button_pad.dart`, `history_strip.dart`.

**Shipped:** seven tester cases in `sample_apps_in_tester_test.dart`
exercise (a) boot rendering `0` and the empty-history placeholder,
(b) `1 + 2 =` digit/operator/equals path producing `3` and pushing
a history entry, (c) operator precedence `2 + 3 × 4 = 14` (the
two-pass evaluator folds `×÷` before `+−`), (d) division by zero
surfacing `Error` on the display, (e) `AC` then a fresh
`7 × 8 = 56`, (f) long-press backspace deleting multiple digits in
one hold (drives a 90 ms `Timer.periodic` repeat schedule), (g)
clear-history wiping the strip back to the empty placeholder.

The sample uses the canonical d4rt-friendly pattern — script-defined
`StatefulWidget` + `State<CalculatorHome>` + `setState` driving a
plain (non-`ChangeNotifier`) engine. No new interpreter bugs
surfaced; the existing GEN-110/112 setState dispatch and GEN-114
Timer-isAssignable held under the GestureDetector long-press path
and the `Timer.periodic` backspace-repeat. The
`Future.microtask`-deferred housekeeping hook is wired in but
currently a no-op placeholder — the slot is there for future
overlays (e.g. a "result copied" snackbar) without churning the
state machine.

---

### 5. [x] `drawing_pad` — single-stroke sketchpad

A `CustomPainter` canvas that accumulates strokes from finger / mouse
drags. Toolbar: colour swatch, brush size slider, undo, redo, clear.
Strokes are stored as `List<Offset>` and re-rendered on every tick.

**Exercises:** `CustomPainter.paint`, `shouldRepaint`,
`GestureDetector.onPanStart/Update/End` callbacks, undo/redo
ring-buffer state, `Slider` callback, colour-picker swatch grid.

**Files:** `main.dart`, `home.dart`, `stroke.dart`,
`canvas_painter.dart`, `tool_bar.dart`.

**Shipped:** five tester cases in `sample_apps_in_tester_test.dart`
exercise (a) boot rendering with the canvas-area / canvas-paint /
tool-bar keys present and Undo/Redo/Clear all disabled, (b)
`timedDragFrom` synthesising a pan that fires exactly one
`onPanStart` + one `onPanEnd` and enables Undo + Clear, (c) full
undo / redo round-trip where committing a *new* stroke correctly
clears the redo history (the "branch the timeline" rule), (d) Clear
emptying both strokes and redo stack and disabling all three
buttons, (e) tapping a colour swatch emitting one trail line whose
component values match the red palette entry (0xFFDC2626 → r≈0.8627,
g≈b≈0.1490 — the test accepts both legacy `Color(0x...)` and the
current Flutter component-form `toString`).

The sample uses the canonical d4rt-friendly pattern: script-defined
`StatefulWidget` + `State<DrawingPadHome>` + `setState` driving a
`CustomPaint` whose `painter` is a script-defined `CanvasPainter`
subclass (proven by tic_tac_toe's `WinLinePainter`). `GestureDetector`
with `HitTestBehavior.opaque` catches pan events anywhere in the
canvas Rect; `Path.moveTo` / `lineTo` + `Canvas.drawPath` /
`Canvas.drawCircle` for stroke rendering. The swatch row uses
`List.generate(palette.length, (i) => ...)` (not classic
`for (var i = 0; ...)`) to dodge the d4rt loop-variable
closure-capture issue. No new interpreter bugs surfaced — all
existing fixes (GEN-110/112 setState dispatch, GEN-113 explicit
`ValueKey<String>`, GEN-114 Timer.isAssignable) held.

---

### 6. [x] `memory_match` — flip-card pair-matching game

4×4 / 6×6 grid of face-down cards. Tap reveals; second tap matches
or hides. Match flow uses `Future.delayed` + `setState`. Each card
flips with a `TweenAnimationBuilder<double>` rotating around Y. Move
counter and "best" highscore persisted in-memory across resets.

**Exercises:** `TweenAnimationBuilder` for the flip,
`Future.delayed` resets, grid layout, win condition,
difficulty selector (`SegmentedButton` or `ToggleButtons`).

**Files:** `main.dart`, `home.dart`, `game.dart` (state machine),
`card_widget.dart`, `score_panel.dart`, `difficulty.dart`.

**Shipped notes (2026-05-20):**

- 6 example files under `example/memory_match/` driven by a 7-case
  `testWidgets` group in `test/sample_apps_in_tester_test.dart`
  (boot easy/hard, single flip, mismatch resolve, match resolve,
  reset mid-game, solve-all-pairs records best).
- Deterministic seed (`_kShuffleSeed = 4242`) lets tests address
  matching pairs by pre-computed slot indices.
- Difficulty selector implemented as an `OutlinedButton` toggle
  pair (kept off `SegmentedButton` to stay within the existing
  bridge surface).
- **Interpreter fix:** generalised the `_prefixedImports` merge in
  `Environment.importEnvironment` (both `tom_d4rt` and
  `tom_d4rt_ast` in sync). When two file-level envs each bind the
  same prefix (e.g. `home.dart` and `card_widget.dart` both doing
  `import 'dart:math' as math;`), the module loader hands each one
  a fresh `shallowCopyFiltered` of the imported env. Previously
  the merge threw `Name conflict in environment: Symbol 'math'
  (prefixed import) is already defined with a different
  environment.` Now non-identical collisions are merged
  (`importEnvironment(env, errorOnConflict: false)`), matching
  Dart's additive prefix-scope semantics. Not specific to
  `dart:math` or to Flutter — any multi-file script with same-
  prefix imports across files benefits.
- All 33 sample-apps tests pass, `tom_d4rt` suite passes (1751
  PASS, only the pre-existing `I-BUG-14a` Won't-Fix failure),
  `tom_d4rt_ast` 117/117 PASS.

---

### 7. [x] `snake_game` — keyboard-driven arcade snake — SHIPPED

A 20×20 grid; arrow keys / WASD steer; speed ramps up with score.
Rendered via `CustomPainter` (snake body + food). Game over modal
on collision; restart via Enter / Reset button. Boots paused with a
length-3 snake and the seeded food pellet at `(17,12)` (kFoodSeed=1337);
tests advance ticks deterministically via a `btn-step` button rather
than the auto-play `Timer.periodic`.

**Exercises:** `Focus` + `KeyboardListener` (or
`FocusableActionDetector` with `Shortcuts`/`Actions`),
`Timer.periodic` game tick, `CustomPainter` rendering, score
animation, `RawKeyEvent` dispatch.

**Files:** `main.dart`, `home.dart`, `game.dart` (board + tick),
`snake.dart`, `board_painter.dart`, `keymap.dart`.

**Tests:** 7/7 pass in `test/sample_apps_in_tester_test.dart`
(boot, step, queued turn, 180° reject, eat + grow, wall game-over,
reset).

**Generic interpreter fixes landed while shipping #7:**

- **GEN-100 (Random / stdlib bridge propagation):** isolated stdlib
  environments (`dart:math`, `dart:io`, …) were unreachable from
  `globalEnvironment.toBridgedInstance` once a value (e.g. a
  `_Random` returned by `Random(seed)`) was passed through an
  interpreted function. `Environment.propagateBridgeTypesTo` now
  mirrors a stdlib's type→bridge mapping into `globalEnvironment`
  without polluting the lexical name scope; wired from
  `ModuleLoader._registerStdlib`. Mirrored in `tom_d4rt_ast`.
- **InterpretedInstance `==` / `hashCode` dispatch + recursion
  guard:** user-defined `==` and `hashCode` are now honoured so
  interpreted instances slot into native Dart `Set`/`Map`. A
  static identity-keyed re-entrancy guard breaks recursion caused
  by eager `$hashCode` string interpolation inside the
  interpreter's own `Logger.debug` calls. Mirrored in
  `tom_d4rt_ast`.

---

### 8. [x] `conway_life` — Conway's Game of Life with patterns — SHIPPED

A 60×40 cell grid. Click to toggle cells; play / pause /
step / clear; speed slider; preset patterns menu (glider, blinker,
LWSS, R-pentomino). Generations counted in a `Chip` in the control
bar. Boots paused so `testWidgets` can drive a deterministic
stamp-and-step sequence via the visible `btn-step` / `btn-clear`
buttons rather than the auto-play `Timer.periodic`.

**Exercises:** `Timer.periodic`, `CustomPainter` for fast
rendering, `GestureDetector.onPanUpdate` for paint-cells-by-dragging,
preset menu via `PopupMenuButton`, `Slider` for tick rate.

**Files:** `main.dart`, `home.dart`, `board.dart` (state +
neighbours), `patterns.dart`, `grid_painter.dart`, `control_bar.dart`.

**Tests:** 6/6 pass in `test/sample_apps_in_tester_test.dart`
(boot, blinker period-2, block static, glider 4-gen translation,
clear-resets-state, play→pause trail).

**Generic interpreter fix landed while shipping #8:**

- **`D4.activeVisitor` propagation across interpreted calls.** Native
  Dart container ops (e.g. `Map<Cell,int>` lookups, `Set<Cell>` adds)
  dispatch through `InterpretedInstance.hashCode` / `==`, which need
  `D4.activeVisitor` to invoke the user-defined override. Before this
  fix `activeVisitor` was only set inside the bridged
  `instance.hashCode` adapter, so a Map/Set lookup happening *outside*
  that adapter fell back to identity hashing — user `==` returned
  `true` while `hashCode` returned identity, silently breaking every
  hash-based container holding interpreted values. Fix: wrap
  `InterpretedFunction.call` (in both `tom_d4rt` and `tom_d4rt_ast`)
  in `D4.withActiveVisitor`, so the active visitor is alive for the
  entire body of every interpreted call. Generic — benefits every
  user class with custom `==`/`hashCode`, not just Conway's `Cell`.

---

### 9. [x] `bouncing_balls_physics` — multi-ball elastic collisions — SHIPPED

N coloured balls bounce inside a fixed-size physics world
(400×300 px). Position updated each animation tick via
gravity + velocity. Sliders adjust gravity (0–2000 px/s²) and
elasticity (0–1). Spawn button adds a ball at a seeded
location; tap on the canvas adds one at the cursor. Boots
paused with a `btn-step` button so `testWidgets` can drive the
simulation deterministically (one fixed `kStepDt=0.05` per tap)
without racing the auto-play `AnimationController`.

**Exercises:** `AnimationController` driving the sim,
`SingleTickerProviderStateMixin`, `CustomPainter` for the
balls, `Slider` callbacks, `GestureDetector.onTapDown` to spawn
balls, immutable `Ball.copyWith` and id-based equality so the
roster lives cleanly across `setState`.

**Files:** `main.dart`, `home.dart`, `world.dart` (Ball, World,
`stepWorld`, `spawnBall`), `ball_painter.dart`,
`physics_controls.dart`.

**Tests:** 7/7 pass in `test/sample_apps_in_tester_test.dart`
(boot defaults, spawn id=0 inside world, step makes ball fall
with topY matching Euler math 26→30→…, ball stays in-bounds and
bounces by step 30, spawn-N + clear resets RNG, play/pause
emits a single play+pause pair, canvas tap spawns at cursor).

**Generic interpreter fixes landed while shipping #9:** none.
Everything worked on top of the GEN-100 stdlib propagation fix
(`Random(seed)` from `dart:math`) and the `D4.withActiveVisitor`
call wrap (`Ball` equality through `Set<Ball>`) that shipped
with examples #7 and #8 respectively.

---

### 10. [x] `particle_field` — interactive particle attractor — SHIPPED

A swarm of 20 particles drifting in a fixed 600×400 world,
seeded by `Random(kParticleSeed)` so boots are reproducible.
Cursor / finger position acts as an attractor; a Material 3
`SegmentedButton<FieldMode>` toggles between Attract / Repel /
Orbit. The sim is driven by a raw `Ticker` (created via
`createTicker` on `SingleTickerProviderStateMixin`, NOT via an
`AnimationController`, per the spec). Boots paused with a
`btn-step` button so `testWidgets` can advance the field
deterministically (one fixed `kStepDt=0.05` per tap).

True multi-frame trail rendering (semi-transparent canvas
overlay) was simplified out — `CustomPainter` doesn't persist
between frames in our setup, so the spec's "trails fade via
paint with semi-transparent overlay" is approximated by colour
choice + a dark background. A real trail would need
`Picture`/`ui.Image` plumbing that isn't bridged today; the
fix-the-bridge path is tracked separately.

**Exercises:** raw `Ticker` (not `AnimationController`),
`CustomPainter`, `MouseRegion` for cursor hover,
`GestureDetector.onTapDown` for taps, `SegmentedButton<FieldMode>`
for mode toggles, immutable `Particle.copyWith` and id-based
equality.

**Files:** `main.dart`, `home.dart`, `field.dart` (Particle,
FieldMode, Field, seedField, stepField, centroid, meanRadius),
`particle_painter.dart`, `mode_selector.dart`.

**Tests:** 7/7 pass in `test/sample_apps_in_tester_test.dart`
(boot defaults at world centre, Attract mode contracts meanR
over 20 steps, mode → Repel emits trail and chip updates,
mode → Orbit ditto, reset re-seeds and restores Attract, canvas
tap repositions attractor inside world bounds, raw Ticker
play/pause emits one play+pause pair).

**Generic interpreter fixes landed while shipping #10:** none.
Builds clean on the existing GEN-100 stdlib propagation,
`D4.withActiveVisitor` call wrap, and bridged
`SingleTickerProviderStateMixin.createTicker` /
`SegmentedButton<T>` / `MouseRegion` already shipping in
`tom_d4rt_flutter_ast`.

---

### 11. [x] `color_picker_studio` — HSV / RGB / HEX picker — SHIPPED

Three coordinated panels: HSV sliders, RGB sliders, hex input,
all driven by a single shared `ValueNotifier<Color>` rebuilt
through `ValueListenableBuilder`. The live-preview square at the
top displays the active hex; below it a `TextField` accepts hex
input (`#RRGGBB` or `RRGGBB`, case-insensitive) and an `Apply`
button commits on submit. The RGB panel shows three integer
`Slider`s (0–255) with stable keys (`slider-r/g/b`); the HSV panel
shows H (0–360), S (0–100), V (0–100), with the math implemented
in pure Dart (`rgbToHsv` / `hsvToRgb`) so it doesn't depend on
`HSVColor` bridge coverage. A bottom swatch strip holds the eight
most recent colours; tapping a swatch makes it the active colour
and pushes it back to the front. Invalid hex submissions surface
an `errorText` on the field and do not mutate state.

The body is wrapped in a `SingleChildScrollView` because the
800×600 test viewport isn't tall enough for preview + hex row +
RGB + HSV + swatch strip simultaneously. The `picker.recent` /
`picker.hex` / `picker.swatch` / `picker.hex.invalid` trail prints
are stable-prefix ASCII so the test harness can scan them with a
single matcher.

**Exercises:** `ValueNotifier<Color>` shared across panels,
`ValueListenableBuilder` (twice — for colour and for recents),
`TextField` + `TextEditingController` with `onSubmitted` and
`didUpdateWidget` sync, `Slider` callbacks (two-way binding via
`Color.fromARGB`), pure-Dart RGB↔HSV math, integer hex parsing
via `int.parse(s, radix: 16)`, deduplicating recents-list helper,
`GestureDetector` swatches (not `InkWell`, to avoid needing a
`Material` ancestor inside the scroll view).

**Files:** `main.dart`, `home.dart`, `color_model.dart`
(rgbToHsv / hsvToRgb / colorToHex / hexToColor / recentsAdd),
`hsv_panel.dart`, `rgb_panel.dart`, `hex_field.dart`,
`swatch_strip.dart`.

**Tests:** 5/5 pass in `test/sample_apps_in_tester_test.dart`
(boots with `kInitialColor=#5599FF` and 8 seeded swatches, hex
field accepts a valid colour and pushes onto recents, invalid
hex is rejected without mutating state, tapping a seeded swatch
swaps the active colour and commits to recents, same-colour
submit is a no-op on the trail). Preview text is targeted via
`Key('preview-hex-label')` since `find.text('#RRGGBB')` would
match both the preview `Text` and the `EditableText` of the hex
field.

**Generic interpreter fixes landed while shipping #11:** none.
Pure layout exercise built on the existing `ValueNotifier<T>`,
`ValueListenableBuilder<T>`, `TextEditingController`, and
`Slider` bridges already shipping in `tom_d4rt_flutter_ast`.

---

### 12. [ ] `tip_calculator` — split-the-bill tool

Bill amount text field, tip % slider (0–30), party size stepper.
Live shows tip total, grand total, per-person amount. Currency
locale picker. Tab/Shift-Tab navigates between fields cleanly via
explicit `FocusNode`s.

**Exercises:** `TextEditingController` + `FocusNode`,
`NumberFormat` parsing/formatting, `Slider`, `Stepper`-ish UI built
from `IconButton`s, focus traversal via `FocusTraversalGroup`.

**Files:** `main.dart`, `home.dart`, `inputs.dart`, `summary.dart`,
`locale_dropdown.dart`.

---

### 13. [ ] `todo_list` — reorderable / swipable task list

A useful real todo list. Add via text field at the top, mark done
(strikethrough animates), swipe-to-delete via `Dismissible`,
drag-to-reorder via `ReorderableListView`. Filter tabs: All /
Active / Completed.

**Exercises:** `ReorderableListView.builder`, `Dismissible` with
confirm-delete bottom sheet, `ChangeNotifier`-backed store,
`ListenableBuilder`, `AnimatedContainer` for the strikethrough
fade. Tab-style filter via `SegmentedButton`.

**Files:** `main.dart`, `home.dart`, `store.dart` (notifier),
`task.dart`, `task_tile.dart`, `composer.dart`, `filter_bar.dart`.

---

### 14. [ ] `note_app` — master/detail with dialogs and sheets

Left pane: list of notes (title + first line). Right pane: editor
for the selected note. New note from FAB; delete via `AlertDialog`
confirm; share menu via `showModalBottomSheet`. Title bar shows
"saved" `SnackBar` on auto-save (debounced via `Future.delayed`).

**Exercises:** master/detail layout with `LayoutBuilder` (stacks
on narrow), `Navigator.push` for "open in new window", `AlertDialog`,
`showModalBottomSheet`, `SnackBar`, debounced async save,
`TextEditingController` lifecycle across selection changes.

**Files:** `main.dart`, `app.dart`, `home.dart`, `store.dart`,
`note.dart`, `note_list.dart`, `editor.dart`, `dialogs.dart`.

---

### 15. [ ] `form_wizard` — multi-step form with validators

Account-sign-up style wizard: 4 steps (account, profile, preferences,
review). Each step is a `Form` with its own `GlobalKey<FormState>`.
Top progress bar advances. Final step shows a summary; submit
disables everything and shows a fake "submitting…" overlay (no
real network).

**Exercises:** `Form` + `TextFormField` + validators + `autovalidateMode`,
multiple `GlobalKey<FormState>` instances, `AnimatedSwitcher` between
steps, `AnimationController` for the progress bar, `Future.delayed`
for the simulated submit.

**Files:** `main.dart`, `app.dart`, `wizard.dart` (controller),
`step_account.dart`, `step_profile.dart`, `step_preferences.dart`,
`step_review.dart`, `progress_bar.dart`.

---

### 16. [ ] `photo_gallery_hero` — Hero transitions + pan-zoom

Grid of placeholder "photos" (gradients + emoji labels). Tap a
thumbnail to fly into a fullscreen viewer with `Hero`; in the
viewer, `InteractiveViewer` enables pinch-zoom and pan. Swipe
through adjacent photos via `PageView` while preserving the Hero
animation.

**Exercises:** `Hero` with matched `tag`, `Navigator.push` with
`PageRouteBuilder` for custom transition, `InteractiveViewer` pan
& zoom, `PageView.builder`, gradient `CustomPaint` placeholders.

**Files:** `main.dart`, `home.dart`, `gallery_grid.dart`,
`viewer_page.dart`, `gradient_tile.dart`.

---

### 17. [ ] `card_swiper` — Tinder-style swipeable card stack

A deck of cards stacked at slight offsets. Drag the top card; on
release past a threshold it flies away (`AnimationController` +
`Tween<Offset>`) and the next card animates up. Swipe-left / -right
buttons drive the same animation programmatically. Counter at the
top shows liked / passed.

**Exercises:** `Draggable` + `DragTarget` (or `GestureDetector`
pan), `AnimationController.animateWith` or `forward`,
`SpringSimulation` (if `flutter_physics` is bridged; otherwise
linear), `Transform.rotate` proportional to drag distance,
`AnimatedPositioned` for the underlying deck.

**Files:** `main.dart`, `home.dart`, `deck.dart`, `card_widget.dart`,
`swipe_controller.dart`.

---

### 18. [ ] `kanban_board` — multi-column drag-and-drop

3 columns (To do / Doing / Done). Each holds a
`ReorderableListView` of cards. Cards can also be dragged between
columns via `LongPressDraggable` + `DragTarget`. "Add card"
composer per column. Card details edit via `showDialog`.

**Exercises:** `LongPressDraggable` + `DragTarget` for cross-column
moves, `ReorderableListView.builder` for within-column ordering,
custom drop indicators, `ChangeNotifier` board state, `AlertDialog`
edit form.

**Files:** `main.dart`, `home.dart`, `board.dart` (notifier),
`column_view.dart`, `card_tile.dart`, `composer.dart`, `card_dialog.dart`.

---

### 19. [ ] `bezier_curve_editor` — interactive control points

A cubic Bézier rendered via `CustomPainter`. Drag the four control
points to reshape. Slider sets the curve resolution (segments).
Toggle to show / hide the construction triangle and tangent
markers. Export `Curves.elastic`-style preview on a moving dot.

**Exercises:** `CustomPainter` with `Path.cubicTo`,
`GestureDetector.onPanUpdate` per draggable point, hit-test math,
`AnimationController` driving the preview dot along the curve via
`Tween` + curve sampling.

**Files:** `main.dart`, `home.dart`, `bezier_model.dart`,
`bezier_painter.dart`, `controls.dart`.

---

### 20. [ ] `tabbed_dashboard` — mixed-content tab shell

3 tabs: a chart (`CustomPaint` line chart), a settings form, a
log viewer (`AnimatedList` streaming entries). Tab transitions
animate via the framework's default sliding. A "Pause" toggle
freezes the log stream.

**Exercises:** `DefaultTabController` + `TabBar` + `TabBarView`,
state preservation across tab switches via `AutomaticKeepAliveClientMixin`,
`AnimatedList` insertions, `Stream`-driven log generation
(`Stream.periodic`).

**Files:** `main.dart`, `app.dart`, `home.dart`, `tab_chart.dart`,
`tab_settings.dart`, `tab_log.dart`, `chart_painter.dart`.

---

### 21. [ ] `bottom_nav_shell` — persistent-tab navigation shell

3 bottom-nav destinations (Home / Search / Profile). Each tab
owns its own `Navigator` so back navigation is per-tab. Tabs are
stacked via `IndexedStack` so scroll positions / form input
survive switches. Theme toggle is shared via an `InheritedNotifier`.

**Exercises:** `BottomNavigationBar` (or `NavigationBar`),
`IndexedStack` for state preservation, multiple `Navigator`s,
`InheritedNotifier` for cross-tab theme state, `WillPopScope`
intercept (or the modern `PopScope`).

**Files:** `main.dart`, `app.dart`, `home.dart`, `tab_navigator.dart`,
`tab_home.dart`, `tab_search.dart`, `tab_profile.dart`,
`theme_scope.dart`.

---

### 22. [ ] `chat_ui` — animated message bubbles + composer

A chat room with one local "user" and a scripted "bot" that
echoes after a short delay. Bubbles slide-in from left/right via
`AnimatedList.of(context).insertItem`. Composer is a multiline
`TextField` with send button + Enter-to-send. Auto-scrolls to
the newest message.

**Exercises:** `AnimatedList` with custom slide+fade builder,
`TextField` + `FocusNode` + composer state, `ScrollController`
auto-scroll, `Stream.fromFuture` for the bot reply,
`Future.delayed` for "typing…" indicator.

**Files:** `main.dart`, `home.dart`, `chat_store.dart`, `message.dart`,
`bubble.dart`, `composer.dart`.

---

### 23. [ ] `carousel_pager` — parallax page carousel

Horizontal `PageView.builder` of 8 vivid pages (each a generated
gradient with a centred title). Background image scrolls at half
speed for a parallax effect; page indicator dots animate. Auto-play
toggle via a `Switch`. Tap a page to expand into a fullscreen detail
with `TweenAnimationBuilder` enlargement.

**Exercises:** `PageView.builder` + `PageController` listener for
the parallax offset, `Switch`/`Timer.periodic` autoplay,
`AnimatedSwitcher` between page → detail, page-indicator
animation.

**Files:** `main.dart`, `home.dart`, `pages.dart`, `page_card.dart`,
`indicator.dart`, `detail_page.dart`.

---

### 24. [ ] `slide_puzzle` — 4×4 sliding-tile puzzle

A 15-puzzle. Tap a tile adjacent to the gap to slide it
(`AnimatedPositioned` transition). Shuffle button scrambles
guaranteed-solvable; solver button runs a BFS animation
move-by-move. Move counter, timer, "best time" display.

**Exercises:** `Stack` + `AnimatedPositioned`, gesture detection
on each tile, BFS solver in script, `Timer` for the elapsed
counter, win-state detection + celebratory `Confetti`-ish
particle burst via `CustomPainter` + `Ticker`.

**Files:** `main.dart`, `home.dart`, `puzzle.dart`, `tile.dart`,
`solver.dart`, `confetti.dart`.

---

### 25. [ ] `clock_face` — live analog clock + world-clock dial

An analog clock face rendered via `CustomPainter`: hour / minute /
second hands, tick marks, date pill at the bottom. The second hand
sweeps smoothly (60 fps via `AnimationController`). A rotary dial
picks a timezone offset; a second smaller clock shows that zone.

**Exercises:** `CustomPainter` for the clock graphics,
`AnimationController` driving smooth seconds, `DateTime.now()`
each frame, custom rotary gesture (`GestureDetector.onPanUpdate`
with polar-coord math) for the timezone dial,
`AnimatedRotation` for the smaller dial.

**Files:** `main.dart`, `home.dart`, `clock.dart` (state),
`clock_painter.dart`, `timezone_dial.dart`.

---

## How to claim an entry

1. Pick a `[ ]` row that excites you and add a TODO list entry in
   the working session.
2. Scaffold the sample under
   `tom_d4rt_flutter_test/example/<folder>/` with the suggested
   file layout (or your variant).
3. Run it locally via the test runner's "Run Sample" picker to
   smoke-test interactivity.
4. Add a `testWidgets` case to
   `tom_d4rt_flutter_test/test/sample_apps_in_tester_test.dart`
   that mounts the sample with `_mountSample`, performs the
   headline interaction, and asserts the resulting widget state.
5. Run `dart analyze example/<folder>/` — should be clean.
6. Run the full
   `flutter test test/sample_apps_in_tester_test.dart` — should
   stay green for every existing sample.
7. If the interpreter trips on something, capture the
   `_printLog` trail in the failing test and add a focused
   reproducer entry to
   `tom_d4rt_flutter_ast/doc/interpreter_issues.md` before
   moving on.
8. Flip the checkbox to `[x]` and reference the commit.
