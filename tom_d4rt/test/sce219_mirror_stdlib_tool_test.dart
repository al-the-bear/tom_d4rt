// REPO-WIDE GUARD (tom_d4rt) — tool/mirror_stdlib.dart mirrors stdlib/ into tom_d4rt_ast safely.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE219 — the stdlib mirror tool writes only what it can write without loss.
//
// The hand-typed `sed` loop it replaces once overwrote `io/process.dart`, a
// file SCD49 pins as deliberately different. So what is tested here is the
// refusals as much as the rewrite: a pinned file, a twin with its own
// comments, a missing tree, and a path outside stdlib/. The scenarios run on
// scratch copies of both trees under `.dart_tool/`, never on the real twin.

import 'dart:io';

import 'package:test/test.dart';

import '../tool/mirror_stdlib.dart';
import 'sibling_trees.dart';

const _scratch = '.dart_tool/sce219_scratch';

void _copyTree(String from, String to) {
  for (final f in Directory(from).listSync(recursive: true).whereType<File>()) {
    final rel = f.path.substring(from.length + 1);
    File('$to/$rel')
      ..createSync(recursive: true)
      ..writeAsBytesSync(f.readAsBytesSync());
  }
}

void main() {
  requirePackage('tom_d4rt', subject: 'the stdlib mirror in tom_d4rt_ast');

  group('SCE219: tool/mirror_stdlib.dart', () {
    test('F-SCE219-1: the real trees are current, and the pins are SCD49\'s '
        '[2026-09-28] (PASS)', () {
      final status = survey();
      final pinned = pinnedFiles();
      expect(pinned, hasLength(5), reason: 'SCD49 allows five on 2026-09-28');
      expect({
        for (final e in status.entries)
          if (e.value == MirrorStatus.pinned) e.key,
      }, pinned);
      expect(
        status.values.where(
          (s) => s != MirrorStatus.current && s != MirrorStatus.pinned,
        ),
        isEmpty,
        reason:
            'the mirror is out of date: run dart run '
            'tool/mirror_stdlib.dart to see which files',
      );
      expect(
        status.values.where((s) => s == MirrorStatus.current).length,
        greaterThanOrEqualTo(minFiles),
      );
    });

    group('on scratch copies', () {
      late String ref;
      late String ast;
      setUp(() {
        final root = Directory(_scratch);
        if (root.existsSync()) root.deleteSync(recursive: true);
        ref = '$_scratch/ref';
        ast = '$_scratch/ast';
        _copyTree(refStdlib, ref);
        _copyTree(astStdlib, ast);
      });
      tearDown(() => Directory(_scratch).deleteSync(recursive: true));

      test('F-SCE219-2: writable vs hand-port vs pinned, and writing makes it '
          'current [2026-09-28] (PASS)', () {
        final pins = pinnedFiles();
        // A pure code change to a file the rewrite reproduces byte for byte.
        const plain = 'core/bool.dart';
        final before = File('$ref/$plain').readAsStringSync();
        expect(
          rewriteImports(before),
          File('$ast/$plain').readAsStringSync(),
          reason: 'fixture premise: $plain mirrors byte for byte today',
        );
        File('$ref/$plain').writeAsStringSync('$before\nconst sce219 = 1;\n');
        // A code change to a file whose twin carries its own comments.
        const commented = 'core/set.dart';
        File('$ref/$commented').writeAsStringSync(
          '${File('$ref/$commented').readAsStringSync()}\nconst sce219 = 1;\n',
        );
        // A code change to a pinned file.
        const pinnedFile = 'io/process.dart';
        File('$ref/$pinnedFile').writeAsStringSync(
          '${File('$ref/$pinnedFile').readAsStringSync()}\nconst sce219 = 1;\n',
        );

        final status = survey(ref: ref, ast: ast, pinned: pins);
        expect(status[plain], MirrorStatus.writable);
        expect(status[commented], MirrorStatus.handPort);
        expect(status[pinnedFile], MirrorStatus.pinned);

        expect(
          () => writeMirror(commented, ref: ref, ast: ast, pinned: pins),
          throwsStateError,
        );
        expect(
          () => writeMirror(pinnedFile, ref: ref, ast: ast, pinned: pins),
          throwsStateError,
        );
        writeMirror(plain, ref: ref, ast: ast, pinned: pins);
        expect(
          survey(ref: ref, ast: ast, pinned: pins)[plain],
          MirrorStatus.current,
        );
      });

      test('F-SCE219-3: a missing tree is refused rather than read as '
          'nothing to do [2026-09-28] (PASS)', () {
        Directory(ast).deleteSync(recursive: true);
        expect(
          () => survey(ref: ref, ast: ast, pinned: pinnedFiles()),
          throwsA(
            isA<StateError>().having(
              (e) => e.message,
              'message',
              contains('refusing to run'),
            ),
          ),
        );
      });
    });

    test('F-SCE219-4: a path outside stdlib/ is refused by the CLI '
        '[2026-09-28] (PASS)', () {
      final result = Process.runSync(Platform.resolvedExecutable, [
        'run',
        'tool/mirror_stdlib.dart',
        '--write',
        'lib/src/interpreter_visitor.dart',
      ]);
      expect(result.exitCode, 2);
      expect('${result.stderr}', contains('outside stdlib/'));
    });
  });
}
