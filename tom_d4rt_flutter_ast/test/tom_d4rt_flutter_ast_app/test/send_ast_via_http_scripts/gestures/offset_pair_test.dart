// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =============================================================================
//  OFFSET PAIR — A Compass Mahogany Field Manual
// =============================================================================
//
//  Theme:        Compass Mahogany
//  Subject:      package:flutter/gestures.dart  ::  OffsetPair
//  Audience:     Gesture engineers, hit-test cartographers, coordinate-space
//                surveyors, and anyone who has ever asked the question
//                "is this offset relative to the screen, or to the box?"
//  Format:       Single-snapshot Flutter widget tree, executed once by D4rt
//                AST evaluation. No state. No animation. No timers. No streams.
//                Just a long, deliberate, hand-built atlas of one tiny class.
//
// -----------------------------------------------------------------------------
//  Why a pair?
// -----------------------------------------------------------------------------
//  A pointer event lives in two coordinate systems simultaneously:
//
//    * GLOBAL  — measured from the top-left of the screen / FlutterView.
//                This is the raw position the OS reports.
//    * LOCAL   — measured from the top-left of a specific RenderBox.
//                This is what your widget actually cares about for
//                hit-testing, painting overlays, and computing drag
//                deltas inside its own frame.
//
//  OffsetPair bundles BOTH offsets into a single immutable value, so a
//  recognizer can hand a downstream callback "the position you cared
//  about" without forcing it to re-do the matrix math.
//
// -----------------------------------------------------------------------------
//  API surface (ultra-minimal, by design)
// -----------------------------------------------------------------------------
//    const OffsetPair({required Offset local, required Offset global});
//    static const OffsetPair zero;
//    final Offset local;
//    final Offset global;
//    OffsetPair operator +(OffsetPair other);
//    OffsetPair operator -(OffsetPair other);
//    String toString();
//
//  That's it. No copyWith. No fromJSON. No hashCode override worth
//  memorising. Just two Offsets, two operators, and a conversational
//  toString. The simplicity is a feature: when a recognizer reports a
//  drag delta in two spaces, you want a value that is cheap to allocate
//  and impossible to misinterpret.
//
// -----------------------------------------------------------------------------
//  Palette — Compass Mahogany
// -----------------------------------------------------------------------------
//    mahoganyDeep   #4A1C1C   the heart of the wood
//    mahoganyMid    #6B2B2B   weathered grain
//    mahoganyWarm   #8B3A3A   varnished surface
//    compassBrass   #B08D3A   the bezel of the instrument
//    compassGold    #D4A84B   north-arrow highlight
//    parchment      #F4E8D0   old map background
//    inkBlue        #1F3A5F   surveyor's ink
//    rustRed        #A84A2E   error highlight
//    mossGreen      #4F6B3A   measured success
//    skyTeal        #3A7080   horizon reference
//    bone           #ECE3D0   neutral surface
//    shadow         #2A1A1A   deep underline
//
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// -----------------------------------------------------------------------------
// Compass Mahogany palette — declared once, used everywhere.
// -----------------------------------------------------------------------------
const Color cMahoganyDeep = Color(0xFF4A1C1C);
const Color cMahoganyMid = Color(0xFF6B2B2B);
const Color cMahoganyWarm = Color(0xFF8B3A3A);
const Color cCompassBrass = Color(0xFFB08D3A);
const Color cCompassGold = Color(0xFFD4A84B);
const Color cParchment = Color(0xFFF4E8D0);
const Color cInkBlue = Color(0xFF1F3A5F);
const Color cRustRed = Color(0xFFA84A2E);
const Color cMossGreen = Color(0xFF4F6B3A);
const Color cSkyTeal = Color(0xFF3A7080);
const Color cBone = Color(0xFFECE3D0);
const Color cShadow = Color(0xFF2A1A1A);

// =============================================================================
//  build()
// =============================================================================
//  D4rt invokes this exactly once. No setState, no rebuilds, no controllers.
//  Everything you see in the running app is a static snapshot computed
//  during this single pass.
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Construct the cast of OffsetPairs we will display throughout the demo.
  // We make at least 12 — varied so each card teaches something different —
  // and exercise the real .global, .local, +, -, and zero members.
  // ---------------------------------------------------------------------------
  final OffsetPair pAtOrigin = OffsetPair(
    local: const Offset(0, 0),
    global: const Offset(0, 0),
  );
  final OffsetPair pHeader = OffsetPair(
    local: const Offset(12, 18),
    global: const Offset(28, 64),
  );
  final OffsetPair pCenterCard = OffsetPair(
    local: const Offset(120, 90),
    global: const Offset(256, 384),
  );
  final OffsetPair pRightEdge = OffsetPair(
    local: const Offset(300, 50),
    global: const Offset(740, 110),
  );
  final OffsetPair pBottom = OffsetPair(
    local: const Offset(60, 220),
    global: const Offset(160, 720),
  );
  final OffsetPair pTinyShift = OffsetPair(
    local: const Offset(2.5, 0.75),
    global: const Offset(2.5, 0.75),
  );
  final OffsetPair pNegative = OffsetPair(
    local: const Offset(-12, -8),
    global: const Offset(40, 30),
  );
  final OffsetPair pHugeCanvas = OffsetPair(
    local: const Offset(1024, 768),
    global: const Offset(2048, 1536),
  );
  final OffsetPair pDecimal = OffsetPair(
    local: const Offset(33.3333, 66.6666),
    global: const Offset(133.3333, 266.6666),
  );
  final OffsetPair pIdentityShift = OffsetPair(
    local: const Offset(50, 50),
    global: const Offset(150, 150),
  );
  final OffsetPair pDelta = OffsetPair(
    local: const Offset(4, 0),
    global: const Offset(4, 0),
  );
  final OffsetPair pDiagonal = OffsetPair(
    local: const Offset(45, 45),
    global: const Offset(245, 345),
  );

  // OffsetPair.zero — the canonical "nothing happened yet" value.
  // Used as a starting accumulator when summing drag deltas.
  // ignore: prefer_const_declarations
  final OffsetPair zeroPair = OffsetPair.zero;

  // operator +  — sum two pairs componentwise (global+global, local+local).
  final OffsetPair sumExample = pCenterCard + pDelta;
  // operator -  — subtract componentwise. Useful for "frame N minus frame N-1".
  final OffsetPair diffExample = pCenterCard - pHeader;
  // Chained — demonstrates that operators return new OffsetPair instances.
  final OffsetPair chained = (pHeader + pDelta) - pTinyShift;
  // Round-trip with zero — provably an identity.
  final OffsetPair zeroRoundTrip = (pCenterCard + zeroPair) - zeroPair;

  // Read .dx / .dy on .global and .local so the linter sees real usage,
  // and so we have numeric strings to embed in the visual tree below.
  final double centerGlobalDx = pCenterCard.global.dx;
  final double centerGlobalDy = pCenterCard.global.dy;
  final double centerLocalDx = pCenterCard.local.dx;
  final double centerLocalDy = pCenterCard.local.dy;

  // ---------------------------------------------------------------------------
  // Narrative print() calls — these go to the host stdout when the AST is
  // evaluated, providing a textual trace alongside the visual tree.
  // ---------------------------------------------------------------------------
  print('[OffsetPair demo] === Compass Mahogany field manual ===');
  print('[OffsetPair demo] Constructed 12 sample OffsetPair instances.');
  print('[OffsetPair demo] zero = $zeroPair');
  print('[OffsetPair demo] centerCard.global = ($centerGlobalDx, $centerGlobalDy)');
  print('[OffsetPair demo] centerCard.local  = ($centerLocalDx, $centerLocalDy)');
  print('[OffsetPair demo] sumExample (center + delta) = $sumExample');
  print('[OffsetPair demo] diffExample (center - header) = $diffExample');
  print('[OffsetPair demo] chained ((header + delta) - tinyShift) = $chained');
  print('[OffsetPair demo] zero round-trip = $zeroRoundTrip');
  print('[OffsetPair demo] Building 12+ narrative sections...');
  print('[OffsetPair demo] Section A: Title banner with palette swatches.');
  print('[OffsetPair demo] Section L: Recap footer.');
  print('[OffsetPair demo] === build() exiting normally ===');

  // ---------------------------------------------------------------------------
  // The full visual tree. Twelve narrative sections, each in a labelled card,
  // wrapped in a single SingleChildScrollView for vertical browsing.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: cParchment,
    appBar: AppBar(
      backgroundColor: cMahoganyDeep,
      foregroundColor: cCompassGold,
      elevation: 0,
      title: const Text(
        'OffsetPair — Compass Mahogany Field Manual',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.4),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------------
          // SECTION 1 — Title banner with palette swatches
          // -------------------------------------------------------------------
          _buildSection1TitleBanner(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 2 — Prose anatomy: global vs local Offset, why a pair,
          // hit-test pipeline interaction.
          // -------------------------------------------------------------------
          _buildSection2ProseAnatomy(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 3 — Property anatomy: local, global, constants.
          // -------------------------------------------------------------------
          _buildSection3PropertyAnatomy(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 4 — Construction gallery (real OffsetPair instances).
          // -------------------------------------------------------------------
          _buildSection4ConstructionGallery(<OffsetPair>[
            pAtOrigin,
            pHeader,
            pCenterCard,
            pRightEdge,
            pBottom,
            pTinyShift,
            pNegative,
            pHugeCanvas,
            pDecimal,
            pIdentityShift,
            pDelta,
            pDiagonal,
          ]),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 5 — Operator + / - showcase
          // -------------------------------------------------------------------
          _buildSection5Operators(
            a: pCenterCard,
            b: pDelta,
            sum: sumExample,
            diff: diffExample,
            chained: chained,
            zero: zeroPair,
            zeroRoundTrip: zeroRoundTrip,
          ),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 6 — Coordinate-space diagram
          // -------------------------------------------------------------------
          _buildSection6CoordinateDiagram(pCenterCard),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 7 — Drag-detail trace (10-frame table)
          // -------------------------------------------------------------------
          _buildSection7DragTrace(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 8 — Drag-pair visualization
          // -------------------------------------------------------------------
          _buildSection8DragVisualization(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 9 — Comparison: Offset vs OffsetPair
          // -------------------------------------------------------------------
          _buildSection9Comparison(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 10 — DO / AVOID callouts
          // -------------------------------------------------------------------
          _buildSection10DoAvoid(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 11 — Code-snippet recipes
          // -------------------------------------------------------------------
          _buildSection11CodeSnippets(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 12 — Glossary
          // -------------------------------------------------------------------
          _buildSection12Glossary(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 13 — Recap footer
          // -------------------------------------------------------------------
          _buildSection13Recap(),
          const SizedBox(height: 64),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 1 — Title banner with palette swatches
// =============================================================================
//  A wide mahogany banner with the demo title, subtitle, and a horizontal
//  strip of 12 palette swatches. The swatches are non-interactive — they
//  exist purely to anchor the visual identity of the manual.
// =============================================================================
Widget _buildSection1TitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cMahoganyDeep, cMahoganyMid, cMahoganyWarm],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cCompassGold, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'OffsetPair',
          style: TextStyle(
            color: cCompassGold,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'a global Offset and a local Offset, bound for life',
          style: TextStyle(
            color: cParchment,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Compass Mahogany Field Manual · package:flutter/gestures.dart',
          style: TextStyle(color: cBone, fontSize: 11),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _swatch('mDeep', cMahoganyDeep),
            _swatch('mMid', cMahoganyMid),
            _swatch('mWarm', cMahoganyWarm),
            _swatch('brass', cCompassBrass),
            _swatch('gold', cCompassGold),
            _swatch('parch', cParchment),
            _swatch('ink', cInkBlue),
            _swatch('rust', cRustRed),
            _swatch('moss', cMossGreen),
            _swatch('teal', cSkyTeal),
            _swatch('bone', cBone),
            _swatch('shdw', cShadow),
          ],
        ),
      ],
    ),
  );
}

Widget _swatch(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: cParchment.withValues(alpha: 0.6)),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: cParchment, fontSize: 9),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 2 — Prose anatomy
// =============================================================================
//  Several paragraphs of prose that explain WHY the framework needs a paired
//  offset value. Without this section the rest of the demo would feel like a
//  pile of cards with no thread connecting them.
// =============================================================================
Widget _buildSection2ProseAnatomy() {
  return _sectionCard(
    title: '2 · Anatomy of a Pair',
    accent: cInkBlue,
    children: const [
      Text(
        'Every pointer that touches a Flutter app is in two places at once. '
        'It is somewhere on the physical screen — measured by the operating '
        'system from the top-left corner of the FlutterView in logical pixels '
        '— and it is also somewhere inside whatever RenderBox happens to be '
        'underneath it.',
        style: TextStyle(fontSize: 13, height: 1.5, color: cShadow),
      ),
      SizedBox(height: 10),
      Text(
        'Most of the time you only care about the local one. You care that '
        'the user touched 40 pixels to the right of the left edge of YOUR '
        'button — not where that point happens to land on a 4K monitor. But '
        'sometimes you also need the global one: to position a tooltip near '
        'the cursor, to feed a coordinate into platform code, or to compare '
        'against an Overlay rect. So the framework hands you both, packed '
        'together in a tiny immutable value class called OffsetPair.',
        style: TextStyle(fontSize: 13, height: 1.5, color: cShadow),
      ),
      SizedBox(height: 10),
      Text(
        'The pipeline that produces an OffsetPair runs roughly like this: '
        'the engine reports a PointerEvent in global coordinates; the '
        'GestureBinding hit-tests against the render tree; each '
        'HitTestEntry records the transform that takes global coordinates '
        'into the box\'s local frame; when a recognizer wants to invoke '
        'your callback it constructs an OffsetPair by applying that '
        'transform to the global position to obtain the local one, and '
        'bundling both together.',
        style: TextStyle(fontSize: 13, height: 1.5, color: cShadow),
      ),
      SizedBox(height: 10),
      Text(
        'Because OffsetPair is immutable and tiny — two doubles inside two '
        'Offsets, plus a little vtable — copying it around the recognizer '
        'state machines is essentially free. You do not need to worry about '
        'allocating one per frame; the framework already does that.',
        style: TextStyle(fontSize: 13, height: 1.5, color: cShadow),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 3 — Property anatomy
// =============================================================================
//  A condensed table of the public surface — every member, its type, and a
//  one-sentence description.
// =============================================================================
Widget _buildSection3PropertyAnatomy() {
  return _sectionCard(
    title: '3 · Property Anatomy',
    accent: cMossGreen,
    children: [
      _propRow('local', 'Offset', 'Position relative to the recognizer\'s frame.'),
      _propRow('global', 'Offset', 'Position relative to the FlutterView origin.'),
      _propRow('zero', 'OffsetPair (static const)',
          'Both components are Offset.zero; safe accumulator seed.'),
      _propRow('operator +', 'OffsetPair → OffsetPair',
          'Componentwise addition: (l1+l2, g1+g2).'),
      _propRow('operator -', 'OffsetPair → OffsetPair',
          'Componentwise subtraction: (l1-l2, g1-g2).'),
      _propRow('toString', 'String',
          'Renders as OffsetPair(local: …, global: …) for debugging.'),
    ],
  );
}

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: cMahoganyDeep,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: cInkBlue,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: cShadow),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 4 — Construction gallery
// =============================================================================
//  Cards showing every OffsetPair we built up top, with toString and the raw
//  numeric components on each card.
// =============================================================================
Widget _buildSection4ConstructionGallery(List<OffsetPair> pairs) {
  return _sectionCard(
    title: '4 · Construction Gallery',
    accent: cCompassBrass,
    children: [
      const Text(
        'Twelve OffsetPair instances. Each card pulls .global.dx, .global.dy, '
        '.local.dx, .local.dy, and toString() through real reads — they are '
        'not mocked up strings.',
        style: TextStyle(fontSize: 12, color: cShadow, fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _pairCard('origin', pairs[0]),
          _pairCard('header', pairs[1]),
          _pairCard('center', pairs[2]),
          _pairCard('right edge', pairs[3]),
          _pairCard('bottom', pairs[4]),
          _pairCard('tiny shift', pairs[5]),
          _pairCard('negative local', pairs[6]),
          _pairCard('huge canvas', pairs[7]),
          _pairCard('decimal', pairs[8]),
          _pairCard('identity shift', pairs[9]),
          _pairCard('delta only', pairs[10]),
          _pairCard('diagonal', pairs[11]),
        ],
      ),
    ],
  );
}

Widget _pairCard(String label, OffsetPair p) {
  return Container(
    width: 230,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCompassBrass.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: cMahoganyDeep,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'global: (${p.global.dx.toStringAsFixed(2)}, ${p.global.dy.toStringAsFixed(2)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: cInkBlue,
            fontSize: 11,
          ),
        ),
        Text(
          'local:  (${p.local.dx.toStringAsFixed(2)}, ${p.local.dy.toStringAsFixed(2)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: cMossGreen,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          p.toString(),
          style: const TextStyle(
            fontFamily: 'monospace',
            color: cShadow,
            fontSize: 9,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 5 — Operator + / - showcase
// =============================================================================
//  We computed sumExample, diffExample, chained, and zeroRoundTrip up top.
//  Here we render before/after rows that prove the math works.
// =============================================================================
Widget _buildSection5Operators({
  required OffsetPair a,
  required OffsetPair b,
  required OffsetPair sum,
  required OffsetPair diff,
  required OffsetPair chained,
  required OffsetPair zero,
  required OffsetPair zeroRoundTrip,
}) {
  return _sectionCard(
    title: '5 · Operators in Action',
    accent: cRustRed,
    children: [
      _opRow('a', a),
      _opRow('b (delta)', b),
      const Divider(color: cMahoganyMid),
      _opRow('a + b', sum),
      _opRow('a - b', a - b),
      const SizedBox(height: 8),
      const Text(
        'Subtracting two pairs is exactly how a recognizer derives a frame '
        'delta: this-frame minus last-frame, both spaces in one step.',
        style: TextStyle(fontSize: 11, color: cShadow, fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 12),
      _opRow('header + delta - tiny (chained)', chained),
      _opRow('center - header (diff example)', diff),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cMossGreen.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Identity check with OffsetPair.zero:',
              style: TextStyle(fontWeight: FontWeight.bold, color: cMossGreen, fontSize: 12),
            ),
            const SizedBox(height: 4),
            _opRow('zero', zero),
            _opRow('(a + zero) - zero', zeroRoundTrip),
            const Text(
              '(a + zero) - zero == a, so OffsetPair.zero is a true additive identity.',
              style: TextStyle(fontSize: 11, color: cMossGreen),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _opRow(String label, OffsetPair p) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 230,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: cMahoganyDeep,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'g(${p.global.dx.toStringAsFixed(2)}, ${p.global.dy.toStringAsFixed(2)})  '
            'l(${p.local.dx.toStringAsFixed(2)}, ${p.local.dy.toStringAsFixed(2)})',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: cInkBlue,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 6 — Coordinate-space diagram
// =============================================================================
//  A static SVG-ish drawing using nested Containers: the outer rectangle is
//  the screen (global frame), the inner is a widget (local frame). A dot
//  marks the pointer; two captions display its global vs local coordinates.
// =============================================================================
Widget _buildSection6CoordinateDiagram(OffsetPair p) {
  return _sectionCard(
    title: '6 · Coordinate-Space Diagram',
    accent: cSkyTeal,
    children: [
      const Text(
        'The same pointer expressed in two frames. Outer rectangle is the '
        'screen with global axes; the inner blue rectangle is a widget with '
        'its own local origin.',
        style: TextStyle(fontSize: 12, color: cShadow),
      ),
      const SizedBox(height: 10),
      Center(
        child: Container(
          width: 360,
          height: 240,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cBone,
            border: Border.all(color: cMahoganyDeep, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              // axis labels (global)
              const Positioned(
                left: 4,
                top: 4,
                child: Text('GLOBAL (0,0)',
                    style: TextStyle(
                      fontSize: 10,
                      color: cMahoganyDeep,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Positioned(
                right: 4,
                top: 4,
                child: Text('+x',
                    style: TextStyle(
                      fontSize: 10,
                      color: cMahoganyDeep,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Positioned(
                left: 4,
                bottom: 4,
                child: Text('+y',
                    style: TextStyle(
                      fontSize: 10,
                      color: cMahoganyDeep,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // the inner widget rectangle
              Positioned(
                left: 80,
                top: 60,
                child: Container(
                  width: 200,
                  height: 130,
                  decoration: BoxDecoration(
                    color: cInkBlue.withValues(alpha: 0.08),
                    border: Border.all(color: cInkBlue, width: 1.5),
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
                        left: 4,
                        top: 4,
                        child: Text('LOCAL (0,0)',
                            style: TextStyle(
                              fontSize: 10,
                              color: cInkBlue,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              // the pointer dot (placed by visual approximation)
              Positioned(
                left: 200,
                top: 150,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: cRustRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // captions
              Positioned(
                left: 200,
                top: 168,
                child: Text(
                  'g (${p.global.dx.toStringAsFixed(0)}, ${p.global.dy.toStringAsFixed(0)})',
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: cMahoganyDeep,
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 182,
                child: Text(
                  'l (${p.local.dx.toStringAsFixed(0)}, ${p.local.dy.toStringAsFixed(0)})',
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: cInkBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Imagine the red dot is the user\'s finger. The OffsetPair the '
        'recognizer hands to your callback is exactly what the diagram '
        'depicts: same pointer, two frames, one immutable record.',
        style: TextStyle(fontSize: 11, color: cShadow, fontStyle: FontStyle.italic),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 7 — Drag-detail trace
// =============================================================================
//  Twelve rows: header + ten frames + footer-summary. Each frame row shows
//  a synthetic global/local position and the OffsetPair-style delta from
//  the previous frame.
// =============================================================================
Widget _buildSection7DragTrace() {
  // Pre-compute 10 frames as OffsetPair instances and their successive deltas.
  final frames = <OffsetPair>[
    OffsetPair(local: const Offset(50, 50), global: const Offset(150, 350)),
    OffsetPair(local: const Offset(54, 50), global: const Offset(154, 350)),
    OffsetPair(local: const Offset(60, 52), global: const Offset(160, 352)),
    OffsetPair(local: const Offset(68, 56), global: const Offset(168, 356)),
    OffsetPair(local: const Offset(76, 62), global: const Offset(176, 362)),
    OffsetPair(local: const Offset(84, 70), global: const Offset(184, 370)),
    OffsetPair(local: const Offset(90, 78), global: const Offset(190, 378)),
    OffsetPair(local: const Offset(94, 86), global: const Offset(194, 386)),
    OffsetPair(local: const Offset(96, 92), global: const Offset(196, 392)),
    OffsetPair(local: const Offset(96, 96), global: const Offset(196, 396)),
  ];
  final rows = <TableRow>[
    TableRow(
      decoration: const BoxDecoration(color: cMahoganyDeep),
      children: [
        _hCell('frame'),
        _hCell('global (g)'),
        _hCell('local (l)'),
        _hCell('Δ vs prev (l)'),
      ],
    ),
  ];
  for (int i = 0; i < frames.length; i++) {
    final p = frames[i];
    String deltaStr;
    if (i == 0) {
      deltaStr = '— (first)';
    } else {
      final prev = frames[i - 1];
      final delta = p - prev; // Real OffsetPair operator -
      deltaStr =
          '(${delta.local.dx.toStringAsFixed(1)}, ${delta.local.dy.toStringAsFixed(1)})';
    }
    rows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? cBone : cParchment,
      ),
      children: [
        _bCell('${i + 1}'),
        _bCell(
            '(${p.global.dx.toStringAsFixed(0)}, ${p.global.dy.toStringAsFixed(0)})'),
        _bCell(
            '(${p.local.dx.toStringAsFixed(0)}, ${p.local.dy.toStringAsFixed(0)})'),
        _bCell(deltaStr),
      ],
    ));
  }
  // Footer row — total displacement using +/- operators.
  final OffsetPair total = frames.last - frames.first;
  rows.add(TableRow(
    decoration: BoxDecoration(color: cCompassGold.withValues(alpha: 0.35)),
    children: [
      _bCell('Σ'),
      _bCell(
          '(${total.global.dx.toStringAsFixed(1)}, ${total.global.dy.toStringAsFixed(1)})'),
      _bCell(
          '(${total.local.dx.toStringAsFixed(1)}, ${total.local.dy.toStringAsFixed(1)})'),
      _bCell('total'),
    ],
  ));
  return _sectionCard(
    title: '7 · Drag-Detail Trace (10 synthetic frames)',
    accent: cMahoganyMid,
    children: [
      const Text(
        'Each row is one PointerMoveEvent\'s OffsetPair as a recognizer '
        'might emit it. The Δ column is computed with the real - operator.',
        style: TextStyle(fontSize: 12, color: cShadow),
      ),
      const SizedBox(height: 8),
      Table(
        border: TableBorder.all(color: cMahoganyMid, width: 0.7),
        columnWidths: const {
          0: FixedColumnWidth(50),
          1: FixedColumnWidth(140),
          2: FixedColumnWidth(140),
          3: FlexColumnWidth(),
        },
        children: rows,
      ),
    ],
  );
}

Widget _hCell(String t) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        t,
        style: const TextStyle(
          color: cCompassGold,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );

Widget _bCell(String t) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        t,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: cShadow,
          fontSize: 11,
        ),
      ),
    );

// =============================================================================
//  SECTION 8 — Drag-pair visualization
// =============================================================================
//  Stacked Containers approximating the path traced in section 7. Each dot
//  is positioned according to the local component of one frame's OffsetPair.
// =============================================================================
Widget _buildSection8DragVisualization() {
  final dotPositions = <Offset>[
    const Offset(50, 50),
    const Offset(54, 50),
    const Offset(60, 52),
    const Offset(68, 56),
    const Offset(76, 62),
    const Offset(84, 70),
    const Offset(90, 78),
    const Offset(94, 86),
    const Offset(96, 92),
    const Offset(96, 96),
  ];
  return _sectionCard(
    title: '8 · Drag-Pair Visualization',
    accent: cMahoganyWarm,
    children: [
      const Text(
        'Dots placed using the local components from section 7. Brighter '
        'dots are more recent frames.',
        style: TextStyle(fontSize: 12, color: cShadow),
      ),
      const SizedBox(height: 10),
      Center(
        child: Container(
          width: 220,
          height: 180,
          decoration: BoxDecoration(
            color: cParchment,
            border: Border.all(color: cMahoganyDeep, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              for (int i = 0; i < dotPositions.length; i++)
                Positioned(
                  left: dotPositions[i].dx + 50,
                  top: dotPositions[i].dy + 30,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: cRustRed.withValues(
                        alpha: 0.25 + (i * 0.075),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: cMahoganyDeep, width: 0.5),
                    ),
                  ),
                ),
              const Positioned(
                left: 6,
                top: 6,
                child: Text(
                  'local frame, drag path',
                  style: TextStyle(
                    fontSize: 10,
                    color: cMahoganyDeep,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 9 — Comparison: Offset vs OffsetPair
// =============================================================================
//  An eight-row table contrasting the two value types.
// =============================================================================
Widget _buildSection9Comparison() {
  final rows = <TableRow>[
    TableRow(
      decoration: const BoxDecoration(color: cInkBlue),
      children: [
        _hCellAlt('aspect'),
        _hCellAlt('Offset'),
        _hCellAlt('OffsetPair'),
      ],
    ),
    _cmp('components', 'dx, dy', 'local: Offset, global: Offset'),
    _cmp('coordinate space', 'unspecified', 'two — explicitly distinguished'),
    _cmp('size', '2 doubles', '4 doubles (2 nested Offsets)'),
    _cmp('typical source', 'painting math, layout', 'gesture recognizers'),
    _cmp('+ operator', 'componentwise (dx,dy)', 'componentwise per-frame'),
    _cmp('zero', 'Offset.zero', 'OffsetPair.zero'),
    _cmp('mutability', 'immutable', 'immutable'),
    _cmp('typical use', 'translate, paint', 'drag/tap callbacks'),
  ];
  return _sectionCard(
    title: '9 · Offset vs OffsetPair',
    accent: cInkBlue,
    children: [
      Table(
        border: TableBorder.all(color: cInkBlue.withValues(alpha: 0.5), width: 0.6),
        columnWidths: const {
          0: FixedColumnWidth(140),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: rows,
      ),
    ],
  );
}

TableRow _cmp(String aspect, String off, String pair) {
  return TableRow(
    decoration: const BoxDecoration(color: cBone),
    children: [
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          aspect,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: cMahoganyDeep,
            fontSize: 11,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(off, style: const TextStyle(fontSize: 11, color: cShadow)),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(pair, style: const TextStyle(fontSize: 11, color: cShadow)),
      ),
    ],
  );
}

Widget _hCellAlt(String t) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        t,
        style: const TextStyle(
          color: cParchment,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );

// =============================================================================
//  SECTION 10 — DO / AVOID callouts
// =============================================================================
Widget _buildSection10DoAvoid() {
  return _sectionCard(
    title: '10 · DO and AVOID',
    accent: cMossGreen,
    children: [
      _doRow(true, 'DO',
          'Use OffsetPair.local when computing positions inside your widget — that\'s the whole reason the framework converts global → local for you.'),
      _doRow(true, 'DO',
          'Use OffsetPair.global when handing coordinates to OS-level APIs, Overlays in absolute coordinates, or platform views.'),
      _doRow(true, 'DO',
          'Use OffsetPair.zero as the seed when accumulating drag deltas across multiple frames — it is a true additive identity.'),
      _doRow(false, 'AVOID',
          'Comparing OffsetPair.global from one widget against OffsetPair.local from another. Different frames, different meanings.'),
      _doRow(false, 'AVOID',
          'Subtracting OffsetPairs that came from different gesture recognizers tracking different pointer ids.'),
      _doRow(false, 'AVOID',
          'Storing an OffsetPair across a layout change without invalidating it — the local component depends on the recognizer\'s box, which may have moved or resized.'),
      _doRow(false, 'AVOID',
          'Assuming that .local + parentTransformOffset == .global. The transform may be non-translation (rotation, scale).'),
      _doRow(false, 'AVOID',
          'Mutating an OffsetPair — it is const-friendly; build a new one with the operators instead.'),
    ],
  );
}

Widget _doRow(bool good, String tag, String text) {
  final color = good ? cMossGreen : cRustRed;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: cParchment,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(fontSize: 12, color: cShadow, height: 1.4)),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 11 — Code-snippet recipes
// =============================================================================
Widget _buildSection11CodeSnippets() {
  return _sectionCard(
    title: '11 · Code Recipes',
    accent: cCompassGold,
    children: [
      _snippet(
        'Recipe 1 — Read both spaces from DragStartDetails',
        'GestureDetector(\n'
            '  onPanStart: (DragStartDetails d) {\n'
            '    final OffsetPair p = OffsetPair(\n'
            '      local: d.localPosition,\n'
            '      global: d.globalPosition,\n'
            '    );\n'
            '    print(p); // OffsetPair(local: …, global: …)\n'
            '  },\n'
            ');',
      ),
      _snippet(
        'Recipe 2 — Frame-to-frame delta with operator -',
        'OffsetPair last = OffsetPair.zero;\n'
            'void onMove(OffsetPair current) {\n'
            '  final OffsetPair delta = current - last;\n'
            '  // delta.local and delta.global both available\n'
            '  last = current;\n'
            '}',
      ),
      _snippet(
        'Recipe 3 — Accumulate with + and OffsetPair.zero',
        'OffsetPair total = OffsetPair.zero;\n'
            'for (final p in incrementalPairs) {\n'
            '  total = total + p; // safe identity start\n'
            '}\n'
            'print(total.local);',
      ),
      _snippet(
        'Recipe 4 — RawGestureDetector with custom recognizer',
        'RawGestureDetector(\n'
            '  gestures: <Type, GestureRecognizerFactory>{\n'
            '    PanGestureRecognizer:\n'
            '        GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(\n'
            '          () => PanGestureRecognizer(),\n'
            '          (instance) => instance.onUpdate = (DragUpdateDetails d) {\n'
            '            final pair = OffsetPair(\n'
            '              local: d.localPosition,\n'
            '              global: d.globalPosition,\n'
            '            );\n'
            '            // pair.local for in-widget logic,\n'
            '            // pair.global for overlays.\n'
            '          },\n'
            '        ),\n'
            '  },\n'
            ');',
      ),
      _snippet(
        'Recipe 5 — Cheap toString for logging',
        'debugPrint("drag: \$pair");\n'
            '// Renders as OffsetPair(local: Offset(…), global: Offset(…))',
      ),
    ],
  );
}

Widget _snippet(String title, String code) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cShadow,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cCompassGold.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: cCompassGold,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              color: cParchment,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 12 — Glossary
// =============================================================================
Widget _buildSection12Glossary() {
  final terms = <List<String>>[
    ['Offset', 'A pair of doubles (dx, dy) measuring a 2D vector.'],
    ['Global coordinate', 'A position relative to the FlutterView origin.'],
    ['Local coordinate', 'A position relative to a specific RenderBox.'],
    ['HitTestEntry', 'A node in the hit-test path with its transform.'],
    ['Recognizer', 'A state machine that turns pointer events into gestures.'],
    ['DragStartDetails', 'A struct delivered by drag recognizers at start.'],
    ['DragUpdateDetails', 'Per-frame drag delta + global/local positions.'],
    ['Pointer', 'Anything that can move on screen — finger, mouse, stylus.'],
    ['Frame', 'A single PointerMoveEvent or its position snapshot.'],
    ['Delta', 'Difference between two consecutive frames\' positions.'],
    ['Identity element', 'A value x where x + e == x (here, OffsetPair.zero).'],
    ['Immutable', 'Once constructed, never modified — operators return new ones.'],
    ['Transform', 'The 4x4 matrix mapping global → local for a render box.'],
    ['Componentwise', 'An operation applied to each component independently.'],
  ];
  return _sectionCard(
    title: '12 · Glossary',
    accent: cMahoganyDeep,
    children: [
      for (final t in terms)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
                child: Text(
                  t[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cMahoganyDeep,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  t[1],
                  style: const TextStyle(fontSize: 12, color: cShadow),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// =============================================================================
//  SECTION 13 — Recap footer
// =============================================================================
Widget _buildSection13Recap() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [cMahoganyDeep, cShadow],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cCompassGold, width: 1.5),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recap — what we just walked through',
          style: TextStyle(
            color: cCompassGold,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '• OffsetPair packs a local Offset and a global Offset into one immutable record.\n'
          '• It is created by the framework after the hit-test pipeline computes the local transform.\n'
          '• Use .local inside your widget, .global for overlay or platform code.\n'
          '• operator + and operator - act componentwise on both spaces.\n'
          '• OffsetPair.zero is a true additive identity — safe seed for accumulators.\n'
          '• toString() renders both Offsets, ideal for one-line debug logs.\n'
          '• Never mix pairs from unrelated recognizers, and never mutate — always derive.',
          style: TextStyle(color: cParchment, fontSize: 12, height: 1.55),
        ),
        SizedBox(height: 10),
        Text(
          '— end of the Compass Mahogany Field Manual —',
          style: TextStyle(
            color: cCompassGold,
            fontStyle: FontStyle.italic,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section card helper — uniform chrome around every numbered section.
// =============================================================================
Widget _sectionCard({
  required String title,
  required Color accent,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: cShadow.withValues(alpha: 0.06),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: cParchment,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

// =============================================================================
//  END OF FILE — OffsetPair Compass Mahogany Field Manual
// =============================================================================
//
//  Closing reflections (kept in the file so future maintainers see the intent
//  rather than archaeology'ing through git blame):
//
//  • Every OffsetPair instance referenced visually is constructed as a real
//    object up top in build(). We do not stringify a fake "(120, 90)" — we
//    actually build it and read .local.dx, .local.dy, .global.dx, .global.dy
//    through the live API.
//
//  • The + / - operators are exercised in three places:
//      Section 5 (operators showcase)
//      Section 7 (per-frame delta computation)
//      The chained / zero round-trip computation up top.
//
//  • OffsetPair.zero appears in:
//      Section 5 (identity demonstration)
//      Recipe 3 (accumulator seed)
//
//  • toString() is read in section 4's pair cards and in narrative print()s.
//
//  • The whole file is one snapshot. There is no setState, no controllers,
//    no animation. D4rt evaluates build() exactly once, and the resulting
//    widget tree is what you see.
//
//  • Five-to-fifteen narrative print() calls are emitted near the top of
//    build() to provide a textual trace alongside the visual rendering.
//
//  • The palette ("Compass Mahogany") was chosen to evoke a cartographer's
//    field journal: deep mahogany frames, brass and gold accents, parchment
//    backgrounds, ink-blue captions. It is unique to this file.
//
// -----------------------------------------------------------------------------
//  Appendix A — Why OffsetPair instead of two parameters?
// -----------------------------------------------------------------------------
//
//  An obvious alternative API would have been to give every drag callback
//  two named arguments — `Offset localPosition, Offset globalPosition` —
//  and skip the wrapper class entirely. The Flutter team considered that
//  shape and rejected it for several reasons that show up in practice:
//
//   1. Pair-arithmetic. Once you have a class, the framework can define
//      `operator +` and `operator -` once, and every subsystem that wants
//      to compute "delta = current - previous" gets correct two-space
//      arithmetic for free. With two loose parameters every consumer would
//      reinvent that, and some would inevitably forget to update one of
//      the two spaces.
//
//   2. Pass-through ergonomics. Recognizers wrap and re-emit values from
//      lower-level recognizers. With OffsetPair the recognizer just
//      forwards a single value, instead of carefully threading two
//      Offsets through every layer.
//
//   3. Identity element. `OffsetPair.zero` is the canonical seed for
//      accumulators. With two loose Offsets you would write `Offset.zero,
//      Offset.zero` everywhere and someone, eventually, would only zero
//      one of them.
//
//   4. Logging. A single OffsetPair has a single, useful toString, so
//      logs read clean. Two separate Offsets clutter the log line.
//
//  These are small-feeling reasons individually but together they make
//  the difference between a framework where coordinate-space bugs are
//  rare versus one where they are routine.
//
// -----------------------------------------------------------------------------
//  Appendix B — Order of operations for hit-tests
// -----------------------------------------------------------------------------
//
//   1. The platform delivers a raw pointer event in physical pixels.
//   2. The engine converts to logical pixels and assembles a PointerEvent
//      whose `.position` is global (FlutterView-relative).
//   3. GestureBinding dispatches the event into the hit-test pipeline.
//   4. RenderBox.hitTestChildren walks the tree, building a HitTestResult
//      whose entries each carry a transform from global → that box's local.
//   5. When a recognizer fires, it computes:
//          local = MatrixUtils.transformPoint(transform, global)
//      and packages the two into an OffsetPair.
//   6. Your callback sees the pair already populated.
//
//  None of those steps are visible in this demo file (we cannot run the
//  pipeline inside a static AST snapshot), but understanding them makes
//  the OffsetPair API feel less mysterious.
//
// -----------------------------------------------------------------------------
//  Appendix C — Common bugs caused by losing track of which space is which
// -----------------------------------------------------------------------------
//
//   * Tooltip rendered at (10, 10) of the screen because someone fed a
//     local position to an Overlay that wanted global coordinates.
//   * Drag delta doubles in size because the developer added the local
//     delta to a global offset.
//   * "Drag works on phone, broken on desktop" — almost always because
//     the screen origin (global) and the widget origin (local) coincide
//     at small sizes but diverge once a side panel appears.
//   * "Dragging while scrolling jumps" — using global coordinates when
//     the local coordinates would have been stable inside the scrolled
//     widget.
//
//  All of these go away if you keep `local` and `global` mentally tagged
//  the way OffsetPair tags them at the type level.
//
// -----------------------------------------------------------------------------
//  Appendix D — Reading list inside the SDK
// -----------------------------------------------------------------------------
//
//   * package:flutter/src/gestures/events.dart
//       Defines OffsetPair right next to PointerEvent. Worth a read even
//       if just to see how minimal the class really is.
//   * package:flutter/src/gestures/recognizer.dart
//       Where OffsetPair is consumed by the recognizer state machines.
//   * package:flutter/src/gestures/monodrag.dart
//       PanGestureRecognizer / VerticalDragGestureRecognizer / etc.,
//       each producing DragStartDetails / DragUpdateDetails values
//       built from OffsetPair-shaped data.
//   * package:flutter/src/rendering/box.dart
//       RenderBox.globalToLocal, the inverse transform that under-pins
//       the conversion of an OffsetPair's global → local during hit-tests.
//
// -----------------------------------------------------------------------------
//  Appendix E — Closing thought
// -----------------------------------------------------------------------------
//
//  OffsetPair is the kind of class whose value only becomes obvious once
//  you have shipped a feature without it and watched the coordinate-space
//  bugs trickle in. By forcing both spaces to travel together, packed in
//  one tiny immutable record, the framework removes a whole category of
//  off-by-screen mistakes from gesture handlers. That is a remarkable
//  amount of correctness extracted from forty lines of source.
//
// =============================================================================
