// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// ---------------------------------------------------------------------------
// PointerScaleEvent  -  Deep Visual Reference  -  "Magnifier Brass"
// ---------------------------------------------------------------------------
// PointerScaleEvent is a low-level pointer signal generated when the user
// performs a pinch-to-zoom (two-finger trackpad scale) gesture on platforms
// that surface scale signals as pointer events. Unlike the higher-level
// ScaleGestureRecognizer (which composes multiple touch points and emits
// ScaleStartDetails / ScaleUpdateDetails / ScaleEndDetails) PointerScaleEvent
// arrives as a single discrete signal carrying the multiplicative scale
// factor relative to the previous frame.
//
// This file is hand-authored as a static, fully declarative reference page
// for human readers and AST round-trip tests. It contains no state, no
// mutation, no animation, no async work. Everything you see is a snapshot.
//
// Palette: "Magnifier Brass"
//   - brassDeep      #5A4214   bezel rim
//   - brassMid       #8C6A1A   ring highlight
//   - brassLight     #C9A24A   focal lens
//   - brassPale      #F4E4B0   parchment surface
//   - lensInk        #1B140A   engraving / glyph ink
//   - cobaltAccent   #2A4D8F   cool counterpoint (for measurement axes)
//   - sageVerdigris  #6E8C6A   patina (gauge resting band)
//   - emberRust      #B0532A   alert hue (pitfall callouts)
//   - parchmentMute  #E7D49A   panel surface
//   - shadowVellum   #B59A55   subtle separator
//
// Theme: trackpad lensmaker. We treat each scale value as the magnification
// of a hand-ground brass loupe; the parchment beneath bears engraved tick
// marks. Pinch gestures turn the lens; the page is a reference catalog for
// the loupe-maker's apprentice.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF4E4B0),
    appBar: AppBar(
      backgroundColor: const Color(0xFF5A4214),
      foregroundColor: const Color(0xFFF4E4B0),
      elevation: 0,
      title: const Text(
        'PointerScaleEvent  -  Magnifier Brass Reference',
        style: TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeroCard(),
          const SizedBox(height: 28),
          _buildSectionHeader('1', 'API Surface'),
          const SizedBox(height: 12),
          _buildApiSurfaceTable(),
          const SizedBox(height: 28),
          _buildSectionHeader('2', 'Scale-Value Gallery'),
          const SizedBox(height: 12),
          _buildScaleGallery(),
          const SizedBox(height: 28),
          _buildSectionHeader('3', 'Constructed Snapshots'),
          const SizedBox(height: 12),
          _buildConstructedSnapshots(),
          const SizedBox(height: 28),
          _buildSectionHeader('4', 'Pinch Gesture Timing Diagram'),
          const SizedBox(height: 12),
          _buildTimingDiagram(),
          const SizedBox(height: 28),
          _buildSectionHeader('5', 'Comparison Matrix'),
          const SizedBox(height: 12),
          _buildComparisonMatrix(),
          const SizedBox(height: 28),
          _buildSectionHeader('6', 'Platform Notes'),
          const SizedBox(height: 12),
          _buildPlatformNotes(),
          const SizedBox(height: 28),
          _buildSectionHeader('7', 'Scenario Panels'),
          const SizedBox(height: 12),
          _buildScenarioPanels(),
          const SizedBox(height: 28),
          _buildSectionHeader('8', 'Pitfalls'),
          const SizedBox(height: 12),
          _buildPitfallsPanel(),
          const SizedBox(height: 28),
          _buildSectionHeader('9', 'Decision Flowchart'),
          const SizedBox(height: 12),
          _buildDecisionFlowchart(),
          const SizedBox(height: 28),
          _buildSectionHeader('10', 'Glossary'),
          const SizedBox(height: 12),
          _buildGlossary(),
          const SizedBox(height: 28),
          _buildSectionHeader('11', 'Palette Swatches'),
          const SizedBox(height: 12),
          _buildPaletteSwatches(),
          const SizedBox(height: 28),
          _buildClosingColophon(),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero card
// ---------------------------------------------------------------------------

Widget _buildHeroCard() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFF5A4214), width: 2),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1B140A).withValues(alpha: 0.18),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ),
    padding: const EdgeInsets.all(22),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildHeroLensBadge(),
        const SizedBox(width: 22),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'PointerScaleEvent',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  color: Color(0xFF1B140A),
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'package:flutter/gestures.dart',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                  color: Color(0xFF5A4214),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'A low-level pointer signal carrying a multiplicative scale '
                'factor produced by trackpad pinch gestures. Distinct from '
                'ScaleUpdateDetails (high-level) and PointerPanZoomUpdateEvent '
                '(combined pan+zoom+rotate).',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: Color(0xFF1B140A),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildHeroChip('extends PointerSignalEvent'),
                  _buildHeroChip('immutable'),
                  _buildHeroChip('multiplicative scale'),
                  _buildHeroChip('per-frame delta'),
                  _buildHeroChip('macOS / Linux / Web'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeroLensBadge() {
  return Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          const Color(0xFFF4E4B0),
          const Color(0xFFC9A24A),
          const Color(0xFF8C6A1A),
          const Color(0xFF5A4214),
        ],
        stops: const [0.0, 0.55, 0.85, 1.0],
      ),
      border: Border.all(color: const Color(0xFF5A4214), width: 3),
    ),
    alignment: Alignment.center,
    child: const Text(
      '*1.25',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Color(0xFF1B140A),
      ),
    ),
  );
}

Widget _buildHeroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFFC9A24A).withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFF8C6A1A)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1B140A),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------

Widget _buildSectionHeader(String number, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF5A4214),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC9A24A), width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFFF4E4B0),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B140A),
            letterSpacing: 0.4,
          ),
        ),
      ),
      Container(
        height: 2,
        width: 60,
        color: const Color(0xFF8C6A1A),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 1. API surface table
// ---------------------------------------------------------------------------

Widget _buildApiSurfaceTable() {
  final List<List<String>> rows = [
    ['timeStamp', 'Duration', 'Time at which the event was generated, relative to engine start.'],
    ['pointer', 'int', 'Identifier for the pointer device. Stable across the life of a contact.'],
    ['kind', 'PointerDeviceKind', 'trackpad / mouse / stylus / touch. Scale typically arrives as trackpad.'],
    ['device', 'int', 'Embedder device id. Distinguishes physical trackpads on multi-device hosts.'],
    ['position', 'Offset', 'Logical pixel position of the pointer when the scale signal arrived.'],
    ['localPosition', 'Offset', 'Position in the coordinate space of the receiver. Defaults to position.'],
    ['scale', 'double', 'Multiplicative scale factor since the previous signal. 1.0 means unchanged.'],
    ['embedderId', 'int', 'Engine-supplied identifier when synthesised from a platform gesture.'],
    ['original', 'PointerEvent?', 'If this event was transformed, the untransformed source event.'],
    ['transform', 'Matrix4?', 'Transformation applied to compute localPosition.'],
  ];
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      border: Border.all(color: const Color(0xFF5A4214), width: 1.4),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildApiHeaderRow(),
        for (int i = 0; i < rows.length; i++)
          _buildApiBodyRow(rows[i][0], rows[i][1], rows[i][2], i),
      ],
    ),
  );
}

Widget _buildApiHeaderRow() {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFF5A4214),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: const [
        SizedBox(
          width: 140,
          child: Text(
            'field',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFFF4E4B0),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(
          width: 160,
          child: Text(
            'type',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFFF4E4B0),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'description',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFFF4E4B0),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiBodyRow(String field, String type, String desc, int index) {
  final Color zebra = index.isEven
      ? const Color(0xFFF4E4B0)
      : const Color(0xFFE7D49A);
  return Container(
    color: zebra,
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            field,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B140A),
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          width: 160,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFF2A4D8F),
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: Color(0xFF1B140A),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 2. Scale-value gallery (with AlwaysStoppedAnimation gauges)
// ---------------------------------------------------------------------------

Widget _buildScaleGallery() {
  final List<double> scales = [0.5, 0.8, 1.0, 1.25, 1.5, 2.0, 3.0];
  final List<String> labels = [
    'pinch in (heavy)',
    'pinch in (light)',
    'identity',
    'pinch out (light)',
    'pinch out (medium)',
    'pinch out (heavy)',
    'pinch out (extreme)',
  ];
  final List<Widget> tiles = [];
  for (int i = 0; i < scales.length; i++) {
    tiles.add(_buildScaleGalleryTile(scales[i], labels[i]));
  }
  return Wrap(
    spacing: 14,
    runSpacing: 14,
    children: tiles,
  );
}

Widget _buildScaleGalleryTile(double scale, String label) {
  // Map scale 0.0 .. 3.0 onto a 0..1 gauge fraction; identity sits at 1/3.
  final double gaugeFraction = (scale / 3.0).clamp(0.0, 1.0);
  final AlwaysStoppedAnimation<double> gaugeAnim =
      AlwaysStoppedAnimation<double>(gaugeFraction);
  final AlwaysStoppedAnimation<double> ringAnim =
      AlwaysStoppedAnimation<double>(scale.clamp(0.0, 3.0) / 3.0);
  return Container(
    width: 220,
    decoration: BoxDecoration(
      color: const Color(0xFFF4E4B0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF8C6A1A), width: 1.4),
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'scale = ${scale.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: Color(0xFF1B140A),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: scale < 1.0
                    ? const Color(0xFF6E8C6A).withValues(alpha: 0.4)
                    : (scale > 1.0
                        ? const Color(0xFFB0532A).withValues(alpha: 0.4)
                        : const Color(0xFFC9A24A).withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                scale < 1.0 ? 'in' : (scale > 1.0 ? 'out' : 'id'),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B140A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF5A4214),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        _buildGauge(gaugeAnim),
        const SizedBox(height: 10),
        _buildLensRing(ringAnim, scale),
        const SizedBox(height: 10),
        _buildScaleEffectLine(scale),
      ],
    ),
  );
}

Widget _buildGauge(AlwaysStoppedAnimation<double> anim) {
  return Container(
    height: 16,
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFF8C6A1A)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: anim.value,
        heightFactor: 1.0,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFC9A24A),
                Color(0xFF8C6A1A),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildLensRing(AlwaysStoppedAnimation<double> anim, double scale) {
  final double diameter = 30 + (anim.value * 50);
  return Center(
    child: Container(
      width: 90,
      height: 60,
      alignment: Alignment.center,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF4E4B0),
          border: Border.all(
            color: const Color(0xFF5A4214),
            width: 2 + (anim.value * 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8C6A1A).withValues(alpha: 0.4),
              blurRadius: 5,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '${(scale * 100).toInt()}%',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1B140A),
          ),
        ),
      ),
    ),
  );
}

Widget _buildScaleEffectLine(double scale) {
  String effect;
  if (scale < 0.7) {
    effect = 'fast zoom-out';
  } else if (scale < 1.0) {
    effect = 'gentle zoom-out';
  } else if (scale == 1.0) {
    effect = 'no change';
  } else if (scale < 1.3) {
    effect = 'gentle zoom-in';
  } else if (scale < 2.0) {
    effect = 'medium zoom-in';
  } else {
    effect = 'rapid zoom-in';
  }
  return Text(
    'effect: $effect',
    style: const TextStyle(
      fontSize: 11.5,
      color: Color(0xFF2A4D8F),
      fontFamily: 'monospace',
    ),
  );
}

// ---------------------------------------------------------------------------
// 3. Constructed snapshots (try/catch around PointerScaleEvent)
// ---------------------------------------------------------------------------

Widget _buildConstructedSnapshots() {
  final List<Widget> cards = [];
  final List<List<dynamic>> recipes = [
    [const Duration(milliseconds: 100), const Offset(120, 80), 1.05, 'frame 1'],
    [const Duration(milliseconds: 116), const Offset(122, 79), 1.08, 'frame 2'],
    [const Duration(milliseconds: 132), const Offset(125, 81), 1.12, 'frame 3'],
    [const Duration(milliseconds: 148), const Offset(127, 80), 1.10, 'frame 4'],
    [const Duration(milliseconds: 164), const Offset(128, 80), 1.04, 'frame 5'],
    [const Duration(milliseconds: 180), const Offset(128, 80), 1.00, 'frame 6'],
  ];
  for (int i = 0; i < recipes.length; i++) {
    cards.add(_buildSnapshotCard(
      recipes[i][0] as Duration,
      recipes[i][1] as Offset,
      recipes[i][2] as double,
      recipes[i][3] as String,
    ));
  }
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: cards,
  );
}

Widget _buildSnapshotCard(
    Duration ts, Offset pos, double scale, String label) {
  String status;
  String repr;
  try {
    final PointerScaleEvent ev = PointerScaleEvent(
      timeStamp: ts,
      kind: PointerDeviceKind.trackpad,
      device: 1,
      position: pos,
      scale: scale,
      embedderId: 42,
    );
    status = 'ok';
    repr = 'ts=${ev.timeStamp.inMilliseconds}ms  '
        'pos=(${ev.position.dx.toStringAsFixed(1)},'
        '${ev.position.dy.toStringAsFixed(1)})  '
        'scale=${ev.scale.toStringAsFixed(3)}';
  } catch (e) {
    status = 'err';
    repr = e.toString();
  }
  return Container(
    width: 240,
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: status == 'ok'
            ? const Color(0xFF6E8C6A)
            : const Color(0xFFB0532A),
        width: 1.4,
      ),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: Color(0xFF1B140A),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: status == 'ok'
                    ? const Color(0xFF6E8C6A).withValues(alpha: 0.4)
                    : const Color(0xFFB0532A).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B140A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          repr,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF1B140A),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 4. Pinch gesture timing diagram (ASCII)
// ---------------------------------------------------------------------------

Widget _buildTimingDiagram() {
  const String diagram =
      '    t (ms)  0    16    32    48    64    80    96   112   128   144\n'
      '            |     |     |     |     |     |     |     |     |     |\n'
      '   pinch -- v --> v --> v --> v --> v --> v --> v --> v --> v --> .\n'
      '   begin    o     -     -     -     -     -     -     -     -     o end\n'
      '   scale  1.00  1.05  1.08  1.12  1.10  1.04  1.02  1.01  1.00  ----\n'
      '   sig     .     S     S     S     S     S     S     S     S     .\n'
      '   pos    (0,0)   .....drift.....                     stable\n'
      '\n'
      'Legend:  S = PointerScaleEvent signal,  o = synthetic begin/end frame\n'
      '         scale is multiplicative *per signal*, never absolute.\n'
      '         Cumulative magnification = product of all observed scales.\n';
  return _buildAsciiPanel(diagram);
}

Widget _buildAsciiPanel(String text) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1B140A),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFC9A24A), width: 1.5),
    ),
    padding: const EdgeInsets.all(16),
    child: SelectableText(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: Color(0xFFF4E4B0),
        height: 1.4,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 5. Comparison matrix
// ---------------------------------------------------------------------------

Widget _buildComparisonMatrix() {
  final List<List<String>> rows = [
    [
      'level',
      'pointer signal',
      'pointer signal',
      'gesture recognizer',
    ],
    [
      'class',
      'PointerScaleEvent',
      'PointerPanZoomUpdateEvent',
      'ScaleUpdateDetails',
    ],
    [
      'value type',
      'double scale',
      'double scale + Offset pan + double rotation',
      'double scale + Offset focal + double rotation',
    ],
    [
      'multiplicative',
      'yes (delta per signal)',
      'yes (delta per signal)',
      'no (absolute since start)',
    ],
    [
      'pan included',
      'no',
      'yes',
      'yes (focalPoint)',
    ],
    [
      'rotation included',
      'no',
      'yes',
      'yes',
    ],
    [
      'arena participation',
      'no (signal)',
      'no (signal)',
      'yes (claims wins)',
    ],
    [
      'typical source',
      'macOS/Linux trackpad pinch',
      'pan-zoom platform gesture',
      'composed touch / mouse drag / trackpad',
    ],
    [
      'when to use',
      'low-level scale-only listeners',
      'compound trackpad gestures',
      'high-level zoomable widgets',
    ],
  ];
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF5A4214), width: 1.4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rows.length; i++)
          _buildComparisonRow(rows[i], i == 0, i.isEven),
      ],
    ),
  );
}

Widget _buildComparisonRow(List<String> cells, bool isHeader, bool zebra) {
  final Color bg = isHeader
      ? const Color(0xFF5A4214)
      : (zebra
          ? const Color(0xFFF4E4B0)
          : const Color(0xFFE7D49A));
  final Color fg = isHeader
      ? const Color(0xFFF4E4B0)
      : const Color(0xFF1B140A);
  return Container(
    color: bg,
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            cells[0],
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: isHeader ? FontWeight.w800 : FontWeight.w700,
              color: fg,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            cells[1],
            style: TextStyle(
              fontFamily: 'monospace',
              color: fg,
              fontSize: 12,
              fontWeight:
                  isHeader ? FontWeight.w800 : FontWeight.w400,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            cells[2],
            style: TextStyle(
              fontFamily: 'monospace',
              color: fg,
              fontSize: 12,
              fontWeight:
                  isHeader ? FontWeight.w800 : FontWeight.w400,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            cells[3],
            style: TextStyle(
              fontFamily: 'monospace',
              color: fg,
              fontSize: 12,
              fontWeight:
                  isHeader ? FontWeight.w800 : FontWeight.w400,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 6. Platform notes (macOS / Linux / Windows)
// ---------------------------------------------------------------------------

Widget _buildPlatformNotes() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildPlatformCard(
        'macOS Trackpad',
        'Magic Trackpad / built-in MacBook trackpad',
        const Color(0xFF2A4D8F),
        [
          'Two-finger pinch surfaces as native scale signals via NSEvent '
              'magnification.',
          'Scale factor is delta per frame (multiplicative). A typical '
              'pinch generates 8 to 30 signals.',
          'momentumPhase is exposed via the parent PointerPanZoomEvent '
              'family; PointerScaleEvent itself is leaner.',
          'Inertia continues firing signals after fingers lift, decaying '
              'toward 1.0 over ~150ms.',
          'Behaves consistently in both windowed and fullscreen apps.',
        ],
      ),
      const SizedBox(height: 12),
      _buildPlatformCard(
        'Linux Two-Finger',
        'libinput / Wayland / X11',
        const Color(0xFF6E8C6A),
        [
          'libinput synthesises pinch via gesture-recognition on touchpad '
              'devices that support semi-multitouch.',
          'Some older drivers emit only mouse-wheel events with Ctrl held; '
              'these arrive as PointerScrollEvent, not PointerScaleEvent.',
          'Synaptics-style driver chains often rely on edge gestures and '
              'will not produce scale signals at all.',
          'Wayland generally yields cleaner scale signal streams than X11.',
          'Test on the target distro: behaviour varies by compositor.',
        ],
      ),
      const SizedBox(height: 12),
      _buildPlatformCard(
        'Windows Precision Touchpad',
        'PTP-class touchpad / High Precision driver',
        const Color(0xFFB0532A),
        [
          'Precision touchpads emit native pinch via WM_POINTER. Older '
              'standard touchpads do not.',
          'Flutter Windows surfaces these as PointerPanZoomUpdateEvent '
              '(combined). PointerScaleEvent is used less often on '
              'Windows than on macOS.',
          'Some hardware reports zoom only when the OS gesture mapping is '
              'set to "Pinch to zoom" rather than custom.',
          'Browser (Web) on Windows: gesture events depend on browser; '
              'Chrome forwards as wheel + ctrl synthesis.',
        ],
      ),
      const SizedBox(height: 12),
      _buildPlatformCard(
        'Web / Browser',
        'Flutter Web embedding',
        const Color(0xFF8C6A1A),
        [
          'Most browsers expose pinch as a synthetic wheel event with '
              'ctrlKey=true; the engine translates this to a scale signal.',
          'Safari on macOS additionally surfaces gesturechange events '
              'with native scale, which yield smoother signals.',
          'On mobile Web, multi-touch pinch is recognised by the embedder '
              'and forwarded as PointerPanZoomUpdateEvent rather than '
              'PointerScaleEvent.',
          'Always verify on the actual target browser; behaviour is '
              'inconsistent across engines.',
        ],
      ),
    ],
  );
}

Widget _buildPlatformCard(
    String title, String subtitle, Color accent, List<String> bullets) {
  final List<Widget> lines = [];
  for (int i = 0; i < bullets.length; i++) {
    lines.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              bullets[i],
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF1B140A),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF4E4B0),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.4),
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Color(0xFF1B140A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5A4214),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...lines,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 7. Scenario panels
// ---------------------------------------------------------------------------

Widget _buildScenarioPanels() {
  final List<List<String>> scenarios = [
    [
      'Image Zoom',
      'Photo viewer / gallery thumbnail',
      'Listen for PointerScaleEvent on a Listener around the Image. '
          'Multiply a stored scale double by event.scale (clamped).',
      'Use Transform.scale or InteractiveViewer to apply. Keep clamping '
          'between sensible min and max (e.g. 0.5x .. 8x).',
      'Consider snapping to 1.0x when within 5% to defeat trackpad jitter.',
    ],
    [
      'Map Pinch',
      'Tile-based map (lat/lon zoom levels)',
      'Translate scale into a logarithmic zoomLevel delta: deltaLevel = '
          'log2(event.scale). Add to current zoom level.',
      'Anchor zoom around event.localPosition so the geographic point '
          'under the pinch stays put.',
      'Throttle tile requests during rapid scaling to avoid network thrash.',
    ],
    [
      'Pinch-to-Collapse',
      'Card list, dismissable header',
      'Use scale below 1.0 as a collapse signal. Cumulative product < '
          '0.7 -> trigger collapse animation.',
      'Treat scale > 1.0 as a no-op (or expand) so the gesture is '
          'asymmetric.',
      'Reset cumulative scale on a synthetic end frame (scale ~ 1.0 '
          'with momentum decay).',
    ],
    [
      'Doc Reader Zoom',
      'PDF / e-book viewer',
      'Apply scale to a 2D matrix transform on the page widget tree. '
          'Pre-cache adjacent zoom levels.',
      'Disable text reflow during active scaling; reflow once on settle.',
      'Use embedderId to disambiguate multiple trackpads on docking '
          'station setups.',
    ],
    [
      'Diagram Editor',
      'Vector / node graph canvas',
      'Convert event.scale into a CanvasTransform delta. Anchor on '
          'localPosition so nodes under cursor remain anchored.',
      'Combine with PointerPanZoomUpdateEvent for the full pan+zoom '
          'experience instead of using PointerScaleEvent alone.',
      'Render guides at integer zoom multipliers (50%, 100%, 200%).',
    ],
    [
      'Game Mini-map',
      'Strategy / city-builder UI',
      'Treat each scale signal as a discrete +/- step on a quantised '
          'zoom ladder.',
      'Quantise the delta: any |scale-1| < 0.05 ignored; >0.05 -> step.',
      'This avoids floating-point drift on long pinch sessions.',
    ],
  ];
  final List<Widget> cards = [];
  for (int i = 0; i < scenarios.length; i++) {
    cards.add(_buildScenarioCard(scenarios[i]));
  }
  return Wrap(
    spacing: 14,
    runSpacing: 14,
    children: cards,
  );
}

Widget _buildScenarioCard(List<String> data) {
  return Container(
    width: 360,
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF8C6A1A), width: 1.4),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFC9A24A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF5A4214)),
              ),
              alignment: Alignment.center,
              child: const Text(
                '@',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B140A),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Color(0xFF1B140A),
                    ),
                  ),
                  Text(
                    data[1],
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF5A4214),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildScenarioBullet('signal', data[2]),
        const SizedBox(height: 6),
        _buildScenarioBullet('apply', data[3]),
        const SizedBox(height: 6),
        _buildScenarioBullet('tip', data[4]),
      ],
    ),
  );
}

Widget _buildScenarioBullet(String tag, String body) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        margin: const EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
          color: const Color(0xFF5A4214),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          tag,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.5,
            color: Color(0xFFF4E4B0),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          body,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF1B140A),
            height: 1.45,
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 8. Pitfalls
// ---------------------------------------------------------------------------

Widget _buildPitfallsPanel() {
  final List<List<String>> pitfalls = [
    [
      'Treating scale as absolute',
      'event.scale is the multiplicative delta since the previous signal, '
          'not the absolute zoom level. Multiply it into a stored '
          'cumulative value.',
      'Maintain a `double cumulative = 1.0;` and update '
          '`cumulative *= event.scale;` on each signal.',
    ],
    [
      'Forgetting to clamp',
      'Without clamping, a runaway pinch can push scale to 1e8 or 1e-9, '
          'making layout break and causing texture upload spikes.',
      'Clamp cumulative to a sane range like (0.05, 64.0) and snap near '
          '1.0 to defeat float drift.',
    ],
    [
      'Anchor drift',
      'Applying scale around the widget centre instead of '
          'event.localPosition makes the content under the cursor escape.',
      'Compose a scale-about-point matrix: translate to localPosition, '
          'scale, translate back.',
    ],
    [
      'Mixing with ScaleGestureRecognizer',
      'Both will fire for the same trackpad pinch on some platforms, '
          'producing double-applied zoom.',
      'Pick one. Use Listener+PointerScaleEvent OR a GestureDetector with '
          'onScaleUpdate, never both on the same subtree.',
    ],
    [
      'Assuming fixed signal cadence',
      'Signal frequency varies wildly: 8..120Hz on macOS, sometimes '
          'bursty on X11. Algorithms based on signal count are fragile.',
      'Drive logic from cumulative scale value, not from event count.',
    ],
    [
      'Ignoring momentum tail',
      'After fingers lift, more signals arrive as inertial decay. Code '
          'that "snaps to grid" on first signal misses these.',
      'Treat the gesture as ongoing until a quiet window of >100ms with '
          'no signals.',
    ],
    [
      'Using scale below 0',
      'scale is always positive. A negative or zero scale indicates a '
          'malformed event and should be ignored or logged.',
      'Guard with `if (event.scale > 0) { ... }` before applying.',
    ],
    [
      'Passing scale to setState every frame',
      'On rapid signals (120Hz) this rebuilds the entire tree. Cheap '
          'in dev, painful on weak GPUs.',
      'Throttle, batch into a vsync tick, or bind via a ValueNotifier '
          'and AnimatedBuilder to localise rebuilds.',
    ],
  ];
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (int i = 0; i < pitfalls.length; i++)
        _buildPitfallEntry(i + 1, pitfalls[i][0], pitfalls[i][1], pitfalls[i][2]),
    ],
  );
}

Widget _buildPitfallEntry(int index, String title, String desc, String fix) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFF4E4B0),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFB0532A), width: 1.4),
    ),
    padding: const EdgeInsets.all(14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFB0532A),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '!$index',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFFF4E4B0),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  color: Color(0xFF1B140A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF1B140A),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF6E8C6A).withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'fix: $fix',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1B140A),
                    fontFamily: 'monospace',
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 9. Decision flowchart (ASCII)
// ---------------------------------------------------------------------------

Widget _buildDecisionFlowchart() {
  const String flow =
      '             +-------------------------------------+\n'
      '             |  user pinches on trackpad / touch   |\n'
      '             +-------------------------------------+\n'
      '                              |\n'
      '                              v\n'
      '             +-------------------------------------+\n'
      '             | does the gesture include pan or     |\n'
      '             | rotation as well as scale?          |\n'
      '             +-------------------------------------+\n'
      '                  |                       |\n'
      '              yes |                       | no\n'
      '                  v                       v\n'
      '   +------------------------+   +-----------------------+\n'
      '   | use                    |   | only scale needed?    |\n'
      '   | PointerPanZoom* events |   +-----------------------+\n'
      '   | OR ScaleGestureRecog.  |        |          |\n'
      '   +------------------------+   yes  |          | no\n'
      '                                     v          v\n'
      '                +----------------------+   +----------------------+\n'
      '                | low-level direct?    |   | reuse existing widget|\n'
      '                +----------------------+   | InteractiveViewer    |\n'
      '                       |          |        +----------------------+\n'
      '                   yes |          | no\n'
      '                       v          v\n'
      '   +-----------------------+   +-----------------------+\n'
      '   | Listener + onPointer  |   | GestureDetector +     |\n'
      '   | Signal -> PointerScale|   | onScaleUpdate (high)  |\n'
      '   +-----------------------+   +-----------------------+\n'
      '\n'
      'Rule of thumb:\n'
      '  - PointerScaleEvent: low-level, scale-only, raw delta.\n'
      '  - PointerPanZoomUpdateEvent: trackpad combined gesture.\n'
      '  - ScaleUpdateDetails: high-level absolute, multi-touch.\n';
  return _buildAsciiPanel(flow);
}

// ---------------------------------------------------------------------------
// 10. Glossary
// ---------------------------------------------------------------------------

Widget _buildGlossary() {
  final List<List<String>> entries = [
    [
      'PointerSignalEvent',
      'Abstract base for non-routed pointer signals (scale, scroll, '
          'pan-zoom). Delivered to the widget under the cursor without '
          'gesture arena participation.',
    ],
    [
      'pointer signal',
      'A pointer event that is dispatched to a hit-tested target without '
          'going through the gesture arena. PointerScaleEvent is one.',
    ],
    [
      'gesture arena',
      'The Flutter mechanism by which competing gesture recognisers '
          'agree on a winner. Pointer signals bypass it.',
    ],
    [
      'multiplicative scale',
      'A scale factor that, when multiplied with a running cumulative, '
          'gives the new size. 1.0 means unchanged.',
    ],
    [
      'momentum / inertia',
      'Continued signals after physical gesture release, decaying back '
          'toward identity. Common on macOS trackpads.',
    ],
    [
      'embedderId',
      'A platform-channel-supplied identifier for the original event. '
          'Useful for distinguishing devices and for engine debugging.',
    ],
    [
      'localPosition',
      'The position of the pointer in the receiving widget\'s '
          'coordinate space, after any transform.',
    ],
    [
      'PointerDeviceKind',
      'Enum: touch, mouse, stylus, trackpad, invertedStylus, unknown. '
          'For PointerScaleEvent, expect trackpad.',
    ],
    [
      'identity scale',
      'scale == 1.0; the gesture conveys no zoom for this frame. May '
          'still imply that a gesture is ongoing.',
    ],
    [
      'snap-to-1',
      'A heuristic that rounds cumulative scale to 1.0 if it lies '
          'within a small epsilon, fighting trackpad jitter at rest.',
    ],
    [
      'trackpad pinch',
      'Two-finger, mostly opposed motion on a trackpad surface, '
          'producing a sequence of scale signals.',
    ],
    [
      'jank',
      'Visible stutter caused by missed frame deadlines. Heavy '
          'rebuild-per-signal logic in scale handlers is a common cause.',
    ],
  ];
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFE7D49A),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF5A4214), width: 1.4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < entries.length; i++)
          _buildGlossaryEntry(entries[i][0], entries[i][1], i.isEven),
      ],
    ),
  );
}

Widget _buildGlossaryEntry(String term, String defn, bool zebra) {
  return Container(
    color: zebra
        ? const Color(0xFFF4E4B0)
        : const Color(0xFFE7D49A),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            term,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              color: Color(0xFF5A4214),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            defn,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF1B140A),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 11. Palette swatches
// ---------------------------------------------------------------------------

Widget _buildPaletteSwatches() {
  final List<List<dynamic>> swatches = [
    ['brassDeep', 0xFF5A4214, 'bezel rim - section headers, dark borders'],
    ['brassMid', 0xFF8C6A1A, 'ring highlight - panel borders'],
    ['brassLight', 0xFFC9A24A, 'focal lens - chips, accent fills'],
    ['brassPale', 0xFFF4E4B0, 'parchment surface - page background'],
    ['lensInk', 0xFF1B140A, 'engraving / glyph ink - body text'],
    ['cobaltAccent', 0xFF2A4D8F, 'cool counterpoint - measurement / types'],
    ['sageVerdigris', 0xFF6E8C6A, 'patina - gauge resting band, success'],
    ['emberRust', 0xFFB0532A, 'alert hue - pitfalls, warnings'],
    ['parchmentMute', 0xFFE7D49A, 'panel surface - cards'],
    ['shadowVellum', 0xFFB59A55, 'subtle separator'],
  ];
  final List<Widget> tiles = [];
  for (int i = 0; i < swatches.length; i++) {
    tiles.add(_buildPaletteTile(
      swatches[i][0] as String,
      Color(swatches[i][1] as int),
      swatches[i][2] as String,
    ));
  }
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: tiles,
  );
}

Widget _buildPaletteTile(String name, Color color, String role) {
  // Compute approximate luminance to pick a legible label colour.
  final double luminance = color.computeLuminance();
  final Color labelColor = luminance > 0.5
      ? const Color(0xFF1B140A)
      : const Color(0xFFF4E4B0);
  final String hex =
      '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  return Container(
    width: 220,
    decoration: BoxDecoration(
      color: const Color(0xFFF4E4B0),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF8C6A1A)),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF5A4214)),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            hex,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: labelColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            fontSize: 13,
            color: Color(0xFF1B140A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF5A4214),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Closing colophon
// ---------------------------------------------------------------------------

Widget _buildClosingColophon() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1B140A),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFC9A24A), width: 2),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'colophon',
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Color(0xFFC9A24A),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Hand-set in Magnifier Brass for the Tom workspace AST round-trip '
          'corpus. Every section above is static and constant: no '
          'StatefulWidget, no setState, no animation controllers, no async. '
          'Each scale-value gauge is materialised through a single '
          'AlwaysStoppedAnimation snapshot, ensuring the visual reflects '
          'one deterministic frame.',
          style: TextStyle(
            color: Color(0xFFF4E4B0),
            fontSize: 13,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'PointerScaleEvent  -  scale is multiplicative, never '
                'absolute. Multiply, clamp, anchor, snap.',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  color: const Color(0xFFF4E4B0).withValues(alpha: 0.85),
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 1.5,
          color: const Color(0xFF8C6A1A),
        ),
        const SizedBox(height: 10),
        const Text(
          'end of reference.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFC9A24A),
          ),
        ),
      ],
    ),
  );
}
