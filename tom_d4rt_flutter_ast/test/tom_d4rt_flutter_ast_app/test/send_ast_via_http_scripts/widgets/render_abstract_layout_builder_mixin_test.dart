import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (stateless-safe reactive state)
// ---------------------------------------------------------------------------
final ValueNotifier<double> _sliderWidth = ValueNotifier<double>(300);

// ---------------------------------------------------------------------------
// Entry point required by the harness
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'RenderAbstractLayoutBuilderMixin — Deep Visual Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
    ),
    home: const _DemoRoot(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with 9-tab DefaultTabController
// ---------------------------------------------------------------------------
class _DemoRoot extends StatelessWidget {
  const _DemoRoot();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Architecture'),
    Tab(text: 'Showcases'),
    Tab(text: 'Constraints'),
    Tab(text: 'Sliver'),
    Tab(text: 'Timing'),
    Tab(text: 'Comparison'),
    Tab(text: 'Patterns'),
    Tab(text: 'Pitfalls & API'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'RenderAbstractLayoutBuilderMixin',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _ArchitectureDiagramTab(),
            _LiveShowcasesTab(),
            _ConstraintChangeTab(),
            _SliverLayoutBuilderTab(),
            _BuilderTimingTab(),
            _ComparisonTab(),
            _ObservablePatternsTab(),
            _PitfallsApiTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------
Widget _sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
  );
}

Widget _subTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _bodyText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(fontSize: 13, height: 1.5)),
  );
}

Widget _divider() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(),
    );

Widget _chip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      border: Border.all(color: color.withAlpha(160)),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(label,
        style: TextStyle(
            fontSize: 11, color: color, fontWeight: FontWeight.w600)),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFCDD6F4),
        height: 1.6,
      ),
    ),
  );
}

Widget _infoCard(String title, String body, {Color? accent}) {
  final Color color = accent ?? const Color(0xFF5C6BC0);
  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: color.withAlpha(80)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontSize: 13)),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 12, height: 1.5)),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero Banner
// ---------------------------------------------------------------------------
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        // Hero banner gradient
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                cs.primaryContainer,
                cs.secondaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.layers, size: 40, color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'RenderAbstractLayoutBuilderMixin',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'A framework-internal mixin applied to the RenderObject of '
                'ConstrainedLayoutBuilder subclasses (LayoutBuilder, '
                'SliverLayoutBuilder). It provides the mechanism that calls '
                'the builder callback during the layout phase — not the '
                'build phase.',
                style: TextStyle(
                    fontSize: 13,
                    color: cs.onPrimaryContainer,
                    height: 1.6),
              ),
              const SizedBox(height: 12),
              Wrap(
                children: <Widget>[
                  _chip('Layout Phase', cs.primary),
                  _chip('Constraint-Driven', cs.secondary),
                  _chip('Framework Internal', Colors.deepOrange),
                  _chip('RenderObject Mixin', Colors.teal),
                ],
              ),
            ],
          ),
        ),

        _divider(),
        _sectionTitle('The Mixin\'s Role'),
        _bodyText(
          'RenderAbstractLayoutBuilderMixin<ConstraintType extends Constraints, '
          'ChildType extends RenderObject> is mixed into the concrete '
          '_RenderLayoutBuilder class (and its Sliver counterpart). The '
          'mixin shoulders three responsibilities:',
        ),
        _infoCard(
          '1. Storing the builder callback',
          'The mixin holds a reference to the LayoutWidgetBuilder (or '
              'SliversLayoutWidgetBuilder) function supplied by the Widget layer. '
              'When the ConstrainedLayoutBuilder widget updates the callback, '
              'the mixin marks layout as dirty so the next layout pass re-invokes it.',
          accent: const Color(0xFF5C6BC0),
        ),
        _infoCard(
          '2. Detecting constraint changes',
          'During performLayout(), the mixin compares incoming constraints '
              'against the previously seen constraints. If they differ, the '
              'callback must be re-invoked. If they are identical, the previously '
              'built subtree can be reused, saving unnecessary rebuilds.',
          accent: Colors.teal,
        ),
        _infoCard(
          '3. Invoking the callback safely inside layout',
          'The callback cannot simply be called from performLayout() — Flutter '
              'prohibits widget-tree mutations during layout. The mixin uses '
              'RenderObject.invokeLayoutCallback() to temporarily lift the '
              'constraint, allowing the builder to call BuildContext APIs and '
              'inflate the child subtree, then re-locks the tree.',
          accent: Colors.deepOrange,
        ),

        _divider(),
        _sectionTitle('Layout Phase vs Build Phase'),
        _bodyText(
          'Most Flutter widgets have their builder callbacks invoked during '
          'the build phase, when the framework walks the element tree calling '
          'Widget.build(). The mixin changes this contract:',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _phaseBox(
                'Build Phase',
                '• Widget.build() called\n'
                    '• Context.size unknown\n'
                    '• Constraints not yet resolved\n'
                    '• No access to final layout info',
                const Color(0xFFB71C1C),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _phaseBox(
                'Layout Phase (Mixin)',
                '• performLayout() running\n'
                    '• Incoming constraints known\n'
                    '• Builder receives BoxConstraints\n'
                    '• Child inflated with real sizes',
                Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _bodyText(
          'This distinction is what makes LayoutBuilder uniquely useful: it '
          'lets you build responsive subtrees that know their exact maximum '
          'width and height at the moment they are constructed.',
        ),

        _divider(),
        _sectionTitle('Type Signature (Conceptual)'),
        _codeBlock(
          'mixin RenderAbstractLayoutBuilderMixin<\n'
          '  ConstraintType extends Constraints,\n'
          '  ChildType extends RenderObject\n'
          '> on RenderObject {\n'
          '  // The callback provided by the widget layer\n'
          '  LayoutCallback<ConstraintType> get callback;\n'
          '  set callback(LayoutCallback<ConstraintType> value);\n\n'
          '  // Invokes callback if constraints changed or rebuild forced\n'
          '  @override\n'
          '  void performLayout();\n\n'
          '  // Internal: runs callback inside invokeLayoutCallback()\n'
          '  void _layout(ConstraintType constraints);\n'
          '}',
        ),
      ],
    );
  }

  Widget _phaseBox(String title, String body, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(18),
        border: Border.all(color: color.withAlpha(120)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontSize: 13)),
          const SizedBox(height: 8),
          Text(body,
              style: const TextStyle(fontSize: 12, height: 1.55)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Architecture Diagram (CustomPainter)
// ---------------------------------------------------------------------------
class _ArchitectureDiagramTab extends StatelessWidget {
  const _ArchitectureDiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Class Hierarchy & Mixin Application'),
        _bodyText(
          'The diagram below traces the inheritance and mixin chain from the '
          'abstract Widget down to the concrete RenderObject that performs '
          'the layout-phase callback.',
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 420,
          child: CustomPaint(
            painter: _ArchitecturePainter(cs),
            child: const SizedBox.expand(),
          ),
        ),
        _divider(),
        _sectionTitle('Node Descriptions'),
        _infoCard(
          'ConstrainedLayoutBuilder<CT> (Widget)',
          'Abstract StatelessWidget (or rather a subclass of '
              'RenderObjectWidget). Holds the LayoutWidgetBuilder callback. '
              'Two concrete subclasses: LayoutBuilder and SliverLayoutBuilder.',
          accent: const Color(0xFF5C6BC0),
        ),
        _infoCard(
          '_RenderLayoutBuilder (RenderObject)',
          'Concrete RenderObject created by LayoutBuilder\'s Element. Extends '
              'RenderBox AND mixes in RenderAbstractLayoutBuilderMixin. This '
              'is where the mixin\'s performLayout() runs.',
          accent: Colors.teal,
        ),
        _infoCard(
          'RenderAbstractLayoutBuilderMixin',
          'The mixin itself. Mixed "on RenderObject", so it can override '
              'performLayout(). Handles callback storage, constraint diff, and '
              'invokeLayoutCallback() wrapping.',
          accent: Colors.deepOrange,
        ),
        _infoCard(
          'Layout Phase Flow',
          'Flutter pipeline → performLayout() called on _RenderLayoutBuilder '
              '→ mixin intercepts → compares new vs cached constraints → if '
              'different: invokeLayoutCallback(cb) → cb(constraints) fires the '
              'user\'s builder → child subtree inflated/updated → child laid out '
              '→ size set.',
          accent: Colors.purple,
        ),
        _divider(),
        _sectionTitle('Sliver Variant'),
        _bodyText(
          'SliverLayoutBuilder follows the identical pattern but uses '
          'SliverConstraints instead of BoxConstraints. The mixin\'s generic '
          'type parameter ConstraintType covers both cases.',
        ),
        _codeBlock(
          '// BoxConstraints variant\n'
          'class _RenderLayoutBuilder extends RenderBox\n'
          '    with RenderAbstractLayoutBuilderMixin<\n'
          '           BoxConstraints, RenderBox> { }\n\n'
          '// SliverConstraints variant\n'
          'class _RenderSliverLayoutBuilder extends RenderSliver\n'
          '    with RenderAbstractLayoutBuilderMixin<\n'
          '           SliverConstraints, RenderSliver> { }',
        ),
      ],
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  const _ArchitecturePainter(this.cs);
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;

    // Node dimensions
    const double nodeW = 240;
    const double nodeH = 44;
    const double hGap = 32;
    final double left = cx - nodeW / 2;

    // Positions (top-y of each box)
    final double y0 = 10;
    final double y1 = y0 + nodeH + hGap;
    final double y2 = y1 + nodeH + hGap;
    final double y3 = y2 + nodeH + hGap;
    // mixin box beside y3
    const double mixinW = 200;
    final double mixinX = cx + nodeW / 2 + 20;
    final double mixinY = y3;
    final double y4 = y3 + nodeH + hGap;

    final Paint fill = Paint()..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    final Paint arrowPaint = Paint()
      ..color = const Color(0xFF888888)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    void drawBox(double x, double y, double w, Color bg, Color border,
        String label, [String? sub]) {
      final RRect rr =
          RRect.fromLTRBR(x, y, x + w, y + nodeH, const Radius.circular(8));
      fill.color = bg;
      stroke.color = border;
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
              color: border,
              fontSize: 12,
              fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: w - 12);
      tp.paint(canvas, Offset(x + 6, sub == null ? y + 14 : y + 8));

      if (sub != null) {
        final TextPainter sp = TextPainter(
          text: TextSpan(
            text: sub,
            style: const TextStyle(
                color: Color(0xFF555555), fontSize: 10),
          ),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: w - 12);
        sp.paint(canvas, Offset(x + 6, y + 26));
      }
    }

    void drawArrow(double x1, double y1a, double x2, double y2a) {
      canvas.drawLine(Offset(x1, y1a), Offset(x2, y2a), arrowPaint);
      // arrowhead
      final double dx = x2 - x1;
      final double dy = y2a - y1a;
      final double len = (dx * dx + dy * dy) > 0
          ? (dx * dx + dy * dy).abs().floorToDouble()
          : 1;
      final double ux = dx / (len == 0 ? 1 : len.toDouble().floorToDouble().clamp(1, 999999));
      final double uy = dy / (len == 0 ? 1 : len.toDouble().floorToDouble().clamp(1, 999999));
      // Simple triangle at tip
      final Path path = Path()
        ..moveTo(x2, y2a)
        ..lineTo(x2 - uy * 8 - ux * 8, y2a + ux * 8 - uy * 8)
        ..lineTo(x2 + uy * 8 - ux * 8, y2a - ux * 8 - uy * 8)
        ..close();
      canvas.drawPath(path, Paint()..color = const Color(0xFF888888));
    }

    // Draw nodes
    drawBox(left, y0, nodeW, cs.primaryContainer.withAlpha(120),
        cs.primary, 'ConstrainedLayoutBuilder<CT>', 'abstract Widget / RenderObjectWidget');
    drawBox(left, y1, nodeW, cs.secondaryContainer.withAlpha(120),
        cs.secondary, 'LayoutBuilder', 'extends ConstrainedLayoutBuilder<BoxConstraints>');
    drawBox(left, y2, nodeW, const Color(0xFFE8F5E9),
        Colors.teal, 'Element layer', 'creates _RenderLayoutBuilder via createRenderObject()');
    drawBox(left, y3, nodeW, const Color(0xFFFFF3E0),
        Colors.deepOrange, '_RenderLayoutBuilder', 'extends RenderBox');
    // Mixin box
    drawBox(mixinX, mixinY, mixinW, const Color(0xFFF3E5F5),
        Colors.purple, 'RenderAbstractLayoutBuilderMixin', '<BoxConstraints, RenderBox>');
    drawBox(left, y4, nodeW, const Color(0xFFE8EAF6),
        const Color(0xFF5C6BC0), 'Layout Phase Callback', 'builder(context, constraints) → Widget');

    // Arrows
    drawArrow(cx, y0 + nodeH, cx, y1);
    drawArrow(cx, y1 + nodeH, cx, y2);
    drawArrow(cx, y2 + nodeH, cx, y3);
    drawArrow(cx, y3 + nodeH, cx, y4);
    // Mixin connection (dashed approximation with shorter segments)
    final Paint dashPaint = Paint()
      ..color = Colors.purple.withAlpha(180)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final double connY = mixinY + nodeH / 2;
    // Draw dashed line from right edge of _RenderLayoutBuilder to left edge of mixin box
    double dashX = left + nodeW;
    while (dashX < mixinX - 4) {
      canvas.drawLine(
          Offset(dashX, connY), Offset(dashX + 8, connY), dashPaint);
      dashX += 14;
    }
    // label "with"
    final TextPainter withTp = TextPainter(
      text: const TextSpan(
          text: 'with (mixin)',
          style: TextStyle(color: Colors.purple, fontSize: 10)),
      textDirection: TextDirection.ltr,
    )..layout();
    withTp.paint(
        canvas, Offset(left + nodeW + 6, connY - 14));
  }

  @override
  bool shouldRepaint(_ArchitecturePainter old) => false;
}

// ---------------------------------------------------------------------------
// Tab 3 — Live LayoutBuilder Showcases
// ---------------------------------------------------------------------------
class _LiveShowcasesTab extends StatelessWidget {
  const _LiveShowcasesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Live LayoutBuilder Showcases'),
        _bodyText(
          'Each card below contains a real LayoutBuilder. Resize the window '
          'or rotate the device to see constraints update live. The builder '
          'function fires during the layout phase each time constraints change.',
        ),
        _divider(),
        _subTitle('Showcase A — Responsive Grid Columns'),
        _bodyText(
          'The builder examines maxWidth and selects 2, 3, or 4 columns '
          'accordingly. The constraint display card shows the exact BoxConstraints '
          'passed by the framework.',
        ),
        _ShowcaseCard(
          label: 'A',
          accentColor: const Color(0xFF5C6BC0),
          builder: (BoxConstraints constraints) {
            final int cols = constraints.maxWidth < 360
                ? 2
                : constraints.maxWidth < 560
                    ? 3
                    : 4;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _constraintCard(constraints, const Color(0xFF5C6BC0)),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: 8,
                  itemBuilder: (BuildContext ctx, int i) => _gridCell(
                      'Cell $i', i.isEven ? const Color(0xFF5C6BC0) : Colors.teal),
                ),
              ],
            );
          },
        ),

        _divider(),
        _subTitle('Showcase B — Adaptive Typography'),
        _bodyText(
          'Font size scales with available width. The builder maps constraint '
          'ranges to text styles without any setState — purely layout-phase driven.',
        ),
        _ShowcaseCard(
          label: 'B',
          accentColor: Colors.teal,
          builder: (BoxConstraints constraints) {
            final double fs = constraints.maxWidth < 300
                ? 11
                : constraints.maxWidth < 480
                    ? 14
                    : 18;
            final String sizeLabel = constraints.maxWidth < 300
                ? 'compact'
                : constraints.maxWidth < 480
                    ? 'medium'
                    : 'expanded';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _constraintCard(constraints, Colors.teal),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.teal.withAlpha(18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Layout: $sizeLabel',
                          style: TextStyle(
                              fontSize: fs,
                              fontWeight: FontWeight.w700,
                              color: Colors.teal.shade700)),
                      const SizedBox(height: 6),
                      Text(
                        'Adaptive typography driven by layout constraints. '
                        'This text\'s font size is $fs px because maxWidth '
                        'is ${constraints.maxWidth.toStringAsFixed(0)} px.',
                        style: TextStyle(fontSize: fs * 0.75, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        _divider(),
        _subTitle('Showcase C — Orientation-Aware Layout'),
        _bodyText(
          'The builder compares maxWidth vs maxHeight to determine an '
          '"orientation" independently of the device orientation API. This '
          'is purely constraint-driven.',
        ),
        _ShowcaseCard(
          label: 'C',
          accentColor: Colors.deepOrange,
          builder: (BoxConstraints constraints) {
            final bool isWide = constraints.maxWidth > constraints.maxHeight;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _constraintCard(constraints, Colors.deepOrange),
                const SizedBox(height: 10),
                isWide
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: _orientBox(
                                'Left Panel', Colors.deepOrange),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _orientBox(
                                'Right Panel', Colors.deepOrangeAccent),
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          _orientBox('Top Panel', Colors.deepOrange),
                          const SizedBox(height: 8),
                          _orientBox(
                              'Bottom Panel', Colors.deepOrangeAccent),
                        ],
                      ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _gridCell(String label, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
    );
  }

  Widget _orientBox(String label, Color color) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w700)),
    );
  }
}

Widget _constraintCard(BoxConstraints constraints, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: accent.withAlpha(20),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent.withAlpha(100)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.straighten, size: 14, color: accent),
        const SizedBox(width: 6),
        Text(
          'maxW=${constraints.maxWidth.toStringAsFixed(0)}  '
          'maxH=${constraints.hasBoundedHeight ? constraints.maxHeight.toStringAsFixed(0) : "∞"}  '
          'minW=${constraints.minWidth.toStringAsFixed(0)}',
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: accent,
              fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({
    required this.label,
    required this.accentColor,
    required this.builder,
  });

  final String label;
  final Color accentColor;
  final Widget Function(BoxConstraints) builder;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withAlpha(80)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 12,
                  backgroundColor: accentColor,
                  child: Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Text('LayoutBuilder Showcase $label',
                    style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
              ],
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints constraints) =>
                  builder(constraints),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4 — Constraint Change Detection
// ---------------------------------------------------------------------------
class _ConstraintChangeTab extends StatelessWidget {
  const _ConstraintChangeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Constraint Change Detection'),
        _bodyText(
          'The mixin re-invokes the builder callback ONLY when constraints '
          'actually change. If a parent rebuilds for unrelated reasons but '
          'passes the same constraints, the callback is skipped and the '
          'previous child subtree is reused.',
        ),
        _infoCard(
          'Key insight',
          'This is fundamentally different from StatefulWidget.setState(), '
              'which always re-runs build(). The mixin\'s performLayout() checks: '
              '`if (_constraints == constraints) return;` before calling the builder.',
          accent: const Color(0xFF5C6BC0),
        ),
        _divider(),
        _subTitle('Slider Drives Parent Width → Observe Constraint Changes'),
        _bodyText(
          'Drag the slider below. It changes the explicit width constraint '
          'given to the LayoutBuilder. The constraint display inside will '
          'update ONLY when the width changes (the mixin re-invokes the builder). '
          'A counter tracks invocation count.',
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<double>(
          valueListenable: _sliderWidth,
          builder: (BuildContext ctx, double width, Widget? _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text('Parent width:', style: TextStyle(fontSize: 13)),
                    Expanded(
                      child: Slider(
                        value: width,
                        min: 100,
                        max: 500,
                        divisions: 40,
                        label: '${width.toStringAsFixed(0)} px',
                        onChanged: (double v) => _sliderWidth.value = v,
                      ),
                    ),
                    SizedBox(
                      width: 52,
                      child: Text('${width.toStringAsFixed(0)} px',
                          style: const TextStyle(
                              fontFamily: 'monospace', fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: width,
                    child: _ConstraintObserverBox(parentWidth: width),
                  ),
                ),
              ],
            );
          },
        ),
        _divider(),
        _sectionTitle('When Builder Is NOT Re-Invoked'),
        _bodyText(
          'The mixin caches the last seen constraints. If the parent '
          'rebuilds (e.g., a sibling widget changes state), but the '
          'incoming constraints are identical, performLayout() returns '
          'early without calling invokeLayoutCallback. This is why '
          'LayoutBuilder is efficient even in rapidly-rebuilding trees.',
        ),
        _codeBlock(
          '// Simplified mixin logic (from Flutter source)\n'
          '@override\n'
          'void performLayout() {\n'
          '  final ConstraintType newConstraints = constraints as ConstraintType;\n'
          '  if (!identical(_previousConstraints, newConstraints)) {\n'
          '    _previousConstraints = newConstraints;\n'
          '    // Only now do we invoke the builder\n'
          '    invokeLayoutCallback<ConstraintType>(\n'
          '      (ConstraintType c) => _callback(c),\n'
          '    );\n'
          '  }\n'
          '  // Either way, lay out child with current constraints\n'
          '  if (child != null) {\n'
          '    child!.layout(newConstraints, parentUsesSize: true);\n'
          '    size = constraints.constrain(child!.size);\n'
          '  } else {\n'
          '    size = constraints.smallest;\n'
          '  }\n'
          '}',
        ),
        _divider(),
        _sectionTitle('Constraint Equality'),
        _bodyText(
          'BoxConstraints implements operator== based on all four values: '
          'minWidth, maxWidth, minHeight, maxHeight. SliverConstraints '
          'has a more complex equality check. The mixin relies on this '
          'equality to decide whether to call the builder.',
        ),
        _infoCard(
          'Gotcha: Tight vs Loose constraints',
          'A tight BoxConstraints (min == max) and a loose one with the same '
              'maxWidth ARE different. If a parent switches between tight and '
              'loose constraints with the same maxWidth, the builder will fire '
              'again because minWidth differs.',
          accent: Colors.deepOrange,
        ),
      ],
    );
  }
}

class _ConstraintObserverBox extends StatelessWidget {
  const _ConstraintObserverBox({required this.parentWidth});

  final double parentWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        final String breakpoint = constraints.maxWidth < 200
            ? 'XS'
            : constraints.maxWidth < 300
                ? 'SM'
                : constraints.maxWidth < 400
                    ? 'MD'
                    : 'LG';
        final Color bpColor = constraints.maxWidth < 200
            ? Colors.red
            : constraints.maxWidth < 300
                ? Colors.orange
                : constraints.maxWidth < 400
                    ? Colors.blue
                    : Colors.green;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bpColor.withAlpha(20),
            border: Border.all(color: bpColor.withAlpha(180), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: bpColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(breakpoint,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  Text('Breakpoint',
                      style: TextStyle(
                          color: bpColor, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              Text('maxWidth: ${constraints.maxWidth.toStringAsFixed(1)} px',
                  style: const TextStyle(
                      fontFamily: 'monospace', fontSize: 12)),
              Text('minWidth: ${constraints.minWidth.toStringAsFixed(1)} px',
                  style: const TextStyle(
                      fontFamily: 'monospace', fontSize: 12)),
              Text(
                  'maxHeight: ${constraints.hasBoundedHeight ? constraints.maxHeight.toStringAsFixed(1) : "∞"} px',
                  style: const TextStyle(
                      fontFamily: 'monospace', fontSize: 12)),
              const SizedBox(height: 6),
              Text(
                'Builder was invoked because constraints changed '
                '(parent set explicit width to ${parentWidth.toStringAsFixed(0)} px).',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — SliverLayoutBuilder
// ---------------------------------------------------------------------------
class _SliverLayoutBuilderTab extends StatelessWidget {
  const _SliverLayoutBuilderTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('SliverLayoutBuilder'),
        _bodyText(
          'SliverLayoutBuilder is the sliver equivalent of LayoutBuilder. '
          'It uses the same RenderAbstractLayoutBuilderMixin but with '
          'SliverConstraints instead of BoxConstraints. This allows '
          'building adaptive sliver content based on scroll offset, '
          'viewport extent, and other sliver-specific measurements.',
        ),
        _infoCard(
          'SliverConstraints properties available to builder',
          '• viewportMainAxisExtent — total visible height\n'
              '• scrollOffset — how far the sliver has been scrolled\n'
              '• overlap — pixels consumed by preceding slivers\n'
              '• crossAxisExtent — width of the viewport\n'
              '• remainingPaintExtent — paint space remaining\n'
              '• remainingCacheExtent — cache space remaining',
          accent: Colors.purple,
        ),
        _divider(),
        _subTitle('Live SliverLayoutBuilder Demo'),
        _bodyText(
          'Scroll the CustomScrollView below. The SliverLayoutBuilder '
          'reads SliverConstraints and renders different content based '
          'on the scroll offset and viewport extent.',
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 360,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: cs.primaryContainer,
                title: Text('Sliver Demo',
                    style: TextStyle(color: cs.onPrimaryContainer)),
                floating: true,
                pinned: false,
              ),
              SliverLayoutBuilder(
                builder:
                    (BuildContext ctx, SliverConstraints constraints) {
                  final double scrolled = constraints.scrollOffset;
                  final double vpExtent =
                      constraints.viewportMainAxisExtent;
                  final double crossExtent =
                      constraints.crossAxisExtent;
                  final bool isDeepScrolled = scrolled > 80;

                  return SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDeepScrolled
                            ? cs.tertiaryContainer
                            : cs.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDeepScrolled
                              ? cs.tertiary
                              : cs.secondary,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                isDeepScrolled
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: isDeepScrolled
                                    ? cs.tertiary
                                    : cs.secondary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isDeepScrolled
                                    ? 'Deep Scroll Mode'
                                    : 'Top Mode',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: isDeepScrolled
                                      ? cs.tertiary
                                      : cs.secondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _sliverConstraintRow(
                              'scrollOffset', scrolled, Colors.purple),
                          _sliverConstraintRow(
                              'viewportMainAxisExtent', vpExtent, Colors.teal),
                          _sliverConstraintRow(
                              'crossAxisExtent', crossExtent, Colors.blue),
                          _sliverConstraintRow(
                              'overlap',
                              constraints.overlap,
                              Colors.deepOrange),
                          _sliverConstraintRow(
                              'remainingPaintExtent',
                              constraints.remainingPaintExtent,
                              Colors.green),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext ctx, int i) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: cs.primaryContainer,
                      child: Text('${i + 1}',
                          style: TextStyle(color: cs.primary)),
                    ),
                    title: Text('Scroll Item ${i + 1}'),
                    subtitle: Text(
                        'Scroll to see SliverConstraints update above'),
                  ),
                  childCount: 20,
                ),
              ),
            ],
          ),
        ),
        _divider(),
        _sectionTitle('SliverLayoutBuilder vs LayoutBuilder'),
        _codeBlock(
          '// LayoutBuilder — BoxConstraints\n'
          'LayoutBuilder(\n'
          '  builder: (context, BoxConstraints constraints) {\n'
          '    return MyWidget(maxWidth: constraints.maxWidth);\n'
          '  },\n'
          ')\n\n'
          '// SliverLayoutBuilder — SliverConstraints\n'
          'SliverLayoutBuilder(\n'
          '  builder: (context, SliverConstraints constraints) {\n'
          '    return SliverToBoxAdapter(\n'
          '      child: MyWidget(\n'
          '        scrollOffset: constraints.scrollOffset,\n'
          '        vpExtent: constraints.viewportMainAxisExtent,\n'
          '      ),\n'
          '    );\n'
          '  },\n'
          ')',
        ),
      ],
    );
  }

  Widget _sliverConstraintRow(String name, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(name,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600)),
          ),
          Text(value.toStringAsFixed(1),
              style: const TextStyle(
                  fontFamily: 'monospace', fontSize: 11)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 — Builder Callback Timing
// ---------------------------------------------------------------------------
class _BuilderTimingTab extends StatelessWidget {
  const _BuilderTimingTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Builder Callback Timing'),
        _bodyText(
          'Understanding WHEN the builder fires is crucial to using '
          'LayoutBuilder correctly. The callback runs inside the layout '
          'phase — specifically inside invokeLayoutCallback(), a special '
          'framework mechanism that temporarily relaxes the "no mutations '
          'during layout" rule.',
        ),
        _divider(),
        _subTitle('Framework Execution Flow'),
        _bodyText(
          'The sequence below shows the exact call chain from the Flutter '
          'rendering pipeline through the mixin to the user\'s builder:',
        ),
        const SizedBox(height: 8),
        _flowStep(1, 'Flutter Pipeline', 'PipelineOwner.flushLayout()',
            'Triggers layout on all dirty RenderObjects', cs.primaryContainer, cs.primary),
        const SizedBox(height: 4),
        _flowArrow(),
        const SizedBox(height: 4),
        _flowStep(2, 'RenderObject', '_RenderLayoutBuilder.performLayout()',
            'Called by parent\'s layout() call; receives BoxConstraints', cs.secondaryContainer, cs.secondary),
        const SizedBox(height: 4),
        _flowArrow(),
        const SizedBox(height: 4),
        _flowStep(3, 'Mixin check', 'constraints != _previousConstraints?',
            'If same: skip builder, just re-layout child. If different: proceed.', cs.tertiaryContainer, cs.tertiary),
        const SizedBox(height: 4),
        _flowArrow(),
        const SizedBox(height: 4),
        _flowStep(4, 'invokeLayoutCallback()', 'RenderObject.invokeLayoutCallback<T>(cb)',
            'Temporarily allows element-tree mutations during layout. Framework internal.', const Color(0xFFFFF3E0), Colors.deepOrange),
        const SizedBox(height: 4),
        _flowArrow(),
        const SizedBox(height: 4),
        _flowStep(5, 'User callback', '_callback(constraints)',
            'Your builder(context, constraints) function runs here. Returns a Widget.', const Color(0xFFE8F5E9), Colors.teal),
        const SizedBox(height: 4),
        _flowArrow(),
        const SizedBox(height: 4),
        _flowStep(6, 'Element update', 'Element.update() / Element.inflateWidget()',
            'The returned widget is used to update or inflate the child element subtree.', const Color(0xFFE8EAF6), const Color(0xFF5C6BC0)),
        const SizedBox(height: 4),
        _flowArrow(),
        const SizedBox(height: 4),
        _flowStep(7, 'Child layout', 'child.layout(constraints, parentUsesSize: true)',
            'Child RenderObject is laid out. Its size is reported back.', const Color(0xFFF3E5F5), Colors.purple),

        _divider(),
        _subTitle('Monospace Source Snippet'),
        _bodyText(
          'Simplified representation of the framework internals that the '
          'mixin implements:',
        ),
        _codeBlock(
          '// Inside RenderAbstractLayoutBuilderMixin.performLayout()\n'
          'void performLayout() {\n'
          '  final CT newConstraints = this.constraints as CT;\n\n'
          '  // Step 3: constraint diff check\n'
          '  if (newConstraints != _previousConstraints ||\n'
          '      _dirtyLayout) {\n'
          '    _previousConstraints = newConstraints;\n'
          '    _dirtyLayout = false;\n\n'
          '    // Step 4: temporarily allow widget mutations\n'
          '    invokeLayoutCallback<CT>((CT c) {\n'
          '      assert(c == newConstraints);\n'
          '      // Step 5: fire the user\'s builder\n'
          '      _callback(c);\n'
          '    });\n'
          '  }\n\n'
          '  // Step 7: layout child regardless\n'
          '  if (child != null) {\n'
          '    child!.layout(newConstraints, parentUsesSize: true);\n'
          '    size = constraints.constrain(child!.size);\n'
          '  } else {\n'
          '    size = constraints.smallest;\n'
          '  }\n'
          '}',
        ),
        _divider(),
        _sectionTitle('invokeLayoutCallback — What It Does'),
        _infoCard(
          'The "temporarily relaxed" mechanism',
          'Flutter normally forbids calling setState(), InheritedWidget lookups, '
              'or element mutations during layout. invokeLayoutCallback wraps the '
              'callback in a zone where these are allowed. After the callback '
              'returns, the zone is exited and the prohibition is restored.',
          accent: Colors.deepOrange,
        ),
        _infoCard(
          'Why not just call builder() directly?',
          'Calling the builder directly during performLayout() would violate '
              'Flutter\'s rendering contract. The BuildContext.dependOnInheritedWidget '
              'calls inside the builder need the element system to be in a valid '
              'state. invokeLayoutCallback ensures this.',
          accent: const Color(0xFF5C6BC0),
        ),
      ],
    );
  }

  Widget _flowStep(int step, String phase, String method, String desc,
      Color bg, Color accent) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withAlpha(120)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 12,
            backgroundColor: accent,
            child: Text('$step',
                style: const TextStyle(
                    color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(phase,
                    style: TextStyle(
                        fontSize: 11,
                        color: accent,
                        fontWeight: FontWeight.w700)),
                Text(method,
                    style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flowArrow() {
    return const Center(
      child: Icon(Icons.arrow_downward, size: 18, color: Colors.grey),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 7 — Comparison
// ---------------------------------------------------------------------------
class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Comparison'),
        _bodyText(
          'Three mechanisms can drive layout-responsive behavior. '
          'Understanding their differences prevents misuse.',
        ),
        _divider(),
        _comparisonCard(
          title: 'RenderAbstractLayoutBuilderMixin',
          icon: Icons.layers,
          color: const Color(0xFF5C6BC0),
          phase: 'Layout Phase',
          when: 'Constraints change',
          constraint: 'Has BoxConstraints / SliverConstraints',
          setState: 'N/A (layout, not build)',
          overhead: 'Very low — skips re-invocation when constraints unchanged',
          useCase: 'LayoutBuilder, SliverLayoutBuilder — adaptive subtrees',
          forbidden: 'Cannot call setState() or showDialog() from builder',
        ),
        _comparisonCard(
          title: 'RenderObject.invokeLayoutCallback',
          icon: Icons.settings,
          color: Colors.teal,
          phase: 'Layout Phase',
          when: 'Explicitly called from performLayout()',
          constraint: 'Whatever RenderObject has at that moment',
          setState: 'N/A',
          overhead:
              'Zero additional — it IS the mechanism mixin uses internally',
          useCase:
              'Custom RenderObjects needing to call element APIs during layout',
          forbidden:
              'Same restrictions as builder: no setState, no async, no showDialog',
        ),
        _comparisonCard(
          title: 'StatefulWidget.setState',
          icon: Icons.refresh,
          color: Colors.deepOrange,
          phase: 'Build Phase',
          when: 'Explicit setState() call',
          constraint: 'Unknown at build time (BoxConstraints not yet resolved)',
          setState: 'Always re-runs build() regardless of constraints',
          overhead: 'High if called frequently — always re-builds subtree',
          useCase: 'User interactions, async data, animations, timers',
          forbidden: 'Cannot access BoxConstraints from build()',
        ),
        _divider(),
        _sectionTitle('Decision Matrix'),
        _bodyText(
          'Use the matrix below to decide which mechanism fits your '
          'responsive layout scenario:',
        ),
        _decisionMatrix(),
      ],
    );
  }

  Widget _comparisonCard({
    required String title,
    required IconData icon,
    required Color color,
    required String phase,
    required String when,
    required String constraint,
    required String setState,
    required String overhead,
    required String useCase,
    required String forbidden,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withAlpha(120)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: color,
                          fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _compRow('Phase', phase, color),
            _compRow('Triggered when', when, color),
            _compRow('Constraint access', constraint, color),
            _compRow('setState behavior', setState, color),
            _compRow('Performance', overhead, color),
            _compRow('Primary use case', useCase, color),
            _compRow('Forbidden in callback', forbidden, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _compRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget _decisionMatrix() {
    const List<List<String>> rows = <List<String>>[
      ['Scenario', 'Use'],
      ['Adapt layout to available width', 'LayoutBuilder'],
      ['Adapt sliver to scroll offset', 'SliverLayoutBuilder'],
      ['React to user tap', 'StatefulWidget + setState'],
      ['Custom RenderObject needs child inflation during layout',
          'invokeLayoutCallback directly'],
      ['Animate size transitions', 'AnimatedContainer or TweenAnimationBuilder'],
      ['Read MediaQuery for orientation', 'MediaQuery.of() in build()'],
    ];
    return Table(
      border: TableBorder.all(color: Colors.grey.withAlpha(80)),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
      },
      children: rows
          .asMap()
          .entries
          .map((MapEntry<int, List<String>> e) {
        final bool isHeader = e.key == 0;
        return TableRow(
          decoration: BoxDecoration(
            color: isHeader
                ? const Color(0xFF5C6BC0).withAlpha(30)
                : e.key.isEven
                    ? Colors.grey.withAlpha(10)
                    : Colors.transparent,
          ),
          children: e.value
              .map(
                (String cell) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(cell,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: isHeader
                              ? FontWeight.w700
                              : FontWeight.normal)),
                ),
              )
              .toList(),
        );
      }).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 8 — Observable Patterns
// ---------------------------------------------------------------------------
class _ObservablePatternsTab extends StatelessWidget {
  const _ObservablePatternsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Observable Patterns'),
        _bodyText(
          'Because the mixin fires the builder at layout time with real '
          'constraints, several powerful patterns become possible. Here are '
          'three production-ready patterns with live demonstrations.',
        ),
        _divider(),

        // Pattern 1 — Constraint Inspector
        _subTitle('Pattern 1 — Constraint Inspector'),
        _bodyText(
          'Wrap any widget with a LayoutBuilder to log/display its constraints. '
          'Useful for debugging layout issues without adding intermediate widgets.',
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('ConstraintInspector',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 8),
                    _inspectorRow('minWidth', c.minWidth),
                    _inspectorRow('maxWidth', c.maxWidth),
                    _inspectorRow(
                        'minHeight', c.minHeight),
                    _inspectorRow(
                        'maxHeight',
                        c.hasBoundedHeight ? c.maxHeight : double.infinity),
                    const SizedBox(height: 6),
                    Text(
                        'isTight: ${c.isTight}   hasBoundedWidth: ${c.hasBoundedWidth}   '
                        'hasBoundedHeight: ${c.hasBoundedHeight}',
                        style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: Colors.grey)),
                  ],
                );
              },
            ),
          ),
        ),

        // Pattern 2 — Adaptive Grid
        _subTitle('Pattern 2 — Adaptive Grid'),
        _bodyText(
          'A grid that automatically adjusts column count, gutter, and cell '
          'aspect ratio based purely on LayoutBuilder constraints. No '
          'MediaQuery needed.',
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
                final int cols = (c.maxWidth / 100).floor().clamp(2, 6);
                final double gutter = c.maxWidth < 300 ? 6.0 : 10.0;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: gutter,
                    mainAxisSpacing: gutter,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: cols * 2,
                  itemBuilder: (BuildContext context, int i) {
                    final Color color = Colors.primaries[i % Colors.primaries.length];
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: color.withAlpha(120)),
                      ),
                      child: Text('$cols-col\n#$i',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              color: color,
                              fontWeight: FontWeight.w600)),
                    );
                  },
                );
              },
            ),
          ),
        ),

        // Pattern 3 — Breakpoint-Driven Layout
        _subTitle('Pattern 3 — Breakpoint-Driven Layout'),
        _bodyText(
          'Define named breakpoints as constants and switch layouts '
          'declaratively. The LayoutBuilder fires exactly when crossing '
          'a breakpoint boundary.',
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
                final _Breakpoint bp = _Breakpoint.from(c.maxWidth);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: bp.color.withAlpha(25),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: bp.color.withAlpha(120)),
                      ),
                      child: Text(
                        '${bp.name}  (maxWidth=${c.maxWidth.toStringAsFixed(0)})',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: bp.color,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 10),
                    bp.layout,
                  ],
                );
              },
            ),
          ),
        ),

        _divider(),
        _sectionTitle('Pattern Code Snippets'),
        _codeBlock(
          '// Pattern: Breakpoint helper\n'
          'enum Breakpoint { xs, sm, md, lg, xl }\n\n'
          'Breakpoint getBreakpoint(double width) {\n'
          '  if (width < 320) return Breakpoint.xs;\n'
          '  if (width < 480) return Breakpoint.sm;\n'
          '  if (width < 768) return Breakpoint.md;\n'
          '  if (width < 1024) return Breakpoint.lg;\n'
          '  return Breakpoint.xl;\n'
          '}\n\n'
          'LayoutBuilder(\n'
          '  builder: (context, constraints) {\n'
          '    final bp = getBreakpoint(constraints.maxWidth);\n'
          '    return switch (bp) {\n'
          '      Breakpoint.xs || Breakpoint.sm => MobileLayout(),\n'
          '      Breakpoint.md => TabletLayout(),\n'
          '      _ => DesktopLayout(),\n'
          '    };\n'
          '  },\n'
          ')',
        ),
      ],
    );
  }

  Widget _inspectorRow(String label, double value) {
    final String display = value == double.infinity
        ? '∞'
        : value.toStringAsFixed(1);
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFF5C6BC0),
                    fontWeight: FontWeight.w600)),
          ),
          Text(display,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        ],
      ),
    );
  }
}

class _Breakpoint {
  const _Breakpoint._(this.name, this.color, this.layout);

  final String name;
  final Color color;
  final Widget layout;

  static _Breakpoint from(double width) {
    if (width < 300) {
      return _Breakpoint._(
        'XS (<300px)',
        Colors.red,
        const Text('Single column — compact mode',
            style: TextStyle(fontSize: 12)),
      );
    } else if (width < 450) {
      return _Breakpoint._(
        'SM (300–450px)',
        Colors.orange,
        const Text('Single column — standard mobile',
            style: TextStyle(fontSize: 13)),
      );
    } else if (width < 650) {
      return _Breakpoint._(
        'MD (450–650px)',
        Colors.blue,
        const Text('Two-column — tablet portrait',
            style: TextStyle(fontSize: 14)),
      );
    } else {
      return _Breakpoint._(
        'LG (650px+)',
        Colors.green,
        const Text('Multi-column — expanded layout',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      );
    }
  }
}

// ---------------------------------------------------------------------------
// Tab 9 — Pitfalls & API Cheat Sheet
// ---------------------------------------------------------------------------
class _PitfallsApiTab extends StatelessWidget {
  const _PitfallsApiTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionTitle('Pitfalls'),
        _bodyText(
          'Because the builder runs during layout, several Flutter APIs '
          'that are safe in build() are forbidden here. Misusing them '
          'causes assertion failures or silent corruption.',
        ),

        // Pitfall 1
        _pitfallCard(
          number: 1,
          title: 'Calling setState() inside builder',
          description:
              'The builder runs during layout — the element tree is partially '
              'locked. Calling setState() on any enclosing StatefulWidget '
              'schedules a rebuild, but may also trigger an assertion because '
              'the tree is mid-layout.',
          wrongCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  // WRONG — setState during layout phase\n'
              '  if (constraints.maxWidth < 400) {\n'
              '    setState(() => _isCompact = true);\n'
              '  }\n'
              '  return CompactWidget();\n'
              '})',
          rightCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  // RIGHT — derive value inside builder, no setState needed\n'
              '  final isCompact = constraints.maxWidth < 400;\n'
              '  return isCompact ? CompactWidget() : FullWidget();\n'
              '})',
          accentColor: Colors.red,
        ),

        // Pitfall 2
        _pitfallCard(
          number: 2,
          title: 'Calling showDialog() or Navigator from builder',
          description:
              'Navigator.push() and showDialog() modify the element tree. '
              'Calling them directly from the builder callback (which runs '
              'inside invokeLayoutCallback) will assert. Schedule them with '
              'WidgetsBinding.addPostFrameCallback instead.',
          wrongCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  if (constraints.maxWidth < 200) {\n'
              '    // WRONG — modifies overlay during layout\n'
              '    showDialog(context: ctx, builder: (_) => Alert());\n'
              '  }\n'
              '  return MyWidget();\n'
              '})',
          rightCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  if (constraints.maxWidth < 200) {\n'
              '    // RIGHT — deferred to post-frame\n'
              '    WidgetsBinding.instance.addPostFrameCallback((_) {\n'
              '      showDialog(context: ctx, builder: (_) => Alert());\n'
              '    });\n'
              '  }\n'
              '  return MyWidget();\n'
              '})',
          accentColor: Colors.deepOrange,
        ),

        // Pitfall 3
        _pitfallCard(
          number: 3,
          title: 'Expensive builder causing jank',
          description:
              'The builder runs synchronously during layout. If the builder '
              'does heavy computation (large list processing, image decoding, '
              'complex math), it blocks the layout phase and causes frame drops. '
              'Pre-compute or cache expensive values.',
          wrongCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  // WRONG — O(n²) computation every layout\n'
              '  final items = generateAllPermutations(data);\n'
              '  return ItemList(items: items);\n'
              '})',
          rightCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  // RIGHT — use cached/pre-computed data\n'
              '  final cols = _cachedColumnCount(constraints.maxWidth);\n'
              '  return GridView(crossAxisCount: cols, ...);\n'
              '})',
          accentColor: Colors.amber.shade800,
        ),

        // Pitfall 4
        _pitfallCard(
          number: 4,
          title: 'Assuming builder runs every build()',
          description:
              'Unlike a StatelessWidget\'s build(), the LayoutBuilder\'s '
              'builder does NOT run when a sibling widget rebuilds. It only '
              'runs when constraints change. Do not rely on it for side effects '
              'that should track every parent build.',
          wrongCode:
              'LayoutBuilder(builder: (ctx, constraints) {\n'
              '  // WRONG — analytics call skipped if constraints unchanged\n'
              '  Analytics.logRender(\'my_widget\');\n'
              '  return MyWidget();\n'
              '})',
          rightCode:
              'class MyWidget extends StatefulWidget {\n'
              '  @override\n'
              '  State<MyWidget> createState() => _State();\n'
              '}\n'
              'class _State extends State<MyWidget> {\n'
              '  @override\n'
              '  Widget build(BuildContext ctx) {\n'
              '    Analytics.logRender(\'my_widget\'); // every build\n'
              '    return LayoutBuilder(builder: (ctx, c) => MyLayout(c));\n'
              '  }\n'
              '}',
          accentColor: Colors.purple,
        ),

        _divider(),
        _sectionTitle('API Cheat Sheet'),
        _bodyText(
          'Conceptual API of the mixin plus practical LayoutBuilder reference:',
        ),

        // Mixin conceptual API
        _subTitle('Mixin Conceptual API'),
        _codeBlock(
          '// The mixin (conceptual — not for direct instantiation)\n'
          'mixin RenderAbstractLayoutBuilderMixin<\n'
          '    CT extends Constraints, ChildT extends RenderObject>\n'
          '    on RenderObject {\n\n'
          '  // Stored callback (set by ConstrainedLayoutBuilder)\n'
          '  LayoutCallback<CT> get callback;\n'
          '  set callback(LayoutCallback<CT> value);\n\n'
          '  // Mark layout dirty when callback changes\n'
          '  // (so builder re-fires on next layout)\n'
          '  @protected\n'
          '  void markNeedsLayout();\n\n'
          '  // Core: performs constraint diff + invokeLayoutCallback\n'
          '  @override\n'
          '  void performLayout();\n'
          '}',
        ),

        const SizedBox(height: 12),
        _subTitle('LayoutBuilder Practical Reference'),
        _apiTable(cs),

        const SizedBox(height: 12),
        _subTitle('SliverLayoutBuilder Practical Reference'),
        _sliverApiTable(cs),

        _divider(),
        _sectionTitle('Quick Rules'),
        _ruleRow(Icons.check_circle, Colors.green,
            'Use LayoutBuilder when you need constraints at widget build time'),
        _ruleRow(Icons.check_circle, Colors.green,
            'Return different widget trees for different constraint ranges'),
        _ruleRow(Icons.check_circle, Colors.green,
            'Combine with const constructors for efficient subtrees'),
        _ruleRow(Icons.check_circle, Colors.green,
            'Use SliverLayoutBuilder for scroll-offset-driven sliver content'),
        _ruleRow(Icons.cancel, Colors.red,
            'Never call setState / Navigator / showDialog from the builder'),
        _ruleRow(Icons.cancel, Colors.red,
            'Never perform async operations inside the builder'),
        _ruleRow(Icons.cancel, Colors.red,
            'Never assume builder runs on every parent rebuild'),
        _ruleRow(Icons.cancel, Colors.red,
            'Never put expensive sync computation in the builder'),

        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.lightbulb, color: cs.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'RenderAbstractLayoutBuilderMixin is the engine that makes '
                  'LayoutBuilder possible. By moving the builder callback into '
                  'the layout phase and using invokeLayoutCallback, it gives '
                  'Flutter developers access to real, resolved constraints '
                  'at widget construction time — a capability no other '
                  'widget type in Flutter provides.',
                  style: TextStyle(
                      fontSize: 12,
                      color: cs.onPrimaryContainer,
                      height: 1.55),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _pitfallCard({
    required int number,
    required String title,
    required String description,
    required String wrongCode,
    required String rightCode,
    required Color accentColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withAlpha(120)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 12,
                  backgroundColor: accentColor,
                  child: Text('$number',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                          fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description,
                style: const TextStyle(fontSize: 12, height: 1.5)),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        color: Colors.red.withAlpha(30),
                        child: const Text('WRONG',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      _codeBlock(wrongCode),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  color: Colors.green.withAlpha(30),
                  child: const Text('RIGHT',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
                _codeBlock(rightCode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _apiTable(ColorScheme cs) {
    const List<List<String>> rows = <List<String>>[
      ['Parameter / Property', 'Type', 'Description'],
      ['builder', 'LayoutWidgetBuilder', 'Required. Called during layout with BoxConstraints.'],
      ['constraints (in builder)', 'BoxConstraints', 'Incoming constraints from parent RenderObject.'],
      ['constraints.maxWidth', 'double', 'Maximum width available. Most commonly used.'],
      ['constraints.maxHeight', 'double', 'Maximum height. May be double.infinity in scrollables.'],
      ['constraints.minWidth', 'double', 'Minimum width (0 for most cases).'],
      ['constraints.isTight', 'bool', 'True if min == max for both axes.'],
      ['constraints.hasBoundedHeight', 'bool', 'False if inside an unconstrained vertical scroll.'],
      ['constraints.biggest', 'Size', 'Size(maxWidth, maxHeight) — maximum size.'],
      ['constraints.smallest', 'Size', 'Size(minWidth, minHeight) — minimum size.'],
    ];
    return _tableWidget(rows, cs);
  }

  Widget _sliverApiTable(ColorScheme cs) {
    const List<List<String>> rows = <List<String>>[
      ['Property', 'Type', 'Description'],
      ['scrollOffset', 'double', 'How far the start of the sliver is from viewport start.'],
      ['viewportMainAxisExtent', 'double', 'Total visible height of the viewport.'],
      ['crossAxisExtent', 'double', 'Width (for vertical scroll) of the sliver.'],
      ['overlap', 'double', 'Pixels painted by preceding slivers in this sliver\'s space.'],
      ['remainingPaintExtent', 'double', 'Paint space remaining below this sliver.'],
      ['remainingCacheExtent', 'double', 'Cache space remaining below visible area.'],
      ['precedingScrollExtent', 'double', 'Total scroll extent of all preceding slivers.'],
    ];
    return _tableWidget(rows, cs);
  }

  Widget _tableWidget(List<List<String>> rows, ColorScheme cs) {
    return Table(
      border: TableBorder.all(color: Colors.grey.withAlpha(80)),
      defaultColumnWidth: const FlexColumnWidth(),
      children: rows
          .asMap()
          .entries
          .map((MapEntry<int, List<String>> e) {
        final bool isHeader = e.key == 0;
        return TableRow(
          decoration: BoxDecoration(
            color: isHeader
                ? cs.primaryContainer.withAlpha(180)
                : e.key.isOdd
                    ? Colors.transparent
                    : Colors.grey.withAlpha(12),
          ),
          children: e.value
              .map((String cell) => Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text(cell,
                        style: TextStyle(
                            fontFamily:
                                (isHeader || e.value.indexOf(cell) <= 1)
                                    ? 'monospace'
                                    : null,
                            fontSize: 11,
                            fontWeight: isHeader
                                ? FontWeight.w700
                                : FontWeight.normal)),
                  ))
              .toList(),
        );
      }).toList(),
    );
  }

  Widget _ruleRow(IconData icon, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
