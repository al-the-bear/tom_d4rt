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
