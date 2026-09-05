import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCB11 — the symbol literal `#foo`.
///
/// Neither interpreter had a `visitSymbolLiteral`, so `SymbolLiteral` fell
/// through `GeneralizingAstVisitor`'s default and every symbol literal
/// evaluated to **null**. That is the worst shape a gap can have: it is
/// silent. There was no "unsupported node" error to point at the literal, so
/// `Invocation.method(#foo, [])` died several frames downstream with
/// `type 'Null' is not a subtype of type 'Symbol' in type cast` — an error
/// that accuses the bridge. SC5's tests write `Symbol('foo')` throughout for
/// exactly this reason; that explicit form always worked.
///
/// Two things about symbols are easy to get wrong and are asserted here
/// rather than assumed:
///
/// **1. `Symbol('foo')` really does equal `#foo`.** The fix builds a
/// *non-const* `Symbol` from the literal's components, which would be wrong if
/// symbol identity were reference-based — a const-canonicalised `#foo` and a
/// freshly constructed `Symbol('foo')` are different objects. They compare
/// equal because `Symbol` overrides `==` and `hashCode` on its name. That is
/// what makes the one-line fix sufficient, and it is what makes a symbol usable
/// as a Map key across the const/non-const boundary.
///
/// **2. The dotted form is one name, not a path.** `#foo.bar.baz` is a single
/// library-qualified symbol whose name is the string `'foo.bar.baz'` — it is
/// not a member access on `#foo`. The components therefore have to be joined
/// with `.` rather than resolved.
///
/// **Audit of the rest of the visitor.** Because a silent gap is only findable
/// by looking, every node that can be reached in *expression* position was
/// checked against both interpreters — the 45 `Expression` subtypes, walked
/// through the `GeneralizingAstVisitor` chain so that a handler on a supertype
/// counts as coverage. `SymbolLiteral` was the only one with no handler. The
/// two apparent misses are not misses: the abstract bases (`Expression`,
/// `Literal`, `TypedLiteral`, `InvocationExpression`) are never instantiated,
/// and `NamedExpression` is grammatically confined to an `ArgumentList`, which
/// both trees evaluate field-wise rather than by dispatch.
///
/// What the audit does NOT fix is the mechanism. `visitNode` is still the
/// inherited one, so it still answers `null` for anything unhandled — the next
/// node the language grows will fail exactly as silently as `#foo` did. Making
/// that default raise instead is SCC33; it is deliberately not done here,
/// because it turns every currently-tolerated unhandled node into a hard error
/// at once and needs its own blast-radius pass.
void main() {
  group('SCB11: symbol literals', () {
    test(
      'F-SCB11-1: a plain symbol literal is a Symbol, not null [2026-07-28]',
      () {
        // The headline regression: this returned `null` and `is Symbol` was
        // false, with no error raised anywhere.
        final result = execute('''
        main() {
          final s = #foo;
          return '\${s != null}|\${s is Symbol}';
        }
      ''');
        expect(result, 'true|true');
      },
    );

    test('F-SCB11-2: a symbol literal equals the explicit Symbol form '
        '[2026-07-28]', () {
      // The joint that makes the fix sound: the interpreter constructs a
      // non-const `Symbol`, and it must still compare equal to the literal the
      // SDK canonicalises. If this ever failed, every script that mixes the two
      // spellings would silently take the wrong branch.
      final result = execute('''
        main() {
          return #foo == Symbol('foo');
        }
      ''');
      expect(result, true);
    });

    test('F-SCB11-3: two symbol literals with the same name are equal '
        '[2026-07-28]', () {
      final result = execute('''
        main() {
          return '\${#foo == #foo}|\${#foo == #bar}';
        }
      ''');
      expect(result, 'true|false');
    });

    test('F-SCB11-4: a dotted symbol is one library-qualified name '
        '[2026-07-28]', () {
      // Not a member access on `#foo`: the whole thing is a single symbol whose
      // name is `'foo.bar.baz'`.
      final result = execute('''
        main() {
          return #foo.bar.baz == Symbol('foo.bar.baz');
        }
      ''');
      expect(result, true);
    });

    test('F-SCB11-5: a dotted symbol is NOT equal to its first component '
        '[2026-07-28]', () {
      // Distinguishes "the components are joined" from "the components are
      // dropped after the first". With only the first component kept, this
      // would answer true.
      final result = execute('''
        main() {
          return #foo.bar == Symbol('foo');
        }
      ''');
      expect(result, false);
    });

    test('F-SCB11-6: operator symbols are legal literals [2026-07-28]', () {
      // `#+` and `#[]` are valid symbol literals whose names are the operator
      // lexemes. `#[]` arrives as a single token, so it needs no special
      // joining — asserted so a future "sanitise the name" change cannot break
      // it unnoticed.
      final result = execute('''
        main() {
          return '\${#+ == Symbol('+')}|\${#[] == Symbol('[]')}|'
                 '\${#== == Symbol('==')}';
        }
      ''');
      expect(result, 'true|true|true');
    });

    test('F-SCB11-7: a symbol literal works as a Map key [2026-07-28]', () {
      // Requires `hashCode` to agree, not just `==` — a lookup that only had
      // `==` right would miss the bucket entirely. `visitSymbolLiteral` returns
      // the bare native `Symbol`, so both the insert and the lookup hash the
      // same way.
      //
      // NOT asserted here: `m[Symbol('alpha')]`, i.e. inserting by literal and
      // looking up by the explicit form. The interpreted `Symbol('alpha')`
      // evaluates to a `BridgedInstance` wrapper whose hash is the wrapper's
      // identity hash, so the lookup misses. That is a defect of *every* bridged
      // value type, not of symbols: `{Duration(seconds: 1): 1}[Duration(
      // seconds: 1)]` is null for the same reason.
      //
      // THIS OMISSION IS A PIN ON A PUBLISH, NOT AN OPEN DEFECT. SCC32 fixed it
      // at the bridged-value level — `BridgedInstance` now delegates `==` and
      // `hashCode` to its native, and hash keys are normalized to the native at
      // storage — and the reference copy of this file asserts the case. This
      // package resolves `tom_d4rt_ast` from pub.dev (DGUC6), and the published
      // 0.20.1 has no `==`/`hashCode` on `BridgedInstance` at all, so the
      // narrower assertion below is a correct measurement of the interpreter
      // this suite actually runs.
      //
      // Measured, not predicted: with the reference tree's assertion in place
      // the case fails here `Expected: ...true|1 / Actual: ...true|null`. Widen
      // it to the reference form on the publish that raises this package's
      // `tom_d4rt_ast` floor past 0.39.0 — the same commit that lands
      // `scc32_bridged_value_key_test.dart` and clears both of this file's
      // entries in `conformance_drift_test.dart`.
      //
      // `containsKey` IS asserted below, and the contrast is the point: it takes
      // the other path — a bridge method call, which does unwrap — so it already
      // agrees across the two spellings even on the published interpreter.
      final result = execute('''
        main() {
          final m = {#alpha: 1, #beta: 2};
          return '\${m[#alpha]}|\${m[#beta]}|\${m[#gamma]}|\${m.length}|'
                 '\${m.containsKey(Symbol('alpha'))}';
        }
      ''');
      expect(result, '1|2|null|2|true');
    });

    test('F-SCB11-8: toString reports the symbol name [2026-07-28]', () {
      final result = execute('''
        main() {
          return (#foo).toString();
        }
      ''');
      expect(result, 'Symbol("foo")');
    });

    test('F-SCB11-9: a symbol literal reaches a native bridge that casts to '
        'Symbol [2026-07-28]', () {
      // The failure that made the gap expensive to diagnose:
      // `Invocation.method` casts its first argument to `Symbol`, so a null
      // literal blew up inside the bridge with
      // `type 'Null' is not a subtype of type 'Symbol' in type cast`. This is
      // the SC5 case that had to be written as `Symbol('foo')`.
      final result = execute('''
        main() {
          final i = Invocation.method(#foo, [1, 2]);
          return '\${i.memberName == Symbol('foo')}|'
                 '\${i.positionalArguments.length}';
        }
      ''');
      expect(result, 'true|2');
    });

    test('F-SCB11-10: a symbol literal survives being passed and returned '
        '[2026-07-28]', () {
      // Guards the value crossing the interpreted-call boundary and the
      // host-return boundary, not just the literal site.
      final result = execute('''
        Symbol echo(Symbol s) => s;
        main() {
          return echo(#round.trip);
        }
      ''');
      expect(result, Symbol('round.trip'));
    });

    test('F-SCB11-11: symbols are usable in a const context [2026-07-28]', () {
      // `#foo` is a compile-time constant in real Dart, so it is legal inside a
      // const collection. The interpreter evaluates it eagerly rather than
      // canonicalising, which is fine *because* equality is by name — this test
      // records that the const spelling is accepted at all.
      final result = execute('''
        main() {
          const names = [#a, #b];
          return '\${names.length}|\${names[1] == Symbol('b')}';
        }
      ''');
      expect(result, '2|true');
    });
  });
}
