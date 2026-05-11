// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// WriteBuffer — Visual Deep Demo
// ----------------------------------------------------------------------------
// A hand-authored exploration of `package:flutter/foundation.dart`'s
// `WriteBuffer`, the growable typed-byte sink that backs platform channel
// codecs and many low-level binary protocols.
//
// SECTIONS
//   1.  DOSSIER       — purpose, lineage, design intent
//   2.  ANATOMY       — each `putXxx` and the bytes it produces
//   3.  ENDIANNESS    — little vs big vs host
//   4.  HEADER        — encode magic + version + length + checksum
//   5.  STRINGS       — length-prefixed UTF-8 strings
//   6.  MIXED RECORD  — Float64List + Uint8List + String
//   7.  COMPARISON    — WriteBuffer vs ByteData vs BytesBuilder
//   8.  PITFALLS      — alignment, signed/unsigned
//   9.  GLOSSARY
//  10.  RECAP
//
// All byte values are computed once at build time and rendered as static
// widgets — there are no Stateful widgets in this file.
// ============================================================================

// ---------------------------------------------------------------------------
// PALETTE
// ---------------------------------------------------------------------------

class _Palette {
  static const Color bg = Color(0xFFF6F8FB);
  static const Color cardBg = Colors.white;
  static const Color ink = Color(0xFF1F2933);
  static const Color subInk = Color(0xFF52606D);
  static const Color faintInk = Color(0xFF7B8794);

  static const Color section1 = Color(0xFF3D5AFE);
  static const Color section2 = Color(0xFF00BFA5);
  static const Color section3 = Color(0xFFFF6F00);
  static const Color section4 = Color(0xFFD81B60);
  static const Color section5 = Color(0xFF6A1B9A);
  static const Color section6 = Color(0xFF2E7D32);
  static const Color section7 = Color(0xFF455A64);
  static const Color section8 = Color(0xFFC62828);
  static const Color section9 = Color(0xFF5D4037);
  static const Color section10 = Color(0xFF00838F);

  static const Color hexCellBg = Color(0xFFEDF2F7);
  static const Color hexCellBorder = Color(0xFFCBD5E0);
  static const Color hexHighlight = Color(0xFFFFF3CD);

  static const Color byteU8 = Color(0xFFE3F2FD);
  static const Color byteU16 = Color(0xFFE8F5E9);
  static const Color byteU32 = Color(0xFFFFF3E0);
  static const Color byteI32 = Color(0xFFFCE4EC);
  static const Color byteI64 = Color(0xFFEDE7F6);
  static const Color byteF32 = Color(0xFFE0F7FA);
  static const Color byteF64 = Color(0xFFF3E5F5);
  static const Color byteStr = Color(0xFFFFFDE7);
}

// ---------------------------------------------------------------------------
// HEX / BYTE HELPERS
// ---------------------------------------------------------------------------

String _hex2(int byte) {
  final h = byte.toRadixString(16).toUpperCase().padLeft(2, '0');
  return h;
}

String _hexJoin(List<int> bytes, {String sep = ' '}) {
  return bytes.map(_hex2).join(sep);
}

List<int> _bytesOfInt32LE(int value) {
  final bd = ByteData(4);
  bd.setInt32(0, value, Endian.little);
  return bd.buffer.asUint8List().toList();
}

List<int> _bytesOfInt32BE(int value) {
  final bd = ByteData(4);
  bd.setInt32(0, value, Endian.big);
  return bd.buffer.asUint8List().toList();
}

List<int> _bytesOfFloat64LE(double value) {
  final bd = ByteData(8);
  bd.setFloat64(0, value, Endian.little);
  return bd.buffer.asUint8List().toList();
}

List<int> _bytesOfFloat32LE(double value) {
  final bd = ByteData(4);
  bd.setFloat32(0, value, Endian.little);
  return bd.buffer.asUint8List().toList();
}

List<int> _bytesOfInt64LE(int value) {
  final bd = ByteData(8);
  bd.setInt64(0, value, Endian.little);
  return bd.buffer.asUint8List().toList();
}

List<int> _bytesOfUint16LE(int value) {
  final bd = ByteData(2);
  bd.setUint16(0, value, Endian.little);
  return bd.buffer.asUint8List().toList();
}

List<int> _bytesOfUint32LE(int value) {
  final bd = ByteData(4);
  bd.setUint32(0, value, Endian.little);
  return bd.buffer.asUint8List().toList();
}

// ---------------------------------------------------------------------------
// BUILD ENTRYPOINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: _Palette.bg,
    appBar: AppBar(
      backgroundColor: _Palette.section1,
      foregroundColor: Colors.white,
      title: const Text('WriteBuffer — Visual Deep Demo'),
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _TitleHeader(),
          SizedBox(height: 24),
          _Section1Dossier(),
          SizedBox(height: 28),
          _Section2Anatomy(),
          SizedBox(height: 28),
          _Section3Endianness(),
          SizedBox(height: 28),
          _Section4Header(),
          SizedBox(height: 28),
          _Section5Strings(),
          SizedBox(height: 28),
          _Section6MixedRecord(),
          SizedBox(height: 28),
          _Section7Comparison(),
          SizedBox(height: 28),
          _Section8Pitfalls(),
          SizedBox(height: 28),
          _Section9Glossary(),
          SizedBox(height: 28),
          _Section10Recap(),
          SizedBox(height: 40),
          _Footer(),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SHARED WIDGETS
// ---------------------------------------------------------------------------

class _TitleHeader extends StatelessWidget {
  const _TitleHeader();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _Palette.cardBg,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'WriteBuffer',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: _Palette.ink,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'A growable, typed binary sink — the workhorse beneath '
              'Flutter platform channels and many custom codecs.',
              style: TextStyle(
                fontSize: 14,
                color: _Palette.subInk,
                height: 1.4,
              ),
            ),
            SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _Pill(label: 'package:flutter/foundation.dart', color: _Palette.section1),
                _Pill(label: 'typed_data', color: _Palette.section2),
                _Pill(label: 'binary protocols', color: _Palette.section3),
                _Pill(label: 'platform channels', color: _Palette.section4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.45), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final Color color;
  final List<Widget> children;

  const _SectionFrame({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _Palette.cardBg,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: color,
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
            child: Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.92),
                          fontSize: 12.5,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubHeading extends StatelessWidget {
  final String text;
  final Color color;
  const _SubHeading({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 18,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: _Palette.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;
  const _Paragraph(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.5,
          height: 1.55,
          color: _Palette.subInk,
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 6, right: 8),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: _Palette.faintInk,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        s,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: _Palette.subInk,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontFamilyFallback: <String>['Menlo', 'Courier New'],
          fontSize: 12,
          height: 1.5,
          color: Color(0xFFDCDCDC),
        ),
      ),
    );
  }
}

class _ByteCell extends StatelessWidget {
  final int? byte;
  final Color background;
  final String? label;
  final int? offset;
  final bool highlight;

  const _ByteCell({
    required this.byte,
    this.background = _Palette.hexCellBg,
    this.label,
    this.offset,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final hex = byte == null ? '··' : _hex2(byte!);
    return Container(
      width: 44,
      height: 56,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: highlight ? _Palette.hexHighlight : background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: highlight ? Colors.amber.shade700 : _Palette.hexCellBorder,
          width: highlight ? 1.4 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (offset != null)
            Text(
              '+${offset!.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 9,
                color: _Palette.faintInk,
                fontFamily: 'monospace',
              ),
            ),
          Text(
            hex,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: _Palette.ink,
            ),
          ),
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                fontSize: 9,
                color: _Palette.subInk,
              ),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}

class _HexRow extends StatelessWidget {
  final List<int> bytes;
  final Color background;
  final bool showOffsets;
  final int offsetStart;

  const _HexRow({
    required this.bytes,
    this.background = _Palette.hexCellBg,
    this.showOffsets = false,
    this.offsetStart = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      runSpacing: 0,
      children: <Widget>[
        for (int i = 0; i < bytes.length; i++)
          _ByteCell(
            byte: bytes[i],
            background: background,
            offset: showOffsets ? offsetStart + i : null,
          ),
      ],
    );
  }
}

class _LabeledHex extends StatelessWidget {
  final String label;
  final List<int> bytes;
  final Color color;
  final String? comment;

  const _LabeledHex({
    required this.label,
    required this.bytes,
    required this.color,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: _Palette.ink,
                  ),
                ),
              ),
              Text(
                '${bytes.length} B',
                style: const TextStyle(
                  fontSize: 11,
                  color: _Palette.faintInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _HexRow(bytes: bytes, background: color.withOpacity(0.18)),
          if (comment != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              comment!,
              style: const TextStyle(
                fontSize: 11.5,
                color: _Palette.subInk,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _KvRow extends StatelessWidget {
  final String k;
  final String v;
  final IconData? icon;
  final Color iconColor;
  const _KvRow({
    required this.k,
    required this.v,
    this.icon,
    this.iconColor = _Palette.faintInk,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 8),
          ],
          SizedBox(
            width: 150,
            child: Text(
              k,
              style: const TextStyle(
                fontSize: 12.5,
                color: _Palette.subInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontSize: 12.5,
                color: _Palette.ink,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  const _Note({
    required this.text,
    this.color = _Palette.section1,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.8,
                color: _Palette.ink,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '— end of WriteBuffer demo —',
        style: TextStyle(
          fontSize: 11.5,
          color: _Palette.faintInk,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 1 — DOSSIER
// ============================================================================

class _Section1Dossier extends StatelessWidget {
  const _Section1Dossier();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      number: 1,
      title: 'DOSSIER',
      subtitle: 'Purpose, lineage, design intent.',
      color: _Palette.section1,
      children: <Widget>[
        const _SubHeading(text: 'What is it?', color: _Palette.section1),
        const _Paragraph(
          'WriteBuffer is a growable, typed byte-sink that lets callers '
          'append primitive numeric values and raw byte sequences without '
          'ever sizing the buffer themselves. Its sibling, ReadBuffer, '
          'walks the produced bytes in the same order.',
        ),
        const _SubHeading(text: 'Lineage', color: _Palette.section1),
        const _BulletList(
          items: <String>[
            'Defined in package:flutter/foundation.dart (file: serialization.dart).',
            'Underlying storage is a ByteData segment that doubles on demand.',
            'Final output is exposed as a ByteData via done().',
            'Mirrors ReadBuffer for symmetric encode/decode pipelines.',
          ],
        ),
        const _SubHeading(text: 'Design intent', color: _Palette.section1),
        const _BulletList(
          items: <String>[
            'Avoid allocating intermediate Uint8Lists for each value.',
            'Provide host-endian writes by default (matches in-memory layout).',
            'Allow explicit Endian.little / Endian.big when wire format matters.',
            'Make growth amortized O(1) by capacity doubling.',
          ],
        ),
        const _SubHeading(text: 'API surface (cheat sheet)', color: _Palette.section1),
        const _CodeBlock(
          'final WriteBuffer w = WriteBuffer();\n'
          'w.putUint8(0xAB);\n'
          'w.putUint16(0x1234, endian: Endian.little);\n'
          'w.putUint32(0xDEADBEEF, endian: Endian.big);\n'
          'w.putInt32(-42);\n'
          'w.putInt64(0x0011223344556677);\n'
          'w.putFloat32(3.14, endian: Endian.little);\n'
          'w.putFloat64(2.718281828);\n'
          'w.putUint8List(Uint8List.fromList([1, 2, 3]));\n'
          'w.putInt32List(Int32List.fromList([100, 200]));\n'
          'w.putFloat64List(Float64List.fromList([1.0, 2.0]));\n'
          'final ByteData bytes = w.done();',
        ),
        const _Note(
          icon: Icons.lightbulb_outline,
          color: _Palette.section1,
          text:
              'Rule of thumb: prefer WriteBuffer over manual ByteData + offset '
              'tracking whenever the payload size is not known up front.',
        ),
        const _SubHeading(text: 'Use cases observed in Flutter', color: _Palette.section1),
        const _BulletList(
          items: <String>[
            'StandardMessageCodec — encoding Maps, Lists, primitives over channels.',
            'StandardMethodCodec — wrapping method calls in binary form.',
            'Custom codecs for engine plugins (audio, video, sensors).',
            'Snapshot/restore of typed in-memory state to disk.',
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 2 — ANATOMY
// ============================================================================

class _Section2Anatomy extends StatelessWidget {
  const _Section2Anatomy();

  @override
  Widget build(BuildContext context) {
    final List<int> u8 = <int>[0xAB];
    final List<int> u16 = _bytesOfUint16LE(0x1234);
    final List<int> u32 = _bytesOfUint32LE(0xDEADBEEF);
    final List<int> i32neg = _bytesOfInt32LE(-42);
    final List<int> i64 = _bytesOfInt64LE(0x0011223344556677);
    final List<int> f32 = _bytesOfFloat32LE(3.14);
    final List<int> f64 = _bytesOfFloat64LE(2.718281828);
    final List<int> strBytes = utf8.encode('hi!');

    return _SectionFrame(
      number: 2,
      title: 'ANATOMY',
      subtitle: 'Each putXxx and the exact bytes it writes.',
      color: _Palette.section2,
      children: <Widget>[
        const _Paragraph(
          'Below, every primitive write is paired with the actual byte sequence '
          'it would append at the current cursor of an empty WriteBuffer. All '
          'values are shown in little-endian (the default in modern hosts).',
        ),
        _AnatomyRow(
          method: 'putUint8(0xAB)',
          bytes: u8,
          color: _Palette.byteU8,
          desc: '1 unsigned byte, 0..255',
        ),
        _AnatomyRow(
          method: 'putUint16(0x1234)',
          bytes: u16,
          color: _Palette.byteU16,
          desc: '2 bytes, low byte first → 34 12',
        ),
        _AnatomyRow(
          method: 'putUint32(0xDEADBEEF)',
          bytes: u32,
          color: _Palette.byteU32,
          desc: '4 bytes, little-endian → EF BE AD DE',
        ),
        _AnatomyRow(
          method: 'putInt32(-42)',
          bytes: i32neg,
          color: _Palette.byteI32,
          desc: 'Two\'s complement, sign extended to 32 bits',
        ),
        _AnatomyRow(
          method: 'putInt64(0x0011223344556677)',
          bytes: i64,
          color: _Palette.byteI64,
          desc: '8 bytes; little-endian byte order',
        ),
        _AnatomyRow(
          method: 'putFloat32(3.14)',
          bytes: f32,
          color: _Palette.byteF32,
          desc: 'IEEE-754 binary32, 4 bytes',
        ),
        _AnatomyRow(
          method: 'putFloat64(2.718281828)',
          bytes: f64,
          color: _Palette.byteF64,
          desc: 'IEEE-754 binary64, 8 bytes',
        ),
        _AnatomyRow(
          method: "utf8.encode('hi!') → putUint8List(...)",
          bytes: strBytes,
          color: _Palette.byteStr,
          desc: 'UTF-8 bytes for "hi!" = 68 69 21 (= h, i, !)',
        ),
        const _Note(
          icon: Icons.bolt,
          color: _Palette.section2,
          text:
              'Note: WriteBuffer.putString uses StandardCodec\'s length-prefix '
              'convention in Flutter\'s codecs; raw use commonly couples '
              'utf8.encode(...) with putUint8List(...) and an explicit length.',
        ),
        const _SubHeading(text: 'Cumulative write', color: _Palette.section2),
        _CumulativeWrite(
          bytes: <int>[...u8, ...u16, ...u32, ...i32neg],
          labels: <String>['u8', 'u16', 'u16', 'u32', 'u32', 'u32', 'u32', 'i32', 'i32', 'i32', 'i32'],
        ),
        const _Paragraph(
          'Each cell above shows one byte of the buffer after four writes; the '
          'small subscript is the method that produced it.',
        ),
      ],
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  final String method;
  final List<int> bytes;
  final Color color;
  final String desc;

  const _AnatomyRow({
    required this.method,
    required this.bytes,
    required this.color,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _Palette.hexCellBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  method,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: _Palette.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _Palette.hexCellBorder),
                ),
                child: Text(
                  '${bytes.length} B',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _Palette.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _HexRow(bytes: bytes, background: color),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 11.8,
              color: _Palette.subInk,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _CumulativeWrite extends StatelessWidget {
  final List<int> bytes;
  final List<String> labels;

  const _CumulativeWrite({required this.bytes, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _Palette.hexCellBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.hexCellBorder),
      ),
      child: Wrap(
        children: <Widget>[
          for (int i = 0; i < bytes.length; i++)
            _ByteCell(
              byte: bytes[i],
              offset: i,
              label: i < labels.length ? labels[i] : null,
              background: Colors.white,
            ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 3 — ENDIANNESS
// ============================================================================

class _Section3Endianness extends StatelessWidget {
  const _Section3Endianness();

  @override
  Widget build(BuildContext context) {
    const int value = 0x12345678;
    final List<int> le = _bytesOfInt32LE(value);
    final List<int> be = _bytesOfInt32BE(value);
    final String host =
        Endian.host == Endian.little ? 'Endian.little' : 'Endian.big';

    return _SectionFrame(
      number: 3,
      title: 'ENDIANNESS',
      subtitle: 'How byte order changes everything.',
      color: _Palette.section3,
      children: <Widget>[
        const _Paragraph(
          'WriteBuffer methods accept an optional Endian parameter. The default '
          'is host endian, which on virtually every modern target is little-endian. '
          'Wire formats often specify big-endian (network byte order), so be deliberate.',
        ),
        const _SubHeading(text: 'Example: 0x12345678', color: _Palette.section3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _EndianCard(
                title: 'Endian.little',
                subtitle: 'low byte first',
                bytes: le,
                color: _Palette.section3,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _EndianCard(
                title: 'Endian.big',
                subtitle: 'high byte first',
                bytes: be,
                color: _Palette.section4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        _Note(
          icon: Icons.computer,
          color: _Palette.section3,
          text:
              'Endian.host on this build target is $host. WriteBuffer treats '
              'this as the default, but always pass an explicit Endian for '
              'wire-format code.',
        ),
        const _SubHeading(text: 'Side-by-side byte layout', color: _Palette.section3),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _Palette.hexCellBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      'offset',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11),
                    ),
                  ),
                  _OffsetHeader(offset: 0),
                  _OffsetHeader(offset: 1),
                  _OffsetHeader(offset: 2),
                  _OffsetHeader(offset: 3),
                ],
              ),
              _EndianRow(label: 'little', bytes: le, color: _Palette.byteU32),
              _EndianRow(label: 'big', bytes: be, color: _Palette.byteI32),
            ],
          ),
        ),
        const _Paragraph(
          'Reading 4 bytes "78 56 34 12" as little-endian yields 0x12345678. '
          'Reading the same bytes as big-endian yields 0x78563412. Encoding '
          'and decoding must agree on order, full stop.',
        ),
      ],
    );
  }
}

class _OffsetHeader extends StatelessWidget {
  final int offset;
  const _OffsetHeader({required this.offset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 24,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      child: Text(
        '+0$offset',
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: _Palette.faintInk,
        ),
      ),
    );
  }
}

class _EndianRow extends StatelessWidget {
  final String label;
  final List<int> bytes;
  final Color color;
  const _EndianRow({required this.label, required this.bytes, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _Palette.ink,
            ),
          ),
        ),
        for (final int b in bytes)
          _ByteCell(byte: b, background: color),
      ],
    );
  }
}

class _EndianCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<int> bytes;
  final Color color;

  const _EndianCard({
    required this.title,
    required this.subtitle,
    required this.bytes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.5,
              color: _Palette.subInk,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          _HexRow(bytes: bytes, background: Colors.white, showOffsets: true),
          const SizedBox(height: 6),
          Text(
            _hexJoin(bytes),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: _Palette.ink,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 4 — RECIPE: PACKET HEADER
// ============================================================================

class _Section4Header extends StatelessWidget {
  const _Section4Header();

  @override
  Widget build(BuildContext context) {
    const int magic = 0xCAFEBABE;
    const int version = 0x0001;
    const int payloadLen = 64;
    const int checksum = 0xA5A5A5A5;

    final List<int> magicBytes = _bytesOfUint32LE(magic);
    final List<int> versionBytes = _bytesOfUint16LE(version);
    final List<int> reservedBytes = <int>[0, 0];
    final List<int> lenBytes = _bytesOfUint32LE(payloadLen);
    final List<int> sumBytes = _bytesOfUint32LE(checksum);

    final List<int> header = <int>[
      ...magicBytes,
      ...versionBytes,
      ...reservedBytes,
      ...lenBytes,
      ...sumBytes,
    ];

    return _SectionFrame(
      number: 4,
      title: 'RECIPE — PACKET HEADER',
      subtitle: 'magic + version + length + checksum, hex-visible.',
      color: _Palette.section4,
      children: <Widget>[
        const _Paragraph(
          'A canonical fixed-size binary header. The encoder appends each field '
          'to a WriteBuffer in a well-defined order; the receiver mirrors it '
          'with a ReadBuffer.',
        ),
        const _CodeBlock(
          'final WriteBuffer w = WriteBuffer();\n'
          'w.putUint32(0xCAFEBABE, endian: Endian.little);  // magic\n'
          'w.putUint16(0x0001,    endian: Endian.little);   // version\n'
          'w.putUint8(0); w.putUint8(0);                    // reserved\n'
          'w.putUint32(payload.length, endian: Endian.little);\n'
          'w.putUint32(checksum,       endian: Endian.little);\n'
          'final ByteData header = w.done();',
        ),
        const _SubHeading(text: 'Field-by-field', color: _Palette.section4),
        _LabeledHex(
          label: 'magic    = 0xCAFEBABE',
          bytes: magicBytes,
          color: _Palette.byteU32,
          comment: 'Identifies the protocol; readers reject mismatched magic.',
        ),
        _LabeledHex(
          label: 'version  = 0x0001',
          bytes: versionBytes,
          color: _Palette.byteU16,
          comment: 'Allows breaking changes to be detected up front.',
        ),
        _LabeledHex(
          label: 'reserved = 0x0000',
          bytes: reservedBytes,
          color: _Palette.byteU8,
          comment: 'Padding for future flags; keep zeroed.',
        ),
        _LabeledHex(
          label: 'length   = 64',
          bytes: lenBytes,
          color: _Palette.byteU32,
          comment: 'Number of payload bytes following this header.',
        ),
        _LabeledHex(
          label: 'checksum = 0xA5A5A5A5',
          bytes: sumBytes,
          color: _Palette.byteU32,
          comment: 'Simple integrity check over the payload.',
        ),
        const _SubHeading(text: 'Final 16-byte header', color: _Palette.section4),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _Palette.hexCellBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _Palette.hexCellBorder),
          ),
          child: _HexRow(bytes: header, background: Colors.white, showOffsets: true),
        ),
        const SizedBox(height: 6),
        _PacketDiagram(header: header),
        const _Note(
          icon: Icons.shield_outlined,
          color: _Palette.section4,
          text:
              'Always validate magic, version, and length before trusting the '
              'rest of the message. Reject early.',
        ),
      ],
    );
  }
}

class _PacketDiagram extends StatelessWidget {
  final List<int> header;
  const _PacketDiagram({required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.hexCellBorder),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              _DiagSlice(text: 'magic\n4 B', color: _Palette.byteU32, flex: 4),
              _DiagSlice(text: 'ver\n2 B', color: _Palette.byteU16, flex: 2),
              _DiagSlice(text: 'rsv\n2 B', color: _Palette.byteU8, flex: 2),
              _DiagSlice(text: 'length\n4 B', color: _Palette.byteU32, flex: 4),
              _DiagSlice(text: 'checksum\n4 B', color: _Palette.byteU32, flex: 4),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'hex: ${_hexJoin(header)}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _Palette.subInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagSlice extends StatelessWidget {
  final String text;
  final Color color;
  final int flex;
  const _DiagSlice({required this.text, required this.color, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _Palette.hexCellBorder),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: _Palette.ink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 5 — STRINGS
// ============================================================================

class _Section5Strings extends StatelessWidget {
  const _Section5Strings();

  @override
  Widget build(BuildContext context) {
    final String s1 = 'flutter';
    final List<int> b1 = utf8.encode(s1);
    final List<int> len1 = _bytesOfUint32LE(b1.length);

    final String s2 = 'café';
    final List<int> b2 = utf8.encode(s2);
    final List<int> len2 = _bytesOfUint32LE(b2.length);

    final String s3 = '日本語';
    final List<int> b3 = utf8.encode(s3);
    final List<int> len3 = _bytesOfUint32LE(b3.length);

    return _SectionFrame(
      number: 5,
      title: 'RECIPE — LENGTH-PREFIXED STRINGS',
      subtitle: 'UTF-8 bytes with a fixed-size length header.',
      color: _Palette.section5,
      children: <Widget>[
        const _Paragraph(
          'There is no implicit terminator: every variable-length payload needs '
          'an explicit length. A common pattern is uint32 byte-length, then '
          'UTF-8 bytes.',
        ),
        const _CodeBlock(
          'void writeString(WriteBuffer w, String s) {\n'
          '  final Uint8List bytes = utf8.encode(s);\n'
          '  w.putUint32(bytes.length, endian: Endian.little);\n'
          '  w.putUint8List(bytes);\n'
          '}',
        ),
        const _SubHeading(text: '"flutter" (ASCII)', color: _Palette.section5),
        _StringRow(string: s1, lenBytes: len1, bodyBytes: b1),
        const _SubHeading(text: '"café" (Latin-1 + multi-byte)', color: _Palette.section5),
        _StringRow(string: s2, lenBytes: len2, bodyBytes: b2),
        const _Note(
          icon: Icons.warning_amber_outlined,
          color: _Palette.section5,
          text:
              'Notice that the visible character count (4) differs from the byte '
              'length (5): "é" is encoded as the two bytes C3 A9 in UTF-8.',
        ),
        const _SubHeading(text: '"日本語" (CJK)', color: _Palette.section5),
        _StringRow(string: s3, lenBytes: len3, bodyBytes: b3),
        const _Paragraph(
          'Three Japanese code points yielding nine bytes: each character occupies '
          'three bytes in UTF-8. Length-prefix counts bytes, not characters.',
        ),
        const _SubHeading(text: 'Alternative prefix sizes', color: _Palette.section5),
        const _BulletList(
          items: <String>[
            'uint8  length: strings up to 255 bytes — useful for tags/names.',
            'uint16 length: up to 65 535 bytes — most user-facing strings fit.',
            'uint32 length: up to 4 GiB — overkill for chat messages but free.',
            'varint length: compact for short strings, complex to read.',
          ],
        ),
      ],
    );
  }
}

class _StringRow extends StatelessWidget {
  final String string;
  final List<int> lenBytes;
  final List<int> bodyBytes;

  const _StringRow({
    required this.string,
    required this.lenBytes,
    required this.bodyBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.hexCellBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _Palette.section5.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  string,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _Palette.section5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'chars: ${string.runes.length}   bytes: ${bodyBytes.length}',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: _Palette.subInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _LabeledHex(
            label: 'length (uint32 LE)',
            bytes: lenBytes,
            color: _Palette.byteU32,
          ),
          _LabeledHex(
            label: 'utf8 bytes',
            bytes: bodyBytes,
            color: _Palette.byteStr,
            comment: _renderCharLine(string, bodyBytes),
          ),
        ],
      ),
    );
  }

  String _renderCharLine(String s, List<int> bytes) {
    final StringBuffer sb = StringBuffer('byte→char: ');
    int i = 0;
    for (final int r in s.runes) {
      final String ch = String.fromCharCode(r);
      final int chBytes = utf8.encode(ch).length;
      sb.write('"$ch"=$chBytes ');
      i += chBytes;
    }
    return sb.toString().trim();
  }
}

// ============================================================================
// SECTION 6 — MIXED BINARY RECORD
// ============================================================================

class _Section6MixedRecord extends StatelessWidget {
  const _Section6MixedRecord();

  @override
  Widget build(BuildContext context) {
    // Record layout:
    //   uint32   id
    //   float64  timestamp
    //   uint32   nameLen
    //   uint8[]  name (utf8)
    //   uint32   floatsLen
    //   float64[] samples
    //   uint32   tagsLen
    //   uint8[]  tags (bitmap)

    const int id = 0x10AB20CD;
    final double ts = 1715000000.250;
    final String name = 'temp-sensor-7';
    final List<double> samples = <double>[21.50, 21.75, 22.00, 21.95, 21.80];
    final List<int> tags = <int>[0xF0, 0x0F, 0xAA, 0x55];

    final List<int> idBytes = _bytesOfUint32LE(id);
    final List<int> tsBytes = _bytesOfFloat64LE(ts);
    final List<int> nameBytes = utf8.encode(name);
    final List<int> nameLen = _bytesOfUint32LE(nameBytes.length);
    final List<int> floatsLen = _bytesOfUint32LE(samples.length);
    final List<int> floatBytes = <int>[];
    for (final double s in samples) {
      floatBytes.addAll(_bytesOfFloat64LE(s));
    }
    final List<int> tagsLen = _bytesOfUint32LE(tags.length);

    final List<int> record = <int>[
      ...idBytes,
      ...tsBytes,
      ...nameLen,
      ...nameBytes,
      ...floatsLen,
      ...floatBytes,
      ...tagsLen,
      ...tags,
    ];

    return _SectionFrame(
      number: 6,
      title: 'MIXED BINARY RECORD',
      subtitle: 'Float64List + Uint8List + length-prefixed string in one buffer.',
      color: _Palette.section6,
      children: <Widget>[
        const _Paragraph(
          'Real protocols mix types freely. WriteBuffer shines here because the '
          'caller never has to compute the total size in advance.',
        ),
        const _CodeBlock(
          'final WriteBuffer w = WriteBuffer();\n'
          'w.putUint32(id);\n'
          'w.putFloat64(timestamp);\n'
          '\n'
          'final Uint8List nameBytes = utf8.encode(name);\n'
          'w.putUint32(nameBytes.length);\n'
          'w.putUint8List(nameBytes);\n'
          '\n'
          'w.putUint32(samples.length);\n'
          'w.putFloat64List(Float64List.fromList(samples));\n'
          '\n'
          'w.putUint32(tags.length);\n'
          'w.putUint8List(Uint8List.fromList(tags));\n'
          '\n'
          'final ByteData out = w.done();',
        ),
        const _SubHeading(text: 'Field anatomy', color: _Palette.section6),
        _KvRow(k: 'id', v: '0x${id.toRadixString(16).toUpperCase()}', icon: Icons.tag),
        _KvRow(k: 'timestamp', v: ts.toString(), icon: Icons.access_time),
        _KvRow(k: 'name', v: '"$name" (${nameBytes.length} B)', icon: Icons.label_outline),
        _KvRow(k: 'samples', v: '${samples.length} × float64', icon: Icons.timeline),
        _KvRow(k: 'tags', v: '${tags.length} bytes bitmap', icon: Icons.bookmark_outline),
        const SizedBox(height: 8),
        const _SubHeading(text: 'Hex panel', color: _Palette.section6),
        _LabeledHex(
          label: 'id (uint32 LE)',
          bytes: idBytes,
          color: _Palette.byteU32,
        ),
        _LabeledHex(
          label: 'timestamp (float64 LE)',
          bytes: tsBytes,
          color: _Palette.byteF64,
        ),
        _LabeledHex(
          label: 'nameLen (uint32 LE)',
          bytes: nameLen,
          color: _Palette.byteU32,
        ),
        _LabeledHex(
          label: 'name (utf8)',
          bytes: nameBytes,
          color: _Palette.byteStr,
          comment: '"$name"',
        ),
        _LabeledHex(
          label: 'floatsLen (uint32 LE)',
          bytes: floatsLen,
          color: _Palette.byteU32,
        ),
        _LabeledHex(
          label: 'samples (float64[] LE)',
          bytes: floatBytes,
          color: _Palette.byteF64,
          comment: '${samples.length} samples × 8 B = ${floatBytes.length} B',
        ),
        _LabeledHex(
          label: 'tagsLen (uint32 LE)',
          bytes: tagsLen,
          color: _Palette.byteU32,
        ),
        _LabeledHex(
          label: 'tags (uint8[])',
          bytes: tags,
          color: _Palette.byteU8,
          comment: 'bitmap bytes',
        ),
        const _SubHeading(text: 'Combined record', color: _Palette.section6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _Palette.hexCellBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _Palette.hexCellBorder),
          ),
          child: _HexRow(bytes: record, background: Colors.white, showOffsets: true),
        ),
        const SizedBox(height: 6),
        _Note(
          icon: Icons.account_tree_outlined,
          color: _Palette.section6,
          text:
              'Final record size: ${record.length} bytes. The decoder uses the '
              'same field order and length prefixes to walk back through the '
              'buffer without ambiguity.',
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 7 — COMPARISON
// ============================================================================

class _Section7Comparison extends StatelessWidget {
  const _Section7Comparison();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      number: 7,
      title: 'COMPARISON — WriteBuffer vs ByteData vs BytesBuilder',
      subtitle: 'Three sinks, three trade-offs.',
      color: _Palette.section7,
      children: <Widget>[
        const _Paragraph(
          'Dart and Flutter offer three commonly used binary sinks. They serve '
          'different needs and pair well in different roles.',
        ),
        const _ComparisonTable(),
        const SizedBox(height: 8),
        const _SubHeading(text: 'When to reach for each', color: _Palette.section7),
        const _CompCard(
          title: 'WriteBuffer',
          desc:
              'Use when you need typed primitive writes (putInt32, putFloat64, '
              'putUint8List), an unbounded growable target, and a ByteData '
              'result at the end. Best for binary codecs and platform channels.',
          color: _Palette.section1,
          icon: Icons.bolt,
        ),
        const _CompCard(
          title: 'ByteData',
          desc:
              'Use when the total size is known up front and offsets are '
              'computed manually. Cheaper than WriteBuffer for fixed-size '
              'records and gives surgical control over alignment.',
          color: _Palette.section3,
          icon: Icons.grid_view_outlined,
        ),
        const _CompCard(
          title: 'BytesBuilder',
          desc:
              'Use when concatenating already-prepared byte chunks (Uint8List '
              'pieces) and you do not need typed numeric writers. Excellent '
              'for stream assembly.',
          color: _Palette.section6,
          icon: Icons.merge_type,
        ),
        const _SubHeading(text: 'API side-by-side', color: _Palette.section7),
        const _CodeBlock(
          '// WriteBuffer\n'
          'final WriteBuffer w = WriteBuffer();\n'
          'w.putInt32(42);\n'
          'w.putFloat64(3.14);\n'
          'final ByteData out = w.done();\n'
          '\n'
          '// ByteData (fixed size 12)\n'
          'final ByteData bd = ByteData(12);\n'
          'bd.setInt32(0, 42, Endian.little);\n'
          'bd.setFloat64(4, 3.14, Endian.little);\n'
          '\n'
          '// BytesBuilder (concatenation)\n'
          'final BytesBuilder bb = BytesBuilder();\n'
          'bb.add([0x2A, 0x00, 0x00, 0x00]);\n'
          'bb.add([0x1F, 0x85, 0xEB, 0x51, 0xB8, 0x1E, 0x09, 0x40]);\n'
          'final Uint8List packed = bb.toBytes();',
        ),
        const _Note(
          icon: Icons.swap_horiz,
          color: _Palette.section7,
          text:
              'It is normal to compose: write into WriteBuffer, hand the '
              'ByteData to a BytesBuilder, then write the result to a Sink.',
        ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _Palette.hexCellBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: const <Widget>[
          _CompHeader(),
          _CompRow(
            criterion: 'Growable',
            wb: 'yes',
            bd: 'no',
            bb: 'yes',
          ),
          _CompRow(
            criterion: 'Typed writers',
            wb: 'int8..int64, float32/64',
            bd: 'set*',
            bb: 'none',
          ),
          _CompRow(
            criterion: 'Endian per write',
            wb: 'yes',
            bd: 'yes',
            bb: 'n/a',
          ),
          _CompRow(
            criterion: 'Output',
            wb: 'ByteData (done)',
            bd: 'self',
            bb: 'Uint8List',
          ),
          _CompRow(
            criterion: 'Allocation cost',
            wb: 'amortized O(1)',
            bd: 'one alloc',
            bb: 'per add()',
          ),
          _CompRow(
            criterion: 'Best for',
            wb: 'binary codecs',
            bd: 'fixed records',
            bb: 'chunk concat',
          ),
        ],
      ),
    );
  }
}

class _CompHeader extends StatelessWidget {
  const _CompHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _Palette.section7,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Criterion',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'WriteBuffer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'ByteData',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'BytesBuilder',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompRow extends StatelessWidget {
  final String criterion;
  final String wb;
  final String bd;
  final String bb;
  const _CompRow({
    required this.criterion,
    required this.wb,
    required this.bd,
    required this.bb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: _Palette.hexCellBorder),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              criterion,
              style: const TextStyle(
                fontSize: 12.5,
                color: _Palette.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              wb,
              style: const TextStyle(fontSize: 12.5, color: _Palette.subInk),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              bd,
              style: const TextStyle(fontSize: 12.5, color: _Palette.subInk),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              bb,
              style: const TextStyle(fontSize: 12.5, color: _Palette.subInk),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompCard extends StatelessWidget {
  final String title;
  final String desc;
  final Color color;
  final IconData icon;
  const _CompCard({
    required this.title,
    required this.desc,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _Palette.subInk,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 8 — PITFALLS
// ============================================================================

class _Section8Pitfalls extends StatelessWidget {
  const _Section8Pitfalls();

  @override
  Widget build(BuildContext context) {
    final List<int> alignedFloat = _bytesOfFloat64LE(1.0);
    final List<int> u8Then = <int>[0x7F, ...alignedFloat];
    final List<int> signed = _bytesOfInt32LE(-1);
    final List<int> unsigned = _bytesOfUint32LE(0xFFFFFFFF);

    return _SectionFrame(
      number: 8,
      title: 'PITFALLS',
      subtitle: 'Alignment, signed-vs-unsigned, and the silent ones.',
      color: _Palette.section8,
      children: <Widget>[
        const _SubHeading(text: 'Pitfall 1 — Alignment expectations', color: _Palette.section8),
        const _Paragraph(
          'WriteBuffer does not pad to any natural alignment. If a putUint8 '
          'precedes a putFloat64, the float\'s 8 bytes will start on an odd '
          'offset. Most platforms tolerate misaligned access in software, but '
          'some FFI consumers and platform code do not.',
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _Palette.hexCellBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _Palette.hexCellBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'putUint8(0x7F); putFloat64(1.0);',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  color: _Palette.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              _HexRow(bytes: u8Then, background: Colors.white, showOffsets: true),
              const SizedBox(height: 6),
              const Text(
                'The float now lives at offset +01, not +00 or +08. Pad '
                'explicitly when receivers care.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: _Palette.subInk,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const _SubHeading(text: 'Pitfall 2 — Signed vs unsigned', color: _Palette.section8),
        const _Paragraph(
          'WriteBuffer has both putInt32(-1) and putUint32(0xFFFFFFFF). Both '
          'produce identical bytes (FF FF FF FF), but ReadBuffer.getInt32 and '
          'ReadBuffer.getUint32 interpret them as -1 and 4 294 967 295 '
          'respectively. Mixing readers and writers is a common source of bugs.',
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _SignedCard(
                title: 'putInt32(-1)',
                bytes: signed,
                color: _Palette.byteI32,
                interp: 'getInt32 → -1\ngetUint32 → 4 294 967 295',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SignedCard(
                title: 'putUint32(0xFFFFFFFF)',
                bytes: unsigned,
                color: _Palette.byteU32,
                interp: 'getInt32 → -1\ngetUint32 → 4 294 967 295',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const _SubHeading(text: 'Pitfall 3 — Endianness drift', color: _Palette.section8),
        const _Paragraph(
          'Mixing host-default writes on one side with explicit Endian.big on '
          'the other side silently corrupts every multi-byte value. Always be '
          'explicit at the protocol boundary.',
        ),
        const _SubHeading(text: 'Pitfall 4 — Forgetting length prefixes', color: _Palette.section8),
        const _Paragraph(
          'There is no implicit terminator for variable-length payloads. Omit a '
          'length prefix and the decoder has no way to find the next field.',
        ),
        const _SubHeading(text: 'Pitfall 5 — Reusing a done() buffer', color: _Palette.section8),
        const _Paragraph(
          'WriteBuffer is a one-shot pipeline: after done() it should be '
          'discarded. Subsequent writes will misbehave or throw.',
        ),
        const _Note(
          icon: Icons.error_outline,
          color: _Palette.section8,
          text:
              'Defence: write a tiny round-trip test for every binary protocol. '
              'WriteBuffer → bytes → ReadBuffer → original value, asserted exactly.',
        ),
        const _SubHeading(text: 'Common bug taxonomy', color: _Palette.section8),
        const _BulletList(
          items: <String>[
            'Off-by-one length: counts characters where it should count bytes.',
            'Truncated payload: receiver reads less than the prefix promised.',
            'Endian mismatch: numbers come out byte-reversed.',
            'Sign overflow: -1 written as int32, read as uint32, decoded as 2^32-1.',
            'Reserved bytes non-zero: forward compatibility silently broken.',
          ],
        ),
      ],
    );
  }
}

class _SignedCard extends StatelessWidget {
  final String title;
  final List<int> bytes;
  final Color color;
  final String interp;
  const _SignedCard({
    required this.title,
    required this.bytes,
    required this.color,
    required this.interp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.hexCellBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: _Palette.ink,
            ),
          ),
          const SizedBox(height: 6),
          _HexRow(bytes: bytes, background: Colors.white),
          const SizedBox(height: 6),
          Text(
            interp,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _Palette.subInk,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 9 — GLOSSARY
// ============================================================================

class _Section9Glossary extends StatelessWidget {
  const _Section9Glossary();

  @override
  Widget build(BuildContext context) {
    final List<_GlossEntry> entries = <_GlossEntry>[
      _GlossEntry(
        term: 'Byte',
        body:
            'The unit WriteBuffer ultimately produces; an 8-bit unsigned value in [0, 255].',
      ),
      _GlossEntry(
        term: 'Endianness',
        body:
            'Byte order for multi-byte values. Little = low byte first, big = high byte first.',
      ),
      _GlossEntry(
        term: 'Endian.host',
        body:
            'The byte order of the current runtime, typically little on x86 and ARM.',
      ),
      _GlossEntry(
        term: 'ByteData',
        body:
            'A typed view over a fixed-size buffer with random-access setters/getters.',
      ),
      _GlossEntry(
        term: 'Uint8List',
        body:
            'A typed list of unsigned 8-bit integers; can be viewed as bytes directly.',
      ),
      _GlossEntry(
        term: 'BytesBuilder',
        body:
            'A growable byte concatenator from dart:typed_data; appends Uint8List chunks.',
      ),
      _GlossEntry(
        term: 'Two\'s complement',
        body:
            'Standard encoding for signed integers; -1 in int32 is FF FF FF FF.',
      ),
      _GlossEntry(
        term: 'IEEE-754',
        body:
            'Floating-point standard. binary32 is 4 bytes, binary64 is 8 bytes.',
      ),
      _GlossEntry(
        term: 'Length-prefix',
        body:
            'A fixed-size byte count placed before a variable-length payload.',
      ),
      _GlossEntry(
        term: 'Codec',
        body:
            'A symmetric encoder/decoder pair; in Flutter, StandardMessageCodec uses WriteBuffer/ReadBuffer.',
      ),
      _GlossEntry(
        term: 'Platform channel',
        body:
            'Flutter\'s mechanism for communicating with native code; messages are binary.',
      ),
      _GlossEntry(
        term: 'Alignment',
        body:
            'Constraint that a value start at an offset divisible by its size.',
      ),
      _GlossEntry(
        term: 'Magic number',
        body:
            'A constant value at the start of a binary format that identifies it.',
      ),
      _GlossEntry(
        term: 'Checksum',
        body:
            'A short integrity value over a payload; e.g. CRC32 or Fletcher\'s checksum.',
      ),
    ];

    return _SectionFrame(
      number: 9,
      title: 'GLOSSARY',
      subtitle: 'Quick definitions used throughout this dossier.',
      color: _Palette.section9,
      children: <Widget>[
        for (final _GlossEntry e in entries) _GlossRow(entry: e),
      ],
    );
  }
}

class _GlossEntry {
  final String term;
  final String body;
  _GlossEntry({required this.term, required this.body});
}

class _GlossRow extends StatelessWidget {
  final _GlossEntry entry;
  const _GlossRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _Palette.hexCellBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              entry.term,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _Palette.section9,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.body,
              style: const TextStyle(
                fontSize: 12.8,
                color: _Palette.subInk,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 10 — RECAP
// ============================================================================

class _Section10Recap extends StatelessWidget {
  const _Section10Recap();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      number: 10,
      title: 'RECAP',
      subtitle: 'What to remember when reaching for WriteBuffer.',
      color: _Palette.section10,
      children: <Widget>[
        const _SubHeading(text: 'Five takeaways', color: _Palette.section10),
        const _BulletList(
          items: <String>[
            'WriteBuffer is the binary-write half of a Reader/Writer pair; it grows on demand and finishes with done().',
            'Every put* method appends a precise number of bytes; size up front is never required.',
            'Endianness is host-default but configurable per call. Be explicit at protocol boundaries.',
            'Strings and lists need explicit length prefixes; there is no implicit terminator.',
            'Round-trip tests using WriteBuffer + ReadBuffer catch nearly every encoding bug.',
          ],
        ),
        const _SubHeading(text: 'Pocket recipe', color: _Palette.section10),
        const _CodeBlock(
          'Uint8List encodeRecord(Record r) {\n'
          '  final WriteBuffer w = WriteBuffer();\n'
          '  w.putUint32(r.id);\n'
          '  w.putFloat64(r.timestamp);\n'
          '\n'
          '  final Uint8List name = utf8.encode(r.name);\n'
          '  w.putUint32(name.length);\n'
          '  w.putUint8List(name);\n'
          '\n'
          '  w.putUint32(r.samples.length);\n'
          '  w.putFloat64List(Float64List.fromList(r.samples));\n'
          '\n'
          '  final ByteData out = w.done();\n'
          '  return out.buffer.asUint8List(\n'
          '    out.offsetInBytes,\n'
          '    out.lengthInBytes,\n'
          '  );\n'
          '}',
        ),
        const _SubHeading(text: 'Anti-pattern reminders', color: _Palette.section10),
        const _BulletList(
          items: <String>[
            'Do not mutate a WriteBuffer after done().',
            'Do not count characters where you should count bytes.',
            'Do not assume host endianness on the wire.',
            'Do not omit length prefixes on variable-length payloads.',
            'Do not mix signed and unsigned readers/writers without explicit conversion.',
          ],
        ),
        const _SubHeading(text: 'Where to look next', color: _Palette.section10),
        const _BulletList(
          items: <String>[
            'ReadBuffer — the mirror image of WriteBuffer.',
            'StandardMessageCodec — Flutter\'s canonical binary message codec.',
            'StandardMethodCodec — wraps method calls atop StandardMessageCodec.',
            'ByteData — fixed-size random-access binary buffer.',
            'BytesBuilder — growable byte concatenator from dart:typed_data.',
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_Palette.section10, _Palette.section1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'WriteBuffer turns the verbose, error-prone dance of "compute size, '
            'allocate, set offsets, advance cursor" into a flat sequence of '
            'typed put calls. Use it whenever your binary output is built '
            'incrementally.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.55,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// END OF FILE
// ============================================================================
