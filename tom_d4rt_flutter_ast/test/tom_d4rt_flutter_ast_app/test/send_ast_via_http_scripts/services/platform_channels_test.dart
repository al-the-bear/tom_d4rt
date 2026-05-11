// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// Platform Channels Deep Visual Demo
// =============================================================================
//
// This file is a hand-authored, statically-rendered tour of Flutter's
// platform-channel surface from `package:flutter/services.dart`. Nothing here
// actually crosses the engine boundary: we construct the channel objects to
// exhibit their shapes, but every "send" rendered on the page is a fabricated
// log entry produced by a `StatefulBuilder`. The point is to visualise the
// mechanics so a reader can trace the path of a method call from Dart land
// through the binary messenger, across the engine, and back as a response,
// without ever having to spin up an embedder.
//
// The hierarchy of concepts demonstrated:
//
//   * Channels:
//       - MethodChannel             (request / response, single method name)
//       - OptionalMethodChannel     (silent when no handler is attached)
//       - BasicMessageChannel<T>    (typed, optionally bidirectional pipe)
//       - EventChannel              (stream of platform-emitted events)
//
//   * Codecs:
//       - BinaryCodec               (identity, raw ByteData)
//       - StringCodec               (UTF-8 string)
//       - JSONMessageCodec          (jsonEncode / jsonDecode)
//       - StandardMessageCodec      (type-tagged binary)
//       - JSONMethodCodec           (JSON-encoded MethodCall envelope)
//       - StandardMethodCodec       (binary-encoded MethodCall envelope)
//
//   * Errors:
//       - PlatformException         (code, message, details, stacktrace)
//       - MissingPluginException    (no handler registered)
//
//   * Envelope:
//       - MethodCall(method, arguments)
//
// The page is organised into eight visually distinct sections, each with its
// own gradient, drop-shadow stack, and inline anatomy diagrams. The hand-built
// "wire format" mockup at the bottom shows a synthetic StandardMethodCodec
// byte stream so the abstract codec table has a concrete payload to point at.
// =============================================================================

// -----------------------------------------------------------------------------
// Palette
// -----------------------------------------------------------------------------

const Color kInk = Color(0xFF0F172A);
const Color kInkSoft = Color(0xFF334155);
const Color kInkMute = Color(0xFF64748B);
const Color kPaper = Color(0xFFF8FAFC);
const Color kPaperWarm = Color(0xFFFFF7ED);
const Color kSurface = Color(0xFFFFFFFF);
const Color kSurfaceAlt = Color(0xFFF1F5F9);
const Color kBorder = Color(0xFFCBD5E1);
const Color kBorderSoft = Color(0xFFE2E8F0);

const Color kBlue = Color(0xFF2563EB);
const Color kBlueDark = Color(0xFF1D4ED8);
const Color kBlueLight = Color(0xFFDBEAFE);

const Color kIndigo = Color(0xFF4F46E5);
const Color kIndigoDark = Color(0xFF312E81);
const Color kIndigoLight = Color(0xFFE0E7FF);

const Color kTeal = Color(0xFF0D9488);
const Color kTealDark = Color(0xFF0F766E);
const Color kTealLight = Color(0xFFCCFBF1);

const Color kAmber = Color(0xFFD97706);
const Color kAmberDark = Color(0xFFB45309);
const Color kAmberLight = Color(0xFFFEF3C7);

const Color kRose = Color(0xFFE11D48);
const Color kRoseDark = Color(0xFFBE123C);
const Color kRoseLight = Color(0xFFFFE4E6);

const Color kViolet = Color(0xFF7C3AED);
const Color kVioletDark = Color(0xFF5B21B6);
const Color kVioletLight = Color(0xFFEDE9FE);

const Color kEmerald = Color(0xFF059669);
const Color kEmeraldDark = Color(0xFF047857);
const Color kEmeraldLight = Color(0xFFD1FAE5);

const Color kSlate = Color(0xFF475569);
const Color kSlateDark = Color(0xFF1E293B);
const Color kSlateLight = Color(0xFFE2E8F0);

// -----------------------------------------------------------------------------
// Reusable visual primitives
// -----------------------------------------------------------------------------

LinearGradient gradient(Color a, Color b) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [a, b],
  );
}

List<BoxShadow> layeredShadows(Color tint) {
  return [
    BoxShadow(
      color: tint.withOpacity(0.18),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
    BoxShadow(
      color: tint.withOpacity(0.10),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
    const BoxShadow(
      color: Color(0x14000000),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];
}

Widget gap(double h) => SizedBox(height: h);
Widget hgap(double w) => SizedBox(width: w);

Widget mono(String text, {Color? color, double size = 12.5}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: size,
      height: 1.45,
      color: color ?? kInk,
    ),
  );
}

Widget label(String text, {Color color = kInkSoft}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: color,
    ),
  );
}

Widget chip(String text, {Color bg = kSlateLight, Color fg = kInk}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: fg.withOpacity(0.15)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: fg,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget paragraph(String text, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.5,
        height: 1.55,
        color: color ?? kInkSoft,
      ),
    ),
  );
}

Widget heading(String text, {Color color = kInk, double size = 22}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: -0.4,
      height: 1.2,
    ),
  );
}

Widget subheading(String text, {Color color = kInkSoft}) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontStyle: FontStyle.italic,
        color: color,
      ),
    ),
  );
}

Widget sectionFrame({
  required String index,
  required String title,
  required String subtitle,
  required LinearGradient bandGradient,
  required Color accent,
  required Color accentLight,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(20),
      boxShadow: layeredShadows(accent),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          decoration: BoxDecoration(
            gradient: bandGradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Text(
                  index,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              hgap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.92),
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentLight.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'flutter/services',
                  style: TextStyle(
                    color: accent,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
          child: child,
        ),
      ],
    ),
  );
}

Widget codeCard(
  String code, {
  Color background = const Color(0xFF0B1220),
  Color foreground = const Color(0xFFE2E8F0),
  String? title,
  Color? titleTint,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
      boxShadow: layeredShadows(background),
      border: Border.all(color: Colors.black.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            decoration: BoxDecoration(
              color: (titleTint ?? Colors.white).withOpacity(0.08),
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
            ),
            child: Row(
              children: [
                _trafficDot(const Color(0xFFEF4444)),
                hgap(6),
                _trafficDot(const Color(0xFFF59E0B)),
                hgap(6),
                _trafficDot(const Color(0xFF22C55E)),
                hgap(12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: titleTint ?? Colors.white.withOpacity(0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
              color: foreground,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _trafficDot(Color c) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

Widget bullet(String text, {Color tint = kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7, right: 10),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: tint,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: kInkSoft,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget pillRow(List<Widget> children) {
  return Wrap(spacing: 8, runSpacing: 8, children: children);
}

Widget keyValue(String k, String v, {Color? tint}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            k,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: tint ?? kInkMute,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: kInk,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget pipelineNode({
  required String title,
  required String role,
  required Color color,
  required Color light,
  IconData? icon,
}) {
  return Container(
    width: 142,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: light,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withOpacity(0.5)),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.20),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon ?? Icons.bolt,
                size: 16,
                color: Colors.white,
              ),
            ),
            hgap(8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
        gap(8),
        Text(
          role,
          style: const TextStyle(
            fontSize: 11.5,
            height: 1.4,
            color: kInkSoft,
          ),
        ),
      ],
    ),
  );
}

Widget arrow(Color color, {String? caption}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (caption != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            caption,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.6,
            ),
          ),
        ),
      SizedBox(
        width: 38,
        height: 22,
        child: CustomPaint(painter: _ArrowPainter(color: color)),
      ),
    ],
  );
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final y = size.height / 2;
    canvas.drawLine(Offset(0, y), Offset(size.width - 6, y), paint);
    final head = Path()
      ..moveTo(size.width, y)
      ..lineTo(size.width - 8, y - 5)
      ..lineTo(size.width - 8, y + 5)
      ..close();
    final fill = Paint()..color = color;
    canvas.drawPath(head, fill);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) =>
      oldDelegate.color != color;
}

Widget table({
  required List<String> headers,
  required List<List<String>> rows,
  Color headerColor = kSlateDark,
  Color zebra = kSurfaceAlt,
}) {
  final widths = <int, TableColumnWidth>{};
  for (var i = 0; i < headers.length; i++) {
    widths[i] = const FlexColumnWidth();
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Table(
      columnWidths: widths,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: kBorderSoft, width: 1),
      children: [
        TableRow(
          decoration: BoxDecoration(color: headerColor),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Text(
                    h,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        for (var r = 0; r < rows.length; r++)
          TableRow(
            decoration: BoxDecoration(
              color: r.isEven ? kSurface : zebra,
            ),
            children: rows[r]
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 9,
                    ),
                    child: Text(
                      cell,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.45,
                        color: kInk,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    ),
  );
}

// =============================================================================
// Page header
// =============================================================================

Widget pageHeader() {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF312E81)],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: layeredShadows(kIndigoDark),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: const Text(
                'package:flutter/services.dart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            hgap(10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: kAmber,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'Deep Visual Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        gap(12),
        const Text(
          'Platform Channels',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
            height: 1.05,
          ),
        ),
        gap(6),
        Text(
          'MethodChannel, BasicMessageChannel<T>, EventChannel — '
          'plus the codecs and exceptions that wrap every message.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14.5,
            height: 1.55,
          ),
        ),
        gap(14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            chip('MethodChannel', bg: kBlueLight, fg: kBlueDark),
            chip('OptionalMethodChannel', bg: kIndigoLight, fg: kIndigoDark),
            chip('BasicMessageChannel<T>', bg: kTealLight, fg: kTealDark),
            chip('EventChannel', bg: kVioletLight, fg: kVioletDark),
            chip('StandardMethodCodec', bg: kAmberLight, fg: kAmberDark),
            chip('JSONMethodCodec', bg: kAmberLight, fg: kAmberDark),
            chip('StandardMessageCodec', bg: kEmeraldLight, fg: kEmeraldDark),
            chip('JSONMessageCodec', bg: kEmeraldLight, fg: kEmeraldDark),
            chip('StringCodec', bg: kEmeraldLight, fg: kEmeraldDark),
            chip('BinaryCodec', bg: kEmeraldLight, fg: kEmeraldDark),
            chip('PlatformException', bg: kRoseLight, fg: kRoseDark),
            chip('MissingPluginException', bg: kRoseLight, fg: kRoseDark),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 1 — Pipeline anatomy
// =============================================================================

Widget section1Pipeline() {
  return sectionFrame(
    index: '01',
    title: 'The pipeline: Dart -> engine -> platform -> response',
    subtitle: 'Anatomy of a single MethodChannel.invokeMethod round-trip',
    bandGradient: gradient(kBlueDark, kIndigo),
    accent: kBlueDark,
    accentLight: kBlueLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'A platform channel is a thin Dart facade over the engine\'s '
          'BinaryMessenger. When framework code calls invokeMethod on a '
          'MethodChannel, the channel asks its codec to serialise the '
          'MethodCall into a binary envelope, hands that envelope to the '
          'BinaryMessenger keyed by the channel name, and waits for a '
          'matching reply envelope. The engine forwards the buffer to the '
          'host platform side (Android, iOS, macOS, Linux, Windows, or web), '
          'where a registered handler decodes it with a mirror codec, '
          'executes the requested method, and ships an encoded result or '
          'error back across the same name.',
        ),
        paragraph(
          'Crucially this is asynchronous in both directions and entirely '
          'message-oriented. There is no shared memory, no synchronous call '
          'stack across the boundary, and no implicit type system: every '
          'value that crosses the line must round-trip through a codec. The '
          'diagram below traces a single call as the seven hops the framework '
          'actually performs at runtime.',
        ),
        gap(14),
        _PipelineDiagram(),
        gap(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kBlueLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kBlue.withOpacity(0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label('REQUEST PATH', color: kBlueDark),
                    gap(6),
                    bullet('Framework invokes MethodChannel.invokeMethod.'),
                    bullet('MethodCodec encodes MethodCall to ByteData.'),
                    bullet('BinaryMessenger.send forwards by channel name.'),
                    bullet('Engine relays buffer to platform side.'),
                    bullet('Host decodes envelope, dispatches handler.'),
                  ],
                ),
              ),
            ),
            hgap(14),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kEmeraldLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kEmerald.withOpacity(0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label('RESPONSE PATH', color: kEmeraldDark),
                    gap(6),
                    bullet('Handler returns success / error / not-implemented.'),
                    bullet('Host codec encodes envelope back to bytes.'),
                    bullet('Engine relays buffer to Dart side.'),
                    bullet('MethodCodec decodes envelope, completes Future.'),
                    bullet('Errors surface as PlatformException or null.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _PipelineDiagram extends StatelessWidget {
  const _PipelineDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFEEF2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
        boxShadow: layeredShadows(kIndigoLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              label('DART SIDE', color: kBlueDark),
              hgap(8),
              Expanded(
                child: Container(
                  height: 1,
                  color: kBlue.withOpacity(0.25),
                ),
              ),
              hgap(8),
              label('PLATFORM SIDE', color: kEmeraldDark),
            ],
          ),
          gap(14),
          Wrap(
            spacing: 6,
            runSpacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              pipelineNode(
                title: 'Framework',
                role: 'Calls invokeMethod()',
                color: kBlueDark,
                light: kBlueLight,
                icon: Icons.code,
              ),
              arrow(kBlue, caption: 'call'),
              pipelineNode(
                title: 'MethodChannel',
                role: 'Wraps codec + name',
                color: kIndigo,
                light: kIndigoLight,
                icon: Icons.swap_horiz,
              ),
              arrow(kIndigo, caption: 'encode'),
              pipelineNode(
                title: 'BinaryMessenger',
                role: 'send(name, bytes)',
                color: kViolet,
                light: kVioletLight,
                icon: Icons.alt_route,
              ),
              arrow(kViolet, caption: 'IPC'),
              pipelineNode(
                title: 'Flutter Engine',
                role: 'Bridges Dart <-> host',
                color: kSlate,
                light: kSlateLight,
                icon: Icons.memory,
              ),
              arrow(kSlate, caption: 'dispatch'),
              pipelineNode(
                title: 'Host Plugin',
                role: 'iOS / Android / etc.',
                color: kTeal,
                light: kTealLight,
                icon: Icons.devices,
              ),
              arrow(kTeal, caption: 'reply'),
              pipelineNode(
                title: 'Result Envelope',
                role: 'success / error',
                color: kEmerald,
                light: kEmeraldLight,
                icon: Icons.check_circle,
              ),
            ],
          ),
          gap(14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBorderSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('TIMELINE'),
                gap(6),
                mono(
                  't0  Framework: channel.invokeMethod("getBattery", null)\n'
                  't1  Codec:     encodeMethodCall(MethodCall(...))\n'
                  't2  Messenger: send("plugin/battery", ByteData(13))\n'
                  't3  Engine:    forward to platform thread\n'
                  't4  Host:      decode -> dispatch -> compute(87)\n'
                  't5  Host:      encodeSuccessEnvelope(87)\n'
                  't6  Engine:    forward reply to UI thread\n'
                  't7  Codec:     decodeEnvelope(reply) -> 87\n'
                  't8  Framework: Future<int> completes with 87',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 2 — MethodChannel
// =============================================================================

Widget section2MethodChannel() {
  // Constructed only to exhibit shape; not invoked.
  final demoMethod = const MethodChannel('com.example.tom/battery');
  final demoOptional = const OptionalMethodChannel('com.example.tom/optional');
  final jsonMethod = const MethodChannel(
    'com.example.tom/json',
    JSONMethodCodec(),
  );

  return sectionFrame(
    index: '02',
    title: 'MethodChannel and OptionalMethodChannel',
    subtitle: 'One channel, many methods, encoded as MethodCall envelopes',
    bandGradient: gradient(kIndigo, kViolet),
    accent: kIndigo,
    accentLight: kIndigoLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'A MethodChannel multiplexes any number of named methods over a '
          'single channel string. The codec — by default StandardMethodCodec '
          '— packages each call as an envelope of (method, arguments) and '
          'each reply as a tagged success or error envelope. The optional '
          'variant simply suppresses MissingPluginException when no handler '
          'is registered, returning null instead. Pick OptionalMethodChannel '
          'for plugins that may or may not be present on the current host '
          'platform.',
        ),
        paragraph(
          'Conceptually, every method exposed by a plugin is a string. The '
          'channel itself never knows about Dart types: it only sees a method '
          'name and a binary blob produced by the codec, plus a binary blob '
          'that comes back. Type safety lives in the wrapper functions you '
          'write on top of the channel, not in the channel itself.',
        ),
        gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _channelCard(demoMethod)),
            hgap(14),
            Expanded(child: _optionalCard(demoOptional)),
          ],
        ),
        gap(14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderSoft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('ALT CONSTRUCTOR WITH EXPLICIT CODEC'),
              gap(6),
              keyValue('name', jsonMethod.name),
              keyValue('codec', jsonMethod.codec.runtimeType.toString()),
              keyValue(
                'envelope',
                'JSON-encoded String -> UTF-8 -> ByteData',
              ),
            ],
          ),
        ),
        gap(14),
        codeCard(
          title: 'plugin/battery_plugin.dart  -  the Dart side',
          '''
class BatteryPlugin {
  static const _channel =
      MethodChannel('com.example.tom/battery');

  /// Returns the current battery level as a percentage.
  /// Throws [PlatformException] if the host call fails.
  Future<int> getBatteryLevel() async {
    final result = await _channel.invokeMethod<int>(
      'getBatteryLevel',
    );
    return result ?? -1;
  }

  /// Listen for handler invocations from the platform side
  /// (rare for MethodChannel; more common with EventChannel).
  void attachHandler() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'onLow':
          return _onLowBattery(call.arguments as Map);
        default:
          throw MissingPluginException('Unhandled: \${call.method}');
      }
    });
  }
}''',
        ),
        gap(14),
        codeCard(
          title: 'BatteryPlugin.kt  -  the Android host handler',
          background: const Color(0xFF1B1B1F),
          '''
class BatteryPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(b: FlutterPluginBinding) {
    channel = MethodChannel(
      b.binaryMessenger,
      "com.example.tom/battery",
    )
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, r: Result) {
    when (call.method) {
      "getBatteryLevel" -> r.success(currentLevel())
      else -> r.notImplemented()
    }
  }
}''',
        ),
        gap(14),
        codeCard(
          title: 'BatteryPlugin.swift  -  the iOS host handler',
          background: const Color(0xFF1E1B2E),
          '''
class BatteryPlugin: NSObject, FlutterPlugin {
  static func register(with r: FlutterPluginRegistrar) {
    let c = FlutterMethodChannel(
      name: "com.example.tom/battery",
      binaryMessenger: r.messenger(),
    )
    let inst = BatteryPlugin()
    r.addMethodCallDelegate(inst, channel: c)
  }

  public func handle(
    _ call: FlutterMethodCall,
    result: @escaping FlutterResult,
  ) {
    switch call.method {
      case "getBatteryLevel":
        result(Self.currentLevel())
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}''',
        ),
        gap(14),
        _CallSimulator(),
      ],
    ),
  );
}

Widget _channelCard(MethodChannel ch) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient(kBlueLight, Colors.white),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBlue.withOpacity(0.35)),
      boxShadow: layeredShadows(kBlue),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: kBlueDark, size: 18),
            hgap(6),
            Text(
              'MethodChannel',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: kBlueDark,
              ),
            ),
            const Spacer(),
            chip('request / response', bg: Colors.white, fg: kBlueDark),
          ],
        ),
        gap(10),
        keyValue('name', ch.name),
        keyValue('codec', ch.codec.runtimeType.toString()),
        keyValue('throws', 'PlatformException, MissingPluginException'),
        keyValue('typical', 'getBatteryLevel, getDeviceId, openSettings'),
      ],
    ),
  );
}

Widget _optionalCard(OptionalMethodChannel ch) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient(kIndigoLight, Colors.white),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kIndigo.withOpacity(0.35)),
      boxShadow: layeredShadows(kIndigo),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.help_outline, color: kIndigoDark, size: 18),
            hgap(6),
            Text(
              'OptionalMethodChannel',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: kIndigoDark,
              ),
            ),
            const Spacer(),
            chip('null-on-miss', bg: Colors.white, fg: kIndigoDark),
          ],
        ),
        gap(10),
        keyValue('name', ch.name),
        keyValue('codec', ch.codec.runtimeType.toString()),
        keyValue('throws', 'PlatformException only'),
        keyValue('typical', 'feature probes, optional plugins'),
      ],
    ),
  );
}

class _CallSimulator extends StatelessWidget {
  const _CallSimulator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorderSoft),
        boxShadow: layeredShadows(kIndigoLight),
      ),
      child: StatefulBuilder(
        builder: (context, setStateSB) {
          final logs = <_FakeLogEntry>[
            _FakeLogEntry(
              method: 'getBatteryLevel',
              args: 'null',
              status: 'success',
              result: '87',
              latency: '11.4ms',
            ),
          ];
          var selected = 0;
          final scenarios = <_Scenario>[
            _Scenario(
              label: 'success',
              color: kEmerald,
              method: 'getBatteryLevel',
              args: 'null',
              status: 'success',
              result: '87',
              latency: '11.4ms',
            ),
            _Scenario(
              label: 'error',
              color: kRose,
              method: 'openSettings',
              args: '{section: "privacy"}',
              status: 'error',
              result: 'PlatformException(UNAVAILABLE)',
              latency: '8.2ms',
            ),
            _Scenario(
              label: 'not-implemented',
              color: kAmber,
              method: 'unknownThing',
              args: 'null',
              status: 'not-implemented',
              result: 'MissingPluginException',
              latency: '6.7ms',
            ),
          ];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.terminal, color: kIndigoDark, size: 18),
                  hgap(6),
                  Text(
                    'Mock invocation log (renders only; never crosses engine)',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: kInk,
                    ),
                  ),
                ],
              ),
              gap(10),
              Wrap(
                spacing: 8,
                children: [
                  for (var i = 0; i < scenarios.length; i++)
                    _ScenarioButton(
                      label: scenarios[i].label,
                      color: scenarios[i].color,
                      selected: selected == i,
                      onTap: () {
                        setStateSB(() {
                          selected = i;
                          logs.insert(
                            0,
                            _FakeLogEntry(
                              method: scenarios[i].method,
                              args: scenarios[i].args,
                              status: scenarios[i].status,
                              result: scenarios[i].result,
                              latency: scenarios[i].latency,
                            ),
                          );
                        });
                      },
                    ),
                ],
              ),
              gap(10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1220),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final entry in logs.take(4)) _logRow(entry),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _logRow(_FakeLogEntry e) {
    Color tint;
    switch (e.status) {
      case 'success':
        tint = const Color(0xFF34D399);
        break;
      case 'error':
        tint = const Color(0xFFF87171);
        break;
      default:
        tint = const Color(0xFFFBBF24);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(
              '${e.latency.padRight(8)} ${e.method.padRight(20)} '
              'args=${e.args.padRight(28)} -> ${e.result}',
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Scenario {
  const _Scenario({
    required this.label,
    required this.color,
    required this.method,
    required this.args,
    required this.status,
    required this.result,
    required this.latency,
  });
  final String label;
  final Color color;
  final String method;
  final String args;
  final String status;
  final String result;
  final String latency;
}

class _FakeLogEntry {
  const _FakeLogEntry({
    required this.method,
    required this.args,
    required this.status,
    required this.result,
    required this.latency,
  });
  final String method;
  final String args;
  final String status;
  final String result;
  final String latency;
}

class _ScenarioButton extends StatelessWidget {
  const _ScenarioButton({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color : color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color),
        ),
        child: Text(
          'simulate $label',
          style: TextStyle(
            color: selected ? Colors.white : color,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 3 — BasicMessageChannel<T>
// =============================================================================

Widget section3BasicMessage() {
  final stringMsg = const BasicMessageChannel<String>(
    'com.example.tom/log_line',
    StringCodec(),
  );
  final jsonMsg = const BasicMessageChannel<Object?>(
    'com.example.tom/config_blob',
    JSONMessageCodec(),
  );
  final stdMsg = const BasicMessageChannel<Object?>(
    'com.example.tom/sensor_packet',
    StandardMessageCodec(),
  );
  final binMsg = const BasicMessageChannel<ByteData?>(
    'com.example.tom/audio_buffer',
    BinaryCodec(),
  );

  return sectionFrame(
    index: '03',
    title: 'BasicMessageChannel<T> — typed, codec-driven, bidirectional',
    subtitle: 'When you do not need a method name, only a typed payload',
    bandGradient: gradient(kTealDark, kEmerald),
    accent: kTealDark,
    accentLight: kTealLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'BasicMessageChannel is the most flexible of the three channel '
          'shapes. It carries a single typed payload in each direction and '
          'has no notion of method names. The type parameter T is governed '
          'by the codec: BinaryCodec gives you ByteData?, StringCodec gives '
          'you String, JSON and Standard codecs give you Object? (dynamic). '
          'Use it for streaming structured data that does not fit the '
          'request/response shape of a MethodChannel, such as continuous '
          'sensor readings, audio frames, log lines, or configuration blobs.',
        ),
        paragraph(
          'A BasicMessageChannel is bidirectional in principle: both Dart and '
          'host code can call send and both can register a message handler. '
          'In practice most plugins use only one direction, but the channel '
          'is happy either way. The codec on both sides must match exactly '
          'or decoding will fail with a FormatException-shaped error.',
        ),
        gap(14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _basicCard(
              channel: stringMsg.name,
              tparam: 'String',
              codec: 'StringCodec',
              tint: kTeal,
              light: kTealLight,
              icon: Icons.short_text,
              example: '"app started at 2026-05-11 09:00"',
            ),
            _basicCard(
              channel: jsonMsg.name,
              tparam: 'Object?',
              codec: 'JSONMessageCodec',
              tint: kEmerald,
              light: kEmeraldLight,
              icon: Icons.data_object,
              example: '{"theme": "dark", "scale": 1.25}',
            ),
            _basicCard(
              channel: stdMsg.name,
              tparam: 'Object?',
              codec: 'StandardMessageCodec',
              tint: kIndigo,
              light: kIndigoLight,
              icon: Icons.dataset,
              example: '[1.2, 3.4, Uint8List(8)]',
            ),
            _basicCard(
              channel: binMsg.name,
              tparam: 'ByteData?',
              codec: 'BinaryCodec',
              tint: kSlateDark,
              light: kSlateLight,
              icon: Icons.memory,
              example: 'ByteData(4096)  // raw PCM',
            ),
          ],
        ),
        gap(16),
        codeCard(
          title: 'logger_channel.dart  -  string message channel',
          '''
final logChannel = BasicMessageChannel<String>(
  'com.example.tom/log_line',
  StringCodec(),
);

void emit(String line) {
  // fire-and-forget; reply is awaited but ignored
  logChannel.send(line);
}

void listen() {
  logChannel.setMessageHandler((String? message) async {
    debugPrint('host says: \$message');
    return 'ack';
  });
}''',
        ),
      ],
    ),
  );
}

Widget _basicCard({
  required String channel,
  required String tparam,
  required String codec,
  required Color tint,
  required Color light,
  required IconData icon,
  required String example,
}) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient(light, Colors.white),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tint.withOpacity(0.4)),
      boxShadow: layeredShadows(tint),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: tint, size: 18),
            hgap(6),
            Expanded(
              child: Text(
                'BasicMessageChannel<$tparam>',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: tint,
                ),
              ),
            ),
          ],
        ),
        gap(10),
        keyValue('channel', channel),
        keyValue('codec', codec),
        keyValue('T', tparam),
        gap(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1220),
            borderRadius: BorderRadius.circular(8),
          ),
          child: mono(example, color: const Color(0xFFE2E8F0)),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 4 — EventChannel
// =============================================================================

Widget section4EventChannel() {
  final ec = const EventChannel('com.example.tom/sensor_stream');

  return sectionFrame(
    index: '04',
    title: 'EventChannel — the platform-pushed stream',
    subtitle: 'Subscribe once, receive events until you cancel',
    bandGradient: gradient(kVioletDark, kViolet),
    accent: kViolet,
    accentLight: kVioletLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'An EventChannel inverts the flow of control. Dart subscribes with '
          'a special listen message, and from then on the host pushes events '
          'whenever it likes — accelerometer readings, GPS fixes, BLE '
          'advertisements, network state changes. Under the hood the engine '
          'multiplexes three different envelope shapes over the channel name: '
          'listen, cancel, and event. From the framework\'s perspective it '
          'looks like a plain stream of typed values.',
        ),
        paragraph(
          'The host side implements StreamHandler (or its platform-specific '
          'equivalent) and pushes events by calling success or error on the '
          'event sink. EventChannel guarantees ordering per channel name but '
          'does not buffer arbitrarily: if the Dart side stops draining the '
          'stream, the host can choose to drop, queue, or pause.',
        ),
        gap(14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: gradient(kVioletLight, Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kViolet.withOpacity(0.35)),
            boxShadow: layeredShadows(kViolet),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sensors, color: kVioletDark, size: 18),
                  hgap(6),
                  Text(
                    'EventChannel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: kVioletDark,
                    ),
                  ),
                  const Spacer(),
                  chip('stream', bg: Colors.white, fg: kVioletDark),
                ],
              ),
              gap(10),
              keyValue('name', ec.name),
              keyValue('codec', ec.codec.runtimeType.toString()),
              keyValue('typical', 'sensors, BLE, network connectivity'),
            ],
          ),
        ),
        gap(14),
        _EventTimeline(),
        gap(14),
        codeCard(
          title: 'sensor_channel.dart  -  receiveBroadcastStream',
          '''
const _events =
    EventChannel('com.example.tom/sensor_stream');

Stream<SensorPacket> get sensorPackets {
  return _events
      .receiveBroadcastStream()
      .map((dynamic event) {
        final m = (event as Map).cast<String, Object?>();
        return SensorPacket(
          ts: m['ts'] as int,
          accelX: (m['x'] as num).toDouble(),
          accelY: (m['y'] as num).toDouble(),
          accelZ: (m['z'] as num).toDouble(),
        );
      });
}''',
        ),
      ],
    ),
  );
}

class _EventTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderSoft),
      ),
      child: StatefulBuilder(
        builder: (context, setStateSB) {
          var ticks = 4;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  label('SIMULATED EVENT TICKS'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => setStateSB(() => ticks = (ticks + 1) % 9),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: kViolet,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'tick +1 (fake)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              gap(10),
              Row(
                children: [
                  for (var i = 0; i < 8; i++) ...[
                    Expanded(
                      child: Container(
                        height: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: i < ticks
                              ? kViolet
                              : kViolet.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              gap(8),
              Text(
                'event[$ticks/8] received from "com.example.tom/sensor_stream"',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: kInkSoft,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Section 5 — Channel comparison
// =============================================================================

Widget section5Comparison() {
  return sectionFrame(
    index: '05',
    title: 'Channel triad side-by-side',
    subtitle: 'Pick the shape that fits the flow of data',
    bandGradient: gradient(kAmberDark, kAmber),
    accent: kAmberDark,
    accentLight: kAmberLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'The three channel shapes are not interchangeable. MethodChannel is '
          'the workhorse for one-shot calls where the framework actively asks '
          'the host to do a thing and waits for an answer. BasicMessageChannel '
          'is for streaming or peer-to-peer messages where there is no method '
          'name — only a typed payload. EventChannel is for long-lived '
          'subscriptions where the host emits events without being asked, and '
          'the framework simply listens.',
        ),
        paragraph(
          'When mapping a feature to a channel, ask yourself two questions: '
          'who initiates each message, and how many replies are there per '
          'request? One-to-one ask/answer is a MethodChannel. Many-to-one or '
          'one-to-many is a BasicMessageChannel. Subscribe-and-listen is an '
          'EventChannel. Picking wrong leads to leaky abstractions and '
          'awkward fan-out logic on both sides of the bridge.',
        ),
        gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _shapeCard(
              icon: Icons.swap_horiz,
              title: 'MethodChannel',
              cap: 'request -> response',
              tint: kBlue,
              light: kBlueLight,
              points: [
                'invokeMethod(name, args) -> Future<T>',
                'Tagged success/error envelope on the wire.',
                'Throws PlatformException on host error.',
                'Throws MissingPluginException when no handler.',
                'Best for actions: read battery, open URL, sign in.',
              ],
            )),
            hgap(10),
            Expanded(child: _shapeCard(
              icon: Icons.compare_arrows,
              title: 'BasicMessageChannel<T>',
              cap: 'typed payload either way',
              tint: kTeal,
              light: kTealLight,
              points: [
                'send(message) -> Future<T>',
                'No method name; payload type follows codec.',
                'Codec-bound: String, Object?, ByteData?.',
                'Both sides may setMessageHandler.',
                'Best for streams of records: logs, sensor frames.',
              ],
            )),
            hgap(10),
            Expanded(child: _shapeCard(
              icon: Icons.sensors,
              title: 'EventChannel',
              cap: 'subscribe -> events',
              tint: kViolet,
              light: kVioletLight,
              points: [
                'receiveBroadcastStream() -> Stream<dynamic>',
                'Implicit listen / cancel envelopes.',
                'Host pushes events at its own rate.',
                'Errors surface on the stream as PlatformException.',
                'Best for sensors, GPS, connectivity, BLE.',
              ],
            )),
          ],
        ),
        gap(16),
        label('DECISION MATRIX — flow vs channel shape', color: kAmberDark),
        gap(8),
        table(
          headers: const [
            'Use case',
            'Initiator',
            'Replies',
            'Best channel',
          ],
          rows: const [
            ['Read battery level once', 'framework', '1', 'MethodChannel'],
            ['Open native settings', 'framework', '1 ok', 'MethodChannel'],
            ['Probe optional feature', 'framework', '0..1', 'OptionalMethodChannel'],
            ['Stream sensor packets', 'host', 'N', 'EventChannel'],
            ['Push diagnostic logs', 'framework', '0..N', 'BasicMessageChannel<String>'],
            ['Sync key/value config', 'either', '1 each', 'BasicMessageChannel<Object?>'],
            ['Transport raw audio frames', 'either', 'N', 'BasicMessageChannel<ByteData?>'],
            ['Listen for connectivity', 'host', 'N', 'EventChannel'],
          ],
        ),
      ],
    ),
  );
}

Widget _shapeCard({
  required IconData icon,
  required String title,
  required String cap,
  required Color tint,
  required Color light,
  required List<String> points,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient(light, Colors.white),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tint.withOpacity(0.4)),
      boxShadow: layeredShadows(tint),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            hgap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: tint,
                    ),
                  ),
                  Text(
                    cap,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: kInkMute,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        gap(8),
        for (final p in points) bullet(p, tint: tint),
      ],
    ),
  );
}

// =============================================================================
// Section 6 — Codecs
// =============================================================================

Widget section6Codecs() {
  // Construct codec instances to exhibit their types.
  const binary = BinaryCodec();
  const string = StringCodec();
  const json = JSONMessageCodec();
  const standard = StandardMessageCodec();
  const jsonMethod = JSONMethodCodec();
  const standardMethod = StandardMethodCodec();

  return sectionFrame(
    index: '06',
    title: 'Codecs — the wire format choice',
    subtitle: 'Same channel API, very different bytes on the line',
    bandGradient: gradient(kEmeraldDark, kEmerald),
    accent: kEmeraldDark,
    accentLight: kEmeraldLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'A codec is the translator that turns Dart values into bytes a host '
          'language can read, and vice versa. Flutter ships four message '
          'codecs and two method codecs. Message codecs are for raw payloads; '
          'method codecs add an outer envelope describing whether the message '
          'is a method call, a success reply, or an error reply.',
        ),
        paragraph(
          'The default everywhere is StandardMethodCodec for MethodChannel '
          'and StandardMessageCodec for BasicMessageChannel and EventChannel. '
          'It is binary, compact, and supports every Flutter-friendly Dart '
          'type including typed-data lists. JSON codecs are great for '
          'interop with non-Flutter platforms but cannot carry binary data '
          'natively. String and Binary are the lowest level: choose them '
          'when you already speak a custom protocol on top.',
        ),
        gap(14),
        pillRow([
          chip(
            'BinaryCodec  ->  ByteData?',
            bg: kSlateLight,
            fg: kSlateDark,
          ),
          chip(
            'StringCodec  ->  String',
            bg: kBlueLight,
            fg: kBlueDark,
          ),
          chip(
            'JSONMessageCodec  ->  Object?',
            bg: kAmberLight,
            fg: kAmberDark,
          ),
          chip(
            'StandardMessageCodec  ->  Object?',
            bg: kEmeraldLight,
            fg: kEmeraldDark,
          ),
          chip(
            'JSONMethodCodec  ->  MethodCall envelope',
            bg: kVioletLight,
            fg: kVioletDark,
          ),
          chip(
            'StandardMethodCodec  ->  MethodCall envelope',
            bg: kTealLight,
            fg: kTealDark,
          ),
        ]),
        gap(16),
        table(
          headers: const [
            'Codec',
            'Dart type',
            'Wire',
            'Binary safe',
            'Cross-platform',
          ],
          rows: [
            [
              binary.runtimeType.toString(),
              'ByteData?',
              'identity bytes',
              'yes',
              'yes',
            ],
            [
              string.runtimeType.toString(),
              'String',
              'UTF-8 bytes',
              'no',
              'yes',
            ],
            [
              json.runtimeType.toString(),
              'Object?',
              'UTF-8 of jsonEncode',
              'no',
              'yes (every lang)',
            ],
            [
              standard.runtimeType.toString(),
              'Object?',
              'type-tagged binary',
              'yes',
              'flutter only',
            ],
            [
              jsonMethod.runtimeType.toString(),
              'MethodCall',
              'JSON of {method,args}',
              'no',
              'yes',
            ],
            [
              standardMethod.runtimeType.toString(),
              'MethodCall',
              'binary envelope',
              'yes',
              'flutter only',
            ],
          ],
        ),
        gap(14),
        codeCard(
          title: 'Choosing a codec',
          background: const Color(0xFF0B132B),
          '''
// Default (recommended for most plugins):
const channel = MethodChannel('com.example.tom/x');
// equivalent to:
const channelExplicit = MethodChannel(
  'com.example.tom/x',
  StandardMethodCodec(),
);

// JSON for non-Flutter peers (e.g. webview, custom embedder):
const jsonChannel = MethodChannel(
  'com.example.tom/x',
  JSONMethodCodec(),
);

// Raw bytes (your protocol on top of the channel):
const audio = BasicMessageChannel<ByteData?>(
  'com.example.tom/audio',
  BinaryCodec(),
);''',
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 7 — MethodCall envelope and wire-format mockup
// =============================================================================

Widget section7Envelope() {
  // Construct a MethodCall purely to exhibit its shape; do not encode at run
  // time (the resulting ByteData is opaque and uninteresting to inspect on
  // every rebuild, and we want this to be a static diagram anyway).
  const call = MethodCall('getBatteryLevel', <String, Object?>{
    'deviceId': 'tom-01',
    'detailed': true,
  });

  return sectionFrame(
    index: '07',
    title: 'MethodCall envelope and wire format',
    subtitle: 'What actually moves between Dart and the engine',
    bandGradient: gradient(kRoseDark, kRose),
    accent: kRoseDark,
    accentLight: kRoseLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Every call on a MethodChannel becomes a MethodCall value — just a '
          'pair of (method, arguments) — and is then wrapped in an envelope '
          'by the codec before crossing the engine. The reply is another '
          'envelope: a success envelope holds a single result value, an '
          'error envelope holds a code plus optional message and details. '
          'A third envelope shape signals "method not implemented" so the '
          'framework can raise MissingPluginException without a generic '
          'PlatformException.',
        ),
        paragraph(
          'The hex below is a synthetic — but realistic — StandardMethodCodec '
          'mockup for the call constructed in this section. It is intended '
          'to make the abstract "ByteData" concrete: tag bytes, length '
          'prefixes, UTF-8 strings, and value markers. The actual codec '
          'implementation is in package:flutter/src/services/message_codecs.dart.',
        ),
        gap(14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: gradient(kRoseLight, Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kRose.withOpacity(0.4)),
            boxShadow: layeredShadows(kRose),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.markunread_mailbox, color: kRoseDark, size: 18),
                  hgap(6),
                  Text(
                    'MethodCall envelope',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: kRoseDark,
                    ),
                  ),
                ],
              ),
              gap(8),
              keyValue('method', '"${call.method}"'),
              keyValue(
                'arguments',
                '{deviceId: "tom-01", detailed: true}',
              ),
              keyValue('codec', 'StandardMethodCodec (default)'),
              keyValue('reply on success', '[0x00, encoded result]'),
              keyValue(
                'reply on error',
                '[0x01, code, message?, details?]',
              ),
              keyValue('reply on not impl', '[]  (empty ByteData)'),
            ],
          ),
        ),
        gap(14),
        codeCard(
          title: 'Pseudo wire format (hex) — synthetic StandardMethodCodec',
          background: const Color(0xFF0A0E1A),
          foreground: const Color(0xFFE0F2FE),
          '''
# encodeMethodCall(MethodCall("getBatteryLevel", {...}))
# byte stream, big-endian where relevant:

07                          # tag: String  (the method name)
0F                          # length prefix: 15 bytes
67 65 74 42 61 74 74 65     # "getBatte"
72 79 4C 65 76 65 6C        # "ryLevel"

0D                          # tag: Map<Object?, Object?>
02                          # entry count: 2

  07                        # tag: String  (key "deviceId")
  08                        # length: 8
  64 65 76 69 63 65 49 64   # "deviceId"

  07                        # tag: String  (value "tom-01")
  06                        # length: 6
  74 6F 6D 2D 30 31         # "tom-01"

  07                        # tag: String  (key "detailed")
  08                        # length: 8
  64 65 74 61 69 6C 65 64   # "detailed"

  01                        # tag: true   (value)

# reply on success:
00 04 01 02 03 04           # 0x00 + encoded result

# reply on error:
01                          # 0x01 envelope tag
07 09 55 4E 41 56 41 49 4C  # "UNAVAIL"  (error code)
07 0F 53 65 72 76 69 63 65  # "Service "  (message)
20 75 6E 61 76 61 69 6C 61  # "unavaila"
62 6C 65                    # "ble"
00                          # null details''',
        ),
        gap(14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderSoft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('STANDARD CODEC TAG REFERENCE', color: kRoseDark),
              gap(8),
              mono(
                '0x00  null        0x01  true        0x02  false\n'
                '0x03  int32       0x04  int64       0x05  large int (str)\n'
                '0x06  float64     0x07  String      0x08  Uint8List\n'
                '0x09  Int32List   0x0A  Int64List   0x0B  Float64List\n'
                '0x0C  List        0x0D  Map         0x0E  Float32List\n',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 8 — Exceptions and palette
// =============================================================================

Widget section8Exceptions() {
  final pex = PlatformException(
    code: 'UNAVAILABLE',
    message: 'Battery service unavailable',
    details: <String, Object?>{
      'reason': 'timeout',
      'retryAfter': 5,
    },
    stacktrace: 'at BatteryPlugin.getBatteryLevel (BatteryPlugin.kt:42)',
  );
  final mex = MissingPluginException(
    'No implementation found for method getBatteryLevel '
    'on channel com.example.tom/battery',
  );

  return sectionFrame(
    index: '08',
    title: 'Errors, exceptions, and the palette of concepts',
    subtitle: 'PlatformException, MissingPluginException, and a recap wrap',
    bandGradient: gradient(kSlateDark, kSlate),
    accent: kSlateDark,
    accentLight: kSlateLight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraph(
          'Errors crossing a platform channel arrive as one of two things. '
          'If the host reported a structured error envelope, the framework '
          'reconstructs it as a PlatformException with code, message, '
          'details, and stacktrace fields. If the host had no handler '
          'registered (or returned the not-implemented sentinel) and the '
          'channel was not an OptionalMethodChannel, the framework throws '
          'MissingPluginException instead.',
        ),
        paragraph(
          'Both exceptions are catchable like any Dart exception. The '
          'standard pattern is to wrap invokeMethod in a try/catch, surface '
          'a typed domain error to the rest of the app, and let the platform '
          'plumbing stay invisible above the plugin boundary. The cards '
          'below render the example exceptions constructed in this section.',
        ),
        gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _exceptionCard(
              icon: Icons.error_outline,
              title: 'PlatformException',
              tint: kRose,
              light: kRoseLight,
              rows: [
                ['code', pex.code],
                ['message', pex.message ?? ''],
                ['details', pex.details.toString()],
                ['stacktrace', pex.stacktrace ?? ''],
              ],
            )),
            hgap(14),
            Expanded(child: _exceptionCard(
              icon: Icons.extension_off,
              title: 'MissingPluginException',
              tint: kAmber,
              light: kAmberLight,
              rows: [
                ['message', mex.message ?? ''],
                ['typical cause', 'plugin not registered on this OS'],
                ['mitigation', 'use OptionalMethodChannel'],
              ],
            )),
          ],
        ),
        gap(14),
        codeCard(
          title: 'try/catch around invokeMethod',
          '''
try {
  final level = await _channel.invokeMethod<int>('getBatteryLevel');
  emit(BatteryLevel(level ?? -1));
} on PlatformException catch (e) {
  log.warn('host rejected: \${e.code} :: \${e.message}');
  emit(BatteryLevel.unavailable(reason: e.code));
} on MissingPluginException {
  // OS does not expose battery level via plugin
  emit(BatteryLevel.unsupported());
}''',
        ),
        gap(14),
        label('PALETTE — concepts visited in this file', color: kSlateDark),
        gap(8),
        pillRow([
          chip('channel name', bg: kBlueLight, fg: kBlueDark),
          chip('binary messenger', bg: kIndigoLight, fg: kIndigoDark),
          chip('codec', bg: kEmeraldLight, fg: kEmeraldDark),
          chip('envelope', bg: kAmberLight, fg: kAmberDark),
          chip('method', bg: kBlueLight, fg: kBlueDark),
          chip('arguments', bg: kBlueLight, fg: kBlueDark),
          chip('reply success', bg: kTealLight, fg: kTealDark),
          chip('reply error', bg: kRoseLight, fg: kRoseDark),
          chip('not implemented', bg: kSlateLight, fg: kSlateDark),
          chip('listen sub-envelope', bg: kVioletLight, fg: kVioletDark),
          chip('cancel sub-envelope', bg: kVioletLight, fg: kVioletDark),
          chip('event sub-envelope', bg: kVioletLight, fg: kVioletDark),
          chip('UTF-8', bg: kEmeraldLight, fg: kEmeraldDark),
          chip('typed-data tag', bg: kEmeraldLight, fg: kEmeraldDark),
          chip('PlatformException', bg: kRoseLight, fg: kRoseDark),
          chip('MissingPluginException', bg: kRoseLight, fg: kRoseDark),
          chip('OptionalMethodChannel', bg: kIndigoLight, fg: kIndigoDark),
          chip('host plugin', bg: kTealLight, fg: kTealDark),
          chip('engine relay', bg: kSlateLight, fg: kSlateDark),
          chip('Dart isolate', bg: kBlueLight, fg: kBlueDark),
        ]),
        gap(14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: gradient(kSlateLight, Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kSlate.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('TAKEAWAYS', color: kSlateDark),
              gap(8),
              bullet(
                'MethodChannel multiplexes named methods over one channel '
                'name; defaults to StandardMethodCodec.',
                tint: kBlueDark,
              ),
              bullet(
                'BasicMessageChannel<T> carries a single typed payload '
                'either way; T follows the codec.',
                tint: kTealDark,
              ),
              bullet(
                'EventChannel inverts control: the host pushes events; '
                'subscribe via receiveBroadcastStream.',
                tint: kVioletDark,
              ),
              bullet(
                'Codecs decide the wire format; methods need a *MethodCodec, '
                'plain payloads use a *MessageCodec.',
                tint: kEmeraldDark,
              ),
              bullet(
                'Errors arrive as PlatformException or MissingPluginException; '
                'OptionalMethodChannel suppresses the latter.',
                tint: kRoseDark,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _exceptionCard({
  required IconData icon,
  required String title,
  required Color tint,
  required Color light,
  required List<List<String>> rows,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient(light, Colors.white),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tint.withOpacity(0.4)),
      boxShadow: layeredShadows(tint),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: tint, size: 18),
            hgap(6),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: tint,
              ),
            ),
          ],
        ),
        gap(8),
        for (final r in rows) keyValue(r[0], r[1], tint: tint),
      ],
    ),
  );
}

// =============================================================================
// Footer
// =============================================================================

Widget pageFooter() {
  return Container(
    margin: const EdgeInsets.only(top: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(18),
      boxShadow: layeredShadows(kSlateDark),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt, color: kAmberLight, size: 18),
            hgap(8),
            const Text(
              'platform_channels_test.dart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        gap(8),
        Text(
          'Hand-authored deep visual demo. No channel is actually invoked: '
          'every payload, log line, and reply on this page is fabricated for '
          'rendering. Use it as a quick reference for the channel shapes, '
          'codecs, and exceptions exposed by package:flutter/services.dart.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 12.5,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Entry point used by the d4rt flutter_ast harness
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Platform Channels Deep Demo',
    theme: ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      scaffoldBackgroundColor: kPaper,
      primaryColor: kIndigoDark,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              pageHeader(),
              section1Pipeline(),
              section2MethodChannel(),
              section3BasicMessage(),
              section4EventChannel(),
              section5Comparison(),
              section6Codecs(),
              section7Envelope(),
              section8Exceptions(),
              pageFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
