/// In-memory filesystem that holds the files the model creates via its
/// `write_file` tool during one generation turn.
///
/// Persistence happens once, at the very end of the agentic loop, by
/// calling [flushTo]. Nothing touches disk before then — including
/// intermediate `write_file` overwrites and `delete_file` calls.
///
/// Paths are normalised to forward-slash form and stripped of leading
/// `/` or `./` so that `'main.dart'`, `'./main.dart'`, and `'/main.dart'`
/// all map to the same entry.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

class GrepHit {
  final String path;
  final int lineNumber;
  final String line;
  GrepHit(this.path, this.lineNumber, this.line);

  @override
  String toString() => '$path:$lineNumber:$line';
}

class VirtualFs {
  final Map<String, String> _files = <String, String>{};

  /// Returns an unmodifiable snapshot of every file currently in the
  /// virtual FS. Use this to inspect state after the generation loop.
  Map<String, String> snapshot() => Map<String, String>.unmodifiable(_files);

  /// Number of files currently held.
  int get fileCount => _files.length;

  /// All paths currently held, optionally filtered by [directory]
  /// (a path prefix; `'src'` matches `'src/foo.dart'` and `'src/bar/'`).
  List<String> listFiles({String? directory}) {
    if (directory == null || directory.isEmpty) {
      final keys = _files.keys.toList()..sort();
      return keys;
    }
    final prefix = _normalize(directory);
    final withSlash = prefix.endsWith('/') ? prefix : '$prefix/';
    final matches = _files.keys
        .where((k) => k == prefix || k.startsWith(withSlash))
        .toList()
      ..sort();
    return matches;
  }

  String? read(String path) => _files[_normalize(path)];

  void write(String path, String content) {
    _files[_normalize(path)] = content;
  }

  bool delete(String path) => _files.remove(_normalize(path)) != null;

  /// Regex search across all (or [directory]-scoped) files. Returns the
  /// matching lines, capped at [limit] hits to keep results bounded for
  /// the model's context window.
  List<GrepHit> grep(
    String pattern, {
    String? directory,
    bool caseSensitive = true,
    int limit = 200,
  }) {
    RegExp re;
    try {
      re = RegExp(pattern, caseSensitive: caseSensitive, multiLine: false);
    } catch (e) {
      throw FormatException('Invalid regex: $e', pattern);
    }
    final hits = <GrepHit>[];
    final paths = listFiles(directory: directory);
    for (final path in paths) {
      final content = _files[path];
      if (content == null) continue;
      final lines = content.split('\n');
      for (var i = 0; i < lines.length; i++) {
        if (re.hasMatch(lines[i])) {
          hits.add(GrepHit(path, i + 1, lines[i]));
          if (hits.length >= limit) return hits;
        }
      }
    }
    return hits;
  }

  /// Writes the entire virtual FS under [targetDir] on disk. Parent
  /// directories are created as needed. Existing files are overwritten.
  ///
  /// Returns the absolute path of `main.dart` if present, otherwise null.
  String? flushTo(String targetDir) {
    final target = Directory(targetDir);
    target.createSync(recursive: true);
    String? mainPath;
    for (final entry in _files.entries) {
      final path = entry.key;
      final content = entry.value;
      final fullPath = p.join(targetDir, path);
      final fileDir = Directory(p.dirname(fullPath));
      if (!fileDir.existsSync()) fileDir.createSync(recursive: true);
      File(fullPath).writeAsStringSync(content);
      if (path == 'main.dart') mainPath = fullPath;
    }
    return mainPath;
  }

  /// Normalise a user-supplied path: collapse `\\` to `/`, drop leading
  /// `./` and `/`, and run `p.normalize` so `'a/../b.dart'` becomes
  /// `'b.dart'`.
  String _normalize(String path) {
    var s = path.replaceAll('\\', '/');
    while (s.startsWith('./')) {
      s = s.substring(2);
    }
    while (s.startsWith('/')) {
      s = s.substring(1);
    }
    return p.posix.normalize(s);
  }
}
