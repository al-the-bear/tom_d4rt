// The provenance line on generated files: its format, and reading it back.

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/version.versioner.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  test('G-STAMP-01: the line carries the time and this generator\'s version, '
      'and reads back [2026-09-11] (PASS)', () {
    final at = DateTime.utc(2026, 9, 11, 14, 30);
    final line = generatedStampLine(at: at);
    expect(line, startsWith(generatedStampPrefix));
    expect(
      line,
      endsWith('by tom_d4rt_generator ${D4rtGenVersionInfo.version}'),
    );

    final stamp = parseGeneratedStamp(
      '// D4rt Bridge - Generated file, do not '
      'edit\n$line\n\nimport x;',
    );
    expect(stamp, isNotNull);
    expect(stamp!.generatedAt, at);
    expect(stamp.generatorVersion, D4rtGenVersionInfo.version);
  });

  test('G-STAMP-02: a line written before the version was recorded still '
      'reads, with no version [2026-09-11] (PASS)', () {
    final stamp = parseGeneratedStamp(
      '// D4rt Bridge - Generated file, do not edit\n'
      '// Generated: 2026-08-12T10:17:10.834715\n',
    );
    expect(stamp!.generatorVersion, isNull);
    expect(stamp.generatedAt, DateTime.parse('2026-08-12T10:17:10.834715'));
  });

  test('G-STAMP-03: only the head of the file is searched, so a string in '
      'generated code is not taken for the stamp [2026-09-11] (PASS)', () {
    final body = List.filled(30, 'final x = 1;').join('\n');
    expect(
      parseGeneratedStamp(
        '$body\n// Generated: 2026-01-01T00:00:00 by '
        'tom_d4rt_generator 9.9.9\n',
      ),
      isNull,
    );
  });

  test('G-STAMP-04: the freshness comparison still drops the line, version '
      'and all [2026-09-11] (PASS)', () {
    expect(
      normaliseGeneratedContent(
        'a\n${generatedStampLine(generatorVersion: '1.0.0')}\nb',
      ),
      normaliseGeneratedContent(
        'a\n${generatedStampLine(generatorVersion: '2.0.0')}\nb',
      ),
    );
  });
}
