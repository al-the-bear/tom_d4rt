// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                  CANYON FLAX --- SliverFillRemaining deep dive
// =============================================================================
//
//  TARGET WIDGET .... SliverFillRemaining
//                     (package:flutter/widgets.dart, re-exported by
//                     package:flutter/material.dart)
//
//  CONTEXT .......... SliverFillRemaining is a sliver that fills the
//                     remaining viewport extent that has not yet been claimed
//                     by previous slivers in a CustomScrollView (or any other
//                     viewport-driven scroll surface). It is, in effect, the
//                     final tail of a scroll: a guaranteed-to-fill block that
//                     pads the bottom of a scroll surface so the foreground
//                     never floats over emptiness.
//
//                     The widget has only three levers:
//                          child            (Widget?)
//                          hasScrollBody    (bool)   default true
//                          fillOverscroll   (bool)   default false
//
//                     Their combined effect is to determine HOW the widget
//                     reports its SliverGeometry to the surrounding viewport.
//                     The widget never measures the child's intrinsic height;
//                     instead it asks the viewport: "how much space is left?"
//                     and either claims that space as a scrollable body
//                     (hasScrollBody:true) or as a flat panel that ends with
//                     the viewport (hasScrollBody:false).
//
//  THEME ............ CANYON FLAX
//
//                     A desert canyon viewed from above. We are perched on a
//                     wind-cut rim with a notebook on our knees, looking
//                     straight down into a half-mile-deep flax-yellow gorge.
//                     Strata of terracotta, ochre, and rust climb the
//                     opposing wall. A sage-green floor of brittle scrub
//                     traces the dry wash at the bottom. Far overhead, a
//                     strip of overlook-blue sky frames the rim. The whole
//                     scene reads like a vertical scroll with a fill at the
//                     bottom: that is the metaphor we ride for the demo.
//
//                     The prose voice is a geologist's field-trip log: brief,
//                     observational, comfortable with terminology, fond of
//                     names and units. The cliffs become slivers; the canyon
//                     floor becomes the SliverFillRemaining tail; the strata
//                     become other slivers stacked above the tail.
//
//  WHAT WE EXPLORE
//
//      child                ........ The widget the tail wraps around.
//      hasScrollBody:true   ........ The default. The tail behaves like a
//                                    scrollable body; the viewport keeps
//                                    scrolling under it.
//      hasScrollBody:false  ........ The tail is a flat panel; the viewport
//                                    terminates with the tail's bottom edge.
//      fillOverscroll       ........ The tail also claims overscroll space
//                                    (only meaningful with bouncing physics
//                                    on iOS-style scrolls).
//      placement contracts  ........ Where the widget can legally appear in
//                                    a CustomScrollView (always last).
//      pull-to-refresh hint ........ How the tail interacts with overscroll
//                                    (sketched, not invoked).
//
//  WHAT WE DO NOT TOUCH
//
//      ScrollController, ScrollPhysics overrides at runtime, no live
//      bouncing animations, no setState, no streams, no timers.
//
//  D4RT CONSTRAINTS
//
//      * build() runs ONCE. We return one snapshot tree.
//      * No StatefulWidget, no setState, no controllers, no async work.
//      * No `for-in` over BridgedInstance: indexed loops only.
//      * No `.value` reads on Tween.animate: we do not animate at all.
//      * Use `.withValues(alpha: ...)` (not `.withOpacity`).
//      * Import only `package:flutter/material.dart`.
//
//  FILE LAYOUT (visual sections)
//
//      Section  1 .... Title banner with palette swatches and metric strip
//      Section  2 .... Prose anatomy of SliverFillRemaining (geologist's log)
//      Section  3 .... Property anatomy table (child, hasScrollBody,
//                      fillOverscroll, key)
//      Section  4 .... Three-states demo (hasScrollBody true/false,
//                      fillOverscroll true)
//      Section  5 .... CustomScrollView mini-canyons --- eight distinct
//                      compositions, each ends in a SliverFillRemaining tail
//      Section  6 .... Pull-to-refresh integration sketch (no live refresh)
//      Section  7 .... Comparison grid: SliverFillRemaining vs
//                      SliverFillViewport vs SliverToBoxAdapter vs
//                      SliverPadding vs SliverList
//      Section  8 .... Layout pitfalls (intrinsic vs explicit child sizing)
//      Section  9 .... DO / AVOID callouts
//      Section 10 .... Code recipe cards
//      Section 11 .... Glossary
//      Section 12 .... Recap footer
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Canyon Flax
// ---------------------------------------------------------------------------
//  A vertically banded palette: the sky at the top, the flax-yellow cliff
//  walls in the upper middle, terracotta strata in the lower middle, sage
//  scrub at the canyon floor, and rust shadows at the deepest overhangs.
//  Each token is named for the geologic feature it represents in the metaphor.
// ---------------------------------------------------------------------------

const Color cnSkyHigh = Color(0xFF6FA8C7); // overlook sky, midday
const Color cnSkyDeep = Color(0xFF3F7D9E); // overlook sky, near horizon
const Color cnRimDust = Color(0xFFE7D9B8); // pale dust on the canyon rim
const Color cnFlaxBright = Color(0xFFEAC65A); // flax-yellow cliff face
const Color cnFlaxDeep = Color(0xFFC79A2A); // shaded flax cliff
const Color cnFlaxBurn = Color(0xFFA17418); // sun-baked flax cliff
const Color cnTerracotta = Color(0xFFB46A3F); // terracotta stratum
const Color cnTerraDeep = Color(0xFF8C4A2A); // shaded terracotta
const Color cnRust = Color(0xFF7A2E18); // rust-iron stratum
const Color cnOchre = Color(0xFFD89A4A); // ochre stratum
const Color cnSage = Color(0xFF7FA170); // sage scrub on floor
const Color cnSageDeep = Color(0xFF4F6F48); // shaded sage
const Color cnDryWash = Color(0xFFB8A77A); // pale dry-wash silt
const Color cnShadow = Color(0xFF2D2218); // overhang shadow
const Color cnBone = Color(0xFFF1E9D5); // sun-bleached bone
const Color cnInk = Color(0xFF1A1410); // field-notebook ink

// Catalogue of every palette token, used by the title banner.
const List<List<Object>> kPalette = <List<Object>>[
  ['skyHigh', cnSkyHigh],
  ['skyDeep', cnSkyDeep],
  ['rimDust', cnRimDust],
  ['flaxBright', cnFlaxBright],
  ['flaxDeep', cnFlaxDeep],
  ['flaxBurn', cnFlaxBurn],
  ['terracotta', cnTerracotta],
  ['terraDeep', cnTerraDeep],
  ['rust', cnRust],
  ['ochre', cnOchre],
  ['sage', cnSage],
  ['sageDeep', cnSageDeep],
  ['dryWash', cnDryWash],
  ['shadow', cnShadow],
  ['bone', cnBone],
  ['ink', cnInk],
];

// ---------------------------------------------------------------------------
//  TEXT STYLES
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w800,
  color: cnBone,
  letterSpacing: 1.4,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontStyle: FontStyle.italic,
  color: cnRimDust,
  height: 1.45,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: cnInk,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13.0,
  height: 1.45,
  color: cnInk,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12.5,
  height: 1.5,
  color: cnInk,
);

const TextStyle kSmallLabelStyle = TextStyle(
  fontSize: 11.0,
  color: cnRust,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
);

const TextStyle kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.0,
  color: cnBone,
  height: 1.4,
);

const TextStyle kCalloutDoStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w800,
  color: cnSageDeep,
  letterSpacing: 0.5,
);

const TextStyle kCalloutAvoidStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w800,
  color: cnRust,
  letterSpacing: 0.5,
);

// ---------------------------------------------------------------------------
//  ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('[canyon-flax] SliverFillRemaining deep-dive demo starting');
  print('[canyon-flax] Theme: desert canyon from above, geologist field-log');
  print('[canyon-flax] D4rt mode: snapshot build, no Stateful, no controllers');
  print('[canyon-flax] Target widget: SliverFillRemaining (sliver tail)');
  print('[canyon-flax] Constructor: ({child, hasScrollBody, fillOverscroll})');
  print('[canyon-flax] Composing twelve-section snapshot tree...');

  // Sanity-construct a tiny SliverFillRemaining up front so the bridge sees
  // the symbol exercised even before any of the visual section helpers run.
  final SliverFillRemaining warmup = SliverFillRemaining(
    hasScrollBody: false,
    fillOverscroll: false,
    child: Container(color: cnFlaxBright),
  );
  print('[canyon-flax] warmup tail built: '
      'hasScrollBody=${warmup.hasScrollBody} '
      'fillOverscroll=${warmup.fillOverscroll}');

  return Scaffold(
    backgroundColor: cnRimDust,
    appBar: AppBar(
      backgroundColor: cnShadow,
      foregroundColor: cnBone,
      elevation: 0,
      title: Text(
        'SliverFillRemaining --- Canyon Flax',
        style: TextStyle(
          color: cnBone,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section1TitleBanner(),
          const SizedBox(height: 28.0),
          _section2ProseAnatomy(),
          const SizedBox(height: 28.0),
          _section3PropertyAnatomy(),
          const SizedBox(height: 28.0),
          _section4ThreeStates(),
          const SizedBox(height: 28.0),
          _section5MiniCanyons(),
          const SizedBox(height: 28.0),
          _section6PullToRefresh(),
          const SizedBox(height: 28.0),
          _section7ComparisonGrid(),
          const SizedBox(height: 28.0),
          _section8LayoutPitfalls(),
          const SizedBox(height: 28.0),
          _section9DoAvoid(),
          const SizedBox(height: 28.0),
          _section10CodeRecipes(),
          const SizedBox(height: 28.0),
          _section11Glossary(),
          const SizedBox(height: 28.0),
          _section12RecapFooter(),
          const SizedBox(height: 48.0),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 --- TITLE BANNER WITH PALETTE SWATCHES
// ===========================================================================
//
// The banner sits above the rest of the demo like the topographic strip on
// a folded park map: a gradient from overlook-blue at the top, down through
// flax-yellow cliff, into shadow at the bottom. We list the sixteen palette
// tokens on the banner so the reader can map any later color back to its
// geologic role.
// ===========================================================================

Widget _section1TitleBanner() {
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final String name = kPalette[i][0] as String;
    final Color color = kPalette[i][1] as Color;
    final bool dark = i >= 6 && i <= 13; // mid-range tokens get light fg
    swatches.add(_swatchChip(name, color, dark ? cnBone : cnInk));
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          cnSkyHigh,
          cnSkyDeep,
          cnFlaxBright,
          cnFlaxBurn,
          cnTerracotta,
          cnRust,
          cnShadow,
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cnShadow.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 64.0,
              height: 64.0,
              decoration: BoxDecoration(
                color: cnFlaxBright,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: cnBone, width: 2.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: cnShadow.withValues(alpha: 0.35),
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'SFR',
                style: TextStyle(
                  color: cnInk,
                  fontWeight: FontWeight.w900,
                  fontSize: 22.0,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'SliverFillRemaining',
                    style: kTitleStyle,
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'A sliver that claims the leftover viewport extent. '
                    'Sits at the tail of a CustomScrollView. Three knobs: '
                    'child, hasScrollBody, fillOverscroll.',
                    style: kSubtitleStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        _bannerMetricStrip(),
        const SizedBox(height: 20.0),
        Text(
          'CANYON FLAX PALETTE',
          style: TextStyle(
            color: cnRimDust,
            fontSize: 11.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: swatches,
        ),
      ],
    ),
  );
}

Widget _bannerMetricStrip() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: cnShadow.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cnBone.withValues(alpha: 0.18)),
    ),
    child: Row(
      children: <Widget>[
        _metric('placement', 'last sliver'),
        _metricDivider(),
        _metric('child', 'optional'),
        _metricDivider(),
        _metric('scrollBody', 'true | false'),
        _metricDivider(),
        _metric('overscroll', 'iOS bounce'),
      ],
    ),
  );
}

Widget _metric(String label, String value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: cnRimDust,
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          value,
          style: TextStyle(
            color: cnBone,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _metricDivider() {
  return Container(
    width: 1.0,
    height: 26.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0),
    color: cnBone.withValues(alpha: 0.18),
  );
}

Widget _swatchChip(String name, Color color, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: cnBone.withValues(alpha: 0.25)),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 2 --- PROSE ANATOMY (geologist's field-trip log)
// ===========================================================================
//
// Eight paragraphs in the voice of a geologist's field-trip log. Each
// paragraph names one aspect of SliverFillRemaining's contract with the
// surrounding viewport: SliverConstraints, SliverGeometry, the meaning of
// the hasScrollBody and fillOverscroll levers, the relationship to viewport
// physics, the placement rule, and the difference between fill-by-extent
// and fill-by-intrinsic.
// ===========================================================================

Widget _section2ProseAnatomy() {
  return _proseCard(
    title: 'Geologist\'s notes on SliverFillRemaining',
    paragraphs: <String>[
      'Imagine standing on the rim of a dry desert canyon at noon. The cliff '
          'wall opposite you is striped: pale flax at the top, terracotta in '
          'the middle, rust-iron at the deepest overhangs. Each stratum was '
          'laid down at a different epoch. Down at the bottom, far below the '
          'rim, the canyon floor extends from wall to wall in a flat sage-'
          'green sheet. That floor is what SliverFillRemaining models: it is '
          'the layer that claims whatever vertical extent the viewport has '
          'not already given to the strata above it.',
      'SliverFillRemaining is invoked from inside a CustomScrollView, '
          'NestedScrollView, or any other viewport that walks a list of '
          'slivers in order. Each preceding sliver consumes some of the '
          'viewport\'s remainingPaintExtent and remainingCacheExtent. By the '
          'time the dispatcher reaches SliverFillRemaining, those quantities '
          'tell it exactly how much room is left. The widget then reports a '
          'SliverGeometry whose paintExtent equals that remainder.',
      'The first lever is `child`. It is optional. If present, it is given '
          'a finite height equal to the remaining viewport extent and is '
          'stretched to the cross-axis width. The child does NOT control '
          'the tail\'s height. The viewport controls the tail\'s height, '
          'and the child must accept whatever height it gets. This is the '
          'point of confusion that catches most newcomers.',
      'The second lever is `hasScrollBody`. Default is true. When true, the '
          'tail behaves like a scrollable body of remaining extent: the '
          'viewport keeps scrolling underneath it, and the child is laid out '
          'as if it were content that could itself participate in scrolling. '
          'When false, the tail is a flat panel: the viewport stops at the '
          'bottom of the tail. This is the form you want for empty-state '
          'screens, error pages, and any time you need a static footer that '
          'fills the gap without participating in scroll.',
      'The third lever is `fillOverscroll`. Default is false. When true, '
          'the tail also extends into the overscroll region of bouncing '
          'physics --- this is meaningful on iOS-style scrolls where the '
          'user can drag past the natural end and watch the content bounce. '
          'It has no visible effect on clamping physics (Android), where '
          'overscroll never opens up in the first place.',
      'Placement matters. SliverFillRemaining must be the LAST sliver in '
          'the slivers list. There is no point putting another sliver after '
          'it: the tail has already taken everything that was left. If you '
          'do, the next sliver will be given zero extent and will be skipped '
          'in painting. The framework will not warn you, but the second '
          'tail will simply not appear.',
      'There is a subtlety worth naming. SliverFillRemaining does not '
          'measure its child\'s intrinsic height. It does not ask "how tall '
          'do you want to be?" --- it tells the child "you are this tall, '
          'lay yourself out". If the child wants to be taller than the '
          'remaining extent, it will overflow inside the tail. If the child '
          'is shorter, it will be stretched. To control alignment within '
          'the tail, wrap the child in a Center, an Align, a Padding, or a '
          'Column with mainAxisAlignment.',
      'A geologist\'s rule of thumb: SliverFillRemaining is a flat layer. '
          'It records the extent the viewport had left at the moment it '
          'was reached. It records nothing about the child\'s wishes for '
          'height. If you need the child to drive the height, you do not '
          'want SliverFillRemaining --- you want SliverToBoxAdapter. Canyon '
          'Flax: layer the strata, end with the floor, write the elevation '
          'in the field log, move on.',
    ],
  );
}

// ===========================================================================
// SECTION 3 --- PROPERTY ANATOMY TABLE
// ===========================================================================

Widget _section3PropertyAnatomy() {
  return _container(
    title: 'Properties of SliverFillRemaining',
    subtitle: 'Three knobs plus the standard Key.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _propRow(
          name: 'child',
          type: 'Widget?',
          isRequired: false,
          defaultValue: 'null',
          summary: 'Optional child to render inside the tail. Receives a '
              'finite height equal to the remaining viewport extent and '
              'is stretched across the cross axis. The child does not '
              'control the tail height.',
        ),
        _propRow(
          name: 'hasScrollBody',
          type: 'bool',
          isRequired: false,
          defaultValue: 'true',
          summary: 'When true (default), the tail behaves like a scrollable '
              'body. When false, the tail is a flat panel and the viewport '
              'terminates at the tail\'s bottom edge.',
        ),
        _propRow(
          name: 'fillOverscroll',
          type: 'bool',
          isRequired: false,
          defaultValue: 'false',
          summary: 'When true, the tail also fills overscroll space '
              'opened by bouncing physics (iOS-style). No effect under '
              'clamping physics.',
        ),
        _propRow(
          name: 'key',
          type: 'Key?',
          isRequired: false,
          defaultValue: 'null',
          summary: 'Standard Widget key. Useful when the surrounding '
              'CustomScrollView rebuilds and you want to preserve the '
              'tail\'s element identity.',
        ),
      ],
    ),
  );
}

Widget _propRow({
  required String name,
  required String type,
  required bool isRequired,
  required String defaultValue,
  required String summary,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cnShadow.withValues(alpha: 0.06),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: cnShadow,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: cnFlaxBright,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: cnSage.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: cnInk,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            if (isRequired)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: cnRust,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'required',
                  style: TextStyle(
                    color: cnBone,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: cnRimDust,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'default: $defaultValue',
                  style: TextStyle(
                    color: cnInk,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          summary,
          style: TextStyle(
            color: cnInk,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 --- THREE-STATES DEMO
// ===========================================================================
//
// The three-states demo lays out three side-by-side mini-viewports that
// each show a different combination of hasScrollBody and fillOverscroll.
// Each viewport is a SizedBox(height: 240) framed in a labelled card.
//
//   4.1  hasScrollBody:true  fillOverscroll:false    --- the default tail.
//   4.2  hasScrollBody:false fillOverscroll:false    --- the flat panel.
//   4.3  hasScrollBody:false fillOverscroll:true     --- the iOS bounce
//                                                       extender.
//
// We do NOT attach a ScrollController. We simply build a CustomScrollView
// with a SliverList of cliff-band rows above and a SliverFillRemaining tail
// below. The tail is colored sage in case 4.1, dryWash in case 4.2, and
// flaxBright in case 4.3 so the reader can see at a glance which state
// they are looking at.
// ===========================================================================

Widget _section4ThreeStates() {
  return _container(
    title: 'Three states of the tail',
    subtitle: 'hasScrollBody and fillOverscroll, side by side.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _stateCard(
          tag: '4.1',
          title: 'hasScrollBody : true',
          captionLine1: 'The default. The tail is a scrollable body of '
              'remaining extent.',
          captionLine2: 'Content scrolls under the tail; the child can '
              'itself participate in scroll if it offers a body.',
          tailColor: cnSage,
          tailLabel: 'scrollable tail',
          buildView: () => _miniCanyonViewportA(),
        ),
        const SizedBox(height: 16.0),
        _stateCard(
          tag: '4.2',
          title: 'hasScrollBody : false',
          captionLine1: 'A flat panel that fills the leftover viewport '
              'extent.',
          captionLine2: 'The viewport terminates at the bottom of this '
              'tail. The child receives a finite height; it cannot scroll.',
          tailColor: cnDryWash,
          tailLabel: 'flat panel tail',
          buildView: () => _miniCanyonViewportB(),
        ),
        const SizedBox(height: 16.0),
        _stateCard(
          tag: '4.3',
          title: 'hasScrollBody : false, fillOverscroll : true',
          captionLine1: 'iOS bounce: the tail extends into overscroll space.',
          captionLine2: 'No visible effect under clamping (Android) physics, '
              'but harmless to set.',
          tailColor: cnFlaxBright,
          tailLabel: 'overscroll-fill tail',
          buildView: () => _miniCanyonViewportC(),
        ),
      ],
    ),
  );
}

Widget _stateCard({
  required String tag,
  required String title,
  required String captionLine1,
  required String captionLine2,
  required Color tailColor,
  required String tailLabel,
  required Widget Function() buildView,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: cnShadow,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: cnFlaxBright,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: cnInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: tailColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: cnInk.withValues(alpha: 0.3)),
              ),
              child: Text(
                tailLabel,
                style: TextStyle(
                  color: cnInk,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(captionLine1, style: kBodyStyle),
        Text(captionLine2, style: kBodyStyle),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: buildView(),
          ),
        ),
      ],
    ),
  );
}

Widget _miniCanyonViewportA() {
  return CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(child: _stratumBand('rim dust', cnRimDust, 28.0)),
      SliverToBoxAdapter(
          child: _stratumBand('flax bright', cnFlaxBright, 36.0)),
      SliverToBoxAdapter(child: _stratumBand('flax deep', cnFlaxDeep, 36.0)),
      SliverToBoxAdapter(
          child: _stratumBand('terracotta', cnTerracotta, 28.0)),
      SliverFillRemaining(
        hasScrollBody: true,
        fillOverscroll: false,
        child: Container(
          color: cnSage,
          alignment: Alignment.center,
          child: Text(
            'tail (hasScrollBody:true)',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _miniCanyonViewportB() {
  return CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(child: _stratumBand('rim dust', cnRimDust, 28.0)),
      SliverToBoxAdapter(
          child: _stratumBand('flax bright', cnFlaxBright, 36.0)),
      SliverToBoxAdapter(
          child: _stratumBand('terracotta', cnTerracotta, 28.0)),
      SliverFillRemaining(
        hasScrollBody: false,
        fillOverscroll: false,
        child: Container(
          color: cnDryWash,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'tail (flat panel)',
                style: TextStyle(
                  color: cnInk,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'hasScrollBody:false',
                style: TextStyle(
                  color: cnInk.withValues(alpha: 0.7),
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _miniCanyonViewportC() {
  return CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(child: _stratumBand('rim dust', cnRimDust, 28.0)),
      SliverToBoxAdapter(
          child: _stratumBand('flax bright', cnFlaxBright, 36.0)),
      SliverFillRemaining(
        hasScrollBody: false,
        fillOverscroll: true,
        child: Container(
          color: cnFlaxBright,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'tail (overscroll-filling)',
                style: TextStyle(
                  color: cnInk,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'fillOverscroll:true',
                style: TextStyle(
                  color: cnInk.withValues(alpha: 0.7),
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _stratumBand(String label, Color color, double height) {
  return Container(
    height: height,
    color: color,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Text(
      label,
      style: TextStyle(
        color: cnInk,
        fontWeight: FontWeight.w700,
        fontFamily: 'monospace',
        fontSize: 11.5,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 5 --- CustomScrollView MINI-CANYONS
// ===========================================================================
//
// Eight CustomScrollView compositions, each ending with a SliverFillRemaining
// tail. The compositions vary in:
//
//   5.1  SliverAppBar (pinned) + SliverList of strata + flat tail.
//   5.2  SliverAppBar (floating) + SliverGrid + scrollable tail.
//   5.3  SliverPersistentHeader + SliverList + flat tail with overscroll.
//   5.4  SliverPadding around SliverList + SliverPadding tail wrapper.
//   5.5  SliverList of cliff-band rows + SliverList of strata + flat tail.
//   5.6  SliverAppBar with FlexibleSpaceBar + SliverGrid + flat tail.
//   5.7  SliverAppBar (snap) + SliverList + scrollable tail (default).
//   5.8  SliverList + SliverPadding + SliverList + flat tail (deep stack).
//
// Each composition is rendered into a SizedBox(height: 240) frame and
// labelled in a strip above the frame. We never attach a ScrollController.
// ===========================================================================

Widget _section5MiniCanyons() {
  return _container(
    title: 'Mini-canyons --- eight CustomScrollView compositions',
    subtitle: 'Each ends with a SliverFillRemaining tail.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _miniCanyonCard(
          tag: '5.1',
          title: 'pinned appBar + strata list + flat tail',
          summary: 'SliverAppBar pinned at the top, a SliverList of '
              'six cliff-band rows, then a flat SliverFillRemaining.',
          buildView: () => _composition51(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.2',
          title: 'floating appBar + sliver grid + scrollable tail',
          summary: 'SliverAppBar that floats back into view, a 3-column '
              'SliverGrid of rust pebbles, then a scrollable tail.',
          buildView: () => _composition52(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.3',
          title: 'persistent header + list + flat tail with overscroll',
          summary: 'A custom SliverPersistentHeaderDelegate at the top, '
              'a list of strata, and a flat tail that fills overscroll.',
          buildView: () => _composition53(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.4',
          title: 'sliver padding wrappers + flat tail',
          summary: 'SliverPadding wraps the body slivers, and the '
              'SliverFillRemaining is itself wrapped by SliverPadding.',
          buildView: () => _composition54(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.5',
          title: 'cliff-bands list + strata list + flat tail',
          summary: 'Two SliverLists in succession, finishing with a flat '
              'tail painted in dryWash for visibility.',
          buildView: () => _composition55(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.6',
          title: 'flexible-space appBar + grid + flat tail',
          summary: 'SliverAppBar with FlexibleSpaceBar showing a flax-'
              'gradient title, a small grid, and a flat tail.',
          buildView: () => _composition56(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.7',
          title: 'snap appBar + list + scrollable tail (default)',
          summary: 'SliverAppBar with snap:true and floating:true, a '
              'list of strata, and the default scrollable tail.',
          buildView: () => _composition57(),
        ),
        const SizedBox(height: 14.0),
        _miniCanyonCard(
          tag: '5.8',
          title: 'deep stack: list + padding + list + flat tail',
          summary: 'Three layered slivers above the tail: cliff-band '
              'list, padded stratum list, then the flat tail.',
          buildView: () => _composition58(),
        ),
      ],
    ),
  );
}

Widget _miniCanyonCard({
  required String tag,
  required String title,
  required String summary,
  required Widget Function() buildView,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: cnShadow,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: cnFlaxBright,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: cnInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(summary, style: kBodyStyle),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: buildView(),
          ),
        ),
      ],
    ),
  );
}

Widget _composition51() {
  final List<Widget> bands = <Widget>[];
  final List<List<Object>> rows = <List<Object>>[
    <Object>['rim dust', cnRimDust, 26.0],
    <Object>['flax bright', cnFlaxBright, 32.0],
    <Object>['flax deep', cnFlaxDeep, 30.0],
    <Object>['ochre', cnOchre, 28.0],
    <Object>['terracotta', cnTerracotta, 32.0],
    <Object>['terra deep', cnTerraDeep, 26.0],
  ];
  for (int i = 0; i < rows.length; i++) {
    final String name = rows[i][0] as String;
    final Color color = rows[i][1] as Color;
    final double height = rows[i][2] as double;
    bands.add(_stratumBand(name, color, height));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        backgroundColor: cnShadow,
        foregroundColor: cnBone,
        pinned: true,
        title: Text(
          'pinned masthead',
          style: TextStyle(
            color: cnFlaxBright,
            fontFamily: 'monospace',
            fontSize: 13.0,
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(bands),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: cnSage,
          alignment: Alignment.center,
          child: Text(
            'flat tail [5.1]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition52() {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < 9; i++) {
    final Color base = i.isEven ? cnRust : cnTerraDeep;
    tiles.add(Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: Text(
        'p$i',
        style: TextStyle(
          color: cnFlaxBright,
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    ));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        backgroundColor: cnTerraDeep,
        foregroundColor: cnBone,
        floating: true,
        title: Text(
          'floating masthead',
          style: TextStyle(
            color: cnFlaxBright,
            fontFamily: 'monospace',
            fontSize: 13.0,
          ),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 36.0,
        ),
        delegate: SliverChildListDelegate(tiles),
      ),
      SliverFillRemaining(
        hasScrollBody: true,
        child: Container(
          color: cnDryWash,
          alignment: Alignment.center,
          child: Text(
            'scrollable tail [5.2]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition53() {
  final List<Widget> bands = <Widget>[];
  final List<List<Object>> rows = <List<Object>>[
    <Object>['flax bright', cnFlaxBright, 30.0],
    <Object>['ochre', cnOchre, 30.0],
    <Object>['terracotta', cnTerracotta, 30.0],
    <Object>['terra deep', cnTerraDeep, 30.0],
  ];
  for (int i = 0; i < rows.length; i++) {
    final String name = rows[i][0] as String;
    final Color color = rows[i][1] as Color;
    final double height = rows[i][2] as double;
    bands.add(_stratumBand(name, color, height));
  }
  return CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: <Widget>[
      SliverPersistentHeader(
        pinned: true,
        delegate: _CanyonHeaderDelegate(),
      ),
      SliverList(delegate: SliverChildListDelegate(bands)),
      SliverFillRemaining(
        hasScrollBody: false,
        fillOverscroll: true,
        child: Container(
          color: cnFlaxBright,
          alignment: Alignment.center,
          child: Text(
            'flat + overscroll tail [5.3]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition54() {
  final List<Widget> bands = <Widget>[];
  final List<List<Object>> rows = <List<Object>>[
    <Object>['rim dust', cnRimDust, 24.0],
    <Object>['flax bright', cnFlaxBright, 28.0],
    <Object>['flax deep', cnFlaxDeep, 28.0],
    <Object>['ochre', cnOchre, 24.0],
  ];
  for (int i = 0; i < rows.length; i++) {
    final String name = rows[i][0] as String;
    final Color color = rows[i][1] as Color;
    final double height = rows[i][2] as double;
    bands.add(_stratumBand(name, color, height));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverList(delegate: SliverChildListDelegate(bands)),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        sliver: SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: cnSage,
            alignment: Alignment.center,
            child: Text(
              'padded flat tail [5.4]',
              style: TextStyle(
                color: cnInk,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition55() {
  final List<Widget> cliffs = <Widget>[];
  final List<List<Object>> cliffRows = <List<Object>>[
    <Object>['cliff a', cnFlaxBright, 24.0],
    <Object>['cliff b', cnFlaxDeep, 24.0],
    <Object>['cliff c', cnFlaxBurn, 24.0],
  ];
  for (int i = 0; i < cliffRows.length; i++) {
    cliffs.add(_stratumBand(
      cliffRows[i][0] as String,
      cliffRows[i][1] as Color,
      cliffRows[i][2] as double,
    ));
  }
  final List<Widget> strata = <Widget>[];
  final List<List<Object>> strataRows = <List<Object>>[
    <Object>['stratum a', cnTerracotta, 26.0],
    <Object>['stratum b', cnTerraDeep, 26.0],
    <Object>['stratum c', cnRust, 26.0],
  ];
  for (int i = 0; i < strataRows.length; i++) {
    strata.add(_stratumBand(
      strataRows[i][0] as String,
      strataRows[i][1] as Color,
      strataRows[i][2] as double,
    ));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverList(delegate: SliverChildListDelegate(cliffs)),
      SliverList(delegate: SliverChildListDelegate(strata)),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: cnDryWash,
          alignment: Alignment.center,
          child: Text(
            'flat tail [5.5]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition56() {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < 6; i++) {
    final Color base = i.isEven ? cnOchre : cnTerracotta;
    tiles.add(Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: Text(
        'g$i',
        style: TextStyle(
          color: cnInk,
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    ));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        backgroundColor: cnFlaxBurn,
        expandedHeight: 80.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'flexible masthead',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[cnFlaxBright, cnFlaxBurn],
              ),
            ),
          ),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 32.0,
        ),
        delegate: SliverChildListDelegate(tiles),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: cnSage,
          alignment: Alignment.center,
          child: Text(
            'flat tail [5.6]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition57() {
  final List<Widget> bands = <Widget>[];
  for (int i = 0; i < 5; i++) {
    final Color color = <Color>[
      cnRimDust,
      cnFlaxBright,
      cnOchre,
      cnTerracotta,
      cnTerraDeep,
    ][i];
    bands.add(_stratumBand('snap stratum $i', color, 28.0));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        backgroundColor: cnRust,
        foregroundColor: cnBone,
        floating: true,
        snap: true,
        title: Text(
          'snap masthead',
          style: TextStyle(
            color: cnFlaxBright,
            fontFamily: 'monospace',
            fontSize: 13.0,
          ),
        ),
      ),
      SliverList(delegate: SliverChildListDelegate(bands)),
      SliverFillRemaining(
        child: Container(
          color: cnDryWash,
          alignment: Alignment.center,
          child: Text(
            'default tail [5.7]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _composition58() {
  final List<Widget> cliffs = <Widget>[];
  final List<List<Object>> cliffRows = <List<Object>>[
    <Object>['rim dust', cnRimDust, 22.0],
    <Object>['flax bright', cnFlaxBright, 22.0],
  ];
  for (int i = 0; i < cliffRows.length; i++) {
    cliffs.add(_stratumBand(
      cliffRows[i][0] as String,
      cliffRows[i][1] as Color,
      cliffRows[i][2] as double,
    ));
  }
  final List<Widget> strata = <Widget>[];
  final List<List<Object>> strataRows = <List<Object>>[
    <Object>['ochre', cnOchre, 22.0],
    <Object>['terracotta', cnTerracotta, 22.0],
    <Object>['terra deep', cnTerraDeep, 22.0],
    <Object>['rust', cnRust, 22.0],
  ];
  for (int i = 0; i < strataRows.length; i++) {
    strata.add(_stratumBand(
      strataRows[i][0] as String,
      strataRows[i][1] as Color,
      strataRows[i][2] as double,
    ));
  }
  return CustomScrollView(
    slivers: <Widget>[
      SliverList(delegate: SliverChildListDelegate(cliffs)),
      SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        sliver: SliverList(delegate: SliverChildListDelegate(strata)),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          color: cnSage,
          alignment: Alignment.center,
          child: Text(
            'flat tail [5.8]',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

class _CanyonHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 36.0;

  @override
  double get maxExtent => 36.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: cnShadow,
      alignment: Alignment.center,
      child: Text(
        'persistent header',
        style: TextStyle(
          color: cnFlaxBright,
          fontFamily: 'monospace',
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_CanyonHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 6 --- PULL-TO-REFRESH INTEGRATION SKETCH
// ===========================================================================
//
// We do NOT invoke a refresh callback here. We do not even hook a controller.
// We simply render a CustomScrollView that combines a CupertinoSliverRefresh-
// Control-like adornment band at the top with a SliverFillRemaining at the
// bottom, so the reader can see how the tail and the refresh adornment cohabit
// inside the same viewport.
//
// In a real app you would replace the adornment band with a CupertinoSliver-
// RefreshControl whose onRefresh hook returns a Future. Here the adornment is
// a static Container labelled "pull-to-refresh placeholder".
// ===========================================================================

Widget _section6PullToRefresh() {
  return _container(
    title: 'Pull-to-refresh integration (sketch)',
    subtitle: 'How the tail cohabits with a refresh adornment.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'In a live app, you would put a CupertinoSliverRefreshControl '
          'at the head of the slivers list, followed by your content '
          'slivers, ending with SliverFillRemaining. The refresh control '
          'occupies overscroll space when the user pulls past the head; '
          'the tail occupies the leftover viewport at the foot. The two '
          'are non-overlapping by construction.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 6.0),
        Text(
          'Setting fillOverscroll:true on the tail is independent of the '
          'refresh control: the tail extends into BOTTOM overscroll, the '
          'refresh control responds to TOP overscroll. They use opposite '
          'ends of the bouncing-physics envelope.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: _refreshSketchView(),
          ),
        ),
        const SizedBox(height: 10.0),
        _sketchCallout(
          label: 'NOTE',
          color: cnRust,
          text: 'The refresh band shown here is decorative. The real '
              'CupertinoSliverRefreshControl is stateful and we cannot '
              'instantiate it inside a snapshot demo.',
        ),
      ],
    ),
  );
}

Widget _refreshSketchView() {
  final List<Widget> bands = <Widget>[];
  final List<List<Object>> rows = <List<Object>>[
    <Object>['stratum 1', cnFlaxBright, 28.0],
    <Object>['stratum 2', cnFlaxDeep, 28.0],
    <Object>['stratum 3', cnOchre, 28.0],
    <Object>['stratum 4', cnTerracotta, 28.0],
    <Object>['stratum 5', cnTerraDeep, 28.0],
  ];
  for (int i = 0; i < rows.length; i++) {
    bands.add(_stratumBand(
      rows[i][0] as String,
      rows[i][1] as Color,
      rows[i][2] as double,
    ));
  }
  return CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          color: cnSkyDeep,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          alignment: Alignment.center,
          child: Text(
            'pull-to-refresh placeholder',
            style: TextStyle(
              color: cnBone,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
      SliverList(delegate: SliverChildListDelegate(bands)),
      SliverFillRemaining(
        hasScrollBody: false,
        fillOverscroll: true,
        child: Container(
          color: cnSage,
          alignment: Alignment.center,
          child: Text(
            'flat + overscroll tail',
            style: TextStyle(
              color: cnInk,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _sketchCallout({
  required String label,
  required Color color,
  required String text,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 7.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: cnBone,
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: kBodyStyle,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 --- COMPARISON GRID
// ===========================================================================
//
// SliverFillRemaining vs four neighbors. We render a 5-row table where each
// row covers one comparison axis: what each widget claims, where it is
// placed, whether it scrolls, whether it sizes by intrinsic, and what its
// typical use case is.
// ===========================================================================

Widget _section7ComparisonGrid() {
  return _container(
    title: 'Comparison grid: tail-shaped slivers',
    subtitle: 'SliverFillRemaining vs SliverFillViewport vs '
        'SliverToBoxAdapter vs SliverPadding vs SliverList.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _comparisonHeaderRow(),
        _comparisonBodyRow(
          name: 'SliverFillRemaining',
          claims: 'leftover viewport',
          placement: 'last only',
          scroll: 'optional',
          sizing: 'viewport-driven',
          tone: cnSage,
        ),
        _comparisonBodyRow(
          name: 'SliverFillViewport',
          claims: 'one full viewport per child',
          placement: 'anywhere',
          scroll: 'always',
          sizing: 'viewport-driven',
          tone: cnFlaxBright,
        ),
        _comparisonBodyRow(
          name: 'SliverToBoxAdapter',
          claims: 'child intrinsic',
          placement: 'anywhere',
          scroll: 'never',
          sizing: 'child-driven',
          tone: cnOchre,
        ),
        _comparisonBodyRow(
          name: 'SliverPadding',
          claims: 'padding around inner sliver',
          placement: 'wraps another sliver',
          scroll: 'inherits',
          sizing: 'inner sliver',
          tone: cnDryWash,
        ),
        _comparisonBodyRow(
          name: 'SliverList',
          claims: 'sum of child intrinsic heights',
          placement: 'anywhere',
          scroll: 'lazy build',
          sizing: 'child-driven',
          tone: cnTerracotta,
        ),
        const SizedBox(height: 14.0),
        Text(
          'The pattern: SliverFillRemaining is the only one in the family '
          'that asks the viewport for its size. The others all derive their '
          'size either from their child (SliverToBoxAdapter, SliverList, '
          'SliverPadding) or by repeating viewport-sized children '
          '(SliverFillViewport).',
          style: kBodyStyle,
        ),
      ],
    ),
  );
}

Widget _comparisonHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: cnShadow,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        _comparisonHeaderCell('widget', 3),
        _comparisonHeaderCell('claims', 3),
        _comparisonHeaderCell('placement', 2),
        _comparisonHeaderCell('scroll', 2),
        _comparisonHeaderCell('sizing', 2),
      ],
    ),
  );
}

Widget _comparisonHeaderCell(String label, int flex) {
  return Expanded(
    flex: flex,
    child: Text(
      label.toUpperCase(),
      style: TextStyle(
        color: cnFlaxBright,
        fontFamily: 'monospace',
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _comparisonBodyRow({
  required String name,
  required String claims,
  required String placement,
  required String scroll,
  required String sizing,
  required Color tone,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: tone.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _comparisonBodyCell(name, 3, weight: FontWeight.w800),
        _comparisonBodyCell(claims, 3),
        _comparisonBodyCell(placement, 2),
        _comparisonBodyCell(scroll, 2),
        _comparisonBodyCell(sizing, 2),
      ],
    ),
  );
}

Widget _comparisonBodyCell(String text, int flex,
    {FontWeight weight = FontWeight.w600}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        color: cnInk,
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: weight,
        height: 1.35,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 8 --- LAYOUT PITFALLS
// ===========================================================================
//
// Four common mistakes, each presented as a short paragraph followed by a
// concrete fix.
//
//   8.1  Putting SliverFillRemaining inside a non-scrollable parent.
//   8.2  Relying on the child's intrinsic height to drive the tail.
//   8.3  Placing another sliver after SliverFillRemaining.
//   8.4  Using fillOverscroll:true under clamping physics.
// ===========================================================================

Widget _section8LayoutPitfalls() {
  return _container(
    title: 'Layout pitfalls',
    subtitle: 'Four common mistakes and their fixes.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _pitfallCard(
          tag: '8.1',
          title: 'Used outside a scrollable viewport',
          mistake: 'You put SliverFillRemaining inside a Column or a '
              'SliverList delegate, expecting it to fill the parent.',
          fix: 'SliverFillRemaining only works inside a sliver-aware '
              'viewport (CustomScrollView, NestedScrollView). For non-'
              'sliver containers, use Expanded or SizedBox.expand.',
        ),
        _pitfallCard(
          tag: '8.2',
          title: 'Child intrinsic height is ignored',
          mistake: 'You wrap a 200-pixel-tall card in a SliverFillRemaining '
              'expecting the tail to be 200 pixels tall.',
          fix: 'The tail height is dictated by the viewport, not the child. '
              'If you want the tail to be exactly the child\'s height, use '
              'SliverToBoxAdapter instead.',
        ),
        _pitfallCard(
          tag: '8.3',
          title: 'Another sliver placed after the tail',
          mistake: 'You add a SliverList after SliverFillRemaining to show '
              'a footer.',
          fix: 'The tail has already claimed the leftover extent. Anything '
              'after it gets zero space. Move the footer into the tail\'s '
              'child via Column(mainAxisAlignment: MainAxisAlignment.end).',
        ),
        _pitfallCard(
          tag: '8.4',
          title: 'fillOverscroll under clamping physics',
          mistake: 'You set fillOverscroll:true on Android and expect a '
              'visible difference.',
          fix: 'Clamping physics never opens overscroll, so the flag has '
              'no visible effect. It is harmless to set, but ineffective.',
        ),
      ],
    ),
  );
}

Widget _pitfallCard({
  required String tag,
  required String title,
  required String mistake,
  required String fix,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: cnRust,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: cnBone,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: cnInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 60.0,
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: cnRust.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'mistake',
                style: TextStyle(
                  color: cnRust,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Text(mistake, style: kBodyStyle)),
          ],
        ),
        const SizedBox(height: 6.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 60.0,
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: cnSageDeep.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'fix',
                style: TextStyle(
                  color: cnSageDeep,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Text(fix, style: kBodyStyle)),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 --- DO / AVOID CALLOUTS
// ===========================================================================

Widget _section9DoAvoid() {
  return _container(
    title: 'Do / Avoid',
    subtitle: 'Quick rules for the field log.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _doRow('Place SliverFillRemaining as the LAST sliver in the list.'),
        _doRow('Use hasScrollBody:false for empty-state and error pages.'),
        _doRow('Use fillOverscroll:true when you want the tail color to '
            'extend into iOS-style bounce zone.'),
        _doRow('Wrap the child in Center, Align, or Padding to control '
            'positioning within the tail.'),
        _doRow('Use SliverToBoxAdapter when the child should drive its '
            'own height instead of the viewport.'),
        const SizedBox(height: 8.0),
        _avoidRow('Do NOT add slivers after SliverFillRemaining --- they '
            'will be given zero extent.'),
        _avoidRow('Do NOT rely on the child\'s intrinsic height. The '
            'viewport, not the child, sets the tail height.'),
        _avoidRow('Do NOT put SliverFillRemaining inside a non-sliver '
            'parent --- it will throw at layout.'),
        _avoidRow('Do NOT expect fillOverscroll to do anything visible '
            'under clamping physics.'),
        _avoidRow('Do NOT use SliverFillRemaining for content that '
            'naturally exceeds the viewport --- use SliverList instead.'),
      ],
    ),
  );
}

Widget _doRow(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: cnSage.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: cnSageDeep.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'DO',
          style: kCalloutDoStyle,
        ),
        const SizedBox(width: 10.0),
        Expanded(child: Text(text, style: kBodyStyle)),
      ],
    ),
  );
}

Widget _avoidRow(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: cnRust.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: cnRust.withValues(alpha: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'AVOID',
          style: kCalloutAvoidStyle,
        ),
        const SizedBox(width: 10.0),
        Expanded(child: Text(text, style: kBodyStyle)),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 --- CODE RECIPE CARDS
// ===========================================================================
//
// Five short, copy-pasteable recipes for using SliverFillRemaining well.
// Each recipe is a snippet of code embedded in a Container styled to look
// like a notebook page.
// ===========================================================================

Widget _section10CodeRecipes() {
  return _container(
    title: 'Code recipes',
    subtitle: 'Five short, copy-pasteable recipes.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _recipeCard(
          name: 'recipe-01',
          title: 'Empty-state screen',
          code: 'CustomScrollView(\n'
              '  slivers: <Widget>[\n'
              '    SliverAppBar(title: Text("Inbox")),\n'
              '    SliverFillRemaining(\n'
              '      hasScrollBody: false,\n'
              '      child: Center(\n'
              '        child: Text("No messages."),\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
        _recipeCard(
          name: 'recipe-02',
          title: 'Error page that fills the viewport',
          code: 'CustomScrollView(\n'
              '  slivers: <Widget>[\n'
              '    SliverFillRemaining(\n'
              '      hasScrollBody: false,\n'
              '      child: Padding(\n'
              '        padding: EdgeInsets.all(24.0),\n'
              '        child: Column(\n'
              '          mainAxisAlignment: MainAxisAlignment.center,\n'
              '          children: const <Widget>[\n'
              '            Icon(Icons.error_outline, size: 48.0),\n'
              '            SizedBox(height: 12.0),\n'
              '            Text("Something went wrong."),\n'
              '          ],\n'
              '        ),\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
        _recipeCard(
          name: 'recipe-03',
          title: 'iOS-style overscroll fill',
          code: 'CustomScrollView(\n'
              '  physics: const BouncingScrollPhysics(),\n'
              '  slivers: <Widget>[\n'
              '    SliverList(delegate: ...),\n'
              '    SliverFillRemaining(\n'
              '      hasScrollBody: false,\n'
              '      fillOverscroll: true,\n'
              '      child: ColoredBox(color: Colors.amber),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
        _recipeCard(
          name: 'recipe-04',
          title: 'Footer pinned to the foot of the viewport',
          code: 'CustomScrollView(\n'
              '  slivers: <Widget>[\n'
              '    SliverList(delegate: ...),\n'
              '    SliverFillRemaining(\n'
              '      hasScrollBody: false,\n'
              '      child: Column(\n'
              '        mainAxisAlignment: MainAxisAlignment.end,\n'
              '        children: <Widget>[\n'
              '          FooterBar(),\n'
              '        ],\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
        _recipeCard(
          name: 'recipe-05',
          title: 'Loading state inside a scroll surface',
          code: 'CustomScrollView(\n'
              '  slivers: <Widget>[\n'
              '    SliverAppBar(title: Text("Loading")),\n'
              '    SliverFillRemaining(\n'
              '      hasScrollBody: false,\n'
              '      child: Center(\n'
              '        child: CircularProgressIndicator(),\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String name,
  required String title,
  required String code,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: cnShadow,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: cnFlaxBurn.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: cnFlaxBright,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: cnInk,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: cnBone,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: cnInk,
            borderRadius: BorderRadius.circular(6.0),
          ),
          width: double.infinity,
          child: Text(
            code,
            style: kCodeStyle,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 --- GLOSSARY
// ===========================================================================
//
// Twelve entries. The vocabulary that the rest of the demo relies on.
// ===========================================================================

Widget _section11Glossary() {
  final List<List<String>> entries = <List<String>>[
    <String>[
      'sliver',
      'A component of a scroll view that can be laid out incrementally as '
          'the viewport scrolls. Slivers report SliverGeometry to the '
          'surrounding viewport.',
    ],
    <String>[
      'viewport',
      'The visible window of a scroll surface. Holds a list of slivers and '
          'computes how each sliver fits into the available space.',
    ],
    <String>[
      'paintExtent',
      'The amount of viewport space, in the scroll direction, that a sliver '
          'currently occupies for painting purposes.',
    ],
    <String>[
      'remainingPaintExtent',
      'The amount of viewport space left after preceding slivers have '
          'claimed their paintExtent. SliverFillRemaining queries this.',
    ],
    <String>[
      'scrollExtent',
      'The total scrollable extent contributed by a sliver, regardless of '
          'how much of it is currently visible.',
    ],
    <String>[
      'overscroll',
      'The region beyond the natural scroll bounds. Visible only with '
          'bouncing physics; clamping physics never opens it up.',
    ],
    <String>[
      'BouncingScrollPhysics',
      'The iOS-style scroll physics. Allows overscroll regions to open up '
          'and rubber-band back when the user releases.',
    ],
    <String>[
      'ClampingScrollPhysics',
      'The Android-style scroll physics. Prevents overscroll; content '
          'cannot be dragged past the natural scroll bounds.',
    ],
    <String>[
      'CustomScrollView',
      'A scroll surface whose content is built from a list of slivers. '
          'The natural home of SliverFillRemaining.',
    ],
    <String>[
      'NestedScrollView',
      'A two-tier scroll surface that coordinates an outer header sliver '
          'list with an inner body. SliverFillRemaining can also live in '
          'the inner body.',
    ],
    <String>[
      'SliverGeometry',
      'The output object a sliver returns to its viewport. Carries '
          'paintExtent, scrollExtent, layoutExtent, and other contract '
          'fields.',
    ],
    <String>[
      'SliverConstraints',
      'The input object a viewport hands to a sliver. Carries scroll '
          'offset, remaining extents, axis direction, growth direction.',
    ],
  ];
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    rows.add(_glossaryRow(entries[i][0], entries[i][1]));
  }
  return _container(
    title: 'Glossary',
    subtitle: 'Twelve terms used throughout the field log.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _glossaryRow(String term, String definition) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 7.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: cnShadow,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            term,
            style: TextStyle(
              color: cnFlaxBright,
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(definition, style: kBodyStyle),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 --- RECAP FOOTER
// ===========================================================================

Widget _section12RecapFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          cnShadow,
          cnTerraDeep,
          cnRust,
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CANYON FLAX RECAP',
          style: TextStyle(
            color: cnFlaxBright,
            fontSize: 12.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'SliverFillRemaining is the canyon floor. It claims whatever '
          'vertical extent is left over once the cliff strata above it '
          'have taken their share. Three knobs: child, hasScrollBody, '
          'fillOverscroll. The first picks the scenery. The second picks '
          'whether the floor is dry sage that you walk across, or a '
          'scrollable continuation of the canyon body. The third picks '
          'whether the floor extends into the iOS bounce zone.',
          style: TextStyle(
            color: cnBone,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Field log closes here. Stack the strata, end with the floor, '
          'pack the notebook, climb back up the rim. Canyon Flax.',
          style: TextStyle(
            color: cnRimDust,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SHARED HELPERS
// ===========================================================================
//
// _container .... a section-frame card with a header, a subtitle strip, and
//                 a child slot; reused by every section that is not the
//                 banner or recap.
// _proseCard .... a card that takes a list of paragraphs and lays them out
//                 with consistent spacing and styling.
// ===========================================================================

Widget _container({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cnShadow.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: kSectionHeaderStyle),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: cnFlaxBright.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            subtitle,
            style: kSectionLeadStyle,
          ),
        ),
        const SizedBox(height: 16.0),
        child,
      ],
    ),
  );
}

Widget _proseCard({
  required String title,
  required List<String> paragraphs,
}) {
  final List<Widget> children = <Widget>[];
  children.add(Text(title, style: kSectionHeaderStyle));
  children.add(const SizedBox(height: 12.0));
  for (int i = 0; i < paragraphs.length; i++) {
    if (i > 0) {
      children.add(const SizedBox(height: 10.0));
    }
    children.add(_proseParagraph(i + 1, paragraphs[i]));
  }
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: cnBone,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cnTerraDeep.withValues(alpha: 0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cnShadow.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget _proseParagraph(int index, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 26.0,
        height: 26.0,
        margin: const EdgeInsets.only(right: 10.0, top: 2.0),
        decoration: BoxDecoration(
          color: cnFlaxBright,
          borderRadius: BorderRadius.circular(13.0),
          border: Border.all(color: cnFlaxBurn, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          '$index',
          style: TextStyle(
            color: cnInk,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            fontSize: 12.0,
          ),
        ),
      ),
      Expanded(
        child: Text(text, style: kBodyStyle),
      ),
    ],
  );
}
