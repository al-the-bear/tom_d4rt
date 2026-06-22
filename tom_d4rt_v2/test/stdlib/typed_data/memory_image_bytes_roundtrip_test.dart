/// I-U29: proof that the `Uint8List` bridge round-trips bytes intact.
///
/// Background (OPEN A.6 / interpreter doc §U29). A flutter-material script
/// (`image_icon_test.dart`) built a `MemoryImage(Uint8List)` from an inline
/// PNG byte literal and the image codec rejected it ("Codec failed to produce
/// an image"). §U29 originally blamed the `Uint8List`/`MemoryImage` bridge,
/// claiming the bytes were corrupted on the way through the interpreter.
///
/// That diagnosis is wrong. The inline PNG literal in that script is itself
/// malformed (invalid IDAT CRC, failed zlib/adler32 — a real PNG decoder
/// rejects it too). The bridge preserves `Uint8List` bytes exactly. These
/// tests lock that down so the bug can never be re-attributed to the bridge:
///
///   1. A pure-interpreter `Uint8List.fromList([...])` returns a native
///      `Uint8List` whose bytes equal the source list byte-for-byte — proven
///      with BOTH the script's malformed PNG literal and a known-valid PNG.
///   2. `D4.extractBridgedArg<Uint8List>` — the exact extraction the generated
///      `MemoryImage(Uint8List bytes)` constructor performs on its argument —
///      returns the same `Uint8List` instance, bytes intact.
///
/// Mirrors the analyzer-free twin —
/// `tom_d4rt_ast/test/runtime/memory_image_bytes_roundtrip_test.dart`.
library;

import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_v2/d4rt.dart';

/// The malformed white 1x1 PNG literal from the §U29 script. Its IDAT CRC is
/// invalid, so a real codec rejects it — but the *bytes* must survive the
/// bridge unchanged.
const List<int> _malformedPngWhite = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, //
  0x54, 0x78, 0x9C, 0x63, 0xFC, 0xCF, 0xC0, 0x50, //
  0x0F, 0x00, 0x05, 0x01, 0x02, 0x00, 0x1D, 0x8A, //
  0x82, 0xC5, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, //
  0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82, //
];

/// A known-valid white 1x1 RGBA PNG (PIL-generated). A real codec accepts it.
const List<int> _validPngWhite = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, //
  0x54, 0x78, 0x9C, 0x63, 0xF8, 0xFF, 0xFF, 0xFF, //
  0x7F, 0x00, 0x09, 0xFB, 0x03, 0xFD, 0x2A, 0x86, //
  0xE3, 0x8A, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, //
  0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82, //
];

void main() {
  final d4rt = D4rt();
  const String testLibPath = 'd4rt-mem:/memory_image_roundtrip_test.dart';

  /// Runs a script that builds a `Uint8List.fromList(<source>)` and returns
  /// the native `Uint8List` back to the host.
  Uint8List interpretFromList(List<int> source) {
    final literal = source.join(', ');
    final result = d4rt.execute(
      library: testLibPath,
      name: 'main',
      sources: {
        testLibPath: '''
          import 'dart:typed_data';
          main() {
            return Uint8List.fromList(<int>[$literal]);
          }
        ''',
      },
    );
    return result as Uint8List;
  }

  group('I-U29: Uint8List bridge byte-preservation', () {
    test('I-U29-1: malformed PNG literal round-trips byte-for-byte', () {
      final out = interpretFromList(_malformedPngWhite);
      expect(out, isA<Uint8List>());
      expect(out.length, _malformedPngWhite.length);
      expect(out, orderedEquals(_malformedPngWhite));
    });

    test('I-U29-2: valid PNG literal round-trips byte-for-byte', () {
      final out = interpretFromList(_validPngWhite);
      expect(out, isA<Uint8List>());
      expect(out.length, _validPngWhite.length);
      expect(out, orderedEquals(_validPngWhite));
    });

    test(
        'I-U29-3: D4.extractBridgedArg<Uint8List> (the MemoryImage ctor path) '
        'preserves bytes', () {
      final bytes = Uint8List.fromList(_malformedPngWhite);
      final extracted = D4.extractBridgedArg<Uint8List>(bytes, 'bytes');
      expect(extracted, isA<Uint8List>());
      expect(extracted, orderedEquals(_malformedPngWhite));
      // Identity: nothing is copied/rebuilt, so no opportunity for corruption.
      expect(identical(extracted, bytes), isTrue);
    });
  });
}
