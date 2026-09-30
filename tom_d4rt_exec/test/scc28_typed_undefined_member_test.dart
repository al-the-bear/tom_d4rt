// EXEC PORT of `tom_d4rt/test/scc28_typed_undefined_member_test.dart`,
// WITHOUT ITS SOURCE SCAN (SCD88, closed by SCG3). F-SCC28-1 reads both
// mirrored interpreter visitors off disk, so a copy here would re-read the
// identical files and produce a duplicate failure, not a second measurement. It
// stays in tom_d4rt. Every other case runs a script or asks the published
// interpreter's types, and here runs through exec's pipeline. Recorded as a
// deliberate subtraction in `conformance_drift_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('SCC28: member absence is typed, not spelled', () {
    test('F-SCC28-2: the typed signal is a RuntimeD4rtException, so the '
        'surrounding handlers still catch it [2026-09-05]', () {
      // Subtyping is the whole migration strategy: had this been a sibling of
      // `RuntimeD4rtException` rather than a subtype, every one of the ~40
      // `on RuntimeD4rtException` clauses between a raise site and its sniffer
      // would have had to change in the same commit.
      final e = UndefinedMemberD4rtException(
        "Undefined property 'foo' on Bar.",
        memberName: 'foo',
      );
      expect(e, isA<RuntimeD4rtException>());
      expect(e, isA<D4rtException>());
      expect(e.memberName, 'foo');
      // Diagnostics are unchanged to the byte — SCB10's `toString()` is
      // inherited, so nothing that reads the message for a human moved.
      expect(e.toString(), "Runtime Error: Undefined property 'foo' on Bar.");
    });
  });

  group('SCC28: extension resolution still works through the typed signal', () {
    final d4rt = D4rt();

    dynamic run(String script) => d4rt.execute(source: script);

    test('F-SCC28-3: extension getter on an interpreted instance resolves via '
        'PropertyAccess [2026-09-05]', () {
      // Routes through the `visitPropertyAccess` sniffer.
      expect(
        run('''
        class Box { int v = 7; }
        extension BoxX on Box { int get doubled => v * 2; }
        main() { return Box().doubled; }
      '''),
        14,
      );
    });

    test('F-SCC28-4: extension method on an interpreted instance resolves via '
        'MethodInvocation [2026-09-05]', () {
      expect(
        run('''
        class Box { int v = 7; }
        extension BoxX on Box { int plus(int n) => v + n; }
        main() { return Box().plus(3); }
      '''),
        10,
      );
    });

    test('F-SCC28-5: extension getter on an enum value resolves '
        '[2026-09-05]', () {
      // The enum receiver has its own raise site (`InterpretedEnumValue.get`)
      // and its own pair of sniffers, separate from the instance ones.
      expect(
        run('''
        enum Status { active, done }
        extension StatusX on Status { String get label => 'S:\$name'; }
        main() { return Status.active.label; }
      '''),
        'S:active',
      );
    });

    test('F-SCC28-6: extension method on an enum value resolves '
        '[2026-09-05]', () {
      expect(
        run('''
        enum Status { active, done }
        extension StatusX on Status { String twice() => '\$name\$name'; }
        main() { return Status.done.twice(); }
      '''),
        'donedone',
      );
    });

    test('F-SCC28-7: extension member resolves through implicit `this` '
        '[2026-09-05]', () {
      // `visitSimpleIdentifier` — the one site that sniffed *both* wordings,
      // because an implicit-`this` receiver may be an interpreted instance
      // ("Undefined property") or a bridged one ("Undefined property or
      // method"). Both are the same type now, so one test covers the pair.
      expect(
        run('''
        class Box {
          int v = 4;
          int use() => tripled;
        }
        extension BoxX on Box { int get tripled => v * 3; }
        main() { return Box().use(); }
      '''),
        12,
      );
    });

    test('F-SCC28-8: a genuinely absent member still reports the same '
        'diagnostic [2026-09-05]', () {
      // The false branch. Nothing resolves it, so the failure has to survive
      // the typed signal and reach the host — with its wording intact, since
      // this is what a script author reads.
      expect(
        () => run('''
          class Box { int v = 1; }
          main() { return Box().missing; }
        '''),
        throwsA(
          predicate<Object>(
            (e) => e.toString().contains("Undefined property 'missing'"),
            'reports the absent member by name',
          ),
        ),
      );
    });

    test('F-SCC28-9: an inner failure naming the same member does not steal '
        'the extension branch [2026-09-05]', () {
      // FLIPPED BY SCD87, and the flip is the proof. This case was written
      // asserting the WRONG answer — `'extension'` — because a test demanding
      // the right one would simply have failed, and one accepting either would
      // have asserted nothing. Pinning the defect was the only honest way to
      // record it, on the understanding that the fix would invert the
      // expectation. It did.
      //
      // `Outer.tag` EXISTS. It runs, and its body fails because `Inner` has no
      // `tag`. The substring test could not tell "the member you asked for is
      // absent" from "the member ran and something inside it was absent"
      // whenever the two shared a name; nor could the typed signal alone, since
      // both failures are genuine `UndefinedMemberD4rtException`s carrying
      // `memberName == 'tag'`. What separates them is WHICH OBJECT the lookup
      // failed on, compared by identity: the caller holds `Outer()`, the
      // failure was raised for an `Inner`.
      const script = '''
          class Inner {}
          class Outer {
            String get tag => Inner().tag;
          }
          extension OuterX on Outer { String get tag => 'extension'; }
          main() { return Outer().tag; }
        ''';
      expect(
        () => run(script),
        throwsA(
          predicate<Object>(
            (e) => e.toString().contains("Undefined property 'tag' on Inner"),
            'propagates the failure from inside the getter, naming Inner',
          ),
        ),
        reason:
            'the extension must not answer for an error raised on a different '
            'receiver — before SCD87 this returned the string "extension"',
      );
    });

    test(
      'F-SCD86-1: a failed static lookup raises the typed signal and carries '
      'the member name [2026-09-14]',
      () {
        // The type SCD86 introduced, asserted where a reader will look for it.
        // Before this it existed only as plumbing between a raise site and one
        // branch, and nothing named it — which is how the wording it replaced
        // survived six raise sites and four different sentences.
        for (final source in const [
          'class Box { static int v = 1; }\nmain() { return Box.missing; }',
          'enum E { a }\nmain() { return E.missing; }',
        ]) {
          expect(
            () => run(source),
            throwsA(
              predicate<Object>(
                (e) =>
                    e is UndefinedStaticMemberD4rtException &&
                    e.memberName == 'missing',
                'raises UndefinedStaticMemberD4rtException naming `missing`',
              ),
            ),
            reason: source,
          );
        }
      },
    );

    test('F-SCD86-2: the static signal is what the compound-assignment branch '
        'asks for, and nothing else answers it [2026-09-14]', () {
      // The decision site SCD86 converted lives in the SimpleIdentifier case of
      // `visitAssignmentExpression` — bare `name op= value`, where the get/set
      // on implicit `this` failed. Its static clause is now a type test.
      //
      // A case driving that clause end to end is NOT here, and the reason is a
      // finding rather than an omission: no script reached it. Five shapes were
      // tried — a missing bare name in an instance method (takes the INSTANCE
      // clause, `UndefinedMemberD4rtException`), the same in a static method
      // ("Assigning to undefined variable"), a bare static name in an instance
      // method, an extension body, and `Box.missing += 1` (a PropertyAccess,
      // a different case entirely, raising "Cannot get value for compound
      // assignment on static member"). None produced an
      // `UndefinedStaticMemberD4rtException` at that site.
      //
      // So the clause may be dead. That is tracked as sce125_ainq, together with
      // the defect the same probe turned up: writing a static field by bare name
      // from an instance method updates a shadow, not the static. What this case
      // pins meanwhile is the half that IS reachable and that the conversion had
      // to preserve — the branch must not relabel a static-member failure as
      // "Assigning to undefined variable".
      expect(
        () => run(
          'class Box { static int v = 1; }\nmain() { Box.missing += 1; return 0; }',
        ),
        throwsA(
          predicate<Object>(
            (e) => !e.toString().contains('Assigning to undefined variable'),
            'does not relabel the failure as an undefined variable',
          ),
        ),
      );
    });

    test('F-SCD86-3: the instance and static signals stay distinguishable '
        '[2026-09-14]', () {
      // Why these are two types and not one. Instance-member absence gates
      // extension lookup; static-member absence gates the compound-assignment
      // fallback. If either type caught the other's failures, one branch would
      // answer for the other — the defect SCC28 removed, reintroduced through
      // the type system instead of through a message.
      expect(
        () => run('class Box { int v = 1; }\nmain() { return Box().missing; }'),
        throwsA(isNot(isA<UndefinedStaticMemberD4rtException>())),
      );
      expect(
        () => run(
          'class Box { static int v = 1; }\nmain() { return Box.missing; }',
        ),
        throwsA(isNot(isA<UndefinedMemberD4rtException>())),
      );
    });
    test('F-SCD87-1: the receiver survives a rewrap [2026-09-14]', () {
      // The one seam where the new discriminator could be erased silently.
      // `rewrapPreservingMemberSignal` rebuilds the exception at five wrapping
      // sites between a raise and the decision that reads it; if it dropped
      // `receiver`, every wrapped failure would look like a plain absence again
      // and the seven identity checks would simply stop matching — extension
      // lookup would quietly stop resolving through those paths rather than
      // failing loudly. Asserted directly because no script distinguishes "the
      // rewrap dropped it" from "this path never wraps".
      final receiver = Object();
      final original = UndefinedMemberD4rtException(
        'Undefined property \'tag\' on Thing.',
        memberName: 'tag',
        receiver: receiver,
      );

      final rewrapped = rewrapPreservingMemberSignal(original, 'wrapped');

      expect(rewrapped, isA<UndefinedMemberD4rtException>());
      final typed = rewrapped as UndefinedMemberD4rtException;
      expect(typed.memberName, 'tag');
      expect(
        identical(typed.receiver, receiver),
        isTrue,
        reason:
            'the same object, not an equal one — the checks use identical()',
      );
      expect(typed.message, contains('wrapped'));
    });
  });
}
