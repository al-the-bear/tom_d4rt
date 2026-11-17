// ghissues70 — tom_d4rt_ast uses a resolved bundle's static facts (GitHub
// al-the-bear/tom_d4rt#18, option B2, part 3).
//
// The fixture `fixtures/ghissues70_map_cases.bundle.json` is GitHub #18's
// map cases, bundled by tom_ast_generator in resolving mode with a stub for
// the host library (`tool/write_resolved_bundle_fixture.dart` there). The
// same code runs natively below, so the interpreted results are compared with
// Dart's own:
//
// * with the facts, the interpreter answers as native Dart: the extension's
//   type arguments come from the receiver's static type, the extension is the
//   one the static type picks, and literals, calls and creations get the type
//   arguments Dart inferred;
// * without them, and when their stamp does not agree with the host, it
//   approximates from run-time values as before (pinned below).

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

// ---------------------------------------------------------------------------
// The fixture's code, natively.
// ---------------------------------------------------------------------------

Map<String, int> _sameMap() => <String, int>{'x': 7};
Map<String, int> _emptyMap() => <String, int>{};

extension _KeyKind<K, V> on Map<K, V> {
  String keyKind() => K.toString();
}

extension _MapJsonExtension<K, V> on Map<K, V> {
  Object toJson() => K == String ? <String, Object?>{} : <Object?>[];
}

extension _WideKind on Map<dynamic, dynamic> {
  String kind() => 'wide';
}

extension _NarrowKind on Map<String, int> {
  String kind() => 'narrow';
}

String _typeOf<T>(T value) => '$T';

class _Box<T> {
  final T value;
  _Box(this.value);
  String get kind => '$T';
}

extension _ListKind<E> on List<E> {
  String keyKindOfList() => E.toString();
}

List<String> _native() {
  final Map<String, int> narrow = _sameMap();
  final Map<dynamic, dynamic> wide = narrow;
  final Map<String, int> emptyNarrow = _emptyMap();
  final Map<dynamic, dynamic> emptyWide = emptyNarrow;
  final Set<int> emptySet = {};
  final list = [1, 2];
  return [
    narrow.keyKind(),
    wide.keyKind(),
    {'x': 7}.keyKind(),
    emptyNarrow.toJson(),
    emptyWide.toJson(),
    <String, int>{}.toJson(),
    wide.kind(),
    narrow.kind(),
    // The interpreter's answer is what is compared, so the check stays.
    // ignore: unnecessary_type_check
    emptySet is Set<int>,
    list.keyKindOfList(),
    _typeOf(3),
    _Box('s').kind,
  ].map((e) => '$e').toList();
}

// ---------------------------------------------------------------------------
// The fixture, interpreted.
// ---------------------------------------------------------------------------

final _fixture = File(
  'test/runtime/fixtures/ghissues70_map_cases.bundle.json',
).readAsStringSync();

Map<String, dynamic> _json() => jsonDecode(_fixture) as Map<String, dynamic>;

/// The fixture as a resolving bundler wrote it: with its facts.
AstBundle _withFacts() => AstBundle.fromJson(_json());

/// The same bundle without the facts table.
AstBundle _withoutFacts() => AstBundle.fromJson(_json()..remove('facts'));

D4rtRunner _runner() => D4rtRunner()
  ..registerTopLevelFunction(
    'sameMap',
    (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
    'package:map_repro/native.dart',
  )
  ..registerTopLevelFunction(
    'emptyMap',
    (visitor, positional, named, typeArgs) => <String, int>{},
    'package:map_repro/native.dart',
  );

List<String> _run(D4rtRunner runner, AstBundle bundle) =>
    (runner.executeBundle(bundle) as List).cast<String>();

/// What tom_d4rt_ast answers without static facts: the receiver's run-time
/// value decides (2026-11-17). The differences from [_native]: an untyped
/// literal's keys (index 2), the extension Dart picks by static type (7), a
/// list literal's element type (9) and type arguments only Dart infers (10,
/// 11). Limitations doc, Lim-13.
const _approximated = [
  'String',
  'dynamic',
  'dynamic',
  '{}',
  '[]',
  '{}',
  'wide',
  'wide',
  'true',
  'dynamic',
  'T',
  'dynamic',
];

/// The fixture with its stamp's packages replaced by [packages].
AstBundle _stamped(Map<String, String> packages) {
  final json = _json();
  final facts = json['facts'] as Map<String, dynamic>;
  (facts['stamp'] as Map<String, dynamic>)['packages'] = packages;
  return AstBundle.fromJson(json);
}

void main() {
  group('ghissues70: GitHub #18 map cases, side by side with native Dart', () {
    test('GH70-1: with the static facts the interpreter answers as native '
        'Dart [2026-11-17]', () {
      final runner = _runner();
      expect(_run(runner, _withFacts()), _native());
      expect(runner.lastRunUsedStaticFacts, isTrue);
      expect(runner.lastStaticFactsMismatch, isNull);
      // The table as the bundler wrote it.
      expect(_native(), [
        'String',
        'dynamic',
        'String',
        '{}',
        '[]',
        '{}',
        'wide',
        'narrow',
        'true',
        'int',
        'int',
        'String',
      ]);
    });

    test('GH70-2: without them it approximates from run-time values, as '
        'before [2026-11-17]', () {
      final runner = _runner();
      expect(_run(runner, _withoutFacts()), _approximated);
      expect(runner.lastRunUsedStaticFacts, isFalse);
    });
  });

  group('ghissues70: the stamp check', () {
    test('GH70-3: another Dart SDK major.minor - the facts are ignored and '
        'the mismatch is reported once, naming both versions '
        '[2026-11-17]', () {
      final messages = <String>[];
      final runner = _runner()
        ..hostSdkVersion = '2.19.6 (stable) on "linux_x64"'
        ..onDiagnostic = messages.add;
      final bundle = _withFacts();
      expect(_run(runner, bundle), _approximated);
      expect(runner.lastRunUsedStaticFacts, isFalse);
      expect(
        runner.lastStaticFactsMismatch,
        allOf(contains('running on 2.19.6'), contains('bundled against 3.')),
      );
      expect(_run(runner, bundle), _approximated);
      expect(messages, hasLength(1));
      expect(messages.single, contains('2.19.6'));

      // The same bundle on a host that agrees uses them again.
      final agreeing = _runner()..hostSdkVersion = null;
      expect(_run(agreeing, bundle), _native());
      expect(agreeing.lastRunUsedStaticFacts, isTrue);
    });

    test('GH70-4: a stamped package the host bridges in another version - '
        'ignored; the same version, or a package the host does not name, '
        'is used [2026-11-17]', () {
      final bundle = _stamped({'map_repro': '1.0.0'});
      final other = _runner()..bridgedPackageVersions['map_repro'] = '1.1.0';
      expect(_run(other, bundle), _approximated);
      expect(
        other.lastStaticFactsMismatch,
        contains('package map_repro: bundled against 1.0.0, bridged 1.1.0'),
      );
      final same = _runner()..bridgedPackageVersions['map_repro'] = '1.0.0';
      expect(_run(same, bundle), _native());
      final unnamed = _runner();
      expect(_run(unnamed, bundle), _native());
    });

    test('GH70-5: the SDK patch level and a host that cannot tell its SDK '
        'are not compared [2026-11-17]', () {
      final bundle = _withFacts();
      final sdk = bundle.facts!.stamp.sdkVersion.split(' ').first;
      final parts = sdk.split('.');
      final patch = _runner()..hostSdkVersion = '${parts[0]}.${parts[1]}.999';
      expect(_run(patch, bundle), _native());
      final web = _runner()..hostSdkVersion = null;
      expect(_run(web, bundle), _native());
    });
  });

  group('ghissues70: the table in the bundle formats', () {
    test('GH70-6: JSON, bytes and ZIP carry the facts [2026-11-17]', () {
      final bundle = _withFacts();
      expect(bundle.facts, isNotNull);
      expect(bundle.facts!.factCount, greaterThan(0));
      for (final copy in [
        AstBundle.fromJson(
          jsonDecode(jsonEncode(bundle.toJson())) as Map<String, dynamic>,
        ),
        AstBundle.fromBytes(bundle.toBytes()),
        AstBundle.fromZip(bundle.toZip()),
      ]) {
        expect(copy.facts!.factCount, bundle.facts!.factCount);
        expect(copy.facts!.stamp, bundle.facts!.stamp);
        expect(_run(_runner(), copy), _native());
      }
      // A bundle without facts writes none.
      final plain = _withoutFacts();
      expect(plain.toJson().containsKey('facts'), isFalse);
      expect(AstBundle.fromZip(plain.toZip()).facts, isNull);
    });

    test('GH70-7: a table of another format, or an unreadable one, is '
        'dropped: the bundle loads and runs as without facts '
        '[2026-11-17]', () {
      final future = _json();
      (future['facts'] as Map<String, dynamic>)['format'] = 99;
      final broken = _json()..['facts'] = {'format': 1, 'types': 'x'};
      for (final json in [future, broken]) {
        final bundle = AstBundle.fromJson(json);
        expect(bundle.facts, isNull);
        expect(_run(_runner(), bundle), _approximated);
      }
    });
  });
}
