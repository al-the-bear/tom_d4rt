import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart' show RuntimeD4rtException;
import 'interpreter_test.dart' show execute;

/// SCD100 — a type alias means its target.
///
/// SCC33 gave both interpreters an explicit handler for type aliases that
/// returned null without recursing. That stopped seven further node types
/// reaching the dispatch backstop, and it made explicit a gap that had been
/// hidden: a typedef had no runtime representation at all. Its doc comment said
/// "making aliases actually resolve is separate work (SCD100)".
///
/// WHAT IT COST, measured before choosing a fix rather than assumed
///
/// Nineteen shapes were probed. Nine were already fine by leniency. The rest
/// split into two groups, and the first is the one worth leading with:
///
///   - **Seven legal programs THREW.** `1 is I` through `typedef I = int` did
///     not answer "no" — it raised `Type check failed: Undefined variable: I`.
///     So did a generic bound and a RETURN TYPE written through an alias:
///     `typedef I = int; I f() => 5;` reported `Type 'I' not found.` and the
///     program never ran.
///   - **Three accepted silently what Dart rejects** — an `as`, a parameter
///     bind and a local, all of which stay lenient when an annotation cannot be
///     resolved.
///
/// The handler was never even REACHED: the ordered declaration walk in
/// `d4rt_base.dart` had phases for enums, classes, extensions, extension types,
/// functions and variables, and none for type aliases. That is why the gap was
/// total rather than partial.
///
/// THE FIX IS ONE REGISTRATION, because every type-resolution path already
/// funnels through `environment.get(typeName)` — `is`/`as`, parameter binding,
/// the return check, generic bounds and a collection literal's type argument.
/// Binding the alias name to the RuntimeType its target resolves to makes each
/// of them behave exactly as if the script had written the target. A new phase
/// runs it to a FIXPOINT so declaration order does not matter, and it sits
/// after classes and before functions so an alias can name a class and a
/// function's annotations can name an alias.
///
/// `as` needed a second, separate touch: it does not resolve types at all, it
/// switches on the WRITTEN name, so an alias fell to its permissive `default:`
/// and cast anything to anything. The written name is now resolved through the
/// alias first — a no-op for every non-alias, since those resolve to their own
/// name.
///
/// THE HANDLER STILL DOES NOT RECURSE, which is the constraint SCC33 left and
/// the todo repeats: the target is read off the annotation by
/// `_resolveTypeAnnotationWithEnvironment`, never by `accept`ing a child, so no
/// type-level syntax reaches the backstop.
///
/// TWO LIMITS MEASURED AND LEFT, each with its reason:
///
///   - A generic bound written through an alias (`typedef N = num; T pick<T
///     extends N>(T)`) threw, because bounds are extracted in PASS 1, by
///     `DeclarationVisitor.visitFunctionDeclaration`, before any phase of pass
///     2 can have registered an alias. **CLOSED by sce130** — F-SCD100-11..16.
///     The repair was not the reorder this note anticipated. Pass 1 is the
///     PLACEHOLDER pass and is already lenient about an unresolvable RETURN
///     type on the very same declaration; the bound was the one strict thing
///     in it. Making it lenient there costs nothing, because pass 2 REBUILDS
///     the function once the alias fixpoint has run and that build is strict —
///     so the bound resolves, is enforced (F-SCD100-12), and a genuinely
///     undefined bound still stops the program (F-SCD100-15). A class needed
///     two further touches: the alias fixpoint now also runs BEFORE the class
///     pass, and a class's own bounds, which nothing re-extracts, are repaired
///     by `InterpretedClass.resolveDeferredTypeParameterBounds`.
///   - A local declared through an alias still accepts a mismatch. That is NOT
///     alias-specific: `int x = 'a'` is equally lenient, because local variable
///     declarations are not type-checked at all. SCC29 covers parameters and
///     SCD63 the for-each variable; locals are the third site nobody wrote —
///     sce131.
void main() {
  group('SCD100: a type alias resolves to its target', () {
    // ------------------------------------------------------------------
    // The seven that threw. These are legal programs that did not run.

    test('F-SCD100-1: `is` through an alias answers, instead of throwing '
        '[2026-09-14]', () {
      expect(execute('typedef I = int;\nmain() => 1 is I;'), isTrue);
      expect(execute("typedef I = int;\nmain() => 'a' is I;"), isFalse);
      expect(execute("typedef I = int;\nmain() => 'a' is! I;"), isTrue);
    });

    test('F-SCD100-2: including an alias to a generic or a class '
        '[2026-09-14]', () {
      expect(
        execute('typedef IL = List<int>;\nmain() => <int>[1] is IL;'),
        isTrue,
      );
      expect(
        execute('class C {}\ntypedef A = C;\nmain() => C() is A;'),
        isTrue,
      );
      expect(
        execute('class C {}\nclass D {}\ntypedef A = C;\nmain() => D() is A;'),
        isFalse,
      );
    });

    test('F-SCD100-3: a RETURN TYPE written through an alias runs '
        '[2026-09-14]', () {
      // Reported `Type 'I' not found.` — the whole program was unrunnable.
      expect(execute('typedef I = int;\nI f() => 5;\nmain() => f();'), 5);
    });

    test('F-SCD100-4: declaration order does not matter [2026-09-14]', () {
      // The fixpoint. `A` names `B`, which is declared after it.
      expect(
        execute('typedef A = B;\ntypedef B = int;\nmain() => 1 is A;'),
        isTrue,
      );
      // And an alias naming a class declared later.
      expect(
        execute('typedef A = C;\nclass C {}\nmain() => C() is A;'),
        isTrue,
      );
    });

    // ------------------------------------------------------------------
    // The three that accepted silently what Dart rejects.

    test(
      'F-SCD100-5: `as` through an alias rejects a mismatch [2026-09-14]',
      () {
        // `as` switches on the written name, so an alias fell to the permissive
        // default and returned the String. `'a' as int` already threw, which is
        // what said the leniency was alias-specific rather than general.
        expect(
          () => execute("typedef I = int;\nmain() => 'a' as I;"),
          throwsA(isA<TypeError>()),
        );
        // And still converts when the cast is good.
        expect(execute('typedef I = int;\nmain() => (1 as I) + 1;'), 2);
      },
    );

    test('F-SCD100-6: a parameter typed by an alias is checked at bind '
        '[2026-09-14]', () {
      // SCC29 checks a declared parameter type; through an alias the
      // annotation did not resolve, so the check waved everything through.
      expect(execute('typedef I = int;\nint f(I x) => x;\nmain() => f(1);'), 1);
      expect(
        () => execute("typedef I = int;\nint f(I x) => 1;\nmain() => f('a');"),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => execute(
          'class C {}\nclass D {}\ntypedef A = C;\n'
          'int f(A x) => 1;\nmain() => f(D());',
        ),
        throwsA(isA<TypeError>()),
      );
    });

    // ------------------------------------------------------------------
    // The nine that already worked. Pinned because the fix reaches the same
    // paths, and a regression here would be the fix making things worse.

    test(
      'F-SCD100-7: the shapes that already worked still do [2026-09-14]',
      () {
        expect(execute('typedef I = int;\nmain() { I x = 7; return x; }'), 7);
        expect(execute('typedef I = int;\nmain() => <I>[1, 2].length;'), 2);
        expect(
          execute(
            'typedef IntCb = int Function(int);\n'
            'int apply(IntCb cb) => cb(1);\n'
            'main() => apply((int x) => x + 1);',
          ),
          2,
        );
        expect(
          execute(
            'class C {}\ntypedef A = C;\nint f(A x) => 1;\nmain() => f(C());',
          ),
          1,
        );
      },
    );

    test('F-SCD100-8: a non-alias program is unaffected [2026-09-14]', () {
      // The `as` change resolves the written name through the environment, so
      // these say it is a no-op when the name is not an alias.
      expect(execute("main() => (1 as int) + 1;"), 2);
      expect(() => execute("main() => 'a' as int;"), throwsA(isA<TypeError>()));
      expect(execute('class C {}\nmain() => (C() as C) is C;'), isTrue);
      expect(execute('main() => 1 is int;'), isTrue);
    });

    // ------------------------------------------------------------------
    // The limits, pinned so they read as decisions rather than oversights.

    test(
      'F-SCD100-9: a GENERIC alias is deliberately not bound [2026-09-14]',
      () {
        // `typedef L<T> = List<T>` needs its argument substituted per use site.
        // Binding it here would bind `T` to nothing and answer confidently
        // wrong, which is worse than the leniency it would replace. It stays
        // lenient — the annotation does not resolve, so nothing is rejected.
        expect(
          execute(
            'typedef L<T> = List<T>;\nint f(L<int> xs) => xs.length;\n'
            'main() => f(<int>[1, 2]);',
          ),
          2,
        );
      },
    );

    test('F-SCD100-10: a local through an alias is checked, as a local '
        'without one is [2026-09-14]', () {
      // NOT alias-specific, which is why it was out of scope here: `int x = 'a'`
      // was equally lenient. SCE103 closed the local-declaration site — the
      // fourth and last, after SCC29's parameters, SCC18's typed patterns and
      // SCD63's for-each variable — and the alias comes along because the
      // annotation is resolved before it is compared, which is the property
      // this file exists to hold.
      //
      // The pair is the point: the alias must behave exactly as the bare name,
      // in whichever direction that is.
      for (final source in [
        "typedef I = int;\nmain() { I x = 'a'; return x; }",
        "main() { int x = 'a'; return x; }",
      ]) {
        expect(
          () => execute(source),
          throwsA(
            isA<TypeError>().having(
              (e) => e.toString(),
              'message',
              "type 'String' is not a subtype of type 'int' of 'x'",
            ),
          ),
          reason: source,
        );
      }
    });
    // ------------------------------------------------------------------
    // sce130: the first of the two limits above, now closed.

    test('F-SCD100-11: a generic BOUND written through an alias runs '
        '[2026-09-22]', () {
      // The shape this file recorded as a standing limit. It threw
      // `Undefined variable: N`, because bounds are resolved in pass 1 and
      // aliases are registered in pass 2.
      expect(
        execute(r"""
        typedef N = num;
        T pick<T extends N>(T v) => v;
        main() => pick(3);
      """),
        3,
      );
    });

    test('F-SCD100-12: the bound is ENFORCED through the alias, not merely '
        'skipped [2026-09-22]', () {
      // The discriminator between the fix and a retreat. Making an
      // unresolvable bound lenient would also let this program run, which is
      // why the pair is tested rather than -11 alone: leniency lives in pass
      // 1, and pass 2 REBUILDS the function once the alias exists, so the
      // bound is real by the time anything consults it.
      expect(
        () => execute(r"""
          typedef N = num;
          T pick<T extends N>(T v) => v;
          main() => pick<String>('a');
        """),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains("does not satisfy bound 'num'"),
          ),
        ),
      );
      // ... and a satisfying argument still binds.
      expect(
        execute(r"""
        typedef N = num;
        T pick<T extends N>(T v) => v;
        main() => pick<int>(3);
      """),
        3,
      );
    });

    test('F-SCD100-13: every alias TARGET reaches a bound — core type, script '
        'class, bridged type, another alias [2026-09-22]', () {
      // One mechanism, so one test: the bound resolves through whatever the
      // alias names. All four threw before.
      expect(
        execute(r"""
        typedef N = num;
        T pick<T extends N>(T v) => v;
        main() => pick(3);
      """),
        3,
      );
      expect(
        execute(r"""
        class C { int get x => 7; }
        typedef A = C;
        T pick<T extends A>(T v) => v;
        main() => pick(C()).x;
      """),
        7,
      );
      expect(
        execute(r"""
        typedef D = DateTime;
        T pick<T extends D>(T v) => v;
        main() => pick(DateTime(2020)).year;
      """),
        2020,
      );
      expect(
        execute(r"""
        typedef N = num;
        typedef M = N;
        T pick<T extends M>(T v) => v;
        main() => pick(3);
      """),
        3,
      );
    });

    test('F-SCD100-14: a CLASS and a METHOD type parameter get the same '
        'treatment [2026-09-22]', () {
      // A method's bounds are resolved when its class is populated, and a
      // class's own bounds are resolved in pass 1 and never re-extracted —
      // two more places the alias had not reached. The class case needs an
      // explicit type argument for a reason that is NOT alias-specific: a
      // bounded class with no written argument infers `dynamic` and fails its
      // own bound, and `class Box<T extends num>` does exactly the same
      // (scf27).
      expect(
        execute(r"""
        typedef N = num;
        class Holder { T pick<T extends N>(T v) => v; }
        main() => Holder().pick(3);
      """),
        3,
      );
      expect(
        execute(r"""
        typedef N = num;
        class Box<T extends N> { final T v; Box(this.v); }
        main() => Box<int>(3).v;
      """),
        3,
      );
      expect(
        () => execute(r"""
          typedef N = num;
          class Box<T extends N> { final T v; Box(this.v); }
          main() => Box<String>('a').v;
        """),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains("does not satisfy bound 'num'"),
          ),
        ),
      );
    });

    test('F-SCD100-15: a genuinely undefined bound is still reported '
        '[2026-09-22]', () {
      // ANTI-VACUITY, and the reason pass 2 stays strict. `Nope` is not an
      // alias anyone forgot to register; it is not defined at all, and the
      // program must not start. Both the function and the class route.
      for (final source in [
        'T pick<T extends Nope>(T v) => v;\nmain() => pick(3);',
        'class Box<T extends Nope> { final T v; Box(this.v); }\n'
            'main() => Box<int>(3).v;',
      ]) {
        expect(
          () => execute(source),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.toString(),
              'message',
              contains('Nope'),
            ),
          ),
          reason: source,
        );
      }
    });

    test(
      'F-SCD100-16: declaration order still does not matter [2026-09-22]',
      () {
        // The fixpoint runs twice now — once before classes, once before
        // functions — so an alias written BELOW the function that bounds on it
        // still binds.
        expect(
          execute(r"""
        T pick<T extends N>(T v) => v;
        typedef N = num;
        main() => pick(3);
      """),
          3,
        );
      },
    );
  });
}
