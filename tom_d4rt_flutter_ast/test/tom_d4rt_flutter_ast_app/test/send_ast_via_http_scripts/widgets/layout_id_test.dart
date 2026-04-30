import 'package:flutter/material.dart';

// ─── Top-level reactive state ─────────────────────────────────────────────────

/// Controls the split ratio for section 4 (Dynamic Position Slider).
final ValueNotifier<double> _splitRatio = ValueNotifier<double>(0.4);

/// Controls which simulated breakpoint width is active for section 5.
final ValueNotifier<double> _simulatedWidth = ValueNotifier<double>(600);

/// Toggles the optional child in section 8 (hasChild guard demo).
final ValueNotifier<bool> _showOptional = ValueNotifier<bool>(true);

// ─── Enum IDs for section 3 ───────────────────────────────────────────────────

enum _SlotId { left, center, right }

// ─── Delegate: Three-Zone (header / body / footer) ───────────────────────────

class _ThreeZoneDelegate extends MultiChildLayoutDelegate {
  final double headerHeight;
  final double footerHeight;

  _ThreeZoneDelegate({
    required this.headerHeight,
    required this.footerHeight,
  });

  @override
  void performLayout(Size size) {
    // Header — fixed height at the top.
    if (hasChild('header')) {
      layoutChild(
        'header',
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild('header', Offset.zero);
    }

    // Footer — fixed height pinned to the bottom.
    if (hasChild('footer')) {
      layoutChild(
        'footer',
        BoxConstraints.tightFor(width: size.width, height: footerHeight),
      );
      positionChild('footer', Offset(0, size.height - footerHeight));
    }

    // Body — takes the remaining vertical space.
    if (hasChild('body')) {
      final bodyHeight = size.height - headerHeight - footerHeight;
      layoutChild(
        'body',
        BoxConstraints.tightFor(width: size.width, height: bodyHeight),
      );
      positionChild('body', Offset(0, headerHeight));
    }
  }

  @override
  bool shouldRelayout(_ThreeZoneDelegate old) =>
      old.headerHeight != headerHeight || old.footerHeight != footerHeight;
}

// ─── Delegate: Enum-keyed three-column ───────────────────────────────────────

class _EnumSlotDelegate extends MultiChildLayoutDelegate {
  final double gap;

  _EnumSlotDelegate({this.gap = 8});

  @override
  void performLayout(Size size) {
    final slotW = (size.width - gap * 2) / 3;

    if (hasChild(_SlotId.left)) {
      layoutChild(
        _SlotId.left,
        BoxConstraints.tightFor(width: slotW, height: size.height),
      );
      positionChild(_SlotId.left, Offset.zero);
    }
    if (hasChild(_SlotId.center)) {
      layoutChild(
        _SlotId.center,
        BoxConstraints.tightFor(width: slotW, height: size.height),
      );
      positionChild(_SlotId.center, Offset(slotW + gap, 0));
    }
    if (hasChild(_SlotId.right)) {
      layoutChild(
        _SlotId.right,
        BoxConstraints.tightFor(width: slotW, height: size.height),
      );
      positionChild(_SlotId.right, Offset((slotW + gap) * 2, 0));
    }
  }

  @override
  bool shouldRelayout(_EnumSlotDelegate old) => old.gap != gap;
}

// ─── Delegate: Dynamic split (ratio-driven) ───────────────────────────────────

class _SplitDelegate extends MultiChildLayoutDelegate {
  final double ratio;

  _SplitDelegate({required this.ratio}) : super(relayout: _splitRatio);

  @override
  void performLayout(Size size) {
    final leftW = size.width * ratio;
    final rightW = size.width - leftW;

    if (hasChild('left')) {
      layoutChild(
        'left',
        BoxConstraints.tightFor(width: leftW, height: size.height),
      );
      positionChild('left', Offset.zero);
    }
    if (hasChild('right')) {
      layoutChild(
        'right',
        BoxConstraints.tightFor(width: rightW, height: size.height),
      );
      positionChild('right', Offset(leftW, 0));
    }
  }

  @override
  bool shouldRelayout(_SplitDelegate old) => old.ratio != ratio;
}

// ─── Delegate: Responsive (compact vs wide) ───────────────────────────────────

class _ResponsiveDelegate extends MultiChildLayoutDelegate {
  final double breakpoint;

  _ResponsiveDelegate({this.breakpoint = 480});

  @override
  void performLayout(Size size) {
    final isWide = size.width >= breakpoint;

    if (isWide) {
      // Side-by-side: nav on left, content on right.
      const navW = 160.0;
      final contentW = size.width - navW;

      if (hasChild('nav')) {
        layoutChild(
          'nav',
          BoxConstraints.tightFor(width: navW, height: size.height),
        );
        positionChild('nav', Offset.zero);
      }
      if (hasChild('content')) {
        layoutChild(
          'content',
          BoxConstraints.tightFor(width: contentW, height: size.height),
        );
        positionChild('content', const Offset(160, 0));
      }
    } else {
      // Stacked: nav on top (48 px tall), content fills the rest.
      const navH = 48.0;
      final contentH = size.height - navH;

      if (hasChild('nav')) {
        layoutChild(
          'nav',
          BoxConstraints.tightFor(width: size.width, height: navH),
        );
        positionChild('nav', Offset.zero);
      }
      if (hasChild('content')) {
        layoutChild(
          'content',
          BoxConstraints.tightFor(width: size.width, height: contentH),
        );
        positionChild('content', const Offset(0, navH));
      }
    }
  }

  @override
  bool shouldRelayout(_ResponsiveDelegate old) =>
      old.breakpoint != breakpoint;
}

// ─── Delegate: Badge overlay ─────────────────────────────────────────────────

class _BadgeDelegate extends MultiChildLayoutDelegate {
  final double badgeRadius;

  _BadgeDelegate({this.badgeRadius = 12});

  @override
  void performLayout(Size size) {
    if (hasChild('content')) {
      final contentSize = layoutChild(
        'content',
        BoxConstraints.tight(size),
      );
      positionChild('content', Offset.zero);

      // Position badge at top-right corner, half-overlapping the content edge.
      if (hasChild('badge')) {
        layoutChild(
          'badge',
          BoxConstraints.tightFor(
            width: badgeRadius * 2,
            height: badgeRadius * 2,
          ),
        );
        positionChild(
          'badge',
          Offset(contentSize.width - badgeRadius, -badgeRadius),
        );
      }
    }
  }

  @override
  bool shouldRelayout(_BadgeDelegate old) =>
      old.badgeRadius != badgeRadius;
}

// ─── Delegate: Optional-child guard ──────────────────────────────────────────

class _OptionalChildDelegate extends MultiChildLayoutDelegate {
  _OptionalChildDelegate() : super(relayout: _showOptional);

  @override
  void performLayout(Size size) {
    // Required child always present.
    if (hasChild('required')) {
      layoutChild(
        'required',
        BoxConstraints.tightFor(width: size.width, height: size.height * 0.6),
      );
      positionChild('required', Offset.zero);
    }

    // Optional child — guard prevents layoutChild on missing child.
    if (hasChild('optional')) {
      layoutChild(
        'optional',
        BoxConstraints.tightFor(
          width: size.width,
          height: size.height * 0.4,
        ),
      );
      positionChild('optional', Offset(0, size.height * 0.6));
    }
  }

  @override
  bool shouldRelayout(_OptionalChildDelegate old) => false;
}

// ─── CustomPainter: Architecture diagram ─────────────────────────────────────

class _DiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFF3F4F6);
    final outerPaint = Paint()
      ..color = const Color(0xFF1E40AF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    final childFill = Paint()..color = const Color(0xFFDBEAFE);
    final childBorder = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final arrowPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final delegateFill = Paint()..color = const Color(0xFFFEF3C7);
    final delegateBorder = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Background.
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Outer CustomMultiChildLayout box.
    final outerRect = Rect.fromLTWH(20, 20, size.width - 40, size.height - 40);
    canvas.drawRect(outerRect, Paint()..color = const Color(0xFFEFF6FF));
    canvas.drawRect(outerRect, outerPaint);
    _drawLabel(canvas, 'CustomMultiChildLayout', Offset(28, 24),
        const Color(0xFF1E40AF), 11);

    // Three child rects (header / body / footer).
    final childRects = <String, Rect>{
      'header': Rect.fromLTWH(40, 55, size.width - 80, 48),
      'body': Rect.fromLTWH(40, 115, size.width - 80, 64),
      'footer': Rect.fromLTWH(40, 191, size.width - 80, 44),
    };

    childRects.forEach((label, rect) {
      canvas.drawRect(rect, childFill);
      canvas.drawRect(rect, childBorder);
      _drawLabel(canvas, 'LayoutId(id: \'$label\')',
          rect.topLeft + const Offset(6, 6), const Color(0xFF1D4ED8), 10);
      _drawLabel(canvas, label.toUpperCase(),
          rect.center - const Offset(0, 6), const Color(0xFF1E3A8A), 9);
    });

    // Delegate box on the right.
    final delegateRect = Rect.fromLTWH(
      size.width - 130,
      size.height / 2 - 44,
      110,
      88,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(delegateRect, const Radius.circular(8)),
      delegateFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(delegateRect, const Radius.circular(8)),
      delegateBorder,
    );
    _drawLabel(canvas, 'Delegate', delegateRect.topLeft + const Offset(8, 8),
        const Color(0xFF92400E), 10);
    _drawLabel(canvas, 'layoutChild(id)', delegateRect.topLeft + const Offset(8, 26),
        const Color(0xFF78350F), 9);
    _drawLabel(canvas, 'positionChild(id)', delegateRect.topLeft + const Offset(8, 42),
        const Color(0xFF78350F), 9);
    _drawLabel(canvas, 'hasChild(id)', delegateRect.topLeft + const Offset(8, 58),
        const Color(0xFF78350F), 9);

    // Arrows from delegate to each child.
    final arrowStart = Offset(delegateRect.left, delegateRect.center.dy);
    childRects.forEach((_, rect) {
      final arrowEnd = Offset(rect.right, rect.center.dy);
      _drawArrow(canvas, arrowStart, arrowEnd, arrowPaint);
    });
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color,
      double fontSize) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, position);
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Paint paint) {
    canvas.drawLine(from, to, paint);
    // Arrowhead.
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final len = (dx * dx + dy * dy) * 0.5;
    if (len == 0) return;
    final ux = dx / len * 8;
    final uy = dy / len * 8;
    final path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(to.dx - ux + uy * 0.5, to.dy - uy - ux * 0.5)
      ..lineTo(to.dx - ux - uy * 0.5, to.dy - uy + ux * 0.5)
      ..close();
    canvas.drawPath(path, Paint()..color = paint.color);
  }

  @override
  bool shouldRepaint(_DiagramPainter old) => false;
}

// ─── Reusable UI helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(
  BuildContext context,
  String number,
  String title,
  String subtitle,
) {
  final scheme = Theme.of(context).colorScheme;
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          scheme.primaryContainer,
          scheme.secondaryContainer,
        ],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: scheme.primary,
          child: Text(
            number,
            style: TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _codeSnippet(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: Color(0xFFCDD6F4),
        height: 1.6,
      ),
    ),
  );
}

Widget _labelChip(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _infoCard(BuildContext context, String text) {
  final scheme = Theme.of(context).colorScheme;
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: scheme.outline.withAlpha(80)),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: scheme.onSurface, height: 1.5),
    ),
  );
}

// ─── Section builders ─────────────────────────────────────────────────────────

// Section 1: Hero Banner
Widget _buildHeroBanner(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Container(
    margin: const EdgeInsets.only(bottom: 28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.primary,
          scheme.tertiary,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: scheme.primary.withAlpha(80),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.grid_view_rounded, color: scheme.onPrimary, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'LayoutId',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: scheme.onPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'A thin wrapper that stamps an Object identity onto a child widget '
            'so that a MultiChildLayoutDelegate can address it by name during '
            'the layout pass.',
            style: TextStyle(
              fontSize: 14,
              color: scheme.onPrimary.withAlpha(220),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          // Relationship diagram row.
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pillBox('LayoutId', scheme.onPrimary, scheme.primary),
                const Icon(Icons.arrow_forward, color: Colors.white70),
                _pillBox('CustomMultiChildLayout', scheme.onPrimary, scheme.primary),
                const Icon(Icons.arrow_forward, color: Colors.white70),
                _pillBox('MultiChildLayoutDelegate', scheme.onPrimary, scheme.primary),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _heroBadge('LayoutId(id: myId, child: widget)', scheme),
              _heroBadge('hasChild(id)', scheme),
              _heroBadge('layoutChild(id, constraints)', scheme),
              _heroBadge('positionChild(id, offset)', scheme),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Key insight: LayoutId does NOT affect painting, hit-testing, or '
            'semantics. It is purely a build-phase annotation that the parent '
            'layout system reads to route children to the correct slot in your '
            'delegate\'s performLayout callback.',
            style: TextStyle(
              fontSize: 12,
              color: scheme.onPrimary.withAlpha(200),
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _pillBox(String text, Color fg, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bg.withAlpha(120),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: fg.withAlpha(60)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _heroBadge(String text, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(25),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.white.withAlpha(50)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: scheme.onPrimary,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// Section 2: Simple Three-Zone Layout
Widget _buildThreeZoneDemo(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '2',
        'Three-Zone Layout',
        '_ThreeZoneDelegate  ·  IDs: "header", "body", "footer"',
      ),
      _infoCard(
        context,
        'The delegate calls layoutChild("header", ...) then positionChild("header", Offset.zero) '
        'to place each zone. The body receives all remaining space after the fixed header and footer heights are subtracted.',
      ),
      _codeSnippet(
        'CustomMultiChildLayout(\n'
        '  delegate: _ThreeZoneDelegate(headerHeight: 56, footerHeight: 48),\n'
        '  children: [\n'
        '    LayoutId(id: \'header\', child: HeaderWidget()),\n'
        '    LayoutId(id: \'body\',   child: BodyWidget()),\n'
        '    LayoutId(id: \'footer\', child: FooterWidget()),\n'
        '  ],\n'
        ')',
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 260,
        child: CustomMultiChildLayout(
          delegate: _ThreeZoneDelegate(headerHeight: 56, footerHeight: 48),
          children: [
            LayoutId(
              id: 'header',
              child: Container(
                color: scheme.primary,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(Icons.dashboard_rounded, color: scheme.onPrimary),
                    const SizedBox(width: 10),
                    Text(
                      'HEADER ZONE',
                      style: TextStyle(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    _labelChip('id: "header"', Colors.white.withAlpha(50),
                        scheme.onPrimary),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            LayoutId(
              id: 'body',
              child: Container(
                color: scheme.surfaceContainerLow,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.view_agenda_rounded,
                          size: 36, color: scheme.primary),
                      const SizedBox(height: 8),
                      Text(
                        'BODY ZONE — flexible height',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _labelChip(
                          'id: "body"', scheme.primaryContainer, scheme.onPrimaryContainer),
                    ],
                  ),
                ),
              ),
            ),
            LayoutId(
              id: 'footer',
              child: Container(
                color: scheme.secondaryContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        size: 16, color: scheme.onSecondaryContainer),
                    const SizedBox(width: 6),
                    Text(
                      'FOOTER ZONE',
                      style: TextStyle(
                        color: scheme.onSecondaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _labelChip('id: "footer"', scheme.secondary.withAlpha(60),
                        scheme.onSecondaryContainer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          _legendDot(scheme.primary, 'header (56 px)'),
          const SizedBox(width: 16),
          _legendDot(scheme.surfaceContainerLow, 'body (flexible)'),
          const SizedBox(width: 16),
          _legendDot(scheme.secondaryContainer, 'footer (48 px)'),
        ],
      ),
    ],
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black26),
        ),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 11)),
    ],
  );
}

// Section 3: Enum IDs
Widget _buildEnumSlotDemo(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '3',
        'Named Enum IDs',
        'enum _SlotId { left, center, right }  ·  type-safe slot addressing',
      ),
      _infoCard(
        context,
        'Any Object can be an ID — using an enum makes it impossible to accidentally '
        'misspell a slot name. The delegate switches on the enum value to apply '
        'different sizing rules per slot.',
      ),
      _codeSnippet(
        'enum _SlotId { left, center, right }\n\n'
        'LayoutId(id: _SlotId.left,   child: LeftPanel())\n'
        'LayoutId(id: _SlotId.center, child: MainContent())\n'
        'LayoutId(id: _SlotId.right,  child: RightPanel())',
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 120,
        child: CustomMultiChildLayout(
          delegate: _EnumSlotDelegate(gap: 8),
          children: [
            LayoutId(
              id: _SlotId.left,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF86EFAC)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.west_rounded,
                        color: Color(0xFF16A34A), size: 28),
                    const SizedBox(height: 4),
                    Text(
                      '_SlotId.left',
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            LayoutId(
              id: _SlotId.center,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFA78BFA)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.center_focus_strong_rounded,
                        color: Color(0xFF7C3AED), size: 28),
                    const SizedBox(height: 4),
                    const Text(
                      '_SlotId.center',
                      style: TextStyle(
                        color: Color(0xFF4C1D95),
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            LayoutId(
              id: _SlotId.right,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFCD34D)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.east_rounded,
                        color: Color(0xFFD97706), size: 28),
                    const SizedBox(height: 4),
                    const Text(
                      '_SlotId.right',
                      style: TextStyle(
                        color: Color(0xFF78350F),
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _infoCard(
        context,
        'Compile-time guarantee: passing _SlotId.lft instead of _SlotId.left '
        'is a compile error, not a silent layout miss.',
      ),
    ],
  );
}

// Section 4: Dynamic Position Slider
Widget _buildDynamicSplitDemo(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '4',
        'Dynamic Position Slider',
        'ValueNotifier<double> drives split ratio — layout re-runs on every change',
      ),
      _infoCard(
        context,
        'A top-level ValueNotifier<double> holds the split ratio (0.0–1.0). '
        '_SplitDelegate is constructed with the current ratio and reads it inside '
        'performLayout. ValueListenableBuilder rebuilds the parent, which passes '
        'a fresh delegate, triggering a layout re-run automatically.',
      ),
      _codeSnippet(
        'final _splitRatio = ValueNotifier<double>(0.4);\n\n'
        'ValueListenableBuilder<double>(\n'
        '  valueListenable: _splitRatio,\n'
        '  builder: (ctx, ratio, _) => CustomMultiChildLayout(\n'
        '    delegate: _SplitDelegate(ratio: ratio),\n'
        '    children: [\n'
        '      LayoutId(id: \'left\',  child: LeftPane()),\n'
        '      LayoutId(id: \'right\', child: RightPane()),\n'
        '    ],\n'
        '  ),\n'
        ')',
      ),
      const SizedBox(height: 12),
      ValueListenableBuilder<double>(
        valueListenable: _splitRatio,
        builder: (ctx, ratio, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Split ratio: ${(ratio * 100).toStringAsFixed(0)}% / '
                    '${((1 - ratio) * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
              Slider(
                value: ratio,
                min: 0.1,
                max: 0.9,
                divisions: 16,
                label: '${(ratio * 100).toStringAsFixed(0)}%',
                onChanged: (v) => _splitRatio.value = v,
              ),
              SizedBox(
                height: 100,
                child: CustomMultiChildLayout(
                  delegate: _SplitDelegate(ratio: ratio),
                  children: [
                    LayoutId(
                      id: 'left',
                      child: Container(
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.view_sidebar_rounded,
                                  color: scheme.onPrimaryContainer, size: 22),
                              const SizedBox(height: 4),
                              Text(
                                'LEFT',
                                style: TextStyle(
                                  color: scheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${(ratio * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: scheme.onPrimaryContainer.withAlpha(180),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    LayoutId(
                      id: 'right',
                      child: Container(
                        decoration: BoxDecoration(
                          color: scheme.tertiaryContainer,
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(10)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.view_sidebar_outlined,
                                  color: scheme.onTertiaryContainer, size: 22),
                              const SizedBox(height: 4),
                              Text(
                                'RIGHT',
                                style: TextStyle(
                                  color: scheme.onTertiaryContainer,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${((1 - ratio) * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: scheme.onTertiaryContainer.withAlpha(180),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

// Section 5: Responsive Delegate
Widget _buildResponsiveDemo(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '5',
        'Responsive Delegate',
        '_ResponsiveDelegate switches between stacked and side-by-side at 480 px',
      ),
      _infoCard(
        context,
        'Inside performLayout, the delegate reads the incoming Size to choose '
        'between a compact (stacked) and a wide (side-by-side) layout. Resize '
        'via the breakpoint chip row below — each chip wraps the layout in a '
        'SizedBox of the chosen width.',
      ),
      _codeSnippet(
        'class _ResponsiveDelegate extends MultiChildLayoutDelegate {\n'
        '  void performLayout(Size size) {\n'
        '    final isWide = size.width >= 480;\n'
        '    if (isWide) {\n'
        '      // nav left (160 px) + content fills rest\n'
        '    } else {\n'
        '      // nav top (48 px) + content fills rest\n'
        '    }\n'
        '  }\n'
        '}',
      ),
      const SizedBox(height: 12),
      // Breakpoint chips.
      ValueListenableBuilder<double>(
        valueListenable: _simulatedWidth,
        builder: (ctx, width, _) {
          return Wrap(
            spacing: 8,
            children: [320.0, 600.0, 900.0].map((w) {
              final selected = width == w;
              return FilterChip(
                label: Text('${w.toInt()} px'),
                selected: selected,
                onSelected: (_) => _simulatedWidth.value = w,
                selectedColor: scheme.primaryContainer,
                checkmarkColor: scheme.primary,
              );
            }).toList(),
          );
        },
      ),
      const SizedBox(height: 12),
      ValueListenableBuilder<double>(
        valueListenable: _simulatedWidth,
        builder: (ctx, simW, _) {
          final isWide = simW >= 480;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isWide ? scheme.primaryContainer : scheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isWide
                      ? 'WIDE mode: side-by-side (nav left + content right)'
                      : 'COMPACT mode: stacked (nav top + content below)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isWide
                        ? scheme.onPrimaryContainer
                        : scheme.onTertiaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Clamp simulated width so it fits on screen.
              LayoutBuilder(
                builder: (ctx2, boxConstraints) {
                  final displayW =
                      simW.clamp(0.0, boxConstraints.maxWidth).toDouble();
                  return SizedBox(
                    width: displayW,
                    height: isWide ? 120 : 140,
                    child: CustomMultiChildLayout(
                      delegate: _ResponsiveDelegate(breakpoint: 480),
                      children: [
                        LayoutId(
                          id: 'nav',
                          child: Container(
                            color: scheme.primary,
                            child: Center(
                              child: Text(
                                isWide ? 'NAV\n(left)' : 'NAV BAR (top)',
                                style: TextStyle(
                                  color: scheme.onPrimary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        LayoutId(
                          id: 'content',
                          child: Container(
                            color: scheme.surfaceContainerLow,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.article_rounded,
                                      size: 24, color: scheme.primary),
                                  const SizedBox(height: 4),
                                  Text(
                                    'CONTENT',
                                    style: TextStyle(
                                      color: scheme.onSurface,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'simulated width: ${simW.toInt()} px',
                                    style: TextStyle(
                                      color: scheme.onSurface.withAlpha(150),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    ],
  );
}

// Section 6: CustomPainter Diagram
Widget _buildDiagramSection(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '6',
        'Architecture Diagram',
        'CustomPainter visualising how delegate methods connect to LayoutId children',
      ),
      _infoCard(
        context,
        'Red arrows show the delegate calling layoutChild(id) and positionChild(id) '
        'for each LayoutId-tagged child. The delegate holds no references to widget '
        'instances — communication is entirely through the opaque Object id.',
      ),
      const SizedBox(height: 12),
      Container(
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outline.withAlpha(80)),
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          painter: _DiagramPainter(),
          size: const Size(double.infinity, 280),
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          _legendDot(const Color(0xFF1E40AF), 'CustomMultiChildLayout'),
          const SizedBox(width: 12),
          _legendDot(const Color(0xFFDBEAFE), 'LayoutId child'),
          const SizedBox(width: 12),
          _legendDot(const Color(0xFFFEF3C7), 'Delegate'),
          const SizedBox(width: 12),
          Container(
            width: 24,
            height: 2,
            color: const Color(0xFFDC2626),
          ),
          const SizedBox(width: 4),
          const Text('layoutChild / positionChild',
              style: TextStyle(fontSize: 11)),
        ],
      ),
    ],
  );
}

// Section 7: Overlay Badge Pattern
Widget _buildBadgePatternDemo(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '7',
        'Overlay Badge Pattern',
        '_BadgeDelegate positions "content" at (0,0) and "badge" at (right-edge, top)',
      ),
      _infoCard(
        context,
        'The delegate calls layoutChild("content", ...) first to learn the '
        'content\'s size, then uses that measured width to position the badge '
        'at (contentSize.width - badgeRadius, -badgeRadius). This is a '
        'common pattern for notification counts and status indicators.',
      ),
      _codeSnippet(
        'final contentSize = layoutChild(\'content\', constraints);\n'
        'positionChild(\'content\', Offset.zero);\n\n'
        'layoutChild(\'badge\', BoxConstraints.tightFor(width: r*2, height: r*2));\n'
        'positionChild(\'badge\', Offset(contentSize.width - r, -r));',
      ),
      const SizedBox(height: 20),
      // Show three badge examples in a row.
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _badgeExample(
              context, Icons.notifications_rounded, 3, scheme.primary, '3'),
          _badgeExample(
              context, Icons.mail_rounded, 99, scheme.error, '99+'),
          _badgeExample(
              context, Icons.cloud_rounded, 0, Colors.green, ''),
        ],
      ),
    ],
  );
}

Widget _badgeExample(BuildContext context, IconData icon, int count,
    Color badgeColor, String label) {
  final scheme = Theme.of(context).colorScheme;
  return SizedBox(
    width: 80,
    height: 70,
    child: CustomMultiChildLayout(
      delegate: _BadgeDelegate(badgeRadius: 12),
      children: [
        LayoutId(
          id: 'content',
          child: Container(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outline.withAlpha(60)),
            ),
            child: Center(
              child: Icon(icon, size: 32, color: scheme.primary),
            ),
          ),
        ),
        LayoutId(
          id: 'badge',
          child: count > 0 || label.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                    color: label.isEmpty ? Colors.green : badgeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: label.isEmpty
                      ? null
                      : Center(
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    ),
  );
}

// Section 8: hasChild Guard Demo
Widget _buildHasChildGuardDemo(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '8',
        'hasChild Guard Demo',
        'Toggle the optional child on/off — delegate guards safely with hasChild()',
      ),
      _infoCard(
        context,
        'Calling layoutChild() for a child that was not provided throws a '
        'FlutterError. Always wrap optional children with if (hasChild(id)) '
        'before calling layoutChild() or positionChild().',
      ),
      _codeSnippet(
        'void performLayout(Size size) {\n'
        '  // Required child is always safe.\n'
        '  layoutChild(\'required\', BoxConstraints.tightFor(...));\n'
        '  positionChild(\'required\', Offset.zero);\n\n'
        '  // Guard optional child.\n'
        '  if (hasChild(\'optional\')) {\n'
        '    layoutChild(\'optional\', BoxConstraints.tightFor(...));\n'
        '    positionChild(\'optional\', Offset(0, size.height * 0.6));\n'
        '  }\n'
        '}',
      ),
      const SizedBox(height: 12),
      ValueListenableBuilder<bool>(
        valueListenable: _showOptional,
        builder: (ctx, showOpt, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Optional child:',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Switch(
                    value: showOpt,
                    onChanged: (v) => _showOptional.value = v,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    showOpt ? 'visible (hasChild = true)' : 'hidden (hasChild = false)',
                    style: TextStyle(
                      color: showOpt ? Colors.green : scheme.error,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 160,
                child: CustomMultiChildLayout(
                  delegate: _OptionalChildDelegate(),
                  children: [
                    LayoutId(
                      id: 'required',
                      child: Container(
                        color: scheme.primaryContainer,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_rounded,
                                  size: 28, color: scheme.onPrimaryContainer),
                              const SizedBox(height: 6),
                              Text(
                                'REQUIRED child',
                                style: TextStyle(
                                  color: scheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'always present — always laid out',
                                style: TextStyle(
                                  color: scheme.onPrimaryContainer.withAlpha(180),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (showOpt)
                      LayoutId(
                        id: 'optional',
                        child: Container(
                          color: scheme.tertiaryContainer,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.tune_rounded,
                                    size: 24,
                                    color: scheme.onTertiaryContainer),
                                const SizedBox(height: 4),
                                Text(
                                  'OPTIONAL child',
                                  style: TextStyle(
                                    color: scheme.onTertiaryContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'guarded by hasChild("optional")',
                                  style: TextStyle(
                                    color: scheme.onTertiaryContainer.withAlpha(180),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: showOpt
                      ? const Color(0xFFF0FDF4)
                      : const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: showOpt
                        ? const Color(0xFF86EFAC)
                        : const Color(0xFFFCD34D),
                  ),
                ),
                child: Text(
                  showOpt
                      ? 'Both children provided → delegate lays out both zones normally.'
                      : 'Optional child removed → delegate skips layoutChild("optional") safely. '
                        'The required zone expands to fill the full height.',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

// Section 9: Comparison Table
Widget _buildComparisonTable(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;

  final headers = ['Approach', 'Strengths', 'Weaknesses', 'Best For'];
  final rows = [
    [
      'LayoutId +\nCustomMultiChildLayout',
      'Full position control, delegate encapsulates policy, type-safe IDs',
      'More boilerplate, requires delegate class per pattern',
      'Dashboards, complex fixed slot UIs, badge overlays',
    ],
    [
      'Stack +\nPositioned',
      'Simple syntax, no delegate needed, good for absolute overlays',
      'Children do not influence each other\'s sizes, overflow risks',
      'Absolute overlays, tooltips, floating actions',
    ],
    [
      'LayoutBuilder +\nRow/Column',
      'Adapts to parent constraints, familiar widget model',
      'Children share axis, no arbitrary independent sizing',
      'Responsive flex layouts within a single axis',
    ],
    [
      'CustomPainter',
      'Pixel-level control, great for graphics and charts',
      'No real widgets — no interactivity, accessibility, or composition',
      'Data visualisation, decorative rendering',
    ],
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '9',
        'Comparison',
        'LayoutId vs Stack+Positioned vs LayoutBuilder vs CustomPainter',
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(
            color: scheme.outline.withAlpha(80),
            borderRadius: BorderRadius.circular(8),
          ),
          columnWidths: const {
            0: FixedColumnWidth(160),
            1: FixedColumnWidth(200),
            2: FixedColumnWidth(200),
            3: FixedColumnWidth(200),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: scheme.primaryContainer),
              children: headers.map((h) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    h,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                );
              }).toList(),
            ),
            ...rows.asMap().entries.map((entry) {
              final i = entry.key;
              final row = entry.value;
              final bg = i.isEven
                  ? scheme.surface
                  : scheme.surfaceContainerLowest;
              return TableRow(
                decoration: BoxDecoration(color: bg),
                children: row.map((cell) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      cell,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: scheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    ],
  );
}

// Section 10: API Cheat Sheet
Widget _buildApiCheatSheet(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        '10',
        'API Cheat Sheet',
        'LayoutId constructor + MultiChildLayoutDelegate methods quick reference',
      ),
      // LayoutId table.
      _apiSubHeading(context, 'LayoutId Constructor'),
      _apiTable(
        context,
        [
          ['Parameter', 'Type', 'Required', 'Description'],
          ['key', 'Key?', 'No', 'Standard widget key.'],
          ['id', 'Object', 'YES', 'Opaque identifier; any Object (String, int, enum).'],
          ['child', 'Widget', 'YES', 'The widget to tag. Must be last positional.'],
        ],
        scheme,
      ),
      const SizedBox(height: 16),
      _apiSubHeading(context, 'MultiChildLayoutDelegate Methods'),
      _apiTable(
        context,
        [
          ['Method', 'Signature', 'Returns', 'Notes'],
          [
            'hasChild',
            'hasChild(Object childId)',
            'bool',
            'Returns true if a LayoutId with this id is among the children.',
          ],
          [
            'layoutChild',
            'layoutChild(Object childId, BoxConstraints constraints)',
            'Size',
            'Lays out the child and returns its chosen size. Each child must be laid out exactly once.',
          ],
          [
            'positionChild',
            'positionChild(Object childId, Offset offset)',
            'void',
            'Places the child\'s top-left corner at offset. Can be called in any order.',
          ],
          [
            'getSize',
            'getSize(BoxConstraints constraints)',
            'Size',
            'Override to report the delegate\'s own size. Default: loosest constraint.',
          ],
          [
            'shouldRelayout',
            'shouldRelayout(MultiChildLayoutDelegate oldDelegate)',
            'bool',
            'Return true when the layout geometry may have changed. Called on every build.',
          ],
          [
            'relayout',
            'Listenable? relayout (constructor param)',
            'void',
            'Listenable that triggers layout without a rebuild (e.g. Animation, ValueNotifier).',
          ],
        ],
        scheme,
      ),
      const SizedBox(height: 16),
      _apiSubHeading(context, 'Common Gotchas'),
      ...[
        'Every child with a LayoutId must be laid out exactly once inside performLayout.',
        'Do NOT call layoutChild for a child that is not in the children list — use hasChild first.',
        'positionChild can be called before layoutChild — but the child\'s paint position will not reflect the layout size.',
        'LayoutId itself has zero render impact; it only annotates the child for the delegate.',
        'The id Object is compared by == — custom classes should override == and hashCode.',
        'Children without a LayoutId are invisible to the delegate (they are simply not laid out).',
      ].map((tip) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: scheme.outline.withAlpha(60)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded,
                  size: 16, color: scheme.tertiary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tip,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      const SizedBox(height: 8),
      _codeSnippet(
        '// Minimal LayoutId usage:\n'
        'CustomMultiChildLayout(\n'
        '  delegate: MyDelegate(),\n'
        '  children: [\n'
        '    LayoutId(id: \'a\', child: const RedBox()),\n'
        '    LayoutId(id: \'b\', child: const BlueBox()),\n'
        '  ],\n'
        ')\n\n'
        '// Minimal delegate:\n'
        'class MyDelegate extends MultiChildLayoutDelegate {\n'
        '  void performLayout(Size size) {\n'
        '    layoutChild(\'a\', BoxConstraints.tightFor(width: 100, height: 100));\n'
        '    positionChild(\'a\', Offset.zero);\n'
        '    layoutChild(\'b\', BoxConstraints.tightFor(width: 80, height: 80));\n'
        '    positionChild(\'b\', const Offset(110, 10));\n'
        '  }\n'
        '  bool shouldRelayout(MyDelegate old) => false;\n'
        '}',
      ),
    ],
  );
}

Widget _apiSubHeading(BuildContext context, String text) {
  final scheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: scheme.primary,
      ),
    ),
  );
}

Widget _apiTable(
    BuildContext context, List<List<String>> rows, ColorScheme scheme) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Table(
      border: TableBorder.all(
        color: scheme.outline.withAlpha(80),
        borderRadius: BorderRadius.circular(8),
      ),
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: rows.asMap().entries.map((entry) {
        final i = entry.key;
        final row = entry.value;
        final isHeader = i == 0;
        final bg = isHeader
            ? scheme.secondaryContainer
            : i.isEven
                ? scheme.surface
                : scheme.surfaceContainerLowest;
        return TableRow(
          decoration: BoxDecoration(color: bg),
          children: row.map((cell) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                cell,
                style: TextStyle(
                  fontSize: isHeader ? 12 : 11.5,
                  fontWeight:
                      isHeader ? FontWeight.w800 : FontWeight.w400,
                  color: isHeader
                      ? scheme.onSecondaryContainer
                      : scheme.onSurface,
                  height: 1.4,
                  fontFamily: (!isHeader && row.indexOf(cell) == 1)
                      ? 'monospace'
                      : null,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    ),
  );
}

// ─── Tab views ────────────────────────────────────────────────────────────────

Widget _tabView(List<Widget> sections) {
  return ListView.separated(
    padding: const EdgeInsets.all(16),
    itemCount: sections.length,
    separatorBuilder: (_, idx) => const SizedBox(height: 24),
    itemBuilder: (ctx, i) => sections[i],
  );
}

// ─── Entry point ─────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
    ),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'LayoutId Deep Dive',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(icon: Icon(Icons.info_outlined),          text: 'Hero'),
              Tab(icon: Icon(Icons.view_agenda_rounded),    text: '3-Zone'),
              Tab(icon: Icon(Icons.view_column_rounded),    text: 'Enum IDs'),
              Tab(icon: Icon(Icons.tune_rounded),           text: 'Slider'),
              Tab(icon: Icon(Icons.devices_rounded),        text: 'Responsive'),
              Tab(icon: Icon(Icons.account_tree_rounded),   text: 'Diagram'),
              Tab(icon: Icon(Icons.notifications_rounded),  text: 'Badge'),
              Tab(icon: Icon(Icons.toggle_on_rounded),      text: 'hasChild'),
              Tab(icon: Icon(Icons.compare_arrows_rounded), text: 'Compare'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Hero + API cheat sheet.
            _tabView([
              Builder(builder: _buildHeroBanner),
              Builder(builder: _buildApiCheatSheet),
            ]),
            // Tab 2: Three-Zone.
            _tabView([Builder(builder: _buildThreeZoneDemo)]),
            // Tab 3: Enum IDs.
            _tabView([Builder(builder: _buildEnumSlotDemo)]),
            // Tab 4: Dynamic Split.
            _tabView([Builder(builder: _buildDynamicSplitDemo)]),
            // Tab 5: Responsive.
            _tabView([Builder(builder: _buildResponsiveDemo)]),
            // Tab 6: Diagram.
            _tabView([Builder(builder: _buildDiagramSection)]),
            // Tab 7: Badge.
            _tabView([Builder(builder: _buildBadgePatternDemo)]),
            // Tab 8: hasChild guard.
            _tabView([Builder(builder: _buildHasChildGuardDemo)]),
            // Tab 9: Comparison + API cheat sheet.
            _tabView([
              Builder(builder: _buildComparisonTable),
            ]),
          ],
        ),
      ),
    ),
  );
}
