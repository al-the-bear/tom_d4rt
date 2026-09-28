/// SCE216 — every bridged `fuse` refuses through ONE message helper.
///
/// A script-defined `Converter` / `Codec` is an interpreted instance and can
/// never be fused (`fuse` builds a native pipeline); decision (b) was to say so
/// rather than build a callback adapter. The wording lives once, in
/// `stdlib/convert/fuse_argument.dart`, and this holds the twenty adapters to
/// it — a twenty-first `fuse` added with its own hand-written refusal would
/// reintroduce the message that read like the SCD181 erasure bug.
///
/// The script-level half (a script-defined converter actually refused, native
/// fusion still working) is `tom_d4rt/test/stdlib/convert/
/// sce216_fuse_script_converter_test.dart`; this package has no parser.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert/fuse_argument.dart';

const _convertDir = 'lib/src/runtime/stdlib/convert';

/// Every `'fuse': (...) { ... }` adapter body in [source].
List<String> _fuseAdapters(String source) {
  final out = <String>[];
  var from = 0;
  while (true) {
    final start = source.indexOf("'fuse': (", from);
    if (start < 0) return out;
    final open = source.indexOf('{', start);
    var depth = 0;
    var i = open;
    for (; i < source.length; i++) {
      if (source[i] == '{') depth++;
      if (source[i] == '}' && --depth == 0) break;
    }
    out.add(source.substring(start, i + 1));
    from = i + 1;
  }
}

void main() {
  group('SCE216: one refusal for every bridged fuse', () {
    test('F-SCE216-5: every fuse adapter in stdlib/convert refuses through '
        'fuseArgumentMessage [2026-09-28] (PASS)', () {
      final adapters = <String, String>{};
      for (final f in Directory(_convertDir).listSync().whereType<File>()) {
        final name = f.uri.pathSegments.last;
        var n = 0;
        for (final body in _fuseAdapters(f.readAsStringSync())) {
          adapters['$name#${n++}'] = body;
        }
      }
      // Measured 2026-09-28: 20 — five codecs (ascii, base64, json, latin1,
      // utf8) x codec / encoder / decoder = 15, plus HtmlEscape,
      // JsonUtf8Encoder, Encoding and the generic Converter / Codec bridges.
      expect(
        adapters.length,
        20,
        reason:
            'the fuse adapter census moved; a new or removed bridged fuse '
            'should be a deliberate edit here',
      );
      final handRolled = [
        for (final e in adapters.entries)
          if (!e.value.contains('fuseArgumentMessage(')) e.key,
      ];
      expect(
        handRolled,
        isEmpty,
        reason:
            'these fuse adapters refuse with their own wording; use '
            'fuseArgumentMessage so a script-defined converter is told about '
            'the limit',
      );
    });

    test('F-SCE216-6: a non-script argument keeps the plain type requirement '
        '[2026-09-28] (PASS)', () {
      expect(
        fuseArgumentMessage(
          'Utf8Decoder.fuse',
          'Converter<String, dynamic>',
          42,
        ),
        'Utf8Decoder.fuse requires another Converter<String, dynamic> as '
        'argument.',
      );
      expect(
        fuseArgumentMessage('Codec.fuse', 'Codec', null),
        'Codec.fuse requires another Codec as argument.',
      );
    });
  });
}
