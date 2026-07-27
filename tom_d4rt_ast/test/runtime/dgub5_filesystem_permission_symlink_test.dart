// DGUB5 (tom_d4rt_ast side): symlink-aware scope matching in the shared
// FilesystemPermission matcher.
//
// This tree carries the matcher but not a filesystem module loader — its
// `AstModuleLoader` is lookup-only, so there is no import to deny here. The
// tests are therefore matcher-level only; the import-path half lives in
// `tom_d4rt/test/dgub5_filesystem_permission_symlink_test.dart` (F-DGUB5-1..3).
//
// The matcher is required to stay byte-identical with tom_d4rt's copy, so these
// cases mirror F-DGUB5-4..6 exactly rather than inventing their own.

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/d4rt.dart';

void main() {
  late io.Directory tempRoot;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dgub5_ast_symlink_');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DGUB5: matcher-level symlink equivalence (analyzer-free tree)', () {
    test(
      'F-DGUB5-A1: allows() equates the symlinked and real spellings of a path '
      '[2026-07-27] (PASS)',
      () {
        final realDir = io.Directory('${tempRoot.path}/real')
          ..createSync(recursive: true);
        final target = io.File('${realDir.path}/data.txt')
          ..writeAsStringSync('x');
        io.Link('${tempRoot.path}/link').createSync(realDir.absolute.path);

        final grantOnReal =
            FilesystemPermission.readPath(realDir.resolveSymbolicLinksSync());
        final grantOnLink =
            FilesystemPermission.readPath('${tempRoot.path}/link');

        Map<String, dynamic> read(String path) =>
            {'type': 'filesystem', 'path': path, 'read': true};

        expect(grantOnReal.allows(read(target.absolute.path)), isTrue);
        expect(
            grantOnReal.allows(read('${tempRoot.path}/link/data.txt')), isTrue);
        expect(grantOnLink.allows(read(target.absolute.path)), isTrue);
        expect(
            grantOnLink.allows(read('${tempRoot.path}/link/data.txt')), isTrue);
      },
    );

    test(
      'F-DGUB5-A2: a not-yet-created path is still matched and does not throw '
      '[2026-07-27] (PASS)',
      () {
        // `realpath` throws for a path that does not exist, and a write grant
        // is normally checked BEFORE the file is created — so resolution has to
        // degrade to the deepest existing ancestor instead of throwing.
        final outDir = io.Directory('${tempRoot.path}/out')
          ..createSync(recursive: true);
        final grant = FilesystemPermission.writePath(outDir.absolute.path);

        expect(
          grant.allows({
            'type': 'filesystem',
            'path': '${outDir.absolute.path}/not/created/yet.txt',
            'write': true,
          }),
          isTrue,
        );
      },
    );

    test(
      'F-DGUB5-A3: a not-yet-created path under a symlinked ancestor resolves '
      'through it [2026-07-27] (PASS)',
      () {
        // The ancestor walk is load-bearing, not a convenience: without it this
        // write would pass the sandbox grant purely because the leaf does not
        // exist yet.
        final sandbox = io.Directory('${tempRoot.path}/sandbox')
          ..createSync(recursive: true);
        final outside = io.Directory('${tempRoot.path}/outside')
          ..createSync(recursive: true);
        io.Link('${sandbox.path}/escape').createSync(outside.absolute.path);

        final grant = FilesystemPermission.writePath(sandbox.absolute.path);

        expect(
          grant.allows({
            'type': 'filesystem',
            'path': '${sandbox.absolute.path}/escape/new_file.txt',
            'write': true,
          }),
          isFalse,
        );
      },
    );
  });
}
