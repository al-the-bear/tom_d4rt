// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================================================================
// SELECT WORD SELECTION EVENT - Deep Demo
// ============================================================================
//
// SelectWordSelectionEvent is a concrete subclass of SelectionEvent in
// Flutter's rendering-layer selection system. It instructs Selectables to
// select the WORD that contains a given screen-space (global) position --
// the canonical use case being a long-press or double-tap landing on a
// piece of text inside a SelectionArea.
//
// API shape (flutter/rendering.dart):
//
//   class SelectWordSelectionEvent extends SelectionEvent {
//     SelectWordSelectionEvent({required this.globalPosition});
//     final Offset globalPosition;
//     // type => SelectionEventType.selectWord
//   }
//
// Flutter's selection event hierarchy:
//
//   SelectionEvent (abstract)
//   |-- ClearSelectionEvent
//   |-- SelectAllSelectionEvent
//   |-- SelectWordSelectionEvent           <-- this demo
//   |-- SelectParagraphSelectionEvent
//   |-- SelectionEdgeUpdateEvent
//   |-- GranularlyExtendSelectionEvent
//   `-- DirectionallyExtendSelectionEvent
//
// Color theme : Indigo / Teal / Amber
// Helper prefix: _sw
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _swIndigo = Color(0xFF3F51B5);
const Color _swDeepIndigo = Color(0xFF283593);
const Color _swLightIndigo = Color(0xFF7986CB);
const Color _swTeal = Color(0xFF00897B);
const Color _swDeepTeal = Color(0xFF004D40);
const Color _swLightTeal = Color(0xFF4DB6AC);
const Color _swAmber = Color(0xFFFFB300);
const Color _swDeepAmber = Color(0xFFE65100);
const Color _swLightAmber = Color(0xFFFFE082);
const Color _swCream = Color(0xFFFFFDF7);
const Color _swCharcoal = Color(0xFF263238);
const Color _swSlate = Color(0xFF455A64);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _swSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 28.0, bottom: 12.0),
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swDeepIndigo.withValues(alpha: 0.95),
          _swIndigo.withValues(alpha: 0.85),
          _swTeal.withValues(alpha: 0.75),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: _swDeepIndigo.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white.withValues(alpha: 0.88),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _swCodeBox(String code, {Color accent = _swLightTeal}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _swCharcoal,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        height: 1.45,
        color: accent,
      ),
    ),
  );
}

Widget _swPropertyRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _swSlate,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: valueColor ?? _swCharcoal,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swPill(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _swCoordinateGrid(Offset position, {double width = 240.0, double height = 140.0}) {
  // Map the position into a 0..1 normalized space for visualization.
  // We use a wide visual range so far-off-screen and negative values still
  // produce a sensible rendering.
  const double rangeMin = -200.0;
  const double rangeMax = 1500.0;
  final double nx = ((position.dx - rangeMin) / (rangeMax - rangeMin)).clamp(0.02, 0.98);
  final double ny = ((position.dy - rangeMin) / (rangeMax - rangeMin)).clamp(0.02, 0.98);

  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swDeepIndigo.withValues(alpha: 0.92),
          _swCharcoal.withValues(alpha: 0.95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _swLightIndigo.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Stack(
      children: [
        // Vertical grid lines
        for (int i = 1; i < 6; i++)
          Positioned(
            left: (width / 6.0) * i,
            top: 0.0,
            bottom: 0.0,
            child: Container(
              width: 1.0,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
        // Horizontal grid lines
        for (int i = 1; i < 4; i++)
          Positioned(
            top: (height / 4.0) * i,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 1.0,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
        // Origin marker
        Positioned(
          left: ((0.0 - rangeMin) / (rangeMax - rangeMin)).clamp(0.0, 1.0) * width - 4.0,
          top: ((0.0 - rangeMin) / (rangeMax - rangeMin)).clamp(0.0, 1.0) * height - 4.0,
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: _swLightAmber,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _swAmber.withValues(alpha: 0.7),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
        // Position dot
        Positioned(
          left: nx * width - 7.0,
          top: ny * height - 7.0,
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: _swLightTeal,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: _swTeal.withValues(alpha: 0.85),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        // Crosshair X label
        Positioned(
          left: 6.0,
          bottom: 4.0,
          child: Text(
            'x: ${position.dx.toStringAsFixed(1)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: _swLightTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          right: 6.0,
          top: 4.0,
          child: Text(
            'y: ${position.dy.toStringAsFixed(1)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: _swLightTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swInstanceCard({
  required int index,
  required String title,
  required String description,
  required SelectWordSelectionEvent event,
  required Color accent,
}) {
  final Offset p = event.globalPosition;
  return Container(
    width: 320.0,
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          accent.withValues(alpha: 0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header strip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.95),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _swSlate,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10.0),
              _swCoordinateGrid(p, width: 296.0, height: 120.0),
              const SizedBox(height: 10.0),
              // Code box rendering the actual constructor call.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _swCharcoal,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'SelectWordSelectionEvent(\n'
                  '  globalPosition: Offset(${p.dx}, ${p.dy}),\n'
                  ');\n'
                  '// type: ${event.type}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    height: 1.45,
                    color: accent.withValues(alpha: 0.95),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  _swPill('dx ${p.dx.toStringAsFixed(1)}', _swIndigo),
                  const SizedBox(width: 6.0),
                  _swPill('dy ${p.dy.toStringAsFixed(1)}', _swTeal),
                  const SizedBox(width: 6.0),
                  _swPill('selectWord', _swAmber),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _swEnumRow({
  required SelectionEventType type,
  required String summary,
  required IconData icon,
  required Color color,
  bool highlight = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: highlight
          ? _swAmber.withValues(alpha: 0.18)
          : Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: highlight
            ? _swDeepAmber.withValues(alpha: 0.7)
            : color.withValues(alpha: 0.35),
        width: highlight ? 1.6 : 1.0,
      ),
    ),
    child: Row(
      children: [
        Icon(icon, size: 22.0, color: color),
        const SizedBox(width: 12.0),
        SizedBox(
          width: 240.0,
          child: Text(
            'SelectionEventType.${type.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: highlight ? _swDeepAmber : _swCharcoal,
            ),
          ),
        ),
        Expanded(
          child: Text(
            summary,
            style: TextStyle(
              fontSize: 12.0,
              color: _swSlate,
              height: 1.35,
            ),
          ),
        ),
        if (highlight) _swPill('THIS DEMO', _swDeepAmber),
      ],
    ),
  );
}

Widget _swLifecycleStep({
  required int n,
  required String title,
  required String body,
  required IconData icon,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.02),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.65)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.45),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            '$n',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 18.0),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _swCharcoal,
                  height: 1.42,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _swComparisonCard({
  required String name,
  required String purpose,
  required String trigger,
  required String payload,
  required Color color,
  required IconData icon,
  bool highlight = false,
}) {
  return Container(
    width: 250.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: highlight
            ? [
                _swAmber.withValues(alpha: 0.20),
                _swDeepAmber.withValues(alpha: 0.10),
              ]
            : [
                color.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0.85),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: highlight
            ? _swDeepAmber.withValues(alpha: 0.85)
            : color.withValues(alpha: 0.55),
        width: highlight ? 2.0 : 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: (highlight ? _swDeepAmber : color).withValues(alpha: 0.22),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: highlight ? _swDeepAmber : color, size: 24.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: highlight ? _swDeepAmber : color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Purpose',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: _swSlate,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          purpose,
          style: TextStyle(fontSize: 12.0, color: _swCharcoal, height: 1.35),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Trigger',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: _swSlate,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          trigger,
          style: TextStyle(fontSize: 12.0, color: _swCharcoal, height: 1.35),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Payload',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: _swSlate,
            letterSpacing: 0.5,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: _swCharcoal,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            payload,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: highlight ? _swLightAmber : _swLightTeal,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swFootgun({
  required int n,
  required String title,
  required String detail,
  required IconData icon,
}) {
  return Container(
    width: 360.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swDeepAmber.withValues(alpha: 0.10),
          _swAmber.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _swDeepAmber.withValues(alpha: 0.55), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: _swDeepAmber.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _swDeepAmber.withValues(alpha: 0.18),
            border: Border.all(color: _swDeepAmber, width: 1.4),
          ),
          child: Icon(icon, color: _swDeepAmber, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: _swDeepAmber,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'F$n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: _swDeepAmber,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _swCharcoal,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Highlights a single word inside a paragraph by splitting on the target.
List<TextSpan> _swSplitHighlight(String paragraph, String word) {
  final List<TextSpan> spans = <TextSpan>[];
  final int idx = paragraph.toLowerCase().indexOf(word.toLowerCase());
  if (idx < 0) {
    spans.add(TextSpan(text: paragraph));
    return spans;
  }
  if (idx > 0) {
    spans.add(TextSpan(text: paragraph.substring(0, idx)));
  }
  spans.add(
    TextSpan(
      text: paragraph.substring(idx, idx + word.length),
      style: TextStyle(
        backgroundColor: _swAmber.withValues(alpha: 0.55),
        color: _swCharcoal,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  if (idx + word.length < paragraph.length) {
    spans.add(TextSpan(text: paragraph.substring(idx + word.length)));
  }
  return spans;
}

// ---------------------------------------------------------------------------
// Build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('SelectWordSelectionEvent Deep Demo executing');

  // ============================================================
  // Build six concrete SelectWordSelectionEvent instances upfront.
  // ============================================================
  final SelectWordSelectionEvent eventTopLeft = SelectWordSelectionEvent(
    globalPosition: const Offset(0.0, 0.0),
  );
  final SelectWordSelectionEvent eventCenter = SelectWordSelectionEvent(
    globalPosition: const Offset(200.0, 200.0),
  );
  final SelectWordSelectionEvent eventEdge = SelectWordSelectionEvent(
    globalPosition: const Offset(1024.0, 768.0),
  );
  final SelectWordSelectionEvent eventSubpixel = SelectWordSelectionEvent(
    globalPosition: const Offset(12.5, 33.7),
  );
  final SelectWordSelectionEvent eventOffscreen = SelectWordSelectionEvent(
    globalPosition: const Offset(5000.0, 5000.0),
  );
  final SelectWordSelectionEvent eventNegative = SelectWordSelectionEvent(
    globalPosition: const Offset(-10.0, -20.0),
  );

  // The "real-world mock" event reused below.
  final SelectWordSelectionEvent eventMock = SelectWordSelectionEvent(
    globalPosition: const Offset(184.0, 96.0),
  );

  print('=== Built ${[
    eventTopLeft,
    eventCenter,
    eventEdge,
    eventSubpixel,
    eventOffscreen,
    eventNegative,
    eventMock,
  ].length} event instances ===');
  print('eventCenter.type = ${eventCenter.type}');
  print('eventCenter.globalPosition = ${eventCenter.globalPosition}');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  final Widget titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swDeepIndigo,
          _swIndigo,
          _swTeal,
          _swDeepTeal,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: _swDeepIndigo.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.55), width: 2.0),
          ),
          child: const Icon(Icons.text_format, size: 56.0, color: Colors.white),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'SelectWordSelectionEvent',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'package:flutter/rendering.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 1.0),
          ),
          child: const Text(
            'Long-press / double-tap -> select containing WORD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  final Widget anatomy = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_swCream, _swLightAmber.withValues(alpha: 0.35)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _swAmber.withValues(alpha: 0.55), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _swAmber.withValues(alpha: 0.22),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: _swDeepAmber, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Class anatomy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: _swDeepAmber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _swCharcoal,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _swLightAmber.withValues(alpha: 0.55), width: 1.0),
          ),
          child: Text(
            'class SelectWordSelectionEvent extends SelectionEvent {\n'
            '  SelectWordSelectionEvent({\n'
            '    required this.globalPosition,\n'
            '  }) : super._(SelectionEventType.selectWord);\n'
            '\n'
            '  final Offset globalPosition;\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
              color: _swLightAmber,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _swIndigo.withValues(alpha: 0.35), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Single field',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: _swDeepIndigo,
                ),
              ),
              const SizedBox(height: 8.0),
              _swPropertyRow('name', 'globalPosition'),
              _swPropertyRow('type', 'Offset', valueColor: _swDeepIndigo),
              _swPropertyRow('nullable', 'false (required)'),
              _swPropertyRow('coordinate space', 'global (screen)'),
              _swPropertyRow('mutability', 'final / immutable'),
              _swPropertyRow('inherited type', 'SelectionEventType.selectWord'),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            _swPill('extends SelectionEvent', _swIndigo),
            const SizedBox(width: 8.0),
            _swPill('selectWord', _swTeal),
            const SizedBox(width: 8.0),
            _swPill('immutable', _swDeepAmber),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Six instance cards
  // ============================================================
  final Widget instanceGrid = Wrap(
    alignment: WrapAlignment.center,
    children: [
      _swInstanceCard(
        index: 1,
        title: 'Origin (top-left)',
        description: 'The screen origin Offset(0, 0). Selecting at this point '
            'targets whatever Selectable is rendered at the very corner.',
        event: eventTopLeft,
        accent: _swIndigo,
      ),
      _swInstanceCard(
        index: 2,
        title: 'Viewport center',
        description: 'A typical mid-screen tap on a paragraph. Word boundary '
            'detection happens locally inside the targeted Selectable.',
        event: eventCenter,
        accent: _swTeal,
      ),
      _swInstanceCard(
        index: 3,
        title: 'Near viewport edge',
        description: 'Approx. bottom-right of a 1024x768 viewport. Useful for '
            'edge-case validation around clipped Selectables.',
        event: eventEdge,
        accent: _swDeepIndigo,
      ),
      _swInstanceCard(
        index: 4,
        title: 'Sub-pixel',
        description: 'Offset uses doubles, so fractional coordinates are first-'
            'class. Hit-testing rounds internally as needed.',
        event: eventSubpixel,
        accent: _swDeepTeal,
      ),
      _swInstanceCard(
        index: 5,
        title: 'Far off-screen',
        description: 'A position outside any rendered Selectable. The event is '
            'still constructible -- handlers simply find no match.',
        event: eventOffscreen,
        accent: _swAmber,
      ),
      _swInstanceCard(
        index: 6,
        title: 'Negative coordinates',
        description: 'Negative Offsets are legal: Flutter does not clamp them. '
            'They model points above / left of the screen origin.',
        event: eventNegative,
        accent: _swDeepAmber,
      ),
    ],
  );

  // ============================================================
  // SECTION 4: SelectionEventType family table
  // ============================================================
  final Widget enumTable = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swCream,
          _swLightIndigo.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _swIndigo.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _swIndigo.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: _swDeepIndigo, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'SelectionEventType family (7 values)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: _swDeepIndigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _swEnumRow(
          type: SelectionEventType.clear,
          summary: 'Clear current selection across all Selectables.',
          icon: Icons.clear,
          color: _swSlate,
        ),
        _swEnumRow(
          type: SelectionEventType.selectAll,
          summary: 'Select every selectable piece of content (Ctrl+A / Cmd+A).',
          icon: Icons.select_all,
          color: _swIndigo,
        ),
        _swEnumRow(
          type: SelectionEventType.selectWord,
          summary: 'Select the WORD containing globalPosition (this demo).',
          icon: Icons.text_fields,
          color: _swDeepAmber,
          highlight: true,
        ),
        _swEnumRow(
          type: SelectionEventType.selectParagraph,
          summary: 'Select the PARAGRAPH containing globalPosition.',
          icon: Icons.subject,
          color: _swTeal,
        ),
        _swEnumRow(
          type: SelectionEventType.granularlyExtendSelection,
          summary: 'Extend by a granularity (character, word, line, document).',
          icon: Icons.swap_horiz,
          color: _swLightIndigo,
        ),
        _swEnumRow(
          type: SelectionEventType.directionallyExtendSelection,
          summary: 'Extend in a TextDirection (left, right, up, down).',
          icon: Icons.compare_arrows,
          color: _swLightTeal,
        ),
        _swEnumRow(
          type: SelectionEventType.endEdgeUpdate,
          summary: 'Drag-update of the trailing edge (paired with start).',
          icon: Icons.east,
          color: _swDeepTeal,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Lifecycle
  // ============================================================
  final Widget lifecycle = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swLightTeal.withValues(alpha: 0.18),
          _swLightIndigo.withValues(alpha: 0.10),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _swTeal.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _swTeal.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: _swDeepTeal, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Selection lifecycle (5 steps)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: _swDeepTeal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _swLifecycleStep(
          n: 1,
          title: 'Long-press / double-tap detected',
          body: 'A gesture recognizer inside SelectionArea (or a custom '
              'GestureDetector) emits a callback carrying the global tap '
              'Offset of the gesture.',
          icon: Icons.touch_app,
          color: _swIndigo,
        ),
        _swLifecycleStep(
          n: 2,
          title: 'SelectionContainer builds the event',
          body: 'The container constructs '
              '"SelectWordSelectionEvent(globalPosition: details.globalPosition)" '
              'as an immutable command object.',
          icon: Icons.build,
          color: _swDeepIndigo,
        ),
        _swLifecycleStep(
          n: 3,
          title: 'Dispatch via SelectionRegistrar',
          body: 'The registrar walks every registered Selectable and forwards '
              'the event to each one through SelectionHandler.dispatchSelectionEvent.',
          icon: Icons.share,
          color: _swTeal,
        ),
        _swLifecycleStep(
          n: 4,
          title: 'Handler resolves containing word',
          body: 'A SelectionHandler (e.g. RenderParagraph) maps globalPosition '
              'to a local TextPosition, finds the locale-aware word boundary, '
              'and updates its internal selection range.',
          icon: Icons.search,
          color: _swDeepTeal,
        ),
        _swLifecycleStep(
          n: 5,
          title: 'Highlight rendered',
          body: 'The Selectable repaints with the new TextSelection, drawing '
              'the selection rect and the platform handles via SelectionOverlay.',
          icon: Icons.brush,
          color: _swDeepAmber,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Real-world mock
  // ============================================================
  const String paragraph =
      'A SelectWordSelectionEvent carries the screen-space Offset of a '
      'long-press, instructing every Selectable in the SelectionArea to '
      'expand the selection to the word containing that point.';
  const String highlightWord = 'Selectable';

  final Widget realWorldMock = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, _swCream],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _swDeepIndigo.withValues(alpha: 0.35), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _swDeepIndigo.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The "selectable text" with the word highlighted.
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _swSlate.withValues(alpha: 0.25), width: 1.0),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SelectableText.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.55,
                      color: _swCharcoal,
                    ),
                    children: _swSplitHighlight(paragraph, highlightWord),
                  ),
                ),
                // Long-press marker (visual only).
                Positioned(
                  left: 168.0,
                  top: 78.0,
                  child: Container(
                    width: 26.0,
                    height: 26.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _swDeepAmber.withValues(alpha: 0.18),
                      border: Border.all(color: _swDeepAmber, width: 2.0),
                      boxShadow: [
                        BoxShadow(
                          color: _swDeepAmber.withValues(alpha: 0.55),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.touch_app,
                      size: 14.0,
                      color: _swDeepAmber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        // Side panel: the constructed event.
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _swDeepIndigo.withValues(alpha: 0.95),
                  _swCharcoal.withValues(alpha: 0.95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _swLightIndigo.withValues(alpha: 0.55), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bolt, color: _swLightAmber, size: 18.0),
                    const SizedBox(width: 6.0),
                    Text(
                      'Constructed event',
                      style: TextStyle(
                        color: _swLightAmber,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  'SelectWordSelectionEvent(\n'
                  '  globalPosition:\n'
                  '    Offset(${eventMock.globalPosition.dx},\n'
                  '           ${eventMock.globalPosition.dy}),\n'
                  ');',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    height: 1.55,
                    color: _swLightTeal,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _swLightAmber.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'type: ${eventMock.type}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: _swLightAmber,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Dispatched -> SelectionRegistrar\n'
                  'Result -> word "$highlightWord" gets highlighted',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: SelectionContainer integration code block
  // ============================================================
  final Widget integrationCode = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _swCream,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _swIndigo.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _swIndigo.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.integration_instructions, color: _swDeepIndigo, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Wiring into SelectionRegistrar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: _swDeepIndigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _swCodeBox(
          '// Inside a custom Selectable / SelectionContainer:\n'
          '\n'
          'GestureDetector(\n'
          '  onLongPressStart: (LongPressStartDetails details) {\n'
          '    final SelectWordSelectionEvent event =\n'
          '        SelectWordSelectionEvent(\n'
          '          globalPosition: details.globalPosition,\n'
          '        );\n'
          '\n'
          '    registrar.handleSelectionEvent(event);\n'
          '  },\n'
          '  child: child,\n'
          ');',
          accent: _swLightTeal,
        ),
        const SizedBox(height: 8.0),
        _swCodeBox(
          '// Custom SelectionHandler reacts to the event:\n'
          '\n'
          '@override\n'
          'SelectionResult dispatchSelectionEvent(SelectionEvent e) {\n'
          '  switch (e.type) {\n'
          '    case SelectionEventType.selectWord:\n'
          '      final SelectWordSelectionEvent w =\n'
          '          e as SelectWordSelectionEvent;\n'
          '      return _selectWordAt(w.globalPosition);\n'
          '    default:\n'
          '      return SelectionResult.none;\n'
          '  }\n'
          '}',
          accent: _swLightAmber,
        ),
        const SizedBox(height: 8.0),
        _swCodeBox(
          '// SelectionArea handles the boilerplate for you:\n'
          '\n'
          'SelectionArea(\n'
          '  child: Text(\n'
          '    "Long-press anywhere to select a single word.",\n'
          '  ),\n'
          ');',
          accent: _swLightIndigo,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Comparison cards
  // ============================================================
  final Widget comparisonCards = Wrap(
    alignment: WrapAlignment.center,
    children: [
      _swComparisonCard(
        name: 'SelectWordSelectionEvent',
        purpose: 'Select the WORD containing a given screen-space point.',
        trigger: 'Long-press / double-tap on text.',
        payload: 'Offset globalPosition',
        color: _swAmber,
        icon: Icons.text_fields,
        highlight: true,
      ),
      _swComparisonCard(
        name: 'SelectAllSelectionEvent',
        purpose: 'Select every Selectable in the registrar tree.',
        trigger: 'Ctrl+A / Cmd+A keyboard shortcut.',
        payload: '(no parameters)',
        color: _swIndigo,
        icon: Icons.select_all,
      ),
      _swComparisonCard(
        name: 'SelectionEdgeUpdateEvent',
        purpose: 'Drag-update one edge (start or end) of the selection range.',
        trigger: 'Selection-handle drag / shift-click.',
        payload: 'Offset globalPosition\nbool granularity',
        color: _swTeal,
        icon: Icons.swap_horiz,
      ),
      _swComparisonCard(
        name: 'SelectParagraphSelectionEvent',
        purpose: 'Select the entire PARAGRAPH containing a global point.',
        trigger: 'Triple-tap on text.',
        payload: 'Offset globalPosition',
        color: _swDeepTeal,
        icon: Icons.subject,
      ),
    ],
  );

  // ============================================================
  // SECTION 9: Coordinate-space caveats
  // ============================================================
  final Widget coordinateCaveats = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swLightIndigo.withValues(alpha: 0.18),
          _swLightTeal.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _swDeepIndigo.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _swDeepIndigo.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.explore, color: _swDeepIndigo, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Coordinate spaces: global vs. local',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: _swDeepIndigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _swIndigo.withValues(alpha: 0.45), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _swPill('GLOBAL', _swIndigo),
                    const SizedBox(height: 8.0),
                    Text(
                      'globalPosition is in screen-space pixels, with origin '
                      'at the top-left of the application window. This is the '
                      'same space as PointerEvent.position and '
                      'GestureDetail.globalPosition.',
                      style: TextStyle(fontSize: 12.5, color: _swCharcoal, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _swTeal.withValues(alpha: 0.45), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _swPill('LOCAL', _swTeal),
                    const SizedBox(height: 8.0),
                    Text(
                      'Each SelectionHandler must convert globalPosition into '
                      'its own coordinate space using '
                      'RenderObject.globalToLocal before performing word-'
                      'boundary lookups.',
                      style: TextStyle(fontSize: 12.5, color: _swCharcoal, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _swCodeBox(
          '// Inside a custom RenderParagraph-like SelectionHandler:\n'
          '\n'
          'final Offset local = globalToLocal(event.globalPosition);\n'
          'final TextPosition tp =\n'
          '    paragraph.getPositionForOffset(local);\n'
          'final TextRange word =\n'
          '    paragraph.getWordBoundary(tp);',
          accent: _swLightTeal,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  final Widget footguns = Wrap(
    alignment: WrapAlignment.center,
    children: [
      _swFootgun(
        n: 1,
        title: 'globalPosition is GLOBAL, not local',
        detail: 'Passing a Selectable-local Offset will hit the wrong content '
            '(or none). Always use details.globalPosition from the gesture, '
            'and let the handler do globalToLocal internally.',
        icon: Icons.public,
      ),
      _swFootgun(
        n: 2,
        title: 'Word boundaries are locale-aware',
        detail: 'CJK, Thai, and other scripts may segment words differently. '
            'Word boundary detection delegates to the platform via '
            'TextPainter.getWordBoundary, which depends on the Locale.',
        icon: Icons.language,
      ),
      _swFootgun(
        n: 3,
        title: 'Selection may span multiple Selectables',
        detail: 'A "word" can straddle InlineSpan boundaries. The SelectionContainer '
            'aggregates per-Selectable results into a coherent global selection.',
        icon: Icons.layers,
      ),
      _swFootgun(
        n: 4,
        title: 'Events are immutable',
        detail: 'Once constructed, a SelectWordSelectionEvent cannot be mutated. '
            'Construct a NEW event for every gesture instead of caching one.',
        icon: Icons.lock,
      ),
      _swFootgun(
        n: 5,
        title: 'Long paragraphs cost O(N)',
        detail: 'Word-boundary search runs over the targeted paragraph. For very '
            'long Selectables, prefer splitting into multiple SelectionContainers '
            'so dispatch can short-circuit on misses.',
        icon: Icons.speed,
      ),
    ],
  );

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  final Widget recap = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _swDeepIndigo,
          _swIndigo,
          _swTeal,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _swDeepIndigo.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: _swLightAmber, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                color: _swLightAmber,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          '* SelectWordSelectionEvent is a SelectionEvent that says "select the '
          'word at this screen point".\n'
          '* It carries a single immutable field: Offset globalPosition.\n'
          '* type resolves to SelectionEventType.selectWord.\n'
          '* It is dispatched through SelectionRegistrar.handleSelectionEvent '
          'and consumed by SelectionHandlers.\n'
          '* Always pass GLOBAL coordinates -- the handler converts to local.\n'
          '* Word boundaries are locale-aware and may span Selectables.\n'
          '* SelectionArea wires this up automatically for long-press / double-tap.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            _swPill('selectWord', _swLightAmber),
            const SizedBox(width: 8.0),
            _swPill('immutable', _swLightTeal),
            const SizedBox(width: 8.0),
            _swPill('global Offset', _swLightIndigo),
          ],
        ),
      ],
    ),
  );

  print('SelectWordSelectionEvent Deep Demo build complete');

  // ============================================================
  // Final assembly: Scaffold -> SingleChildScrollView -> Column
  // ============================================================
  return Scaffold(
    backgroundColor: _swCream,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1
          titleBanner,

          // Section 2
          _swSectionHeader(
            '1. Anatomy',
            subtitle: 'Class shape and the single Offset field.',
          ),
          anatomy,

          // Section 3
          _swSectionHeader(
            '2. Six instances at varied coordinates',
            subtitle: 'Real SelectWordSelectionEvent objects, each rendered '
                'with a coordinate-grid visual.',
          ),
          instanceGrid,

          // Section 4
          _swSectionHeader(
            '3. SelectionEventType family',
            subtitle: 'Where selectWord sits among its siblings.',
          ),
          enumTable,

          // Section 5
          _swSectionHeader(
            '4. Lifecycle',
            subtitle: 'Five steps from gesture to highlighted word.',
          ),
          lifecycle,

          // Section 6
          _swSectionHeader(
            '5. Real-world mock',
            subtitle: 'A paragraph with a long-press indicator and a '
                'highlighted selected word.',
          ),
          realWorldMock,

          // Section 7
          _swSectionHeader(
            '6. SelectionContainer integration',
            subtitle: 'Constructing and dispatching the event in code.',
          ),
          integrationCode,

          // Section 8
          _swSectionHeader(
            '7. Comparison cards',
            subtitle: 'How SelectWordSelectionEvent relates to its siblings.',
          ),
          comparisonCards,

          // Section 9
          _swSectionHeader(
            '8. Coordinate-space caveats',
            subtitle: 'Global vs. local; why globalToLocal matters.',
          ),
          coordinateCaveats,

          // Section 10
          _swSectionHeader(
            '9. Footguns',
            subtitle: 'Five things that bite on the way to production.',
          ),
          footguns,

          // Section 11
          _swSectionHeader(
            '10. Recap',
            subtitle: 'Everything you need to remember.',
          ),
          recap,

          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
