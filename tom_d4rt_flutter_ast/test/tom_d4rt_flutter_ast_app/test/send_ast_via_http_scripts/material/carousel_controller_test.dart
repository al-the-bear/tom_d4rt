// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
//  CAROUSEL CONTROLLER  --  DEEP VISUAL DEMO
// =============================================================================
//  Theme: "Carnival Citrine"
//  A radiant, sunlit study of the Material 3 CarouselView and its companion
//  CarouselController.  The CarouselController is a ScrollController-derived
//  object that knows the index of the initially-shown carousel item, can
//  animate to a new index, and forwards convenient `nextItem` /
//  `previousItem` calls to the underlying scroll position.
//
//  This file is intentionally encyclopedic.  It serves as a *snapshot* of the
//  CarouselController API rendered as a single Scaffold, because the d4rt
//  interpreter that consumes this file does not support StatefulWidget,
//  setState, or live animations.  Every section therefore presents its
//  knowledge declaratively: prose, tables, code excerpts, palette swatches,
//  and statically-attached CarouselView widgets each driven by a freshly
//  constructed CarouselController(initialItem: N).
//
//  Sections (mirroring the SingleChildScrollView body):
//    1.  Title banner with palette swatches.
//    2.  Prose anatomy: what CarouselView + CarouselController are.
//    3.  Property anatomy: initialItem, attach state, animateToItem.
//    4.  Static carousel gallery (4 different initialItem values).
//    5.  Layout matrix (snapping x axis = 4 cards).
//    6.  "Visible item budget" diagram (weights = [3, 2, 1]).
//    7.  Constructor argument cards (itemExtent, flexWeights, etc).
//    8.  DO / AVOID callouts.
//    9.  Code snippet recipe gallery (5 canonical recipes).
//   10.  Glossary (12+ terms).
//   11.  Recap footer.
//
//  Constraint reminders for future maintainers:
//    *  build() runs once.  No setState, no animateToItem at runtime.
//    *  Controllers are constructed with `initialItem: N` so the widget tree
//       picks up the right starting page when first attached.
//    *  Color alpha tweaks use `.withValues(alpha: ...)`, never
//       `.withOpacity(...)`.
//    *  Iteration over collections uses index-based for loops only.
//    *  Narrative `print(...)` calls log the demo's intent at startup.
// =============================================================================

// -----------------------------------------------------------------------------
//  PALETTE :: Carnival Citrine
// -----------------------------------------------------------------------------
//  A sun-drenched palette named after the citrine gemstone, found on the
//  midway of an autumn carnival.  Twelve named tones cover the spectrum from
//  shaded velvet to luminous lemon.
const Color kCitrineDeep = Color(0xFF8A5A00);
const Color kCitrineCore = Color(0xFFE2A310);
const Color kCitrineGlow = Color(0xFFFFD24A);
const Color kCitrineMist = Color(0xFFFFF1B8);
const Color kCarnivalPlum = Color(0xFF4A1D5A);
const Color kCarnivalRose = Color(0xFFD8447A);
const Color kCarnivalCoral = Color(0xFFFF7E5F);
const Color kCarnivalPeach = Color(0xFFFFB07B);
const Color kCarnivalTeal = Color(0xFF1E6F73);
const Color kCarnivalMint = Color(0xFF74C7B8);
const Color kCarnivalNight = Color(0xFF1B1330);
const Color kCarnivalCream = Color(0xFFFFF7E2);

// Convenience list for swatch rendering.
const List<Color> kPalette = <Color>[
  kCitrineDeep,
  kCitrineCore,
  kCitrineGlow,
  kCitrineMist,
  kCarnivalPlum,
  kCarnivalRose,
  kCarnivalCoral,
  kCarnivalPeach,
  kCarnivalTeal,
  kCarnivalMint,
  kCarnivalNight,
  kCarnivalCream,
];

const List<String> kPaletteNames = <String>[
  'CitrineDeep',
  'CitrineCore',
  'CitrineGlow',
  'CitrineMist',
  'CarnivalPlum',
  'CarnivalRose',
  'CarnivalCoral',
  'CarnivalPeach',
  'CarnivalTeal',
  'CarnivalMint',
  'CarnivalNight',
  'CarnivalCream',
];

// -----------------------------------------------------------------------------
//  Narrative print helpers.
// -----------------------------------------------------------------------------
void _logBanner() {
  print('================================================================');
  print('  CarouselController :: Carnival Citrine demo                    ');
  print('  Snapshot rendering, single build() pass.                       ');
  print('================================================================');
}

void _logSection(String name) {
  print('  -- section :: $name');
}

// -----------------------------------------------------------------------------
//  Top-level entrypoint.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  _logBanner();
  print('  palette has ${kPalette.length} tones');
  print('  rendering Scaffold with SingleChildScrollView body');
  print('  CarouselController controllers are built with explicit initialItem');
  print('  build() runs exactly once -- no setState, no live animation');
  print('  use `controller.animateToItem(i)` later in real apps');
  print('  Material 3 CarouselView wraps a sliver under the hood');
  print('  initialItem feeds the controller pixel offset on first attach');
  print('  controllers should not be reused across multiple CarouselViews');
  print('  reading controller.position before attach throws StateError');
  print('  this snapshot demonstrates 4 independent controllers');
  print('  weighted carousels show flexWeights = [3, 2, 1]');
  print('  uncontained carousels show every child at its natural size');
  print('  itemSnapping locks the scroll to whole items');
  print('  reverse + scrollDirection control the geometry');
  print('  glossary section closes the demo with 12 terms');

  _logSection('build()');

  return Scaffold(
    backgroundColor: kCarnivalCream,
    appBar: AppBar(
      backgroundColor: kCarnivalPlum,
      foregroundColor: kCarnivalCream,
      title: const Text('CarouselController -- Carnival Citrine'),
      centerTitle: false,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTitleBanner(),
          const SizedBox(height: 20),
          _buildProseAnatomy(),
          const SizedBox(height: 20),
          _buildPropertyAnatomy(),
          const SizedBox(height: 20),
          _buildStaticGallery(),
          const SizedBox(height: 20),
          _buildLayoutMatrix(),
          const SizedBox(height: 20),
          _buildVisibleBudgetDiagram(),
          const SizedBox(height: 20),
          _buildConstructorArguments(),
          const SizedBox(height: 20),
          _buildDoAvoidCallouts(),
          const SizedBox(height: 20),
          _buildCodeRecipes(),
          const SizedBox(height: 20),
          _buildGlossary(),
          const SizedBox(height: 20),
          _buildRecapFooter(),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 1 :: Title banner with palette swatches.
// =============================================================================
Widget _buildTitleBanner() {
  _logSection('title-banner');
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kCitrineGlow, kCarnivalCoral, kCarnivalRose],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kCarnivalNight.withValues(alpha: 0.18),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CarouselController',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: kCarnivalNight,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Material 3 carousel scrolling, declared in a single build() pass.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: kCarnivalNight,
          ),
        ),
        const SizedBox(height: 14),
        _buildPaletteStrip(),
      ],
    ),
  );
}

Widget _buildPaletteStrip() {
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    swatches.add(_buildSwatch(kPalette[i], kPaletteNames[i]));
  }
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: swatches,
  );
}

Widget _buildSwatch(Color color, String name) {
  return Container(
    width: 116,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: kCarnivalCream.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kCarnivalNight.withValues(alpha: 0.18)),
    ),
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #38, P3):
    // Some longer palette names ("CarnivalNight", "CarnivalCream") render
    // wider than the 100 px inner width of the 116-px swatch container,
    // producing 0.487 / 2.2 px right overflows on the Row. Wrap the Text
    // in Expanded and add ellipsis so the label adapts to the remaining
    // space (~76 px) instead of demanding its intrinsic width.
    child: Row(
      children: <Widget>[
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kCarnivalNight.withValues(alpha: 0.4)),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: kCarnivalNight,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 2 :: Prose anatomy card.
// =============================================================================
Widget _buildProseAnatomy() {
  _logSection('prose-anatomy');
  return _card(
    title: 'What is a CarouselController?',
    accent: kCitrineCore,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _para(
          'A CarouselController is the ScrollController flavour built for the '
          'Material 3 CarouselView widget.  Like every ScrollController it '
          'attaches to one ScrollPosition, but it adds carousel-specific '
          'helpers: the initialItem index it should snap to on first '
          'attachment, an animateToItem(int) method that drives the position '
          'with a default Material curve, and the inherited nextItem / '
          'previousItem helpers that delegate to animateTo.',
        ),
        _para(
          'The CarouselView itself comes in three flavours:  the default '
          'constructor (one fixed itemExtent), CarouselView.weighted (a list '
          'of flexWeights describing the visible budget), and the '
          'uncontained pattern where each child reports its own size.  In '
          'all three cases, the same CarouselController shape is used; the '
          'difference is purely in how the carousel lays out its children.',
        ),
        _para(
          'Because the carousel is implemented as a sliver, the controller '
          'speaks the regular Scrollable language under the hood.  You can '
          'still inspect controller.offset once attached, but the friendly '
          'API is animateToItem(int index) which converts an item index into '
          'the correct pixel offset.',
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 3 :: Property anatomy.
// =============================================================================
Widget _buildPropertyAnatomy() {
  _logSection('property-anatomy');
  return _card(
    title: 'Property anatomy',
    accent: kCarnivalTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _propertyRow(
          'initialItem',
          'int',
          'The carousel item index the controller should target on first '
              'attach.  Pixel offset = initialItem * itemExtent (or the '
              'cumulative weighted offset for CarouselView.weighted).',
        ),
        _propertyRow(
          'attached',
          'bool',
          'True once the CarouselView mounts and registers its scroll '
              'position with the controller.  Reading offset/position before '
              'this happens throws a StateError.',
        ),
        _propertyRow(
          'position',
          'ScrollPosition',
          'The single attached ScrollPosition.  Useful for advanced '
              'introspection but not normally required.',
        ),
        _propertyRow(
          'animateToItem(index)',
          'Future<void>',
          'High-level helper that animates the carousel to the requested '
              'item index using the default carousel curve and duration.',
        ),
        _propertyRow(
          'jumpToItem(index)',
          'void',
          'Snap to the given item index without animation -- useful for '
              'restoring scroll state on rebuild.',
        ),
        _propertyRow(
          'nextItem / previousItem',
          'Future<void>',
          'Convenience wrappers that animate by exactly one item in the '
              'natural scroll direction.',
        ),
        _propertyRow(
          'dispose()',
          'void',
          'Releases the listener subscription.  Always call this from '
              'StatefulWidget.dispose().  This snapshot demo skips dispose '
              'because it never enters the framework lifecycle directly.',
        ),
      ],
    ),
  );
}

Widget _propertyRow(String name, String type, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: kCarnivalPlum,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: kCarnivalTeal,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: kCarnivalNight,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 4 :: Static carousel gallery.
//  Four CarouselView.weighted instances, each with its own controller and
//  its own initialItem -- live widgets in the snapshot.
// =============================================================================
Widget _buildStaticGallery() {
  _logSection('static-gallery');
  // Build four independent controllers so each carousel starts on a
  // different item without sharing state.
  final CarouselController c0 = CarouselController(initialItem: 0);
  final CarouselController c1 = CarouselController(initialItem: 1);
  final CarouselController c2 = CarouselController(initialItem: 2);
  final CarouselController c3 = CarouselController(initialItem: 3);

  return _card(
    title: 'Static gallery (4 controllers, 4 starting items)',
    accent: kCarnivalRose,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _galleryRow(c0, 'initialItem: 0', kCitrineGlow),
        const SizedBox(height: 12),
        _galleryRow(c1, 'initialItem: 1', kCarnivalCoral),
        const SizedBox(height: 12),
        _galleryRow(c2, 'initialItem: 2', kCarnivalMint),
        const SizedBox(height: 12),
        _galleryRow(c3, 'initialItem: 3', kCarnivalRose),
      ],
    ),
  );
}

Widget _galleryRow(CarouselController controller, String label, Color tone) {
  // Read controller.initialItem to surface it in the UI.  This is one of the
  // few things you can do safely *before* attach.
  final int initial = controller.initialItem;
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kCarnivalCream,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tone.withValues(alpha: 0.6), width: 1.5),
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
                color: tone,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: kCarnivalNight,
              ),
            ),
            const Spacer(),
            Text(
              'controller.initialItem == $initial',
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: kCarnivalPlum,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: CarouselView.weighted(
            controller: controller,
            flexWeights: const <int>[3, 2, 1],
            itemSnapping: true,
            children: _buildCarouselTiles(tone),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildCarouselTiles(Color baseTone) {
  // Real children for the carousel.  Different shades of the base tone make
  // the visible-item budget obvious at a glance.
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < 6; i++) {
    final double t = (i + 1) / 7.0;
    tiles.add(
      Container(
        decoration: BoxDecoration(
          color: Color.lerp(baseTone, kCarnivalNight, 1 - t) ?? baseTone,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          'item $i',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: kCarnivalCream,
          ),
        ),
      ),
    );
  }
  return tiles;
}

// =============================================================================
//  SECTION 5 :: Layout matrix -- itemSnapping x scrollDirection.
// =============================================================================
Widget _buildLayoutMatrix() {
  _logSection('layout-matrix');
  return _card(
    title: 'Layout matrix :: itemSnapping x scrollDirection',
    accent: kCarnivalPlum,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _matrixCell(
                title: 'snap=true, horizontal',
                snap: true,
                axis: Axis.horizontal,
                tone: kCitrineCore,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _matrixCell(
                title: 'snap=false, horizontal',
                snap: false,
                axis: Axis.horizontal,
                tone: kCarnivalCoral,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: _matrixCell(
                title: 'snap=true, vertical',
                snap: true,
                axis: Axis.vertical,
                tone: kCarnivalTeal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _matrixCell(
                title: 'snap=false, vertical',
                snap: false,
                axis: Axis.vertical,
                tone: kCarnivalMint,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _matrixCell({
  required String title,
  required bool snap,
  required Axis axis,
  required Color tone,
}) {
  // Each cell uses its own controller so the four cells truly are
  // independent.
  final CarouselController controller = CarouselController(initialItem: 0);
  final double height = axis == Axis.horizontal ? 100 : 200;
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tone, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: kCarnivalNight,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: height,
          child: CarouselView.weighted(
            controller: controller,
            flexWeights: const <int>[2, 1],
            itemSnapping: snap,
            scrollDirection: axis,
            children: _buildCarouselTiles(tone),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 6 :: Visible item budget diagram.
//  flexWeights = [3, 2, 1] -- visualised as color-coded boxes.
// =============================================================================
Widget _buildVisibleBudgetDiagram() {
  _logSection('visible-budget');
  return _card(
    title: 'Visible item budget :: flexWeights = [3, 2, 1]',
    accent: kCitrineDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _para(
          'CarouselView.weighted accepts a list of integer weights.  Together '
          'they describe how many "slots" of viewport width each visible item '
          'occupies.  The leading slot is the focused item, and the slots '
          'taper off so that items recede into the distance.',
        ),
        const SizedBox(height: 10),
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: kCarnivalCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kCitrineDeep.withValues(alpha: 0.4)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: <Widget>[
              Expanded(flex: 3, child: _budgetBox('3 -- focus', kCitrineCore)),
              const SizedBox(width: 6),
              Expanded(flex: 2, child: _budgetBox('2 -- next', kCarnivalCoral)),
              const SizedBox(width: 6),
              Expanded(
                flex: 1,
                child: _budgetBox('1 -- edge', kCarnivalTeal),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _para(
          'The sum of the weights (3+2+1 = 6) defines the total slot count '
          'visible at once.  CarouselController.animateToItem(2) would slide '
          'the third tile into the focus slot.',
        ),
      ],
    ),
  );
}

Widget _budgetBox(String label, Color tone) {
  return Container(
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: kCarnivalCream,
      ),
    ),
  );
}

// =============================================================================
//  SECTION 7 :: Constructor argument cards.
// =============================================================================
Widget _buildConstructorArguments() {
  _logSection('constructor-args');
  return _card(
    title: 'Constructor arguments at a glance',
    accent: kCarnivalCoral,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _argCard(
          name: 'itemExtent',
          domain: 'CarouselView()',
          summary:
              'Fixed pixel extent for every carousel child.  Mutually '
                  'exclusive with flexWeights.  Use when items are uniform.',
          tone: kCitrineCore,
        ),
        _argCard(
          name: 'flexWeights',
          domain: 'CarouselView.weighted()',
          summary:
              'List<int> describing the visible item budget.  The first '
                  'weight is the focused item; later weights are the trailing '
                  'preview items.',
          tone: kCarnivalRose,
        ),
        _argCard(
          name: 'itemSnapping',
          domain: 'all CarouselView constructors',
          summary:
              'When true, the carousel snaps to the nearest item on scroll '
                  'end.  Combine with controller.animateToItem for nicely '
                  'aligned programmatic transitions.',
          tone: kCarnivalTeal,
        ),
        _argCard(
          name: 'reverse',
          domain: 'all CarouselView constructors',
          summary:
              'Reverses the scroll direction.  initialItem still refers to '
                  'the same logical index; only the geometry flips.',
          tone: kCarnivalPlum,
        ),
        _argCard(
          name: 'scrollDirection',
          domain: 'all CarouselView constructors',
          summary:
              'Axis.horizontal (default) or Axis.vertical.  The controller '
                  'API is unchanged; pixel offsets simply move along the '
                  'chosen axis.',
          tone: kCitrineDeep,
        ),
        _argCard(
          name: 'shrinkExtent',
          domain: 'CarouselView()',
          summary:
              'Minimum extent an item shrinks to as it leaves the viewport.  '
                  'Smaller values produce a more dramatic "fold" effect.',
          tone: kCarnivalCoral,
        ),
      ],
    ),
  );
}

Widget _argCard({
  required String name,
  required String domain,
  required String summary,
  required Color tone,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: tone, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: kCarnivalNight,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                domain,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: kCarnivalNight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          summary,
          style: const TextStyle(
            fontSize: 13,
            height: 1.35,
            color: kCarnivalNight,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 8 :: DO / AVOID callouts.
// =============================================================================
Widget _buildDoAvoidCallouts() {
  _logSection('do-avoid');
  return _card(
    title: 'DO / AVOID',
    accent: kCarnivalTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _calloutRow(
          good:
              'DO construct one CarouselController per CarouselView and store '
                  'it on the State.',
          bad:
              'AVOID sharing a single CarouselController across multiple '
                  'CarouselView widgets -- ScrollControllers can attach to '
                  'one position only.',
        ),
        _calloutRow(
          good:
              'DO read controller.initialItem before attach if you need to '
                  'echo the planned starting index in your UI.',
          bad:
              'AVOID reading controller.offset or controller.position before '
                  'the carousel has mounted -- both throw StateError.',
        ),
        _calloutRow(
          good:
              'DO call animateToItem(index) for programmatic navigation.  '
                  'It accepts duration and curve overrides.',
          bad:
              'AVOID calling animateTo with hand-computed pixel offsets -- '
                  'snapping logic may fight you.',
        ),
        _calloutRow(
          good:
              'DO dispose() the controller from State.dispose() when you no '
                  'longer need it.',
          bad:
              'AVOID forgetting to dispose() -- it leaks the listener '
                  'subscription on every rebuild.',
        ),
        _calloutRow(
          good:
              'DO use itemSnapping: true when the carousel represents discrete '
                  'pages (e.g. a photo gallery).',
          bad:
              'AVOID itemSnapping with continuous content like a tickertape; '
                  'it produces choppy interactions.',
        ),
        _calloutRow(
          good:
              'DO use Axis.vertical for tall columns of cards on phones; the '
                  'controller API is identical.',
          bad:
              'AVOID switching scrollDirection at runtime; the position has '
                  'to recompute every offset.',
        ),
      ],
    ),
  );
}

Widget _calloutRow({required String good, required String bad}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _calloutBox(good, kCarnivalMint, 'DO')),
        const SizedBox(width: 8),
        Expanded(child: _calloutBox(bad, kCarnivalRose, 'AVOID')),
      ],
    ),
  );
}

Widget _calloutBox(String text, Color tone, String tag) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tone, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tag,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
            color: tone,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            height: 1.35,
            color: kCarnivalNight,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 9 :: Code-snippet recipe gallery.
// =============================================================================
Widget _buildCodeRecipes() {
  _logSection('code-recipes');
  return _card(
    title: 'Five canonical recipes',
    accent: kCarnivalPlum,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _codeBlock(
          title: '1. Basic uniform carousel',
          source: '''
final controller = CarouselController(initialItem: 0);

CarouselView(
  controller: controller,
  itemExtent: 280,
  shrinkExtent: 200,
  children: <Widget>[
    for (int i = 0; i < items.length; i++) _Card(items[i]),
  ],
);
''',
        ),
        _codeBlock(
          title: '2. Weighted carousel with focus + previews',
          source: '''
CarouselView.weighted(
  controller: controller,
  flexWeights: const <int>[3, 2, 1],
  itemSnapping: true,
  children: tiles,
);
''',
        ),
        _codeBlock(
          title: '3. Carousel with onTap callbacks',
          source: '''
CarouselView.weighted(
  controller: controller,
  flexWeights: const <int>[3, 2, 1],
  onTap: (int index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => DetailPage(index: index)),
    );
  },
  children: tiles,
);
''',
        ),
        _codeBlock(
          title: '4. Snapping vertical carousel',
          source: '''
CarouselView.weighted(
  controller: controller,
  flexWeights: const <int>[3, 2, 1],
  itemSnapping: true,
  scrollDirection: Axis.vertical,
  children: tiles,
);
''',
        ),
        _codeBlock(
          title: '5. Reversed carousel + animateToItem',
          source: '''
final controller = CarouselController(initialItem: 4);

CarouselView.weighted(
  controller: controller,
  flexWeights: const <int>[3, 2, 1],
  reverse: true,
  children: tiles,
);

// Later, in a callback:
controller.animateToItem(0);
''',
        ),
      ],
    ),
  );
}

Widget _codeBlock({required String title, required String source}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: kCarnivalNight,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: kCarnivalPlum,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: kCarnivalCream,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            source,
            style: const TextStyle(
              fontSize: 12,
              color: kCitrineGlow,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 10 :: Glossary.
// =============================================================================
Widget _buildGlossary() {
  _logSection('glossary');
  return _card(
    title: 'Glossary (12+ terms)',
    accent: kCarnivalMint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _glossaryEntry(
          'CarouselController',
          'ScrollController subclass with initialItem, animateToItem, and '
              'jumpToItem helpers.',
        ),
        _glossaryEntry(
          'CarouselView',
          'Material 3 carousel widget that lays its children out as a sliver.',
        ),
        _glossaryEntry(
          'CarouselView.weighted',
          'Constructor that accepts flexWeights describing the visible item '
              'budget.',
        ),
        _glossaryEntry(
          'flexWeights',
          'List<int> where each entry is one slot of viewport width.',
        ),
        _glossaryEntry(
          'itemExtent',
          'Fixed per-item extent for the default uniform carousel.',
        ),
        _glossaryEntry(
          'shrinkExtent',
          'Minimum extent an item shrinks to as it leaves the viewport.',
        ),
        _glossaryEntry(
          'itemSnapping',
          'When true, carousels snap to the nearest item on scroll end.',
        ),
        _glossaryEntry(
          'initialItem',
          'Item index used to compute the controller starting offset on '
              'first attach.',
        ),
        _glossaryEntry(
          'animateToItem',
          'Future-returning helper that animates to the given item index.',
        ),
        _glossaryEntry(
          'jumpToItem',
          'Synchronous variant of animateToItem with no animation.',
        ),
        _glossaryEntry(
          'attach / detach',
          'ScrollController lifecycle events fired when a CarouselView '
              'enters or leaves the tree.',
        ),
        _glossaryEntry(
          'scrollDirection',
          'Axis.horizontal (default) or Axis.vertical for the carousel '
              'layout.',
        ),
        _glossaryEntry(
          'reverse',
          'Flips the geometric direction without changing the logical item '
              'index.',
        ),
        _glossaryEntry(
          'onTap',
          'Per-item tap callback exposed by CarouselView.  Receives the '
              'tapped item index.',
        ),
      ],
    ),
  );
}

Widget _glossaryEntry(String term, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 13,
          color: kCarnivalNight,
          height: 1.4,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: '$term :: ',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: kCarnivalPlum,
              fontFamily: 'monospace',
            ),
          ),
          TextSpan(text: description),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 11 :: Recap footer.
// =============================================================================
Widget _buildRecapFooter() {
  _logSection('recap-footer');
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kCarnivalNight,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recap',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: kCitrineGlow,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'CarouselController is the ScrollController shaped for the Material '
          '3 CarouselView.  It carries a starting item index, supports '
          'animateToItem / jumpToItem, and lives one-per-CarouselView.  Wire '
          'it up in initState, dispose it in dispose, and let the snapshot '
          'demo above remind you of the visual contract.',
          style: TextStyle(
            fontSize: 13,
            height: 1.4,
            color: kCarnivalCream,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            _recapChip('Material 3'),
            _recapChip('weighted'),
            _recapChip('itemSnapping'),
            _recapChip('initialItem'),
            _recapChip('animateToItem'),
            _recapChip('Carnival Citrine'),
          ],
        ),
      ],
    ),
  );
}

Widget _recapChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: kCitrineCore.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kCitrineGlow, width: 1.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: kCitrineGlow,
      ),
    ),
  );
}

// =============================================================================
//  Shared helpers used across sections.
// =============================================================================
Widget _card({
  required String title,
  required Color accent,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border(left: BorderSide(color: accent, width: 6)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kCarnivalNight.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: kCarnivalNight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _para(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        height: 1.5,
        color: kCarnivalNight,
      ),
    ),
  );
}

// =============================================================================
//  EXTENDED APPENDIX :: CarouselController, in depth.
// =============================================================================
//
//  The body of this file already showed the visual snapshot.  This appendix
//  is a long-form reference that future maintainers can scroll through
//  without leaving the source.  It is intentionally rendered as comment
//  text -- the interpreter does not need to parse it -- yet it lives in
//  the same file so that the demo is fully self-contained.
//
//  -------------------------------------------------------------------
//  A1.  Lifecycle in detail
//  -------------------------------------------------------------------
//
//  Step 1 -- construction.  The application instantiates a CarouselController
//  with `CarouselController(initialItem: N)`.  At this point the controller
//  has no attached scroll position, so calls like `controller.position` or
//  `controller.offset` would throw `'ScrollController not attached'`.
//
//  Step 2 -- mounting.  A CarouselView (default, weighted, or uncontained)
//  is built somewhere in the tree.  The CarouselView creates a Scrollable
//  internally and registers its ScrollPosition with the supplied
//  controller.  This is the "attach" event.  After it, `controller.attached`
//  reports true and `controller.position` returns a usable
//  `ScrollPositionWithSingleContext`.
//
//  Step 3 -- first layout.  The carousel asks the controller "where should
//  I be?"  The controller answers with `initialItem`, which is converted
//  into a pixel offset (item-extent times index, or the cumulative weighted
//  offset for `CarouselView.weighted`).  The first frame therefore shows
//  the requested item already in the focus slot.
//
//  Step 4 -- user interaction.  The Scrollable forwards drag gestures to
//  the ScrollPosition.  When `itemSnapping` is true, the position uses a
//  carousel-aware physics object that snaps to the nearest item at the
//  end of every drag.
//
//  Step 5 -- programmatic interaction.  The application calls
//  `controller.animateToItem(index)`.  Internally this resolves the index
//  to a pixel offset and forwards the request to `position.animateTo(...)`
//  with the default carousel curve and duration.
//
//  Step 6 -- detach.  When the CarouselView is removed from the tree (page
//  pop, widget rebuild that drops the carousel), the position detaches
//  itself from the controller.  After detach, `controller.attached` is
//  false again and direct position access becomes unsafe.
//
//  Step 7 -- dispose.  When the owning State is disposed, the controller's
//  `dispose()` method must be called to release the listener subscription.
//  Forgetting this is a classic Flutter memory leak.
//
//  -------------------------------------------------------------------
//  A2.  Comparison with PageController
//  -------------------------------------------------------------------
//
//  CarouselController and PageController look superficially similar -- both
//  are ScrollController subclasses, both carry an "initial page/item", and
//  both expose programmatic navigation methods.  The differences:
//
//  *  PageController views one page at a time; CarouselView surfaces several
//     items in the same viewport via flexWeights or itemExtent.
//  *  PageController.animateToPage uses a Tween between page indices.
//     CarouselController.animateToItem operates in pixel space because
//     weighted carousels lack a uniform page extent.
//  *  PageController exposes `viewportFraction`; CarouselView replaces this
//     concept with `flexWeights` for weighted layouts and `shrinkExtent` for
//     uniform layouts.
//  *  PageController has been around since Flutter 1.x; CarouselController
//     ships with the Material 3 carousel introduced in 2024.
//
//  When porting a PageView-based experience to CarouselView, the typical
//  migration path is:
//    1.  Replace `PageView` with `CarouselView.weighted` and pick weights
//        that approximate the previous viewport fraction.
//    2.  Replace `PageController` with `CarouselController(initialItem: N)`.
//    3.  Replace `controller.animateToPage(...)` with
//        `controller.animateToItem(...)`.
//    4.  Re-evaluate any direct `controller.page` reads -- the carousel
//        does not surface a continuous page value.
//
//  -------------------------------------------------------------------
//  A3.  Common pitfalls and how to avoid them
//  -------------------------------------------------------------------
//
//  *  Pitfall: sharing a controller across two CarouselView widgets.  The
//     second attach throws because a ScrollController can only own one
//     position.  Fix: use a separate controller per carousel.
//
//  *  Pitfall: declaring the controller in build().  Each rebuild then
//     constructs a fresh controller, dropping any in-flight animation.
//     Fix: declare the controller as a final field on State and dispose
//     it in dispose().
//
//  *  Pitfall: assuming `controller.offset` reflects the focused item
//     index.  It is a pixel value.  Use `(offset / itemExtent).round()` for
//     uniform carousels, or compute the cumulative weighted offset for
//     `CarouselView.weighted`.
//
//  *  Pitfall: calling `animateToItem` before the carousel mounts.  The
//     call no-ops or throws depending on Flutter version.  Fix: call from
//     a post-frame callback or from a user gesture that happens after the
//     first frame.
//
//  *  Pitfall: assuming `nextItem`/`previousItem` wrap around.  They do
//     not -- they delegate to `animateTo` and clamp at the edges.  Fix:
//     wrap your navigation logic to mod the index against the item count.
//
//  *  Pitfall: combining `itemSnapping: false` with custom animateToItem
//     calls.  The carousel will animate to the requested item but the user
//     can drift away on the next gesture.  Fix: choose a snapping policy
//     consistently for the whole carousel.
//
//  -------------------------------------------------------------------
//  A4.  Mental model -- the carousel as a sliver
//  -------------------------------------------------------------------
//
//  Internally CarouselView is implemented as a sliver inside a custom
//  Scrollable.  This means everything you know about slivers applies:
//
//  *  Scroll physics can be customised via the host Scrollable.
//  *  ScrollNotifications fire normally and can be intercepted with a
//     NotificationListener<ScrollNotification>.
//  *  The carousel respects PrimaryScrollController inheritance, so if you
//     leave `controller` null inside a single-Scrollable page, the carousel
//     will attach to the primary controller.  This is rarely what you
//     want; pass an explicit CarouselController for predictability.
//  *  Because the layout is sliver-based, the carousel can live alongside
//     other slivers in a CustomScrollView -- but in practice this is
//     uncommon, and the standard pattern is to host the CarouselView
//     inside a SizedBox.
//
//  -------------------------------------------------------------------
//  A5.  Performance considerations
//  -------------------------------------------------------------------
//
//  *  CarouselView builds all of its children at construction time when
//     given the `children: <Widget>[...]` parameter.  For long lists this
//     can be expensive.  Use `CarouselView.builder` (where available) for
//     lazily-built children.
//  *  Each rebuild that swaps the children list re-runs the carousel's
//     layout pass.  Stable keys help Flutter reuse RenderObjects.
//  *  Animations driven by `animateToItem` run on the platform thread by
//     default; combining many simultaneous animations can starve the
//     raster thread.  Spread programmatic navigation across frames using
//     `Future.delayed` if necessary.
//  *  Avoid wrapping each carousel item in a Material widget if you don't
//     need ink effects -- a plain Container with a BoxDecoration is much
//     cheaper.
//
//  -------------------------------------------------------------------
//  A6.  Accessibility checklist
//  -------------------------------------------------------------------
//
//  *  Each carousel child should be wrapped in a Semantics node that
//     describes its content.  Screen readers otherwise announce only the
//     position within the scrollable.
//  *  When using `CarouselView` with `onTap`, ensure the action is also
//     reachable via keyboard (e.g. by wrapping the child in InkWell + a
//     Focus node).
//  *  Provide a logical label for the carousel itself -- "Featured
//     products", "Recent photos", etc. -- via Semantics.label.
//  *  Honor `MediaQuery.of(context).disableAnimations`; when true, replace
//     `animateToItem` with `jumpToItem` to respect user preferences.
//  *  Make sure the visible item budget always shows at least one fully
//     visible item.  Carousels where every item is partially clipped are
//     hostile to users with low vision.
//
//  -------------------------------------------------------------------
//  A7.  Testing recommendations
//  -------------------------------------------------------------------
//
//  *  Unit tests can construct a CarouselController and verify that
//     `controller.initialItem` matches the constructor argument.  This is
//     useful for regression-testing controller wiring code.
//  *  Widget tests should pump a CarouselView, await the first frame, then
//     assert that the focused tile matches the controller's initialItem.
//     Use `find.byType(CarouselView)` and the `WidgetTester.drag(...)`
//     helper to simulate user gestures.
//  *  Integration tests can drive the carousel programmatically via
//     `controller.animateToItem(index)` followed by
//     `await tester.pumpAndSettle()`.  Snapshot the resulting frame and
//     compare against a golden image to catch visual regressions.
//  *  When the carousel is part of a larger Scaffold, prefer
//     `find.descendant(of: find.byType(CarouselView), matching: ...)` to
//     scope your finders.
//
//  -------------------------------------------------------------------
//  A8.  Closing remarks
//  -------------------------------------------------------------------
//
//  CarouselController is a small but powerful piece of the Material 3
//  toolkit.  Its API surface is intentionally minimal -- a constructor, a
//  starting index, and three navigation helpers -- but the constraints it
//  imposes (single attached position, lifecycle-bound dispose) make it a
//  precise tool for building carousel-driven experiences.
//
//  Treat this file as a living tour: every visual section has prose to
//  accompany it, every prose paragraph has a corresponding visual element,
//  and every code recipe has been distilled from real-world usage.  When
//  the next maintainer arrives, they should be able to read top-to-bottom
//  and emerge with a working mental model of CarouselController without
//  consulting any external documentation.
//
//  Carnival lights stay on, citrine glows warm, and the carousel keeps
//  spinning.
//
// =============================================================================
//  END OF FILE -- CarouselController :: Carnival Citrine
//
//  Final notes for future maintainers
//  ----------------------------------
//  *  This file deliberately exceeds 1500 lines so every facet of the
//     CarouselController API has a home: prose, properties, snapshot
//     gallery, layout matrix, weighted budget diagram, constructor cards,
//     do/avoid rules, code recipes, glossary, recap.
//  *  Do NOT introduce StatefulWidget here.  The d4rt interpreter that
//     consumes this file does not implement setState semantics.  Instead,
//     prefer additional _card() blocks and prose to expand the demo.
//  *  When adding new CarouselView widgets, always construct a fresh
//     CarouselController with an explicit initialItem.  Reusing a
//     controller across two carousels will throw at attach time.
//  *  When adding new colors, extend kPalette and kPaletteNames in lockstep
//     so the swatch strip in section 1 stays accurate.
//  *  When adding new code recipes, prefer the _codeBlock() helper -- it
//     keeps formatting consistent and avoids stray syntax highlighters.
//  *  When adding new glossary entries, keep the term short (one or two
//     words) and the description focused on a single, observable behavior.
//  *  Animations and runtime navigation are NOT demonstrated here on
//     purpose: they require a stateful host that can invoke
//     controller.animateToItem(...) at the right point in the widget
//     lifecycle.  Instead, the recipe gallery shows the call shapes the
//     reader is expected to copy into their own StatefulWidget.
//  *  If you need to demonstrate an animation, do it in a *separate* file
//     that uses StatefulWidget under the regular Flutter test harness.
//  *  Always prefer Color.withValues(alpha: ...) to Color.withOpacity(...).
//     The latter is deprecated and the lint at the top of the file only
//     suppresses warnings, not the conceptual debt.
//  *  Keep palette tones inside the Carnival Citrine family.  Mixing in
//     unrelated hues defeats the "single coherent demo" goal.
//  *  The narrative print() calls at the top of build() are intentional;
//     they make the file easy to follow when executed under d4rt with
//     stdout enabled.
//  *  Section ordering is load-bearing: the visual rhythm goes from
//     overview to anatomy to live snapshots to layout details to written
//     guidance to code recipes to a glossary.  If you add new sections,
//     slot them in with consistent spacing and a leading _card() title.
//  *  Avoid embedding Image or Network widgets here -- they would force
//     the snapshot to depend on assets that are not available inside the
//     interpreter.
//  *  Avoid relying on MediaQuery for sizing.  The demo aims to look the
//     same regardless of host viewport, which is why every fixed dimension
//     is expressed as a literal SizedBox or itemExtent.
//  *  No generic types beyond what dart:core or flutter/material exposes.
//     The interpreter does not support arbitrary user-defined generics.
//  *  No closures over a CarouselController are stored beyond the local
//     scope of their _matrixCell or _galleryRow factory.  This keeps the
//     ownership model obvious: the widget tree owns the controller for
//     the duration of the snapshot.
// =============================================================================
