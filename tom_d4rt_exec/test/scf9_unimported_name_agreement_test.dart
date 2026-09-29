/// SCF9 — `execute(source:)` and `executeBundle*` agree about a bridged name
/// the script never imported.
///
/// Measured 2026-09-29 against the published tom_d4rt_ast 0.184.0, with one
/// bridged class `Probe` registered under `package:p/p.dart` and a script that
/// names it without importing it:
///
///     execute(source: 'main() => Probe.id();')  -> Undefined variable: Probe
///     executeBundleAs(<the same program>)       -> 'probe'
///
/// One interpreter, one registration, two answers, depending only on whether
/// the caller handed it source or a bundle. The source path is right — Dart
/// and the reference `tom_d4rt` both refuse the name. The bundle path reached
/// it through `D4rtRunner`'s warm parent, which bound every registered class
/// into a NAME baseline every script enclosed. SCF9 made that parent register
/// bridge types only, as `tom_d4rt`'s does.
///
/// exec resolves `tom_d4rt_ast` from pub.dev (DGUC6), so the bundle half can
/// only pass once a release carries the change. F-SCF9-2 skips until the
/// resolved version reaches [_fixedIn] and then asserts, without anybody
/// editing this file — the flip is the publish.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// The first `tom_d4rt_ast` release whose warm parent registers types only.
const _fixedIn = '0.187.0';

class _Probe {}

D4rt _runner() => D4rt()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _Probe,
      name: 'Probe',
      staticMethods: {'id': (visitor, positional, named, typeArgs) => 'probe'},
    ),
    'package:p/p.dart',
  );

/// `main() => Probe.id();`, optionally importing `package:p/p.dart`.
AstBundle _bundle({required bool imported}) {
  const entry = 'package:t/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          if (imported)
            SImportDirective(
              offset: 11,
              length: 1,
              uri: SSimpleStringLiteral(
                offset: 12,
                length: 1,
                value: 'package:p/p.dart',
              ),
            ),
        ],
        declarations: [
          SFunctionDeclaration(
            offset: 1,
            length: 1,
            name: SSimpleIdentifier(offset: 2, length: 4, name: 'main'),
            functionExpression: SFunctionExpression(
              offset: 3,
              length: 1,
              parameters: SFormalParameterList(offset: 4, length: 1),
              body: SExpressionFunctionBody(
                offset: 5,
                length: 1,
                expression: SMethodInvocation(
                  offset: 6,
                  length: 1,
                  target: SSimpleIdentifier(
                    offset: 7,
                    length: 5,
                    name: 'Probe',
                  ),
                  operator: '.',
                  methodName: SSimpleIdentifier(
                    offset: 8,
                    length: 2,
                    name: 'id',
                  ),
                  argumentList: SArgumentList(offset: 9, length: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

/// The `tom_d4rt_ast` version this package's lock resolves.
String _resolvedAst() {
  final lock = File('pubspec.lock').readAsStringSync();
  final m = RegExp(
    r'\n  tom_d4rt_ast:\n(?:    .*\n)*?    version: "([^"]+)"',
  ).firstMatch(lock);
  if (m == null) throw StateError('tom_d4rt_ast not found in pubspec.lock');
  return m.group(1)!;
}

bool _atLeast(String version, String floor) {
  List<int> core(String v) =>
      v.split(RegExp(r'[-+]')).first.split('.').map(int.parse).toList();
  final a = core(version), b = core(floor);
  for (var i = 0; i < 3; i++) {
    if (a[i] != b[i]) return a[i] > b[i];
  }
  return true;
}

final Matcher _undefinedProbe = predicate<Object>(
  (e) => '$e'.contains('Undefined') && '$e'.contains('Probe'),
  'an undefined-name error for Probe',
);

void main() {
  final resolved = _resolvedAst();
  final bundleSkip = _atLeast(resolved, _fixedIn)
      ? false
      : 'publish-blocked: exec resolves tom_d4rt_ast $resolved, whose warm '
            'parent still binds every registered name; flips at $_fixedIn '
            '(scf42 carries the release).';

  group('SCF9: an un-imported bridged name', () {
    test('F-SCF9-1: execute(source:) refuses it [2026-09-29] (PASS)', () {
      expect(
        () => _runner().execute(source: 'main() => Probe.id();'),
        throwsA(_undefinedProbe),
      );
    });

    test('F-SCF9-2: executeBundleAs agrees with execute(source:) and refuses '
        'it too [2026-09-29]', () {
      expect(
        () => _runner().executeBundleAs<Object?>(_bundle(imported: false)),
        throwsA(_undefinedProbe),
      );
    }, skip: bundleSkip);

    test('F-SCF9-3 (control): imported, both paths reach it '
        '[2026-09-29] (PASS)', () {
      expect(
        _runner().execute(
          source: "import 'package:p/p.dart';\nmain() => Probe.id();",
        ),
        'probe',
      );
      expect(
        _runner().executeBundleAs<Object?>(_bundle(imported: true)),
        'probe',
      );
    });
  });
}
