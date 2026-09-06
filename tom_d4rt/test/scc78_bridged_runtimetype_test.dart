// SCC78 — `runtimeType` on a bridged instance answered from the wrapper.
//
// THE DEFECT
//
// For any value the interpreter represents as a `BridgedInstance`,
// `visitPropertyAccess` intercepted `runtimeType` and returned
// `target.runtimeType` — where `target` is the WRAPPER. Every such value
// therefore reported `BridgedInstance<Object>`, and the `runtimeType` getter
// the bridge itself declares was never consulted, even though most bridges
// declare one that returns the right answer.
//
// The interception sat in a `switch` ahead of the getter-adapter lookup, so no
// bridge could override it. Primitives and collections were unaffected — they
// are not wrapped — which is why the defect reads as "some types are fine".
//
// WHY THE OBVIOUS ASSERTION DOES NOT WORK, and what is used instead.
//
// SCC78 proposed `StringBuffer().runtimeType == StringBuffer` on the reasoning
// that an identity check is the one shape a wrapper name cannot satisfy.
// Measured, that comparison is FALSE for every type in this interpreter,
// including ones whose `runtimeType` is already correct:
//
//     "x".runtimeType == String   => false
//     1.runtimeType   == int      => false
//
// A bare type name does not evaluate to the same object a `runtimeType` read
// returns, so the assertion cannot distinguish fixed from broken — it fails in
// both states. That is a separate defect, filed as its own todo.
//
// The discriminator used here needs no type literal and no type NAME:
//
//     StringBuffer().runtimeType == Duration(seconds: 1).runtimeType
//
// Two unrelated classes must not share a runtime type. While the wrapper
// answered, both were `BridgedInstance<Object>` and this was TRUE. It is the
// assertion a wrapper cannot satisfy, and it stays meaningful whatever the
// types are called.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String body, {String imports = ''}) async {
  const path = 'd4rt-mem:/scc78_runtimetype.dart';
  final d4rt = D4rt();
  d4rt.grant(FilesystemPermission.any);
  return await d4rt.execute(
    library: path,
    name: 'main',
    sources: {path: '$imports\nFuture<Object?> main() async {\n$body\n}\n'},
  );
}

void main() {
  group('SCC78: a bridged instance reports its own type', () {
    test('F-SCC78-1: two unrelated bridged types do not share a runtimeType '
        '[2026-09-06]', () async {
      // The load-bearing case. Needs no type name and no type literal, so it
      // cannot be satisfied by a wrapper however the wrapper is spelled.
      expect(
        await _run(
          'return StringBuffer().runtimeType == '
          'Duration(seconds: 1).runtimeType;',
        ),
        isFalse,
      );
    });

    test('F-SCC78-2: two instances of one bridged type DO share a runtimeType '
        '[2026-09-06]', () async {
      // The other half, without which F-SCC78-1 could be satisfied by making
      // every runtimeType distinct — which would be just as wrong.
      expect(
        await _run(
          'return StringBuffer().runtimeType == StringBuffer().runtimeType;',
        ),
        isTrue,
      );
    });

    test('F-SCC78-3: StringBuffer names itself [2026-09-06]', () async {
      expect(
        await _run('return StringBuffer().runtimeType.toString();'),
        equals('StringBuffer'),
      );
    });

    test('F-SCC78-4: Object names itself [2026-09-06]', () async {
      expect(
        await _run('return Object().runtimeType.toString();'),
        equals('Object'),
      );
    });

    test('F-SCC78-5: Duration names itself [2026-09-06]', () async {
      expect(
        await _run('return Duration(seconds: 1).runtimeType.toString();'),
        equals('Duration'),
      );
    });

    test('F-SCC78-6: a dart:io value reports a real type, not the wrapper '
        '[2026-09-06]', () async {
      // `File('x').runtimeType` is `_File` in the SDK — a private
      // implementation name. It is deliberately not pinned here: SCC24
      // established that naming an SDK-private type trades this bug for a
      // version-fragility bug. What is asserted is that the answer is NOT the
      // wrapper, and that two different io types disagree.
      final result = await _run('''
        final a = File('x').runtimeType.toString();
        final b = Directory('x').runtimeType.toString();
        return [a, b, a == b];
      ''', imports: "import 'dart:io';");
      expect(result, isA<List<Object?>>());
      final values = result! as List<Object?>;
      expect(values[0], isNot(contains('BridgedInstance')));
      expect(values[1], isNot(contains('BridgedInstance')));
      expect(values[2], isFalse, reason: 'File and Directory must differ');
    });
  });

  group('SCC78: the values that were already right stay right', () {
    // Primitives and collections are never wrapped, so they never took the
    // wrapper branch. Pinned because the fix moves code on the shared
    // property-access path, and "did not break the working cases" is exactly
    // what a fix on a shared path has to show.
    test(
      'F-SCC78-7: String, int and List keep their type names [2026-09-06]',
      () async {
        expect(
          await _run('return "x".runtimeType.toString();'),
          equals('String'),
        );
        expect(await _run('return 1.runtimeType.toString();'), equals('int'));
        expect(
          await _run('return <int>[].runtimeType.toString();'),
          equals('List<Object?>'),
        );
      },
    );

    test('F-SCC78-8: String and int still disagree [2026-09-06]', () async {
      expect(await _run('return "a".runtimeType == 1.runtimeType;'), isFalse);
      expect(await _run('return "a".runtimeType == "b".runtimeType;'), isTrue);
    });
  });
}
