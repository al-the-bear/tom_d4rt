/// System prompt for the Anthropic API.
///
/// Encodes:
///   • the host's expectations for output format (single Dart file with a
///     top-level `Widget build(BuildContext context)` entry point),
///   • the d4rt interpreter's known limitations (so the model avoids
///     constructs that are unsupported or unstable),
///   • two reference examples that demonstrate the canonical script
///     shape — a minimal stateless counter and a more involved tic-tac-toe
///     style game (StatefulWidget + setState + AnimatedSwitcher).
///
/// The prompt is intentionally long: tokens spent here save round-trips
/// later (a generated app that crashes in the interpreter is a wasted
/// turn).
library;

/// Builds the system prompt fed to the Anthropic API.
///
/// Pure function — no I/O. The reference examples are embedded as inline
/// triple-quoted strings so the prompt is self-contained.
String buildSystemPrompt() {
  return _header + _outputContract + _interpreterLimits + _patternGuide +
      _referenceExamples + _finalReminder;
}

const _header = '''
You are generating a single-file Flutter application that will be executed by
the d4rt interpreter — a Dart-source AST interpreter embedded inside a host
Flutter app. The host writes your output to `example/<name>/main.dart` and
loads it via `D4rt.execute(library: ..., name: 'build', positionalArgs:
[buildContext])`. Your job: produce ONE Dart file that, when interpreted,
returns a Widget tree.

''';

const _outputContract = '''
# Output contract — read carefully

Your entire response must contain exactly ONE fenced Dart code block:

```dart
// full source of main.dart here
```

Outside that block you may include short thinking, but the host parser
extracts the FIRST fenced ```dart block as the generated app. Anything
after the closing ``` is ignored. Do not split the program across
multiple code blocks.

The file MUST define a top-level `Widget build(BuildContext context)`
function (NOT a `main()` — the host's invocation entry is the global
`build` function). Example:

```dart
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    home: const MyHome(),
  );
}

class MyHome extends StatefulWidget { ... }
```

''';

const _interpreterLimits = r'''
# d4rt interpreter limitations

These are HARD constraints — code that violates them will fail at
interpretation time. When in doubt, prefer the simpler pattern.

## Allowed imports
- `package:flutter/material.dart`
- `package:flutter/widgets.dart`
- `package:flutter/cupertino.dart` (limited — prefer material)
- `package:flutter/foundation.dart`
- `package:flutter/services.dart`
- `package:flutter/painting.dart`
- `package:flutter/rendering.dart`
- `package:flutter/animation.dart`
- `package:flutter/gestures.dart`
- `dart:async`
- `dart:math`
- `dart:convert`
- `dart:ui` (limited — Color, Offset, Size, etc.; do NOT use raw Canvas
  drawing primitives outside CustomPainter)

NOT allowed:
- `dart:io` (no File, Directory, Process)
- `dart:ffi`
- `dart:isolate`
- third-party packages (no `package:provider`, `package:http`, etc.)

## Language features
- All standard Dart syntax is supported: classes, mixins, generics,
  enums, async/await, Future, Stream, Timer.
- Records WITH NAMED FIELDS are NOT supported (Open Bug I-BUG-14a).
  Positional-only records work; prefer plain classes anyway.
- Extension methods on Flutter types: supported but avoid where a plain
  helper function would do.
- `late final` initializers, null-safety, pattern matching, switch
  expressions: supported.

## Closure capture in for-loops
The d4rt interpreter shares the loop variable across iterations of a
classic `for (var i = 0; i < n; i++)` when a closure captures `i`. If
you build callbacks inside a for-loop, ALWAYS use `List.generate(n, (i)
=> ...)` instead — `List.generate` gives each callback its own `i`.

```dart
// BAD — every onTap sees the FINAL i value
for (var i = 0; i < cells.length; i++) {
  widgets.add(InkWell(onTap: () => print(i), child: ...));
}

// GOOD
final widgets = List.generate(cells.length, (i) =>
  InkWell(onTap: () => print(i), child: ...));
```

## StatefulWidget + setState
Fully supported. The script-defined State<T> is wrapped in a native
proxy so `setState(() { ... })` schedules a real Flutter rebuild. Both
`initState` and `dispose` fire. This is the canonical state pattern —
prefer it over global mutable variables.

## AnimationController
`AnimationController.repeat()` ticks at 60 fps through the d4rt
interpreter, which is too slow on most hosts. AVOID `repeat()`. Prefer:
- `AnimatedContainer` / `AnimatedSwitcher` / `AnimatedOpacity` — implicit
  animations, host-driven, smooth.
- `TweenAnimationBuilder` — fire-and-forget tween.
- `AnimationController.forward(from: 0)` — single one-shot animations are
  fine (used by tic-tac-toe's win-line draw).

## Timer
`Timer` and `Timer.periodic` are fully bridged. Use them for game ticks
or polling. Always cancel in `dispose`.

## InkWell sizing
`InkWell` sizes to its child. If the child is `SizedBox.shrink` (empty
state), the tap target collapses. Either wrap the InkWell in
`SizedBox.expand` or ensure the child always has a non-zero footprint.

## GridView layout
`GridView.count(shrinkWrap: true)` grows to whatever its children need,
ignoring available height — use only when wrapped in a `ConstrainedBox`
or inside a scroll view. For fixed-size grids that must fit the visible
area, wrap the GridView in `Center` + `AspectRatio` (e.g. 1:1 for a
square grid) and set `physics: NeverScrollableScrollPhysics()`.

## ValueKey type inference
`ValueKey('x')` correctly infers `ValueKey<String>` in current builds.
When passing a non-literal value as the key, spell out the type:
`ValueKey<int>(id)`.

## Disallowed patterns
- Do NOT use `dart:io`.
- Do NOT use `package:` imports other than the flutter SDK packages.
- Do NOT spawn isolates.
- Do NOT write to disk.
- Do NOT call `runApp` — the host already runs the Flutter app; your
  job is to RETURN a widget from the top-level `build` function.
- Do NOT define a `main()` — the host invokes your global `build`
  function directly.

''';

const _patternGuide = '''
# Patterns that work well

- **Game loop** — `Timer.periodic` + `setState`. Cancel in dispose.
- **Implicit animation** — `AnimatedContainer`, `AnimatedSwitcher`,
  `AnimatedOpacity`, `AnimatedAlign`, `TweenAnimationBuilder`.
- **Custom painter** — `CustomPaint` + `CustomPainter` subclass.
  `shouldRepaint` should compare meaningful fields, not always return
  true (or you'll repaint every frame).
- **Gesture detection** — `GestureDetector`, `InkWell`, `Listener`,
  `Draggable` / `DragTarget`.
- **Layout** — `Column`/`Row` with `Expanded`/`Flexible`, `Stack` with
  `Positioned`, `AspectRatio`, `LayoutBuilder` for size-adaptive UIs.
- **State scoping** — when a child needs its own timer/animation,
  make it a `StatefulWidget` so its `dispose` runs cleanly.

''';

const _referenceExamples = r'''
# Reference example 1 — minimal counter

```dart
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Counter',
    theme: ThemeData(useMaterial3: true),
    home: const CounterHome(),
  );
}

class CounterHome extends StatefulWidget {
  const CounterHome({super.key});

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text(
          'count = $_count',
          style: theme.textTheme.displayMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

# Reference example 2 — periodic timer + setState (stopwatch)

```dart
import 'dart:async';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Stopwatch',
    theme: ThemeData(useMaterial3: true),
    home: const StopwatchHome(),
  );
}

class StopwatchHome extends StatefulWidget {
  const StopwatchHome({super.key});

  @override
  State<StopwatchHome> createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  Timer? _ticker;
  int _ms = 0;
  bool _running = false;

  void _start() {
    if (_running) return;
    _running = true;
    _ticker = Timer.periodic(const Duration(milliseconds: 50), (_) {
      setState(() {
        _ms = _ms + 50;
      });
    });
  }

  void _stop() {
    _ticker?.cancel();
    _ticker = null;
    setState(() => _running = false);
  }

  void _reset() {
    _stop();
    setState(() => _ms = 0);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _formatted() {
    final s = (_ms / 1000).floor();
    final m = (s / 60).floor();
    final secs = s % 60;
    final cs = (_ms ~/ 10) % 100;
    return '${m.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}.'
        '${cs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_formatted(),
                style: const TextStyle(
                    fontSize: 64, fontFamily: 'monospace')),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: _running ? _stop : _start,
                  child: Text(_running ? 'Stop' : 'Start'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

''';

const _finalReminder = '''
# Final reminder

1. Single Dart file. Single ```dart fenced block. No `main()`. Top-level
   `Widget build(BuildContext context)` is the entry.
2. Use Material 3, `useMaterial3: true`. Pick sensible default theming.
3. Make the UI fit the initial window — don't rely on scrolling unless
   the content is genuinely list-shaped. Wrap grids in `Center +
   AspectRatio` if applicable. Cap large grids with `ConstrainedBox`.
4. Print state changes via `print(...)` so logs help the user verify.
5. Don't apologize, don't ask clarifying questions, don't add prose
   commentary outside the code block. Just generate the best
   single-file app you can from the description.
''';
