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

### 3. [ ] `pomodoro_timer` — work / break cycle with theme transitions

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

---

### 4. [ ] `calculator` — desk calculator with history

Classic 4-operation calculator. A `GridView` of buttons, expression
display at the top, scrollable history list at the bottom. Buttons
animate on tap (`InkWell`); long-press repeats backspace.

**Exercises:** `GridView.count` button layout, `setState` after
every input, expression parser (script-side), `Future.microtask`
deferred clears, `LongPressGestureRecognizer` via `GestureDetector`.

**Files:** `main.dart`, `home.dart`, `engine.dart` (parser),
`button_pad.dart`, `history_strip.dart`.

---

### 5. [ ] `drawing_pad` — single-stroke sketchpad

A `CustomPainter` canvas that accumulates strokes from finger / mouse
drags. Toolbar: colour swatch, brush size slider, undo, redo, clear.
Strokes are stored as `List<Offset>` and re-rendered on every tick.

**Exercises:** `CustomPainter.paint`, `shouldRepaint`,
`GestureDetector.onPanStart/Update/End` callbacks, undo/redo
ring-buffer state, `Slider` callback, colour-picker swatch grid.

**Files:** `main.dart`, `home.dart`, `stroke.dart`,
`canvas_painter.dart`, `tool_bar.dart`.

---

### 6. [ ] `memory_match` — flip-card pair-matching game

4×4 / 6×6 grid of face-down cards. Tap reveals; second tap matches
or hides. Match flow uses `Future.delayed` + `setState`. Each card
flips with a `TweenAnimationBuilder<double>` rotating around Y. Move
counter and "best" highscore persisted in-memory across resets.

**Exercises:** `TweenAnimationBuilder` for the flip,
`Future.delayed` resets, grid layout, win condition,
difficulty selector (`SegmentedButton` or `ToggleButtons`).

**Files:** `main.dart`, `home.dart`, `game.dart` (state machine),
`card_widget.dart`, `score_panel.dart`, `difficulty.dart`.

---

### 7. [ ] `snake_game` — keyboard-driven arcade snake

A 20×20 grid; arrow keys / WASD steer; speed ramps up with score.
Rendered via `CustomPainter` (snake body + food). Game over modal
on collision; restart via Enter.

**Exercises:** `Focus` + `KeyboardListener` (or
`FocusableActionDetector` with `Shortcuts`/`Actions`),
`Timer.periodic` game tick, `CustomPainter` rendering, score
animation, `RawKeyEvent` dispatch.

**Files:** `main.dart`, `home.dart`, `game.dart` (board + tick),
`snake.dart`, `board_painter.dart`, `keymap.dart`.

---

### 8. [ ] `conway_life` — Conway's Game of Life with patterns

A 60×40 cell grid. Click to toggle cells; play / pause /
step / clear; speed slider; preset patterns menu (glider, blinker,
LWSS, R-pentomino, Gosper glider gun). Generations counted in a
`Chip` above the grid.

**Exercises:** `Timer.periodic`, `CustomPainter` for fast
rendering, `GestureDetector.onPanUpdate` for paint-cells-by-dragging,
preset menu via `PopupMenuButton`, `Slider` for tick rate.

**Files:** `main.dart`, `home.dart`, `board.dart` (state +
neighbours), `patterns.dart`, `grid_painter.dart`, `control_bar.dart`.

---

### 9. [ ] `bouncing_balls_physics` — multi-ball elastic collisions

N coloured balls bounce inside a `RenderBox`. Position updated each
animation tick via gravity + velocity. Sliders adjust ball count,
gravity strength, elasticity. Click to add a ball at the cursor.

**Exercises:** `AnimationController` driving the sim, `Ticker`-style
update loop, `CustomPainter` for the balls, `Slider` callbacks,
`GestureDetector.onTapDown` to spawn balls.

**Files:** `main.dart`, `home.dart`, `world.dart` (ball list + step),
`ball_painter.dart`, `physics_controls.dart`.

---

### 10. [ ] `particle_field` — interactive particle attractor

A swarm of particles drifting on a `CustomPainter`. Cursor / finger
position acts as an attractor; toggle between attract / repel / orbit
modes. Trails fade via paint with semi-transparent overlay.

**Exercises:** `Ticker` raw (not via AnimationController) for the
sim, `CustomPainter`, `MouseRegion` for cursor tracking,
`GestureDetector` for touch, mode toggles via `SegmentedButton`.

**Files:** `main.dart`, `home.dart`, `field.dart`,
`particle_painter.dart`, `mode_selector.dart`.

---

### 11. [ ] `color_picker_studio` — HSV / RGB / HEX picker

Three coordinated panels: HSV sliders, RGB sliders, hex input.
Editing one updates the others. Live preview square, plus a swatch
strip of recent colours.

**Exercises:** `ValueNotifier<Color>` shared across panels,
`ValueListenableBuilder`, `Slider`/`TextField` two-way binding,
input parsing + clamping, copy-to-clipboard via `Clipboard.setData`
(if bridged; otherwise omit). Pure layout exercise.

**Files:** `main.dart`, `home.dart`, `color_model.dart`,
`hsv_panel.dart`, `rgb_panel.dart`, `hex_field.dart`,
`swatch_strip.dart`.

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
