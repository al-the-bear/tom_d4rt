import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Entry point required by the d4rt test harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B50DF),
    brightness: Brightness.light,
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Roboto',
    ),
    home: const _LookupBoundaryDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root shell: DefaultTabController + AppBar + TabBarView.
// ---------------------------------------------------------------------------
class _LookupBoundaryDemo extends StatelessWidget {
  const _LookupBoundaryDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Comparison'),
    Tab(text: 'Diagram'),
    Tab(text: 'of / maybeOf'),
    Tab(text: 'debugCheck'),
    Tab(text: 'Isolation'),
    Tab(text: 'dependOn'),
    Tab(text: 'Nested'),
    Tab(text: 'Pitfalls'),
    Tab(text: 'API'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LookupBoundary'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _TabHero(),
            _TabComparison(),
            _TabDiagram(),
            _TabOfVsMaybeOf(),
            _TabDebugCheck(),
            _TabIsolation(),
            _TabDependOn(),
            _TabNested(),
            _TabPitfalls(),
            _TabApiCheatSheet(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

/// A section heading with a bottom divider.
class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Divider(color: cs.outlineVariant, height: 1),
        ],
      ),
    );
  }
}

/// A styled card wrapper.
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      color: color ?? cs.surfaceContainerLow,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

/// Monospace code block widget.
class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          color: cs.onSurface,
          height: 1.55,
        ),
      ),
    );
  }
}

/// A labelled row bullet.
class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(height: 1.45))),
        ],
      ),
    );
  }
}

/// A small coloured badge label.
class _Badge extends StatelessWidget {
  const _Badge(this.label, {this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? cs.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color != null ? Colors.white : cs.onPrimaryContainer,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1: Hero banner
// ---------------------------------------------------------------------------
class _TabHero extends StatelessWidget {
  const _TabHero();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        // ---- Banner ----
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[cs.primary, cs.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.block_rounded, size: 48, color: cs.onPrimary),
              const SizedBox(height: 14),
              Text(
                'LookupBoundary',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Scoped inherited-widget isolation for testing and tooling.',
                style: TextStyle(
                  color: cs.onPrimary.withAlpha(220),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ---- The Problem ----
        _SectionHeading('The Problem'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Inherited widgets propagate upward',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Flutter\'s `context.dependOnInheritedWidgetOfExactType<T>()` '
                'walks the element tree upward until it finds the first '
                'matching `InheritedWidget` ancestor — or reaches the root. '
                'In a real app this is desirable: widgets share a single '
                'Theme, MediaQuery, or Navigator provided near the root.',
                style: TextStyle(height: 1.55),
              ),
              const SizedBox(height: 12),
              const _Bullet(
                'In the Flutter DevTools widget inspector, a subtree is '
                'rendered outside its normal position in the tree.',
              ),
              const _Bullet(
                'The inspector subtree must not accidentally depend on — '
                'and re-render because of — ambient `InheritedWidget`s from '
                'the host app.',
              ),
              const _Bullet(
                'Widget test harnesses similarly need isolated subtrees '
                'that do not leak dependencies to a surrounding `TestApp`.',
              ),
            ],
          ),
        ),

        // ---- What LookupBoundary Does ----
        _SectionHeading('What LookupBoundary Does'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '`LookupBoundary` is an `InheritedWidget` that acts as a '
                'firewall. When a descendant performs a lookup using the '
                '`LookupBoundary`-aware static methods, the walk stops at '
                'the nearest `LookupBoundary` in the tree instead of '
                'continuing to the root.',
                style: TextStyle(height: 1.55),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  _Badge('Blocks: dependOn…'),
                  const SizedBox(width: 8),
                  _Badge('Blocks: getInheritedWidget…'),
                ],
              ),
            ],
          ),
        ),

        // ---- Primary Use Cases ----
        _SectionHeading('Primary Use Cases'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildRow2Badge('DevTools / Widget Inspector',
                  'Subtrees rendered outside normal position', cs),
              const SizedBox(height: 10),
              _buildRow2Badge('Widget Testing', 'Isolated test subtrees', cs),
              const SizedBox(height: 10),
              _buildRow2Badge('Design System Sandboxes',
                  'Components previewed in isolation', cs),
            ],
          ),
        ),

        // ---- Quick API overview ----
        _SectionHeading('Quick Constructor'),
        _CodeBlock(
          'LookupBoundary({\n'
          '  Key? key,\n'
          '  required Widget child,\n'
          '})',
        ),
        const SizedBox(height: 12),
        _InfoCard(
          child: const Text(
            'LookupBoundary is defined in `package:flutter/widgets.dart` '
            '(not material) and is available from Flutter 3.7+. It is an '
            'InheritedWidget itself, which is why it can intercept the '
            'upward walk — the walk finds the LookupBoundary instance '
            'and the boundary-aware lookup methods stop there.',
            style: TextStyle(height: 1.5),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

Widget _buildRow2Badge(String label, String sub, ColorScheme cs) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Icon(Icons.check_circle_outline, size: 20, color: cs.primary),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(sub,
                style: const TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Tab 2: Normal vs Boundary lookup comparison
// ---------------------------------------------------------------------------
class _TabComparison extends StatelessWidget {
  const _TabComparison();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('Normal Lookup — Reaches Outer Theme'),
        const _InfoCard(
          child: Text(
            'Without a LookupBoundary, a descendant\'s Theme.of(context) '
            'walks all the way up and finds the outermost MaterialApp '
            'Theme. The deep widget inherits the outer purple seed colour.',
            style: TextStyle(height: 1.5),
          ),
        ),
        // Panel without boundary
        _ComparisonPanel(
          label: 'No LookupBoundary',
          useBoundary: false,
          cs: cs,
        ),
        const SizedBox(height: 20),
        _SectionHeading('With LookupBoundary — Lookup Blocked'),
        const _InfoCard(
          child: Text(
            'With a LookupBoundary wrapping the subtree, '
            'LookupBoundary.dependOnInheritedWidgetOfExactType<MediaQuery> '
            'returns null. The child falls back to a default value, '
            'demonstrating that the ambient MediaQuery did not leak through.',
            style: TextStyle(height: 1.5),
          ),
        ),
        _ComparisonPanel(
          label: 'Inside LookupBoundary',
          useBoundary: true,
          cs: cs,
        ),
        const SizedBox(height: 24),
        _SectionHeading('What the code looks like'),
        _CodeBlock(
          '// WITHOUT boundary:\n'
          '// Descendant context reads outermost Theme / MediaQuery.\n'
          'final theme = Theme.of(context); // found at root\n\n'
          '// WITH LookupBoundary around this subtree:\n'
          '// Use the boundary-aware static method:\n'
          'final mq = LookupBoundary\n'
          '    .dependOnInheritedWidgetOfExactType<MediaQuery>(context);\n'
          '// mq == null — lookup stopped at boundary.',
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ComparisonPanel extends StatelessWidget {
  const _ComparisonPanel({
    required this.label,
    required this.useBoundary,
    required this.cs,
  });
  final String label;
  final bool useBoundary;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final Widget innerPanel = _InnerComparisonWidget(
      useBoundary: useBoundary,
      borderColor: useBoundary ? cs.error : cs.primary,
    );

    final Widget content =
        useBoundary ? LookupBoundary(child: innerPanel) : innerPanel;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: useBoundary ? cs.errorContainer : cs.primaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: useBoundary
                    ? cs.onErrorContainer
                    : cs.onPrimaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }
}

class _InnerComparisonWidget extends StatelessWidget {
  const _InnerComparisonWidget({
    required this.useBoundary,
    required this.borderColor,
  });
  final bool useBoundary;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    // Demonstrate boundary-aware vs normal lookup.
    final MediaQuery? blockedMQ = useBoundary
        ? LookupBoundary.dependOnInheritedWidgetOfExactType<MediaQuery>(
            context)
        : null;
    final bool isBlocked = useBoundary && blockedMQ == null;

    // Normal Theme.of always walks to root even inside LookupBoundary —
    // because Theme.of uses the global dependOn, not the boundary-aware one.
    final ThemeData outerTheme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: outerTheme.colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                isBlocked ? Icons.block : Icons.check_circle,
                color: isBlocked ? Colors.red : Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isBlocked
                    ? 'MediaQuery blocked (null returned)'
                    : 'MediaQuery reached root provider',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isBlocked
                ? 'LookupBoundary.dependOnInheritedWidgetOfExactType'
                    '<MediaQuery>(context) → null\n'
                    'Fallback used: width = "unknown"'
                : 'Outer Theme seed: '
                    '${outerTheme.colorScheme.primary}',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: isBlocked ? Colors.red[700] : Colors.green[800],
            ),
          ),
          const SizedBox(height: 8),
          _Badge(
            isBlocked ? 'BLOCKED' : 'PASSED THROUGH',
            color: isBlocked ? Colors.red : Colors.green,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3: Diagram (CustomPainter)
// ---------------------------------------------------------------------------
class _TabDiagram extends StatelessWidget {
  const _TabDiagram();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('Widget Tree Diagram'),
        const _InfoCard(
          child: Text(
            'The diagram below shows a widget tree where LookupBoundary sits '
            'between a root-level Theme/MediaQuery and a ChildWidget. '
            'The upward lookup arrow from ChildWidget is blocked (✗) at the '
            'LookupBoundary node and never reaches the outer providers.',
            style: TextStyle(height: 1.5),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 380,
          child: CustomPaint(
            painter: _TreeDiagramPainter(cs: cs),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 20),
        _SectionHeading('Reading the diagram'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _DiagramLegendRow(color: cs.primary, label: 'Normal ancestors'),
              const SizedBox(height: 8),
              _DiagramLegendRow(
                  color: cs.error, label: 'LookupBoundary node'),
              const SizedBox(height: 8),
              _DiagramLegendRow(
                  color: cs.tertiary, label: 'ChildWidget (lookup origin)'),
              const SizedBox(height: 8),
              _DiagramLegendRow(
                  color: Colors.orange, label: 'Arrow = lookup walk'),
              const SizedBox(height: 8),
              const Text(
                '✗ at LookupBoundary = walk is intercepted and null is '
                'returned to the child instead of the ancestor value.',
                style: TextStyle(height: 1.45),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _DiagramLegendRow extends StatelessWidget {
  const _DiagramLegendRow({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(label),
      ],
    );
  }
}

class _TreeDiagramPainter extends CustomPainter {
  const _TreeDiagramPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const double nodeW = 160;
    const double nodeH = 40;
    const double vertGap = 60;
    const double startY = 24;

    // Node centres (x, y)
    final List<Offset> centres = <Offset>[
      Offset(cx, startY + nodeH / 2), // 0: RootApp
      Offset(cx, startY + nodeH + vertGap + nodeH / 2), // 1: Theme/MediaQuery
      Offset(cx, startY + 2 * (nodeH + vertGap) + nodeH / 2), // 2: LB
      Offset(cx, startY + 3 * (nodeH + vertGap) + nodeH / 2), // 3: Child
    ];

    final List<String> labels = <String>[
      'RootApp / MaterialApp',
      'Theme / MediaQuery',
      'LookupBoundary',
      'ChildWidget',
    ];
    final List<Color> boxColors = <Color>[
      cs.primary,
      cs.secondary,
      cs.error,
      cs.tertiary,
    ];

    final Paint linePaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint arrowPaint = Paint()
      ..color = Colors.orange.shade700
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Draw tree lines (top-down)
    for (int i = 0; i < centres.length - 1; i++) {
      canvas.drawLine(
        Offset(centres[i].dx, centres[i].dy + nodeH / 2),
        Offset(centres[i + 1].dx, centres[i + 1].dy - nodeH / 2),
        linePaint,
      );
    }

    // Draw dashed upward lookup arrow from Child to LookupBoundary
    _drawDashedArrow(
      canvas,
      arrowPaint,
      from: Offset(centres[3].dx + 30, centres[3].dy),
      to: Offset(centres[2].dx + 30, centres[2].dy + nodeH / 2 + 4),
    );

    // Draw ✗ between LookupBoundary and Theme
    final TextPainter xPainter = TextPainter(
      text: TextSpan(
        text: '✗',
        style: TextStyle(
          color: cs.error,
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    xPainter.paint(
      canvas,
      Offset(cx + 34, centres[2].dy + nodeH / 2 + 8),
    );

    // Draw nodes
    for (int i = 0; i < centres.length; i++) {
      final Rect rect = Rect.fromCenter(
        center: centres[i],
        width: nodeW,
        height: nodeH,
      );
      final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
      canvas.drawRRect(
        rRect,
        Paint()..color = boxColors[i].withAlpha(230),
      );
      canvas.drawRRect(
        rRect,
        Paint()
          ..color = boxColors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: nodeW - 8);
      tp.paint(
        canvas,
        Offset(centres[i].dx - tp.width / 2, centres[i].dy - tp.height / 2),
      );
    }

    // Legend text for arrow
    final TextPainter legendPainter = TextPainter(
      text: TextSpan(
        text: '← lookup walk (upward)',
        style: TextStyle(
          color: Colors.orange.shade700,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legendPainter.paint(
      canvas,
      Offset(cx + 38, centres[3].dy - 6),
    );
  }

  void _drawDashedArrow(
    Canvas canvas,
    Paint paint, {
    required Offset from,
    required Offset to,
  }) {
    const double dashLen = 6;
    const double gapLen = 4;
    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double dist = (Offset(dx, dy)).distance;
    double walked = 0;
    bool drawing = true;
    while (walked < dist) {
      final double seg = drawing ? dashLen : gapLen;
      final double end = (walked + seg).clamp(0, dist);
      if (drawing) {
        canvas.drawLine(
          Offset(from.dx + dx * walked / dist,
              from.dy + dy * walked / dist),
          Offset(from.dx + dx * end / dist, from.dy + dy * end / dist),
          paint,
        );
      }
      walked += seg;
      drawing = !drawing;
    }
    // Arrowhead pointing upward
    final double headLen = 10;
    final double angle = (to - from).direction;
    canvas.drawLine(
      to,
      to +
          Offset(headLen * (angle - 2.6).cos, headLen * (angle - 2.6).sin),
      paint,
    );
    canvas.drawLine(
      to,
      to +
          Offset(headLen * (angle + 2.6).cos, headLen * (angle + 2.6).sin),
      paint,
    );
  }

  @override
  bool shouldRepaint(_TreeDiagramPainter oldDelegate) => false;
}

extension _DoubleTrigo on double {
  double get cos => _mathCos(this);
  double get sin => _mathSin(this);
}

double _mathCos(double r) {
  // Taylor series cos(x): 1 - x²/2 + x⁴/24 - x⁶/720
  final double x = r % (2 * 3.14159265358979);
  final double x2 = x * x;
  return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
}

double _mathSin(double r) {
  // Taylor series sin(x): x - x³/6 + x⁵/120 - x⁷/5040
  final double x = r % (2 * 3.14159265358979);
  final double x3 = x * x * x;
  return x - x3 / 6 + x3 * x * x / 120 - x3 * x * x * x * x / 5040;
}

// ---------------------------------------------------------------------------
// Tab 4: of vs maybeOf safety
// ---------------------------------------------------------------------------
class _TabOfVsMaybeOf extends StatelessWidget {
  const _TabOfVsMaybeOf();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('Theme.of vs Theme.maybeOf inside a Boundary'),
        const _InfoCard(
          child: Text(
            'When the ambient Theme is blocked by a LookupBoundary and you '
            'use the boundary-aware lookup, `Theme.of(context)` would throw '
            'an assertion error in debug mode (the inherited widget is '
            'genuinely not reachable). `Theme.maybeOf(context)` returns null '
            'gracefully, letting you provide a fallback.',
            style: TextStyle(height: 1.5),
          ),
        ),
        const SizedBox(height: 16),

        // Card A: .of behaviour
        _InfoCard(
          color: cs.errorContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.warning_amber_rounded,
                      color: cs.onErrorContainer, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Theme.of(context) — dangerous inside boundary',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onErrorContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _CodeBlock(
                '// If Theme InheritedWidget is blocked:\n'
                'final theme = Theme.of(context);\n'
                '// ↑ Throws in debug:\n'
                '//   Could not find an ancestor of type "Theme"\n'
                '//   in the widget tree.\n'
                '//\n'
                '// Theme.of uses the global\n'
                '// dependOnInheritedWidgetOfExactType —\n'
                '// it does NOT respect LookupBoundary.\n'
                '//\n'
                '// Safe only when Theme IS above boundary\n'
                '// or boundary-aware methods are used.',
              ),
              const SizedBox(height: 10),
              _Badge('Can assert / throw', color: cs.error),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Card B: .maybeOf behaviour
        _InfoCard(
          color: cs.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.check_circle_outline,
                      color: cs.onPrimaryContainer, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Theme.maybeOf(context) — safe fallback',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _CodeBlock(
                '// maybeOf returns null when not found:\n'
                'final ThemeData? theme = Theme.maybeOf(context);\n'
                'if (theme == null) {\n'
                '  // Provide a safe fallback:\n'
                '  return const Placeholder();\n'
                '}\n'
                '// Use theme safely here.',
              ),
              const SizedBox(height: 10),
              _Badge('Returns null — no throw', color: Colors.green),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Card C: boundary-aware maybeOf equivalent
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Boundary-aware pattern (recommended in isolation)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                '// Use LookupBoundary static method:\n'
                'final ThemeData? theme = Theme.maybeOf(context);\n'
                '// OR for your custom InheritedWidget:\n'
                'final MyData? data = LookupBoundary\n'
                '    .dependOnInheritedWidgetOfExactType<MyInherited>(\n'
                '        context,\n'
                '    )?.data; // null if blocked',
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Card D: correct guard in widgets that might be used in isolation
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Guard pattern for widgets used in both contexts',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _CodeBlock(
                '@override\n'
                'Widget build(BuildContext context) {\n'
                '  // Safe in isolation AND in normal tree:\n'
                '  final ThemeData theme =\n'
                '      Theme.maybeOf(context) ?? ThemeData.light();\n'
                '  return Text(\n'
                '    \'Result\',\n'
                '    style: TextStyle(\n'
                '        color: theme.colorScheme.primary),\n'
                '  );\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5: debugIsHidingAncestorWidgetOfExactType
// ---------------------------------------------------------------------------
class _TabDebugCheck extends StatelessWidget {
  const _TabDebugCheck();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    // Demonstrate the debug check inside and outside a boundary.
    final bool isHidingMediaQuery = LookupBoundary
        .debugIsHidingAncestorWidgetOfExactType<MediaQuery>(context);
    // Should be false at this level (no LookupBoundary between us and root).

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('debugIsHidingAncestorWidgetOfExactType'),
        const _InfoCard(
          child: Text(
            'This static method lets you query, at runtime (debug mode), '
            'whether a LookupBoundary between the given context and the '
            'nearest ancestor of type T would block its lookup. '
            'It is intended for assertions and debugging only — '
            'do not use it to drive production logic.',
            style: TextStyle(height: 1.5),
          ),
        ),

        _SectionHeading('Signature'),
        _CodeBlock(
          'static bool\n'
          '    debugIsHidingAncestorWidgetOfExactType<T extends InheritedWidget>(\n'
          '        BuildContext context,\n'
          '    );',
        ),

        _SectionHeading('Live result at this tab\'s context'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'LookupBoundary.debugIsHidingAncestorWidgetOfExactType'
                '<MediaQuery>(context)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    isHidingMediaQuery ? Icons.block : Icons.check_circle,
                    color: isHidingMediaQuery ? cs.error : Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Result: $isHidingMediaQuery',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'false — there is no LookupBoundary between this widget\'s '
                'context and the root, so MediaQuery is fully reachable.',
                style: TextStyle(height: 1.45, fontSize: 13),
              ),
            ],
          ),
        ),

        // Nested context inside a LookupBoundary
        _SectionHeading('Inside a LookupBoundary'),
        LookupBoundary(
          child: Builder(
            builder: (BuildContext innerCtx) {
              final bool hidden = LookupBoundary
                  .debugIsHidingAncestorWidgetOfExactType<MediaQuery>(innerCtx);
              return _InfoCard(
                color: cs.errorContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Context is inside LookupBoundary',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: cs.onErrorContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'debugIsHidingAncestorWidgetOfExactType'
                      '<MediaQuery> → $hidden',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        color: cs.onErrorContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Badge(
                      hidden ? 'HIDDEN (true)' : 'NOT HIDDEN (false)',
                      color: hidden ? cs.error : Colors.green,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        _SectionHeading('Usage pattern'),
        _CodeBlock(
          'assert(\n'
          '  !LookupBoundary\n'
          '      .debugIsHidingAncestorWidgetOfExactType<Theme>(context),\n'
          '  \'Theme must be accessible from this context. \'\n'
          '  \'Ensure no LookupBoundary blocks it.\',\n'
          ');',
        ),
        const SizedBox(height: 12),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Bullet('Debug-only: stripped in release mode.'),
              const _Bullet(
                  'Use in assert() statements, not in widget build logic.'),
              const _Bullet(
                  'Ideal for library authors to guard against misuse.'),
              const _Bullet(
                  'Returns false when no LookupBoundary is present at all.'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6: Testing isolation pattern
// ---------------------------------------------------------------------------
class _TabIsolation extends StatelessWidget {
  const _TabIsolation();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('Testing Isolation Pattern'),
        const _InfoCard(
          child: Text(
            'In widget testing, you often want to render a component in a '
            'controlled environment without it picking up ambient '
            'Theme/MediaQuery values from the surrounding TestApp. '
            'LookupBoundary lets you wrap the component in an isolated '
            'subtree that provides its own inner providers.',
            style: TextStyle(height: 1.5),
          ),
        ),

        _SectionHeading('Isolation structure (code)'),
        _CodeBlock(
          '// Test wrapper providing its own isolated environment:\n'
          'testWidgets(\'MyWidget renders correctly\', (tester) async {\n'
          '  await tester.pumpWidget(\n'
          '    MaterialApp(\n'
          '      home: LookupBoundary(\n'
          '        child: MediaQuery(\n'
          '          data: const MediaQueryData(\n'
          '              size: Size(400, 800)),\n'
          '          child: Theme(\n'
          '            data: ThemeData(\n'
          '                colorScheme: ColorScheme.fromSeed(\n'
          '                    seedColor: Colors.teal)),\n'
          '            child: const MyWidget(),\n'
          '          ),\n'
          '        ),\n'
          '      ),\n'
          '    ),\n'
          '  );\n'
          '});',
        ),

        _SectionHeading('Live simulation'),
        const _IsolatedWidgetSimulation(),

        _SectionHeading('Why this matters'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Bullet(
                'The outer MaterialApp may have a purple theme; the '
                'LookupBoundary ensures the isolated subtree uses teal.',
              ),
              const _Bullet(
                'MediaQueryData can be fixed to specific dimensions, '
                'removing flakiness caused by real device size variations.',
              ),
              const _Bullet(
                'Multiple isolated test panels can run in the same '
                'widget tree without interfering with each other.',
              ),
              const _Bullet(
                'DevTools uses the same pattern to inspect subtrees '
                'outside their normal position in the tree.',
              ),
            ],
          ),
        ),

        _SectionHeading('Outer vs inner theme comparison'),
        _OuterInnerThemeDemo(cs: cs),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _IsolatedWidgetSimulation extends StatelessWidget {
  const _IsolatedWidgetSimulation();

  @override
  Widget build(BuildContext context) {
    final ColorScheme outerCs = Theme.of(context).colorScheme;

    // Provide an inner Theme inside LookupBoundary that is distinctly
    // different (orange) so the visual contrast is obvious.
    final ThemeData innerTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orange,
        brightness: Brightness.light,
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Outer context — outer theme seed:',
              style: TextStyle(
                fontSize: 13,
                color: outerCs.onSurface.withAlpha(160),
              ),
            ),
            const SizedBox(height: 6),
            _Badge(
              '${outerCs.primary}',
              color: outerCs.primary,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Text(
              'LookupBoundary — inner theme (orange seed):',
              style: TextStyle(
                fontSize: 13,
                color: outerCs.onSurface.withAlpha(160),
              ),
            ),
            const SizedBox(height: 6),
            LookupBoundary(
              child: Theme(
                data: innerTheme,
                child: MediaQuery(
                  data: const MediaQueryData(
                    size: Size(400, 800),
                  ),
                  child: Builder(
                    builder: (BuildContext innerCtx) {
                      final ThemeData t = Theme.of(innerCtx);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _Badge(
                            '${t.colorScheme.primary}',
                            color: t.colorScheme.primary,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: t.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Isolated component\n'
                              'Media size: 400x800 (fixed)\n'
                              'Theme: orange seed',
                              style: TextStyle(
                                color: t.colorScheme.onPrimaryContainer,
                                fontSize: 13,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OuterInnerThemeDemo extends StatelessWidget {
  const _OuterInnerThemeDemo({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _InfoCard(
            color: cs.primaryContainer,
            child: Column(
              children: <Widget>[
                Icon(Icons.public, color: cs.primary),
                const SizedBox(height: 8),
                Text(
                  'Outer theme',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Purple seed\nambient',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _InfoCard(
            color: Colors.orange.shade100,
            child: Column(
              children: <Widget>[
                const Icon(Icons.shield_outlined, color: Colors.orange),
                const SizedBox(height: 8),
                const Text(
                  'Inner theme',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Orange seed\nisolated',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 7: LookupBoundary.dependOnInheritedWidgetOfExactType
// ---------------------------------------------------------------------------
class _TabDependOn extends StatelessWidget {
  const _TabDependOn();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('dependOnInheritedWidgetOfExactType'),
        const _InfoCard(
          child: Text(
            'This is the boundary-aware version of the standard '
            'BuildContext.dependOnInheritedWidgetOfExactType<T>(). '
            'When called from a context that has a LookupBoundary ancestor, '
            'the walk stops at that boundary and returns null instead of '
            'continuing to the root.',
            style: TextStyle(height: 1.5),
          ),
        ),

        _SectionHeading('Signature'),
        _CodeBlock(
          'static T?\n'
          '    dependOnInheritedWidgetOfExactType<T extends InheritedWidget>(\n'
          '        BuildContext context, {\n'
          '        Object? aspect,\n'
          '    });',
        ),

        _SectionHeading('Comparison table'),
        _InfoCard(
          child: Table(
            border: TableBorder.all(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.2),
              1: FlexColumnWidth(1),
            },
            children: const <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Color(0xFFE8E4FF)),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Method',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Stops at\nboundary?',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        'context.dependOnInheritedWidgetOfExactType<T>()'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('No — walks to root',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        'LookupBoundary.dependOnInheritedWidgetOfExactType<T>(ctx)'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Yes — returns null',
                        style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        'LookupBoundary.getInheritedWidgetOfExactType<T>(ctx)'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Yes — no rebuild',
                        style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ],
          ),
        ),

        _SectionHeading('When to use dependOn vs getInherited'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Bullet(
                'dependOnInheritedWidgetOfExactType — creates a dependency '
                'so the widget rebuilds when the inherited widget changes. '
                'Use when the widget DISPLAYS or REACTS to the value.',
              ),
              const SizedBox(height: 6),
              const _Bullet(
                'getInheritedWidgetOfExactType — reads the value once '
                'without registering a dependency. Use for one-off reads '
                'where rebuilding is not needed (e.g., event handlers).',
              ),
            ],
          ),
        ),

        _SectionHeading('Usage example'),
        _CodeBlock(
          'class _MyIsolatedWidget extends StatelessWidget {\n'
          '  const _MyIsolatedWidget();\n\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    // Boundary-aware — stops at nearest LookupBoundary:\n'
          '    final MediaQuery? mq = LookupBoundary\n'
          '        .dependOnInheritedWidgetOfExactType<MediaQuery>(\n'
          '            context);\n'
          '    final Size screenSize = mq?.data.size ?? Size(390, 844);\n\n'
          '    return Text(\n'
          '      \'Screen: \${screenSize.width}x\${screenSize.height}\',\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        _SectionHeading('Live demonstration'),
        // Outside boundary: LookupBoundary.dependOn finds MediaQuery from root.
        LookupBoundary(
          child: Builder(
            builder: (BuildContext innerCtx) {
              final MediaQuery? mq = LookupBoundary
                  .dependOnInheritedWidgetOfExactType<MediaQuery>(innerCtx);
              return _InfoCard(
                color: cs.tertiaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Inside LookupBoundary',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: cs.onTertiaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'LookupBoundary.dependOnInheritedWidgetOfExactType'
                      '<MediaQuery> → ${mq == null ? "null (blocked)" : "found"}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: cs.onTertiaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Badge(
                      mq == null ? 'BLOCKED — null' : 'FOUND',
                      color: mq == null ? cs.error : Colors.green,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 8: Nested boundaries
// ---------------------------------------------------------------------------
class _TabNested extends StatelessWidget {
  const _TabNested();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('Nested LookupBoundaries'),
        const _InfoCard(
          child: Text(
            'You can nest LookupBoundary widgets. A lookup from the '
            'innermost context stops at the nearest boundary — the inner '
            'LookupBoundary. The outer boundary is not involved in that '
            'lookup unless the lookup originates from between the two '
            'boundaries.',
            style: TextStyle(height: 1.5),
          ),
        ),

        _SectionHeading('Diagram'),
        SizedBox(
          height: 300,
          child: CustomPaint(
            painter: _NestedDiagramPainter(cs: cs),
            child: const SizedBox.expand(),
          ),
        ),

        _SectionHeading('Widget composition'),
        _CodeBlock(
          '// Outer boundary\n'
          'LookupBoundary(\n'
          '  child: Column(\n'
          '    children: [\n'
          '      // Widget at this level stops at OUTER boundary.\n'
          '      const _MidWidget(),\n\n'
          '      // Inner boundary\n'
          '      LookupBoundary(\n'
          '        child: Column(\n'
          '          children: [\n'
          '            // Widget here stops at INNER boundary.\n'
          '            const _DeepWidget(),\n'
          '          ],\n'
          '        ),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ');',
        ),

        _SectionHeading('Live nested demonstration'),
        _NestedLiveDemo(cs: cs),

        _SectionHeading('Key rules for nested boundaries'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Bullet(
                'The lookup always stops at the nearest LookupBoundary '
                'ancestor, regardless of how many boundaries exist above it.',
              ),
              const _Bullet(
                'An InheritedWidget placed between the two boundaries is '
                'reachable from the inner subtree ONLY if no inner '
                'LookupBoundary blocks it.',
              ),
              const _Bullet(
                'debugIsHidingAncestorWidgetOfExactType checks from the '
                'current context upward — it detects the first boundary.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _NestedLiveDemo extends StatelessWidget {
  const _NestedLiveDemo({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return LookupBoundary(
      child: Builder(
        builder: (BuildContext outerBoundaryCtx) {
          final MediaQuery? outerMQ = LookupBoundary
              .dependOnInheritedWidgetOfExactType<MediaQuery>(
                  outerBoundaryCtx);
          return _InfoCard(
            color: cs.secondaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Outer LookupBoundary context',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.onSecondaryContainer,
                  ),
                ),
                Text(
                  'MediaQuery → ${outerMQ == null ? "null (blocked by outer)" : "found"}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: cs.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 12),
                LookupBoundary(
                  child: Builder(
                    builder: (BuildContext innerBoundaryCtx) {
                      final MediaQuery? innerMQ = LookupBoundary
                          .dependOnInheritedWidgetOfExactType<MediaQuery>(
                              innerBoundaryCtx);
                      return Container(
                        margin: const EdgeInsets.only(left: 16, top: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cs.tertiaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: cs.tertiary),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Inner LookupBoundary context',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: cs.onTertiaryContainer,
                              ),
                            ),
                            Text(
                              'MediaQuery → ${innerMQ == null ? "null (blocked by inner)" : "found"}',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: cs.onTertiaryContainer,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _Badge(
                              innerMQ == null
                                  ? 'BLOCKED at inner boundary'
                                  : 'FOUND',
                              color:
                                  innerMQ == null ? cs.error : Colors.green,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NestedDiagramPainter extends CustomPainter {
  const _NestedDiagramPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const double nodeW = 170;
    const double nodeH = 36;
    const double vertGap = 44;
    const double startY = 16;

    final List<String> labels = <String>[
      'Root / MaterialApp',
      'Outer LookupBoundary',
      'MidWidget (lookup → outer stops)',
      'Inner LookupBoundary',
      'DeepWidget (lookup → inner stops)',
    ];
    final List<Color> colors = <Color>[
      cs.primary,
      cs.error,
      cs.secondary,
      cs.error,
      cs.tertiary,
    ];

    final List<Offset> centres = List<Offset>.generate(labels.length, (int i) {
      return Offset(cx, startY + nodeH / 2 + i * (nodeH + vertGap));
    });

    final Paint linePaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < centres.length - 1; i++) {
      canvas.drawLine(
        Offset(centres[i].dx, centres[i].dy + nodeH / 2),
        Offset(centres[i + 1].dx, centres[i + 1].dy - nodeH / 2),
        linePaint,
      );
    }

    for (int i = 0; i < centres.length; i++) {
      final Rect rect = Rect.fromCenter(
          center: centres[i], width: nodeW, height: nodeH);
      final RRect rr =
          RRect.fromRectAndRadius(rect, const Radius.circular(8));
      canvas.drawRRect(rr, Paint()..color = colors[i].withAlpha(210));
      canvas.drawRRect(
        rr,
        Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: nodeW - 8);
      tp.paint(canvas,
          Offset(centres[i].dx - tp.width / 2, centres[i].dy - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(_NestedDiagramPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Tab 9: Pitfalls
// ---------------------------------------------------------------------------
class _TabPitfalls extends StatelessWidget {
  const _TabPitfalls();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('Common Pitfalls'),

        // Pitfall 1
        _PitfallCard(
          number: '01',
          title: 'Accidentally blocking Scaffold lookups',
          description:
              'Placing a LookupBoundary above a widget that calls '
              'Scaffold.of(context) or Navigator.of(context) will cause '
              'those lookups to fail at runtime because the boundary blocks '
              'the walk to the ancestor Scaffold/Navigator.',
          badCode: '// Accidentally blocking Scaffold:\n'
              'LookupBoundary(\n'
              '  child: Builder(\n'
              '    builder: (ctx) {\n'
              '      // throws — Scaffold not found!\n'
              '      Scaffold.of(ctx).showSnackBar(...);\n'
              '      return Container();\n'
              '    },\n'
              '  ),\n'
              ');',
          fixNote:
              'Provide your own Scaffold inside the boundary, or ensure '
              'that Scaffold.of uses the context above the boundary.',
          cs: cs,
        ),

        // Pitfall 2
        _PitfallCard(
          number: '02',
          title: 'Forgetting .maybeOf / null-safety after blocking',
          description:
              'If you block an inherited widget and then call the non-null '
              '.of() variant, your app crashes or asserts in debug mode. '
              'Always pair LookupBoundary usage with null-safe lookups.',
          badCode: '// Inside LookupBoundary — Theme.of will throw:\n'
              'final color = Theme.of(context).colorScheme.primary;\n\n'
              '// Safe version:\n'
              'final color = Theme.maybeOf(context)\n'
              '    ?.colorScheme.primary ?? Colors.purple;',
          fixNote: 'Always use maybeOf / null-aware access when inside or '
              'near a LookupBoundary.',
          cs: cs,
        ),

        // Pitfall 3
        _PitfallCard(
          number: '03',
          title: 'Using debugIsHidingAncestor in production logic',
          description:
              'The debug check is stripped in release mode. Using it to '
              'drive conditional widget logic means the behaviour differs '
              'between debug and release builds.',
          badCode: '// WRONG — release mode always takes the else branch:\n'
              'if (LookupBoundary\n'
              '    .debugIsHidingAncestorWidgetOfExactType<Theme>(\n'
              '        context)) {\n'
              '  return const FallbackWidget();\n'
              '}\n'
              'return const NormalWidget();',
          fixNote: 'Use debugIsHidingAncestor only inside assert() or '
              'inside #if debug/#if release guards.',
          cs: cs,
        ),

        // Pitfall 4
        _PitfallCard(
          number: '04',
          title: 'Using LookupBoundary in production widget trees',
          description:
              'LookupBoundary is designed for testing and tooling. Using it '
              'in production widget trees to "hide" an inherited widget is '
              'fragile — it may block lookups you did not intend to block, '
              'including framework-internal ones.',
          badCode: '// Fragile production usage:\n'
              'LookupBoundary(\n'
              '  // Trying to prevent child from reading app Theme...\n'
              '  child: MyProductionWidget(),\n'
              ');\n'
              '// MyProductionWidget internally calls Navigator.of(),\n'
              '// DefaultTabController.of(), etc. — all blocked!',
          fixNote: 'For production theme overrides use Theme(...) or '
              'MediaQuery(...) widgets instead.',
          cs: cs,
        ),

        // Pitfall 5
        _PitfallCard(
          number: '05',
          title: 'Calling the standard context method, not the static one',
          description:
              'The standard BuildContext.dependOnInheritedWidgetOfExactType '
              'does NOT stop at LookupBoundary. You must use the static '
              'LookupBoundary.dependOnInheritedWidgetOfExactType.',
          badCode: '// Does NOT respect boundary:\n'
              'final mq = context\n'
              '    .dependOnInheritedWidgetOfExactType<MediaQuery>();\n\n'
              '// DOES respect boundary:\n'
              'final mq = LookupBoundary\n'
              '    .dependOnInheritedWidgetOfExactType<MediaQuery>(\n'
              '        context);',
          fixNote:
              'Always use the LookupBoundary static methods when isolation '
              'is required.',
          cs: cs,
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.description,
    required this.badCode,
    required this.fixNote,
    required this.cs,
  });
  final String number;
  final String title;
  final String description;
  final String badCode;
  final String fixNote;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: cs.errorContainer,
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: cs.error,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: TextStyle(
                      color: cs.onError,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(description, style: const TextStyle(height: 1.5)),
                const SizedBox(height: 12),
                _CodeBlock(badCode),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.lightbulb_outline,
                          color: Colors.green, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Fix: $fixNote',
                          style: const TextStyle(
                              height: 1.45, color: Colors.green),
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
}

// ---------------------------------------------------------------------------
// Tab 10: API cheat sheet
// ---------------------------------------------------------------------------
class _TabApiCheatSheet extends StatelessWidget {
  const _TabApiCheatSheet();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: <Widget>[
        _SectionHeading('API Cheat Sheet'),

        // Constructor
        _ApiSection(
          title: 'Constructor',
          cs: cs,
          entries: const <_ApiEntry>[
            _ApiEntry(
              name: 'LookupBoundary({Key? key, required Widget child})',
              description:
                  'Creates a lookup boundary. Descendants using boundary-aware '
                  'static methods will have their walk stopped here.',
              returnType: 'LookupBoundary',
            ),
          ],
        ),

        // Static methods
        _ApiSection(
          title: 'Static Methods',
          cs: cs,
          entries: const <_ApiEntry>[
            _ApiEntry(
              name: 'dependOnInheritedWidgetOfExactType<T>(\n'
                  '    BuildContext context, {Object? aspect})',
              description:
                  'Boundary-aware dependOn. Walks upward from context '
                  'but stops at the nearest LookupBoundary. Returns T? '
                  '(null if blocked). Creates a rebuild dependency.',
              returnType: 'T?',
            ),
            _ApiEntry(
              name: 'getInheritedWidgetOfExactType<T>(\n'
                  '    BuildContext context)',
              description:
                  'Boundary-aware getInherited. Same walk as dependOn but '
                  'does NOT register a dependency — no rebuild triggered.',
              returnType: 'T?',
            ),
            _ApiEntry(
              name: 'debugIsHidingAncestorWidgetOfExactType<T>(\n'
                  '    BuildContext context)',
              description:
                  'Returns true if a LookupBoundary between context and '
                  'the nearest T ancestor would block a boundary-aware '
                  'lookup. Debug mode only — stripped in release.',
              returnType: 'bool',
            ),
          ],
        ),

        _SectionHeading('Package and availability'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Bullet(
                  'Package: package:flutter/widgets.dart (included in package:flutter/material.dart)'),
              const _Bullet('Available: Flutter 3.7.0+'),
              const _Bullet(
                  'Category: Framework internals / Testing and Tooling'),
            ],
          ),
        ),

        _SectionHeading('Quick reference card'),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildQuickRow('Constructor', 'LookupBoundary(child: …)', cs),
              const Divider(height: 20),
              _buildQuickRow('Block + rebuild dep.',
                  'LookupBoundary.dependOnInheritedWidgetOfExactType<T>(ctx)',
                  cs),
              const Divider(height: 20),
              _buildQuickRow('Block, no rebuild dep.',
                  'LookupBoundary.getInheritedWidgetOfExactType<T>(ctx)', cs),
              const Divider(height: 20),
              _buildQuickRow('Debug check',
                  'LookupBoundary.debugIsHidingAncestorWidgetOfExactType<T>(ctx)',
                  cs),
            ],
          ),
        ),

        _SectionHeading('Decision flowchart'),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Need to isolate inherited widget lookups?',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _FlowStep(
                  '1. Wrap subtree with LookupBoundary(child: …)', cs, 0),
              _FlowStep(
                  '2. Inside subtree — use boundary-aware static methods', cs,
                  1),
              _FlowStep(
                  '3. Use dependOn if widget should rebuild on changes', cs,
                  2),
              _FlowStep(
                  '4. Use getInherited for one-shot reads (no rebuild)', cs, 2),
              _FlowStep(
                  '5. Use maybeOf / null-safe access for any .of() calls', cs,
                  1),
              _FlowStep(
                  '6. Use debugIsHidingAncestor in assert() for guard checks',
                  cs, 1),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ApiSection extends StatelessWidget {
  const _ApiSection({
    required this.title,
    required this.entries,
    required this.cs,
  });
  final String title;
  final List<_ApiEntry> entries;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionHeading(title),
        ...entries.map((_ApiEntry e) => _ApiEntryCard(entry: e, cs: cs)),
      ],
    );
  }
}

class _ApiEntry {
  const _ApiEntry({
    required this.name,
    required this.description,
    required this.returnType,
  });
  final String name;
  final String description;
  final String returnType;
}

class _ApiEntryCard extends StatelessWidget {
  const _ApiEntryCard({required this.entry, required this.cs});
  final _ApiEntry entry;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    entry.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _Badge(entry.returnType),
              ],
            ),
            const SizedBox(height: 8),
            Text(entry.description,
                style: const TextStyle(height: 1.45, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

Widget _buildQuickRow(String label, String code, ColorScheme cs) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        width: 120,
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12)),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: cs.primary,
          ),
        ),
      ),
    ],
  );
}

class _FlowStep extends StatelessWidget {
  const _FlowStep(this.text, this.cs, this.indent);
  final String text;
  final ColorScheme cs;
  final int indent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 16.0, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.arrow_right, color: cs.primary, size: 18),
          const SizedBox(width: 4),
          Expanded(
            child: Text(text, style: const TextStyle(height: 1.4)),
          ),
        ],
      ),
    );
  }
}
