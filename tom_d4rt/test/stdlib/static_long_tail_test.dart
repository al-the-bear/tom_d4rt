import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import '../interpreter_test.dart' show execute;

/// A real Dart enum, registered as a bridge so F-SCC11-28 can exercise the
/// `BridgedEnumValue` representation. Declaration order is deliberately the
/// reverse of alphabetical order so index and name comparisons disagree.
enum _Priority { low, high }

/// SCC11 part 3 — the long tail: one or two members each, spread across a dozen
/// classes.
///
/// These have nothing in common except being the last thing missing from their
/// class, which is exactly why they are worth closing together: each one alone
/// looks too small to schedule, and collectively they are most of what the gap
/// oracle still reports.
///
/// Two of them carry a shape the interpreter can get wrong in a way that
/// compiles:
///
/// **Static constants belong in `staticGetters`, not `getters`.** `Symbol.empty`,
/// `Symbol.unaryMinus` and `ProcessStartMode.values` are `static const` fields.
/// An instance getter takes `(visitor, target)` and a static getter takes
/// `(visitor)`, so putting a static const in the instance map registers, exports
/// and analyses cleanly — and is inert, because nothing ever looks it up there.
///
/// **`Enum.compareByIndex` cannot require a native `Enum`.** D4rt has two enum
/// value representations: `BridgedEnumValue`, which wraps a native SDK enum, and
/// `InterpretedEnumValue`, which has no native value at all because the enum was
/// declared in the script. An adapter written as `positionalArgs[0] as Enum`
/// would work for SDK enums and fail for precisely the enums a script is most
/// likely to declare and then compare. Both representations expose `index` and
/// `name`, so the comparison is expressible over both — and the rule that
/// settles it is the one this bridge family keeps running into: the bridge must
/// not refuse what Dart accepts.
void main() {
  group('SCC11: Enum comparators', () {
    test('F-SCC11-25: compareByIndex orders a script-declared enum by '
        'declaration order [2026-09-04]', () {
      // Declaration order is b, a — so comparing by *index* must say b < a,
      // which is the opposite of what a name comparison would say. That is the
      // point of asserting on a deliberately unsorted enum.
      final result = execute('''
        enum E { b, a }
        main() {
          return Enum.compareByIndex(E.b, E.a);
        }
      ''');
      expect(result, lessThan(0));
    });

    test('F-SCC11-26: compareByName orders a script-declared enum '
        'alphabetically [2026-09-04]', () {
      final result = execute('''
        enum E { b, a }
        main() {
          return Enum.compareByName(E.b, E.a);
        }
      ''');
      expect(result, greaterThan(0));
    });

    test('F-SCC11-27: the comparators sort a script-declared enum list '
        '[2026-09-04]', () {
      final result = execute('''
        enum Colour { red, green, blue }
        main() {
          final byName = [Colour.red, Colour.green, Colour.blue]
            ..sort(Enum.compareByName);
          return byName.map((c) => c.name).toList();
        }
      ''');
      expect(result, equals(['blue', 'green', 'red']));
    });

    test('F-SCC11-28: the comparators also accept bridged enum values '
        '[2026-09-04]', () {
      // The other representation. `BridgedEnumValue` does carry a native enum,
      // so this is the case a naive `as Enum` adapter would have passed —
      // keeping it asserted stops a later "simplification" from regressing the
      // interpreted side.
      //
      // The bridge has to be registered here rather than reached through
      // `dart:io`, because none of the SDK "enum" surfaces the stdlib exposes
      // is a Dart `enum`: `ProcessStartMode`, `ProcessSignal`, `FileMode`,
      // `FileSystemEntityType` and `InternetAddressType` are all final classes
      // with static const instances, and `x is Enum` is false for every one of
      // them.
      final d4rt = D4rt()..setDebug(false);
      d4rt.registerBridgedEnum(
        BridgedEnumDefinition<_Priority>(
          name: 'Priority',
          values: _Priority.values,
        ),
        'package:test_lib/test_lib.dart',
      );
      final result = d4rt.execute(
        library: 'package:test/main.dart',
        sources: {
          'package:test/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              return [
                Enum.compareByIndex(Priority.low, Priority.high),
                Enum.compareByName(Priority.low, Priority.high),
              ];
            }
          ''',
        },
      );
      // Declaration order is low, high — so by index low < high, while by name
      // 'high' sorts before 'low'. Asserting both directions in one script is
      // what proves the two comparators are not the same function.
      expect(result, equals([-1, 1]));
    });

    test('F-SCC11-29: comparing a non-enum reports a diagnostic naming Enum '
        '[2026-09-04]', () {
      // Matched against the adapter's own wording, not the class name:
      // `contains('Enum')` was also true of "Bridged class 'Enum' has no static
      // method named 'compareByIndex'", so it passed while the member was
      // missing. A red test that cannot fail proves nothing.
      final result = execute('''
        main() {
          try {
            Enum.compareByIndex(1, 2);
            return 'no-throw';
          } catch (e) {
            return e.toString().contains('enum value');
          }
        }
      ''');
      expect(result, true);
    });
  });

  group('SCC11: Symbol static constants', () {
    test('F-SCC11-30: Symbol.empty is the symbol for the empty name '
        '[2026-09-04]', () {
      final result = execute('''
        main() {
          return Symbol.empty == Symbol('');
        }
      ''');
      expect(result, true);
    });

    test('F-SCC11-31: Symbol.unaryMinus is the unary minus operator symbol '
        '[2026-09-04]', () {
      final result = execute('''
        main() {
          return Symbol.unaryMinus == Symbol('unary-');
        }
      ''');
      expect(result, true);
    });
  });

  group('SCC11: dart:io enum surfaces', () {
    test('F-SCC11-32: ProcessStartMode.values lists all four modes '
        '[2026-09-04]', () {
      // Rendered through `toString()`, not `.name`: `ProcessStartMode` is a
      // final class with static const instances rather than a Dart `enum`, so
      // it has no `name` and no `index`. Bridging a synthesised `name` would
      // let a script write something the SDK rejects.
      final result = execute('''
        import 'dart:io';
        main() {
          return ProcessStartMode.values.map((m) => m.toString()).toList();
        }
      ''');
      expect(result,
          equals(['normal', 'inheritStdio', 'detached', 'detachedWithStdio']));
    });

    test('F-SCC11-33: ProcessSignal.signalNumber exposes the POSIX number '
        '[2026-09-04]', () {
      final result = execute('''
        import 'dart:io';
        main() {
          return ProcessSignal.sigint.signalNumber;
        }
      ''');
      expect(result, 2);
    });

    test('F-SCC11-34: InternetAddressType.name gives the declared name '
        '[2026-09-04]', () {
      final result = execute('''
        import 'dart:io';
        main() {
          return InternetAddressType.IPv4.name;
        }
      ''');
      expect(result, 'IPv4');
    });
  });

  group('SCC11: LineSplitter.split', () {
    test('F-SCC11-35: the static split() yields the lines without an instance '
        '[2026-09-04]', () {
      final result = execute('''
        import 'dart:convert';
        main() {
          return LineSplitter.split('a\\nb\\nc').toList();
        }
      ''');
      expect(result, equals(['a', 'b', 'c']));
    });

    test('F-SCC11-36: split() honours the optional start offset [2026-09-04]',
        () {
      // The offset is what distinguishes the static from `LineSplitter().convert`
      // — a bridge that forwarded only the string would look correct until
      // someone passed a second argument.
      final result = execute('''
        import 'dart:convert';
        main() {
          return LineSplitter.split('a\\nb\\nc', 2).toList();
        }
      ''');
      expect(result, equals(['b', 'c']));
    });

    test('F-SCC11-37: split() honours an explicit end offset [2026-09-04]', () {
      final result = execute('''
        import 'dart:convert';
        main() {
          return LineSplitter.split('a\\nb\\nc', 0, 3).toList();
        }
      ''');
      expect(result, equals(['a', 'b']));
    });
  });

  group('SCC11: Iterable string helpers', () {
    test('F-SCC11-38: iterableToShortString defaults to round delimiters '
        '[2026-09-04]', () {
      // The defaults are `(` and `)`, not `[` and `]` — easy to assume wrong,
      // and invisible until a script compares the rendered string.
      final result = execute('''
        main() {
          return Iterable.iterableToShortString([1, 2, 3]);
        }
      ''');
      expect(result, '(1, 2, 3)');
    });

    test('F-SCC11-39: iterableToShortString accepts explicit delimiters '
        '[2026-09-04]', () {
      final result = execute('''
        main() {
          return Iterable.iterableToShortString([1, 2, 3], '[', ']');
        }
      ''');
      expect(result, '[1, 2, 3]');
    });

    test('F-SCC11-40: iterableToShortString truncates a long iterable '
        '[2026-09-04]', () {
      // Truncation is the entire difference between the short and full forms.
      // Without this assertion the two helpers are indistinguishable.
      final result = execute('''
        main() {
          final long = List.generate(200, (i) => i);
          return Iterable.iterableToShortString(long).contains('...');
        }
      ''');
      expect(result, true);
    });

    test('F-SCC11-41: iterableToFullString renders every element '
        '[2026-09-04]', () {
      final result = execute('''
        main() {
          final long = List.generate(200, (i) => i);
          final rendered = Iterable.iterableToFullString(long, '<', '>');
          return [rendered.contains('...'), rendered.contains('199')];
        }
      ''');
      expect(result, equals([false, true]));
    });
  });

  group('SCC11: String.matchAsPrefix', () {
    test('F-SCC11-42: the receiver is the pattern, matched at the start of the '
        'argument [2026-09-04]', () {
      // `Pattern.matchAsPrefix(String string, [int start])` — the string being
      // searched is the *argument*. Reading it the other way round produces a
      // bridge that compiles and matches nothing.
      final result = execute('''
        main() {
          return 'abc'.matchAsPrefix('abcdef')?.group(0);
        }
      ''');
      expect(result, 'abc');
    });

    test('F-SCC11-43: matchAsPrefix returns null when the prefix does not match '
        '[2026-09-04]', () {
      final result = execute('''
        main() {
          return 'zzz'.matchAsPrefix('abcdef') == null;
        }
      ''');
      expect(result, true);
    });

    test('F-SCC11-44: matchAsPrefix honours the start offset [2026-09-04]', () {
      final result = execute('''
        main() {
          return 'abc'.matchAsPrefix('xxabcdef', 2)?.group(0);
        }
      ''');
      expect(result, 'abc');
    });
  });

  group('SCC11: StreamSubscription.asFuture', () {
    test('F-SCC11-45: asFuture completes with the given value when the stream '
        'ends [2026-09-04]', () async {
      // `listen((e) { seen.add(e); })` rather than `listen(seen.add)`: passing a
      // torn-off *bridged* method where the adapter casts to
      // `InterpretedFunction?` fails with a cast error. That is an interpreter
      // limitation unrelated to `asFuture`, tracked separately — using a closure
      // keeps this test measuring the member it is named after.
      final result = await execute('''
        main() async {
          final seen = [];
          final sub = Stream.fromIterable([1, 2, 3]).listen((e) { seen.add(e); });
          final done = await sub.asFuture('done');
          return [done, seen.length];
        }
      ''');
      expect(result, equals(['done', 3]));
    });

    test('F-SCC11-46: asFuture completes with null when no value is given '
        '[2026-09-04]', () async {
      final result = await execute('''
        main() async {
          final sub = Stream.fromIterable([1]).listen((e) {});
          return await sub.asFuture() == null;
        }
      ''');
      expect(result, true);
    });
  });
}
