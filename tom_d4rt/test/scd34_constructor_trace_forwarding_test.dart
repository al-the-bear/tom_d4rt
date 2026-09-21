// REPO-WIDE GUARD (tom_d4rt) — both trees forward the stack trace at all three bridged-constructor wrap sites.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
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

import 'sibling_trees.dart';

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

/// Wrap sites that exist in `tom_d4rt_ast` and have no analyzer-tree twin.
///
/// One: the `SPropertyAccess` clause handling member lookup through a prefixed
/// import. The analyzer tree reaches prefixed access through a different node
/// shape and has no such clause, so this is a genuine divergence rather than a
/// fix that half-landed. Named as a constant so F-SCD34-8 stays an equality
/// with a stated exception rather than becoming an inequality that would let
/// the next real divergence through.
const int _astOnlyWrapSites = 1;

/// Every `on RuntimeD4rtException catch` clause in [root]'s `lib/` that builds
/// a new `RuntimeD4rtException` without forwarding the payload it caught.
///
/// SCE70. [_wrapSites] above is keyed on `originalException:` being PRESENT —
/// it audits the SCC11 wrap sites, asking whether they also carry the trace.
/// This asks the opposite question, and by construction the other scan cannot:
/// a clause that RE-WRAPS a wrapper and builds the new one from `e.message`
/// alone has no `originalException:` in it, so it is invisible to a scan that
/// selects on that marker. Everything SCC11 preserved one frame below is
/// discarded there, which is why two of SCD34's three widenings were still
/// invisible to a script after being applied.
///
/// `rethrow` bodies are not findings: rethrowing preserves the payload by
/// construction, and is the other correct answer at these sites.
({List<String> findings, int examined}) _payloadDroppingRewraps(String root) {
  final clause = RegExp(r'on\s+RuntimeD4rtException\s+catch\s*\(\s*(\w+)');
  final found = <String>[];
  var examined = 0;
  final lib = Directory('$root/lib');
  for (final entity in lib.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final source = entity.readAsStringSync();
    for (final match in clause.allMatches(source)) {
      examined++;
      final open = source.indexOf('{', match.end);
      if (open < 0) continue;
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
      if (body.contains('rethrow')) continue;
      if (!body.contains('RuntimeD4rtException(')) continue;
      if (body.contains('originalException:')) continue;
      found.add(
        '${entity.path.substring(root.length + 1)}:'
        '${'\n'.allMatches(source.substring(0, match.start)).length + 1}',
      );
    }
  }
  return (findings: found..sort(), examined: examined);
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage('tom_d4rt', subject: 'both interpreter trees under lib/src');

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

      test('F-SCE70-1: no re-wrap discards the payload it caught '
          '[2026-09-21]', () {
        // The class F-SCD34-7 cannot see. A clause that re-wraps a wrapper and
        // builds the new one from `e.message` alone drops everything SCC11
        // preserved one frame below — and because it has no
        // `originalException:` in it, the scan above steps straight over it.
        //
        // Measured 2026-09-21 before the fix: 22 in tom_d4rt, 23 in
        // tom_d4rt_ast. The asymmetry is REAL and is not a half-landed fix:
        // the AST tree has an `SPropertyAccess` clause for prefixed-import
        // member lookup ("Undefined member '...' in prefixed import") that the
        // analyzer tree has no counterpart for, because the two front ends
        // reach prefixed access through different node shapes. Confirmed by
        // diffing the two site lists by MESSAGE rather than by line, since the
        // line numbers do not correspond.
        for (final root in [d4rtRoot, astRoot]) {
          expect(
            _payloadDroppingRewraps(root).findings,
            isEmpty,
            reason:
                'These clauses re-wrap a RuntimeD4rtException and construct '
                'the new one without carrying what the old one preserved. The '
                'script then sees the wrapper where it should see the native '
                'exception, and a trace that points at the interpreter. Add '
                '`originalException: e.originalException` and '
                '`originalStackTrace: e.originalStackTrace`, or `rethrow`.',
          );
        }
      });

      test('F-SCE70-2 (control): the re-wrap scan is looking at something '
          '[2026-09-21]', () {
        // F-SCE70-1 is an emptiness over a scan of two trees, so a scan that
        // matched nothing — a moved directory, a renamed exception type, a
        // broken pattern — satisfies it perfectly.
        //
        // IT ASSERTS THE SCAN'S OWN DENOMINATOR, and the first draft did not.
        // That draft counted clauses with a SECOND regex written beside the
        // first, so breaking the finding scan's pattern left the control
        // counting happily from its own copy: the ablation that should have
        // turned this red passed. A control that re-derives what it is
        // checking is not a control. `examined` is now returned by the scan
        // itself, so the two cannot disagree.
        for (final root in [d4rtRoot, astRoot]) {
          expect(
            _payloadDroppingRewraps(root).examined,
            greaterThan(20),
            reason:
                'The scan examined only '
                '${_payloadDroppingRewraps(root).examined} '
                '`on RuntimeD4rtException catch` clauses under $root/lib. That '
                'is a broken scan, not a clean tree.',
          );
        }
      });

      test('F-SCD34-8: the two twins carry the same number of wrap sites '
          '[2026-09-12]', () {
        // The mirror rule in prose form. A site threaded on one side only is
        // a half-landed fix, and nothing else in either suite would say so.
        //
        // SCE70 MADE THIS COUNT DIVERGE BY ONE, LEGITIMATELY, and the constant
        // is why the case is still a ratchet rather than a widened tolerance.
        // Threading the payload through every re-wrap gave `originalException:`
        // to 22 clauses here and 23 in the AST tree, because the AST tree has
        // an `SPropertyAccess` clause for prefixed-import member lookup
        // ("Undefined member '...' in prefixed import") that the analyzer tree
        // has no counterpart for at all — the two front ends reach prefixed
        // access through different node shapes. Established by diffing the two
        // site lists by MESSAGE, not by line, since the lines do not
        // correspond.
        //
        // Equalising the counts would have meant NOT fixing the AST-only site,
        // which is the wrong way round: the guard exists to catch a fix that
        // landed on one side, not to stop a site that exists on one side from
        // being fixed. Any OTHER divergence still fails.
        expect(
          _wrapSites(astRoot).length,
          _wrapSites(d4rtRoot).length + _astOnlyWrapSites,
          reason:
              'The AST tree should carry exactly $_astOnlyWrapSites wrap '
              'site(s) more than the analyzer tree — the prefixed-import '
              'lookup. Any other difference is a fix that landed on one side.',
        );
      });
    });
  });
}
