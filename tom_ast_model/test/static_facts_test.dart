// ghissues69 — the static facts table (GitHub al-the-bear/tom_d4rt#18,
// option 3): its model and JSON codec. A resolving bundler writes it; a
// runtime reads it. It is optional and additive, and a table of another
// format reads as null rather than being misread.

import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_ast_model/tom_ast_model.dart';

/// `Map<String, int>` and its parts, interned the way a bundler does.
SStaticFacts _sample() {
  final b = SStaticFactsBuilder();
  final string = b.intern(
    const SFactType(
      kind: SFactTypeKind.interface,
      libraryUri: 'dart:core',
      name: 'String',
    ),
  );
  final integer = b.intern(
    const SFactType(
      kind: SFactTypeKind.interface,
      libraryUri: 'dart:core',
      name: 'int',
    ),
  );
  final map = b.intern(
    SFactType(
      kind: SFactTypeKind.interface,
      libraryUri: 'dart:core',
      name: 'Map',
      typeArguments: [string, integer],
    ),
  );
  b.add(
    'package:p/main.dart',
    120,
    18,
    SExtensionCallFact(
      receiverType: map,
      extensionLibraryUri: 'package:p/main.dart',
      extensionName: 'KeyKind',
      typeArguments: [string, integer],
    ),
  );
  b.add('package:p/main.dart', 40, 2, STypeArgumentsFact([string, integer]));
  b.add(
    'package:p/other.dart',
    7,
    9,
    STypeArgumentsFact([
      b.intern(const SFactType(kind: SFactTypeKind.dynamicType)),
    ]),
  );
  return b.build(
    const SFactsStamp(sdkVersion: '3.13.7', packages: {'intl': '0.20.3'}),
  );
}

void main() {
  group('ghissues69: SStaticFacts', () {
    test('GH69-M1: interning stores each type once [2026-11-17]', () {
      final b = SStaticFactsBuilder();
      const t = SFactType(
        kind: SFactTypeKind.interface,
        libraryUri: 'dart:core',
        name: 'String',
      );
      expect(b.intern(t), 0);
      expect(b.intern(t), 0);
      expect(
        b.intern(const SFactType(kind: SFactTypeKind.typeParameter, name: 'T')),
        1,
      );
      expect(b.isEmpty, isTrue);
    });

    test('GH69-M2: a table round-trips through JSON text [2026-11-17]', () {
      final facts = _sample();
      final text = jsonEncode(facts.toJson());
      final read = SStaticFacts.fromJson(
        jsonDecode(text) as Map<String, dynamic>,
      )!;
      expect(read.stamp, facts.stamp);
      expect(read.types, facts.types);
      expect(read.factCount, 3);
      expect(
        read.factAt('package:p/main.dart', 120, 18),
        facts.factAt('package:p/main.dart', 120, 18),
      );
      expect(
        read.factAt('package:p/main.dart', 40, 2),
        const STypeArgumentsFact([0, 1]),
      );
      final call = read.factAt('package:p/main.dart', 120, 18)!;
      expect(call, isA<SExtensionCallFact>());
      final map = read.type((call as SExtensionCallFact).receiverType);
      expect(map.name, 'Map');
      expect(
        [for (final a in map.typeArguments) read.type(a).name],
        ['String', 'int'],
      );
      expect(read.factAt('package:p/main.dart', 1, 1), isNull);
      expect(read.factAt('package:p/nowhere.dart', 40, 2), isNull);
    });

    test('GH69-M3: nullability, type parameters, function and record types '
        'and an unnamed extension survive [2026-11-17]', () {
      final b = SStaticFactsBuilder();
      final types = [
        const SFactType(
          kind: SFactTypeKind.interface,
          libraryUri: 'dart:core',
          name: 'int',
          nullable: true,
        ),
        const SFactType(kind: SFactTypeKind.typeParameter, name: 'T'),
        const SFactType(
          kind: SFactTypeKind.function,
          display: 'int Function(String)',
        ),
        const SFactType(
          kind: SFactTypeKind.record,
          display: '(int, {String a})',
        ),
        const SFactType(kind: SFactTypeKind.voidType),
        const SFactType(kind: SFactTypeKind.neverType),
      ];
      final indices = [for (final t in types) b.intern(t)];
      b.add(
        'm',
        0,
        1,
        SExtensionCallFact(
          receiverType: indices[0],
          extensionLibraryUri: 'package:p/e.dart',
        ),
      );
      final read = SStaticFacts.fromJson(
        jsonDecode(
              jsonEncode(
                b.build(const SFactsStamp(sdkVersion: '3.13.7')).toJson(),
              ),
            )
            as Map<String, dynamic>,
      )!;
      expect(read.types, types);
      expect(read.stamp.packages, isEmpty);
      final fact = read.factAt('m', 0, 1)! as SExtensionCallFact;
      expect(fact.extensionName, isNull);
      expect(fact.typeArguments, isEmpty);
    });

    test('GH69-M4: a table of another format reads as null; an unknown fact '
        'kind is refused [2026-11-17]', () {
      final json = _sample().toJson()..['format'] = SStaticFacts.format + 1;
      expect(SStaticFacts.fromJson(json), isNull);
      expect(
        () => SStaticFact.fromJson({'z': 1}),
        throwsA(isA<FormatException>()),
      );
    });

    test('GH69-M5: the JSON is compact - short keys, defaults left out '
        '[2026-11-17]', () {
      final json = jsonEncode(_sample().toJson());
      expect(json, contains('"k":"i"'));
      expect(json, isNot(contains('"q":false')));
      expect(json, isNot(contains('typeArguments')));
      expect(json, contains('"120:18"'));
    });
  });
}
