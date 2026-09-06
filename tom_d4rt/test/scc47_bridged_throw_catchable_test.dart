/// SCC47: an exception thrown by a bridged member must be catchable by
/// interpreted `catch (e)`, exactly as it is in real Dart.
///
/// In Dart a bare `catch (e)` catches every thrown object without exception.
/// Interpreted code that guards a platform-dependent API with
/// `try { ... } catch (e) { ...fallback... }` therefore expects to survive a
/// native `UnsupportedError`. If the interpreter lets that native error escape
/// the interpreted `try`, the script dies mid-build and the guard it wrote is
/// simply not honoured.
///
/// Found while executing SCC47. `flutter_extended_23`'s
/// `retest/dart_ui/system_color_palette_test.dart` was carrying a skip labelled
/// "SystemColor not supported on desktop platforms (web-only API)" — framed as
/// a platform guard. The script does handle the platform reality itself:
///
/// ```dart
/// try {
///   light = ui.SystemColor.light;   // throws UnsupportedError off-web
///   dark  = ui.SystemColor.dark;
/// } catch (e) {
///   platformError = e.toString();   // ...and renders a fallback widget
/// }
/// ```
///
/// so on real Dart it renders the fallback and passes on every desktop host.
/// It failed only because the `UnsupportedError` escaped the interpreted
/// `catch (e)` and aborted interpretation (`status=error httpStatus=400`,
/// `appInterpretEndMs=-1`). The skip was therefore masking an interpreter
/// defect behind a platform-sounding justification.
///
/// The blast radius is much wider than one script: EVERY interpreted
/// `try`/`catch` around a bridged call depends on this. A script cannot
/// defend itself against any native failure — I/O, platform channels,
/// range errors, unsupported operations — if the interpreter will not deliver
/// the exception to its handler.
///
/// Twin of `tom_d4rt_exec/test/scc47_bridged_throw_catchable_test.dart`. The
/// AST-line twin lives in `tom_d4rt_exec`, not `tom_d4rt_ast`, because
/// `tom_d4rt_ast` is analyzer-free and so cannot parse the interpreted source
/// these assertions need. Exec runs the `tom_d4rt_ast` interpreter, which is
/// the line the Flutter corpus executes — so that copy is the one that speaks
/// to the system_color_palette finding.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Stands in for `dart:ui`'s `SystemColor`, whose `.light` / `.dark` static
/// getters throw `UnsupportedError` on every non-web platform.
class SystemColor {
  SystemColor._();
}

/// Stands in for a bridged instance whose getter fails at runtime.
class Palette {
  Palette();
}

const _libUri = 'package:scc47/scc47.dart';

D4rt _interpreterWithThrowingBridges() {
  final interpreter = D4rt();

  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: SystemColor,
      name: 'SystemColor',
      staticGetters: {
        'light': (visitor) => throw UnsupportedError(
          'SystemColor not supported on the current '
          'platform.',
        ),
      },
      staticMethods: {
        'probe': (visitor, positional, named, typeArgs) =>
            throw UnsupportedError('probe is unsupported'),
      },
    ),
    _libUri,
    sourceUri: _libUri,
  );

  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Palette,
      name: 'Palette',
      constructors: {'': (visitor, positional, named) => Palette()},
      getters: {
        'canvas': (visitor, target) =>
            throw UnsupportedError('canvas is unsupported'),
      },
      methods: {
        'resolve': (visitor, target, positional, named, typeArgs) =>
            throw UnsupportedError('resolve is unsupported'),
      },
    ),
    _libUri,
    sourceUri: _libUri,
  );

  return interpreter;
}

/// Runs [body] inside an interpreted `try`/`catch (e)` and reports which arm
/// was taken. Returns `'caught:<message>'` when the handler ran, or
/// `'no-throw'` when the expression unexpectedly succeeded. If the exception
/// escapes the interpreted `try`, `execute` throws and the test fails — which
/// is precisely the defect under test.
String _runGuarded(D4rt interpreter, String body) {
  final result = interpreter.execute(
    source:
        '''
import '$_libUri';

String main() {
  try {
    $body
    return 'no-throw';
  } catch (e) {
    return 'caught:\$e';
  }
}
''',
  );
  return result as String;
}

void main() {
  group('SCC47: exceptions from bridged members reach interpreted catch', () {
    test('F-SCC47-1: a bridged STATIC GETTER that throws is caught by '
        '`catch (e)` — the system_color_palette case', () {
      final outcome = _runGuarded(
        _interpreterWithThrowingBridges(),
        'final v = SystemColor.light;',
      );

      expect(
        outcome,
        startsWith('caught:'),
        reason:
            'A bare `catch (e)` catches everything in Dart. Letting the '
            'native UnsupportedError escape the interpreted try means no '
            'script can guard a platform-dependent bridged API.',
      );
      expect(outcome, contains('SystemColor not supported'));
    });

    test(
      'F-SCC47-2: a bridged STATIC METHOD that throws is caught by `catch (e)`',
      () {
        final outcome = _runGuarded(
          _interpreterWithThrowingBridges(),
          'final v = SystemColor.probe();',
        );

        expect(outcome, startsWith('caught:'));
        expect(outcome, contains('probe is unsupported'));
      },
    );

    test('F-SCC47-3: a bridged INSTANCE GETTER that throws is caught by '
        '`catch (e)`', () {
      final outcome = _runGuarded(
        _interpreterWithThrowingBridges(),
        'final v = Palette().canvas;',
      );

      expect(outcome, startsWith('caught:'));
      expect(outcome, contains('canvas is unsupported'));
    });

    test('F-SCC47-4: a bridged INSTANCE METHOD that throws is caught by '
        '`catch (e)`', () {
      final outcome = _runGuarded(
        _interpreterWithThrowingBridges(),
        'final v = Palette().resolve();',
      );

      expect(outcome, startsWith('caught:'));
      expect(outcome, contains('resolve is unsupported'));
    });

    test(
      'F-SCC47-5: the same exception is also catchable by its declared TYPE, '
      'not merely by a bare `catch (e)`',
      () {
        final interpreter = _interpreterWithThrowingBridges();
        final result = interpreter.execute(
          source:
              '''
import '$_libUri';

String main() {
  try {
    final v = SystemColor.light;
    return 'no-throw';
  } on UnsupportedError catch (e) {
    return 'typed:\$e';
  } catch (e) {
    return 'untyped:\$e';
  }
}
''',
        );

        expect(
          result,
          startsWith('typed:'),
          reason:
              'The native UnsupportedError must keep its identity, so an '
              '`on UnsupportedError` clause selects it.',
        );
      },
    );
  });
}
