/// SCE160 — exec's own script-to-host boundary keeps a specialised
/// collection's type.
///
/// `_bridgeInterpreterValueToNative` in this package's `d4rt_base.dart`
/// rebuilt every List with `.map(...).toList()` and every Map with `.map`,
/// which retypes unconditionally: a `Uint8List` returned by a METHOD reached
/// the host as `List<Object?>` and `as Uint8List` threw. SCD98 fixed the same
/// function in the reference front end and in tom_d4rt_ast's runner; this
/// mirror was missed, and the pre-publish pass found it the moment a
/// constructor stopped returning a wrapper. The failure does not depend on
/// that change, though: a method return is a bare native on every version,
/// which is why these cases are red against the published interpreter too.
library;

import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('SCE160: exec\'s boundary rebuilds a collection only when it must', () {
    test('F-SCE160-EX-1: a Uint8List from a method reaches the host as a '
        'Uint8List [2026-09-25]', () async {
      final result = await D4rt().execute(
        source: '''
import 'dart:typed_data';
main() => Uint8List.fromList([1, 2, 3]).sublist(0);
''',
      );
      expect(result, isA<Uint8List>());
      expect(result, [1, 2, 3]);
    });

    test('F-SCE160-EX-2: a Float64List from a getter keeps its type too '
        '[2026-09-25]', () async {
      final result = await D4rt().execute(
        source: '''
import 'dart:typed_data';
main() => Float64List.fromList([1.5, 2.5]).buffer.asFloat64List();
''',
      );
      expect(result, isA<Float64List>());
      expect(result, [1.5, 2.5]);
    });

    test('F-SCE160-EX-3 (control): a list holding interpreter values is still '
        'rebuilt with native elements [2026-09-25]', () async {
      final result = await D4rt().execute(source: 'main() => [(1, 2)];');
      expect(result, [(1, 2)]);
    });
  });
}
