/// relaxsize1 - a relaxer output too large for one file moves its RC-2
/// generic constructor factories into `part` files.
///
/// The Flutter twins' `flutter_relaxers.b.dart` reached 93 MB at generator
/// 1.63.0, 98.8% of it the RC-2 factories' bounded-dispatch leaves; GitHub
/// refuses a push with a file above 100 MB. Above `maxFileBytes` the
/// factories are packed, in order, into `<stem>_part<N>.b.dart` files of the
/// same library: the code is the same, only spread over files. Below it the
/// output is one file, byte for byte what it was before.
///
/// The fixture: two generic classes `Box<T>` and `Crate<T>` (one RC-2
/// factory each) over three concrete classes.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  const barrel = 'package:fake_pkg/fake_pkg.dart';

  ClassInfo generic(String name) => ClassInfo(
    name: name,
    sourceFile: barrel,
    typeParameters: const {'T': null},
    constructors: const [
      ConstructorInfo(
        parameters: [ParameterInfo(name: 'value', type: 'T')],
      ),
    ],
  );

  Map<String, ClassInfo> lookup() => {
    'Box': generic('Box'),
    'Crate': generic('Crate'),
    for (final n in ['Apple', 'Banana', 'Cherry'])
      n: ClassInfo(name: n, sourceFile: barrel),
  };

  late Directory tempDir;
  late String relaxerPath;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('relaxsize1_test');
    relaxerPath = p.join(tempDir.path, 'lib', 'src', 'relaxers.b.dart');
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  BridgeConfig config() => BridgeConfig(
    name: 'fake_pkg',
    modules: const [
      ModuleConfig(
        name: 'fake',
        barrelFiles: ['lib/fake_pkg.dart'],
        outputPath: 'lib/src/fake.b.dart',
        barrelImport: barrel,
      ),
    ],
    relaxerOutputPath: relaxerPath,
  );

  Future<RelaxerGenerationResult> generate({int? maxFileBytes}) =>
      generateRelaxers(
        config: config(),
        projectPath: tempDir.path,
        globalClassLookup: lookup(),
        genericExtractionSites: const [
          GenericExtractionSite(
            baseTypeName: 'Box',
            typeArg: 'Apple',
            moduleName: 'fake',
          ),
        ],
        maxFileBytes: maxFileBytes ?? defaultRelaxerMaxFileBytes,
      );

  List<String> partFilesOnDisk() =>
      Directory(p.dirname(relaxerPath))
          .listSync()
          .whereType<File>()
          .map((f) => p.basename(f.path))
          .where((n) => n.contains('_part'))
          .toList()
        ..sort();

  // The top-level declarations of [source] that start with `Object? _rc2`,
  // each up to the next top-level line: the RC-2 factory functions.
  Set<String> rc2Functions(String source) {
    final found = <String>{};
    final lines = source.split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (!lines[i].startsWith('Object? _rc2')) continue;
      final body = StringBuffer();
      var j = i;
      do {
        body.writeln(lines[j]);
        j++;
      } while (j < lines.length && lines[j] != '}');
      body.writeln('}');
      found.add(body.toString());
    }
    return found;
  }

  test('RS1-1: an output below the budget is one file with no part '
      'directive and no part files [2026-11-13]', () async {
    final result = await generate();
    final main = File(result.outputFile!).readAsStringSync();

    expect(result.partFiles, isEmpty);
    expect(partFilesOnDisk(), isEmpty);
    expect(main, isNot(contains("part '")));
    expect(main, isNot(contains('@@d4rtgen-rc2-factories@@')));
    expect(main, contains('Object? _rc2Box('));
    expect(main, contains('Object? _rc2Crate('));
    expect(main, contains('void registerGenericConstructors()'));
  });

  test('RS1-2: above the budget the RC-2 factories move into part files of '
      'the same library, unchanged [2026-11-13]', () async {
    final oneFile = File((await generate()).outputFile!).readAsStringSync();

    // Each factory is far above 10 bytes, so each gets a part of its own.
    final result = await generate(maxFileBytes: 10);
    final main = File(result.outputFile!).readAsStringSync();

    expect(partFilesOnDisk(), [
      'relaxers_part1.b.dart',
      'relaxers_part2.b.dart',
    ]);
    expect(result.partFiles.map(p.basename), [
      'relaxers_part1.b.dart',
      'relaxers_part2.b.dart',
    ]);
    expect(main, contains("part 'relaxers_part1.b.dart';"));
    expect(main, contains("part 'relaxers_part2.b.dart';"));
    expect(
      main.indexOf("part 'relaxers_part1.b.dart';"),
      greaterThan(main.lastIndexOf('import ')),
      reason: 'part directives follow every import',
    );
    expect(main, isNot(contains('@@d4rtgen-rc2-factories@@')));
    expect(rc2Functions(main), isEmpty, reason: 'no factory stays in main');
    expect(
      main,
      contains("D4.registerGenericConstructor('Box', '', _rc2Box);"),
    );

    final parts = [
      for (final f in result.partFiles) File(f).readAsStringSync(),
    ];
    for (final part in parts) {
      expect(part, contains("part of 'relaxers.b.dart';"));
      expect(part, contains('// ignore_for_file:'));
      expect(part, isNot(contains('import ')));
    }
    expect(rc2Functions(parts[0]), hasLength(1));
    expect(parts[0], contains('Object? _rc2Box('));
    expect(parts[1], contains('Object? _rc2Crate('));

    // The factories are the same text as in the one-file output.
    expect({
      for (final part in parts) ...rc2Functions(part),
    }, rc2Functions(oneFile));
  });

  test('RS1-3: a regeneration deletes the part files it no longer writes '
      '[2026-11-13]', () async {
    await generate(maxFileBytes: 10);
    expect(partFilesOnDisk(), hasLength(2));

    final stray = File(p.join(p.dirname(relaxerPath), 'relaxers_part7.b.dart'))
      ..writeAsStringSync('// stale');
    final other = File(p.join(p.dirname(relaxerPath), 'other_part1.b.dart'))
      ..writeAsStringSync('// not ours');

    final result = await generate();
    expect(result.partFiles, isEmpty);
    expect(partFilesOnDisk(), ['other_part1.b.dart']);
    expect(stray.existsSync(), isFalse);
    expect(other.existsSync(), isTrue, reason: 'only this file stem is ours');
  });

  test('RS1-4: relaxerPartFileName numbers parts beside the relaxer file '
      '[2026-11-13]', () {
    expect(
      relaxerPartFileName('flutter_relaxers.b.dart', 1),
      'flutter_relaxers_part1.b.dart',
    );
    expect(
      relaxerPartFileName('relaxers.b.dart', 12),
      'relaxers_part12.b.dart',
    );
  });
}
