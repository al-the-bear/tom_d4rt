/// SCF33 — `doc/astgen_build_yaml.md` describes the tool that ships.
///
/// The package's two CLI docs described a pre-v2 astgen: project discovery
/// through `tom_build.yaml`, conversion through `build.yaml`, and, in one of
/// them, a generator emitting `d4rt_ast.g.dart` registration code that this
/// package has never produced. A user following them wrote configuration the
/// tool never opens. They are now one document, written from
/// `lib/src/v2/astgen_executor.dart`; these tests keep it that way:
///
/// * every `astgen:` example in the doc is read by the executor — listed and
///   dry-run successfully in a project configured from it (F-SCF33-1);
/// * every key an example uses is one `_loadConfig` reads, so a documented key
///   the tool silently ignores cannot creep back (F-SCF33-2);
/// * the output naming the doc states is what a real run writes (F-SCF33-3);
/// * an unresolvable output fails the project with or without `--verbose`
///   (F-SCF33-4) — before SCF33 only a verbose run reported the failure.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_ast_generator/src/v2/astgen_executor.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:yaml/yaml.dart';

const _docPath = 'doc/astgen_build_yaml.md';

/// The fenced YAML blocks of the doc that configure astgen.
List<String> _docExamples() {
  final doc = File(_docPath).readAsStringSync();
  return RegExp(r'```yaml\n([\s\S]*?)```')
      .allMatches(doc)
      .map((m) => m.group(1)!)
      .where((block) => RegExp(r'^astgen:', multiLine: true).hasMatch(block))
      .toList();
}

/// A workspace holding a project configured with [buildkit], plus a sibling
/// project for every `project:<name>` output it names.
Directory _workspace(String buildkit) {
  final ws = Directory.systemTemp.createTempSync('scf33_');
  final project = Directory(p.join(ws.path, 'astgen_doc_project'))
    ..createSync();
  File(
    p.join(project.path, 'pubspec.yaml'),
  ).writeAsStringSync('name: astgen_doc_project\n');
  File(p.join(project.path, 'buildkit.yaml')).writeAsStringSync(buildkit);
  // A `root` that does not exist fails the project, as the doc says, so the
  // project configured from an example has the directories it names.
  final convert =
      ((loadYaml(buildkit) as YamlMap)['astgen'] as YamlMap)['convert']
          as YamlList;
  for (final entry in convert.cast<YamlMap>()) {
    final root = entry['root'] as String? ?? '.';
    Directory(p.join(project.path, root)).createSync(recursive: true);
  }
  for (final m in RegExp(r'project:(\w+)').allMatches(buildkit)) {
    final name = m.group(1)!;
    Directory(p.join(ws.path, name)).createSync(recursive: true);
    File(
      p.join(ws.path, name, 'pubspec.yaml'),
    ).writeAsStringSync('name: $name\n');
  }
  return ws;
}

Future<ItemResult> _run(Directory ws, CliArgs args) {
  final project = p.join(ws.path, 'astgen_doc_project');
  return AstgenExecutor().execute(
    CommandContext(
      fsFolder: FsFolder(path: project),
      natures: const [],
      executionRoot: ws.path,
    ),
    args,
  );
}

void main() {
  group('SCF33: the astgen doc describes the shipped tool', () {
    test('F-SCF33-1: every astgen example in the doc is listed and dry-runs '
        'cleanly [2026-09-30] (PASS)', () async {
      final examples = _docExamples();
      expect(
        examples.length,
        greaterThanOrEqualTo(3),
        reason: 'the doc should carry its configuration examples',
      );
      for (final example in examples) {
        final ws = _workspace(example);
        try {
          for (final args in const [
            CliArgs(listOnly: true),
            CliArgs(dryRun: true),
          ]) {
            final result = await _run(ws, args);
            expect(result.success, isTrue, reason: '$args on:\n$example');
          }
        } finally {
          ws.deleteSync(recursive: true);
        }
      }
    });

    test('F-SCF33-2: every key the examples use is one the executor reads '
        '[2026-09-30] (PASS)', () {
      final source = File('lib/src/v2/astgen_executor.dart').readAsStringSync();
      final read = RegExp(
        r"""config\['(\w+)'\]|containsKey\('(\w+)'\)""",
      ).allMatches(source).map((m) => m.group(1) ?? m.group(2)!).toSet();
      expect(read, containsAll(['entrypoints', 'output', 'root']));

      for (final example in _docExamples()) {
        final yaml = loadYaml(example) as YamlMap;
        final entries = (yaml['astgen'] as YamlMap)['convert'] as YamlList;
        for (final entry in entries.cast<YamlMap>()) {
          final unknown = entry.keys.cast<String>().toSet().difference(read);
          expect(unknown, isEmpty, reason: 'in:\n$example');
        }
      }
    });

    test('F-SCF33-3: the output keeps the source name minus its last '
        'extension, under preserve_structure relative to root '
        '[2026-09-30] (PASS)', () async {
      final ws = _workspace('''
astgen:
  convert:
    - entrypoints: '**/*.runner.dart'
      root: lib
      output: out
      preserve_structure: true
''');
      try {
        final lib = p.join(ws.path, 'astgen_doc_project', 'lib');
        File(p.join(lib, 'main.runner.dart'))
          ..createSync(recursive: true)
          ..writeAsStringSync('int main() => 1;\n');
        File(p.join(lib, 'tools', 'my_tool.runner.dart'))
          ..createSync(recursive: true)
          ..writeAsStringSync('int main() => 2;\n');

        final result = await _run(ws, const CliArgs());

        expect(result.success, isTrue);
        final out = p.join(ws.path, 'astgen_doc_project', 'out');
        expect(File(p.join(out, 'main.runner.ast.yaml')).existsSync(), isTrue);
        expect(
          File(p.join(out, 'tools', 'my_tool.runner.ast.yaml')).existsSync(),
          isTrue,
        );
      } finally {
        ws.deleteSync(recursive: true);
      }
    });

    test('F-SCF33-4: an unresolvable output fails the project whether or not '
        '--verbose is set [2026-09-30] (PASS)', () async {
      final ws = _workspace('''
astgen:
  convert:
    - entrypoints: lib/*.dart
      output: project:astgen_no_such_project/assets
''');
      // The sibling _workspace creates for the name must not exist here.
      Directory(
        p.join(ws.path, 'astgen_no_such_project'),
      ).deleteSync(recursive: true);
      try {
        for (final args in const [
          CliArgs(),
          CliArgs(verbose: true),
          CliArgs(dryRun: true),
        ]) {
          final result = await _run(ws, args);
          expect(result.success, isFalse, reason: '$args');
        }
      } finally {
        ws.deleteSync(recursive: true);
      }
    });
  });
}
