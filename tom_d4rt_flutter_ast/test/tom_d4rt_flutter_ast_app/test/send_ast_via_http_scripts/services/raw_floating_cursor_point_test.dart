// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//  STYLUS CINDER  --  A Draftsman's Notebook on RawFloatingCursorPoint
// ----------------------------------------------------------------------------
//  Theme           : Stylus Cinder. Picture a graphite-on-paper drafting
//                    studio at the end of a long winter afternoon. A vellum
//                    off-white sheet of cartridge paper has been pinned to a
//                    drafting board. A 4B pencil rests in the gutter beside a
//                    smudged kneaded eraser. Cinder-grey hatch marks fan out
//                    from a half-finished study of an iPad keyboard. The
//                    palette is charcoal, cinder grey, vellum off-white,
//                    smoke, ash, with sparing inks of slate and bone. Prose
//                    is written as a draftsman's marginalia: terse, exact,
//                    hand-lettered.
//  Subject         : `RawFloatingCursorPoint` from `package:flutter/services
//                    .dart`. A small, immutable record that carries one
//                    sample of an iOS floating-cursor session from the
//                    platform engine to `RenderEditable`. Three fields:
//                      state        : FloatingCursorDragState (Start/Update
//                                     /End)
//                      offset       : Offset?      -- delta from the
//                                     anchor used during Update samples.
//                      startLocation: (Offset, TextPosition)? -- the anchor
//                                     point captured at the Start sample,
//                                     handy for hit-testing.
//  Surface         : Constructor:
//                      RawFloatingCursorPoint({
//                        required FloatingCursorDragState state,
//                        Offset? offset,
//                        (Offset, TextPosition)? startLocation,
//                      })
//                    No methods to memorise. The whole class is a tagged
//                    snapshot the platform sends through TextInput's
//                    "TextInputClient.updateFloatingCursor" channel.
//  Audience        : Flutter engineers wiring custom editors that want to
//                    honour the iOS spacebar-drag cursor; QA folk writing
//                    snapshot tests for floating-cursor behaviour; curious
//                    readers of the Tom AI D4rt flutter ast smoke harness
//                    who want to see a RawFloatingCursorPoint rendered as a
//                    pencil study rather than a JSON dump.
//  D4rt notes      : `build()` is invoked exactly once. The returned widget
//                    tree is a static snapshot. No StatefulWidget, no
//                    setState, no controllers, no timers, no streams. We do
//                    NOT iterate BridgedInstance values with for-in, and we
//                    do NOT touch `.value` on a Tween.animate. Alpha colours
//                    use `.withValues(alpha: ...)` instead of withOpacity.
//                    All loops are indexed (`for (int i = 0; ...)`).
//  Style           : Charcoal, cinder, ash, smoke, graphite, vellum, bone,
//                    slate-blue, paper-shadow, eraser pink, pencil-tip
//                    silver, and a deep ink for code blocks. Section
//                    headings sit on a hatched cinder strip, mimicking the
//                    fan of pencil strokes around a draftsman's title block.
//  Length goal     : 1900+ lines so the harness exercises its rendering
//                    pipeline against a substantial AST and the reader can
//                    treat the file as a small standalone reference work.
//  Print policy    : Narrative print(...) calls scattered through build()
//                    to log the journey. Each section opens with a print so
//                    that running this script in dcli tells a story.
// ----------------------------------------------------------------------------
//  Anatomy diagram (rendered later as a card):
//
//      class RawFloatingCursorPoint {
//        final FloatingCursorDragState state;
//        final Offset? offset;
//        final (Offset, TextPosition)? startLocation;
//        const RawFloatingCursorPoint({
//          required this.state,
//          this.offset,
//          this.startLocation,
//        });
//      }
//
//  State machine (rendered later as a flow card):
//
//                  +-------+     long-press space
//      none ------>| Start |  <-- iOS keyboard captures anchor
//                  +-------+
//                       |
//                       v
//                  +--------+   finger drags
//      .--------> | Update | <-- one sample per movement frame
//      |          +--------+
//      |               |
//      |               | finger keeps dragging
//      |               v
//      |          +--------+
//      '--------- | Update |
//                 +--------+
//                       |
//                       v finger lifts
//                  +-----+
//                  | End |
//                  +-----+
//
//  Channel context:
//
//      iOS UITextInteraction --[platform channel]--> TextInput
//      TextInput.onFloatingCursor --> TextInputClient
//      TextInputClient.updateFloatingCursor(point) -->
//          EditableText -> RenderEditable.setFloatingCursor(...)
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Stylus Cinder palette. These constants are reused across every section so
// the demo feels like a single bound notebook rather than a scrapbook.
// ---------------------------------------------------------------------------

const Color cVellum = Color(0xFFF4EFE6);
const Color cVellumDeep = Color(0xFFE7DFCF);
const Color cBone = Color(0xFFFAF6EC);
const Color cPaperShadow = Color(0xFFD9D2C2);
const Color cMist = Color(0xFFCEC7B7);
const Color cAsh = Color(0xFF9C968A);
const Color cSmoke = Color(0xFF6E6A62);
const Color cCinder = Color(0xFF4B4842);
const Color cCharcoal = Color(0xFF2A2824);
const Color cInk = Color(0xFF15140F);
const Color cGraphite = Color(0xFF383631);
const Color cSilverTip = Color(0xFFB6B0A1);
const Color cSlateBlue = Color(0xFF55657A);
const Color cEraserPink = Color(0xFFE8B5A8);
const Color cAccentChalk = Color(0xFFD8D2C2);
const Color cAccentRust = Color(0xFFA15A3A);
const Color cAccentSage = Color(0xFF7C8B6F);

// Derived washes for soft backgrounds.
final Color cCinderWash = cCinder.withValues(alpha: 0.18);
final Color cSmokeWash = cSmoke.withValues(alpha: 0.18);
final Color cAshWash = cAsh.withValues(alpha: 0.20);
final Color cSlateWash = cSlateBlue.withValues(alpha: 0.18);
final Color cRustWash = cAccentRust.withValues(alpha: 0.18);
final Color cSageWash = cAccentSage.withValues(alpha: 0.20);

// ---------------------------------------------------------------------------
// Reusable text-style helpers. Plain functions so call-sites stay short.
// ---------------------------------------------------------------------------

TextStyle _titleStyle({Color color = cInk, double size = 22}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.4,
  );
}

TextStyle _subtitleStyle({Color color = cCinder, double size = 15}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}

TextStyle _bodyStyle({Color color = cCharcoal, double size = 13.5}) {
  return TextStyle(color: color, fontSize: size, height: 1.45);
}

TextStyle _marginStyle({Color color = cSlateBlue, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
    height: 1.4,
  );
}

TextStyle _codeStyle({Color color = cVellum, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: 'monospace',
    height: 1.4,
  );
}

TextStyle _captionStyle({Color color = cSmoke, double size = 11}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
  );
}

// ---------------------------------------------------------------------------
// Visual helper widgets. Each returns a widget so the body of build() can
// stay declarative. We avoid any control-flow over BridgedInstance values.
// ---------------------------------------------------------------------------

Widget _swatch(Color c, String label) {
  return Container(
    width: 92,
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: cInk.withValues(alpha: 0.35)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: _captionStyle(color: cCharcoal, size: 10)),
      ],
    ),
  );
}

// _hatchStrip renders a thin band of fine pencil hatching using a Row of
// short vertical bars. Drafting studios use hatching to show that an area is
// in shadow; we use it as a recurring decorative motif.
Widget _hatchStrip({
  Color color = cCinder,
  double height = 10,
  int count = 80,
  double gap = 3,
}) {
  final List<Widget> bars = <Widget>[];
  for (int i = 0; i < count; i++) {
    final double opacity = 0.35 + ((i % 5) * 0.10);
    bars.add(
      Container(
        width: 1.2,
        height: height,
        margin: EdgeInsets.only(right: gap),
        color: color.withValues(alpha: opacity),
      ),
    );
  }
  return SizedBox(
    height: height,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: bars,
    ),
  );
}

Widget _sectionHeader(String index, String title, {Color? accent}) {
  final Color c = accent ?? cCinder;
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: c, width: 6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                index,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title, style: _titleStyle(size: 18)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _hatchStrip(color: c, height: 8, count: 60, gap: 2.4),
      ],
    ),
  );
}

Widget _proseBlock(String text, {Color? color}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: (color ?? cBone),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cMist),
    ),
    child: Text(text, style: _bodyStyle()),
  );
}

Widget _marginNote(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
    decoration: BoxDecoration(
      color: cSlateWash,
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: cSlateBlue, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.draw, color: cSlateBlue, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: _marginStyle())),
      ],
    ),
  );
}

Widget _bulletList(List<String> bullets, {Color dot = cCinder}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < bullets.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6, right: 8),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dot,
                shape: BoxShape.rectangle,
              ),
            ),
            Expanded(
              child: Text(bullets[i], style: _bodyStyle()),
            ),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rows,
  );
}

Widget _kvRow(String key, String value, {Color? keyColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            key,
            style: _subtitleStyle(
              color: keyColor ?? cCinder,
              size: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: _bodyStyle(size: 13)),
        ),
      ],
    ),
  );
}

Widget _codeCard(String title, String code, {Color? accent}) {
  final Color c = accent ?? cCinder;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: c.withValues(alpha: 0.7), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: cSilverTip,
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: cAsh,
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: cAccentRust,
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(code, style: _codeStyle()),
      ],
    ),
  );
}

Widget _doAvoid(String label, String text, {required bool isDo}) {
  final Color border = isDo ? cAccentSage : cAccentRust;
  final String prefix = isDo ? 'DO' : 'AVOID';
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: border.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: border, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: border,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            prefix,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: _subtitleStyle(size: 13)),
              const SizedBox(height: 4),
              Text(text, style: _bodyStyle(size: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryItem(String term, String definition) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cAsh.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(term, style: _subtitleStyle(color: cCinder, size: 13)),
        const SizedBox(height: 3),
        Text(definition, style: _bodyStyle(size: 12.5)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _stateBadge: a small tag indicating the FloatingCursorDragState. We give
// each state a distinct chip colour so a glance through a session shows the
// shape of the gesture.
// ---------------------------------------------------------------------------

Widget _stateBadge(FloatingCursorDragState s, {double size = 12}) {
  String label;
  Color color;
  IconData icon;
  if (s == FloatingCursorDragState.Start) {
    label = 'START';
    color = cAccentSage;
    icon = Icons.play_arrow;
  } else if (s == FloatingCursorDragState.Update) {
    label = 'UPDATE';
    color = cSlateBlue;
    icon = Icons.swap_horiz;
  } else {
    label = 'END';
    color = cAccentRust;
    icon = Icons.stop;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: size + 1),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _formatOffset: pencil-style coordinate formatter so cards look uniform.
// ---------------------------------------------------------------------------
String _formatOffset(Offset? o) {
  if (o == null) {
    return 'null';
  }
  final String dx = o.dx.toStringAsFixed(1);
  final String dy = o.dy.toStringAsFixed(1);
  return 'Offset($dx, $dy)';
}

// _formatStartLocation: stringify a (Offset, TextPosition) record. Records
// arrived in Dart 3 and `RawFloatingCursorPoint.startLocation` uses one
// directly. We render its first element as an Offset and second as a
// TextPosition that describes the anchor caret offset and affinity.
String _formatStartLocation((Offset, TextPosition)? rec) {
  if (rec == null) {
    return 'null';
  }
  final Offset anchor = rec.$1;
  final TextPosition pos = rec.$2;
  final String dx = anchor.dx.toStringAsFixed(1);
  final String dy = anchor.dy.toStringAsFixed(1);
  return '(Offset($dx, $dy), TextPosition(offset: ${pos.offset}, '
      'affinity: ${pos.affinity}))';
}

// ---------------------------------------------------------------------------
// _samplePencilCard: the workhorse of the demo. Render a single
// RawFloatingCursorPoint as a pencil-study card showing:
//   * The state badge, an index number, and a one-line caption.
//   * The offset coordinates rendered as a tiny crosshair on a graphite
//     grid (a real iOS sample is in points relative to a captured anchor).
//   * If startLocation is non-null, the anchor caret offset and affinity.
//   * A short narrative explaining what the editor would do upon receiving
//     this exact sample.
// ---------------------------------------------------------------------------

Widget _samplePencilCard({
  required int index,
  required RawFloatingCursorPoint point,
  required String caption,
  required String narrative,
  Color accent = cCinder,
}) {
  final FloatingCursorDragState state = point.state;
  final Offset? offset = point.offset;
  final (Offset, TextPosition)? startLoc = point.startLocation;

  // A small crosshair preview. We map the offset onto a 120x80 graphite
  // grid centred at (60, 40). A real session may carry offsets larger than
  // the grid; we clamp visually but keep the textual coordinates honest.
  final double gridW = 130;
  final double gridH = 84;
  final double centerX = gridW / 2;
  final double centerY = gridH / 2;
  final double dx = offset?.dx ?? 0;
  final double dy = offset?.dy ?? 0;
  final double clampedX = dx.clamp(-centerX + 6, centerX - 6).toDouble();
  final double clampedY = dy.clamp(-centerY + 6, centerY - 6).toDouble();

  // Build the grid as a Stack of overlaid lines and a marker dot.
  final List<Widget> gridLines = <Widget>[];
  // Horizontal hatch.
  for (int i = 0; i < 7; i++) {
    final double y = (gridH / 6) * i;
    gridLines.add(
      Positioned(
        left: 0,
        right: 0,
        top: y,
        child: Container(
          height: 0.6,
          color: cMist.withValues(alpha: 0.7),
        ),
      ),
    );
  }
  // Vertical hatch.
  for (int i = 0; i < 11; i++) {
    final double x = (gridW / 10) * i;
    gridLines.add(
      Positioned(
        top: 0,
        bottom: 0,
        left: x,
        child: Container(
          width: 0.6,
          color: cMist.withValues(alpha: 0.7),
        ),
      ),
    );
  }
  // Centre crosshair.
  gridLines.add(
    Positioned(
      left: 0,
      right: 0,
      top: centerY,
      child: Container(
        height: 0.8,
        color: cAsh.withValues(alpha: 0.85),
      ),
    ),
  );
  gridLines.add(
    Positioned(
      top: 0,
      bottom: 0,
      left: centerX,
      child: Container(
        width: 0.8,
        color: cAsh.withValues(alpha: 0.85),
      ),
    ),
  );
  // The marker.
  if (offset != null) {
    final double markerLeft = centerX + clampedX - 5;
    final double markerTop = centerY + clampedY - 5;
    gridLines.add(
      Positioned(
        left: markerLeft,
        top: markerTop,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
            border: Border.all(color: cInk, width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.5),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    // Null offset: draw a faint hatch over the grid to communicate absence.
    gridLines.add(
      Positioned(
        left: centerX - 16,
        top: centerY - 7,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          color: cAsh,
          child: Text(
            'null',
            style: TextStyle(
              color: cBone,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInk.withValues(alpha: 0.10),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _stateBadge(state),
            const SizedBox(width: 8),
            Expanded(
              child: Text(caption, style: _subtitleStyle(size: 13)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: gridW,
              height: gridH,
              decoration: BoxDecoration(
                color: cVellum,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: cMist),
              ),
              child: Stack(children: gridLines),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _kvRow('state', '$state'),
                  _kvRow('offset', _formatOffset(offset)),
                  _kvRow('startLocation', _formatStartLocation(startLoc)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
            color: cSlateWash,
            borderRadius: BorderRadius.circular(4),
            border: Border(
              left: BorderSide(color: cSlateBlue, width: 2.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.edit_note, color: cSlateBlue, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(narrative, style: _marginStyle()),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _sessionTimelineCard: render an entire ordered session as a horizontal
// timeline. Each sample becomes a lozenge whose colour matches its state.
// Dotted connectors visualise the order. A miniature path is drawn beneath
// showing the cumulative offset traced by the cursor.
// ---------------------------------------------------------------------------

Widget _sessionTimelineCard({
  required String title,
  required String subtitle,
  required List<RawFloatingCursorPoint> session,
  Color accent = cCinder,
}) {
  // Build lozenges for the timeline.
  final List<Widget> lozenges = <Widget>[];
  for (int i = 0; i < session.length; i++) {
    final RawFloatingCursorPoint p = session[i];
    Color c;
    if (p.state == FloatingCursorDragState.Start) {
      c = cAccentSage;
    } else if (p.state == FloatingCursorDragState.Update) {
      c = cSlateBlue;
    } else {
      c = cAccentRust;
    }
    if (i > 0) {
      lozenges.add(
        Container(
          width: 14,
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          color: cAsh.withValues(alpha: 0.6),
        ),
      );
    }
    lozenges.add(
      Container(
        width: 56,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '#${i + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              p.state == FloatingCursorDragState.Start
                  ? 'S'
                  : (p.state == FloatingCursorDragState.Update ? 'U' : 'E'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _formatOffset(p.offset).replaceFirst('Offset', ''),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Mini path canvas: cumulative offsets onto a 320x90 grid.
  // Use a simple bounded transform: walk the session, accumulate offsets,
  // record min/max, then map onto the canvas.
  final List<Offset> path = <Offset>[];
  double cx = 0;
  double cy = 0;
  for (int i = 0; i < session.length; i++) {
    final Offset? o = session[i].offset;
    if (o != null) {
      cx = o.dx;
      cy = o.dy;
    }
    path.add(Offset(cx, cy));
  }
  double minX = 0;
  double maxX = 0;
  double minY = 0;
  double maxY = 0;
  for (int i = 0; i < path.length; i++) {
    if (path[i].dx < minX) minX = path[i].dx;
    if (path[i].dx > maxX) maxX = path[i].dx;
    if (path[i].dy < minY) minY = path[i].dy;
    if (path[i].dy > maxY) maxY = path[i].dy;
  }
  final double rangeX = (maxX - minX) <= 0 ? 1 : (maxX - minX);
  final double rangeY = (maxY - minY) <= 0 ? 1 : (maxY - minY);
  final double canvasW = 320;
  final double canvasH = 90;
  final List<Widget> pathDots = <Widget>[];
  // Background hatch grid.
  for (int i = 0; i < 11; i++) {
    final double x = (canvasW / 10) * i;
    pathDots.add(
      Positioned(
        top: 0,
        bottom: 0,
        left: x,
        child: Container(width: 0.5, color: cMist.withValues(alpha: 0.6)),
      ),
    );
  }
  for (int i = 0; i < 5; i++) {
    final double y = (canvasH / 4) * i;
    pathDots.add(
      Positioned(
        left: 0,
        right: 0,
        top: y,
        child: Container(height: 0.5, color: cMist.withValues(alpha: 0.6)),
      ),
    );
  }
  // Path dots.
  for (int i = 0; i < path.length; i++) {
    final Offset p = path[i];
    final double nx = ((p.dx - minX) / rangeX) * (canvasW - 12) + 6;
    final double ny = ((p.dy - minY) / rangeY) * (canvasH - 12) + 6;
    Color dot;
    final FloatingCursorDragState s = session[i].state;
    if (s == FloatingCursorDragState.Start) {
      dot = cAccentSage;
    } else if (s == FloatingCursorDragState.End) {
      dot = cAccentRust;
    } else {
      dot = cSlateBlue;
    }
    pathDots.add(
      Positioned(
        left: nx - 4,
        top: ny - 4,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dot,
            shape: BoxShape.circle,
            border: Border.all(color: cInk, width: 0.8),
          ),
        ),
      ),
    );
    pathDots.add(
      Positioned(
        left: nx + 6,
        top: ny - 7,
        child: Text(
          '${i + 1}',
          style: TextStyle(
            color: cInk,
            fontFamily: 'monospace',
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cVellum,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: _subtitleStyle(size: 14)),
            ),
            Text(
              '${session.length} samples',
              style: _captionStyle(color: cCinder, size: 11),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: _bodyStyle(size: 12.5)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: lozenges,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: canvasW,
          height: canvasH,
          decoration: BoxDecoration(
            color: cBone,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: cMist),
          ),
          child: Stack(children: pathDots),
        ),
        const SizedBox(height: 6),
        Text(
          'Mini path map: cumulative offset trace, oldest at #1.',
          style: _captionStyle(color: cSmoke, size: 11),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _editorCanvas: a static caricature of an editor surface with a glowing
// cursor dot positioned at a given offset. The "text" is fixed lorem-style
// prose drawn as a Column of Text rows; the cursor sits over the appropriate
// row. We do not call into any TextEditing controllers; everything is
// hand-laid for this demo.
// ---------------------------------------------------------------------------

Widget _editorCanvas({
  required String title,
  required RawFloatingCursorPoint point,
  required String description,
}) {
  // The fake document: a list of fixed strings rendered as monospace lines.
  final List<String> lines = <String>[
    'When the wind reaches the eaves it whistles like a',
    'tea kettle on its third morning. The drafting board',
    'tilts a quarter-turn to keep the lamp from glaring,',
    'and the pencil sharpener spits curls onto the felt.',
    'A floating cursor moves beneath the glass, drawn by',
    'a fingertip held above the spacebar of the keyboard.',
    'Each sample arrives with a tiny offset measured from',
    'the anchor caret captured at the start of the drag.',
  ];

  final double canvasW = 360;
  final double canvasH = 220;
  final double lineH = canvasH / lines.length;

  // Cursor placement. We pretend the offset is in editor-local points and
  // map dy onto a row, dx onto the row's horizontal extent. Update samples
  // get a bright dot, Start gets a sage circle, End gets a rust ring.
  final FloatingCursorDragState s = point.state;
  final Offset offset = point.offset ?? const Offset(0, 0);

  // Anchor row: assume row 4 (index 4). Add the offset's dy to find the
  // current row, then clamp.
  final double anchorRowY = 4 * lineH + lineH / 2;
  final double cursorY = (anchorRowY + offset.dy).clamp(8, canvasH - 8);
  final double cursorX = (60 + offset.dx).clamp(8, canvasW - 8).toDouble();

  Color cursorColor;
  if (s == FloatingCursorDragState.Start) {
    cursorColor = cAccentSage;
  } else if (s == FloatingCursorDragState.End) {
    cursorColor = cAccentRust;
  } else {
    cursorColor = cSlateBlue;
  }

  // Render lines.
  final List<Widget> lineWidgets = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    lineWidgets.add(
      Positioned(
        left: 14,
        top: i * lineH + 4,
        right: 14,
        child: Text(
          lines[i],
          style: TextStyle(
            color: cCharcoal,
            fontFamily: 'monospace',
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  // Cursor caret line.
  final Widget caret = Positioned(
    left: cursorX - 1,
    top: cursorY - lineH / 2 + 2,
    child: Container(
      width: 2,
      height: lineH - 4,
      color: cursorColor.withValues(alpha: 0.8),
    ),
  );

  // The glow disk.
  final Widget glow = Positioned(
    left: cursorX - 12,
    top: cursorY - 12,
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: cursorColor.withValues(alpha: 0.18),
        shape: BoxShape.circle,
      ),
    ),
  );

  // The dot.
  final Widget dot = Positioned(
    left: cursorX - 5,
    top: cursorY - 5,
    child: Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: cursorColor,
        shape: BoxShape.circle,
        border: Border.all(color: cInk, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cursorColor.withValues(alpha: 0.55),
            blurRadius: 6,
          ),
        ],
      ),
    ),
  );

  // Background hatch grid.
  final List<Widget> hatch = <Widget>[];
  for (int i = 0; i < 9; i++) {
    final double x = (canvasW / 8) * i;
    hatch.add(
      Positioned(
        top: 0,
        bottom: 0,
        left: x,
        child: Container(width: 0.4, color: cMist.withValues(alpha: 0.6)),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cCinder, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.edit_document, color: cCinder, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: _subtitleStyle(size: 14)),
            ),
            _stateBadge(s),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: canvasW,
          height: canvasH,
          decoration: BoxDecoration(
            color: cVellum,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: cMist),
          ),
          child: Stack(
            children: <Widget>[
              ...hatch,
              ...lineWidgets,
              glow,
              caret,
              dot,
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(description, style: _bodyStyle(size: 12.5)),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            Text(
              'cursor at ',
              style: _captionStyle(color: cSmoke, size: 11),
            ),
            Text(
              '(${cursorX.toStringAsFixed(1)}, ${cursorY.toStringAsFixed(1)})',
              style: TextStyle(
                color: cInk,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'offset ',
              style: _captionStyle(color: cSmoke, size: 11),
            ),
            Text(
              _formatOffset(point.offset),
              style: TextStyle(
                color: cInk,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _stateMachineNode: a single state node for the state-machine diagram.
// ---------------------------------------------------------------------------
Widget _stateMachineNode({
  required String label,
  required Color color,
  required IconData icon,
  required String description,
}) {
  return Container(
    width: 180,
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInk.withValues(alpha: 0.18),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.95),
            fontSize: 11.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _arrowConnector(String label) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Column(
      children: <Widget>[
        Icon(Icons.arrow_forward, color: cCinder, size: 18),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: cCinder,
            fontSize: 10.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _scenarioCard: A reproduction of a common UX scenario, hand-curated. Used
// in section 6 to illustrate how a particular gesture maps to a sequence of
// RawFloatingCursorPoint values.
// ---------------------------------------------------------------------------
Widget _scenarioCard({
  required String name,
  required String description,
  required List<String> steps,
  required Color accent,
  required IconData icon,
}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < steps.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(steps[i], style: _bodyStyle(size: 12.5)),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(name, style: _subtitleStyle(size: 14)),
            ),
            Text(
              '${steps.length} steps',
              style: _captionStyle(color: cSmoke, size: 11),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(description, style: _bodyStyle(size: 12.5)),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows,
        ),
      ],
    ),
  );
}

// _channelTrace: a tiny "platform channel" trace card. Renders a JSON-ish
// payload of what the iOS engine would put on the wire, beside how the
// framework decodes it back to a RawFloatingCursorPoint. Purely
// illustrative; the actual encoding details live deep inside Flutter.
Widget _channelTrace({
  required String name,
  required String json,
  required String decoded,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cInk,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cCinder, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.cell_tower, color: Colors.white70, size: 16),
            const SizedBox(width: 6),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'platform -> framework (JSON-ish)',
          style: TextStyle(
            color: cSilverTip,
            fontSize: 10.5,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(json, style: _codeStyle(color: cVellum, size: 11.5)),
        const SizedBox(height: 8),
        Text(
          'decoded RawFloatingCursorPoint',
          style: TextStyle(
            color: cSilverTip,
            fontSize: 10.5,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(decoded, style: _codeStyle(color: cAccentChalk, size: 11.5)),
      ],
    ),
  );
}

// ===========================================================================
//                                  build()
// ===========================================================================
dynamic build(BuildContext context) {
  print('=== Stylus Cinder notebook for RawFloatingCursorPoint ===');
  print('Step 1: minting palette and helper widgets.');
  print('Step 2: constructing twelve illustrative RawFloatingCursorPoint '
      'instances.');

  // ------------------------------------------------------------------------
  // Twelve illustrative RawFloatingCursorPoint instances. The first three
  // are isolated singletons demonstrating each constructor pattern; the
  // remainder form two coherent multi-step sessions traced later in the
  // notebook.
  // ------------------------------------------------------------------------

  // Singleton 1: a Start sample carrying both a startLocation anchor and
  // an offset of (0, 0). The iOS engine generally sends Start with offset
  // == (0, 0) since the cursor has not moved yet; the anchor caret offset
  // is what matters.
  final RawFloatingCursorPoint sample1 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Start,
    offset: const Offset(0, 0),
    startLocation: (
      const Offset(120, 64),
      const TextPosition(offset: 17, affinity: TextAffinity.downstream),
    ),
  );

  // Singleton 2: a typical Update sample. Offset is the delta from the
  // anchor; startLocation is null because the platform only sends it in
  // the Start sample.
  final RawFloatingCursorPoint sample2 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(48, 0),
  );

  // Singleton 3: an End sample. Both offset and startLocation are null;
  // the framework simply hides the floating cursor.
  final RawFloatingCursorPoint sample3 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.End,
  );

  // Session A: a single horizontal drag from "the" to "manuscript" in the
  // first paragraph. Eight samples: Start, six Updates, End.
  final RawFloatingCursorPoint sA1 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Start,
    offset: const Offset(0, 0),
    startLocation: (
      const Offset(60, 18),
      const TextPosition(offset: 5, affinity: TextAffinity.downstream),
    ),
  );
  final RawFloatingCursorPoint sA2 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(8, 0),
  );
  final RawFloatingCursorPoint sA3 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(20, 0),
  );
  final RawFloatingCursorPoint sA4 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(36, 0),
  );
  final RawFloatingCursorPoint sA5 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(58, 0),
  );
  final RawFloatingCursorPoint sA6 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(82, 0),
  );
  final RawFloatingCursorPoint sA7 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(110, 0),
  );
  final RawFloatingCursorPoint sA8 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.End,
  );
  final List<RawFloatingCursorPoint> sessionA =
      <RawFloatingCursorPoint>[sA1, sA2, sA3, sA4, sA5, sA6, sA7, sA8];

  // Session B: a drag with an overshoot that comes back. Eleven samples:
  // Start, Updates that go right, peak, two Updates back, End.
  final RawFloatingCursorPoint sB1 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Start,
    offset: const Offset(0, 0),
    startLocation: (
      const Offset(48, 86),
      const TextPosition(offset: 144, affinity: TextAffinity.upstream),
    ),
  );
  final RawFloatingCursorPoint sB2 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(12, 4),
  );
  final RawFloatingCursorPoint sB3 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(32, 6),
  );
  final RawFloatingCursorPoint sB4 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(64, 12),
  );
  final RawFloatingCursorPoint sB5 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(96, 18),
  );
  final RawFloatingCursorPoint sB6 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(120, 22),
  );
  final RawFloatingCursorPoint sB7 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(98, 18),
  );
  final RawFloatingCursorPoint sB8 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: const Offset(70, 12),
  );
  final RawFloatingCursorPoint sB9 = RawFloatingCursorPoint(
    state: FloatingCursorDragState.End,
  );
  final List<RawFloatingCursorPoint> sessionB =
      <RawFloatingCursorPoint>[sB1, sB2, sB3, sB4, sB5, sB6, sB7, sB8, sB9];

  // The complete catalogue of the 12 named samples for Section 4.
  final List<RawFloatingCursorPoint> catalogue = <RawFloatingCursorPoint>[
    sample1,
    sample2,
    sample3,
    sA1,
    sA4,
    sA8,
    sB1,
    sB4,
    sB6,
    sB7,
    sB8,
    sB9,
  ];

  print('Step 3: minted ${catalogue.length} catalogue entries plus sessions '
      'A (${sessionA.length}) and B (${sessionB.length}).');
  print('Step 4: building title block.');

  // ------------------------------------------------------------------------
  // SECTION 1 -- Title banner with palette swatches.
  // ------------------------------------------------------------------------
  final Widget section1 = Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cInk, cCharcoal, cCinder],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'STYLUS CINDER',
          style: TextStyle(
            color: cVellum,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'RawFloatingCursorPoint',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 26,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A draftsman\'s notebook on the iOS floating cursor.',
          style: TextStyle(
            color: cAccentChalk,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        _hatchStrip(color: cAccentChalk, height: 6, count: 90, gap: 2.2),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: cVellum,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.architecture, color: cInk, size: 14),
              const SizedBox(width: 6),
              Text(
                'package:flutter/services.dart',
                style: TextStyle(
                  color: cInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _swatch(cVellum, 'vellum'),
            _swatch(cBone, 'bone'),
            _swatch(cMist, 'mist'),
            _swatch(cAsh, 'ash'),
            _swatch(cSmoke, 'smoke'),
            _swatch(cCinder, 'cinder'),
            _swatch(cCharcoal, 'charcoal'),
            _swatch(cInk, 'ink'),
            _swatch(cSilverTip, 'silver-tip'),
            _swatch(cSlateBlue, 'slate'),
            _swatch(cAccentSage, 'sage'),
            _swatch(cAccentRust, 'rust'),
          ],
        ),
      ],
    ),
  );

  print('Step 5: assembling Section 2 -- Anatomy of a floating cursor event.');

  // ------------------------------------------------------------------------
  // SECTION 2 -- Anatomy of a floating cursor event.
  // ------------------------------------------------------------------------
  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S2', 'Anatomy of a floating cursor event'),
      _proseBlock(
        'The floating cursor on iOS is the slim grey caret that glides '
        'beneath your finger when you long-press the spacebar of the '
        'system keyboard. Inside the engine that gesture is decomposed '
        'into a stream of "RawFloatingCursorPoint" samples and pushed '
        'across the platform channel into Dart. Each sample is a small '
        'tagged record: a state (Start/Update/End), an optional offset '
        'measured from the anchor caret, and -- only on Start -- an '
        'optional (Offset, TextPosition) pair recording where the anchor '
        'caret originally lived in editor-local coordinates and the '
        'TextEditingValue.',
      ),
      _codeCard(
        'class RawFloatingCursorPoint',
        '// from package:flutter/services.dart\n'
            'class RawFloatingCursorPoint {\n'
            '  final FloatingCursorDragState state;\n'
            '  final Offset? offset;\n'
            '  final (Offset, TextPosition)? startLocation;\n'
            '  const RawFloatingCursorPoint({\n'
            '    required this.state,\n'
            '    this.offset,\n'
            '    this.startLocation,\n'
            '  });\n'
            '}',
      ),
      _proseBlock(
        'Three fields, three responsibilities. "state" answers WHEN, '
        '"offset" answers HOW FAR, and "startLocation" answers FROM WHERE. '
        'A correct floating-cursor handler reads each field in that '
        'order, and behaves slightly differently for each state: on '
        'Start it caches the anchor; on Update it adds the offset to '
        'the anchor and shows the caret; on End it forgets the anchor '
        'and snaps the real caret to the projected location.',
      ),
      _kvRow('library', 'package:flutter/services.dart'),
      _kvRow('immutable', 'yes -- final fields, no setters'),
      _kvRow('arrives via', 'TextInput -> onFloatingCursor channel call'),
      _kvRow('handled by', 'TextInputClient.updateFloatingCursor'),
      _kvRow('rendered by', 'RenderEditable.setFloatingCursor'),
      _kvRow('feature platform', 'iOS only (no equivalent on Android)'),
      _kvRow('introduced', 'Long predates Material 3; available since iOS 9'),
      const SizedBox(height: 8),
      _bulletList(<String>[
        'Receive: TextInputClient.updateFloatingCursor(point) is invoked.',
        'Read state: switch over FloatingCursorDragState constants.',
        'On Start: cache point.startLocation as the anchor.',
        'On Update: read point.offset and project caret = anchor + delta.',
        'On End: hide the floating cursor visual; commit the caret.',
        'Always tolerate null offset and null startLocation.',
      ]),
      const SizedBox(height: 8),
      _marginNote(
        'Drafting note: think of the floating cursor as a chalk '
        'line traced by the user above your text canvas. The line is not '
        'the caret -- it is a hint about where the caret will land when '
        'the user lifts their finger.',
      ),
      _proseBlock(
        'Companion enum FloatingCursorDragState carries three constants:\n'
        '  - Start  : the gesture begins; record the anchor and show '
        'the floating cursor visual at the anchor.\n'
        '  - Update : the finger moves; redraw the floating cursor at '
        'anchor + offset.\n'
        '  - End    : the finger lifts; hide the floating cursor and '
        'commit the underlying caret to its final position.',
      ),
      _codeCard(
        'enum FloatingCursorDragState',
        'enum FloatingCursorDragState {\n'
            '  Start,\n'
            '  Update,\n'
            '  End,\n'
            '}\n\n'
            '// FloatingCursorDragState.values has length 3.\n'
            '// .name strings are exactly "Start", "Update", "End".',
      ),
      _proseBlock(
        'A subtle aside about types: prior to Dart 3 the startLocation '
        'field was typed as Tuple2<Offset, TextPosition> (or even a '
        'List<dynamic>). Modern Flutter expresses it as a record: '
        '(Offset, TextPosition)?. Fields are accessed via the positional '
        'getters .\$1 and .\$2.',
      ),
      _doAvoid(
        'Treat the offset as a delta',
        'Update.offset is measured from the anchor captured at Start, '
        'not from the previous sample. Cumulating Update offsets yields '
        'the wrong path.',
        isDo: true,
      ),
      _doAvoid(
        'Do not assume offset is non-null on Start',
        'iOS often sends Start with offset = (0, 0), but framework '
        'implementations that defensively read offset must still tolerate '
        'a null. The contract simply says "may be present".',
        isDo: true,
      ),
      _doAvoid(
        'Do not commit selection on Update',
        'Updating the underlying TextEditingValue.selection on every '
        'Update sample causes flicker. Only the final End should commit; '
        'Updates only paint the floating-cursor visual.',
        isDo: false,
      ),
    ],
  );

  print('Step 6: assembling Section 3 -- State machine diagram.');

  // ------------------------------------------------------------------------
  // SECTION 3 -- State machine diagram.
  // ------------------------------------------------------------------------
  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S3', 'State machine: Start -> Update -> End'),
      _proseBlock(
        'A floating-cursor session is a tiny finite-state machine. The '
        'machine has three observed states (Start, Update, End) and one '
        'implicit "idle" state between sessions. Sessions never overlap; '
        'iOS guarantees that each Start is matched by exactly one End, '
        'with zero or more Updates between them. A naive editor can '
        'therefore use a single Boolean "isFloating" flag plus an Offset '
        'anchor to track everything it needs.',
      ),
      const SizedBox(height: 8),
      Wrap(
        children: <Widget>[
          _stateMachineNode(
            label: 'IDLE',
            color: cSmoke,
            icon: Icons.pause_circle,
            description: 'No active session. RenderEditable shows the '
                'normal caret. Listening for Start.',
          ),
          _arrowConnector('long-press space'),
          _stateMachineNode(
            label: 'START',
            color: cAccentSage,
            icon: Icons.play_arrow,
            description: 'iOS captured an anchor. Cache the anchor caret '
                'offset and the editor-local point; show floating cursor.',
          ),
          _arrowConnector('finger drags'),
          _stateMachineNode(
            label: 'UPDATE',
            color: cSlateBlue,
            icon: Icons.swap_horiz,
            description: 'A new sample arrives every frame. Recompute '
                'cursor = anchor + offset; redraw the floating cursor.',
          ),
          _arrowConnector('finger lifts'),
          _stateMachineNode(
            label: 'END',
            color: cAccentRust,
            icon: Icons.stop,
            description: 'Hide the floating cursor visual. Commit the '
                'projected caret as the new selection. Return to idle.',
          ),
        ],
      ),
      const SizedBox(height: 12),
      _proseBlock(
        'Note the loop on Update. A single drag may produce dozens of '
        'Update samples. Each one is small and idempotent: redraw the '
        'caret at anchor + offset and forget about it. Flutter\'s '
        'RenderEditable already debounces redundant frames, so a handler '
        'can read every Update without worrying about overdraw.',
      ),
      _codeCard(
        'minimal updateFloatingCursor handler',
        '@override\n'
            'void updateFloatingCursor(RawFloatingCursorPoint point) {\n'
            '  switch (point.state) {\n'
            '    case FloatingCursorDragState.Start:\n'
            '      _anchor = point.startLocation?.\$1 ?? Offset.zero;\n'
            '      _floating = true;\n'
            '      break;\n'
            '    case FloatingCursorDragState.Update:\n'
            '      final Offset delta = point.offset ?? Offset.zero;\n'
            '      _floatingPos = _anchor + delta;\n'
            '      break;\n'
            '    case FloatingCursorDragState.End:\n'
            '      _floating = false;\n'
            '      _commitCaret(_floatingPos);\n'
            '      break;\n'
            '  }\n'
            '  _redraw();\n'
            '}',
      ),
      _marginNote(
        'A slightly more luxurious implementation interpolates the '
        'caret position so the visual glides instead of jumping. Flutter '
        'does this in RenderEditable by lerping the cursor offset toward '
        'the Update target in the next frame.',
      ),
      _kvRow('FloatingCursorDragState.values', 'length 3'),
      _kvRow('FloatingCursorDragState.Start.name',
          '"Start" -- a literal capitalised label'),
      _kvRow('FloatingCursorDragState.Update.name', '"Update"'),
      _kvRow('FloatingCursorDragState.End.name', '"End"'),
    ],
  );

  print('Step 7: assembling Section 4 -- Constructor patterns and field '
      'semantics with the catalogue cards.');

  // ------------------------------------------------------------------------
  // SECTION 4 -- Constructor patterns and field semantics.
  // ------------------------------------------------------------------------
  final List<Widget> catalogueCards = <Widget>[];
  final List<String> catalogueCaptions = <String>[
    'canonical Start with anchor + zero offset',
    'plain Update with horizontal delta only',
    'bare End sample, fields all null',
    'Session A start: drag begins on word "the"',
    'Session A mid-drag: cursor halfway across the line',
    'Session A end: finger lifts after reaching "manuscript"',
    'Session B start: drag begins on second paragraph',
    'Session B mid-drag: heading toward edge of paragraph',
    'Session B peak: maximum distance from anchor',
    'Session B return: cursor recoils after overshoot',
    'Session B late return: nearly back at the anchor',
    'Session B end: finger lifts at the chosen position',
  ];
  final List<String> catalogueNarratives = <String>[
    'On a Start sample iOS commonly sends offset = (0, 0). The anchor '
    'lives in startLocation. The editor caches both pieces and shows '
    'a translucent floating cursor at the anchor.',
    'On Update, offset is the only field that matters. It is a delta '
    'from the anchor, not from the previous Update. The framework adds '
    'this delta to the cached anchor to find the floating-cursor pos.',
    'End is a notification, not a measurement. Both offset and '
    'startLocation are typically null. The framework hides the floating '
    'cursor and commits the projected caret to TextEditingValue.',
    'The first sample in Session A. Anchor caret is at offset 5 in '
    'the document, downstream affinity. iOS clears any prior selection '
    'before showing the floating cursor.',
    'A middle Update from Session A; finger has travelled 36 points '
    'from the anchor. The floating cursor is drawn at anchor + this '
    'delta.',
    'The closing End for Session A. The framework reads the last '
    'Update offset (110, 0) and commits the caret roughly 110 points '
    'right of the anchor.',
    'Session B opens deeper in the document; the anchor is at offset '
    '144 with upstream affinity, indicating the user pressed near the '
    'end of a soft-wrapped line.',
    'Mid-drag in Session B. Notice that offset is now both x AND y '
    'because the user is dragging diagonally toward a target on the '
    'next line.',
    'The peak of Session B. The user briefly overshoots the intended '
    'caret position before bringing the finger back. Editors that '
    'live-update the projected caret will paint this overshoot.',
    'A return Update; the offset has shrunk relative to the peak, so '
    'the floating cursor is now drifting back toward the anchor.',
    'A second return Update, very close to the original anchor. iOS '
    'often emits these "settling" samples to give the visual time to '
    'animate back.',
    'The End that closes Session B. The framework commits the caret '
    'at a point computed from the last Update; the brief overshoot is '
    'discarded.',
  ];

  for (int i = 0; i < catalogue.length; i++) {
    final RawFloatingCursorPoint p = catalogue[i];
    Color accent;
    if (p.state == FloatingCursorDragState.Start) {
      accent = cAccentSage;
    } else if (p.state == FloatingCursorDragState.End) {
      accent = cAccentRust;
    } else {
      accent = cSlateBlue;
    }
    catalogueCards.add(
      _samplePencilCard(
        index: i + 1,
        point: p,
        caption: catalogueCaptions[i],
        narrative: catalogueNarratives[i],
        accent: accent,
      ),
    );
  }

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S4', 'Constructor patterns and field semantics'),
      _proseBlock(
        'A RawFloatingCursorPoint is constructed only by the framework '
        'plumbing. As an editor author you never build one yourself in '
        'production code; you receive them. Tests, on the other hand, '
        'frequently mint instances by hand to drive a fake floating '
        'session. The catalogue below walks through twelve hand-crafted '
        'instances that illustrate every common shape iOS will send: '
        'three isolated singletons up top, then nine excerpted from the '
        'two traced sessions later in the notebook.',
      ),
      _codeCard(
        'common construction patterns',
        '// 1. Start with anchor + zero offset (most common)\n'
            'RawFloatingCursorPoint(\n'
            '  state: FloatingCursorDragState.Start,\n'
            '  offset: Offset.zero,\n'
            '  startLocation: (\n'
            '    Offset(120, 64),\n'
            '    TextPosition(offset: 17),\n'
            '  ),\n'
            ');\n\n'
            '// 2. Update with delta only\n'
            'RawFloatingCursorPoint(\n'
            '  state: FloatingCursorDragState.Update,\n'
            '  offset: Offset(48, 0),\n'
            ');\n\n'
            '// 3. End with no fields\n'
            'RawFloatingCursorPoint(\n'
            '  state: FloatingCursorDragState.End,\n'
            ');',
      ),
      _proseBlock(
        'Each card below shows the state badge, the offset, and the '
        'startLocation tuple if present. The miniature graphite grid in '
        'each card visualises the offset as a glowing dot relative to '
        'the centre crosshair. Marker positions are clamped to the grid '
        'so the visual stays inside the card; the textual coordinates '
        'are always honest.',
      ),
      const SizedBox(height: 6),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: catalogueCards,
      ),
    ],
  );

  print('Step 8: assembling Section 5 -- Traced session walkthrough.');

  // ------------------------------------------------------------------------
  // SECTION 5 -- Traced session walkthrough (Sessions A and B).
  // ------------------------------------------------------------------------
  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S5', 'Traced session walkthrough'),
      _proseBlock(
        'Two hand-fed sessions, traced sample by sample. Session A is a '
        'simple horizontal drag of the kind a user performs when they '
        'want to nudge the caret a few words right. Session B is a '
        'diagonal drag with a brief overshoot, common when reaching for '
        'a target on a different line.',
      ),
      _sessionTimelineCard(
        title: 'Session A -- horizontal drag, eight samples',
        subtitle: 'Anchor at offset 5; finger travels 110 points right '
            'before lifting. No vertical motion.',
        session: sessionA,
        accent: cSlateBlue,
      ),
      _proseBlock(
        'Session A is the cleanest possible case: one Start, six '
        'monotonically increasing Updates, one End. A simple editor can '
        'walk it with a switch statement. The mini path map shows the '
        'sample dots marching steadily to the right.',
      ),
      _sessionTimelineCard(
        title: 'Session B -- diagonal drag with overshoot',
        subtitle: 'Anchor at offset 144 with upstream affinity. The drag '
            'goes diagonally, peaks at sample #6, then returns.',
        session: sessionB,
        accent: cAccentRust,
      ),
      _proseBlock(
        'Session B is closer to a real user gesture. Note the dx '
        'climbing through samples 2-6 and then receding through samples '
        '7-8 before the End. RenderEditable smooths over this overshoot '
        'so the underlying caret never visibly jitters; only the '
        'floating cursor visual reaches the peak.',
      ),
      _marginNote(
        'On iPad with a Magic Keyboard the cursor sometimes emits a '
        'short trail of "settling" Update samples after the finger '
        'physically lifts; those samples are inertia-style smoothing '
        'inside the system itself. Treat them like any other Update; the '
        'subsequent End is still authoritative.',
      ),
      _codeCard(
        'walking a traced session in a unit test',
        'final List<RawFloatingCursorPoint> session = <RawFloatingCursorPoint>[\n'
            '  RawFloatingCursorPoint(state: Start, offset: Offset.zero,\n'
            '    startLocation: (Offset(60, 18), TextPosition(offset: 5))),\n'
            '  RawFloatingCursorPoint(state: Update, offset: Offset(8, 0)),\n'
            '  RawFloatingCursorPoint(state: Update, offset: Offset(20, 0)),\n'
            '  // ...\n'
            '  RawFloatingCursorPoint(state: End),\n'
            '];\n\n'
            'for (int i = 0; i < session.length; i++) {\n'
            '  client.updateFloatingCursor(session[i]);\n'
            '}\n'
            '// expect(controller.selection.baseOffset, equals(...));',
      ),
    ],
  );

  print('Step 9: assembling Section 6 -- Platform channel context.');

  // ------------------------------------------------------------------------
  // SECTION 6 -- Platform channel context.
  // ------------------------------------------------------------------------
  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S6', 'Platform channel: TextInput.onFloatingCursor'),
      _proseBlock(
        'On iOS the engine implements UITextInteraction\'s '
        'floating-cursor protocol. When the user long-presses the '
        'spacebar UIKit emits a sequence of UIFloatingCursor calls; the '
        'engine wraps each into a "TextInputClient.updateFloatingCursor" '
        'channel call carrying a small JSON-ish payload. The framework '
        'side decodes that payload back into a RawFloatingCursorPoint '
        'and dispatches it to the active TextInputClient.',
      ),
      _codeCard(
        'TextInputClient hook',
        'abstract class TextInputClient {\n'
            '  void updateFloatingCursor(RawFloatingCursorPoint point);\n'
            '  // ... other hooks: updateEditingValue, performAction, ...\n'
            '}',
      ),
      _channelTrace(
        name: 'Start sample',
        json: '{\n'
            '  "method": "TextInputClient.updateFloatingCursor",\n'
            '  "args": [\n'
            '    1,                       // textInputClient id\n'
            '    "FloatingCursorDragState.start",\n'
            '    {\n'
            '      "X": 0.0,\n'
            '      "Y": 0.0\n'
            '    }\n'
            '  ]\n'
            '}',
        decoded: 'RawFloatingCursorPoint(\n'
            '  state: FloatingCursorDragState.Start,\n'
            '  offset: Offset(0.0, 0.0),\n'
            '  startLocation: (Offset(120, 64),\n'
            '                  TextPosition(offset: 17)),\n'
            ')',
      ),
      _channelTrace(
        name: 'Update sample',
        json: '{\n'
            '  "method": "TextInputClient.updateFloatingCursor",\n'
            '  "args": [\n'
            '    1,\n'
            '    "FloatingCursorDragState.update",\n'
            '    {\n'
            '      "X": 48.0,\n'
            '      "Y": 0.0\n'
            '    }\n'
            '  ]\n'
            '}',
        decoded: 'RawFloatingCursorPoint(\n'
            '  state: FloatingCursorDragState.Update,\n'
            '  offset: Offset(48.0, 0.0),\n'
            '  startLocation: null,\n'
            ')',
      ),
      _channelTrace(
        name: 'End sample',
        json: '{\n'
            '  "method": "TextInputClient.updateFloatingCursor",\n'
            '  "args": [\n'
            '    1,\n'
            '    "FloatingCursorDragState.end",\n'
            '    {}\n'
            '  ]\n'
            '}',
        decoded: 'RawFloatingCursorPoint(\n'
            '  state: FloatingCursorDragState.End,\n'
            '  offset: null,\n'
            '  startLocation: null,\n'
            ')',
      ),
      _proseBlock(
        'The channel is one-way: the framework never sends '
        'RawFloatingCursorPoint values back to the platform. The flow is '
        'platform-driven; iOS decides exactly when each sample fires '
        'based on the touch rate of the underlying surface. On Pencil '
        'Pro on iPad you may see dozens of Updates per second; on a '
        'first-generation iPhone with the spacebar gesture you may see '
        'a much sparser stream.',
      ),
      _marginNote(
        'Android does not have an equivalent. The Android engine does '
        'send pointer events through TextInput, but UIFloatingCursor has '
        'no analogue. Cross-platform editors should treat '
        'updateFloatingCursor as iOS-only behaviour.',
      ),
    ],
  );

  print('Step 10: assembling Section 7 -- Responsive cursor visualisation.');

  // ------------------------------------------------------------------------
  // SECTION 7 -- Responsive cursor visualisation.
  // ------------------------------------------------------------------------
  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S7', 'Responsive cursor visualisation'),
      _proseBlock(
        'The cards below render a tiny editor canvas with a glowing '
        'cursor positioned by a single RawFloatingCursorPoint. The text '
        'is fixed lorem-style prose. The cursor colour reflects the '
        'state of the sample (sage for Start, slate for Update, rust '
        'for End). This is the moment where data becomes pixels.',
      ),
      _editorCanvas(
        title: 'Snapshot at sample #4 (Session A, sA4)',
        point: sA4,
        description: 'Mid-drag horizontal Update. The floating cursor '
            'sits roughly 36 points right of the anchor. The base caret '
            'is unchanged; it would only commit on End.',
      ),
      _editorCanvas(
        title: 'Snapshot at sample #6 (Session B peak, sB6)',
        point: sB6,
        description: 'The peak of the diagonal drag. The cursor has '
            'moved 120 points right and 22 down. RenderEditable\'s '
            'caret position projection would land on a different line.',
      ),
      _editorCanvas(
        title: 'Snapshot at sample #1 (Session A start, sA1)',
        point: sA1,
        description: 'A Start sample. The cursor is placed at the '
            'anchor itself; offset is (0, 0). The sage colouring marks '
            'the beginning of the session.',
      ),
      _editorCanvas(
        title: 'Snapshot at sample #9 (Session B end, sB9)',
        point: sB9,
        description: 'The End sample. With offset null, our visualisation '
            'draws the cursor at the anchor; in practice the framework '
            'commits the caret at the last Update target rather than the '
            'anchor.',
      ),
      _marginNote(
        'These canvases are deliberately static. A live editor would '
        'animate between cursor positions; we show snapshots so the '
        'reader can compare states without distraction.',
      ),
    ],
  );

  print('Step 11: assembling Section 8 -- Common UX scenarios.');

  // ------------------------------------------------------------------------
  // SECTION 8 -- Common UX scenarios.
  // ------------------------------------------------------------------------
  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S8', 'Common UX scenarios'),
      _proseBlock(
        'In the wild, the floating cursor appears in a small handful of '
        'recognisable shapes. Recognising the shape lets a custom editor '
        'tune its responsiveness: a single tap should not animate; a '
        'long drag should; a drag with overshoot should snap.',
      ),
      _scenarioCard(
        name: 'Single tap (degenerate session)',
        description: 'User briefly presses spacebar and lifts. iOS may '
            'emit a Start immediately followed by an End with no Update '
            'between. The editor should treat this as a no-op.',
        steps: <String>[
          'Start: anchor captured, offset (0, 0).',
          'End: floating cursor hidden, no caret commit needed.',
        ],
        accent: cAccentSage,
        icon: Icons.touch_app,
      ),
      _scenarioCard(
        name: 'Short horizontal drag',
        description: 'User wants to nudge the caret two or three '
            'characters left or right. Single Start, three or four '
            'Updates, single End.',
        steps: <String>[
          'Start: anchor at current caret.',
          'Update: offset (12, 0) -- finger nudges right.',
          'Update: offset (24, 0) -- continues right.',
          'Update: offset (32, 0) -- nearly there.',
          'End: caret commits at +32 offset from anchor.',
        ],
        accent: cSlateBlue,
        icon: Icons.swipe_right,
      ),
      _scenarioCard(
        name: 'Long horizontal drag (Session A shape)',
        description: 'User drags across most of a paragraph. Eight or '
            'more Updates, monotonic dx growth.',
        steps: <String>[
          'Start: anchor captured.',
          'Update: dx grows by ~10-30 points per frame.',
          'Update: dx grows; floating cursor crosses word boundaries.',
          'Update: dx still growing; mid-line.',
          'Update: dx near final value.',
          'End: caret commits at far right.',
        ],
        accent: cSlateBlue,
        icon: Icons.swipe,
      ),
      _scenarioCard(
        name: 'Drag with overshoot (Session B shape)',
        description: 'User drags past the intended target then comes '
            'back. Updates climb then recede; final End is past the '
            'recede point.',
        steps: <String>[
          'Start: anchor captured.',
          'Update: dx grows toward the target.',
          'Update: dx exceeds the target (overshoot).',
          'Update: dx shrinks (return).',
          'Update: dx near intended value.',
          'End: caret commits at the corrected position.',
        ],
        accent: cAccentRust,
        icon: Icons.swap_horiz,
      ),
      _scenarioCard(
        name: 'Lift-and-replace',
        description: 'User lifts the finger briefly and presses again '
            'within the spacebar gesture. iOS emits one full session '
            '(Start..End), then another full session immediately after.',
        steps: <String>[
          'Start (session 1): anchor captured.',
          'Update: small motion.',
          'End: session 1 closes; caret commits.',
          'Start (session 2): new anchor captured.',
          'Update: drag continues.',
          'End: session 2 closes; caret commits again.',
        ],
        accent: cAccentRust,
        icon: Icons.replay,
      ),
      _scenarioCard(
        name: 'Diagonal drag across line break',
        description: 'User drags both horizontally and vertically; the '
            'projected caret crosses a line boundary.',
        steps: <String>[
          'Start: anchor on line N.',
          'Update: offset (40, 4).',
          'Update: offset (80, 12).',
          'Update: offset (110, 22) -- now on line N+1.',
          'End: caret commits on line N+1.',
        ],
        accent: cSlateBlue,
        icon: Icons.straighten,
      ),
      _proseBlock(
        'Each scenario above maps directly onto the contract of '
        'RawFloatingCursorPoint. The class itself is intentionally '
        'thin; the richness lives in how iOS sequences the samples and '
        'how RenderEditable projects them onto the document. Your job '
        'as an editor author is to faithfully relay each sample into '
        'the projection, not to reinterpret the gesture.',
      ),
    ],
  );

  print('Step 12: assembling Section 9 -- Glossary, do/avoid, footer.');

  // ------------------------------------------------------------------------
  // SECTION 9 -- Glossary, do-avoid checklist, footer.
  // ------------------------------------------------------------------------
  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('S9', 'Glossary and best-practice checklist'),
      _glossaryItem('floating cursor',
          'An iOS-only translucent caret visual that follows the user\'s '
          'finger during a long-press-spacebar gesture. Independent of '
          'the underlying caret until commit.'),
      _glossaryItem('anchor',
          'The (Offset, TextPosition) pair captured at Start. All '
          'subsequent Update offsets are deltas from this anchor.'),
      _glossaryItem('TextPosition',
          'A logical caret position inside the document: an integer '
          'offset plus an affinity (upstream/downstream) for resolving '
          'positions at line wraps.'),
      _glossaryItem('TextAffinity.upstream',
          'When a TextPosition sits at a line boundary, upstream means '
          '"end of the previous line" rather than "start of the next".'),
      _glossaryItem('TextAffinity.downstream',
          'The default; positions resolve to the start of the next line '
          'at a line boundary.'),
      _glossaryItem('RenderEditable.setFloatingCursor',
          'The framework hook that paints the floating-cursor visual '
          'and projects the underlying caret while a session is active.'),
      _glossaryItem('TextInputClient.updateFloatingCursor',
          'The Dart-side entry point invoked by TextInput when the '
          'platform sends an updateFloatingCursor channel call.'),
      _glossaryItem('FloatingCursorDragState',
          'The companion enum carrying three constants: Start, Update, '
          'End. Used as the .state field of every sample.'),
      _glossaryItem('Offset?',
          'Nullable Offset. On Update samples this carries the delta '
          'from the anchor; on Start it is typically Offset.zero; on '
          'End it is null.'),
      _glossaryItem('startLocation',
          'A (Offset, TextPosition) record present on Start samples. '
          'Identifies where the anchor lives in the editor canvas and '
          'in the document.'),
      _doAvoid(
        'Do switch on point.state',
        'A simple switch on the three enum constants is the canonical '
        'shape of an updateFloatingCursor handler. It documents the '
        'protocol at a glance.',
        isDo: true,
      ),
      _doAvoid(
        'Do null-check offset and startLocation',
        'Both fields are nullable. End samples have both as null; '
        'Update samples have startLocation as null. Always guard.',
        isDo: true,
      ),
      _doAvoid(
        'Do treat End as authoritative',
        'A floating session may emit settling Updates after the user '
        'visually lifts the finger. Trust the End to mean "commit and '
        'stop"; do not synthesise your own.',
        isDo: true,
      ),
      _doAvoid(
        'Avoid mutating the enum',
        'FloatingCursorDragState has exactly three values. Do not add '
        'a fourth via inheritance hacks; the framework will not know '
        'how to dispatch it.',
        isDo: false,
      ),
      _doAvoid(
        'Avoid relying on offset on End',
        'iOS sends End with offset = null. Reading point.offset! on '
        'End throws. Cache the most recent Update offset if you need it.',
        isDo: false,
      ),
      _doAvoid(
        'Avoid blocking work in the handler',
        'updateFloatingCursor runs on the platform-message dispatch '
        'path. Heavy work here will choke the message pump and stall '
        'the gesture; defer to a microtask or Tick.',
        isDo: false,
      ),
      const SizedBox(height: 12),
      _proseBlock(
        'Final aside on testing. Because RawFloatingCursorPoint has no '
        'platform-side dependencies, unit tests can mint a session by '
        'hand and feed it directly to a TextInputClient. There is no '
        'need to spin up a fake platform channel; just call '
        'client.updateFloatingCursor(point) for each sample. The two '
        'sessions traced above are ready-made test fixtures: copy them '
        'into a test, drive them through your client, and assert on the '
        'resulting selection or caret.',
      ),
      const SizedBox(height: 8),
      _hatchStrip(color: cCinder, height: 8, count: 80, gap: 2.4),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cCinder,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.draw, color: cVellum, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Stylus Cinder, plate XXIII -- end of notebook.',
                style: TextStyle(
                  color: cVellum,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            Text(
              '${catalogue.length} samples + 2 sessions',
              style: TextStyle(
                color: cAccentChalk,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Step 13: composing the final scrollable notebook.');
  print('Notebook contains ${catalogue.length} catalogue cards plus two '
      'traced sessions of ${sessionA.length} and ${sessionB.length} '
      'samples respectively.');
  print('=== Stylus Cinder notebook assembled ===');

  // ------------------------------------------------------------------------
  // Compose the final notebook. SingleChildScrollView wraps the column so
  // tall content remains visible in the host harness.
  // ------------------------------------------------------------------------
  return Container(
    color: cVellum,
    padding: const EdgeInsets.all(14),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          const SizedBox(height: 14),
          Center(
            child: Text(
              'RawFloatingCursorPoint -- Stylus Cinder, plate XXIII',
              style: _captionStyle(color: cSmoke, size: 11),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
