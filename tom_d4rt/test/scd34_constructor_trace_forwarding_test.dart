/// SCD34: the three bridged-*constructor* wrap sites must forward the trace.
///
/// SCC11 gave `RuntimeD4rtException` an `originalStackTrace` and threaded it
/// through the wrap sites, so an interpreted `catch (e, st)` receives the
/// trace of the *native throw* rather than of the interpreter's own `catch`
/// block. Three sites were left binding only `catch (e)` and so could forward
/// nothing — all three on the bridged-constructor paths:
///
/// | site | reached by |
/// | ---- | ---------- |
/// | `callable.dart`, bridged super constructor | `: super.named()` from an interpreted subclass |
/// | `callable.dart`, implicit bridged super constructor | an interpreted subclass with no explicit `super` call |
/// | `interpreter_visitor.dart`, `visitInstanceCreationExpression` | `new BridgedClass()` |
///
/// **These assertions are negative controls, not smoke tests.** A test that
/// merely asserts "a trace arrived" passes just as readily when the trace is
/// the wrap site's own — which is the entire defect. So each adapter throws
/// via `Error.throwWithStackTrace` carrying a `StackTrace.fromString`
/// **sentinel**. No trace the interpreter can manufacture contains that
/// sentinel, so the assertion passes only if the adapter's trace was carried
/// through the wrapper and handed to the script. All three were confirmed red
/// before the widening and green after it.
///
/// ## The `new` in F-SCD34-3 is load-bearing
///
/// Writing `Detonator()` without it does **not** reach the instance-creation
/// site. D4rt parses unresolved source, so a bare `Detonator()` arrives as a
/// `MethodInvocation` and is dispatched through the static/constructor lookup
/// in `visitMethodInvocation` — a site SCC11 had *already* fixed. The first
/// draft of this file used the bare form and went green before the widening,
/// against an entirely different code path. That is exactly the false green
/// the sentinel is meant to expose and it still slipped through, because the
/// sentinel only proves *a* forwarding site worked, not *which* one.
///
/// F-SCD34-7 is what actually pins the set: it reads both trees and asserts
/// that no wrap site anywhere in `lib/` preserves a native exception without
/// also preserving its trace. A behavioural test can drift onto a neighbouring
/// path; a census cannot.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _libUri = 'package:scd34/scd34.dart';

const _superSentinel = 'SCD34-SENTINEL-EXPLICIT-SUPER';
const _implicitSentinel = 'SCD34-SENTINEL-IMPLICIT-SUPER';
const _directSentinel = 'SCD34-SENTINEL-DIRECT';

/// `StackTrace.fromString` keeps the string verbatim, so a `contains` check on
/// the script's `st.toString()` is exact.
Never _throwWithSentinel(String sentinel) {
  Error.throwWithStackTrace(
    StateError('adapter refused ($sentinel)'),
    StackTrace.fromString('#0      $sentinel (package:scd34/native.dart:1:1)'),
  );
}

/// Bridged base whose constructors throw natively, each with its own sentinel
/// so the two super-call shapes cannot be confused for one another.
class Anchor {
  Anchor();
}

/// Bridged class constructed directly by script, for the third site.
class Detonator {
  Detonator();
}

D4rt _interpreter() {
  final interpreter = D4rt();

  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Anchor,
      name: 'Anchor',
      constructors: {
        // Reached by an interpreted subclass with no explicit `super` call.
        '': (visitor, positional, named) =>
            _throwWithSentinel(_implicitSentinel),
        // Reached by `: super.boom()`.
        'boom': (visitor, positional, named) =>
            _throwWithSentinel(_superSentinel),
      },
    ),
    _libUri,
    sourceUri: _libUri,
  );

  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Detonator,
      name: 'Detonator',
      constructors: {
        '': (visitor, positional, named) => _throwWithSentinel(_directSentinel),
      },
    ),
    _libUri,
    sourceUri: _libUri,
  );

  return interpreter;
}

/// Runs [body] under an interpreted `catch (e, st)` and returns the trace the
/// script was handed.
String _traceHandedToScript(String body) {
  final result = _interpreter().execute(
    source:
        '''
import '$_libUri';

$body
''',
  );
  return result as String;
}

/// Every `catch` clause in [root]'s `lib/` that preserves a native exception
/// via `originalException:`, paired with whether it also preserves the trace.
List<({String file, int line, bool forwardsTrace})> _wrapSites(String root) {
  final catchClause = RegExp(r'catch\s*\(\s*\w+\s*(?:,\s*\w+\s*)?\)\s*\{');
  final sites = <({String file, int line, bool forwardsTrace})>[];

  final lib = Directory('$root/lib');
  for (final entity in lib.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final source = entity.readAsStringSync();
    if (!source.contains('originalException:')) continue;

    for (final match in catchClause.allMatches(source)) {
      final open = source.indexOf('{', match.start);
      var depth = 0;
      var close = open;
      for (var i = open; i < source.length; i++) {
        if (source[i] == '{') depth++;
        if (source[i] == '}') {
          depth--;
          if (depth == 0) {
            close = i;
            break;
          }
        }
      }
      final body = source.substring(open, close);
      if (!body.contains('originalException:')) continue;
      sites.add((
        file: entity.path.substring(root.length + 1),
        line: '\n'.allMatches(source.substring(0, match.start)).length + 1,
        forwardsTrace: body.contains('originalStackTrace:'),
      ));
    }
  }
  sites.sort((a, b) {
    final byFile = a.file.compareTo(b.file);
    return byFile != 0 ? byFile : a.line.compareTo(b.line);
  });
  return sites;
}

void main() {
  group('SCD34: bridged-constructor wrap sites forward the native trace', () {
    test('F-SCD34-1: explicit `super.named()` hands the script the adapter '
        "trace, not the wrap site's [2026-09-12]", () {
      final trace = _traceHandedToScript('''
class Sub extends Anchor {
  Sub() : super.boom();
}

String main() {
  try {
    Sub();
    return 'no-throw';
  } catch (e, st) {
    return st.toString();
  }
}
''');

      expect(
        trace,
        contains(_superSentinel),
        reason:
            'The adapter threw with an explicit sentinel trace. Nothing the '
            'interpreter manufactures at the wrap site can contain it, so a '
            'trace without the sentinel means the wrapper dropped it.',
      );
    });

    test('F-SCD34-2: an implicit super call hands the script the adapter '
        "trace, not the wrap site's [2026-09-12]", () {
      final trace = _traceHandedToScript('''
class Sub extends Anchor {
  Sub();
}

String main() {
  try {
    Sub();
    return 'no-throw';
  } catch (e, st) {
    return st.toString();
  }
}
''');

      expect(trace, contains(_implicitSentinel));
    });

    test('F-SCD34-3: `new BridgedClass()` hands the script the adapter trace, '
        "not the wrap site's [2026-09-12]", () {
      // `new` is required to reach visitInstanceCreationExpression -- see the
      // library doc comment. Dropping it silently retargets this test at a
      // site that was already fixed.
      final trace = _traceHandedToScript('''
String main() {
  try {
    new Detonator();
    return 'no-throw';
  } catch (e, st) {
    return st.toString();
  }
}
''');

      expect(trace, contains(_directSentinel));
    });

    group('the census, which is what pins the set', () {
      // Resolved from this file rather than the CWD so the case survives being
      // run from the repo root or from the package.
      final d4rtRoot = Directory.current.path.endsWith('tom_d4rt')
          ? Directory.current.path
          : '${Directory.current.path}/tom_d4rt';
      final astRoot = Directory('$d4rtRoot/../tom_d4rt_ast').absolute.path;

      test('F-SCD34-7: no wrap site in either twin preserves a native '
          'exception without its trace [2026-09-12]', () {
        for (final root in [d4rtRoot, astRoot]) {
          final sites = _wrapSites(root);
          expect(
            sites,
            isNotEmpty,
            reason:
                'Scanning $root/lib found no wrap sites at all. The scan is '
                'broken, not the tree -- a vacuous pass here would retire the '
                'only instrument that covers every site.',
          );
          final dropped = sites.where((s) => !s.forwardsTrace);
          expect(
            dropped.map((s) => '${s.file}:${s.line}'),
            isEmpty,
            reason:
                'A `catch` clause that preserves the native exception so a '
                'script can match it by type must preserve the trace from the '
                'same clause, or `catch (e, st)` reports the interpreter '
                'instead of the script. Widen the binder to `catch (e, s)` '
                'and pass `originalStackTrace: s`.',
          );
        }
      });

      test('F-SCD34-8: the two twins carry the same number of wrap sites '
          '[2026-09-12]', () {
        // The mirror rule in prose form. A site threaded on one side only is
        // a half-landed fix, and nothing else in either suite would say so.
        expect(_wrapSites(astRoot).length, _wrapSites(d4rtRoot).length);
      });
    });
  });
}
