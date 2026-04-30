import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (stateless file — no StatefulWidget allowed)
// ---------------------------------------------------------------------------

final ValueNotifier<OverlayChildLocation> _activeLocation =
    ValueNotifier<OverlayChildLocation>(OverlayChildLocation.nearestOverlay);

// ---------------------------------------------------------------------------
// Controllers (top-level, reused across builds)
// ---------------------------------------------------------------------------

final OverlayPortalController _tooltipController = OverlayPortalController(
  debugLabel: 'tooltip-demo',
);
final OverlayPortalController _dropdownController = OverlayPortalController(
  debugLabel: 'dropdown-demo',
);
final OverlayPortalController _contextMenuController = OverlayPortalController(
  debugLabel: 'context-menu-demo',
);
final OverlayPortalController _popoverController = OverlayPortalController(
  debugLabel: 'popover-demo',
);
final OverlayPortalController _badgeController = OverlayPortalController(
  debugLabel: 'badge-demo',
);
final OverlayPortalController _rootController = OverlayPortalController(
  debugLabel: 'root-overlay-demo',
);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
    ),
    home: const _OverlayChildLocationDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root demo shell — stateless, driven by ValueNotifiers
// ---------------------------------------------------------------------------

class _OverlayChildLocationDemo extends StatelessWidget {
  const _OverlayChildLocationDemo();

  static const List<String> _tabLabels = <String>[
    'Hero',
    'Architecture',
    'Live Demo',
    'Use Cases',
    'Anchor',
    'Comparison',
    'Mini Cards',
    'Pitfalls',
    'Cheat Sheet',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabLabels.length,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primaryContainer,
          foregroundColor: cs.onPrimaryContainer,
          title: const Text('OverlayChildLocation — Deep Visual Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: cs.onPrimaryContainer,
            indicatorColor: cs.primary,
            tabs: _tabLabels
                .map((String label) => Tab(text: label))
                .toList(),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _ArchitectureDiagramTab(),
            _LiveDemoTab(),
            _UseCasesTab(),
            _AnchorPatternTab(),
            _ComparisonTab(),
            _MiniCardsTab(),
            _PitfallsTab(),
            _CheatSheetTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 1 — Hero Banner
// ---------------------------------------------------------------------------

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _GradientBanner(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                cs.primaryContainer,
                cs.secondaryContainer,
                cs.tertiaryContainer,
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.layers_rounded, size: 48, color: cs.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'OverlayChildLocation',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'An enum that controls which Overlay an OverlayPortal '
                    'renders its overlay child on — the nearest ancestor Overlay '
                    'or the root Overlay above the current View.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _HeroBadge(label: 'Flutter 3.27+', icon: Icons.flutter_dash),
                      _HeroBadge(label: 'widgets library', icon: Icons.widgets_rounded),
                      _HeroBadge(label: 'OverlayPortal', icon: Icons.open_in_new_rounded),
                      _HeroBadge(label: 'enum', icon: Icons.code_rounded),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('What is OverlayChildLocation?'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'OverlayChildLocation is a two-value enum used as the overlayLocation '
                'property of OverlayPortal. It decides which Overlay receives the '
                'portal\'s overlay child:\n\n'
                '• nearestOverlay (default) — targets the closest ancestor Overlay '
                'in the widget tree. In most apps this is the Overlay created by '
                'Navigator.\n\n'
                '• rootOverlay — skips nested Overlays and targets the root Overlay '
                'that sits directly below the current View widget. This makes the '
                'overlay child float above navigation bars, drawers, bottom sheets, '
                'and even other navigators.',
          ),
          const SizedBox(height: 24),
          _SectionTitle('Enum Values at a Glance'),
          const SizedBox(height: 12),
          _EnumValueCard(
            name: 'OverlayChildLocation.nearestOverlay',
            description:
                'Renders on the closest ancestor Overlay. Paint order: '
                'drawn on top of the OverlayEntry that hosts the OverlayPortal, '
                'and below the next OverlayEntry above it. Ideal for local '
                'widgets like tooltips and dropdowns that belong to a specific '
                'route.',
            icon: Icons.location_on_rounded,
            color: cs.primaryContainer,
            onColor: cs.onPrimaryContainer,
          ),
          const SizedBox(height: 8),
          _EnumValueCard(
            name: 'OverlayChildLocation.rootOverlay',
            description:
                'Renders on the root Overlay, bypassing any nested navigators or '
                'modal routes. Use this for truly global overlays such as in-app '
                'notifications, system-level banners, or overlays that must '
                'survive route transitions.',
            icon: Icons.public_rounded,
            color: cs.secondaryContainer,
            onColor: cs.onSecondaryContainer,
          ),
          const SizedBox(height: 24),
          _SectionTitle('Historical Note'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'Before OverlayChildLocation was introduced, OverlayPortal offered '
                'a named constructor OverlayPortal.targetsRootOverlay() to achieve '
                'root-Overlay rendering. That constructor is now deprecated '
                '(after Flutter 3.33.0-0.0.pre) in favour of passing '
                'overlayLocation: OverlayChildLocation.rootOverlay to the '
                'primary constructor.',
          ),
        ],
      ),
    );
  }
}

class _GradientBanner extends StatelessWidget {
  const _GradientBanner({required this.gradient, required this.child});
  final Gradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(icon, size: 16, color: cs.onPrimary),
      label: Text(label, style: TextStyle(color: cs.onPrimary, fontSize: 12)),
      backgroundColor: cs.primary,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

class _EnumValueCard extends StatelessWidget {
  const _EnumValueCard({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.onColor,
  });
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 32, color: onColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: onColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: onColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 2 — Architecture Diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _ArchitectureDiagramTab extends StatelessWidget {
  const _ArchitectureDiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('Widget Tree & Overlay Routing'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'The diagram below shows how OverlayPortal routes its overlay child '
                'to different Overlay instances depending on the overlayLocation value.',
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 520,
            child: CustomPaint(
              painter: _OverlayArchitecturePainter(colorScheme: cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Layer Rendering Order'),
          const SizedBox(height: 12),
          _LayerLegend(colorScheme: cs),
          const SizedBox(height: 24),
          _SectionTitle('Key Insight'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'OverlayPortal renders its overlay child as a render child of the '
                'target Overlay\'s RenderObject, not of its own position in the tree. '
                'This means the overlay child can visually extend beyond the bounds '
                'of the OverlayPortal widget, and can receive hit-test events outside '
                'of those bounds — as long as it stays inside the target Overlay.',
          ),
        ],
      ),
    );
  }
}

class _OverlayArchitecturePainter extends CustomPainter {
  const _OverlayArchitecturePainter({required this.colorScheme});
  final ColorScheme colorScheme;

  static const double _boxW = 160;
  static const double _boxH = 44;
  static const double _radius = 10;

  void _drawBox(
    Canvas canvas,
    Offset topLeft,
    String label,
    Color bg,
    Color fg,
    TextStyle style,
  ) {
    final RRect rr = RRect.fromRectAndRadius(
      topLeft & const Size(_boxW, _boxH),
      const Radius.circular(_radius),
    );
    canvas.drawRRect(rr, Paint()..color = bg);
    canvas.drawRRect(
      rr,
      Paint()
        ..color = fg.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    final TextPainter tp = TextPainter(
      text: TextSpan(text: label, style: style.copyWith(color: fg, fontSize: 12)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: _boxW - 8);
    tp.paint(
      canvas,
      topLeft +
          Offset(
            (_boxW - tp.width) / 2,
            (_boxH - tp.height) / 2,
          ),
    );
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Color color, {bool dashed = false}) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    if (dashed) {
      const double dashLen = 6;
      final double dx = to.dx - from.dx;
      final double dy = to.dy - from.dy;
      final double len = (to - from).distance;
      int count = (len / (dashLen * 2)).floor();
      for (int i = 0; i < count; i++) {
        final double t0 = (i * 2 * dashLen) / len;
        final double t1 = ((i * 2 + 1) * dashLen) / len;
        canvas.drawLine(
          Offset(from.dx + dx * t0, from.dy + dy * t0),
          Offset(from.dx + dx * t1, from.dy + dy * t1),
          p,
        );
      }
    } else {
      canvas.drawLine(from, to, p);
    }
    // Arrow head
    final double angle = (to - from).direction;
    const double headLen = 10;
    const double headAngle = 0.4;
    final Path head = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - headLen * (1 * _cos(angle - headAngle)),
        to.dy - headLen * (_sin(angle - headAngle)),
      )
      ..lineTo(
        to.dx - headLen * _cos(angle + headAngle),
        to.dy - headLen * _sin(angle + headAngle),
      )
      ..close();
    canvas.drawPath(head, Paint()..color = color);
  }

  static double _cos(double a) => math.cos(a);
  static double _sin(double a) => math.sin(a);

  @override
  void paint(Canvas canvas, Size size) {
    final TextStyle style = TextStyle(
      fontWeight: FontWeight.w600,
      color: colorScheme.onSurface,
    );

    final double cx = size.width / 2;

    // Root View box
    _drawBox(canvas, Offset(cx - _boxW / 2, 8), 'View', colorScheme.surfaceContainerHighest, colorScheme.outline, style);

    // Root Overlay box
    _drawBox(canvas, Offset(16, 68), 'Root Overlay', colorScheme.primaryContainer, colorScheme.onPrimaryContainer, style);

    // MaterialApp / Navigator box
    _drawBox(canvas, Offset(cx - _boxW / 2, 68), 'MaterialApp\n(Navigator)', colorScheme.secondaryContainer, colorScheme.onSecondaryContainer, style);

    // Nested Navigator
    _drawBox(canvas, Offset(size.width - _boxW - 16, 68), 'Nested\nNavigator', colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer, style);

    // Route Overlay (nearest)
    _drawBox(canvas, Offset(cx - _boxW / 2, 148), 'Route Overlay\n(nearest)', colorScheme.secondaryContainer, colorScheme.onSecondaryContainer, style);

    // OverlayPortal
    _drawBox(canvas, Offset(cx - _boxW / 2, 228), 'OverlayPortal', colorScheme.errorContainer, colorScheme.onErrorContainer, style);

    // overlayLocation labels
    _drawBox(canvas, Offset(16, 308), 'rootOverlay\nchild', colorScheme.primaryContainer, colorScheme.onPrimaryContainer, style);
    _drawBox(canvas, Offset(cx - _boxW / 2, 308), 'nearestOverlay\nchild', colorScheme.secondaryContainer, colorScheme.onSecondaryContainer, style);

    // Draw connection lines
    final Color lineColor = colorScheme.outline;
    final Color nearColor = colorScheme.secondary;
    final Color rootColor = colorScheme.primary;

    // View → Root Overlay
    _drawArrow(canvas, Offset(cx - _boxW / 2, 30), Offset(16 + _boxW / 2, 68), lineColor);
    // View → MaterialApp
    _drawArrow(canvas, Offset(cx, 52), Offset(cx, 68), lineColor);
    // View → Nested Navigator
    _drawArrow(canvas, Offset(cx + _boxW / 2, 30), Offset(size.width - 16 - _boxW / 2, 68), lineColor);
    // MaterialApp → Route Overlay
    _drawArrow(canvas, Offset(cx, 112), Offset(cx, 148), lineColor);
    // Route Overlay → OverlayPortal
    _drawArrow(canvas, Offset(cx, 192), Offset(cx, 228), lineColor);
    // OverlayPortal → nearestOverlay child
    _drawArrow(canvas, Offset(cx, 272), Offset(cx, 308), nearColor);
    // OverlayPortal → rootOverlay child (dashed, curved via intermediate point)
    _drawArrow(canvas, Offset(cx - _boxW / 2, 252), Offset(16 + _boxW / 2, 330), rootColor, dashed: true);

    // Legend text
    final TextPainter nearTP = TextPainter(
      text: TextSpan(
        text: '← nearestOverlay',
        style: style.copyWith(color: nearColor, fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    nearTP.paint(canvas, Offset(cx + _boxW / 2 + 8, 308 + (_boxH - nearTP.height) / 2));

    final TextPainter rootTP = TextPainter(
      text: TextSpan(
        text: '← rootOverlay (dashed)',
        style: style.copyWith(color: rootColor, fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    rootTP.paint(canvas, Offset(16, 308 + _boxH + 8));

    // Step labels
    _drawLabel(canvas, Offset(cx + _boxW / 2 + 8, 148 + 8), '② nearest Overlay\n   receives child', colorScheme.secondary, style);
    _drawLabel(canvas, Offset(16, 68 + _boxH + 8), '① root Overlay\n   receives child', colorScheme.primary, style);

    // Divider showing "above route" boundary
    final Paint divPaint = Paint()
      ..color = colorScheme.outline.withValues(alpha: 0.4)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    const double divY = 420;
    canvas.drawLine(Offset(0, divY), Offset(size.width, divY), divPaint);
    final TextPainter divTP = TextPainter(
      text: TextSpan(
        text: 'Overlay paint order: OverlayEntry → OverlayPortal children → next OverlayEntry',
        style: style.copyWith(fontSize: 10, color: colorScheme.outline),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 32);
    divTP.paint(canvas, Offset(16, divY + 8));
  }

  void _drawLabel(Canvas canvas, Offset pos, String text, Color color, TextStyle base) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: base.copyWith(color: color, fontSize: 10)),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 160);
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(_OverlayArchitecturePainter oldDelegate) =>
      oldDelegate.colorScheme != colorScheme;
}

class _LayerLegend extends StatelessWidget {
  const _LayerLegend({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: <Widget>[
        _LegendChip(color: colorScheme.primaryContainer, label: 'Root Overlay'),
        _LegendChip(color: colorScheme.secondaryContainer, label: 'Nearest Overlay'),
        _LegendChip(color: colorScheme.tertiaryContainer, label: 'Nested Navigator'),
        _LegendChip(color: colorScheme.errorContainer, label: 'OverlayPortal'),
      ],
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          child: const SizedBox(width: 20, height: 20),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 3 — Live Demo
// ---------------------------------------------------------------------------

class _LiveDemoTab extends StatelessWidget {
  const _LiveDemoTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('Live OverlayChildLocation Demo'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'Select an OverlayChildLocation value below and then press Show Overlay '
                'to see an OverlayPortal render its child on the chosen Overlay. '
                'The overlay child is shown as a floating banner.',
          ),
          const SizedBox(height: 20),
          _LocationSelector(colorScheme: cs),
          const SizedBox(height: 20),
          _LiveOverlayDemoArea(colorScheme: cs),
          const SizedBox(height: 24),
          _SectionTitle('How the Demo Works'),
          const SizedBox(height: 12),
          _CodeExplanationCard(
            code: '''OverlayPortal(
  controller: _controller,
  overlayLocation: OverlayChildLocation.nearestOverlay, // or rootOverlay
  overlayChildBuilder: (BuildContext ctx) {
    return Positioned(
      top: 80, left: 16, right: 16,
      child: _FloatingBanner(),
    );
  },
  child: ElevatedButton(
    onPressed: _controller.show,
    child: Text('Show Overlay'),
  ),
)''',
          ),
        ],
      ),
    );
  }
}

class _LocationSelector extends StatelessWidget {
  const _LocationSelector({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<OverlayChildLocation>(
      valueListenable: _activeLocation,
      builder: (BuildContext context, OverlayChildLocation value, Widget? child) {
        return Card(
          elevation: 0,
          color: colorScheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'overlayLocation:',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),
                RadioGroup<OverlayChildLocation>(
                  groupValue: value,
                  onChanged: (OverlayChildLocation? v) {
                    if (v != null) _activeLocation.value = v;
                  },
                  child: Column(
                    children: <Widget>[
                      RadioListTile<OverlayChildLocation>(
                        title: const Text('OverlayChildLocation.nearestOverlay'),
                        subtitle: const Text('Default — targets closest ancestor Overlay'),
                        value: OverlayChildLocation.nearestOverlay,
                      ),
                      RadioListTile<OverlayChildLocation>(
                        title: const Text('OverlayChildLocation.rootOverlay'),
                        subtitle: const Text('Targets root Overlay, bypasses nested navigators'),
                        value: OverlayChildLocation.rootOverlay,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LiveOverlayDemoArea extends StatelessWidget {
  const _LiveOverlayDemoArea({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<OverlayChildLocation>(
      valueListenable: _activeLocation,
      builder: (BuildContext context, OverlayChildLocation location, Widget? child) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Active: ${location == OverlayChildLocation.nearestOverlay ? "nearestOverlay" : "rootOverlay"}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                OverlayPortal(
                  controller: _tooltipController,
                  overlayLocation: location,
                  overlayChildBuilder: (BuildContext ctx) {
                    return Positioned(
                      top: 90,
                      left: 24,
                      right: 24,
                      child: _FloatingOverlayBanner(
                        location: location,
                        onDismiss: _tooltipController.hide,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: _tooltipController.show,
                        icon: const Icon(Icons.visibility_rounded),
                        label: const Text('Show Overlay'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: _tooltipController.hide,
                        icon: const Icon(Icons.visibility_off_rounded),
                        label: const Text('Hide Overlay'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: ValueNotifier<bool>(true),
                  builder: (BuildContext ctx, bool value2, Widget? child2) {
                    final bool isShowing = _tooltipController.isShowing;
                    return Text(
                      'Controller.isShowing = $isShowing',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isShowing ? colorScheme.primary : colorScheme.outline,
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloatingOverlayBanner extends StatelessWidget {
  const _FloatingOverlayBanner({required this.location, required this.onDismiss});
  final OverlayChildLocation location;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final bool isRoot = location == OverlayChildLocation.rootOverlay;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      color: isRoot ? cs.primaryContainer : cs.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              isRoot ? Icons.public_rounded : Icons.location_on_rounded,
              color: isRoot ? cs.onPrimaryContainer : cs.onSecondaryContainer,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isRoot ? 'Root Overlay Child' : 'Nearest Overlay Child',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isRoot ? cs.onPrimaryContainer : cs.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    isRoot
                        ? 'Rendered on the root Overlay — floats above everything'
                        : 'Rendered on the nearest ancestor Overlay',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isRoot ? cs.onPrimaryContainer : cs.onSecondaryContainer,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close_rounded,
                  color: isRoot ? cs.onPrimaryContainer : cs.onSecondaryContainer),
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 4 — Use Cases
// ---------------------------------------------------------------------------

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('Use-Case Patterns'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'The choice between nearestOverlay and rootOverlay determines '
                'the visual stacking and lifetime of the overlay child. '
                'Below are common patterns and which location value fits each.',
          ),
          const SizedBox(height: 20),
          _UseCaseCard(
            title: 'Tooltip',
            description:
                'Anchored to the target widget; should close when navigating. '
                'Use nearestOverlay — it lives and dies with the route.',
            icon: Icons.info_outline_rounded,
            location: 'nearestOverlay',
            color: cs.primaryContainer,
            onColor: cs.onPrimaryContainer,
          ),
          const SizedBox(height: 8),
          _UseCaseCard(
            title: 'Dropdown / Select Menu',
            description:
                'Expands below (or above) the trigger widget; position is relative '
                'to that widget\'s layout. Use nearestOverlay so InheritedWidget '
                'theming remains consistent with the trigger.',
            icon: Icons.arrow_drop_down_circle_rounded,
            location: 'nearestOverlay',
            color: cs.primaryContainer,
            onColor: cs.onPrimaryContainer,
          ),
          const SizedBox(height: 8),
          _UseCaseCard(
            title: 'Context Menu',
            description:
                'Appears at pointer position. Use nearestOverlay; the menu is '
                'scoped to the current view and should dismiss on route pop.',
            icon: Icons.menu_rounded,
            location: 'nearestOverlay',
            color: cs.primaryContainer,
            onColor: cs.onPrimaryContainer,
          ),
          const SizedBox(height: 8),
          _UseCaseCard(
            title: 'In-App Notification Banner',
            description:
                'Must appear above routes, navigation bars, and drawers. '
                'Use rootOverlay to guarantee top-level visibility.',
            icon: Icons.notifications_active_rounded,
            location: 'rootOverlay',
            color: cs.secondaryContainer,
            onColor: cs.onSecondaryContainer,
          ),
          const SizedBox(height: 8),
          _UseCaseCard(
            title: 'Global Loading Indicator',
            description:
                'A full-screen dimming overlay that blocks all interaction. '
                'Use rootOverlay so it sits above every navigator and modal.',
            icon: Icons.hourglass_top_rounded,
            location: 'rootOverlay',
            color: cs.secondaryContainer,
            onColor: cs.onSecondaryContainer,
          ),
          const SizedBox(height: 8),
          _UseCaseCard(
            title: 'Nested-Navigator Popover',
            description:
                'When showing a popover inside an inner navigator that should '
                'not bleed into the outer navigator\'s Overlay, use nearestOverlay '
                'targeting the inner Overlay. For the opposite — use rootOverlay.',
            icon: Icons.call_to_action_rounded,
            location: 'context-dependent',
            color: cs.tertiaryContainer,
            onColor: cs.onTertiaryContainer,
          ),
          const SizedBox(height: 24),
          _SectionTitle('Interactive Overlay Showcase'),
          const SizedBox(height: 12),
          _InteractiveShowcase(colorScheme: cs),
        ],
      ),
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.location,
    required this.color,
    required this.onColor,
  });
  final String title;
  final String description;
  final IconData icon;
  final String location;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 28, color: onColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: onColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(
                          location,
                          style: TextStyle(fontSize: 10, color: onColor),
                        ),
                        backgroundColor: onColor.withValues(alpha: 0.15),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: onColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveShowcase extends StatelessWidget {
  const _InteractiveShowcase({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        _ShowcaseButton(
          label: 'Dropdown',
          icon: Icons.arrow_drop_down_rounded,
          controller: _dropdownController,
          location: OverlayChildLocation.nearestOverlay,
          colorScheme: colorScheme,
          overlayContent: _DropdownOverlayContent(onDismiss: _dropdownController.hide),
        ),
        _ShowcaseButton(
          label: 'Context Menu',
          icon: Icons.more_vert_rounded,
          controller: _contextMenuController,
          location: OverlayChildLocation.nearestOverlay,
          colorScheme: colorScheme,
          overlayContent: _ContextMenuContent(onDismiss: _contextMenuController.hide),
        ),
        _ShowcaseButton(
          label: 'Popover',
          icon: Icons.chat_bubble_outline_rounded,
          controller: _popoverController,
          location: OverlayChildLocation.nearestOverlay,
          colorScheme: colorScheme,
          overlayContent: _PopoverContent(onDismiss: _popoverController.hide),
        ),
        _ShowcaseButton(
          label: 'Root Banner',
          icon: Icons.notifications_rounded,
          controller: _rootController,
          location: OverlayChildLocation.rootOverlay,
          colorScheme: colorScheme,
          overlayContent: _RootBannerContent(onDismiss: _rootController.hide),
        ),
      ],
    );
  }
}

class _ShowcaseButton extends StatelessWidget {
  const _ShowcaseButton({
    required this.label,
    required this.icon,
    required this.controller,
    required this.location,
    required this.colorScheme,
    required this.overlayContent,
  });
  final String label;
  final IconData icon;
  final OverlayPortalController controller;
  final OverlayChildLocation location;
  final ColorScheme colorScheme;
  final Widget overlayContent;

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayLocation: location,
      overlayChildBuilder: (BuildContext ctx) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: controller.hide,
              ),
            ),
            Positioned(
              top: 120,
              left: 24,
              right: 24,
              child: overlayContent,
            ),
          ],
        );
      },
      child: FilledButton.tonalIcon(
        onPressed: controller.show,
        icon: Icon(icon, size: 18),
        label: Text(label),
      ),
    );
  }
}

class _DropdownOverlayContent extends StatelessWidget {
  const _DropdownOverlayContent({required this.onDismiss});
  final VoidCallback onDismiss;

  static const List<String> _items = <String>['Option Alpha', 'Option Beta', 'Option Gamma', 'Option Delta'];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      color: cs.surfaceContainerHigh,
      child: Column(
        children: _items.map((String item) {
          return ListTile(
            leading: const Icon(Icons.radio_button_unchecked_rounded),
            title: Text(item),
            onTap: onDismiss,
          );
        }).toList(),
      ),
    );
  }
}

class _ContextMenuContent extends StatelessWidget {
  const _ContextMenuContent({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      color: cs.surfaceContainerHigh,
      child: Column(
        children: <Widget>[
          ListTile(leading: const Icon(Icons.copy_rounded), title: const Text('Copy'), onTap: onDismiss),
          ListTile(leading: const Icon(Icons.cut_rounded), title: const Text('Cut'), onTap: onDismiss),
          ListTile(leading: const Icon(Icons.paste_rounded), title: const Text('Paste'), onTap: onDismiss),
          const Divider(),
          ListTile(leading: const Icon(Icons.delete_outline_rounded), title: const Text('Delete'), onTap: onDismiss),
        ],
      ),
    );
  }
}

class _PopoverContent extends StatelessWidget {
  const _PopoverContent({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      color: cs.inverseSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.info_rounded, color: cs.onInverseSurface),
                const SizedBox(width: 8),
                Text('Popover Info', style: TextStyle(color: cs.onInverseSurface, fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: cs.onInverseSurface, size: 18),
                  onPressed: onDismiss,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'This popover is rendered via OverlayPortal with nearestOverlay. '
              'It inherits the same Theme as the trigger widget.',
              style: TextStyle(color: cs.onInverseSurface, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _RootBannerContent extends StatelessWidget {
  const _RootBannerContent({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(14),
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            Icon(Icons.public_rounded, color: cs.onPrimaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Root Overlay Banner — floats above everything via rootOverlay',
                style: TextStyle(color: cs.onPrimaryContainer, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close_rounded, color: cs.onPrimaryContainer),
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 5 — Anchor-to-Widget Pattern
// ---------------------------------------------------------------------------

class _AnchorPatternTab extends StatelessWidget {
  const _AnchorPatternTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('Anchor-to-Widget Pattern'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'A common requirement is to position an overlay child relative to '
                'a specific widget — e.g., show a dropdown directly below a button. '
                'OverlayPortal supports two complementary techniques:\n\n'
                '① overlayChildLayoutBuilder constructor — provides the child widget\'s '
                'size and paint transform (as OverlayChildLayoutInfo) at layout time.\n\n'
                '② CompositedTransformTarget + CompositedTransformFollower — the '
                'traditional anchor link. Note: do NOT place CompositedTransformFollower '
                'between the OverlayPortal and the Overlay when using '
                'overlayChildLayoutBuilder, as this prevents correct transform delivery.',
          ),
          const SizedBox(height: 20),
          _AnchorDemo(colorScheme: cs),
          const SizedBox(height: 24),
          _SectionTitle('OverlayChildLayoutInfo Fields'),
          const SizedBox(height: 12),
          _FieldTable(
            fields: const <_ApiField>[
              _ApiField(
                name: 'childSize',
                type: 'Size',
                description: 'The size of the OverlayPortal child in its own coordinate system.',
              ),
              _ApiField(
                name: 'childPaintTransform',
                type: 'Matrix4',
                description:
                    'The paint transform of the child in the target Overlay\'s coordinate system. '
                    'Use this to translate and position the overlay child relative to the anchor.',
              ),
              _ApiField(
                name: 'overlaySize',
                type: 'Size',
                description: 'The size of the target Overlay, useful for edge clamping.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle('CompositedTransformTarget Pattern'),
          const SizedBox(height: 12),
          _CompositedAnchorDemo(colorScheme: cs),
        ],
      ),
    );
  }
}

class _AnchorDemo extends StatelessWidget {
  const _AnchorDemo({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'overlayChildLayoutBuilder Demo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            OverlayPortal.overlayChildLayoutBuilder(
              controller: _badgeController,
              overlayLocation: OverlayChildLocation.nearestOverlay,
              overlayChildBuilder: (BuildContext ctx, OverlayChildLayoutInfo info) {
                // Position the badge in the top-right corner of the trigger
                final Matrix4 transform = info.childPaintTransform;
                final double dx = transform.getTranslation().x + info.childSize.width - 8;
                final double dy = transform.getTranslation().y - 8;
                final double safeX = dx.clamp(0, info.overlaySize.width - 24);
                final double safeY = dy.clamp(0, info.overlaySize.height - 24);
                return Positioned(
                  left: safeX,
                  top: safeY,
                  child: _NotificationBadge(),
                );
              },
              child: FilledButton.tonalIcon(
                onPressed: () {
                  if (_badgeController.isShowing) {
                    _badgeController.hide();
                  } else {
                    _badgeController.show();
                  }
                },
                icon: const Icon(Icons.notifications_rounded),
                label: const Text('Toggle Badge (anchored)'),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The red badge is positioned relative to the button using '
              'OverlayChildLayoutInfo.childPaintTransform and childSize.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.error,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(color: cs.error.withValues(alpha: 0.4), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text('3', style: TextStyle(color: cs.onError, fontSize: 11, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _CompositedAnchorDemo extends StatelessWidget {
  const _CompositedAnchorDemo({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CompositedTransformTarget + Follower',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _ProseCard(
              text:
                  'Wrap the anchor widget in CompositedTransformTarget(link: link). '
                  'Inside overlayChildBuilder, wrap the floating content in '
                  'CompositedTransformFollower(link: link) — the follower tracks '
                  'the anchor\'s position automatically.',
            ),
            const SizedBox(height: 12),
            _CodeExplanationCard(
              code: '''final LayerLink _link = LayerLink();

OverlayPortal(
  controller: _ctrl,
  overlayChildBuilder: (ctx) => CompositedTransformFollower(
    link: _link,
    offset: Offset(0, anchorHeight),
    child: _DropdownMenu(),
  ),
  child: CompositedTransformTarget(
    link: _link,
    child: ElevatedButton(
      onPressed: _ctrl.show,
      child: Text('Open Menu'),
    ),
  ),
)''',
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 6 — Comparison
// ---------------------------------------------------------------------------

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('OverlayPortal vs Alternatives'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'There are several ways to render content above the main widget tree '
                'in Flutter. This tab compares them, focusing on how OverlayPortal '
                'with different OverlayChildLocation values compares to the alternatives.',
          ),
          const SizedBox(height: 20),
          _ComparisonTable(colorScheme: cs),
          const SizedBox(height: 24),
          _SectionTitle('Decision Flow'),
          const SizedBox(height: 12),
          _DecisionFlow(colorScheme: cs),
          const SizedBox(height: 24),
          _SectionTitle('Paint Order Details'),
          const SizedBox(height: 12),
          _PaintOrderCard(colorScheme: cs),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(colorScheme.primaryContainer),
        columns: <DataColumn>[
          DataColumn(label: Text('Approach', style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer))),
          DataColumn(label: Text('InheritedWidget access', style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer))),
          DataColumn(label: Text('Overlay target', style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer))),
          DataColumn(label: Text('Lifetime', style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer))),
          DataColumn(label: Text('Best for', style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onPrimaryContainer))),
        ],
        rows: const <DataRow>[
          DataRow(cells: <DataCell>[
            DataCell(Text('OverlayEntry', style: TextStyle(fontFamily: 'monospace'))),
            DataCell(Text('❌ No — separate subtree')),
            DataCell(Text('manual insert/remove')),
            DataCell(Text('manual')),
            DataCell(Text('Complex drag avatars')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('OverlayPortal (nearest)', style: TextStyle(fontFamily: 'monospace'))),
            DataCell(Text('✅ Yes')),
            DataCell(Text('closest ancestor Overlay')),
            DataCell(Text('tied to OverlayPortal')),
            DataCell(Text('Tooltips, dropdowns')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('OverlayPortal (root)', style: TextStyle(fontFamily: 'monospace'))),
            DataCell(Text('✅ Yes')),
            DataCell(Text('root Overlay')),
            DataCell(Text('tied to OverlayPortal')),
            DataCell(Text('Global banners')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('Stack', style: TextStyle(fontFamily: 'monospace'))),
            DataCell(Text('✅ Yes')),
            DataCell(Text('N/A — within widget')),
            DataCell(Text('widget lifetime')),
            DataCell(Text('Simple local layering')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('Navigator.overlay', style: TextStyle(fontFamily: 'monospace'))),
            DataCell(Text('❌ No')),
            DataCell(Text('Navigator\'s Overlay')),
            DataCell(Text('manual')),
            DataCell(Text('Route transitions')),
          ]),
        ],
      ),
    );
  }
}

class _DecisionFlow extends StatelessWidget {
  const _DecisionFlow({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _FlowStep(
          step: '1',
          question: 'Does the overlay need InheritedWidget access (Theme, locale)?',
          yes: 'Use OverlayPortal',
          no: 'OverlayEntry is also fine',
          colorScheme: colorScheme,
        ),
        _FlowArrow(),
        _FlowStep(
          step: '2',
          question: 'Should it float above nested navigators and modal routes?',
          yes: 'overlayLocation: OverlayChildLocation.rootOverlay',
          no: 'overlayLocation: OverlayChildLocation.nearestOverlay (default)',
          colorScheme: colorScheme,
        ),
        _FlowArrow(),
        _FlowStep(
          step: '3',
          question: 'Need to anchor to a specific widget using layout info?',
          yes: 'Use OverlayPortal.overlayChildLayoutBuilder',
          no: 'Use OverlayPortal (with optional CompositedTransformFollower)',
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({
    required this.step,
    required this.question,
    required this.yes,
    required this.no,
    required this.colorScheme,
  });
  final String step;
  final String question;
  final String yes;
  final String no;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              radius: 14,
              child: Text(step, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(question, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _FlowAnswerRow(label: 'YES', text: yes, color: colorScheme.primary),
                  const SizedBox(height: 4),
                  _FlowAnswerRow(label: 'NO', text: no, color: colorScheme.outline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowAnswerRow extends StatelessWidget {
  const _FlowAnswerRow({required this.label, required this.text, required this.color});
  final String label;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('$label: ', style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 12)),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
}

class _FlowArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Center(child: Icon(Icons.arrow_downward_rounded, size: 20)),
    );
  }
}

class _PaintOrderCard extends StatelessWidget {
  const _PaintOrderCard({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Paint Order (bottom → top)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            _PaintLayer(index: 1, label: 'OverlayEntry (enclosing Route)', color: colorScheme.surfaceContainerLowest),
            _PaintLayer(index: 2, label: 'OverlayPortal child (first show())', color: colorScheme.primaryContainer),
            _PaintLayer(index: 3, label: 'OverlayPortal child (second show())', color: colorScheme.secondaryContainer),
            _PaintLayer(index: 4, label: 'Next OverlayEntry above', color: colorScheme.tertiaryContainer),
          ],
        ),
      ),
    );
  }
}

class _PaintLayer extends StatelessWidget {
  const _PaintLayer({required this.index, required this.label, required this.color});
  final int index;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
            child: SizedBox(width: 28, height: 28, child: Center(child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)))),
          ),
          const SizedBox(width: 10),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 7 — Mini Cards (6 use-case scenarios)
// ---------------------------------------------------------------------------

class _MiniCardsTab extends StatelessWidget {
  const _MiniCardsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('6 Scenario Mini-Cards'),
          const SizedBox(height: 12),
          _MiniCardGrid(colorScheme: cs),
        ],
      ),
    );
  }
}

class _MiniCardGrid extends StatelessWidget {
  const _MiniCardGrid({required this.colorScheme});
  final ColorScheme colorScheme;

  static const List<_MiniCardData> _cards = <_MiniCardData>[
    _MiniCardData(
      icon: Icons.chat_bubble_rounded,
      title: 'Tooltip',
      scenario: 'Show contextual help text above a widget.',
      code: 'overlayLocation: OverlayChildLocation.nearestOverlay',
      reason: 'Scoped to route; dismisses on navigation.',
    ),
    _MiniCardData(
      icon: Icons.menu_open_rounded,
      title: 'Dropdown Menu',
      scenario: 'Expand a selection list below a button.',
      code: 'overlayLocation: OverlayChildLocation.nearestOverlay',
      reason: 'Inherits same Theme; anchored via paint transform.',
    ),
    _MiniCardData(
      icon: Icons.notifications_rounded,
      title: 'Notification Banner',
      scenario: 'Show a system-level alert above all routes.',
      code: 'overlayLocation: OverlayChildLocation.rootOverlay',
      reason: 'Must survive route pushes and modal sheets.',
    ),
    _MiniCardData(
      icon: Icons.hourglass_full_rounded,
      title: 'Global Loader',
      scenario: 'Block all interaction during async operation.',
      code: 'overlayLocation: OverlayChildLocation.rootOverlay',
      reason: 'Needs to sit above NavigationBar and Drawer.',
    ),
    _MiniCardData(
      icon: Icons.label_rounded,
      title: 'Floating Badge',
      scenario: 'Show a badge anchored to a toolbar icon.',
      code: 'OverlayPortal.overlayChildLayoutBuilder',
      reason: 'Uses childPaintTransform for precise positioning.',
    ),
    _MiniCardData(
      icon: Icons.layers_rounded,
      title: 'Nested Navigator Overlay',
      scenario: 'Overlay within an inner navigator only.',
      code: 'overlayLocation: OverlayChildLocation.nearestOverlay',
      reason: 'Targets inner Overlay; stays within nested nav.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: _cards.length,
      itemBuilder: (BuildContext context, int index) {
        return _MiniCard(data: _cards[index], colorScheme: colorScheme, index: index);
      },
    );
  }
}

class _MiniCardData {
  const _MiniCardData({
    required this.icon,
    required this.title,
    required this.scenario,
    required this.code,
    required this.reason,
  });
  final IconData icon;
  final String title;
  final String scenario;
  final String code;
  final String reason;
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.data, required this.colorScheme, required this.index});
  final _MiniCardData data;
  final ColorScheme colorScheme;
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Color> bgColors = <Color>[
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.errorContainer,
      colorScheme.surfaceContainerHigh,
    ];
    final List<Color> fgColors = <Color>[
      colorScheme.onPrimaryContainer,
      colorScheme.onSecondaryContainer,
      colorScheme.onTertiaryContainer,
      colorScheme.onSurface,
      colorScheme.onErrorContainer,
      colorScheme.onSurface,
    ];
    final Color bg = bgColors[index % bgColors.length];
    final Color fg = fgColors[index % fgColors.length];

    return Card(
      elevation: 2,
      color: bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(data.icon, color: fg, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    data.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: fg, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(data.scenario, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: fg)),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(color: fg.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(data.code, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: fg)),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lightbulb_outline_rounded, size: 14, color: fg.withValues(alpha: 0.7)),
                const SizedBox(width: 4),
                Expanded(child: Text(data.reason, style: TextStyle(fontSize: 11, color: fg.withValues(alpha: 0.85)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 8 — Pitfalls
// ---------------------------------------------------------------------------

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('Common Pitfalls'),
          const SizedBox(height: 12),
          _PitfallTile(
            number: 1,
            title: 'Using CompositedTransformFollower between OverlayPortal and Overlay',
            detail:
                'When using OverlayPortal.overlayChildLayoutBuilder, the RenderObject '
                'of CompositedTransformFollower only establishes its paint transform '
                'during the compositing phase — too late for layout. This causes '
                'incorrect childPaintTransform values and triggers an assertion in '
                'debug mode.\n\nFix: Use CompositedTransformFollower inside the '
                'overlayChildBuilder (not as an ancestor of OverlayPortal).',
            colorScheme: cs,
          ),
          const SizedBox(height: 12),
          _PitfallTile(
            number: 2,
            title: 'Calling show() / hide() before the OverlayPortal is mounted',
            detail:
                'OverlayPortalController.show() and hide() can be called before the '
                'controller is attached to any OverlayPortal. However, the isShowing '
                'state in that pre-attach window is undefined and does not carry over '
                'when the controller is eventually attached.\n\nFix: Defer show/hide '
                'calls to post-frame callbacks or initState, ensuring the widget is '
                'mounted first.',
            colorScheme: cs,
          ),
          const SizedBox(height: 12),
          _PitfallTile(
            number: 3,
            title: 'Expecting overlay child to survive route pop',
            detail:
                'When using nearestOverlay, the overlay child is semantically a '
                'child of the OverlayPortal. If the route is popped and the '
                'OverlayPortal is unmounted, the overlay child is also removed — '
                'even if show() was called.\n\nFix: If the overlay must survive '
                'route transitions, use rootOverlay. If that is not appropriate, '
                'call hide() before popping the route.',
            colorScheme: cs,
          ),
          const SizedBox(height: 24),
          _SectionTitle('Semantics Gotcha'),
          const SizedBox(height: 12),
          _ProseCard(
            text:
                'The semantics subtree of the overlay child is attached to the '
                'OverlayPortal widget, not to the target Overlay. This means if '
                'OverlayPortal becomes invisible in a scroll view (but is kept '
                'alive by KeepAlive), the overlay child\'s semantics are also '
                'dropped from the accessibility tree — even though the overlay '
                'child is still visually painted on screen.\n\n'
                'This is usually acceptable but should be considered when building '
                'accessible overlays.',
          ),
          const SizedBox(height: 24),
          _SectionTitle('Deprecated API Warning'),
          const SizedBox(height: 12),
          _DeprecationWarning(colorScheme: cs),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.number,
    required this.title,
    required this.detail,
    required this.colorScheme,
  });
  final int number;
  final String title;
  final String detail;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.errorContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
          child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.onErrorContainer,
                fontWeight: FontWeight.w700,
              ),
        ),
        iconColor: colorScheme.onErrorContainer,
        collapsedIconColor: colorScheme.onErrorContainer,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              detail,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeprecationWarning extends StatelessWidget {
  const _DeprecationWarning({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.warning_amber_rounded, color: colorScheme.onTertiaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Deprecated: OverlayPortal.targetsRootOverlay()',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colorScheme.onTertiaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'The named constructor OverlayPortal.targetsRootOverlay() was deprecated '
              'after Flutter 3.33.0-0.0.pre. Migration is straightforward:\n\n'
              'Before:\n  OverlayPortal.targetsRootOverlay(controller: c, overlayChildBuilder: b)\n\n'
              'After:\n  OverlayPortal(controller: c, overlayChildBuilder: b,\n'
              '    overlayLocation: OverlayChildLocation.rootOverlay)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onTertiaryContainer,
                    fontFamily: 'monospace',
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 9 — API Cheat Sheet
// ---------------------------------------------------------------------------

class _CheatSheetTab extends StatelessWidget {
  const _CheatSheetTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionTitle('API Cheat Sheet'),
          const SizedBox(height: 12),
          _SectionSubtitle('OverlayChildLocation enum'),
          const SizedBox(height: 8),
          _FieldTable(
            fields: const <_ApiField>[
              _ApiField(
                name: 'OverlayChildLocation.nearestOverlay',
                type: 'enum value',
                description:
                    'Targets the closest ancestor Overlay. Default for OverlayPortal. '
                    'Paint order: after the enclosing OverlayEntry, before the next one.',
              ),
              _ApiField(
                name: 'OverlayChildLocation.rootOverlay',
                type: 'enum value',
                description:
                    'Targets the root Overlay below the View. Bypasses nested navigators '
                    'and modal routes. Replaces the deprecated targetsRootOverlay constructor.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionSubtitle('OverlayPortal'),
          const SizedBox(height: 8),
          _FieldTable(
            fields: const <_ApiField>[
              _ApiField(
                name: 'controller',
                type: 'OverlayPortalController',
                description: 'Required. Controls show/hide/bringToTop of the overlay child.',
              ),
              _ApiField(
                name: 'overlayChildBuilder',
                type: 'WidgetBuilder',
                description:
                    'Required. Builds the widget rendered on the target Overlay. '
                    'Called only when the controller is showing.',
              ),
              _ApiField(
                name: 'overlayLocation',
                type: 'OverlayChildLocation',
                description:
                    'Optional. Defaults to nearestOverlay. Set to rootOverlay for global overlays.',
              ),
              _ApiField(
                name: 'child',
                type: 'Widget?',
                description: 'The primary child of the OverlayPortal in the normal widget tree.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionSubtitle('OverlayPortal.overlayChildLayoutBuilder (named constructor)'),
          const SizedBox(height: 8),
          _FieldTable(
            fields: const <_ApiField>[
              _ApiField(
                name: 'overlayChildBuilder',
                type: 'OverlayChildLayoutBuilder',
                description:
                    'Widget Function(BuildContext, OverlayChildLayoutInfo). '
                    'Called during layout with size and paint transform of the child.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionSubtitle('OverlayPortalController'),
          const SizedBox(height: 8),
          _FieldTable(
            fields: const <_ApiField>[
              _ApiField(
                name: 'show()',
                type: 'void',
                description:
                    'Reveals the overlay child. The last controller to call show() '
                    'gets the highest z-index among siblings.',
              ),
              _ApiField(
                name: 'hide()',
                type: 'void',
                description: 'Hides the overlay child. Stateful descendants may lose state.',
              ),
              _ApiField(
                name: 'isShowing',
                type: 'bool',
                description: 'Whether the overlay child is currently shown.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionSubtitle('OverlayChildLayoutInfo (extension type)'),
          const SizedBox(height: 8),
          _FieldTable(
            fields: const <_ApiField>[
              _ApiField(
                name: 'childSize',
                type: 'Size',
                description: 'Size of OverlayPortal.child in its own coordinate space.',
              ),
              _ApiField(
                name: 'childPaintTransform',
                type: 'Matrix4',
                description:
                    'Paint transform of the child relative to the target Overlay\'s '
                    'coordinate space. Use for pixel-precise positioning.',
              ),
              _ApiField(
                name: 'overlaySize',
                type: 'Size',
                description: 'Size of the target Overlay. Use for edge-clamp calculations.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle('Quick Reference Snippets'),
          const SizedBox(height: 12),
          _CodeExplanationCard(
            code: '''// 1. Nearest Overlay (default)
OverlayPortal(
  controller: _ctrl,
  overlayChildBuilder: (ctx) => Positioned(top: 80, left: 16, right: 16, child: _MyWidget()),
  child: _TriggerButton(),
);

// 2. Root Overlay
OverlayPortal(
  controller: _ctrl,
  overlayLocation: OverlayChildLocation.rootOverlay,
  overlayChildBuilder: (ctx) => _GlobalBanner(),
  child: _TriggerButton(),
);

// 3. Layout-aware anchoring
OverlayPortal.overlayChildLayoutBuilder(
  controller: _ctrl,
  overlayChildBuilder: (ctx, info) {
    final t = info.childPaintTransform.getTranslation();
    return Positioned(
      left: t.x,
      top: t.y + info.childSize.height + 4,
      child: _DropdownMenu(),
    );
  },
  child: _TriggerButton(),
);

// 4. Controller lifecycle
final OverlayPortalController _ctrl = OverlayPortalController();
_ctrl.show();       // show overlay child
_ctrl.hide();       // hide overlay child
_ctrl.isShowing;    // query state''',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helper widgets
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w800,
          ),
    );
  }
}

class _SectionSubtitle extends StatelessWidget {
  const _SectionSubtitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: cs.secondary,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _ProseCard extends StatelessWidget {
  const _ProseCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class _CodeExplanationCard extends StatelessWidget {
  const _CodeExplanationCard({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            code,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: cs.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}

class _ApiField {
  const _ApiField({required this.name, required this.type, required this.description});
  final String name;
  final String type;
  final String description;
}

class _FieldTable extends StatelessWidget {
  const _FieldTable({required this.fields});
  final List<_ApiField> fields;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Column(
      children: fields.map((_ApiField f) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Card(
            elevation: 0,
            color: cs.surfaceContainerLow,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          f.name,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                        ),
                        Text(
                          f.type,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: cs.secondary,
                                fontFamily: 'monospace',
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      f.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
