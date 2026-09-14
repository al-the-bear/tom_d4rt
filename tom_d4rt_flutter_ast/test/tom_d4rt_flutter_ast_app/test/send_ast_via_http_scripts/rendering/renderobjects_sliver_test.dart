// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of the RenderSliver family.
//
// Scope:
//   RenderSliver, SliverConstraints, SliverGeometry, RenderSliverList,
//   RenderSliverFixedExtentList, RenderSliverGrid, RenderSliverFillViewport,
//   RenderSliverFillRemaining, RenderSliverToBoxAdapter,
//   RenderSliverPersistentHeader, RenderSliverPadding, RenderViewport,
//   AxisDirection, GrowthDirection.
//
// Approach: most RenderSliver subclasses cannot be instantiated from script
// code (they need RenderBox children with the right protocol). Instead we
// drive the same render-tree shapes through their public widget counterparts
// inside height-bounded CustomScrollView specimens — a "scroll laboratory".
//
// Palette: charcoal-graphite / acid-yellow / lime, technical drawing line work.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

// ============================================================================
// PALETTE / TOKENS — graphite + acid-yellow + lime technical drawing
// ============================================================================

const Color _kInk = Color(0xFF12141A);
const Color _kGraphite = Color(0xFF1E222B);
const Color _kSteel = Color(0xFF2D333F);
const Color _kAsh = Color(0xFF40485A);
const Color _kFog = Color(0xFF8C95A8);
const Color _kPaper = Color(0xFFF4F4EE);
const Color _kSheet = Color(0xFFE6E6DC);
const Color _kAcid = Color(0xFFE7FF52);
const Color _kAcidDeep = Color(0xFFBFE020);
const Color _kLime = Color(0xFF7BD64A);
const Color _kLimeDeep = Color(0xFF3F7A20);
const Color _kAmber = Color(0xFFF5B400);
const Color _kRust = Color(0xFFD25A2A);
const Color _kBlueprint = Color(0xFF1F3A5F);
const Color _kBlueprintHi = Color(0xFF3C6FA8);

const double _kRadiusS = 4.0;
const double _kRadiusM = 8.0;
const double _kRadiusL = 14.0;

// ============================================================================
// SMALL HELPERS — labels, chips, dividers, rule lines
// ============================================================================

Widget _tag(String text, {Color bg = _kAcid, Color fg = _kInk}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(_kRadiusS),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _mono(String text, {double size = 11.5, Color color = _kInk}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: size,
      color: color,
      height: 1.35,
    ),
  );
}

Widget _label(String text,
    {double size = 12.0, Color color = _kAsh, FontWeight w = FontWeight.w600}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: w,
      letterSpacing: 0.3,
    ),
  );
}

Widget _hairline({Color color = _kAsh, double thickness = 1.0}) {
  return Container(height: thickness, color: color);
}

Widget _sectionHeader(String index, String title, String subtitle,
    {Color accent = _kAcid}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: _kGraphite,
      borderRadius: BorderRadius.circular(_kRadiusM),
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(_kRadiusS),
          ),
          child: Text(
            index,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: _kInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  color: _kPaper,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: _kFog,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child, Color bg = _kPaper, Color border = _kAsh}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(_kRadiusM),
      border: Border.all(color: border, width: 1.0),
    ),
    child: child,
  );
}

// ============================================================================
// SPECIMEN SHELL — a labeled, height-bounded sandbox that hosts a real
// CustomScrollView. Top strip names the sliver type; right strip names the
// scroll axis; bottom strip surfaces caveats / notes.
// ============================================================================

Widget _specimen({
  required String code,
  required String caption,
  required Widget scrollView,
  double height = 220.0,
  String axis = 'vertical',
  Color accent = _kAcid,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      color: _kSheet,
      borderRadius: BorderRadius.circular(_kRadiusM),
      border: Border.all(color: _kAsh, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(_kRadiusM),
              topRight: Radius.circular(_kRadiusM),
            ),
          ),
          child: Row(
            children: [
              _tag('SPECIMEN', bg: accent),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  code,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: _kPaper,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _tag(axis, bg: _kAmber),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: _kPaper,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kAsh, width: 1.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_kRadiusS),
              child: scrollView,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 10.0),
          child: Text(
            caption,
            style: const TextStyle(
              fontSize: 11.5,
              color: _kAsh,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// COLORED CARD ITEMS — used as RenderBox children inside slivers.
// Deterministic palette so re-renders are stable across script invocations.
// ============================================================================

const List<Color> _kCardSwatches = <Color>[
  Color(0xFFE7FF52),
  Color(0xFFBFE020),
  Color(0xFF7BD64A),
  Color(0xFF3F7A20),
  Color(0xFFF5B400),
  Color(0xFFD25A2A),
  Color(0xFF3C6FA8),
  Color(0xFF1F3A5F),
  Color(0xFF8C95A8),
  Color(0xFF40485A),
  Color(0xFF2D333F),
  Color(0xFF12141A),
];

Color _swatch(int i) => _kCardSwatches[i % _kCardSwatches.length];

Color _readable(Color bg) {
  final double luma =
      0.2126 * bg.red + 0.7152 * bg.green + 0.0722 * bg.blue;
  return luma > 140.0 ? _kInk : _kPaper;
}

Widget _listCard(int index, {double? height, String? overrideLabel}) {
  final Color bg = _swatch(index);
  final Color fg = _readable(bg);
  return Container(
    height: height,
    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(_kRadiusS),
      border: Border.all(color: _kInk, width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kInk.withOpacity(0.65),
            borderRadius: BorderRadius.circular(_kRadiusS),
          ),
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: _kAcid,
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            overrideLabel ?? 'item ${index + 1}',
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Text(
          '0x${bg.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
          style: TextStyle(
            color: fg,
            fontFamily: 'monospace',
            fontSize: 10.5,
          ),
        ),
      ],
    ),
  );
}

Widget _gridTile(int index) {
  final Color bg = _swatch(index);
  final Color fg = _readable(bg);
  return Container(
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(_kRadiusS),
      border: Border.all(color: _kInk, width: 1.0),
    ),
    alignment: Alignment.center,
    child: Text(
      'T${index + 1}',
      style: TextStyle(
        color: fg,
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _pageTile(int index, String name) {
  final Color bg = _swatch(index + 2);
  final Color fg = _readable(bg);
  return Container(
    decoration: BoxDecoration(
      color: bg,
      border: Border.all(color: _kInk, width: 1.0),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PAGE ${index + 1}',
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          name,
          style: TextStyle(
            color: fg,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SLIVER PERSISTENT HEADER DELEGATE — used by section 11 specimen.
// ============================================================================

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({
    required this.title,
    required this.minHeight,
    required this.maxHeight,
    required this.background,
    required this.foreground,
  });

  final String title;
  final double minHeight;
  final double maxHeight;
  final Color background;
  final Color foreground;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(minHeight, maxHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double t =
        ((maxExtent - shrinkOffset) / maxExtent).clamp(0.0, 1.0);
    return Container(
      decoration: BoxDecoration(
        color: background,
        border: Border(
          bottom: BorderSide(color: _kInk, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 8.0,
            height: 22.0,
            color: foreground,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: foreground,
                fontWeight: FontWeight.w800,
                fontSize: 14.0 + 4.0 * t,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Text(
            't=${t.toStringAsFixed(2)}',
            style: TextStyle(
              color: foreground,
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.background != background ||
        oldDelegate.foreground != foreground;
  }
}

// ============================================================================
// SECTION HERO — the page title
// ============================================================================

Widget _hero() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kInk, _kGraphite, _kSteel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(_kRadiusL),
      border: Border.all(color: _kAcid, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _tag('D4RT'),
            const SizedBox(width: 8.0),
            _tag('RENDERING', bg: _kLime),
            const SizedBox(width: 8.0),
            _tag('SLIVERS', bg: _kAmber),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'RenderSliver family — the scroll protocol',
          style: TextStyle(
            color: _kPaper,
            fontSize: 26.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'A scroll laboratory of bounded specimens. Each specimen drives the '
          'same RenderSliver pipeline as a real viewport — through public '
          'widget counterparts — so we can read geometry, growth direction '
          'and protocol behaviour without instantiating the render objects '
          'by hand.',
          style: TextStyle(
            color: _kFog,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _tag('CustomScrollView', bg: _kAcidDeep),
            const SizedBox(width: 6.0),
            _tag('SliverList', bg: _kAcid),
            const SizedBox(width: 6.0),
            _tag('SliverGrid', bg: _kLime),
          ],
        ),
        const SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            _tag('SliverFillViewport', bg: _kAmber),
            const SizedBox(width: 6.0),
            _tag('SliverFillRemaining', bg: _kAmber),
            const SizedBox(width: 6.0),
            _tag('SliverPersistentHeader', bg: _kRust, fg: _kPaper),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — CONCEPT OVERVIEW
// ============================================================================

Widget _conceptOverview() {
  return _card(
    bg: _kPaper,
    border: _kAsh,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('CONCEPT'),
          const SizedBox(width: 8.0),
          _label('RenderSliver vs RenderBox',
              size: 13.0, color: _kInk, w: FontWeight.w800),
        ]),
        const SizedBox(height: 12.0),
        const Text(
          'RenderBox lays out with BoxConstraints (min/max width × height) '
          'and produces a Size. RenderSliver lays out with SliverConstraints '
          '(scrollOffset, remainingPaintExtent, cross-axis extent, axis '
          'direction, growth direction) and produces a SliverGeometry '
          '(scrollExtent, paintExtent, paintOrigin, layoutExtent, …).',
          style: TextStyle(fontSize: 13.0, height: 1.5, color: _kInk),
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _kSheet,
                  borderRadius: BorderRadius.circular(_kRadiusS),
                  border: Border.all(color: _kAsh),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _tag('RenderBox', bg: _kBlueprintHi, fg: _kPaper),
                    const SizedBox(height: 8.0),
                    _mono('input  : BoxConstraints'),
                    _mono('output : Size'),
                    _mono('uses   : Cartesian layout'),
                    _mono('parents: Row, Column, Stack…'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _kSheet,
                  borderRadius: BorderRadius.circular(_kRadiusS),
                  border: Border.all(color: _kAcidDeep, width: 1.4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _tag('RenderSliver', bg: _kAcid),
                    const SizedBox(height: 8.0),
                    _mono('input  : SliverConstraints'),
                    _mono('output : SliverGeometry'),
                    _mono('uses   : scroll-axis layout'),
                    _mono('parents: Viewport, CustomScrollView…'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _hairline(),
        const SizedBox(height: 10.0),
        _label('AxisDirection × GrowthDirection',
            size: 13.0, color: _kInk, w: FontWeight.w800),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final AxisDirection ad in AxisDirection.values)
              for (final GrowthDirection gd in GrowthDirection.values)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: gd == GrowthDirection.forward ? _kAcid : _kAmber,
                    borderRadius: BorderRadius.circular(_kRadiusS),
                    border: Border.all(color: _kInk),
                  ),
                  child: Text(
                    '${ad.name} / ${gd.name}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: _kInk,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — SliverConstraints anatomy
// ============================================================================

Widget _sliverConstraintsAnatomy() {
  final List<List<String>> rows = <List<String>>[
    <String>['axisDirection',
        'Direction the scroll offset increases along.', 'AxisDirection'],
    <String>['growthDirection',
        'forward grows toward axis, reverse grows backward.', 'GrowthDirection'],
    <String>['userScrollDirection',
        'Last direction the user dragged.', 'ScrollDirection'],
    <String>['scrollOffset',
        'Distance from the leading edge of this sliver to the leading edge of the viewport.', 'double'],
    <String>['overlap',
        'Number of pixels the previous slivers paint into this one.', 'double'],
    <String>['remainingPaintExtent',
        'How many paint pixels are left in the viewport for this sliver.', 'double'],
    <String>['crossAxisExtent',
        'Size in the direction perpendicular to the scroll axis.', 'double'],
    <String>['crossAxisDirection',
        'Direction perpendicular to axisDirection.', 'AxisDirection'],
    <String>['viewportMainAxisExtent',
        'Main-axis size of the viewport.', 'double'],
    <String>['remainingCacheExtent',
        'Paint pixels left in the cache region.', 'double'],
    <String>['cacheOrigin',
        'Negative offset where the cache begins.', 'double'],
  ];
  return _card(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('ANATOMY'),
          const SizedBox(width: 8.0),
          _label('class SliverConstraints',
              size: 13.0, color: _kInk, w: FontWeight.w800),
          const Spacer(),
          _tag('input', bg: _kBlueprintHi, fg: _kPaper),
        ]),
        const SizedBox(height: 10.0),
        const Text(
          'The parent viewport hands these to every sliver, every frame. The '
          'sliver must read them and respond with a SliverGeometry consistent '
          'with the offered space.',
          style: TextStyle(fontSize: 12.5, color: _kAsh, height: 1.45),
        ),
        const SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: _kSheet,
            borderRadius: BorderRadius.circular(_kRadiusS),
            border: Border.all(color: _kAsh),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < rows.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 170.0,
                        child: Text(
                          rows[i][0],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            color: _kInk,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          rows[i][1],
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: _kInk,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      _tag(rows[i][2], bg: _kLime),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — SliverGeometry anatomy
// ============================================================================

Widget _sliverGeometryAnatomy() {
  // Build a real SliverGeometry to display the canonical default values
  // alongside the field descriptions. This exercises the constructor in d4rt.
  final SliverGeometry sample = SliverGeometry(
    scrollExtent: 320.0,
    paintExtent: 180.0,
    paintOrigin: 0.0,
    layoutExtent: 180.0,
    maxPaintExtent: 320.0,
    maxScrollObstructionExtent: 0.0,
    hitTestExtent: 180.0,
    visible: true,
    hasVisualOverflow: false,
    scrollOffsetCorrection: null,
    cacheExtent: 220.0,
  );

  final SliverGeometry zero = SliverGeometry.zero;

  final List<List<String>> rows = <List<String>>[
    <String>['scrollExtent',
        'Total scrollable length this sliver contributes.',
        sample.scrollExtent.toString(),
        zero.scrollExtent.toString()],
    <String>['paintExtent',
        'Pixels the sliver actually paints right now.',
        sample.paintExtent.toString(),
        zero.paintExtent.toString()],
    <String>['paintOrigin',
        'Offset from where painting starts relative to the layout origin.',
        sample.paintOrigin.toString(),
        zero.paintOrigin.toString()],
    <String>['layoutExtent',
        'Pixels the next sliver should be offset by along the main axis.',
        sample.layoutExtent.toString(),
        zero.layoutExtent.toString()],
    <String>['maxPaintExtent',
        'Maximum paint extent this sliver could ever reach (used by indicators).',
        sample.maxPaintExtent.toString(),
        zero.maxPaintExtent.toString()],
    <String>['maxScrollObstructionExtent',
        'Pixels the sliver pins in front of subsequent slivers.',
        sample.maxScrollObstructionExtent.toString(),
        zero.maxScrollObstructionExtent.toString()],
    <String>['hitTestExtent',
        'Pixels along the main axis that can receive hit tests.',
        sample.hitTestExtent.toString(),
        zero.hitTestExtent.toString()],
    <String>['visible',
        'False when paintExtent is 0 — viewport may skip painting.',
        sample.visible.toString(),
        zero.visible.toString()],
    <String>['hasVisualOverflow',
        'True if the sliver paints outside its declared paintExtent.',
        sample.hasVisualOverflow.toString(),
        zero.hasVisualOverflow.toString()],
    <String>['scrollOffsetCorrection',
        'If non-null, viewport restarts layout with this correction.',
        '${sample.scrollOffsetCorrection}',
        '${zero.scrollOffsetCorrection}'],
    <String>['cacheExtent',
        'Cache-region size around the visible region.',
        sample.cacheExtent.toString(),
        zero.cacheExtent.toString()],
  ];

  return _card(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('ANATOMY'),
          const SizedBox(width: 8.0),
          _label('class SliverGeometry',
              size: 13.0, color: _kInk, w: FontWeight.w800),
          const Spacer(),
          _tag('output', bg: _kLimeDeep, fg: _kPaper),
        ]),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kSheet,
            border: Border.all(color: _kAsh),
            borderRadius: BorderRadius.circular(_kRadiusS),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 170.0, child: Text('field',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 11.5,
                            fontWeight: FontWeight.w800, color: _kAsh))),
                    const Expanded(child: Text('meaning',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 11.5,
                            fontWeight: FontWeight.w800, color: _kAsh))),
                    const SizedBox(width: 80.0,
                        child: Text('sample',
                            style: TextStyle(fontFamily: 'monospace', fontSize: 11.5,
                                fontWeight: FontWeight.w800, color: _kAsh))),
                    const SizedBox(width: 60.0,
                        child: Text('.zero',
                            style: TextStyle(fontFamily: 'monospace', fontSize: 11.5,
                                fontWeight: FontWeight.w800, color: _kAsh))),
                  ],
                ),
              ),
              _hairline(color: _kAsh),
              for (int i = 0; i < rows.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: _kFog.withOpacity(0.5), width: 0.5),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 170.0,
                        child: Text(
                          rows[i][0],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: _kInk,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          rows[i][1],
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: _kInk,
                            height: 1.35,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80.0,
                        child: Text(
                          rows[i][2],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: _kBlueprint,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60.0,
                        child: Text(
                          rows[i][3],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: _kRust,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — SliverList specimen
// ============================================================================

Widget _sliverListSpecimen() {
  return _specimen(
    code: 'CustomScrollView(slivers: [SliverList(SliverChildBuilderDelegate(...))])',
    caption:
        'SliverList builds children lazily, each with its own intrinsic height. '
        'Variable item heights are fine. Underlying render object: RenderSliverList.',
    accent: _kAcid,
    height: 240.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final double extra = (index % 4) * 6.0;
              return _listCard(
                index,
                height: 38.0 + extra,
                overrideLabel: 'lazy row ${index + 1}',
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 — SliverFixedExtentList specimen
// ============================================================================

Widget _sliverFixedExtentListSpecimen() {
  return _specimen(
    code: 'SliverFixedExtentList(itemExtent: 60, delegate: ...)',
    caption:
        'Every child is forced to exactly 60 logical pixels along the main axis. '
        'The viewport can skip per-child layout and compute scroll position in O(1). '
        'Underlying render object: RenderSliverFixedExtentList.',
    accent: _kLime,
    height: 240.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: 60.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _listCard(index,
                  overrideLabel: 'fixed row ${index + 1}');
            },
            childCount: 15,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — SliverGrid specimen
// ============================================================================

Widget _sliverGridSpecimen() {
  return _specimen(
    code: 'SliverGrid.count(crossAxisCount: 3, children: ...)',
    caption:
        'SliverGrid lays out children in cells determined by a grid delegate. '
        '.count is the simplest delegate: fixed N columns. Underlying render '
        'object: RenderSliverGrid.',
    accent: _kAmber,
    height: 260.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.2,
          children: <Widget>[
            for (int i = 0; i < 12; i++) _gridTile(i),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 — SliverFillViewport specimen
// ============================================================================

Widget _sliverFillViewportSpecimen() {
  return _specimen(
    code: 'SliverFillViewport(viewportFraction: 1.0, delegate: ...)',
    caption:
        'Every child is sized to the full viewport in the main axis — a pager. '
        'Underlying render object: RenderSliverFillViewport.',
    accent: _kRust,
    height: 220.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverFillViewport(
          viewportFraction: 1.0,
          delegate: SliverChildListDelegate(<Widget>[
            _pageTile(0, 'intro page'),
            _pageTile(1, 'middle page'),
            _pageTile(2, 'outro page'),
          ]),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — SliverFillRemaining specimen
// ============================================================================

Widget _sliverFillRemainingSpecimen() {
  return _specimen(
    code: 'CustomScrollView([SliverList(short), SliverFillRemaining(tail)])',
    caption:
        'SliverFillRemaining occupies the remaining viewport space after '
        'previous slivers. Common pattern for empty-state tails and footers. '
        'Underlying render object: RenderSliverFillRemaining.',
    accent: _kLime,
    height: 260.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            _listCard(0, height: 40.0, overrideLabel: 'short item A'),
            _listCard(1, height: 40.0, overrideLabel: 'short item B'),
            _listCard(2, height: 40.0, overrideLabel: 'short item C'),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kBlueprint,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kAcid, width: 1.2),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('fill-remaining tail',
                    style: TextStyle(
                        color: _kAcid,
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 6.0),
                Text('no scroll body — fills available space exactly',
                    style: TextStyle(color: _kPaper, fontSize: 11.5)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — SliverToBoxAdapter specimen
// ============================================================================

Widget _sliverToBoxAdapterSpecimen() {
  return _specimen(
    code: 'SliverToBoxAdapter(child: <RenderBox subtree>)',
    caption:
        'SliverToBoxAdapter wraps a single RenderBox so it can live in a sliver-only '
        'list. Useful for hero headers, banners, separators. Underlying render '
        'object: RenderSliverToBoxAdapter.',
    accent: _kAcid,
    height: 240.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: 64.0,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kAcid,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kInk, width: 1.0),
            ),
            alignment: Alignment.center,
            child: const Text('adapter A — hero banner',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: _kInk)),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 72.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: _kLime,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kInk, width: 1.0),
            ),
            alignment: Alignment.center,
            child: const Text('adapter B — divider section',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: _kInk)),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 56.0,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kAmber,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kInk, width: 1.0),
            ),
            alignment: Alignment.center,
            child: const Text('adapter C — footer banner',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: _kInk)),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — SliverPersistentHeader specimen
// ============================================================================

Widget _sliverPersistentHeaderSpecimen() {
  return _specimen(
    code:
        'SliverPersistentHeader(pinned: true, delegate: _StickyHeaderDelegate(...))',
    caption:
        'SliverPersistentHeader stays attached to the leading edge while content '
        'scrolls beneath it. pinned/floating flags control how it returns when the '
        'user scrolls back. Underlying render object: RenderSliverPersistentHeader.',
    accent: _kRust,
    height: 280.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            title: 'pinned header (group A)',
            minHeight: 36.0,
            maxHeight: 36.0,
            background: _kInk,
            foreground: _kAcid,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) =>
                _listCard(index, height: 36.0,
                    overrideLabel: 'A-row ${index + 1}'),
            childCount: 6,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            title: 'pinned header (group B)',
            minHeight: 36.0,
            maxHeight: 36.0,
            background: _kBlueprint,
            foreground: _kAcid,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) =>
                _listCard(index + 6, height: 36.0,
                    overrideLabel: 'B-row ${index + 1}'),
            childCount: 6,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 — SliverPadding specimen
// ============================================================================

Widget _sliverPaddingSpecimen() {
  return _specimen(
    code:
        'SliverPadding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), sliver: SliverList(...))',
    caption:
        'SliverPadding inserts inset around an inner sliver, adjusting layout '
        'and paint extents accordingly. Underlying render object: RenderSliverPadding.',
    accent: _kLime,
    height: 240.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  _listCard(index, height: 40.0,
                      overrideLabel: 'padded ${index + 1}'),
              childCount: 8,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 13 — Reverse / AxisDirection specimens
// ============================================================================

Widget _reverseAndHorizontalSpecimens() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _specimen(
        code: 'CustomScrollView(reverse: true, slivers: [SliverList(...)])',
        caption:
            'reverse:true flips the AxisDirection to up — items 1..N grow from '
            'the bottom toward the top. GrowthDirection stays forward.',
        accent: _kAmber,
        height: 200.0,
        axis: 'vertical-up',
        scrollView: CustomScrollView(
          reverse: true,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) =>
                    _listCard(index, height: 40.0,
                        overrideLabel: 'reversed ${index + 1}'),
                childCount: 8,
              ),
            ),
          ],
        ),
      ),
      _specimen(
        code:
            'CustomScrollView(scrollDirection: Axis.horizontal, slivers: [SliverList(...)])',
        caption:
            'scrollDirection:Axis.horizontal sets AxisDirection.right. The main '
            'axis becomes width; the cross axis becomes height (the specimen height).',
        accent: _kBlueprintHi,
        height: 100.0,
        axis: 'horizontal',
        scrollView: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: 120.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final Color bg = _swatch(index);
                  final Color fg = _readable(bg);
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(_kRadiusS),
                      border: Border.all(color: _kInk),
                    ),
                    alignment: Alignment.center,
                    child: Text('col ${index + 1}',
                        style: TextStyle(
                            color: fg,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'monospace',
                            fontSize: 13.0)),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 14 — Composition specimen (5+ sliver types in one CSV)
// ============================================================================

Widget _compositionSpecimen() {
  return _specimen(
    code:
        'CustomScrollView([Adapter, PinnedHeader, Padding(List), Grid, FillRemaining])',
    caption:
        'A real composition: a hero adapter, a pinned header, a padded list, a '
        'grid, then a fill-remaining tail. The viewport drives every sliver via '
        'the same protocol; each sliver returns its own SliverGeometry.',
    accent: _kAcid,
    height: 380.0,
    scrollView: CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: 56.0,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kAcid, width: 1.2),
            ),
            alignment: Alignment.center,
            child: const Text('hero (SliverToBoxAdapter)',
                style: TextStyle(
                    color: _kAcid,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 13.0)),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            title: 'sticky — composition',
            minHeight: 32.0,
            maxHeight: 32.0,
            background: _kGraphite,
            foreground: _kAcid,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  _listCard(index, height: 36.0,
                      overrideLabel: 'comp ${index + 1}'),
              childCount: 5,
            ),
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 4,
          childAspectRatio: 1.3,
          children: <Widget>[
            for (int i = 0; i < 8; i++) _gridTile(i + 3),
          ],
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kSheet,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kAsh),
            ),
            alignment: Alignment.center,
            child: const Text('SliverFillRemaining — composition tail',
                style: TextStyle(
                    color: _kInk,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5)),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 15 — Lifecycle / protocol diagram
// ============================================================================

Widget _lifecycleDiagram() {
  final List<List<String>> phases = <List<String>>[
    <String>['1', 'parent.performLayout()',
        'Viewport iterates its sliver children and computes SliverConstraints for each.'],
    <String>['2', 'child.layout(constraints, parentUsesSize: true)',
        'Each sliver lays itself out, asking its RenderBox children for sizes when needed.'],
    <String>['3', 'child.geometry = SliverGeometry(...)',
        'Sliver publishes its geometry. Parent reads paintExtent/layoutExtent.'],
    <String>['4', 'parent.applyPaintTransform / paint()',
        'Viewport composes the sliver into the scene at the correct paint offset.'],
    <String>['5', 'hitTest(SliverHitTestResult, mainAxisPosition, crossAxisPosition)',
        'Hits are routed in scroll coordinates; only hitTestExtent pixels are eligible.'],
  ];
  return _card(
    bg: _kInk,
    border: _kAcid,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('LIFECYCLE'),
          const SizedBox(width: 8.0),
          const Text('RenderSliver layout → paint → hit-test',
              style: TextStyle(
                  color: _kPaper,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800)),
        ]),
        const SizedBox(height: 10.0),
        for (int i = 0; i < phases.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: _kAcid,
                    borderRadius: BorderRadius.circular(_kRadiusS),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    phases[i][0],
                    style: const TextStyle(
                      color: _kInk,
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        phases[i][1],
                        style: const TextStyle(
                          color: _kAcid,
                          fontFamily: 'monospace',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        phases[i][2],
                        style: const TextStyle(
                          color: _kFog,
                          fontSize: 12.0,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 16 — Recipe cards
// ============================================================================

class _Recipe {
  const _Recipe(this.title, this.signature, this.note, this.accent);
  final String title;
  final String signature;
  final String note;
  final Color accent;
}

Widget _recipeCards() {
  const List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      'lazy list',
      'SliverList(delegate: SliverChildBuilderDelegate(builder, childCount: n))',
      'Default choice for variable-height rows.',
      _kAcid,
    ),
    _Recipe(
      'fixed-height list',
      'SliverFixedExtentList(itemExtent: H, delegate: …)',
      'O(1) scrolling math; great for very long uniform lists.',
      _kLime,
    ),
    _Recipe(
      'grid with header',
      'CustomScrollView([SliverToBoxAdapter(header), SliverGrid.count(N, …)])',
      'Mix a banner with a grid by stacking slivers.',
      _kAmber,
    ),
    _Recipe(
      'two-column ratio',
      'SliverGrid(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(2, ratio))',
      'Pick aspect ratio to size cells without per-child height.',
      _kAcidDeep,
    ),
    _Recipe(
      'sticky header + list',
      'SliverPersistentHeader(pinned: true, …) followed by SliverList(…)',
      'Header pins at viewport leading edge while list scrolls.',
      _kRust,
    ),
    _Recipe(
      'expanding hero',
      'SliverAppBar(expandedHeight: 240, flexibleSpace: …) or persistent delegate',
      'shrinkOffset drives a graphical collapse curve.',
      _kBlueprintHi,
    ),
  ];

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      for (int i = 0; i < recipes.length; i += 2)
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _recipeCard(recipes[i])),
              const SizedBox(width: 10.0),
              if (i + 1 < recipes.length)
                Expanded(child: _recipeCard(recipes[i + 1]))
              else
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ),
    ],
  );
}

Widget _recipeCard(_Recipe r) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: BorderRadius.circular(_kRadiusM),
      border: Border.all(color: r.accent, width: 1.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('RECIPE', bg: r.accent),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              r.title,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: _kInk,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kSheet,
            borderRadius: BorderRadius.circular(_kRadiusS),
            border: Border.all(color: _kAsh),
          ),
          child: Text(
            r.signature,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: _kInk,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          r.note,
          style: const TextStyle(
            fontSize: 11.5,
            color: _kAsh,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 17 — Comparison table
// ============================================================================

Widget _comparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['SliverList', 'variable-height lazy list', 'O(n) layout',
        'builder/list delegate'],
    <String>['SliverFixedExtentList', 'uniform-height long list', 'O(1) scroll math',
        'builder/list delegate'],
    <String>['SliverPrototypeExtentList', 'all items match a prototype', 'O(1) once measured',
        'prototype + delegate'],
    <String>['SliverGrid', '2D cell grid', 'O(n) layout',
        'grid delegate + child delegate'],
    <String>['SliverFillViewport', 'full-viewport pages', 'O(1) per page',
        'child delegate'],
    <String>['SliverFillRemaining', 'fill leftover space', 'one box child',
        'box child'],
    <String>['SliverToBoxAdapter', 'wrap a single RenderBox', 'trivial',
        'box child'],
    <String>['SliverPersistentHeader', 'pinned/floating header', 'depends on delegate',
        'persistent header delegate'],
    <String>['SliverPadding', 'inset wrapper for any sliver', 'thin',
        'one inner sliver'],
    <String>['SliverAppBar', 'high-level pinned hero', 'depends on flexibleSpace',
        'composes persistent header'],
  ];

  return _card(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('TABLE'),
          const SizedBox(width: 8.0),
          _label('sliver type × use case × cost × child shape',
              size: 13.0, color: _kInk, w: FontWeight.w800),
        ]),
        const SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: _kSheet,
            borderRadius: BorderRadius.circular(_kRadiusS),
            border: Border.all(color: _kAsh),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                decoration: const BoxDecoration(
                  color: _kInk,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_kRadiusS),
                    topRight: Radius.circular(_kRadiusS),
                  ),
                ),
                child: Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 170.0,
                      child: Text('sliver',
                          style: TextStyle(
                              color: _kAcid,
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800)),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('use case',
                          style: TextStyle(
                              color: _kAcid,
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('cost',
                          style: TextStyle(
                              color: _kAcid,
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800)),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('child shape',
                          style: TextStyle(
                              color: _kAcid,
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < rows.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: i.isEven ? _kSheet : _kPaper,
                    border: Border(
                      bottom: BorderSide(
                        color: _kFog.withOpacity(0.4),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 170.0,
                        child: Text(rows[i][0],
                            style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: _kInk)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(rows[i][1],
                            style: const TextStyle(
                                fontSize: 11.5,
                                color: _kInk,
                                height: 1.35)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(rows[i][2],
                            style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11.0,
                                color: _kRust)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(rows[i][3],
                            style: const TextStyle(
                                fontSize: 11.5,
                                color: _kBlueprint)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 18 — Pitfalls
// ============================================================================

Widget _pitfalls() {
  final List<List<String>> pitfalls = <List<String>>[
    <String>['missing crossAxisCount',
        'SliverGrid.count without crossAxisCount fails to lay out — every '
            'grid delegate must define how cross-axis space is partitioned.'],
    <String>['infinite extent',
        'A sliver that returns scrollExtent=double.infinity inside a viewport '
            'that does not allow infinite extent (e.g. bounded CustomScrollView) '
            'will throw during layout.'],
    <String>['mixing slivers with box children',
        'CustomScrollView.slivers expects only RenderSliver children. Passing '
            'a Container directly produces a protocol mismatch — wrap it in '
            'SliverToBoxAdapter.'],
    <String>['viewport size assumptions',
        'Code that reads MediaQuery.size at build time to size a SliverFillViewport '
            'page can desync from the real viewport main-axis extent. Prefer '
            'viewportFraction.'],
    <String>['shrinkWrap inside infinite parent',
        'CustomScrollView(shrinkWrap: true) inside an unbounded parent forces '
            'all children to lay out — defeats lazy building and can be O(n²).'],
    <String>['SliverFillRemaining hasScrollBody',
        'Set hasScrollBody:false when the tail is a single non-scrolling box, '
            'otherwise the sliver assumes its child is itself scrollable.'],
  ];

  return _card(
    bg: _kPaper,
    border: _kRust,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('PITFALL', bg: _kRust, fg: _kPaper),
          const SizedBox(width: 8.0),
          _label('common sliver protocol mistakes',
              size: 13.0, color: _kInk, w: FontWeight.w800),
        ]),
        const SizedBox(height: 10.0),
        for (int i = 0; i < pitfalls.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _kSheet,
              borderRadius: BorderRadius.circular(_kRadiusS),
              border: Border.all(color: _kRust),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  pitfalls[i][0],
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: _kRust,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  pitfalls[i][1],
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _kInk,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 19 — Glossary
// ============================================================================

Widget _glossary() {
  final List<List<String>> entries = <List<String>>[
    <String>['sliver', 'A region that lays out along the scroll axis and '
        'produces a SliverGeometry instead of a Size.'],
    <String>['scrollOffset', 'The number of pixels from this sliver\'s leading '
        'edge to the viewport\'s leading edge.'],
    <String>['paintExtent', 'How many pixels of this sliver are visible in the '
        'viewport right now.'],
    <String>['layoutExtent', 'How many pixels of main-axis space the sliver '
        'consumes for the next sliver.'],
    <String>['maxPaintExtent', 'Largest possible paintExtent — used by scroll '
        'indicators to size the thumb.'],
    <String>['cacheExtent', 'Extra paint pixels eagerly laid out outside the '
        'visible region for smoother scroll.'],
    <String>['cacheOrigin', 'Negative offset where the cache region begins '
        'relative to the visible region.'],
    <String>['axisDirection', 'down/up/left/right — the direction in which '
        'scrollOffset increases.'],
    <String>['growthDirection', 'forward = grow toward axisDirection; reverse = '
        'grow opposite. Both can coexist in a viewport (center-anchored).'],
    <String>['userScrollDirection', 'Most recent direction the user actively '
        'scrolled. May differ from axisDirection.'],
    <String>['SliverChildDelegate', 'Strategy object that vends widgets to a '
        'list/grid sliver — builder or list variants are the common ones.'],
    <String>['SliverPersistentHeaderDelegate', 'Strategy object describing '
        'a pinnable/floatable header: min/maxExtent and a build callback that '
        'receives shrinkOffset.'],
    <String>['viewport', 'A render object that owns and clips a set of '
        'slivers, supplying SliverConstraints to each one.'],
    <String>['hit test', 'Routing a pointer event in scroll coordinates to '
        'whichever sliver covers hitTestExtent at that offset.'],
  ];
  return _card(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('GLOSSARY'),
          const SizedBox(width: 8.0),
          _label('${entries.length} terms',
              size: 13.0, color: _kInk, w: FontWeight.w800),
        ]),
        const SizedBox(height: 10.0),
        for (int i = 0; i < entries.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 180.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _kAcid,
                    borderRadius: BorderRadius.circular(_kRadiusS),
                  ),
                  child: Text(
                    entries[i][0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: _kInk,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    entries[i][1],
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: _kInk,
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

// ============================================================================
// SECTION 20 — Epilogue
// ============================================================================

Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kGraphite, _kInk],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(_kRadiusL),
      border: Border.all(color: _kLime, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: <Widget>[
          _tag('EPILOGUE', bg: _kLime),
          const SizedBox(width: 8.0),
          const Text('the portage line',
              style: TextStyle(
                  color: _kPaper,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800)),
        ]),
        const SizedBox(height: 12.0),
        const Text(
          'Slivers are how Flutter portages content across a viewport. Each '
          'one negotiates with its parent in two currencies: SliverConstraints '
          '(what the viewport offers) and SliverGeometry (what the sliver '
          'returns). That tiny protocol is the entire reason CustomScrollView '
          'can mix lazy lists, sticky headers, grids, pagers and tail-fillers '
          'in one cohesive scroll surface.',
          style: TextStyle(
            color: _kFog,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'This specimen book exercised every major sliver type through the '
          'real render pipeline. The script returned a single root widget — '
          'no controllers, no streams — yet every CustomScrollView above '
          'instantiated genuine RenderSliver subclasses behind the scenes.',
          style: TextStyle(
            color: _kFog,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(children: <Widget>[
          _tag('END', bg: _kAcid),
          const SizedBox(width: 8.0),
          _tag('20/20 sections', bg: _kLime),
          const SizedBox(width: 8.0),
          _tag('scroll laboratory', bg: _kAmber),
        ]),
      ],
    ),
  );
}

// ============================================================================
// MAIN ENTRY POINT — assemble the page
// ============================================================================

dynamic build(BuildContext context) {
  return Container(
    color: _kSheet,
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 1.
          _hero(),
          const SizedBox(height: 20.0),

          // 2.
          _sectionHeader('02', 'Concept overview',
              'RenderSliver vs RenderBox; axis × growth direction'),
          const SizedBox(height: 10.0),
          _conceptOverview(),
          const SizedBox(height: 20.0),

          // 3.
          _sectionHeader('03', 'SliverConstraints anatomy',
              'What the parent viewport hands to every sliver'),
          const SizedBox(height: 10.0),
          _sliverConstraintsAnatomy(),
          const SizedBox(height: 20.0),

          // 4.
          _sectionHeader('04', 'SliverGeometry anatomy',
              'What every sliver returns to its parent', accent: _kLime),
          const SizedBox(height: 10.0),
          _sliverGeometryAnatomy(),
          const SizedBox(height: 20.0),

          // 5.
          _sectionHeader('05', 'SliverList specimen',
              'lazy, variable-height rows in a bounded viewport',
              accent: _kAcid),
          const SizedBox(height: 10.0),
          _sliverListSpecimen(),
          const SizedBox(height: 16.0),

          // 6.
          _sectionHeader('06', 'SliverFixedExtentList specimen',
              'uniform 60px rows — O(1) scroll math', accent: _kLime),
          const SizedBox(height: 10.0),
          _sliverFixedExtentListSpecimen(),
          const SizedBox(height: 16.0),

          // 7.
          _sectionHeader('07', 'SliverGrid specimen',
              '3-column grid via .count', accent: _kAmber),
          const SizedBox(height: 10.0),
          _sliverGridSpecimen(),
          const SizedBox(height: 16.0),

          // 8.
          _sectionHeader('08', 'SliverFillViewport specimen',
              'pager — every child fills the viewport', accent: _kRust),
          const SizedBox(height: 10.0),
          _sliverFillViewportSpecimen(),
          const SizedBox(height: 16.0),

          // 9.
          _sectionHeader('09', 'SliverFillRemaining specimen',
              'short list + tail that fills available space',
              accent: _kLime),
          const SizedBox(height: 10.0),
          _sliverFillRemainingSpecimen(),
          const SizedBox(height: 16.0),

          // 10.
          _sectionHeader('10', 'SliverToBoxAdapter specimen',
              'three RenderBox children embedded inside a sliver list'),
          const SizedBox(height: 10.0),
          _sliverToBoxAdapterSpecimen(),
          const SizedBox(height: 16.0),

          // 11.
          _sectionHeader('11', 'SliverPersistentHeader specimen',
              'pinned headers anchored to the leading edge',
              accent: _kRust),
          const SizedBox(height: 10.0),
          _sliverPersistentHeaderSpecimen(),
          const SizedBox(height: 16.0),

          // 12.
          _sectionHeader('12', 'SliverPadding specimen',
              'inset wrapper for any inner sliver', accent: _kLime),
          const SizedBox(height: 10.0),
          _sliverPaddingSpecimen(),
          const SizedBox(height: 16.0),

          // 13.
          _sectionHeader('13', 'Reverse / AxisDirection demos',
              'reverse: true and scrollDirection: Axis.horizontal',
              accent: _kAmber),
          const SizedBox(height: 10.0),
          _reverseAndHorizontalSpecimens(),
          const SizedBox(height: 16.0),

          // 14.
          _sectionHeader('14', 'Composition specimen',
              '5 sliver types in a single CustomScrollView',
              accent: _kAcid),
          const SizedBox(height: 10.0),
          _compositionSpecimen(),
          const SizedBox(height: 20.0),

          // 15.
          _sectionHeader('15', 'Lifecycle / protocol diagram',
              'parent → child → geometry → paint → hit-test',
              accent: _kAcid),
          const SizedBox(height: 10.0),
          _lifecycleDiagram(),
          const SizedBox(height: 20.0),

          // 16.
          _sectionHeader('16', 'Recipe cards',
              '6 ready-made sliver compositions', accent: _kLime),
          const SizedBox(height: 10.0),
          _recipeCards(),
          const SizedBox(height: 20.0),

          // 17.
          _sectionHeader('17', 'Comparison table',
              'sliver × use case × cost × child shape',
              accent: _kBlueprintHi),
          const SizedBox(height: 10.0),
          _comparisonTable(),
          const SizedBox(height: 20.0),

          // 18.
          _sectionHeader('18', 'Pitfalls',
              'common sliver protocol mistakes', accent: _kRust),
          const SizedBox(height: 10.0),
          _pitfalls(),
          const SizedBox(height: 20.0),

          // 19.
          _sectionHeader('19', 'Glossary',
              '14 essential sliver terms', accent: _kAcid),
          const SizedBox(height: 10.0),
          _glossary(),
          const SizedBox(height: 20.0),

          // 20.
          _epilogue(),
        ],
      ),
    ),
  );
}
