@Timeout(Duration(minutes: 2))
library;

// The five permission gates reach the permission table through a NULLABLE
// handle and return when it is absent:
//
//     final d4rt = visitor.moduleLoader.d4rt;
//     if (d4rt == null) return;            // no D4rt, no check
//
// An early return from a gate GRANTS, and it grants in the four capabilities
// the sandbox exists for — `Platform`, process spawning, sockets, filesystem
// paths — plus certificate installation. Read on its own that is a sandbox
// failing open, and the analyzer-free twin, which has no nullable handle and
// always calls `checkPermission`, reads as the corrected version.
//
// IT IS NEITHER, AND THE MEASUREMENTS ARE WHY.
//
// (1) THE BRANCH IS UNREACHABLE FROM A SCRIPT. `d4rt_base.dart` constructs
//     exactly one `ModuleLoader`, passing `d4rt: this`, and all three
//     `_moduleLoader` assignments go through it. F-SCE87-3 asserts that
//     structurally, because everything else here depends on it: the only
//     `lib/` code that builds a d4rt-less loader is the bridged-enum
//     `toString` fallback, which calls a `toString` adapter inside a
//     `try/catch` and reaches no gate.
//
// (2) THE GATE IS LIVE ON THE PATH A SCRIPT TAKES. F-SCE87-1 grants
//     `FilesystemPermission` — needed for `dart:io` to import at all — and
//     withholds `DangerousPermission`, and `Platform.version` is refused.
//
// (3) THE TWIN IS PERMISSIVE IN THE SAME STATE. `NoOpModuleContext
//     .checkPermission` returns `true` when no checker is wired, under the
//     comment "be permissive (allow all)". So both trees grant when nothing
//     sandboxed them; they differ in WHERE that is expressed — the reference
//     in each gate, the twin in its module context. The twin's half of this
//     is pinned in `tom_d4rt_ast`'s own case of the same name.
//
// So this is the UN-SANDBOXED MODE, not an oversight, and denying here would
// make the reference refuse where the twin allows — introducing the
// behavioural divergence rather than removing it, and breaking the documented
// mode in which a bridge is driven directly.
//
// WHAT WOULD MAKE IT A HOLE is (1) ceasing to hold: a d4rt-less loader on a
// path that runs a script. That is what F-SCE87-3 is for, and it is the case
// to read first if this file ever goes red.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/stdlib/io/certificate_permission_helper.dart';
import 'package:tom_d4rt/src/stdlib/io/filesystem_permission_helper.dart';
import 'package:tom_d4rt/src/stdlib/io/network_permission_helper.dart';
import 'package:tom_d4rt/src/stdlib/io/platform.dart';

import '../../sibling_trees.dart';

Future<Object?> _run(String body, void Function(D4rt) grant) {
  const path = 'd4rt-mem:/sce87_permission_gate.dart';
  final d4rt = D4rt();
  grant(d4rt);
  return d4rt.execute(
    library: path,
    name: 'main',
    sources: {
      path: "import 'dart:io';\nFuture<Object?> main() async {\n$body\n}\n",
    },
  );
}

/// A visitor in the state the gates guard against: no `D4rt` behind it.
InterpreterVisitor _visitorWithoutD4rt() {
  final env = Environment();
  return InterpreterVisitor(
    globalEnvironment: env,
    moduleLoader: ModuleLoader(env, {}, {}, {}),
  );
}

void main() {
  // SCD158: F-SCE87-3 resolves `lib/src` relative to the package it runs in.
  requirePackage('tom_d4rt', subject: 'this package\'s own lib/src tree');

  group('SCE87: the permission gates and the null interpreter handle', () {
    test('F-SCE87-1: a script is refused, so the gate is live on the path a '
        'script takes [2026-09-21] (PASS)', () {
      // `FilesystemPermission` is granted because `dart:io` will not import
      // without it — an ungranted script never reaches an adapter at all,
      // which is itself worth knowing: the import is the outer gate.
      expect(
        _run(
          'return Platform.version;',
          (d) => d.grant(FilesystemPermission.any),
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains('DangerousPermission'),
          ),
        ),
      );
    });

    test('F-SCE87-2: the same script passes once the permission is granted '
        '[2026-09-21] (PASS)', () {
      // The control for F-SCE87-1. Without it, a case asserting a throw
      // passes just as well against a gate that refuses everything, which
      // would hide the opposite defect.
      expect(
        _run('return Platform.version;', (d) {
          d.grant(FilesystemPermission.any);
          d.grant(DangerousPermission.any);
        }),
        completion(isA<String>()),
      );
    });

    test('F-SCE87-3: no script path can build a loader without a D4rt '
        '[2026-09-21] (PASS)', () {
      // THE LOAD-BEARING ONE. Every other case here, and the comment at each
      // of the five gates, rests on "a script's visitor always carries a
      // D4rt". That holds because `d4rt_base.dart` has ONE `ModuleLoader`
      // construction and it passes `d4rt: this`. A second one, or that
      // argument going away, turns the early return from an un-sandboxed mode
      // into a live hole — silently, because every existing test would stay
      // green.
      final d4rtBase = File('lib/src/d4rt_base.dart').readAsStringSync();
      final constructions = 'ModuleLoader('.allMatches(d4rtBase).length;
      expect(
        constructions,
        1,
        reason:
            'd4rt_base.dart builds $constructions module loaders. Each one '
            'that omits `d4rt:` gives a script a visitor whose permission '
            'gates return without checking.',
      );
      expect(
        d4rtBase.substring(d4rtBase.indexOf('ModuleLoader(')),
        contains('d4rt: this'),
        reason: 'the one loader a script runs on must carry the D4rt',
      );

      // And the only d4rt-less loaders in lib/ are the bridged-enum toString
      // fallbacks, which reach no gate. Named rather than counted, so adding
      // one anywhere else fails here with its own path.
      final offenders = <String>[];
      for (final f
          in Directory('lib/src')
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.dart'))) {
        final source = f.readAsStringSync();
        if (!source.contains('ModuleLoader(')) continue;
        if (f.path.endsWith('d4rt_base.dart')) continue;
        if (f.path.endsWith('module_loader.dart')) continue; // the declaration
        if (f.path.endsWith('bridge/bridged_enum.dart')) continue;
        offenders.add(f.path);
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'These files construct a ModuleLoader outside the three places '
            'that are accounted for. If any of them can be reached while a '
            'script is running, the permission gates stop checking:\n'
            '${offenders.join('\n')}',
      );
    });

    test('F-SCE87-4: with no D4rt behind it, every gate grants — the '
        'un-sandboxed mode [2026-09-21] (PASS)', () {
      // The behaviour the five comments claim, asserted rather than described.
      // It is pinned in the granting direction ON PURPOSE: if someone makes
      // these deny, this case goes red and says where to read why — the
      // reference would then refuse where the twin allows.
      final visitor = _visitorWithoutD4rt();
      expect(visitor.moduleLoader.d4rt, isNull, reason: 'precondition');

      expect(
        () => checkFilesystemReadPermission(
          visitor,
          '/etc/hosts',
          operation: 'read',
        ),
        returnsNormally,
      );
      expect(
        () => checkNetworkConnectPermission(
          visitor,
          '127.0.0.1',
          9,
          operation: 'connect',
        ),
        returnsNormally,
      );
      expect(
        () => checkCertificatePermission(visitor, 'useCertificateChain'),
        returnsNormally,
      );
      expect(
        () => PlatformIo.definition.staticGetters['version']!(visitor),
        returnsNormally,
      );
    });
  });
}
