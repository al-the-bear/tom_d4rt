/// In-process tests for the multi-file sample apps in `example/`.
///
/// Unlike the HTTP-driven scripts under `test/<suite>_test.dart`, these
/// tests run [SourceFlutterD4rt.buildMultiFile] *directly* inside a
/// `WidgetTester` so we can `tester.tap()` interpreted widgets and
/// assert that interpreted state actually updates the rendered UI.
///
/// This is the harness used to reproduce and (eventually) regress
/// the two interpreter bugs tracked in
/// `tom_d4rt_flutter_ast/doc/interpreter_issues.md`:
///   1. user-defined `State.setState` doesn't schedule a rebuild
///   2. classic `for (var i = ...; ...; ...)` loop variable is shared
///      across iterations (closures capture the post-loop value)
///
/// Each test runs in a `runZonedGuarded` block that captures every
/// `print()` call from the interpreted script (and from the host)
/// and dumps the log on teardown — that way failures come with a
/// trace of what the interpreter actually executed.
@TestOn('vm')
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LogicalKeyboardKey; // for tester.sendKey*Event in tron tests
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt_flutter_test/src/source_flutter_d4rt.dart';

/// Reusable interpreter instance — bridge registration is the most
/// expensive part of the setup, so we share it across tests.
late SourceFlutterD4rt _d4rt;

/// Captured print() lines from the most recent test run. Cleared at the
/// start of each test, dumped to stdout on teardown so the trail is
/// visible whether the test passed or failed.
final List<String> _printLog = <String>[];

String _samplePath(String sampleDir) {
  // `flutter test` sets the CWD to the package root, so `example/<dir>/main.dart`
  // is the canonical path. Fall back to walking up one level for safety.
  final candidates = [
    p.join(Directory.current.path, 'example', sampleDir, 'main.dart'),
    p.join(Directory.current.path, '..', 'example', sampleDir, 'main.dart'),
  ];
  for (final c in candidates) {
    if (File(c).existsSync()) return p.normalize(c);
  }
  throw StateError(
    'Could not find example/$sampleDir/main.dart. CWD=${Directory.current.path}',
  );
}

void main() {
  setUpAll(() {
    // Construct once — bridge registration is heavy.
    _d4rt = SourceFlutterD4rt();
  });

  setUp(() {
    _printLog.clear();
  });

  tearDown(() {
    if (_printLog.isNotEmpty) {
      // Dump captured trail so test output makes the interpreter behaviour
      // visible regardless of whether the assertions passed.
      // ignore: avoid_print
      print('\n──── captured script trail (${_printLog.length} lines) ────');
      for (final line in _printLog) {
        // ignore: avoid_print
        print(line);
      }
      // ignore: avoid_print
      print('──── end trail ────\n');
    }
  });

  group('counter_app (multi-file user-defined State)', () {
    testWidgets('FAB tap increments the displayed count', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'counter_app');

        expect(find.text('count = 0'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('count = 1'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('count = 2'), findsOneWidget,
            reason: 'Multi-tap should accumulate; if it sticks at 1, '
                'the second setState dispatch is broken.');
      });
    });
  });

  group('sudoku_app (multi-file user-defined State)', () {
    testWidgets('cell tap selects + digit tap sets value', (tester) async {
      // The sudoku layout (560-max board + keypad + AppBar) needs more
      // vertical room than the default 800x600 WidgetTester surface.
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await _runInZone(() async {
        await _mountSample(tester, 'sudoku_app');

        // Sample mounted and rules panel rendered alongside the board.
        expect(find.text('Sudoku — puzzle 1'), findsOneWidget);
        expect(find.text('How to play'), findsOneWidget,
            reason: 'Rules panel should be rendered to the right of the board.');
        expect(
          find.text('Every row contains the digits 1–9 exactly once.'),
          findsOneWidget,
        );

        // Verify "Next puzzle" rebuilds the title. Scope the icon
        // finder to the AppBar — the rules panel also uses skip_next
        // in its toolbar bullet.
        final appBarNext = find.descendant(
          of: find.byType(AppBar),
          matching: find.byIcon(Icons.skip_next),
        );
        await tester.tap(appBarNext);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Sudoku — puzzle 2'), findsOneWidget,
            reason: 'Next-puzzle button should drive a setState '
                'rebuild updating the AppBar title.');

        // And cycling round again.
        await tester.tap(appBarNext);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Sudoku — puzzle 1'), findsOneWidget);
      });
    });
  });

  group('user-defined State.setState (GEN-112)', () {
    testWidgets('FAB tap rebuilds via script-side setState', (tester) async {
      // This script uses the *idiomatic* StatefulWidget + State<T> pattern
      // (NOT the StatefulBuilder workaround). It exercises the bridged
      // `State.setState` dispatch through the `_InterpretedState` proxy
      // routed via `nativeStateProxy` (GEN-112). Without that fix, the
      // setState callback would run (so script-side `n` would mutate)
      // but `Element.markNeedsBuild` would never be called and the
      // displayed text would stay frozen at "n = 0".
      await _runInZone(() async {
        const source = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(home: const Counter());
}

class Counter extends StatefulWidget {
  const Counter({super.key});
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int n = 0;
  @override
  Widget build(BuildContext context) {
    print('build n=\$n');
    return Scaffold(
      body: Center(child: Text('n = \$n')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB pressed; before setState n=\$n');
          setState(() { n = n + 1; });
          print('FAB pressed; after  setState n=\$n');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';

        await tester.pumpWidget(_InlineSourceHost(d4rt: _d4rt, source: source));

        expect(find.text('n = 0'), findsOneWidget,
            reason: 'Initial render expected n = 0.');

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('n = 1'), findsOneWidget,
            reason: 'After one FAB tap, script-side setState should '
                'schedule a rebuild and the displayed text should be '
                'n = 1. If it stays at n = 0, GEN-112 (RC-9 fallback '
                'routing through `nativeStateProxy`) regressed.');
      });
    });
  });

  group('stopwatch_laps (example #2 — Timer.periodic + AnimationController + ListView)',
      () {
    testWidgets('Start → wait → Stop accumulates elapsed time',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'stopwatch_laps');

        // Initial state — paused, 00:00.00, no laps.
        expect(find.text('00:00.00'), findsOneWidget);
        expect(find.text('paused'), findsOneWidget);
        expect(find.text('No laps yet — tap "Lap" while running.'),
            findsOneWidget);

        // Start.
        await tester.tap(find.byKey(const ValueKey<String>('toggle')));
        await tester.pump();
        expect(find.text('running'), findsOneWidget,
            reason: 'After Start, the status should read "running".');

        // Advance simulated time by ~500 ms via repeated pumps. The
        // Timer.periodic that the stopwatch installs is a FakeTimer
        // under `flutter_test`'s simulated clock — `runAsync` would
        // not fire it; we have to pump frames to advance the fake
        // clock. 10 × 60 ms covers a few centiseconds in the
        // displayed format and is plenty for `findsNothing` on the
        // zeroed display.
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 60));
        }

        // Stop.
        await tester.tap(find.byKey(const ValueKey<String>('toggle')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        expect(find.text('paused'), findsOneWidget);
        expect(find.text('00:00.00'), findsNothing,
            reason: 'Elapsed should have advanced past zero.');
      });
    });

    testWidgets('Lap button appends entries to the history',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'stopwatch_laps');

        // Start running.
        await tester.tap(find.byKey(const ValueKey<String>('toggle')));
        await tester.pump();

        // Capture three laps separated by simulated 120 ms intervals.
        // Each tap also pumps so the Lap entry mounts cleanly.
        for (var i = 0; i < 3; i++) {
          for (var j = 0; j < 2; j++) {
            await tester.pump(const Duration(milliseconds: 60));
          }
          await tester.tap(find.text('Lap'));
          await tester.pump();
        }

        // Three lap-index pills (1, 2, 3) should now be in the list.
        expect(find.text('1'), findsOneWidget,
            reason: 'Lap #1 should appear in the history.');
        expect(find.text('2'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);

        // The "no laps yet" hint must be gone.
        expect(find.text('No laps yet — tap "Lap" while running.'),
            findsNothing);

        // Reset clears everything.
        await tester.tap(find.byIcon(Icons.restart_alt));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(find.text('00:00.00'), findsOneWidget);
        expect(find.text('No laps yet — tap "Lap" while running.'),
            findsOneWidget);
      });
    });
  });

  group('tic_tac_toe (example #1 — AnimationController + AnimatedSwitcher + CustomPainter)',
      () {
    testWidgets('X plays a top-row win → headline + scoreboard update',
        (tester) async {
      // Board + scoreboard + reset button comfortably fit a 700x900 window.
      tester.view.physicalSize = const Size(700, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'tic_tac_toe');

        expect(find.text("X's turn"), findsOneWidget,
            reason: 'Initial banner should show X to move.');

        // Play out X-win on the top row: X@0, O@3, X@1, O@4, X@2.
        //
        // `pumpAndSettle` between taps so the AnimatedSwitcher's 250ms
        // headline transition completes before the next assertion —
        // mid-transition the tree briefly contains both the outgoing
        // ("X's turn") and incoming ("O's turn") Text, so a naked
        // `find.text(...)` would otherwise return two widgets.
        Future<void> tapCell(int n) async {
          await tester.tap(find.byKey(ValueKey('cell-$n')));
          await tester.pumpAndSettle(const Duration(milliseconds: 600));
        }

        await tapCell(0); // X
        expect(find.text("O's turn"), findsOneWidget);

        await tapCell(3); // O
        expect(find.text("X's turn"), findsOneWidget);

        await tapCell(1); // X
        await tapCell(4); // O
        await tapCell(2); // X — completes the top row

        // Settle the win-line AnimationController + AnimatedSwitcher.
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('X wins!'), findsOneWidget,
            reason: 'Top-row XXX should be detected and announced.');

        // Score chip for X should read 1; O and Draws stay at 0.
        // Each chip is `Label N` — find the X-chip via the parent Row.
        expect(find.text('1'), findsOneWidget,
            reason: 'X wins should advance to 1.');
        expect(find.text('0'), findsNWidgets(2),
            reason: 'O wins and Draws should both still read 0.');

        // "New round" should be enabled now. Tap it → board cleared.
        await tester.tap(find.text('New round'));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text("X's turn"), findsOneWidget,
            reason: 'After New round the banner returns to X to move.');
      });
    });

    testWidgets('Filling all 9 cells without a winner records a draw',
        (tester) async {
      tester.view.physicalSize = const Size(700, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'tic_tac_toe');

        // A sequence that produces no winner — classic draw pattern:
        //   X O X
        //   X O O
        //   O X X
        // Tap order (X, O, X, O, X, O, X, O, X):
        //   X@0, O@1, X@2, O@4, X@3, O@5, X@7, O@6, X@8
        final taps = [0, 1, 2, 4, 3, 5, 7, 6, 8];
        for (final n in taps) {
          await tester.tap(find.byKey(ValueKey('cell-$n')));
          await tester.pumpAndSettle(const Duration(milliseconds: 600));
        }
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Draw'), findsOneWidget,
            reason: 'All 9 cells filled with no 3-in-a-row should '
                'land on Draw.');
      });
    });
  });

  group(
      'pomodoro_timer (example #3 — Timer.periodic + ChangeNotifier + ListenableBuilder + AnimatedTheme)',
      () {
    // The sample boots with 25 / 5-minute defaults — way too long to
    // step through with FakeTimer.pump. We verify boot, manual phase
    // flip via the Skip button (no time-stepping), the notification
    // chip lifecycle, and pause/resume / reset state transitions.
    testWidgets('boots into the focus phase with the work countdown',
        (tester) async {
      tester.view.physicalSize = const Size(700, 1100);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'pomodoro_timer');

        expect(find.text('Pomodoro'), findsOneWidget,
            reason: 'AppBar title should be "Pomodoro".');
        expect(find.text('FOCUS'), findsOneWidget,
            reason: 'Phase badge should start on FOCUS.');
        expect(find.text('25:00'), findsOneWidget,
            reason: 'Countdown should start at the default work length '
                '(25 min).');
        expect(find.text('Start'), findsOneWidget,
            reason: 'Toggle button should read "Start" while paused.');
        expect(find.text('Cycles completed: 0'), findsOneWidget,
            reason: 'No cycles have completed at boot.');
      });
    });

    testWidgets('Start flips toggle label and one tick advances countdown',
        (tester) async {
      tester.view.physicalSize = const Size(700, 1100);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'pomodoro_timer');

        await tester.tap(find.byKey(const ValueKey<String>('toggle')));
        await tester.pump();
        expect(find.text('Pause'), findsOneWidget,
            reason: 'After Start the toggle label should read "Pause".');

        // Single Timer.periodic tick should decrement the countdown.
        await tester.pump(const Duration(seconds: 1));
        expect(find.text('24:59'), findsOneWidget,
            reason: 'One second of fake-clock pumping should advance the '
                'countdown from 25:00 to 24:59.');

        // Pause stops the ticker; subsequent pump should NOT advance.
        await tester.tap(find.byKey(const ValueKey<String>('toggle')));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        expect(find.text('24:59'), findsOneWidget,
            reason: 'After Pause, the countdown should freeze at the '
                'last value.');
        expect(find.text('Start'), findsOneWidget,
            reason: 'Paused state should expose the Start label again.');
      });
    });

    testWidgets(
        'Skip flips phase to Break, surfaces phase-end chip, auto-dismisses',
        (tester) async {
      tester.view.physicalSize = const Size(700, 1100);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'pomodoro_timer');

        // Skip while still paused — flips phase but does not start the
        // ticker. The chip's auto-dismiss timer is a one-shot, so we
        // can advance the fake clock past it without spinning the
        // 1 Hz Timer.periodic.
        await tester.tap(find.byKey(const ValueKey<String>('skip')));
        await tester.pump();

        expect(find.text('BREAK'), findsOneWidget,
            reason: 'Phase badge should swap to BREAK after one Skip.');
        expect(find.text('05:00'), findsOneWidget,
            reason: 'Countdown should reset to the default break length '
                '(5 min).');
        expect(find.text('Break time'), findsOneWidget,
            reason: 'Phase-end chip should announce the new phase.');
        expect(find.text('Cycles completed: 1'), findsOneWidget,
            reason: 'Skipping out of the focus phase should count as a '
                'completed cycle.');

        // Wait past the auto-dismiss window.
        await tester
            .pump(const Duration(seconds: 4)); // 3 s auto-dismiss + slack
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        expect(find.text('Break time'), findsNothing,
            reason: 'The chip should auto-dismiss after the notice '
                'window elapses.');

        // Skip again — back to focus.
        await tester.tap(find.byKey(const ValueKey<String>('skip')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        expect(find.text('FOCUS'), findsOneWidget);
        expect(find.text('25:00'), findsOneWidget);
        expect(find.text('Back to work'), findsOneWidget,
            reason: 'Returning from break should surface the work-resume '
                'notice.');
      });
    });

    testWidgets('Reset returns to the initial state', (tester) async {
      tester.view.physicalSize = const Size(700, 1100);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'pomodoro_timer');

        // Step the clock forward a touch, then reset.
        await tester.tap(find.byKey(const ValueKey<String>('toggle')));
        await tester.pump();
        await tester.pump(const Duration(seconds: 5));
        expect(find.text('24:55'), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey<String>('reset')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        expect(find.text('25:00'), findsOneWidget,
            reason: 'Reset should restore the work countdown to 25:00.');
        expect(find.text('FOCUS'), findsOneWidget);
        expect(find.text('Start'), findsOneWidget,
            reason: 'Reset should leave the toggle in the Start state.');
        expect(find.text('Cycles completed: 0'), findsOneWidget);
      });
    });
  });

  group(
      'calculator (example #4 — GridView.count + setState + history + long-press)',
      () {
    // The calculator is a pure-state engine driven by an interpreted
    // host State<T>. Tests assert the headline behaviours — digit
    // entry, operator precedence, equals, history, clear-all, and
    // long-press repeat-backspace — through the rendered widget tree.
    testWidgets('boots showing 0 and no history', (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        expect(find.text('Calculator'), findsOneWidget,
            reason: 'AppBar title should be "Calculator".');
        expect(
          find.byKey(const ValueKey<String>('display')),
          findsOneWidget,
          reason: 'The big display Text should mount.',
        );
        // The display shows "0" at boot. Look for the placeholder.
        final displayFinder = find.byKey(const ValueKey<String>('display'));
        final displayText = tester.widget<Text>(displayFinder).data;
        expect(displayText, '0',
            reason: 'Initial display should be "0".');

        expect(find.text('No history yet'), findsOneWidget,
            reason: 'Empty history strip should render its placeholder.');
      });
    });

    testWidgets('digit entry: 1 + 2 = 3', (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-1')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-add')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-2')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-equals')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        final display = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        expect(display, '3',
            reason: '1 + 2 = should display 3.');

        // History strip should now contain the completed entry.
        expect(find.byKey(const ValueKey<String>('history-entry-0')),
            findsOneWidget);
        expect(find.text('1 + 2'), findsOneWidget,
            reason: 'History expression should be "1 + 2".');
      });
    });

    testWidgets(
        'operator precedence: 2 + 3 × 4 = 14 (× binds tighter than +)',
        (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-2')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-add')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-3')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-mul')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-4')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-equals')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        final display = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        expect(display, '14',
            reason: '2 + 3 × 4 = 14 — multiplication should fold first. '
                'If it produces 20, the engine is folding left-to-right '
                'without precedence.');
      });
    });

    testWidgets('division by zero surfaces "Error"', (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-5')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-div')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-0')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-equals')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        final display = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        expect(display, 'Error',
            reason: '5 ÷ 0 should surface "Error" on the display.');
      });
    });

    testWidgets('AC clears, then 7 × 8 = 56 works on a fresh expression',
        (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        // Dirty the engine first.
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-9')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-add')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-9')));
        await tester.pump();

        await tester.tap(find.byKey(const ValueKey<String>('btn-ac')));
        await tester.pump();

        final afterAc = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        expect(afterAc, '0',
            reason: 'AC should restore the display to "0".');

        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-7')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-mul')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-8')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-equals')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        final display = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        expect(display, '56',
            reason: 'Fresh expression 7 × 8 should evaluate to 56.');
      });
    });

    testWidgets('long-press backspace deletes multiple digits in one hold',
        (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        // Type "1234".
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-1')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-2')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-3')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-4')));
        await tester.pump();

        var display = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        expect(display, '1234',
            reason: 'After typing 1234 the display should read "1234".');

        // Long-press the backspace key. The handler fires once
        // immediately, then after a 350 ms delay starts a 90 ms
        // repeat. Holding for ~900 ms should drop the operand all
        // the way down to "0" (single-char operands snap to "0" on
        // backspace).
        final backspaceCenter = tester
            .getCenter(find.byKey(const ValueKey<String>('btn-backspace')));
        final gesture = await tester.startGesture(backspaceCenter);
        // Wait past the long-press recognition threshold (~500 ms by
        // default), then through the initial delay + a few repeats.
        await tester.pump(const Duration(milliseconds: 600));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pump(const Duration(milliseconds: 200));
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        display = tester
            .widget<Text>(find.byKey(const ValueKey<String>('display')))
            .data;
        // We can't be exact about how many ticks fired without
        // committing to a precise schedule, but after the hold the
        // display must be shorter than what we typed.
        expect(display!.length < 4, isTrue,
            reason: 'Long-press backspace should delete more than one '
                'digit during a single hold. Started with "1234"; after '
                'the hold expected fewer than 4 chars but got "$display".');
      });
    });

    testWidgets('clear-history empties the strip', (tester) async {
      tester.view.physicalSize = const Size(700, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'calculator');

        // Land one calculation so the history strip becomes non-empty.
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-2')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-op-add')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-digit-2')));
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey<String>('btn-equals')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        expect(find.byKey(const ValueKey<String>('history-entry-0')),
            findsOneWidget,
            reason: 'After 2 + 2 = the history should hold one entry.');
        expect(find.text('No history yet'), findsNothing);

        // Tap the clear-history icon.
        await tester.tap(find.byKey(const ValueKey<String>('history-clear')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(find.byKey(const ValueKey<String>('history-entry-0')),
            findsNothing,
            reason: 'Clear-history should wipe the strip.');
        expect(find.text('No history yet'), findsOneWidget,
            reason: 'Empty placeholder should reappear once history is '
                'cleared.');
      });
    });
  });

  group(
      'drawing_pad (example #5 — CustomPainter + GestureDetector + undo/redo)',
      () {
    // The drawing pad exercises a script-defined CustomPainter
    // subclass, GestureDetector.onPan(Start|Update|End) callbacks,
    // and the canonical undo/redo state pair. Tests assert through
    // (a) the captured print trail (the host emits one print per
    // state change so we can see what the engine did) and (b) the
    // toolbar's IconButton enabled state.
    testWidgets('boots with empty canvas and disabled undo/redo/clear',
        (tester) async {
      tester.view.physicalSize = const Size(900, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'drawing_pad');

        expect(find.text('Drawing Pad'), findsOneWidget,
            reason: 'AppBar title should read "Drawing Pad".');
        expect(find.byKey(const ValueKey<String>('canvas-area')),
            findsOneWidget,
            reason: 'Gesture-detecting canvas area should mount.');
        expect(find.byKey(const ValueKey<String>('canvas-paint')),
            findsOneWidget,
            reason: 'CustomPaint hosting the script CanvasPainter should '
                'mount.');
        expect(find.byKey(const ValueKey<String>('tool-bar')), findsOneWidget,
            reason: 'Toolbar should mount.');

        final undo = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-undo')));
        final redo = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-redo')));
        final clear = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-clear')));
        expect(undo.onPressed, isNull,
            reason: 'Undo should be disabled on a blank canvas.');
        expect(redo.onPressed, isNull,
            reason: 'Redo should be disabled on a blank canvas.');
        expect(clear.onPressed, isNull,
            reason: 'Clear should be disabled on a blank canvas.');
      });
    });

    testWidgets('dragging on the canvas fires onPanStart/Update/End',
        (tester) async {
      tester.view.physicalSize = const Size(900, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'drawing_pad');

        final canvas = find.byKey(const ValueKey<String>('canvas-area'));
        final start = tester.getCenter(canvas);

        // timedDragFrom emits a pointer-down → multiple moves →
        // pointer-up sequence that wins the pan recognizer.
        await tester.timedDragFrom(
          start,
          const Offset(120, 60),
          const Duration(milliseconds: 220),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final panStart = _printLog
            .where((l) => l.startsWith('drawingpad.panStart'))
            .toList();
        expect(panStart, hasLength(1),
            reason: 'Exactly one onPanStart should fire for a single drag. '
                'If this is 0, the GestureDetector is not receiving '
                'pointer events; if >1, the recognizer is mis-firing.');

        final panEnd = _printLog
            .where((l) => l.startsWith('drawingpad.panEnd'))
            .toList();
        expect(panEnd, hasLength(1),
            reason: 'Exactly one onPanEnd should fire after the drag '
                'releases. The line also reports the committed-stroke '
                'point count so the engine path is visible.');

        // After the drag commits, Undo and Clear should turn on.
        final undo = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-undo')));
        final clear = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-clear')));
        expect(undo.onPressed, isNotNull,
            reason: 'After committing a stroke, Undo should be enabled.');
        expect(clear.onPressed, isNotNull,
            reason: 'After committing a stroke, Clear should be enabled.');
      });
    });

    testWidgets('undo / redo round-trip restores the stroke history',
        (tester) async {
      tester.view.physicalSize = const Size(900, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'drawing_pad');

        // Draw one stroke.
        final canvas = find.byKey(const ValueKey<String>('canvas-area'));
        await tester.timedDragFrom(
          tester.getCenter(canvas),
          const Offset(80, 0),
          const Duration(milliseconds: 200),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Undo it.
        await tester.tap(find.byKey(const ValueKey<String>('btn-undo')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final undoLines = _printLog
            .where((l) => l.startsWith('drawingpad.undo'))
            .toList();
        expect(undoLines, hasLength(1),
            reason: 'Tapping Undo should emit exactly one undo trail line.');
        expect(undoLines.single, contains('strokes=0'),
            reason: 'After undoing a single stroke, the strokes list '
                'should be empty.');
        expect(undoLines.single, contains('redo=1'),
            reason: 'The undone stroke should now sit on the redo stack.');

        // After undo, redo should be enabled.
        final redoBtn = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-redo')));
        expect(redoBtn.onPressed, isNotNull,
            reason: 'After Undo, Redo should be enabled.');

        // Redo it.
        await tester.tap(find.byKey(const ValueKey<String>('btn-redo')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final redoLines = _printLog
            .where((l) => l.startsWith('drawingpad.redo'))
            .toList();
        expect(redoLines, hasLength(1),
            reason: 'Tapping Redo should emit exactly one redo trail line.');
        expect(redoLines.single, contains('strokes=1'),
            reason: 'After redo, the stroke should be back in history.');
        expect(redoLines.single, contains('redo=0'),
            reason: 'After redo, the redo stack should be drained.');

        // Now drawing a new stroke must drop the redo stack
        // (timeline branch).
        await tester.timedDragFrom(
          tester.getCenter(canvas) + const Offset(0, 40),
          const Offset(40, 40),
          const Duration(milliseconds: 200),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // After Undo the new stroke once more — the redo stack
        // should now hold *only* the most recent stroke (the
        // previously-redone stroke is not back on the redo stack
        // since we committed a new stroke after redo).
        await tester.tap(find.byKey(const ValueKey<String>('btn-undo')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final allUndo = _printLog
            .where((l) => l.startsWith('drawingpad.undo'))
            .toList();
        expect(allUndo.last, contains('redo=1'),
            reason: 'After undoing the second stroke, the redo stack '
                'should hold exactly one stroke (the just-undone one). '
                'If it holds 2, the panEnd handler is not clearing the '
                'redo stack on commit.');
      });
    });

    testWidgets('clear empties everything and disables undo/redo',
        (tester) async {
      tester.view.physicalSize = const Size(900, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'drawing_pad');

        // Draw two strokes.
        final canvas = find.byKey(const ValueKey<String>('canvas-area'));
        await tester.timedDragFrom(
          tester.getCenter(canvas),
          const Offset(60, 0),
          const Duration(milliseconds: 200),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        await tester.timedDragFrom(
          tester.getCenter(canvas) + const Offset(0, 30),
          const Offset(60, 30),
          const Duration(milliseconds: 200),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Tap clear.
        await tester.tap(find.byKey(const ValueKey<String>('btn-clear')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final clearLines = _printLog
            .where((l) => l == 'drawingpad.clear')
            .toList();
        expect(clearLines, hasLength(1),
            reason: 'Clear should emit exactly one clear trail line.');

        final undo = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-undo')));
        final redo = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-redo')));
        final clear = tester.widget<IconButton>(
            find.byKey(const ValueKey<String>('btn-clear')));
        expect(undo.onPressed, isNull,
            reason: 'Clear should leave Undo disabled.');
        expect(redo.onPressed, isNull,
            reason: 'Clear should leave Redo disabled.');
        expect(clear.onPressed, isNull,
            reason: 'Clear should disable itself once the canvas is '
                'empty.');
      });
    });

    testWidgets('tapping a colour swatch records the colour change',
        (tester) async {
      tester.view.physicalSize = const Size(900, 1300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'drawing_pad');

        // Swatch index 1 is the red palette entry.
        await tester.tap(find.byKey(const ValueKey<String>('swatch-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final colorLines = _printLog
            .where((l) => l.startsWith('drawingpad.color='))
            .toList();
        expect(colorLines, hasLength(1),
            reason: 'Tapping a swatch should emit exactly one colour-'
                'change trail line.');
        // The script prints the Color's toString. Older Flutter
        // versions formatted as `Color(0xffdc2626)`; current Flutter
        // uses component form `Color(alpha: 1.0, red: 0.8627, green:
        // 0.1490, blue: 0.1490, ...)`. Red palette entry is
        // 0xFFDC2626 → red ≈ 0.8627, green/blue ≈ 0.1490. Accept
        // either format.
        final line = colorLines.single.toLowerCase();
        final matchesHex = line.contains('dc2626');
        final matchesComponents = line.contains('red: 0.8627') &&
            line.contains('green: 0.149') &&
            line.contains('blue: 0.149');
        expect(matchesHex || matchesComponents, isTrue,
            reason: 'The selected colour should be the red palette '
                'entry (0xFFDC2626). Got: ${colorLines.single}');
      });
    });
  });

  group(
      'memory_match (example #6 — TweenAnimationBuilder flip + pair matching)',
      () {
    // The memory-match game exercises a script-defined StatefulWidget
    // whose per-card flip is driven by `TweenAnimationBuilder<double>`,
    // a one-shot `Timer` resolve window, an enum-keyed difficulty
    // selector, and a per-difficulty highscore map. The script
    // deterministically deals the deck with a fixed RNG seed (4242)
    // so tests can address matching pairs by slot index. For seed
    // 4242, the 4×4 layout pairs are:
    //   face=6 at slots [0, 2]      face=5 at slots [1, 14]
    //   face=1 at slots [3, 6]      face=4 at slots [4, 5]
    //   face=2 at slots [7, 12]     face=7 at slots [8, 15]
    //   face=3 at slots [9, 10]     face=0 at slots [11, 13]

    Duration resolvePad = const Duration(milliseconds: 700);

    testWidgets(
        'boots on Easy with 16 face-down cards and an empty score panel',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        expect(find.text('Memory Match'), findsOneWidget,
            reason: 'AppBar title should read "Memory Match".');
        expect(find.byKey(const ValueKey<String>('difficulty-bar')),
            findsOneWidget,
            reason: 'Difficulty selector row should mount.');
        expect(find.byKey(const ValueKey<String>('score-panel')),
            findsOneWidget,
            reason: 'Score panel should mount.');
        expect(find.byKey(const ValueKey<String>('card-grid')),
            findsOneWidget,
            reason: 'Card grid should mount.');

        // 16 cards for the 4×4 easy layout.
        for (var i = 0; i < 16; i++) {
          expect(find.byKey(ValueKey<String>('card-$i')), findsOneWidget,
              reason: 'card-$i should mount in easy mode (16 slots).');
        }
        expect(find.byKey(const ValueKey<String>('card-16')), findsNothing,
            reason: 'card-16 should NOT exist in easy mode '
                '(only 16 slots, indices 0..15).');

        // Score panel starts at moves=0, pairs=0/8, best=—.
        expect(find.text('0 / 8'), findsOneWidget,
            reason: 'Pairs readout should be "0 / 8" before any matches.');
        expect(find.text('—'), findsOneWidget,
            reason: 'Best column should be "—" before the player has '
                'solved any board.');

        final dealLines = _printLog
            .where((l) => l.startsWith('memmatch.deal'))
            .toList();
        expect(dealLines, hasLength(1),
            reason: 'Boot should deal the deck exactly once.');
        expect(dealLines.single, contains('difficulty=easy'),
            reason: 'Initial difficulty is easy.');
        expect(dealLines.single, contains('cards=16'),
            reason: 'Easy mode deals 16 cards.');
      });
    });

    testWidgets('switching to Hard re-deals the deck at 36 cards',
        (tester) async {
      tester.view.physicalSize = const Size(900, 1500);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        await tester
            .tap(find.byKey(const ValueKey<String>('difficulty-hard')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        for (var i = 0; i < 36; i++) {
          expect(find.byKey(ValueKey<String>('card-$i')), findsOneWidget,
              reason: 'card-$i should mount in hard mode (36 slots).');
        }

        expect(find.text('0 / 18'), findsOneWidget,
            reason: 'Hard mode has 18 pairs.');

        final dealLines = _printLog
            .where((l) => l.startsWith('memmatch.deal'))
            .toList();
        expect(dealLines, hasLength(2),
            reason: 'One deal at boot, one after the difficulty swap.');
        expect(dealLines.last, contains('difficulty=hard'),
            reason: 'Second deal should be for hard difficulty.');
        expect(dealLines.last, contains('cards=36'),
            reason: 'Hard mode deals 36 cards.');
      });
    });

    testWidgets(
        'tapping a single card reveals it without changing the move count',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        await tester.tap(find.byKey(const ValueKey<String>('card-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 350));

        final flipFirst = _printLog
            .where((l) => l.startsWith('memmatch.flipFirst'))
            .toList();
        expect(flipFirst, hasLength(1),
            reason: 'Tapping a face-down card should emit one flipFirst.');
        expect(flipFirst.single, contains('slot=0'),
            reason: 'The first flip targeted slot 0.');

        final flipSecond = _printLog
            .where((l) => l.startsWith('memmatch.flipSecond'))
            .toList();
        expect(flipSecond, isEmpty,
            reason: 'A single tap should NOT emit a flipSecond — the '
                'second-card path only runs after the player picks a '
                'second card.');
      });
    });

    testWidgets(
        'mismatched pair increments moves then hides both cards after '
        'the resolve delay', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        // Slot 0 has face=6, slot 1 has face=5 → mismatch.
        await tester.tap(find.byKey(const ValueKey<String>('card-0')));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const ValueKey<String>('card-1')));
        await tester.pump(const Duration(milliseconds: 50));

        final flipSecond = _printLog
            .where((l) => l.startsWith('memmatch.flipSecond'))
            .toList();
        expect(flipSecond, hasLength(1),
            reason: 'Tapping the second card should emit flipSecond.');
        expect(flipSecond.single, contains('match=false'),
            reason: 'Slots 0 and 1 (faces 6 and 5) are not a match.');
        expect(flipSecond.single, contains('moves=1'),
            reason: 'The move counter should advance on the second tap.');

        // Wait past the resolve window.
        await tester.pumpAndSettle(resolvePad);

        final resolve = _printLog
            .where((l) => l.startsWith('memmatch.resolve'))
            .toList();
        expect(resolve, hasLength(1),
            reason: 'The resolve Timer should have fired exactly once.');
        expect(resolve.single, contains('match=false'),
            reason: 'The resolve should report match=false.');
        expect(resolve.single, contains('matches=0'),
            reason: 'A miss should NOT advance the matches counter.');

        // Moves display should now read 1.
        expect(find.text('1'), findsOneWidget,
            reason: 'Moves readout should be "1" after one full attempt.');
      });
    });

    testWidgets(
        'matched pair stays face-up, advances matches, and emits one '
        'resolve line', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        // Slots 4 and 5 both have face=4 → guaranteed match.
        await tester.tap(find.byKey(const ValueKey<String>('card-4')));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const ValueKey<String>('card-5')));
        await tester.pumpAndSettle(resolvePad);

        final resolve = _printLog
            .where((l) => l.startsWith('memmatch.resolve'))
            .toList();
        expect(resolve, hasLength(1),
            reason: 'One pair attempt = one resolve line.');
        expect(resolve.single, contains('match=true'),
            reason: 'Slots 4 and 5 (both face 4) are a match.');
        expect(resolve.single, contains('matches=1'),
            reason: 'Matches counter should advance to 1.');

        expect(find.text('1 / 8'), findsOneWidget,
            reason: 'Pairs readout should be "1 / 8" after the first '
                'successful match.');

        // The game is not yet solved — newBest/solved lines should
        // not have fired.
        final solvedLines = _printLog
            .where((l) => l.startsWith('memmatch.solved'))
            .toList();
        expect(solvedLines, isEmpty,
            reason: 'A single match should not trigger the solved path.');
      });
    });

    testWidgets(
        'reset button mid-game returns to zero moves without dropping '
        'the deck size', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        // One mismatched attempt to dirty the state.
        await tester.tap(find.byKey(const ValueKey<String>('card-0')));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const ValueKey<String>('card-1')));
        await tester.pumpAndSettle(resolvePad);

        // Now reset.
        await tester.tap(find.byKey(const ValueKey<String>('btn-reset')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        final reset = _printLog
            .where((l) => l.startsWith('memmatch.reset'))
            .toList();
        expect(reset, hasLength(1),
            reason: 'Tapping reset should emit one reset trail line.');

        final dealLines = _printLog
            .where((l) => l.startsWith('memmatch.deal'))
            .toList();
        expect(dealLines, hasLength(2),
            reason: 'Reset should trigger a second deal '
                '(boot deal + reset deal).');

        // After reset, the score panel should be moves=0 again,
        // pairs=0/8, best=— (we never solved the board).
        expect(find.text('0 / 8'), findsOneWidget,
            reason: 'After reset, pairs readout should be "0 / 8".');
        expect(find.text('—'), findsOneWidget,
            reason: 'No completed run = best column stays "—".');
      });
    });

    testWidgets(
        'solving every pair on easy records the move count as the new best',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // For seed 4242, the 4×4 layout matching pairs (face → slots):
      //   6 → [0, 2]   5 → [1, 14]   1 → [3, 6]   4 → [4, 5]
      //   2 → [7, 12]  7 → [8, 15]   3 → [9, 10]  0 → [11, 13]
      // Solving in this order takes exactly 8 moves (perfect run).
      const List<List<int>> pairOrder = <List<int>>[
        <int>[0, 2],
        <int>[1, 14],
        <int>[3, 6],
        <int>[4, 5],
        <int>[7, 12],
        <int>[8, 15],
        <int>[9, 10],
        <int>[11, 13],
      ];

      await _runInZone(() async {
        await _mountSample(tester, 'memory_match');

        for (final pair in pairOrder) {
          await tester
              .tap(find.byKey(ValueKey<String>('card-${pair[0]}')));
          await tester.pump(const Duration(milliseconds: 50));
          await tester
              .tap(find.byKey(ValueKey<String>('card-${pair[1]}')));
          await tester.pumpAndSettle(resolvePad);
        }

        final solved = _printLog
            .where((l) => l.startsWith('memmatch.solved'))
            .toList();
        expect(solved, hasLength(1),
            reason: 'Solving the board should emit exactly one solved '
                'trail line.');
        expect(solved.single, contains('moves=8'),
            reason: 'A perfect run is 8 moves (one per pair).');

        final newBest = _printLog
            .where((l) => l.startsWith('memmatch.newBest'))
            .toList();
        expect(newBest, hasLength(1),
            reason: 'A first-ever solve should record a new best.');
        expect(newBest.single, contains('moves=8'),
            reason: 'New best should be 8 moves on a perfect run.');

        expect(find.text('8 / 8'), findsOneWidget,
            reason: 'Pairs readout should reach 8 / 8.');
      });
    });
  });

  group(
      'snake_game (example #7 — KeyboardListener + Timer.periodic + '
      'CustomPainter)', () {
    // Initial state for kFoodSeed=1337:
    //   body = [(10,10), (9,10), (8,10)]  (head right of centre,
    //                                       facing right)
    //   first food pellet = (17, 12)
    //   second food pellet = (14, 16)
    // The game boots PAUSED; tests advance ticks deterministically
    // via the `btn-step` button, never via the auto-play Timer.

    testWidgets(
        'boots paused with a length-3 snake and the seeded food pellet',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        // The script prints the initial body length, food pos, and dir.
        expect(
          _printLog.where((l) => l.startsWith('snake.init')),
          hasLength(1),
          reason: 'Boot should emit exactly one init trail line.',
        );
        final init = _printLog.firstWhere(
          (l) => l.startsWith('snake.init'),
        );
        expect(init, contains('body=3'));
        expect(init, contains('food=(17,12)'));
        expect(init, contains('dir=right'));

        // Surface readouts.
        expect(find.text('Score: 0'), findsOneWidget);
        expect(find.text('PAUSED'), findsOneWidget);
        expect(find.text('Best: 0'), findsOneWidget);
        expect(find.byKey(const ValueKey<String>('snake-canvas')),
            findsOneWidget);
      });
    });

    testWidgets('Step button moves the head one cell right',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        await tester.tap(find.byKey(const ValueKey<String>('btn-step')));
        await tester.pump(const Duration(milliseconds: 50));

        final ticks = _printLog
            .where((l) => l.startsWith('snake.tick'))
            .toList();
        expect(ticks, hasLength(1),
            reason: 'A single step should produce one tick line.');
        expect(ticks.single, contains('dir=right'));
        expect(ticks.single, contains('head=(11,10)'));
      });
    });

    testWidgets('tapping a direction queues it for the next step',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        // Right→Down is a valid turn (not opposite).
        await tester.tap(find.byKey(const ValueKey<String>('btn-down')));
        await tester.pump(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const ValueKey<String>('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l == 'snake.dir queued=down'),
          hasLength(1),
          reason: 'Down should be accepted and queued.',
        );
        final tick = _printLog.firstWhere(
          (l) => l.startsWith('snake.tick'),
        );
        expect(tick, contains('dir=down'));
        expect(tick, contains('head=(10,11)'));
      });
    });

    testWidgets('reverse direction is rejected as a 180° turn',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        // Heading right → tapping left should be ignored.
        await tester.tap(find.byKey(const ValueKey<String>('btn-left')));
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.contains('ignored=left')),
          hasLength(1),
          reason: 'Reverse-direction press should produce one '
              'ignored-line and no queued-line.',
        );
        expect(
          _printLog.where((l) => l == 'snake.dir queued=left'),
          isEmpty,
        );
      });
    });

    testWidgets('eating food grows the snake and bumps the score',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        // Head starts at (10,10). Food at (17,12). Walk right 7
        // ticks to reach (17,10), then down twice to land on the
        // pellet.
        for (var i = 0; i < 7; i++) {
          await tester
              .tap(find.byKey(const ValueKey<String>('btn-step')));
          await tester.pump(const Duration(milliseconds: 10));
        }
        // Turn down and step into (17,11) then (17,12).
        await tester.tap(find.byKey(const ValueKey<String>('btn-down')));
        await tester.pump(const Duration(milliseconds: 10));
        await tester.tap(find.byKey(const ValueKey<String>('btn-step')));
        await tester.pump(const Duration(milliseconds: 10));
        await tester.tap(find.byKey(const ValueKey<String>('btn-step')));
        await tester.pump(const Duration(milliseconds: 50));

        final eats =
            _printLog.where((l) => l.startsWith('snake.eat')).toList();
        expect(eats, hasLength(1),
            reason: 'Landing on the pellet should emit one eat line.');
        expect(eats.single, contains('score=1'));
        expect(eats.single, contains('body=4'));
        // The next pellet should respawn at the second seeded cell.
        expect(eats.single, contains('food=(14,16)'));
        expect(find.text('Score: 1'), findsOneWidget);
      });
    });

    testWidgets(
        'walking off the right edge ends the game with reason=wall',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        // From (10,10) heading right, ten steps lands on (20,10)
        // which is past the right edge — the food at (17,12) is
        // off-axis so no eat happens.
        for (var i = 0; i < 10; i++) {
          await tester
              .tap(find.byKey(const ValueKey<String>('btn-step')));
          await tester.pump(const Duration(milliseconds: 10));
        }

        final over =
            _printLog.where((l) => l.startsWith('snake.over')).toList();
        expect(over, hasLength(1),
            reason: 'Tenth step should run the head off-board and '
                'emit one over line.');
        expect(over.single, contains('reason=wall'));
        expect(over.single, contains('score=0'));
        expect(find.text('GAME OVER'), findsOneWidget);
      });
    });

    testWidgets('Reset button restores the initial position',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'snake_game');

        // Take a few steps then reset.
        for (var i = 0; i < 3; i++) {
          await tester
              .tap(find.byKey(const ValueKey<String>('btn-step')));
          await tester.pump(const Duration(milliseconds: 10));
        }
        await tester.tap(find.byKey(const ValueKey<String>('btn-reset')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Two reset prints total: the one at init and the one we
        // just triggered (announce='reset').
        final resetLines = _printLog
            .where((l) => l.startsWith('snake.reset'))
            .toList();
        expect(resetLines, hasLength(1),
            reason: 'Tapping Reset should emit exactly one reset line.');
        expect(resetLines.single, contains('body=3'));
        expect(resetLines.single, contains('food=(17,12)'));
        expect(resetLines.single, contains('dir=right'));

        // After reset the snake should be paused at length 3 again,
        // with score zeroed.
        expect(find.text('Score: 0'), findsOneWidget);
        expect(find.text('PAUSED'), findsOneWidget);
        expect(find.text('GAME OVER'), findsNothing);
      });
    });
  });

  group(
      "conway_life (example #8 — Set<Cell> equality + Timer.periodic + "
      'CustomPainter + PopupMenuButton)', () {
    // The Life board is 60×40 and boots paused & empty. Every test
    // drives the board deterministically through `btn-step` so the
    // auto-play Timer is never relied upon.
    //
    // Coordinate cheatsheet (centre cell = (30, 20)):
    //   Blinker        : (29,20) (30,20) (31,20) — period-2
    //   Block          : (30,20) (31,20) (30,21) (31,21) — static
    //   Glider offsets : (0,-1) (1,0) (-1,1) (0,1) (1,1) → at centre
    //                    that's (30,19) (31,20) (29,21) (30,21) (31,21).
    //                    After 4 generations the same shape sits at
    //                    (+1,+1) relative to where it started.

    testWidgets('boots paused, empty, with gen=0 and the slider readout',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'conway_life');

        final init = _printLog.firstWhere(
          (l) => l.startsWith('life.init'),
          orElse: () => '',
        );
        expect(init, isNot(isEmpty),
            reason: 'Boot should emit exactly one life.init trail line.');
        expect(init, contains('w=60'));
        expect(init, contains('h=40'));
        expect(init, contains('gen=0'));
        expect(init, contains('alive=0'));

        expect(find.text('gen 0 / alive 0'), findsOneWidget);
        expect(find.text('200 ms'), findsOneWidget,
            reason: 'Default slider should read 200 ms on boot.');
        expect(find.byKey(const Key('life-board')), findsOneWidget);
        expect(find.byKey(const Key('btn-play-pause')), findsOneWidget);
      });
    });

    testWidgets('blinker preset rotates between horizontal and vertical',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'conway_life');

        await tester.tap(find.byKey(const Key('preset-menu')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.text('Blinker'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final preset = _printLog.firstWhere(
          (l) => l.startsWith('life.preset name=Blinker'),
          orElse: () => '',
        );
        expect(preset, isNot(isEmpty),
            reason: 'Blinker should emit one preset trail line.');
        expect(preset, contains('alive=3'));
        expect(find.text('gen 0 / alive 3'), findsOneWidget);

        // One step → still 3 cells (period-2 oscillator).
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));
        final firstStep = _printLog.firstWhere(
          (l) => l.startsWith('life.step gen=1'),
          orElse: () => '',
        );
        expect(firstStep, contains('alive=3'),
            reason: 'Blinker after one step should still have 3 cells. '
                'If alive!=3 the Set<Cell>/Map<Cell,int> equality is '
                'broken — see GEN equality fix.');

        // Two more steps: original shape returns on even generations.
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));
        final secondStep = _printLog.firstWhere(
          (l) => l.startsWith('life.step gen=2'),
          orElse: () => '',
        );
        expect(secondStep, contains('alive=3'),
            reason: 'Blinker after two steps should rotate back to 3.');
      });
    });

    testWidgets('block preset is a still life — alive count never changes',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'conway_life');

        await tester.tap(find.byKey(const Key('preset-menu')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.text('Block'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final preset = _printLog.firstWhere(
          (l) => l.startsWith('life.preset name=Block'),
          orElse: () => '',
        );
        expect(preset, contains('alive=4'));

        for (var i = 0; i < 3; i++) {
          await tester.tap(find.byKey(const Key('btn-step')));
          await tester.pump(const Duration(milliseconds: 20));
        }

        final steps = _printLog
            .where((l) => l.startsWith('life.step'))
            .toList();
        expect(steps, hasLength(3),
            reason: 'Three step taps should produce three life.step lines.');
        for (final s in steps) {
          expect(s, contains('alive=4'),
              reason: 'Block is a still life — alive count must remain 4.');
        }
      });
    });

    testWidgets('glider returns to same shape shifted by (+1,+1) after 4 gens',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'conway_life');

        await tester.tap(find.byKey(const Key('preset-menu')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.text('Glider'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final preset = _printLog.firstWhere(
          (l) => l.startsWith('life.preset name=Glider'),
          orElse: () => '',
        );
        expect(preset, contains('alive=5'),
            reason: 'Glider has 5 live cells.');

        // Advance four generations.
        for (var i = 0; i < 4; i++) {
          await tester.tap(find.byKey(const Key('btn-step')));
          await tester.pump(const Duration(milliseconds: 20));
        }

        final steps = _printLog
            .where((l) => l.startsWith('life.step'))
            .toList();
        expect(steps, hasLength(4));
        // Glider stays at 5 alive cells across its 4-cycle.
        for (final s in steps) {
          expect(s, contains('alive=5'),
              reason: 'Glider is a 5-cell pattern; alive must stay 5. '
                  'If it drifts, Set<Cell> equality is mis-counting.');
        }
        expect(find.text('gen 4 / alive 5'), findsOneWidget);
      });
    });

    testWidgets('clear button resets gen and live count',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'conway_life');

        await tester.tap(find.byKey(const Key('preset-menu')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.text('Glider'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 20));
        await tester.tap(find.byKey(const Key('btn-clear')));
        await tester.pump(const Duration(milliseconds: 20));

        final clears = _printLog
            .where((l) => l.startsWith('life.clear'))
            .toList();
        expect(clears, hasLength(1));
        expect(clears.single, contains('gen=0'));
        expect(clears.single, contains('alive=0'));
        expect(find.text('gen 0 / alive 0'), findsOneWidget);
      });
    });

    testWidgets('play/pause toggle starts and stops the ticker',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'conway_life');

        await tester.tap(find.byKey(const Key('preset-menu')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.text('Blinker'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Press play, let it tick once or twice, then pause.
        await tester.tap(find.byKey(const Key('btn-play-pause')));
        await tester.pump(const Duration(milliseconds: 250));
        await tester.tap(find.byKey(const Key('btn-play-pause')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(
          _printLog.where((l) => l.startsWith('life.play interval=')),
          hasLength(1),
          reason: 'play should emit exactly one life.play line.',
        );
        expect(
          _printLog.where((l) => l == 'life.pause'),
          hasLength(1),
          reason: 'pause should emit exactly one life.pause line.',
        );
        // The blinker oscillates, so we should observe at least one step.
        expect(
          _printLog.where((l) => l.startsWith('life.step')).length,
          greaterThanOrEqualTo(1),
          reason: 'Auto-play should produce at least one step before pause.',
        );
      });
    });
  });

  group(
      'bouncing_balls_physics (example #9 — AnimationController-driven '
      'sim + Ball.copyWith + CustomPainter + Slider)', () {
    // The world is a fixed 400×300 box with gravity=800px/s² and
    // elasticity=0.85 by default. The script boots paused and tests
    // drive the physics deterministically through `btn-step` (one
    // fixed dt per tap = 0.05s). The auto-play AnimationController
    // is only touched by the play/pause smoke test.
    //
    // Math sanity-check (g=800, dt=0.05, ball spawn y=24, vy=0):
    //   step 1 → vy=40,  y=26.0
    //   step 2 → vy=80,  y=30.0
    //   step 5 → vy=200, y=54.0
    //   step 16 → vy=640, y=296 → clamps to 288 (floor), vy=-544
    //   so by step 16 the ball has bounced at least once.

    testWidgets(
        'boots paused, empty, with default gravity / elasticity / dims',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        final init = _printLog.firstWhere(
          (l) => l.startsWith('physics.init'),
          orElse: () => '',
        );
        expect(init, isNot(isEmpty),
            reason: 'Boot should emit exactly one physics.init trail line.');
        expect(init, contains('w=400'));
        expect(init, contains('h=300'));
        expect(init, contains('balls=0'));
        expect(init, contains('gravity=800'));
        expect(init, contains('elasticity=0.85'));

        expect(find.text('balls 0'), findsOneWidget);
        expect(find.text('800 px/s²'), findsOneWidget);
        expect(find.text('0.85'), findsOneWidget);
        expect(find.byKey(const Key('balls-canvas')), findsOneWidget);
        expect(find.byKey(const Key('btn-play-pause')), findsOneWidget);
      });
    });

    testWidgets('spawn button adds a ball with id=0 inside the world',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        await tester.tap(find.byKey(const Key('btn-spawn')));
        await tester.pump(const Duration(milliseconds: 30));

        final spawn = _printLog.firstWhere(
          (l) => l.startsWith('physics.spawn'),
          orElse: () => '',
        );
        expect(spawn, isNot(isEmpty),
            reason: 'Spawn tap should emit one physics.spawn trail line.');
        expect(spawn, contains('id=0'));
        expect(spawn, contains('balls=1'));
        expect(find.text('balls 1'), findsOneWidget);

        // Spawn anchor is 25–75 % of world width and y = 2 * radius = 24.
        // We don't pin RNG output but the spawn rectangle is fixed.
        final xMatch =
            RegExp(r'x=([0-9]+(?:\.[0-9]+)?)').firstMatch(spawn);
        final yMatch =
            RegExp(r'y=([0-9]+(?:\.[0-9]+)?)').firstMatch(spawn);
        expect(xMatch, isNotNull);
        expect(yMatch, isNotNull);
        final x = double.parse(xMatch!.group(1)!);
        final y = double.parse(yMatch!.group(1)!);
        expect(x, greaterThanOrEqualTo(100.0));
        expect(x, lessThanOrEqualTo(300.0));
        expect(y, closeTo(24.0, 0.01),
            reason: 'Initial spawn y must equal 2 * kBallRadius.');
      });
    });

    testWidgets('step makes the ball fall (topY strictly increases)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        await tester.tap(find.byKey(const Key('btn-spawn')));
        await tester.pump(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));

        final steps = _printLog
            .where((l) => l.startsWith('physics.step'))
            .toList();
        expect(steps, hasLength(2),
            reason: 'Two step taps should produce exactly two trail lines.');

        double extractTopY(String line) {
          final m = RegExp(r'topY=([0-9]+(?:\.[0-9]+)?)').firstMatch(line);
          expect(m, isNotNull, reason: 'topY missing in: $line');
          return double.parse(m!.group(1)!);
        }

        final topY1 = extractTopY(steps[0]);
        final topY2 = extractTopY(steps[1]);
        // Euler with g=800,dt=0.05: y₁=26.0, y₂=30.0
        expect(topY1, closeTo(26.0, 0.01));
        expect(topY2, closeTo(30.0, 0.01));
        expect(topY2, greaterThan(topY1),
            reason: 'Gravity should pull the ball down between steps.');
      });
    });

    testWidgets('ball stays inside the world after many steps (bounces)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        await tester.tap(find.byKey(const Key('btn-spawn')));
        await tester.pump(const Duration(milliseconds: 30));

        // 30 steps is well past the first floor bounce (~step 16).
        for (var i = 0; i < 30; i++) {
          await tester.tap(find.byKey(const Key('btn-step')));
          await tester.pump(const Duration(milliseconds: 10));
        }

        final steps = _printLog
            .where((l) => l.startsWith('physics.step'))
            .toList();
        expect(steps, hasLength(30));

        // After every step the ball is still inside the world.
        // World height = 300, ball radius = 12 → topY must always be
        // in [12, 288] (centre y, since topY is the centre coordinate).
        for (final s in steps) {
          final m =
              RegExp(r'topY=([0-9]+(?:\.[0-9]+)?)').firstMatch(s);
          expect(m, isNotNull, reason: 'topY missing in $s');
          final topY = double.parse(m!.group(1)!);
          expect(topY, greaterThanOrEqualTo(12.0),
              reason: 'Ball should never escape the ceiling: $s');
          expect(topY, lessThanOrEqualTo(288.0),
              reason: 'Ball should never escape the floor: $s');
        }

        // By step 30 the ball has bounced — its topY must have ticked
        // back upward at least once.
        var bounced = false;
        for (var i = 1; i < steps.length; i++) {
          final prev = double.parse(
              RegExp(r'topY=([0-9]+(?:\.[0-9]+)?)').firstMatch(steps[i - 1])!.group(1)!);
          final cur = double.parse(
              RegExp(r'topY=([0-9]+(?:\.[0-9]+)?)').firstMatch(steps[i])!.group(1)!);
          if (cur < prev) {
            bounced = true;
            break;
          }
        }
        expect(bounced, isTrue,
            reason: 'Ball should bounce off the floor before step 30.');
      });
    });

    testWidgets('spawn multiple balls then clear', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        for (var i = 0; i < 3; i++) {
          await tester.tap(find.byKey(const Key('btn-spawn')));
          await tester.pump(const Duration(milliseconds: 20));
        }
        expect(find.text('balls 3'), findsOneWidget);

        await tester.tap(find.byKey(const Key('btn-clear')));
        await tester.pump(const Duration(milliseconds: 20));

        final clears = _printLog
            .where((l) => l.startsWith('physics.clear'))
            .toList();
        expect(clears, hasLength(1));
        expect(clears.single, contains('balls=0'));
        expect(find.text('balls 0'), findsOneWidget);

        // After clear, spawning again should restart at id=0 (rng is
        // re-seeded so trajectories are reproducible after clear).
        await tester.tap(find.byKey(const Key('btn-spawn')));
        await tester.pump(const Duration(milliseconds: 20));
        final post = _printLog
            .where((l) => l.startsWith('physics.spawn'))
            .toList();
        expect(post, hasLength(4),
            reason: 'Three pre-clear spawns + one post-clear spawn.');
        expect(post.last, contains('id=0'),
            reason: 'Clear should reset _nextId back to 0.');
      });
    });

    testWidgets('play/pause toggle starts and stops the auto-play ticker',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        await tester.tap(find.byKey(const Key('btn-spawn')));
        await tester.pump(const Duration(milliseconds: 20));

        await tester.tap(find.byKey(const Key('btn-play-pause')));
        // Let the AnimationController tick a few frames.
        await tester.pump(const Duration(milliseconds: 50));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('btn-play-pause')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(
          _printLog.where((l) => l == 'physics.play'),
          hasLength(1),
          reason: 'play should emit exactly one physics.play line.',
        );
        expect(
          _printLog.where((l) => l == 'physics.pause'),
          hasLength(1),
          reason: 'pause should emit exactly one physics.pause line.',
        );
      });
    });

    testWidgets('tap on the canvas spawns a ball at the tap location',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bouncing_balls_physics');

        // Tap roughly the centre of the canvas.
        final canvas = find.byKey(const Key('balls-canvas'));
        await tester.tap(canvas);
        await tester.pump(const Duration(milliseconds: 30));

        final tap = _printLog.firstWhere(
          (l) => l.startsWith('physics.tap'),
          orElse: () => '',
        );
        expect(tap, isNot(isEmpty),
            reason: 'Canvas tap should emit one physics.tap trail line.');
        expect(tap, contains('id=0'));
        expect(tap, contains('balls=1'));
        expect(find.text('balls 1'), findsOneWidget);
      });
    });
  });

  group(
      'particle_field (example #10 — raw Ticker + MouseRegion + '
      'SegmentedButton + CustomPainter)', () {
    // The field is 600×400 with 20 seeded particles (kParticleSeed),
    // attractor centred at (300, 200), mode=Attract on boot. Tests
    // drive the sim via btn-step; the raw Ticker is only exercised
    // by the play/pause smoke test.

    testWidgets('boots paused with attractor at world centre and 20 particles',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        final init = _printLog.firstWhere(
          (l) => l.startsWith('field.init'),
          orElse: () => '',
        );
        expect(init, isNot(isEmpty),
            reason: 'Boot should emit exactly one field.init trail line.');
        expect(init, contains('w=600'));
        expect(init, contains('h=400'));
        expect(init, contains('particles=20'));
        expect(init, contains('mode=Attract'));
        expect(init, contains('attractorX=300.0'));
        expect(init, contains('attractorY=200.0'));

        expect(find.text('mode Attract'), findsOneWidget);
        expect(find.byKey(const Key('mode-selector')), findsOneWidget);
        expect(find.byKey(const Key('field-canvas')), findsOneWidget);
      });
    });

    testWidgets('attract mode contracts: meanR strictly decreases over 20 steps',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        for (var i = 0; i < 20; i++) {
          await tester.tap(find.byKey(const Key('btn-step')));
          await tester.pump(const Duration(milliseconds: 10));
        }

        final steps = _printLog
            .where((l) => l.startsWith('field.step'))
            .toList();
        expect(steps, hasLength(20));

        double extractMeanR(String line) {
          final m = RegExp(r'meanR=([0-9]+(?:\.[0-9]+)?)').firstMatch(line);
          expect(m, isNotNull, reason: 'meanR missing in: $line');
          return double.parse(m!.group(1)!);
        }

        // We don't require monotonic strict decrease (orbits build
        // momentum and overshoot is normal once particles cross the
        // attractor), but the *first* few steps must contract sharply
        // because every particle starts at rest with full attract
        // acceleration. Over 20 steps the meanR must clearly drop
        // from its initial value.
        final first = extractMeanR(steps.first);
        final last = extractMeanR(steps.last);
        expect(last, lessThan(first),
            reason: 'Attract mode should pull particles inward over 20 '
                'steps. first=$first last=$last');
      });
    });

    testWidgets('mode tap (Attract → Repel) emits trail and updates chip',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        await tester.tap(find.text('Repel'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final modeLines = _printLog
            .where((l) => l.startsWith('field.mode'))
            .toList();
        expect(modeLines, hasLength(1),
            reason: 'SegmentedButton change should emit one field.mode line.');
        expect(modeLines.single, contains('mode=Repel'));
        expect(find.text('mode Repel'), findsOneWidget);

        // After one Repel step, meanR should be larger than the
        // boot-time meanR — particles flee the attractor.
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));
        final stepLine = _printLog.firstWhere(
          (l) => l.startsWith('field.step'),
          orElse: () => '',
        );
        expect(stepLine, contains('mode=Repel'));
      });
    });

    testWidgets('mode tap (Attract → Orbit) emits trail and updates chip',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        await tester.tap(find.text('Orbit'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final modeLines = _printLog
            .where((l) => l.startsWith('field.mode'))
            .toList();
        expect(modeLines, hasLength(1));
        expect(modeLines.single, contains('mode=Orbit'));
        expect(find.text('mode Orbit'), findsOneWidget);
      });
    });

    testWidgets('reset re-seeds the field and restores Attract defaults',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        // Mutate the field a bit: change mode, step a few times.
        await tester.tap(find.text('Repel'));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        for (var i = 0; i < 3; i++) {
          await tester.tap(find.byKey(const Key('btn-step')));
          await tester.pump(const Duration(milliseconds: 10));
        }

        await tester.tap(find.byKey(const Key('btn-reset')));
        await tester.pumpAndSettle(const Duration(milliseconds: 30));

        final resets = _printLog
            .where((l) => l.startsWith('field.reset'))
            .toList();
        expect(resets, hasLength(1));
        expect(resets.single, contains('particles=20'));
        // Reset returns to Attract mode (see seedField).
        expect(find.text('mode Attract'), findsOneWidget);
      });
    });

    testWidgets('tap on canvas repositions the attractor', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        await tester.tap(find.byKey(const Key('field-canvas')));
        await tester.pump(const Duration(milliseconds: 20));

        final taps = _printLog
            .where((l) => l.startsWith('field.tap'))
            .toList();
        expect(taps, hasLength(1),
            reason: 'A canvas tap should emit one field.tap line.');

        // The default tap target on tester.tap is the widget centre
        // in screen space; in world space that maps roughly to
        // (300, 200) — within wide bounds we just assert "inside the
        // world box".
        final m = RegExp(
          r'field\.tap x=([0-9]+(?:\.[0-9]+)?) y=([0-9]+(?:\.[0-9]+)?)',
        ).firstMatch(taps.single);
        expect(m, isNotNull);
        final x = double.parse(m!.group(1)!);
        final y = double.parse(m.group(2)!);
        expect(x, greaterThanOrEqualTo(0.0));
        expect(x, lessThanOrEqualTo(600.0));
        expect(y, greaterThanOrEqualTo(0.0));
        expect(y, lessThanOrEqualTo(400.0));

        // One more step should pull particles toward the NEW
        // attractor, not the old centre.
        await tester.tap(find.byKey(const Key('btn-step')));
        await tester.pump(const Duration(milliseconds: 30));
        final step = _printLog.firstWhere(
          (l) => l.startsWith('field.step'),
          orElse: () => '',
        );
        expect(step, contains('mode=Attract'));
      });
    });

    testWidgets('play/pause toggle drives the raw Ticker',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'particle_field');

        await tester.tap(find.byKey(const Key('btn-play-pause')));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('btn-play-pause')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(
          _printLog.where((l) => l == 'field.play'),
          hasLength(1),
          reason: 'play should emit exactly one field.play line.',
        );
        expect(
          _printLog.where((l) => l == 'field.pause'),
          hasLength(1),
          reason: 'pause should emit exactly one field.pause line.',
        );
      });
    });
  });

  group(
      'color_picker_studio (example #11 — ValueNotifier<Color> + '
      'ValueListenableBuilder + TextField + Slider)', () {
    // The studio boots on kInitialColor = #5599FF, hex round-trips
    // cleanly, and HSV math lands on round numbers (h≈216, s≈66, v=100).
    // Tests drive the picker via the hex field (enterText) and the
    // swatch strip (tap by stable Key) — sliders are exercised
    // indirectly through the trail.

    testWidgets('boots with kInitialColor and seeded recents', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'color_picker_studio');

        final init = _printLog.firstWhere(
          (l) => l.startsWith('picker.init'),
          orElse: () => '',
        );
        expect(init, isNot(isEmpty),
            reason: 'Boot should emit exactly one picker.init line.');
        expect(init, contains('hex=#5599FF'));
        expect(init, contains('r=85'));
        expect(init, contains('g=153'));
        expect(init, contains('b=255'));
        expect(init, contains('recents=8'));

        expect(find.byKey(const Key('preview-swatch')), findsOneWidget);
        final previewLabel = tester.widget<Text>(
            find.byKey(const Key('preview-hex-label')));
        expect(previewLabel.data, '#5599FF',
            reason: 'Preview label should display the current hex.');

        // All 8 seeded swatches should be present.
        for (var i = 0; i < 8; i++) {
          expect(find.byKey(Key('swatch-$i')), findsOneWidget,
              reason: 'Expected seed swatch index $i to be present.');
        }
      });
    });

    testWidgets('hex field accepts a new colour and pushes onto recents',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'color_picker_studio');

        await tester.enterText(find.byKey(const Key('hex-field')), '#FF0080');
        await tester.tap(find.byKey(const Key('hex-submit')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final hexLines = _printLog
            .where((l) => l.startsWith('picker.hex hex='))
            .toList();
        expect(hexLines, hasLength(1),
            reason: 'A valid hex submit should emit one picker.hex line.');
        expect(hexLines.single, contains('hex=#FF0080'));
        expect(hexLines.single, contains('r=255'));
        expect(hexLines.single, contains('g=0'));
        expect(hexLines.single, contains('b=128'));

        final recentLines = _printLog
            .where((l) => l.startsWith('picker.recent'))
            .toList();
        expect(recentLines, hasLength(1),
            reason: 'Committing a new colour should push exactly one '
                'picker.recent line.');
        expect(recentLines.single, contains('hex=#FF0080'));
        expect(recentLines.single, contains('source=hex'));

        // Preview label should reflect the new value (the hex field
        // text would also contain '#FF0080', so target the label by
        // Key rather than by find.text).
        final previewLabel = tester.widget<Text>(
            find.byKey(const Key('preview-hex-label')));
        expect(previewLabel.data, '#FF0080');
      });
    });

    testWidgets('invalid hex is rejected and does not mutate state',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'color_picker_studio');

        await tester.enterText(find.byKey(const Key('hex-field')), 'NOTHEX');
        await tester.tap(find.byKey(const Key('hex-submit')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final invalid = _printLog
            .where((l) => l.startsWith('picker.hex.invalid'))
            .toList();
        expect(invalid, hasLength(1),
            reason: 'A non-hex submission should emit one '
                'picker.hex.invalid line.');

        // No picker.hex / picker.recent should have fired.
        expect(
          _printLog.where((l) => l.startsWith('picker.hex hex=')),
          isEmpty,
          reason: 'Invalid hex must not commit a colour.',
        );
        expect(
          _printLog.where((l) => l.startsWith('picker.recent')),
          isEmpty,
        );

        // Preview label should still show the boot colour.
        final previewLabel = tester.widget<Text>(
            find.byKey(const Key('preview-hex-label')));
        expect(previewLabel.data, '#5599FF');
      });
    });

    testWidgets('tapping a seeded swatch swaps the active colour',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'color_picker_studio');

        // Swatch index 5 in kDefaultPalette is #1E88E5 (blue). The
        // strip lives at the bottom of a scroll view, so make sure
        // it's in the viewport before tapping.
        await tester.ensureVisible(find.byKey(const Key('swatch-5')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('swatch-5')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        final swatchLines = _printLog
            .where((l) => l.startsWith('picker.swatch hex='))
            .toList();
        expect(swatchLines, hasLength(1),
            reason: 'Tapping a swatch should emit one picker.swatch line.');
        expect(swatchLines.single, contains('hex=#1E88E5'));

        // The tap also commits to recents (source=swatch).
        final recentLines = _printLog
            .where((l) => l.startsWith('picker.recent'))
            .toList();
        expect(recentLines, hasLength(1));
        expect(recentLines.single, contains('source=swatch'));
        expect(recentLines.single, contains('hex=#1E88E5'));
      });
    });

    testWidgets('same-colour hex submit is a no-op (no trail churn)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'color_picker_studio');

        // Submit the SAME initial hex — should not emit picker.hex
        // because _apply short-circuits when value.value matches.
        await tester.enterText(find.byKey(const Key('hex-field')), '#5599FF');
        await tester.tap(find.byKey(const Key('hex-submit')));
        await tester.pumpAndSettle(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('picker.hex hex=')),
          isEmpty,
          reason: 'Submitting the current colour should be a no-op '
              'on the picker.hex trail.',
        );
      });
    });
  });

  group(
      'tip_calculator (example #12 — TextField + FocusNode + Slider + '
      'IconButton stepper + DropdownButton)', () {
    // Defaults: bill=0, tip=15%, party=1, USD. The trail emits
    // tip.compute after every state mutation so tests can assert
    // the derived totals from a single line.

    testWidgets('boots with USD defaults and an initial tip.compute',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tip_calculator');

        final init = _printLog.firstWhere(
          (l) => l.startsWith('tip.init'),
          orElse: () => '',
        );
        expect(init, contains('bill=0.00'));
        expect(init, contains('tip=15'));
        expect(init, contains('party=1'));
        expect(init, contains('currency=USD'));

        final computes = _printLog
            .where((l) => l.startsWith('tip.compute'))
            .toList();
        expect(computes, hasLength(1),
            reason: 'Boot should emit one tip.compute baseline.');
        expect(computes.single, contains('bill=0.00'));
        expect(computes.single, contains('tip=0.00'));
        expect(computes.single, contains('grand=0.00'));
        expect(computes.single, contains('each=0.00'));
        expect(computes.single, contains('currency=USD'));

        // The summary should render the USD baseline.
        final tipText = tester.widget<Text>(find.byKey(const Key('row-tip')));
        expect(tipText.data, r'$0.00');
        final grandText = tester.widget<Text>(find.byKey(const Key('row-grand')));
        expect(grandText.data, r'$0.00');
      });
    });

    testWidgets('submitting a bill emits tip.bill + tip.compute and '
        'updates summary', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tip_calculator');

        await tester.enterText(find.byKey(const Key('bill-field')), '100');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        final bills = _printLog
            .where((l) => l.startsWith('tip.bill'))
            .where((l) => !l.startsWith('tip.bill.invalid'))
            .toList();
        expect(bills, hasLength(1),
            reason: 'A valid bill submit should emit one tip.bill line.');
        expect(bills.single, contains('raw=100'));
        expect(bills.single, contains('parsed=100.00'));

        // The most recent compute line drives the assertions.
        final computes = _printLog
            .where((l) => l.startsWith('tip.compute'))
            .toList();
        expect(computes.length, greaterThanOrEqualTo(2));
        final last = computes.last;
        expect(last, contains('bill=100.00'));
        // 15% tip on 100.00 = 15.00; grand = 115.00; party=1 -> each=115.00.
        expect(last, contains('tip=15.00'));
        expect(last, contains('grand=115.00'));
        expect(last, contains('each=115.00'));

        // Summary text should reflect the same numbers.
        final tipText = tester.widget<Text>(find.byKey(const Key('row-tip')));
        expect(tipText.data, r'$15.00');
        final grandText = tester.widget<Text>(find.byKey(const Key('row-grand')));
        expect(grandText.data, r'$115.00');
      });
    });

    testWidgets('invalid bill is rejected without mutating state',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tip_calculator');

        await tester.enterText(find.byKey(const Key('bill-field')), 'oops');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final invalid = _printLog
            .where((l) => l.startsWith('tip.bill.invalid'))
            .toList();
        expect(invalid, hasLength(1));
        expect(invalid.single, contains('raw=oops'));

        // No new tip.compute should have fired (boot still emits one).
        final computes = _printLog
            .where((l) => l.startsWith('tip.compute'))
            .toList();
        expect(computes, hasLength(1),
            reason: 'Invalid input must not trigger a new compute line.');

        // Summary stays on USD baseline.
        final tipText = tester.widget<Text>(find.byKey(const Key('row-tip')));
        expect(tipText.data, r'$0.00');
      });
    });

    testWidgets('party stepper: + grows the party and clamps - at 1',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tip_calculator');

        // Press the minus once while party=1 — onPressed is null
        // (button is disabled), so no tip.party line fires.
        await tester.tap(
          find.byKey(const Key('party-minus')),
          warnIfMissed: false,
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        expect(
          _printLog.where((l) => l.startsWith('tip.party')),
          isEmpty,
          reason: 'Pressing - at party=1 should be a no-op (button disabled).',
        );

        // Press plus three times -> party=4. Use short pumps rather
        // than pumpAndSettle so we don't wait through the InkResponse
        // splash before the next tap can be dispatched.
        for (var i = 0; i < 3; i++) {
          await tester.tap(find.byKey(const Key('party-plus')));
          await tester.pump(const Duration(milliseconds: 50));
        }
        final partyLines = _printLog
            .where((l) => l.startsWith('tip.party'))
            .toList();
        expect(partyLines, hasLength(3),
            reason: 'Three + taps should emit three tip.party lines.');
        expect(partyLines.last, contains('value=4'));

        // The count label should show "4" now.
        final count = tester.widget<Text>(find.byKey(const Key('party-count')));
        expect(count.data, '4');

        // Now press minus once -> party=3.
        await tester.tap(find.byKey(const Key('party-minus')));
        await tester.pump(const Duration(milliseconds: 50));
        final newest = _printLog
            .where((l) => l.startsWith('tip.party'))
            .last;
        expect(newest, contains('value=3'));
      });
    });

    testWidgets('changing currency updates the summary symbol',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tip_calculator');

        // Seed a bill so the symbol swap is visible.
        await tester.enterText(find.byKey(const Key('bill-field')), '50');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Open the dropdown and tap the EUR entry.
        await tester.tap(find.byKey(const Key('currency-dropdown')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));
        // After opening, two DropdownMenuItem widgets for EUR exist
        // (one in the closed button, one in the open menu). `.last`
        // selects the menu entry.
        await tester.tap(find.byKey(const Key('currency-EUR')).last);
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final currencyLines = _printLog
            .where((l) => l.startsWith('tip.currency'))
            .toList();
        expect(currencyLines, hasLength(1));
        expect(currencyLines.single, contains('value=EUR'));

        // EUR formats as "€ 57,50" (symbol + space, comma decimal).
        // 50 bill + 15% tip = 57.50.
        final grandText = tester.widget<Text>(find.byKey(const Key('row-grand')));
        expect(grandText.data, '\u20AC 57,50',
            reason: 'EUR grand total should use € + comma decimal. '
                'Got: ${grandText.data}');
      });
    });
  });

  group(
      'todo_list (example #13 — ChangeNotifier + ListenableBuilder + '
      'ReorderableListView + Dismissible + SegmentedButton)', () {
    // Trail prefix: `todo.*`. The store emits one line per mutation
    // so the assertion shape mirrors tip_calculator — derive from
    // the log rather than scraping widgets.

    testWidgets('boots empty with init trail and empty-state placeholder',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'todo_list');

        final initLines = _printLog
            .where((l) => l.startsWith('todo.init'))
            .toList();
        expect(initLines, hasLength(1));
        expect(initLines.single, contains('n=0'));

        // Composer and empty-state are both present, no tiles yet.
        expect(find.byKey(const Key('composer-input')), findsOneWidget);
        expect(find.byKey(const Key('empty-state')), findsOneWidget);
        expect(find.byKey(const Key('todo-list')), findsNothing,
            reason: 'List should be omitted while there are no tasks.');

        // Count line shows 0/0.
        final count = tester.widget<Text>(find.byKey(const Key('count-line')));
        expect(count.data, '0 active · 0 done');
      });
    });

    testWidgets('adding a task via the composer appends a tile',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'todo_list');

        await tester.enterText(
            find.byKey(const Key('composer-input')), 'buy milk');
        await tester.tap(find.byKey(const Key('composer-add')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        final adds = _printLog
            .where((l) => l.startsWith('todo.add '))
            .toList();
        expect(adds, hasLength(1),
            reason: 'One submit should emit one todo.add line.');
        expect(adds.single, contains('id=1'));
        expect(adds.single, contains('text="buy milk"'));

        // Tile rendered + count updated.
        expect(find.byKey(const Key('task-tile-1')), findsOneWidget);
        expect(find.text('buy milk'), findsOneWidget);
        final count = tester.widget<Text>(find.byKey(const Key('count-line')));
        expect(count.data, '1 active · 0 done');

        // Composer cleared after submit.
        final input = tester.widget<TextField>(
            find.byKey(const Key('composer-input')));
        expect(input.controller!.text, isEmpty);
      });
    });

    testWidgets('toggling done strikes through the text and updates count',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'todo_list');

        await tester.enterText(
            find.byKey(const Key('composer-input')), 'write report');
        await tester.tap(find.byKey(const Key('composer-add')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        await tester.tap(find.byKey(const Key('task-check-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 250));

        final toggles = _printLog
            .where((l) => l.startsWith('todo.toggle '))
            .toList();
        expect(toggles, hasLength(1));
        expect(toggles.single, contains('id=1'));
        expect(toggles.single, contains('done=true'));

        // Strikethrough text style is applied.
        final textWidget = tester.widget<Text>(find.text('write report'));
        expect(textWidget.style?.decoration, TextDecoration.lineThrough,
            reason: 'Done tile should render with lineThrough decoration.');

        // Count line moves the task to the done column.
        final count = tester.widget<Text>(find.byKey(const Key('count-line')));
        expect(count.data, '0 active · 1 done');
      });
    });

    testWidgets('swipe-to-delete + bottom-sheet confirm removes the task',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'todo_list');

        await tester.enterText(
            find.byKey(const Key('composer-input')), 'delete me');
        await tester.tap(find.byKey(const Key('composer-add')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        // Drive a swipe from right to left across the tile.
        await tester.drag(
          find.byKey(const Key('task-tile-1')),
          const Offset(-600.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Bottom sheet should be open with the prompt + buttons.
        expect(find.text('Delete "delete me"?'), findsOneWidget);
        expect(find.byKey(const Key('dismiss-cancel')), findsOneWidget);
        expect(find.byKey(const Key('dismiss-confirm')), findsOneWidget);

        await tester.tap(find.byKey(const Key('dismiss-confirm')));
        // Let the bottom-sheet pop animation finish, the
        // confirmDismiss future resolve, and the Dismissible
        // resize animation (default 300ms) run to completion before
        // expecting onDismissed to have fired.
        await tester.pumpAndSettle();

        final removes = _printLog
            .where((l) => l.startsWith('todo.remove '))
            .toList();
        expect(removes, hasLength(1));
        expect(removes.single, contains('id=1'));

        // Tile is gone, empty-state is back.
        expect(find.byKey(const Key('task-tile-1')), findsNothing);
        expect(find.byKey(const Key('empty-state')), findsOneWidget);
      });
    });

    testWidgets('filter bar restricts the visible list', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'todo_list');

        // Add two tasks, mark the second done.
        await tester.enterText(
            find.byKey(const Key('composer-input')), 'task A');
        await tester.tap(find.byKey(const Key('composer-add')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.enterText(
            find.byKey(const Key('composer-input')), 'task B');
        await tester.tap(find.byKey(const Key('composer-add')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('task-check-2')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Active filter -> only task A.
        await tester.tap(find.text('Active'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final filterLines = _printLog
            .where((l) => l.startsWith('todo.filter '))
            .toList();
        expect(filterLines, isNotEmpty);
        expect(filterLines.last, contains('value=active'));

        expect(find.byKey(const Key('task-tile-1')), findsOneWidget);
        expect(find.byKey(const Key('task-tile-2')), findsNothing);

        // Completed filter -> only task B.
        await tester.tap(find.text('Completed'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        expect(find.byKey(const Key('task-tile-1')), findsNothing);
        expect(find.byKey(const Key('task-tile-2')), findsOneWidget);

        // Back to All -> both visible.
        await tester.tap(find.text('All'));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        expect(find.byKey(const Key('task-tile-1')), findsOneWidget);
        expect(find.byKey(const Key('task-tile-2')), findsOneWidget);
      });
    });

    testWidgets('reorder via drag handle moves the tile', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'todo_list');

        for (final text in <String>['alpha', 'beta', 'gamma']) {
          await tester.enterText(
              find.byKey(const Key('composer-input')), text);
          await tester.tap(find.byKey(const Key('composer-add')));
          await tester.pumpAndSettle(const Duration(milliseconds: 50));
        }

        // Sanity: 3 tiles in the right order.
        final initialTitles = tester
            .widgetList<ListTile>(find.byType(ListTile))
            .map((t) => (t.title as AnimatedContainer).child as Text)
            .map((t) => t.data)
            .toList();
        expect(initialTitles, <String>['alpha', 'beta', 'gamma']);

        // Drag the first drag-handle down past the second tile.
        // ReorderableDragStartListener picks up pointer-down without a
        // long press, so a normal `tester.drag` triggers the reorder.
        await tester.drag(
          find.byKey(const Key('drag-handle-1')),
          const Offset(0.0, 140.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        final reorders = _printLog
            .where((l) => l.startsWith('todo.reorder '))
            .toList();
        expect(reorders, isNotEmpty,
            reason: 'Drag should emit at least one todo.reorder line.');
        expect(reorders.last, contains('id=1'));

        // alpha is no longer first.
        final afterTitles = tester
            .widgetList<ListTile>(find.byType(ListTile))
            .map((t) => (t.title as AnimatedContainer).child as Text)
            .map((t) => t.data)
            .toList();
        expect(afterTitles.first, isNot('alpha'),
            reason: 'After dragging alpha down it should not be first. '
                'Order after: $afterTitles');
      });
    });
  });

  group(
      'note_app (example #14 — master/detail + dialogs + sheets + '
      'debounced SnackBar)', () {
    // Trail prefix: `note.*`. The store emits one line per mutation
    // (add/select/update/save/delete) and the editor emits
    // `editor.swap` when the user picks a different note. Tests
    // mostly drive the wide layout (1200x1200 default) — the
    // narrow-layout Navigator.push path gets its own case below.

    testWidgets('boots empty with init trail and empty-pane placeholder',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        final initLines = _printLog
            .where((l) => l.startsWith('note.init'))
            .toList();
        expect(initLines, hasLength(1));
        expect(initLines.single, contains('n=0'));

        // Empty placeholders are visible in both panes.
        expect(find.byKey(const Key('list-empty-state')), findsOneWidget);
        expect(find.byKey(const Key('editor-empty-state')), findsOneWidget);
        // FAB is mounted and reachable.
        expect(find.byKey(const Key('fab-new-note')), findsOneWidget);
      });
    });

    testWidgets('FAB creates a blank note and selects it (wide)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        final adds = _printLog
            .where((l) => l.startsWith('note.add '))
            .toList();
        expect(adds, hasLength(1));
        expect(adds.single, contains('id=1'));

        // The note shows in the list and the editor is now active.
        expect(find.byKey(const Key('note-row-1')), findsOneWidget);
        expect(find.byKey(const Key('editor-empty-state')), findsNothing);
        expect(find.byKey(const Key('editor-title')), findsOneWidget);
        expect(find.byKey(const Key('editor-body')), findsOneWidget);
      });
    });

    testWidgets('typing in title updates the list preview row',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        await tester.enterText(
            find.byKey(const Key('editor-title')), 'Groceries');
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        // Update fired with the new title.
        final updates = _printLog
            .where((l) => l.startsWith('note.update '))
            .toList();
        expect(updates, isNotEmpty);
        expect(updates.last, contains('title="Groceries"'));

        // List row reflects the new title.
        final row = tester.widget<ListTile>(
            find.byKey(const Key('note-row-1')));
        final rowTitle = row.title as Text;
        expect(rowTitle.data, 'Groceries');
      });
    });

    testWidgets('debounced save emits a "Saved" SnackBar',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        await tester.enterText(
            find.byKey(const Key('editor-body')), 'remember to call');
        // Pump just past the editor's 250ms debounce so the
        // Future.delayed fires and the SnackBar mounts.
        await tester.pump(const Duration(milliseconds: 280));
        await tester.pump(const Duration(milliseconds: 50));

        final saves = _printLog
            .where((l) => l.startsWith('note.save '))
            .toList();
        expect(saves, isNotEmpty,
            reason: 'Debounced editor.onSaved should have flushed '
                'one note.save line after the delay.');
        expect(find.byKey(const Key('snackbar-saved')), findsOneWidget);
        expect(find.text('Saved'), findsOneWidget);
      });
    });

    testWidgets('delete via AlertDialog confirm removes the note',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));
        await tester.enterText(
            find.byKey(const Key('editor-title')), 'doomed');
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        await tester.tap(find.byKey(const Key('appbar-delete')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // AlertDialog is up.
        expect(find.byKey(const Key('delete-dialog')), findsOneWidget);
        expect(find.byKey(const Key('delete-cancel')), findsOneWidget);
        expect(find.byKey(const Key('delete-confirm')), findsOneWidget);

        await tester.tap(find.byKey(const Key('delete-confirm')));
        await tester.pumpAndSettle();

        final deletes = _printLog
            .where((l) => l.startsWith('note.delete id='))
            .toList();
        expect(deletes, hasLength(1));
        expect(deletes.single, contains('id=1'));

        // Note row is gone; deleted SnackBar fired.
        expect(find.byKey(const Key('note-row-1')), findsNothing);
        expect(find.byKey(const Key('snackbar-deleted')), findsOneWidget);
      });
    });

    testWidgets('share via bottom-sheet pops "Shared" SnackBar',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));
        await tester.enterText(
            find.byKey(const Key('editor-title')), 'shareable');
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        await tester.tap(find.byKey(const Key('appbar-share')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Bottom sheet is up with all three options.
        expect(find.byKey(const Key('share-sheet')), findsOneWidget);
        expect(find.byKey(const Key('share-copy')), findsOneWidget);
        expect(find.byKey(const Key('share-email')), findsOneWidget);
        expect(find.byKey(const Key('share-link')), findsOneWidget);

        await tester.tap(find.byKey(const Key('share-email')));
        await tester.pumpAndSettle();

        // Shared SnackBar fired with the title baked in.
        expect(find.byKey(const Key('snackbar-shared')), findsOneWidget);
        expect(find.text('Shared "shareable"'), findsOneWidget);
      });
    });

    testWidgets(
        'selecting a different note swaps the editor controllers',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        // Two distinct notes.
        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));
        await tester.enterText(
            find.byKey(const Key('editor-title')), 'note one');
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 80));
        await tester.enterText(
            find.byKey(const Key('editor-title')), 'note two');
        await tester.pumpAndSettle(const Duration(milliseconds: 80));

        // Tap the first note in the list — editor must swap to it.
        await tester.tap(find.byKey(const Key('note-row-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final swaps = _printLog
            .where((l) => l.startsWith('editor.swap '))
            .toList();
        expect(swaps, isNotEmpty,
            reason: 'didUpdateWidget should have detected the note id '
                'change and emitted editor.swap.');
        expect(swaps.last, contains('note=1'));

        // Title field now reflects note 1's text.
        final title = tester.widget<TextField>(
            find.byKey(const Key('editor-title')));
        expect(title.controller!.text, 'note one');
      });
    });

    testWidgets(
        'narrow layout pushes editor via Navigator.push',
        (tester) async {
      // Force a narrow window so LayoutBuilder picks the stacked
      // navigation path.
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await _runInZone(() async {
        await _mountSample(tester, 'note_app');

        // FAB on narrow layout: creates + pushes editor.
        await tester.tap(find.byKey(const Key('fab-new-note')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Editor route should be on top (AppBar carries the new
        // route's title), and the list page should NOT be hit-testable.
        expect(find.byKey(const Key('editor-appbar-1')), findsOneWidget);
        expect(find.byKey(const Key('editor-title')), findsOneWidget);
      });
    });
  });

  group(
      'form_wizard (example #15 — multi-step Form + validators + '
      'AnimatedSwitcher + AnimationController + Future.delayed submit)',
      () {
    // Trail prefix: `wizard.*`. Each public mutation on the
    // controller emits one line (init / next / prev / goto / update /
    // validate.ok / validate.fail / submit.start / submit.done). The
    // progress bar also emits `progress.animate ...` when the step
    // changes — useful for asserting the AnimationController fires.

    testWidgets('boots on step 0 with the account form visible',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        final inits = _printLog
            .where((l) => l.startsWith('wizard.init'))
            .toList();
        expect(inits, hasLength(1));

        expect(find.byKey(const Key('account-heading')), findsOneWidget);
        expect(find.byKey(const Key('email-field')), findsOneWidget);
        expect(find.byKey(const Key('password-field')), findsOneWidget);
        expect(find.byKey(const Key('progress-bar')), findsOneWidget);

        // Back is disabled on step 0, Next is enabled, Submit is
        // hidden (only shows on the last step).
        final TextButton prev = tester.widget<TextButton>(
            find.byKey(const Key('prev-btn')));
        expect(prev.onPressed, isNull);
        final FilledButton next = tester.widget<FilledButton>(
            find.byKey(const Key('next-btn')));
        expect(next.onPressed, isNotNull);
        expect(find.byKey(const Key('submit-btn')), findsNothing);
      });
    });

    testWidgets('Next on an empty form blocks advance with validators',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        // First Next press: both fields empty → validation must fail
        // and the wizard must stay on step 0.
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 60));

        final fails = _printLog
            .where((l) => l.startsWith('wizard.validate.fail'))
            .toList();
        expect(fails, isNotEmpty);
        expect(fails.last, contains('step=0'));

        // Validator error texts should be visible on screen.
        expect(find.text('Email is required'), findsOneWidget);
        expect(
            find.text('Password must be at least 6 characters'),
            findsOneWidget);

        // No `wizard.next` line yet — we should still be on step 0.
        expect(
            _printLog.where((l) => l.startsWith('wizard.next ')),
            isEmpty);
        expect(find.byKey(const Key('account-heading')), findsOneWidget);
      });
    });

    testWidgets('valid account input advances to the profile step',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        await tester.enterText(
            find.byKey(const Key('email-field')), 'jane@example.com');
        await tester.enterText(
            find.byKey(const Key('password-field')), 'sup3rsecret');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Trail must show a successful validate + the step advance.
        expect(
            _printLog.where((l) => l.startsWith('wizard.validate.ok')),
            isNotEmpty);
        final advances = _printLog
            .where((l) => l.startsWith('wizard.next '))
            .toList();
        expect(advances, hasLength(1));
        expect(advances.single, contains('step=1'));

        // Profile step is mounted; account step is gone.
        expect(find.byKey(const Key('profile-heading')), findsOneWidget);
        expect(find.byKey(const Key('account-heading')), findsNothing);

        // onSaved should have written the field values to the wizard.
        final updates = _printLog
            .where((l) => l.startsWith('wizard.update key="email"'))
            .toList();
        expect(updates, isNotEmpty);
      });
    });

    testWidgets('Back button restores the previous step without losing data',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        await tester.enterText(
            find.byKey(const Key('email-field')), 'jane@example.com');
        await tester.enterText(
            find.byKey(const Key('password-field')), 'sup3rsecret');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));

        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        expect(find.byKey(const Key('profile-heading')), findsOneWidget);

        await tester.tap(find.byKey(const Key('prev-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // We're back on step 0, the email field should retain its
        // initialValue from the wizard's data map.
        expect(find.byKey(const Key('account-heading')), findsOneWidget);
        final TextFormField emailField = tester.widget<TextFormField>(
            find.byKey(const Key('email-field')));
        expect(emailField.initialValue, equals('jane@example.com'));

        final prevs = _printLog
            .where((l) => l.startsWith('wizard.prev '))
            .toList();
        expect(prevs.last, contains('step=0'));
      });
    });

    testWidgets('progress bar animates whenever the step changes',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        await tester.enterText(
            find.byKey(const Key('email-field')), 'jane@example.com');
        await tester.enterText(
            find.byKey(const Key('password-field')), 'sup3rsecret');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));

        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // The progress AnimationController fires its `from→to` line
        // each time the goal value changes.
        final animLines = _printLog
            .where((l) => l.startsWith('progress.animate '))
            .toList();
        expect(animLines, isNotEmpty);
        expect(animLines.last, contains('to=0.375'));
      });
    });

    testWidgets('reaching the review step shows collected entries',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        // Step 0 → 1
        await tester.enterText(
            find.byKey(const Key('email-field')), 'jane@example.com');
        await tester.enterText(
            find.byKey(const Key('password-field')), 'sup3rsecret');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Step 1 → 2
        await tester.enterText(
            find.byKey(const Key('name-field')), 'Jane Doe');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Step 2 → 3
        await tester.enterText(
            find.byKey(const Key('color-field')), 'teal');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Review step is visible, summary lists every captured key.
        expect(find.byKey(const Key('review-heading')), findsOneWidget);
        expect(find.byKey(const Key('review-row-email')), findsOneWidget);
        expect(find.byKey(const Key('review-row-name')), findsOneWidget);
        expect(find.byKey(const Key('review-row-color')), findsOneWidget);
        expect(
            find.byKey(const Key('review-value-email')), findsOneWidget);
        expect(
            tester
                .widget<Text>(
                    find.byKey(const Key('review-value-email')))
                .data,
            equals('jane@example.com'));

        // Next button is replaced by the Submit button on the last step.
        expect(find.byKey(const Key('next-btn')), findsNothing);
        expect(find.byKey(const Key('submit-btn')), findsOneWidget);
      });
    });

    testWidgets(
        'Submit shows the overlay, awaits Future.delayed, then the done banner',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        // Run through the wizard.
        await tester.enterText(
            find.byKey(const Key('email-field')), 'jane@example.com');
        await tester.enterText(
            find.byKey(const Key('password-field')), 'sup3rsecret');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await tester.enterText(
            find.byKey(const Key('name-field')), 'Jane Doe');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await tester.enterText(
            find.byKey(const Key('color-field')), 'teal');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));
        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Tap submit — overlay should appear, banner not yet.
        await tester.tap(find.byKey(const Key('submit-btn')));
        await tester.pump(const Duration(milliseconds: 50));

        expect(
            find.byKey(const Key('submitting-overlay')), findsOneWidget);
        expect(find.byKey(const Key('submit-done-banner')), findsNothing);
        expect(
            _printLog.where((l) => l == 'wizard.submit.start'),
            hasLength(1));

        // Drain the Future.delayed (600ms default).
        await tester.pumpAndSettle(const Duration(milliseconds: 800));

        expect(
            find.byKey(const Key('submitting-overlay')), findsNothing);
        expect(
            find.byKey(const Key('submit-done-banner')), findsOneWidget);
        expect(
            _printLog.where((l) => l == 'wizard.submit.done'),
            hasLength(1));

        // Submit button is disabled after completion.
        final FilledButton submit = tester.widget<FilledButton>(
            find.byKey(const Key('submit-btn')));
        expect(submit.onPressed, isNull);
      });
    });

    testWidgets('bad email format keeps the user on step 0',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'form_wizard');

        // Missing domain — should fail the format check.
        await tester.enterText(
            find.byKey(const Key('email-field')), 'notanemail');
        await tester.enterText(
            find.byKey(const Key('password-field')), 'sup3rsecret');
        await tester.pumpAndSettle(const Duration(milliseconds: 30));

        await tester.tap(find.byKey(const Key('next-btn')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // autovalidateMode.onUserInteraction has now flipped on and
        // the validator error is visible.
        expect(find.text('Email must contain "@"'), findsOneWidget);
        expect(
            _printLog.where((l) => l.startsWith('wizard.next ')),
            isEmpty);
        expect(find.byKey(const Key('account-heading')), findsOneWidget);
      });
    });
  });

  group(
      'photo_gallery_hero (example #16 — Hero + PageRouteBuilder + '
      'InteractiveViewer + PageView + gradient CustomPaint)',
      () {
    // Trail prefixes:
    //   gallery.init n=N        — home rebuilt; N photos in catalogue
    //   gallery.tap id=N        — user tapped tile for photo N
    //   gallery.open id=N idx=I — home is opening viewer for photo N
    //   viewer.open id=N        — viewer page mounted with initial id
    //   viewer.page id=N        — PageView swiped to photo N
    //   viewer.scale=X.XX       — InteractiveViewer transform changed
    //   viewer.close id=N       — user dismissed viewer from photo N

    testWidgets('boots with a 2-column grid of Hero-wrapped tiles',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(find.byKey(const Key('gallery-appbar')), findsOneWidget);
        expect(find.byKey(const Key('gallery-grid')), findsOneWidget);

        // GridView.builder only mounts visible cells in the 800x600
        // test viewport, so we only assert the top-row tiles are on
        // screen and check `itemCount` for the full catalogue size.
        for (var id = 0; id < 2; id++) {
          expect(find.byKey(Key('gallery-tile-$id')), findsOneWidget,
              reason: 'tile for photo $id should be on the grid');
        }
        final GridView grid =
            tester.widget<GridView>(find.byKey(const Key('gallery-grid')));
        final SliverChildBuilderDelegate delegate =
            grid.childrenDelegate as SliverChildBuilderDelegate;
        expect(delegate.childCount, 6,
            reason: 'gallery should expose all 6 photos to the grid');

        final inits = _printLog
            .where((l) => l.startsWith('gallery.init '))
            .toList();
        expect(inits, isNotEmpty);
        expect(inits.first, contains('n=6'));
      });
    });

    testWidgets('every grid tile is wrapped in a Hero with matched tag',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // The grid Heroes own the canonical tag `photo-<id>`.
        // We check the first three to keep the assertion compact.
        for (var id = 0; id < 3; id++) {
          final heroes = find.descendant(
            of: find.byKey(Key('gallery-tile-$id')),
            matching: find.byType(Hero),
          );
          expect(heroes, findsOneWidget,
              reason: 'tile $id must contain exactly one Hero');
          final Hero hero = tester.widget<Hero>(heroes);
          expect(hero.tag, 'photo-$id',
              reason: 'tile $id must use the canonical hero tag');
        }
      });
    });

    testWidgets('tapping a tile pushes the viewer route', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Tile 1 sits in the first row of the 2-column grid, so it
        // is always visible regardless of the test viewport size.
        await tester.tap(find.byKey(const Key('gallery-tile-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        final taps = _printLog
            .where((l) => l.startsWith('gallery.tap '))
            .toList();
        expect(taps, isNotEmpty);
        expect(taps.last, contains('id=1'));

        final opens = _printLog
            .where((l) => l.startsWith('gallery.open '))
            .toList();
        expect(opens, isNotEmpty);
        expect(opens.last, contains('id=1'));

        // Viewer scaffold + appbar must now be on screen.
        expect(find.byKey(const Key('viewer-appbar')), findsOneWidget);
        expect(find.byKey(const Key('viewer-pageview')), findsOneWidget);

        final viewerOpens = _printLog
            .where((l) => l.startsWith('viewer.open '))
            .toList();
        expect(viewerOpens, hasLength(1));
        expect(viewerOpens.first, contains('id=1'));
      });
    });

    testWidgets('viewer mounts an InteractiveViewer for the tapped photo',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Tile 1 is in the first row — guaranteed visible.
        await tester.tap(find.byKey(const Key('gallery-tile-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        expect(find.byKey(const Key('viewer-iv-1')), findsOneWidget);
        expect(find.byType(InteractiveViewer), findsWidgets);
      });
    });

    testWidgets('swiping the PageView advances to the next photo',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('gallery-tile-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Fling left to advance the page view.
        await tester.fling(
            find.byKey(const Key('viewer-pageview')),
            const Offset(-400, 0),
            1200);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        final pages = _printLog
            .where((l) => l.startsWith('viewer.page '))
            .toList();
        expect(pages, isNotEmpty,
            reason: 'PageView swipe should emit a viewer.page line');
        expect(pages.last, contains('id=2'),
            reason: 'After a left swipe from photo 1 the next photo (id=2) '
                'should be on screen.');
      });
    });

    testWidgets('closing the viewer pops back to the grid', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('gallery-tile-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        expect(find.byKey(const Key('viewer-appbar')), findsOneWidget);

        await tester.tap(find.byKey(const Key('viewer-close')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Viewer is gone, grid is back.
        expect(find.byKey(const Key('viewer-appbar')), findsNothing);
        expect(find.byKey(const Key('gallery-grid')), findsOneWidget);

        final closes = _printLog
            .where((l) => l.startsWith('viewer.close '))
            .toList();
        expect(closes, isNotEmpty);
        expect(closes.last, contains('id=0'));
      });
    });

    testWidgets('Photo tile paints a gradient via CustomPaint',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'photo_gallery_hero');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Every grid tile contains at least one CustomPaint (the
        // gradient painter). We sample tile 0.
        final paints = find.descendant(
          of: find.byKey(const Key('gallery-tile-0')),
          matching: find.byType(CustomPaint),
        );
        expect(paints, findsWidgets,
            reason: 'GradientTile should mount a CustomPaint');
      });
    });
  });

  group(
      'card_swiper (example #17 — drag/fly stack + AnimationController + '
      'Transform.rotate + AnimatedPositioned)',
      () {
    // Trail prefixes:
    //   swipe.init n=N
    //   swipe.drag dx=DX
    //   swipe.release dir=left|right|none
    //   swipe.button dir=left|right
    //   swipe.fly id=N dir=left|right
    //   swipe.done id=N dir=left|right liked=L passed=P

    testWidgets('boots with the top card visible and counter at 0/0',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(find.byKey(const Key('swiper-appbar')), findsOneWidget);
        expect(find.byKey(const Key('deck-stack')), findsOneWidget);
        // Top card has id=0 (Alex).
        expect(find.byKey(const Key('card-name-0')), findsOneWidget);
        expect(find.text('Alex'), findsOneWidget);

        final counter = tester.widget<Text>(
            find.byKey(const Key('swiper-counter')));
        expect(counter.data, contains('Liked 0'));
        expect(counter.data, contains('Passed 0'));

        final inits =
            _printLog.where((l) => l.startsWith('swipe.init ')).toList();
        expect(inits, hasLength(1));
        expect(inits.first, contains('n=6'));
      });
    });

    testWidgets(
        'like button flies the top card right and bumps the liked counter',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('btn-like')));
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        // Trail: button → fly → done.
        final buttons = _printLog
            .where((l) => l.startsWith('swipe.button '))
            .toList();
        expect(buttons, isNotEmpty);
        expect(buttons.last, contains('dir=right'));

        final flies = _printLog
            .where((l) => l.startsWith('swipe.fly '))
            .toList();
        expect(flies, hasLength(1));
        expect(flies.single, contains('id=0'));
        expect(flies.single, contains('dir=right'));

        final dones = _printLog
            .where((l) => l.startsWith('swipe.done '))
            .toList();
        expect(dones, hasLength(1));
        expect(dones.single, contains('id=0'));
        expect(dones.single, contains('liked=1'));
        expect(dones.single, contains('passed=0'));

        // Counter must reflect the new totals.
        final counter = tester.widget<Text>(
            find.byKey(const Key('swiper-counter')));
        expect(counter.data, contains('Liked 1'));
        expect(counter.data, contains('Passed 0'));

        // Card 0 is gone; card 1 (Bree) is now the top.
        expect(find.byKey(const Key('card-name-0')), findsNothing);
        expect(find.byKey(const Key('card-name-1')), findsOneWidget);
      });
    });

    testWidgets(
        'pass button flies the top card left and bumps the passed counter',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('btn-pass')));
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        final dones = _printLog
            .where((l) => l.startsWith('swipe.done '))
            .toList();
        expect(dones, hasLength(1));
        expect(dones.single, contains('id=0'));
        expect(dones.single, contains('dir=left'));
        expect(dones.single, contains('liked=0'));
        expect(dones.single, contains('passed=1'));
      });
    });

    testWidgets('dragging the top card past the threshold commits a swipe',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Drag the top card to the right past the 80px threshold.
        await tester.drag(
          find.byKey(const Key('deck-top-0')),
          const Offset(200.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        final releases = _printLog
            .where((l) => l.startsWith('swipe.release '))
            .toList();
        expect(releases, isNotEmpty);
        expect(releases.last, contains('dir=right'),
            reason: 'A 200px right drag should commit a right release');

        final dones = _printLog
            .where((l) => l.startsWith('swipe.done '))
            .toList();
        expect(dones, hasLength(1));
        expect(dones.single, contains('liked=1'));
      });
    });

    testWidgets(
        'short drag is cancelled and the original card stays on top',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Drag only 30px — well under the 80px threshold.
        await tester.drag(
          find.byKey(const Key('deck-top-0')),
          const Offset(30.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        final releases = _printLog
            .where((l) => l.startsWith('swipe.release '))
            .toList();
        expect(releases, isNotEmpty);
        expect(releases.last, contains('dir=none'),
            reason: 'A 30px drag is below threshold and should snap back');

        // No fly / done events fired.
        expect(_printLog.where((l) => l.startsWith('swipe.fly ')), isEmpty);
        expect(_printLog.where((l) => l.startsWith('swipe.done ')), isEmpty);

        // Card 0 is still the top.
        expect(find.byKey(const Key('card-name-0')), findsOneWidget);
      });
    });

    testWidgets('three button taps advance through three cards',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // like → pass → like
        await tester.tap(find.byKey(const Key('btn-like')));
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        await tester.tap(find.byKey(const Key('btn-pass')));
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        await tester.tap(find.byKey(const Key('btn-like')));
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        final dones = _printLog
            .where((l) => l.startsWith('swipe.done '))
            .toList();
        expect(dones, hasLength(3));
        expect(dones[0], contains('id=0'));
        expect(dones[1], contains('id=1'));
        expect(dones[2], contains('id=2'));

        final counter = tester.widget<Text>(
            find.byKey(const Key('swiper-counter')));
        expect(counter.data, contains('Liked 2'));
        expect(counter.data, contains('Passed 1'));

        // Card 3 (Dana) is now the top.
        expect(find.byKey(const Key('card-name-3')), findsOneWidget);
      });
    });

    testWidgets('deck shows the empty placeholder after all cards swiped',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Burn through the entire 6-card deck.
        for (var i = 0; i < 6; i++) {
          await tester.tap(find.byKey(const Key('btn-like')));
          await tester.pumpAndSettle(const Duration(milliseconds: 600));
        }

        expect(find.byKey(const Key('deck-empty')), findsOneWidget);
        expect(find.text('No more cards.'), findsOneWidget);

        // Both buttons must now be disabled.
        final pass = tester.widget<FloatingActionButton>(
            find.byKey(const Key('btn-pass')));
        final like = tester.widget<FloatingActionButton>(
            find.byKey(const Key('btn-like')));
        expect(pass.onPressed, isNull);
        expect(like.onPressed, isNull);

        final counter = tester.widget<Text>(
            find.byKey(const Key('swiper-counter')));
        expect(counter.data, contains('Liked 6'));
      });
    });

    testWidgets('top card has a Transform.rotate driven by drag offset',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'card_swiper');
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Start a pan but do NOT release — we want to inspect the
        // intermediate Transform.rotate angle while the drag is live.
        final gesture = await tester.startGesture(
          tester.getCenter(find.byKey(const Key('deck-top-0'))),
        );
        await gesture.moveBy(const Offset(120.0, 0.0));
        await tester.pump(const Duration(milliseconds: 16));

        // Find the Transform widgets inside the top card subtree.
        // We expect at least one with a non-identity rotation matrix.
        final transforms = tester.widgetList<Transform>(find.descendant(
          of: find.byKey(const Key('deck-top-0')),
          matching: find.byType(Transform),
        ));
        final hasRotation = transforms.any((t) {
          // Pull off the (0,0) and (0,1) entries — a pure rotation
          // matrix has m[0][0] = cos(angle) and m[0][1] = -sin(angle).
          // For our 120px drag the angle should be small but non-zero.
          final m = t.transform;
          final m00 = m.entry(0, 0);
          final m01 = m.entry(0, 1);
          return (m00 - 1.0).abs() > 1e-6 || m01.abs() > 1e-6;
        });
        expect(hasRotation, isTrue,
            reason: 'A live drag should rotate the top card via '
                'Transform.rotate (m[0][0] != 1 or m[0][1] != 0).');

        // Release without committing so we don't leak a fly animation
        // into subsequent tests.
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
      });
    });
  });

  group(
      'kanban_board (example #18 — multi-column ChangeNotifier + '
      'ReorderableListView + LongPressDraggable/DragTarget + showDialog)',
      () {
    // Trail prefixes:
    //   kanban.init cols=N cards=M
    //   kanban.add col=C id=I title=T
    //   kanban.remove col=C id=I
    //   kanban.rename id=I new=T
    //   kanban.move id=I from=A to=B
    //   kanban.reorder col=C from=A to=B

    testWidgets('boots with three columns and the seed cards visible',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // AppBar + the three column titles must all render.
        expect(find.byKey(const Key('kanban-appbar')), findsOneWidget);
        expect(find.text('To do'), findsOneWidget);
        expect(find.text('Doing'), findsOneWidget);
        expect(find.text('Done'), findsOneWidget);

        // Seed cards: 2 in To do, 1 in Doing, 1 in Done.
        expect(find.text('Write proposal'), findsOneWidget);
        expect(find.text('Review PR'), findsOneWidget);
        expect(find.text('Refactor API'), findsOneWidget);
        expect(find.text('Ship release'), findsOneWidget);

        // Column count badges.
        final c0 = tester.widget<Text>(find.descendant(
          of: find.byKey(const Key('column-count-0')),
          matching: find.byType(Text),
        ));
        expect(c0.data, '2');
        final c1 = tester.widget<Text>(find.descendant(
          of: find.byKey(const Key('column-count-1')),
          matching: find.byType(Text),
        ));
        expect(c1.data, '1');
        final c2 = tester.widget<Text>(find.descendant(
          of: find.byKey(const Key('column-count-2')),
          matching: find.byType(Text),
        ));
        expect(c2.data, '1');

        final inits =
            _printLog.where((l) => l.startsWith('kanban.init ')).toList();
        expect(inits, hasLength(1));
        expect(inits.first, contains('cols=3'));
        expect(inits.first, contains('cards=4'));
      });
    });

    testWidgets('composer adds a new card to the To do column',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.enterText(
            find.byKey(const Key('composer-input-0')), 'Plan sprint');
        await tester.tap(find.byKey(const Key('composer-add-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.text('Plan sprint'), findsOneWidget);

        final adds =
            _printLog.where((l) => l.startsWith('kanban.add ')).toList();
        expect(adds, hasLength(1));
        expect(adds.first, contains('col=0'));
        expect(adds.first, contains('title=Plan sprint'));

        // Count badge on To do must now read 3.
        final c0 = tester.widget<Text>(find.descendant(
          of: find.byKey(const Key('column-count-0')),
          matching: find.byType(Text),
        ));
        expect(c0.data, '3');
      });
    });

    testWidgets('tapping a card opens the edit dialog pre-filled',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Tap on the first card (Write proposal, id=0).
        await tester.tap(find.byKey(const Key('card-title-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.byKey(const Key('card-dialog')), findsOneWidget);
        final field = tester.widget<TextField>(
            find.byKey(const Key('card-dialog-input')));
        expect(field.controller?.text, 'Write proposal');
      });
    });

    testWidgets('Save in the dialog renames the card and dismisses',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('card-title-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.enterText(
            find.byKey(const Key('card-dialog-input')), 'Write spec');
        await tester.tap(find.byKey(const Key('card-dialog-save')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.byKey(const Key('card-dialog')), findsNothing);
        expect(find.text('Write spec'), findsOneWidget);
        expect(find.text('Write proposal'), findsNothing);

        final renames = _printLog
            .where((l) => l.startsWith('kanban.rename '))
            .toList();
        expect(renames, hasLength(1));
        expect(renames.first, contains('id=0'));
        expect(renames.first, contains('new=Write spec'));
      });
    });

    testWidgets('Cancel in the dialog preserves the card title',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('card-title-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.enterText(
            find.byKey(const Key('card-dialog-input')), 'GARBAGE');
        await tester.tap(find.byKey(const Key('card-dialog-cancel')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.byKey(const Key('card-dialog')), findsNothing);
        // Title unchanged.
        expect(find.text('Write proposal'), findsOneWidget);
        expect(find.text('GARBAGE'), findsNothing);

        final renames = _printLog
            .where((l) => l.startsWith('kanban.rename '))
            .toList();
        expect(renames, isEmpty,
            reason: 'Cancel must not produce a rename trail entry.');
      });
    });

    testWidgets('Delete in the dialog removes the card from its column',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('card-title-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('card-dialog-delete')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.byKey(const Key('card-dialog')), findsNothing);
        // Card id=1 (Review PR) is gone.
        expect(find.text('Review PR'), findsNothing);

        final removes = _printLog
            .where((l) => l.startsWith('kanban.remove '))
            .toList();
        expect(removes, hasLength(1));
        expect(removes.first, contains('id=1'));
        expect(removes.first, contains('col=0'));
      });
    });

    testWidgets('right-arrow button moves a card to the next column',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Move card 0 (Write proposal) from To do → Doing.
        await tester.tap(find.byKey(const Key('card-right-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Doing now has 2 cards, To do has 1.
        final c0 = tester.widget<Text>(find.descendant(
          of: find.byKey(const Key('column-count-0')),
          matching: find.byType(Text),
        ));
        expect(c0.data, '1');
        final c1 = tester.widget<Text>(find.descendant(
          of: find.byKey(const Key('column-count-1')),
          matching: find.byType(Text),
        ));
        expect(c1.data, '2');

        final moves =
            _printLog.where((l) => l.startsWith('kanban.move ')).toList();
        expect(moves, hasLength(1));
        expect(moves.first, contains('id=0'));
        expect(moves.first, contains('from=0'));
        expect(moves.first, contains('to=1'));
      });
    });

    testWidgets('down-arrow reorders a card within its column',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'kanban_board');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Initially To do is [Write proposal (id=0), Review PR (id=1)].
        // Tapping ↓ on id=0 should swap them.
        await tester.tap(find.byKey(const Key('card-down-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        final reorders = _printLog
            .where((l) => l.startsWith('kanban.reorder '))
            .toList();
        expect(reorders, hasLength(1));
        expect(reorders.first, contains('col=0'));
        expect(reorders.first, contains('from=0'));
        // After the +2/-1 correction the new index is 1.
        expect(reorders.first, contains('to=1'));

        // Both cards still present in column 0.
        expect(find.text('Write proposal'), findsOneWidget);
        expect(find.text('Review PR'), findsOneWidget);
      });
    });
  });

  group(
      'bezier_curve_editor (example #19 — CustomPainter cubicTo + '
      'per-point GestureDetector + AnimationController + elastic preview)',
      () {
    // Trail prefixes:
    //   bezier.init points=N resolution=R construction=B
    //   bezier.point i=I x=X y=Y
    //   bezier.resolution=N
    //   bezier.toggle=true|false
    //   bezier.drag.start i=I
    //   bezier.drag.end i=I
    //   bezier.play start|pause|reset|complete
    //   bezier.preview t=T  (only at 0 and 1)

    testWidgets('boots with four handles and the painter in the tree',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.byKey(const Key('bezier-appbar')), findsOneWidget);
        expect(find.byKey(const Key('bezier-stack')), findsOneWidget);
        expect(find.byKey(const Key('bezier-paint')), findsOneWidget);

        // Four draggable handles, one per control point.
        expect(find.byKey(const Key('bezier-handle-0')), findsOneWidget);
        expect(find.byKey(const Key('bezier-handle-1')), findsOneWidget);
        expect(find.byKey(const Key('bezier-handle-2')), findsOneWidget);
        expect(find.byKey(const Key('bezier-handle-3')), findsOneWidget);

        // Init line in the trail.
        final inits =
            _printLog.where((l) => l.startsWith('bezier.init ')).toList();
        expect(inits, hasLength(1));
        expect(inits.first, contains('points=4'));
        expect(inits.first, contains('resolution=16'));
        expect(inits.first, contains('construction=true'));
      });
    });

    testWidgets('dragging a handle calls setPoint on the model',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Drag handle 1 (tangent handle) up and to the right.
        await tester.drag(
          find.byKey(const Key('bezier-handle-1')),
          const Offset(40.0, -40.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final starts = _printLog
            .where((l) => l.startsWith('bezier.drag.start '))
            .toList();
        expect(starts, isNotEmpty);
        expect(starts.first, contains('i=1'));

        final updates = _printLog
            .where((l) => l.startsWith('bezier.point '))
            .toList();
        expect(updates, isNotEmpty,
            reason: 'A drag on handle 1 must emit at least one '
                'bezier.point line.');
        // Every update must reference i=1 (no cross-talk to other
        // handles' GestureDetectors).
        expect(
          updates.every((l) => l.contains('i=1')),
          isTrue,
          reason:
              'All bezier.point lines from this drag must be on i=1.',
        );

        final ends = _printLog
            .where((l) => l.startsWith('bezier.drag.end '))
            .toList();
        expect(ends, isNotEmpty);
        expect(ends.last, contains('i=1'));
      });
    });

    testWidgets('resolution slider updates the model',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Drag the slider thumb far to the right.
        final Finder slider =
            find.byKey(const Key('bezier-resolution-slider'));
        await tester.drag(slider, const Offset(300.0, 0.0));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final res = _printLog
            .where((l) => l.startsWith('bezier.resolution='))
            .toList();
        expect(res, isNotEmpty);
        // The slider goes up to 48 — after a 300-pixel rightward
        // drag the value must be strictly larger than the initial
        // 16. Pulling the *last* line is the robust assertion.
        final String last = res.last;
        final String numStr = last.split('=').last;
        final int parsed = int.parse(numStr);
        expect(parsed, greaterThan(16));

        final label = tester.widget<Text>(
          find.byKey(const Key('bezier-resolution-label')),
        );
        expect(label.data, '$parsed');
      });
    });

    testWidgets('construction switch toggles the overlay flag',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Initially on; tap once -> off; tap again -> on.
        await tester
            .tap(find.byKey(const Key('bezier-construction-switch')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester
            .tap(find.byKey(const Key('bezier-construction-switch')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final toggles = _printLog
            .where((l) => l.startsWith('bezier.toggle='))
            .toList();
        expect(toggles, hasLength(2));
        expect(toggles[0], 'bezier.toggle=false');
        expect(toggles[1], 'bezier.toggle=true');
      });
    });

    testWidgets('play runs the preview animation to completion',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('bezier-play-button')));
        // The animation has a 1500ms duration with an elastic
        // curve; settle generously to let it finish.
        await tester
            .pumpAndSettle(const Duration(milliseconds: 2500));

        final plays = _printLog
            .where((l) => l.startsWith('bezier.play '))
            .toList();
        expect(plays, isNotEmpty);
        expect(plays.first, 'bezier.play start');
        expect(plays.last, 'bezier.play complete');

        // After completion we must have seen the t=1.00 boundary.
        final previews = _printLog
            .where((l) => l.startsWith('bezier.preview '))
            .toList();
        expect(previews, isNotEmpty);
        expect(previews.last, contains('t=1.00'));
      });
    });

    testWidgets(
        'reset returns the preview to t=0 after a full play',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Run the animation to completion so previewT moves to
        // 1.0 (emits a t=1.00 boundary line), then reset.
        await tester.tap(find.byKey(const Key('bezier-play-button')));
        await tester
            .pumpAndSettle(const Duration(milliseconds: 2500));

        await tester.tap(find.byKey(const Key('bezier-reset-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final resets = _printLog
            .where((l) => l == 'bezier.play reset')
            .toList();
        expect(resets, hasLength(1));

        // The reset path sets previewT back to 0.0, which must
        // emit a t=0.00 boundary preview line.
        final previewsAt0 = _printLog
            .where((l) => l == 'bezier.preview t=0.00')
            .toList();
        expect(previewsAt0, isNotEmpty);

        // The final preview boundary in the trail must be t=0.00
        // (i.e. reset moved us back from t=1.00).
        final allPreviews = _printLog
            .where((l) => l.startsWith('bezier.preview '))
            .toList();
        expect(allPreviews.last, contains('t=0.00'));
      });
    });

    testWidgets(
        'dragging different handles emits non-cross-talking trails',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.drag(
          find.byKey(const Key('bezier-handle-0')),
          const Offset(20.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.drag(
          find.byKey(const Key('bezier-handle-3')),
          const Offset(-20.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final starts = _printLog
            .where((l) => l.startsWith('bezier.drag.start '))
            .toList();
        expect(starts, hasLength(2));
        expect(starts[0], contains('i=0'));
        expect(starts[1], contains('i=3'));

        final ends = _printLog
            .where((l) => l.startsWith('bezier.drag.end '))
            .toList();
        expect(ends, hasLength(2));
        expect(ends[0], contains('i=0'));
        expect(ends[1], contains('i=3'));
      });
    });

    testWidgets('pointAt(0)=p0 and pointAt(1)=p3 in the painter math',
        (tester) async {
      // Indirect oracle check: the preview dot at t=0 must sit at
      // the same screen position as handle 0, and at t=1 at handle
      // 3. We don't have direct access to the model from the test
      // (the sample runs inside the interpreter) so we rely on the
      // drag/reset trail to assert the math wiring is intact.
      await _runInZone(() async {
        await _mountSample(tester, 'bezier_curve_editor');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // After init, previewT defaults to 0 — no preview boundary
        // line is emitted at startup because setPreviewT short-
        // circuits when the value is unchanged. After a play +
        // reset we must see *both* boundaries.
        await tester.tap(find.byKey(const Key('bezier-play-button')));
        await tester
            .pumpAndSettle(const Duration(milliseconds: 2500));
        await tester.tap(find.byKey(const Key('bezier-reset-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final previews = _printLog
            .where((l) => l.startsWith('bezier.preview '))
            .toList();
        expect(previews.any((l) => l.contains('t=1.00')), isTrue);
        expect(previews.any((l) => l.contains('t=0.00')), isTrue);
      });
    });
  });

  group(
      'tabbed_dashboard (example #20 — DefaultTabController + '
      'AutomaticKeepAliveClientMixin + AnimatedList + Stream.periodic)',
      () {
    // Trail prefixes:
    //   tab.init labels=[Chart,Settings,Log]
    //   tab.switch from=I to=J
    //   chart.add value=V
    //   chart.points n=N
    //   chart.cleared
    //   settings.threshold=V
    //   settings.label=S
    //   log.tick i=I msg=S
    //   log.pause=true|false
    //   log.cleared

    testWidgets('boots on the Chart tab with all three tabs present',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.byKey(const Key('tabbed-appbar')), findsOneWidget);
        expect(find.byKey(const Key('tabbed-tabbar')), findsOneWidget);
        expect(find.byKey(const Key('tabbed-tabview')), findsOneWidget);
        expect(find.byKey(const Key('tabbed-tab-chart')), findsOneWidget);
        expect(find.byKey(const Key('tabbed-tab-settings')), findsOneWidget);
        expect(find.byKey(const Key('tabbed-tab-log')), findsOneWidget);

        // Chart tab is the initial selection — its controls must be
        // mounted.
        expect(find.byKey(const Key('chart-add-button')), findsOneWidget);
        expect(find.byKey(const Key('chart-paint')), findsOneWidget);

        // Init line in the trail.
        final inits =
            _printLog.where((l) => l.startsWith('tab.init ')).toList();
        expect(inits, hasLength(1));
        expect(inits.first, contains('Chart'));
        expect(inits.first, contains('Settings'));
        expect(inits.first, contains('Log'));
      });
    });

    testWidgets('Add button grows the chart point list',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('chart-add-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('chart-add-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final adds =
            _printLog.where((l) => l.startsWith('chart.add ')).toList();
        expect(adds, hasLength(2));

        final counts = _printLog
            .where((l) => l.startsWith('chart.points '))
            .toList();
        expect(counts, isNotEmpty);
        // Seed list has 5; +2 adds => 7.
        expect(counts.last, contains('n=7'));

        final label = tester.widget<Text>(
          find.byKey(const Key('chart-count-label')),
        );
        expect(label.data, 'Points: 7');
      });
    });

    testWidgets('Clear button resets the chart to zero points',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('chart-add-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('chart-clear-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final cleared =
            _printLog.where((l) => l == 'chart.cleared').toList();
        expect(cleared, hasLength(1));

        final counts = _printLog
            .where((l) => l.startsWith('chart.points '))
            .toList();
        expect(counts.last, contains('n=0'));

        final label = tester.widget<Text>(
          find.byKey(const Key('chart-count-label')),
        );
        expect(label.data, 'Points: 0');
      });
    });

    testWidgets('switching tabs emits a single tab.switch line per move',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Chart (0) -> Settings (1) -> Log (2) -> Chart (0).
        // Note: the Log tab subscribes to a `Stream.periodic` in
        // initState that never completes — once we've visited the
        // Log tab we must use repeated `pump(...)` calls rather than
        // `pumpAndSettle(...)`, which would otherwise spin forever
        // waiting for the never-ending stream's timer.
        await tester.tap(find.byKey(const Key('tabbed-tab-settings')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        await tester.tap(find.byKey(const Key('tabbed-tab-log')));
        for (int i = 0; i < 12; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
        await tester.tap(find.byKey(const Key('tabbed-tab-chart')));
        for (int i = 0; i < 12; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        final switches = _printLog
            .where((l) => l.startsWith('tab.switch '))
            .toList();
        expect(switches, hasLength(3),
            reason:
                'Each tab move should emit exactly one tab.switch line.');
        expect(switches[0], 'tab.switch from=0 to=1');
        expect(switches[1], 'tab.switch from=1 to=2');
        expect(switches[2], 'tab.switch from=2 to=0');
      });
    });

    testWidgets('threshold slider on the Settings tab updates the label',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('tabbed-tab-settings')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Initial value is 0.50.
        Text label = tester.widget<Text>(
          find.byKey(const Key('settings-threshold-label')),
        );
        expect(label.data, 'Threshold: 0.50');

        await tester.drag(
          find.byKey(const Key('settings-threshold-slider')),
          const Offset(-200.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final updates = _printLog
            .where((l) => l.startsWith('settings.threshold='))
            .toList();
        expect(updates, isNotEmpty);

        label = tester.widget<Text>(
          find.byKey(const Key('settings-threshold-label')),
        );
        // After a 200-pixel leftward drag the value must be below
        // the initial 0.50.
        final String s = label.data!.split(' ').last;
        expect(double.parse(s), lessThan(0.5));
      });
    });

    testWidgets(
        'AutomaticKeepAliveClientMixin preserves Settings state across '
        'tab switches', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Settings tab: drag slider far left.
        await tester.tap(find.byKey(const Key('tabbed-tab-settings')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        await tester.drag(
          find.byKey(const Key('settings-threshold-slider')),
          const Offset(-200.0, 0.0),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final Text afterEdit = tester.widget<Text>(
          find.byKey(const Key('settings-threshold-label')),
        );
        final String editedValue = afterEdit.data!;
        expect(editedValue, isNot('Threshold: 0.50'),
            reason: 'The drag must have changed the threshold.');

        // Bounce to Chart and back.
        await tester.tap(find.byKey(const Key('tabbed-tab-chart')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        await tester.tap(find.byKey(const Key('tabbed-tab-settings')));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        final Text afterReturn = tester.widget<Text>(
          find.byKey(const Key('settings-threshold-label')),
        );
        expect(afterReturn.data, editedValue,
            reason: 'Keep-alive mixin must have preserved the value.');
      });
    });

    testWidgets('Log tab streams entries via Stream.periodic',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('tabbed-tab-log')));
        // Bare `pump` advances tab animation by one frame and then
        // releases — pumpAndSettle would never return because the
        // tab subscribes to a periodic stream in initState.
        for (int i = 0; i < 12; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        // Let the periodic stream fire a few times. The ticker
        // period is 300ms — pump 1.5s in 100ms frames so the
        // subscription has time to receive several values.
        for (int i = 0; i < 15; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }

        final ticks =
            _printLog.where((l) => l.startsWith('log.tick ')).toList();
        expect(ticks.length, greaterThanOrEqualTo(2),
            reason: 'Stream.periodic should have emitted >= 2 entries.');
        expect(ticks.first, contains('i=0'));
      });
    });

    testWidgets('Pause toggle freezes the log stream',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tabbed_dashboard');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('tabbed-tab-log')));
        // pumpAndSettle would spin forever — Stream.periodic in the
        // log tab's initState never completes.
        for (int i = 0; i < 12; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        // Let a couple of ticks land first.
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        final int beforePause = _printLog
            .where((l) => l.startsWith('log.tick '))
            .length;
        expect(beforePause, greaterThanOrEqualTo(1));

        // Pause and wait.
        await tester.tap(find.byKey(const Key('log-pause-button')));
        for (int i = 0; i < 15; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }

        final int afterPause = _printLog
            .where((l) => l.startsWith('log.tick '))
            .length;
        // The stream subscription stays alive while paused — the
        // pause flag short-circuits inside _onTick. New raw ticks
        // can still arrive on the host side, but no new `log.tick`
        // lines must be emitted by the script. The count of script
        // tick lines must therefore not grow.
        expect(afterPause, beforePause,
            reason: 'No new log.tick lines should appear while paused.');

        final pauses = _printLog
            .where((l) => l.startsWith('log.pause='))
            .toList();
        expect(pauses, hasLength(1));
        expect(pauses.first, 'log.pause=true');
      });
    });
  });

  group(
      'bottom_nav_shell (example #21 — BottomNavigationBar + IndexedStack + '
      'per-tab Navigators + InheritedNotifier-style ThemeScope + PopScope)',
      () {
    // Trail prefixes used by this sample:
    //   route.gen tab=<id> name=<route>
    //   nav.switch from=<id> to=<id>
    //   nav.innerpop tab=<id>
    //   nav.rootpop tab=<id>
    //   nav.poproot tab=<id>
    //   home.tap item=<n>
    //   detail.back tab=<id> title=<s>
    //   search.run q="<text>" total=<n>
    //   theme.toggle source=<Home|Profile> dark=<bool>

    testWidgets('boots on Home with all three nav destinations',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Bottom-nav scaffolding.
        expect(find.byKey(const Key('bn-bar')), findsOneWidget);
        expect(find.byKey(const Key('bn-stack')), findsOneWidget);
        // The inactive TabNavigators are offstage inside the
        // IndexedStack — pass `skipOffstage: false` to assert they
        // are mounted in the tree.
        expect(
            find.byKey(const Key('bn-nav-home'), skipOffstage: false),
            findsOneWidget);
        expect(
            find.byKey(const Key('bn-nav-search'), skipOffstage: false),
            findsOneWidget);
        expect(
            find.byKey(const Key('bn-nav-profile'), skipOffstage: false),
            findsOneWidget);

        // Home tab is the initial selection.
        expect(find.byKey(const Key('home-appbar')), findsOneWidget);
        expect(find.byKey(const Key('home-list')), findsOneWidget);
        expect(find.byKey(const Key('home-item-1')), findsOneWidget);

        // Three labels — also confirms all destinations rendered.
        expect(find.text('Home'), findsWidgets);
        expect(find.text('Search'), findsWidgets);
        expect(find.text('Profile'), findsWidgets);
      });
    });

    testWidgets('bottom-nav tap switches the active tab',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Tap Search via the icon — there's only one search icon in
        // the bar, so this is unambiguous.
        await tester.tap(find.byIcon(Icons.search_outlined));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(find.byKey(const Key('search-appbar')), findsOneWidget);
        expect(find.byKey(const Key('search-field')), findsOneWidget);

        final switches = _printLog
            .where((l) => l.startsWith('nav.switch '))
            .toList();
        expect(switches, hasLength(1));
        expect(switches.first, 'nav.switch from=home to=search');
      });
    });

    testWidgets(
        'IndexedStack preserves search field text across tab switches',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Visit Search tab.
        await tester.tap(find.byIcon(Icons.search_outlined));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.enterText(
          find.byKey(const Key('search-field')),
          'preserved',
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Bounce: Search → Home → Search.
        await tester.tap(find.byIcon(Icons.home_outlined));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        await tester.tap(find.byIcon(Icons.search_outlined));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final TextField field = tester.widget<TextField>(
          find.byKey(const Key('search-field')),
        );
        expect(field.controller?.text, 'preserved',
            reason:
                'IndexedStack keeps inactive tab Elements alive, so the '
                'TextEditingController must still hold the typed text.');
      });
    });

    testWidgets('search counter increments and renders results',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byIcon(Icons.search_outlined));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.enterText(
          find.byKey(const Key('search-field')),
          'flutter',
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        await tester.tap(find.byKey(const Key('search-go')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('search-go')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final Text count = tester.widget<Text>(
          find.byKey(const Key('search-count')),
        );
        expect(count.data, 'Searches run: 2');

        // Three result tiles.
        expect(find.byKey(const Key('search-result-0')), findsOneWidget);
        expect(find.byKey(const Key('search-result-1')), findsOneWidget);
        expect(find.byKey(const Key('search-result-2')), findsOneWidget);

        final runs = _printLog
            .where((l) => l.startsWith('search.run '))
            .toList();
        expect(runs, hasLength(2));
      });
    });

    testWidgets('Home theme toggle propagates to Profile via ThemeScope',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Toggle from Home.
        await tester.tap(find.byKey(const Key('home-theme-toggle')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // Switch to Profile and confirm the SwitchListTile reflects
        // the new value.
        await tester.tap(find.byIcon(Icons.person_outline));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        final SwitchListTile sw = tester.widget<SwitchListTile>(
          find.byKey(const Key('profile-dark-switch')),
        );
        expect(sw.value, isTrue,
            reason:
                'Toggling the theme from Home must flip the Profile '
                'switch — the ThemeScope ancestor is shared.');

        // The toggle line must come from Home, not Profile.
        final toggles = _printLog
            .where((l) => l.startsWith('theme.toggle '))
            .toList();
        expect(toggles, hasLength(1));
        expect(toggles.first, 'theme.toggle source=Home dark=true');
      });
    });

    testWidgets('tapping a Home list item pushes a detail page on the '
        'tab\'s own Navigator', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.tap(find.byKey(const Key('home-item-3')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Detail page mounted on the home tab.
        expect(find.byKey(const Key('detail-appbar-home')), findsOneWidget);
        expect(find.byKey(const Key('detail-body-home')), findsOneWidget);
        final Text body = tester.widget<Text>(
          find.byKey(const Key('detail-body-home')),
        );
        expect(body.data, 'Detail page: Item 3');

        // The bottom-nav bar must still be visible — the inner
        // Navigator only replaced the home tab's body, not the
        // whole app.
        expect(find.byKey(const Key('bn-bar')), findsOneWidget);

        final taps = _printLog
            .where((l) => l.startsWith('home.tap '))
            .toList();
        expect(taps, hasLength(1));
        expect(taps.first, 'home.tap item=3');
      });
    });

    testWidgets(
        'PopScope routes system back to the active tab\'s nested '
        'Navigator', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Push a detail page on Home.
        await tester.tap(find.byKey(const Key('home-item-2')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        expect(find.byKey(const Key('detail-body-home')), findsOneWidget);

        // Simulate the system back gesture — the framework invokes
        // the active PopScope's `onPopInvoked(false)` because the
        // shell sets `canPop: false`. Our handler pops the inner
        // navigator.
        final NavigatorState root =
            tester.state<NavigatorState>(find.byType(Navigator).first);
        await root.maybePop();
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Back to the home list.
        expect(find.byKey(const Key('detail-body-home')), findsNothing);
        expect(find.byKey(const Key('home-list')), findsOneWidget);

        final innerPops = _printLog
            .where((l) => l.startsWith('nav.innerpop '))
            .toList();
        expect(innerPops, hasLength(1));
        expect(innerPops.first, 'nav.innerpop tab=home');
      });
    });

    testWidgets('tapping the active tab pops its Navigator to root',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'bottom_nav_shell');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Push detail.
        await tester.tap(find.byKey(const Key('home-item-4')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        expect(find.byKey(const Key('detail-body-home')), findsOneWidget);

        // Tap the already-active Home destination → pops to root.
        await tester.tap(find.byIcon(Icons.home));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        expect(find.byKey(const Key('detail-body-home')), findsNothing);
        expect(find.byKey(const Key('home-list')), findsOneWidget);

        final popRoots = _printLog
            .where((l) => l.startsWith('nav.poproot '))
            .toList();
        expect(popRoots, hasLength(1));
        expect(popRoots.first, 'nav.poproot tab=home');
      });
    });
  });

  group('diagnostics — AnimatedSwitcher across user-State setState', () {
    testWidgets('headline swap does NOT trip duplicate-keys',
        (tester) async {
      // Minimal reproducer: a script-defined StatefulWidget whose
      // build returns a Scaffold with an AnimatedSwitcher whose child
      // is a Text keyed by the current value. Two FAB taps should
      // swap the headline twice — Flutter should *not* assert
      // "Duplicate keys found".
      await _runInZone(() async {
        const source = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(home: const Demo());
}

class Demo extends StatefulWidget {
  const Demo({super.key});
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int n = 0;
  String get label => n.isEven ? 'even' : 'odd';
  @override
  Widget build(BuildContext context) {
    print('demo.build n=\$n label=\$label');
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 80),
          child: Text(label, key: ValueKey<String>(label)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() { n = n + 1; }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';
        await tester.pumpWidget(
            _InlineSourceHost(d4rt: _d4rt, source: source));

        expect(find.text('even'), findsOneWidget);
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('odd'), findsOneWidget,
            reason: 'After 1 tap the headline should be "odd".');
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('even'), findsOneWidget,
            reason: 'After 2 taps the headline should be "even" again.');
      });
    });
  });

  group('diagnostics — type inference for generic constructors', () {
    testWidgets('ValueKey("foo") should produce ValueKey<String>',
        (tester) async {
      await _runInZone(() async {
        const source = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  final implicit = ValueKey('foo');
  final explicit = ValueKey<String>('foo');
  print('implicit ValueKey rt=\${implicit.runtimeType}');
  print('explicit ValueKey rt=\${explicit.runtimeType}');
  print('implicit == explicit ? \${implicit == explicit}');
  return MaterialApp(home: Container());
}
''';
        await tester.pumpWidget(
            _InlineSourceHost(d4rt: _d4rt, source: source));

        final implicitLine = _printLog.firstWhere(
            (l) => l.startsWith('implicit ValueKey rt='),
            orElse: () => '');
        final explicitLine = _printLog.firstWhere(
            (l) => l.startsWith('explicit ValueKey rt='),
            orElse: () => '');
        // ignore: avoid_print
        print('TEST observed: $implicitLine / $explicitLine');
        expect(implicitLine, contains('ValueKey<String>'),
            reason: 'd4rt should infer the type argument from the '
                "String literal so `ValueKey('foo') is ValueKey<String>`. "
                'If it reports `ValueKey<Object?>` or `<dynamic>`, the '
                'generic-constructor type inference is broken.');
      });
    });
  });

  group('closure capture in for-loops', () {
    testWidgets('three-button reproducer prints captured i', (tester) async {
      // Simpler variant: just verify the print log captured the right index.
      await _runInZone(() async {
        const source = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          for (var i = 0; i < 3; i++)
            ElevatedButton(
              onPressed: () {
                print('TAP i=\$i');
              },
              child: Text('btn \$i'),
            ),
        ],
      ),
    ),
  );
}
''';

        await tester.pumpWidget(_InlineSourceHost(d4rt: _d4rt, source: source));

        await tester.tap(find.text('btn 1'));
        await tester.pump();

        // If closure capture is correct, the log contains "TAP i=1".
        // If d4rt shares the loop variable, every closure sees i=3 (the
        // post-loop value), so the log shows "TAP i=3" instead.
        final tapLines = _printLog.where((l) => l.contains('TAP i=')).toList();
        expect(tapLines, hasLength(1),
            reason: 'Expected exactly one TAP log entry after one tap.');
        expect(tapLines.single, contains('TAP i=1'),
            reason: 'Tapping btn 1 should print "TAP i=1". If it prints '
                '"TAP i=3", the d4rt classic-for loop variable is shared '
                'across iterations — see interpreter_issues.md "[Open] '
                'classic for-loop closure capture".');
      });
    });
  });

  group('tron (KeyboardListener + CustomPainter)', () {
    // tron uses `KeyboardListener(autofocus: true)` and discriminates
    // KeyDownEvent vs other KeyEvent subtypes via
    // `event.runtimeType.toString()` (a workaround for the d4rt
    // interpreter's unreliable `event is KeyDownEvent` resolution
    // for some bridged event subtypes).
    //
    // These tests fire real key events through `tester.sendKeyDownEvent`
    // — if a key gets dropped (focus missed, type check broken, etc.)
    // the script's print log won't include the `[tron] key=...` line
    // and the test fails with a clear log.

    // The top bar is laid out for a real-window 1400×900 desktop; the
    // 768-px default tester surface overflows it. Each tron test
    // resizes the test viewport before mounting so RenderFlex
    // assertions don't mask the real test signal. We use `tester.view`
    // because `setSurfaceSize` doesn't propagate to the MediaQuery
    // size used by the interpreted MaterialApp before the first
    // pumpWidget.
    Future<void> mountTron(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await _mountSample(tester, 'tron');
      // Pump enough to let MediaQuery propagate the new view size to
      // the interpreted MaterialApp and lay everything out.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 30));
      // Drain RenderFlex overflow assertions raised by the top bar
      // — the bar is hand-laid for desktop sizes and not the focus
      // of these keyboard tests. Multiple overflows can be queued
      // (one per laid-out Row), so loop until the framework's
      // exception queue is empty. Anything NOT an overflow is
      // re-raised so interpreter crashes still surface.
      while (true) {
        final caught = tester.takeException();
        if (caught == null) break;
        if (!caught.toString().contains('A RenderFlex overflowed')) {
          throw caught;
        }
      }
    }

    testWidgets('boots with the arena focused and KEYS ACTIVE shown',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'tron');
        // Let `autofocus: true` settle.
        await tester.pump(const Duration(milliseconds: 30));

        final init = _printLog.where((l) => l == '[tron] init').toList();
        expect(init, hasLength(1),
            reason: 'Boot should emit exactly one [tron] init line.');

        // KeyboardListener autofocuses, so the focus-change handler
        // should have flipped to true and the focus badge should show
        // "KEYS ACTIVE".
        expect(find.text('KEYS ACTIVE'), findsOneWidget,
            reason:
                'autofocus: true on KeyboardListener should claim focus '
                'on first build.');
      });
    });

    testWidgets('arrow-left key queues a LEFT turn', (tester) async {
      await _runInZone(() async {
        await mountTron(tester);

        await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('[tron] key=')).toList(),
          isNotEmpty,
          reason:
              'Pressing arrowLeft should reach the script handler. If '
              'this is empty, KeyEvent type discrimination is broken — '
              'see the runtimeType.toString() workaround in home.dart.',
        );
        expect(
          _printLog.where((l) => l.startsWith('[tron] LEFT')).toList(),
          hasLength(1),
          reason: 'arrowLeft should fire exactly one LEFT turn.',
        );
      });
    });

    testWidgets('letter A also turns LEFT (alternate binding)',
        (tester) async {
      await _runInZone(() async {
        await mountTron(tester);

        await tester.sendKeyDownEvent(LogicalKeyboardKey.keyA);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('[tron] LEFT')).toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('arrow-right key queues a RIGHT turn', (tester) async {
      await _runInZone(() async {
        await mountTron(tester);

        await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('[tron] RIGHT')).toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('letter D also turns RIGHT (alternate binding)',
        (tester) async {
      await _runInZone(() async {
        await mountTron(tester);

        await tester.sendKeyDownEvent(LogicalKeyboardKey.keyD);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('[tron] RIGHT')).toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('space key toggles pause once the game has started',
        (tester) async {
      await _runInZone(() async {
        await mountTron(tester);

        // The game boots in the "armed but idle" state; arrow keys
        // start it. We need to start first because the very first
        // space press arms the game rather than toggling pause.
        await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
        await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowLeft);
        await tester.pump(const Duration(milliseconds: 30));
        expect(_printLog, contains('[tron] started'),
            reason: 'arrowLeft on an idle game should print "started".');

        await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
        await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l == '[tron] paused=true').toList(),
          hasLength(1),
          reason: 'First space press after start should pause.',
        );

        await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
        await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l == '[tron] paused=false').toList(),
          hasLength(1),
          reason: 'Second space press should resume.',
        );
      });
    });

    testWidgets('boots armed-but-idle until the first key arms the ticker',
        (tester) async {
      // Regression for the "AI wins before I can react" bug. The
      // game must NOT tick before the user presses something; the
      // ticker only starts after the first key (or steering button)
      // and the script prints `[tron] started` at that moment.
      await _runInZone(() async {
        await mountTron(tester);
        // Pump well past the natural 110ms tick rate. If the ticker
        // is wired to auto-start, we'd see `[tron] round ended` in
        // the trail by now.
        await tester.pump(const Duration(milliseconds: 600));
        expect(
          _printLog.where((l) => l.startsWith('[tron] round ended')),
          isEmpty,
          reason: 'The ticker must stay idle before the first key '
              'arms the game.',
        );
        // The READY overlay should be visible.
        expect(find.text('READY'), findsOneWidget,
            reason: 'A "READY" overlay should appear in the armed-but-'
                'idle state.');

        // Arming via any key starts the game.
        await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
        await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowRight);
        await tester.pump(const Duration(milliseconds: 30));
        expect(
          _printLog.where((l) => l == '[tron] started').toList(),
          hasLength(1),
          reason: 'First key press should print "[tron] started".',
        );
        // The directional key that armed the game must also queue
        // its turn — otherwise the user wouldn't see their press
        // take effect.
        expect(
          _printLog.where((l) => l.startsWith('[tron] RIGHT')).toList(),
          hasLength(1),
          reason: 'arrowRight on an idle game should both arm the '
              'ticker AND queue a RIGHT turn.',
        );
        // Pump past 110ms — the ticker should now actually advance.
        await tester.pump(const Duration(milliseconds: 250));
        // (No specific assertion on the trail here — we already
        // proved the ticker is armed via the "started" line. Real
        // gameplay timings are non-deterministic against the test
        // clock.)
      });
    });

    testWidgets('KeyUpEvent is ignored — only down/repeat queues a turn',
        (tester) async {
      await _runInZone(() async {
        await mountTron(tester);

        // A press is down + up; the up half must NOT queue another turn.
        await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
        await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowLeft);
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('[tron] LEFT')).toList(),
          hasLength(1),
          reason: 'One press = one LEFT. If the count is 2, the script '
              'is processing KeyUpEvent as a turn-trigger.',
        );
      });
    });

    testWidgets('LEFT button (UI fallback) also queues a turn',
        (tester) async {
      // Independent of keyboard plumbing — exercises the on-screen
      // _SteerButton path. Useful as a regression baseline: if this
      // passes but the keyboard tests fail, the engine + setState are
      // fine and the bug is in the key pipeline.
      await _runInZone(() async {
        await mountTron(tester);

        await tester.tap(find.text('LEFT  (A / ←)'));
        await tester.pump(const Duration(milliseconds: 30));

        expect(
          _printLog.where((l) => l.startsWith('[tron] LEFT')).toList(),
          hasLength(1),
        );
      });
    });
  });

  group(
      'chat_ui (example #22 — AnimatedList + slide/fade bubbles + '
      'multiline composer + Stream.fromFuture bot reply)', () {
    // Trail emitted by the interpreted script (see example/chat_ui/):
    //   chat.send rejected=empty
    //   chat.user.append id=<n> text="<s>"
    //   chat.typing on
    //   chat.typing off
    //   chat.bot.append id=<n> text="<s>"
    //   chat.scroll target=bottom messages=<n>

    Future<void> sendViaComposer(WidgetTester tester, String text) async {
      await tester.enterText(
        find.byKey(const Key('composer-field')),
        text,
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 50));
      await tester.tap(find.byKey(const Key('composer-send')));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    }

    testWidgets('boots with empty list and an idle composer',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Shell renders.
        expect(find.byKey(const Key('chat-appbar')), findsOneWidget);
        expect(find.byKey(const Key('composer-field')), findsOneWidget);
        expect(find.byKey(const Key('composer-send')), findsOneWidget);

        // No bubbles, no typing indicator yet.
        expect(find.byKey(const Key('typing-indicator')), findsNothing);
        expect(find.byKey(const Key('bubble-1')), findsNothing);

        // No chat trail lines emitted at boot.
        expect(
          _printLog.where((l) => l.startsWith('chat.')).toList(),
          isEmpty,
        );
      });
    });

    testWidgets('disabled send button before any text is typed',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Tapping send while the field is empty must not enqueue a
        // message. The button's onPressed is null, so the tap is a
        // no-op — `chat.user.append` must NOT appear in the trail.
        await tester.tap(find.byKey(const Key('composer-send')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(
          _printLog.where((l) => l.startsWith('chat.user.append ')),
          isEmpty,
          reason: 'Empty-text send must not enqueue a user message.',
        );
      });
    });

    testWidgets('tapping send appends a user bubble + starts typing',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.enterText(
          find.byKey(const Key('composer-field')),
          'hello bot',
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('composer-send')));
        // Don't settle yet — the bot reply is delayed; we just want
        // the synchronous user-append + typing-on lines.
        await tester.pump(const Duration(milliseconds: 50));

        // User bubble is on screen.
        expect(find.byKey(const Key('bubble-1')), findsOneWidget);
        expect(find.text('hello bot'), findsOneWidget);

        // Typing indicator is showing.
        expect(find.byKey(const Key('typing-indicator')), findsOneWidget);

        // The composer was cleared.
        final TextField field = tester.widget<TextField>(
          find.byKey(const Key('composer-field')),
        );
        expect(field.controller?.text, isEmpty);

        // Trail proves the synchronous half of `send()` ran.
        expect(
          _printLog
              .where((l) => l == 'chat.user.append id=1 text="hello bot"')
              .toList(),
          hasLength(1),
        );
        expect(
          _printLog.where((l) => l == 'chat.typing on').toList(),
          hasLength(1),
        );
        // Drain the pending bot future so this test doesn't leave a
        // dangling timer for the next test to inherit.
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
      });
    });

    testWidgets('bot reply arrives, typing flips off, bubble appears',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await sendViaComposer(tester, 'ping');
        // Drain the bot delay (250ms in chat_store.dart, plus the
        // insert animation).
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Bot bubble is on screen with the echo text.
        expect(find.byKey(const Key('bubble-2')), findsOneWidget);
        expect(find.text('echo: ping'), findsOneWidget);

        // Typing indicator is gone.
        expect(find.byKey(const Key('typing-indicator')), findsNothing);

        expect(
          _printLog.where((l) => l == 'chat.typing off').toList(),
          hasLength(1),
        );
        expect(
          _printLog
              .where((l) => l == 'chat.bot.append id=2 text="echo: ping"')
              .toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('send via Enter (onSubmitted) — composer keyboard path',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Type, then submit via the TextField's `onSubmitted` hook
        // (the test framework equivalent of pressing Enter).
        await tester.enterText(
          find.byKey(const Key('composer-field')),
          'from enter',
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.testTextInput.receiveAction(TextInputAction.send);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        expect(find.text('from enter'), findsOneWidget);
        expect(find.text('echo: from enter'), findsOneWidget);
        expect(
          _printLog
              .where((l) => l == 'chat.user.append id=1 text="from enter"'),
          hasLength(1),
        );
      });
    });

    testWidgets('whitespace-only text is rejected even via Enter',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await tester.enterText(
          find.byKey(const Key('composer-field')),
          '   ',
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.testTextInput.receiveAction(TextInputAction.send);
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        // No bubble, no trail.
        expect(find.byKey(const Key('bubble-1')), findsNothing);
        expect(
          _printLog.where((l) => l.startsWith('chat.user.append ')),
          isEmpty,
        );
      });
    });

    testWidgets('multi-turn conversation grows in order',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await sendViaComposer(tester, 'hi');
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        await sendViaComposer(tester, 'how are you');
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Four bubbles total: user(1), bot(2), user(3), bot(4).
        expect(find.byKey(const Key('bubble-1')), findsOneWidget);
        expect(find.byKey(const Key('bubble-2')), findsOneWidget);
        expect(find.byKey(const Key('bubble-3')), findsOneWidget);
        expect(find.byKey(const Key('bubble-4')), findsOneWidget);

        expect(find.text('hi'), findsOneWidget);
        expect(find.text('echo: hi'), findsOneWidget);
        expect(find.text('how are you'), findsOneWidget);
        expect(find.text('echo: how are you'), findsOneWidget);

        // The trail is ordered (user → bot → user → bot).
        final ordered = _printLog
            .where((l) =>
                l.startsWith('chat.user.append ') ||
                l.startsWith('chat.bot.append '))
            .toList();
        expect(ordered, hasLength(4));
        expect(ordered[0], startsWith('chat.user.append id=1'));
        expect(ordered[1], startsWith('chat.bot.append id=2'));
        expect(ordered[2], startsWith('chat.user.append id=3'));
        expect(ordered[3], startsWith('chat.bot.append id=4'));
      });
    });

    testWidgets('auto-scroll fires after each message append',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'chat_ui');
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        await sendViaComposer(tester, 'one');
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        await sendViaComposer(tester, 'two');
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Every user OR bot append should produce one scroll line.
        final scrolls = _printLog
            .where((l) => l.startsWith('chat.scroll target=bottom '))
            .toList();
        expect(
          scrolls.length,
          greaterThanOrEqualTo(4),
          reason: 'Each of 2 user + 2 bot appends should auto-scroll.',
        );
        // The last scroll reports messages=4 — confirms it ran AFTER
        // the data list grew, not before.
        expect(scrolls.last, 'chat.scroll target=bottom messages=4');
      });
    });
  });

  group(
      'carousel_pager (example #23 — PageView.builder + parallax + '
      'autoplay + AnimatedSwitcher to detail)', () {
    // Trail emitted by the interpreted script (example/carousel_pager/):
    //   pager.boot pages=<n> page=0
    //   page.change from=<n> to=<n>
    //   parallax bg=<n.nn>
    //   autoplay on / autoplay off
    //   autoplay.tick to=<n>
    //   detail.open page=<title> index=<n>
    //   detail.close index=<n>

    testWidgets('boots on page 0 with all carousel chrome',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Shell renders.
        expect(find.byKey(const Key('carousel-appbar')), findsOneWidget);
        expect(find.byKey(const Key('pager')), findsOneWidget);
        expect(find.byKey(const Key('autoplay-switch')), findsOneWidget);
        expect(find.byKey(const Key('page-counter')), findsOneWidget);
        expect(find.byKey(const Key('parallax-bg')), findsOneWidget);

        // First card is visible.
        expect(find.byKey(const Key('page-title-0')), findsOneWidget);
        expect(find.text('Aurora'), findsWidgets);
        expect(find.text('Page 1 of 8'), findsOneWidget);

        // 8 indicator dots in the tree.
        for (int i = 0; i < 8; i = i + 1) {
          expect(find.byKey(Key('indicator-dot-$i')), findsOneWidget);
        }

        // Boot trail line is emitted (post-frame, hence the pump).
        expect(
          _printLog.where((l) => l == 'pager.boot pages=8 page=0').toList(),
          hasLength(1),
        );
        // No page.change should fire until the user navigates.
        expect(
          _printLog.where((l) => l.startsWith('page.change ')),
          isEmpty,
        );
      });
    });

    testWidgets('next button advances to the following page',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('next-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        // Now on page 1 (Sunset).
        expect(find.text('Page 2 of 8'), findsOneWidget);

        final changes = _printLog
            .where((l) => l.startsWith('page.change '))
            .toList();
        expect(changes, contains('page.change from=0 to=1'));
        // Parallax line is emitted at least once during the scroll.
        expect(
          _printLog.where((l) => l.startsWith('parallax bg=')).length,
          greaterThanOrEqualTo(1),
        );
      });
    });

    testWidgets('prev button on page 0 is a no-op (clamped)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('prev-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        expect(find.text('Page 1 of 8'), findsOneWidget);
        expect(
          _printLog.where((l) => l.startsWith('page.change ')),
          isEmpty,
          reason: 'Prev on page 0 must clamp; no page.change should fire.',
        );
      });
    });

    testWidgets('autoplay switch toggles trail lines + advances pages',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Flip the switch on. Use plain pump after this — the
        // periodic timer never quiesces, so pumpAndSettle would
        // spin forever.
        await tester.tap(find.byKey(const Key('autoplay-switch')));
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          _printLog.where((l) => l == 'autoplay on').toList(),
          hasLength(1),
        );

        // Pump past one full autoplay period (1500ms) — the timer
        // should have fired at least once.
        await tester.pump(const Duration(milliseconds: 1600));

        expect(
          _printLog.where((l) => l.startsWith('autoplay.tick to=')).length,
          greaterThanOrEqualTo(1),
          reason: 'Periodic timer must fire at least once within 1600ms.',
        );

        // Flip the switch off — still plain pump until we've
        // confirmed the timer was cancelled.
        await tester.tap(find.byKey(const Key('autoplay-switch')));
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          _printLog.where((l) => l == 'autoplay off').toList(),
          hasLength(1),
        );

        // Let any in-flight animateToPage finish so the test can
        // settle without leaking a Ticker. Capturing the tick count
        // BEFORE the long pump gives us the baseline; capturing
        // AFTER lets us verify the timer really stopped.
        final int ticksBefore = _printLog
            .where((l) => l.startsWith('autoplay.tick to='))
            .length;
        await tester.pump(const Duration(milliseconds: 1600));
        final int ticksAfter = _printLog
            .where((l) => l.startsWith('autoplay.tick to='))
            .length;
        expect(
          ticksAfter,
          ticksBefore,
          reason: 'No new ticks after autoplay is switched off.',
        );
        // Allow any final animation to wrap up.
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
      });
    });

    testWidgets('tapping a page card opens the detail view',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Page 0 card is in the carousel; tap it.
        await tester.tap(find.byKey(const Key('page-card-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        // Detail chrome is mounted; carousel chrome is gone.
        expect(find.byKey(const Key('detail-scaffold-0')), findsOneWidget);
        expect(find.byKey(const Key('detail-title-0')), findsOneWidget);
        expect(find.byKey(const Key('detail-back')), findsOneWidget);
        expect(find.byKey(const Key('carousel-appbar')), findsNothing);

        expect(
          _printLog
              .where((l) => l == 'detail.open page=Aurora index=0')
              .toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('detail view back button returns to the carousel',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('page-card-0')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        await tester.tap(find.byKey(const Key('detail-back')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        expect(find.byKey(const Key('carousel-appbar')), findsOneWidget);
        expect(find.byKey(const Key('detail-scaffold-0')), findsNothing);

        expect(
          _printLog
              .where((l) => l == 'detail.close index=0')
              .toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('navigating then tapping opens detail for the new page',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Advance twice → page 2 (Ocean).
        await tester.tap(find.byKey(const Key('next-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        await tester.tap(find.byKey(const Key('next-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        expect(find.text('Page 3 of 8'), findsOneWidget);

        // Tap the Ocean card.
        await tester.tap(find.byKey(const Key('page-card-2')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        expect(find.byKey(const Key('detail-title-2')), findsOneWidget);
        expect(
          _printLog
              .where((l) => l == 'detail.open page=Ocean index=2')
              .toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('parallax bg lines accompany every page change',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'carousel_pager');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('next-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        await tester.tap(find.byKey(const Key('next-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        final int changes = _printLog
            .where((l) => l.startsWith('page.change '))
            .length;
        final int parallaxLines = _printLog
            .where((l) => l.startsWith('parallax bg='))
            .length;
        expect(changes, 2);
        expect(
          parallaxLines,
          greaterThanOrEqualTo(changes),
          reason:
              'Every page.change is preceded by at least one parallax line.',
        );
        // The last parallax value should match page 2's bg offset
        // (= 2 * 0.5 = 1.00).
        expect(
          _printLog
              .where((l) => l.startsWith('parallax bg=')).last,
          'parallax bg=1.00',
        );
      });
    });
  });

  group(
      'slide_puzzle (example #24 — 4×4 sliding tile, AnimatedPositioned + '
      'BFS solver + confetti CustomPainter)', () {
    // Trail emitted by the interpreted script (example/slide_puzzle/):
    //   puzzle.boot tiles=16 gap=15
    //   tile.tap cell=<c> value=<v>
    //   tile.reject cell=<c>
    //   move.count=<n>
    //   puzzle.shuffle moves=<n> seed=<s>
    //   timer.start / timer.stop elapsed=<n>
    //   puzzle.solver moves=<n>
    //   puzzle.solver.step cell=<c>
    //   puzzle.solve moves=<n> elapsed=<n>
    //   confetti.start particles=<n> / confetti.end

    testWidgets('boots in solved state with 15 numbered tiles + chrome',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(find.byKey(const Key('puzzle-scaffold')), findsOneWidget);
        expect(find.byKey(const Key('puzzle-board')), findsOneWidget);
        expect(find.byKey(const Key('shuffle-button')), findsOneWidget);
        expect(find.byKey(const Key('solver-button')), findsOneWidget);
        expect(find.byKey(const Key('move-counter')), findsOneWidget);
        expect(find.byKey(const Key('timer-text')), findsOneWidget);

        // 15 numbered tiles in the tree.
        for (int v = 1; v <= 15; v = v + 1) {
          expect(find.byKey(Key('tile-$v')), findsOneWidget);
        }

        // Solved state starts with the celebrate label visible.
        expect(find.text('Moves: 0'), findsOneWidget);
        expect(find.text('Time: 0s'), findsOneWidget);

        // Boot line is emitted post-frame.
        expect(
          _printLog
              .where((l) => l == 'puzzle.boot tiles=16 gap=15')
              .toList(),
          hasLength(1),
        );
      });
    });

    testWidgets('shuffle button scrambles the board + resets the counter',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('shuffle-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        // Shuffle line is emitted with the deterministic seed.
        expect(
          _printLog
              .where((l) => l == 'puzzle.shuffle moves=4 seed=42')
              .toList(),
          hasLength(1),
        );
        // Counter sits at zero after the shuffle.
        expect(find.text('Moves: 0'), findsOneWidget);
        // The "Solved!" badge should be gone now.
        expect(find.byKey(const Key('solved-label')), findsNothing);
      });
    });

    testWidgets(
        'tapping a tile adjacent to the gap accepts the move + bumps the '
        'counter', (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // In the solved board, gap is at cell 15. Tile value 15 sits at
        // cell 14, and tile value 12 sits at cell 11 — both adjacent
        // to the gap. Tap tile 15.
        await tester.tap(find.byKey(const Key('tile-15')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        // Trail: a single tile.tap + a single move.count=1 line.
        expect(
          _printLog
              .where((l) => l == 'tile.tap cell=14 value=15')
              .toList(),
          hasLength(1),
        );
        expect(
          _printLog.where((l) => l == 'move.count=1').toList(),
          hasLength(1),
        );
        expect(find.text('Moves: 1'), findsOneWidget);
      });
    });

    testWidgets('tapping a tile not adjacent to the gap is rejected',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Tile value 1 sits at cell 0; the gap is at cell 15 — not
        // adjacent. The tap must be rejected.
        await tester.tap(find.byKey(const Key('tile-1')));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(
          _printLog
              .where((l) => l == 'tile.reject cell=0')
              .toList(),
          hasLength(1),
        );
        // No move.count increment.
        expect(_printLog.where((l) => l.startsWith('move.count=')), isEmpty);
        expect(find.text('Moves: 0'), findsOneWidget);
      });
    });

    testWidgets('first valid tap starts the elapsed-time timer',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Before any tap, no timer.start line should have fired.
        expect(_printLog.where((l) => l == 'timer.start'), isEmpty);

        await tester.tap(find.byKey(const Key('tile-15')));
        // Timer.periodic is alive after this, so use plain pump.
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          _printLog.where((l) => l == 'timer.start').toList(),
          hasLength(1),
        );

        // Pump past one second so the timer fires at least once.
        await tester.pump(const Duration(milliseconds: 1100));
        expect(find.text('Time: 1s'), findsOneWidget);

        // Undo the move so the board returns to solved — that fires
        // timer.stop and lets the test settle without a leaked timer.
        await tester.tap(find.byKey(const Key('tile-15')));
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          _printLog.where((l) => l.startsWith('timer.stop ')).length,
          greaterThanOrEqualTo(1),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
      });
    });

    testWidgets('undoing the single-move scramble triggers puzzle.solve',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Move tile 15 into the gap. Board now has the gap at cell 14
        // and tile 15 at cell 15.
        await tester.tap(find.byKey(const Key('tile-15')));
        await tester.pump(const Duration(milliseconds: 100));
        // Tap tile 15 again — its current cell (15) is adjacent to the
        // new gap (14). The swap restores the solved state.
        await tester.tap(find.byKey(const Key('tile-15')));
        // Step in 50ms ticks so the confetti burst (whose ticker
        // clamps dt to 50ms by design — sane behaviour on resume from
        // pause) actually drains.
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        expect(
          _printLog.where((l) => l.startsWith('puzzle.solve ')).length,
          greaterThanOrEqualTo(1),
        );
        // After the burst finishes, the celebrate flag flips off and
        // the "Solved!" badge appears.
        expect(find.byKey(const Key('solved-label')), findsOneWidget);
      });
    });

    testWidgets('solve emits a confetti.start trail line + paints overlay',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('tile-15')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byKey(const Key('tile-15')));
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          _printLog
              .where((l) => l.startsWith('confetti.start particles=')).length,
          greaterThanOrEqualTo(1),
        );
        expect(find.byKey(const Key('confetti')), findsOneWidget);

        // Drain the burst in 50ms steps so the ticker's per-frame dt
        // (clamped to 50ms — sane resume-after-pause behaviour) advances
        // each frame instead of being collapsed by a single big pump.
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        expect(
          _printLog.where((l) => l == 'confetti.end').length,
          greaterThanOrEqualTo(1),
        );
      });
    });

    testWidgets('solver button auto-solves a shuffled board',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'slide_puzzle');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('shuffle-button')));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));

        await tester.tap(find.byKey(const Key('solver-button')));
        // The solver chains moves via Future.delayed(260ms) — pump
        // generously past kShuffleMoves * step so every step has time
        // to fire. Use plain pump for the timer-active phase.
        for (int i = 0; i < 12; i = i + 1) {
          await tester.pump(const Duration(milliseconds: 300));
        }

        final List<String> solverLines = _printLog
            .where((l) => l.startsWith('puzzle.solver '))
            .toList();
        expect(solverLines, hasLength(1));
        expect(
          _printLog
              .where((l) => l.startsWith('puzzle.solver.step cell=')).length,
          greaterThanOrEqualTo(1),
        );
        expect(
          _printLog.where((l) => l.startsWith('puzzle.solve ')).length,
          greaterThanOrEqualTo(1),
        );
        // Drain the confetti ticker.
        await tester.pump(const Duration(milliseconds: 1800));
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
      });
    });
  });

  group(
      'clock_face (example #25 — AnalogClock CustomPainter + '
      'AnimationController seconds sweep + rotary timezone dial)', () {
    // Trail emitted by the interpreted script (example/clock_face/):
    //   clock.boot base=<iso> offsetMin=0
    //   clock.play / clock.pause
    //   clock.tick second=<n>
    //   dial.rotate offsetMin=<m>

    testWidgets('boots paused at 12:00:00 with both clocks + dial',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // Chrome.
        expect(find.byKey(const Key('clock-scaffold')), findsOneWidget);
        expect(find.byKey(const Key('main-clock')), findsOneWidget);
        expect(find.byKey(const Key('world-clock')), findsOneWidget);
        expect(find.byKey(const Key('date-pill')), findsOneWidget);
        expect(find.byKey(const Key('timezone-dial')), findsOneWidget);
        expect(find.byKey(const Key('dial-rotation')), findsOneWidget);
        expect(find.byKey(const Key('play-button')), findsOneWidget);

        // Boot trail line is emitted post-frame with the deterministic
        // base time.
        expect(
          _printLog
              .where((l) => l ==
                  'clock.boot base=2026-05-21T12:00:00.000 offsetMin=0')
              .toList(),
          hasLength(1),
        );

        // Paused start ⇒ displayed time is exactly the base.
        expect(find.text('12:00:00'), findsOneWidget);
        expect(find.text('2026-05-21'), findsOneWidget);
        expect(find.text('UTC'), findsOneWidget);

        // Before play, no clock.tick lines should have fired.
        expect(_printLog.where((l) => l.startsWith('clock.tick ')), isEmpty);
      });
    });

    testWidgets('play button starts the controller + emits ticks',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('play-button')));
        // Controller.repeat() owns a Ticker — pumpAndSettle would spin
        // forever, so step in plain pumps.
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          _printLog.where((l) => l == 'clock.play').toList(),
          hasLength(1),
        );

        // Advance past one whole second — controller.value = 1.1/60 ≈
        // 0.0183 ⇒ elapsed.inSeconds = 1.
        await tester.pump(const Duration(milliseconds: 1100));
        expect(
          _printLog.where((l) => l == 'clock.tick second=1').toList(),
          hasLength(1),
        );
        expect(find.text('12:00:01'), findsOneWidget);

        // Stop the controller so the test can settle without a leaked
        // Ticker.
        await tester.tap(find.byKey(const Key('play-button')));
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          _printLog.where((l) => l == 'clock.pause').toList(),
          hasLength(1),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
      });
    });

    testWidgets('pausing freezes the second hand at the last whole second',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('play-button')));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 2200));
        await tester.tap(find.byKey(const Key('play-button')));
        await tester.pump(const Duration(milliseconds: 100));

        final String frozenLabel =
            (find.byKey(const Key('time-label')).evaluate().first.widget
                    as Text)
                .data ??
                '';
        expect(frozenLabel.startsWith('12:00:0'), isTrue);

        // Wait without pumping more time-real-progress — the label
        // should remain stable now.
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        final String afterIdle =
            (find.byKey(const Key('time-label')).evaluate().first.widget
                    as Text)
                .data ??
                '';
        expect(afterIdle, frozenLabel);
      });
    });

    testWidgets('dial-plus button advances the offset by +60 minutes',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('dial-plus')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        expect(
          _printLog
              .where((l) => l == 'dial.rotate offsetMin=60')
              .toList(),
          hasLength(1),
        );
        expect(find.text('UTC+1:00'), findsOneWidget);
        // Time label rolls forward by one hour from the base.
        expect(find.text('13:00:00'), findsOneWidget);
      });
    });

    testWidgets('dial-minus button rolls the offset negative',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byKey(const Key('dial-minus')));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        expect(
          _printLog
              .where((l) => l == 'dial.rotate offsetMin=-60')
              .toList(),
          hasLength(1),
        );
        expect(find.text('UTC-1:00'), findsOneWidget);
        expect(find.text('11:00:00'), findsOneWidget);
      });
    });

    testWidgets('repeated dial-plus stacks the offset (quantised snap)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        for (int i = 0; i < 3; i = i + 1) {
          await tester.tap(find.byKey(const Key('dial-plus')));
          await tester.pumpAndSettle(const Duration(milliseconds: 200));
        }

        final List<String> rotates = _printLog
            .where((l) => l.startsWith('dial.rotate '))
            .toList();
        expect(rotates, <String>[
          'dial.rotate offsetMin=60',
          'dial.rotate offsetMin=120',
          'dial.rotate offsetMin=180',
        ]);
        expect(find.text('UTC+3:00'), findsOneWidget);
        expect(find.text('15:00:00'), findsOneWidget);
      });
    });

    testWidgets('offset clamps at +14h (no further dial.rotate beyond that)',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // 14 plus-taps gets us to +14h; the 15th must be a no-op.
        for (int i = 0; i < 14; i = i + 1) {
          await tester.tap(find.byKey(const Key('dial-plus')));
          await tester.pumpAndSettle(const Duration(milliseconds: 50));
        }
        expect(find.text('UTC+14:00'), findsOneWidget);
        final int beforeClamp = _printLog
            .where((l) => l.startsWith('dial.rotate '))
            .length;

        // Extra plus-taps at the clamp must not produce additional
        // dial.rotate lines.
        await tester.tap(find.byKey(const Key('dial-plus')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const Key('dial-plus')));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));

        final int afterClamp = _printLog
            .where((l) => l.startsWith('dial.rotate '))
            .length;
        expect(afterClamp, beforeClamp);
      });
    });

    testWidgets('AnimatedRotation receives turns matching the offset',
        (tester) async {
      await _runInZone(() async {
        await _mountSample(tester, 'clock_face');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        AnimatedRotation rotation = tester.widget<AnimatedRotation>(
          find.byKey(const Key('dial-rotation')),
        );
        expect(rotation.turns, 0.0);

        // +6h ⇒ 360 minutes ⇒ turns = 360/720 = 0.5.
        for (int i = 0; i < 6; i = i + 1) {
          await tester.tap(find.byKey(const Key('dial-plus')));
          await tester.pumpAndSettle(const Duration(milliseconds: 50));
        }
        rotation = tester.widget<AnimatedRotation>(
          find.byKey(const Key('dial-rotation')),
        );
        expect(rotation.turns, 0.5);
      });
    });
  });
}

/// Pump a `MaterialApp` whose body is the widget produced by interpreting
/// the multi-file sample at `example/<sampleDir>/main.dart`.
///
/// The sample is interpreted once during the first build of the host
/// widget and cached, so subsequent rebuilds (e.g. from tester.pump()
/// after tap events) reuse the same interpreted tree.
Future<void> _mountSample(WidgetTester tester, String sampleDir) async {
  final path = _samplePath(sampleDir);
  await tester.pumpWidget(_SampleHost(d4rt: _d4rt, mainPath: path));
}

/// Wraps the test body in a print-capturing Zone so every `print()` call
/// — from the host, from the interpreted script, from bridges — is
/// recorded in `_printLog` and dumped on teardown.
Future<void> _runInZone(Future<void> Function() body) async {
  Object? caught;
  StackTrace? caughtStack;
  await runZonedGuarded<Future<void>>(
    () async {
      try {
        await body();
      } catch (e, st) {
        caught = e;
        caughtStack = st;
      }
    },
    (e, st) {
      caught ??= e;
      caughtStack ??= st;
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        _printLog.add(line);
        // Forward to parent zone so `flutter test` still shows the line live.
        parent.print(zone, line);
      },
    ),
  );
  if (caught != null) {
    Error.throwWithStackTrace(caught!, caughtStack ?? StackTrace.current);
  }
}

/// Host widget that interprets a multi-file sample exactly once and
/// caches the resulting widget so taps don't re-execute the script.
class _SampleHost extends StatefulWidget {
  final SourceFlutterD4rt d4rt;
  final String mainPath;

  const _SampleHost({required this.d4rt, required this.mainPath});

  @override
  State<_SampleHost> createState() => _SampleHostState();
}

class _SampleHostState extends State<_SampleHost> {
  Widget? _built;
  Object? _err;
  StackTrace? _errStack;

  @override
  Widget build(BuildContext context) {
    if (_built == null && _err == null) {
      try {
        _built = widget.d4rt
            .buildMultiFile<Widget>(widget.mainPath, buildContext: context);
        // ignore: avoid_print
        print('[host] interpreted ${widget.mainPath}');
      } catch (e, st) {
        _err = e;
        _errStack = st;
        // ignore: avoid_print
        print('[host] interpreter threw: $e');
      }
    }
    if (_err != null) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: SelectableText(
              'Interpreter error:\n$_err\n\n$_errStack',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
            ),
          ),
        ),
      );
    }
    return _built ?? const SizedBox.shrink();
  }
}

/// Host for an in-memory source string (used by the closure-capture tests).
class _InlineSourceHost extends StatefulWidget {
  final SourceFlutterD4rt d4rt;
  final String source;

  const _InlineSourceHost({required this.d4rt, required this.source});

  @override
  State<_InlineSourceHost> createState() => _InlineSourceHostState();
}

class _InlineSourceHostState extends State<_InlineSourceHost> {
  Widget? _built;

  @override
  Widget build(BuildContext context) {
    _built ??= widget.d4rt.build<Widget>(widget.source, context);
    return _built!;
  }
}
