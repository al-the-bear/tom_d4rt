// DFUB12: swapping the GZIP codec must not change the bundle format.
//
// `AstBundle` used to compress with `dart:io`'s `gzip` codec. It now uses
// `package:archive`'s `GZipEncoder`/`GZipDecoder`, which delegate to the native
// `dart:io` codec on native and to a pure-Dart ZLib on web — that platform
// switch is the whole reason for the change (see web_safety_test.dart).
//
// `.ast` bundles are PERSISTED ARTIFACTS: they are built on a host, shipped,
// and read back later — possibly by a different version of this package. So
// the swap has to be format-preserving in BOTH directions, and "both codecs
// are called gzip" is not evidence. These tests pin it down empirically:
// bytes produced by one codec must be readable by the other.
//
// If this ever fails, the bundle format has forked and every previously
// shipped `.ast` file is at risk — it is not a test to relax.

import 'dart:convert';
import 'dart:io' as io;

import 'package:archive/archive.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('DFUB12: gzip codec interop between dart:io and package:archive', () {
    // Deliberately compressible and non-trivial in size — a few bytes would
    // round-trip through almost anything and prove nothing about the framing.
    final payload = utf8.encode(
      jsonEncode({
        'modules': List.generate(
          50,
          (i) => {'uri': 'package:x/m$i.dart', 'body': 'a' * 200},
        ),
      }),
    );

    test('F-DFUB12-4: archive decodes what dart:io encoded [2026-07-27]', () {
      final legacyBytes = io.gzip.encode(payload);

      expect(
        const GZipDecoder().decodeBytes(legacyBytes),
        equals(payload),
        reason: 'a bundle written by a pre-DFUB12 build must still load',
      );
    });

    test('F-DFUB12-5: dart:io decodes what archive encoded [2026-07-27]', () {
      final newBytes = const GZipEncoder().encodeBytes(payload);

      expect(
        io.gzip.decode(newBytes),
        equals(payload),
        reason:
            'a bundle written by a post-DFUB12 build must still load in '
            'a consumer pinned to an older tom_d4rt_ast',
      );
    });

    test('F-DFUB12-6: the gzip magic bytes AstBundle sniffs on are unchanged '
        '[2026-07-27]', () {
      // AstBundle.fromFile / _decodeModuleContent auto-detect the format from
      // the first two bytes. If the new encoder framed its output differently
      // the sniff would silently fall through to the "plain JSON" branch.
      final newBytes = const GZipEncoder().encodeBytes(payload);

      expect(newBytes.take(2), equals([0x1F, 0x8B]));
    });

    test('F-DFUB12-7: AstBundle byte round-trip still works end to end '
        '[2026-07-27]', () {
      final bundle = AstBundle(
        modules: {
          'package:x/main.dart': SCompilationUnit(offset: 0, length: 0),
        },
        entryPointUri: 'package:x/main.dart',
      );

      final restored = AstBundle.fromBytes(bundle.toBytes());

      expect(restored.entryPointUri, equals('package:x/main.dart'));
      expect(restored.modules.keys, equals(['package:x/main.dart']));
    });

    test('F-DFUB12-8: AstBundle ZIP round-trip still works end to end '
        '[2026-07-27]', () {
      // toZip stores each module pre-compressed with the swapped encoder and
      // marks the archive entry `noCompress`, so this exercises the encoder
      // and the decoder on the path that produces real `.ast` files.
      final bundle = AstBundle(
        modules: {
          'package:x/main.dart': SCompilationUnit(offset: 0, length: 0),
          'package:x/lib.dart': SCompilationUnit(offset: 0, length: 0),
        },
        entryPointUri: 'package:x/main.dart',
      );

      final restored = AstBundle.fromZip(bundle.toZip());

      expect(restored.entryPointUri, equals('package:x/main.dart'));
      expect(
        restored.modules.keys,
        containsAll(['package:x/main.dart', 'package:x/lib.dart']),
      );
    });
  });
}
