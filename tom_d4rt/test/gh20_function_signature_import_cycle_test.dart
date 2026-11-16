// GitHub al-the-bear/tom_d4rt#20 — a top-level function whose signature names
// a class of a library in the same import cycle.
//
// Reported from slang 4.19.2 (`_findNode<T extends Node>` in
// translation_model_builder.dart, which imports node.dart back); reproduced
// 2026-11-16 on this tree (1.264.0) with the issue's three files: `main.dart`
// imports `node.dart`, which imports `helper.dart` before declaring `Node`;
// `helper.dart` imports `node.dart` back and declares
// `T identity<T extends Node>(T x) => x`. Loading helper.dart failed with
// `Undefined variable: Node`, although `identity` is never called. The same
// held for a plain return type naming the class (`Node make() ...`:
// `Type 'Node' not found`).
//
// #9 deferred a class's supertypes and a METHOD's type-parameter bounds while
// modules load. A top-level function is rebuilt in pass 2 with its bounds and
// its return type resolved strictly, so it threw first. Now both are resolved
// once the outermost load returns, as #9 does for methods: the bound is still
// checked when the function is called, the return type when it returns, and a
// name that is genuinely undefined is still reported.
//
// Found with it, in every library, cycle or not (GH20-6): a block body that
// returns the function's own type parameter (`T identity<T>(T x) { return
// x; }`) refused an interpreted instance, because the return was checked
// against the bare `T`. It is now checked against this call's type argument.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// The issue's graph: `helper.dart` declares [helper] and `marker()`.
Object? run(String helper, {String main = 'main() => answer();'}) =>
    D4rt().execute(
      library: 'package:p/main.dart',
      sources: {
        'package:p/main.dart':
            "import 'package:p/node.dart';\n"
            "import 'package:p/helper.dart';\n$main",
        'package:p/node.dart':
            "import 'package:p/helper.dart';\n"
            'class Node {}\n'
            'class Leaf extends Node {}\n'
            'int answer() => marker();',
        'package:p/helper.dart':
            "import 'package:p/node.dart';\n$helper\nint marker() => 7;",
      },
    );

void main() {
  group('gh20: a top-level function signature across an import cycle', () {
    test('GH20-1: the issue - a bound naming the cycle\'s class, never '
        'called [2026-11-16]', () {
      expect(run('T identity<T extends Node>(T x) => x;'), 7);
      // The issue's control.
      expect(run('T identity<T>(T x) => x;'), 7);
    });

    test('GH20-2: the deferred bound is checked when the function is called '
        '[2026-11-16]', () {
      expect(
        run(
          'T identity<T extends Node>(T x) => x;',
          main: 'main() => identity<Leaf>(Leaf()) is Leaf;',
        ),
        isTrue,
      );
      expect(
        () => run(
          'T identity<T extends Node>(T x) => x;',
          main: "main() => identity<String>('s');",
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "Type argument 'String' for type parameter 'T' does not satisfy "
              "bound 'Node' in function 'identity'",
            ),
          ),
        ),
      );
    });

    test('GH20-3: a return type naming the cycle\'s class - plain, nullable, '
        'a getter, async [2026-11-16]', () {
      expect(
        run(
          'Node make(Node n) => n;\n'
          'Node? maybe() => null;\n'
          'Node get first => Leaf();\n'
          'Future<Node> later() async => Leaf();',
          // The awaited value goes through a local: `(await x) is T` is
          // ghissues62, an await an `is` does not propagate.
          main:
              'main() async { final last = await later(); '
              'return [make(Leaf()) is Leaf, maybe(), first is Leaf, '
              'last is Leaf]; }',
        ),
        completion([true, null, true, true]),
      );
    });

    test('GH20-4: the deferred return type is checked when the function '
        'returns, and is part of its function type [2026-11-16]', () {
      expect(
        () => run(
          'Node bad() { dynamic x = "s"; return x; }',
          main: 'main() => bad();',
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "can't be returned from the function 'bad' because it has a "
              "return type of 'Node'",
            ),
          ),
        ),
      );
      expect(
        run(
          'Leaf make() => Leaf();',
          main:
              'main() { Node Function() f = make; '
              'return [f() is Leaf, make is Leaf Function(), '
              'make is String Function()]; }',
        ),
        [true, true, false],
      );
    });

    test('GH20-5: a bound naming the function\'s own type parameter and a '
        'returned closure [2026-11-16]', () {
      expect(
        run(
          'T Function(T) pick<T extends Node>() => (T x) => x;\n'
          'List<T> both<T extends Comparable<T>>(T a, T b) => [a, b];',
          main: 'main() => [pick<Leaf>()(Leaf()) is Leaf, both(1, 2)];',
        ),
        [
          true,
          [1, 2],
        ],
      );
    });

    test('GH20-6: a block body returning the function\'s type parameter is '
        'checked against this call\'s type argument [2026-11-16]', () {
      // Found with the issue: `T identity<T extends Node>(T x) { return x; }`
      // refused to return an interpreted instance ("can't be returned ...
      // return type of 'T'") in every library, cycle or not.
      Object? single(String main) => D4rt().execute(
        source:
            'class Node {}\n'
            'class Leaf extends Node {}\n'
            'class Box<T> { T v; Box(this.v); }\n'
            'T identity<T extends Node>(T x) { return x; }\n'
            'T any<T>(T x) { return x; }\n'
            "T make<T>() { dynamic x = 's'; return x; }\n"
            'T? none<T>() { return null; }\n'
            'T unbox<T>(Box<T> b) { return b.v; }\n'
            'List<T> wrap<T>(T x) { return [x]; }\n'
            '$main',
      );
      expect(
        single(
          'main() { T local<T>(T x) { return x; } return ['
          'identity<Leaf>(Leaf()) is Leaf, identity<Node>(Leaf()) is Leaf, '
          'any(Leaf()) is Leaf, any<int>(3), make<String>(), none<int>(), '
          "unbox<String>(Box('a')), wrap<Leaf>(Leaf()).length, "
          'local<Leaf>(Leaf()) is Leaf]; }',
        ),
        [true, true, true, 3, 's', null, 'a', 1, true],
      );
      expect(
        () => single('main() => make<int>();'),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "A value of type 'String' can't be returned from the function "
              "'make' because it has a return type of 'int'",
            ),
          ),
        ),
      );
    });

    test('GH20-7: an undefined bound or return type is still reported '
        '[2026-11-16]', () {
      expect(
        () => run('T lost<T extends Missing>(T x) => x;'),
        throwsA(predicate((Object e) => e.toString().contains('Missing'))),
      );
      expect(
        () => run('Gone lost() => null;'),
        throwsA(
          predicate(
            (Object e) => e.toString().contains("Type 'Gone' not found"),
          ),
        ),
      );
    });
  });
}
