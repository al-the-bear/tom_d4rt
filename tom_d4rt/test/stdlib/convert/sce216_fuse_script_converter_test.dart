/// SCE216 — `fuse` refuses a script-defined `Converter` / `Codec`, and says why.
///
/// A converter a script defines is an interpreted instance, not a native
/// `Converter`, and `fuse` builds a native pipeline the interpreter does not
/// run — so it cannot be accepted. Decision (b): keep that limit and make it
/// legible. Before this the refusal read "requires another Converter<String,
/// dynamic> as argument", which looks exactly like the SCD181 / SCC68 erasure
/// bug (a right value whose type argument was lost) and invites the same
/// coercion fix, which cannot work here.
///
/// Every refusal comes from `stdlib/convert/fuse_argument.dart`; the AST twin's
/// `sce216_fuse_argument_message_test.dart` holds that all twenty bridged
/// `fuse` guards use it.
library;

import 'package:test/test.dart';

import '../../interpreter_test.dart';

const _scriptConverter = '''
import 'dart:convert';
class Upper extends Converter<String, String> {
  String convert(String input) => input.toUpperCase();
}
''';

Matcher _refusal(List<String> fragments) => throwsA(
  predicate(
    (Object? e) => fragments.every('$e'.contains),
    'an error containing ${fragments.join(' / ')}',
  ),
);

void main() {
  group('SCE216: fuse and script-defined converters', () {
    test('F-SCE216-1: a script-defined Converter is refused, and the message '
        'names the limit [2026-09-28] (PASS)', () {
      expect(
        () =>
            execute('$_scriptConverter main() => utf8.decoder.fuse(Upper());'),
        _refusal([
          'Utf8Decoder.fuse',
          'Upper is defined in the script',
          'cannot be fused',
          'convert on each stage',
        ]),
      );
    });

    test(
      'F-SCE216-2: the same for a script-defined Codec [2026-09-28] (PASS)',
      () {
        expect(
          () => execute('''
          import 'dart:convert';
          class Ident extends Codec<String, String> {
            Converter<String, String> get encoder => throw 'unused';
            Converter<String, String> get decoder => throw 'unused';
          }
          main() => json.fuse(Ident());
        '''),
          _refusal(['JsonCodec.fuse', 'Ident is defined in the script']),
        );
      },
    );

    test('F-SCE216-3: a wrongly typed NATIVE argument keeps the plain type '
        'requirement [2026-09-28] (PASS)', () {
      // The limit is only claimed for what it is about. A number is not a
      // script-defined converter, so telling that caller about scripts would be
      // the misleading message this todo removes, pointed the other way.
      expect(
        () =>
            execute("import 'dart:convert';\nmain() => utf8.decoder.fuse(42);"),
        throwsA(
          predicate(
            (Object? e) =>
                '$e'.contains(
                  'Utf8Decoder.fuse requires another Converter<String, '
                  'dynamic> as argument.',
                ) &&
                !'$e'.contains('defined in the script'),
            'the plain type requirement',
          ),
        ),
      );
    });

    test('F-SCE216-4 (control): native-to-native fusion still works, and the '
        'script converter still works on its own [2026-09-28] (PASS)', () {
      expect(
        execute('''
          $_scriptConverter
          main() => [
            utf8.decoder.fuse(json.decoder).convert(utf8.encode('[1, 2]')),
            json.fuse(utf8).decode(utf8.encode('{"a": 1}')),
            Upper().convert(utf8.decoder.convert(utf8.encode('ok'))),
          ];
        '''),
        [
          [1, 2],
          {'a': 1},
          'OK',
        ],
      );
    });
  });
}
