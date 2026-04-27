// SlottedMultiChildRenderObjectWidget — Full Slot-Widget Integration
//
// This demo showcases the UNIFIED CONCRETE widget that ships in the Flutter
// framework: `SlottedMultiChildRenderObjectWidget<SlotType, ChildType>`.
//
// Flutter actually provides THREE layers for slot-based composition:
//   - `SlottedContainerRenderObjectMixin`  (file 413 — render-object tier)
//   - `SlottedMultiChildRenderObjectWidgetMixin` (file 414 — widget tier)
//   - `SlottedMultiChildRenderObjectWidget` (file 415 — THIS FILE)
//   - `SlottedRenderObjectElement` (file 416 — element glue)
//
// File 415 is the *capstone* — it pre-applies the widget-tier mixin onto
// `RenderObjectWidget` and exposes a single abstract class that callers can
// `extend` directly, skipping the `with` incantation. Subclasses only have to
// implement:
//   - `Iterable<SlotType> get slots`
//   - `Widget? childForSlot(SlotType slot)`
//   - `RenderObject createRenderObject(BuildContext context)`  (required)
//   - `void updateRenderObject(...)`                            (as needed)
//
// This demo intentionally restricts itself to the CONCRETE-WIDGET INTEGRATION
// angle (sibling file 414 covers the mixin-in-isolation, 413 covers the
// render-object mixin, 416 covers the element). Here we focus on:
//
//   - What it means to extend the concrete abstract widget instead of
//     composing `RenderObjectWidget` + mixin manually.
//   - A realistic production-shaped subclass (`_SmcrowDashboardCard`) with six
//     slots.
//   - Four live specimens with distinct slot combinations.
//   - Architectural synthesis diagrams explaining how the three layers fuse.
//
// Visual brief — "Full Slot-Widget Integration":
//   - Teal-shadow   Color(0xFF1E5F6B)
//   - Champagne     Color(0xFFE8D5A8)
//   - Deep plum     Color(0xFF3F1F4A)
//
// Capstone / synthesis aesthetic: stacked layers, composition arrows, unified
// silhouettes. No ignore directives. No main(). No runApp(). Top-level `build`
// is the d4rt AST harness entry point.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// --------------------------------------------------------------------------
// Palette + typography helpers.
// --------------------------------------------------------------------------

const Color _kSmcrowTeal = Color(0xFF1E5F6B);
const Color _kSmcrowTealDeep = Color(0xFF0F3C46);
const Color _kSmcrowTealMist = Color(0xFF4A8A96);
const Color _kSmcrowChampagne = Color(0xFFE8D5A8);
const Color _kSmcrowChampagneDeep = Color(0xFFC9B07A);
const Color _kSmcrowChampagneSoft = Color(0xFFF4E8CB);
const Color _kSmcrowPlum = Color(0xFF3F1F4A);
const Color _kSmcrowPlumDeep = Color(0xFF2A0E33);
const Color _kSmcrowPlumBlush = Color(0xFF7A4F86);
const Color _kSmcrowParchment = Color(0xFFFAF6EC);
const Color _kSmcrowInk = Color(0xFF1A1420);

TextStyle _smcrowTitle({double size = 22, Color? color, FontWeight? weight}) {
  return TextStyle(
    fontSize: size,
    color: color ?? _kSmcrowInk,
    fontWeight: weight ?? FontWeight.w700,
    letterSpacing: 0.4,
    height: 1.2,
  );
}

TextStyle _smcrowBody({double size = 13, Color? color, FontWeight? weight}) {
  return TextStyle(
    fontSize: size,
    color: color ?? (_kSmcrowInk ?? const Color(0xFF000000)).withValues(alpha: 0.82),
    fontWeight: weight ?? FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.45,
  );
}

TextStyle _smcrowMono({double size = 12, Color? color}) {
  return TextStyle(
    fontSize: size,
    color: color ?? _kSmcrowInk,
    fontWeight: FontWeight.w500,
    fontFamily: 'monospace',
    letterSpacing: 0.1,
    height: 1.4,
  );
}

TextStyle _smcrowLabel({double size = 11, Color? color}) {
  return TextStyle(
    fontSize: size,
    color: color ?? _kSmcrowTealDeep,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.6,
  );
}

// --------------------------------------------------------------------------
// Slot definition for the production-shaped concrete subclass.
// --------------------------------------------------------------------------

/// The slot enumeration used by [_SmcrowDashboardCard]. It lists the six
/// logical regions the concrete widget is responsible for wiring up.
///
/// The order of the enum matters: the render object uses it both for layout
/// direction and for child-index stability across rebuilds.
enum _SmcrowDashboardSlot {
  icon,
  title,
  subtitle,
  primaryMetric,
  trendLine,
  actions,
}

String _smcrowSlotName(_SmcrowDashboardSlot s) {
  switch (s) {
    case _SmcrowDashboardSlot.icon:
      return 'icon';
    case _SmcrowDashboardSlot.title:
      return 'title';
    case _SmcrowDashboardSlot.subtitle:
      return 'subtitle';
    case _SmcrowDashboardSlot.primaryMetric:
      return 'primaryMetric';
    case _SmcrowDashboardSlot.trendLine:
      return 'trendLine';
    case _SmcrowDashboardSlot.actions:
      return 'actions';
  }
}

String _smcrowSlotResponsibility(_SmcrowDashboardSlot s) {
  switch (s) {
    case _SmcrowDashboardSlot.icon:
      return 'Leading glyph, fixed 32x32.';
    case _SmcrowDashboardSlot.title:
      return 'Primary identifier text.';
    case _SmcrowDashboardSlot.subtitle:
      return 'Secondary descriptor text.';
    case _SmcrowDashboardSlot.primaryMetric:
      return 'Hero numeric value.';
    case _SmcrowDashboardSlot.trendLine:
      return 'Small sparkline / trend graphic.';
    case _SmcrowDashboardSlot.actions:
      return 'Trailing action chips row.';
  }
}

// --------------------------------------------------------------------------
// Production-shaped concrete subclass.
//
// This is the whole point of file 415: extend the abstract widget directly,
// get the widget-tier mixin for free, and only have to answer the slot
// questions + wire the render object.
// --------------------------------------------------------------------------

class _SmcrowDashboardCard
    extends SlottedMultiChildRenderObjectWidget<_SmcrowDashboardSlot, RenderBox> {
  const _SmcrowDashboardCard({
    this.icon,
    this.title,
    this.subtitle,
    this.primaryMetric,
    this.trendLine,
    this.actions,
    this.accent = _kSmcrowTeal,
    this.surface = _kSmcrowParchment,
    this.radius = 14,
    this.minHeight = 120,
  });

  final Widget? icon;
  final Widget? title;
  final Widget? subtitle;
  final Widget? primaryMetric;
  final Widget? trendLine;
  final Widget? actions;

  final Color accent;
  final Color surface;
  final double radius;
  final double minHeight;

  @override
  Iterable<_SmcrowDashboardSlot> get slots => _SmcrowDashboardSlot.values;

  @override
  Widget? childForSlot(_SmcrowDashboardSlot slot) {
    switch (slot) {
      case _SmcrowDashboardSlot.icon:
        return icon;
      case _SmcrowDashboardSlot.title:
        return title;
      case _SmcrowDashboardSlot.subtitle:
        return subtitle;
      case _SmcrowDashboardSlot.primaryMetric:
        return primaryMetric;
      case _SmcrowDashboardSlot.trendLine:
        return trendLine;
      case _SmcrowDashboardSlot.actions:
        return actions;
    }
  }

  @override
  _SmcrowDashboardRender createRenderObject(BuildContext context) {
    return _SmcrowDashboardRender(
      accent: accent,
      surface: surface,
      radius: radius,
      minHeight: minHeight,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _SmcrowDashboardRender renderObject,
  ) {
    renderObject
      ..accent = accent
      ..surface = surface
      ..radius = radius
      ..minHeight = minHeight;
  }
}

/// The render object behind [_SmcrowDashboardCard]. It uses
/// [SlottedContainerRenderObjectMixin] so the concrete widget can hand us
/// children indexed by [_SmcrowDashboardSlot] via `childForSlot` from the
/// sibling mixin.
class _SmcrowDashboardRender extends RenderBox
    with SlottedContainerRenderObjectMixin<_SmcrowDashboardSlot, RenderBox> {
  _SmcrowDashboardRender({
    required Color accent,
    required Color surface,
    required double radius,
    required double minHeight,
  })  : _accent = accent,
        _surface = surface,
        _radius = radius,
        _minHeight = minHeight;

  Color _accent;
  Color get accent => _accent;
  set accent(Color value) {
    if (_accent == value) return;
    _accent = value;
    markNeedsPaint();
  }

  Color _surface;
  Color get surface => _surface;
  set surface(Color value) {
    if (_surface == value) return;
    _surface = value;
    markNeedsPaint();
  }

  double _radius;
  double get radius => _radius;
  set radius(double value) {
    if (_radius == value) return;
    _radius = value;
    markNeedsPaint();
  }

  double _minHeight;
  double get minHeight => _minHeight;
  set minHeight(double value) {
    if (_minHeight == value) return;
    _minHeight = value;
    markNeedsLayout();
  }

  RenderBox? _childFor(_SmcrowDashboardSlot slot) => childForSlot(slot);

  @override
  void performLayout() {
    final double maxW = constraints.hasBoundedWidth ? constraints.maxWidth : 320;
    final double padding = 14;
    final double innerW = math.max(0, maxW - padding * 2);

    final BoxConstraints iconC = BoxConstraints.tight(const Size(32, 32));
    final BoxConstraints titleC = BoxConstraints(maxWidth: innerW - 44);
    final BoxConstraints subC = BoxConstraints(maxWidth: innerW - 44);
    final BoxConstraints metricC = BoxConstraints(maxWidth: innerW);
    final BoxConstraints trendC = BoxConstraints(
      maxWidth: innerW,
      maxHeight: 40,
    );
    final BoxConstraints actionsC = BoxConstraints(maxWidth: innerW);

    final RenderBox? iconBox = _childFor(_SmcrowDashboardSlot.icon);
    final RenderBox? titleBox = _childFor(_SmcrowDashboardSlot.title);
    final RenderBox? subBox = _childFor(_SmcrowDashboardSlot.subtitle);
    final RenderBox? metricBox = _childFor(_SmcrowDashboardSlot.primaryMetric);
    final RenderBox? trendBox = _childFor(_SmcrowDashboardSlot.trendLine);
    final RenderBox? actionsBox = _childFor(_SmcrowDashboardSlot.actions);

    iconBox?.layout(iconC, parentUsesSize: true);
    titleBox?.layout(titleC, parentUsesSize: true);
    subBox?.layout(subC, parentUsesSize: true);
    metricBox?.layout(metricC, parentUsesSize: true);
    trendBox?.layout(trendC, parentUsesSize: true);
    actionsBox?.layout(actionsC, parentUsesSize: true);

    double dy = padding;
    final double headerH = math.max(
      iconBox?.size.height ?? 0,
      (titleBox?.size.height ?? 0) + (subBox?.size.height ?? 0) + 2,
    );

    if (iconBox != null) {
      _place(iconBox, Offset(padding, dy));
    }
    final double textX = padding + (iconBox != null ? 44 : 0);
    double textY = dy;
    if (titleBox != null) {
      _place(titleBox, Offset(textX, textY));
      textY += titleBox.size.height + 2;
    }
    if (subBox != null) {
      _place(subBox, Offset(textX, textY));
      textY += subBox.size.height;
    }

    dy += headerH + 10;
    if (metricBox != null) {
      _place(metricBox, Offset(padding, dy));
      dy += metricBox.size.height + 8;
    }
    if (trendBox != null) {
      _place(trendBox, Offset(padding, dy));
      dy += trendBox.size.height + 8;
    }
    if (actionsBox != null) {
      _place(actionsBox, Offset(padding, dy));
      dy += actionsBox.size.height;
    }
    dy += padding;

    size = Size(maxW, math.max(_minHeight, dy));
  }

  void _place(RenderBox child, Offset offset) {
    final BoxParentData parentData = child.parentData! as BoxParentData;
    parentData.offset = offset;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Rect rect = offset & size;
    final RRect rr = RRect.fromRectAndRadius(rect, Radius.circular(_radius));

    // Surface.
    final Paint surfacePaint = Paint()..color = _surface;
    canvas.drawRRect(rr, surfacePaint);

    // Accent ribbon along the left edge.
    final Paint ribbon = Paint()..color = _accent;
    final RRect ribbonR = RRect.fromLTRBAndCorners(
      rect.left,
      rect.top,
      rect.left + 5,
      rect.bottom,
      topLeft: Radius.circular(_radius),
      bottomLeft: Radius.circular(_radius),
    );
    canvas.drawRRect(ribbonR, ribbon);

    // Border.
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = (_accent ?? const Color(0xFF000000)).withValues(alpha: 0.35);
    canvas.drawRRect(rr, border);

    // Paint slotted children in enum order for deterministic Z.
    for (final _SmcrowDashboardSlot slot in _SmcrowDashboardSlot.values) {
      final RenderBox? child = _childFor(slot);
      if (child == null) continue;
      final BoxParentData parentData = child.parentData! as BoxParentData;
      context.paintChild(child, parentData.offset + offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final _SmcrowDashboardSlot slot in _SmcrowDashboardSlot.values) {
      final RenderBox? child = _childFor(slot);
      if (child == null) continue;
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool hit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult r, Offset p) {
          return child.hitTest(r, position: p);
        },
      );
      if (hit) return true;
    }
    return false;
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) => 220;
  @override
  double computeMaxIntrinsicWidth(double height) => 480;
  @override
  double computeMinIntrinsicHeight(double width) => _minHeight;
  @override
  double computeMaxIntrinsicHeight(double width) => 320;
}

// --------------------------------------------------------------------------
// Hero header — stacked capstone painter.
// --------------------------------------------------------------------------

class _SmcrowHeroHeader extends StatelessWidget {
  const _SmcrowHeroHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(painter: _SmcrowCapstonePainter()),
          ),
          Positioned(
            left: 32,
            top: 36,
            right: 32,
            child: Text(
              'SLOTTED · MULTI · CHILD · WIDGET',
              style: _smcrowLabel(
                size: 13,
                color: (_kSmcrowChampagne ?? const Color(0xFF000000)).withValues(alpha: 0.92),
              ),
            ),
          ),
          Positioned(
            left: 32,
            top: 60,
            right: 32,
            child: Text(
              'The Unified Concrete Capstone',
              style: _smcrowTitle(
                size: 34,
                color: _kSmcrowChampagne,
                weight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            left: 32,
            top: 114,
            right: 200,
            child: Text(
              'File 415 fuses the widget-tier mixin and the abstract slot '
              'contract into a single extendable class. Subclasses skip the '
              '"with" composition and answer only the slot questions.',
              style: _smcrowBody(
                size: 14,
                color: (_kSmcrowChampagneSoft ?? const Color(0xFF000000)).withValues(alpha: 0.92),
              ),
            ),
          ),
          Positioned(
            right: 28,
            top: 36,
            child: _SmcrowHeroBadge(),
          ),
        ],
      ),
    );
  }
}

class _SmcrowHeroBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: (_kSmcrowPlumDeep ?? const Color(0xFF000000)).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (_kSmcrowChampagne ?? const Color(0xFF000000)).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'FILE 415',
            style: _smcrowLabel(size: 10, color: _kSmcrowChampagne),
          ),
          const SizedBox(height: 2),
          Text(
            'concrete widget',
            style: _smcrowBody(size: 11, color: _kSmcrowChampagneSoft),
          ),
        ],
      ),
    );
  }
}

class _SmcrowCapstonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient.
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kSmcrowPlumDeep, _kSmcrowTealDeep, _kSmcrowPlum],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Three stacked "capstone" plates from narrow base to wide top.
    _drawPlate(
      canvas,
      size,
      yCenter: size.height * 0.76,
      width: size.width * 0.78,
      height: 28,
      color: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.55),
      label: 'render-object mixin',
    );
    _drawPlate(
      canvas,
      size,
      yCenter: size.height * 0.64,
      width: size.width * 0.64,
      height: 28,
      color: (_kSmcrowPlumBlush ?? const Color(0xFF000000)).withValues(alpha: 0.55),
      label: 'widget-tier mixin',
    );
    _drawPlate(
      canvas,
      size,
      yCenter: size.height * 0.52,
      width: size.width * 0.50,
      height: 30,
      color: (_kSmcrowChampagne ?? const Color(0xFF000000)).withValues(alpha: 0.85),
      label: 'abstract widget',
      labelColor: _kSmcrowInk,
    );

    // Arrow up through the stack.
    final Paint arrow = Paint()
      ..color = (_kSmcrowChampagne ?? const Color(0xFF000000)).withValues(alpha: 0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final double ax = size.width * 0.5;
    canvas.drawLine(
      Offset(ax, size.height * 0.80),
      Offset(ax, size.height * 0.42),
      arrow,
    );
    final Path head = Path()
      ..moveTo(ax - 6, size.height * 0.44)
      ..lineTo(ax, size.height * 0.40)
      ..lineTo(ax + 6, size.height * 0.44);
    canvas.drawPath(head, arrow);

    // Subtle starfield.
    final math.Random rng = math.Random(415);
    final Paint star = Paint()
      ..color = (_kSmcrowChampagneSoft ?? const Color(0xFF000000)).withValues(alpha: 0.18);
    for (int i = 0; i < 42; i++) {
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        rng.nextDouble() * 1.4 + 0.2,
        star,
      );
    }
  }

  void _drawPlate(
    Canvas canvas,
    Size size, {
    required double yCenter,
    required double width,
    required double height,
    required Color color,
    required String label,
    Color? labelColor,
  }) {
    final Rect r = Rect.fromCenter(
      center: Offset(size.width / 2, yCenter),
      width: width,
      height: height,
    );
    final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6));
    canvas.drawRRect(rr, Paint()..color = color);
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = (_kSmcrowChampagne ?? const Color(0xFF000000)).withValues(alpha: 0.45),
    );
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label.toUpperCase(),
        style: _smcrowLabel(
          size: 10,
          color: labelColor ?? _kSmcrowChampagne,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - 10);
    tp.paint(
      canvas,
      Offset(r.left + (width - tp.width) / 2, yCenter - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _SmcrowCapstonePainter oldDelegate) => false;
}

// --------------------------------------------------------------------------
// Section header.
// --------------------------------------------------------------------------

class _SmcrowSection extends StatelessWidget {
  const _SmcrowSection({
    required this.index,
    required this.label,
    required this.child,
  });

  final String index;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kSmcrowPlum,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  index,
                  style: _smcrowLabel(size: 11, color: _kSmcrowChampagne),
                ),
              ),
              const SizedBox(width: 12),
              Text(label, style: _smcrowTitle(size: 18)),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 1,
                  color: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Four live specimens — each one uses the SAME _SmcrowDashboardCard but with
// a different slot combination.
// --------------------------------------------------------------------------

class _SmcrowSpecimenAllFilled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SmcrowSpecimenFrame(
      caption: 'A. All six slots populated',
      subCaption: 'Maximum information density.',
      accent: _kSmcrowTeal,
      child: _SmcrowDashboardCard(
        accent: _kSmcrowTeal,
        surface: _kSmcrowChampagneSoft,
        minHeight: 170,
        icon: _SmcrowGlyph(color: _kSmcrowTeal, symbol: 'I'),
        title: Text('Monthly Revenue', style: _smcrowTitle(size: 15)),
        subtitle: Text(
          'Northern region · Q3',
          style: _smcrowBody(size: 12),
        ),
        primaryMetric: Text(
          'EUR 1.24M',
          style: _smcrowTitle(
            size: 28,
            color: _kSmcrowTealDeep,
            weight: FontWeight.w800,
          ),
        ),
        trendLine: _SmcrowSpark(
          color: _kSmcrowTeal,
          values: const <double>[4, 6, 5, 8, 7, 9, 10, 9, 12, 11, 14, 13],
        ),
        actions: _SmcrowActionsRow(
          accent: _kSmcrowTeal,
          labels: const <String>['EXPORT', 'DETAILS'],
        ),
      ),
    );
  }
}

class _SmcrowSpecimenIconTitleOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SmcrowSpecimenFrame(
      caption: 'B. Icon + title only',
      subCaption: 'Minimal banner variant.',
      accent: _kSmcrowChampagneDeep,
      child: _SmcrowDashboardCard(
        accent: _kSmcrowChampagneDeep,
        surface: const Color(0xFFFFFBF1),
        minHeight: 90,
        icon: _SmcrowGlyph(color: _kSmcrowChampagneDeep, symbol: 'B'),
        title: Text(
          'Broadcast channel',
          style: _smcrowTitle(size: 15, color: _kSmcrowPlum),
        ),
      ),
    );
  }
}

class _SmcrowSpecimenTrendEmphasis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SmcrowSpecimenFrame(
      caption: 'C. Trend-emphasis',
      subCaption: 'Metric + sparkline, no actions.',
      accent: _kSmcrowPlum,
      child: _SmcrowDashboardCard(
        accent: _kSmcrowPlum,
        surface: const Color(0xFFF2E8F5),
        minHeight: 160,
        icon: _SmcrowGlyph(color: _kSmcrowPlum, symbol: 'T'),
        title: Text(
          'Engagement trend',
          style: _smcrowTitle(size: 15, color: _kSmcrowPlumDeep),
        ),
        primaryMetric: Text(
          '+18.4%',
          style: _smcrowTitle(
            size: 26,
            color: _kSmcrowPlumDeep,
            weight: FontWeight.w800,
          ),
        ),
        trendLine: _SmcrowSpark(
          color: _kSmcrowPlumBlush,
          values: const <double>[2, 3, 5, 4, 6, 9, 7, 10, 12, 14, 13, 16],
        ),
      ),
    );
  }
}

class _SmcrowSpecimenActionsForward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SmcrowSpecimenFrame(
      caption: 'D. Actions-forward',
      subCaption: 'Title + subtitle + action chips.',
      accent: _kSmcrowTealMist,
      child: _SmcrowDashboardCard(
        accent: _kSmcrowTealMist,
        surface: const Color(0xFFEFF6F7),
        minHeight: 130,
        icon: _SmcrowGlyph(color: _kSmcrowTealMist, symbol: 'A'),
        title: Text(
          'Maintenance window',
          style: _smcrowTitle(size: 15, color: _kSmcrowTealDeep),
        ),
        subtitle: Text(
          'Scheduled Saturday 02:00 UTC',
          style: _smcrowBody(size: 12),
        ),
        actions: _SmcrowActionsRow(
          accent: _kSmcrowTealMist,
          labels: const <String>['RESCHEDULE', 'CANCEL', 'NOTIFY'],
        ),
      ),
    );
  }
}

class _SmcrowSpecimenFrame extends StatelessWidget {
  const _SmcrowSpecimenFrame({
    required this.caption,
    required this.subCaption,
    required this.accent,
    required this.child,
  });

  final String caption;
  final String subCaption;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.12),
            blurRadius: 12,
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
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(caption, style: _smcrowTitle(size: 14)),
              ),
              Text(
                'specimen',
                style: _smcrowLabel(size: 10, color: accent),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(subCaption, style: _smcrowBody(size: 12)),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SmcrowGlyph extends StatelessWidget {
  const _SmcrowGlyph({required this.color, required this.symbol});
  final Color color;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.7)),
      ),
      child: Text(
        symbol,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _SmcrowSpark extends StatelessWidget {
  const _SmcrowSpark({required this.color, required this.values});
  final Color color;
  final List<double> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: CustomPaint(
        painter: _SmcrowSparkPainter(values: values, color: color),
      ),
    );
  }
}

class _SmcrowSparkPainter extends CustomPainter {
  _SmcrowSparkPainter({required this.values, required this.color});
  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final double minV = values.reduce(math.min);
    final double maxV = values.reduce(math.max);
    final double range = (maxV - minV).abs() < 1e-6 ? 1 : maxV - minV;
    final Path p = Path();
    for (int i = 0; i < values.length; i++) {
      final double x = i / (values.length - 1) * size.width;
      final double y =
          size.height - ((values[i] - minV) / range) * (size.height - 4) - 2;
      if (i == 0) {
        p.moveTo(x, y);
      } else {
        p.lineTo(x, y);
      }
    }
    canvas.drawPath(
      p,
      Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
    // Fill under curve.
    final Path fill = Path.from(p)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()..color = (color ?? const Color(0xFF000000)).withValues(alpha: 0.14),
    );
  }

  @override
  bool shouldRepaint(covariant _SmcrowSparkPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.color != color;
}

class _SmcrowActionsRow extends StatelessWidget {
  const _SmcrowActionsRow({required this.accent, required this.labels});
  final Color accent;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        for (final String l in labels)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
            ),
            child: Text(
              l,
              style: _smcrowLabel(size: 10, color: accent),
            ),
          ),
      ],
    );
  }
}

// --------------------------------------------------------------------------
// "From mixin to concrete" comparison panel.
// --------------------------------------------------------------------------

class _SmcrowComparisonPanel extends StatelessWidget {
  const _SmcrowComparisonPanel();

  static const String _verbose = '''
class _MyCard extends RenderObjectWidget
    with SlottedMultiChildRenderObjectWidgetMixin<Slot, RenderBox> {

  const _MyCard({ ...slots });

  @override
  Iterable<Slot> get slots => Slot.values;

  @override
  Widget? childForSlot(Slot s) => ...;

  @override
  RenderObject createRenderObject(BuildContext c) => ...;
}
''';

  static const String _concise = '''
class _MyCard extends
    SlottedMultiChildRenderObjectWidget<Slot, RenderBox> {

  const _MyCard({ ...slots });

  @override
  Iterable<Slot> get slots => Slot.values;

  @override
  Widget? childForSlot(Slot s) => ...;

  @override
  RenderObject createRenderObject(BuildContext c) => ...;
}
''';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints c) {
        final bool tight = c.maxWidth < 720;
        final List<Widget> children = <Widget>[
          Expanded(
            child: _SmcrowCodeBlock(
              title: 'BEFORE — mixin applied manually',
              color: _kSmcrowPlum,
              code: _verbose,
              annotations: const <String>[
                'Extends RenderObjectWidget.',
                'Applies the widget-tier mixin with `with`.',
                'Two-slot name repetition in declaration.',
              ],
            ),
          ),
          const SizedBox(width: 14, height: 14),
          Expanded(
            child: _SmcrowCodeBlock(
              title: 'AFTER — extend the concrete capstone',
              color: _kSmcrowTeal,
              code: _concise,
              annotations: const <String>[
                'Extends the abstract widget directly.',
                'Mixin is already applied for you.',
                'Shorter surface, same semantics.',
              ],
            ),
          ),
        ];
        if (tight) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              children[0],
              children[1],
              children[2],
            ],
          );
        }
        // IntrinsicHeight bounds the Row's vertical extent so that
        // CrossAxisAlignment.stretch does not propagate the unbounded
        // height inherited from the surrounding scrollable Column.
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        );
      },
    );
  }
}

class _SmcrowCodeBlock extends StatelessWidget {
  const _SmcrowCodeBlock({
    required this.title,
    required this.color,
    required this.code,
    required this.annotations,
  });

  final String title;
  final Color color;
  final String code;
  final List<String> annotations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSmcrowPlumDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: _smcrowLabel(size: 10, color: _kSmcrowChampagne),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SelectableText(
            code,
            style: _smcrowMono(
              size: 12,
              color: _kSmcrowChampagneSoft,
            ),
          ),
          const SizedBox(height: 10),
          for (final String a in annotations)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      a,
                      style: _smcrowBody(
                        size: 12,
                        color: _kSmcrowChampagneSoft,
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
}

// --------------------------------------------------------------------------
// Architecture diagram — 3 stacked layers with composition arrows.
// --------------------------------------------------------------------------

class _SmcrowArchitectureDiagram extends StatelessWidget {
  const _SmcrowArchitectureDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Three layers, one surface', style: _smcrowTitle(size: 16)),
          const SizedBox(height: 4),
          Text(
            'How the three mixins/classes fuse into one extendable widget.',
            style: _smcrowBody(size: 13),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: CustomPaint(painter: _SmcrowArchPainter()),
          ),
        ],
      ),
    );
  }
}

class _SmcrowArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    void plate(
      Rect r,
      Color fill,
      String title,
      String sub,
      Color textColor,
    ) {
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      canvas.drawRRect(rr, Paint()..color = fill);
      canvas.drawRRect(
        rr,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..color = (textColor ?? const Color(0xFF000000)).withValues(alpha: 0.55),
      );
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: title,
          style: _smcrowTitle(size: 14, color: textColor),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 16);
      t.paint(canvas, Offset(r.left + 10, r.top + 10));
      final TextPainter sub2 = TextPainter(
        text: TextSpan(
          text: sub,
          style: _smcrowBody(
            size: 11,
            color: (textColor ?? const Color(0xFF000000)).withValues(alpha: 0.82),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 16);
      sub2.paint(canvas, Offset(r.left + 10, r.top + 34));
    }

    final double plateH = 70;
    final double plateW = w * 0.7;
    final double x = (w - plateW) / 2;

    final Rect r1 = Rect.fromLTWH(x, h - plateH - 8, plateW, plateH);
    final Rect r2 = Rect.fromLTWH(x, h / 2 - plateH / 2, plateW, plateH);
    final Rect r3 = Rect.fromLTWH(x, 8, plateW, plateH);

    plate(
      r1,
      (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.18),
      'SlottedContainerRenderObjectMixin',
      'Render-object tier: childForSlot, attach/detach, visit, hit-test.',
      _kSmcrowTealDeep,
    );
    plate(
      r2,
      (_kSmcrowPlumBlush ?? const Color(0xFF000000)).withValues(alpha: 0.24),
      'SlottedMultiChildRenderObjectWidgetMixin',
      'Widget tier: childForSlot, slots, createElement.',
      _kSmcrowPlumDeep,
    );
    plate(
      r3,
      (_kSmcrowChampagne ?? const Color(0xFF000000)).withValues(alpha: 0.65),
      'SlottedMultiChildRenderObjectWidget (THIS FILE)',
      'Abstract capstone: RenderObjectWidget + widget-tier mixin pre-applied.',
      _kSmcrowInk,
    );

    // Arrows from bottom to top.
    final Paint arrow = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.75);
    final double ax = x + 30;
    canvas.drawLine(
      Offset(ax, r1.top),
      Offset(ax, r2.bottom),
      arrow,
    );
    canvas.drawLine(
      Offset(ax, r2.top),
      Offset(ax, r3.bottom),
      arrow,
    );
    // Arrow heads.
    for (final double y in <double>[r2.bottom + 0.5, r3.bottom + 0.5]) {
      final Path head = Path()
        ..moveTo(ax - 5, y + 6)
        ..lineTo(ax, y)
        ..lineTo(ax + 5, y + 6);
      canvas.drawPath(head, arrow);
    }

    // Right-side annotations.
    final TextPainter note = TextPainter(
      text: TextSpan(
        text: 'fused\ndownward\nthrough\n"with"',
        style: _smcrowBody(
          size: 11,
          color: (_kSmcrowPlum ?? const Color(0xFF000000)).withValues(alpha: 0.82),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 80);
    note.paint(canvas, Offset(x + plateW + 14, r2.top - 6));
  }

  @override
  bool shouldRepaint(covariant _SmcrowArchPainter oldDelegate) => false;
}

// --------------------------------------------------------------------------
// Interactive configurator.
// --------------------------------------------------------------------------

class _SmcrowConfigurator extends StatefulWidget {
  const _SmcrowConfigurator();

  @override
  State<_SmcrowConfigurator> createState() => _SmcrowConfiguratorState();
}

class _SmcrowConfiguratorState extends State<_SmcrowConfigurator> {
  bool _showIcon = true;
  bool _showTitle = true;
  bool _showSubtitle = true;
  bool _showMetric = true;
  bool _showTrend = true;
  bool _showActions = true;

  double _radius = 14;
  double _minHeight = 150;
  double _accentIndex = 0;

  static const List<Color> _accents = <Color>[
    _kSmcrowTeal,
    _kSmcrowPlum,
    _kSmcrowChampagneDeep,
    _kSmcrowTealMist,
    _kSmcrowPlumBlush,
  ];

  Color get _accent => _accents[_accentIndex.round() % _accents.length];

  void _report() {
    debugPrint(
      '[Smcrow] configurator: icon=$_showIcon title=$_showTitle '
      'subtitle=$_showSubtitle metric=$_showMetric trend=$_showTrend '
      'actions=$_showActions radius=${_radius.toStringAsFixed(1)} '
      'minH=${_minHeight.toStringAsFixed(0)} '
      'accent=r${_accent.r.toStringAsFixed(2)}/g${_accent.g.toStringAsFixed(2)}/b${_accent.b.toStringAsFixed(2)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    _report();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (_kSmcrowPlum ?? const Color(0xFF000000)).withValues(alpha: 0.3)),
      ),
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final bool tight = c.maxWidth < 720;
          final Widget controls = _buildControls();
          final Widget preview = _buildPreview();
          if (tight) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                controls,
                const SizedBox(height: 14),
                preview,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 3, child: controls),
              const SizedBox(width: 16),
              Expanded(flex: 4, child: preview),
            ],
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Slot on/off', style: _smcrowLabel(size: 11)),
        const SizedBox(height: 6),
        _switchRow('icon', _showIcon, (bool v) {
          setState(() => _showIcon = v);
        }),
        _switchRow('title', _showTitle, (bool v) {
          setState(() => _showTitle = v);
        }),
        _switchRow('subtitle', _showSubtitle, (bool v) {
          setState(() => _showSubtitle = v);
        }),
        _switchRow('primaryMetric', _showMetric, (bool v) {
          setState(() => _showMetric = v);
        }),
        _switchRow('trendLine', _showTrend, (bool v) {
          setState(() => _showTrend = v);
        }),
        _switchRow('actions', _showActions, (bool v) {
          setState(() => _showActions = v);
        }),
        const SizedBox(height: 14),
        Text('Radius: ${_radius.toStringAsFixed(1)}',
            style: _smcrowBody(size: 12)),
        Slider(
          value: _radius,
          min: 0,
          max: 28,
          divisions: 28,
          activeColor: _kSmcrowTeal,
          onChanged: (double v) => setState(() => _radius = v),
        ),
        Text('Min height: ${_minHeight.toStringAsFixed(0)}',
            style: _smcrowBody(size: 12)),
        Slider(
          value: _minHeight,
          min: 80,
          max: 240,
          divisions: 16,
          activeColor: _kSmcrowPlum,
          onChanged: (double v) => setState(() => _minHeight = v),
        ),
        Text(
          'Accent index: ${_accentIndex.toStringAsFixed(0)}',
          style: _smcrowBody(size: 12),
        ),
        Slider(
          value: _accentIndex,
          min: 0,
          max: (_accents.length - 1).toDouble(),
          divisions: _accents.length - 1,
          activeColor: _kSmcrowChampagneDeep,
          onChanged: (double v) => setState(() => _accentIndex = v),
        ),
      ],
    );
  }

  Widget _switchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(label, style: _smcrowBody(size: 13))),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: _kSmcrowTeal,
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSmcrowParchment,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (_accent ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
      ),
      child: _SmcrowDashboardCard(
        accent: _accent,
        surface: Colors.white,
        radius: _radius,
        minHeight: _minHeight,
        icon: _showIcon
            ? _SmcrowGlyph(color: _accent, symbol: 'L')
            : null,
        title: _showTitle
            ? Text(
                'Live dashboard card',
                style: _smcrowTitle(size: 15),
              )
            : null,
        subtitle: _showSubtitle
            ? Text(
                'Rebuilt as you toggle slots',
                style: _smcrowBody(size: 12),
              )
            : null,
        primaryMetric: _showMetric
            ? Text(
                '${(_minHeight * 1.3).round()} pts',
                style: _smcrowTitle(
                  size: 24,
                  color: _accent,
                  weight: FontWeight.w800,
                ),
              )
            : null,
        trendLine: _showTrend
            ? _SmcrowSpark(
                color: _accent,
                values: const <double>[3, 5, 4, 6, 8, 7, 10, 9, 11, 13],
              )
            : null,
        actions: _showActions
            ? _SmcrowActionsRow(
                accent: _accent,
                labels: const <String>['OK', 'TUNE'],
              )
            : null,
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Spec-sheet DataTable.
// --------------------------------------------------------------------------

class _SmcrowSpecSheet extends StatelessWidget {
  const _SmcrowSpecSheet();

  @override
  Widget build(BuildContext context) {
    final List<_SmcrowDashboardSlot> rows = _SmcrowDashboardSlot.values;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSmcrowChampagneDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Slot specification sheet', style: _smcrowTitle(size: 16)),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              headingRowColor: WidgetStatePropertyAll<Color>(
                (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.12),
              ),
              headingTextStyle: _smcrowLabel(size: 11),
              dataTextStyle: _smcrowBody(size: 12),
              columns: const <DataColumn>[
                DataColumn(label: Text('SLOT')),
                DataColumn(label: Text('REQUIRED?')),
                DataColumn(label: Text('DEFAULT')),
                DataColumn(label: Text('VISUAL RESPONSIBILITY')),
              ],
              rows: <DataRow>[
                for (final _SmcrowDashboardSlot s in rows)
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_smcrowSlotName(s))),
                      DataCell(Text(_smcrowRequired(s))),
                      DataCell(Text(_smcrowDefault(s))),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 260),
                          child: Text(_smcrowSlotResponsibility(s)),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _smcrowRequired(_SmcrowDashboardSlot s) {
    switch (s) {
      case _SmcrowDashboardSlot.title:
        return 'recommended';
      default:
        return 'optional';
    }
  }

  String _smcrowDefault(_SmcrowDashboardSlot s) {
    switch (s) {
      case _SmcrowDashboardSlot.icon:
        return 'null';
      case _SmcrowDashboardSlot.title:
        return 'null';
      case _SmcrowDashboardSlot.subtitle:
        return 'null';
      case _SmcrowDashboardSlot.primaryMetric:
        return 'null';
      case _SmcrowDashboardSlot.trendLine:
        return 'null';
      case _SmcrowDashboardSlot.actions:
        return 'null';
    }
  }
}

// --------------------------------------------------------------------------
// Decision tree card: mixin directly vs extend concrete.
// --------------------------------------------------------------------------

class _SmcrowDecisionTree extends StatelessWidget {
  const _SmcrowDecisionTree();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmcrowChampagneSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSmcrowChampagneDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Should I extend the concrete widget, or apply the mixin myself?',
            style: _smcrowTitle(size: 15, color: _kSmcrowPlumDeep),
          ),
          const SizedBox(height: 10),
          _SmcrowDecisionNode(
            question: 'Do you already extend another widget class '
                '(e.g. a custom InheritedWidget or RenderObjectWidget '
                'specialization)?',
            yes: 'Apply the widget-tier mixin directly to your class.',
            no: 'Extend SlottedMultiChildRenderObjectWidget.',
          ),
          const SizedBox(height: 10),
          _SmcrowDecisionNode(
            question: 'Do you need an exotic createElement override '
                '(e.g. a custom Element subclass)?',
            yes: 'Use the mixin and override createElement yourself.',
            no: 'Extend SlottedMultiChildRenderObjectWidget.',
          ),
          const SizedBox(height: 10),
          _SmcrowDecisionNode(
            question: 'Are you building a reusable production widget '
                'with a small, stable slot enum?',
            yes: 'Extend SlottedMultiChildRenderObjectWidget — least code.',
            no: 'Either works; the mixin gives you marginally more freedom.',
          ),
        ],
      ),
    );
  }
}

class _SmcrowDecisionNode extends StatelessWidget {
  const _SmcrowDecisionNode({
    required this.question,
    required this.yes,
    required this.no,
  });

  final String question;
  final String yes;
  final String no;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (_kSmcrowChampagneDeep ?? const Color(0xFF000000)).withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Q.',
                style: _smcrowLabel(size: 11, color: _kSmcrowPlum),
              ),
              const SizedBox(width: 6),
              Expanded(child: Text(question, style: _smcrowBody(size: 13))),
            ],
          ),
          const SizedBox(height: 8),
          _branch('YES', yes, _kSmcrowTeal),
          const SizedBox(height: 4),
          _branch('NO', no, _kSmcrowPlum),
        ],
      ),
    );
  }

  Widget _branch(String label, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          padding: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.6)),
          ),
          child: Text(label, style: _smcrowLabel(size: 10, color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: _smcrowBody(size: 12))),
      ],
    );
  }
}

// --------------------------------------------------------------------------
// Pitfall card: don't also apply the mixin.
// --------------------------------------------------------------------------

class _SmcrowPitfallCard extends StatelessWidget {
  const _SmcrowPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDEEE2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (_kSmcrowPlum ?? const Color(0xFF000000)).withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CustomPaint(
                size: const Size(28, 28),
                painter: _SmcrowDiamondPainter(),
              ),
              const SizedBox(width: 10),
              Text(
                'Pitfall — diamond re-application',
                style: _smcrowTitle(size: 15, color: _kSmcrowPlumDeep),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'When you extend the concrete widget, the widget-tier mixin is '
            'already hosted by the superclass. Re-applying it with `with` '
            'creates a diamond that shadows the concrete hooks.',
            style: _smcrowBody(size: 13),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSmcrowPlumDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              '// DON\'T\n'
              'class _Bad extends\n'
              '    SlottedMultiChildRenderObjectWidget<Slot, RenderBox>\n'
              '    with SlottedMultiChildRenderObjectWidgetMixin<Slot, RenderBox> {\n'
              '  // re-implemented hooks compete with the concrete ones.\n'
              '}\n\n'
              '// DO\n'
              'class _Good extends\n'
              '    SlottedMultiChildRenderObjectWidget<Slot, RenderBox> {\n'
              '  // just override slots/childForSlot/createRenderObject.\n'
              '}',
              style: _smcrowMono(size: 11, color: _kSmcrowChampagneSoft),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmcrowDiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();
    canvas.drawPath(
      p,
      Paint()..color = (_kSmcrowPlum ?? const Color(0xFF000000)).withValues(alpha: 0.85),
    );
    canvas.drawPath(
      p,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _kSmcrowChampagne,
    );
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: '!',
        style: _smcrowTitle(
          size: 16,
          color: _kSmcrowChampagne,
          weight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(
        (size.width - tp.width) / 2,
        (size.height - tp.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _SmcrowDiamondPainter oldDelegate) => false;
}

// --------------------------------------------------------------------------
// Legend strip — quick color cheatsheet.
// --------------------------------------------------------------------------

class _SmcrowLegend extends StatelessWidget {
  const _SmcrowLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 8,
      children: <Widget>[
        _chip(_kSmcrowTeal, 'teal shadow — accents'),
        _chip(_kSmcrowChampagne, 'champagne — surfaces'),
        _chip(_kSmcrowPlum, 'deep plum — hierarchy'),
        _chip(_kSmcrowChampagneDeep, 'champagne deep — borders'),
      ],
    );
  }

  Widget _chip(Color c, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: (c ?? const Color(0xFF000000)).withValues(alpha: 0.9)),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: _smcrowBody(size: 12)),
      ],
    );
  }
}

// --------------------------------------------------------------------------
// Integration checklist strip.
// --------------------------------------------------------------------------

class _SmcrowChecklist extends StatelessWidget {
  const _SmcrowChecklist();

  static const List<String> _items = <String>[
    'Declare a slot enum (small, stable, comparable).',
    'Extend SlottedMultiChildRenderObjectWidget<Slot, RenderBox>.',
    'Override slots to return all enum values.',
    'Override childForSlot with a switch on slot.',
    'Create a RenderBox using SlottedContainerRenderObjectMixin.',
    'In updateRenderObject, forward mutable style fields.',
    'Do NOT re-apply the widget-tier mixin with `with`.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Integration checklist', style: _smcrowTitle(size: 15)),
          const SizedBox(height: 8),
          for (int i = 0; i < _items.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.55),
                      ),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: _smcrowLabel(size: 10, color: _kSmcrowTealDeep),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(_items[i], style: _smcrowBody(size: 13))),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Lifecycle strip — how slots interact with element updates.
// --------------------------------------------------------------------------

class _SmcrowLifecycleStrip extends StatelessWidget {
  const _SmcrowLifecycleStrip();

  @override
  Widget build(BuildContext context) {
    final List<_LifecycleStep> steps = <_LifecycleStep>[
      _LifecycleStep(
        title: 'createElement',
        body: 'The concrete widget returns a SlottedRenderObjectElement '
            'configured with this widget instance.',
        accent: _kSmcrowTeal,
      ),
      _LifecycleStep(
        title: 'mount',
        body: 'Element iterates `slots`, calls `childForSlot`, and inflates '
            'each non-null widget as a child subtree.',
        accent: _kSmcrowPlum,
      ),
      _LifecycleStep(
        title: 'updateChild',
        body: 'On update, each slot is diffed independently; stable slot '
            'identity means minimal rebuilds.',
        accent: _kSmcrowChampagneDeep,
      ),
      _LifecycleStep(
        title: 'render object',
        body: 'Render object receives slotted children via the mixin and '
            'lays them out per enum order.',
        accent: _kSmcrowTealMist,
      ),
    ];
    return Column(
      children: <Widget>[
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SmcrowLifecycleCard(step: steps[i], index: i),
          ),
      ],
    );
  }
}

class _LifecycleStep {
  _LifecycleStep({
    required this.title,
    required this.body,
    required this.accent,
  });
  final String title;
  final String body;
  final Color accent;
}

class _SmcrowLifecycleCard extends StatelessWidget {
  const _SmcrowLifecycleCard({required this.step, required this.index});
  final _LifecycleStep step;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (step.accent ?? const Color(0xFF000000)).withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (step.accent ?? const Color(0xFF000000)).withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(color: step.accent),
            ),
            child: Text(
              '${index + 1}',
              style: _smcrowTitle(
                size: 14,
                color: step.accent,
                weight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(step.title, style: _smcrowTitle(size: 15)),
                const SizedBox(height: 3),
                Text(step.body, style: _smcrowBody(size: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Slot constellation diagram — shows which slot each specimen uses.
// --------------------------------------------------------------------------

class _SmcrowConstellation extends StatelessWidget {
  const _SmcrowConstellation();

  @override
  Widget build(BuildContext context) {
    final List<List<bool>> matrix = <List<bool>>[
      <bool>[true, true, true, true, true, true], // all filled
      <bool>[true, true, false, false, false, false], // icon + title
      <bool>[true, true, false, true, true, false], // trend
      <bool>[true, true, true, false, false, true], // actions forward
    ];
    final List<String> specs = <String>[
      'A · all filled',
      'B · icon + title',
      'C · trend emphasis',
      'D · actions forward',
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (_kSmcrowPlum ?? const Color(0xFF000000)).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Slot constellation per specimen',
              style: _smcrowTitle(size: 15)),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 18,
              headingRowColor: WidgetStatePropertyAll<Color>(
                (_kSmcrowPlum ?? const Color(0xFF000000)).withValues(alpha: 0.1),
              ),
              columns: <DataColumn>[
                const DataColumn(label: Text('SPEC')),
                for (final _SmcrowDashboardSlot s in _SmcrowDashboardSlot.values)
                  DataColumn(label: Text(_smcrowSlotName(s))),
              ],
              rows: <DataRow>[
                for (int i = 0; i < matrix.length; i++)
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(specs[i], style: _smcrowBody(size: 12))),
                      for (int j = 0; j < matrix[i].length; j++)
                        DataCell(
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: matrix[i][j]
                                  ? _kSmcrowTeal
                                  : _kSmcrowChampagneSoft,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: matrix[i][j]
                                    ? _kSmcrowTealDeep
                                    : _kSmcrowChampagneDeep,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Footer strip.
// --------------------------------------------------------------------------

class _SmcrowFooter extends StatelessWidget {
  const _SmcrowFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      color: _kSmcrowPlumDeep,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: _kSmcrowChampagne,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SlottedMultiChildRenderObjectWidget — the abstract capstone. '
              'Extend it, answer the slot questions, ship.',
              style: _smcrowBody(
                size: 13,
                color: _kSmcrowChampagneSoft,
              ),
            ),
          ),
          Text(
            'file 415 / 4',
            style: _smcrowLabel(size: 10, color: _kSmcrowChampagne),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Build tree.
// --------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('[Smcrow] Building SlottedMultiChildRenderObjectWidget demo.');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: const ColorScheme.light(
        primary: _kSmcrowTeal,
        secondary: _kSmcrowChampagneDeep,
        surface: _kSmcrowParchment,
      ),
      scaffoldBackgroundColor: _kSmcrowParchment,
      dividerColor: (_kSmcrowTeal ?? const Color(0xFF000000)).withValues(alpha: 0.25),
      textTheme: const TextTheme().apply(bodyColor: _kSmcrowInk),
      useMaterial3: true,
    ),
    home: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(child: _SmcrowHeroHeader()),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '01',
              label: 'Legend',
              child: const _SmcrowLegend(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '02',
              label: 'Architecture — three layers, one capstone',
              child: const _SmcrowArchitectureDiagram(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '03',
              label: 'From mixin to concrete',
              child: const _SmcrowComparisonPanel(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '04',
              label: 'Four specimens · different slot combinations',
              child: Column(
                children: <Widget>[
                  _SmcrowSpecimenAllFilled(),
                  _SmcrowSpecimenIconTitleOnly(),
                  _SmcrowSpecimenTrendEmphasis(),
                  _SmcrowSpecimenActionsForward(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '05',
              label: 'Interactive configurator',
              child: const _SmcrowConfigurator(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '06',
              label: 'Slot specification sheet',
              child: const _SmcrowSpecSheet(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '07',
              label: 'Slot constellation',
              child: const _SmcrowConstellation(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '08',
              label: 'Lifecycle strip',
              child: const _SmcrowLifecycleStrip(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '09',
              label: 'Decision tree',
              child: const _SmcrowDecisionTree(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '10',
              label: 'Pitfall — diamond re-application',
              child: const _SmcrowPitfallCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: _SmcrowSection(
              index: '11',
              label: 'Integration checklist',
              child: const _SmcrowChecklist(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 28)),
          const SliverToBoxAdapter(child: _SmcrowFooter()),
        ],
      ),
    ),
  );
}
