// DFUB11: match a granted FilesystemPermission scope on a canonical
// path-segment boundary.
//
// `FilesystemPermission.allows` used to compare with a raw
// `opPath.startsWith(_path)`, so `..` traversal escaped the scope and a sibling
// directory whose name merely shares the prefix (`allowed_sneaky` vs
// `allowed`) was treated as inside it. Ported from upstream kodjodevf/d4rt
// 861117a; the boundary half is what quest todo dgub4 asked for.
//
// DELIBERATE DIVERGENCE FROM UPSTREAM: upstream imports `dart:io` into
// `permissions.dart` for `File(path).absolute.path`. This package must compile
// for web — it puts all of `dart:io` behind a `dart.library.html` conditional —
// so the current directory is reached through the
// `security/current_directory_{io,web}.dart` shim instead.
//
// This package has no parser, so the end-to-end "a script is actually denied"
// half of DFUB11 lives in the twins that can execute source:
//   tom_d4rt/test/dfub11_filesystem_operation_permission_test.dart
//   tom_d4rt_exec/test/dfub11_filesystem_operation_permission_test.dart
// What is verified here is the matcher those bridges call into.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('DFUB11: FilesystemPermission.allows scope matching', () {
    test('F-DFUB11-A1: canonical equality and segment-boundary prefix '
        '[2026-07-27]', () {
      final permission = FilesystemPermission.readPath('/allowed');

      bool canRead(String path) =>
          permission.allows({'type': 'filesystem', 'path': path, 'read': true});

      expect(canRead('/allowed'), isTrue, reason: 'the scope root itself');
      expect(canRead('/allowed/file.txt'), isTrue);
      expect(canRead('/allowed/nested/deep/file.txt'), isTrue);
      expect(canRead('/allowed/'), isTrue, reason: 'trailing slash is noise');
      expect(canRead('/allowed/./file.txt'), isTrue, reason: '`.` is noise');

      expect(
        canRead('/allowed_sneaky/file.txt'),
        isFalse,
        reason: 'shares the string prefix but not the path prefix',
      );
      expect(canRead('/allowedx'), isFalse);
      expect(canRead('/other/file.txt'), isFalse);
    });

    test('F-DFUB11-A2: `..` traversal is normalized before matching '
        '[2026-07-27]', () {
      final permission = FilesystemPermission.readPath('/allowed');

      bool canRead(String path) =>
          permission.allows({'type': 'filesystem', 'path': path, 'read': true});

      expect(canRead('/allowed/../etc/passwd'), isFalse);
      expect(canRead('/allowed/nested/../../etc/passwd'), isFalse);
      // Traversal that stays inside the scope is still inside it.
      expect(canRead('/allowed/nested/../file.txt'), isTrue);
    });

    test('F-DFUB11-A3: pathAgnostic operations bypass the scope check, not '
        'the access flags [2026-07-27]', () {
      final readOnly = FilesystemPermission.readPath('/allowed');

      expect(
        readOnly.allows({'type': 'filesystem', 'pathAgnostic': true}),
        isTrue,
        reason: 'no meaningful path — e.g. the dart:io import gate',
      );
      expect(
        readOnly.allows({
          'type': 'filesystem',
          'pathAgnostic': true,
          'write': true,
        }),
        isFalse,
        reason: 'pathAgnostic waives the PATH check, never the WRITE flag',
      );
    });

    test('F-DFUB11-A4: a scoped grant denies a pathless operation '
        '[2026-07-27]', () {
      // Not path-agnostic and no path supplied: the matcher cannot prove the
      // operation is in scope, so it must deny rather than assume.
      expect(
        FilesystemPermission.readPath(
          '/allowed',
        ).allows({'type': 'filesystem', 'read': true}),
        isFalse,
      );
      // An unscoped grant is unaffected.
      expect(
        FilesystemPermission.read.allows({'type': 'filesystem', 'read': true}),
        isTrue,
      );
    });

    test('F-DFUB11-A5: unscoped grants stay allow-all [2026-07-27]', () {
      // `_path == null` must keep meaning "any path" — this is what every
      // pre-existing permission test relies on.
      expect(
        FilesystemPermission.any.allows({
          'type': 'filesystem',
          'path': '/anywhere',
          'read': true,
        }),
        isTrue,
      );
      expect(
        FilesystemPermission.any.allows({
          'type': 'filesystem',
          'path': '/anywhere',
          'write': true,
        }),
        isTrue,
      );
    });
  });
}
