// DFUB11: enforce FilesystemPermission on every file/directory operation, and
// match granted path scopes on a canonical path-segment boundary.
//
// Two independent sandbox holes are closed here (upstream kodjodevf/d4rt
// 861117a is the source of the port):
//
//   1. NO PER-OPERATION ENFORCEMENT. `stdlib/io/{file,directory,
//      file_system_entity}.dart` carried zero permission checks; the only gate
//      was at `dart:io` IMPORT time, which merely required *some*
//      FilesystemPermission. A scoped grant was therefore indistinguishable
//      from `FilesystemPermission.any` once the import succeeded.
//
//   2. NAIVE SCOPE MATCH. `FilesystemPermission.allows` compared with a raw
//      `opPath.startsWith(_path)`, so `..` traversal escaped the scope and a
//      sibling directory whose name merely shares the prefix
//      (`allowed_sneaky` vs `allowed`) was inside it.
//
// Hole 2's boundary half is what quest todo dgub4 asked for; upstream's
// `_isPathWithinScope` (canonical equality OR canonical prefix on a `/`
// boundary) closes both halves at once, so they land together here.
//
// DELIBERATE DIVERGENCE FROM UPSTREAM: upstream throws `RuntimeError`; we use
// `RuntimeD4rtException`, our equivalent. Upstream also imports `dart:io` into
// `permissions.dart` for `File(path).absolute.path`; we reach the current
// directory through a conditional-import shim instead, because the twin file
// in tom_d4rt_ast must stay web-safe (that package puts all of `dart:io`
// behind a `dart.library.html` conditional).
//
// Twin: tom_d4rt_ast/test/runtime/dfub11_filesystem_operation_permission_test.dart

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  late io.Directory sandbox;
  late String allowedPath;
  late String siblingPath;
  late String outsidePath;

  setUp(() {
    // A real temp tree, so the grant and the operation are both spelled as
    // absolute paths and no test can accidentally reach the repo.
    sandbox = io.Directory.systemTemp.createTempSync('dfub11_');
    allowedPath = '${sandbox.path}/allowed';
    // Shares the string prefix of `allowedPath` but is NOT under it — the
    // boundary case a raw `startsWith` gets wrong.
    siblingPath = '${sandbox.path}/allowed_sneaky';
    outsidePath = '${sandbox.path}/outside';

    io.Directory(allowedPath).createSync();
    io.Directory(siblingPath).createSync();
    io.Directory(outsidePath).createSync();

    io.File('$allowedPath/inside.txt').writeAsStringSync('inside');
    io.File('$siblingPath/sneaky.txt').writeAsStringSync('sneaky');
    io.File('$outsidePath/secret.txt').writeAsStringSync('secret');
    io.File('${sandbox.path}/top_secret.txt').writeAsStringSync('top secret');
  });

  tearDown(() {
    if (sandbox.existsSync()) sandbox.deleteSync(recursive: true);
  });

  Matcher throwsPermissionDenied() => throwsA(isA<RuntimeD4rtException>()
      .having((e) => e.toString(), 'message',
          contains('Filesystem permission denied')));

  group('DFUB11: per-operation filesystem permission enforcement', () {
    test('F-DFUB11-1: scoped read is allowed inside its scope [2026-07-27]',
        () {
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));
      expect(
        d4rt.execute(source: '''
          import 'dart:io';
          String main() => File('$allowedPath/inside.txt').readAsStringSync();
        '''),
        equals('inside'),
      );
    });

    test('F-DFUB11-2: scoped read is denied outside its scope [2026-07-27]',
        () {
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));
      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          String main() => File('$outsidePath/secret.txt').readAsStringSync();
        '''),
        throwsPermissionDenied(),
      );
    });

    test(
        'F-DFUB11-3: a sibling sharing the scope prefix is outside the scope '
        '[2026-07-27]', () {
      // dgub4's case: `<tmp>/allowed_sneaky` starts with `<tmp>/allowed` as a
      // STRING but is not under it as a PATH.
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));
      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          String main() => File('$siblingPath/sneaky.txt').readAsStringSync();
        '''),
        throwsPermissionDenied(),
      );
    });

    test('F-DFUB11-4: `..` traversal cannot escape the scope [2026-07-27]', () {
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));
      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          String main() =>
              File('$allowedPath/../top_secret.txt').readAsStringSync();
        '''),
        throwsPermissionDenied(),
      );
    });

    test('F-DFUB11-5: read grant does not authorize a write [2026-07-27]', () {
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));
      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          void main() {
            File('$allowedPath/new.txt').writeAsStringSync('nope');
          }
        '''),
        throwsPermissionDenied(),
      );
    });

    test('F-DFUB11-6: scoped write is allowed inside, denied outside '
        '[2026-07-27]', () {
      final d4rt = D4rt()..grant(FilesystemPermission.writePath(allowedPath));

      d4rt.execute(source: '''
        import 'dart:io';
        void main() {
          File('$allowedPath/written.txt').writeAsStringSync('ok');
        }
      ''');
      expect(io.File('$allowedPath/written.txt').readAsStringSync(),
          equals('ok'));

      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          void main() {
            File('$outsidePath/written.txt').writeAsStringSync('nope');
          }
        '''),
        throwsPermissionDenied(),
      );
    });

    test('F-DFUB11-7: directory listing is scope-checked [2026-07-27]', () {
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));

      expect(
        d4rt.execute(source: '''
          import 'dart:io';
          int main() => Directory('$allowedPath').listSync().length;
        '''),
        equals(1),
      );

      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          int main() => Directory('$outsidePath').listSync().length;
        '''),
        throwsPermissionDenied(),
      );
    });

    test('F-DFUB11-8: existsSync is a read and is scope-checked [2026-07-27]',
        () {
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));

      expect(
        d4rt.execute(source: '''
          import 'dart:io';
          bool main() => File('$allowedPath/inside.txt').existsSync();
        '''),
        isTrue,
      );

      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          bool main() => File('$outsidePath/secret.txt').existsSync();
        '''),
        throwsPermissionDenied(),
      );
    });

    test('F-DFUB11-9: deleteSync is a write and is scope-checked [2026-07-27]',
        () {
      final d4rt = D4rt()..grant(FilesystemPermission.writePath(allowedPath));
      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          void main() {
            File('$outsidePath/secret.txt').deleteSync();
          }
        '''),
        throwsPermissionDenied(),
      );
      // The denial must happen BEFORE the operation, not after.
      expect(io.File('$outsidePath/secret.txt').existsSync(), isTrue);
    });

    test(
        'F-DFUB11-10: `copy` needs read on the source AND write on the target '
        '[2026-07-27]', () {
      final d4rt = D4rt()..grant(FilesystemPermission.path(allowedPath));
      expect(
        () => d4rt.execute(source: '''
          import 'dart:io';
          void main() {
            File('$allowedPath/inside.txt').copySync('$outsidePath/copy.txt');
          }
        '''),
        throwsPermissionDenied(),
      );
      expect(io.File('$outsidePath/copy.txt').existsSync(), isFalse);
    });

    test(
        'F-DFUB11-11: a SCOPED grant still admits the dart:io import '
        '[2026-07-27]', () {
      // The import gate asks for "some filesystem permission" with no path.
      // Tightening the matcher must not turn every scoped grant into a
      // `dart:io` denial — the gate is path-agnostic by construction.
      final d4rt = D4rt()..grant(FilesystemPermission.readPath(allowedPath));
      expect(
        d4rt.execute(source: '''
          import 'dart:io';
          int main() => 42;
        '''),
        equals(42),
      );
    });

    test('F-DFUB11-12: unscoped grants stay allow-all [2026-07-27]', () {
      // `_path == null` must keep meaning "any path" — this is what every
      // pre-existing test in the suite relies on.
      final d4rt = D4rt()..grant(FilesystemPermission.any);
      expect(
        d4rt.execute(source: '''
          import 'dart:io';
          String main() => File('$outsidePath/secret.txt').readAsStringSync();
        '''),
        equals('secret'),
      );
    });
  });

  group('DFUB11: FilesystemPermission.allows scope matching', () {
    test('F-DFUB11-13: canonical equality and segment-boundary prefix '
        '[2026-07-27]', () {
      final permission = FilesystemPermission.readPath('/allowed');

      bool canRead(String path) =>
          permission.allows({'type': 'filesystem', 'path': path, 'read': true});

      expect(canRead('/allowed'), isTrue, reason: 'the scope root itself');
      expect(canRead('/allowed/file.txt'), isTrue);
      expect(canRead('/allowed/nested/deep/file.txt'), isTrue);
      expect(canRead('/allowed/'), isTrue, reason: 'trailing slash is noise');
      expect(canRead('/allowed/./file.txt'), isTrue, reason: '`.` is noise');

      expect(canRead('/allowed_sneaky/file.txt'), isFalse,
          reason: 'shares the string prefix but not the path prefix');
      expect(canRead('/allowedx'), isFalse);
      expect(canRead('/other/file.txt'), isFalse);
    });

    test('F-DFUB11-14: `..` traversal is normalized before matching '
        '[2026-07-27]', () {
      final permission = FilesystemPermission.readPath('/allowed');

      bool canRead(String path) =>
          permission.allows({'type': 'filesystem', 'path': path, 'read': true});

      expect(canRead('/allowed/../etc/passwd'), isFalse);
      expect(canRead('/allowed/nested/../../etc/passwd'), isFalse);
      // Traversal that stays inside the scope is still inside it.
      expect(canRead('/allowed/nested/../file.txt'), isTrue);
    });

    test('F-DFUB11-15: pathAgnostic operations bypass the scope check, not '
        'the access flags [2026-07-27]', () {
      final readOnly = FilesystemPermission.readPath('/allowed');

      expect(
        readOnly.allows({'type': 'filesystem', 'pathAgnostic': true}),
        isTrue,
        reason: 'no meaningful path — e.g. the dart:io import gate',
      );
      expect(
        readOnly.allows(
            {'type': 'filesystem', 'pathAgnostic': true, 'write': true}),
        isFalse,
        reason: 'pathAgnostic waives the PATH check, never the WRITE flag',
      );
    });

    test('F-DFUB11-16: a scoped grant denies a pathless operation '
        '[2026-07-27]', () {
      // Not path-agnostic and no path supplied: the matcher cannot prove the
      // operation is in scope, so it must deny rather than assume.
      expect(
        FilesystemPermission.readPath('/allowed')
            .allows({'type': 'filesystem', 'read': true}),
        isFalse,
      );
      // An unscoped grant is unaffected.
      expect(
        FilesystemPermission.read.allows({'type': 'filesystem', 'read': true}),
        isTrue,
      );
    });
  });
}
