// ghissues47 — GitHub #14: the extensions of a library imported with a prefix
// apply implicitly, as those of an unprefixed import do.
//
// Measured 2026-11-14 on tom_d4rt 1.257.0 / tom_d4rt_ast 0.237.0:
//
//   // package:r/public.dart:        export 'src/encoding.dart';
//   // package:r/src/encoding.dart:  extension ListEncoding on List<int> {
//   //                                 List<int> toJson() => this; }
//   import 'package:r/public.dart' as api;
//   main() => <int>[1, 2].toJson();   // threw: Bridged class 'List' has no
//                                     //   instance method named 'toJson'
//                                     //   (Dart: [1, 2]; without the prefix
//                                     //   the interpreter answered [1, 2])
//
// In Dart a prefixed import brings the library's extensions into scope for
// implicit application; only naming the extension (an explicit override)
// needs the prefix. The extension lookup walked the scope chain but never the
// environments bound to import prefixes; it now visits each scope's prefix
// environments after the scope itself (`Environment._extensionScopes`), with
// the import's show / hide applied. The same in tom_d4rt_ast
// (test/runtime/ghissues47_prefixed_import_extensions_test.dart).
//
// Name resolution: an extension member now resolves through a prefixed import.
//
// The explicit override `api.ListEncoding(list).toJson()` is not tested here:
// measured 2026-11-14, no explicit extension override works in either tree,
// prefixed or not (`ListEncoding(list)` is refused as calling a non-callable)
// - ghissues53.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _encoding =
    'extension ListEncoding on List<int> { List<int> toJson() => this; }';

Object? _run(String main, {Map<String, String> libraries = const {}}) {
  final d4rt = D4rt()
    ..registerBridgedExtension(
      BridgedExtensionDefinition(
        name: 'Gh47Shout',
        onTypeName: 'String',
        methods: {
          'shout': (visitor, target, positional, named, typeArgs) =>
              '${(target as String).toUpperCase()}!',
        },
      ),
      'package:b/b.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:r/public.dart': "export 'src/encoding.dart';",
      'package:r/src/encoding.dart': _encoding,
      'package:r/direct.dart':
          "extension on String { String twice() => this + this; }\n"
          'extension Named on int { int get doubled => this * 2; }',
      ...libraries,
      'package:p/main.dart': main,
    },
  );
}

Matcher _noMember(String name) => throwsA(
  predicate(
    (Object e) =>
        e.toString().contains("no instance method named '$name'") ||
        e.toString().contains("has no method named '$name'"),
    "no member '$name'",
  ),
);

void main() {
  group('ghissues47: extensions through a prefixed import', () {
    test('GHI47-1: the issue - an extension a prefixed library exports '
        'applies (GitHub #14) [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/public.dart' as api;\n"
          'Object main() => <int>[1, 2].toJson();',
        ),
        [1, 2],
      );
    });

    test('GHI47-2: the unprefixed control answers the same [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/public.dart';\n"
          'Object main() => <int>[1, 2].toJson();',
        ),
        [1, 2],
      );
    });

    test('GHI47-3: unnamed and named extensions declared by the prefixed '
        'library itself, a method and a getter [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/direct.dart' as d;\n"
          "Object main() => ['ab'.twice(), 21.doubled];",
        ),
        ['abab', 42],
      );
    });

    test('GHI47-4: hide removes a named extension from a prefixed import; '
        'show of another name leaves it out [2026-11-14]', () {
      expect(
        () => _run(
          "import 'package:r/public.dart' as api hide ListEncoding;\n"
          'Object main() => <int>[1, 2].toJson();',
        ),
        _noMember('toJson'),
      );
      expect(
        () => _run(
          "import 'package:r/direct.dart' as d show Named;\n"
          "import 'package:r/public.dart' as api show Other;\n"
          'Object main() => <int>[1, 2].toJson();',
          libraries: {
            'package:r/public.dart':
                "export 'src/encoding.dart';\nclass Other {}",
          },
        ),
        _noMember('toJson'),
      );
    });

    test('GHI47-6: a bridged extension through a prefixed import '
        '[2026-11-14]', () {
      expect(
        _run(
          "import 'package:b/b.dart' as b;\n"
          "Object main() => 'hi'.shout();",
        ),
        'HI!',
      );
    });

    test('GHI47-7: without any import of the library the extension stays '
        'out of scope [2026-11-14]', () {
      expect(
        () => _run('Object main() => <int>[1, 2].toJson();'),
        _noMember('toJson'),
      );
    });
  });
}
