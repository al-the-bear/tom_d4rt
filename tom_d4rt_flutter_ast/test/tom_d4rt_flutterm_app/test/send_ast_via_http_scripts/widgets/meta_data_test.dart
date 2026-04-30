import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (stateless UI; all mutable state lives here)
// ---------------------------------------------------------------------------

final ValueNotifier<String> _tappedCard = ValueNotifier<String>('none');
final ValueNotifier<String> _behaviorLog = ValueNotifier<String>('');
final ValueNotifier<HitTestBehavior> _selectedBehavior =
    ValueNotifier<HitTestBehavior>(HitTestBehavior.deferToChild);
final ValueNotifier<Map<String, dynamic>?> _droppedPayload =
    ValueNotifier<Map<String, dynamic>?>(null);
final ValueNotifier<String> _activeRegion = ValueNotifier<String>('none');
final ValueNotifier<String> _typedMetaResult =
    ValueNotifier<String>('tap a card');
final ValueNotifier<String> _nestedResult =
    ValueNotifier<String>('tap the nested zone');

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A6FFF)),
    ),
    home: const _MetaDataDemoHome(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with DefaultTabController (~9 tabs)
// ---------------------------------------------------------------------------

class _MetaDataDemoHome extends StatelessWidget {
  const _MetaDataDemoHome();

  static const List<Tab> _tabs = [
    Tab(text: 'Intro'),
    Tab(text: 'Diagram'),
    Tab(text: 'Basic'),
    Tab(text: 'Behavior'),
    Tab(text: 'Payload'),
    Tab(text: 'Regions'),
    Tab(text: 'Types'),
    Tab(text: 'Nested'),
    Tab(text: 'Pitfalls'),
    Tab(text: 'API'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primaryContainer,
          title: Text(
            'MetaData Widget Deep Dive',
            style: TextStyle(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: cs.onPrimaryContainer,
            indicatorColor: cs.primary,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            _TabIntro(),
            _TabDiagram(),
            _TabBasicDemo(),
            _TabBehaviorShowcase(),
            _TabPayloadDemo(),
            _TabRegionLabeling(),
            _TabTypedMetadata(),
            _TabNestedMetaData(),
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String text;
  final IconData icon;
  const _InfoBox({required this.text, this.icon = Icons.info_outline});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: cs.secondary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: cs.onSecondaryContainer, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock(this.code);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: cs.onSurface,
          height: 1.6,
        ),
      ),
    );
  }
}

class _ChipLabel extends StatelessWidget {
  final String label;
  final Color? color;
  const _ChipLabel(this.label, {this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = color ?? cs.tertiaryContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: cs.onTertiaryContainer,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero Banner / Intro
// ---------------------------------------------------------------------------

class _TabIntro extends StatelessWidget {
  const _TabIntro();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.label_important_outline,
                        size: 40, color: cs.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'MetaData',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: cs.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Attach arbitrary data to render objects so that pointer '
                  'events carry semantic meaning — card IDs, payload objects, '
                  'region labels — without any inherited-widget plumbing.',
                  style: TextStyle(
                    color: cs.onPrimaryContainer,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('What MetaData does'),
          const _InfoBox(
            text:
                'MetaData wraps a child widget and attaches a Dart object (the '
                '"metaData" property) to the associated RenderMetaData render '
                'object. During a hit test the Flutter framework walks the '
                'render tree collecting HitTestEntry objects into a '
                'HitTestResult. Any entry whose render object is a '
                'RenderMetaData carries the attached payload — making it '
                'retrievable from the result path.',
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Constructor'),
          const _CodeBlock(
            'MetaData({\n'
            '  Key? key,\n'
            '  dynamic metaData,          // any Dart object\n'
            '  HitTestBehavior behavior   // deferToChild (default)\n'
            '      = HitTestBehavior.deferToChild,\n'
            '  Widget? child,\n'
            '})',
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Where it lives in the render tree'),
          _RenderTreeDiagram(),
          const SizedBox(height: 16),
          const _SectionTitle('Why use MetaData?'),
          const SizedBox(height: 8),
          _UseCaseRow(
            Icons.touch_app,
            'Identify tapped widget without lifting state',
          ),
          const SizedBox(height: 6),
          _UseCaseRow(
            Icons.drag_indicator,
            'Attach drag-drop payloads at the render level',
          ),
          const SizedBox(height: 6),
          _UseCaseRow(
            Icons.map_outlined,
            'Label canvas regions for hover or pointer analytics',
          ),
          const SizedBox(height: 6),
          _UseCaseRow(
            Icons.accessibility_new,
            'Complement hit-testing in custom render objects',
          ),
          const SizedBox(height: 6),
          _UseCaseRow(
            Icons.layers_outlined,
            'Disambiguate overlapping interactive areas',
          ),
          const SizedBox(height: 24),
          const _SectionTitle('Key fact'),
          const _InfoBox(
            icon: Icons.lightbulb_outline,
            text:
                'MetaData does NOT propagate data through the widget tree the '
                'way InheritedWidget does. It is strictly a hit-test annotation '
                'on the render object — only code that performs a hit test and '
                'inspects HitTestResult.path can see it.',
          ),
        ],
      ),
    );
  }
}

class _UseCaseRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _UseCaseRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: cs.tertiary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(color: cs.onSurface, height: 1.4)),
        ),
      ],
    );
  }
}

class _RenderTreeDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final nodes = [
      ('Widget tree', 'MetaData(metaData: myObject)', cs.primaryContainer),
      ('Element tree', 'SingleChildRenderObjectElement', cs.secondaryContainer),
      ('Render tree', 'RenderMetaData', cs.tertiaryContainer),
      ('HitTestResult', 'BoxHitTestEntry  →  .metaData', cs.errorContainer),
    ];
    return Column(
      children: [
        for (int i = 0; i < nodes.length; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: nodes[i].$3,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  nodes[i].$1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    nodes[i].$2,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (i < nodes.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Icon(Icons.arrow_downward,
                  size: 18, color: cs.onSurfaceVariant),
            ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Hit-Test Diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _TabDiagram extends StatelessWidget {
  const _TabDiagram();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Hit-test flow with MetaData'),
          const _InfoBox(
            text:
                'When you tap the screen Flutter performs a hit test starting '
                'from the root render object. Each render object in the path '
                'calls hitTest() and may add itself to the HitTestResult. '
                'RenderMetaData overrides hitTest to attach itself — carrying '
                'the metaData property — to every BoxHitTestEntry it adds.',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 420,
            child: CustomPaint(
              painter: _HitTestFlowPainter(
                primary: cs.primary,
                secondary: cs.secondary,
                tertiary: cs.tertiary,
                surface: cs.surfaceContainerHighest,
                onSurface: cs.onSurface,
                error: cs.error,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const _SectionTitle('Reading the metadata back'),
          const _CodeBlock(
            '// After a hit test (e.g. inside GestureRecognizer):\n'
            'final result = BoxHitTestResult();\n'
            'renderBox.hitTest(result, position: localPosition);\n'
            '\n'
            'for (final entry in result.path) {\n'
            '  if (entry is BoxHitTestEntry) {\n'
            '    final ro = entry.target;\n'
            '    if (ro is RenderMetaData) {\n'
            '      final data = ro.metaData;  // your object\n'
            '    }\n'
            '  }\n'
            '}',
          ),
          const SizedBox(height: 16),
          const _InfoBox(
            icon: Icons.warning_amber_outlined,
            text:
                'In most widget-level code you cannot easily run a hit test '
                'yourself; instead pattern-match with a GestureDetector wrapping '
                'each MetaData zone and update a ValueNotifier — which is the '
                'approach shown in the demos below.',
          ),
        ],
      ),
    );
  }
}

class _HitTestFlowPainter extends CustomPainter {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color surface;
  final Color onSurface;
  final Color error;

  const _HitTestFlowPainter({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.surface,
    required this.onSurface,
    required this.error,
  });

  void _drawBox(
    Canvas canvas,
    Rect rect,
    Color fill,
    String label,
    String sublabel,
  ) {
    final paint = Paint()..color = fill;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(rrect, paint);
    final borderPaint = Paint()
      ..color = onSurface.withAlpha(60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(rrect, borderPaint);

    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 16);
    tp.paint(canvas, Offset(rect.left + 8, rect.top + 8));

    if (sublabel.isNotEmpty) {
      final sp = TextPainter(
        text: TextSpan(
          text: sublabel,
          style: TextStyle(
            color: onSurface.withAlpha(180),
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 16);
      sp.paint(canvas, Offset(rect.left + 8, rect.top + 26));
    }
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, String label) {
    final paint = Paint()
      ..color = onSurface.withAlpha(180)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(from, to, paint);

    // Arrow head
    final angle = (to - from).direction;
    final head = Paint()
      ..color = onSurface.withAlpha(180)
      ..style = PaintingStyle.fill;
    // simple triangle arrowhead
    final arrowPath = Path();
    arrowPath.moveTo(to.dx, to.dy);
    arrowPath.lineTo(
      to.dx - 10 * (angle.abs() > 1 ? 0.2 : 1),
      to.dy - 7,
    );
    arrowPath.lineTo(
      to.dx - 10 * (angle.abs() > 1 ? -0.2 : 1),
      to.dy + 7,
    );
    arrowPath.close();
    canvas.drawPath(arrowPath, head);

    if (label.isNotEmpty) {
      final lp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: secondary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final mid = Offset(
        (from.dx + to.dx) / 2 + 6,
        (from.dy + to.dy) / 2 - 14,
      );
      lp.paint(canvas, mid);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    const boxW = 260.0;
    const boxH = 52.0;
    final centerX = size.width / 2 - boxW / 2;

    // Boxes (top to bottom)
    final rects = [
      Rect.fromLTWH(centerX, 10, boxW, boxH),
      Rect.fromLTWH(centerX, 90, boxW, boxH),
      Rect.fromLTWH(centerX, 170, boxW, boxH),
      Rect.fromLTWH(centerX, 250, boxW, boxH),
      Rect.fromLTWH(centerX, 340, boxW, boxH),
    ];

    final colors = [primary, secondary, tertiary, surface, error];
    final labels = [
      'Pointer event (tap)',
      'GestureDetector',
      'RenderMetaData.hitTest()',
      'BoxHitTestEntry added',
      'App reads .metaData',
    ];
    final sublabels = [
      'PointerDownEvent at (x, y)',
      'hitTest dispatched down tree',
      'adds entry if hit',
      'entry.target is RenderMetaData',
      'final data = ro.metaData',
    ];

    final arrowLabels = [
      'dispatched',
      'walk tree',
      'hit!',
      'result.path',
    ];

    for (int i = 0; i < rects.length; i++) {
      _drawBox(canvas, rects[i], colors[i], labels[i], sublabels[i]);
      if (i < rects.length - 1) {
        _drawArrow(
          canvas,
          Offset(size.width / 2, rects[i].bottom),
          Offset(size.width / 2, rects[i + 1].top),
          arrowLabels[i],
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Tab 3 — Basic Metadata Demo (5 cards)
// ---------------------------------------------------------------------------

class _TabBasicDemo extends StatelessWidget {
  const _TabBasicDemo();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Five MetaData-tagged cards'),
          const _InfoBox(
            text:
                'Each card is wrapped in MetaData(metaData: "card_N", '
                'behavior: HitTestBehavior.opaque). A GestureDetector inside '
                'each card updates a top-level ValueNotifier so the banner '
                'below shows which card was tapped — simulating a hit-test '
                'metadata read.',
          ),
          const SizedBox(height: 16),
          // Live result banner
          ValueListenableBuilder<String>(
            valueListenable: _tappedCard,
            builder: (context, val, _) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: val == 'none' ? cs.surfaceContainerHigh : cs.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    val == 'none' ? Icons.touch_app : Icons.check_circle,
                    color: val == 'none' ? cs.onSurfaceVariant : cs.onPrimary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    val == 'none'
                        ? 'Tap a card to read its MetaData'
                        : 'MetaData read: "$val"',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: val == 'none' ? cs.onSurfaceVariant : cs.onPrimary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < 5; i++) ...[
            _BasicMetaCard(index: i),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 16),
          const _SectionTitle('Code pattern'),
          const _CodeBlock(
            'MetaData(\n'
            '  metaData: "card_\$i",\n'
            '  behavior: HitTestBehavior.opaque,\n'
            '  child: GestureDetector(\n'
            '    onTap: () => _tappedCard.value = "card_\$i",\n'
            '    child: Card(...),\n'
            '  ),\n'
            ')',
          ),
        ],
      ),
    );
  }
}

class _BasicMetaCard extends StatelessWidget {
  final int index;
  const _BasicMetaCard({required this.index});

  static const List<Color> _seeds = [
    Color(0xFF4A6FFF),
    Color(0xFF2DB67D),
    Color(0xFFFF6B35),
    Color(0xFF9B5DE5),
    Color(0xFFE83F6F),
  ];

  static const List<String> _icons = [
    'alpha', 'beta', 'gamma', 'delta', 'epsilon',
  ];

  @override
  Widget build(BuildContext context) {
    final seedColor = _seeds[index % _seeds.length];
    final metaValue = 'card_$index';
    return MetaData(
      metaData: metaValue,
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        onTap: () => _tappedCard.value = metaValue,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: seedColor.withAlpha(220),
                  radius: 22,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card ${_icons[index % _icons.length].toUpperCase()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'MetaData: "$metaValue"',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.fingerprint, color: seedColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4 — HitTestBehavior Showcase
// ---------------------------------------------------------------------------

class _TabBehaviorShowcase extends StatelessWidget {
  const _TabBehaviorShowcase();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('HitTestBehavior explained'),
          const _InfoBox(
            text:
                'The behavior property controls whether MetaData participates '
                'in the hit test independently of its child:\n\n'
                '• deferToChild — hit only if child reports a hit\n'
                '• opaque       — always reports a hit (blocks pass-through)\n'
                '• translucent  — always reports a hit AND allows bubbling',
          ),
          const SizedBox(height: 20),
          const _SectionTitle('Select behavior'),
          ValueListenableBuilder<HitTestBehavior>(
            valueListenable: _selectedBehavior,
            builder: (context, current, _) {
              return SegmentedButton<HitTestBehavior>(
                segments: const [
                  ButtonSegment(
                    value: HitTestBehavior.deferToChild,
                    label: Text('deferToChild'),
                  ),
                  ButtonSegment(
                    value: HitTestBehavior.opaque,
                    label: Text('opaque'),
                  ),
                  ButtonSegment(
                    value: HitTestBehavior.translucent,
                    label: Text('translucent'),
                  ),
                ],
                selected: {current},
                onSelectionChanged: (s) {
                  _selectedBehavior.value = s.first;
                  _behaviorLog.value = '';
                },
              );
            },
          ),
          const SizedBox(height: 20),
          const _SectionTitle('Interactive stack'),
          ValueListenableBuilder<HitTestBehavior>(
            valueListenable: _selectedBehavior,
            builder: (context, behavior, _) =>
                _BehaviorStack(behavior: behavior),
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Event log'),
          ValueListenableBuilder<String>(
            valueListenable: _behaviorLog,
            builder: (context, log, _) {
              final cs = Theme.of(context).colorScheme;
              return Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 60),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: Text(
                  log.isEmpty ? 'Tap the colored zones above…' : log,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: cs.onSurface,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Behavior comparison table'),
          _BehaviorTable(),
        ],
      ),
    );
  }
}

class _BehaviorStack extends StatelessWidget {
  final HitTestBehavior behavior;
  const _BehaviorStack({required this.behavior});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    void log(String msg) {
      _behaviorLog.value =
          '${DateTime.now().toIso8601String().substring(11, 19)}  $msg\n'
          '${_behaviorLog.value}';
    }

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Background layer — always tappable
          Positioned.fill(
            child: GestureDetector(
              onTap: () => log('[BACKGROUND] tapped — always reachable'),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cs.outline),
                ),
                child: Center(
                  child: Text(
                    'BACKGROUND (GestureDetector)',
                    style: TextStyle(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Middle layer — MetaData with chosen behavior
          Positioned(
            left: 30,
            top: 30,
            width: 260,
            height: 120,
            child: MetaData(
              metaData: 'middle-layer',
              behavior: behavior,
              child: GestureDetector(
                onTap: () => log('[MIDDLE MetaData/$behavior] tapped'),
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.primaryContainer.withAlpha(220),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cs.primary, width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'MIDDLE MetaData',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          'behavior: $behavior',
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Top layer — transparent GestureDetector
          Positioned(
            left: 80,
            top: 60,
            width: 180,
            height: 80,
            child: GestureDetector(
              onTap: () => log('[TOP transparent] tapped'),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.tertiaryContainer.withAlpha(170),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.tertiary, width: 2),
                ),
                child: Center(
                  child: Text(
                    'TOP LAYER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.onTertiaryContainer,
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
}

class _BehaviorTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const headers = ['Behavior', 'Empty area hit?', 'Allows pass-through?'];
    const rows = [
      ['deferToChild', 'No', 'Yes (if child misses)'],
      ['opaque', 'Yes', 'No (blocks)'],
      ['translucent', 'Yes', 'Yes (bubbles)'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    h,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
        ),
        for (final row in rows)
          TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(cell,
                        style: const TextStyle(fontFamily: 'monospace',
                            fontSize: 12)),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — Payload Identification (drag-drop simulation)
// ---------------------------------------------------------------------------

class _TabPayloadDemo extends StatelessWidget {
  const _TabPayloadDemo();

  static const List<Map<String, dynamic>> _cards = [
    {'id': 'task-001', 'title': 'Design System', 'priority': 'high'},
    {'id': 'task-002', 'title': 'Backend API', 'priority': 'medium'},
    {'id': 'task-003', 'title': 'Unit Tests', 'priority': 'low'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Payload-carrying drag source'),
          const _InfoBox(
            text:
                'Each source card wraps its data in MetaData(metaData: payload). '
                'Tapping a card simulates "dragging" it — the payload Map is '
                'written to a ValueNotifier that the drop zone reads.',
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Source cards'),
          for (final p in _cards) ...[
            _PayloadSourceCard(payload: p),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 20),
          const _SectionTitle('Drop target'),
          _DropTarget(),
          const SizedBox(height: 16),
          const _SectionTitle('Code pattern'),
          const _CodeBlock(
            '// Source:\n'
            'MetaData(\n'
            '  metaData: {"id": "task-001", "title": "Design System"},\n'
            '  behavior: HitTestBehavior.opaque,\n'
            '  child: GestureDetector(\n'
            '    onTap: () => _droppedPayload.value = payload,\n'
            '    child: SourceCard(),\n'
            '  ),\n'
            ')\n\n'
            '// Drop zone reads:\n'
            '_droppedPayload.value  // the attached Map',
          ),
        ],
      ),
    );
  }
}

class _PayloadSourceCard extends StatelessWidget {
  final Map<String, dynamic> payload;
  const _PayloadSourceCard({required this.payload});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final priority = payload['priority'] as String;
    final priorityColor = switch (priority) {
      'high' => cs.error,
      'medium' => cs.tertiary,
      _ => cs.secondary,
    };
    return MetaData(
      metaData: payload,
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        onTap: () => _droppedPayload.value = payload,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.drag_indicator, color: cs.onSurfaceVariant),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payload['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'id: ${payload["id"]}',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _ChipLabel(
                  priority.toUpperCase(),
                  color: priorityColor.withAlpha(60),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 14, color: cs.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DropTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: _droppedPayload,
      builder: (context, payload, _) {
        final hasPayload = payload != null;
        return GestureDetector(
          onTap: () => _droppedPayload.value = null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: hasPayload
                  ? cs.primaryContainer
                  : cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: hasPayload ? cs.primary : cs.outlineVariant,
                width: hasPayload ? 2 : 1,
              ),
            ),
            child: hasPayload
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: cs.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Payload received!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: cs.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      for (final entry in payload.entries)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Text(
                                  '${entry.key}:',
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                    color: cs.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${entry.value}',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: cs.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        '(tap to clear)',
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onPrimaryContainer.withAlpha(150),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      children: [
                        Icon(Icons.inbox_outlined,
                            size: 36, color: cs.onSurfaceVariant),
                        const SizedBox(height: 8),
                        Text(
                          'Drop zone — tap a source card above',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 — Region Labeling
// ---------------------------------------------------------------------------

class _TabRegionLabeling extends StatelessWidget {
  const _TabRegionLabeling();

  static const List<_Region> _regions = [
    _Region('North-West', Color(0xFF4A6FFF), Alignment.topLeft),
    _Region('North-East', Color(0xFF2DB67D), Alignment.topRight),
    _Region('South-West', Color(0xFFFF6B35), Alignment.bottomLeft),
    _Region('South-East', Color(0xFF9B5DE5), Alignment.bottomRight),
    _Region('Centre', Color(0xFFE83F6F), Alignment.center),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Canvas regions with MetaData labels'),
          const _InfoBox(
            text:
                'Each colored quadrant (and centre) is wrapped in '
                'MetaData(metaData: regionName). A GestureDetector on each zone '
                'reports which region is being touched — simulating the pattern '
                'used in map renderers, game UIs, or analytics overlays.',
          ),
          const SizedBox(height: 16),
          // Active region indicator
          ValueListenableBuilder<String>(
            valueListenable: _activeRegion,
            builder: (context, region, _) {
              final cs = Theme.of(context).colorScheme;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: region == 'none'
                      ? cs.surfaceContainerHigh
                      : cs.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  region == 'none'
                      ? 'Touch a region below'
                      : 'Active region: $region',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        region == 'none' ? cs.onSurfaceVariant : cs.onPrimary,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: _RegionCanvas(regions: _regions),
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Pattern'),
          const _CodeBlock(
            'MetaData(\n'
            '  metaData: "North-West",\n'
            '  behavior: HitTestBehavior.opaque,\n'
            '  child: GestureDetector(\n'
            '    onPanUpdate: (_) => _activeRegion.value = "North-West",\n'
            '    onTap: () => _activeRegion.value = "North-West",\n'
            '    child: NWQuadrant(),\n'
            '  ),\n'
            ')',
          ),
        ],
      ),
    );
  }
}

class _Region {
  final String name;
  final Color color;
  final Alignment alignment;
  const _Region(this.name, this.color, this.alignment);
}

class _RegionCanvas extends StatelessWidget {
  final List<_Region> regions;
  const _RegionCanvas({required this.regions});

  @override
  Widget build(BuildContext context) {
    // 2x2 grid + centre overlay
    return Stack(
      children: [
        // Quadrants
        Row(
          children: [
            Expanded(child: _RegionZone(region: regions[0])),
            Expanded(child: _RegionZone(region: regions[1])),
          ],
        ),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            children: [
              Expanded(child: _RegionZone(region: regions[2])),
              Expanded(child: _RegionZone(region: regions[3])),
            ],
          ),
        ),
        // Centre
        Positioned(
          top: 90,
          left: 90,
          right: 90,
          child: SizedBox(
            height: 120,
            child: _RegionZone(region: regions[4]),
          ),
        ),
      ],
    );
  }
}

class _RegionZone extends StatelessWidget {
  final _Region region;
  const _RegionZone({required this.region});

  @override
  Widget build(BuildContext context) {
    return MetaData(
      metaData: region.name,
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        onTap: () => _activeRegion.value = region.name,
        onPanUpdate: (_) => _activeRegion.value = region.name,
        child: Container(
          decoration: BoxDecoration(
            color: region.color.withAlpha(160),
            border: Border.all(color: region.color, width: 2),
          ),
          child: Center(
            child: Text(
              region.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 7 — Typed Metadata
// ---------------------------------------------------------------------------

enum _CardCategory { design, backend, testing, devops }

class _TaskCard {
  final String title;
  final _CardCategory category;
  const _TaskCard(this.title, this.category);
}

class _TabTypedMetadata extends StatelessWidget {
  const _TabTypedMetadata();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('metaData accepts any Dart type'),
          const _InfoBox(
            text:
                'The metaData property is typed as dynamic — it can hold an int, '
                'a String, an enum value, or a custom class instance. Tap each '
                'card to see what type was attached.',
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<String>(
            valueListenable: _typedMetaResult,
            builder: (context, result, _) {
              final cs = Theme.of(context).colorScheme;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  result,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // int metadata
          _TypedCard<int>(
            label: 'int',
            value: 42,
            icon: Icons.numbers,
            color: const Color(0xFF4A6FFF),
            description: 'MetaData(metaData: 42)',
            onTap: (v) =>
                _typedMetaResult.value = 'int: $v  (runtimeType: ${v.runtimeType})',
          ),
          const SizedBox(height: 12),
          // String metadata
          _TypedCard<String>(
            label: 'String',
            value: 'hero-zone',
            icon: Icons.text_fields,
            color: const Color(0xFF2DB67D),
            description: 'MetaData(metaData: "hero-zone")',
            onTap: (v) =>
                _typedMetaResult.value = 'String: "$v"  (runtimeType: ${v.runtimeType})',
          ),
          const SizedBox(height: 12),
          // enum metadata — cycles through all four enum values
          _TypedCard<_CardCategory>(
            label: 'enum (_CardCategory.design)',
            value: _CardCategory.design,
            icon: Icons.palette_outlined,
            color: const Color(0xFFFF6B35),
            description: 'MetaData(metaData: _CardCategory.design)',
            onTap: (v) =>
                _typedMetaResult.value = 'enum: ${v.name}  (runtimeType: ${v.runtimeType})',
          ),
          const SizedBox(height: 12),
          _TypedCard<_CardCategory>(
            label: 'enum (_CardCategory.testing)',
            value: _CardCategory.testing,
            icon: Icons.science_outlined,
            color: const Color(0xFFE83F6F),
            description: 'MetaData(metaData: _CardCategory.testing)',
            onTap: (v) =>
                _typedMetaResult.value = 'enum: ${v.name}  (runtimeType: ${v.runtimeType})',
          ),
          const SizedBox(height: 12),
          _TypedCard<_CardCategory>(
            label: 'enum (_CardCategory.devops)',
            value: _CardCategory.devops,
            icon: Icons.terminal_outlined,
            color: const Color(0xFF4A6FFF),
            description: 'MetaData(metaData: _CardCategory.devops)',
            onTap: (v) =>
                _typedMetaResult.value = 'enum: ${v.name}  (runtimeType: ${v.runtimeType})',
          ),
          const SizedBox(height: 12),
          _TypedCard<_CardCategory>(
            label: 'enum (_CardCategory.backend)',
            value: _CardCategory.backend,
            icon: Icons.category_outlined,
            color: const Color(0xFF2DB67D),
            description: 'MetaData(metaData: _CardCategory.backend)',
            onTap: (v) =>
                _typedMetaResult.value = 'enum: ${v.name}  (runtimeType: ${v.runtimeType})',
          ),
          const SizedBox(height: 12),
          // custom class metadata
          _TypedCard<_TaskCard>(
            label: 'custom class',
            value: const _TaskCard('Implement Auth', _CardCategory.backend),
            icon: Icons.class_outlined,
            color: const Color(0xFF9B5DE5),
            description: 'MetaData(metaData: TaskCard(...))',
            onTap: (v) =>
                _typedMetaResult.value =
                    'TaskCard: title="${v.title}", category=${v.category.name}',
          ),
          const SizedBox(height: 20),
          const _SectionTitle('Why this matters'),
          const _InfoBox(
            text:
                'Because metaData is dynamic you can attach rich domain objects '
                'and cast them on retrieval. Type-check with "is" before use:\n\n'
                '  if (ro.metaData is TaskCard) {\n'
                '    final task = ro.metaData as TaskCard;\n'
                '  }',
          ),
        ],
      ),
    );
  }
}

class _TypedCard<T> extends StatelessWidget {
  final String label;
  final T value;
  final IconData icon;
  final Color color;
  final String description;
  final void Function(T) onTap;

  const _TypedCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MetaData(
      metaData: value,
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withAlpha(200),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ChipLabel(label),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.touch_app_outlined, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 8 — Nested MetaData
// ---------------------------------------------------------------------------

class _TabNestedMetaData extends StatelessWidget {
  const _TabNestedMetaData();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Nested MetaData widgets'),
          const _InfoBox(
            text:
                'When MetaData is nested the innermost render object is hit '
                'first — because hit testing walks from child to parent. '
                'The first entry in HitTestResult.path is the deepest (innermost) '
                'MetaData; the outer one appears later in the path.',
          ),
          const SizedBox(height: 20),
          // Visualisation
          ValueListenableBuilder<String>(
            valueListenable: _nestedResult,
            builder: (context, result, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      result,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Outer MetaData
                  MetaData(
                    metaData: 'outer-panel',
                    behavior: HitTestBehavior.opaque,
                    child: GestureDetector(
                      onTap: () =>
                          _nestedResult.value = 'tapped OUTER "outer-panel"',
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer.withAlpha(100),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: cs.primary, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.layers_outlined,
                                    color: cs.primary, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Outer MetaData  ("outer-panel")',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: cs.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Tap here (outside inner box) to read "outer-panel"',
                              style: TextStyle(
                                fontSize: 12,
                                color: cs.onPrimaryContainer.withAlpha(180),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Inner MetaData
                            MetaData(
                              metaData: 'inner-widget',
                              behavior: HitTestBehavior.opaque,
                              child: GestureDetector(
                                onTap: () => _nestedResult.value =
                                    'tapped INNER "inner-widget" (innermost wins)',
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: cs.secondaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: cs.secondary, width: 2),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.layers,
                                              color: cs.secondary, size: 16),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Inner MetaData  ("inner-widget")',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: cs.onSecondaryContainer,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Tap here — innermost MetaData is hit first',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: cs.onSecondaryContainer
                                              .withAlpha(180),
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
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const _SectionTitle('Why innermost wins'),
          const _InfoBox(
            text:
                'Flutter performs hit testing by recursing into children first. '
                'The child with the deepest nesting reports its hit entry before '
                'the parent does. HitTestResult.path is ordered deepest-first, '
                'so result.path.first is the innermost MetaData.',
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Code'),
          const _CodeBlock(
            'MetaData(\n'
            '  metaData: "outer",\n'
            '  child: MetaData(\n'
            '    metaData: "inner",          // this is hit first\n'
            '    child: SomeWidget(),\n'
            '  ),\n'
            ')\n\n'
            '// result.path order:\n'
            '// 1. RenderMetaData("inner")   ← first\n'
            '// 2. RenderMetaData("outer")   ← second',
          ),
          const SizedBox(height: 16),
          const _SectionTitle('Nesting depth diagram'),
          _NestingDepthDiagram(),
        ],
      ),
    );
  }
}

class _NestingDepthDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final levels = [
      ('Depth 0 — Root RenderBox', cs.surfaceContainerHigh),
      ('Depth 1 — RenderMetaData ("outer")', cs.primaryContainer),
      ('Depth 2 — RenderMetaData ("inner") ← hit first', cs.secondaryContainer),
      ('Depth 3 — Child RenderBox', cs.tertiaryContainer),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < levels.length; i++) ...[
          Padding(
            padding: EdgeInsets.only(left: i * 16.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: levels[i].$2,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                levels[i].$1,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: cs.onSurface,
                ),
              ),
            ),
          ),
          if (i < levels.length - 1) const SizedBox(height: 4),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 9 — Pitfalls
// ---------------------------------------------------------------------------

class _TabPitfalls extends StatelessWidget {
  const _TabPitfalls();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Common MetaData pitfalls'),
          const SizedBox(height: 8),
          _PitfallTile(
            number: 1,
            title: 'Metadata stale after rebuild',
            icon: Icons.autorenew,
            iconColor: cs.error,
            body:
                'If the widget tree is rebuilt with a new metaData value the '
                'render object is updated — but any code holding a stale '
                'reference to the old metaData object will see the old value. '
                'Always read metaData fresh from the render object, not from '
                'a cached variable.',
            code:
                '// Stale reference — avoid:\n'
                'final stale = renderMetaData.metaData;  // cached at build\n'
                '\n'
                '// Safe — read at event time:\n'
                'void onTap() {\n'
                '  final live = findRenderMetaData().metaData;\n'
                '}',
          ),
          const SizedBox(height: 16),
          _PitfallTile(
            number: 2,
            title: 'Null metaData is valid but risky',
            icon: Icons.warning_amber_outlined,
            iconColor: cs.tertiary,
            body:
                'MetaData(metaData: null) is perfectly legal — the widget '
                'still participates in hit testing. However, if you cast '
                'metaData directly without a null check you will get a '
                'null-dereference at runtime.',
            code:
                '// Unsafe:\n'
                'final id = (ro.metaData as String).toUpperCase();  // NPE!\n'
                '\n'
                '// Safe:\n'
                'final id = ro.metaData is String\n'
                '    ? (ro.metaData as String).toUpperCase()\n'
                '    : "unknown";',
          ),
          const SizedBox(height: 16),
          _PitfallTile(
            number: 3,
            title: 'Confusing MetaData with InheritedWidget',
            icon: Icons.compare_arrows,
            iconColor: cs.secondary,
            body:
                'MetaData is NOT a state-management or dependency-injection '
                'mechanism. It does not propagate data down the tree; no '
                'widget can call context.dependOnInheritedWidgetOfExactType '
                'to read it. It is only visible to code that has a direct '
                'reference to the render object — typically code inside a '
                'GestureArena or a custom RenderObject.',
            code:
                '// This does NOT work:\n'
                'final data = context.findAncestorWidgetOfExactType<MetaData>();\n'
                '// (gives widget, not metaData value, and is fragile)\n'
                '\n'
                '// MetaData is render-tree only:\n'
                'final entry = result.path\n'
                '    .whereType<BoxHitTestEntry>()\n'
                '    .first;\n'
                'final data = (entry.target as RenderMetaData).metaData;',
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  final int number;
  final String title;
  final IconData icon;
  final Color iconColor;
  final String body;
  final String code;

  const _PitfallTile({
    required this.number,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.body,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: iconColor.withAlpha(200),
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(body,
                style: TextStyle(color: cs.onSurface, height: 1.45)),
            const SizedBox(height: 10),
            _CodeBlock(code),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 10 — API Cheat Sheet
// ---------------------------------------------------------------------------

class _TabApiCheatSheet extends StatelessWidget {
  const _TabApiCheatSheet();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Constructor'),
          const _CodeBlock(
            'const MetaData({\n'
            '  Key? key,\n'
            '  dynamic metaData,\n'
            '  HitTestBehavior behavior = HitTestBehavior.deferToChild,\n'
            '  Widget? child,\n'
            '})',
          ),
          const SizedBox(height: 20),
          const _SectionTitle('Properties'),
          _PropTable(),
          const SizedBox(height: 20),
          const _SectionTitle('HitTestBehavior values'),
          _BehaviorDescTable(),
          const SizedBox(height: 20),
          const _SectionTitle('Comparison: MetaData vs AbsorbPointer vs IgnorePointer'),
          _ComparisonTable(),
          const SizedBox(height: 20),
          const _SectionTitle('Use-cases at a glance'),
          _UseCasesTable(),
          const SizedBox(height: 20),
          const _SectionTitle('Minimal working example'),
          const _CodeBlock(
            "import 'package:flutter/material.dart';\n"
            "import 'package:flutter/rendering.dart';\n"
            '\n'
            'final _lastId = ValueNotifier<String>("—");\n'
            '\n'
            'Widget build(BuildContext context) {\n'
            '  return Column(\n'
            '    children: [\n'
            '      for (int i = 0; i < 3; i++)\n'
            '        MetaData(\n'
            '          metaData: "item_\$i",\n'
            '          behavior: HitTestBehavior.opaque,\n'
            '          child: GestureDetector(\n'
            '            onTap: () => _lastId.value = "item_\$i",\n'
            '            child: ListTile(title: Text("Item \$i")),\n'
            '          ),\n'
            '        ),\n'
            '      ValueListenableBuilder<String>(\n'
            '        valueListenable: _lastId,\n'
            '        builder: (_, v, __) => Text("Tapped: \$v"),\n'
            '      ),\n'
            '    ],\n'
            '  );\n'
            '}',
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.tertiaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick rules',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.onPrimaryContainer,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                for (final rule in [
                  'Use MetaData to label hit-testable render objects with domain data.',
                  'Prefer HitTestBehavior.opaque for solid interactive areas.',
                  'Use HitTestBehavior.translucent when events must pass through.',
                  'Never confuse MetaData with InheritedWidget — they are different mechanisms.',
                  'Innermost MetaData is reached first in HitTestResult.path.',
                  'Always null-check before casting the dynamic metaData value.',
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 16, color: cs.primary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            rule,
                            style: TextStyle(
                              color: cs.onPrimaryContainer,
                              height: 1.4,
                              fontSize: 13,
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
}

class _PropTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = [
      ['metaData', 'dynamic', 'Any object to attach to the render object'],
      [
        'behavior',
        'HitTestBehavior',
        'Controls how the widget participates in hit testing',
      ],
      ['child', 'Widget?', 'The widget subtree below this annotation'],
      ['key', 'Key?', 'Standard widget key'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const {
        0: FlexColumnWidth(1.4),
        1: FlexColumnWidth(1.6),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: ['Property', 'Type', 'Description']
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(h,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
              .toList(),
        ),
        for (final row in rows)
          TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      cell,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _BehaviorDescTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = [
      ['deferToChild', 'Hit only if a child reports a hit. Default.'],
      ['opaque', 'Always hit in bounds; blocks underlying handlers.'],
      ['translucent', 'Always hit in bounds; allows bubbling to underlying.'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const {
        0: FlexColumnWidth(1.6),
        1: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: cs.secondaryContainer),
          children: ['Value', 'Meaning']
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(h,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
              .toList(),
        ),
        for (final row in rows)
          TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      cell,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const headers = ['Widget', 'Attaches data?', 'Blocks events?', 'Purpose'];
    const rows = [
      ['MetaData', 'Yes', 'Optional', 'Label render objects with payload'],
      ['AbsorbPointer', 'No', 'Yes', 'Silently absorb pointer events'],
      ['IgnorePointer', 'No', 'Yes (pass-through)', 'Let events fall through'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1.3),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2.5),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: cs.tertiaryContainer),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(h,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 11)),
                ),
              )
              .toList(),
        ),
        for (final row in rows)
          TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      cell,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _UseCasesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = [
      ['Card ID labeling', 'Identify which card was tapped without lifting state'],
      ['Drag-drop payload', 'Carry payload from source to drop target'],
      ['Map regions', 'Name geographic or canvas zones for analytics'],
      ['Custom hit testing', 'Attach data to custom render objects'],
      ['Game entities', 'Tag sprites or tiles with game entity references'],
      ['Accessibility', 'Supply extra semantic context alongside SemanticsNode'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const {
        0: FlexColumnWidth(1.8),
        1: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: ['Use case', 'Description']
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(h,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
              .toList(),
        ),
        for (final row in rows)
          TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(cell,
                        style: const TextStyle(fontSize: 12)),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
