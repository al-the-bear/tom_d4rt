// ghissues66 — GitHub al-the-bear/tom_d4rt#21 follow-up: an enum value
// reached through an import prefix, and a field implementing an interface
// getter.
//
// Reported 2026-11-17 on #21 (tom_d4rt_ast 0.246.0): one case of the
// reporter's Slang 4.19.2 suite failed with `Undefined static property 'zhCn'
// on enum 'AppLocale'`. Reproduced 2026-11-17 in both trees (this one
// 1.268.0): `import 'e.dart' as e; e.Color.green` failed the same way, for
// every enum. `Color.green` parses as a prefixed identifier, whose evaluation
// looks the value up; `e.Color.green` parses as a property access on
// `e.Color`, whose enum branch looked up static getters, fields and methods,
// mixins and `values`, but never the enum's values. That branch is the only
// place the message is thrown, and an import prefix is the only way a static
// enum member reaches it.
//
// Found on the way (loading Slang's package closure, source_span's
// `_FileSpan`): `abstract class I { int get x; } class A implements I { final
// int x; ... }` was refused with `Missing concrete implementation for
// interface getter 'x'`. The interface check counted methods, getters and
// setters but no fields; the check of inherited abstract members already
// did.
//
// Expected values are native Dart's (Dart 3.13.7, 2026-11-17).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs `package:fixture/main.dart` of [files] (names relative to the
/// package).
Object? run(Map<String, String> files) => D4rt().execute(
  library: 'package:fixture/main.dart',
  sources: {
    for (final MapEntry(:key, :value) in files.entries)
      'package:fixture/$key': value,
  },
);

Matcher refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

/// Slang's generated shape: an enhanced enum with a generic mixin and a
/// const constructor taking named arguments.
const _strings = '''
mixin BaseAppLocale<E extends BaseAppLocale<E, T>, T> {
  String get languageCode;
  String? get countryCode;
  String get tag =>
      countryCode == null ? languageCode : '\$languageCode-\$countryCode';
}
class Translations {}
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
  en(languageCode: 'en'),
  zhCn(languageCode: 'zh', countryCode: 'CN');

  const AppLocale({required this.languageCode, this.countryCode});
  @override
  final String languageCode;
  @override
  final String? countryCode;

  static const AppLocale base = AppLocale.en;
  static AppLocale parse(String tag) =>
      values.firstWhere((l) => l.tag == tag);
  static int get count => values.length;
}
''';

void main() {
  group('ghissues66: an enum value through an import prefix', () {
    test('GH66-1: the issue - `s.AppLocale.zhCn` of a Slang-shaped enum '
        '[2026-11-17]', () {
      expect(
        run({
          'strings.dart': _strings,
          'main.dart': '''
import 'strings.dart' as s;
main() => [
  s.AppLocale.zhCn.tag,
  s.AppLocale.zhCn.name,
  s.AppLocale.zhCn.index,
  identical(s.AppLocale.zhCn, s.AppLocale.values[1]),
];
''',
        }),
        ['zh-CN', 'zhCn', 1, true],
      );
    });

    test('GH66-2: a plain enum through a prefix [2026-11-17]', () {
      expect(
        run({
          'e.dart': 'enum Color { red, green }',
          'main.dart':
              "import 'e.dart' as e; "
              'main() => [e.Color.green.toString(), e.Color.green.index, '
              'e.Color.values.length];',
        }),
        ['Color.green', 1, 2],
      );
    });

    test('GH66-3: prefixed values as switch cases, and the static members '
        'beside them [2026-11-17]', () {
      expect(
        run({
          'strings.dart': _strings,
          'main.dart': '''
import 'strings.dart' as s;
String describe(s.AppLocale l) {
  switch (l) {
    case s.AppLocale.en:
      return 'english';
    case s.AppLocale.zhCn:
      return 'chinese';
  }
}
main() => [
  describe(s.AppLocale.zhCn),
  describe(s.AppLocale.en),
  s.AppLocale.base.tag,
  s.AppLocale.parse('zh-CN') == s.AppLocale.zhCn,
  s.AppLocale.count,
];
''',
        }),
        ['chinese', 'english', 'en', true, 2],
      );
    });

    test('GH66-4: a name the enum does not have is still refused '
        '[2026-11-17]', () {
      expect(
        () => run({
          'e.dart': 'enum Color { red, green }',
          'main.dart': "import 'e.dart' as e; main() => e.Color.blue;",
        }),
        refusedWith("Undefined static property 'blue' on enum 'Color'"),
      );
    });
  });

  group('ghissues66: an enum\'s own names inside its members', () {
    test('GH66-8: values, `values`, static fields, getters and methods by '
        'bare name in static and instance members [2026-11-17]', () {
      final result = run({
        'main.dart': '''
enum E {
  a, b;
  static const k = 3;
  static const E first = a;
  static int twice(int x) => x * 2;
  static int get size => values.length;
  static List<Object> fromStatic() => [values.length, a, k, twice(2), size];
  List<Object> fromInstance() => [values.length, b, k, twice(5), size, first];
}
main() => [...E.fromStatic(), ...E.a.fromInstance()];
''',
      });
      expect(
        [for (final v in result! as List) '$v'],
        [
          '2', 'E.a', '3', '4', '2', //
          '2', 'E.b', '3', '10', '2', 'E.a',
        ],
      );
    });
  });

  group('ghissues66: a field implements an interface getter', () {
    test('GH66-5: a final field implements a getter, a mutable one a getter '
        'and a setter [2026-11-17]', () {
      expect(
        run({
          'main.dart': '''
abstract class I { int get x; }
abstract class J { int get y; set y(int v); }
class A implements I, J {
  @override
  final int x;
  @override
  int y = 0;
  A(this.x);
}
main() {
  final a = A(3);
  a.y = 4;
  final I i = a;
  return [i.x, a.y];
}
''',
        }),
        [3, 4],
      );
    });

    test('GH66-6: source_span\'s shape - a field of a class extending an '
        'abstract base and implementing an interface from another library '
        '[2026-11-17]', () {
      expect(
        run({
          'span.dart': '''
abstract class SourceSpan { int get length; }
abstract class SpanMixin implements SourceSpan {
  int get twice => length * 2;
}
''',
          'file.dart': '''
import 'span.dart';
class SourceFile { final String text; SourceFile(this.text); }
abstract class FileSpan implements SourceSpan { SourceFile get file; }
class _FileSpan extends SpanMixin implements FileSpan {
  @override
  final SourceFile file;
  final int _start;
  final int _end;
  _FileSpan(this.file, this._start, this._end);
  @override
  int get length => _end - _start;
}
FileSpan span(String text, int start, int end) =>
    _FileSpan(SourceFile(text), start, end);
''',
          'main.dart': '''
import 'file.dart';
main() {
  final s = span('abcdef', 1, 4);
  return [s.file.text, s.length];
}
''',
        }),
        ['abcdef', 3],
      );
    });

    test('GH66-7: a field does not implement an interface method '
        '[2026-11-17]', () {
      expect(
        () => run({
          'main.dart': '''
abstract class I { int x(); }
class A implements I { final int x = 1; }
main() => A();
''',
        }),
        refusedWith(
          "Missing concrete implementation for interface method 'x' in "
          "class 'A'",
        ),
      );
    });
  });
}
