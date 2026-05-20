// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import

// =====================================================================
// sizing_test.dart
// ---------------------------------------------------------------------
// Deep dive into Flutter's WIDGET SIZING toolbox.
//
// Flutter's layout pipeline runs in two passes:
//   1. Constraints flow DOWN the tree (parent -> child).
//      A parent says "you may be between minWidth..maxWidth wide and
//      minHeight..maxHeight tall".
//   2. Sizes flow UP the tree (child -> parent).
//      The child picks a Size that satisfies the constraints and
//      reports back. The parent then positions it.
//
// This file walks through the sizing widgets that participate in (or
// modify) that conversation:
//
//   * BoxConstraints           -- the actual contract object.
//   * ConstrainedBox           -- tighten or loosen a child's contract.
//   * UnconstrainedBox         -- strip the parent's contract entirely.
//   * LimitedBox               -- only constrain when parent is unbounded.
//   * OverflowBox              -- let the child be larger than allowed.
//   * SizedBox / .fromSize     -- ask for an exact Size.
//   * IntrinsicWidth/Height    -- "use the child's natural width".
//   * FittedBox                -- scale a child to fit a slot.
//   * AspectRatio              -- pick a size that obeys w/h ratio.
//   * FractionallySizedBox     -- size proportionally to parent.
//
// Theme: BLUEPRINT / ARCHITECTURAL DRAFTING.
// Cream paper, drafting-blue ink, ruler-gray lines, blueprint-cyan
// gradients. Every gallery card looks like a small drafted plate.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------
// Color palette: blueprint / architectural drafting room.
// ---------------------------------------------------------------------
const Color _kPaperCream = Color(0xFFF5EFD8);
const Color _kPaperDeep = Color(0xFFE8DDB7);
const Color _kInkBlue = Color(0xFF143A70);
const Color _kInkDeep = Color(0xFF0B214A);
const Color _kBlueprintCyan = Color(0xFF1E6FB8);
const Color _kBlueprintLight = Color(0xFF74B6E5);
const Color _kRulerGray = Color(0xFF6B6B6B);
const Color _kPencilGraphite = Color(0xFF2E2E2E);
const Color _kAccentRust = Color(0xFFB05A2C);
const Color _kAccentMoss = Color(0xFF4F6B3A);
const Color _kAccentSepia = Color(0xFF7A5230);
const Color _kGridFaint = Color(0x331E6FB8);

// =====================================================================
// ENTRY POINT
// =====================================================================
dynamic build(BuildContext context) {
  print('==========================================================');
  print(' sizing_test.dart -- Flutter sizing widget tour');
  print(' Theme: blueprint / architectural drafting room');
  print('==========================================================');

  // Anchor BoxConstraints we will reference throughout the tour.
  final BoxConstraints anchorTight = BoxConstraints.tight(const Size(120, 80));
  final BoxConstraints anchorLoose = BoxConstraints.loose(const Size(240, 160));
  final BoxConstraints anchorExpand = const BoxConstraints.expand();
  final BoxConstraints anchorTightForFinite =
      BoxConstraints.tightForFinite(width: 200);

  print('--- Anchor constraints constructed ---');
  print('tight   = $anchorTight');
  print('loose   = $anchorLoose');
  print('expand  = $anchorExpand');
  print('tightFF = $anchorTightForFinite');

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #133, P2):
  // Page root packs 10 themed sections (anchors + banner + anatomy +
  // 7 galleries + cheat-sheet) into a Container > Column(stretch, min)
  // with combined intrinsic height ≈ 3525 px > desktop test viewport,
  // firing "A RenderFlex overflowed by 3525 pixels on the bottom."
  // Fix: wrap the Column in SingleChildScrollView; the cream-paper
  // Container stays *outside* so the architectural backdrop fills the
  // whole viewport, not just the scrolled content; the inner padding
  // moves onto the SCV so the page-edge inset is preserved.
  // (The plan label included P1, but the only Row(crossAxisAlignment
  // .stretch) site at line 737 is already wrapped in IntrinsicHeight,
  // so P1 doesn't materialise. P2 alone clears the assertion.)
  return Container(
    color: _kPaperCream,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _section0Anchors(anchorTight, anchorLoose, anchorExpand,
              anchorTightForFinite),
          const SizedBox(height: 28),
          _section1Banner(),
          const SizedBox(height: 28),
          _section2Anatomy(anchorTight),
          const SizedBox(height: 28),
          _section3ConstrainedBoxGallery(),
          const SizedBox(height: 28),
          _section4IntrinsicComparison(),
          const SizedBox(height: 28),
          _section5FittedBoxGallery(),
          const SizedBox(height: 28),
          _section6AspectRatioGallery(),
          const SizedBox(height: 28),
          _section7FractionallySized(),
          const SizedBox(height: 28),
          _section8OverflowAndUnconstrained(),
          const SizedBox(height: 28),
          _section9CheatSheet(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// =====================================================================
// SECTION 0: ANCHOR BOXCONSTRAINTS INSTANCES
// ---------------------------------------------------------------------
// We construct several BoxConstraints with the four named constructors
// and dump every introspection getter to the console. This is the
// single best way to learn the BoxConstraints API.
// =====================================================================
Widget _section0Anchors(
  BoxConstraints tight,
  BoxConstraints loose,
  BoxConstraints expand,
  BoxConstraints tightFF,
) {
  print('=== Section 0: BoxConstraints anchors ===');
  print('Inspecting tight  ----------');
  _dumpConstraints('tight', tight);
  print('Inspecting loose  ----------');
  _dumpConstraints('loose', loose);
  print('Inspecting expand ----------');
  _dumpConstraints('expand', expand);
  print('Inspecting tightFF ---------');
  _dumpConstraints('tightFF', tightFF);

  return _platePanel(
    title: '0. BoxConstraints anchors',
    subtitle: 'Four ways to spell a sizing contract',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _constraintRow('tight  ', tight),
        const SizedBox(height: 8),
        _constraintRow('loose  ', loose),
        const SizedBox(height: 8),
        _constraintRow('expand ', expand),
        const SizedBox(height: 8),
        _constraintRow('tightFF', tightFF),
      ],
    ),
  );
}

void _dumpConstraints(String label, BoxConstraints c) {
  print('  [$label] minWidth          = ${c.minWidth}');
  print('  [$label] maxWidth          = ${c.maxWidth}');
  print('  [$label] minHeight         = ${c.minHeight}');
  print('  [$label] maxHeight         = ${c.maxHeight}');
  print('  [$label] biggest           = ${c.biggest}');
  print('  [$label] smallest          = ${c.smallest}');
  print('  [$label] isTight           = ${c.isTight}');
  print('  [$label] hasBoundedWidth   = ${c.hasBoundedWidth}');
  print('  [$label] hasBoundedHeight  = ${c.hasBoundedHeight}');
  print('  [$label] hasInfiniteWidth  = ${c.hasInfiniteWidth}');
  print('  [$label] hasInfiniteHeight = ${c.hasInfiniteHeight}');
  print('  [$label] isNormalized      = ${c.isNormalized}');
}

Widget _constraintRow(String tag, BoxConstraints c) {
  // We render the constraint's textual fingerprint in a monospaced
  // pill so it reads like an engineering callout.
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _kPaperDeep,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kInkBlue, width: 1),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kInkBlue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: _kPaperCream,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'min=(${c.minWidth.toStringAsFixed(1)},${c.minHeight.toStringAsFixed(1)})  '
            'max=(${_pp(c.maxWidth)},${_pp(c.maxHeight)})  '
            'tight=${c.isTight}  norm=${c.isNormalized}',
            style: const TextStyle(
              color: _kPencilGraphite,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

String _pp(double v) {
  if (v == double.infinity) return 'inf';
  return v.toStringAsFixed(1);
}

// =====================================================================
// SECTION 1: TITLE BANNER
// ---------------------------------------------------------------------
// A wide drafting-paper banner with a blueprint-cyan gradient bar at
// the bottom. Built with Stack / Positioned to demonstrate one
// non-trivial composition before we get into the sizing widgets.
// =====================================================================
Widget _section1Banner() {
  print('=== Section 1: Title banner ===');
  print('Banner uses Stack + Positioned + LinearGradient.');
  print('Outer height fixed at 160. Inner gradient bar 18.');
  print('Border doubled to look like a drafting plate.');

  return Container(
    height: 160,
    decoration: BoxDecoration(
      color: _kPaperCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlue, width: 2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55143A70),
          offset: Offset(0, 6),
          blurRadius: 14,
          spreadRadius: 0,
        ),
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kPaperCream, _kPaperDeep],
      ),
    ),
    child: Stack(
      children: <Widget>[
        // Faint grid overlay (decorative).
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  _kGridFaint,
                  _kPaperCream.withOpacity(0),
                  _kGridFaint,
                ],
                stops: const <double>[0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        // Title text.
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'PLATE 01 -- SIZING WIDGETS',
                style: TextStyle(
                  color: _kInkDeep,
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Constraints, Intrinsics, Fits & Aspects',
                style: TextStyle(
                  color: _kInkBlue,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'A drafted tour through Flutter\'s sizing toolbox.',
                style: TextStyle(
                  color: _kPencilGraphite.withOpacity(0.85),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        // Bottom blueprint bar.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 18,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  _kInkDeep,
                  _kBlueprintCyan,
                  _kBlueprintLight,
                  _kBlueprintCyan,
                  _kInkDeep,
                ],
                stops: <double>[0.0, 0.3, 0.5, 0.7, 1.0],
              ),
            ),
          ),
        ),
        // Plate corner marker.
        Positioned(
          right: 14,
          top: 14,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _kInkBlue,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x88143A70),
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              '01',
              style: TextStyle(
                color: _kPaperCream,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 2: ANATOMY DIAGRAM
// ---------------------------------------------------------------------
// Show the flow:  Parent -> Constraints -> Child -> Size -> Parent.
// Five boxes wired in a row. Each box is a labelled drafting card.
// =====================================================================
Widget _section2Anatomy(BoxConstraints anchor) {
  print('=== Section 2: Anatomy of a layout pass ===');
  print('Anchor used in diagram: $anchor');
  print('Pipeline = Parent -> Constraints -> Child -> Size -> Parent.');
  print('Each node rendered as a small plate with a directional arrow.');

  final List<_Node> nodes = <_Node>[
    _Node('Parent', 'asks for layout', _kInkBlue, _kPaperCream),
    _Node('Constraints', 'min..max box', _kBlueprintCyan, _kPaperCream),
    _Node('Child', 'picks a size', _kAccentMoss, _kPaperCream),
    _Node('Size', 'reports back', _kAccentRust, _kPaperCream),
    _Node('Parent', 'positions child', _kInkDeep, _kPaperCream),
  ];

  return _platePanel(
    title: '2. Anatomy of a layout pass',
    subtitle: 'Constraints flow down, sizes flow up.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 110,
          child: Row(
            children: <Widget>[
              _anatomyNode(nodes[0]),
              _anatomyArrow('down'),
              _anatomyNode(nodes[1]),
              _anatomyArrow('down'),
              _anatomyNode(nodes[2]),
              _anatomyArrow('up'),
              _anatomyNode(nodes[3]),
              _anatomyArrow('up'),
              _anatomyNode(nodes[4]),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPaperDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kRulerGray),
          ),
          child: Text(
            'Anchor: minW=${anchor.minWidth}  maxW=${anchor.maxWidth}  '
            'minH=${anchor.minHeight}  maxH=${anchor.maxHeight}\n'
            'isTight=${anchor.isTight}  isNormalized=${anchor.isNormalized}',
            style: const TextStyle(
              color: _kPencilGraphite,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyNode(_Node n) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: n.bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kInkDeep, width: 1.4),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(2, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              n.title,
              style: TextStyle(
                color: n.fg,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              n.subtitle,
              style: TextStyle(
                color: n.fg.withOpacity(0.85),
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _anatomyArrow(String direction) {
  final IconData icon =
      direction == 'down' ? Icons.arrow_forward : Icons.arrow_back;
  final Color color = direction == 'down' ? _kInkBlue : _kAccentRust;
  return SizedBox(
    width: 28,
    child: Center(
      child: Icon(icon, color: color, size: 22),
    ),
  );
}

class _Node {
  final String title;
  final String subtitle;
  final Color bg;
  final Color fg;
  const _Node(this.title, this.subtitle, this.bg, this.fg);
}

// =====================================================================
// SECTION 3: CONSTRAINEDBOX GALLERY
// ---------------------------------------------------------------------
// Six cards. Each wraps the same colored child in a different
// ConstrainedBox. We caption the constraints used.
// =====================================================================
Widget _section3ConstrainedBoxGallery() {
  print('=== Section 3: ConstrainedBox gallery ===');

  final List<_CGItem> items = <_CGItem>[
    _CGItem(
      'minWidth 60',
      const BoxConstraints(minWidth: 60),
      _kAccentRust,
    ),
    _CGItem(
      'minWidth 140',
      const BoxConstraints(minWidth: 140),
      _kAccentMoss,
    ),
    _CGItem(
      'minHeight 60',
      const BoxConstraints(minHeight: 60),
      _kBlueprintCyan,
    ),
    _CGItem(
      'maxWidth 80',
      const BoxConstraints(maxWidth: 80),
      _kInkBlue,
    ),
    _CGItem(
      'tight 100x40',
      BoxConstraints.tight(const Size(100, 40)),
      _kAccentSepia,
    ),
    _CGItem(
      'expand h=60',
      const BoxConstraints.expand(height: 60),
      _kPencilGraphite,
    ),
  ];

  print('Building ${items.length} ConstrainedBox cards.');
  for (var i = 0; i < items.length; i++) {
    print(
        '  card[$i] label=${items[i].label}  constraints=${items[i].constraints}');
  }

  final List<Widget> cards = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    cards.add(_constrainedCard(items[i], i));
  }

  return _platePanel(
    title: '3. ConstrainedBox gallery',
    subtitle: 'Same child, six different contracts.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: cards,
    ),
  );
}

class _CGItem {
  final String label;
  final BoxConstraints constraints;
  final Color color;
  const _CGItem(this.label, this.constraints, this.color);
}

Widget _constrainedCard(_CGItem item, int index) {
  // We size the card to a fixed 220x150 frame so the wrap lines up.
  return Container(
    width: 220,
    height: 150,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPaperCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlue, width: 1.2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33143A70),
          blurRadius: 6,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: _kInkBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: const TextStyle(
                  color: _kPaperCream,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(
                  color: _kInkDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _kPaperDeep,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kRulerGray, width: 0.8),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: item.constraints,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      item.color,
                      item.color.withOpacity(0.55),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: item.color.withOpacity(0.45),
                      blurRadius: 4,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6),
                child: const Text(
                  'child',
                  style: TextStyle(
                    color: _kPaperCream,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 4: INTRINSIC WIDTH/HEIGHT
// ---------------------------------------------------------------------
// Two side-by-side rows of three buttons. The left row is wrapped in
// IntrinsicWidth so all three buttons share the widest natural width.
// The right row is left to its own devices for comparison.
// =====================================================================
Widget _section4IntrinsicComparison() {
  print('=== Section 4: IntrinsicWidth / IntrinsicHeight ===');
  print('Left  column: IntrinsicWidth -> all rows share widest button.');
  print('Right column: no intrinsic   -> rows take their own width.');
  print('IntrinsicWidth is O(N^2)-ish, use sparingly in production.');

  final List<String> labels = <String>['SAVE', 'EXPORT TO PDF', 'OK'];

  // Build left side intrinsic-width rows.
  final List<Widget> leftRows = <Widget>[];
  for (var i = 0; i < labels.length; i++) {
    leftRows.add(_intrinsicButtonRow(labels[i], _kBlueprintCyan, i));
    if (i != labels.length - 1) {
      leftRows.add(const SizedBox(height: 8));
    }
  }

  // Right side -- same buttons but no intrinsic width.
  final List<Widget> rightRows = <Widget>[];
  for (var i = 0; i < labels.length; i++) {
    rightRows.add(_plainButton(labels[i], _kAccentRust));
    if (i != labels.length - 1) {
      rightRows.add(const SizedBox(height: 8));
    }
  }

  return _platePanel(
    title: '4. IntrinsicWidth vs natural width',
    subtitle: 'Make a row of buttons line up by their widest member.',
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'IntrinsicWidth -- aligned',
                style: TextStyle(
                  color: _kInkDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: leftRows,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'IntrinsicHeight row',
                style: TextStyle(
                  color: _kInkDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _intrinsicCell('Short', 0, _kBlueprintCyan),
                    const SizedBox(width: 6),
                    _intrinsicCell(
                        'Medium-ish content goes here for height',
                        1,
                        _kAccentMoss),
                    const SizedBox(width: 6),
                    _intrinsicCell('Tiny', 2, _kAccentRust),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'No intrinsic -- ragged',
                style: TextStyle(
                  color: _kInkDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rightRows,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _intrinsicButtonRow(String label, Color color, int idx) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color, color.withOpacity(0.6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.5),
          blurRadius: 4,
          offset: const Offset(1, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        color: _kPaperCream,
        fontSize: 12,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget _plainButton(String label, Color color) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _kPaperCream,
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

Widget _intrinsicCell(String text, int idx, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 5: FITTEDBOX GALLERY
// ---------------------------------------------------------------------
// Build a wrap of identical "200x80" content rendered into a fixed
// 130x90 slot, each with a different BoxFit.
// =====================================================================
Widget _section5FittedBoxGallery() {
  print('=== Section 5: FittedBox / BoxFit gallery ===');

  final List<BoxFit> fits = <BoxFit>[
    BoxFit.fill,
    BoxFit.contain,
    BoxFit.cover,
    BoxFit.fitWidth,
    BoxFit.fitHeight,
    BoxFit.none,
    BoxFit.scaleDown,
  ];

  print('Rendering ${fits.length} BoxFit cards in a Wrap.');
  for (var i = 0; i < fits.length; i++) {
    print('  fit[$i] = ${fits[i]}');
  }

  final List<Widget> cards = <Widget>[];
  for (var i = 0; i < fits.length; i++) {
    cards.add(_fittedCard(fits[i], i));
  }

  return _platePanel(
    title: '5. FittedBox -- every BoxFit',
    subtitle: 'Same 200x80 banner squeezed into a 130x90 slot.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: cards,
    ),
  );
}

Widget _fittedCard(BoxFit fit, int idx) {
  return Container(
    width: 160,
    height: 150,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kPaperCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlue, width: 1.2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33143A70),
          blurRadius: 5,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'BoxFit.${fit.toString().split('.').last}',
          style: const TextStyle(
            color: _kInkDeep,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _kPaperDeep,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kRulerGray),
            ),
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 130,
                height: 90,
                child: FittedBox(
                  fit: fit,
                  alignment: Alignment.center,
                  child: _fittedSampleBanner(idx),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fittedSampleBanner(int idx) {
  // The sample child is intentionally 200x80 -- larger than the 130x90
  // viewport so each BoxFit yields a visibly different result.
  return Container(
    width: 200,
    height: 80,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kBlueprintCyan,
          _kInkBlue,
          _kBlueprintLight,
        ],
        stops: <double>[0.0, 0.5, 1.0],
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66143A70),
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      '200x80 #$idx',
      style: const TextStyle(
        color: _kPaperCream,
        fontSize: 16,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

// =====================================================================
// SECTION 6: ASPECTRATIO GALLERY
// ---------------------------------------------------------------------
// Six cards each driven by AspectRatio. Useful when you have a flexible
// width and want height to follow.
// =====================================================================
Widget _section6AspectRatioGallery() {
  print('=== Section 6: AspectRatio gallery ===');

  final List<_ARItem> items = <_ARItem>[
    _ARItem('1:1 square', 1.0, _kAccentRust),
    _ARItem('16:9 widescreen', 16.0 / 9.0, _kBlueprintCyan),
    _ARItem('4:3 classic', 4.0 / 3.0, _kAccentMoss),
    _ARItem('3:4 portrait', 3.0 / 4.0, _kAccentSepia),
    _ARItem('21:9 ultra', 21.0 / 9.0, _kInkBlue),
    _ARItem('2:3 photo', 2.0 / 3.0, _kPencilGraphite),
  ];

  print('Rendering ${items.length} aspect ratio cards.');
  for (var i = 0; i < items.length; i++) {
    print('  ar[$i] = ${items[i].label} -> ${items[i].ratio}');
  }

  final List<Widget> cells = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    cells.add(_aspectCard(items[i]));
  }

  return _platePanel(
    title: '6. AspectRatio gallery',
    subtitle: 'Width is given; height is computed.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: cells,
    ),
  );
}

class _ARItem {
  final String label;
  final double ratio;
  final Color color;
  const _ARItem(this.label, this.ratio, this.color);
}

Widget _aspectCard(_ARItem item) {
  return Container(
    width: 220,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPaperCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlue, width: 1.2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33143A70),
          blurRadius: 5,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          item.label,
          style: const TextStyle(
            color: _kInkDeep,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'ratio = ${item.ratio.toStringAsFixed(3)}',
          style: const TextStyle(
            color: _kRulerGray,
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: item.ratio,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[
                  item.color.withOpacity(0.95),
                  item.color.withOpacity(0.55),
                ],
                radius: 0.9,
              ),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kInkDeep, width: 1),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: item.color.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              item.label,
              style: const TextStyle(
                color: _kPaperCream,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 7: FRACTIONALLY SIZED BOX
// ---------------------------------------------------------------------
// Show a horizontal bar where children claim 0.25, 0.5, 0.75, 1.0 of
// the parent's width with FractionallySizedBox -- and a similar height
// example.
// =====================================================================
Widget _section7FractionallySized() {
  print('=== Section 7: FractionallySizedBox ===');
  print('Children request width as a fraction of the parent slot.');

  final List<double> fractions = <double>[0.25, 0.5, 0.75, 1.0];

  final List<Widget> rows = <Widget>[];
  for (var i = 0; i < fractions.length; i++) {
    rows.add(_fractionRow(fractions[i], i));
    rows.add(const SizedBox(height: 10));
  }

  print('Built ${fractions.length} fractional rows.');

  return _platePanel(
    title: '7. FractionallySizedBox',
    subtitle: 'Width factor expressed as a fraction of the parent.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        rows[0], rows[1], rows[2], rows[3], rows[4], rows[5], rows[6], rows[7],
        const SizedBox(height: 6),
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: _kPaperDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kRulerGray),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.3,
                    widthFactor: 0.9,
                    child: _bar(_kAccentRust, '30%'),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    widthFactor: 0.9,
                    child: _bar(_kBlueprintCyan, '60%'),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.85,
                    widthFactor: 0.9,
                    child: _bar(_kAccentMoss, '85%'),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 1.0,
                    widthFactor: 0.9,
                    child: _bar(_kInkBlue, '100%'),
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

Widget _fractionRow(double f, int idx) {
  return Container(
    height: 28,
    decoration: BoxDecoration(
      color: _kPaperDeep,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _kRulerGray),
    ),
    padding: const EdgeInsets.all(3),
    child: Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: f,
        heightFactor: 1.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[
                _kBlueprintCyan,
                _kInkBlue,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x44143A70),
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'widthFactor = ${f.toStringAsFixed(2)}',
            style: const TextStyle(
              color: _kPaperCream,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _bar(Color color, String label) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          color.withOpacity(0.95),
          color.withOpacity(0.6),
        ],
      ),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.55),
          blurRadius: 5,
          offset: const Offset(1, 2),
        ),
      ],
    ),
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      label,
      style: const TextStyle(
        color: _kPaperCream,
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

// =====================================================================
// SECTION 8: OVERFLOWBOX + UNCONSTRAINEDBOX
// ---------------------------------------------------------------------
// We give a parent a small fixed slot (180x80) and show three children:
//   a) Plain Container -- clamps to the slot.
//   b) OverflowBox     -- can render larger than its parent's box.
//   c) UnconstrainedBox -- removes constraints and reports child's size.
// =====================================================================
Widget _section8OverflowAndUnconstrained() {
  print('=== Section 8: OverflowBox & UnconstrainedBox ===');
  print('Parent slot: 180x80.');
  print('OverflowBox      -> child renders 240x110 visually.');
  print('UnconstrainedBox -> child uses its own width.');
  print('LimitedBox       -> only kicks in for unbounded parents.');

  return _platePanel(
    title: '8. Constraint relaxation',
    subtitle: 'OverflowBox and UnconstrainedBox break the contract on purpose.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'a) Plain ConstrainedBox (clamped):',
          style: TextStyle(
            color: _kInkDeep,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        _slotFrame(
          child: SizedBox.fromSize(
            size: const Size(240, 110),
            child: _slotChild('clamped', _kAccentRust),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'b) OverflowBox (visually overflows the slot):',
          style: TextStyle(
            color: _kInkDeep,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        _slotFrame(
          child: OverflowBox(
            minWidth: 0,
            minHeight: 0,
            maxWidth: 360,
            maxHeight: 220,
            alignment: Alignment.center,
            child: SizedBox.fromSize(
              size: const Size(240, 110),
              child: _slotChild('OverflowBox', _kBlueprintCyan),
            ),
          ),
          clip: false,
        ),
        const SizedBox(height: 16),
        const Text(
          'c) UnconstrainedBox (parent constraints discarded):',
          style: TextStyle(
            color: _kInkDeep,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kPaperDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kRulerGray),
          ),
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: SizedBox.fromSize(
              size: const Size(260, 70),
              child: _slotChild('UnconstrainedBox', _kAccentMoss),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'd) LimitedBox (only kicks in for unbounded parents):',
          style: TextStyle(
            color: _kInkDeep,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kPaperDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kRulerGray),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: LimitedBox(
              maxWidth: 200,
              maxHeight: 60,
              child: _slotChild('LimitedBox', _kAccentSepia),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _slotFrame({required Widget child, bool clip = true}) {
  final Widget framed = Container(
    width: 180,
    height: 80,
    decoration: BoxDecoration(
      color: _kPaperDeep,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kRulerGray, width: 1.2),
    ),
    alignment: Alignment.center,
    child: child,
  );
  if (clip) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: framed,
    );
  }
  return framed;
}

Widget _slotChild(String label, Color color) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          color,
          color.withOpacity(0.55),
        ],
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.45),
          blurRadius: 6,
          offset: const Offset(2, 3),
        ),
      ],
    ),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Text(
      label,
      style: const TextStyle(
        color: _kPaperCream,
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.1,
      ),
    ),
  );
}

// =====================================================================
// SECTION 9: CHEAT SHEET
// ---------------------------------------------------------------------
// One panel listing every sizing widget covered in this file with a
// short "use this when..." sentence.
// =====================================================================
Widget _section9CheatSheet() {
  print('=== Section 9: Cheat sheet ===');

  final List<_CheatRow> rows = <_CheatRow>[
    _CheatRow('BoxConstraints',
        'The contract object passed parent -> child during layout.'),
    _CheatRow('ConstrainedBox',
        'Add or tighten constraints on a child without changing layout strategy.'),
    _CheatRow('UnconstrainedBox',
        'Drop the parent\'s constraints; let the child size itself.'),
    _CheatRow('LimitedBox',
        'Only constrain when parent is unbounded (e.g. inside a ListView).'),
    _CheatRow('OverflowBox',
        'Allow the child to exceed the parent\'s slot visually.'),
    _CheatRow('SizedBox / SizedBox.fromSize',
        'Tightly request a specific Size or width/height.'),
    _CheatRow('IntrinsicWidth',
        'Make Column children share the widest natural width (use sparingly).'),
    _CheatRow('IntrinsicHeight',
        'Make Row children share the tallest natural height (use sparingly).'),
    _CheatRow('FittedBox',
        'Scale a child to fit a slot using a BoxFit strategy.'),
    _CheatRow('AspectRatio',
        'Pick a Size that obeys width/height = ratio.'),
    _CheatRow('FractionallySizedBox',
        'Use a fraction of the parent\'s width/height.'),
  ];

  print('Cheat sheet contains ${rows.length} entries.');
  for (var i = 0; i < rows.length; i++) {
    print('  ${i.toString().padLeft(2)}. ${rows[i].name}');
  }

  final List<Widget> entries = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    entries.add(_cheatEntry(rows[i], i));
    if (i != rows.length - 1) {
      entries.add(const SizedBox(height: 6));
    }
  }

  return _platePanel(
    title: '9. Sizing widget cheat sheet',
    subtitle: 'Pick the right tool for the right slot.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: entries,
    ),
  );
}

class _CheatRow {
  final String name;
  final String description;
  const _CheatRow(this.name, this.description);
}

Widget _cheatEntry(_CheatRow row, int idx) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          _kPaperDeep,
          _kPaperCream,
        ],
      ),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kInkBlue.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kInkBlue,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${idx + 1}',
            style: const TextStyle(
              color: _kPaperCream,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                row.name,
                style: const TextStyle(
                  color: _kInkDeep,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                row.description,
                style: const TextStyle(
                  color: _kPencilGraphite,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SHARED PLATE PANEL
// ---------------------------------------------------------------------
// Each section is wrapped in a "plate" so the document reads like a
// stack of drafting plates. The plate has a header strip, a subtitle,
// and a body slot that the section fills with its own widgets.
// =====================================================================
Widget _platePanel({
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kPaperCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kInkBlue, width: 1.4),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x44143A70),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Header strip with gradient.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                _kInkDeep,
                _kInkBlue,
                _kBlueprintCyan,
              ],
              stops: <double>[0.0, 0.6, 1.0],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kPaperCream,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _kPaperCream.withOpacity(0.85),
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kPaperCream,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'PLATE',
                  style: TextStyle(
                    color: _kInkDeep,
                    fontSize: 9,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Body.
        Padding(
          padding: const EdgeInsets.all(14),
          child: body,
        ),
      ],
    ),
  );
}
