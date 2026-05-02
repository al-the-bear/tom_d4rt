// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - SingleChildLayoutDelegate + CustomSingleChildLayout
//
// This script is a hand-authored, comprehensive showcase of the
// SingleChildLayoutDelegate API and the CustomSingleChildLayout widget.
//
// SingleChildLayoutDelegate gives you a four-method contract for placing a
// single child within a region of available space:
//
//   - Size getSize(BoxConstraints constraints)
//       The size that CustomSingleChildLayout itself takes inside its
//       parent. Default returns constraints.biggest. Override to shrink-wrap
//       or to expand to fixed dimensions.
//
//   - BoxConstraints getConstraintsForChild(BoxConstraints constraints)
//       The constraints handed to the child during its own layout pass.
//       Default returns the incoming constraints. Override to force a child
//       to use less than the full size, or to tighten one axis.
//
//   - Offset getPositionForChild(Size size, Size childSize)
//       Where the child is painted, given the layout's own size and the
//       size the child resolved to. Default returns Offset.zero (top-left).
//       This is the most commonly overridden method.
//
//   - bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate)
//       Whether the layout must re-run when the delegate instance changes.
//       Required override. Compare any fields that affect layout output.
//
// CustomSingleChildLayout(delegate: ..., child: ...) wires the delegate to a
// real widget tree, calling these hooks during the render pipeline.
//
// Common real-world uses include:
//
//   - Tooltip / popover positioning relative to an anchor
//   - Snapping a child to a corner or anchor of a flexible box
//   - Enforcing aspect ratio without a separate AspectRatio wrapper
//   - Pushing a child out of a "no-fly zone" obstacle region
//   - Constraining child to a fraction of the parent
//   - Best-fit scaling without OverflowBox or FittedBox
//
// Each section below builds one of those patterns end-to-end with a real
// visible child, distinct palettes, and educational copy that explains when
// to reach for SingleChildLayoutDelegate vs Align / Center / Padding /
// LayoutBuilder / OverflowBox / FractionallySizedBox.

import 'package:flutter/material.dart';

// ============================================================================
// DELEGATE 1: ANCHOR BOTTOM-RIGHT
// ----------------------------------------------------------------------------
// Places the child against the bottom-right corner of the available area,
// regardless of the child's own size. The child is laid out with loose
// constraints, so it shrink-wraps. Then we position it so its bottom-right
// corner aligns with the layout's bottom-right corner, minus an optional
// inset.
//
// Why not Align(alignment: Alignment.bottomRight)? Align works fine when the
// surrounding box already has a defined size. Use a delegate when you want
// the layout itself to control its own size, or when bottom-right placement
// is part of a larger composite (anchors, callouts, badge layers).
// ============================================================================
class _AnchorBottomRightDelegate extends SingleChildLayoutDelegate {
  const _AnchorBottomRightDelegate({this.inset = 8});

  final double inset;

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = size.width - childSize.width - inset;
    final dy = size.height - childSize.height - inset;
    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant _AnchorBottomRightDelegate oldDelegate) {
    return oldDelegate.inset != inset;
  }
}

// ============================================================================
// DELEGATE 2: FIXED ASPECT RATIO
// ----------------------------------------------------------------------------
// Forces the child to maintain a fixed aspect ratio (e.g. 16:9) inside a
// stretchy parent. Computes the largest rectangle of that ratio that fits
// inside the available space, centers it, and tightens the child's
// constraints to that rectangle so the child is forced to that exact size.
//
// Why not AspectRatio? AspectRatio shrinks itself to whatever the parent
// allows along one axis, which can produce surprising results in unbounded
// dimensions. With a delegate you control both axes explicitly and you can
// also drive layout decisions like centering vs corner-pinning at the same
// time.
// ============================================================================
class _FixedAspectDelegate extends SingleChildLayoutDelegate {
  const _FixedAspectDelegate({this.ratio = 16 / 9});

  final double ratio;

  Size _fittedSize(Size container) {
    final wByH = container.width / ratio;
    if (wByH <= container.height) {
      return Size(container.width, wByH);
    }
    final hByW = container.height * ratio;
    return Size(hByW, container.height);
  }

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final fitted = _fittedSize(constraints.biggest);
    return BoxConstraints.tight(fitted);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = (size.width - childSize.width) / 2.0;
    final dy = (size.height - childSize.height) / 2.0;
    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant _FixedAspectDelegate oldDelegate) {
    return oldDelegate.ratio != ratio;
  }
}

// ============================================================================
// DELEGATE 3: ABSOLUTE PIXEL POSITION
// ----------------------------------------------------------------------------
// Places the child at exact pixel offsets from the top-left, clamped to the
// available area so the child stays visible. The child is loosely
// constrained so it can size itself naturally.
//
// Why not Positioned inside Stack? Positioned only works inside Stack and
// requires you to manage stacking semantics. CustomSingleChildLayout is the
// right tool when you want a single placed child without a stack and want
// the parent's own size driven by the child or by constraints, not by all
// stack siblings.
// ============================================================================
class _AbsolutePositionDelegate extends SingleChildLayoutDelegate {
  const _AbsolutePositionDelegate({required this.dx, required this.dy});

  final double dx;
  final double dy;

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final maxX = (size.width - childSize.width).clamp(0.0, double.infinity);
    final maxY = (size.height - childSize.height).clamp(0.0, double.infinity);
    final clampedX = dx.clamp(0.0, maxX);
    final clampedY = dy.clamp(0.0, maxY);
    return Offset(clampedX.toDouble(), clampedY.toDouble());
  }

  @override
  bool shouldRelayout(covariant _AbsolutePositionDelegate oldDelegate) {
    return oldDelegate.dx != dx || oldDelegate.dy != dy;
  }
}

// ============================================================================
// DELEGATE 4: PERCENTAGE SIZE
// ----------------------------------------------------------------------------
// Forces the child to take a configurable fraction of the available width
// and height, then centers it. Equivalent in spirit to FractionallySizedBox
// but keeps positioning logic in the same place as sizing.
//
// Why not FractionallySizedBox? FractionallySizedBox is great when only the
// fraction matters. Use a delegate when fraction-sizing is one part of a
// bigger placement decision (e.g. fraction-sized AND anchored to corner) so
// you don't end up nesting four wrappers.
// ============================================================================
class _PercentageSizeDelegate extends SingleChildLayoutDelegate {
  const _PercentageSizeDelegate({
    this.widthFactor = 0.6,
    this.heightFactor = 0.6,
  });

  final double widthFactor;
  final double heightFactor;

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final big = constraints.biggest;
    final w = big.width * widthFactor;
    final h = big.height * heightFactor;
    return BoxConstraints.tight(Size(w, h));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = (size.width - childSize.width) / 2.0;
    final dy = (size.height - childSize.height) / 2.0;
    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant _PercentageSizeDelegate oldDelegate) {
    return oldDelegate.widthFactor != widthFactor ||
        oldDelegate.heightFactor != heightFactor;
  }
}

// ============================================================================
// DELEGATE 5: AVOID OBSTACLE
// ----------------------------------------------------------------------------
// Treats a horizontal band in the middle of the available space as a "no-fly
// zone" and positions the child either above or below it, whichever has more
// room. This shape of logic shows up in real apps as: tooltip vs anchor,
// snackbar vs floating-action-button, modal placement vs keyboard.
//
// Why not LayoutBuilder + Align? LayoutBuilder gives you constraints but you
// still have to wrap a child to position it. The delegate approach keeps
// "where do I go" logic in one named, testable type.
// ============================================================================
class _AvoidObstacleDelegate extends SingleChildLayoutDelegate {
  const _AvoidObstacleDelegate({
    required this.obstacleTop,
    required this.obstacleBottom,
  });

  final double obstacleTop;
  final double obstacleBottom;

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final spaceAbove = obstacleTop;
    final spaceBelow = size.height - obstacleBottom;
    final placeAbove = spaceAbove >= spaceBelow;

    final dx = (size.width - childSize.width) / 2.0;
    final dy = placeAbove
        ? (spaceAbove - childSize.height) / 2.0
        : obstacleBottom + (spaceBelow - childSize.height) / 2.0;

    final clampedDy = dy.clamp(0.0, size.height - childSize.height);
    final clampedDx = dx.clamp(0.0, size.width - childSize.width);
    return Offset(clampedDx.toDouble(), clampedDy.toDouble());
  }

  @override
  bool shouldRelayout(covariant _AvoidObstacleDelegate oldDelegate) {
    return oldDelegate.obstacleTop != obstacleTop ||
        oldDelegate.obstacleBottom != obstacleBottom;
  }
}

// ============================================================================
// DELEGATE 6: SCALE TO FIT
// ----------------------------------------------------------------------------
// Best-fit scales the child by giving it a constrained target size that is
// the largest box of a target intrinsic ratio that fits inside the available
// space, multiplied by a scaleFactor (1.0 = exact best-fit, 0.5 = half the
// best-fit, etc.). The child is then centered.
//
// Why not FittedBox? FittedBox draws the child at its intrinsic size and
// scales the painting. With a delegate you control the actual layout size
// of the child, which means hit testing and child-internal layout (text
// wrap, flex children) all behave correctly at the chosen size.
// ============================================================================
class _ScaleToFitDelegate extends SingleChildLayoutDelegate {
  const _ScaleToFitDelegate({
    this.intrinsicWidth = 320,
    this.intrinsicHeight = 180,
    this.scaleFactor = 1.0,
  });

  final double intrinsicWidth;
  final double intrinsicHeight;
  final double scaleFactor;

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final big = constraints.biggest;
    final scaleX = big.width / intrinsicWidth;
    final scaleY = big.height / intrinsicHeight;
    final fit = (scaleX < scaleY ? scaleX : scaleY) * scaleFactor;
    final w = intrinsicWidth * fit;
    final h = intrinsicHeight * fit;
    return BoxConstraints.tight(Size(w, h));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = (size.width - childSize.width) / 2.0;
    final dy = (size.height - childSize.height) / 2.0;
    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant _ScaleToFitDelegate oldDelegate) {
    return oldDelegate.intrinsicWidth != intrinsicWidth ||
        oldDelegate.intrinsicHeight != intrinsicHeight ||
        oldDelegate.scaleFactor != scaleFactor;
  }
}

// ============================================================================
// DELEGATE 7: TOOLTIP-STYLE OVERLAY
// ----------------------------------------------------------------------------
// Recipe for the most common real-world use: position a tooltip / popover
// near an anchor, flipping side if the preferred side has no room, and
// clamping horizontally so the tooltip never overflows the viewport.
//
// targetCenter is the center of the anchor, in the layout's own coordinate
// space. preferAbove asks for the tooltip above the anchor; the delegate
// flips if there isn't enough room.
// ============================================================================
class _TooltipOverlayDelegate extends SingleChildLayoutDelegate {
  const _TooltipOverlayDelegate({
    required this.targetCenter,
    this.gap = 12,
    this.preferAbove = true,
  });

  final Offset targetCenter;
  final double gap;
  final bool preferAbove;

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double dy;
    if (preferAbove) {
      final candidate = targetCenter.dy - gap - childSize.height;
      dy = candidate >= 0 ? candidate : targetCenter.dy + gap;
    } else {
      final candidate = targetCenter.dy + gap;
      dy = (candidate + childSize.height <= size.height)
          ? candidate
          : targetCenter.dy - gap - childSize.height;
    }
    final maxDy = (size.height - childSize.height).clamp(0.0, double.infinity);
    dy = dy.clamp(0.0, maxDy).toDouble();

    final dx = targetCenter.dx - childSize.width / 2.0;
    final maxDx = (size.width - childSize.width).clamp(0.0, double.infinity);
    final clampedDx = dx.clamp(0.0, maxDx);
    return Offset(clampedDx.toDouble(), dy);
  }

  @override
  bool shouldRelayout(covariant _TooltipOverlayDelegate oldDelegate) {
    return oldDelegate.targetCenter != targetCenter ||
        oldDelegate.gap != gap ||
        oldDelegate.preferAbove != preferAbove;
  }
}

// ============================================================================
// SHARED CHILD CARD
// ----------------------------------------------------------------------------
// Every delegate showcase places a real visible child. Using one helper makes
// it easy to compare placement behavior across delegates with no visual
// noise from differing children.
// ============================================================================
Widget _childCard({
  required String label,
  required Color background,
  required Color border,
  Color? text,
  double minWidth = 80,
  double minHeight = 36,
}) {
  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: border, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text ?? Color(0xFF0F172A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

// Section header used everywhere.
Widget _sectionHeader({
  required String title,
  required String tagline,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          tagline,
          style: const TextStyle(
            color: Color(0xFF475569),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text, {Color color = const Color(0xFF334155)}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.fiber_manual_record, size: 6, color: color),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 13, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _codeChip(String code, {Color color = const Color(0xFF1E293B)}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFF1F5F9),
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.5,
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  const scriptName = 'proxies/singlechildlayout_proxy_test.dart';
  print('$scriptName executing - SingleChildLayoutDelegate Deep Demo');

  // Slider state holders for the live sections.
  double absX = 40;
  double absY = 40;
  double aspectRatio = 16 / 9;
  double percentW = 0.6;
  double percentH = 0.6;
  double obstacleTop = 80;
  double obstacleBottom = 140;
  double scaleFactor = 1.0;
  double tooltipX = 160;
  double tooltipY = 90;
  bool preferAbove = true;

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SingleChildLayoutDelegate Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF6366F1),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1B4B),
        foregroundColor: Colors.white,
        title: const Text('SingleChildLayoutDelegate Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ============================================================
              // INTRO CARD
              // ============================================================
              Card(
                color: const Color(0xFFEEF2FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SingleChildLayoutDelegate',
                        style: TextStyle(
                          color: Color(0xFF312E81),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'A four-method contract that controls a single '
                        'child\u2019s size and position inside a layout box.',
                        style: TextStyle(
                          color: Color(0xFF312E81),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _bullet(
                        'getSize(constraints) - the layout\u2019s own size; '
                        'default is constraints.biggest.',
                        color: const Color(0xFF312E81),
                      ),
                      _bullet(
                        'getConstraintsForChild(constraints) - the child\u2019s '
                        'constraints during its own layout pass.',
                        color: const Color(0xFF312E81),
                      ),
                      _bullet(
                        'getPositionForChild(size, childSize) - the offset at '
                        'which the child paints; default is Offset.zero.',
                        color: const Color(0xFF312E81),
                      ),
                      _bullet(
                        'shouldRelayout(oldDelegate) - whether the layout must '
                        'rerun when the delegate changes (required override).',
                        color: const Color(0xFF312E81),
                      ),
                      const SizedBox(height: 12),
                      _codeChip(
                        'CustomSingleChildLayout(\n'
                        '  delegate: const _AnchorBottomRightDelegate(),\n'
                        '  child: Text(\'Anchored\'),\n'
                        ')',
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Use this when Align, Center, Padding, or '
                        'FractionallySizedBox don\u2019t give you enough '
                        'control over both sizing AND positioning at the '
                        'same time.',
                        style: TextStyle(
                          color: Color(0xFF312E81),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 1: ANCHOR BOTTOM-RIGHT
              // ============================================================
              Card(
                color: const Color(0xFFFFF7ED),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFEA580C), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        title: '1. Anchor: Bottom-Right',
                        tagline:
                            'Stick the child to the bottom-right corner of '
                            'the available area.',
                        color: const Color(0xFF9A3412),
                      ),
                      const Text(
                        'The delegate gives the child loose constraints so '
                        'it shrink-wraps, then offsets it so its own '
                        'bottom-right corner sits at the parent\u2019s '
                        'bottom-right corner minus an inset. Resize the '
                        'window to see the anchor stay put.',
                        style: TextStyle(
                          color: Color(0xFF7C2D12),
                          height: 1.5,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _codeChip(
                        'Offset getPositionForChild(Size size, Size c) =>\n'
                        '    Offset(size.width - c.width - inset,\n'
                        '           size.height - c.height - inset);',
                        color: const Color(0xFF7C2D12),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEDD5),
                          border: Border.all(
                            color: const Color(0xFFFB923C),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomSingleChildLayout(
                          delegate: const _AnchorBottomRightDelegate(
                            inset: 12,
                          ),
                          child: _childCard(
                            label: 'Anchored child',
                            background: const Color(0xFFFFEDD5),
                            border: const Color(0xFFEA580C),
                            text: const Color(0xFF7C2D12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _bullet(
                        'When to use: badges, floating-action overlays, '
                        '"powered by" stamps.',
                        color: const Color(0xFF7C2D12),
                      ),
                      _bullet(
                        'When to avoid: if Align(alignment: '
                        'Alignment.bottomRight) inside a sized parent works, '
                        'use that instead. It\u2019s simpler.',
                        color: const Color(0xFF7C2D12),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 2: FIXED ASPECT RATIO
              // ============================================================
              Card(
                color: const Color(0xFFECFEFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF0891B2), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                            title: '2. Fixed Aspect Ratio',
                            tagline:
                                'Largest 16:9 (or your ratio) rectangle that '
                                'fits the available area.',
                            color: const Color(0xFF155E75),
                          ),
                          const Text(
                            'The delegate computes the largest box of the '
                            'target ratio that fits inside the available '
                            'space, tightens the child to that exact size, '
                            'and centers it. The child cannot push back: '
                            'sizing is fully delegate-driven.',
                            style: TextStyle(
                              color: Color(0xFF155E75),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'ratio: ',
                                style: TextStyle(color: Color(0xFF155E75)),
                              ),
                              Text(
                                aspectRatio.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Color(0xFF0E7490),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: aspectRatio,
                            min: 0.5,
                            max: 3.0,
                            divisions: 25,
                            activeColor: const Color(0xFF0891B2),
                            onChanged: (v) =>
                                setState(() => aspectRatio = v),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCFFAFE),
                              border: Border.all(
                                color: const Color(0xFF22D3EE),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomSingleChildLayout(
                              delegate: _FixedAspectDelegate(
                                ratio: aspectRatio,
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF06B6D4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'aspect-locked child',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _bullet(
                            'When to use: video / preview surfaces, image '
                            'placeholders, fixed-ratio cards.',
                            color: const Color(0xFF155E75),
                          ),
                          _bullet(
                            'When to avoid: AspectRatio is enough when one '
                            'axis is bounded and the other is free.',
                            color: const Color(0xFF155E75),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 3: ABSOLUTE POSITION (LIVE SLIDERS)
              // ============================================================
              Card(
                color: const Color(0xFFFDF2F8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFDB2777), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                            title: '3. Absolute Pixel Position',
                            tagline:
                                'Move a single child by exact (dx, dy) '
                                'pixels - drag the sliders.',
                            color: const Color(0xFF9D174D),
                          ),
                          const Text(
                            'The delegate gives the child loose constraints '
                            'so it shrink-wraps, then places it at exact '
                            'pixel offsets, clamped to keep the child fully '
                            'visible. Sliders update the delegate instance, '
                            'and shouldRelayout returns true so the layout '
                            'reruns.',
                            style: TextStyle(
                              color: Color(0xFF9D174D),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'dx: ',
                                style: TextStyle(color: Color(0xFF9D174D)),
                              ),
                              Text(
                                absX.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color(0xFFBE185D),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: absX,
                            min: 0,
                            max: 320,
                            activeColor: const Color(0xFFDB2777),
                            onChanged: (v) => setState(() => absX = v),
                          ),
                          Row(
                            children: [
                              const Text(
                                'dy: ',
                                style: TextStyle(color: Color(0xFF9D174D)),
                              ),
                              Text(
                                absY.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color(0xFFBE185D),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: absY,
                            min: 0,
                            max: 200,
                            activeColor: const Color(0xFFDB2777),
                            onChanged: (v) => setState(() => absY = v),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 240,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCE7F3),
                              border: Border.all(
                                color: const Color(0xFFF472B6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomSingleChildLayout(
                              delegate: _AbsolutePositionDelegate(
                                dx: absX,
                                dy: absY,
                              ),
                              child: _childCard(
                                label: 'pixel placed',
                                background: const Color(0xFFFBCFE8),
                                border: const Color(0xFFDB2777),
                                text: const Color(0xFF831843),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _bullet(
                            'When to use: ad-hoc anchored UI, drag-and-drop '
                            'preview placement, custom hit-test regions.',
                            color: const Color(0xFF9D174D),
                          ),
                          _bullet(
                            'When to avoid: if you have multiple positioned '
                            'children, use Stack with Positioned.',
                            color: const Color(0xFF9D174D),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 4: PERCENTAGE SIZE
              // ============================================================
              Card(
                color: const Color(0xFFF0FDF4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF16A34A), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                            title: '4. Percentage Size',
                            tagline:
                                'Force the child to take a fraction of the '
                                'available area on each axis.',
                            color: const Color(0xFF14532D),
                          ),
                          const Text(
                            'getConstraintsForChild returns tight constraints '
                            'sized to widthFactor and heightFactor of the '
                            'parent. The child has no say. Then we center '
                            'the result.',
                            style: TextStyle(
                              color: Color(0xFF14532D),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'widthFactor: ',
                                style: TextStyle(color: Color(0xFF14532D)),
                              ),
                              Text(
                                percentW.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Color(0xFF166534),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: percentW,
                            min: 0.1,
                            max: 1.0,
                            divisions: 18,
                            activeColor: const Color(0xFF16A34A),
                            onChanged: (v) => setState(() => percentW = v),
                          ),
                          Row(
                            children: [
                              const Text(
                                'heightFactor: ',
                                style: TextStyle(color: Color(0xFF14532D)),
                              ),
                              Text(
                                percentH.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Color(0xFF166534),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: percentH,
                            min: 0.1,
                            max: 1.0,
                            divisions: 18,
                            activeColor: const Color(0xFF16A34A),
                            onChanged: (v) => setState(() => percentH = v),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              border: Border.all(
                                color: const Color(0xFF4ADE80),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomSingleChildLayout(
                              delegate: _PercentageSizeDelegate(
                                widthFactor: percentW,
                                heightFactor: percentH,
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'fraction-sized',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _bullet(
                            'When to use: responsive panels, modal cards on '
                            'tablets, banner takeovers.',
                            color: const Color(0xFF14532D),
                          ),
                          _bullet(
                            'When to avoid: FractionallySizedBox is simpler '
                            'for the pure-size case.',
                            color: const Color(0xFF14532D),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 5: AVOID OBSTACLE
              // ============================================================
              Card(
                color: const Color(0xFFFEF2F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                            title: '5. Avoid Obstacle (No-Fly Zone)',
                            tagline:
                                'Position the child above or below a '
                                'horizontal blocked region - whichever has '
                                'more room.',
                            color: const Color(0xFF7F1D1D),
                          ),
                          const Text(
                            'A common shape: tooltip versus anchor, modal '
                            'card versus keyboard, popover versus '
                            'navigation bar. The delegate picks the side '
                            'with more space and centers within it.',
                            style: TextStyle(
                              color: Color(0xFF7F1D1D),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'obstacleTop: ',
                                style: TextStyle(color: Color(0xFF7F1D1D)),
                              ),
                              Text(
                                obstacleTop.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color(0xFFB91C1C),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: obstacleTop,
                            min: 30,
                            max: 200,
                            activeColor: const Color(0xFFDC2626),
                            onChanged: (v) {
                              setState(() {
                                obstacleTop = v;
                                if (obstacleBottom <= obstacleTop + 20) {
                                  obstacleBottom = obstacleTop + 20;
                                }
                              });
                            },
                          ),
                          Row(
                            children: [
                              const Text(
                                'obstacleBottom: ',
                                style: TextStyle(color: Color(0xFF7F1D1D)),
                              ),
                              Text(
                                obstacleBottom.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color(0xFFB91C1C),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: obstacleBottom,
                            min: 50,
                            max: 240,
                            activeColor: const Color(0xFFDC2626),
                            onChanged: (v) {
                              setState(() {
                                obstacleBottom = v;
                                if (obstacleTop >= obstacleBottom - 20) {
                                  obstacleTop = obstacleBottom - 20;
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 280,
                            child: Stack(
                              children: [
                                // Obstacle visualization underneath.
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: obstacleTop,
                                  height: obstacleBottom - obstacleTop,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0x44DC2626),
                                      border: Border.all(
                                        color: const Color(0xFFDC2626),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'NO-FLY ZONE',
                                      style: TextStyle(
                                        color: Color(0xFF7F1D1D),
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFFCA5A5),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                CustomSingleChildLayout(
                                  delegate: _AvoidObstacleDelegate(
                                    obstacleTop: obstacleTop,
                                    obstacleBottom: obstacleBottom,
                                  ),
                                  child: _childCard(
                                    label: 'avoids obstacle',
                                    background: const Color(0xFFFECACA),
                                    border: const Color(0xFFB91C1C),
                                    text: const Color(0xFF7F1D1D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _bullet(
                            'When to use: tooltips, snackbars, contextual '
                            'menus, AR overlays.',
                            color: const Color(0xFF7F1D1D),
                          ),
                          _bullet(
                            'When to avoid: if the obstacle isn\u2019t '
                            'inside the same coordinate space, use an '
                            'OverlayEntry instead.',
                            color: const Color(0xFF7F1D1D),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 6: SCALE TO FIT
              // ============================================================
              Card(
                color: const Color(0xFFFFFBEB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFD97706), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                            title: '6. Scale-to-Fit',
                            tagline:
                                'Best-fit the child to the available area '
                                'using a target intrinsic size.',
                            color: const Color(0xFF92400E),
                          ),
                          const Text(
                            'The delegate measures available space, computes '
                            'how much it can scale a 320x180 "canvas" to '
                            'fit, multiplies by scaleFactor, and tightens '
                            'the child to that exact size. The child is '
                            'centered in the leftover area.',
                            style: TextStyle(
                              color: Color(0xFF92400E),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'scaleFactor: ',
                                style: TextStyle(color: Color(0xFF92400E)),
                              ),
                              Text(
                                scaleFactor.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Color(0xFFB45309),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: scaleFactor,
                            min: 0.2,
                            max: 1.0,
                            divisions: 16,
                            activeColor: const Color(0xFFD97706),
                            onChanged: (v) =>
                                setState(() => scaleFactor = v),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              border: Border.all(
                                color: const Color(0xFFFBBF24),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomSingleChildLayout(
                              delegate: _ScaleToFitDelegate(
                                intrinsicWidth: 320,
                                intrinsicHeight: 180,
                                scaleFactor: scaleFactor,
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'best-fit canvas',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _bullet(
                            'When to use: "design canvas" surfaces, '
                            'thumbnail previews, fixed-aspect game viewports.',
                            color: const Color(0xFF92400E),
                          ),
                          _bullet(
                            'When to avoid: FittedBox if you only need '
                            'visual scaling and don\u2019t care that hit '
                            'testing happens in intrinsic coordinates.',
                            color: const Color(0xFF92400E),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 7: TOOLTIP-STYLE OVERLAY
              // ============================================================
              Card(
                color: const Color(0xFFF5F3FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader(
                            title: '7. Tooltip / Overlay Recipe',
                            tagline:
                                'The most common real-world reason to reach '
                                'for SingleChildLayoutDelegate.',
                            color: const Color(0xFF5B21B6),
                          ),
                          const Text(
                            'Position a tooltip near a target point. Prefer '
                            'placing above; if there isn\u2019t enough room '
                            'above, flip to below. Clamp horizontally so '
                            'the tooltip never overflows.',
                            style: TextStyle(
                              color: Color(0xFF5B21B6),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'targetX: ',
                                style: TextStyle(color: Color(0xFF5B21B6)),
                              ),
                              Text(
                                tooltipX.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color(0xFF6D28D9),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: tooltipX,
                            min: 0,
                            max: 320,
                            activeColor: const Color(0xFF7C3AED),
                            onChanged: (v) => setState(() => tooltipX = v),
                          ),
                          Row(
                            children: [
                              const Text(
                                'targetY: ',
                                style: TextStyle(color: Color(0xFF5B21B6)),
                              ),
                              Text(
                                tooltipY.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color(0xFF6D28D9),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: tooltipY,
                            min: 0,
                            max: 200,
                            activeColor: const Color(0xFF7C3AED),
                            onChanged: (v) => setState(() => tooltipY = v),
                          ),
                          Row(
                            children: [
                              const Text(
                                'preferAbove: ',
                                style: TextStyle(color: Color(0xFF5B21B6)),
                              ),
                              Switch(
                                value: preferAbove,
                                activeColor: const Color(0xFF7C3AED),
                                onChanged: (v) =>
                                    setState(() => preferAbove = v),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 240,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDE9FE),
                                    border: Border.all(
                                      color: const Color(0xFFC4B5FD),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                // Anchor dot.
                                Positioned(
                                  left: tooltipX - 6,
                                  top: tooltipY - 6,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF7C3AED),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                CustomSingleChildLayout(
                                  delegate: _TooltipOverlayDelegate(
                                    targetCenter: Offset(tooltipX, tooltipY),
                                    gap: 14,
                                    preferAbove: preferAbove,
                                  ),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 200,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E1B4B),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'I am a tooltip placed by '
                                          'SingleChildLayoutDelegate.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _bullet(
                            'This pattern is exactly how Flutter\u2019s '
                            'built-in Tooltip widget positions itself.',
                            color: const Color(0xFF5B21B6),
                          ),
                          _bullet(
                            'shouldRelayout returns true whenever the anchor '
                            'or preference changes, so the tooltip follows.',
                            color: const Color(0xFF5B21B6),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 8: getSize DISCUSSION
              // ============================================================
              Card(
                color: const Color(0xFFF1F5F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF334155), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        title: '8. getSize: Shrink-Wrap or Expand?',
                        tagline:
                            'How the delegate controls the layout\u2019s '
                            'OWN size, independent of its child.',
                        color: const Color(0xFF0F172A),
                      ),
                      const Text(
                        'Default getSize returns constraints.biggest, which '
                        'means CustomSingleChildLayout fills the available '
                        'space. Override it to do something different:',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          height: 1.5,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _codeChip(
                        '// Shrink-wrap to a fixed minimum:\n'
                        '@override\n'
                        'Size getSize(BoxConstraints constraints) {\n'
                        '  return constraints.constrain(const Size(280, 160));\n'
                        '}',
                      ),
                      _codeChip(
                        '// Expand to all available width but fix the height:\n'
                        '@override\n'
                        'Size getSize(BoxConstraints constraints) =>\n'
                        '    Size(constraints.maxWidth, 96);',
                      ),
                      const SizedBox(height: 8),
                      _bullet(
                        'Note: getSize cannot consult the child. It runs '
                        'before the child lays out.',
                      ),
                      _bullet(
                        'If you need the child\u2019s size to drive the '
                        'parent\u2019s size, use IntrinsicWidth / '
                        'IntrinsicHeight or LayoutBuilder around it instead.',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 9: DECISION CARD
              // ============================================================
              Card(
                color: const Color(0xFFFEF9C3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFCA8A04), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        title: '9. Decision: Which Tool, When?',
                        tagline:
                            'CustomSingleChildLayout vs LayoutBuilder vs '
                            'OverflowBox vs FractionallySizedBox.',
                        color: const Color(0xFF713F12),
                      ),
                      _bullet(
                        'CustomSingleChildLayout: pick this when sizing AND '
                        'positioning of one child are coupled and you want '
                        'a named, testable delegate type.',
                        color: const Color(0xFF713F12),
                      ),
                      _bullet(
                        'LayoutBuilder: pick this when you need to read '
                        'incoming constraints in order to choose a different '
                        'WIDGET TREE - not just position one child.',
                        color: const Color(0xFF713F12),
                      ),
                      _bullet(
                        'OverflowBox: pick this when you need a child to '
                        'paint outside its parent\u2019s bounds, with no '
                        'positioning logic of your own.',
                        color: const Color(0xFF713F12),
                      ),
                      _bullet(
                        'FractionallySizedBox: pick this when sizing is '
                        'fractional and positioning is just an alignment.',
                        color: const Color(0xFF713F12),
                      ),
                      _bullet(
                        'Stack + Positioned: pick this when you have many '
                        'children with independent positions.',
                        color: const Color(0xFF713F12),
                      ),
                      _bullet(
                        'Align: pick this when sizing is unchanged and you '
                        'just need a corner / edge alignment.',
                        color: const Color(0xFF713F12),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // SECTION 10: REFERENCE TABLE
              // ============================================================
              Card(
                color: const Color(0xFFF8FAFC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF1E293B), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        title: '10. Delegate Reference Table',
                        tagline:
                            'Every delegate in this demo, and which methods '
                            'each one overrides.',
                        color: const Color(0xFF0F172A),
                      ),
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(
                          color: const Color(0xFF94A3B8),
                          width: 1,
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(2.4),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1.6),
                          3: FlexColumnWidth(1.6),
                          4: FlexColumnWidth(1.4),
                        },
                        children: const [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Color(0xFFE2E8F0),
                            ),
                            children: [
                              _Cell('Delegate', bold: true),
                              _Cell('getSize', bold: true),
                              _Cell('getConstraintsForChild', bold: true),
                              _Cell('getPositionForChild', bold: true),
                              _Cell('shouldRelayout', bold: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_AnchorBottomRightDelegate'),
                              _Cell('default'),
                              _Cell('loose(biggest)'),
                              _Cell('size - childSize - inset'),
                              _Cell('inset'),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_FixedAspectDelegate'),
                              _Cell('biggest'),
                              _Cell('tight(fittedSize)'),
                              _Cell('center'),
                              _Cell('ratio'),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_AbsolutePositionDelegate'),
                              _Cell('biggest'),
                              _Cell('loose(biggest)'),
                              _Cell('clamp(dx, dy)'),
                              _Cell('dx, dy'),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_PercentageSizeDelegate'),
                              _Cell('biggest'),
                              _Cell('tight(w*f, h*f)'),
                              _Cell('center'),
                              _Cell('widthFactor, heightFactor'),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_AvoidObstacleDelegate'),
                              _Cell('biggest'),
                              _Cell('loose(biggest)'),
                              _Cell('above-or-below'),
                              _Cell('obstacleTop/Bottom'),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_ScaleToFitDelegate'),
                              _Cell('biggest'),
                              _Cell('tight(scaledIntrinsic)'),
                              _Cell('center'),
                              _Cell('intrinsicW/H, scaleFactor'),
                            ],
                          ),
                          TableRow(
                            children: [
                              _Cell('_TooltipOverlayDelegate'),
                              _Cell('biggest'),
                              _Cell('loose(biggest)'),
                              _Cell('flip+clamp'),
                              _Cell('targetCenter, gap, preferAbove'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'shouldRelayout MUST return true whenever any of the '
                        'fields listed in the rightmost column changes. If '
                        'you forget this, layout will be stale.',
                        style: TextStyle(
                          color: Color(0xFF334155),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Footer
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Deep demo: SingleChildLayoutDelegate + '
                    'CustomSingleChildLayout',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Helper cell widget for the reference table.
class _Cell extends StatelessWidget {
  const _Cell(this.text, {this.bold = false});

  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF0F172A),
          fontSize: 12,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w400,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
