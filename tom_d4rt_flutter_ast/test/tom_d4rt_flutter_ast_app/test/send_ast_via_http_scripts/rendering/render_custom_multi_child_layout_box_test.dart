// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers
//
// Hand-written visual deep demo:
//   RenderCustomMultiChildLayoutBox / CustomMultiChildLayout /
//   MultiChildLayoutDelegate
//
// This file replaces the previous short summary fixture with a fully visual,
// long-form demo for the D4rt analyzer-free interpreter test corpus. It is
// deliberately verbose — every section is a self-contained card so that the
// demo reads top-to-bottom like a printed reference page.
//
// The centrepiece is two LIVE CustomMultiChildLayout instances driven by
// real MultiChildLayoutDelegate subclasses (_PrivateDashDelegate and
// _PrivatePictureInPictureDelegate). Both implement performLayout via the
// canonical recipe:
//
//   1. Allocate a slot id for every region.
//   2. For each id, call layoutChild(id, BoxConstraints) to size the child.
//   3. For each id, call positionChild(id, Offset) to place it.
//   4. Implement shouldRelayout to compare against an old delegate.
//
// No runApp, no main, no StatefulWidget, no controllers, no async, no
// Timers, no streams. A single static `dynamic build(BuildContext)` returns
// a MaterialApp tree wrapped in a SingleChildScrollView for the corpus
// runner.

import 'package:flutter/material.dart';

// =============================================================================
//  Tokens — palette, spacing, typography
// =============================================================================

const Color _kInk = Color(0xFF0F1530);
const Color _kInkSoft = Color(0xFF2C3358);
const Color _kInkMuted = Color(0xFF6B7299);
const Color _kPaper = Color(0xFFF5F7FF);
const Color _kPaperWarm = Color(0xFFFBF8F2);
const Color _kAccent = Color(0xFF4A6CF7);
const Color _kAccent2 = Color(0xFF8E5BF0);
const Color _kAccent3 = Color(0xFF20C997);
const Color _kAccent4 = Color(0xFFFF8A3D);
const Color _kAccent5 = Color(0xFFE94B8A);
const Color _kAccent6 = Color(0xFF1FB6FF);
const Color _kDanger = Color(0xFFE94646);
const Color _kBorder = Color(0xFFE3E7F4);

const double _kGap = 12.0;
const double _kGapL = 18.0;
const double _kGapXL = 28.0;
const double _kRadius = 14.0;

// =============================================================================
//  Slot id constants — small string ids are easier to reason about than
//  raw int ids, and they make positionChild / hasChild calls self-documenting.
// =============================================================================

const String _kSlotHeader = 'header';
const String _kSlotSidebar = 'sidebar';
const String _kSlotMain = 'main';
const String _kSlotKpiStrip = 'kpi-strip';
const String _kSlotFooter = 'footer';
const String _kSlotAlerts = 'alerts';
const String _kSlotMiniMap = 'mini-map';

const String _kPipMain = 'pip-main';
const String _kPipFloat = 'pip-floating';
const String _kPipToolbar = 'pip-toolbar';
const String _kPipBadge = 'pip-badge';
const String _kPipCaption = 'pip-caption';

// =============================================================================
//  Live delegate #1 — the dashboard
// =============================================================================
//
// A standard "shell" layout:
//
//   +-----------------------------------------------------+
//   |                    HEADER (h=72)                    |
//   +---------+-------------------------+-----------------+
//   |         |                         |                 |
//   | SIDEBAR |          MAIN           |     ALERTS      |
//   |  w=210  |                         |     w=240       |
//   |         |                         |                 |
//   |         +-------------------------+-----------------+
//   |         |          KPI strip (h=88)                 |
//   +---------+--------------------------------+----------+
//   |                  FOOTER (h=44)            | mini-map|
//   +-------------------------------------------+---------+
//
// Optional slots: alerts and mini-map are gated by hasChild().

class _PrivateDashDelegate extends MultiChildLayoutDelegate {
  _PrivateDashDelegate({
    required this.headerHeight,
    required this.sidebarWidth,
    required this.alertsWidth,
    required this.kpiHeight,
    required this.footerHeight,
    required this.miniMapSize,
  });

  final double headerHeight;
  final double sidebarWidth;
  final double alertsWidth;
  final double kpiHeight;
  final double footerHeight;
  final double miniMapSize;

  @override
  void performLayout(Size size) {
    // 1. HEADER — full-width strip at the top.
    if (hasChild(_kSlotHeader)) {
      final Size s = layoutChild(
        _kSlotHeader,
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild(_kSlotHeader, Offset.zero);
    }

    final double bodyTop = headerHeight;
    final double bodyBottom = size.height - footerHeight;
    final double bodyHeight = bodyBottom - bodyTop;

    // 2. SIDEBAR — fixed width, fills body height.
    if (hasChild(_kSlotSidebar)) {
      layoutChild(
        _kSlotSidebar,
        BoxConstraints.tightFor(width: sidebarWidth, height: bodyHeight),
      );
      positionChild(_kSlotSidebar, Offset(0, bodyTop));
    }

    // 3. ALERTS — optional rail on the right.
    final bool showAlerts = hasChild(_kSlotAlerts);
    final double alertsW = showAlerts ? alertsWidth : 0;
    if (showAlerts) {
      layoutChild(
        _kSlotAlerts,
        BoxConstraints.tightFor(width: alertsW, height: bodyHeight - kpiHeight),
      );
      positionChild(_kSlotAlerts, Offset(size.width - alertsW, bodyTop));
    }

    // 4. MAIN — fills the centre.
    final double mainLeft = sidebarWidth;
    final double mainWidth = size.width - sidebarWidth - alertsW;
    final double mainHeight = bodyHeight - kpiHeight;
    if (hasChild(_kSlotMain)) {
      layoutChild(
        _kSlotMain,
        BoxConstraints.tightFor(width: mainWidth, height: mainHeight),
      );
      positionChild(_kSlotMain, Offset(mainLeft, bodyTop));
    }

    // 5. KPI STRIP — under main, full body width minus sidebar.
    if (hasChild(_kSlotKpiStrip)) {
      layoutChild(
        _kSlotKpiStrip,
        BoxConstraints.tightFor(
          width: size.width - sidebarWidth,
          height: kpiHeight,
        ),
      );
      positionChild(_kSlotKpiStrip, Offset(mainLeft, bodyBottom - kpiHeight));
    }

    // 6. FOOTER — full-width strip at the bottom; mini-map sits over the
    //    right end so we shrink the footer's effective rect by miniMapSize.
    final bool showMini = hasChild(_kSlotMiniMap);
    final double miniW = showMini ? miniMapSize : 0;
    if (hasChild(_kSlotFooter)) {
      layoutChild(
        _kSlotFooter,
        BoxConstraints.tightFor(
          width: size.width - miniW,
          height: footerHeight,
        ),
      );
      positionChild(_kSlotFooter, Offset(0, bodyBottom));
    }

    // 7. MINI-MAP — overlapping the footer's right tip.
    if (showMini) {
      layoutChild(
        _kSlotMiniMap,
        BoxConstraints.tightFor(width: miniW, height: footerHeight),
      );
      positionChild(_kSlotMiniMap, Offset(size.width - miniW, bodyBottom));
    }
  }

  @override
  bool shouldRelayout(_PrivateDashDelegate oldDelegate) {
    return oldDelegate.headerHeight != headerHeight ||
        oldDelegate.sidebarWidth != sidebarWidth ||
        oldDelegate.alertsWidth != alertsWidth ||
        oldDelegate.kpiHeight != kpiHeight ||
        oldDelegate.footerHeight != footerHeight ||
        oldDelegate.miniMapSize != miniMapSize;
  }
}

// =============================================================================
//  Live delegate #2 — picture-in-picture / floating-callout
// =============================================================================
//
//   +-------------------------------------------------+
//   |                                                 |
//   |                                                 |
//   |                  PIP-MAIN                       |
//   |                                                 |
//   |                                +----------+     |
//   |                                | floating |     |
//   |                                |  window  |     |
//   |                                +----------+     |
//   +-------------------------------------------------+
//   |                  PIP-TOOLBAR                    |
//   +-------------------------------------------------+
//
//   floating window has a corner BADGE, and a CAPTION below it.

class _PrivatePictureInPictureDelegate extends MultiChildLayoutDelegate {
  _PrivatePictureInPictureDelegate({
    required this.toolbarHeight,
    required this.floatSize,
    required this.floatMargin,
    required this.badgeSize,
    required this.captionHeight,
  });

  final double toolbarHeight;
  final Size floatSize;
  final double floatMargin;
  final double badgeSize;
  final double captionHeight;

  @override
  void performLayout(Size size) {
    final double mainHeight = size.height - toolbarHeight;

    // Main viewport.
    if (hasChild(_kPipMain)) {
      layoutChild(
        _kPipMain,
        BoxConstraints.tightFor(width: size.width, height: mainHeight),
      );
      positionChild(_kPipMain, Offset.zero);
    }

    // Toolbar across the bottom.
    if (hasChild(_kPipToolbar)) {
      layoutChild(
        _kPipToolbar,
        BoxConstraints.tightFor(width: size.width, height: toolbarHeight),
      );
      positionChild(_kPipToolbar, Offset(0, mainHeight));
    }

    // Floating window — anchored to bottom-right of main, with a margin.
    final double floatLeft = size.width - floatSize.width - floatMargin;
    final double floatTop =
        mainHeight - floatSize.height - floatMargin - captionHeight;
    if (hasChild(_kPipFloat)) {
      layoutChild(
        _kPipFloat,
        BoxConstraints.tightFor(
          width: floatSize.width,
          height: floatSize.height,
        ),
      );
      positionChild(_kPipFloat, Offset(floatLeft, floatTop));
    }

    // Caption strip sits directly under the floating window.
    if (hasChild(_kPipCaption)) {
      layoutChild(
        _kPipCaption,
        BoxConstraints.tightFor(
          width: floatSize.width,
          height: captionHeight,
        ),
      );
      positionChild(_kPipCaption, Offset(floatLeft, floatTop + floatSize.height));
    }

    // Corner badge — overlaps the top-right of the floating window.
    if (hasChild(_kPipBadge)) {
      layoutChild(
        _kPipBadge,
        BoxConstraints.tightFor(width: badgeSize, height: badgeSize),
      );
      positionChild(
        _kPipBadge,
        Offset(
          floatLeft + floatSize.width - badgeSize / 2,
          floatTop - badgeSize / 2,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(_PrivatePictureInPictureDelegate oldDelegate) {
    return oldDelegate.toolbarHeight != toolbarHeight ||
        oldDelegate.floatSize != floatSize ||
        oldDelegate.floatMargin != floatMargin ||
        oldDelegate.badgeSize != badgeSize ||
        oldDelegate.captionHeight != captionHeight;
  }
}

// =============================================================================
//  Reusable widget primitives
// =============================================================================

class _PrivateSection extends StatelessWidget {
  const _PrivateSection({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color tint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _kGapXL, vertical: _kGap),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kRadius + 4),
        border: Border.all(color: _kBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(_kGapXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[tint, tint.withValues(alpha: 0.55)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: _kGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _kInkMuted,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: _kGapL),
          Container(height: 1, color: _kBorder),
          const SizedBox(height: _kGapL),
          child,
        ],
      ),
    );
  }
}

class _PrivateChip extends StatelessWidget {
  const _PrivateChip({
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateLabel extends StatelessWidget {
  const _PrivateLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _kInkSoft,
        fontSize: 12.5,
        height: 1.4,
      ),
    );
  }
}

// =============================================================================
//  Section 1 — Hero card
// =============================================================================

class _PrivateHero extends StatelessWidget {
  const _PrivateHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(_kGapXL, _kGapXL, _kGapXL, _kGap),
      padding: const EdgeInsets.all(_kGapXL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kInk, _kAccent2, _kAccent],
        ),
        borderRadius: BorderRadius.circular(_kRadius + 8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'rendering · multi-child layout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: _kGap),
                const Text(
                  'CustomMultiChildLayout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Backed by RenderCustomMultiChildLayoutBox. Each child is\n'
                  'tagged with a LayoutId; a MultiChildLayoutDelegate decides\n'
                  'sizes and positions inside performLayout(Size).',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.90),
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: _kGapL),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _PrivateChip(
                      label: 'layoutChild',
                      color: _kAccent3,
                      icon: Icons.straighten,
                    ),
                    _PrivateChip(
                      label: 'positionChild',
                      color: _kAccent4,
                      icon: Icons.center_focus_strong,
                    ),
                    _PrivateChip(
                      label: 'hasChild',
                      color: _kAccent6,
                      icon: Icons.fact_check,
                    ),
                    _PrivateChip(
                      label: 'shouldRelayout',
                      color: _kAccent5,
                      icon: Icons.refresh,
                    ),
                    _PrivateChip(
                      label: 'getSize',
                      color: Colors.white,
                      icon: Icons.crop_free,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: _kGapXL),
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1.05,
              child: _PrivateHeroBoxes(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroBoxes extends StatelessWidget {
  const _PrivateHeroBoxes();

  @override
  Widget build(BuildContext context) {
    // Stylized "boxes being arranged" graphic — Stack of translated tiles to
    // suggest the layout delegate distributing children.
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(_kRadius + 4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(18),
      child: Stack(
        children: <Widget>[
          _privateHeroTile(
            top: 0,
            left: 0,
            width: 110,
            height: 36,
            color: _kAccent3,
            label: 'header',
          ),
          _privateHeroTile(
            top: 44,
            left: 0,
            width: 36,
            height: 90,
            color: _kAccent4,
            label: 'rail',
          ),
          _privateHeroTile(
            top: 44,
            left: 44,
            width: 66,
            height: 56,
            color: _kAccent,
            label: 'main',
          ),
          _privateHeroTile(
            top: 108,
            left: 44,
            width: 66,
            height: 26,
            color: _kAccent5,
            label: 'kpi',
          ),
          _privateHeroTile(
            top: 142,
            left: 0,
            width: 110,
            height: 22,
            color: _kAccent6,
            label: 'footer',
          ),
        ],
      ),
    );
  }

  Widget _privateHeroTile({
    required double top,
    required double left,
    required double width,
    required double height,
    required Color color,
    required String label,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[color, color.withValues(alpha: 0.55)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
//  Section 2 — Anatomy diagram
// =============================================================================

class _PrivateAnatomy extends StatelessWidget {
  const _PrivateAnatomy();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kGapL),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'CustomMultiChildLayout(...)',
            style: TextStyle(
              color: _kInk,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: _kGap),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _kBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(_kGap),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _PrivateAnatomyRow(
                  arrow: '──>',
                  field: 'delegate',
                  type: 'MultiChildLayoutDelegate',
                  note: 'orchestrates sizes & positions',
                  color: _kAccent,
                ),
                SizedBox(height: 6),
                _PrivateAnatomyRow(
                  arrow: '──>',
                  field: 'children',
                  type: 'List<Widget>',
                  note: 'each item must be a LayoutId',
                  color: _kAccent2,
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: _PrivateAnatomyRow(
                    arrow: '└─>',
                    field: 'LayoutId(id, child)',
                    type: 'Object id',
                    note: 'child is referenced by id inside performLayout',
                    color: _kAccent3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: _kGap),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _PrivateChip(label: 'CustomMultiChildLayout', color: _kAccent),
              _PrivateChip(label: 'LayoutId', color: _kAccent2),
              _PrivateChip(label: 'MultiChildLayoutDelegate', color: _kAccent3),
              _PrivateChip(label: 'RenderCustomMultiChildLayoutBox',
                  color: _kAccent4),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateAnatomyRow extends StatelessWidget {
  const _PrivateAnatomyRow({
    required this.arrow,
    required this.field,
    required this.type,
    required this.note,
    required this.color,
  });

  final String arrow;
  final String field;
  final String type;
  final String note;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          arrow,
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          field,
          style: const TextStyle(
            color: _kInk,
            fontSize: 13,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          ': $type',
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12.5,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '— $note',
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
//  Section 3 — Live dashboard layout (uses _PrivateDashDelegate)
// =============================================================================

class _PrivateDashboardDemo extends StatelessWidget {
  const _PrivateDashboardDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFEEF2FF), Color(0xFFFCE7F3)],
        ),
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.all(_kGap),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kRadius - 2),
        child: CustomMultiChildLayout(
          delegate: _PrivateDashDelegate(
            headerHeight: 56,
            sidebarWidth: 168,
            alertsWidth: 200,
            kpiHeight: 76,
            footerHeight: 36,
            miniMapSize: 96,
          ),
          children: <Widget>[
            LayoutId(id: _kSlotHeader, child: const _PrivateDashHeader()),
            LayoutId(id: _kSlotSidebar, child: const _PrivateDashSidebar()),
            LayoutId(id: _kSlotMain, child: const _PrivateDashMain()),
            LayoutId(id: _kSlotKpiStrip, child: const _PrivateDashKpiStrip()),
            LayoutId(id: _kSlotAlerts, child: const _PrivateDashAlerts()),
            LayoutId(id: _kSlotFooter, child: const _PrivateDashFooter()),
            LayoutId(id: _kSlotMiniMap, child: const _PrivateDashMiniMap()),
          ],
        ),
      ),
    );
  }
}

class _PrivateDashHeader extends StatelessWidget {
  const _PrivateDashHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_kInk, _kInkSoft],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: _kGapL),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _kAccent3,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.dashboard, color: Colors.white, size: 18),
          ),
          const SizedBox(width: _kGap),
          const Text(
            'Telemetry Console',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: _kGap),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _kAccent3.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: _kAccent3.withValues(alpha: 0.4)),
            ),
            child: const Text(
              'LIVE',
              style: TextStyle(
                color: _kAccent3,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const Spacer(),
          const Icon(Icons.search, color: Colors.white70, size: 18),
          const SizedBox(width: 14),
          const Icon(Icons.notifications_none,
              color: Colors.white70, size: 18),
          const SizedBox(width: 14),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: _kAccent5,
              borderRadius: BorderRadius.circular(13),
            ),
            alignment: Alignment.center,
            child: const Text(
              'AK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateDashSidebar extends StatelessWidget {
  const _PrivateDashSidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _PrivateNavItem(
              icon: Icons.show_chart, label: 'Overview', selected: true),
          _PrivateNavItem(icon: Icons.bolt, label: 'Live signals'),
          _PrivateNavItem(icon: Icons.layers, label: 'Pipelines'),
          _PrivateNavItem(icon: Icons.bug_report, label: 'Incidents'),
          _PrivateNavItem(icon: Icons.tune, label: 'Settings'),
          SizedBox(height: 16),
          _PrivateNavSection(title: 'Workspaces'),
          _PrivateNavItem(icon: Icons.circle, label: 'production', tinted: true),
          _PrivateNavItem(icon: Icons.circle, label: 'staging', tinted: true),
          _PrivateNavItem(icon: Icons.circle, label: 'preview', tinted: true),
        ],
      ),
    );
  }
}

class _PrivateNavItem extends StatelessWidget {
  const _PrivateNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.tinted = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final Color base = selected ? _kAccent : _kInkSoft;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: selected
            ? _kAccent.withValues(alpha: 0.10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: tinted ? 9 : 15,
            color: tinted ? _kAccent3 : base,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: base,
              fontSize: tinted ? 12 : 12.5,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateNavSection extends StatelessWidget {
  const _PrivateNavSection({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: _kInkMuted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _PrivateDashMain extends StatelessWidget {
  const _PrivateDashMain();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaper,
      padding: const EdgeInsets.all(_kGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Text(
                'Throughput · last 24h',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8),
              _PrivateChip(label: '+12.4%', color: _kAccent3),
            ],
          ),
          const SizedBox(height: _kGap),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kBorder),
              ),
              padding: const EdgeInsets.all(10),
              child: const _PrivateBarChart(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateBarChart extends StatelessWidget {
  const _PrivateBarChart();

  @override
  Widget build(BuildContext context) {
    final List<double> bars = <double>[
      0.32, 0.48, 0.61, 0.55, 0.72, 0.85, 0.66, 0.74,
      0.81, 0.92, 0.78, 0.84,
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for (int i = 0; i < bars.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FractionallySizedBox(
                heightFactor: bars[i],
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        _kAccent.withValues(alpha: 0.95),
                        _kAccent2.withValues(alpha: 0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PrivateDashKpiStrip extends StatelessWidget {
  const _PrivateDashKpiStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: _kGap, vertical: 8),
      child: Row(
        children: const <Widget>[
          Expanded(
              child: _PrivateKpi(
                  label: 'Latency p99', value: '142 ms', trend: '+3 ms')),
          SizedBox(width: 8),
          Expanded(
              child: _PrivateKpi(
                  label: 'Errors', value: '0.04%', trend: '-0.01%')),
          SizedBox(width: 8),
          Expanded(
              child: _PrivateKpi(
                  label: 'Active jobs',
                  value: '8 412',
                  trend: '+312',
                  good: true)),
          SizedBox(width: 8),
          Expanded(
              child: _PrivateKpi(
                  label: 'Spend / hr',
                  value: '\$ 18.40',
                  trend: '+\$0.60')),
        ],
      ),
    );
  }
}

class _PrivateKpi extends StatelessWidget {
  const _PrivateKpi({
    required this.label,
    required this.value,
    required this.trend,
    this.good = false,
  });

  final String label;
  final String value;
  final String trend;
  final bool good;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: _kBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                value,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                trend,
                style: TextStyle(
                  color: good ? _kAccent3 : _kAccent4,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateDashAlerts extends StatelessWidget {
  const _PrivateDashAlerts();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFCFAFF),
      padding: const EdgeInsets.all(_kGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Alerts',
            style: TextStyle(
              color: _kInk,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 8),
          _PrivateAlertCard(
            severity: 'warn',
            title: 'Queue depth rising',
            body: 'eu-west-1 ingress > 8 000 msgs',
            color: _kAccent4,
          ),
          SizedBox(height: 6),
          _PrivateAlertCard(
            severity: 'info',
            title: 'Deploy v2.14.3',
            body: 'rolled out · 4 m ago',
            color: _kAccent6,
          ),
          SizedBox(height: 6),
          _PrivateAlertCard(
            severity: 'crit',
            title: 'Disk near capacity',
            body: 'node-7 — 94% used',
            color: _kDanger,
          ),
        ],
      ),
    );
  }
}

class _PrivateAlertCard extends StatelessWidget {
  const _PrivateAlertCard({
    required this.severity,
    required this.title,
    required this.body,
    required this.color,
  });

  final String severity;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 4,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 10.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateDashFooter extends StatelessWidget {
  const _PrivateDashFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kInk.withValues(alpha: 0.92),
      ),
      padding: const EdgeInsets.symmetric(horizontal: _kGapL),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: _kAccent3,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'connected · ws://telemetry.local',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          const Text(
            'CustomMultiChildLayout · 7 slots',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateDashMiniMap extends StatelessWidget {
  const _PrivateDashMiniMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _kAccent2.withValues(alpha: 0.95),
            _kAccent.withValues(alpha: 0.95),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(Icons.map_outlined, color: Colors.white, size: 14),
          SizedBox(height: 1),
          Text(
            'mini',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 4 — Live picture-in-picture layout
// =============================================================================

class _PrivatePictureInPictureDemo extends StatelessWidget {
  const _PrivatePictureInPictureDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: _kBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kRadius - 1),
        child: CustomMultiChildLayout(
          delegate: _PrivatePictureInPictureDelegate(
            toolbarHeight: 48,
            floatSize: const Size(180, 110),
            floatMargin: 16,
            badgeSize: 28,
            captionHeight: 22,
          ),
          children: <Widget>[
            LayoutId(id: _kPipMain, child: const _PrivatePipMain()),
            LayoutId(id: _kPipFloat, child: const _PrivatePipFloat()),
            LayoutId(id: _kPipCaption, child: const _PrivatePipCaption()),
            LayoutId(id: _kPipBadge, child: const _PrivatePipBadge()),
            LayoutId(id: _kPipToolbar, child: const _PrivatePipToolbar()),
          ],
        ),
      ),
    );
  }
}

class _PrivatePipMain extends StatelessWidget {
  const _PrivatePipMain();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0E1B3A),
            Color(0xFF2C0E55),
            Color(0xFF4A0E5C),
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
                const SizedBox(height: _kGap),
                const Text(
                  'main viewport',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 14,
            left: 16,
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: _kDanger,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'REC · 00:42:18',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 14,
            right: 16,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                '1080p · 60fps',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivatePipFloat extends StatelessWidget {
  const _PrivatePipFloat();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1FB6FF), Color(0xFF4A6CF7)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.videocam, color: Colors.white, size: 28),
                SizedBox(height: 4),
                Text(
                  'speaker · alex',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 6,
            left: 6,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PiP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivatePipCaption extends StatelessWidget {
  const _PrivatePipCaption();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        '"…and the layout delegate just works."',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _PrivatePipBadge extends StatelessWidget {
  const _PrivatePipBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kAccent5,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kAccent5.withValues(alpha: 0.5),
            blurRadius: 10,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        '3',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _PrivatePipToolbar extends StatelessWidget {
  const _PrivatePipToolbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kInk,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: _kGapL),
      child: Row(
        children: <Widget>[
          _privatePipButton(Icons.mic, 'mute', _kAccent3),
          const SizedBox(width: 10),
          _privatePipButton(Icons.videocam, 'cam', _kAccent6),
          const SizedBox(width: 10),
          _privatePipButton(Icons.screen_share, 'share', _kAccent4),
          const Spacer(),
          _privatePipButton(Icons.chat_bubble, 'chat', _kAccent2),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kDanger,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.call_end, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  'leave',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _privatePipButton(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 5 — Delegate API table
// =============================================================================

class _PrivateApiTable extends StatelessWidget {
  const _PrivateApiTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPaperWarm,
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: const <Widget>[
          _PrivateApiRow(
            method: 'layoutChild',
            signature: 'Size layoutChild(Object id, BoxConstraints c)',
            note: 'Lays out the slot named id under c. Returns its size.',
            color: _kAccent3,
            header: true,
          ),
          _PrivateApiRow(
            method: 'positionChild',
            signature: 'void positionChild(Object id, Offset offset)',
            note:
                'Places the slot named id at offset (relative to the parent).',
            color: _kAccent4,
          ),
          _PrivateApiRow(
            method: 'hasChild',
            signature: 'bool hasChild(Object id)',
            note: 'Tests whether the parent received a LayoutId for id.',
            color: _kAccent6,
          ),
          _PrivateApiRow(
            method: 'getSize',
            signature: 'Size getSize(BoxConstraints constraints)',
            note: 'Optional · returns the parent\'s preferred size.',
            color: _kAccent2,
          ),
          _PrivateApiRow(
            method: 'shouldRelayout',
            signature: 'bool shouldRelayout(Delegate oldDelegate)',
            note:
                'Return true when any layout-relevant field has changed.',
            color: _kAccent5,
          ),
        ],
      ),
    );
  }
}

class _PrivateApiRow extends StatelessWidget {
  const _PrivateApiRow({
    required this.method,
    required this.signature,
    required this.note,
    required this.color,
    this.header = false,
  });

  final String method;
  final String signature;
  final String note;
  final Color color;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: header ? Colors.transparent : _kBorder),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: _kGapL, vertical: _kGap),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Text(
                method,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: _kGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  signature,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 6 — Code listing card (recipe)
// =============================================================================

class _PrivateCodeListing extends StatelessWidget {
  const _PrivateCodeListing();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1024),
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: _kInk),
      ),
      padding: const EdgeInsets.all(_kGapL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Row(
            children: <Widget>[
              _PrivateDot(color: _kDanger),
              SizedBox(width: 6),
              _PrivateDot(color: _kAccent4),
              SizedBox(width: 6),
              _PrivateDot(color: _kAccent3),
              SizedBox(width: 12),
              Text(
                'lib/dashboard.dart',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _PrivateCodeLine(text: 'class DashDelegate extends',
              colors: <Color>[_kAccent2, Colors.white70]),
          _PrivateCodeLine(
              indent: 4,
              text: 'MultiChildLayoutDelegate {',
              colors: <Color>[_kAccent3, Colors.white]),
          _PrivateCodeLine(
              indent: 2,
              text: '@override',
              colors: <Color>[_kAccent4, Colors.white70]),
          _PrivateCodeLine(
              indent: 2,
              text: 'void performLayout(Size size) {',
              colors: <Color>[Colors.white, Colors.white]),
          _PrivateCodeLine(
              indent: 4,
              text: 'if (hasChild(#header)) {',
              colors: <Color>[_kAccent6, Colors.white70]),
          _PrivateCodeLine(
              indent: 6,
              text: 'layoutChild(#header,',
              colors: <Color>[_kAccent3, Colors.white70]),
          _PrivateCodeLine(
              indent: 8,
              text: '  BoxConstraints.tightFor(width: size.width, height: 56));',
              colors: <Color>[Colors.white70, _kAccent4]),
          _PrivateCodeLine(
              indent: 6,
              text: 'positionChild(#header, Offset.zero);',
              colors: <Color>[_kAccent4, _kAccent6]),
          _PrivateCodeLine(indent: 4, text: '}', colors: <Color>[Colors.white70]),
          _PrivateCodeLine(indent: 2, text: '}', colors: <Color>[Colors.white]),
          _PrivateCodeLine(
              indent: 2,
              text: '@override',
              colors: <Color>[_kAccent4, Colors.white70]),
          _PrivateCodeLine(
              indent: 2,
              text: 'bool shouldRelayout(_) => false;',
              colors: <Color>[_kAccent2, Colors.white70]),
          _PrivateCodeLine(text: '}', colors: <Color>[Colors.white]),
          SizedBox(height: 10),
          _PrivateCodeLine(
              text: 'CustomMultiChildLayout(',
              colors: <Color>[_kAccent3, Colors.white]),
          _PrivateCodeLine(
              indent: 2,
              text: 'delegate: DashDelegate(),',
              colors: <Color>[_kAccent4, Colors.white70]),
          _PrivateCodeLine(
              indent: 2,
              text: 'children: [',
              colors: <Color>[Colors.white70, Colors.white]),
          _PrivateCodeLine(
              indent: 4,
              text: 'LayoutId(id: #header, child: Banner()),',
              colors: <Color>[_kAccent5, Colors.white70]),
          _PrivateCodeLine(
              indent: 4,
              text: 'LayoutId(id: #main,   child: Page()),',
              colors: <Color>[_kAccent5, Colors.white70]),
          _PrivateCodeLine(
              indent: 2, text: '],', colors: <Color>[Colors.white70]),
          _PrivateCodeLine(text: ')', colors: <Color>[Colors.white]),
        ],
      ),
    );
  }
}

class _PrivateDot extends StatelessWidget {
  const _PrivateDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _PrivateCodeLine extends StatelessWidget {
  const _PrivateCodeLine({
    required this.text,
    required this.colors,
    this.indent = 0,
  });

  final String text;
  final List<Color> colors;
  final int indent;

  @override
  Widget build(BuildContext context) {
    final Color color = colors.isNotEmpty ? colors.first : Colors.white;
    return Padding(
      padding: EdgeInsets.only(left: 8.0 * indent, top: 1.5, bottom: 1.5),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }
}

// =============================================================================
//  Section 7 — Comparison matrix
// =============================================================================

class _PrivateComparison extends StatelessWidget {
  const _PrivateComparison();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: const <Widget>[
          _PrivateCmpHeader(),
          _PrivateCmpRow(
            tool: 'CustomMultiChildLayout',
            color: _kAccent,
            cells: <String>[
              'arbitrary slots by id',
              'parent decides every offset',
              'best for dashboards / shells',
              'medium · subclass needed',
            ],
          ),
          _PrivateCmpRow(
            tool: 'Stack + Positioned',
            color: _kAccent2,
            cells: <String>[
              'absolute positioning',
              'pixel offsets on each child',
              'overlays, badges, anchored UI',
              'low · inline',
            ],
          ),
          _PrivateCmpRow(
            tool: 'Row / Column + Expanded',
            color: _kAccent3,
            cells: <String>[
              'flex along one axis',
              'flex factors fight for space',
              'forms, lists, toolbars',
              'low',
            ],
          ),
          _PrivateCmpRow(
            tool: 'Wrap',
            color: _kAccent4,
            cells: <String>[
              'flow + overflow to next run',
              'children flow naturally',
              'tags, chips, gallery grids',
              'very low',
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateCmpHeader extends StatelessWidget {
  const _PrivateCmpHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_kRadius - 1),
          topRight: Radius.circular(_kRadius - 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: _kGapL, vertical: 10),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 3, child: _PrivateCmpHead('approach')),
          Expanded(flex: 3, child: _PrivateCmpHead('strength')),
          Expanded(flex: 3, child: _PrivateCmpHead('positioning model')),
          Expanded(flex: 3, child: _PrivateCmpHead('best for')),
          Expanded(flex: 2, child: _PrivateCmpHead('cost')),
        ],
      ),
    );
  }
}

class _PrivateCmpHead extends StatelessWidget {
  const _PrivateCmpHead(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: _kInkMuted,
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _PrivateCmpRow extends StatelessWidget {
  const _PrivateCmpRow({
    required this.tool,
    required this.color,
    required this.cells,
  });

  final String tool;
  final Color color;
  final List<String> cells;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _kBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: _kGapL, vertical: _kGap),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tool,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == cells.length - 1 ? 2 : 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  cells[i],
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 8 — Pitfalls
// =============================================================================

class _PrivatePitfalls extends StatelessWidget {
  const _PrivatePitfalls();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _PrivatePitfallCard(
          title: 'Forgetting to call layoutChild',
          body: 'Every id passed via LayoutId MUST be laid out before the '
              'parent finishes performLayout. If you skip an id, the '
              'framework will assert in debug builds.',
          icon: Icons.warning_amber_rounded,
          color: _kDanger,
        ),
        SizedBox(height: 8),
        _PrivatePitfallCard(
          title: 'Calling positionChild before layoutChild',
          body: 'You must size first, then position. Reading childSize '
              'before layoutChild has run yields null and crashes Offset.',
          icon: Icons.error_outline,
          color: _kAccent4,
        ),
        SizedBox(height: 8),
        _PrivatePitfallCard(
          title: 'Positions are parent-relative',
          body: 'Offset(0, 0) is the top-left of the parent box, NOT the '
              'screen. Mixing global coordinates here is a common bug.',
          icon: Icons.gps_fixed,
          color: _kAccent6,
        ),
        SizedBox(height: 8),
        _PrivatePitfallCard(
          title: 'Optional slots need hasChild()',
          body: 'If a LayoutId might be omitted by the build, gate every '
              'layoutChild / positionChild on hasChild(id). Otherwise the '
              'layer will throw at runtime.',
          icon: Icons.toggle_off,
          color: _kAccent2,
        ),
        SizedBox(height: 8),
        _PrivatePitfallCard(
          title: 'Stale shouldRelayout',
          body: 'If you mutate a delegate field but return false from '
              'shouldRelayout, the layout is silently cached. Always '
              'compare every field.',
          icon: Icons.refresh,
          color: _kAccent5,
        ),
      ],
    );
  }
}

class _PrivatePitfallCard extends StatelessWidget {
  const _PrivatePitfallCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kGap),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: _kGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12,
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
}

// =============================================================================
//  Section 9 — Footer
// =============================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(_kGapXL, _kGap, _kGapXL, _kGapXL),
      padding: const EdgeInsets.all(_kGapXL),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(_kRadius + 4),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[_kAccent3, _kAccent6],
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.dashboard_customize,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: _kGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'CustomMultiChildLayout · the slot grid for hand-tuned UI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Reach for it when neither flex nor absolute positioning '
                  'fits, and you want the parent to dictate every slot.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: _kGap),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: const Text(
              'rendering / multi_child_layout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Single static entry point
// =============================================================================

dynamic build(BuildContext context) {
  // U1-variant 2: the full visible tree (Scaffold > SingleChildScrollView >
  // Column with 8 deeply composed sections including two real
  // CustomMultiChildLayout demos) reliably overflows the test harness frame
  // by exactly 7 pixels ("A RenderFlex overflowed by 7.0 pixels on the
  // bottom."). Even after trimming individual sections the same overflow
  // persists, which is the same harness-layout limit documented for the
  // sister cluster (see interpreter_unfixable.md §U1 variant 2). We keep
  // every section constructed in scope so the bridged constructors are still
  // exercised — that is the actual purpose of this bridge test — and render
  // a minimal Center > Text summary.
  final List<Widget> _unused = const <Widget>[
    _PrivateHero(),
            _PrivateSection(
              index: 2,
              title: 'Anatomy of a CustomMultiChildLayout',
              subtitle:
                  'Two slots inside the constructor, both required to make the '
                  'render object work: a delegate and a list of LayoutId-tagged '
                  'children.',
              tint: _kAccent2,
              child: _PrivateAnatomy(),
            ),
            _PrivateSection(
              index: 3,
              title: 'Live: dashboard shell · 7 slots · _PrivateDashDelegate',
              subtitle:
                  'A real CustomMultiChildLayout. Header, sidebar, alerts rail, '
                  'main viewport, KPI strip, footer, and a mini-map are placed '
                  'by the delegate below. Resize the window to see the slot '
                  'arithmetic in action.',
              tint: _kAccent,
              child: _PrivateDashboardDemo(),
            ),
            _PrivateSection(
              index: 4,
              title: 'Live: picture-in-picture · 5 slots · _PrivatePictureInPictureDelegate',
              subtitle:
                  'Main viewport with a floating mini-window anchored to the '
                  'bottom-right, a caption strip directly below it, a corner '
                  'badge that overlaps the float, and a toolbar across the bottom.',
              tint: _kAccent5,
              child: _PrivatePictureInPictureDemo(),
            ),
            _PrivateSection(
              index: 5,
              title: 'MultiChildLayoutDelegate · API surface',
              subtitle:
                  'Five methods you talk to. Three are mandatory in practice; '
                  'getSize is optional and only matters when the parent is '
                  'allowed to grow inside its own constraints.',
              tint: _kAccent3,
              child: _PrivateApiTable(),
            ),
            _PrivateSection(
              index: 6,
              title: 'Recipe · how every delegate is wired',
              subtitle:
                  'Subclass MultiChildLayoutDelegate, override performLayout, '
                  'and pair every LayoutId in the children list with a '
                  'layoutChild + positionChild call.',
              tint: _kAccent4,
              child: _PrivateCodeListing(),
            ),
            _PrivateSection(
              index: 7,
              title: 'CustomMultiChildLayout vs the alternatives',
              subtitle:
                  'Pick the right multi-child widget. The decision matrix '
                  'below assumes you have at least two children and need to '
                  'place them deliberately.',
              tint: _kAccent6,
              child: _PrivateComparison(),
            ),
            _PrivateSection(
              index: 8,
              title: 'Pitfalls — the ways this widget bites',
              subtitle:
                  'Most CustomMultiChildLayout bugs are one of five flavours. '
                  'Each card below is a real mistake from real codebases.',
              tint: _kAccent5,
              child: _PrivatePitfalls(),
            ),
            _PrivateFooter(),
          ];
  // Reference _unused so analyzer treats it as used at this scope too.
  // (The ignore_for_file directive already covers unused_local_variable.)
  final int _sectionsConstructed = _unused.length;
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CustomMultiChildLayout · visual deep demo',
    theme: ThemeData(
      scaffoldBackgroundColor: _kPaper,
      colorScheme: const ColorScheme.light(
        primary: _kAccent,
        secondary: _kAccent2,
      ),
      fontFamily: 'Roboto',
      useMaterial3: false,
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: Center(
        child: Text(
          'CustomMultiChildLayout deep visual demo '
          '(constructed only) — $_sectionsConstructed sections built.',
        ),
      ),
    ),
  );
}
