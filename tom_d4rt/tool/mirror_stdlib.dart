/// Mirrors `tom_d4rt/lib/src/stdlib/` into `tom_d4rt_ast/lib/src/runtime/stdlib/`
/// — the rewrite half of the mirror rule, replacing a hand-typed `sed` loop.
///
///     dart run tool/mirror_stdlib.dart            # --check: report, write nothing
///     dart run tool/mirror_stdlib.dart --write    # write the files it can safely
///     dart run tool/mirror_stdlib.dart --write core/set.dart io/file.dart
///
/// SCE219. The rewrite is mechanical — `package:tom_d4rt/d4rt.dart` becomes
/// `package:tom_d4rt_ast/runtime.dart`, `package:tom_d4rt/src/stdlib/` becomes
/// `package:tom_d4rt_ast/src/runtime/stdlib/`, and any other
/// `package:tom_d4rt/src/` becomes `package:tom_d4rt_ast/src/runtime/` — and
/// the `sed` loop that did it by hand once overwrote `io/process.dart`, one of
/// the files that must NOT match. So this tool is deliberately narrow:
///
///   * ONLY `stdlib/`. Outside it SCD183 measured five shared files that are
///     structurally different throughout, and a tool that helps with the easy
///     files and not with those is one that gets reached for by habit where it
///     does not apply. A path outside `stdlib/` is refused, loudly.
///   * NEVER a pinned file. SCD49's `_allowed` map
///     (`test/scd49_stdlib_twin_sync_test.dart`) names the files whose code is
///     meant to differ; this tool reads those keys from that file — it does not
///     keep a second copy — and refuses to write them.
///   * NEVER a twin's own comments. SCD49 compares CODE because the twins'
///     comments legitimately differ (a twin doc comment naming its own test is
///     right). A file is only written when the twin's comments are the
///     reference's too, so the rewrite loses nothing; a file whose code moved
///     AND whose twin has comments of its own is reported for a hand port.
///   * NOTHING when a tree is missing. Both trees must hold at least
///     [minFiles] files, for the reason SCD49's F-1 runs first: a rewrite over
///     an empty set writes nothing and reports success.
///
/// The check mode computes the rewrite in memory and compares; it never
/// touches the twin. The guard (SCD49) stays the authority — this removes one
/// way of reaching a state the guard would then report.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/token.dart';

/// The reference tree, relative to the `tom_d4rt` package root.
const refStdlib = 'lib/src/stdlib';

/// The twin tree, relative to the `tom_d4rt` package root.
const astStdlib = '../tom_d4rt_ast/lib/src/runtime/stdlib';

/// Where SCD49's allow-list lives; its keys are read, never copied.
const scd49Guard = 'test/scd49_stdlib_twin_sync_test.dart';

/// Fewer files than this in either tree means the tree is not there.
const minFiles = 100;

/// The mechanical rewrite from a reference stdlib file to its twin.
String rewriteImports(String source) => source
    .replaceAll(
      'package:tom_d4rt/d4rt.dart',
      'package:tom_d4rt_ast/runtime.dart',
    )
    .replaceAll(
      'package:tom_d4rt/src/stdlib/',
      'package:tom_d4rt_ast/src/runtime/stdlib/',
    )
    .replaceAll('package:tom_d4rt/src/', 'package:tom_d4rt_ast/src/runtime/');

/// The executable tokens of [source]: no comments, no directives, no trailing
/// commas. SCD49's comparison, shared with its guard so the two cannot
/// disagree about what "code-identical" means.
List<String> codeTokens(String source) {
  final unit = _parse(source);
  final directives = unit.directives;
  // `Token.next` skips comments — they hang off `precedingComments`.
  final start = directives.isEmpty
      ? unit.beginToken
      : directives.last.endToken.next!;
  final out = <String>[];
  for (Token? t = start; t != null && t.type != TokenType.EOF; t = t.next) {
    if (t.lexeme == ',') {
      final next = t.next;
      if (next != null && const [')', ']', '}'].contains(next.lexeme)) continue;
    }
    out.add(t.lexeme);
  }
  return out;
}

/// Every comment in [source], in order, whitespace-normalised.
List<String> commentTexts(String source) {
  final out = <String>[];
  for (Token? t = _parse(source).beginToken; t != null; t = t.next) {
    for (Token? c = t.precedingComments; c != null; c = c.next) {
      out.add(c.lexeme.replaceAll(RegExp(r'\s+'), ' ').trim());
    }
    if (t.type == TokenType.EOF) break;
  }
  return out;
}

dynamic _parse(String source) => parseString(
  content: source,
  featureSet: FeatureSet.latestLanguageVersion(),
  throwIfDiagnostics: false,
).unit;

/// The keys of SCD49's `_allowed` map, read from the guard's source.
Set<String> pinnedFiles([String guardPath = scd49Guard]) {
  final source = File(guardPath).readAsStringSync();
  final start = source.indexOf('const _allowed = ');
  if (start < 0) {
    throw StateError('no `const _allowed = ` in $guardPath — SCD49 moved');
  }
  final body = source.substring(start, source.indexOf('\n};', start));
  final keys = RegExp(
    r"^\s*'([^']+)'\s*:",
    multiLine: true,
  ).allMatches(body).map((m) => m.group(1)!).toSet();
  if (keys.isEmpty) {
    throw StateError('read no keys from SCD49 `_allowed` in $guardPath');
  }
  return keys;
}

/// What the tool would do with one file.
enum MirrorStatus {
  /// Code-identical (comments and formatting may differ). Nothing to do.
  current,

  /// Code differs and the twin's comments are the reference's: writing the
  /// rewrite loses nothing.
  writable,

  /// Only in the reference; writing creates it.
  missingInTwin,

  /// Code differs and the twin carries comments of its own: port by hand.
  handPort,

  /// Pinned by SCD49 as deliberately different: never written.
  pinned,

  /// Only in the twin: nothing to mirror from.
  orphan,
}

/// The status of every stdlib file, keyed by its path relative to `stdlib/`.
Map<String, MirrorStatus> survey({
  String ref = refStdlib,
  String ast = astStdlib,
  Set<String>? pinned,
}) {
  final pins = pinned ?? pinnedFiles();
  final refFiles = _dartFilesUnder(ref);
  final astFiles = _dartFilesUnder(ast);
  if (refFiles.length < minFiles || astFiles.length < minFiles) {
    throw StateError(
      'refusing to run: $ref holds ${refFiles.length} files and $ast holds '
      '${astFiles.length}; both need at least $minFiles. A rewrite over a '
      'missing tree writes nothing and reports success.',
    );
  }
  final out = <String, MirrorStatus>{};
  for (final rel in {...refFiles, ...astFiles}) {
    if (pins.contains(rel)) {
      out[rel] = MirrorStatus.pinned;
    } else if (!astFiles.contains(rel)) {
      out[rel] = MirrorStatus.missingInTwin;
    } else if (!refFiles.contains(rel)) {
      out[rel] = MirrorStatus.orphan;
    } else {
      final rewritten = rewriteImports(File('$ref/$rel').readAsStringSync());
      final twin = File('$ast/$rel').readAsStringSync();
      if (_listEquals(codeTokens(rewritten), codeTokens(twin))) {
        out[rel] = MirrorStatus.current;
      } else if (_listEquals(commentTexts(rewritten), commentTexts(twin))) {
        out[rel] = MirrorStatus.writable;
      } else {
        out[rel] = MirrorStatus.handPort;
      }
    }
  }
  return out;
}

/// Writes the rewrite of [rel] into the twin. Only for a file [survey]
/// classed [MirrorStatus.writable] or [MirrorStatus.missingInTwin]; anything
/// else is refused here too, so a caller cannot bypass the survey.
void writeMirror(
  String rel, {
  String ref = refStdlib,
  String ast = astStdlib,
  Set<String>? pinned,
}) {
  final status = survey(ref: ref, ast: ast, pinned: pinned)[rel];
  if (status != MirrorStatus.writable && status != MirrorStatus.missingInTwin) {
    throw StateError('refusing to write $rel: it is ${status?.name}');
  }
  File('$ast/$rel')
    ..createSync(recursive: true)
    ..writeAsStringSync(rewriteImports(File('$ref/$rel').readAsStringSync()));
}

List<String> _dartFilesUnder(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.path.substring(root.length + 1))
      .toList()
    ..sort();
}

bool _listEquals(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

void main(List<String> args) {
  final write = args.contains('--write');
  final requested = args.where((a) => !a.startsWith('--')).toList();

  for (final path in requested) {
    final normalised = path.startsWith('$refStdlib/')
        ? path.substring(refStdlib.length + 1)
        : path;
    if (normalised.startsWith('/') ||
        normalised.contains('..') ||
        path.startsWith('lib/') && !path.startsWith('$refStdlib/')) {
      stderr.writeln(
        'refusing: $path is outside stdlib/. The mirror outside stdlib/ is '
        'structurally different (SCD183) and is ported by hand.',
      );
      exit(2);
    }
  }

  final Map<String, MirrorStatus> status;
  try {
    status = survey();
  } on StateError catch (e) {
    stderr.writeln(e.message);
    exit(2);
  }

  final scope = requested.isEmpty
      ? status.keys.toList()
      : [
          for (final p in requested)
            p.startsWith('$refStdlib/') ? p.substring(refStdlib.length + 1) : p,
        ];
  for (final rel in scope) {
    if (!status.containsKey(rel)) {
      stderr.writeln('refusing: $rel is not a file in either stdlib tree');
      exit(2);
    }
  }

  var exitCode = 0;
  final byStatus = <MirrorStatus, List<String>>{};
  for (final rel in scope..sort()) {
    byStatus.putIfAbsent(status[rel]!, () => []).add(rel);
  }
  final current = byStatus[MirrorStatus.current]?.length ?? 0;
  stdout.writeln('stdlib mirror: $current of ${scope.length} code-identical');

  for (final rel in byStatus[MirrorStatus.pinned] ?? const <String>[]) {
    stdout.writeln('  pinned (SCD49, never written)  $rel');
  }
  for (final kind in [MirrorStatus.writable, MirrorStatus.missingInTwin]) {
    for (final rel in byStatus[kind] ?? const <String>[]) {
      if (write) {
        writeMirror(rel);
        stdout.writeln('  WROTE                           $rel');
      } else {
        stdout.writeln('  out of date (--write mirrors it) $rel');
        exitCode = 1;
      }
    }
  }
  for (final rel in byStatus[MirrorStatus.handPort] ?? const <String>[]) {
    stdout.writeln(
      '  HAND PORT (twin has its own comments; not written)  $rel',
    );
    exitCode = 1;
  }
  for (final rel in byStatus[MirrorStatus.orphan] ?? const <String>[]) {
    stdout.writeln('  orphan (only in the twin)       $rel');
    exitCode = 1;
  }
  if (write) {
    stdout.writeln(
      'Run `dart format` on the twin and `dart test '
      'test/scd49_stdlib_twin_sync_test.dart` — SCD49 is the authority.',
    );
  }
  exit(exitCode);
}
