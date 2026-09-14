// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =====================================================================
// Deep demo: SliverPaintOrder
// =====================================================================
//
// SliverPaintOrder is a Flutter enum (rendering library, exposed via
// widgets/scroll_view.dart) that controls which sliver paints on top
// when multiple slivers overlap inside a viewport. The two values are:
//
//   - SliverPaintOrder.firstIsTop  (default)
//       The first sliver in CustomScrollView.slivers is painted LAST,
//       so it appears on top. Hit-testing happens in declaration order.
//   - SliverPaintOrder.lastIsTop
//       The last sliver in CustomScrollView.slivers is painted LAST,
//       so it appears on top. Hit-testing happens in reverse order.
//
// This affects:
//   * Floating + pinned headers that hover over other slivers.
//   * Stacked drop shadows where two slivers spill into each other.
//   * Cross-axis groups where one sliver visually overlaps another.
//   * SliverMainAxisGroup / SliverCrossAxisGroup combined with the
//     enclosing CustomScrollView's paintOrder property.
//
// This file exercises the LIVE enum: every demo passes a real
// SliverPaintOrder value to the CustomScrollView constructor and the
// painted result is observably different between firstIsTop and
// lastIsTop. The reference at the top of the file
//
//     final SliverPaintOrder _ref = SliverPaintOrder.lastIsTop;
//
// is also load-bearing: removing it removes the symbol reference in
// case a particular demo is later trimmed.

import 'package:flutter/material.dart';

// ─── live enum reference (always referenced so symbol cannot be DCE'd)
// ignore: unused_element
final SliverPaintOrder _ref = SliverPaintOrder.lastIsTop;
// ignore: unused_element
final SliverPaintOrder _refDefault = SliverPaintOrder.firstIsTop;

// ─── palette: Teal / Mint Cream ───────────────────────────────────
const Color _poTeal = Color(0xFF00695C);
const Color _poMint = Color(0xFFE0F2F1);
const Color _poAccent = Color(0xFF26A69A);
const Color _poOnTeal = Colors.white;
const Color _poWarn = Color(0xFFFF6D00);
const Color _poDark = Color(0xFF212121);
const Color _poRose = Color(0xFFE91E63);
const Color _poIndigo = Color(0xFF3F51B5);
const Color _poAmber = Color(0xFFFFC107);
// ignore: unused_element
const Color _poLime = Color(0xFFCDDC39);
const Color _poBlueGrey = Color(0xFF607D8B);
const Color _poDeepOrange = Color(0xFFFF5722);
const Color _poPaper = Color(0xFFFAFAFA);

// ─── text helpers ─────────────────────────────────────────────────
Widget _poTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: _poTeal,
          letterSpacing: 0.3,
        ),
      ),
    );

Widget _poSection(String t) => Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 6),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: _poTeal,
          letterSpacing: 0.2,
        ),
      ),
    );

// ignore: unused_element
Widget _poSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: _poAccent,
        ),
      ),
    );

Widget _poBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        t,
        style: const TextStyle(
          fontSize: 13.5,
          color: Colors.black87,
          height: 1.45,
        ),
      ),
    );

Widget _poBullet(String t) => Padding(
      padding: const EdgeInsets.fromLTRB(14, 2, 0, 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: _poAccent),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t,
              style: const TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );

Widget _poCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _poDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        t,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          color: _poMint,
          height: 1.4,
        ),
      ),
    );

Widget _poNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _poMint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _poAccent, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: _poTeal, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t,
              style: const TextStyle(
                fontSize: 13,
                color: _poDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );

// ignore: unused_element
Widget _poWarning(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _poWarn, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, color: _poWarn, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t,
              style: const TextStyle(
                fontSize: 13,
                color: _poDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );

Widget _poDivider() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Divider(color: _poAccent, thickness: 1.2, height: 0),
    );

// ─── small reusable card frame ────────────────────────────────────
Widget _poCard(String label, Widget child, {Color? color}) => Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _poAccent.withOpacity(0.4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: _poTeal,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );

Widget _poChip(String text, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );

// =====================================================================
// SECTION 1 — INTRO
// =====================================================================
Widget _poSection1Intro() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_poMint, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _poAccent, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.layers_rounded, color: _poTeal, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'SliverPaintOrder — what is it?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _poTeal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _poBody(
          'When two slivers in a CustomScrollView overlap in screen '
          'space — typically because one of them is a floating or pinned '
          'header — the framework needs to decide which one paints on top. '
          'SliverPaintOrder is the enum that captures that choice.',
        ),
        const SizedBox(height: 8),
        _poBullet(
          'firstIsTop (default): the first sliver in the slivers list '
          'paints last, so it sits visually on top of everything below it.',
        ),
        _poBullet(
          'lastIsTop: the last sliver in the slivers list paints last, '
          'so a footer-like or trailing sliver sits on top.',
        ),
        _poBullet(
          'Hit-testing happens in the OPPOSITE order from painting, so '
          'whichever sliver is on top also receives taps first.',
        ),
        const SizedBox(height: 10),
        _poCode(
          'CustomScrollView(\n'
          '  paintOrder: SliverPaintOrder.lastIsTop,\n'
          '  slivers: <Widget>[\n'
          '    SliverAppBar(pinned: true, ...),\n'
          '    SliverList(...),\n'
          '    // last sliver paints on top now:\n'
          '    SliverPersistentHeader(pinned: true, ...),\n'
          '  ],\n'
          ')',
        ),
        _poNote(
          'In most every-day scrolls there is no overlap, so the paint '
          'order has no visible effect. It only matters when slivers '
          'spill into each other — pinned/floating headers, cross-axis '
          'groups, drop shadows, and so on.',
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 2 — firstIsTop vs lastIsTop SIDE BY SIDE
// =====================================================================
Widget _poSection2SideBySide() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _poSection('2 · firstIsTop vs lastIsTop, side-by-side'),
      _poBody(
        'Two CustomScrollViews — same slivers, only the paintOrder '
        'differs. Watch what happens in the overlap zone where the '
        'pinned blue header meets the floating amber header.',
      ),
      const SizedBox(height: 10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _poCard(
              'firstIsTop  (default)',
              _PoSideBySideScroller(
                paintOrder: SliverPaintOrder.firstIsTop,
                tag: 'A',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _poCard(
              'lastIsTop',
              _PoSideBySideScroller(
                paintOrder: SliverPaintOrder.lastIsTop,
                tag: 'B',
              ),
            ),
          ),
        ],
      ),
      _poNote(
        'Scroll either column. With firstIsTop, the blue pinned header '
        'paints over the amber floating header — because the blue '
        'sliver is FIRST in the slivers list. With lastIsTop, the amber '
        'floating header (which is LAST) paints on top instead.',
      ),
    ],
  );
}

class _PoSideBySideScroller extends StatelessWidget {
  final SliverPaintOrder paintOrder;
  final String tag;
  const _PoSideBySideScroller({required this.paintOrder, required this.tag});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          paintOrder: paintOrder,
          slivers: <Widget>[
            // First sliver — blue pinned header.
            SliverPersistentHeader(
              pinned: true,
              delegate: _PoStickyDelegate(
                color: _poIndigo,
                title: 'BLUE header (first in list) — $tag',
                height: 70,
              ),
            ),
            // Filler list so the user can scroll.
            SliverList.builder(
              itemCount: 30,
              itemBuilder: (context, i) {
                return Container(
                  height: 36,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: i.isEven ? _poMint : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('$tag · row $i'),
                );
              },
            ),
            // Last sliver — amber floating header (overlaps the blue one
            // when scrolled to the top).
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _PoStickyDelegate(
                color: _poAmber,
                title: 'AMBER header (last in list) — $tag',
                height: 70,
                textColor: _poDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PoStickyDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String title;
  final double height;
  final Color textColor;
  _PoStickyDelegate({
    required this.color,
    required this.title,
    required this.height,
    this.textColor = Colors.white,
  });

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color.withOpacity(0.95),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_PoStickyDelegate oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.title != title ||
        oldDelegate.height != height ||
        oldDelegate.textColor != textColor;
  }
}

// =====================================================================
// SECTION 3 — SliverMainAxisGroup with paint order toggle
// =====================================================================
Widget _poSection3MainAxisGroup() {
  return _PoMainAxisGroupDemo();
}

class _PoMainAxisGroupDemo extends StatefulWidget {
  @override
  State<_PoMainAxisGroupDemo> createState() => _PoMainAxisGroupDemoState();
}

class _PoMainAxisGroupDemoState extends State<_PoMainAxisGroupDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('3 · SliverMainAxisGroup with paint order toggle'),
        _poBody(
          'A SliverMainAxisGroup bundles a header, list, and footer into '
          'a single sliver. The group itself does not have a paintOrder, '
          'but the enclosing CustomScrollView does — and it controls how '
          'the group paints relative to a floating overlay header.',
        ),
        const SizedBox(height: 8),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverMainAxisGroup(
                  slivers: <Widget>[
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _PoStickyDelegate(
                        color: _poTeal,
                        title: 'GROUP header (inside SliverMainAxisGroup)',
                        height: 60,
                      ),
                    ),
                    SliverList.builder(
                      itemCount: 18,
                      itemBuilder: (_, i) => Container(
                        height: 38,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: i.isEven ? _poPaper : _poMint,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('group · row $i'),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.all(6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _poBlueGrey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'GROUP footer',
                          style: TextStyle(
                            color: _poOnTeal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Overlay floating-pinned header that competes for paint
                // space with the group above.
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poRose,
                    title: 'OVERLAY header (last sliver)',
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
        _poNote(
          'With firstIsTop the group (declared first) paints its teal '
          'header over the rose overlay. With lastIsTop the rose '
          'overlay wins because it is declared last.',
        ),
      ],
    );
  }
}

class _PoOrderSegmented extends StatelessWidget {
  final SliverPaintOrder value;
  final ValueChanged<SliverPaintOrder> onChanged;
  const _PoOrderSegmented({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SliverPaintOrder>(
      segments: const <ButtonSegment<SliverPaintOrder>>[
        ButtonSegment(
          value: SliverPaintOrder.firstIsTop,
          label: Text('firstIsTop'),
          icon: Icon(Icons.vertical_align_top),
        ),
        ButtonSegment(
          value: SliverPaintOrder.lastIsTop,
          label: Text('lastIsTop'),
          icon: Icon(Icons.vertical_align_bottom),
        ),
      ],
      selected: <SliverPaintOrder>{value},
      onSelectionChanged: (s) => onChanged(s.first),
    );
  }
}

// =====================================================================
// SECTION 4 — SliverCrossAxisGroup with paint order
// =====================================================================
Widget _poSection4CrossAxisGroup() {
  return _PoCrossAxisGroupDemo();
}

class _PoCrossAxisGroupDemo extends StatefulWidget {
  @override
  State<_PoCrossAxisGroupDemo> createState() => _PoCrossAxisGroupDemoState();
}

class _PoCrossAxisGroupDemoState extends State<_PoCrossAxisGroupDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('4 · SliverCrossAxisGroup with paint order'),
        _poBody(
          'SliverCrossAxisGroup lays its children side by side along the '
          'cross axis. When combined with a floating overlay sliver in '
          'the parent CustomScrollView, the parent paint order decides '
          'which one wins in the overlap zone.',
        ),
        const SizedBox(height: 8),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverCrossAxisGroup(
                  slivers: <Widget>[
                    SliverConstrainedCrossAxis(
                      maxExtent: 90,
                      sliver: SliverList.builder(
                        itemCount: 30,
                        itemBuilder: (_, i) => Container(
                          height: 32,
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _poTeal,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'L $i',
                            style: const TextStyle(
                              color: _poOnTeal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: 30,
                      itemBuilder: (_, i) => Container(
                        height: 32,
                        margin: const EdgeInsets.all(2),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: i.isEven ? _poPaper : _poMint,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('right pane · row $i'),
                      ),
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poDeepOrange,
                    title: 'CROSS overlay header',
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
        _poNote(
          'Because the cross-axis group is declared first, with '
          'firstIsTop its content paints on top of any overlap with '
          'the deep-orange overlay below; with lastIsTop the overlay '
          'wins.',
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 5 — STACKED FLOATING-PINNED HEADERS (z-order playground)
// =====================================================================
Widget _poSection5StackedFloating() {
  return _PoStackedFloatingDemo();
}

class _PoStackedFloatingDemo extends StatefulWidget {
  @override
  State<_PoStackedFloatingDemo> createState() => _PoStackedFloatingDemoState();
}

class _PoStackedFloatingDemoState extends State<_PoStackedFloatingDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('5 · Three stacked floating-pinned headers'),
        _poBody(
          'Three SliverPersistentHeaders, all pinned + floating with the '
          'same height. They sit on top of one another at the top of the '
          'viewport. Toggle the paint order to see which one wins.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poRose,
                    title: '1st header (rose)',
                    height: 56,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poIndigo,
                    title: '2nd header (indigo)',
                    height: 56,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poAmber,
                    title: '3rd header (amber)',
                    height: 56,
                    textColor: _poDark,
                  ),
                ),
                SliverList.builder(
                  itemCount: 50,
                  itemBuilder: (_, i) => Container(
                    height: 30,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    color: i.isEven ? _poPaper : Colors.white,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('content $i'),
                  ),
                ),
              ],
            ),
          ),
        ),
        _poNote(
          'firstIsTop → ROSE wins. lastIsTop → AMBER wins. INDIGO is '
          'always sandwiched in the middle of the z-stack.',
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 6 — DROP-SHADOW SCENARIO
// =====================================================================
Widget _poSection6DropShadow() {
  return _PoDropShadowDemo();
}

class _PoDropShadowDemo extends StatefulWidget {
  @override
  State<_PoDropShadowDemo> createState() => _PoDropShadowDemoState();
}

class _PoDropShadowDemoState extends State<_PoDropShadowDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('6 · Drop-shadow scenario'),
        _poBody(
          'Two slivers each carry a drop shadow. Where they overlap, '
          'paint order determines which shadow falls on top of the '
          'other — important for elevation feel.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PoShadowedHeaderDelegate(
                    color: _poTeal,
                    title: 'top — pinned header (shadow ↓)',
                    height: 70,
                  ),
                ),
                SliverList.builder(
                  itemCount: 24,
                  itemBuilder: (_, i) => Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('item $i'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoShadowedHeaderDelegate(
                    color: _poAmber,
                    title: 'bottom — floating overlay (shadow ↑↓)',
                    height: 70,
                    textColor: _poDark,
                  ),
                ),
              ],
            ),
          ),
        ),
        _poNote(
          'When two shadowed slivers overlap, switching paintOrder '
          'inverts which shadow is visible at the seam.',
        ),
      ],
    );
  }
}

class _PoShadowedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String title;
  final double height;
  final Color textColor;
  _PoShadowedHeaderDelegate({
    required this.color,
    required this.title,
    required this.height,
    this.textColor = Colors.white,
  });

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_PoShadowedHeaderDelegate oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.title != title ||
        oldDelegate.height != height ||
        oldDelegate.textColor != textColor;
  }
}

// =====================================================================
// SECTION 7 — MIXED SLIVERS (List + Grid + Header) WITH TOGGLE
// =====================================================================
Widget _poSection7MixedSlivers() {
  return _PoMixedSliversDemo();
}

class _PoMixedSliversDemo extends StatefulWidget {
  @override
  State<_PoMixedSliversDemo> createState() => _PoMixedSliversDemoState();
}

class _PoMixedSliversDemoState extends State<_PoMixedSliversDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('7 · Mixed slivers — list + grid + persistent header'),
        _poBody(
          'A more realistic stack: pinned header → list → pinned mid '
          'header → grid → pinned footer header. Floating overlay at '
          'the bottom of the slivers list. Toggle paint order.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 380,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PoStickyDelegate(
                    color: _poTeal,
                    title: '#1 SECTION  list',
                    height: 44,
                  ),
                ),
                SliverList.builder(
                  itemCount: 10,
                  itemBuilder: (_, i) => Container(
                    height: 32,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: i.isEven ? _poPaper : _poMint,
                    child: Text('list row $i'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PoStickyDelegate(
                    color: _poIndigo,
                    title: '#2 SECTION  grid',
                    height: 44,
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => Container(
                      margin: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _poBlueGrey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'g$i',
                        style: const TextStyle(
                          color: _poOnTeal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    childCount: 12,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.4,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PoStickyDelegate(
                    color: _poDeepOrange,
                    title: '#3 SECTION  footer',
                    height: 44,
                  ),
                ),
                SliverList.builder(
                  itemCount: 8,
                  itemBuilder: (_, i) => Container(
                    height: 32,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: i.isEven ? _poPaper : _poMint,
                    child: Text('footer row $i'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poAmber,
                    title: 'OVERLAY (last sliver in list)',
                    height: 44,
                    textColor: _poDark,
                  ),
                ),
              ],
            ),
          ),
        ),
        _poNote(
          'firstIsTop favours the teal section header. lastIsTop lifts '
          'the amber overlay above everything else.',
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 8 — EDGE CASES PANEL
// =====================================================================
Widget _poSection8EdgeCases() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _poSection('8 · Edge cases'),
      _poBody(
        'Some configurations make paintOrder a no-op. These three '
        'examples document the observable null effect.',
      ),
      _poCard(
        'A · Single-child viewport',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _poBody(
              'Only one sliver — nothing to paint over anything else, '
              'so paintOrder is irrelevant.',
            ),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomScrollView(
                  paintOrder: SliverPaintOrder.lastIsTop,
                  slivers: <Widget>[
                    SliverList.builder(
                      itemCount: 20,
                      itemBuilder: (_, i) => ListTile(title: Text('only $i')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      _poCard(
        'B · Group with one sliver of zero extent',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _poBody(
              'A SliverToBoxAdapter wrapping a zero-height SizedBox '
              'produces no painted output, so paintOrder cannot affect it.',
            ),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomScrollView(
                  paintOrder: SliverPaintOrder.firstIsTop,
                  slivers: const <Widget>[
                    SliverToBoxAdapter(child: SizedBox.shrink()),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 60,
                        child: ColoredBox(
                          color: _poMint,
                          child: Center(child: Text('the only visible sliver')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      _poCard(
        'C · No overlap zone',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _poBody(
              'Two slivers stacked end-to-end without any pinned or '
              'floating overlap — paintOrder has no observable effect.',
            ),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomScrollView(
                  paintOrder: SliverPaintOrder.lastIsTop,
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        height: 60,
                        color: _poTeal,
                        alignment: Alignment.center,
                        child: const Text(
                          'A',
                          style: TextStyle(
                            color: _poOnTeal,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 60,
                        color: _poRose,
                        alignment: Alignment.center,
                        child: const Text(
                          'B',
                          style: TextStyle(
                            color: _poOnTeal,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      _poNote(
        'Rule of thumb: if you cannot point at the pixels where two '
        'slivers occupy the same paint region, paintOrder is decoration '
        'only — it changes nothing visible.',
      ),
    ],
  );
}

// =====================================================================
// SECTION 9 — RECIPE GALLERY
// =====================================================================
Widget _poSection9Recipes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _poSection('9 · Recipe gallery — when to pick which paint order'),
      _poBody(
        'Four small recipes with a recommended paintOrder for each.',
      ),
      _PoRecipeCard(
        title: 'Sticky filter overlay',
        intent: 'A pinned filter bar must sit visually ABOVE all '
            'section headers, regardless of how many sections there '
            'are.',
        recommended: SliverPaintOrder.lastIsTop,
        sliversBuilder: () => <Widget>[
          for (int s = 0; s < 4; s++) ...<Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _PoStickyDelegate(
                color: s.isEven ? _poTeal : _poIndigo,
                title: 'section header $s',
                height: 36,
              ),
            ),
            SliverList.builder(
              itemCount: 6,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                title: Text('section $s · row $i'),
              ),
            ),
          ],
          // Filter bar last → on top.
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _PoStickyDelegate(
              color: _poRose,
              title: 'STICKY FILTER (always on top)',
              height: 40,
            ),
          ),
        ],
      ),
      _PoRecipeCard(
        title: 'Z-stacked tabs',
        intent: 'Tabs sit at the top of the slivers list and must stay '
            'in front of the section headers. firstIsTop places the '
            'first sliver on top — exactly what we want.',
        recommended: SliverPaintOrder.firstIsTop,
        sliversBuilder: () => <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _PoStickyDelegate(
              color: _poDeepOrange,
              title: 'TABS (first sliver, must stay on top)',
              height: 40,
            ),
          ),
          for (int s = 0; s < 3; s++) ...<Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _PoStickyDelegate(
                color: s.isEven ? _poTeal : _poIndigo,
                title: 'section $s',
                height: 36,
              ),
            ),
            SliverList.builder(
              itemCount: 5,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                title: Text('s$s row $i'),
              ),
            ),
          ],
        ],
      ),
      _PoRecipeCard(
        title: 'Shadowed sticky search',
        intent: 'A search bar with a strong drop shadow at the top. '
            'Section headers should slide UNDER it. firstIsTop again, '
            'because the search bar is the first sliver.',
        recommended: SliverPaintOrder.firstIsTop,
        sliversBuilder: () => <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _PoShadowedHeaderDelegate(
              color: _poBlueGrey,
              title: 'SEARCH (first, casts shadow over content)',
              height: 50,
            ),
          ),
          for (int s = 0; s < 3; s++) ...<Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _PoStickyDelegate(
                color: _poTeal,
                title: 'section $s',
                height: 32,
              ),
            ),
            SliverList.builder(
              itemCount: 6,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                title: Text('s$s · $i'),
              ),
            ),
          ],
        ],
      ),
      _PoRecipeCard(
        title: 'Promo banner takeover',
        intent: 'A floating promo banner declared at the bottom of the '
            'slivers list takes over the entire top edge. lastIsTop '
            'lifts the banner above all other slivers.',
        recommended: SliverPaintOrder.lastIsTop,
        sliversBuilder: () => <Widget>[
          for (int s = 0; s < 3; s++) ...<Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _PoStickyDelegate(
                color: _poTeal,
                title: 'section $s',
                height: 32,
              ),
            ),
            SliverList.builder(
              itemCount: 6,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                title: Text('s$s · $i'),
              ),
            ),
          ],
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _PoStickyDelegate(
              color: _poAmber,
              title: 'PROMO (last, takes over)',
              height: 40,
              textColor: _poDark,
            ),
          ),
        ],
      ),
    ],
  );
}

class _PoRecipeCard extends StatelessWidget {
  final String title;
  final String intent;
  final SliverPaintOrder recommended;
  final List<Widget> Function() sliversBuilder;
  const _PoRecipeCard({
    required this.title,
    required this.intent,
    required this.recommended,
    required this.sliversBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return _poCard(
      title,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _poBody(intent),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text(
                'Recommended:  ',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              _poChip(
                recommended.name,
                recommended == SliverPaintOrder.firstIsTop
                    ? _poTeal
                    : _poRose,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 260,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomScrollView(
                paintOrder: recommended,
                slivers: sliversBuilder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 — REFERENCE TABLE
// =====================================================================
Widget _poSection10Reference() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _poSection('10 · Reference table — who accepts SliverPaintOrder?'),
      _poBody(
        'These are the public widgets and render objects that take '
        'a SliverPaintOrder argument in this Flutter version.',
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: _poAccent),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2.4),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(3),
          },
          border: TableBorder.symmetric(
            inside: BorderSide(color: _poAccent.withOpacity(0.3)),
          ),
          children: <TableRow>[
            const TableRow(
              decoration: BoxDecoration(color: _poMint),
              children: <Widget>[
                _PoTableCell('Widget / RenderObject', isHeader: true),
                _PoTableCell('Default paintOrder', isHeader: true),
                _PoTableCell('Effect', isHeader: true),
              ],
            ),
            TableRow(
              children: const <Widget>[
                _PoTableCell('CustomScrollView'),
                _PoTableCell('firstIsTop'),
                _PoTableCell(
                  'Top-level scroll view — most app surfaces use this.',
                ),
              ],
            ),
            TableRow(
              children: const <Widget>[
                _PoTableCell('Viewport (low-level)'),
                _PoTableCell('firstIsTop'),
                _PoTableCell(
                  'Used internally by CustomScrollView and ScrollView.',
                ),
              ],
            ),
            TableRow(
              children: const <Widget>[
                _PoTableCell('ShrinkWrappingViewport'),
                _PoTableCell('firstIsTop'),
                _PoTableCell(
                  'Used by sliver-based widgets that shrink-wrap their '
                  'content — e.g. inside intrinsic-size layouts.',
                ),
              ],
            ),
            TableRow(
              children: const <Widget>[
                _PoTableCell('RenderViewport'),
                _PoTableCell('firstIsTop'),
                _PoTableCell(
                  'Render-object level — exposed via the .paintOrder '
                  'getter/setter for low-level callers.',
                ),
              ],
            ),
            TableRow(
              children: const <Widget>[
                _PoTableCell('NestedScrollView (outer)'),
                _PoTableCell('firstIsTop'),
                _PoTableCell(
                  'Outer scroll view delegates to the underlying '
                  'CustomScrollView; the same enum applies.',
                ),
              ],
            ),
          ],
        ),
      ),
      _poNote(
        'SliverMainAxisGroup and SliverCrossAxisGroup do NOT take a '
        'paintOrder argument themselves. Their painted z-order is '
        'inherited from the enclosing CustomScrollView via '
        'SliverPaintOrder.',
      ),
    ],
  );
}

class _PoTableCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  const _PoTableCell(this.text, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.w800 : FontWeight.w400,
          color: isHeader ? _poTeal : _poDark,
          fontSize: 13,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 11 — BONUS: GROUPED SLIVERS INSIDE A PAINT-ORDERED VIEWPORT
// =====================================================================
Widget _poSection11GroupedBonus() {
  return _PoGroupedBonusDemo();
}

class _PoGroupedBonusDemo extends StatefulWidget {
  @override
  State<_PoGroupedBonusDemo> createState() => _PoGroupedBonusDemoState();
}

class _PoGroupedBonusDemoState extends State<_PoGroupedBonusDemo> {
  SliverPaintOrder _order = SliverPaintOrder.lastIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('11 · Groups inside a paint-ordered viewport (bonus)'),
        _poBody(
          'Two SliverMainAxisGroup blocks side-by-side via a '
          'SliverCrossAxisGroup, both inside a CustomScrollView whose '
          'paintOrder we control. Adds an overlay floating header.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 380,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverCrossAxisGroup(
                  slivers: <Widget>[
                    SliverMainAxisGroup(
                      slivers: <Widget>[
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _PoStickyDelegate(
                            color: _poTeal,
                            title: 'L head',
                            height: 36,
                          ),
                        ),
                        SliverList.builder(
                          itemCount: 12,
                          itemBuilder: (_, i) => Container(
                            height: 28,
                            margin: const EdgeInsets.all(2),
                            color: i.isEven ? _poMint : Colors.white,
                            alignment: Alignment.center,
                            child: Text('L $i'),
                          ),
                        ),
                      ],
                    ),
                    SliverMainAxisGroup(
                      slivers: <Widget>[
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _PoStickyDelegate(
                            color: _poRose,
                            title: 'R head',
                            height: 36,
                          ),
                        ),
                        SliverList.builder(
                          itemCount: 12,
                          itemBuilder: (_, i) => Container(
                            height: 28,
                            margin: const EdgeInsets.all(2),
                            color: i.isEven ? _poPaper : _poMint,
                            alignment: Alignment.center,
                            child: Text('R $i'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poDeepOrange,
                    title: 'TOP overlay (last sliver)',
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
        _poNote(
          'lastIsTop floats the overlay above the cross-axis group; '
          'firstIsTop hides it underneath the group headers.',
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 12 — BONUS: PAINT ORDER + HORIZONTAL CUSTOMSCROLLVIEW
// =====================================================================
Widget _poSection12Horizontal() {
  return _PoHorizontalDemo();
}

class _PoHorizontalDemo extends StatefulWidget {
  @override
  State<_PoHorizontalDemo> createState() => _PoHorizontalDemoState();
}

class _PoHorizontalDemoState extends State<_PoHorizontalDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('12 · Paint order in a horizontal CustomScrollView'),
        _poBody(
          'paintOrder is axis-agnostic. A horizontal CustomScrollView '
          'with a pinned-floating left edge demonstrates the same '
          'first/last semantics rotated 90°.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              paintOrder: _order,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoHorizontalHeaderDelegate(
                    color: _poTeal,
                    title: 'LEFT edge',
                  ),
                ),
                SliverList.builder(
                  itemCount: 30,
                  itemBuilder: (_, i) => Container(
                    width: 100,
                    margin: const EdgeInsets.all(4),
                    color: i.isEven ? _poMint : _poPaper,
                    alignment: Alignment.center,
                    child: Text('h $i'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoHorizontalHeaderDelegate(
                    color: _poDeepOrange,
                    title: 'TRAIL edge',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PoHorizontalHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String title;
  _PoHorizontalHeaderDelegate({required this.color, required this.title});

  @override
  double get minExtent => 80;
  @override
  double get maxExtent => 80;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(
          title,
          style: const TextStyle(
            color: _poOnTeal,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_PoHorizontalHeaderDelegate oldDelegate) {
    return oldDelegate.color != color || oldDelegate.title != title;
  }
}

// =====================================================================
// SECTION 13 — BONUS: TOGGLING PAINT ORDER ON A SLIVERAPPBAR STACK
// =====================================================================
Widget _poSection13AppBarStack() {
  return _PoSliverAppBarStack();
}

class _PoSliverAppBarStack extends StatefulWidget {
  @override
  State<_PoSliverAppBarStack> createState() => _PoSliverAppBarStackState();
}

class _PoSliverAppBarStackState extends State<_PoSliverAppBarStack> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('13 · SliverAppBar stack with paint order toggle'),
        _poBody(
          'A typical Material setup: SliverAppBar at the top, then '
          'a tab-like SliverPersistentHeader, then content. The '
          'overlay below either dives under or sits above based on '
          'paintOrder.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() => _order = o),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 380,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 100,
                  backgroundColor: _poTeal,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('SliverAppBar (1st)'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PoStickyDelegate(
                    color: _poIndigo,
                    title: 'tabs (2nd)',
                    height: 40,
                  ),
                ),
                SliverList.builder(
                  itemCount: 30,
                  itemBuilder: (_, i) => ListTile(
                    dense: true,
                    title: Text('content row $i'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoStickyDelegate(
                    color: _poRose,
                    title: 'overlay (last)',
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 14 — BONUS: HIT-TEST DEMONSTRATION
// =====================================================================
Widget _poSection14HitTest() {
  return _PoHitTestDemo();
}

class _PoHitTestDemo extends StatefulWidget {
  @override
  State<_PoHitTestDemo> createState() => _PoHitTestDemoState();
}

class _PoHitTestDemoState extends State<_PoHitTestDemo> {
  SliverPaintOrder _order = SliverPaintOrder.firstIsTop;
  String _lastTap = '(nothing yet)';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poSection('14 · Hit-test order follows paint order (inverse)'),
        _poBody(
          'Tap inside the overlap region of the two pinned headers. '
          'The header on top (paint-wise) receives the tap.',
        ),
        _PoOrderSegmented(
          value: _order,
          onChanged: (o) => setState(() {
            _order = o;
            _lastTap = '(reset)';
          }),
        ),
        const SizedBox(height: 4),
        _poNote('Last tap: $_lastTap'),
        SizedBox(
          height: 240,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomScrollView(
              paintOrder: _order,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PoTapHeaderDelegate(
                    color: _poTeal,
                    title: 'TEAL (first)',
                    height: 50,
                    onTap: () => setState(() => _lastTap = 'TEAL (first)'),
                  ),
                ),
                SliverList.builder(
                  itemCount: 30,
                  itemBuilder: (_, i) => ListTile(
                    dense: true,
                    title: Text('content $i'),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _PoTapHeaderDelegate(
                    color: _poAmber,
                    title: 'AMBER (last)',
                    height: 50,
                    textColor: _poDark,
                    onTap: () => setState(() => _lastTap = 'AMBER (last)'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PoTapHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String title;
  final double height;
  final Color textColor;
  final VoidCallback onTap;
  _PoTapHeaderDelegate({
    required this.color,
    required this.title,
    required this.height,
    required this.onTap,
    this.textColor = Colors.white,
  });

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_PoTapHeaderDelegate oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.title != title ||
        oldDelegate.height != height ||
        oldDelegate.textColor != textColor;
  }
}

// =====================================================================
// SECTION 15 — SUMMARY / CHEAT-SHEET
// =====================================================================
Widget _poSection15Summary() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _poDark,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CHEAT SHEET',
          style: TextStyle(
            color: _poAmber,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'SliverPaintOrder.firstIsTop',
          style: TextStyle(
            color: _poMint,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        _PoCheatLine(text: '• default value'),
        _PoCheatLine(text: '• first sliver paints last → on top'),
        _PoCheatLine(text: '• hit tests in declaration order'),
        _PoCheatLine(
          text:
              '• pick when an early sliver (e.g. tabs / search) is the '
              'visually dominant element',
        ),
        const SizedBox(height: 12),
        const Text(
          'SliverPaintOrder.lastIsTop',
          style: TextStyle(
            color: _poMint,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        _PoCheatLine(text: '• opt-in'),
        _PoCheatLine(text: '• last sliver paints last → on top'),
        _PoCheatLine(text: '• hit tests in reverse order'),
        _PoCheatLine(
          text:
              '• pick when a trailing sliver (filter overlay, promo '
              'banner, undo bar) must dominate',
        ),
      ],
    ),
  );
}

class _PoCheatLine extends StatelessWidget {
  final String text;
  const _PoCheatLine({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.4,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 16 — FINAL: ENUM ROUNDTRIP DIAGNOSTIC
// =====================================================================
Widget _poSection16Diagnostic() {
  // Roundtrip the values through SliverPaintOrder.values to make
  // absolutely sure the live enum is referenced.
  final List<SliverPaintOrder> all = SliverPaintOrder.values;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _poMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _poAccent, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'enum roundtrip',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: _poTeal,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        for (final v in all)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: <Widget>[
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color:
                        v == SliverPaintOrder.firstIsTop ? _poTeal : _poRose,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'SliverPaintOrder.${v.name}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'index=${v.index}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        Text(
          'count = ${all.length}, '
          'default = ${SliverPaintOrder.firstIsTop.name}',
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    ),
  );
}

// =====================================================================
// TOP-LEVEL build()
// =====================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _poTeal),
      useMaterial3: true,
      scaffoldBackgroundColor: _poPaper,
    ),
    home: Scaffold(
      backgroundColor: _poPaper,
      appBar: AppBar(
        backgroundColor: _poTeal,
        foregroundColor: _poOnTeal,
        title: const Text('SliverPaintOrder · deep demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _poTitle('Sliver Paint Order — the SliverPaintOrder enum'),
              _poBody(
                'A live, hand-authored walkthrough of the '
                'SliverPaintOrder enum, the property that picks which '
                'sliver paints on top when slivers overlap inside a '
                'CustomScrollView.',
              ),
              _poDivider(),
              _poSection1Intro(),
              _poDivider(),
              _poSection2SideBySide(),
              _poDivider(),
              _poSection3MainAxisGroup(),
              _poDivider(),
              _poSection4CrossAxisGroup(),
              _poDivider(),
              _poSection5StackedFloating(),
              _poDivider(),
              _poSection6DropShadow(),
              _poDivider(),
              _poSection7MixedSlivers(),
              _poDivider(),
              _poSection8EdgeCases(),
              _poDivider(),
              _poSection9Recipes(),
              _poDivider(),
              _poSection10Reference(),
              _poDivider(),
              _poSection11GroupedBonus(),
              _poDivider(),
              _poSection12Horizontal(),
              _poDivider(),
              _poSection13AppBarStack(),
              _poDivider(),
              _poSection14HitTest(),
              _poDivider(),
              _poSection15Summary(),
              _poDivider(),
              _poSection16Diagnostic(),
              const SizedBox(height: 28),
              Center(
                child: Opacity(
                  opacity: 0.6,
                  child: Text(
                    '— end of SliverPaintOrder demo —  ${_ref.name} / '
                    '${_refDefault.name}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: _poDark,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
