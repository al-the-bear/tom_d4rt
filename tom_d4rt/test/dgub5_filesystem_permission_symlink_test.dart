// DGUB5: make the FilesystemPermission scope matcher symlink-aware.
//
// DFUB3 canonicalized module URIs and, for the `_moduleCache` KEY, resolved
// symlinks to the real path. It deliberately left the READ GATE on the caller's
// spelling so existing grants kept matching, and parked the residual gap here.
//
// The gap has two halves, and they pull in opposite directions:
//
//   (a) TOO STRICT — a grant on the REAL path does not authorize a read spelled
//       through a symlink, even though both name the same bytes. On macOS this
//       is not exotic: `Directory.systemTemp` hands out `/var/folders/...`,
//       which is itself a symlink to `/private/var/folders/...`, so a caller
//       who grants a resolved path and imports via the unresolved one is denied
//       for no reason a user can see.
//
//   (b) TOO LOOSE — a grant on a directory authorizes anything whose SPELLING
//       sits under it, wherever the bytes really live. A symlink inside the
//       granted directory pointing anywhere on the disk is therefore a sandbox
//       escape: `<sandbox>/escape/secret.dart` is lexically in scope while
//       actually reading from outside it.
//
// Resolving both sides to a real path fixes both at once: (a) starts matching
// because the two spellings converge, and (b) stops matching because the
// request diverges from the grant. That is the "single canonical identity"
// framing DFUB3 already uses for cache dedup.

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  late io.Directory tempRoot;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dgub5_symlink_');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DGUB5: symlink-aware scope matching', () {
    test(
      'F-DGUB5-1: a grant on the real path authorizes a read spelled through a '
      'symlink [2026-07-27] (PASS)',
      () {
        // Half (a). The grant and the import name the same file by two
        // different routes; only a realpath-aware matcher sees that.
        final realDir = io.Directory('${tempRoot.path}/real')
          ..createSync(recursive: true);
        io.File('${realDir.path}/helper.dart').writeAsStringSync('''
String helperValue() => "via-symlink";
''');
        final linkDir = io.Link('${tempRoot.path}/link')
          ..createSync(realDir.absolute.path);

        final d4rt = D4rt()
          ..grant(
            FilesystemPermission.readPath(realDir.resolveSymbolicLinksSync()),
          );

        final result = d4rt.execute(
          source: '''
import './helper.dart';

String main() => helperValue();
''',
          basePath: linkDir.absolute.path,
          allowFileSystemImports: true,
        );

        expect(result, equals('via-symlink'));
      },
    );

    test(
      'F-DGUB5-2: a symlink inside the granted directory cannot read outside it '
      '[2026-07-27] (PASS)',
      () {
        // Half (b), and the security-relevant half. The import path is
        // lexically inside the grant; the bytes are not.
        final sandbox = io.Directory('${tempRoot.path}/sandbox')
          ..createSync(recursive: true);
        final outside = io.Directory('${tempRoot.path}/outside')
          ..createSync(recursive: true);
        io.File('${outside.path}/secret.dart').writeAsStringSync('''
String secretValue() => "escaped";
''');
        io.Link('${sandbox.path}/escape').createSync(outside.absolute.path);

        final d4rt = D4rt()
          ..grant(FilesystemPermission.readPath(sandbox.absolute.path));

        expect(
          () => d4rt.execute(
            source: '''
import './escape/secret.dart';

String main() => secretValue();
''',
            basePath: sandbox.absolute.path,
            allowFileSystemImports: true,
          ),
          throwsA(
            predicate(
              (e) => e.toString().contains('requires FilesystemPermission'),
            ),
          ),
        );
      },
    );

    test('F-DGUB5-3: a genuine in-sandbox import is still allowed [2026-07-27] '
        '(PASS)', () {
      // The anchor for F-DGUB5-2. Tightening the matcher must not make the
      // ordinary case fail — without this, -2 would pass just as well if
      // symlink handling denied everything.
      final sandbox = io.Directory('${tempRoot.path}/sandbox')
        ..createSync(recursive: true);
      io.File('${sandbox.path}/ok.dart').writeAsStringSync('''
String okValue() => "in-sandbox";
''');

      final d4rt = D4rt()
        ..grant(FilesystemPermission.readPath(sandbox.absolute.path));

      final result = d4rt.execute(
        source: '''
import './ok.dart';

String main() => okValue();
''',
        basePath: sandbox.absolute.path,
        allowFileSystemImports: true,
      );

      expect(result, equals('in-sandbox'));
    });
  });

  group('DGUB5: matcher-level symlink equivalence', () {
    test(
      'F-DGUB5-4: allows() equates the symlinked and real spellings of a path '
      '[2026-07-27] (PASS)',
      () {
        final realDir = io.Directory('${tempRoot.path}/real')
          ..createSync(recursive: true);
        final target = io.File('${realDir.path}/data.txt')
          ..writeAsStringSync('x');
        io.Link('${tempRoot.path}/link').createSync(realDir.absolute.path);

        final grantOnReal = FilesystemPermission.readPath(
          realDir.resolveSymbolicLinksSync(),
        );
        final grantOnLink = FilesystemPermission.readPath(
          '${tempRoot.path}/link',
        );

        Map<String, dynamic> read(String path) => {
          'type': 'filesystem',
          'path': path,
          'read': true,
        };

        // Both grants must admit both spellings — that is what "single
        // canonical identity" means, and it has to hold in all four
        // combinations or the matcher is merely lucky.
        expect(read(target.absolute.path), predicate(grantOnReal.allows));
        expect(
          read('${tempRoot.path}/link/data.txt'),
          predicate(grantOnReal.allows),
        );
        expect(read(target.absolute.path), predicate(grantOnLink.allows));
        expect(
          read('${tempRoot.path}/link/data.txt'),
          predicate(grantOnLink.allows),
        );
      },
    );

    test(
      'F-DGUB5-5: a not-yet-created path is still matched lexically and does '
      'not throw [2026-07-27] (PASS)',
      () {
        // The objection that kept DFUB3 from doing this: `realpath` fails for
        // paths that do not exist, and a WRITE grant is normally checked
        // BEFORE the file is created. Resolution therefore has to degrade to
        // the deepest existing ancestor rather than throwing or denying.
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
      'F-DGUB5-6: a not-yet-created path under a symlinked ancestor resolves '
      'through it [2026-07-27] (PASS)',
      () {
        // Combines -5 with the escape case: the file does not exist, so the
        // ancestor walk is what carries the resolution, and it must still
        // notice that the ancestor leaves the sandbox. Without the walk this
        // is the write-side version of F-DGUB5-2.
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
