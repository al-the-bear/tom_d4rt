// The `dart:io` bridges accept collections a SCRIPT built, not only ones a
// native call returned.
//
// THE DEFECT SHAPE. A map literal written in a script arrives as
// `_Map<Object?, Object?>` whatever its entries hold, and a list literal as
// `List<Object?>`, because the interpreter checks element types without
// reifying them. So `namedArgs['headers'] as Map<String, dynamic>?` cannot
// succeed for anything a script can write: it throws
// `type '_Map<Object?, Object?>' is not a subtype of ...` before the SDK call
// is reached, naming interpreter internals at a script author.
//
// WHY THE STATIC GUARD IS NOT ENOUGH, which is what this file adds. SCD70
// turned the rule into a REPO-WIDE GUARD — `scd70_no_container_arg_casts_test`
// bans a cast to a parameterised container anywhere in either tree's bridges,
// and found seventeen sites per tree against a todo that named two. That guard
// is green and the population is now zero. But it is a SOURCE scan: it proves
// no adapter still casts, and proves nothing about whether the coercion that
// replaced the cast actually works on a literal. SCD173 put the point exactly:
// "a bridge whose collection named args happen to be untested looks identical
// to one that works".
//
// So these cases pass real literals through the three io sites that coerce a
// collection and had no test doing so. Each is the difference between "no cast
// present" and "known-working", and each fails if the coercion is reverted.
// `WebSocket.connect(headers:)` — the site the whole rule was found in — is
// already covered by F-SCC63-22 and is not repeated here.

import 'package:test/test.dart';
import '../../interpreter_test.dart';

void main() {
  group('SCD173: io bridges take collections a script built', () {
    test('F-SCD173-1: ContentType takes a parameters map literal '
        '[2026-09-15] (PASS)', () {
      // `Map<String, String?>`, so the VALUE type is nullable too — a literal
      // mixing a string and a null is the shape that distinguishes a real
      // coercion from a `cast<String, String>()` that would throw on the null.
      expect(
        execute('''
        import 'dart:io';
        main() {
          var type = ContentType('text', 'plain',
              parameters: {'charset': 'utf-8', 'boundary': null});
          return [
            type.mimeType,
            type.parameters['charset'],
            type.parameters.containsKey('boundary'),
            type.parameters['boundary'],
          ];
        }
        '''),
        ['text/plain', 'utf-8', true, null],
      );
    });

    test('F-SCD173-2: HeaderValue takes a positional parameters map literal '
        '[2026-09-15] (PASS)', () {
      // Positional rather than named, which is the same coercion on the other
      // argument list — and the reason the rule is about ARGUMENTS and not
      // about named arguments specifically.
      expect(
        execute('''
        import 'dart:io';
        main() {
          var value = HeaderValue('form-data', {'name': 'file', 'flag': null});
          return [value.value, value.parameters['name'], value.toString()];
        }
        '''),
        ['form-data', 'file', 'form-data; name=file; flag'],
      );
    });

    test('F-SCD173-3: findProxyFromEnvironment takes an environment map '
        'literal [2026-09-15] (PASS)', () {
      // `Map<String, String>` — non-nullable values, so this is the variant
      // that would ALSO break on a `cast`, and the one place in `dart:io` where
      // a script hands over an environment rather than reading one.
      expect(
        execute('''
        import 'dart:io';
        main() => HttpClient.findProxyFromEnvironment(
          Uri.parse('http://example.com/'),
          environment: {'http_proxy': 'proxy.example:8080', 'no_proxy': ''},
        );
        '''),
        'PROXY proxy.example:8080',
      );
    });

    test('F-SCD173-4 (control): a wrongly-typed entry is still rejected, by '
        'name [2026-09-15] (PASS)', () {
      // The coercion widens the CONTAINER type and nothing else. Without this,
      // F-SCD173-1..3 are satisfied by a coercion that accepts anything — a
      // different bug with the same test results — and the diagnostic is the
      // other half of what `D4.coerceMap` buys over a cast: it names the
      // parameter and the type it got.
      expect(
        () => execute('''
        import 'dart:io';
        main() => ContentType('text', 'plain', parameters: {'charset': 7});
        '''),
        throwsA(
          predicate(
            (Object? e) =>
                e.toString().contains('parameters') &&
                e.toString().contains('int'),
            'an error naming the parameter and the offending type',
          ),
        ),
      );
    });
  });
}
