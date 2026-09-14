// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                      STACK SPRUCE --- ListBody deep dive
// =============================================================================
//
//  TARGET WIDGET .... ListBody  (package:flutter/widgets.dart, re-exported by
//                     package:flutter/material.dart)
//
//  CONTEXT .......... A simple, flex-less linear layout primitive. It lays
//                     its children out one after another along the main axis,
//                     each at its intrinsic size along the main axis and
//                     stretched to fill the cross axis. Unlike Column/Row,
//                     ListBody does NOT honor flex/Expanded/Spacer. Unlike
//                     Wrap, ListBody does not break lines. Unlike ListView,
//                     ListBody does not scroll on its own. Unlike Flex, it
//                     does no flexing whatsoever.
//
//                     ListBody is the no-frills cordwood-stack of Flutter
//                     layout: stack the logs, fill the cross axis, move on.
//
//  CONSTRUCTOR ......
//
//      ListBody({
//        Key? key,
//        Axis mainAxis = Axis.vertical,
//        bool reverse = false,
//        List<Widget> children = const <Widget>[],
//      })
//
//  PROPERTIES .......
//
//      mainAxis (Axis)        --- Axis.vertical (default) or Axis.horizontal.
//                                 Determines which direction the children are
//                                 laid out along.
//      reverse  (bool)        --- When true, children are laid out from the
//                                 end toward the start of the main axis. With
//                                 a vertical ListBody, reverse:true means the
//                                 first child is painted at the BOTTOM.
//      children (List<Widget>)
//                             --- The widgets to lay out, in tree order.
//
//  WHEN TO PICK ListBody
//
//      * You want the simplest possible "stack one widget after another"
//        primitive without the per-child flex bookkeeping of Column/Row.
//      * You are inside a slot that supplies UNBOUNDED constraints along the
//        main axis: a SingleChildScrollView, a CustomScrollView's
//        SliverToBoxAdapter, a ListView with shrinkWrap:true, etc. ListBody
//        relies on this — it cannot itself hand out finite main-axis space.
//      * You need predictable intrinsic-size behavior with no flex tricks.
//      * You are composing a custom sliver and want a body of children that
//        sizes to their natural height.
//
//  WHEN TO REACH ELSEWHERE
//
//      * You need flex/Spacer/Expanded behavior         --- use Column/Row.
//      * You need automatic line wrap                   --- use Wrap.
//      * You need lazy build / scrollable / large lists --- use ListView.
//      * You need cross-axis alignment options          --- use Column/Row,
//                                                          ListBody always
//                                                          stretches.
//      * You need spacing between children              --- ListBody has no
//                                                          spacing knob, you
//                                                          must put padding
//                                                          on each child.
//
//  THEME ............ STACK SPRUCE
//
//                     Forester's stacked-cordwood inventory. We are walking
//                     the woodlot at the end of the season, counting the
//                     spruce ricks: each rick is a vertical stack of clean
//                     bucked rounds; each round shows its annual rings. The
//                     palette is moss, bark, sap, lichen, snow, and the
//                     burnt-orange of a foreman's vest. Prose is written in
//                     the tone of a forester's day-log: stripped down,
//                     observational, occasionally grim.
//
//  D4RT CONSTRAINTS
//
//      * build() runs ONCE. Snapshot tree only.
//      * No StatefulWidget, setState, controllers, futures, streams, timers.
//      * No `for-in` over BridgedInstance: we use indexed `for (int i ...)`
//        loops everywhere.
//      * No `.value` reads on Tween.animate: we do not animate.
//      * Use `.withValues(alpha: ...)` instead of `.withOpacity()`.
//      * Import only `package:flutter/material.dart`.
//
//  FILE LAYOUT (visual sections)
//
//      Section  1 .... Title banner with palette swatches and a metric strip
//      Section  2 .... Prose anatomy of ListBody (forester's notes)
//      Section  3 .... Property anatomy table (mainAxis, reverse, children)
//      Section  4 .... Vertical ListBody catalogue (5 distinct compositions)
//      Section  5 .... Horizontal ListBody catalogue (3 distinct compositions)
//      Section  6 .... reverse:true variants (vertical + horizontal)
//      Section  7 .... Comparison grid: ListBody vs Column vs ListView vs Wrap
//      Section  8 .... Nested ListBody-in-Container with explicit constraints
//      Section  9 .... Scrolling integration via SingleChildScrollView (no
//                      ScrollController — we just wrap the ListBody)
//      Section 10 .... Ring-tile catalogues (themed Stack Spruce sample
//                      rings, rendered with concentric Container borders)
//      Section 11 .... DO / AVOID callouts
//      Section 12 .... Code-recipe cards (5 recipes)
//      Section 13 .... Glossary (12+ terms)
//      Section 14 .... Recap footer
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Stack Spruce
// ---------------------------------------------------------------------------
//  Sixteen named colors. Each is an ARGB Color. We use them as theme tokens
//  throughout the file. Spruce-green dominates; bark, moss, sap, snow, and
//  vest-orange supply the secondary scale.
// ---------------------------------------------------------------------------

const Color spruceNeedle = Color(0xFF1F3A2C); // deepest spruce needle
const Color spruceBough = Color(0xFF2E5440); // mid spruce branch
const Color spruceMoss = Color(0xFF4F7A4A); // ground moss
const Color spruceLichen = Color(0xFF7E9A6E); // crusty lichen
const Color spruceFern = Color(0xFFA8C29A); // young fern
const Color spruceDuff = Color(0xFF6B5A3F); // forest duff
const Color spruceBark = Color(0xFF4A3A28); // outer bark
const Color spruceCambium = Color(0xFFB28856); // inner cambium ring
const Color spruceHeartwood = Color(0xFF8B5A2B); // dense heartwood
const Color spruceSap = Color(0xFFE7C36A); // golden spruce sap
const Color spruceResin = Color(0xFFC97D2C); // hardened resin
const Color spruceVest = Color(0xFFD9531E); // foreman's vest
const Color spruceSnow = Color(0xFFF1ECE0); // clean snow on the rick
const Color spruceFog = Color(0xFFD9D6CC); // dawn fog
const Color spruceSlate = Color(0xFF394046); // wet slate
const Color spruceChar = Color(0xFF1A1715); // burned stump

// A flat catalogue of every palette token, used by the title banner.
const List<List<Object>> kPalette = <List<Object>>[
  ['needle', spruceNeedle],
  ['bough', spruceBough],
  ['moss', spruceMoss],
  ['lichen', spruceLichen],
  ['fern', spruceFern],
  ['duff', spruceDuff],
  ['bark', spruceBark],
  ['cambium', spruceCambium],
  ['heartwood', spruceHeartwood],
  ['sap', spruceSap],
  ['resin', spruceResin],
  ['vest', spruceVest],
  ['snow', spruceSnow],
  ['fog', spruceFog],
  ['slate', spruceSlate],
  ['char', spruceChar],
];

// ---------------------------------------------------------------------------
//  ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('[stack-spruce] ListBody deep-dive demo starting');
  print('[stack-spruce] Theme: forester cordwood, sixteen-color spruce scale');
  print('[stack-spruce] D4rt mode: snapshot build, no Stateful, no controllers');
  print('[stack-spruce] Target widget: ListBody (flex-less linear layout)');
  print('[stack-spruce] Constructor: ({mainAxis, reverse, children})');
  print('[stack-spruce] Composing 14-section snapshot tree...');

  // Sanity-construct a tiny ListBody up front so the bridge sees the symbol
  // exercised even before we hit any of the visual section helpers below.
  final ListBody warmup = ListBody(
    mainAxis: Axis.vertical,
    reverse: false,
    children: <Widget>[
      Container(height: 1.0, color: spruceFog),
      Container(height: 1.0, color: spruceFog),
    ],
  );
  print('[stack-spruce] warmup ListBody built: '
      'mainAxis=${warmup.mainAxis} reverse=${warmup.reverse} '
      'children=${warmup.children.length}');

  return Scaffold(
    backgroundColor: spruceSnow,
    appBar: AppBar(
      backgroundColor: spruceNeedle,
      foregroundColor: spruceSnow,
      elevation: 0,
      title: Text(
        'ListBody --- Stack Spruce',
        style: TextStyle(
          color: spruceSnow,
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
          _section4VerticalCatalogue(),
          const SizedBox(height: 28.0),
          _section5HorizontalCatalogue(),
          const SizedBox(height: 28.0),
          _section6ReverseVariants(),
          const SizedBox(height: 28.0),
          _section7ComparisonGrid(),
          const SizedBox(height: 28.0),
          _section8NestedConstrained(),
          const SizedBox(height: 28.0),
          _section9ScrollingIntegration(),
          const SizedBox(height: 28.0),
          _section10RingTiles(),
          const SizedBox(height: 28.0),
          _section11DoAvoid(),
          const SizedBox(height: 28.0),
          _section12CodeRecipes(),
          const SizedBox(height: 28.0),
          _section13Glossary(),
          const SizedBox(height: 28.0),
          _section14RecapFooter(),
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
// The banner sits above the rest of the demo like a foreman's nameplate
// nailed to the gate of the woodlot. It carries:
//
//   * The widget name (ListBody) in foundry-bold serif feel,
//   * A one-sentence position statement,
//   * The full sixteen-color Stack Spruce palette as labelled chips,
//   * A small metric strip listing key facts (no flex, intrinsic main, etc.).
//
// The chip strip is built with a Wrap because it is decorative, NOT with a
// ListBody --- ListBody does not break lines, so it would fail this
// particular layout brief. We mention this contrast explicitly in the prose.
// ===========================================================================

Widget _section1TitleBanner() {
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final String name = kPalette[i][0] as String;
    final Color color = kPalette[i][1] as Color;
    final bool dark = i < 9; // first nine are dark; switch foreground.
    swatches.add(_swatchChip(name, color, dark ? spruceSnow : spruceChar));
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          spruceNeedle,
          spruceBough,
          spruceMoss,
          spruceSlate,
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spruceChar.withValues(alpha: 0.45),
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
                color: spruceSap,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: spruceSnow, width: 2.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: spruceChar.withValues(alpha: 0.35),
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'LB',
                style: TextStyle(
                  color: spruceChar,
                  fontWeight: FontWeight.w900,
                  fontSize: 24.0,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ListBody',
                    style: TextStyle(
                      color: spruceSnow,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'A flex-less linear layout. Stacks children one after '
                    'another along the main axis at their intrinsic size, '
                    'and stretches each child to fill the cross axis.',
                    style: TextStyle(
                      color: spruceFog,
                      fontSize: 14.0,
                      height: 1.45,
                    ),
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
          'STACK SPRUCE PALETTE',
          style: TextStyle(
            color: spruceFern,
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
      color: spruceChar.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceSnow.withValues(alpha: 0.18)),
    ),
    child: Row(
      children: <Widget>[
        _metric('axes', 'vertical | horizontal'),
        _metricDivider(),
        _metric('flex', 'none --- intrinsic only'),
        _metricDivider(),
        _metric('cross-axis', 'always stretch'),
        _metricDivider(),
        _metric('reverse', 'true | false'),
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
            color: spruceFern,
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          value,
          style: TextStyle(
            color: spruceSnow,
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
    color: spruceSnow.withValues(alpha: 0.18),
  );
}

Widget _swatchChip(String name, Color color, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: spruceSnow.withValues(alpha: 0.25)),
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
// SECTION 2 --- PROSE ANATOMY (forester's notes)
// ===========================================================================
//
// Six paragraphs in the voice of a forester's day-log. We explain the role
// of ListBody in the layout family, what its constructor does, why you need
// unbounded main-axis constraints, and where it sits relative to Column,
// Row, Wrap, and ListView.
// ===========================================================================

Widget _section2ProseAnatomy() {
  return _proseCard(
    title: 'Forester\'s notes on ListBody',
    paragraphs: <String>[
      'ListBody is the cordwood-stack of Flutter. You hand it a list of '
          'children and an axis, and it lays each child end-to-end along '
          'that axis at its intrinsic size, stretched to fill the other '
          'axis. There are no knobs for flex, no Spacer, no Expanded, no '
          'crossAxisAlignment, no mainAxisAlignment. It is the simplest '
          'linear layout the framework offers.',
      'The constructor is short: an optional Axis (vertical by default), '
          'an optional bool reverse (false by default), and a list of '
          'children (empty by default). That is everything. There is no '
          'configurable spacing between children --- if you want gaps, '
          'pad each child individually, or interleave SizedBox separators '
          'in the children list.',
      'ListBody requires UNBOUNDED constraints along its main axis. If '
          'you stuff one straight into a Column without an explicit '
          'height, it will throw at layout time, complaining that it has '
          'been given finite vertical space and cannot grow. The fix is '
          'to embed it in a SingleChildScrollView, in a SliverToBoxAdapter '
          'inside a CustomScrollView, in a ListView with shrinkWrap:true, '
          'or in any other slot that promises infinite room.',
      'Why does ListBody exist when Column already does most of the same '
          'job? Because Column has flex bookkeeping baked in. ListBody '
          'skips that bookkeeping, which makes it a cleaner building '
          'block for custom slivers and for situations where you '
          'positively want intrinsic-only sizing. It is also the body '
          'used internally by ListView when shrinkWrap is true.',
      'The reverse flag flips the lay-out order along the main axis. '
          'With a vertical ListBody, reverse:true means the first child '
          'in the list paints at the BOTTOM, and the last paints at the '
          'TOP. This is genuinely different from simply reversing the '
          'list: it interacts with directional embedding and with hit-'
          'testing. Pick the flag, do not pre-reverse the list.',
      'A forester\'s rule of thumb: pick ListBody when you need a stack '
          'of bucked rounds and nothing else. Pick Column when you need '
          'flex and alignment. Pick Wrap when the rounds need to break '
          'into a second course. Pick ListView when there are too many '
          'rounds to load at once. Pick a Sliver when the rounds need '
          'to participate in shared scroll physics. Stack Spruce, count '
          'cordwood, move on.',
    ],
  );
}

// ===========================================================================
// SECTION 3 --- PROPERTY ANATOMY TABLE
// ===========================================================================

Widget _section3PropertyAnatomy() {
  return _container(
    title: 'Properties of ListBody',
    subtitle: 'Three knobs, no surprises.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _propRow(
          name: 'mainAxis',
          type: 'Axis',
          required: false,
          defaultValue: 'Axis.vertical',
          summary: 'Direction along which children are laid out. '
              'Axis.vertical stacks top-to-bottom; Axis.horizontal '
              'stacks left-to-right (or right-to-left under RTL).',
        ),
        _propRow(
          name: 'reverse',
          type: 'bool',
          required: false,
          defaultValue: 'false',
          summary: 'When true, children paint from end-to-start of the '
              'main axis. The first child in the list lands at the far '
              'end, the last at the near end.',
        ),
        _propRow(
          name: 'children',
          type: 'List<Widget>',
          required: false,
          defaultValue: 'const <Widget>[]',
          summary: 'The widgets to lay out, in declaration order. There '
              'is no automatic separator between them. Each child gets '
              'the cross-axis extent stretched, and its intrinsic main-'
              'axis extent honored.',
        ),
        _propRow(
          name: 'key',
          type: 'Key?',
          required: false,
          defaultValue: 'null',
          summary: 'Standard Widget key. Useful when ListBody appears '
              'inside a list of siblings whose identity matters across '
              'rebuilds.',
        ),
      ],
    ),
  );
}

Widget _propRow({
  required String name,
  required String type,
  required bool required,
  required String defaultValue,
  required String summary,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spruceChar.withValues(alpha: 0.06),
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
                color: spruceNeedle,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: spruceSap,
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
                color: spruceFern.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: spruceNeedle,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            if (required)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: spruceVest,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'required',
                  style: TextStyle(
                    color: spruceSnow,
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
                  color: spruceFog,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'default: $defaultValue',
                  style: TextStyle(
                    color: spruceSlate,
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
            color: spruceChar,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 --- VERTICAL ListBody CATALOGUE
// ===========================================================================
//
// Five distinct vertical ListBody compositions. Each is wrapped in a card
// with a header, a caption, and an explicit SizedBox to give the surrounding
// SingleChildScrollView something to lay the rick against. Inside each card
// we drop a fresh ListBody so the bridge actually sees the constructor used
// in five separate forms.
//
//   4.1  Bare rounds      --- five plain Containers, no decoration.
//   4.2  Banded rounds    --- alternating bark/cambium colors.
//   4.3  Snow-capped rick --- white-topped rounds with bark sides.
//   4.4  Tagged rick      --- each round wears a paper tag (Row inside).
//   4.5  Foreman's rick   --- vest-colored separators every other round.
//
// We also gather the children of each ListBody via indexed loops so we
// touch the BridgedInstance via index access, never via for-in.
// ===========================================================================

Widget _section4VerticalCatalogue() {
  return _container(
    title: 'Vertical ListBody catalogue',
    subtitle: 'Five spruce ricks, each a different stacking style.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _verticalRickBare(),
        const SizedBox(height: 16.0),
        _verticalRickBanded(),
        const SizedBox(height: 16.0),
        _verticalRickSnowCapped(),
        const SizedBox(height: 16.0),
        _verticalRickTagged(),
        const SizedBox(height: 16.0),
        _verticalRickForeman(),
      ],
    ),
  );
}

Widget _verticalRickBare() {
  // Build five plain rounds. Index loop, so no for-in over BridgedInstance.
  final List<Widget> rounds = <Widget>[];
  for (int i = 0; i < 5; i++) {
    rounds.add(Container(
      height: 38.0,
      color: i.isEven ? spruceMoss : spruceLichen,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        'round ${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.vertical,
    reverse: false,
    children: rounds,
  );

  return _rickCard(
    title: '4.1 Bare rounds',
    caption: 'mainAxis: Axis.vertical, reverse: false. '
        'Five plain Containers, alternating moss/lichen.',
    height: 200.0,
    body: body,
  );
}

Widget _verticalRickBanded() {
  final List<Widget> rounds = <Widget>[];
  const List<Color> bands = <Color>[
    spruceBark,
    spruceCambium,
    spruceBark,
    spruceCambium,
    spruceBark,
    spruceCambium,
  ];
  for (int i = 0; i < bands.length; i++) {
    rounds.add(Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: bands[i],
        border: Border(
          bottom: BorderSide(
            color: spruceChar.withValues(alpha: 0.45),
            width: 1.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'band ${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    ));
  }

  final ListBody body = ListBody(children: rounds);

  return _rickCard(
    title: '4.2 Banded rounds',
    caption: 'Default mainAxis (vertical). Alternating bark/cambium '
        'with a hairline char divider on each round.',
    height: 220.0,
    body: body,
  );
}

Widget _verticalRickSnowCapped() {
  final List<Widget> rounds = <Widget>[];
  for (int i = 0; i < 4; i++) {
    rounds.add(Container(
      height: 44.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            spruceSnow,
            spruceFog,
            spruceBark,
            spruceBark,
          ],
          stops: const <double>[0.0, 0.18, 0.32, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 12.0, top: 6.0),
      alignment: Alignment.topLeft,
      child: Text(
        'snow-capped round ${i + 1}',
        style: TextStyle(
          color: spruceChar,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    ));
  }

  final ListBody body = ListBody(children: rounds);

  return _rickCard(
    title: '4.3 Snow-capped rick',
    caption: 'Each round shows a snow cap fading into bark. ListBody '
        'lays them top-to-bottom; the cross axis fills the card width.',
    height: 220.0,
    body: body,
  );
}

Widget _verticalRickTagged() {
  final List<Widget> rounds = <Widget>[];
  const List<String> grades = <String>[
    'A1 dry',
    'B2 green',
    'A2 dry',
    'C1 cull',
    'A1 dry',
  ];
  for (int i = 0; i < grades.length; i++) {
    rounds.add(Container(
      height: 38.0,
      decoration: BoxDecoration(
        color: spruceDuff,
        border: Border(
          bottom: BorderSide(
            color: spruceChar.withValues(alpha: 0.4),
            width: 0.8,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 22.0,
            height: 22.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: spruceSap,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Text(
              '${i + 1}',
              style: TextStyle(
                color: spruceChar,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            'round',
            style: TextStyle(
              color: spruceSnow,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: spruceSnow,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              grades[i],
              style: TextStyle(
                color: spruceChar,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 10.5,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  final ListBody body = ListBody(children: rounds);

  return _rickCard(
    title: '4.4 Tagged rick',
    caption: 'Each child is itself a Row with an index, a label, and a '
        'paper grade tag. ListBody just stacks the Rows vertically.',
    height: 240.0,
    body: body,
  );
}

Widget _verticalRickForeman() {
  // Foreman's rick: vest-colored separators. We interleave them.
  final List<Widget> rounds = <Widget>[];
  for (int i = 0; i < 4; i++) {
    rounds.add(Container(
      height: 36.0,
      color: spruceHeartwood,
      alignment: Alignment.center,
      child: Text(
        'heartwood round ${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    ));
    if (i < 3) {
      rounds.add(Container(
        height: 4.0,
        color: spruceVest,
      ));
    }
  }

  final ListBody body = ListBody(children: rounds);

  return _rickCard(
    title: '4.5 Foreman\'s rick',
    caption: 'Heartwood rounds separated by vest-orange spacer Containers. '
        'ListBody has no spacing knob, so we interleave separators by hand.',
    height: 220.0,
    body: body,
  );
}

Widget _rickCard({
  required String title,
  required String caption,
  required double height,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spruceChar.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: spruceNeedle,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          caption,
          style: TextStyle(
            color: spruceSlate,
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        // ListBody requires unbounded main-axis room. We grant it a fixed
        // height with a SingleChildScrollView, the simplest legal slot.
        SizedBox(
          height: height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 --- HORIZONTAL ListBody CATALOGUE
// ===========================================================================
//
// Three horizontal ListBody compositions. The cross axis is now vertical,
// so each child must declare its own width and ListBody stretches it to
// the full card height.
//
//   5.1  Cordwood row          --- six rounds laid left-to-right.
//   5.2  Two-tone log fence    --- bark/cambium alternation as a fence.
//   5.3  Numbered sample line  --- numbered cells, like a measuring tape.
//
// ===========================================================================

Widget _section5HorizontalCatalogue() {
  return _container(
    title: 'Horizontal ListBody catalogue',
    subtitle: 'Three horizontal ricks, each on its own measuring line.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _horizontalCordwood(),
        const SizedBox(height: 16.0),
        _horizontalLogFence(),
        const SizedBox(height: 16.0),
        _horizontalSampleLine(),
      ],
    ),
  );
}

Widget _horizontalCordwood() {
  final List<Widget> rounds = <Widget>[];
  const List<Color> shades = <Color>[
    spruceBark,
    spruceHeartwood,
    spruceCambium,
    spruceHeartwood,
    spruceBark,
    spruceCambium,
  ];
  for (int i = 0; i < shades.length; i++) {
    rounds.add(Container(
      width: 56.0,
      decoration: BoxDecoration(
        color: shades[i],
        border: Border(
          right: BorderSide(
            color: spruceChar.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'r${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w800,
          fontSize: 12.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.horizontal,
    children: rounds,
  );

  return _horizontalCard(
    title: '5.1 Cordwood row',
    caption: 'mainAxis: Axis.horizontal. Six fixed-width rounds laid '
        'left-to-right. The cross axis (vertical) is stretched.',
    height: 80.0,
    body: body,
  );
}

Widget _horizontalLogFence() {
  final List<Widget> posts = <Widget>[];
  for (int i = 0; i < 10; i++) {
    posts.add(Container(
      width: i.isEven ? 14.0 : 30.0,
      decoration: BoxDecoration(
        color: i.isEven ? spruceBark : spruceCambium,
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.horizontal,
    children: posts,
  );

  return _horizontalCard(
    title: '5.2 Two-tone log fence',
    caption: 'Alternating thin bark posts and wide cambium rails. The '
        'cross axis stretches each one to full card height.',
    height: 60.0,
    body: body,
  );
}

Widget _horizontalSampleLine() {
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < 12; i++) {
    cells.add(Container(
      width: 40.0,
      decoration: BoxDecoration(
        color: i % 3 == 0 ? spruceVest : spruceFog,
        border: Border(
          right: BorderSide(
            color: spruceChar.withValues(alpha: 0.4),
            width: 0.8,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '${i + 1}',
        style: TextStyle(
          color: i % 3 == 0 ? spruceSnow : spruceChar,
          fontWeight: FontWeight.w800,
          fontSize: 12.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.horizontal,
    children: cells,
  );

  return _horizontalCard(
    title: '5.3 Numbered sample line',
    caption: 'Twelve numbered cells with a vest-orange call-out every '
        'third one. Looks like a forester\'s measuring tape.',
    height: 70.0,
    body: body,
  );
}

Widget _horizontalCard({
  required String title,
  required String caption,
  required double height,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: spruceNeedle,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          caption,
          style: TextStyle(
            color: spruceSlate,
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: height,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 --- reverse:true VARIANTS
// ===========================================================================
//
// Two sub-cards: one vertical with reverse:true, one horizontal with
// reverse:true. We pair each with its reverse:false counterpart in a
// side-by-side layout so the difference is concrete.
// ===========================================================================

Widget _section6ReverseVariants() {
  return _container(
    title: 'reverse:true variants',
    subtitle: 'reverse flips the lay-out direction along the main axis.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _reverseVerticalCard(reverse: false),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _reverseVerticalCard(reverse: true),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _reverseHorizontalPair(),
      ],
    ),
  );
}

Widget _reverseVerticalCard({required bool reverse}) {
  final List<Widget> rounds = <Widget>[];
  const List<String> labels = <String>['ALPHA', 'BRAVO', 'CHARLIE', 'DELTA'];
  const List<Color> tones = <Color>[
    spruceMoss,
    spruceBough,
    spruceLichen,
    spruceFern,
  ];
  for (int i = 0; i < labels.length; i++) {
    rounds.add(Container(
      height: 36.0,
      color: tones[i],
      alignment: Alignment.center,
      child: Text(
        '${i + 1}. ${labels[i]}',
        style: TextStyle(
          color: i < 2 ? spruceSnow : spruceChar,
          fontWeight: FontWeight.w800,
          fontSize: 12.0,
          letterSpacing: 0.5,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.vertical,
    reverse: reverse,
    children: rounds,
  );

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: reverse ? spruceVest.withValues(alpha: 0.10) : spruceFog,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: reverse ? spruceVest : spruceBark.withValues(alpha: 0.3),
        width: reverse ? 1.5 : 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'vertical, reverse: $reverse',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 160.0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          reverse
              ? 'ALPHA painted at the BOTTOM (last visually).'
              : 'ALPHA painted at the TOP (first visually).',
          style: TextStyle(
            color: spruceSlate,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _reverseHorizontalPair() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: _reverseHorizontalCard(reverse: false)),
      const SizedBox(width: 14.0),
      Expanded(child: _reverseHorizontalCard(reverse: true)),
    ],
  );
}

Widget _reverseHorizontalCard({required bool reverse}) {
  final List<Widget> cells = <Widget>[];
  const List<String> letters = <String>['A', 'B', 'C', 'D', 'E'];
  for (int i = 0; i < letters.length; i++) {
    cells.add(Container(
      width: 44.0,
      color: i.isEven ? spruceBark : spruceCambium,
      alignment: Alignment.center,
      child: Text(
        letters[i],
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w800,
          fontSize: 14.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.horizontal,
    reverse: reverse,
    children: cells,
  );

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: reverse ? spruceVest.withValues(alpha: 0.10) : spruceFog,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: reverse ? spruceVest : spruceBark.withValues(alpha: 0.3),
        width: reverse ? 1.5 : 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'horizontal, reverse: $reverse',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 60.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          reverse
              ? 'A painted at the FAR END.'
              : 'A painted at the NEAR END.',
          style: TextStyle(
            color: spruceSlate,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 --- COMPARISON GRID: ListBody vs Column vs ListView vs Wrap
// ===========================================================================
//
// Four cells side by side, each given the same data set (six bucked rounds)
// but rendered with a different layout primitive. The point is to make the
// behavioral differences visible: ListBody stretches and stacks, Column
// stretches and stacks but flexes if asked, ListView scrolls and lazies,
// Wrap line-breaks. We render each cell with a header explaining what its
// primitive does that the others do not.
// ===========================================================================

Widget _section7ComparisonGrid() {
  return _container(
    title: 'Comparison grid',
    subtitle: 'Same six rounds, four different layout primitives.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _compareListBody()),
            const SizedBox(width: 12.0),
            Expanded(child: _compareColumn()),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _compareListView()),
            const SizedBox(width: 12.0),
            Expanded(child: _compareWrap()),
          ],
        ),
        const SizedBox(height: 14.0),
        _comparisonNotes(),
      ],
    ),
  );
}

List<Widget> _comparisonRounds() {
  final List<Widget> rounds = <Widget>[];
  const List<Color> tones = <Color>[
    spruceBark,
    spruceCambium,
    spruceHeartwood,
    spruceCambium,
    spruceBark,
    spruceHeartwood,
  ];
  for (int i = 0; i < tones.length; i++) {
    rounds.add(Container(
      height: 28.0,
      color: tones[i],
      alignment: Alignment.center,
      child: Text(
        'r${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w800,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }
  return rounds;
}

Widget _compareListBody() {
  final ListBody body = ListBody(children: _comparisonRounds());
  return _comparisonCard(
    title: 'ListBody',
    note: 'Stacks, stretches, no flex.',
    accent: spruceMoss,
    body: SizedBox(
      height: 200.0,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: body,
      ),
    ),
  );
}

Widget _compareColumn() {
  final List<Widget> rounds = _comparisonRounds();
  // Wrap each in CrossAxisAlignment.stretch via the parent Column.
  return _comparisonCard(
    title: 'Column',
    note: 'Stacks, stretches optional, flex/Expanded supported.',
    accent: spruceBough,
    body: SizedBox(
      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rounds,
      ),
    ),
  );
}

Widget _compareListView() {
  final List<Widget> rounds = _comparisonRounds();
  return _comparisonCard(
    title: 'ListView',
    note: 'Scrolls. Lazy-builds. Owns its own physics.',
    accent: spruceLichen,
    body: SizedBox(
      height: 200.0,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: rounds,
      ),
    ),
  );
}

Widget _compareWrap() {
  // Wrap needs items with non-zero width since cross-axis is not stretched.
  final List<Widget> chips = <Widget>[];
  const List<Color> tones = <Color>[
    spruceBark,
    spruceCambium,
    spruceHeartwood,
    spruceCambium,
    spruceBark,
    spruceHeartwood,
  ];
  for (int i = 0; i < tones.length; i++) {
    chips.add(Container(
      width: 60.0,
      height: 28.0,
      color: tones[i],
      alignment: Alignment.center,
      child: Text(
        'r${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w800,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }
  return _comparisonCard(
    title: 'Wrap',
    note: 'Breaks to a new run when it overflows the cross axis.',
    accent: spruceFern,
    body: SizedBox(
      height: 200.0,
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: chips,
      ),
    ),
  );
}

Widget _comparisonCard({
  required String title,
  required String note,
  required Color accent,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.w800,
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          note,
          style: TextStyle(
            color: spruceSlate,
            fontSize: 11.5,
            height: 1.4,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10.0),
        body,
      ],
    ),
  );
}

Widget _comparisonNotes() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceFog,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Reading the grid',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'ListBody and Column produce visually identical output for this '
          'data set — both stack the rounds top-to-bottom and stretch them '
          'to the available width. The difference is contractual: Column '
          'reserves the right to honor flex children, and is willing to '
          'lay out under bounded constraints; ListBody refuses both. '
          'ListView introduces scrolling and lazy build; Wrap breaks lines.',
          style: TextStyle(
            color: spruceChar,
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 --- NESTED ListBody-IN-CONTAINER WITH EXPLICIT CONSTRAINTS
// ===========================================================================
//
// Three sub-cards, each demonstrating a way to give ListBody a legal slot
// that is NOT a SingleChildScrollView. We explicitly hand it a finite
// height through different mechanisms, with prose explaining why each one
// works.
//
//   8.1  Container + IntrinsicHeight
//   8.2  ConstrainedBox with maxHeight + SingleChildScrollView fallback
//   8.3  Nested ListBody inside an outer ListBody (composition)
// ===========================================================================

Widget _section8NestedConstrained() {
  return _container(
    title: 'Nested ListBody in constrained slots',
    subtitle: 'Three legal homes for a ListBody that is not a scroll view.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _nestedIntrinsicHeight(),
        const SizedBox(height: 14.0),
        _nestedConstrainedBox(),
        const SizedBox(height: 14.0),
        _nestedListBodyInListBody(),
      ],
    ),
  );
}

Widget _nestedIntrinsicHeight() {
  final List<Widget> rounds = <Widget>[];
  for (int i = 0; i < 4; i++) {
    rounds.add(Container(
      height: 32.0,
      color: i.isEven ? spruceMoss : spruceBough,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        'intrinsic-row ${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w700,
          fontSize: 11.5,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(children: rounds);

  return _nestCard(
    title: '8.1 IntrinsicHeight slot',
    caption: 'IntrinsicHeight measures the natural height of its child '
        'and constrains itself to that height. Inside it we wrap the '
        'ListBody in a SingleChildScrollView so the bridge sees both the '
        'outer slot type and the inner ListBody behavior.',
    child: Container(
      decoration: BoxDecoration(
        color: spruceFog,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
      ),
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: body,
        ),
      ),
    ),
  );
}

Widget _nestedConstrainedBox() {
  final List<Widget> rounds = <Widget>[];
  for (int i = 0; i < 6; i++) {
    rounds.add(Container(
      height: 30.0,
      color: i.isEven ? spruceCambium : spruceHeartwood,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        'constrained-row ${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w700,
          fontSize: 11.5,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(children: rounds);

  return _nestCard(
    title: '8.2 ConstrainedBox slot',
    caption: 'A ConstrainedBox with maxHeight gives ListBody an upper '
        'bound. We still need a SingleChildScrollView to legalize the '
        'unbounded main-axis contract; the ConstrainedBox simply caps '
        'the visible viewport.',
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 140.0),
      child: Container(
        decoration: BoxDecoration(
          color: spruceFog,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: body,
        ),
      ),
    ),
  );
}

Widget _nestedListBodyInListBody() {
  // Outer ListBody contains two children, each of which is itself a
  // ListBody. We render them as a single rick of sub-ricks.
  final List<Widget> innerA = <Widget>[];
  for (int i = 0; i < 3; i++) {
    innerA.add(Container(
      height: 26.0,
      color: spruceBough,
      alignment: Alignment.center,
      child: Text(
        'A.${i + 1}',
        style: TextStyle(
          color: spruceSap,
          fontWeight: FontWeight.w800,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }
  final List<Widget> innerB = <Widget>[];
  for (int i = 0; i < 3; i++) {
    innerB.add(Container(
      height: 26.0,
      color: spruceHeartwood,
      alignment: Alignment.center,
      child: Text(
        'B.${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w800,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody outer = ListBody(
    mainAxis: Axis.vertical,
    children: <Widget>[
      _innerLabel('inner ListBody A'),
      ListBody(children: innerA),
      _innerLabel('inner ListBody B'),
      ListBody(children: innerB),
    ],
  );

  return _nestCard(
    title: '8.3 ListBody inside ListBody',
    caption: 'The outer ListBody hosts two inner ListBodies plus their '
        'labels. Composition is fine: the bridge sees three ListBody '
        'instances inside the same SingleChildScrollView.',
    child: Container(
      decoration: BoxDecoration(
        color: spruceFog,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: outer,
      ),
    ),
  );
}

Widget _innerLabel(String text) {
  return Container(
    height: 22.0,
    color: spruceSlate,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Text(
      text,
      style: TextStyle(
        color: spruceSap,
        fontWeight: FontWeight.w800,
        fontSize: 10.5,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _nestCard({
  required String title,
  required String caption,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          caption,
          style: TextStyle(
            color: spruceSlate,
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10.0),
        child,
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 --- SCROLLING INTEGRATION (no ScrollController)
// ===========================================================================
//
// The classic legal home for a ListBody. We wrap two ListBody instances
// (one vertical, one horizontal) in their own SingleChildScrollViews
// without supplying a ScrollController — per the rules, no controllers in
// a D4rt snapshot demo. A short prose tile sits between them explaining
// why this is the canonical pattern.
// ===========================================================================

Widget _section9ScrollingIntegration() {
  return _container(
    title: 'Scrolling integration via SingleChildScrollView',
    subtitle: 'The canonical legal home for a ListBody (no ScrollController).',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _scrollVerticalCard(),
        const SizedBox(height: 14.0),
        _scrollProseTile(),
        const SizedBox(height: 14.0),
        _scrollHorizontalCard(),
      ],
    ),
  );
}

Widget _scrollVerticalCard() {
  final List<Widget> rounds = <Widget>[];
  for (int i = 0; i < 14; i++) {
    rounds.add(Container(
      height: 32.0,
      decoration: BoxDecoration(
        color: i.isEven ? spruceBark : spruceHeartwood,
        border: Border(
          bottom: BorderSide(
            color: spruceChar.withValues(alpha: 0.4),
            width: 0.6,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Text(
        'rick-row ${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w700,
          fontSize: 11.5,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(children: rounds);

  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spruceMoss, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '9.1 Vertical scroll wrap',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'A 14-round rick wrapped in a SingleChildScrollView. The scroll '
          'view supplies the unbounded vertical constraint that the '
          'ListBody requires; no controller is needed.',
          style: TextStyle(
            color: spruceSlate,
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: spruceFog,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
      ],
    ),
  );
}

Widget _scrollHorizontalCard() {
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < 24; i++) {
    cells.add(Container(
      width: 50.0,
      decoration: BoxDecoration(
        color: i % 4 == 0 ? spruceVest : spruceCambium,
        border: Border(
          right: BorderSide(
            color: spruceChar.withValues(alpha: 0.4),
            width: 0.8,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '${i + 1}',
        style: TextStyle(
          color: spruceSnow,
          fontWeight: FontWeight.w800,
          fontSize: 12.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.horizontal,
    children: cells,
  );

  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spruceVest, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '9.2 Horizontal scroll wrap',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'A 24-cell horizontal sample line wrapped in a horizontal '
          'SingleChildScrollView. ListBody.mainAxis must agree with the '
          'scroll view\'s scrollDirection.',
          style: TextStyle(
            color: spruceSlate,
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: spruceFog,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
      ],
    ),
  );
}

Widget _scrollProseTile() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: spruceFog,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Why pair ListBody with SingleChildScrollView?',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'The scroll view introduces a viewport that supplies an '
          'unbounded constraint to its child along its scroll axis. '
          'ListBody asks for exactly that — unbounded room to grow. '
          'The child of a SingleChildScrollView lays out at its '
          'intrinsic size, and that is precisely what ListBody '
          'computes from its children. No controller is strictly '
          'required: if you do not need to programmatically scroll, '
          'observe scroll position, or persist offsets, you can omit '
          'the ScrollController entirely.',
          style: TextStyle(
            color: spruceChar,
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 --- RING-TILE CATALOGUES
// ===========================================================================
//
// Themed sample-ring tiles. Each tile is a Container with concentric
// border layers (heartwood, cambium, bark) sitting on top of a small
// data label. We assemble them with two more ListBody instances: one
// vertical rick of large tiles, one horizontal rick of small tiles.
// ===========================================================================

Widget _section10RingTiles() {
  return _container(
    title: 'Stack Spruce sample-ring tiles',
    subtitle: 'Concentric tiles that stand in for tree-ring samples.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _ringTilesVertical(),
        const SizedBox(height: 16.0),
        _ringTilesHorizontal(),
      ],
    ),
  );
}

Widget _ringTilesVertical() {
  final List<Widget> tiles = <Widget>[];
  const List<String> ages = <String>[
    'age 24',
    'age 38',
    'age 56',
    'age 71',
    'age 88',
  ];
  for (int i = 0; i < ages.length; i++) {
    tiles.add(_ringTile(label: ages[i], rings: i + 3, big: true));
    tiles.add(const SizedBox(height: 8.0));
  }

  final ListBody body = ListBody(children: tiles);

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: spruceFog,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '10.1 Vertical ring rick',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 380.0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
      ],
    ),
  );
}

Widget _ringTilesHorizontal() {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < 8; i++) {
    tiles.add(_ringTile(label: 's${i + 1}', rings: 3 + (i % 4), big: false));
    tiles.add(const SizedBox(width: 8.0));
  }

  final ListBody body = ListBody(
    mainAxis: Axis.horizontal,
    children: tiles,
  );

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: spruceFog,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '10.2 Horizontal ring line',
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 110.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: body,
          ),
        ),
      ],
    ),
  );
}

Widget _ringTile({required String label, required int rings, required bool big}) {
  // Build concentric Containers via nested wrapping. We start from the
  // innermost and accumulate outward.
  final double innerSize = big ? 40.0 : 24.0;
  final double step = big ? 8.0 : 5.0;
  Widget core = Container(
    width: innerSize,
    height: innerSize,
    decoration: BoxDecoration(
      color: spruceSap,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
      '$rings',
      style: TextStyle(
        color: spruceChar,
        fontWeight: FontWeight.w900,
        fontSize: big ? 14.0 : 10.0,
        fontFamily: 'monospace',
      ),
    ),
  );
  for (int i = 0; i < rings; i++) {
    final Color ringColor = i.isEven ? spruceCambium : spruceBark;
    core = Container(
      padding: EdgeInsets.all(step / 2),
      decoration: BoxDecoration(
        color: ringColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: spruceChar.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: core,
    );
  }

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #119, P12):
  // The small-tile (big=false) path is rendered inside the horizontal
  // `ListBody(mainAxis: Axis.horizontal)` of `_ringTilesHorizontal`,
  // which sits inside a `SingleChildScrollView(scrollDirection: Axis.
  // horizontal)`. That SCV grants its child unbounded width on the main
  // axis. With `width: null` the tile Container also goes unbounded, so
  // the inner `Row > Expanded(...)` asserts "RenderFlex children have
  // non-zero flex but incoming width constraints are unbounded." Give
  // the small tile an explicit finite width so the Row receives a
  // bounded constraint. The big-tile (vertical-axis) path stays at
  // `double.infinity` — its parent vertical ListBody bounds the
  // cross-axis width to the container width.
  return Container(
    height: big ? 64.0 : 88.0,
    width: big ? double.infinity : 140.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: <Widget>[
        core,
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: spruceNeedle,
                  fontWeight: FontWeight.w800,
                  fontSize: big ? 13.0 : 11.0,
                  fontFamily: 'monospace',
                ),
              ),
              if (big) ...<Widget>[
                const SizedBox(height: 2.0),
                Text(
                  '$rings rings counted',
                  style: TextStyle(
                    color: spruceSlate,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 --- DO / AVOID CALLOUTS
// ===========================================================================

Widget _section11DoAvoid() {
  return _container(
    title: 'DO and AVOID',
    subtitle: 'Field-tested rules for working with ListBody.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _doRow('DO place ListBody inside a slot that supplies unbounded '
            'main-axis constraints — most commonly a SingleChildScrollView '
            'or a CustomScrollView slot.'),
        _doRow('DO match ListBody.mainAxis to the surrounding scroll '
            'view\'s scrollDirection. A horizontal ListBody inside a '
            'vertical scroll view will throw at layout.'),
        _doRow('DO use the reverse flag rather than pre-reversing your '
            'children list. The flag interacts correctly with hit-testing '
            'and directional embedding; a manual reverse does not.'),
        _doRow('DO interleave SizedBox separators when you need spacing '
            'between rounds. ListBody itself has no spacing knob.'),
        _doRow('DO prefer ListBody over Column when you positively want '
            'no flex bookkeeping and you are inside a scroll body — it '
            'is the lighter-weight primitive.'),
        _avoidRow('AVOID putting a ListBody inside a Column without a '
            'SizedBox or scrollable wrapper. The bounded vertical '
            'constraint will crash the layout.'),
        _avoidRow('AVOID expecting Spacer or Expanded to do anything '
            'inside a ListBody. They are flex widgets; ListBody is not '
            'a Flex. They will throw.'),
        _avoidRow('AVOID using ListBody when you actually need a long, '
            'lazily-built list. ListBody builds every child up front; '
            'ListView builds on demand.'),
        _avoidRow('AVOID using ListBody when you actually need '
            'cross-axis alignment options. ListBody always stretches '
            'each child to the full cross-axis extent.'),
      ],
    ),
  );
}

Widget _doRow(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: spruceMoss.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: spruceMoss, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.check_circle, color: spruceMoss, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: spruceChar,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _avoidRow(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: spruceVest.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: spruceVest, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.do_not_disturb_on, color: spruceVest, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: spruceChar,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 --- CODE-RECIPE CARDS
// ===========================================================================

Widget _section12CodeRecipes() {
  return _container(
    title: 'Code recipes',
    subtitle: 'Five concrete patterns you will use repeatedly.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _recipe(
          n: '1',
          title: 'ListBody inside SingleChildScrollView',
          code: "SingleChildScrollView(\n"
              "  child: ListBody(\n"
              "    children: <Widget>[\n"
              "      Container(height: 40, color: Colors.blue),\n"
              "      Container(height: 40, color: Colors.green),\n"
              "      Container(height: 40, color: Colors.red),\n"
              "    ],\n"
              "  ),\n"
              ")",
        ),
        _recipe(
          n: '2',
          title: 'Horizontal ListBody inside horizontal scroll',
          code: "SingleChildScrollView(\n"
              "  scrollDirection: Axis.horizontal,\n"
              "  child: ListBody(\n"
              "    mainAxis: Axis.horizontal,\n"
              "    children: <Widget>[\n"
              "      Container(width: 60, color: Colors.amber),\n"
              "      Container(width: 60, color: Colors.brown),\n"
              "    ],\n"
              "  ),\n"
              ")",
        ),
        _recipe(
          n: '3',
          title: 'Reverse-stack from the bottom',
          code: "ListBody(\n"
              "  reverse: true,\n"
              "  children: <Widget>[\n"
              "    Text('first child paints at bottom'),\n"
              "    Text('then this'),\n"
              "    Text('last child paints at top'),\n"
              "  ],\n"
              ")",
        ),
        _recipe(
          n: '4',
          title: 'Interleaved separators',
          code: "ListBody(\n"
              "  children: <Widget>[\n"
              "    Round(label: 'A'),\n"
              "    SizedBox(height: 4),\n"
              "    Round(label: 'B'),\n"
              "    SizedBox(height: 4),\n"
              "    Round(label: 'C'),\n"
              "  ],\n"
              ")",
        ),
        _recipe(
          n: '5',
          title: 'ListBody as the body of a SliverToBoxAdapter',
          code: "CustomScrollView(\n"
              "  slivers: <Widget>[\n"
              "    SliverToBoxAdapter(\n"
              "      child: ListBody(\n"
              "        children: <Widget>[\n"
              "          Header(),\n"
              "          Body(),\n"
              "          Footer(),\n"
              "        ],\n"
              "      ),\n"
              "    ),\n"
              "  ],\n"
              ")",
        ),
      ],
    ),
  );
}

Widget _recipe({required String n, required String title, required String code}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: spruceNeedle,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: spruceSap,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Text(
                  n,
                  style: TextStyle(
                    color: spruceChar,
                    fontWeight: FontWeight.w900,
                    fontSize: 13.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: spruceSnow,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: spruceChar,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: spruceFern,
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 13 --- GLOSSARY
// ===========================================================================

Widget _section13Glossary() {
  final List<List<String>> terms = <List<String>>[
    <String>[
      'ListBody',
      'A flex-less linear layout widget. Lays children one after another '
          'along the main axis at intrinsic size, stretched to fill the '
          'cross axis.',
    ],
    <String>[
      'mainAxis',
      'The Axis along which ListBody arranges its children. Default is '
          'Axis.vertical; Axis.horizontal is also supported.',
    ],
    <String>[
      'reverse',
      'When true, children are laid out from the end of the main axis '
          'back toward the start. The first child paints at the far end.',
    ],
    <String>[
      'children',
      'The list of widgets ListBody will lay out. There is no built-in '
          'separator; gaps must be inserted as explicit widgets.',
    ],
    <String>[
      'unbounded constraint',
      'A BoxConstraints whose maxHeight (or maxWidth) is double.infinity. '
          'ListBody requires this along its main axis.',
    ],
    <String>[
      'intrinsic size',
      'The natural size a widget would assume given infinite room. ListBody '
          'sizes each child to its intrinsic size along the main axis.',
    ],
    <String>[
      'SingleChildScrollView',
      'The most common parent for a ListBody. Supplies an unbounded '
          'main-axis constraint by introducing a scrollable viewport.',
    ],
    <String>[
      'SliverToBoxAdapter',
      'A sliver that exposes a single RenderBox child to a CustomScrollView. '
          'A common alternate home for ListBody inside slivers.',
    ],
    <String>[
      'shrinkWrap',
      'A ListView property that, when true, makes the list size to its '
          'children. Internally it lays out via a body similar to ListBody.',
    ],
    <String>[
      'Column',
      'A Flex widget with vertical mainAxis. Like ListBody, stacks children, '
          'but supports flex/Expanded/Spacer and crossAxisAlignment options.',
    ],
    <String>[
      'Row',
      'A Flex widget with horizontal mainAxis. Horizontal counterpart to '
          'Column. Same flex/alignment relationship to a horizontal ListBody.',
    ],
    <String>[
      'Wrap',
      'A widget that lays children in runs and breaks to a new run when '
          'the cross axis is exhausted. ListBody never breaks lines.',
    ],
    <String>[
      'ListView',
      'A scrollable, lazy-built list. Use it instead of ListBody when the '
          'list is long enough that lazy build matters or you want owned '
          'scroll physics.',
    ],
    <String>[
      'IntrinsicHeight',
      'Forces its child to the natural height of its content. A legal '
          'home for a ListBody when paired with an inner scroll view.',
    ],
    <String>[
      'ConstrainedBox',
      'Caps the maximum size of its child. Useful to limit a ListBody '
          'rick to a particular viewport height.',
    ],
    <String>[
      'TextDirection',
      'When mainAxis is horizontal and reverse interacts with the ambient '
          'TextDirection, ListBody honors directional embedding.',
    ],
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < terms.length; i++) {
    rows.add(_glossaryRow(terms[i][0], terms[i][1]));
  }

  return _container(
    title: 'Glossary',
    subtitle: '${terms.length} terms you will see again and again.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _glossaryRow(String term, String def) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: spruceSnow,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          term,
          style: TextStyle(
            color: spruceNeedle,
            fontWeight: FontWeight.w800,
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          def,
          style: TextStyle(
            color: spruceChar,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 14 --- RECAP FOOTER
// ===========================================================================

Widget _section14RecapFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[spruceSlate, spruceNeedle, spruceChar],
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Recap',
          style: TextStyle(
            color: spruceSap,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'ListBody is the cordwood-stack of Flutter layout. Vertical '
          'or horizontal, forward or reverse, no flex, no wrap, no '
          'scroll of its own. Hand it children, hand its parent an '
          'unbounded main-axis constraint, and it will lay each round '
          'end-to-end at its natural size, stretched across the cross '
          'axis. Reach for it inside scroll bodies, custom slivers, '
          'and other intrinsic-only contexts; reach for Column when '
          'you need flex, ListView when you need scroll, Wrap when '
          'you need line breaks.',
          style: TextStyle(
            color: spruceSnow,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Stack Spruce closes here — needles, bark, sap, vest-orange. '
          'Stack the rounds clean, mark each rick, walk on. The '
          'inventory holds.',
          style: TextStyle(
            color: spruceFern,
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
// SHARED HELPERS --- generic container, prose card
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
      color: spruceFog,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spruceChar.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: spruceNeedle,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: spruceBark,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
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
  children.add(Text(
    title,
    style: TextStyle(
      color: spruceNeedle,
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
    ),
  ));
  children.add(const SizedBox(height: 12.0));
  for (int i = 0; i < paragraphs.length; i++) {
    children.add(Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: spruceSnow,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: spruceLichen.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22.0,
            height: 22.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: spruceNeedle,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              '${i + 1}',
              style: TextStyle(
                color: spruceSap,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              paragraphs[i],
              style: TextStyle(
                color: spruceChar,
                fontSize: 13.0,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: spruceFog,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: spruceBark.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}
