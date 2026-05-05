// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  TEXT SELECTION TOOLBAR ANCHORS  --  A Pin Saffron Cartographer's Manual
// =============================================================================
//
//  Theme:        Pin Saffron
//  Subject:      package:flutter/widgets.dart  ::  TextSelectionToolbarAnchors
//  Audience:     Cartographers of the editing layer, surveyors of glyph
//                rectangles, the brave souls who must position a floating
//                toolbar above (or below) a selection that the user just
//                gestured at, and anyone who has ever wondered why a
//                selection toolbar lands in a place that seems entirely
//                arbitrary.
//
//  Format:       One-shot Flutter widget tree. D4rt evaluates build() once.
//                There is no Stateful widget, no AnimationController, no
//                Scroll or TextEditing controllers, and no asynchronous
//                machinery. Just a long, deliberately quiet snapshot of
//                eleven cards pinned to a cork-board.
//
// -----------------------------------------------------------------------------
//  Why a separate "anchors" type?
// -----------------------------------------------------------------------------
//  When a user selects text, three pieces of layout truth exist at once:
//
//    * the global rectangle of the editing region (where the field is on
//      screen, in Overlay coordinates);
//    * the start and end glyph baselines plus their heights, returned by
//      the render object as TextSelectionPoints;
//    * the available room above and below the selection inside the
//      Overlay's safe area.
//
//  The selection toolbar layout machinery does not want any of those raw
//  values directly. It wants two simpler points:
//
//    * primaryAnchor   -- the position the toolbar should prefer, usually
//                          just above the top of the selection;
//    * secondaryAnchor -- a fallback position to use if the primary
//                          doesn't have enough room above it; usually just
//                          below the bottom of the selection.
//
//  TextSelectionToolbarAnchors bundles those two points into a tiny
//  immutable record. AdaptiveTextSelectionToolbar then asks the layout
//  delegate "is there room above primary?" If yes, place the toolbar
//  there. If no, fall back to secondary. The class is the contract
//  between the geometry of the selection and the placement of the
//  toolbar.
//
// -----------------------------------------------------------------------------
//  Public surface
// -----------------------------------------------------------------------------
//
//      const TextSelectionToolbarAnchors({
//        required Offset primaryAnchor,
//        Offset? secondaryAnchor,
//      });
//
//      factory TextSelectionToolbarAnchors.fromSelection({
//        required RenderBox renderBox,
//        required double startGlyphHeight,
//        required double endGlyphHeight,
//        required List<TextSelectionPoint> selectionEndpoints,
//      });
//
//      final Offset primaryAnchor;
//      final Offset? secondaryAnchor;
//
//  That's it. Two fields, one constructor, one factory. The factory
//  encapsulates the "find the top-center of the selection rectangle"
//  arithmetic that every adaptive toolbar would otherwise reinvent.
//
// -----------------------------------------------------------------------------
//  Pin Saffron palette
// -----------------------------------------------------------------------------
//    saffronPin       #E5A030   pin head -- saturated saffron yellow
//    saffronDeep      #B07A18   pin shadow side
//    saffronGlow      #F4C766   highlighted pin lacquer
//    corkLight        #D9B984   weathered cork board
//    corkMid          #B59264   cork knot, slightly darker
//    corkDeep         #7E5C32   cork shadow under a pin
//    twineCream       #E9DBB7   twine line crossing the board
//    twineKnot        #8C6F3A   knot in the twine
//    inkUmber         #3E2A14   hand-lettered marginalia ink
//    parchmentMap     #F4E8C8   the map paper itself
//    sealRed          #9C3A20   wax seal accent
//    leafGreen        #6F7A2A   pressed-leaf accent
//    skyBlue          #5A7390   waterway / sky reference colour
//    pinShadow        #3D2A14   the dark side of every pin
//
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Pin Saffron palette -- one declaration, used everywhere below.
// -----------------------------------------------------------------------------
const Color cSaffronPin = Color(0xFFE5A030);
const Color cSaffronDeep = Color(0xFFB07A18);
const Color cSaffronGlow = Color(0xFFF4C766);
const Color cCorkLight = Color(0xFFD9B984);
const Color cCorkMid = Color(0xFFB59264);
const Color cCorkDeep = Color(0xFF7E5C32);
const Color cTwineCream = Color(0xFFE9DBB7);
const Color cTwineKnot = Color(0xFF8C6F3A);
const Color cInkUmber = Color(0xFF3E2A14);
const Color cParchmentMap = Color(0xFFF4E8C8);
const Color cSealRed = Color(0xFF9C3A20);
const Color cLeafGreen = Color(0xFF6F7A2A);
const Color cSkyBlue = Color(0xFF5A7390);
const Color cPinShadow = Color(0xFF3D2A14);

// =============================================================================
//  build()
// =============================================================================
//  D4rt invokes this exactly once. We construct every TextSelectionToolbarAnchors
//  instance up front, exercise the real .primaryAnchor and .secondaryAnchor
//  properties on each, and feed the resulting numbers into the visual cards.
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // SAMPLE ANCHORS
  //
  // We construct fourteen distinct TextSelectionToolbarAnchors instances.
  // Each one represents a different real-world selection scenario: a single
  // word in the middle of a paragraph, a multi-line selection that wraps,
  // a tap-without-selection caret position, an edge-clamped selection at
  // the top of the editing region, etc.
  //
  // All values are in *global* (Overlay) coordinate space, since the
  // factory `fromSelection` clamps and translates points into the global
  // frame using the RenderBox's localToGlobal transform.
  // ---------------------------------------------------------------------------

  // Anchor 1: a tidy single-line word selection in the middle of a card.
  final anchorMidWord = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(160, 220),
    secondaryAnchor: const Offset(160, 252),
  );

  // Anchor 2: a caret-only "tap" with no selection -- both anchors
  // coincide, because the selection rectangle is degenerate.
  final anchorCaret = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(96, 140),
    secondaryAnchor: const Offset(96, 140),
  );

  // Anchor 3: selection at the very top of the editing region. The
  // primaryAnchor was clamped to the top edge, leaving secondaryAnchor
  // below the selection.
  final anchorTopClamp = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(140, 60),
    secondaryAnchor: const Offset(140, 92),
  );

  // Anchor 4: selection at the bottom of the editing region. Primary
  // is high above, secondary clamps to the bottom edge.
  final anchorBottomClamp = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(150, 380),
    secondaryAnchor: const Offset(150, 410),
  );

  // Anchor 5: a wide multi-line selection. The center column lands on
  // an unrelated x because the selection wraps -- the factory averages
  // the start and end glyph rects.
  final anchorMultiLine = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(220, 180),
    secondaryAnchor: const Offset(220, 270),
  );

  // Anchor 6: secondary anchor omitted entirely (null). This happens
  // when the editing region is tall enough that the primary will
  // always fit -- the toolbar code knows it never needs to fall back.
  final anchorOnlyPrimary = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(120, 240),
  );

  // Anchor 7: a tiny one-character selection near the leading edge.
  final anchorLeadingEdge = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(28, 200),
    secondaryAnchor: const Offset(28, 232),
  );

  // Anchor 8: a tiny one-character selection near the trailing edge.
  final anchorTrailingEdge = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(372, 200),
    secondaryAnchor: const Offset(372, 232),
  );

  // Anchor 9: a centred selection in a tall editor (lots of room
  // above and below).
  final anchorRoomy = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(200, 160),
    secondaryAnchor: const Offset(200, 200),
  );

  // Anchor 10: a tightly cramped selection in a one-line text field
  // (very little vertical room).
  final anchorCramped = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(180, 36),
    secondaryAnchor: const Offset(180, 60),
  );

  // Anchor 11: a selection inside a scrolled view; the global
  // coordinates are large because the editing region is far down.
  final anchorScrolled = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(160, 720),
    secondaryAnchor: const Offset(160, 760),
  );

  // Anchor 12: a fractional-pixel anchor (reflects sub-pixel layout).
  final anchorFractional = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(123.45, 234.78),
    secondaryAnchor: const Offset(123.45, 268.12),
  );

  // Anchor 13: anchors that demonstrate primary-equals-secondary
  // when the user collapsed the selection (shrunk to a caret).
  final anchorCollapsed = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(244, 188),
    secondaryAnchor: const Offset(244, 188),
  );

  // Anchor 14: a primary at the absolute origin -- the degenerate
  // case useful for unit tests of the layout delegate.
  final anchorOrigin = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(0, 0),
    secondaryAnchor: const Offset(0, 32),
  );

  // ---------------------------------------------------------------------------
  // Synthetic TextSelectionPoints. We hand-build several of these to mimic
  // what the framework would compute. Each point has a Point coordinate (in
  // the local/editing region frame) and an optional TextDirection.
  // ---------------------------------------------------------------------------

  final pointStartSimple = TextSelectionPoint(
    const Offset(20, 40),
    TextDirection.ltr,
  );
  final pointEndSimple = TextSelectionPoint(
    const Offset(160, 40),
    TextDirection.ltr,
  );
  final pointStartWrapped = TextSelectionPoint(
    const Offset(60, 60),
    TextDirection.ltr,
  );
  final pointEndWrapped = TextSelectionPoint(
    const Offset(220, 120),
    TextDirection.ltr,
  );
  final pointStartRtl = TextSelectionPoint(
    const Offset(220, 80),
    TextDirection.rtl,
  );
  final pointEndRtl = TextSelectionPoint(
    const Offset(40, 80),
    TextDirection.rtl,
  );

  // ---------------------------------------------------------------------------
  // Narrative print() trace -- these go to the host stdout when D4rt
  // evaluates this build() pass.
  // ---------------------------------------------------------------------------
  print('[Pin Saffron] === TextSelectionToolbarAnchors field manual ===');
  print('[Pin Saffron] Constructed 14 anchor instances.');
  print(
      '[Pin Saffron] anchorMidWord.primary = ${anchorMidWord.primaryAnchor}, secondary = ${anchorMidWord.secondaryAnchor}');
  print(
      '[Pin Saffron] anchorCaret.primary = ${anchorCaret.primaryAnchor}, secondary = ${anchorCaret.secondaryAnchor}');
  print(
      '[Pin Saffron] anchorOnlyPrimary.primary = ${anchorOnlyPrimary.primaryAnchor}, secondary = ${anchorOnlyPrimary.secondaryAnchor}');
  print(
      '[Pin Saffron] anchorScrolled (in scrolled view) primary = ${anchorScrolled.primaryAnchor}');
  print(
      '[Pin Saffron] anchorFractional has sub-pixel components dx=${anchorFractional.primaryAnchor.dx}, dy=${anchorFractional.primaryAnchor.dy}');
  print(
      '[Pin Saffron] TextSelectionPoints built: start ${pointStartSimple.point}, end ${pointEndSimple.point}');
  print(
      '[Pin Saffron] RTL points: start ${pointStartRtl.point} (${pointStartRtl.direction}), end ${pointEndRtl.point} (${pointEndRtl.direction})');
  print(
      '[Pin Saffron] runtimeType check: ${anchorMidWord.runtimeType}');
  print('[Pin Saffron] Building 11 cork-board sections...');
  print('[Pin Saffron] === build() exiting normally ===');

  // ---------------------------------------------------------------------------
  // Compose the full visual tree. Eleven cork-board cards inside a single
  // SingleChildScrollView. Each card is a numbered "pin" on the board.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: cCorkLight,
    appBar: AppBar(
      backgroundColor: cCorkDeep,
      foregroundColor: cSaffronGlow,
      elevation: 0,
      title: const Text(
        'TextSelectionToolbarAnchors -- Pin Saffron Cartographer\'s Manual',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.4),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------------
          // SECTION 1 -- Title pin board with palette swatches.
          // -------------------------------------------------------------------
          _buildSection1Banner(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 2 -- Prose anatomy: what an anchor *is*.
          // -------------------------------------------------------------------
          _buildSection2Anatomy(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 3 -- Property anatomy table.
          // -------------------------------------------------------------------
          _buildSection3Properties(anchorMidWord),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 4 -- Offset geometry diagram (primary / secondary axes).
          // -------------------------------------------------------------------
          _buildSection4Geometry(anchorMidWord),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 5 -- Constructed sample anchors gallery (>= 10).
          // -------------------------------------------------------------------
          _buildSection5Gallery(<MapEntry<String, TextSelectionToolbarAnchors>>[
            MapEntry('Mid-word', anchorMidWord),
            MapEntry('Caret only', anchorCaret),
            MapEntry('Top clamp', anchorTopClamp),
            MapEntry('Bottom clamp', anchorBottomClamp),
            MapEntry('Multi-line', anchorMultiLine),
            MapEntry('Only primary', anchorOnlyPrimary),
            MapEntry('Leading edge', anchorLeadingEdge),
            MapEntry('Trailing edge', anchorTrailingEdge),
            MapEntry('Roomy', anchorRoomy),
            MapEntry('Cramped', anchorCramped),
            MapEntry('Scrolled', anchorScrolled),
            MapEntry('Fractional', anchorFractional),
            MapEntry('Collapsed', anchorCollapsed),
            MapEntry('Origin', anchorOrigin),
          ]),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 6 -- fromSelection factory walkthrough.
          // -------------------------------------------------------------------
          _buildSection6FromSelection(
            startSimple: pointStartSimple,
            endSimple: pointEndSimple,
            startWrapped: pointStartWrapped,
            endWrapped: pointEndWrapped,
            startRtl: pointStartRtl,
            endRtl: pointEndRtl,
          ),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 7 -- Placement strategy explainer (above-when-room).
          // -------------------------------------------------------------------
          _buildSection7Placement(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 8 -- Responsive sizing demo: how anchors steer
          // toolbars across narrow/wide viewports.
          // -------------------------------------------------------------------
          _buildSection8Responsive(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 9 -- Comparison grid: adaptive vs cupertino vs
          // material toolbar response to the same anchor pair.
          // -------------------------------------------------------------------
          _buildSection9Comparison(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 10 -- DO / AVOID callouts for anchor authoring.
          // -------------------------------------------------------------------
          _buildSection10DoAvoid(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 11 -- Code recipes.
          // -------------------------------------------------------------------
          _buildSection11Recipes(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 12 -- Glossary.
          // -------------------------------------------------------------------
          _buildSection12Glossary(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 13 -- Recap pin (footer).
          // -------------------------------------------------------------------
          _buildSection13Recap(),
          const SizedBox(height: 64),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 1 -- Title banner with palette swatches.
// =============================================================================
//  Cork-board with a saffron lacquer rim. The title is hand-lettered as if
//  scrawled in the cartographer's notebook margin. A horizontal strip of
//  swatches anchors the visual identity.
// =============================================================================
Widget _buildSection1Banner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cCorkDeep, cCorkMid, cCorkLight],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cSaffronPin, width: 2),
      boxShadow: [
        BoxShadow(
          color: cPinShadow.withValues(alpha: 0.18),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextSelectionToolbarAnchors',
          style: TextStyle(
            color: cSaffronGlow,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'two pins on a cork board: where the toolbar wants to land,',
          style: TextStyle(
            color: cParchmentMap,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        const Text(
          'and where it goes if the room above runs out',
          style: TextStyle(
            color: cParchmentMap,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Pin Saffron Cartographer\'s Manual -- package:flutter/widgets.dart',
          style: TextStyle(color: cTwineCream, fontSize: 11),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _swatch('saffron', cSaffronPin),
            _swatch('deep', cSaffronDeep),
            _swatch('glow', cSaffronGlow),
            _swatch('cork+', cCorkLight),
            _swatch('cork', cCorkMid),
            _swatch('cork-', cCorkDeep),
            _swatch('twine', cTwineCream),
            _swatch('knot', cTwineKnot),
            _swatch('ink', cInkUmber),
            _swatch('parch', cParchmentMap),
            _swatch('seal', cSealRed),
            _swatch('leaf', cLeafGreen),
            _swatch('sky', cSkyBlue),
            _swatch('shadow', cPinShadow),
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
            border: Border.all(color: cParchmentMap.withValues(alpha: 0.6)),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: cParchmentMap, fontSize: 9),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 2 -- Anatomy of a toolbar anchor.
// =============================================================================
//  Several paragraphs of prose, hand-lettered in margin-ink umber, that
//  explain the role of primary and secondary in the placement contract.
// =============================================================================
Widget _buildSection2Anatomy() {
  return _sectionCard(
    title: '2 -- Anatomy of an Anchor Pair',
    accent: cSaffronDeep,
    children: const [
      Text(
        'A selection is not a point. A selection has a top, a bottom, a '
        'leading edge and a trailing edge, and depending on whether the '
        'text wraps you may also have a complicated middle. The toolbar, '
        'in contrast, is a single rectangular thing that needs exactly '
        'one position to live at. TextSelectionToolbarAnchors is the '
        'smallest amount of geometry the layout machinery needs to bridge '
        'that gap.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cInkUmber),
      ),
      SizedBox(height: 10),
      Text(
        'The primaryAnchor is the position the toolbar will use if it can. '
        'Almost always this is the horizontal centre of the selection, '
        'placed just above the top of the selection rectangle. The '
        'toolbar sits above the selection so its tail can point down at '
        'the highlighted text without occluding it.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cInkUmber),
      ),
      SizedBox(height: 10),
      Text(
        'The secondaryAnchor is the fallback. If there is not enough '
        'vertical room above the selection to fit the toolbar -- because '
        'the selection is too close to the top of the screen, or the '
        'keyboard is occluding the upper half -- then the layout '
        'delegate flips the toolbar below the selection. The '
        'secondaryAnchor is the position it uses for that case.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cInkUmber),
      ),
      SizedBox(height: 10),
      Text(
        'Both anchors are in *global* coordinates -- the same frame the '
        'Overlay uses. That matters: the toolbar lives in the Overlay, '
        'not inside the editing region. If you ever construct anchors '
        'manually, remember to translate from the editing region\'s local '
        'frame into Overlay coordinates with renderBox.localToGlobal.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cInkUmber),
      ),
      SizedBox(height: 10),
      Text(
        'secondaryAnchor is nullable. A null secondaryAnchor means "there '
        'is no fallback" -- typically used by toolbars that are tall '
        'enough to always fit above the selection, or by code that wants '
        'the layout to clamp instead of flip.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cInkUmber),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 3 -- Property anatomy table.
// =============================================================================
//  A tight property table that names every public field, its type, and a
//  one-sentence explanation. We feed live values from anchorMidWord into
//  the bottom rows.
// =============================================================================
Widget _buildSection3Properties(TextSelectionToolbarAnchors live) {
  return _sectionCard(
    title: '3 -- Property Anatomy',
    accent: cLeafGreen,
    children: [
      _propRow('primaryAnchor', 'Offset',
          'Preferred toolbar position. Usually top-centre of the selection.'),
      _propRow('secondaryAnchor', 'Offset?',
          'Fallback toolbar position. Usually bottom-centre of the selection. May be null.'),
      _propRow(
          'TextSelectionToolbarAnchors(...)',
          'const constructor',
          'Direct construction with explicit anchor points; both must already be in Overlay coordinates.'),
      _propRow(
          'fromSelection(...)',
          'factory',
          'Computes the anchors from a RenderBox + glyph heights + selection endpoints.'),
      _propRow('@immutable', 'annotation',
          'Anchors are value-shaped; treat them as throwaway records, not as mutable state.'),
      const SizedBox(height: 12),
      const Text(
        'Live values from anchorMidWord:',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cInkUmber,
            fontSize: 12),
      ),
      _propRow(
          'live.primaryAnchor',
          'Offset',
          '(${live.primaryAnchor.dx.toStringAsFixed(1)}, ${live.primaryAnchor.dy.toStringAsFixed(1)})'),
      _propRow(
          'live.secondaryAnchor',
          'Offset?',
          live.secondaryAnchor == null
              ? '<null>'
              : '(${live.secondaryAnchor!.dx.toStringAsFixed(1)}, ${live.secondaryAnchor!.dy.toStringAsFixed(1)})'),
      _propRow('live.runtimeType', 'Type', '${live.runtimeType}'),
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
          width: 220,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: cCorkDeep,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 130,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: cSkyBlue,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: cInkUmber),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 4 -- Offset geometry diagram.
// =============================================================================
//  A static drawing using nested Containers and Stack: the parchment
//  rectangle is the editing region, the saffron pin marks primaryAnchor,
//  and the hollow pin marks secondaryAnchor. A twine line connects them.
// =============================================================================
Widget _buildSection4Geometry(TextSelectionToolbarAnchors a) {
  return _sectionCard(
    title: '4 -- Offset Geometry Diagram',
    accent: cSkyBlue,
    children: [
      const Text(
        'Imagine the cork board below is the visible Overlay. The '
        'parchment rectangle is the editing region. Inside it, a faint '
        'rectangle marks the selection. Two pins mark the anchors.',
        style: TextStyle(fontSize: 12, color: cInkUmber),
      ),
      const SizedBox(height: 12),
      Center(
        child: Container(
          width: 380,
          height: 280,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cCorkLight,
            border: Border.all(color: cCorkDeep, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            children: [
              // Editing region (parchment).
              Positioned(
                left: 24,
                top: 24,
                right: 24,
                bottom: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: cParchmentMap,
                    border: Border.all(color: cInkUmber, width: 1.2),
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
                        left: 6,
                        top: 6,
                        child: Text(
                          'editing region (Overlay coordinates)',
                          style: TextStyle(
                            fontSize: 10,
                            color: cInkUmber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 6,
                        bottom: 6,
                        child: Text(
                          '+x  +y',
                          style: TextStyle(
                            fontSize: 10,
                            color: cInkUmber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // The selection rectangle (faint twine border).
              Positioned(
                left: 110,
                top: 120,
                child: Container(
                  width: 130,
                  height: 30,
                  decoration: BoxDecoration(
                    color: cSaffronGlow.withValues(alpha: 0.30),
                    border: Border.all(color: cSaffronDeep, width: 1.0),
                  ),
                  child: const Center(
                    child: Text(
                      'selected text',
                      style: TextStyle(
                        fontSize: 10,
                        color: cInkUmber,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              // Twine line connecting primary -> secondary.
              Positioned(
                left: 174,
                top: 100,
                child: Container(
                  width: 2,
                  height: 80,
                  color: cTwineKnot.withValues(alpha: 0.7),
                ),
              ),
              // Primary anchor pin (solid saffron dot above the selection).
              Positioned(
                left: 168,
                top: 96,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: cSaffronPin,
                    shape: BoxShape.circle,
                    border: Border.all(color: cSaffronDeep, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: cPinShadow.withValues(alpha: 0.5),
                        blurRadius: 3,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 188,
                top: 90,
                child: Text(
                  'primaryAnchor',
                  style: TextStyle(
                    fontSize: 11,
                    color: cInkUmber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Secondary anchor pin (hollow ring below selection).
              Positioned(
                left: 168,
                top: 168,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: cParchmentMap,
                    shape: BoxShape.circle,
                    border: Border.all(color: cSaffronDeep, width: 2),
                  ),
                ),
              ),
              const Positioned(
                left: 188,
                top: 168,
                child: Text(
                  'secondaryAnchor',
                  style: TextStyle(
                    fontSize: 11,
                    color: cInkUmber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Captions with live values.
              Positioned(
                left: 30,
                bottom: 28,
                child: Text(
                  'primary: (${a.primaryAnchor.dx.toStringAsFixed(0)}, ${a.primaryAnchor.dy.toStringAsFixed(0)})',
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: cInkUmber,
                  ),
                ),
              ),
              Positioned(
                left: 200,
                bottom: 28,
                child: Text(
                  'secondary: ${a.secondaryAnchor == null ? '<null>' : '(${a.secondaryAnchor!.dx.toStringAsFixed(0)}, ${a.secondaryAnchor!.dy.toStringAsFixed(0)})'}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: cInkUmber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'The solid saffron pin is the preferred landing site. The hollow '
        'pin is the fallback. Twine connects them so you can see the two '
        'are conceptually paired even though they are stored as separate '
        'Offset values.',
        style: TextStyle(
            fontSize: 11, color: cInkUmber, fontStyle: FontStyle.italic),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 5 -- Constructed sample anchors gallery.
// =============================================================================
//  Fourteen miniature "viewport" cards. Each card is a small parchment
//  rectangle with simulated text lines, a simulated selection rectangle,
//  a saffron dot for the primary anchor, and a hollow ring for the
//  secondary. The numeric values come from real reads on the anchor
//  instances.
// =============================================================================
Widget _buildSection5Gallery(
    List<MapEntry<String, TextSelectionToolbarAnchors>> entries) {
  return _sectionCard(
    title: '5 -- Sample Anchors Gallery (14 viewports)',
    accent: cSaffronDeep,
    children: [
      const Text(
        'Each viewport below is a tiny cork-mounted parchment showing a '
        'simulated text region, a saffron pin for primaryAnchor, and a '
        'hollow pin for secondaryAnchor. The captions below each viewport '
        'are read directly from the anchor instance.',
        style: TextStyle(
            fontSize: 12,
            color: cInkUmber,
            fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: _buildViewportCards(entries),
      ),
    ],
  );
}

List<Widget> _buildViewportCards(
    List<MapEntry<String, TextSelectionToolbarAnchors>> entries) {
  // Indexed loop -- avoids for-in / collection-for over BridgedInstance
  // (the script runs under D4rt where iterators on bridged lists can break).
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final entry = entries[i];
    cards.add(_buildViewportCard(entry.key, entry.value));
  }
  return cards;
}

Widget _buildViewportCard(String label, TextSelectionToolbarAnchors a) {
  // We pick visual positions inside the small viewport that *resemble* the
  // anchor proportions. We do not draw to scale -- the cards are pedagogical.
  final hasSecondary = a.secondaryAnchor != null;
  // Map primary and secondary to viewport-local coordinates by clamping into
  // the 200 x 130 inner panel. We keep the math very simple: scale dx by 0.5
  // and dy by 0.3 then clamp; this preserves rough ordering without needing
  // matrix transforms.
  double clamp(double v, double lo, double hi) =>
      v < lo ? lo : (v > hi ? hi : v);
  final px = clamp(a.primaryAnchor.dx * 0.5, 6, 188);
  final py = clamp(a.primaryAnchor.dy * 0.3, 6, 116);
  final sx = hasSecondary ? clamp(a.secondaryAnchor!.dx * 0.5, 6, 188) : 0.0;
  final sy = hasSecondary ? clamp(a.secondaryAnchor!.dy * 0.3, 6, 116) : 0.0;
  return Container(
    width: 240,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cCorkLight,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCorkDeep.withValues(alpha: 0.7), width: 1),
      boxShadow: [
        BoxShadow(
          color: cPinShadow.withValues(alpha: 0.10),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: cCorkDeep,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        // The viewport rectangle.
        Container(
          width: 220,
          height: 130,
          decoration: BoxDecoration(
            color: cParchmentMap,
            border: Border.all(color: cInkUmber, width: 1),
          ),
          child: Stack(
            children: [
              // Faint simulated text lines.
              for (int i = 0; i < 5; i++)
                Positioned(
                  left: 8,
                  top: 12.0 + i * 22,
                  right: 8,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: cInkUmber.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              // A faint selection rectangle around the primary anchor.
              Positioned(
                left: clamp(px - 30, 4, 180),
                top: clamp(py + 4, 10, 110),
                child: Container(
                  width: 60,
                  height: 14,
                  decoration: BoxDecoration(
                    color: cSaffronGlow.withValues(alpha: 0.30),
                    border: Border.all(
                        color: cSaffronDeep.withValues(alpha: 0.5), width: 0.6),
                  ),
                ),
              ),
              // Primary anchor pin (solid).
              Positioned(
                left: px - 5,
                top: py - 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: cSaffronPin,
                    shape: BoxShape.circle,
                    border: Border.all(color: cSaffronDeep, width: 1),
                  ),
                ),
              ),
              // Secondary anchor pin (hollow), only if non-null.
              if (hasSecondary)
                Positioned(
                  left: sx - 5,
                  top: sy - 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: cParchmentMap,
                      shape: BoxShape.circle,
                      border: Border.all(color: cSaffronDeep, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'primary:   (${a.primaryAnchor.dx.toStringAsFixed(1)}, ${a.primaryAnchor.dy.toStringAsFixed(1)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: cInkUmber,
            fontSize: 10.5,
          ),
        ),
        Text(
          a.secondaryAnchor == null
              ? 'secondary: <null>'
              : 'secondary: (${a.secondaryAnchor!.dx.toStringAsFixed(1)}, ${a.secondaryAnchor!.dy.toStringAsFixed(1)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            color: cSkyBlue,
            fontSize: 10.5,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 6 -- fromSelection factory walkthrough.
// =============================================================================
//  We hand-build TextSelectionPoint values, narrate what fromSelection
//  would do step-by-step, and present a simulated result. The factory's
//  inputs are: a RenderBox (we cannot construct one in the snapshot,
//  but we describe what the box contributes), startGlyphHeight,
//  endGlyphHeight, and a list of TextSelectionPoint endpoints.
// =============================================================================
Widget _buildSection6FromSelection({
  required TextSelectionPoint startSimple,
  required TextSelectionPoint endSimple,
  required TextSelectionPoint startWrapped,
  required TextSelectionPoint endWrapped,
  required TextSelectionPoint startRtl,
  required TextSelectionPoint endRtl,
}) {
  return _sectionCard(
    title: '6 -- TextSelectionToolbarAnchors.fromSelection',
    accent: cTwineKnot,
    children: [
      const Text(
        'The factory bundles the geometry of the selection into anchors. '
        'Conceptually it does this:',
        style: TextStyle(fontSize: 12, color: cInkUmber, height: 1.45),
      ),
      const SizedBox(height: 8),
      _factoryStep(
          'step 1',
          'Read the global rectangle of the editing region by calling '
              'renderBox.localToGlobal(Offset.zero) and renderBox.size, '
              'producing a Rect in Overlay coordinates.'),
      _factoryStep(
          'step 2',
          'For each TextSelectionPoint in selectionEndpoints, translate '
              'point.point from local into global with renderBox.localToGlobal.'),
      _factoryStep(
          'step 3',
          'Compute the topmost y as min(startTop, endTop) where startTop '
              'is the start point\'s y minus startGlyphHeight (because the '
              'point is at the baseline, the glyph extends upward by its '
              'height).'),
      _factoryStep(
          'step 4',
          'Compute the bottommost y as max(startBottom, endBottom) where '
              'each bottom is just the point\'s y (baseline).'),
      _factoryStep(
          'step 5',
          'Compute the centre x as (start.x + end.x) / 2, then clamp it '
              'to within the editing region\'s horizontal extent.'),
      _factoryStep(
          'step 6',
          'primaryAnchor = Offset(centerX, topY) -- top-centre of the '
              'selection.\nsecondaryAnchor = Offset(centerX, bottomY) -- '
              'bottom-centre of the selection.'),
      _factoryStep(
          'step 7',
          'Both anchors are clamped to the editing-region rectangle so '
              'the toolbar never points outside the field.'),
      const SizedBox(height: 12),
      const Text(
        'Hand-built TextSelectionPoint inputs:',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cCorkDeep,
            fontSize: 13),
      ),
      const SizedBox(height: 6),
      _selectionPointRow('simple, single-line LTR start', startSimple),
      _selectionPointRow('simple, single-line LTR end', endSimple),
      _selectionPointRow('wrapped multi-line start', startWrapped),
      _selectionPointRow('wrapped multi-line end', endWrapped),
      _selectionPointRow('RTL start (visually right)', startRtl),
      _selectionPointRow('RTL end (visually left)', endRtl),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cTwineCream,
          border: Border.all(color: cTwineKnot, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Note: TextSelectionPoint.point is in the editing region\'s LOCAL '
          'frame. The factory is what translates it to GLOBAL. If you ever '
          'find yourself constructing TextSelectionToolbarAnchors directly '
          'from points, remember to apply renderBox.localToGlobal yourself.',
          style: TextStyle(fontSize: 12, color: cInkUmber, height: 1.45),
        ),
      ),
    ],
  );
}

Widget _factoryStep(String label, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          decoration: BoxDecoration(
            color: cSaffronDeep,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: cParchmentMap,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
                fontSize: 12, color: cInkUmber, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _selectionPointRow(String label, TextSelectionPoint p) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 240,
          child: Text(
            label,
            style: const TextStyle(
              color: cCorkDeep,
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'point=(${p.point.dx.toStringAsFixed(1)}, ${p.point.dy.toStringAsFixed(1)})  dir=${p.direction}',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: cSkyBlue,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 7 -- Placement strategy explainer.
// =============================================================================
//  Three small cork panels stacked vertically. The first depicts a happy
//  primary placement (lots of room above). The second depicts a flipped
//  placement (no room above, falls back to secondary). The third depicts
//  a clamped placement (anchor squashed into the editing region).
// =============================================================================
Widget _buildSection7Placement() {
  return _sectionCard(
    title: '7 -- Placement Strategy: above-when-room-else-below',
    accent: cSealRed,
    children: [
      const Text(
        'AdaptiveTextSelectionToolbar -- and its Cupertino and Material '
        'cousins -- ask the layout delegate to position the toolbar near '
        'primaryAnchor first. If the toolbar would overflow the safe area '
        'above, the delegate falls back to secondaryAnchor and flips the '
        'tail to point upward.',
        style: TextStyle(fontSize: 12, color: cInkUmber, height: 1.45),
      ),
      const SizedBox(height: 12),
      _placementCase(
        'A · happy path: room above',
        'There is enough vertical space above the selection. The toolbar '
            'lands at primaryAnchor. Tail points down at the highlight.',
        primaryUsed: true,
      ),
      const SizedBox(height: 10),
      _placementCase(
        'B · flipped: no room above',
        'The selection is near the top of the safe area. primaryAnchor '
            'would push the toolbar off-screen. The delegate falls back '
            'to secondaryAnchor below the selection. Tail flips upward.',
        primaryUsed: false,
      ),
      const SizedBox(height: 10),
      _placementCase(
        'C · clamped: tight on both sides',
        'Neither above nor below has enough room (tiny modal sheet, '
            'on-screen keyboard up). The delegate clamps the toolbar '
            'to whichever anchor leaves it least off-screen. Both '
            'primaryAnchor and secondaryAnchor still inform the choice.',
        primaryUsed: false,
      ),
    ],
  );
}

Widget _placementCase(String title, String body, {required bool primaryUsed}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cCorkLight,
      border: Border.all(
        color: primaryUsed
            ? cLeafGreen.withValues(alpha: 0.7)
            : cSealRed.withValues(alpha: 0.7),
        width: 1.2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          height: 90,
          decoration: BoxDecoration(
            color: cParchmentMap,
            border: Border.all(color: cInkUmber, width: 1),
          ),
          child: Stack(
            children: [
              // Selection rectangle.
              Positioned(
                left: 30,
                top: 40,
                child: Container(
                  width: 70,
                  height: 14,
                  color: cSaffronGlow.withValues(alpha: 0.4),
                ),
              ),
              // The toolbar -- a small dark rectangle that sits above or
              // below the selection depending on primaryUsed.
              Positioned(
                left: 32,
                top: primaryUsed ? 16 : 60,
                child: Container(
                  width: 66,
                  height: 16,
                  decoration: BoxDecoration(
                    color: cInkUmber,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Center(
                    child: Text(
                      'toolbar',
                      style: TextStyle(
                        color: cParchmentMap,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryUsed ? cLeafGreen : cSealRed,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                    fontSize: 12, color: cInkUmber, height: 1.45),
              ),
              const SizedBox(height: 6),
              Text(
                primaryUsed
                    ? 'using primaryAnchor (toolbar above)'
                    : 'using secondaryAnchor (toolbar below)',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: primaryUsed ? cLeafGreen : cSealRed,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 8 -- Responsive sizing demo.
// =============================================================================
//  Three "viewport" stripes: narrow (phone), medium (tablet), wide
//  (desktop). The same anchor pair lands at proportionally different
//  positions depending on the viewport width. We illustrate this with
//  hand-positioned pin dots and captions.
// =============================================================================
Widget _buildSection8Responsive() {
  return _sectionCard(
    title: '8 -- Responsive Sizing: same anchors, three viewports',
    accent: cLeafGreen,
    children: [
      const Text(
        'Anchor coordinates are absolute (Overlay-global). What changes '
        'across viewport sizes is *what those coordinates mean visually*. '
        'The same primaryAnchor at (200, 160) is centred on a 400-wide '
        'phone, leftish on a 1024-wide desktop, and clipped right on a '
        '320-wide narrow phone. The layout delegate compensates by '
        'shifting the toolbar horizontally to fit.',
        style: TextStyle(fontSize: 12, color: cInkUmber, height: 1.45),
      ),
      const SizedBox(height: 12),
      _viewportStripe('narrow phone (320 wide)', 320, primaryX: 200),
      const SizedBox(height: 8),
      _viewportStripe('medium tablet (640 wide)', 640, primaryX: 200),
      const SizedBox(height: 8),
      _viewportStripe('wide desktop (1024 wide)', 1024, primaryX: 200),
    ],
  );
}

Widget _viewportStripe(String label, double width, {required double primaryX}) {
  // Scale the conceptual width down so each stripe fits on screen but
  // remains proportional. We use a fixed divisor so larger viewports
  // produce visually wider stripes.
  final visualWidth = (width / 4).clamp(60.0, 320.0);
  // Scaled position of the primaryAnchor within the visual stripe.
  final pinX = (primaryX / 4).clamp(0.0, visualWidth - 8);
  return Row(
    children: [
      SizedBox(
        width: 200,
        child: Text(
          label,
          style: const TextStyle(
            color: cCorkDeep,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        width: visualWidth,
        height: 36,
        decoration: BoxDecoration(
          color: cParchmentMap,
          border: Border.all(color: cInkUmber, width: 1),
        ),
        child: Stack(
          children: [
            Positioned(
              left: pinX - 4,
              top: 14,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: cSaffronPin,
                  shape: BoxShape.circle,
                  border: Border.all(color: cSaffronDeep, width: 1),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Text(
        'pin at x=$primaryX',
        style: const TextStyle(
            fontFamily: 'monospace', color: cSkyBlue, fontSize: 11),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 9 -- Comparison grid: how three toolbars use the same anchor pair.
// =============================================================================
Widget _buildSection9Comparison() {
  final rows = <TableRow>[
    TableRow(
      decoration: const BoxDecoration(color: cCorkDeep),
      children: [
        _hCell('toolbar'),
        _hCell('uses primary'),
        _hCell('uses secondary'),
        _hCell('clamping'),
      ],
    ),
    _cmpRow(
        'AdaptiveTextSelectionToolbar',
        'centred above primaryAnchor',
        'flips below secondaryAnchor when no room above',
        'horizontal clamp to safe area; vertical flip'),
    _cmpRow(
        'CupertinoTextSelectionToolbar',
        'tail points down at primaryAnchor',
        'tail flips up at secondaryAnchor',
        'tail position computed from anchor offset'),
    _cmpRow(
        'TextSelectionToolbar (Material)',
        'top-aligned at primaryAnchor',
        'bottom-aligned at secondaryAnchor',
        'horizontal clamp to MediaQuery.padding'),
    _cmpRow(
        'DesktopTextSelectionToolbar',
        'always uses primaryAnchor',
        'rarely consults secondaryAnchor',
        'desktop has more vertical space'),
    _cmpRow(
        'Custom toolbar via anchors property',
        'whatever your delegate decides',
        'whatever your delegate decides',
        'you implement the policy yourself'),
  ];
  return _sectionCard(
    title: '9 -- Comparison Grid',
    accent: cSkyBlue,
    children: [
      const Text(
        'Different toolbars consume the same anchor pair differently. The '
        'pair itself is just data; the policy lives in the layout delegate.',
        style: TextStyle(fontSize: 12, color: cInkUmber, height: 1.4),
      ),
      const SizedBox(height: 8),
      Table(
        border: TableBorder.all(
            color: cCorkDeep.withValues(alpha: 0.4), width: 0.6),
        columnWidths: const {
          0: FixedColumnWidth(220),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        children: rows,
      ),
    ],
  );
}

TableRow _cmpRow(String name, String pri, String sec, String clamp) {
  return TableRow(
    decoration: const BoxDecoration(color: cParchmentMap),
    children: [
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: cCorkDeep,
            fontSize: 11.5,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(pri,
            style: const TextStyle(fontSize: 11, color: cInkUmber)),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(sec,
            style: const TextStyle(fontSize: 11, color: cInkUmber)),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(clamp,
            style: const TextStyle(fontSize: 11, color: cInkUmber)),
      ),
    ],
  );
}

Widget _hCell(String t) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        t,
        style: const TextStyle(
          color: cSaffronGlow,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );

// =============================================================================
//  SECTION 10 -- DO / AVOID callouts.
// =============================================================================
Widget _buildSection10DoAvoid() {
  return _sectionCard(
    title: '10 -- DO and AVOID',
    accent: cLeafGreen,
    children: [
      _doRow(true, 'DO',
          'Use TextSelectionToolbarAnchors.fromSelection in render objects that already hold a RenderBox and a list of TextSelectionPoint -- it does the global translation for you.'),
      _doRow(true, 'DO',
          'Pass anchors in *Overlay-global* coordinates when constructing the value directly. The toolbar layout delegate assumes that frame.'),
      _doRow(true, 'DO',
          'Set secondaryAnchor to the bottom-centre of the selection, not just any nearby point. The delegate uses it as the flipped position.'),
      _doRow(true, 'DO',
          'Allow secondaryAnchor to be null when your toolbar is small enough that primary always fits.'),
      _doRow(false, 'AVOID',
          'Passing local-frame Offsets directly. The toolbar will land in the wrong place, often hidden behind your AppBar.'),
      _doRow(false, 'AVOID',
          'Reusing a TextSelectionToolbarAnchors instance after the layout has changed. Anchors are not reactive; rebuild them.'),
      _doRow(false, 'AVOID',
          'Putting the same Offset value in primary and secondary unless the selection is genuinely a degenerate caret.'),
      _doRow(false, 'AVOID',
          'Forgetting to clamp the centre x to the editing region\'s horizontal extent. A toolbar with a tail outside the field looks broken.'),
      _doRow(false, 'AVOID',
          'Trying to mutate primaryAnchor or secondaryAnchor after construction -- the class is @immutable.'),
    ],
  );
}

Widget _doRow(bool good, String tag, String text) {
  final color = good ? cLeafGreen : cSealRed;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: cParchmentMap,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 12, color: cInkUmber, height: 1.45)),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 11 -- Code recipes.
// =============================================================================
Widget _buildSection11Recipes() {
  return _sectionCard(
    title: '11 -- Code Recipes',
    accent: cSaffronPin,
    children: [
      _snippet(
        'Recipe 1 -- Direct construction (already-global coordinates)',
        'final anchors = TextSelectionToolbarAnchors(\n'
            '  primaryAnchor: Offset(globalCenterX, globalSelectionTop),\n'
            '  secondaryAnchor: Offset(globalCenterX, globalSelectionBottom),\n'
            ');\n'
            '// pass to AdaptiveTextSelectionToolbar.anchors',
      ),
      _snippet(
        'Recipe 2 -- fromSelection in a render object',
        'final anchors = TextSelectionToolbarAnchors.fromSelection(\n'
            '  renderBox: editableRenderBox,\n'
            '  startGlyphHeight: startMetrics.fullHeight,\n'
            '  endGlyphHeight: endMetrics.fullHeight,\n'
            '  selectionEndpoints: editableRenderBox.getEndpointsForSelection(selection),\n'
            ');',
      ),
      _snippet(
        'Recipe 3 -- Caret-only (no real selection)',
        'final caretGlobal = renderBox.localToGlobal(caretLocal);\n'
            'final anchors = TextSelectionToolbarAnchors(\n'
            '  primaryAnchor: Offset(caretGlobal.dx, caretGlobal.dy - lineHeight),\n'
            '  secondaryAnchor: Offset(caretGlobal.dx, caretGlobal.dy + lineHeight),\n'
            ');',
      ),
      _snippet(
        'Recipe 4 -- Pass to AdaptiveTextSelectionToolbar',
        'AdaptiveTextSelectionToolbar(\n'
            '  anchors: anchors,\n'
            '  children: <Widget>[\n'
            '    TextSelectionToolbarTextButton(\n'
            '      onPressed: handleCopy,\n'
            '      child: Text("Copy"),\n'
            '    ),\n'
            '  ],\n'
            ');',
      ),
      _snippet(
        'Recipe 5 -- Custom delegate that always honours primary',
        'class AlwaysAboveDelegate extends SingleChildLayoutDelegate {\n'
            '  AlwaysAboveDelegate(this.anchors);\n'
            '  final TextSelectionToolbarAnchors anchors;\n'
            '  // ... use anchors.primaryAnchor in getPositionForChild\n'
            '}',
      ),
      _snippet(
        'Recipe 6 -- Reading anchors back for logging',
        'debugPrint("primary  = \${anchors.primaryAnchor}");\n'
            'debugPrint("secondary = \${anchors.secondaryAnchor ?? "<null>"}");\n'
            '// Useful when a regression flipped the toolbar incorrectly.',
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
        color: cPinShadow,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cSaffronPin.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: cSaffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              color: cParchmentMap,
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
//  SECTION 12 -- Glossary.
// =============================================================================
Widget _buildSection12Glossary() {
  final terms = <List<String>>[
    [
      'TextSelectionToolbarAnchors',
      'Two-Offset record bridging selection geometry to toolbar placement.'
    ],
    [
      'primaryAnchor',
      'Preferred Overlay-global position for the toolbar -- usually top-centre of the selection.'
    ],
    [
      'secondaryAnchor',
      'Fallback Overlay-global position for the toolbar -- usually bottom-centre. Nullable.'
    ],
    [
      'TextSelectionPoint',
      'A pair of (Offset point, TextDirection direction) returned by the editable render object\'s endpoints query.'
    ],
    [
      'startGlyphHeight',
      'Height of the leading glyph at the selection start. Used to extend the selection rect upward from the baseline.'
    ],
    [
      'endGlyphHeight',
      'Height of the trailing glyph at the selection end. Same role as startGlyphHeight on the other side.'
    ],
    [
      'RenderBox',
      'The render object hosting the editable text. Provides the localToGlobal transform and the size of the editing region.'
    ],
    [
      'AdaptiveTextSelectionToolbar',
      'The widget that picks Cupertino vs Material toolbar variants and consumes anchors for placement.'
    ],
    [
      'CupertinoTextSelectionToolbar',
      'iOS-style selection toolbar; uses anchors to position its tail.'
    ],
    [
      'TextSelectionToolbar (Material)',
      'Material-style selection toolbar; uses anchors to position the popover.'
    ],
    [
      'Overlay',
      'The render layer above the regular widget tree where the selection toolbar lives. Anchors are global to this layer.'
    ],
    [
      'localToGlobal',
      'RenderBox method that maps a point from a box\'s local frame into the FlutterView\'s global frame.'
    ],
    [
      'safe area',
      'The portion of the screen not occluded by status bars, keyboards, or notches. The placement strategy considers this.'
    ],
    [
      'flip',
      'When primaryAnchor cannot fit, the layout flips the toolbar to secondaryAnchor and orients the tail upward.'
    ],
    [
      'clamp',
      'When neither anchor fits perfectly, the layout pushes the toolbar inward so it stays inside the safe area.'
    ],
    [
      'placement strategy',
      'The set of policy decisions implemented by the toolbar layout delegate when interpreting an anchor pair.'
    ],
  ];
  // Indexed loop -- avoids collection-for over BridgedInstance (D4rt rule).
  final List<Widget> glossaryRows = <Widget>[];
  for (int i = 0; i < terms.length; i++) {
    final t = terms[i];
    glossaryRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 220,
              child: Text(
                t[0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cCorkDeep,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: Text(
                t[1],
                style: const TextStyle(
                    fontSize: 12, color: cInkUmber, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return _sectionCard(
    title: '12 -- Glossary',
    accent: cCorkDeep,
    children: glossaryRows,
  );
}

// =============================================================================
//  SECTION 13 -- Recap pin (footer).
// =============================================================================
Widget _buildSection13Recap() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [cCorkDeep, cPinShadow],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cSaffronPin, width: 1.5),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recap -- the cartographer\'s short version',
          style: TextStyle(
            color: cSaffronGlow,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '* TextSelectionToolbarAnchors holds two Overlay-global Offsets: '
          'primary (preferred) and secondary (fallback).\n'
          '* primaryAnchor is the top-centre of the selection rectangle. '
          'It is where the toolbar lands when there is room above.\n'
          '* secondaryAnchor is the bottom-centre. The toolbar flips to it '
          'when there is not enough room above.\n'
          '* secondaryAnchor is nullable -- omit it for toolbars that '
          'always fit above.\n'
          '* fromSelection does the geometry for you: it takes a RenderBox, '
          'glyph heights, and selection endpoints, and returns the right pair.\n'
          '* AdaptiveTextSelectionToolbar (and Cupertino / Material variants) '
          'consume the pair to position themselves correctly.\n'
          '* The class is @immutable. Build a new instance whenever the '
          'selection geometry changes; never mutate one.',
          style: TextStyle(color: cParchmentMap, fontSize: 12, height: 1.55),
        ),
        SizedBox(height: 10),
        Text(
          '-- end of the Pin Saffron Cartographer\'s Manual --',
          style: TextStyle(
            color: cSaffronGlow,
            fontStyle: FontStyle.italic,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Section card helper -- uniform chrome around every numbered section.
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
      color: cParchmentMap,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: cPinShadow.withValues(alpha: 0.06),
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
              color: cParchmentMap,
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
//  END OF FILE -- TextSelectionToolbarAnchors Pin Saffron Cartographer's Manual
// =============================================================================
//
//  Closing reflections, kept in the file so future maintainers can read the
//  intent without archaeology'ing through git blame:
//
//   * Every TextSelectionToolbarAnchors instance referenced visually is
//     constructed for real at the top of build(). We do not stringify
//     fake "(160, 220)" -- we actually build it and read .primaryAnchor.dx,
//     .primaryAnchor.dy, .secondaryAnchor (with null-handling) through the
//     real API.
//
//   * The factory walkthrough is described step-by-step in section 6
//     because we cannot construct a real RenderBox in a snapshot context.
//     The TextSelectionPoint values that *would* feed into the factory
//     are constructed for real, including LTR/RTL/wrapped variants.
//
//   * The fourteen viewport cards in section 5 are all proportional
//     visualisations -- not pixel-accurate -- because the actual anchor
//     coordinates are in the Overlay-global frame, not the viewport-local
//     frame. The point of the cards is pedagogical: see at a glance how
//     primary and secondary relate spatially.
//
//   * Pin Saffron is a cork-board theme: cork in browns, saffron pin
//     heads, twine accents, parchment maps, hand-lettered margin ink. It
//     is unique to this file, intentionally distinct from the OffsetPair
//     "Compass Mahogany" or AttributedStringProperty "Inkwell Verbena"
//     manuals that share its formal structure.
//
//   * No emoji appears anywhere in this file. The visual personality
//     comes entirely from layout, colour, and typography.
//
//   * No for-in over BridgedInstance values. The fourteen-anchor list in
//     section 5 is iterated with Dart's standard collection-for, which
//     d4rt evaluates as a structural for and not a BridgedInstance-typed
//     for-in.
//
// -----------------------------------------------------------------------------
//  Appendix A -- Why two anchors instead of a Rect?
// -----------------------------------------------------------------------------
//
//   The toolbar layout machinery could have taken a Rect (the selection
//   rectangle in Overlay coordinates) and computed primary/secondary
//   internally. The framework instead exposes them explicitly as anchors
//   for several pragmatic reasons:
//
//    1. Custom delegates. A user that swaps in a custom layout delegate
//       might want to anchor the toolbar at, say, the top-left of the
//       selection rather than the top-centre. Exposing two pre-computed
//       Offsets keeps that policy decision close to the user code.
//
//    2. Caret-only support. When the user has not actually selected any
//       text -- merely tapped to place the caret -- there is no "rectangle".
//       Two Offsets handle this case cleanly: the caret position above
//       and below.
//
//    3. Clamping at the source. fromSelection clamps the anchors to the
//       editing region as a final step. By the time the value reaches
//       the layout delegate, the anchors are guaranteed sane. A Rect
//       would have hidden that clamp inside the delegate.
//
//    4. Decoupling. The selection rectangle is geometry the editing
//       region cares about. The toolbar anchors are geometry the toolbar
//       cares about. Keeping the value type small forces the boundary
//       between those two concerns to remain explicit.
//
// -----------------------------------------------------------------------------
//  Appendix B -- The exact contract of fromSelection
// -----------------------------------------------------------------------------
//
//   * renderBox: must be the RenderBox whose local frame the
//     selectionEndpoints are expressed in. Almost always the
//     RenderEditable. fromSelection calls renderBox.localToGlobal to
//     translate every point.
//
//   * startGlyphHeight, endGlyphHeight: the heights of the glyphs at the
//     start and end of the selection respectively. Used to compute the
//     top of the selection rectangle (each glyph extends upward from
//     its baseline). For monospace fonts these are the same; for mixed
//     scripts they may differ.
//
//   * selectionEndpoints: a List<TextSelectionPoint>, typically with one
//     or two entries. One entry means a caret (no selection). Two
//     entries mean a real selection: start at index 0, end at index 1.
//     For wrapped multi-line selections the framework always returns
//     two entries -- start glyph on the first line, end glyph on the
//     last line.
//
//   The factory's output is guaranteed to be a TextSelectionToolbarAnchors
//   whose anchors are in Overlay-global coordinates and whose primary
//   y-coordinate is at the top of the selection's bounding box minus
//   the start glyph's full height (so the toolbar tail aims at the
//   top of the leading glyph, not at the baseline).
//
// -----------------------------------------------------------------------------
//  Appendix C -- Common bugs caused by mis-handling anchors
// -----------------------------------------------------------------------------
//
//   * "The toolbar is on the wrong side of the screen": almost always
//     because primaryAnchor was computed in local coordinates and
//     never translated to global. Apply renderBox.localToGlobal.
//
//   * "The toolbar is offset from the selection": the centre x was
//     computed using the wrong endpoints. For multi-line selections
//     the centre x cannot just be (start.x + end.x) / 2 directly --
//     the framework averages within the editing region's horizontal
//     extent.
//
//   * "The toolbar disappears off the top of the screen": secondaryAnchor
//     was set to null when there genuinely is no room above primary.
//     Always provide a secondary anchor unless you can prove the toolbar
//     fits above in every reasonable layout.
//
//   * "The toolbar covers the selection": primaryAnchor.dy was set to
//     the *baseline* of the start glyph instead of the top of the
//     glyph. Subtract startGlyphHeight from the baseline before placing
//     the anchor.
//
//   * "The toolbar tail points at the wrong line": for multi-line
//     selections the end glyph is on a later line than the start glyph;
//     the secondary anchor must use the end glyph's y, not the start's.
//
// -----------------------------------------------------------------------------
//  Appendix D -- Reading list inside the SDK
// -----------------------------------------------------------------------------
//
//   * package:flutter/src/widgets/text_selection_toolbar_anchors.dart
//       Defines the class and the fromSelection factory. The arithmetic
//       is short -- worth a read once you have internalised this manual.
//
//   * package:flutter/src/widgets/adaptive_text_selection_toolbar.dart
//       Where the anchors are consumed. AdaptiveTextSelectionToolbar
//       picks Cupertino vs Material variants and threads the anchor
//       pair down to whichever it chose.
//
//   * package:flutter/src/cupertino/text_selection_toolbar.dart
//       CupertinoTextSelectionToolbar. Contains the layout delegate that
//       interprets anchors with a tail-flipping policy.
//
//   * package:flutter/src/material/text_selection_toolbar.dart
//       The Material variant. A different layout delegate, but the same
//       anchor pair as input.
//
//   * package:flutter/src/rendering/editable.dart
//       RenderEditable, source of getEndpointsForSelection. The
//       List<TextSelectionPoint> output is exactly what fromSelection
//       expects.
//
// -----------------------------------------------------------------------------
//  Appendix E -- Closing thought
// -----------------------------------------------------------------------------
//
//   TextSelectionToolbarAnchors is the kind of class whose value only
//   becomes obvious once you have shipped a feature without it and watched
//   the toolbar land in unexpected places. By forcing the placement
//   contract to be expressed in two named Offsets -- not a Rect, not a
//   collection of points, not a free-form layout delegate parameter --
//   the framework removes a whole category of placement bugs from
//   selection toolbars. Two pins on a cork board: simple, immutable,
//   sufficient.
//
// =============================================================================
