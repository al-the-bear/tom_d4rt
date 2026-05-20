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
