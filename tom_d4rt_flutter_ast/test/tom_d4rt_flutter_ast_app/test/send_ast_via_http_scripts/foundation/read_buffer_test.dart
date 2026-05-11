// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_import
// D4rt test script: Deep Demo - ReadBuffer from package:flutter/foundation.dart
// Demonstrates sequential binary reading of values produced by WriteBuffer.
// Renders byte dumps, advancing read cursors, and parsed value cards.

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1 DATA: DOSSIER
  // ===========================================================================

  final dossier = <Map<String, String>>[
    {
      'field': 'Class',
      'value': 'ReadBuffer',
    },
    {
      'field': 'Library',
      'value': 'package:flutter/foundation.dart',
    },
    {
      'field': 'Counterpart',
      'value': 'WriteBuffer (producer)',
    },
    {
      'field': 'Role',
      'value': 'Sequential reader over a ByteData',
    },
    {
      'field': 'Endianness',
      'value': 'host endian (little endian on most platforms)',
    },
    {
      'field': 'Primary use',
      'value': 'Binary message channel encoding for platform channels',
    },
    {
      'field': 'Layout',
      'value': 'Tightly packed primitives with alignment for typed lists',
    },
    {
      'field': 'Cursor',
      'value': 'Internal offset advanced by each get* call',
    },
    {
      'field': 'Lifetime',
      'value': 'Single forward pass; no random access API',
    },
    {
      'field': 'Coupling',
      'value': 'Schema must be agreed between writer and reader',
    },
  ];

  // ===========================================================================
  // SECTION 2 DATA: ANATOMY OF METHODS
  // ===========================================================================

  final anatomy = <Map<String, String>>[
    {
      'member': 'ReadBuffer(ByteData data)',
      'kind': 'constructor',
      'cost': 'O(1) — wraps existing buffer, does not copy',
    },
    {
      'member': 'bool get hasRemaining',
      'kind': 'getter',
      'cost': 'O(1) — compares cursor to length',
    },
    {
      'member': 'int getUint8()',
      'kind': 'reader',
      'cost': '1 byte; advances cursor by 1',
    },
    {
      'member': 'int getInt32()',
      'kind': 'reader',
      'cost': '4 bytes; advances cursor by 4',
    },
    {
      'member': 'int getUint32()',
      'kind': 'reader',
      'cost': '4 bytes; advances cursor by 4',
    },
    {
      'member': 'int getInt64()',
      'kind': 'reader',
      'cost': '8 bytes; advances cursor by 8',
    },
    {
      'member': 'double getFloat64()',
      'kind': 'reader',
      'cost': '8 bytes; advances cursor by 8',
    },
    {
      'member': 'Uint8List getUint8List(int length)',
      'kind': 'reader',
      'cost': 'length bytes (no alignment padding)',
    },
    {
      'member': 'Int32List getInt32List(int length)',
      'kind': 'reader',
      'cost': 'pad to 4-byte boundary + length*4',
    },
    {
      'member': 'Int64List getInt64List(int length)',
      'kind': 'reader',
      'cost': 'pad to 8-byte boundary + length*8',
    },
    {
      'member': 'Float64List getFloat64List(int length)',
      'kind': 'reader',
      'cost': 'pad to 8-byte boundary + length*8',
    },
  ];

  // ===========================================================================
  // SECTION 3 DATA: PRIMITIVE ROUND-TRIPS
  // ===========================================================================

  // Helper to dump bytes from a ByteData as upper-case hex pairs.
  List<String> dumpBytes(ByteData bd) {
    final out = <String>[];
    for (var i = 0; i < bd.lengthInBytes; i++) {
      final b = bd.getUint8(i);
      out.add(b.toRadixString(16).toUpperCase().padLeft(2, '0'));
    }
    return out;
  }

  // ----- Uint8 round-trip -----
  final wbU8 = WriteBuffer();
  wbU8.putUint8(0x2A);
  wbU8.putUint8(0xFF);
  wbU8.putUint8(0x01);
  wbU8.putUint8(0x80);
  final bdU8 = wbU8.done();
  final rbU8 = ReadBuffer(bdU8);
  final u8Values = <int>[
    rbU8.getUint8(),
    rbU8.getUint8(),
    rbU8.getUint8(),
    rbU8.getUint8(),
  ];
  final u8Dump = dumpBytes(bdU8);

  // ----- Int32 round-trip -----
  final wbI32 = WriteBuffer();
  wbI32.putInt32(42);
  wbI32.putInt32(-1);
  wbI32.putInt32(0x7FFFFFFF);
  final bdI32 = wbI32.done();
  final rbI32 = ReadBuffer(bdI32);
  final i32Values = <int>[
    rbI32.getInt32(),
    rbI32.getInt32(),
    rbI32.getInt32(),
  ];
  final i32Dump = dumpBytes(bdI32);

  // ----- Uint32 round-trip -----
  final wbU32 = WriteBuffer();
  wbU32.putUint32(0);
  wbU32.putUint32(0xDEADBEEF);
  wbU32.putUint32(0x12345678);
  final bdU32 = wbU32.done();
  final rbU32 = ReadBuffer(bdU32);
  final u32Values = <int>[
    rbU32.getUint32(),
    rbU32.getUint32(),
    rbU32.getUint32(),
  ];
  final u32Dump = dumpBytes(bdU32);

  // ----- Int64 round-trip -----
  final wbI64 = WriteBuffer();
  wbI64.putInt64(1);
  wbI64.putInt64(-2);
  wbI64.putInt64(0x0102030405060708);
  final bdI64 = wbI64.done();
  final rbI64 = ReadBuffer(bdI64);
  final i64Values = <int>[
    rbI64.getInt64(),
    rbI64.getInt64(),
    rbI64.getInt64(),
  ];
  final i64Dump = dumpBytes(bdI64);

  // ----- Float64 round-trip -----
  final wbF64 = WriteBuffer();
  wbF64.putFloat64(3.14159);
  wbF64.putFloat64(2.71828);
  wbF64.putFloat64(-0.5);
  final bdF64 = wbF64.done();
  final rbF64 = ReadBuffer(bdF64);
  final f64Values = <double>[
    rbF64.getFloat64(),
    rbF64.getFloat64(),
    rbF64.getFloat64(),
  ];
  final f64Dump = dumpBytes(bdF64);

  // ===========================================================================
  // SECTION 4 DATA: TYPED LIST READS WITH ALIGNMENT
  // ===========================================================================

  // Uint8 marker + Int32List shows the alignment pad bytes.
  final wbAlign = WriteBuffer();
  wbAlign.putUint8(0xAA); // 1 byte
  wbAlign.putInt32List(Int32List.fromList(<int>[10, 20, 30])); // pad 3 + 12
  final bdAlign = wbAlign.done();
  final alignDump = dumpBytes(bdAlign);
  final rbAlign = ReadBuffer(bdAlign);
  final alignMarker = rbAlign.getUint8();
  final alignList = rbAlign.getInt32List(3).toList();

  // Uint8 marker + Int64List shows 8-byte alignment.
  final wbAlign8 = WriteBuffer();
  wbAlign8.putUint8(0xBB); // 1 byte
  wbAlign8.putInt64List(Int64List.fromList(<int>[1, 2, 3])); // pad 7 + 24
  final bdAlign8 = wbAlign8.done();
  final align8Dump = dumpBytes(bdAlign8);
  final rbAlign8 = ReadBuffer(bdAlign8);
  final align8Marker = rbAlign8.getUint8();
  final align8List = rbAlign8.getInt64List(3).toList();

  // Uint8 marker + Float64List shows 8-byte alignment.
  final wbAlignF = WriteBuffer();
  wbAlignF.putUint8(0xCC);
  wbAlignF.putFloat64List(Float64List.fromList(<double>[0.5, 1.5, 2.5]));
  final bdAlignF = wbAlignF.done();
  final alignFDump = dumpBytes(bdAlignF);
  final rbAlignF = ReadBuffer(bdAlignF);
  final alignFMarker = rbAlignF.getUint8();
  final alignFList = rbAlignF.getFloat64List(3).toList();

  // Uint8List does NOT pad (it is byte-aligned).
  final wbBytes = WriteBuffer();
  wbBytes.putUint8(0xDD);
  wbBytes.putUint8List(Uint8List.fromList(<int>[1, 2, 3, 4, 5]));
  final bdBytes = wbBytes.done();
  final bytesDump = dumpBytes(bdBytes);
  final rbBytes = ReadBuffer(bdBytes);
  final bytesMarker = rbBytes.getUint8();
  final bytesList = rbBytes.getUint8List(5).toList();

  // ===========================================================================
  // SECTION 5 DATA: MIXED RECORD WALK-THROUGH
  // ===========================================================================

  // Format: u8 tag, i32 count, f64 ratio, i64 timestamp, u8 trailer.
  final wbMixed = WriteBuffer();
  wbMixed.putUint8(0x07); // tag
  wbMixed.putInt32(123456); // count
  wbMixed.putFloat64(0.875); // ratio
  wbMixed.putInt64(0x00000001A0000000); // timestamp-like
  wbMixed.putUint8(0xEE); // trailer
  final bdMixed = wbMixed.done();
  final mixedDump = dumpBytes(bdMixed);
  final rbMixed = ReadBuffer(bdMixed);

  final mixedSteps = <Map<String, dynamic>>[];
  var cursor = 0;
  final tag = rbMixed.getUint8();
  mixedSteps.add(<String, dynamic>{
    'step': 1,
    'method': 'getUint8()',
    'span': '$cursor..${cursor + 0}',
    'bytes': mixedDump.sublist(cursor, cursor + 1).join(' '),
    'value': tag.toString(),
  });
  cursor += 1;
  final count = rbMixed.getInt32();
  mixedSteps.add(<String, dynamic>{
    'step': 2,
    'method': 'getInt32()',
    'span': '$cursor..${cursor + 3}',
    'bytes': mixedDump.sublist(cursor, cursor + 4).join(' '),
    'value': count.toString(),
  });
  cursor += 4;
  final ratio = rbMixed.getFloat64();
  mixedSteps.add(<String, dynamic>{
    'step': 3,
    'method': 'getFloat64()',
    'span': '$cursor..${cursor + 7}',
    'bytes': mixedDump.sublist(cursor, cursor + 8).join(' '),
    'value': ratio.toString(),
  });
  cursor += 8;
  final ts = rbMixed.getInt64();
  mixedSteps.add(<String, dynamic>{
    'step': 4,
    'method': 'getInt64()',
    'span': '$cursor..${cursor + 7}',
    'bytes': mixedDump.sublist(cursor, cursor + 8).join(' '),
    'value': ts.toString(),
  });
  cursor += 8;
  final trailer = rbMixed.getUint8();
  mixedSteps.add(<String, dynamic>{
    'step': 5,
    'method': 'getUint8()',
    'span': '$cursor..$cursor',
    'bytes': mixedDump.sublist(cursor, cursor + 1).join(' '),
    'value': trailer.toString(),
  });
  cursor += 1;

  // ===========================================================================
  // SECTION 6 DATA: WIRE FORMAT MINI PROTOCOL
  // ===========================================================================

  // Pretend protocol: cmd:u8 | length:u32 | payload:bytes[length]
  Uint8List encodeFrame(int cmd, List<int> payload) {
    final wb = WriteBuffer();
    wb.putUint8(cmd);
    wb.putUint32(payload.length);
    wb.putUint8List(Uint8List.fromList(payload));
    return wb.done().buffer.asUint8List();
  }

  final frameA = encodeFrame(0x01, <int>[0x48, 0x49]); // "HI"
  final frameB = encodeFrame(0x02, <int>[0x50, 0x4F, 0x4E, 0x47]); // "PONG"
  final frameC = encodeFrame(0x03, <int>[]); // empty payload

  Map<String, dynamic> decodeFrame(Uint8List bytes) {
    final bd = ByteData.sublistView(bytes);
    final rb = ReadBuffer(bd);
    final cmd = rb.getUint8();
    final length = rb.getUint32();
    final payload = rb.getUint8List(length);
    final text = String.fromCharCodes(payload);
    return <String, dynamic>{
      'cmd': '0x' +
          cmd.toRadixString(16).toUpperCase().padLeft(2, '0'),
      'length': length,
      'payload_hex': payload
          .map((b) =>
              b.toRadixString(16).toUpperCase().padLeft(2, '0'))
          .join(' '),
      'payload_text': text,
      'frame_hex': bytes
          .map((b) =>
              b.toRadixString(16).toUpperCase().padLeft(2, '0'))
          .join(' '),
    };
  }

  final framesDecoded = <Map<String, dynamic>>[
    decodeFrame(frameA),
    decodeFrame(frameB),
    decodeFrame(frameC),
  ];

  // ===========================================================================
  // SECTION 7 DATA: hasRemaining SHOWCASE
  // ===========================================================================

  final wbScan = WriteBuffer();
  for (var i = 1; i <= 6; i++) {
    wbScan.putUint8(i * 10);
  }
  final bdScan = wbScan.done();
  final scanDump = dumpBytes(bdScan);
  final rbScan = ReadBuffer(bdScan);
  final scanTrace = <Map<String, dynamic>>[];
  var scanIndex = 0;
  while (rbScan.hasRemaining) {
    final value = rbScan.getUint8();
    scanTrace.add(<String, dynamic>{
      'index': scanIndex,
      'value': value,
      'hasRemainingAfter': rbScan.hasRemaining,
    });
    scanIndex += 1;
  }

  // ===========================================================================
  // SECTION 8 DATA: RECIPES
  // ===========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Decode a fixed header',
      'body':
          'Agree on order: u8 version, u32 flags, u32 payload-length. Then call '
              'getUint8 / getUint32 / getUint32 in that exact order.',
    },
    {
      'title': 'Read a TLV record',
      'body': 'Use getUint8() for tag, getUint32() for length, then '
          'getUint8List(length) for the value bytes.',
    },
    {
      'title': 'Stream-parse a list of records',
      'body':
          'Loop while ReadBuffer.hasRemaining and parse one record per iteration; '
              'stop naturally when the buffer is exhausted.',
    },
    {
      'title': 'Decode a vector of doubles',
      'body':
          'Write the length as u32 with WriteBuffer, then putFloat64List(values). '
              'On read: getUint32 then getFloat64List(length).',
    },
    {
      'title': 'Skip a typed-list pad',
      'body':
          'Typed lists are aligned to their element width. Trust ReadBuffer to '
              'consume the pad bytes; do not manually advance.',
    },
    {
      'title': 'Decode a string blob',
      'body': 'Write byte count as u32 then putUint8List(utf8.encode(s)). '
          'On read: length = getUint32, then '
          'utf8.decode(getUint8List(length)).',
    },
    {
      'title': 'Inspect bytes during debugging',
      'body':
          'Wrap a ByteData in a ReadBuffer for parsing, but keep a Uint8List view '
              'around to print hex while you debug schema mismatches.',
    },
    {
      'title': 'Validate before decoding',
      'body':
          'Check ByteData.lengthInBytes against a minimum size before constructing '
              'the ReadBuffer to avoid out-of-range reads.',
    },
  ];

  // ===========================================================================
  // SECTION 9 DATA: COMPARISON TABLE
  // ===========================================================================

  final comparisonRows = <Map<String, String>>[
    {
      'feature': 'Sequential cursor',
      'readbuffer': 'yes — automatic',
      'bytedata': 'no — caller tracks offset',
      'uint8list': 'no — index manually',
    },
    {
      'feature': 'Typed list read',
      'readbuffer': 'yes — getInt32List / getFloat64List etc.',
      'bytedata': 'no — must build view manually',
      'uint8list': 'no — must convert bytes manually',
    },
    {
      'feature': 'Alignment handling',
      'readbuffer': 'yes — pads aligned with WriteBuffer',
      'bytedata': 'manual',
      'uint8list': 'manual',
    },
    {
      'feature': 'Float decoding',
      'readbuffer': 'yes — getFloat64',
      'bytedata': 'yes — getFloat64(offset)',
      'uint8list': 'no — needs ByteData view',
    },
    {
      'feature': 'Bounds errors',
      'readbuffer': 'RangeError on overrun',
      'bytedata': 'RangeError on overrun',
      'uint8list': 'RangeError on overrun',
    },
    {
      'feature': 'Intended pair',
      'readbuffer': 'WriteBuffer',
      'bytedata': 'none — primitive',
      'uint8list': 'none — primitive',
    },
    {
      'feature': 'API surface',
      'readbuffer': 'narrow — get* methods only',
      'bytedata': 'broad — random get/set',
      'uint8list': 'broad — index + view',
    },
  ];

  // ===========================================================================
  // SECTION 10 DATA: GLOSSARY
  // ===========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'ByteData',
      'definition':
          'Random-access view over a byte buffer with typed get/set methods.',
    },
    {
      'term': 'Cursor',
      'definition':
          'The internal offset that ReadBuffer advances after each read.',
    },
    {
      'term': 'Alignment',
      'definition':
          'Insertion of pad bytes so a typed-list starts on a multiple of '
              'its element width.',
    },
    {
      'term': 'Endianness',
      'definition':
          'Byte order used to lay out multi-byte numbers in memory.',
    },
    {
      'term': 'Wire format',
      'definition':
          'The agreed binary layout between writer and reader sides of a '
              'channel.',
    },
    {
      'term': 'TLV',
      'definition':
          'Tag-Length-Value, a common framing pattern for self-describing '
              'records.',
    },
    {
      'term': 'Float64',
      'definition':
          'IEEE 754 double-precision 64-bit floating point number.',
    },
    {
      'term': 'Int32',
      'definition':
          'Two\'s-complement signed 32-bit integer, range ~-2.1B to 2.1B.',
    },
    {
      'term': 'Int64',
      'definition':
          'Two\'s-complement signed 64-bit integer, used for large IDs and '
              'timestamps.',
    },
    {
      'term': 'WriteBuffer',
      'definition':
          'Producer side counterpart to ReadBuffer; appends bytes and '
              'finalizes to ByteData via done().',
    },
    {
      'term': 'done()',
      'definition':
          'WriteBuffer terminator returning a ByteData snapshot for handing '
              'to ReadBuffer.',
    },
    {
      'term': 'hasRemaining',
      'definition':
          'Boolean getter — true while the cursor has not reached the end '
              'of the underlying ByteData.',
    },
  ];

  // ===========================================================================
  // RENDERING
  // ===========================================================================

  Widget sectionHeader(int n, String title, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'SECTION $n',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget twoColRow(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              left,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget byteDumpRow(List<String> dump, {int? highlightStart, int? highlightEnd, Color highlight = Colors.orange}) {
    final chips = <Widget>[];
    for (var i = 0; i < dump.length; i++) {
      final inSel = highlightStart != null &&
          highlightEnd != null &&
          i >= highlightStart &&
          i <= highlightEnd;
      chips.add(Container(
        margin: const EdgeInsets.only(right: 4, bottom: 4),
        padding:
            const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: inSel ? highlight : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          dump[i],
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: inSel ? Colors.white : Colors.black87,
            fontWeight: inSel ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ));
    }
    return Wrap(children: chips);
  }

  Widget byteDumpWithOffsets(List<String> dump) {
    final rows = <Widget>[];
    const perRow = 16;
    for (var start = 0; start < dump.length; start += perRow) {
      final end = (start + perRow > dump.length) ? dump.length : start + perRow;
      final slice = dump.sublist(start, end);
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: Colors.blueGrey.shade50,
              child: Text(
                '0x' + start.toRadixString(16).toUpperCase().padLeft(4, '0'),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                slice.join(' '),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget valueCard(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBox(String message, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  // -------------------- SECTION 1 widget: dossier --------------------

  final section1 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Dossier — ReadBuffer in the platform-channel stack',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'ReadBuffer reads a ByteData produced by WriteBuffer. It is the binary '
              'counterpart of a stream of put* / get* operations agreed between '
              'the two ends of a Flutter platform channel.',
          Colors.indigo,
        ),
        const SizedBox(height: 8),
        ...dossier.map((m) => twoColRow(m['field']!, m['value']!)),
      ],
    ),
  );

  // -------------------- SECTION 2 widget: anatomy --------------------

  final section2 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy — constructor and reader methods',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'Each get* call advances the internal cursor by the indicated number '
              'of bytes. Typed-list reads also consume up to (alignment - 1) '
              'pad bytes that WriteBuffer emitted on the producer side.',
          Colors.teal,
        ),
        const SizedBox(height: 8),
        ...anatomy.map((m) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 110,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      m['kind']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          m['member']!,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          m['cost']!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );

  // -------------------- SECTION 3 widget: primitive round-trips ----

  Widget primitiveBlock({
    required String title,
    required List<String> dump,
    required List<String> labels,
    required List<String> values,
    required Color color,
  }) {
    final cards = <Widget>[];
    for (var i = 0; i < labels.length; i++) {
      cards.add(valueCard(labels[i], values[i], color));
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bytes on the wire:',
            style: TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          byteDumpRow(dump, highlight: color),
          const SizedBox(height: 8),
          const Text(
            'Decoded values:',
            style: TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Wrap(children: cards),
        ],
      ),
    );
  }

  final section3 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Primitive round-trips — WriteBuffer.put* → ReadBuffer.get*',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'For each primitive type we encode three values with WriteBuffer, '
              'dump the byte representation, then decode with ReadBuffer. The '
              'decoded values match the input exactly, byte-for-byte.',
          Colors.deepPurple,
        ),
        const SizedBox(height: 12),
        primitiveBlock(
          title: 'getUint8 — single byte',
          dump: u8Dump,
          labels: <String>['[0]', '[1]', '[2]', '[3]'],
          values: u8Values.map((v) => v.toString()).toList(),
          color: Colors.deepPurple,
        ),
        primitiveBlock(
          title: 'getInt32 — 4 bytes, signed',
          dump: i32Dump,
          labels: <String>['[0]', '[1]', '[2]'],
          values: i32Values.map((v) => v.toString()).toList(),
          color: Colors.indigo,
        ),
        primitiveBlock(
          title: 'getUint32 — 4 bytes, unsigned',
          dump: u32Dump,
          labels: <String>['[0]', '[1]', '[2]'],
          values: u32Values
              .map((v) =>
                  '0x' + v.toRadixString(16).toUpperCase().padLeft(8, '0'))
              .toList(),
          color: Colors.blue,
        ),
        primitiveBlock(
          title: 'getInt64 — 8 bytes, signed',
          dump: i64Dump,
          labels: <String>['[0]', '[1]', '[2]'],
          values: i64Values.map((v) => v.toString()).toList(),
          color: Colors.teal,
        ),
        primitiveBlock(
          title: 'getFloat64 — IEEE 754 double',
          dump: f64Dump,
          labels: <String>['[0]', '[1]', '[2]'],
          values: f64Values.map((v) => v.toString()).toList(),
          color: Colors.green,
        ),
      ],
    ),
  );

  // -------------------- SECTION 4 widget: typed lists --------------------

  Widget listBlock({
    required String title,
    required String description,
    required List<String> dump,
    required int markerLen,
    required int padLen,
    required int payloadLen,
    required String markerLabel,
    required String marker,
    required String payloadLabel,
    required String payload,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          // Render dump with 3 color zones: marker / pad / payload
          Wrap(
            children: <Widget>[
              for (var i = 0; i < dump.length; i++)
                Container(
                  margin: const EdgeInsets.only(right: 4, bottom: 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: i < markerLen
                        ? Colors.amber
                        : (i < markerLen + padLen
                            ? Colors.red.shade300
                            : color),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    dump[i],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              _legend(Colors.amber, 'marker u8 ($markerLen B)'),
              const SizedBox(width: 6),
              _legend(Colors.red.shade300, 'alignment pad ($padLen B)'),
              const SizedBox(width: 6),
              _legend(color, 'list payload ($payloadLen B)'),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            children: <Widget>[
              valueCard(markerLabel, marker, Colors.amber.shade800),
              valueCard(payloadLabel, payload, color),
            ],
          ),
        ],
      ),
    );
  }

  final section4 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Typed list reads — alignment visible in the dump',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'When a typed list follows a misaligned cursor, WriteBuffer pads with '
              'extra bytes so the payload starts on a multiple of the element '
              'width. ReadBuffer transparently consumes that pad — but you can '
              'see it clearly in the byte dump below.',
          Colors.orange,
        ),
        const SizedBox(height: 12),
        listBlock(
          title: 'Int32List of length 3 after a u8 marker',
          description: 'pad = 3 bytes to reach 4-byte alignment; payload = 12 B',
          dump: alignDump,
          markerLen: 1,
          padLen: 3,
          payloadLen: 12,
          markerLabel: 'marker u8',
          marker:
              '0x' + alignMarker.toRadixString(16).toUpperCase().padLeft(2, '0'),
          payloadLabel: 'Int32List(3)',
          payload: alignList.toString(),
          color: Colors.orange,
        ),
        listBlock(
          title: 'Int64List of length 3 after a u8 marker',
          description: 'pad = 7 bytes to reach 8-byte alignment; payload = 24 B',
          dump: align8Dump,
          markerLen: 1,
          padLen: 7,
          payloadLen: 24,
          markerLabel: 'marker u8',
          marker: '0x' +
              align8Marker.toRadixString(16).toUpperCase().padLeft(2, '0'),
          payloadLabel: 'Int64List(3)',
          payload: align8List.toString(),
          color: Colors.deepOrange,
        ),
        listBlock(
          title: 'Float64List of length 3 after a u8 marker',
          description: 'pad = 7 bytes to reach 8-byte alignment; payload = 24 B',
          dump: alignFDump,
          markerLen: 1,
          padLen: 7,
          payloadLen: 24,
          markerLabel: 'marker u8',
          marker: '0x' +
              alignFMarker.toRadixString(16).toUpperCase().padLeft(2, '0'),
          payloadLabel: 'Float64List(3)',
          payload: alignFList.toString(),
          color: Colors.green,
        ),
        listBlock(
          title: 'Uint8List of length 5 after a u8 marker',
          description: 'pad = 0 (bytes are 1-aligned); payload = 5 B',
          dump: bytesDump,
          markerLen: 1,
          padLen: 0,
          payloadLen: 5,
          markerLabel: 'marker u8',
          marker: '0x' +
              bytesMarker.toRadixString(16).toUpperCase().padLeft(2, '0'),
          payloadLabel: 'Uint8List(5)',
          payload: bytesList.toString(),
          color: Colors.blue,
        ),
      ],
    ),
  );

  // -------------------- SECTION 5 widget: mixed cursor walkthrough --

  final section5 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Mixed-record walk-through — cursor steps',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'A buffer with five interleaved fields: u8 tag, i32 count, f64 ratio, '
              'i64 timestamp, u8 trailer. We highlight the slice consumed by '
              'each step and report the value the reader produced.',
          Colors.purple,
        ),
        const SizedBox(height: 12),
        const Text(
          'Full byte dump:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 6),
        byteDumpWithOffsets(mixedDump),
        const SizedBox(height: 12),
        ...List<Widget>.generate(mixedSteps.length, (i) {
          final step = mixedSteps[i];
          final parts = (step['span'] as String).split('..');
          final from = int.parse(parts[0]);
          final to = int.parse(parts[1]);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.purple.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.purple,
                      child: Text(
                        step['step'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      step['method'].toString(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      color: Colors.purple.shade100,
                      child: Text(
                        'span ${step['span']}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                byteDumpRow(
                  mixedDump,
                  highlightStart: from,
                  highlightEnd: to,
                  highlight: Colors.purple,
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    const Icon(Icons.arrow_forward,
                        size: 14, color: Colors.purple),
                    const SizedBox(width: 4),
                    Text(
                      'value = ${step['value']}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        infoBox(
          'After step 5 the cursor sits at $cursor and hasRemaining is now '
              '${rbMixed.hasRemaining}. The buffer is exhausted.',
          Colors.purple,
        ),
      ],
    ),
  );

  // -------------------- SECTION 6 widget: wire format --------------

  final section6 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Mini wire format — cmd(u8) | length(u32) | payload',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'A toy protocol shows the typical handler shape: read a command byte, '
              'read the payload length, then pull the payload as a Uint8List. '
              'The bytes shown below were produced with WriteBuffer and decoded '
              'with ReadBuffer in one pass.',
          Colors.cyan,
        ),
        const SizedBox(height: 12),
        ...framesDecoded.map((frame) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.cyan.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        color: Colors.cyan,
                        child: Text(
                          'cmd ${frame['cmd']}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'length = ${frame['length']}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'frame: ${frame['frame_hex']}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'payload (hex): ${frame['payload_hex']}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'payload (text): "${frame['payload_text']}"',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );

  // -------------------- SECTION 7 widget: hasRemaining --------------

  final section7 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.lime.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'hasRemaining showcase — loop until exhausted',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        infoBox(
          'Iterate while ReadBuffer.hasRemaining is true. Once the cursor has '
              'consumed every byte the flag flips to false and the loop stops.',
          Colors.lime.shade800,
        ),
        const SizedBox(height: 8),
        const Text(
          'Buffer dump (6 bytes):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 6),
        byteDumpRow(scanDump, highlight: Colors.lime.shade700),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: 60,
              child: Text(
                'i',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              child: Text(
                'getUint8()',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'hasRemaining after',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Divider(),
        ...scanTrace.map((row) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: Text(
                      row['index'].toString(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      row['value'].toString(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    color: row['hasRemainingAfter'] == true
                        ? Colors.lightGreen.shade200
                        : Colors.red.shade100,
                    child: Text(
                      row['hasRemainingAfter'].toString(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );

  // -------------------- SECTION 8 widget: recipes ----------------------

  final section8 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.brown.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recipes — common ReadBuffer patterns',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        ...recipes.map((r) => Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.brown.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.menu_book,
                          size: 16, color: Colors.brown),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          r['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    r['body']!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )),
      ],
    ),
  );

  // -------------------- SECTION 9 widget: comparison -----------------

  final section9 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.pink.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Comparison — ReadBuffer vs ByteData vs Uint8List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(color: Colors.pink.shade200),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(3),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: Colors.pink.shade100),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    'Feature',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    'ReadBuffer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    'ByteData',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    'Uint8List',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...comparisonRows.map((r) => TableRow(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(r['feature']!,
                          style:
                              const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(r['readbuffer']!,
                          style: const TextStyle(fontSize: 12)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(r['bytedata']!,
                          style: const TextStyle(fontSize: 12)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(r['uint8list']!,
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ],
                )),
          ],
        ),
      ],
    ),
  );

  // -------------------- SECTION 10 widget: glossary -----------------

  final section10 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Glossary — terminology used in this demo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        ...glossary.map((g) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    child: Text(
                      g['term']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      g['definition']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );

  // -------------------- SECTION 11 widget: composed summary ---------

  final section11 = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.indigo.shade50, Colors.cyan.shade50],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Composed summary — what we exercised',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Wrap(
          children: <Widget>[
            valueCard('uint8 reads', '${u8Values.length}', Colors.deepPurple),
            valueCard('int32 reads', '${i32Values.length}', Colors.indigo),
            valueCard('uint32 reads', '${u32Values.length}', Colors.blue),
            valueCard('int64 reads', '${i64Values.length}', Colors.teal),
            valueCard('float64 reads', '${f64Values.length}', Colors.green),
            valueCard('list reads', '4', Colors.orange),
            valueCard('cursor steps', '${mixedSteps.length}', Colors.purple),
            valueCard('frames decoded', '${framesDecoded.length}', Colors.cyan),
            valueCard('scan ticks', '${scanTrace.length}', Colors.lime.shade800),
            valueCard('recipes', '${recipes.length}', Colors.brown),
            valueCard('glossary terms', '${glossary.length}', Colors.blueGrey),
          ],
        ),
        const SizedBox(height: 10),
        infoBox(
          'Every byte rendered in this demo was produced by WriteBuffer and '
              'consumed by ReadBuffer. The cursor advanced strictly forward, '
              'and hasRemaining served as the natural termination signal.',
          Colors.indigo,
        ),
      ],
    ),
  );

  // ===========================================================================
  // FINAL WIDGET TREE
  // ===========================================================================

  return Scaffold(
    appBar: AppBar(
      title: const Text('ReadBuffer — Deep Visual Demo'),
      backgroundColor: Colors.indigo,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'package:flutter/foundation.dart → ReadBuffer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Sequential reader over a ByteData produced by WriteBuffer',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          sectionHeader(1, 'Dossier', Colors.indigo),
          section1,
          sectionHeader(2, 'Anatomy of read methods', Colors.teal),
          section2,
          sectionHeader(3, 'Primitive round-trips', Colors.deepPurple),
          section3,
          sectionHeader(4, 'Typed lists & alignment', Colors.orange),
          section4,
          sectionHeader(5, 'Mixed record cursor walk', Colors.purple),
          section5,
          sectionHeader(6, 'Wire format protocol', Colors.cyan),
          section6,
          sectionHeader(7, 'hasRemaining showcase', Colors.lime.shade800),
          section7,
          sectionHeader(8, 'Recipes', Colors.brown),
          section8,
          sectionHeader(9, 'Comparison table', Colors.pink),
          section9,
          sectionHeader(10, 'Glossary', Colors.blueGrey),
          section10,
          sectionHeader(11, 'Composed summary', Colors.indigo),
          section11,
          const SizedBox(height: 32),
          const Center(
            child: Text(
              'end of ReadBuffer demo',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _legend(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 12,
        height: 12,
        color: color,
      ),
      const SizedBox(width: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 10, color: Colors.black54),
      ),
    ],
  );
}
