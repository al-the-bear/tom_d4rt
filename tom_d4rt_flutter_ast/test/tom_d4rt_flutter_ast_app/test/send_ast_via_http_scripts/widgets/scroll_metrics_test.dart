// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =============================================================================
//  TIDE ALMANAC --- ScrollMetrics deep dive
// =============================================================================
//
//  TARGET API .......... ScrollMetrics  (mixin/abstract from
//                        package:flutter/widgets.dart, re-exported by
//                        package:flutter/material.dart)
//                        plus the two concrete siblings exercised throughout:
//                          - FixedScrollMetrics
//                          - PageMetrics  (a FixedScrollMetrics subclass)
//
//  CONTEXT .............. ScrollMetrics is the immutable snapshot value that
//                        every Scrollable hands to its physics, scrollbar,
//                        and notification listeners. Whenever someone asks
//                        "where is the scroll position right now?", what
//                        actually flows through the widget tree is a
//                        ScrollMetrics instance: a small bundle of doubles
//                        plus an axis direction. From that bundle the rest of
//                        the scrolling machinery derives:
//
//                            extentBefore   --- pixels - minScrollExtent
//                            extentInside   --- min(pixels + viewportDimension,
//                                                   maxScrollExtent)
//                                              - max(pixels, minScrollExtent)
//                                              clamped >= 0
//                            extentAfter    --- maxScrollExtent
//                                              - min(pixels + viewportDimension,
//                                                    maxScrollExtent)
//                                              clamped >= 0
//                            extentTotal    --- maxScrollExtent - minScrollExtent
//                            atEdge         --- pixels == minScrollExtent ||
//                                              pixels == maxScrollExtent
//                            outOfRange     --- pixels < minScrollExtent ||
//                                              pixels > maxScrollExtent
//                            axis           --- axisOf(axisDirection)
//                            devicePixelRatio
//                                          --- the host MediaQuery's pixel
//                                              ratio at the time the metrics
//                                              were captured.
//
//                        Because metrics are immutable, every change to the
//                        scroll position produces a fresh value. The
//                        ScrollPosition itself implements ScrollMetrics so it
//                        can be passed where one is expected, and a snapshot
//                        copy is made via `copyWith(...)` whenever a frozen
//                        record is needed (notifications, scrollbars, etc.).
//                        FixedScrollMetrics is exactly such a frozen record:
//                        a plain immutable bag of the same fields, with
//                        copyWith for spawning derived bags.
//
//  WHY THE METRICS SHAPE
//
//                        The clever trick of ScrollMetrics is that one tiny
//                        struct serves three audiences:
//
//                          1. Physics  --- needs minScrollExtent /
//                             maxScrollExtent / pixels / viewportDimension
//                             to decide overscroll, friction, ballistics.
//                          2. Scrollbar --- needs extentBefore / extentInside
//                             / extentAfter to size and place the thumb.
//                          3. App code via NotificationListener --- needs
//                             atEdge / outOfRange / axis to react to
//                             milestones.
//
//                        All three views are computed from the same five
//                        underlying numbers. ScrollMetrics is the protocol
//                        that says: "give me those five and the axis
//                        direction; I will derive the rest on demand."
//
//  THEME ................ TIDE ALMANAC --- a coastal almanac of tide heights.
//                        We are sitting in the harbour-master's office at
//                        the end of an evening watch, leafing through the
//                        printed almanac. Each scroll-state is a tide
//                        reading from a different hour: low water, slack,
//                        flood, springs, neap, storm-surge over the wall,
//                        and a backwash that has briefly drained below
//                        chart datum. The cards are drawn as tide-tables;
//                        the prose is in the dry tone of a port note.
//
//                        Palette is tide-blue, sand-beige, seafoam,
//                        driftwood-brown, with a few accents for warning
//                        flags and the storm-glass.
//
//  D4RT CONSTRAINTS
//
//      * build() runs ONCE. Snapshot tree only.
//      * No StatefulWidget, no setState, no controllers, no Timer/Future/
//        Stream.
//      * NO `for-in` over BridgedInstance: every iteration is indexed
//        `for (int i = 0; i < x.length; i++)`.
//      * No `.value` reads on Tween.animate (we do not animate at runtime).
//      * Use `.withValues(alpha: ...)` instead of `.withOpacity(...)`.
//      * Import only `package:flutter/material.dart`.
//      * No emoji anywhere in the file.
//
//  FILE LAYOUT
//
//      Section 1  ... Title banner with palette swatches and almanac strip
//      Section 2  ... Prose anatomy of ScrollMetrics (harbour-master notes)
//      Section 3  ... Property anatomy table (every field + every derived)
//      Section 4  ... Tide ruler legend (how to read the upcoming rulers)
//      Section 5  ... Eight scroll-state samples, each as a ruler + card
//      Section 6  ... copyWith() catalogue --- four derived snapshots
//      Section 7  ... PageMetrics gallery --- three paginated examples
//      Section 8  ... Axis direction matrix (down/up/right/left)
//      Section 9  ... Edge / overscroll callouts (DO / AVOID)
//      Section 10 ... Recipe cards (5 short patterns)
//      Section 11 ... Glossary
//      Section 12 ... Recap footer
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Tide Almanac
// ---------------------------------------------------------------------------
//  Sixteen named colors. Tide-blues dominate; sand and seafoam supply the
//  midtones; driftwood and oil-lamp amber carry the secondary scale.
// ---------------------------------------------------------------------------

const Color tideAbyss = Color(0xFF0B1E2C); // unlit deep
const Color tideMidnight = Color(0xFF14334A); // midnight harbour
const Color tideNavy = Color(0xFF1F4E6E); // chart-paper navy
const Color tideHarbour = Color(0xFF2E6F95); // harbour blue
const Color tideShoal = Color(0xFF4A93B8); // shoal water
const Color tideSeafoam = Color(0xFF8FCFC9); // pale seafoam
const Color tideSpray = Color(0xFFB8E0DA); // breaking spray
const Color tideMist = Color(0xFFD8ECE8); // dawn mist
const Color tideSandWet = Color(0xFFC9B98A); // wet packed sand
const Color tideSandDry = Color(0xFFE8D9A8); // dry beach sand
const Color tideShell = Color(0xFFF1E8CF); // bleached shell
const Color tideDrift = Color(0xFF8A6A48); // driftwood brown
const Color tideRopeTar = Color(0xFF3A2A1E); // tarred rope
const Color tideOilLamp = Color(0xFFD4A24A); // oil-lamp amber
const Color tideWarn = Color(0xFFB05A2C); // warning flag rust
const Color tideStorm = Color(0xFF6E2C2C); // storm-glass crimson

// Flat catalogue of the palette, used in the title banner.
const List<List<Object>> kPalette = <List<Object>>[
  ['abyss', tideAbyss],
  ['midnight', tideMidnight],
  ['navy', tideNavy],
  ['harbour', tideHarbour],
  ['shoal', tideShoal],
  ['seafoam', tideSeafoam],
  ['spray', tideSpray],
  ['mist', tideMist],
  ['sand-wet', tideSandWet],
  ['sand-dry', tideSandDry],
  ['shell', tideShell],
  ['drift', tideDrift],
  ['rope', tideRopeTar],
  ['lamp', tideOilLamp],
  ['warn', tideWarn],
  ['storm', tideStorm],
];

// ---------------------------------------------------------------------------
//  SAMPLE DESCRIPTOR
// ---------------------------------------------------------------------------
//  Each scroll-state we render carries a hand-picked label, a narrative
//  paragraph, an accent color, and the FixedScrollMetrics itself. We bundle
//  them in a small record so that each section helper can be a pure
//  function over a list of samples.
// ---------------------------------------------------------------------------

class _TideSample {
  final String code;
  final String title;
  final String narrative;
  final FixedScrollMetrics metrics;
  final Color accent;
  const _TideSample({
    required this.code,
    required this.title,
    required this.narrative,
    required this.metrics,
    required this.accent,
  });
}

// ---------------------------------------------------------------------------
//  CopyWith descriptor --- used in section 6.
// ---------------------------------------------------------------------------

class _CopyEntry {
  final String label;
  final String description;
  final ScrollMetrics original;
  final ScrollMetrics derived;
  final Color accent;
  const _CopyEntry({
    required this.label,
    required this.description,
    required this.original,
    required this.derived,
    required this.accent,
  });
}

// ---------------------------------------------------------------------------
//  PageMetrics descriptor --- used in section 7.
// ---------------------------------------------------------------------------

class _PageEntry {
  final String label;
  final String description;
  final PageMetrics metrics;
  final Color accent;
  const _PageEntry({
    required this.label,
    required this.description,
    required this.metrics,
    required this.accent,
  });
}

// ---------------------------------------------------------------------------
//  AxisDirection descriptor --- used in section 8.
// ---------------------------------------------------------------------------

class _AxisEntry {
  final AxisDirection direction;
  final String label;
  final String description;
  final FixedScrollMetrics metrics;
  final Color accent;
  const _AxisEntry({
    required this.direction,
    required this.label,
    required this.description,
    required this.metrics,
    required this.accent,
  });
}

// =============================================================================
//  build()
// =============================================================================
//  D4rt invokes this exactly once. We construct every metrics fixture up
//  front, dump them to print() with derived-quantity readouts, and then
//  hand the bag to a Scaffold built out of helper functions.
// =============================================================================

dynamic build(BuildContext context) {
  print('[tide-almanac] ScrollMetrics deep-dive demo starting');
  print('[tide-almanac] Theme: harbour-master almanac, 16-colour tide scale');
  print('[tide-almanac] D4rt mode: snapshot build, no Stateful, no controllers');
  print('[tide-almanac] Target: ScrollMetrics, FixedScrollMetrics, PageMetrics');

  // ---------------------------------------------------------------------------
  //  Eight FixedScrollMetrics samples.
  //
  //  Each sample is a hand-picked snapshot of a typical scroll position. We
  //  use a 600-pixel viewport throughout because the almanac page is a
  //  fixed-width column; only the document length and current pixels vary.
  //  All of these are constructed with axisDirection: AxisDirection.down so
  //  this section keeps to a single axis for legibility; section 8 will
  //  vary the direction.
  // ---------------------------------------------------------------------------

  // Sample S1 --- low tide at the top of a long page. Pixels sit on
  // minScrollExtent; nothing has scrolled away yet. Used to teach the
  // "atEdge with extentBefore == 0" case.
  final FixedScrollMetrics m1 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 0.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S2 --- slack water, mid-page. Pixels at a comfortable midpoint;
  // both extentBefore and extentAfter are non-zero; nothing is at edge.
  final FixedScrollMetrics m2 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 900.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S3 --- flood tide near the bottom. Pixels equal maxScrollExtent;
  // extentAfter == 0; atEdge true.
  final FixedScrollMetrics m3 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 2400.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S4 --- backwash overscroll at the head. Pixels < minScrollExtent
  // by 40 pixels (a refresh-spinner pull). outOfRange true; atEdge false.
  final FixedScrollMetrics m4 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: -40.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S5 --- storm-surge overscroll at the tail. Pixels >
  // maxScrollExtent by 60 pixels (a bouncing-physics fling past the bottom).
  final FixedScrollMetrics m5 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 2460.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S6 --- short list, content shorter than viewport. maxScrollExtent
  // equals minScrollExtent; extentTotal == 0; the content fits, so the
  // scrollable cannot move. atEdge is true at both ends simultaneously.
  final FixedScrollMetrics m6 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 0.0,
    pixels: 0.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S7 --- very long list (10000 px), pixels parked midway through
  // the lower half. Used to teach how extentBefore / extentInside /
  // extentAfter scale with very large totals.
  final FixedScrollMetrics m7 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 10000.0,
    pixels: 6400.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );

  // Sample S8 --- page-paginated. ViewportDimension equals exactly one page
  // width (600); maxScrollExtent equals 4 * 600 = 2400 (5 pages); pixels
  // sits at exactly page index 2 (1200). Sets up section 7's PageMetrics
  // commentary.
  final FixedScrollMetrics m8 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 1200.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.right,
    devicePixelRatio: 3.0,
  );

  final List<_TideSample> samples = <_TideSample>[
    _TideSample(
      code: 'S1',
      title: 'Low water --- head of page',
      narrative:
          'Pixels rest on minScrollExtent. Nothing has scrolled away from '
          'the top, so extentBefore is zero. atEdge reports true; '
          'outOfRange reports false; the scrollbar thumb sits flush with '
          'the leading rail.',
      metrics: m1,
      accent: tideHarbour,
    ),
    _TideSample(
      code: 'S2',
      title: 'Slack water --- mid page',
      narrative:
          'A textbook midpoint reading. Both extentBefore and extentAfter '
          'are positive, atEdge is false, and the visible window covers '
          'pixels[900..1500] of a 0..2400 document.',
      metrics: m2,
      accent: tideShoal,
    ),
    _TideSample(
      code: 'S3',
      title: 'High water --- tail of page',
      narrative:
          'Pixels equal maxScrollExtent. The visible window ends exactly '
          'at 2400; extentAfter is zero; atEdge true. The thumb is '
          'pressed against the trailing rail.',
      metrics: m3,
      accent: tideOilLamp,
    ),
    _TideSample(
      code: 'S4',
      title: 'Backwash --- overscroll at head',
      narrative:
          'A refresh-spinner pull has dragged pixels 40 below '
          'minScrollExtent. extentBefore would be negative, so the getter '
          'clamps it at zero; outOfRange flips true; atEdge is false '
          '(the position is past the edge, not on it).',
      metrics: m4,
      accent: tideWarn,
    ),
    _TideSample(
      code: 'S5',
      title: 'Storm surge --- overscroll at tail',
      narrative:
          'A bouncing fling has carried pixels 60 past maxScrollExtent. '
          'The bottom of the viewport is technically below the document; '
          'extentInside / extentAfter clamp to zero; outOfRange true.',
      metrics: m5,
      accent: tideStorm,
    ),
    _TideSample(
      code: 'S6',
      title: 'Calm pool --- content shorter than viewport',
      narrative:
          'Min and max coincide: there is nothing to scroll. extentTotal '
          'is zero; atEdge is trivially true. Many gestures will return '
          'before consulting this metrics at all, but it remains a valid '
          'reading.',
      metrics: m6,
      accent: tideSeafoam,
    ),
    _TideSample(
      code: 'S7',
      title: 'Long shore --- very long document',
      narrative:
          'Document is 10000 pixels long; pixels sits at 6400. The thumb '
          'position is pixels / extentTotal = 0.64 down its rail; the '
          'thumb size is viewportDimension / extentTotal = 0.06 of the '
          'rail length.',
      metrics: m7,
      accent: tideNavy,
    ),
    _TideSample(
      code: 'S8',
      title: 'Page two --- horizontal pagination',
      narrative:
          'Five horizontal pages of 600 pixels each. Pixels parked at '
          '1200 = page index 2. axisDirection is right, so axis evaluates '
          'to Axis.horizontal; everything else flows from there.',
      metrics: m8,
      accent: tideDrift,
    ),
  ];

  // Dump each sample to print() with full derived-quantity readout. This
  // gives the bridge a hard exercise of every getter on FixedScrollMetrics.
  for (int i = 0; i < samples.length; i++) {
    final _TideSample s = samples[i];
    final FixedScrollMetrics m = s.metrics;
    print('[tide-almanac] sample ${s.code} --- ${s.title}');
    print('  pixels:            ${m.pixels}');
    print('  minScrollExtent:   ${m.minScrollExtent}');
    print('  maxScrollExtent:   ${m.maxScrollExtent}');
    print('  viewportDimension: ${m.viewportDimension}');
    print('  axisDirection:     ${m.axisDirection}');
    print('  axis:              ${m.axis}');
    print('  devicePixelRatio:  ${m.devicePixelRatio}');
    print('  extentBefore:      ${m.extentBefore}');
    print('  extentInside:      ${m.extentInside}');
    print('  extentAfter:       ${m.extentAfter}');
    print('  extentTotal:       ${m.extentTotal}');
    print('  atEdge:            ${m.atEdge}');
    print('  outOfRange:        ${m.outOfRange}');
  }

  // ---------------------------------------------------------------------------
  //  copyWith() catalogue --- four derived snapshots, each based on m2.
  // ---------------------------------------------------------------------------
  final ScrollMetrics c1 = m2.copyWith(pixels: 1500.0);
  final ScrollMetrics c2 = m2.copyWith(viewportDimension: 300.0);
  final ScrollMetrics c3 = m2.copyWith(maxScrollExtent: 4800.0);
  final ScrollMetrics c4 = m2.copyWith(
    minScrollExtent: -120.0,
    pixels: -120.0,
  );
  final List<_CopyEntry> copies = <_CopyEntry>[
    _CopyEntry(
      label: 'shifted pixels',
      description:
          'Same document and viewport as S2, but pixels moved from 900 '
          'to 1500. Useful for synthesising a "what would the metrics '
          'look like 600 pixels lower?" forecast.',
      original: m2,
      derived: c1,
      accent: tideShoal,
    ),
    _CopyEntry(
      label: 'shrunk viewport',
      description:
          'ViewportDimension halved from 600 to 300. The visible window '
          'now covers pixels[900..1200]; extentInside drops; the thumb '
          'becomes longer relative to a smaller rail.',
      original: m2,
      derived: c2,
      accent: tideSeafoam,
    ),
    _CopyEntry(
      label: 'lengthened document',
      description:
          'maxScrollExtent doubled to 4800. Pixels still 900, so '
          'extentBefore unchanged; extentAfter expanded; atEdge becomes '
          'and stays false.',
      original: m2,
      derived: c3,
      accent: tideNavy,
    ),
    _CopyEntry(
      label: 'sliding window',
      description:
          'Both minScrollExtent and pixels shifted to -120. The window '
          'is still aligned at the top edge of the document, but the '
          'document\'s coordinate system has been re-anchored.',
      original: m2,
      derived: c4,
      accent: tideOilLamp,
    ),
  ];
  for (int i = 0; i < copies.length; i++) {
    final _CopyEntry e = copies[i];
    print('[tide-almanac] copyWith --- ${e.label}');
    print('  original.pixels=${e.original.pixels} '
        'derived.pixels=${e.derived.pixels}');
    print('  original.maxScrollExtent=${e.original.maxScrollExtent} '
        'derived.maxScrollExtent=${e.derived.maxScrollExtent}');
    print('  derived.extentBefore=${e.derived.extentBefore} '
        'extentInside=${e.derived.extentInside} '
        'extentAfter=${e.derived.extentAfter} '
        'atEdge=${e.derived.atEdge} '
        'outOfRange=${e.derived.outOfRange}');
  }

  // ---------------------------------------------------------------------------
  //  PageMetrics gallery --- three paginated examples.
  //
  //  PageMetrics adds a single concept on top of FixedScrollMetrics: page.
  //  page == pixels / max(viewportDimension, 1). When pixels is 0 and
  //  viewport is 600, page is 0.0; when pixels is 1200 and viewport is
  //  600, page is 2.0; partial drags produce fractional pages.
  // ---------------------------------------------------------------------------

  final PageMetrics p1 = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 0.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 1.0,
    devicePixelRatio: 3.0,
  );
  final PageMetrics p2 = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 900.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 1.0,
    devicePixelRatio: 3.0,
  );
  final PageMetrics p3 = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 1500.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 1.0,
    devicePixelRatio: 3.0,
  );
  final List<_PageEntry> pages = <_PageEntry>[
    _PageEntry(
      label: 'page 0.0 --- aligned',
      description:
          'pixels=0, viewport=600. page evaluates to 0.0; first page is '
          'fully visible; PageController would report currentPage as 0.',
      metrics: p1,
      accent: tideHarbour,
    ),
    _PageEntry(
      label: 'page 1.5 --- mid-flick',
      description:
          'pixels=900 in 600-wide pages: page evaluates to 1.5. The user '
          'is mid-flick between page 1 and page 2; the snapping physics '
          'will round to whichever is nearer when the finger lifts.',
      metrics: p2,
      accent: tideOilLamp,
    ),
    _PageEntry(
      label: 'page 2.5 --- mid-flick',
      description:
          'pixels=1500 = halfway between page 2 (1200) and page 3 (1800). '
          'Same shape as p2, one whole page along the axis.',
      metrics: p3,
      accent: tideDrift,
    ),
  ];
  for (int i = 0; i < pages.length; i++) {
    final _PageEntry e = pages[i];
    final PageMetrics m = e.metrics;
    print('[tide-almanac] page metrics --- ${e.label}');
    print('  pixels=${m.pixels} viewport=${m.viewportDimension} '
        'page=${m.page} viewportFraction=${m.viewportFraction}');
  }

  // ---------------------------------------------------------------------------
  //  Axis-direction matrix --- one sample for each AxisDirection.
  // ---------------------------------------------------------------------------

  final FixedScrollMetrics axDown = m2;
  final ScrollMetrics axUp = m2.copyWith();
  // copyWith() does not let us change axisDirection on FixedScrollMetrics,
  // so we just build new ones for the three remaining directions.
  final FixedScrollMetrics axUp2 = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 900.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.up,
    devicePixelRatio: 3.0,
  );
  final FixedScrollMetrics axRight = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 900.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.right,
    devicePixelRatio: 3.0,
  );
  final FixedScrollMetrics axLeft = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2400.0,
    pixels: 900.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.left,
    devicePixelRatio: 3.0,
  );
  final List<_AxisEntry> axes = <_AxisEntry>[
    _AxisEntry(
      direction: AxisDirection.down,
      label: 'down',
      description:
          'Vertical axis, content scrolls upward as pixels grow. The most '
          'common direction; matches the natural "down the page" reading '
          'order of a ListView.',
      metrics: axDown,
      accent: tideHarbour,
    ),
    _AxisEntry(
      direction: AxisDirection.up,
      label: 'up',
      description:
          'Vertical axis, but reversed. Pixels growing means content '
          'travels downward. Used for chat-style reverse:true scrollables '
          'where new messages enter at the bottom.',
      metrics: axUp2,
      accent: tideShoal,
    ),
    _AxisEntry(
      direction: AxisDirection.right,
      label: 'right',
      description:
          'Horizontal axis. axis evaluates to Axis.horizontal; pixels '
          'growing means content moves leftwards out of the viewport.',
      metrics: axRight,
      accent: tideOilLamp,
    ),
    _AxisEntry(
      direction: AxisDirection.left,
      label: 'left',
      description:
          'Horizontal axis, reversed. Pixels growing pulls content from '
          'the left edge. Used for RTL languages or carousels that paginate '
          'from right to left.',
      metrics: axLeft,
      accent: tideDrift,
    ),
  ];
  // Touch axUp so the analyzer does not warn about an unused local.
  print('[tide-almanac] axUp.axisDirection=${axUp.axisDirection}');
  for (int i = 0; i < axes.length; i++) {
    final _AxisEntry a = axes[i];
    print('[tide-almanac] axis ${a.label} '
        'axis=${a.metrics.axis} '
        'axisDirection=${a.metrics.axisDirection}');
  }

  // ---------------------------------------------------------------------------
  //  Ship the snapshot tree.
  // ---------------------------------------------------------------------------

  print('[tide-almanac] composing 12-section snapshot tree');

  return Scaffold(
    backgroundColor: tideMist,
    appBar: AppBar(
      backgroundColor: tideMidnight,
      foregroundColor: tideShell,
      elevation: 0,
      title: Text(
        'ScrollMetrics --- Tide Almanac',
        style: TextStyle(
          color: tideShell,
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
          _section4RulerLegend(),
          const SizedBox(height: 28.0),
          _section5SamplesCatalogue(samples),
          const SizedBox(height: 28.0),
          _section6CopyWithCatalogue(copies),
          const SizedBox(height: 28.0),
          _section7PageMetricsGallery(pages),
          const SizedBox(height: 28.0),
          _section8AxisMatrix(axes),
          const SizedBox(height: 28.0),
          _section9EdgeAndOverscroll(),
          const SizedBox(height: 28.0),
          _section10Recipes(),
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
// SHARED HELPERS
// ===========================================================================
//
// A handful of small leaf-builder helpers that the section composers reuse.
// We keep them centralised so the visual language stays consistent across
// the file: every section uses the same chip, the same caption, the same
// kv row, the same divider strip, etc.
// ===========================================================================

// ---------------------------------------------------------------------------
//  _swatchChip --- a single named palette chip used in the title banner.
// ---------------------------------------------------------------------------

Widget _swatchChip(String name, Color background, Color foreground) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tideShell.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: foreground,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//  _sectionHeader --- a number + title + thin tide-line, repeated twelve
//  times in the file.
// ---------------------------------------------------------------------------

Widget _sectionHeader(String number, String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    decoration: BoxDecoration(
      color: tideMidnight,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tideNavy, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tideOilLamp,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                number,
                style: TextStyle(
                  color: tideRopeTar,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: tideShell,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 2.0,
          color: tideHarbour,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: tideSpray,
            fontSize: 13.0,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
//  _proseParagraph --- a body paragraph with the standard almanac styling.
// ---------------------------------------------------------------------------

Widget _proseParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Text(
      text,
      style: TextStyle(
        color: tideAbyss,
        fontSize: 13.5,
        height: 1.55,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//  _kvRow --- a single key/value row used in property tables.
// ---------------------------------------------------------------------------

Widget _kvRow(String key, String value, {Color? accent}) {
  final Color a = accent ?? tideHarbour;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 18.0,
          margin: const EdgeInsets.only(top: 2.0, right: 10.0),
          decoration: BoxDecoration(
            color: a,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            key,
            style: TextStyle(
              color: tideMidnight,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
              letterSpacing: 0.2,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: tideAbyss,
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
//  _captionedCard --- a coloured card with a title strip and arbitrary body.
// ---------------------------------------------------------------------------

Widget _captionedCard({
  required String code,
  required String title,
  required Color accent,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tideSandWet, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tideAbyss.withValues(alpha: 0.08),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: tideShell,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    color: tideMidnight,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: tideShell,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 14.0),
          child: body,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
//  _divider --- a thin horizontal hairline used inside cards.
// ---------------------------------------------------------------------------

Widget _divider() {
  return Container(
    height: 1.0,
    color: tideSandWet,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
  );
}

// ===========================================================================
// SECTION 1 --- TITLE BANNER WITH PALETTE SWATCHES
// ===========================================================================
//
// A wide, dark, gradient banner that announces the demo. It carries:
//   * The widget name (ScrollMetrics) in a foundry-bold treatment,
//   * A one-sentence position statement,
//   * The full sixteen-colour Tide Almanac palette as labelled chips,
//   * A small metric strip listing key facts (immutable, derived getters,
//     etc.).
// ===========================================================================

Widget _section1TitleBanner() {
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final String name = kPalette[i][0] as String;
    final Color color = kPalette[i][1] as Color;
    final bool dark = i < 8; // first eight are dark; switch foreground.
    swatches.add(_swatchChip(name, color, dark ? tideShell : tideAbyss));
  }
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          tideAbyss,
          tideMidnight,
          tideNavy,
          tideHarbour,
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tideAbyss.withValues(alpha: 0.45),
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
                color: tideOilLamp,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: tideShell, width: 2.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: tideAbyss.withValues(alpha: 0.45),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'TA',
                style: TextStyle(
                  color: tideRopeTar,
                  fontWeight: FontWeight.w800,
                  fontSize: 22.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ScrollMetrics',
                    style: TextStyle(
                      color: tideShell,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Tide Almanac --- a coastal field-guide to the '
                    'immutable scroll-position record.',
                    style: TextStyle(
                      color: tideSpray,
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: tideAbyss.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: tideShell.withValues(alpha: 0.2), width: 1.0),
          ),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _bannerMetric('immutable'),
              _bannerMetric('value-typed'),
              _bannerMetric('derived getters'),
              _bannerMetric('axis-aware'),
              _bannerMetric('overscroll-safe'),
              _bannerMetric('copyWith()'),
              _bannerMetric('FixedScrollMetrics'),
              _bannerMetric('PageMetrics'),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(spacing: 8.0, runSpacing: 8.0, children: swatches),
      ],
    ),
  );
}

Widget _bannerMetric(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tideShoal,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tideShell,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 2 --- PROSE ANATOMY OF ScrollMetrics
// ===========================================================================
//
// Five paragraphs of harbour-master prose that introduce the type, its
// purpose, and its derived getters. We keep this heavy on metaphor so the
// reader has something to picture before the property table arrives.
// ===========================================================================

Widget _section2ProseAnatomy() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '02',
          'Anatomy --- what is a ScrollMetrics?',
          'Five paragraphs from the harbour-master\'s log.',
        ),
        const SizedBox(height: 14.0),
        _proseParagraph(
          'Think of the harbour at the foot of the cliff. There is a '
          'tide gauge bolted to the inside of the breakwater, and on '
          'the wall above the office door is a printed almanac. Every '
          'half-hour the duty officer reads the gauge, copies the '
          'reading into the almanac, and goes back inside. The almanac '
          'is the historical record; the gauge is the live reading. '
          'ScrollMetrics is one entry in that almanac --- a frozen '
          'snapshot of where the water was at one specific moment.',
        ),
        _proseParagraph(
          'The reading itself is small: minScrollExtent, maxScrollExtent, '
          'pixels, viewportDimension, axisDirection, and devicePixelRatio. '
          'That is the entire payload. Everything else --- extentBefore, '
          'extentAfter, extentInside, atEdge, outOfRange, axis, '
          'extentTotal --- is a getter that does a couple of '
          'subtractions, a clamp, and returns. The cleverness is in '
          'choosing exactly six fields whose ratios produce all the '
          'derived quantities the rest of the framework needs.',
        ),
        _proseParagraph(
          'minScrollExtent and maxScrollExtent describe the document --- '
          'the chart datum and the deepest reading the gauge can record. '
          'pixels is the current reading. viewportDimension is the '
          'thickness of the slice the harbour-master can see at one '
          'time through the office window. axisDirection says which way '
          'is "down" in this particular harbour: vertical for a '
          'standard ListView, horizontal for a carousel, reversed for '
          'an upside-down chat log.',
        ),
        _proseParagraph(
          'extentBefore, extentInside, and extentAfter divide the '
          'document into three slices: what has been left behind in the '
          'wake, what is inside the visible window now, and what is '
          'still ahead. They always sum to extentTotal, which itself is '
          'maxScrollExtent - minScrollExtent. The three slices are the '
          'numbers the scrollbar uses to size and place its thumb. They '
          'are also what NotificationListener implementations consult '
          'when they want to react to "the user has scrolled past '
          'eighty percent of the document".',
        ),
        _proseParagraph(
          'atEdge and outOfRange are the bell-and-whistle: atEdge says '
          '"pixels are exactly on the rim", outOfRange says "pixels are '
          'past the rim". The two are mutually exclusive: an overscrolled '
          'position is past the edge, not on it. Apps lean on these for '
          'pull-to-refresh, infinite-scroll, snap-to-edge, and '
          'shadow-when-scrollable indicators.',
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3 --- PROPERTY ANATOMY TABLE
// ===========================================================================
//
// One row per field and one row per derived getter. Each row carries an
// accent strip in the colour family that section 5 uses for the matching
// concept (so the reader can train their eye on, e.g., extentBefore being
// always rendered in tideHarbour).
// ===========================================================================

Widget _section3PropertyAnatomy() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '03',
          'Property anatomy --- fields and derived getters',
          'Six stored fields, seven derived getters, one method.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: tideMist,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'STORED FIELDS',
            style: TextStyle(
              color: tideMidnight,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        _kvRow('minScrollExtent (double)',
            'The lowest pixels value reachable without overscrolling. Almost '
            'always 0 for ListViews.',
            accent: tideNavy),
        _kvRow('maxScrollExtent (double)',
            'The highest pixels value reachable without overscrolling. '
            'Total document length minus viewportDimension.',
            accent: tideNavy),
        _kvRow('pixels (double)',
            'The current reading of the tide-gauge. Can fall outside '
            '[minScrollExtent, maxScrollExtent] when overscrolled.',
            accent: tideOilLamp),
        _kvRow('viewportDimension (double)',
            'The size of the visible slice along the scroll axis. For a '
            'vertical ListView, this is the visible height.',
            accent: tideShoal),
        _kvRow('axisDirection (AxisDirection)',
            'down / up / right / left. Direction the visible slice moves '
            'when pixels grows. Determines axis (horizontal/vertical).',
            accent: tideHarbour),
        _kvRow('devicePixelRatio (double)',
            'The MediaQuery devicePixelRatio captured with the snapshot. '
            'Used to round to nearest physical pixel for crisp paint.',
            accent: tideDrift),
        _divider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: tideMist,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'DERIVED GETTERS',
            style: TextStyle(
              color: tideMidnight,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        _kvRow('axis',
            'axisDirectionToAxis(axisDirection): horizontal for left/right; '
            'vertical for up/down.',
            accent: tideHarbour),
        _kvRow('extentBefore',
            'pixels - minScrollExtent, clamped >= 0. Material that has '
            'scrolled away above the visible window.',
            accent: tideNavy),
        _kvRow('extentInside',
            'How much of the document is inside the visible window. '
            'min(pixels + viewport, max) - max(pixels, min), clamped >= 0.',
            accent: tideShoal),
        _kvRow('extentAfter',
            'maxScrollExtent - min(pixels + viewport, max), clamped >= 0. '
            'Material still ahead of the window.',
            accent: tideOilLamp),
        _kvRow('extentTotal',
            'maxScrollExtent - minScrollExtent. The full length of the '
            'document along the scroll axis.',
            accent: tideDrift),
        _kvRow('atEdge',
            'pixels == minScrollExtent || pixels == maxScrollExtent. '
            'True only at the rim, not past it.',
            accent: tideSeafoam),
        _kvRow('outOfRange',
            'pixels < minScrollExtent || pixels > maxScrollExtent. '
            'True only when overscrolled past either rim.',
            accent: tideWarn),
        _divider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: tideMist,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'METHOD',
            style: TextStyle(
              color: tideMidnight,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        _kvRow('copyWith(...)',
            'Returns a new FixedScrollMetrics with selected fields '
            'replaced. The only safe way to derive a new metrics from an '
            'existing one without mutating shared state.',
            accent: tideHarbour),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 --- TIDE RULER LEGEND
// ===========================================================================
//
// Section 5 will render eight tide-rulers, one per sample. Before we hit
// the catalogue we need to teach the reader how to read one. The legend is
// a single annotated ruler with every band, marker, and chip labelled
// inline. We re-use the same ruler-builder helper for the catalogue, so
// what the reader learns here applies directly.
//
// The ruler is laid out horizontally even when the metrics describe a
// vertical scroll: it is a chart-style normalisation, not a literal
// projection. We map the document range
// [min - overscrollHead, max + overscrollTail] linearly onto the visible
// width of the ruler. Inside that span we paint:
//
//   * a grey dry-sand strip                       --- the document
//   * a wet-sand strip [min, max]                 --- in-bounds region
//   * a tide-blue rectangle                       --- the visible window
//                                                     [pixels, pixels+vp]
//                                                     clamped to the ruler
//   * a vertical pixels marker                    --- pixels itself
//   * tick marks every 25% of extentTotal         --- chart graticule
//
// We then sit four chips below the ruler showing extentBefore,
// extentInside, extentAfter, and a final flag chip ("at edge", "in range",
// "head overscroll", "tail overscroll"). The chip widths mirror the ratio
// of each extent to extentTotal, so the chip strip becomes a horizontal
// stacked-bar of where the document\'s pixels are right now.
// ===========================================================================

Widget _section4RulerLegend() {
  // Build a small synthetic example for the legend. Document 0..1000,
  // viewport 250, pixels 300; nicely middle-of-the-page.
  final FixedScrollMetrics legendMetrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 300.0,
    viewportDimension: 250.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '04',
          'How to read a tide ruler',
          'The chart-style normalisation used in section 5.',
        ),
        const SizedBox(height: 14.0),
        _proseParagraph(
          'A tide ruler maps the entire scrollable document onto a fixed '
          'horizontal strip. Sand colours encode in-bounds versus '
          'overscroll territory, the deeper blue rectangle marks the '
          'currently-visible window, and a slim oil-lamp marker shows '
          'the precise pixels reading. Read the ruler left-to-right and '
          'you have read the metrics.',
        ),
        const SizedBox(height: 8.0),
        _ruler(legendMetrics, accent: tideHarbour),
        const SizedBox(height: 8.0),
        _extentChipStrip(legendMetrics),
        _divider(),
        _kvRow('dry sand strip',
            'The full ruler including overscroll padding on either side.',
            accent: tideSandDry),
        _kvRow('wet sand strip',
            '[minScrollExtent, maxScrollExtent] --- in-bounds territory.',
            accent: tideSandWet),
        _kvRow('window rectangle',
            '[pixels, pixels+viewportDimension] clamped to the wet strip. '
            'The actual visible slice.',
            accent: tideHarbour),
        _kvRow('lamp marker',
            'Vertical line at pixels itself --- the leading edge of the '
            'visible window.',
            accent: tideOilLamp),
        _kvRow('chip strip below',
            'extentBefore / extentInside / extentAfter sized to the ratio '
            'of each part of extentTotal, plus a flag chip for atEdge / '
            'outOfRange.',
            accent: tideShoal),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
//  _ruler --- render a horizontal tide ruler for a given FixedScrollMetrics.
// ---------------------------------------------------------------------------
//  We use a fixed virtual width of 1.0 for the ruler\'s domain and rely on
//  flex weights inside a Row to position rectangles. This keeps the ruler
//  responsive to whatever width the parent gives us without us having to
//  measure pixels.
//
//  We compute the chart bounds as
//    chartMin = min(min, pixels)              --- include head overscroll
//    chartMax = max(max, pixels + vp)         --- include tail overscroll
//  with a 10% padding on each side so an overscroll case never touches
//  the edge of the ruler.
// ---------------------------------------------------------------------------

Widget _ruler(ScrollMetrics m, {required Color accent}) {
  final double minE = m.minScrollExtent;
  final double maxE = m.maxScrollExtent;
  final double pix = m.pixels;
  final double vp = m.viewportDimension;
  final double winEnd = pix + vp;

  // Compute the chart range that includes any overscroll.
  double chartMin = minE;
  if (pix < chartMin) {
    chartMin = pix;
  }
  double chartMax = maxE;
  if (winEnd > chartMax) {
    chartMax = winEnd;
  }
  if (chartMin == chartMax) {
    // Degenerate (calm-pool) case: avoid a zero-width ruler by giving it
    // a notional 100-unit padding on either side.
    chartMin = chartMin - 100.0;
    chartMax = chartMax + 100.0;
  }
  final double pad = (chartMax - chartMin) * 0.10;
  final double chartLow = chartMin - pad;
  final double chartHigh = chartMax + pad;
  final double chartSpan = chartHigh - chartLow;

  // Compute the four key x-positions in [0..1] inside the ruler.
  final double minPos = (minE - chartLow) / chartSpan;
  final double maxPos = (maxE - chartLow) / chartSpan;
  final double winStart = (pix - chartLow) / chartSpan;
  final double winFinish = (winEnd - chartLow) / chartSpan;

  // Helper to clamp a fraction into [0..1] without using .clamp on doubles
  // (some d4rt builds prefer explicit if/else).
  final double minPosC = _clamp01(minPos);
  final double maxPosC = _clamp01(maxPos);
  final double winStartC = _clamp01(winStart);
  final double winFinishC = _clamp01(winFinish);

  // Use a Stack of LayoutBuilder-free rectangles via FractionallySizedBox.
  return Container(
    height: 56.0,
    decoration: BoxDecoration(
      color: tideSandDry,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tideDrift, width: 1.0),
    ),
    child: Stack(
      children: <Widget>[
        // Wet-sand strip [min, max].
        Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: maxPosC - minPosC,
            heightFactor: 1.0,
            child: Container(
              margin: EdgeInsets.only(left: 0.0),
              decoration: BoxDecoration(
                color: tideSandWet,
              ),
            ),
          ),
        ),
        // The wet-sand strip needs an offset, but FractionallySizedBox
        // honours alignment within its parent --- so we wrap in a Row
        // that pads from the left.
        Row(
          children: <Widget>[
            Expanded(flex: (minPosC * 1000).round(), child: const SizedBox()),
            Expanded(
              flex: ((maxPosC - minPosC) * 1000).round() + 1,
              child: Container(
                color: tideSandWet,
              ),
            ),
            Expanded(
              flex: ((1.0 - maxPosC) * 1000).round() + 1,
              child: const SizedBox(),
            ),
          ],
        ),
        // Visible window [pixels, pixels + vp].
        Row(
          children: <Widget>[
            Expanded(
              flex: (winStartC * 1000).round() + 1,
              child: const SizedBox(),
            ),
            Expanded(
              flex: ((winFinishC - winStartC) * 1000).round() + 1,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.55),
                  border: Border.all(color: accent, width: 1.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            Expanded(
              flex: ((1.0 - winFinishC) * 1000).round() + 1,
              child: const SizedBox(),
            ),
          ],
        ),
        // Lamp marker at pixels itself.
        Row(
          children: <Widget>[
            Expanded(
              flex: (winStartC * 1000).round() + 1,
              child: const SizedBox(),
            ),
            Container(
              width: 3.0,
              color: tideOilLamp,
            ),
            Expanded(
              flex: ((1.0 - winStartC) * 1000).round() + 1,
              child: const SizedBox(),
            ),
          ],
        ),
      ],
    ),
  );
}

double _clamp01(double v) {
  if (v < 0.0) {
    return 0.0;
  }
  if (v > 1.0) {
    return 1.0;
  }
  return v;
}

// ---------------------------------------------------------------------------
//  _extentChipStrip --- a stacked chip strip below the ruler.
// ---------------------------------------------------------------------------

Widget _extentChipStrip(ScrollMetrics m) {
  final double total = m.extentTotal;
  final double before = m.extentBefore;
  final double inside = m.extentInside;
  final double after = m.extentAfter;
  // Avoid divide-by-zero on calm-pool case.
  final double denom = total <= 0.0 ? 1.0 : total;
  final int beforeFlex = ((before / denom) * 1000).round() + 1;
  final int insideFlex = ((inside / denom) * 1000).round() + 1;
  final int afterFlex = ((after / denom) * 1000).round() + 1;

  String flagText;
  Color flagBg;
  if (m.outOfRange) {
    if (m.pixels < m.minScrollExtent) {
      flagText = 'head overscroll';
      flagBg = tideWarn;
    } else {
      flagText = 'tail overscroll';
      flagBg = tideStorm;
    }
  } else if (m.atEdge) {
    flagText = 'at edge';
    flagBg = tideOilLamp;
  } else {
    flagText = 'in range';
    flagBg = tideSeafoam;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: beforeFlex,
            child: Container(
              height: 22.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tideNavy,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
              ),
              child: Text(
                'before ${before.toStringAsFixed(0)}',
                style: TextStyle(
                  color: tideShell,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 2.0),
          Expanded(
            flex: insideFlex,
            child: Container(
              height: 22.0,
              alignment: Alignment.center,
              color: tideShoal,
              child: Text(
                'inside ${inside.toStringAsFixed(0)}',
                style: TextStyle(
                  color: tideShell,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 2.0),
          Expanded(
            flex: afterFlex,
            child: Container(
              height: 22.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tideOilLamp,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
              ),
              child: Text(
                'after ${after.toStringAsFixed(0)}',
                style: TextStyle(
                  color: tideRopeTar,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 6.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: flagBg,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          flagText,
          style: TextStyle(
            color: tideShell,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 5 --- EIGHT SAMPLE CATALOGUE
// ===========================================================================
//
// One captioned card per _TideSample. Each card carries:
//   * The sample code chip (S1..S8) + title strip in the sample's accent,
//   * The narrative paragraph,
//   * The tide ruler,
//   * The chip strip below the ruler,
//   * A compact metrics readout: pixels, min, max, viewport,
//     extentBefore / extentInside / extentAfter, atEdge, outOfRange.
//
// We render the cards as a Column so the snapshot prints cleanly down the
// page; in a non-snapshot build they could equally be a GridView.
// ===========================================================================

Widget _section5SamplesCatalogue(List<_TideSample> samples) {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    cards.add(_sampleCard(samples[i]));
  }
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '05',
          'Eight scroll-state readings',
          'A catalogue of FixedScrollMetrics shapes you will meet.',
        ),
        const SizedBox(height: 14.0),
        _proseParagraph(
          'Below: low water at the head of the page; slack water in the '
          'middle; high water at the tail; backwash overscroll above '
          'the head; storm-surge overscroll past the tail; the calm pool '
          'where content is shorter than the viewport; a long-shore page '
          'with very large extentTotal; and a horizontally paginated '
          'almanac sitting on page two.',
        ),
        Column(children: cards),
      ],
    ),
  );
}

Widget _sampleCard(_TideSample s) {
  final FixedScrollMetrics m = s.metrics;
  return _captionedCard(
    code: s.code,
    title: s.title,
    accent: s.accent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          s.narrative,
          style: TextStyle(
            color: tideAbyss,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        _ruler(m, accent: s.accent),
        const SizedBox(height: 8.0),
        _extentChipStrip(m),
        const SizedBox(height: 10.0),
        _divider(),
        _kvRow('pixels', m.pixels.toStringAsFixed(1), accent: s.accent),
        _kvRow('min .. max',
            '${m.minScrollExtent.toStringAsFixed(1)} .. '
            '${m.maxScrollExtent.toStringAsFixed(1)}',
            accent: tideNavy),
        _kvRow('viewportDimension',
            m.viewportDimension.toStringAsFixed(1),
            accent: tideShoal),
        _kvRow('extentBefore', m.extentBefore.toStringAsFixed(1),
            accent: tideNavy),
        _kvRow('extentInside', m.extentInside.toStringAsFixed(1),
            accent: tideShoal),
        _kvRow('extentAfter', m.extentAfter.toStringAsFixed(1),
            accent: tideOilLamp),
        _kvRow('extentTotal', m.extentTotal.toStringAsFixed(1),
            accent: tideDrift),
        _kvRow('atEdge', m.atEdge.toString(), accent: tideSeafoam),
        _kvRow('outOfRange', m.outOfRange.toString(), accent: tideWarn),
        _kvRow('axisDirection', m.axisDirection.toString(),
            accent: tideHarbour),
        _kvRow('axis', m.axis.toString(), accent: tideHarbour),
        _kvRow('devicePixelRatio',
            m.devicePixelRatio.toStringAsFixed(1), accent: tideDrift),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 --- copyWith() CATALOGUE
// ===========================================================================
//
// Four side-by-side comparisons. Each row shows the original metrics on
// the left, the derived metrics on the right, and a small narrative chip
// in between describing what was changed.
// ===========================================================================

Widget _section6CopyWithCatalogue(List<_CopyEntry> copies) {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < copies.length; i++) {
    cards.add(_copyCard(copies[i]));
  }
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '06',
          'copyWith() catalogue',
          'Four derived snapshots, each based on the slack-water reading.',
        ),
        const SizedBox(height: 14.0),
        _proseParagraph(
          'copyWith() is the only safe way to derive a new FixedScrollMetrics '
          'from an existing one. Because metrics are immutable, every '
          '"what would the metrics look like if we shifted pixels by 600?" '
          'question must produce a fresh value. The four examples below '
          'walk through the most common questions you will ask.',
        ),
        Column(children: cards),
      ],
    ),
  );
}

Widget _copyCard(_CopyEntry e) {
  return _captionedCard(
    code: 'CW',
    title: e.label,
    accent: e.accent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          e.description,
          style: TextStyle(
            color: tideAbyss,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _miniMetrics('original', e.original, tideNavy)),
            const SizedBox(width: 10.0),
            Container(
              width: 24.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: e.accent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '>',
                style: TextStyle(
                  color: tideShell,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: _miniMetrics('derived', e.derived, e.accent)),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(child: _ruler(e.original, accent: tideNavy)),
            const SizedBox(width: 8.0),
            Expanded(child: _ruler(e.derived, accent: e.accent)),
          ],
        ),
      ],
    ),
  );
}

Widget _miniMetrics(String label, ScrollMetrics m, Color accent) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: tideMist,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: tideShell,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        _miniLine('pixels', m.pixels),
        _miniLine('min', m.minScrollExtent),
        _miniLine('max', m.maxScrollExtent),
        _miniLine('viewport', m.viewportDimension),
        _miniLine('extBefore', m.extentBefore),
        _miniLine('extInside', m.extentInside),
        _miniLine('extAfter', m.extentAfter),
      ],
    ),
  );
}

Widget _miniLine(String key, double value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 70.0,
          child: Text(
            key,
            style: TextStyle(
              color: tideMidnight,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            color: tideAbyss,
            fontSize: 10.5,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 --- PageMetrics GALLERY
// ===========================================================================
//
// PageMetrics is FixedScrollMetrics with one extra getter: page. Its value
// is pixels / max(viewportDimension, 1). In a PageView a finger drag that
// is not yet snapped will produce a fractional page; once the snap-physics
// settle, page will be an integer again.
// ===========================================================================

Widget _section7PageMetricsGallery(List<_PageEntry> pages) {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < pages.length; i++) {
    cards.add(_pageCard(pages[i]));
  }
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '07',
          'PageMetrics gallery',
          'Three snapshots from a paginated almanac.',
        ),
        const SizedBox(height: 14.0),
        _proseParagraph(
          'PageMetrics is a FixedScrollMetrics subclass with one extra '
          'getter: page. The numerator is pixels; the denominator is '
          'max(viewportDimension, 1.0). On a five-page horizontal almanac '
          'with 600-pixel pages, page == 0.0 means we are flush with the '
          'first page; page == 1.5 means we are halfway between pages 1 '
          'and 2 mid-flick; page == 4.0 means we are pinned to the last '
          'page.',
        ),
        Column(children: cards),
      ],
    ),
  );
}

Widget _pageCard(_PageEntry e) {
  return _captionedCard(
    code: 'PM',
    title: e.label,
    accent: e.accent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          e.description,
          style: TextStyle(
            color: tideAbyss,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        // Render five page rectangles with one highlighted to the
        // floor(page) index.
        _pageStrip(e.metrics),
        const SizedBox(height: 12.0),
        _kvRow('pixels', e.metrics.pixels.toStringAsFixed(1),
            accent: e.accent),
        _kvRow('viewportDimension',
            e.metrics.viewportDimension.toStringAsFixed(1),
            accent: tideShoal),
        _kvRow('viewportFraction',
            e.metrics.viewportFraction.toStringAsFixed(2),
            accent: tideDrift),
        _kvRow('page', (e.metrics.page ?? 0.0).toStringAsFixed(2),
            accent: tideOilLamp),
        _kvRow('extentBefore',
            e.metrics.extentBefore.toStringAsFixed(1),
            accent: tideNavy),
        _kvRow('extentInside',
            e.metrics.extentInside.toStringAsFixed(1),
            accent: tideShoal),
        _kvRow('extentAfter',
            e.metrics.extentAfter.toStringAsFixed(1),
            accent: tideOilLamp),
        _kvRow('atEdge', e.metrics.atEdge.toString(),
            accent: tideSeafoam),
      ],
    ),
  );
}

Widget _pageStrip(PageMetrics m) {
  // 5 pages of 600 each on a 0..2400 document means there are 5 pages
  // (indexes 0..4). We render them as a row of five identical
  // rectangles; whichever page contains pixels gets the accent fill.
  final List<Widget> cells = <Widget>[];
  final double pageVal = m.page ?? 0.0;
  final int activeFloor = pageVal.floor();
  final int activeCeil = pageVal.ceil();
  for (int i = 0; i < 5; i++) {
    Color bg;
    if (i == activeFloor && i == activeCeil) {
      bg = tideHarbour; // exact page hit
    } else if (i == activeFloor) {
      bg = tideShoal; // mid-flick from
    } else if (i == activeCeil) {
      bg = tideSeafoam; // mid-flick to
    } else {
      bg = tideMist;
    }
    cells.add(Expanded(
      child: Container(
        height: 36.0,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: tideNavy, width: 1.0),
        ),
        child: Text(
          'p$i',
          style: TextStyle(
            color: tideMidnight,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ));
  }
  return Row(children: cells);
}

// ===========================================================================
// SECTION 8 --- AXIS DIRECTION MATRIX
// ===========================================================================
//
// Four cards, one for each AxisDirection value. Each card carries the
// direction\'s name, a small arrow visualisation, and the same metrics
// recomputed for that direction. The point is to make explicit how the
// .axis getter folds four AxisDirections into two Axis values.
// ===========================================================================

Widget _section8AxisMatrix(List<_AxisEntry> axes) {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < axes.length; i++) {
    cards.add(_axisCard(axes[i]));
  }
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '08',
          'Axis direction matrix',
          'Four AxisDirections, two Axis values, one .axis getter.',
        ),
        const SizedBox(height: 14.0),
        _proseParagraph(
          'AxisDirection encodes both an axis (horizontal / vertical) and '
          'a direction along that axis (forward / reverse). The .axis '
          'getter folds AxisDirection.up and AxisDirection.down into '
          'Axis.vertical, and AxisDirection.left and AxisDirection.right '
          'into Axis.horizontal. Most layout decisions only care about '
          '.axis; only the physics need the full direction.',
        ),
        Column(children: cards),
      ],
    ),
  );
}

Widget _axisCard(_AxisEntry a) {
  return _captionedCard(
    code: 'AX',
    title: 'AxisDirection.${a.label}',
    accent: a.accent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          a.description,
          style: TextStyle(
            color: tideAbyss,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _arrowGlyph(a.direction, a.accent),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _kvRow('axisDirection', a.metrics.axisDirection.toString(),
                      accent: a.accent),
                  _kvRow('axis', a.metrics.axis.toString(), accent: a.accent),
                  _kvRow('extentBefore',
                      a.metrics.extentBefore.toStringAsFixed(1),
                      accent: tideNavy),
                  _kvRow('extentInside',
                      a.metrics.extentInside.toStringAsFixed(1),
                      accent: tideShoal),
                  _kvRow('extentAfter',
                      a.metrics.extentAfter.toStringAsFixed(1),
                      accent: tideOilLamp),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _arrowGlyph(AxisDirection d, Color accent) {
  String label;
  if (d == AxisDirection.down) {
    label = 'v';
  } else if (d == AxisDirection.up) {
    label = '^';
  } else if (d == AxisDirection.right) {
    label = '>';
  } else {
    label = '<';
  }
  return Container(
    width: 56.0,
    height: 56.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: accent,
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tideAbyss.withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tideShell,
        fontSize: 28.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 9 --- EDGE / OVERSCROLL CALLOUTS (DO / AVOID)
// ===========================================================================
//
// A side-by-side DO / AVOID strip, written in the harbour-master\'s tone.
// The DO column shows habits that survive overscroll and unusual
// configurations; the AVOID column shows the kind of mistakes a junior
// keeper makes their first season on the wall.
// ===========================================================================

Widget _section9EdgeAndOverscroll() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '09',
          'Edge and overscroll --- do and avoid',
          'Habits that survive a storm-surge reading.',
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _doColumn()),
            const SizedBox(width: 14.0),
            Expanded(child: _avoidColumn()),
          ],
        ),
      ],
    ),
  );
}

Widget _doColumn() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tideMist,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tideSeafoam, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tideSeafoam,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'DO',
            style: TextStyle(
              color: tideMidnight,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        _doAvoidLine(
            'Use atEdge for "snap to edge" decisions; it is exclusive of '
            'overscroll.'),
        _doAvoidLine(
            'Use outOfRange when reacting to refresh-spinner pulls or '
            'bounce physics.'),
        _doAvoidLine(
            'Compute thumb position from extentBefore / extentTotal --- '
            'the framework already clamps for you.'),
        _doAvoidLine(
            'Treat ScrollMetrics as immutable; copyWith() to derive new '
            'snapshots.'),
        _doAvoidLine(
            'Read .axis when you only care horizontal vs vertical.'),
        _doAvoidLine(
            'Read .axisDirection when you also need forward / reverse.'),
      ],
    ),
  );
}

Widget _avoidColumn() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tideMist,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tideWarn, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tideWarn,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'AVOID',
            style: TextStyle(
              color: tideShell,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        _doAvoidLine(
            'Comparing pixels < maxScrollExtent --- ignores overscroll on '
            'the tail.'),
        _doAvoidLine(
            'Dividing by extentTotal without checking for the calm-pool '
            'case (extentTotal == 0).'),
        _doAvoidLine(
            'Using .pixels as a thumb-rail fraction --- it does not '
            'normalise to the rail length.'),
        _doAvoidLine(
            'Mutating ScrollMetrics --- it is immutable; do not subclass '
            'to add fields.'),
        _doAvoidLine(
            'Assuming extentBefore + extentInside + extentAfter equals '
            'extentTotal during overscroll --- the clamps may make it '
            'less.'),
        _doAvoidLine(
            'Mixing AxisDirection with TextDirection --- they are '
            'different concepts.'),
      ],
    ),
  );
}

Widget _doAvoidLine(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 7.0, right: 8.0),
          decoration: BoxDecoration(
            color: tideHarbour,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: tideAbyss,
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 --- RECIPE CARDS
// ===========================================================================
//
// Five short code-recipe cards. Each carries a one-line task, a code-like
// snippet rendered as a monospaced strip, and a one-paragraph note that
// expands on what to watch for.
// ===========================================================================

Widget _section10Recipes() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '10',
          'Recipe cards',
          'Five short patterns lifted from the day-log.',
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'R1',
          'Read the thumb-rail fraction',
          'final f = (m.extentBefore + 0.5 * m.extentInside) / m.extentTotal;',
          'Use the midpoint of the visible window so the thumb represents '
              '"where the centre of the page is" rather than only its top. '
              'Guard against extentTotal == 0 first.',
        ),
        _recipeCard(
          'R2',
          'Detect a refresh-pull',
          'if (m.pixels < m.minScrollExtent) { triggerRefresh(); }',
          'A negative pixels value is the canonical "user has dragged past '
              'the head" signal. Pair with a minimum-pull threshold and a '
              'release-time check before actually firing the refresh.',
        ),
        _recipeCard(
          'R3',
          'Snap to nearest page',
          'final target = (m.pixels / m.viewportDimension).round() '
              '* m.viewportDimension;',
          'Page-snapping logic is just a round() against viewportDimension. '
              'For PageMetrics with viewportFraction != 1.0, divide by '
              'viewportDimension * viewportFraction instead.',
        ),
        _recipeCard(
          'R4',
          'Approximate scroll percentage',
          'final pct = (m.pixels - m.minScrollExtent) / m.extentTotal;',
          'Equivalent to extentBefore / extentTotal (extentBefore is '
              'already pre-clamped). Useful for chaptered progress bars and '
              'reading-time estimates.',
        ),
        _recipeCard(
          'R5',
          'Make a frozen snapshot for a notification',
          'final frozen = FixedScrollMetrics(\n'
              '  minScrollExtent: m.minScrollExtent,\n'
              '  maxScrollExtent: m.maxScrollExtent,\n'
              '  pixels: m.pixels,\n'
              '  viewportDimension: m.viewportDimension,\n'
              '  axisDirection: m.axisDirection,\n'
              '  devicePixelRatio: m.devicePixelRatio,\n'
              ');',
          'Notifications are async-ish: by the time a listener runs, the '
              'live ScrollPosition may have moved. Capture a frozen value at '
              'the moment of dispatch.',
        ),
      ],
    ),
  );
}

Widget _recipeCard(String code, String title, String snippet, String note) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: tideMist,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tideShoal, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: tideHarbour,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(11.0),
              topRight: Radius.circular(11.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: tideShell,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    color: tideMidnight,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: tideShell,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: tideAbyss,
          ),
          child: Text(
            snippet,
            style: TextStyle(
              color: tideSpray,
              fontSize: 12.0,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            note,
            style: TextStyle(
              color: tideAbyss,
              fontSize: 12.5,
              height: 1.5,
            ),
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
// Twelve terms, each defined in one or two sentences, in alphabetical
// order. The glossary is the reference card a junior keeper tucks into
// the back of the almanac.
// ===========================================================================

Widget _section11Glossary() {
  final List<List<String>> entries = <List<String>>[
    <String>[
      'atEdge',
      'pixels equals minScrollExtent or maxScrollExtent. Exclusive of '
          'overscroll: a position past the rim is not on the rim.'
    ],
    <String>[
      'AxisDirection',
      'Enum of {up, down, left, right}. Encodes both axis and forward / '
          'reverse along that axis.'
    ],
    <String>[
      'axis',
      'Derived: Axis.horizontal for left/right; Axis.vertical for up/down. '
          'Used by layout code that does not care about reverse.'
    ],
    <String>[
      'devicePixelRatio',
      'The MediaQuery devicePixelRatio captured with the metrics, used '
          'when rounding to physical pixels.'
    ],
    <String>[
      'extentAfter',
      'Material that has not yet entered the visible window. Clamped at '
          'zero when overscrolled past the tail.'
    ],
    <String>[
      'extentBefore',
      'Material already scrolled out of the visible window above. Clamped '
          'at zero when overscrolled past the head.'
    ],
    <String>[
      'extentInside',
      'How much of the document is currently visible. Equals viewport '
          'when fully in-bounds; less when overscrolled.'
    ],
    <String>[
      'extentTotal',
      'maxScrollExtent - minScrollExtent. The full length of the document '
          'along the scroll axis.'
    ],
    <String>[
      'FixedScrollMetrics',
      'Concrete immutable bag that implements ScrollMetrics. The frozen '
          'snapshot used in notifications.'
    ],
    <String>[
      'outOfRange',
      'pixels is past the rim (overscrolled). Mutually exclusive with '
          'atEdge.'
    ],
    <String>[
      'PageMetrics',
      'FixedScrollMetrics subclass with one extra getter: page = pixels / '
          'max(viewportDimension, 1).'
    ],
    <String>[
      'viewportDimension',
      'The size of the visible slice along the scroll axis. The visible '
          'height for a vertical ListView.'
    ],
  ];
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final String term = entries[i][0];
    final String def = entries[i][1];
    rows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: tideNavy,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                term,
                style: TextStyle(
                  color: tideShell,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              def,
              style: TextStyle(
                color: tideAbyss,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: tideShell,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tideSandWet, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '11',
          'Glossary',
          'Twelve terms, alphabetical, one card to cut out and keep.',
        ),
        const SizedBox(height: 14.0),
        Column(children: rows),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 --- RECAP FOOTER
// ===========================================================================
//
// A dark gradient footer that closes the almanac with three takeaway
// bullets and a brief sign-off in the harbour-master\'s voice.
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
          tideAbyss,
          tideMidnight,
          tideNavy,
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Recap',
          style: TextStyle(
            color: tideShell,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 2.0,
          color: tideOilLamp,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          width: 80.0,
        ),
        const SizedBox(height: 10.0),
        _recapBullet(
            'ScrollMetrics is six stored fields plus seven derived getters; '
            'do not try to remember more.'),
        _recapBullet(
            'Use atEdge and outOfRange together: one is on the rim, the '
            'other is past it.'),
        _recapBullet(
            'extentBefore + extentInside + extentAfter equals extentTotal '
            'in-bounds; less during overscroll.'),
        _recapBullet(
            'copyWith() is the only safe way to derive a new metrics from '
            'an existing one.'),
        _recapBullet(
            'PageMetrics adds page = pixels / max(viewportDimension, 1) '
            'for snap-physics.'),
        const SizedBox(height: 14.0),
        Text(
          'Close the almanac. Hang it back on its nail beside the door.',
          style: TextStyle(
            color: tideSpray,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.only(top: 6.0, right: 10.0),
          decoration: BoxDecoration(
            color: tideOilLamp,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: tideShell,
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}
