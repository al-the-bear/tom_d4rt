@TestOn('vm')
library;

// SCD132/AST — a bare name prefix is not evidence of a bridge relationship.
//
// `Environment.toBridgedClass` ends in a prefix fallback (PASS B): if no exact,
// nativeNames or suffix rule matched anywhere in the scope chain, it claimed
// any registered bridge whose name was a >=3-character prefix of the native
// type name. Nothing else was asked.
//
// TWO OF THE THREE FALSE POSITIVES THE METHOD'S OWN HEADER DOCUMENTS ARE THAT
// RULE FIRING: `MappedListIterable` claimed by `Map`, and `TextDirection`
// claimed by `Text`. Each was repaired by routing ONE caller around PASS B —
// SCC46 made `getRuntimeType` consult the bridged-enum registry first — so the
// rule survived every fix and the next name-shaped coincidence was always going
// to be claimed just as silently. A bridge named `Set` claims `Settings`; one
// named `Col` claims `Color`.
//
// SO THE PREFIX NOW ONLY FINDS A CANDIDATE. The bridge must also DECLARE the
// connection: `nativeNames` naming the type, or a supertype-registry edge
// between the two names. Both are things somebody wrote down. When nothing
// corroborates, `toBridgedClass` throws — which every caller already handles,
// and which is more honest than a silently wrong dispatch.
//
// MEASURED BEFORE NARROWING, because "expect fallout" deserved a number. A
// probe on every PASS B match across both trees' full suites fired 12 times:
// 11 for one test's deliberately prefix-named proxy, and once for
// `TextDirection` → `Text`, the known false positive. G-DCLI-05's
// `ProgressBothImpl` → `Progress` — the case PASS B was ADDED for — never
// reached it: PASS A resolves it today. The rule had no measured legitimate
// user, and the one test that relied on it now declares `nativeNames`, which is
// the relationship becoming declared instead of guessed.
//
// F-SCD132-AST-4 IS WHY THIS IS A NARROWING AND NOT A DELETION. Removing PASS B
// outright would pass the first three cases here. The fourth fails, because
// PASS A's exact and suffix rules are untouched and must stay that way.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class Text {}

class TextDirection {}

class Progress {}

class ProgressBothImpl {}

class Widget {}

class WidgetPanel {}

class CastList<T> {}

void main() {
  group('SCD132/AST: a prefix match needs corroboration', () {
    late Environment env;

    setUp(() {
      // The registry is the subject, so it is built directly rather than
      // through a script run — `toBridgedClass` is a resolver over what is
      // registered, and a script would only add a parser between the two.
      env = Environment();
    });

    void register(BridgedClass definition) => env.defineBridge(definition);

    test(
      'F-SCD132-AST-1: an UNCORROBORATED prefix no longer resolves [2026-09-15]',
      () {
        // The SCC46 shape: a `Text` bridge and an unrelated `TextDirection`.
        register(BridgedClass(nativeType: Text, name: 'Text'));
        expect(
          () => env.toBridgedClass(TextDirection),
          throwsA(isA<RuntimeD4rtException>()),
          reason:
              'A bridge named Text claimed TextDirection on the shared prefix '
              'alone. That is the false positive SCC46 routed one caller '
              'around; it is now refused at the source.',
        );
      },
    );

    test(
      'F-SCD132-AST-2: a prefix corroborated by nativeNames resolves [2026-09-15]',
      () {
        // G-DCLI-05's shape, made explicit: the bridge says it speaks for the
        // implementation type.
        register(
          BridgedClass(
            nativeType: Progress,
            name: 'Progress',
            nativeNames: const ['ProgressBothImpl'],
          ),
        );
        expect(env.toBridgedClass(ProgressBothImpl).name, equals('Progress'));
      },
    );

    test(
      'F-SCD132-AST-3: a prefix corroborated by the supertype registry resolves '
      '[2026-09-15]',
      () {
        register(BridgedClass(nativeType: Widget, name: 'Widget'));
        BridgedClass.registerSupertypes({
          'WidgetPanel': ['Widget'],
        });
        expect(
          env.toBridgedClass(WidgetPanel).name,
          equals('Widget'),
          reason:
              'The registry records the edge, so the prefix is corroborated by '
              'a hierarchy somebody declared rather than by the spelling.',
        );
      },
    );

    test('F-SCD132-AST-4 (control): PASS A is untouched — a suffix match still '
        'resolves with no corroboration [2026-09-15]', () {
      // `CastList<int>` ends with the bridge name `List`, and PASS A's suffix
      // rule claims it with no `nativeNames` and no registry edge. That rule is
      // NOT what this change narrows: it is structural rather than
      // coincidental, and carries its own specificity handling (SCC49's
      // longest-suffix win, so `_BodyBoxConstraints` reaches `BoxConstraints`
      // rather than `Constraints`).
      //
      // It is the case that separates a narrowing from a deletion. Removing
      // PASS B outright leaves -1 passing and -2/-3 failing; weakening PASS A
      // instead leaves -1/-2/-3 passing and this one failing. Only the actual
      // change passes all four.
      register(BridgedClass(nativeType: Object, name: 'List'));
      expect(env.toBridgedClass(CastList<int>).name, equals('List'));
    });
  });
}
