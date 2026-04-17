import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DiagnosticsDebugCreator — Deep Visual Demo
//
// DiagnosticsDebugCreator is a specialised DiagnosticsNode attached to a
// RenderObject in DEBUG mode so that, when an error travels through
// Flutter's error-reporting pipeline, the framework can map the failing
// RenderObject back to the Widget (and Element) that created it.
//
// It holds a `debugCreator` value (conventionally a `DebugCreator` struct
// carrying `element` and `widget`) and exposes it through the diagnostics
// stream.  The rendering-library error formatter picks it up and injects
// a "The relevant error-causing widget was: …" block into the error
// message, together with the creation stack when available.
//
// This demo visualises:
//   1. Pipeline from Widget ➜ Element ➜ RenderObject ➜ DebugCreator ➜ error
//   2. The shape of the `debugCreator` struct
//   3. Error output WITH vs WITHOUT debugCreator
//   4. How framework elements populate it in debug mode
//   5. Debug-only nature (kDebugMode contrast)
//   6. Typical use-cases (overflow, constraint mismatch, missing
//      Directionality, etc.)
//   7. Comparison with DebugCreator, DiagnosticsNode, FlutterErrorDetails
//   8. Pitfalls + property / API cheat sheet
//
// The tour is stateless — no runApp, no main, no flutter_test.
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// Top-level mutable state (only ValueNotifier<T>, no StatefulWidget)
// ─────────────────────────────────────────────────────────────────────────────

/// Tab 4: error-mapping toggle — with vs without debugCreator
final ValueNotifier<bool> _showWithCreator = ValueNotifier<bool>(true);

/// Tab 6: kDebugMode contrast toggle
final ValueNotifier<bool> _debugModeToggle = ValueNotifier<bool>(true);

/// Tab 7: selected use-case card (0..5)
final ValueNotifier<int> _useCase = ValueNotifier<int>(0);

/// Tab 8: selected comparison row
final ValueNotifier<int> _comparisonPick = ValueNotifier<int>(0);

// ─────────────────────────────────────────────────────────────────────────────
// Entry point — d4rt sandbox contract
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    ),
    home: const _DiagnosticsDebugCreatorDemo(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Root shell — 9 tabs
// ─────────────────────────────────────────────────────────────────────────────

class _DiagnosticsDebugCreatorDemo extends StatelessWidget {
  const _DiagnosticsDebugCreatorDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Pipeline'),
    Tab(text: 'Struct'),
    Tab(text: 'Error Map'),
    Tab(text: 'How Populated'),
    Tab(text: 'Debug Only'),
    Tab(text: 'Use Cases'),
    Tab(text: 'Compare'),
    Tab(text: 'Cheatsheet'),
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
            'DiagnosticsDebugCreator — Deep Demo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cs.onPrimaryContainer,
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
            _HeroTab(),
            _PipelineTab(),
            _StructTab(),
            _ErrorMapTab(),
            _HowPopulatedTab(),
            _DebugOnlyTab(),
            _UseCasesTab(),
            _CompareTab(),
            _CheatsheetTab(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow(this.name, this.value, {this.highlight = false});

  final String name;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: highlight
            ? cs.primaryContainer.withValues(alpha: 0.35)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet(this.code, {this.label});

  final String code;
  final String? label;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Row(
              children: [
                Icon(Icons.code, size: 14, color: cs.primary),
                const SizedBox(width: 6),
                Text(
                  label!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          Text(
            code,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: cs.onSurfaceVariant,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text, {this.leading = Icons.check_circle_outline});

  final String text;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 8),
            child: Icon(leading, size: 16, color: cs.primary),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConceptTile extends StatelessWidget {
  const _ConceptTile({
    required this.icon,
    required this.label,
    required this.body,
  });

  final IconData icon;
  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 18, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 1 — HERO
// ─────────────────────────────────────────────────────────────────────────────

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gradient hero
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.tertiaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bug_report_outlined,
                      size: 44,
                      color: cs.primary,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DiagnosticsDebugCreator',
                            style: tt.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            'Render-object  ➜  source-widget bridge',
                            style: tt.bodyMedium?.copyWith(
                              color: cs.onTertiaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'DiagnosticsDebugCreator is a DiagnosticsNode that the '
                  'rendering library attaches to each RenderObject in '
                  'debug mode. Its sole job is to remember which Widget '
                  '(and Element) created the RenderObject, so that when '
                  'Flutter\'s error-reporting pipeline fires, the error '
                  'message can surface a "relevant error-causing widget" '
                  'block pointing straight at your source code.',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onPrimaryContainer,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: const Text('debug-mode only'),
                      avatar: Icon(Icons.shield_outlined, color: cs.primary),
                      backgroundColor: cs.surface,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: const Text('rendering layer'),
                      avatar: Icon(Icons.layers_outlined, color: cs.primary),
                      backgroundColor: cs.surface,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: const Text('error pipeline'),
                      avatar: Icon(Icons.error_outline, color: cs.primary),
                      backgroundColor: cs.surface,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Why it exists',
            subtitle:
                'Map render-object errors back to the widgets that caused them',
            child: Column(
              children: const [
                _BulletPoint(
                  'RenderObjects operate far from your widget code; error '
                  'messages from the layout/paint pipeline would otherwise '
                  'name only RenderFlex, RenderPadding, RenderParagraph …',
                ),
                _BulletPoint(
                  'DiagnosticsDebugCreator injects a back-reference: the '
                  'creating Element and Widget, plus (optionally) a '
                  'creation stack captured by the widget-inspector.',
                ),
                _BulletPoint(
                  'The error formatter in FlutterErrorDetails picks the '
                  'node up and renders the familiar "The relevant '
                  'error-causing widget was:" block.',
                ),
                _BulletPoint(
                  'Only attached when asserts are enabled (kDebugMode); '
                  'the cost is removed from release builds by the '
                  'tree-shaker.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Quick facts',
            subtitle: 'What you will see in the remaining tabs',
            child: Column(
              children: const [
                _ConceptTile(
                  icon: Icons.share_outlined,
                  label: 'Pipeline',
                  body: 'Widget → Element → RenderObject → '
                      'DiagnosticsDebugCreator → FlutterErrorDetails → '
                      'dumped error message.',
                ),
                _ConceptTile(
                  icon: Icons.widgets_outlined,
                  label: 'Struct',
                  body: 'Wraps a DebugCreator payload with `element` '
                      '(and therefore `widget`, `debugGetCreatorChain`, …).',
                ),
                _ConceptTile(
                  icon: Icons.report_gmailerrorred_outlined,
                  label: 'Error message',
                  body: 'Contrast: without the node you only see render '
                      'types; with it you see the widget name and file.',
                ),
                _ConceptTile(
                  icon: Icons.build_outlined,
                  label: 'Framework internals',
                  body: 'RenderObjectElement sets '
                      '`renderObject.debugCreator = DebugCreator(this)` '
                      'during `_firstBuild` / `mount`.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 2 — PIPELINE (CustomPainter diagram)
// ─────────────────────────────────────────────────────────────────────────────

class _PipelineTab extends StatelessWidget {
  const _PipelineTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'The error-pipeline flow',
            subtitle:
                'From widget declaration to the "error-causing widget" block',
            child: SizedBox(
              height: 320,
              child: CustomPaint(
                painter: _PipelinePainter(
                  scheme: Theme.of(context).colorScheme,
                ),
              ),
            ),
          ),
          _SectionCard(
            title: 'What happens step-by-step',
            subtitle: 'Each stop in the pipeline',
            child: Column(
              children: const [
                _StageDetail(
                  n: 1,
                  label: 'Widget',
                  body: 'You write `MyWidget(...)` in your build method. '
                      'A Widget is a lightweight, immutable configuration.',
                ),
                _StageDetail(
                  n: 2,
                  label: 'Element',
                  body: 'The framework inflates the Widget into an Element '
                      '(e.g. StatelessElement, StatefulElement, '
                      'RenderObjectElement). This is the live node in the '
                      'tree.',
                ),
                _StageDetail(
                  n: 3,
                  label: 'RenderObject',
                  body: 'A RenderObjectElement creates and owns a '
                      'RenderObject (e.g. RenderFlex). This is where '
                      'layout, paint and hit-testing happen.',
                ),
                _StageDetail(
                  n: 4,
                  label: 'DebugCreator attached',
                  body: 'In debug mode the Element assigns '
                      '`renderObject.debugCreator = DebugCreator(this)`. '
                      'Internally, the diagnostics system wraps that in a '
                      '`DiagnosticsDebugCreator` node.',
                ),
                _StageDetail(
                  n: 5,
                  label: 'Error occurs',
                  body: 'Layout throws (overflow), paint asserts, '
                      'constraints mismatch, etc. The RenderObject adds '
                      'its diagnostics to the FlutterErrorDetails context, '
                      'including the DiagnosticsDebugCreator node.',
                ),
                _StageDetail(
                  n: 6,
                  label: 'Formatter renders it',
                  body: 'ErrorDescription / debugTransformDebugCreator '
                      'reads the node, extracts widget+creation-stack, and '
                      'prints the "The relevant error-causing widget was: …" '
                      'block with a clickable file:line reference.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'debugTransformDebugCreator',
            subtitle: 'Where the magic conversion happens',
            child: const _CodeSnippet(
              label: 'package:flutter/src/widgets/widget_inspector.dart',
              'List<DiagnosticsNode> debugTransformDebugCreator(\n'
              '  List<DiagnosticsNode> properties,\n'
              ') {\n'
              '  if (!kDebugMode) return properties;\n'
              '  final result = <DiagnosticsNode>[];\n'
              '  for (final node in properties) {\n'
              '    if (node.value is DebugCreator) {\n'
              '      // Replace the opaque DebugCreator node with rich,\n'
              '      // widget-aware diagnostics entries such as the\n'
              '      // "error-causing widget was" block and the\n'
              '      // "creation stack" entry (when available).\n'
              '      result.addAll(_parseDiagnosticsTreeNew(node));\n'
              '    } else {\n'
              '      result.add(node);\n'
              '    }\n'
              '  }\n'
              '  return result;\n'
              '}',
            ),
          ),
        ],
      ),
    );
  }
}

class _StageDetail extends StatelessWidget {
  const _StageDetail({
    required this.n,
    required this.label,
    required this.body,
  });

  final int n;
  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '$n',
              style: TextStyle(
                color: cs.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(body, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelinePainter extends CustomPainter {
  _PipelinePainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = scheme.surfaceContainerHighest;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final stages = <(String, String, Color, Color)>[
      ('Widget',           'MyCard(...)',          scheme.primaryContainer,    scheme.onPrimaryContainer),
      ('Element',          'CardElement',          scheme.secondaryContainer,  scheme.onSecondaryContainer),
      ('RenderObject',     'RenderFlex',           scheme.tertiaryContainer,   scheme.onTertiaryContainer),
      ('DebugCreator',     'element + widget',     scheme.surfaceContainer,    scheme.onSurface),
      ('Error',            'FlutterErrorDetails',  scheme.errorContainer,      scheme.onErrorContainer),
      ('Formatter',        'error-causing widget', scheme.inversePrimary,      scheme.onPrimaryContainer),
    ];

    const n = 6;
    final boxW = (size.width - 24 - (n - 1) * 10) / n;
    final boxH = 88.0;
    final top = 40.0;

    final arrow = Paint()
      ..color = scheme.outline
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < n; i++) {
      final x = 12 + i * (boxW + 10);
      final rect = Rect.fromLTWH(x, top, boxW, boxH);
      final r = RRect.fromRectAndRadius(rect, const Radius.circular(10));

      canvas.drawRRect(r, Paint()..color = stages[i].$3);

      final titlePainter = TextPainter(
        text: TextSpan(
          text: stages[i].$1,
          style: TextStyle(
            color: stages[i].$4,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
        textAlign: TextAlign.center,
      )..layout(maxWidth: boxW - 8);
      titlePainter.paint(
        canvas,
        Offset(
          x + (boxW - titlePainter.width) / 2,
          top + 12,
        ),
      );

      final valuePainter = TextPainter(
        text: TextSpan(
          text: stages[i].$2,
          style: TextStyle(
            color: stages[i].$4.withValues(alpha: 0.85),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
        textAlign: TextAlign.center,
      )..layout(maxWidth: boxW - 8);
      valuePainter.paint(
        canvas,
        Offset(
          x + (boxW - valuePainter.width) / 2,
          top + 40,
        ),
      );

      // Index pill
      final pillR = RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 6, top + 6, 18, 18),
        const Radius.circular(9),
      );
      canvas.drawRRect(pillR, Paint()..color = scheme.surface);
      final pillText = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: scheme.primary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      pillText.paint(
        canvas,
        Offset(x + 6 + (18 - pillText.width) / 2,
            top + 6 + (18 - pillText.height) / 2),
      );

      if (i < n - 1) {
        final ax = x + boxW;
        final ay = top + boxH / 2;
        canvas.drawLine(Offset(ax, ay), Offset(ax + 10, ay), arrow);
        final path = Path()
          ..moveTo(ax + 10, ay)
          ..lineTo(ax + 4, ay - 4)
          ..lineTo(ax + 4, ay + 4)
          ..close();
        canvas.drawPath(path, Paint()..color = scheme.outline);
      }
    }

    // Explanatory bottom arc: 4 -> 5 -> 6 highlight
    final arc = Paint()
      ..color = scheme.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final arcRect = Rect.fromLTWH(
      12 + 3 * (boxW + 10),
      top + boxH + 10,
      3 * boxW + 2 * 10,
      60,
    );
    canvas.drawArc(arcRect, 3.14, 3.14, false, arc);

    final label = TextPainter(
      text: TextSpan(
        text: 'debug-mode wiring (stripped in release)',
        style: TextStyle(
          color: scheme.primary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(
      canvas,
      Offset(
        arcRect.left + (arcRect.width - label.width) / 2,
        arcRect.bottom + 4,
      ),
    );

    // Bottom caption
    final caption = TextPainter(
      text: TextSpan(
        text:
            'User code  ──  Framework  ──────────────  DevTools / console',
        style: TextStyle(
          color: scheme.onSurfaceVariant,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    caption.paint(
      canvas,
      Offset((size.width - caption.width) / 2, size.height - 22),
    );
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 3 — STRUCT (what debugCreator holds)
// ─────────────────────────────────────────────────────────────────────────────

class _StructTab extends StatelessWidget {
  const _StructTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Shape of debugCreator',
            subtitle: 'A tiny struct, a rich diagnostics wrapper',
            child: SizedBox(
              height: 280,
              child: CustomPaint(
                painter: _StructPainter(
                  scheme: Theme.of(context).colorScheme,
                ),
              ),
            ),
          ),
          _SectionCard(
            title: 'Fields',
            subtitle:
                'DebugCreator holds just an Element reference; DiagnosticsDebugCreator is the DiagnosticsNode layer',
            child: Column(
              children: const [
                _PropRow('DebugCreator.element', 'Element — the live tree node'),
                _PropRow('DebugCreator.widget',  'Element.widget — implicit, via .element'),
                _PropRow('debugCreator (field)', 'Object? on every RenderObject'),
                _PropRow('DiagnosticsDebugCreator.value', 'DebugCreator (the payload)'),
                _PropRow('DiagnosticsDebugCreator.name',  'usually "debugCreator"'),
                _PropRow('style', 'DiagnosticsTreeStyle.dense / hidden'),
                _PropRow('showName', 'false — hidden in default dumps'),
              ],
            ),
          ),
          _SectionCard(
            title: 'Why a DiagnosticsNode wrapper at all?',
            subtitle: 'Diagnostics nodes are the currency of the error pipeline',
            child: Column(
              children: const [
                _BulletPoint(
                  'FlutterErrorDetails.describeInformation expects a flat '
                  'list of DiagnosticsNode; raw Elements would not fit.',
                ),
                _BulletPoint(
                  'DiagnosticsDebugCreator inherits toStringDeep / '
                  'toJsonMap so DevTools can serialise the creator '
                  'reference over the protocol.',
                ),
                _BulletPoint(
                  'debugTransformDebugCreator walks the property list and '
                  'replaces each DebugCreator entry with human-readable '
                  'diagnostics (widget, source file, creation stack).',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Source-shape summary',
            subtitle: 'Pseudocode view of the two types',
            child: const _CodeSnippet(
              label: 'pseudocode — package:flutter/src/widgets/',
              'class DebugCreator {\n'
              '  DebugCreator(this.element);\n'
              '  final Element element;\n'
              '  // widget  = element.widget\n'
              '  // chain() = element.debugGetCreatorChain(n)\n'
              '}\n'
              '\n'
              'class DiagnosticsDebugCreator extends DiagnosticsProperty<Object> {\n'
              '  DiagnosticsDebugCreator(DebugCreator value, { String? name })\n'
              '      : super(name, value, showName: false, style: Hidden);\n'
              '}\n'
              '\n'
              'abstract class RenderObject with DiagnosticableTreeMixin {\n'
              '  Object? debugCreator; // usually a DebugCreator instance\n'
              '}',
            ),
          ),
        ],
      ),
    );
  }
}

class _StructPainter extends CustomPainter {
  _StructPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = scheme.surfaceContainerHighest;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    // Outer RenderObject container
    final outer = Rect.fromLTWH(16, 16, size.width - 32, size.height - 32);
    canvas.drawRRect(
      RRect.fromRectAndRadius(outer, const Radius.circular(12)),
      Paint()..color = scheme.tertiaryContainer,
    );
    final outerLabel = TextPainter(
      text: TextSpan(
        text: 'RenderObject (e.g. RenderFlex)',
        style: TextStyle(
          color: scheme.onTertiaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    outerLabel.paint(canvas, Offset(outer.left + 12, outer.top + 8));

    // debugCreator field
    final field = Rect.fromLTWH(
      outer.left + 24,
      outer.top + 36,
      outer.width - 48,
      60,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(field, const Radius.circular(8)),
      Paint()..color = scheme.secondaryContainer,
    );
    final fieldLabel = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: scheme.onSecondaryContainer,
          fontSize: 12,
          fontFamily: 'monospace',
        ),
        children: const [
          TextSpan(
            text: 'Object? debugCreator  ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '= DebugCreator(element);'),
        ],
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: field.width - 20);
    fieldLabel.paint(
      canvas,
      Offset(field.left + 10, field.top + 10),
    );
    final fieldSub = TextPainter(
      text: TextSpan(
        text: 'populated by RenderObjectElement.mount() in debug mode only',
        style: TextStyle(
          color: scheme.onSecondaryContainer.withValues(alpha: 0.8),
          fontSize: 10,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: field.width - 20);
    fieldSub.paint(
      canvas,
      Offset(field.left + 10, field.top + 32),
    );

    // DebugCreator payload
    final payload = Rect.fromLTWH(
      outer.left + 24,
      field.bottom + 16,
      outer.width - 48,
      90,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(payload, const Radius.circular(8)),
      Paint()..color = scheme.primaryContainer,
    );
    final payloadLabel = TextPainter(
      text: TextSpan(
        text: 'DebugCreator',
        style: TextStyle(
          color: scheme.onPrimaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    payloadLabel.paint(
      canvas,
      Offset(payload.left + 10, payload.top + 8),
    );

    // Element / Widget sub-boxes
    final elemBox = Rect.fromLTWH(
      payload.left + 12,
      payload.top + 32,
      (payload.width - 36) / 2,
      48,
    );
    final widgetBox = Rect.fromLTWH(
      elemBox.right + 12,
      payload.top + 32,
      (payload.width - 36) / 2,
      48,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(elemBox, const Radius.circular(6)),
      Paint()..color = scheme.surface,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(widgetBox, const Radius.circular(6)),
      Paint()..color = scheme.surface,
    );

    void drawLabel(Rect r, String h, String sub) {
      final hp = TextPainter(
        text: TextSpan(
          text: h,
          style: TextStyle(
            color: scheme.primary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      hp.paint(canvas, Offset(r.left + 8, r.top + 6));
      final sp = TextPainter(
        text: TextSpan(
          text: sub,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
      )..layout(maxWidth: r.width - 16);
      sp.paint(canvas, Offset(r.left + 8, r.top + 22));
    }

    drawLabel(elemBox, 'element', 'RenderObjectElement');
    drawLabel(widgetBox, 'widget', 'element.widget (implicit)');

    // Arrow from field -> payload
    final paint = Paint()
      ..color = scheme.outline
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(field.center.dx, field.bottom),
      Offset(payload.center.dx, payload.top),
      paint,
    );
    final arrow = Path()
      ..moveTo(payload.center.dx, payload.top)
      ..lineTo(payload.center.dx - 5, payload.top - 7)
      ..lineTo(payload.center.dx + 5, payload.top - 7)
      ..close();
    canvas.drawPath(arrow, Paint()..color = scheme.outline);
  }

  @override
  bool shouldRepaint(covariant _StructPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 4 — ERROR MAPPING (with vs without)
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorMapTab extends StatelessWidget {
  const _ErrorMapTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Error output: with vs without debugCreator',
            subtitle: 'Toggle to see how the node transforms the message',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _showWithCreator,
                  builder: (context, withCreator, _) {
                    return Row(
                      children: [
                        _ModeButton(
                          label: 'With debugCreator',
                          selected: withCreator,
                          onTap: () => _showWithCreator.value = true,
                          icon: Icons.check_circle_outline,
                        ),
                        const SizedBox(width: 8),
                        _ModeButton(
                          label: 'Without debugCreator',
                          selected: !withCreator,
                          onTap: () => _showWithCreator.value = false,
                          icon: Icons.highlight_off,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<bool>(
                  valueListenable: _showWithCreator,
                  builder: (context, withCreator, _) {
                    return _ErrorPanel(withCreator: withCreator);
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'What the node adds to the report',
            subtitle: 'A short inventory of diagnostics generated by the node',
            child: Column(
              children: const [
                _BulletPoint(
                  '"The relevant error-causing widget was:" block with the '
                  'widget type name and source file:line.',
                ),
                _BulletPoint(
                  'Creation-stack entry (when widget inspector is active) '
                  'that traces the chain of calls that created the widget.',
                ),
                _BulletPoint(
                  'Owner-chain text linking the rendering error to the '
                  'user-defined widget that contains the render object.',
                ),
                _BulletPoint(
                  'DevTools deep-link enabling "jump-to-source" from an '
                  'error in the inspector UI.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Implementation note',
            subtitle: 'How the formatter picks up DiagnosticsDebugCreator',
            child: const _CodeSnippet(
              label: 'framework pseudo-flow',
              'FlutterError.reportError(FlutterErrorDetails d) {\n'
              '  final properties = d.informationCollector?.call() ?? const [];\n'
              '  // ↓ This is the transform that unpacks DebugCreator nodes.\n'
              '  final expanded = debugTransformDebugCreator(\n'
              '    [\n'
              '      ErrorDescription(d.exceptionAsString()),\n'
              '      ...properties,\n'
              '      if (d.context is RenderObject)\n'
              '        (d.context as RenderObject).toDiagnosticsNode(),\n'
              '    ],\n'
              '  );\n'
              '  for (final p in expanded) debugPrint(p.toString());\n'
              '}',
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? cs.primary : cs.outlineVariant,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: selected ? cs.primary : cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.withCreator});

  final bool withCreator;

  static const String _common =
      '══╡ EXCEPTION CAUGHT BY RENDERING LIBRARY ╞══════════════\n'
      'The following assertion was thrown during layout():\n'
      'A RenderFlex overflowed by 182 pixels on the right.\n\n'
      'The overflowing RenderFlex has an orientation of Axis.horizontal.\n'
      'The edge of the RenderFlex that is overflowing has been marked\n'
      'in the rendering with a yellow and black striped pattern.\n';

  static const String _withBlock =
      '\nThe relevant error-causing widget was:\n'
      '  Row  file:///lib/ui/profile_card.dart:42:18\n'
      '\n'
      'When the exception was thrown, this was the stack:\n'
      '#0   RenderFlex.performLayout (package:flutter/src/rendering/flex.dart:934)\n'
      '#1   RenderObject.layout (package:flutter/src/rendering/object.dart:2214)\n'
      '…\n';

  static const String _withoutBlock =
      '\n(Without debugCreator the error ends here — the user now has to\n'
      'guess which widget in their source produced this RenderFlex.)\n';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final body = _common + (withCreator ? _withBlock : _withoutBlock);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: withCreator
            ? cs.errorContainer.withValues(alpha: 0.30)
            : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: withCreator ? cs.error : cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                withCreator
                    ? Icons.auto_fix_high_outlined
                    : Icons.question_mark_outlined,
                size: 18,
                color: withCreator ? cs.error : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                withCreator
                    ? 'Console output WITH debugCreator'
                    : 'Console output WITHOUT debugCreator',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: withCreator ? cs.error : cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SelectableText(
            body,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 5 — HOW POPULATED
// ─────────────────────────────────────────────────────────────────────────────

class _HowPopulatedTab extends StatelessWidget {
  const _HowPopulatedTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'How the framework populates debugCreator',
            subtitle:
                'RenderObjectElement does the wiring during mount / update',
            child: Column(
              children: const [
                _BulletPoint(
                  'Every RenderObjectElement subclass (SingleChildRenderObjectElement, '
                  'MultiChildRenderObjectElement, LeafRenderObjectElement, …) '
                  'assigns `renderObject.debugCreator = DebugCreator(this)`.',
                ),
                _BulletPoint(
                  'The assignment is gated by an `assert` block so it is '
                  'removed entirely in release / profile builds.',
                ),
                _BulletPoint(
                  'Because DebugCreator holds the Element (not the Widget), '
                  'it stays up-to-date if the element is rebuilt with a new '
                  'Widget — `element.widget` is read lazily.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Canonical framework pattern',
            subtitle: 'From RenderObjectElement.mount',
            child: const _CodeSnippet(
              label: 'package:flutter/src/widgets/framework.dart',
              '@override\n'
              'void mount(Element? parent, Object? newSlot) {\n'
              '  super.mount(parent, newSlot);\n'
              '  _renderObject = (widget as RenderObjectWidget).createRenderObject(this);\n'
              '  assert(() {\n'
              '    // Attach the back-reference. This is the *only* place\n'
              '    // DiagnosticsDebugCreator ultimately comes from.\n'
              '    _renderObject!.debugCreator = DebugCreator(this);\n'
              '    return true;\n'
              '  }());\n'
              '  attachRenderObject(newSlot);\n'
              '  rebuild(force: true);\n'
              '}',
            ),
          ),
          _SectionCard(
            title: 'Diagnostics pickup on the rendering side',
            subtitle: 'RenderObject.debugFillProperties',
            child: const _CodeSnippet(
              label: 'package:flutter/src/rendering/object.dart',
              '@override\n'
              'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
              '  super.debugFillProperties(properties);\n'
              '  properties.add(\n'
              '    DiagnosticsProperty<Object?>(\n'
              '      \'creator\',\n'
              '      debugCreator,\n'
              '      defaultValue: null,\n'
              '      level: DiagnosticLevel.debug,\n'
              '    ),\n'
              '  );\n'
              '  // …plus size, constraints, parentData, etc.\n'
              '}',
            ),
          ),
          _SectionCard(
            title: 'A minimal custom RenderObjectWidget',
            subtitle: 'debugCreator is wired automatically — you do nothing',
            child: const _CodeSnippet(
              label: 'user code',
              'class TiltBox extends SingleChildRenderObjectWidget {\n'
              '  const TiltBox({super.key, super.child, required this.angle});\n'
              '  final double angle;\n'
              '\n'
              '  @override\n'
              '  RenderTiltBox createRenderObject(BuildContext context) =>\n'
              '      RenderTiltBox(angle: angle);\n'
              '\n'
              '  // No code to set debugCreator — the framework does it for you\n'
              '  // during SingleChildRenderObjectElement.mount().\n'
              '}',
            ),
          ),
          _SectionCard(
            title: 'Anti-pattern — do not set it manually',
            subtitle: 'You almost never need to touch debugCreator yourself',
            child: Column(
              children: const [
                _BulletPoint(
                  'If you create a RenderObject outside of the widget tree '
                  '(e.g. in a custom layout adapter), you can set '
                  '`renderObject.debugCreator = DebugCreator(elementRef)` '
                  'manually — but only behind an assert.',
                  leading: Icons.warning_amber_outlined,
                ),
                _BulletPoint(
                  'Storing a string or a Widget directly instead of a '
                  'DebugCreator breaks `debugTransformDebugCreator` and '
                  'degrades the error-causing-widget block to an opaque '
                  '"creator: <your object>" line.',
                  leading: Icons.warning_amber_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 6 — DEBUG-ONLY NATURE
// ─────────────────────────────────────────────────────────────────────────────

class _DebugOnlyTab extends StatelessWidget {
  const _DebugOnlyTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Debug mode vs release mode',
            subtitle:
                'DiagnosticsDebugCreator is stripped from production binaries',
            child: Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _debugModeToggle,
                  builder: (context, isDebug, _) {
                    return Row(
                      children: [
                        _ModeButton(
                          label: 'kDebugMode == true',
                          selected: isDebug,
                          onTap: () => _debugModeToggle.value = true,
                          icon: Icons.bug_report_outlined,
                        ),
                        const SizedBox(width: 8),
                        _ModeButton(
                          label: 'kDebugMode == false',
                          selected: !isDebug,
                          onTap: () => _debugModeToggle.value = false,
                          icon: Icons.rocket_launch_outlined,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<bool>(
                  valueListenable: _debugModeToggle,
                  builder: (context, isDebug, _) {
                    return _DebugModePanel(isDebug: isDebug);
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Why strip it at all?',
            subtitle: 'Cost / benefit',
            child: Column(
              children: const [
                _BulletPoint(
                  'Extra object per RenderObject — allocation pressure.',
                ),
                _BulletPoint(
                  'Retains Element references, which would pin widgets '
                  'alive across rebuilds in release.',
                ),
                _BulletPoint(
                  'Creation-stack capture is O(depth) and uses the '
                  'widget-inspector, which is only loaded in debug builds.',
                ),
                _BulletPoint(
                  'Release users do not see "error-causing widget" blocks; '
                  'they see sanitised error messages designed for users, '
                  'not developers.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Test surface',
            subtitle: 'Running in a widget-test environment',
            child: Column(
              children: const [
                _PropRow('kDebugMode',           'true (asserts are enabled)'),
                _PropRow('debugCreator present', 'yes — every RenderObject'),
                _PropRow('debugTransformDebugCreator', 'wired via WidgetsApp'),
                _PropRow('widget-inspector',    'available, captures stacks'),
                _PropRow('error pipeline',      'renders "error-causing widget"'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DebugModePanel extends StatelessWidget {
  const _DebugModePanel({required this.isDebug});

  final bool isDebug;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final title = isDebug ? 'DEBUG build' : 'RELEASE build';
    final effects = isDebug
        ? const <(IconData, String)>[
            (Icons.check_circle, 'Asserts enabled — DebugCreator attached'),
            (Icons.check_circle, 'FlutterError.reportError expands creator'),
            (Icons.check_circle, 'Creation stack captured by inspector'),
            (Icons.check_circle, 'DevTools shows widget source mapping'),
          ]
        : const <(IconData, String)>[
            (Icons.remove_circle_outline, 'Asserts stripped — DebugCreator never set'),
            (Icons.remove_circle_outline, 'debugTransformDebugCreator is a no-op'),
            (Icons.remove_circle_outline, 'No creation-stack captured'),
            (Icons.remove_circle_outline, 'Errors surface only RenderObject types'),
          ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (isDebug ? cs.primaryContainer : cs.surfaceContainerHighest)
            .withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDebug ? cs.primary : cs.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDebug ? Icons.bug_report : Icons.flight_takeoff,
                color: isDebug ? cs.primary : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final (icon, text) in effects)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2, right: 8),
                    child: Icon(
                      icon,
                      size: 16,
                      color: isDebug ? cs.primary : cs.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodySmall,
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

// ─────────────────────────────────────────────────────────────────────────────
// TAB 7 — USE CASES
// ─────────────────────────────────────────────────────────────────────────────

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  static const List<_UseCase> _cases = [
    _UseCase(
      icon: Icons.arrow_forward_ios,
      title: 'Row overflow',
      short: 'Child wider than available width',
      rendering: 'RenderFlex overflowed by 182 pixels on the right',
      widgetLine: 'Row   file:///lib/cards/profile.dart:42:18',
    ),
    _UseCase(
      icon: Icons.straighten_outlined,
      title: 'Constraint violation',
      short: 'Unbounded height in a Column inside a ListView',
      rendering: 'RenderBox was not laid out: RenderFlex#…',
      widgetLine: 'Column  file:///lib/ui/feed.dart:118:6',
    ),
    _UseCase(
      icon: Icons.swap_horiz_outlined,
      title: 'Parent-data mismatch',
      short: 'Flexible under a non-flex parent',
      rendering: 'Incorrect ParentData type in Flex',
      widgetLine: 'Flexible  file:///lib/ui/bar.dart:27:11',
    ),
    _UseCase(
      icon: Icons.wallpaper_outlined,
      title: 'Nested Scaffold',
      short: 'Scaffold inside another Scaffold body',
      rendering: 'Material widget not found on ancestor chain',
      widgetLine: 'Scaffold  file:///lib/screens/settings.dart:61:14',
    ),
    _UseCase(
      icon: Icons.sort_by_alpha,
      title: 'Missing Directionality',
      short: 'Text inside Stack without Directionality',
      rendering: 'No Directionality widget found',
      widgetLine: 'Text  file:///lib/overlays/tooltip.dart:33:9',
    ),
    _UseCase(
      icon: Icons.anchor_outlined,
      title: 'Ambiguous anchor',
      short: 'CompositedTransformFollower without matching target',
      rendering: 'LayerLink has no leader',
      widgetLine: 'CompositedTransformFollower  file:///lib/popover.dart:17:20',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Realistic errors where DiagnosticsDebugCreator shines',
            subtitle: 'Pick a scenario to see the extracted widget line',
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _useCase,
                  builder: (context, pick, _) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (int i = 0; i < _cases.length; i++)
                          _UseCaseChip(
                            index: i,
                            selected: pick == i,
                            data: _cases[i],
                            onTap: () => _useCase.value = i,
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<int>(
                  valueListenable: _useCase,
                  builder: (context, pick, _) {
                    return _UseCaseDetail(data: _cases[pick]);
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Why these six?',
            subtitle: 'They all emit errors from the rendering library',
            child: Column(
              children: const [
                _BulletPoint(
                  'Each one originates deep inside a RenderObject method '
                  '(performLayout, paint, hitTest, or parentData '
                  'validation) — places where the stack-trace alone would '
                  'not tell you which widget is to blame.',
                ),
                _BulletPoint(
                  'DiagnosticsDebugCreator guarantees the "The relevant '
                  'error-causing widget was: …" block lands in your '
                  'console / DevTools with a file:line reference.',
                ),
                _BulletPoint(
                  'Without it, you would face a RenderFlex / RenderBox / '
                  'CompositedTransformLayer naked error — and have to '
                  'instrument your code to hunt the culprit down.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCase {
  const _UseCase({
    required this.icon,
    required this.title,
    required this.short,
    required this.rendering,
    required this.widgetLine,
  });
  final IconData icon;
  final String title;
  final String short;
  final String rendering;
  final String widgetLine;
}

class _UseCaseChip extends StatelessWidget {
  const _UseCaseChip({
    required this.index,
    required this.selected,
    required this.data,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final _UseCase data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              data.icon,
              size: 16,
              color: selected ? cs.primary : cs.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              data.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selected
                    ? cs.onPrimaryContainer
                    : cs.onSurfaceVariant,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UseCaseDetail extends StatelessWidget {
  const _UseCaseDetail({required this.data});

  final _UseCase data;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.errorContainer.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.error),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(data.icon, color: cs.error),
              const SizedBox(width: 8),
              Text(
                data.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            data.short,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Text(
            'Rendering-library error line',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            data.rendering,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Expanded by DiagnosticsDebugCreator',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: SelectableText(
              'The relevant error-causing widget was:\n  ${data.widgetLine}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 8 — COMPARE
// ─────────────────────────────────────────────────────────────────────────────

class _CompareTab extends StatelessWidget {
  const _CompareTab();

  static const List<_CompareRow> _rows = [
    _CompareRow(
      type: 'DiagnosticsDebugCreator',
      role: 'DiagnosticsNode wrapper',
      where: 'Rendering-layer error pipeline',
      holds: 'DebugCreator payload, hidden name',
      stripped: 'Yes (asserts-only)',
    ),
    _CompareRow(
      type: 'DebugCreator',
      role: 'Plain payload class',
      where: 'RenderObject.debugCreator field',
      holds: 'Element (therefore widget)',
      stripped: 'Yes (asserts-only)',
    ),
    _CompareRow(
      type: 'DiagnosticsNode',
      role: 'Abstract base of diagnostics entries',
      where: 'Everywhere (widgets, render, painting, gestures)',
      holds: 'value, name, style, description …',
      stripped: 'No — release-safe',
    ),
    _CompareRow(
      type: 'FlutterErrorDetails',
      role: 'Envelope for the whole error report',
      where: 'FlutterError.reportError',
      holds: 'exception, library, context, stack, informationCollector',
      stripped: 'No — release-safe, slimmer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Sibling concepts — side-by-side',
            subtitle:
                'Easy to mix these up; each has a distinct role',
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _comparisonPick,
                  builder: (context, pick, _) {
                    return Column(
                      children: [
                        for (int i = 0; i < _rows.length; i++)
                          _CompareRowTile(
                            row: _rows[i],
                            selected: pick == i,
                            onTap: () => _comparisonPick.value = i,
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<int>(
                  valueListenable: _comparisonPick,
                  builder: (context, pick, _) {
                    return _CompareDetail(row: _rows[pick]);
                  },
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Mental-model shortcut',
            subtitle: 'One sentence per concept',
            child: Column(
              children: const [
                _BulletPoint(
                  '“DebugCreator is the fact, DiagnosticsDebugCreator is '
                  'the message, DiagnosticsNode is the medium, '
                  'FlutterErrorDetails is the envelope.”',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareRow {
  const _CompareRow({
    required this.type,
    required this.role,
    required this.where,
    required this.holds,
    required this.stripped,
  });

  final String type;
  final String role;
  final String where;
  final String holds;
  final String stripped;
}

class _CompareRowTile extends StatelessWidget {
  const _CompareRowTile({
    required this.row,
    required this.selected,
    required this.onTap,
  });

  final _CompareRow row;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              size: 18,
              color: selected ? cs.primary : cs.onSurfaceVariant,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row.type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? cs.onPrimaryContainer
                          : cs.onSurface,
                    ),
                  ),
                  Text(
                    row.role,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              row.stripped,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: row.stripped.startsWith('Yes') ? cs.error : cs.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompareDetail extends StatelessWidget {
  const _CompareDetail({required this.row});

  final _CompareRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          _PropRow('type',            row.type,     highlight: true),
          _PropRow('role',            row.role),
          _PropRow('where it lives',  row.where),
          _PropRow('holds / payload', row.holds),
          _PropRow('release-strip',   row.stripped),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 9 — CHEATSHEET (pitfalls + API)
// ─────────────────────────────────────────────────────────────────────────────

class _CheatsheetTab extends StatelessWidget {
  const _CheatsheetTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionCard(
            title: 'Pitfalls',
            subtitle: 'Three common mistakes',
            child: Column(
              children: const [
                _PitfallTile(
                  icon: Icons.do_not_disturb_on_outlined,
                  title: 'Assuming it works in release',
                  body: 'DiagnosticsDebugCreator is wrapped in an '
                      'assert — release builds will never populate it. Do '
                      'not rely on it for crash analytics in production; '
                      'use Sentry / Crashlytics + your own widget labels.',
                ),
                _PitfallTile(
                  icon: Icons.report_outlined,
                  title: 'Overwriting debugCreator on a render object',
                  body: 'Setting `renderObject.debugCreator = anything` '
                      'outside an assert compiles but breaks '
                      'debugTransformDebugCreator. Worse, setting it to a '
                      'String or Widget hides the element reference.',
                ),
                _PitfallTile(
                  icon: Icons.memory_outlined,
                  title: 'Holding DebugCreator across rebuilds',
                  body: 'DebugCreator stores an Element. If you cache it '
                      'in a Map or a long-lived list, you keep dead '
                      'elements alive. Always re-read from '
                      '`renderObject.debugCreator` at the moment you need it.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'API cheat-sheet',
            subtitle: 'Key members you will actually touch',
            child: Column(
              children: const [
                _PropRow('RenderObject.debugCreator',
                    'Object? — the DebugCreator payload set by the framework'),
                _PropRow('DebugCreator(this)',
                    'Constructor used inside RenderObjectElement.mount'),
                _PropRow('DebugCreator.element',
                    'Element — use element.widget / runtimeType for messages'),
                _PropRow('DiagnosticsDebugCreator(value)',
                    'DiagnosticsNode wrapper, usually never built by you'),
                _PropRow('debugTransformDebugCreator',
                    'List<DiagnosticsNode> → list with widget-aware entries'),
                _PropRow('FlutterErrorDetails.context',
                    'Typically the RenderObject that hosts debugCreator'),
                _PropRow('WidgetsBinding.instance.debugCreator',
                    'Not a real field — debugCreator lives per RenderObject'),
                _PropRow('kDebugMode',
                    'Compile-time constant; false strips all DebugCreator wiring'),
              ],
            ),
          ),
          _SectionCard(
            title: 'Idiomatic one-liners',
            subtitle: 'Copy-pasteable patterns',
            child: const _CodeSnippet(
              label: 'patterns',
              '// 1. Read the creating widget from a RenderObject (in tests)\n'
              'final creator = renderBox.debugCreator;\n'
              'assert(creator is DebugCreator);\n'
              'final el = (creator as DebugCreator).element;\n'
              'print(el.widget.runtimeType); // e.g. Row\n'
              '\n'
              '// 2. Guard for release — never dereference in a prod path\n'
              'if (kDebugMode) {\n'
              '  final c = renderBox.debugCreator;\n'
              '  if (c is DebugCreator) handleCreator(c);\n'
              '}\n'
              '\n'
              '// 3. Attach creator info to a custom RenderObject you built\n'
              '//    outside of the widget tree (e.g. in a shell app).\n'
              'assert(() {\n'
              '  myRenderObject.debugCreator = DebugCreator(someElement);\n'
              '  return true;\n'
              '}());',
            ),
          ),
          _SectionCard(
            title: 'When to look this up',
            subtitle: 'Signals that DiagnosticsDebugCreator is the lead',
            child: Column(
              children: const [
                _BulletPoint(
                  'Console shows "The relevant error-causing widget was:" '
                  '— you are already reading DiagnosticsDebugCreator output.',
                ),
                _BulletPoint(
                  'Crash bug that happens in release only; debug builds '
                  'print helpful widget info, release does not — expected '
                  'behaviour, not a bug.',
                ),
                _BulletPoint(
                  'Writing a bespoke RenderObject that lives outside the '
                  'widget tree and want inspector support.',
                ),
                _BulletPoint(
                  'Writing a devtool / golden-test helper that needs to '
                  'map a RenderObject back to a widget.',
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Further reading',
            subtitle: 'Related files in the Flutter repo',
            child: Column(
              children: const [
                _PropRow(
                  'widget_inspector.dart',
                  'debugTransformDebugCreator + _parseDiagnosticsTreeNew',
                ),
                _PropRow(
                  'framework.dart',
                  'RenderObjectElement.mount where debugCreator is set',
                ),
                _PropRow(
                  'object.dart',
                  'RenderObject.debugCreator field + debugFillProperties',
                ),
                _PropRow(
                  'diagnostics.dart',
                  'DiagnosticsNode / DiagnosticsProperty hierarchy',
                ),
                _PropRow(
                  'assertions.dart',
                  'FlutterError / FlutterErrorDetails envelope',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.errorContainer.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.error),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: cs.error.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 18, color: cs.error),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
