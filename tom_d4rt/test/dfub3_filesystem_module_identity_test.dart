// DFUB3: filesystem imports must reuse ONE module identity across different
// URI forms of the same file and across symlinks pointing at the same real
// file.
//
// Ports upstream kodjodevf/d4rt 3b8b8ca: canonicalize the module URI at the
// top of `loadModule` so the `_moduleCache` key is always the resolved,
// real-path filesystem URI. Without canonicalization, importing the same
// helper file under two spellings that resolve to different-looking paths
// (a symlinked directory vs the real directory, or a symlinked file vs the
// real file) loads the file TWICE, creating two independent module
// environments.
//
// These tests observe dedup directly: the helper module carries mutable
// top-level state. A program mutates that state through one spelling and
// reads it back through the other spelling. If the two spellings share ONE
// module instance (canonicalized), the read sees the mutation (1). If they
// load twice (no canonicalization), each spelling gets its own counter and
// the read sees the initial value (0).

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  late io.Directory tempRoot;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dfub3_fs_identity_');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DFUB3: filesystem module identity dedup', () {
    test(
      'F-DFUB3-1: same file reached via a symlinked directory + its real path '
      'shares one module instance [2026-07-23] (PASS)',
      () {
        if (io.Platform.isWindows) {
          return;
        }

        final realDir = io.Directory('${tempRoot.path}/real')
          ..createSync(recursive: true);
        // A symlink to the directory: `./helper.dart` resolved against the
        // symlinked base does not collapse to the real path unless we
        // canonicalize with realpath.
        io.Link('${tempRoot.path}/link').createSync(realDir.absolute.path);

        final helperFile = io.File('${realDir.path}/helper.dart')
          ..writeAsStringSync('''
int _counter = 0;
void bumpCounter() { _counter = _counter + 1; }
int readCounter() => _counter;
''');

        final d4rt = D4rt();
        // Grant on the caller's temp path: DFUB3 keeps reads/permissions on the
        // caller's spelling (only the cache key is symlink-resolved), so a grant
        // on the non-realpath temp dir still matches.
        d4rt.grant(FilesystemPermission.readPath(tempRoot.path));

        final result = d4rt.execute(
          source: '''
import './helper.dart';
import '${helperFile.absolute.uri}' as viaReal;

int main() {
  bumpCounter();
  return viaReal.readCounter();
}
''',
          // Anchor relative imports at the SYMLINKED directory.
          basePath: '${tempRoot.path}/link',
          allowFileSystemImports: true,
        );

        expect(result, equals(1));
      },
    );

    test(
      'F-DFUB3-2: same file reached via a symlinked file + its real path '
      'shares one module instance [2026-07-23] (PASS)',
      () {
        if (io.Platform.isWindows) {
          return;
        }

        io.File('${tempRoot.path}/real_helper.dart').writeAsStringSync('''
int _counter = 0;
void bumpCounter() { _counter = _counter + 1; }
int readCounter() => _counter;
''');
        io.Link('${tempRoot.path}/linked_helper.dart')
            .createSync('${tempRoot.path}/real_helper.dart');

        final d4rt = D4rt();
        // Grant on the caller's temp path: DFUB3 keeps reads/permissions on the
        // caller's spelling (only the cache key is symlink-resolved), so a grant
        // on the non-realpath temp dir still matches.
        d4rt.grant(FilesystemPermission.readPath(tempRoot.path));

        final result = d4rt.execute(
          source: '''
import './real_helper.dart';
import './linked_helper.dart' as viaLink;

int main() {
  bumpCounter();
  return viaLink.readCounter();
}
''',
          basePath: tempRoot.path,
          allowFileSystemImports: true,
        );

        expect(result, equals(1));
      },
    );
  });
}
