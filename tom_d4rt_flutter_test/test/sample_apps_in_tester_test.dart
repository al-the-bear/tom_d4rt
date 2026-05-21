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
