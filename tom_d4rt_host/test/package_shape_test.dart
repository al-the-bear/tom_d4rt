/// What this package may depend on, and the licence it carries.
///
/// It is generic infrastructure for any application that hosts the
/// interpreter, so it names no application package, takes no copyleft
/// dependency and is BSD-3-Clause; and a worker isolate runs plain Dart, so it
/// has no Flutter edge, which would compile and then fail on every machine
/// without Flutter.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  final pubspec = loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
  final dependencies = (pubspec['dependencies'] as YamlMap).keys.toSet();

  test('HOST-P1: the dependencies are the interpreter and tom_basics', () {
    expect(dependencies, {'tom_d4rt', 'tom_basics'});
  });

  test(
    'HOST-P2: no application package, no copyleft dependency, no Flutter',
    () {
      final lock = File('pubspec.lock');
      final resolved = lock.existsSync()
          ? ((loadYaml(lock.readAsStringSync()) as YamlMap)['packages']
                    as YamlMap)
                .keys
                .cast<String>()
                .toSet()
          : dependencies.cast<String>();
      expect(resolved.where((p) => p.startsWith('tom_webwork_')), isEmpty);
      expect(
        resolved.intersection({'kdbx', 'appflowy_editor', 'flutter'}),
        isEmpty,
      );
    },
  );

  test('HOST-P3: the licence is BSD-3-Clause', () {
    expect(File('LICENSE').readAsStringSync(), startsWith('BSD 3-Clause'));
  });

  test('HOST-P4: the library imports nothing outside this package but the '
      'interpreter, tom_basics and the Dart SDK', () {
    final allowed = RegExp(
      r"^import '(dart:|package:(tom_d4rt|tom_basics)/|[a-z_]+\.dart')",
    );
    for (final file in Directory('lib').listSync(recursive: true)) {
      if (file is! File || !file.path.endsWith('.dart')) continue;
      for (final line in file.readAsLinesSync()) {
        if (!line.startsWith('import ')) continue;
        expect(line, matches(allowed), reason: file.path);
      }
    }
  });
}
