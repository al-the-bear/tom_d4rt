// ghissues17 — an extension applies to subtypes of its `on` type, not to any
// type of the same name.
//
// Measured 2026-11-10 on this tree (1.242.0): `Environment._matchesExtensionType`
// accepted an extension when the receiver's type was a subtype of the `on` type
// OR merely had the same NAME. The name fallback was Bug-98's fix for raw
// native generics (a native `List` against an extension on `List<int>`), but it
// matched every pair, so a class named like the `on` type got the extension:
//
//   // package:p/types.dart
//   abstract class Base { String b() => 'base'; }
//   // main
//   import 'package:p/types.dart' as l;
//   class Base {}
//   extension X on l.Base { String x() => 'x:' + b(); }
//   main() => Base().x();   // Dart: compile error; d4rt ran X.x on the local
//                           // Base and failed inside it: Undefined variable: b
//
// GH17-4 pins Bug-98's raw-generic case, which must keep matching.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _entry = 'package:p/main.dart';

Object? _run(Map<String, String> sources, [D4rt? interpreter]) =>
    (interpreter ?? D4rt()).execute(library: _entry, sources: sources);

/// The refusal of a member no extension supplies. Before the fix the wrong
/// extension ran and failed inside its body ("Error executing extension
/// method"), so the message is pinned, not just any error.
final Matcher _noExtension = throwsA(
  predicate(
    (Object e) =>
        (e.toString().contains('no suitable extension method found') ||
            e.toString().contains('has no instance method named')) &&
        !e.toString().contains('Error executing extension method'),
    'no extension applied',
  ),
);

class _NativeTokenA {}

class _NativeTokenB {}

/// Two bridges named `Gh17Token` over different native types, in two
/// libraries.
D4rt _twoTokens() => D4rt()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _NativeTokenA,
      name: 'Gh17Token',
      constructors: {'': (visitor, positional, named) => _NativeTokenA()},
    ),
    'package:a/a.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _NativeTokenB,
      name: 'Gh17Token',
      constructors: {'': (visitor, positional, named) => _NativeTokenB()},
    ),
    'package:b/b.dart',
  );

void main() {
  group('ghissues17: an extension does not apply by name', () {
    test('GH17-1: an extension on an imported class is not applied to a local '
        'class of the same name [2026-11-10]', () {
      const types = "abstract class Base { String b() => 'base'; }";
      const declarations =
          "import 'package:p/types.dart' as l;\n"
          'class Base {}\n'
          "extension X on l.Base { String x() => 'x:' + b(); }\n"
          'class W extends l.Base {}\n';
      expect(
        _run({
          'package:p/types.dart': types,
          _entry: '${declarations}main() => W().x();',
        }),
        'x:base',
      );
      expect(
        () => _run({
          'package:p/types.dart': types,
          _entry: '${declarations}main() => Base().x();',
        }),
        _noExtension,
      );
    });

    test('GH17-2: an extension on a bridged type is not applied to a script '
        'class named like it [2026-11-10]', () {
      const ext =
          'extension X on Duration { int x() => inSeconds; }\n'
          'int viaLibrary() => const Duration(seconds: 2).x();\n';
      expect(
        _run({
          'package:p/ext.dart': ext,
          _entry:
              "import 'package:p/ext.dart';\n"
              'class Duration {}\n'
              'main() => viaLibrary();',
        }),
        2,
      );
      expect(
        () => _run({
          'package:p/ext.dart': ext,
          _entry:
              "import 'package:p/ext.dart';\n"
              'class Duration {}\n'
              'main() => Duration().x();',
        }),
        _noExtension,
      );
    });

    test('GH17-3: an extension on one bridge is not applied to another bridge '
        'of the same name [2026-11-10]', () {
      const declarations =
          "import 'package:a/a.dart' as a;\n"
          "import 'package:b/b.dart' as b;\n"
          "extension X on a.Gh17Token { String x() => 'x'; }\n";
      expect(
        _run({
          _entry: '${declarations}main() => a.Gh17Token().x();',
        }, _twoTokens()),
        'x',
      );
      expect(
        () => _run({
          _entry: '${declarations}main() => b.Gh17Token().x();',
        }, _twoTokens()),
        _noExtension,
      );
    });

    test('GH17-4: Bug-98 - an extension on a parameterised type still applies '
        'to a value of that type [2026-11-10]', () {
      expect(
        _run({
          _entry: '''
extension IntListX on List<int> { int get sum => fold(0, (a, b) => a + b); }
extension StringMapX on Map<String, int> { int get total => values.fold(0, (a, b) => a + b); }
extension IterableX on Iterable<String> { String get joined => join('+'); }
class Box<T> { Box(this.v); final T v; }
extension IntBoxX on Box<int> { int get twice => v * 2; }

main() {
  final numbers = [1, 2, 3];
  final map = <String, int>{'a': 1, 'b': 2};
  return [numbers.sum, map.total, ['p', 'q'].joined, Box<int>(4).twice,
    <int>{5, 6}.map((e) => e.toString()).joined];
}
''',
        }),
        [6, 3, 'p+q', 8, '5+6'],
      );
    });
  });
}
