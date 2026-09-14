// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF0F1A2B);
const Color _kInkSoft = Color(0xFF2C3E50);
const Color _kInkMute = Color(0xFF5C6B7A);
const Color _kPaper = Color(0xFFF4F6FB);
const Color _kPaperWarm = Color(0xFFFFF7EE);
const Color _kAccentTeal = Color(0xFF0F8E8E);
const Color _kAccentTealDeep = Color(0xFF055F66);
const Color _kAccentAmber = Color(0xFFE08E2A);
const Color _kAccentAmberDeep = Color(0xFFB36A0E);
const Color _kAccentMagenta = Color(0xFFB8348C);
const Color _kAccentMagentaDeep = Color(0xFF741457);
const Color _kAccentBlue = Color(0xFF2F6FE0);
const Color _kAccentBlueDeep = Color(0xFF124AB5);
const Color _kAccentGreen = Color(0xFF2E8F4C);
const Color _kAccentGreenDeep = Color(0xFF155D2A);
const Color _kAccentViolet = Color(0xFF6E45C8);
const Color _kAccentVioletDeep = Color(0xFF3C1D8A);
const Color _kAccentSlate = Color(0xFF455A75);
const Color _kAccentSlateDeep = Color(0xFF22364E);
const Color _kCellPrimary = Color(0xFFE3F4F4);
const Color _kCellSecondary = Color(0xFFFFE8C2);
const Color _kCellTertiary = Color(0xFFEBE2FB);
const Color _kCellQuaternary = Color(0xFFD7EAFE);
const Color _kCellLength = Color(0xFFFFD7E0);
const Color _kCellPad = Color(0xFFE4E8EE);

const TextStyle _kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: _kInk,
  height: 1.4,
);

const TextStyle _kCodeStyleLight = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: Colors.white,
  height: 1.4,
);

const TextStyle _kSectionTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w800,
  color: Colors.white,
  letterSpacing: 0.4,
);

const TextStyle _kSubTitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: _kInk,
);

const TextStyle _kBody = TextStyle(
  fontSize: 13.5,
  color: _kInkSoft,
  height: 1.55,
);

// ---------------------------------------------------------------------------
// Sample payload helpers
// ---------------------------------------------------------------------------

/// Builds the structured demo payload used across the document.
ByteData _buildSamplePayload() {
  final WriteBuffer wb = WriteBuffer();
  wb.putUint16(0xCAFE);          // magic
  wb.putUint8(3);                // version
  wb.putUint8(0);                // pad/reserved
  wb.putInt32(0x0000002A);       // record id
  final List<int> nameBytes = const <int>[84, 111, 109]; // "Tom"
  wb.putUint8(nameBytes.length); // name length
  wb.putUint8List(Uint8List.fromList(nameBytes));
  // 4-byte aligned padding for the float64 list that follows.
  wb.putUint8(0);
  wb.putUint8(0);
  wb.putUint8(0);
  wb.putUint8(0);
  wb.putInt32(3);                // values length
  wb.putFloat64List(Float64List.fromList(<double>[1.0, 2.0, 3.0]));
  return wb.done();
}

/// Builds a smaller payload used for the alignment showcase.
ByteData _buildAlignmentPayload() {
  final WriteBuffer wb = WriteBuffer();
  wb.putUint8(0xAB);
  wb.putInt32(0x11223344);
  wb.putFloat64(1.5);
  return wb.done();
}

/// Decodes the sample payload using `ReadBuffer` and returns a structured map.
Map<String, Object> _decodeSamplePayload(ByteData data) {
  final ReadBuffer rb = ReadBuffer(data);
  final int magic = rb.getUint16();
  final int version = rb.getUint8();
  rb.getUint8(); // skip reserved
  final int id = rb.getInt32();
  final int nameLen = rb.getUint8();
  final Uint8List nameBytes = rb.getUint8List(nameLen);
  // Consume 4 bytes of padding before the float64 list.
  rb.getUint8();
  rb.getUint8();
  rb.getUint8();
  rb.getUint8();
  final int valuesLen = rb.getInt32();
  final Float64List values = rb.getFloat64List(valuesLen);
  return <String, Object>{
    'magic': magic,
    'version': version,
    'id': id,
    'name': String.fromCharCodes(nameBytes),
    'values': values.toList(),
  };
}

/// Renders the bytes of [data] as a list of hex strings.
List<String> _hexBytes(ByteData data) {
  final List<String> out = <String>[];
  for (int i = 0; i < data.lengthInBytes; i++) {
    out.add(data.getUint8(i).toRadixString(16).toUpperCase().padLeft(2, '0'));
  }
  return out;
}

/// Returns a hexdump-style line list with offset, hex bytes, and ASCII.
List<String> _hexDumpLines(ByteData data, {int width = 16}) {
  final List<String> lines = <String>[];
  for (int i = 0; i < data.lengthInBytes; i += width) {
    final StringBuffer hex = StringBuffer();
    final StringBuffer ascii = StringBuffer();
    for (int j = 0; j < width; j++) {
      final int p = i + j;
      if (p < data.lengthInBytes) {
        final int b = data.getUint8(p);
        hex.write(b.toRadixString(16).toUpperCase().padLeft(2, '0'));
        hex.write(' ');
        ascii.write(b >= 0x20 && b < 0x7F ? String.fromCharCode(b) : '.');
      } else {
        hex.write('   ');
        ascii.write(' ');
      }
      if (j == width ~/ 2 - 1) hex.write(' ');
    }
    final String offset =
        i.toRadixString(16).toUpperCase().padLeft(4, '0');
    lines.add('$offset  $hex |$ascii|');
  }
  return lines;
}

// ---------------------------------------------------------------------------
// Small reusable visual primitives
// ---------------------------------------------------------------------------

Widget _hexCell(String hex, {required Color background, String? label}) {
  return Container(
    width: 58,
    margin: const EdgeInsets.all(2),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kInk.withAlpha(40)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withAlpha(20),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          hex,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: _kInk,
          ),
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                color: _kInkMute,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _legendChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kInk.withAlpha(60)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withAlpha(25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: _kInk,
      ),
    ),
  );
}

Widget _pillTag(String text, {required Color background, Color? text2}) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: background.withAlpha(120),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: text2 ?? Colors.white,
      ),
    ),
  );
}

Widget _sectionHeader({
  required String index,
  required String title,
  required String subtitle,
  required List<Color> gradient,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: gradient.last.withAlpha(120),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: _kInk.withAlpha(40),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(70),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withAlpha(180)),
          ),
          alignment: Alignment.center,
          child: Text(
            index,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kSectionTitle),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withAlpha(220),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionShell({
  required String index,
  required String title,
  required String subtitle,
  required List<Color> headerGradient,
  required Color bodyTint,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 22),
    decoration: BoxDecoration(
      color: bodyTint,
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withAlpha(35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: headerGradient.last.withAlpha(50),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          index: index,
          title: title,
          subtitle: subtitle,
          gradient: headerGradient,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
          child: body,
        ),
      ],
    ),
  );
}

Widget _proseBlock(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kInk.withAlpha(20)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withAlpha(18),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(text, style: _kBody),
  );
}

Widget _codeCard(String code, {String? caption}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInk, _kInkSoft],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withAlpha(120),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: Colors.black.withAlpha(80),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (caption != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF27C93F),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  caption,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white70,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        SelectableText(code, style: _kCodeStyleLight),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Introduction header
// ---------------------------------------------------------------------------

Widget _buildIntroSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kAccentTealDeep, _kAccentBlueDeep, _kAccentVioletDeep],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kAccentVioletDeep.withAlpha(140),
          blurRadius: 22,
          offset: const Offset(0, 12),
        ),
        BoxShadow(
          color: _kInk.withAlpha(80),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: Colors.white.withAlpha(40),
          blurRadius: 1,
          offset: const Offset(0, -1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(70),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.memory,
                size: 36,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ReadBuffer & WriteBuffer',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'A deep visual tour of flutter foundation binary buffers',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withAlpha(80)),
          ),
          child: const Text(
            'Flutter ships a pair of buffer types in package:flutter/foundation.dart that '
            'underpin the platform message protocol. WriteBuffer accumulates primitive '
            'values into a growing block of memory and yields a ByteData when sealed with '
            'done(). ReadBuffer wraps an existing ByteData and exposes parallel readers. '
            'Together they form the building blocks for codecs such as StandardMessageCodec, '
            'StandardMethodCodec, and any other host channel framing you might design.',
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.white,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _pillTag('putUint8', background: _kAccentTeal),
            _pillTag('putInt32', background: _kAccentBlue),
            _pillTag('putFloat64', background: _kAccentMagenta),
            _pillTag('putUint8List', background: _kAccentAmber),
            _pillTag('putInt32List', background: _kAccentGreen),
            _pillTag('putFloat64List', background: _kAccentViolet),
            _pillTag('done()', background: _kAccentSlate),
            _pillTag('ReadBuffer(data)', background: _kAccentTealDeep),
            _pillTag('getUint8()', background: _kAccentBlueDeep),
            _pillTag('getInt32List(n)', background: _kAccentMagentaDeep),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: WriteBuffer anatomy
// ---------------------------------------------------------------------------

Widget _buildWriteBufferSection() {
  return _sectionShell(
    index: '02',
    title: 'WriteBuffer — accumulating primitives',
    subtitle: 'Each put* call advances the cursor and may grow the buffer.',
    headerGradient: const <Color>[_kAccentTealDeep, _kAccentTeal],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'WriteBuffer is a growable scratchpad. Internally it manages an array '
          'of bytes that doubles in capacity whenever a put call would overflow. '
          'Each putter writes its operand using host endianness by default, which '
          'on virtually every Flutter target is little-endian. The cursor is '
          'append-only: there is no seek, no overwrite, and no truncate. The buffer '
          'is single-use; calling done() seals the bytes and returns a ByteData '
          'view that may share storage with the writer.',
        ),
        _codeCard(
          'final WriteBuffer wb = WriteBuffer();\n'
          'wb.putUint16(0xCAFE);            // magic\n'
          'wb.putUint8(3);                  // version\n'
          'wb.putUint8(0);                  // reserved/padding\n'
          'wb.putInt32(0x2A);               // record id\n'
          'wb.putUint8(3);                  // name length\n'
          'wb.putUint8List(Uint8List.fromList(<int>[84, 111, 109]));\n'
          'wb.putInt32(3);                  // values length\n'
          'wb.putFloat64List(Float64List.fromList(<double>[1, 2, 3]));\n'
          'final ByteData data = wb.done();',
          caption: 'foundation/buffers.dart — encoding a small record',
        ),
        _proseBlock(
          'Notice the recurring pattern: scalar header values, a length, then a '
          'block. The length always precedes the block because ReadBuffer has no '
          'concept of framing. This is the same shape that StandardMessageCodec '
          'uses for its tagged values, except the codec also prefixes each value '
          'with a one-byte type tag. WriteBuffer itself does not know about types: '
          'it is your responsibility to encode and decode in matching order.',
        ),
        Wrap(
          children: <Widget>[
            _pillTag('cursor advances', background: _kAccentTeal),
            _pillTag('host endian', background: _kAccentBlue),
            _pillTag('grows on demand', background: _kAccentGreen),
            _pillTag('done() seals', background: _kAccentSlate),
            _pillTag('no rewind', background: _kAccentMagenta),
            _pillTag('no seek', background: _kAccentAmber),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: ReadBuffer anatomy
// ---------------------------------------------------------------------------

Widget _buildReadBufferSection() {
  return _sectionShell(
    index: '03',
    title: 'ReadBuffer — consuming primitives',
    subtitle: 'A position-based view over a fixed ByteData payload.',
    headerGradient: const <Color>[_kAccentAmberDeep, _kAccentAmber],
    bodyTint: _kPaperWarm,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'ReadBuffer is the dual: it wraps an existing ByteData and walks the '
          'cursor forward as you call get* methods. There is no automatic peek '
          'and no rewind. If you need to look ahead you must keep an external '
          'index. The constructor accepts ByteData directly, so you can pass the '
          'output of WriteBuffer.done() across an isolate or platform boundary '
          'and reconstruct values on the other side using the same primitives.',
        ),
        _codeCard(
          'final ReadBuffer rb = ReadBuffer(data);\n'
          'final int magic = rb.getUint16();           // 0xCAFE\n'
          'final int version = rb.getUint8();          // 3\n'
          'rb.getUint8();                              // skip reserved\n'
          'final int id = rb.getInt32();               // 0x2A\n'
          'final int nameLen = rb.getUint8();          // 3\n'
          'final Uint8List name = rb.getUint8List(nameLen);\n'
          '// consume 4 bytes of padding\n'
          'rb..getUint8()..getUint8()..getUint8()..getUint8();\n'
          'final int valuesLen = rb.getInt32();\n'
          'final Float64List values = rb.getFloat64List(valuesLen);',
          caption: 'foundation/buffers.dart — decoding the same record',
        ),
        _proseBlock(
          'Because ReadBuffer mirrors WriteBuffer exactly, the two sides of the '
          'serialization must agree on every byte. There is no length prefix on '
          'the buffer itself: the producer and consumer must share an out-of-band '
          'schema. In practice that schema is the codec contract — for platform '
          'channels, StandardMessageCodec; for shaders, the Skia formats; for ad '
          'hoc isolate messages, your own encoder pair.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Putter / getter decision matrix
// ---------------------------------------------------------------------------

Widget _buildDecisionMatrixSection() {
  final TextStyle headStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.white,
    fontSize: 12.5,
    letterSpacing: 0.3,
  );
  final TextStyle cellStyle = const TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _kInk,
  );
  return _sectionShell(
    index: '04',
    title: 'Decision matrix — choose your putter',
    subtitle: 'Bytes consumed, endianness, alignment, and the matching reader.',
    headerGradient: const <Color>[_kAccentMagentaDeep, _kAccentMagenta],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'The matrix below lists every primitive putter on WriteBuffer alongside '
          'the matching reader on ReadBuffer. Bytes consumed refers to a single '
          'element call; list variants multiply by the element count. Endianness '
          'is the host default, which Flutter assumes is little-endian on the '
          'platforms it supports. Alignment notes flag the readers that require '
          'the cursor to sit on a particular multiple before the read can be '
          'performed safely against typed_data views.',
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kInk.withAlpha(40)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kInk.withAlpha(30),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.2),
              1: FlexColumnWidth(1.3),
              2: FlexColumnWidth(1.3),
              3: FlexColumnWidth(1.3),
              4: FlexColumnWidth(2.0),
            },
            border: TableBorder.symmetric(
              inside: BorderSide(color: _kInk.withAlpha(25)),
            ),
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kAccentMagentaDeep),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Putter', style: headStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Bytes', style: headStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Endian', style: headStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Align', style: headStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Reader', style: headStyle),
                  ),
                ],
              ),
              _row('putUint8(v)', '1', 'n/a', '1', 'getUint8()', cellStyle),
              _row('putUint16(v)', '2', 'host', '2', 'getUint16()', cellStyle),
              _row('putInt32(v)', '4', 'host', '4', 'getInt32()', cellStyle),
              _row('putInt64(v)', '8', 'host', '8', 'getInt64()', cellStyle),
              _row('putFloat64(v)', '8', 'host', '8', 'getFloat64()', cellStyle),
              _row('putUint8List(list)', '1*N', 'n/a', '1', 'getUint8List(N)', cellStyle),
              _row('putInt32List(list)', '4*N', 'host', '4', 'getInt32List(N)', cellStyle),
              _row('putInt64List(list)', '8*N', 'host', '8', 'getInt64List(N)', cellStyle),
              _row('putFloat32List(list)', '4*N', 'host', '4', 'getFloat32List(N)', cellStyle),
              _row('putFloat64List(list)', '8*N', 'host', '8', 'getFloat64List(N)', cellStyle),
              _row('done()', '0', 'n/a', 'n/a', '(seals buffer)', cellStyle),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _proseBlock(
          'When you need a list reader, the count is not stored anywhere in the '
          'buffer — you must pass it explicitly. Producers almost always write a '
          'length using putInt32 or putUint8 just before the block; the consumer '
          'reads that length and forwards it to the matching list getter. Skipping '
          'this convention is the most common source of off-by-one decoding bugs '
          'when graduating from ad hoc encoders to ReadBuffer.',
        ),
      ],
    ),
  );
}

TableRow _row(String op, String bytes, String endian, String align,
    String reader, TextStyle style) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(op, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(bytes, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(endian, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(align, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(reader, style: style),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Anatomy — byte layout grid for the sample payload
// ---------------------------------------------------------------------------

Widget _buildAnatomySection(ByteData data) {
  final List<String> bytes = _hexBytes(data);
  // Index → (label, region color)
  final Map<int, _ByteAnnotation> ann = <int, _ByteAnnotation>{};
  // magic 0..1
  ann[0] = const _ByteAnnotation('magic', _kCellPrimary);
  ann[1] = const _ByteAnnotation('magic', _kCellPrimary);
  // version 2
  ann[2] = const _ByteAnnotation('ver', _kCellSecondary);
  // reserved 3
  ann[3] = const _ByteAnnotation('pad', _kCellPad);
  // id 4..7
  for (int i = 4; i <= 7; i++) {
    ann[i] = const _ByteAnnotation('id', _kCellQuaternary);
  }
  // nameLen 8
  ann[8] = const _ByteAnnotation('nLen', _kCellLength);
  // name 9..11
  for (int i = 9; i <= 11; i++) {
    ann[i] = const _ByteAnnotation('name', _kCellTertiary);
  }
  // padding 12..15
  for (int i = 12; i <= 15; i++) {
    ann[i] = const _ByteAnnotation('pad', _kCellPad);
  }
  // valuesLen 16..19
  for (int i = 16; i <= 19; i++) {
    ann[i] = const _ByteAnnotation('vLen', _kCellLength);
  }
  // values 20..end
  for (int i = 20; i < bytes.length; i++) {
    ann[i] = const _ByteAnnotation('vals', _kCellSecondary);
  }

  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < bytes.length; i++) {
    final _ByteAnnotation a = ann[i] ??
        const _ByteAnnotation('???', Color(0xFFEEEEEE));
    cells.add(_hexCell(bytes[i], background: a.color, label: '${a.label}\n$i'));
  }

  return _sectionShell(
    index: '05',
    title: 'Anatomy — labelled byte grid',
    subtitle: 'A full visual breakdown of every byte in the sample payload.',
    headerGradient: const <Color>[_kAccentBlueDeep, _kAccentBlue],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'Below is the actual ByteData emitted by WriteBuffer for our worked '
          'example. Each cell shows one byte in uppercase hex along with the '
          'logical field it belongs to and its offset. Notice how a two-byte '
          'magic and a one-byte version are followed by a padding byte to align '
          'the upcoming int32. The name block is preceded by a length byte and '
          'followed by four padding bytes so the float64 list lands on an 8-byte '
          'boundary, which keeps downstream typed_data views happy.',
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kInk.withAlpha(35)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kInk.withAlpha(40),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Wrap(children: cells),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            _legendChip('magic', _kCellPrimary),
            _legendChip('ver', _kCellSecondary),
            _legendChip('pad', _kCellPad),
            _legendChip('id', _kCellQuaternary),
            _legendChip('nLen / vLen', _kCellLength),
            _legendChip('name', _kCellTertiary),
            _legendChip('vals', _kCellSecondary),
          ],
        ),
        const SizedBox(height: 12),
        _proseBlock(
          'Padding is a deliberate cost in this encoding because little-endian '
          'platforms do not require strict alignment for individual scalar reads, '
          'yet typed_data list views do. If the float64 list started at offset 17 '
          'we could still decode it scalar by scalar, but creating a Float64List '
          'view that aliases the backing buffer would throw. WriteBuffer leaves '
          'alignment to you because it cannot guess the consumer\'s appetite.',
        ),
      ],
    ),
  );
}

class _ByteAnnotation {
  final String label;
  final Color color;
  const _ByteAnnotation(this.label, this.color);
}

// ---------------------------------------------------------------------------
// Section 6: Hexdump — byte rendering
// ---------------------------------------------------------------------------

Widget _buildHexDumpSection(ByteData data) {
  final List<String> dump = _hexDumpLines(data);
  return _sectionShell(
    index: '06',
    title: 'Hexdump — wire-level view',
    subtitle: 'How tools like xxd or hexyl would render the same payload.',
    headerGradient: const <Color>[_kAccentSlateDeep, _kAccentSlate],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'The labelled grid is convenient for teaching but real-world debugging '
          'usually means staring at a hexdump. Here we reproduce the classic '
          'xxd-style layout: a four-digit hex offset, sixteen bytes per row '
          'split into two groups of eight, and a printable-ASCII gutter on the '
          'right. The non-printable bytes are replaced with dots in the gutter, '
          'which makes it easy to spot strings such as the embedded "Tom" name.',
        ),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0E1B2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(150),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: _kAccentSlate.withAlpha(80),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SelectableText(
            dump.join('\n'),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFB9F2A1),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _proseBlock(
          'When something is going wrong on a platform channel, the first move '
          'is almost always to dump the bytes on both sides. If the producer\'s '
          'dump and the consumer\'s dump do not match, the bug is in transport. '
          'If they match but the decoder still fails, the bug is a schema drift: '
          'someone added or removed a field without updating the other side. '
          'Either way, the hexdump is the ground truth.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Worked example with decoded record
// ---------------------------------------------------------------------------

Widget _buildWorkedExampleSection(ByteData data) {
  final Map<String, Object> record = _decodeSamplePayload(data);
  return _sectionShell(
    index: '07',
    title: 'Worked example — round trip',
    subtitle: 'Encode a structured record, decode it, render the result.',
    headerGradient: const <Color>[_kAccentVioletDeep, _kAccentViolet],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'The encoder and decoder above were not props — they are the exact '
          'functions that produced the bytes you see in the anatomy and hexdump '
          'sections. Below is the decoded record rendered as a small property '
          'sheet. Each row shows the field name, the runtime type, and the value. '
          'Compare those values to the byte grid: every hex you see has a '
          'meaning, and every meaning is recoverable.',
        ),
        StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setLocal) {
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kInk.withAlpha(35)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _kInk.withAlpha(30),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _recordRow('magic', '0x${(record['magic'] as int).toRadixString(16).toUpperCase()}', 'int'),
                  _recordRow('version', '${record['version']}', 'int'),
                  _recordRow('id', '0x${(record['id'] as int).toRadixString(16).toUpperCase()}', 'int'),
                  _recordRow('name', '"${record['name']}"', 'String'),
                  _recordRow('values', '${record['values']}', 'Float64List'),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _codeCard(
          'Map<String, Object> decode(ByteData data) {\n'
          '  final ReadBuffer rb = ReadBuffer(data);\n'
          '  final int magic = rb.getUint16();\n'
          '  final int version = rb.getUint8();\n'
          '  rb.getUint8(); // reserved\n'
          '  final int id = rb.getInt32();\n'
          '  final int nameLen = rb.getUint8();\n'
          '  final Uint8List nb = rb.getUint8List(nameLen);\n'
          '  rb..getUint8()..getUint8()..getUint8()..getUint8();\n'
          '  final int vLen = rb.getInt32();\n'
          '  final Float64List values = rb.getFloat64List(vLen);\n'
          '  return <String, Object>{\n'
          '    "magic": magic, "version": version, "id": id,\n'
          '    "name": String.fromCharCodes(nb), "values": values.toList(),\n'
          '  };\n'
          '}',
          caption: 'foundation/buffers.dart — decode helper',
        ),
        _proseBlock(
          'A subtle but important detail: getUint8List and getFloat64List return '
          'typed_data views that may share storage with the underlying ByteData. '
          'If you intend to keep the slice past the lifetime of the source buffer, '
          'copy it eagerly with Uint8List.fromList. The view is fine for one-shot '
          'decoding inside a method channel handler; it is dangerous if you stash '
          'it in a long-lived cache.',
        ),
      ],
    ),
  );
}

Widget _recordRow(String name, String value, String type) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: _kInk,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kCellTertiary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          child: SelectableText(value, style: _kCodeStyle),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Alignment showcase
// ---------------------------------------------------------------------------

Widget _buildAlignmentSection() {
  final ByteData data = _buildAlignmentPayload();
  final List<String> bytes = _hexBytes(data);
  return _sectionShell(
    index: '08',
    title: 'Alignment — why padding bytes appear',
    subtitle: 'A small payload that illustrates host-endian alignment.',
    headerGradient: const <Color>[_kAccentGreenDeep, _kAccentGreen],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'Here is a deliberately small payload that demonstrates the alignment '
          'rule. We write a single uint8 followed by an int32 and a float64. '
          'WriteBuffer itself does not insert padding for you — that is your job. '
          'In the bytes below you can see the int32 starts immediately after the '
          'uint8, but the float64 starts on an 8-byte boundary so a Float64List '
          'view can be created safely against the backing memory.',
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kInk.withAlpha(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kInk.withAlpha(30),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Wrap(
            children: <Widget>[
              for (int i = 0; i < bytes.length; i++)
                _hexCell(
                  bytes[i],
                  background: i == 0
                      ? _kCellPrimary
                      : (i < 5
                          ? _kCellQuaternary
                          : _kCellSecondary),
                  label: i == 0
                      ? 'u8\n$i'
                      : (i < 5 ? 'i32\n$i' : 'f64\n$i'),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _proseBlock(
          'Read this grid carefully. The first cell holds the lone uint8. Cells '
          'one through four hold the four bytes of the int32, in little-endian. '
          'Cells five through twelve hold the eight bytes of the float64. There '
          'is no padding here because WriteBuffer wrote the values back to back. '
          'If your protocol requires alignment, you must enforce it yourself by '
          'inserting putUint8(0) calls until the cursor reaches the right offset.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9: Codec relationship
// ---------------------------------------------------------------------------

Widget _buildCodecRelationshipSection() {
  return _sectionShell(
    index: '09',
    title: 'Relationship to StandardMessageCodec',
    subtitle: 'How the buffer primitives compose into Flutter codecs.',
    headerGradient: const <Color>[_kAccentAmberDeep, _kAccentMagenta, _kAccentBlueDeep],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'StandardMessageCodec is the default codec used by BasicMessageChannel '
          'and MethodChannel. It is implemented as a thin layer on top of '
          'WriteBuffer and ReadBuffer. The codec adds a one-byte type tag in '
          'front of every encoded value: 0 for null, 1 for true, 2 for false, '
          '3 for int32, 4 for int64, 5 for largeInt, 6 for float64, 7 for '
          'string, 8 for uint8List, and so on through map and list.',
        ),
        _codeCard(
          'class StandardMessageCodec implements MessageCodec<Object?> {\n'
          '  ByteData encodeMessage(Object? message) {\n'
          '    if (message == null) return ByteData(0);\n'
          '    final WriteBuffer buffer = WriteBuffer();\n'
          '    writeValue(buffer, message);   // recursive\n'
          '    return buffer.done();\n'
          '  }\n'
          '\n'
          '  Object? decodeMessage(ByteData? message) {\n'
          '    if (message == null) return null;\n'
          '    final ReadBuffer buffer = ReadBuffer(message);\n'
          '    final Object? result = readValue(buffer);\n'
          '    if (buffer.hasRemaining) throw const FormatException();\n'
          '    return result;\n'
          '  }\n'
          '}',
          caption: 'codec.dart — StandardMessageCodec scaffolding',
        ),
        _proseBlock(
          'The trailing hasRemaining check is worth pausing on. After decode, '
          'the read cursor should be exactly at the end of the byte stream. Any '
          'remaining bytes mean the producer and consumer disagree on the schema '
          'and the message must be rejected. When you build your own codec on '
          'top of buffers, copy this defensive check; it converts silent data '
          'corruption into loud and obvious format exceptions.',
        ),
        Wrap(
          children: <Widget>[
            _pillTag('tag=0 null', background: _kAccentSlate),
            _pillTag('tag=1 true', background: _kAccentGreen),
            _pillTag('tag=2 false', background: _kAccentMagenta),
            _pillTag('tag=3 int32', background: _kAccentBlue),
            _pillTag('tag=4 int64', background: _kAccentBlueDeep),
            _pillTag('tag=6 float64', background: _kAccentViolet),
            _pillTag('tag=7 string', background: _kAccentTeal),
            _pillTag('tag=8 uint8List', background: _kAccentAmber),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10: Operations palette + interactive demo
// ---------------------------------------------------------------------------

Widget _buildPaletteSection() {
  return _sectionShell(
    index: '10',
    title: 'Operations palette + interactive byte counter',
    subtitle: 'Click chips to add operations and watch the cursor advance.',
    headerGradient: const <Color>[_kAccentBlueDeep, _kAccentTealDeep],
    bodyTint: _kPaper,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseBlock(
          'The palette below maps every primitive on WriteBuffer to a clickable '
          'chip. As you tap, the simulator builds an operation log and totals '
          'the bytes written. Use it to develop intuition for how a record '
          'grows. The button labelled done seals the buffer and reports the '
          'final length; reset clears the log. No real WriteBuffer is created — '
          'this is a pure visual aid that mirrors the cost model.',
        ),
        StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setLocal) {
            final List<_OpEntry> log = <_OpEntry>[];
            int total = 0;
            bool sealed = false;

            void add(String op, int cost) {
              if (sealed) return;
              setLocal(() {
                log.add(_OpEntry(op, cost));
                total += cost;
              });
            }

            void seal() {
              setLocal(() {
                sealed = true;
              });
            }

            void reset() {
              setLocal(() {
                log.clear();
                total = 0;
                sealed = false;
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kInk.withAlpha(35)),
                  ),
                  child: Wrap(
                    children: <Widget>[
                      _opChip('putUint8', 1, _kAccentTeal, add),
                      _opChip('putUint16', 2, _kAccentBlue, add),
                      _opChip('putInt32', 4, _kAccentBlueDeep, add),
                      _opChip('putInt64', 8, _kAccentVioletDeep, add),
                      _opChip('putFloat64', 8, _kAccentMagenta, add),
                      _opChip('putUint8List(4)', 4, _kAccentAmber, add),
                      _opChip('putInt32List(2)', 8, _kAccentGreen, add),
                      _opChip('putFloat64List(2)', 16, _kAccentViolet, add),
                      _actionChip('done()', _kAccentSlateDeep, () => seal()),
                      _actionChip('reset', _kAccentMagentaDeep, () => reset()),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: sealed
                          ? const <Color>[_kAccentGreen, _kAccentGreenDeep]
                          : const <Color>[_kAccentSlate, _kAccentSlateDeep],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: _kInk.withAlpha(60),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sealed
                            ? 'Sealed buffer — $total byte(s) emitted'
                            : 'Cursor at byte offset $total',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sealed
                            ? 'done() returned a ByteData of length $total. '
                              'Press reset to start again.'
                            : 'Tap chips above to add operations. Each chip shows the '
                              'byte cost of one call.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(220),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kInk.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Operation log',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: _kInk,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (log.isEmpty)
                        const Text(
                          'No operations yet. The buffer is empty.',
                          style: TextStyle(
                            color: _kInkMute,
                            fontSize: 12,
                          ),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (int i = 0; i < log.length; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 28,
                                      child: Text(
                                        '#${i + 1}',
                                        style: const TextStyle(
                                          fontFamily: 'monospace',
                                          color: _kInkMute,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        log[i].op,
                                        style: _kCodeStyle,
                                      ),
                                    ),
                                    Text(
                                      '+${log[i].cost} B',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        color: _kAccentTealDeep,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        _proseBlock(
          'The simulator highlights the cost model of WriteBuffer: scalar puts '
          'add a fixed number of bytes, list puts add a multiple, and done is '
          'free in the sense that it allocates no further bytes — it simply '
          'returns the accumulated ByteData. Tap a few chips and you will see '
          'the cursor jump in lockstep with the matrix from section four.',
        ),
      ],
    ),
  );
}

Widget _opChip(
  String label,
  int cost,
  Color color,
  void Function(String, int) onTap,
) {
  return GestureDetector(
    onTap: () => onTap(label, cost),
    child: Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[color, color.withAlpha(190)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withAlpha(140),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(80),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '+$cost',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _actionChip(String label, Color color, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withAlpha(140),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

class _OpEntry {
  final String op;
  final int cost;
  _OpEntry(this.op, this.cost);
}

// ---------------------------------------------------------------------------
// Section 11: Reference card / closing summary
// ---------------------------------------------------------------------------

Widget _buildReferenceCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInk, _kAccentSlateDeep, _kAccentBlueDeep],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withAlpha(160),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: _kAccentBlue.withAlpha(80),
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text(
              'Closing reference card',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _refLine('1.', 'WriteBuffer accumulates bytes, ReadBuffer consumes them.'),
        _refLine('2.', 'Endianness is host (little-endian on every Flutter target).'),
        _refLine('3.', 'Alignment is your responsibility; insert padding bytes.'),
        _refLine('4.', 'Length prefixes are a convention, not a built-in feature.'),
        _refLine('5.', 'done() seals the buffer and returns a ByteData view.'),
        _refLine('6.', 'List getters may share storage; copy if you stash them.'),
        _refLine('7.', 'StandardMessageCodec is a thin tag-prefixed layer on top.'),
        _refLine('8.', 'Always call hasRemaining after decoding to catch drift.'),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(35),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withAlpha(80)),
          ),
          child: const Text(
            'When in doubt: produce a hexdump on both sides of the channel and '
            'diff them byte by byte. Buffer bugs are deterministic — they are '
            'always reproducible from the bytes alone.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _refLine(String num, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 26,
          child: Text(
            num,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Top-level harness
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  final ByteData sample = _buildSamplePayload();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ReadBuffer & WriteBuffer Visual Tour',
    theme: ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: const Color(0xFFE9ECF3),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk),
        bodySmall: TextStyle(color: _kInkSoft),
        titleLarge: _kSubTitle,
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFE9ECF3),
      appBar: AppBar(
        backgroundColor: _kAccentTealDeep,
        elevation: 0,
        title: const Text(
          'ReadBuffer & WriteBuffer — deep visual tour',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildIntroSection(),
              _buildWriteBufferSection(),
              _buildReadBufferSection(),
              _buildDecisionMatrixSection(),
              _buildAnatomySection(sample),
              _buildHexDumpSection(sample),
              _buildWorkedExampleSection(sample),
              _buildAlignmentSection(),
              _buildCodecRelationshipSection(),
              _buildPaletteSection(),
              _buildReferenceCard(),
            ],
          ),
        ),
      ),
    ),
  );
}
