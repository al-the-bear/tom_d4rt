// GitHub al-the-bear/tom_d4rt#9 — a class whose supertype (or a type bound it
// uses) is declared in a library that is still loading.
//
// Reported from a Slang project loading intl 0.20.3 from source; reproduced
// 2026-11-06 on tom_d4rt_ast 0.210.0 and 2026-11-07 on this tree (1.233.0):
//
//   * `intl_helpers.dart` imports `message_lookup_by_library.dart`, which
//     imports `intl_helpers.dart` back; the inner one declares
//     `CompositeMessageLookup implements MessageLookup` before the outer one
//     has declared `MessageLookup`:
//     `Interface 'MessageLookup' not found for class 'CompositeMessageLookup'`.
//   * `number_format.dart` reaches `NumberParserBase` only through the
//     `intl.dart` barrel, which has not reached the export declaring it yet:
//     `parseWith<R, P extends NumberParserBase<R>>` failed with
//     `Undefined variable: NumberParserBase`.
//
// Dart has no declaration order across libraries. The module loader loads a
// module's imports before declaring its own names, so inside a cycle a class
// can be visited before its supertype exists anywhere. Now a class (or mixin)
// whose `extends` / `implements` / `with` / `on` names are not declared yet
// while modules load, and a method or class whose type-parameter bound is not,
// has that resolution (and the inherited-member checks) run once the outermost
// load returns. An undefined name is still reported then.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? run(Map<String, String> sources) =>
    D4rt().execute(library: 'package:p/main.dart', sources: sources);

/// `main.dart` imports a barrel exporting `user.dart` and `base.dart`; both
/// import the barrel back, and `user.dart` comes first, so it is declared
/// before anything in `base.dart` exists.
Map<String, String> viaBarrel(String user, String main) => {
  'package:p/main.dart': "import 'package:p/barrel.dart';\n$main",
  'package:p/barrel.dart':
      "export 'package:p/user.dart';\nexport 'package:p/base.dart';",
  'package:p/user.dart': "import 'package:p/barrel.dart';\n$user",
  'package:p/base.dart':
      "import 'package:p/barrel.dart';\n"
      "abstract class Base { String b() => 'base'; }\n"
      "mixin M on Base { String m() => 'm'; }\n"
      'abstract class Iface { String i(); }',
};

void main() {
  group('gh9: supertypes declared in a library still loading', () {
    test('GH9-1: implements an interface across an import cycle '
        '[2026-11-07]', () {
      expect(
        run({
          'package:p/main.dart':
              "import 'package:p/helpers.dart'; main() => describe();",
          'package:p/helpers.dart':
              "import 'package:p/lookup.dart';\n"
              'abstract class MessageLookup { String name(); }\n'
              'String describe() => CompositeMessageLookup().name();',
          'package:p/lookup.dart':
              "import 'package:p/helpers.dart';\n"
              'class CompositeMessageLookup implements MessageLookup {\n'
              "  String name() => 'composite'; }",
        }),
        'composite',
      );
    });

    test('GH9-2: extends a class a barrel exports later [2026-11-07]', () {
      expect(
        run(
          viaBarrel(
            'class Parser extends Base { String kind() => "parser:" + b(); }',
            'main() => Parser().kind();',
          ),
        ),
        'parser:base',
      );
    });

    test('GH9-3: a three-library cycle [2026-11-07]', () {
      expect(
        run({
          'package:p/main.dart':
              "import 'package:p/a.dart'; main() => C().who();",
          'package:p/a.dart':
              "import 'package:p/b.dart';\nexport 'package:p/c.dart';\n"
              'abstract class A { String who(); }',
          'package:p/b.dart':
              "import 'package:p/a.dart';\nimport 'package:p/c.dart';\n"
              'abstract class B implements A {}',
          'package:p/c.dart':
              "import 'package:p/a.dart';\nimport 'package:p/b.dart';\n"
              "class C extends B { String who() => 'c'; }",
        }),
        'c',
      );
    });

    test('GH9-4: a method type-parameter bound a barrel exports later '
        '[2026-11-07]', () {
      expect(
        run(
          viaBarrel(
            'class Format { String parseWith<P extends Base>(P p) => p.b(); }\n'
                'class Sub extends Base {}',
            'main() => Format().parseWith(Sub());',
          ),
        ),
        'base',
      );
    });

    test('GH9-5: a class type-parameter bound, a mixin, a mixin `on` clause '
        'and an enum interface across the barrel [2026-11-07]', () {
      expect(
        run(
          viaBarrel(
            "class Box<T extends Base> { String ok() => 'box'; }\n"
                'class U extends Base with M {}\n'
                "mixin N on Base { String n() => 'n' + b(); }\n"
                'class V extends Base with N {}\n'
                "enum E implements Iface { a; String i() => 'ei'; }",
            'main() => [Box().ok(), U().m(), V().n(), E.a.i()];',
          ),
        ),
        ['box', 'm', 'nbase', 'ei'],
      );
    });

    test('GH9-6: the inherited-member checks still run for a deferred class '
        '[2026-11-07]', () {
      expect(
        () => run(viaBarrel('class Bad implements Iface {}', 'main() => 1;')),
        throwsA(
          predicate(
            (Object e) =>
                e.toString().contains("interface method 'i'") &&
                e.toString().contains("'Bad'"),
            'names the missing member and the class',
          ),
        ),
      );
    });

    test('GH9-7: an undefined supertype or bound is still reported '
        '[2026-11-07]', () {
      expect(
        () => run({
          'package:p/main.dart': "import 'package:p/lib.dart'; main() => 1;",
          'package:p/lib.dart': 'class X extends Missing {}',
        }),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "Superclass 'Missing' not found for class 'X'",
            ),
          ),
        ),
      );
      expect(
        () => run({
          'package:p/main.dart': "import 'package:p/lib.dart'; main() => 1;",
          'package:p/lib.dart': 'class Y { void f<T extends Gone>() {} }',
        }),
        throwsA(predicate((Object e) => e.toString().contains('Gone'))),
      );
    });
  });

  group('gh9: intl 0.20.3 from source', () {
    // The issue's own case, on the unmodified intl source closure read from
    // the pub cache (intl, clock, path, meta). The cache is the only place the
    // sources exist on a machine; a machine without them cannot answer.
    final cache = '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev';
    final packages = {
      'intl': '$cache/intl-0.20.3',
      'clock': '$cache/clock-1.1.2',
      'path': '$cache/path-1.9.1',
      'meta': '$cache/meta-1.18.0',
    };
    final missing = packages.values.where((d) => !Directory(d).existsSync());
    final sources = <String, String>{
      if (missing.isEmpty)
        for (final MapEntry(key: name, value: dir) in packages.entries)
          for (final file
              in Directory('$dir/lib')
                  .listSync(recursive: true)
                  .whereType<File>()
                  .where((f) => f.path.endsWith('.dart')))
            'package:$name/${file.path.substring(dir.length + 5)}': file
                .readAsStringSync(),
    };

    for (final (label, imports) in [
      ('intl.dart alone', "import 'package:intl/intl.dart';"),
      (
        'message_lookup_by_library.dart first',
        "import 'package:intl/message_lookup_by_library.dart';\n"
            "import 'package:intl/intl.dart';",
      ),
    ]) {
      test(
        'GH9-8: Intl.canonicalizedLocale from source, $label [2026-11-07]',
        () {
          expect(
            D4rt().execute(
              library: 'package:p/main.dart',
              sources: {
                ...sources,
                'package:p/main.dart':
                    "$imports\nmain() => Intl.canonicalizedLocale('en-US');",
              },
            ),
            'en_US',
          );
        },
        skip: missing.isEmpty
            ? false
            : 'the intl 0.20.3 source closure is not in this pub cache: '
                  '${missing.join(', ')}',
        timeout: const Timeout(Duration(minutes: 3)),
      );
    }
  });
}
