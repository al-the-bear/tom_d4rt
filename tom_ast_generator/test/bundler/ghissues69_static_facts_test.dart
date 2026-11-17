// ghissues69 — the static facts table (GitHub al-the-bear/tom_d4rt#18,
// option 3 / B2, part 2).
//
// With `AstBundlerConfig(resolve: true)` the bundler records, from the
// analyzer's resolved units, the static receiver type, extension and type
// arguments of every extension member access, and the inferred type
// arguments of generic calls, instance creations and collection literals
// that do not write them. The bundle is then a `ResolvedAstBundle`, whose
// JSON carries the table under the optional `facts` key. A reader that does
// not know the key - the published tom_d4rt_ast this package resolves - reads
// and runs the bundle as before.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle, D4rtRunner;

const _resolve = AstBundlerConfig(resolve: true);

const _entry = 'package:map_repro/entry.dart';

/// GitHub #18's repro: a typed local from a host function registered only at
/// run time.
const _repro = '''
import 'package:map_repro/native.dart';

extension KeyKind<K, V> on Map<K, V> {
  String keyKind() => K.toString();
}

Object main() {
  final Map<String, int> narrow = sameMap();
  return narrow.keyKind();
}
''';

const _nativeStub = '''
Map<String, int> sameMap() => throw UnimplementedError();
''';

/// Inferred type arguments, and the written ones that get no fact.
const _inferred = '''
T identity<T>(T value) => value;

class Box<T> {
  final T value;
  Box(this.value);
}

Object main() {
  final list = [1, 2];
  final map = {'a': 1.5};
  final set = {'x'};
  final box = Box('s');
  final same = identity(3);
  final written = <int>[1];
  final explicit = identity<String>('t');
  return [list, map, set, box.value, same, written, explicit].length;
}
''';

/// A program both readers can run: the extension on a typed local.
const _runnable = '''
extension KeyKind<K, V> on Map<K, V> {
  String keyKind() => K.toString();
}

Object main() {
  final Map<String, int> narrow = {'a': 1};
  return narrow.keyKind();
}
''';

/// The `offset:length` key of [snippet]'s first occurrence in [source].
(int, int) _at(String source, String snippet) {
  final offset = source.indexOf(snippet);
  expect(offset, isNot(-1), reason: snippet);
  return (offset, snippet.length);
}

SStaticFact? _fact(SStaticFacts facts, String module, String source, String s) {
  final (offset, length) = _at(source, s);
  return facts.factAt(module, offset, length);
}

/// The type a fact's index names, written out (`Map<String, int>`).
String _name(SStaticFacts facts, int index) {
  final type = facts.type(index);
  final name = type.name ?? type.display ?? type.kind.name;
  if (type.typeArguments.isEmpty) return name;
  return '$name<${[for (final a in type.typeArguments) _name(facts, a)].join(', ')}>';
}

List<String> _args(SStaticFacts facts, SStaticFact? fact) => switch (fact) {
  STypeArgumentsFact(:final typeArguments) => [
    for (final a in typeArguments) _name(facts, a),
  ],
  SExtensionCallFact(:final typeArguments) => [
    for (final a in typeArguments) _name(facts, a),
  ],
  null => fail('no fact'),
};

void main() {
  // One resolver for the suite: the SDK is looked up once.
  final resolver = AstResolver();

  Future<AstBundle> bundle(
    String source, {
    String entry = _entry,
    Map<String, String> stubs = const {},
    Set<String> bridged = const {},
    AstBundlerConfig config = _resolve,
  }) => AstBundler(
    bridgedLibraries: bridged,
    explicitSources: {entry: source},
    declarationStubs: stubs,
    fileAccessValidator: (_) => false,
    config: config,
    resolver: resolver,
  ).createFromSource(source, sourcePath: entry);

  group('ghissues69: the facts a resolving bundle records', () {
    test('GH69-1: #18 - the extension call on a typed local records its '
        'receiver type, extension and type arguments [2026-11-17]', () async {
      final b = await bundle(
        _repro,
        stubs: {'package:map_repro/native.dart': _nativeStub},
        bridged: {'package:map_repro/native.dart'},
      );
      expect(b, isA<ResolvedAstBundle>());
      final facts = (b as ResolvedAstBundle).facts;
      final call = _fact(facts, _entry, _repro, 'narrow.keyKind()');
      expect(call, isA<SExtensionCallFact>());
      call as SExtensionCallFact;
      expect(_name(facts, call.receiverType), 'Map<String, int>');
      expect(call.extensionLibraryUri, _entry);
      expect(call.extensionName, 'KeyKind');
      expect(_args(facts, call), ['String', 'int']);
      // The stub's library is not bundled, and only stamped packages count.
      expect(b.modules.keys, [_entry]);
    });

    test(
      'GH69-2: inferred type arguments of literals, instance creations '
      'and generic calls; none where they are written [2026-11-17]',
      () async {
        final b = await bundle(_inferred) as ResolvedAstBundle;
        final facts = b.facts;
        String at(String s) =>
            _args(facts, _fact(facts, _entry, _inferred, s)).join(', ');
        expect(at('[1, 2]'), 'int');
        expect(at("{'a': 1.5}"), 'String, double');
        expect(at("{'x'}"), 'String');
        expect(at("Box('s')"), 'String');
        expect(at('identity(3)'), 'int');
        expect(_fact(facts, _entry, _inferred, '<int>[1]'), isNull);
        expect(
          _fact(facts, _entry, _inferred, "identity<String>('t')"),
          isNull,
        );
        // A list of the locals: inferred too, an `Object` element type.
        expect(
          at('[list, map, set, box.value, same, written, explicit]'),
          'Object',
        );
      },
    );

    test('GH69-3: without a stub, a typed local still names its receiver; '
        'an untyped one from a runtime-only library cannot and gets no fact '
        '[2026-11-17]', () async {
      final typed =
          await bundle(_repro, bridged: {'package:map_repro/native.dart'})
              as ResolvedAstBundle;
      final call =
          _fact(typed.facts, _entry, _repro, 'narrow.keyKind()')
              as SExtensionCallFact;
      expect(_name(typed.facts, call.receiverType), 'Map<String, int>');

      final untyped = _repro.replaceFirst(
        'final Map<String, int> narrow',
        'final narrow',
      );
      final b = await bundle(
        untyped,
        bridged: {'package:map_repro/native.dart'},
      );
      final facts = b is ResolvedAstBundle ? b.facts : null;
      expect(
        facts == null
            ? null
            : _fact(facts, _entry, untyped, 'narrow.keyKind()'),
        isNull,
      );
    });

    test('GH69-4: no table without resolve, with staticFacts: false, or '
        'without a fact [2026-11-17]', () async {
      expect(
        await bundle(_inferred, config: const AstBundlerConfig()),
        isNot(isA<ResolvedAstBundle>()),
      );
      expect(
        await bundle(
          _inferred,
          config: const AstBundlerConfig(resolve: true, staticFacts: false),
        ),
        isNot(isA<ResolvedAstBundle>()),
      );
      expect(
        await bundle('Object main() => 1;'),
        isNot(isA<ResolvedAstBundle>()),
      );
    });

    test(
      'GH69-5: the stamp names the SDK the analyzer ran on [2026-11-17]',
      () async {
        final b = await bundle(_inferred) as ResolvedAstBundle;
        final sdk = File(
          p.join(resolver.dartSdk, 'version'),
        ).readAsStringSync().trim();
        expect(b.facts.stamp.sdkVersion, sdk);
        // Only dart: types here - no package to stamp.
        expect(b.facts.stamp.packages, isEmpty);
      },
    );
  });

  group('ghissues69: the table in the bundle bytes', () {
    test('GH69-6: toBytes carries the table and readFacts reads it back '
        '[2026-11-17]', () async {
      final b = await bundle(_inferred) as ResolvedAstBundle;
      final read = ResolvedAstBundle.readFacts(b.toBytes())!;
      expect(read.stamp, b.facts.stamp);
      expect(read.types, b.facts.types);
      expect(read.factCount, b.facts.factCount);
      expect(
        read.factAt(_entry, _inferred.indexOf('[1, 2]'), 6),
        b.facts.factAt(_entry, _inferred.indexOf('[1, 2]'), 6),
      );
      // A plain bundle's bytes have none.
      final plain = await bundle(_inferred, config: const AstBundlerConfig());
      expect(ResolvedAstBundle.readFacts(plain.toBytes()), isNull);
    });

    test(
      'GH69-7: an old reader ignores the table - the published '
      'tom_d4rt_ast reads and runs the bundle as without it [2026-11-17]',
      () async {
        final resolved = await bundle(_runnable) as ResolvedAstBundle;
        expect(resolved.facts.factCount, greaterThan(0));
        final plain = await bundle(_runnable, config: const AstBundlerConfig());

        final read = AstBundle.fromBytes(resolved.toBytes());
        expect(read.entryPointUri, _entry);
        expect(read.modules.keys, [_entry]);
        expect(
          D4rtRunner().executeBundle(read),
          D4rtRunner().executeBundle(AstBundle.fromBytes(plain.toBytes())),
        );
        // The format version stays: the key is additive.
        expect(resolved.toJson()['version'], plain.toJson()['version']);
      },
    );
  });

  group('ghissues69: facts in a project', () {
    late Directory project;

    setUp(() {
      project = Directory.systemTemp.createTempSync('gh69_project_');
      File(p.join(project.path, 'pubspec.yaml')).writeAsStringSync(
        'name: gh69proj\nversion: 1.2.3\nenvironment:\n  sdk: ^3.10.0\n',
      );
      File(p.join(project.path, '.dart_tool', 'package_config.json'))
        ..createSync(recursive: true)
        ..writeAsStringSync('''
{
  "configVersion": 2,
  "packages": [
    {"name": "gh69proj", "rootUri": "../", "packageUri": "lib/", "languageVersion": "3.10"}
  ]
}
''');
      File(p.join(project.path, 'lib', 'shapes.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync('''
class Shape {}
extension Area on Shape {
  double get area => 1.0;
}
''');
    });

    tearDown(() => project.deleteSync(recursive: true));

    test('GH69-8: createFromFile records facts and stamps the package a '
        'recorded type comes from with its version [2026-11-17]', () async {
      const source = '''
import 'package:gh69proj/shapes.dart';
Object main() {
  final shapes = [Shape()];
  return shapes.first.area;
}
''';
      final file = File(p.join(project.path, 'bin', 'main.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync(source);
      final b =
          await AstBundler(
                packageName: 'gh69proj',
                projectRoot: project.path,
                config: _resolve,
                resolver: resolver,
              ).createFromFile(file.path)
              as ResolvedAstBundle;
      final facts = b.facts;
      final module = b.entryPointUri;
      final area = _fact(facts, module, source, 'shapes.first.area');
      expect(area, isA<SExtensionCallFact>());
      area as SExtensionCallFact;
      expect(_name(facts, area.receiverType), 'Shape');
      expect(area.extensionLibraryUri, 'package:gh69proj/shapes.dart');
      expect(area.extensionName, 'Area');
      expect(_args(facts, _fact(facts, module, source, '[Shape()]')), [
        'Shape',
      ]);
      expect(facts.stamp.packages, {'gh69proj': '1.2.3'});
    });
  });
}
