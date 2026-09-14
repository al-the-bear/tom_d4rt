// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// RenderAnimatedOpacityMixin<T extends RenderObject> — Deep Demo
// =============================================================================
//
// This file is a hand-authored, harness-safe deep demo of the rendering layer
// mixin RenderAnimatedOpacityMixin<T>. The mixin lives privately in the Flutter
// rendering layer and is the engine behind two user-facing widgets:
//
//   * AnimatedOpacity        (RenderObject: RenderAnimatedOpacity)
//   * SliverAnimatedOpacity  (RenderObject: RenderSliverAnimatedOpacity)
//
// Both render objects mix in RenderAnimatedOpacityMixin to share a common
// implementation of the four "opacity-from-an-Animation" duties:
//
//   1. Hold a reference to an Animation<double> ('opacity').
//   2. Add/remove the listener on the animation when attached/detached, so
//      the render object repaints whenever the animation ticks.
//   3. Push an OpacityLayer when painting (compositing-friendly path), with
//      the ability to short-circuit at alpha 0 (skip painting children) and
//      alpha 255 (paint children directly).
//   4. Honour the alwaysIncludeSemantics flag so that fully-transparent
//      subtrees can still expose semantics nodes when the developer asks.
//
// The mixin's API is internal, but its observable behaviour is fully exposed
// through AnimatedOpacity and SliverAnimatedOpacity, and that is what this
// demo exercises.
//
// Harness contract:
//   * Single dynamic build(BuildContext) entry that returns a MaterialApp.
//   * No main(), no runApp(), no testWidgets().
//   * Only material.dart is imported.
//   * dart analyze must be clean.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== RenderAnimatedOpacityMixin Deep Demo ===');
  print('Subject: rendering/animated_opacity.dart -> RenderAnimatedOpacityMixin<T>');
  print('Surface APIs exercised: AnimatedOpacity, SliverAnimatedOpacity');
  print('Sections: 16 — see overview comment for details.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderAnimatedOpacityMixin Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderAnimatedOpacityMixin — Deep Demo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _SectionOneHeroIntro(),
              SizedBox(height: 24),
              _SectionTwoBasicAnimatedOpacity(),
              SizedBox(height: 24),
              _SectionThreeCurveGallery(),
              SizedBox(height: 24),
              _SectionFourDurationSweep(),
              SizedBox(height: 24),
              _SectionFiveAlwaysIncludeSemantics(),
              SizedBox(height: 24),
              _SectionSixStagger(),
              SizedBox(height: 24),
              _SectionSevenSliverAnimatedOpacity(),
              SizedBox(height: 24),
              _SectionEightCompositingBenefit(),
              SizedBox(height: 24),
              _SectionNineListenerForwarding(),
              SizedBox(height: 24),
              _SectionTenCrossfade(),
              SizedBox(height: 24),
              _SectionElevenHeroGallery(),
              SizedBox(height: 24),
              _SectionTwelveOpacityScaleCombo(),
              SizedBox(height: 24),
              _SectionThirteenPerformanceNote(),
              SizedBox(height: 24),
              _SectionFourteenDecisionCard(),
              SizedBox(height: 24),
              _SectionFifteenReferenceTable(),
              SizedBox(height: 24),
              _SectionSixteenFooter(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Shared building blocks
// =============================================================================

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: accent.withOpacity(0.45), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[accent.withOpacity(0.85), accent.withOpacity(0.55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: accent,
                  child: Text(
                    '$index',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}

class _Explainer extends StatelessWidget {
  const _Explainer(this.text, {this.bold = false});

  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.5,
          height: 1.42,
          color: Colors.black87,
          fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label, {required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 11),
      ),
    );
  }
}

// =============================================================================
// SECTION 1 — Hero Intro
// =============================================================================

class _SectionOneHeroIntro extends StatelessWidget {
  const _SectionOneHeroIntro();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF1A237E);
    return _SectionShell(
      index: 1,
      title: 'Hero Intro — From Opacity to Animated Opacity',
      subtitle: 'Why a render-mixin exists and what it really does',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explainer(
                'Opacity in Flutter is conceptually simple — multiply the alpha '
                'channel of a subtree by some value in [0..1]. Implementing it '
                'efficiently is harder. The straight Opacity widget pushes an '
                'OpacityLayer every paint, which forces the engine to render its '
                'subtree into a separate offscreen buffer and then blit it with '
                'the chosen alpha.',
              ),
              const _Explainer(
                'AnimatedOpacity wraps that same compositing pattern, but the '
                'opacity is not a scalar set imperatively — it is driven by an '
                'Animation<double>. The render object listens to the animation '
                'and only marks itself for repaint when the animation ticks.',
              ),
              const _Explainer(
                'RenderAnimatedOpacityMixin<T extends RenderObject> is the '
                'rendering-layer abstraction shared by RenderAnimatedOpacity '
                '(box-protocol) and RenderSliverAnimatedOpacity (sliver-protocol). '
                'It owns four duties:',
                bold: true,
              ),
              const _Explainer('  1. hold an Animation<double> opacity reference;'),
              const _Explainer('  2. addListener / removeListener on attach/detach;'),
              const _Explainer('  3. push an OpacityLayer in paint(), short-circuiting at 0 and 255;'),
              const _Explainer('  4. honour alwaysIncludeSemantics for transparent subtrees.'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const <Widget>[
                  _Tag('Animation<double>', color: Color(0xFF1A237E)),
                  _Tag('OpacityLayer', color: Color(0xFF283593)),
                  _Tag('alwaysIncludeSemantics', color: Color(0xFF303F9F)),
                  _Tag('addListener / removeListener', color: Color(0xFF3949AB)),
                  _Tag('alpha 0 / 255 short-circuit', color: Color(0xFF5C6BC0)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigo.shade50,
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: CustomPaint(
                  painter: _ArchitectureDiagramPainter(),
                  size: Size.infinite,
                ),
              ),
              const SizedBox(height: 12),
              const _Explainer(
                'Diagram: AnimatedOpacity (widget) -> _AnimatedOpacityState (element) '
                '-> RenderAnimatedOpacity (render) -> RenderAnimatedOpacityMixin '
                '(behaviour) -> OpacityLayer (engine). The animation lives on the '
                'state, but its current value is read inside the render object '
                'every paint.',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ArchitectureDiagramPainter extends CustomPainter {
  _ArchitectureDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFF1A237E);
    final Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = const Color(0xFF3949AB);

    final List<_Node> nodes = <_Node>[
      _Node('Widget\nAnimatedOpacity', const Color(0xFFE8EAF6), 0.05, 0.10),
      _Node('Element\n_AnimatedOpacityState', const Color(0xFFC5CAE9), 0.05, 0.40),
      _Node('Render\nRenderAnimatedOpacity', const Color(0xFF9FA8DA), 0.05, 0.70),
      _Node('Mixin\nRenderAnimatedOpacityMixin<T>', const Color(0xFF7986CB), 0.55, 0.10),
      _Node('Listener\nAnimation<double>', const Color(0xFF5C6BC0), 0.55, 0.40),
      _Node('Engine\nOpacityLayer', const Color(0xFF3F51B5), 0.55, 0.70),
    ];

    final List<Rect> rects = <Rect>[];
    for (final _Node node in nodes) {
      final Rect rect = Rect.fromLTWH(
        node.x * size.width + 8,
        node.y * size.height + 8,
        size.width * 0.40 - 16,
        size.height * 0.22,
      );
      rects.add(rect);
      boxPaint.color = node.color;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), boxPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), borderPaint);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: node.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: rect.width - 8);
      tp.paint(
        canvas,
        Offset(
          rect.left + (rect.width - tp.width) / 2,
          rect.top + (rect.height - tp.height) / 2,
        ),
      );
    }

    void arrow(int from, int to) {
      final Rect a = rects[from];
      final Rect b = rects[to];
      final Offset start = Offset(a.right, a.center.dy);
      final Offset end = Offset(b.left, b.center.dy);
      canvas.drawLine(start, end, linePaint);
      // arrow head
      final Path head = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(end.dx - 6, end.dy - 4)
        ..lineTo(end.dx - 6, end.dy + 4)
        ..close();
      canvas.drawPath(head, Paint()..color = const Color(0xFF3949AB));
    }

    void arrowDown(int from, int to) {
      final Rect a = rects[from];
      final Rect b = rects[to];
      final Offset start = Offset(a.center.dx, a.bottom);
      final Offset end = Offset(b.center.dx, b.top);
      canvas.drawLine(start, end, linePaint);
      final Path head = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(end.dx - 4, end.dy - 6)
        ..lineTo(end.dx + 4, end.dy - 6)
        ..close();
      canvas.drawPath(head, Paint()..color = const Color(0xFF3949AB));
    }

    arrowDown(0, 1);
    arrowDown(1, 2);
    arrowDown(3, 4);
    arrowDown(4, 5);
    arrow(0, 3);
    arrow(2, 5);
  }

  @override
  bool shouldRepaint(covariant _ArchitectureDiagramPainter oldDelegate) => false;
}

class _Node {
  const _Node(this.label, this.color, this.x, this.y);
  final String label;
  final Color color;
  final double x;
  final double y;
}

// =============================================================================
// SECTION 2 — Basic AnimatedOpacity
// =============================================================================

class _SectionTwoBasicAnimatedOpacity extends StatelessWidget {
  const _SectionTwoBasicAnimatedOpacity();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF00695C);
    return _SectionShell(
      index: 2,
      title: 'Basic AnimatedOpacity',
      subtitle: 'A Card that fades 0 -> 1 with duration + curve',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          bool visible = true;
          Duration duration = const Duration(milliseconds: 600);
          Curve curve = Curves.easeInOut;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'AnimatedOpacity is the implicit-animation entry point. '
                    'When the opacity argument changes, the framework lerps the '
                    'value over duration using the specified curve. The render '
                    'object created by the widget mixes in '
                    'RenderAnimatedOpacityMixin, which is what actually pushes '
                    'an OpacityLayer with the current animated alpha.',
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: AnimatedOpacity(
                      opacity: visible ? 1.0 : 0.0,
                      duration: duration,
                      curve: curve,
                      child: Container(
                        width: 220,
                        height: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: <Color>[Color(0xFF00695C), Color(0xFF26A69A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(blurRadius: 6, color: Colors.black26),
                          ],
                        ),
                        child: const Text(
                          'I fade with the mixin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      const Text('Visible'),
                      Switch(
                        value: visible,
                        onChanged: (bool v) => setInner(() => visible = v),
                      ),
                      const SizedBox(width: 16),
                      const Text('Curve:'),
                      const SizedBox(width: 8),
                      DropdownButton<Curve>(
                        value: curve,
                        items: const <DropdownMenuItem<Curve>>[
                          DropdownMenuItem<Curve>(value: Curves.linear, child: Text('linear')),
                          DropdownMenuItem<Curve>(value: Curves.easeIn, child: Text('easeIn')),
                          DropdownMenuItem<Curve>(value: Curves.easeOut, child: Text('easeOut')),
                          DropdownMenuItem<Curve>(value: Curves.easeInOut, child: Text('easeInOut')),
                          DropdownMenuItem<Curve>(value: Curves.bounceOut, child: Text('bounceOut')),
                          DropdownMenuItem<Curve>(value: Curves.elasticOut, child: Text('elasticOut')),
                        ],
                        onChanged: (Curve? c) {
                          if (c != null) setInner(() => curve = c);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Duration:'),
                      Expanded(
                        child: Slider(
                          value: duration.inMilliseconds.toDouble(),
                          min: 100,
                          max: 2000,
                          divisions: 19,
                          label: '${duration.inMilliseconds} ms',
                          onChanged: (double v) => setInner(
                            () => duration = Duration(milliseconds: v.round()),
                          ),
                        ),
                      ),
                      Text('${duration.inMilliseconds} ms'),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Curve gallery
// =============================================================================

class _SectionThreeCurveGallery extends StatelessWidget {
  const _SectionThreeCurveGallery();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF6A1B9A);
    final List<_CurveSpec> curves = <_CurveSpec>[
      const _CurveSpec('linear', Curves.linear, Color(0xFFCE93D8)),
      const _CurveSpec('easeIn', Curves.easeIn, Color(0xFFBA68C8)),
      const _CurveSpec('easeOut', Curves.easeOut, Color(0xFFAB47BC)),
      const _CurveSpec('easeInOut', Curves.easeInOut, Color(0xFF9C27B0)),
      const _CurveSpec('bounceOut', Curves.bounceOut, Color(0xFF8E24AA)),
      const _CurveSpec('elasticOut', Curves.elasticOut, Color(0xFF7B1FA2)),
    ];

    return _SectionShell(
      index: 3,
      title: 'Curve Gallery',
      subtitle: 'Six AnimatedOpacity tiles, six curves, one toggle',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          bool visible = true;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'The curve passed to AnimatedOpacity does not change what '
                    'the render mixin does at all. The mixin only knows about '
                    'Animation<double>. The widget builds a CurvedAnimation that '
                    'wraps an internal AnimationController, and the render '
                    'object reads .value each frame.',
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: curves
                        .map((_CurveSpec c) => AnimatedOpacity(
                              opacity: visible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 1200),
                              curve: c.curve,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: c.color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  c.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => setInner(() => visible = !visible),
                      icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
                      label: Text(visible ? 'Hide all' : 'Show all'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _CurveSpec {
  const _CurveSpec(this.label, this.curve, this.color);
  final String label;
  final Curve curve;
  final Color color;
}

// =============================================================================
// SECTION 4 — Duration sweep
// =============================================================================

class _SectionFourDurationSweep extends StatelessWidget {
  const _SectionFourDurationSweep();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFFC62828);
    return _SectionShell(
      index: 4,
      title: 'Duration Sweep',
      subtitle: 'A slider 100ms..3000ms drives a single AnimatedOpacity',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          double ms = 600;
          bool visible = true;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'The duration argument controls how long the underlying '
                    'AnimationController runs. Longer durations mean more frames '
                    'between alpha=0 and alpha=255, and therefore more calls '
                    'into the render object\'s paint() that go through the '
                    'OpacityLayer path. The mixin still short-circuits at the '
                    'two endpoints.',
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: GestureDetector(
                      onTap: () => setInner(() => visible = !visible),
                      child: AnimatedOpacity(
                        opacity: visible ? 1.0 : 0.05,
                        duration: Duration(milliseconds: ms.round()),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: 260,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Tap me — ${ms.round()} ms',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      const Text('100'),
                      Expanded(
                        child: Slider(
                          value: ms,
                          min: 100,
                          max: 3000,
                          divisions: 29,
                          label: '${ms.round()} ms',
                          onChanged: (double v) => setInner(() => ms = v),
                        ),
                      ),
                      const Text('3000'),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — alwaysIncludeSemantics
// =============================================================================

class _SectionFiveAlwaysIncludeSemantics extends StatelessWidget {
  const _SectionFiveAlwaysIncludeSemantics();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFFEF6C00);
    return _SectionShell(
      index: 5,
      title: 'alwaysIncludeSemantics',
      subtitle: 'Two cards: default vs alwaysIncludeSemantics: true',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          bool visible = false;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'When alpha is 0, the mixin can omit the subtree from the '
                    'semantic tree, because nothing is visible. That is correct '
                    'for decorative content — you do not want screen readers to '
                    'announce text that the user cannot see. For accessibility '
                    'features that should remain reachable (e.g. screen-reader '
                    'focusable invisible buttons), pass alwaysIncludeSemantics: '
                    'true so the render mixin keeps semantics on regardless of '
                    'the current alpha.',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AnimatedOpacity(
                          opacity: visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: _SemanticsDemoCard(
                            label: 'Default (omit when invisible)',
                            color: Colors.orange.shade400,
                            description:
                                'Hidden from a11y when alpha=0',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AnimatedOpacity(
                          opacity: visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          alwaysIncludeSemantics: true,
                          child: _SemanticsDemoCard(
                            label: 'alwaysIncludeSemantics: true',
                            color: Colors.deepOrange.shade400,
                            description:
                                'Stays in a11y tree even at alpha=0',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => setInner(() => visible = !visible),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(visible ? 'Fade out both' : 'Fade in both'),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _SemanticsDemoCard extends StatelessWidget {
  const _SemanticsDemoCard({
    required this.label,
    required this.color,
    required this.description,
  });

  final String label;
  final Color color;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          Text(
            description,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Stagger
// =============================================================================

class _SectionSixStagger extends StatelessWidget {
  const _SectionSixStagger();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF2E7D32);
    return _SectionShell(
      index: 6,
      title: 'Stagger',
      subtitle: '12 AnimatedOpacity badges fade in via Future.delayed',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          List<bool> shown = List<bool>.filled(12, false);
          bool running = false;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              Future<void> reveal() async {
                if (running) return;
                running = true;
                for (int i = 0; i < shown.length; i++) {
                  await Future<void>.delayed(const Duration(milliseconds: 80));
                  setInner(() => shown[i] = true);
                }
                running = false;
              }

              Future<void> hide() async {
                if (running) return;
                running = true;
                for (int i = shown.length - 1; i >= 0; i--) {
                  await Future<void>.delayed(const Duration(milliseconds: 60));
                  setInner(() => shown[i] = false);
                }
                running = false;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'Each badge has its own AnimatedOpacity. By staggering when '
                    'we set their opacity to 1.0, we get a ripple-like reveal. '
                    'Each individual render object schedules its own listener '
                    'and pushes its own OpacityLayer — the mixin makes sure '
                    'these are all independent.',
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: List<Widget>.generate(12, (int i) {
                      return AnimatedOpacity(
                        opacity: shown[i] ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 360),
                        curve: Curves.easeOut,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: HSLColor.fromAHSL(
                            1,
                            (i * 30) % 360,
                            0.6,
                            0.5,
                          ).toColor(),
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: reveal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Reveal'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: hide,
                        child: const Text('Hide'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — SliverAnimatedOpacity
// =============================================================================

class _SectionSevenSliverAnimatedOpacity extends StatelessWidget {
  const _SectionSevenSliverAnimatedOpacity();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF0277BD);
    return _SectionShell(
      index: 7,
      title: 'SliverAnimatedOpacity',
      subtitle: 'A SliverList wrapped in a sliver-protocol fade',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          bool show = true;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'SliverAnimatedOpacity is the sliver-protocol counterpart to '
                    'AnimatedOpacity. Its render object — '
                    'RenderSliverAnimatedOpacity — also mixes in '
                    'RenderAnimatedOpacityMixin, but parameterised with '
                    'RenderSliver instead of RenderBox. The mixin therefore '
                    'sees a sliver child, but its addListener / OpacityLayer / '
                    'short-circuit logic is identical.',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: show,
                        onChanged: (bool? v) => setInner(() => show = v ?? true),
                      ),
                      const Text('Show sliver list'),
                    ],
                  ),
                  SizedBox(
                    height: 220,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: true,
                          backgroundColor: accent,
                          title: const Text(
                            'Pinned bar (always visible)',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SliverAnimatedOpacity(
                          opacity: show ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 600),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: accent.withOpacity(0.8),
                                  foregroundColor: Colors.white,
                                  child: Text('$i'),
                                ),
                                title: Text('Sliver row #$i'),
                                subtitle:
                                    const Text('Faded together by SliverAnimatedOpacity'),
                              ),
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Compositing benefit
// =============================================================================

class _SectionEightCompositingBenefit extends StatelessWidget {
  const _SectionEightCompositingBenefit();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF4527A0);
    return _SectionShell(
      index: 8,
      title: 'Compositing Benefit',
      subtitle: 'Opacity (rebuild every frame) vs AnimatedOpacity (mixin)',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          int rebuildsLeft = 0;
          int rebuildsRight = 0;
          double leftAlpha = 1.0;
          bool rightVisible = true;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              rebuildsLeft++;
              rebuildsRight++;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'The Opacity widget is fine for static alpha values. For an '
                    'animated alpha you want AnimatedOpacity: the framework only '
                    'rebuilds the widget tree when the target value changes, '
                    'while the render object itself triggers a paint each tick '
                    'via the listener installed by the mixin. The widget tree '
                    'sees just two builds (target=1.0, target=0.0); the engine '
                    'still gets a smooth fade.',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Opacity (manual)',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Opacity(
                              opacity: leftAlpha,
                              child: Container(
                                width: 120,
                                height: 80,
                                color: Colors.purple.shade400,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Opacity',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Slider(
                              value: leftAlpha,
                              onChanged: (double v) => setInner(() => leftAlpha = v),
                            ),
                            Text('builds: $rebuildsLeft'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'AnimatedOpacity (mixin)',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            AnimatedOpacity(
                              opacity: rightVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 800),
                              child: Container(
                                width: 120,
                                height: 80,
                                color: Colors.deepPurple.shade400,
                                alignment: Alignment.center,
                                child: const Text(
                                  'AnimatedOpacity',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () =>
                                  setInner(() => rightVisible = !rightVisible),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Toggle'),
                            ),
                            Text('builds: $rebuildsRight'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 9 — Listener forwarding
// =============================================================================

class _SectionNineListenerForwarding extends StatefulWidget {
  const _SectionNineListenerForwarding();

  @override
  State<_SectionNineListenerForwarding> createState() =>
      _SectionNineListenerForwardingState();
}

class _SectionNineListenerForwardingState
    extends State<_SectionNineListenerForwarding>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _ticks = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        if (mounted) setState(() => _ticks++);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFFAD1457);
    return _SectionShell(
      index: 9,
      title: 'Listener Forwarding',
      subtitle: 'addListener / removeListener as the mixin does internally',
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _Explainer(
            'The mixin overrides attach() to call opacity.addListener(_updateOpacity), '
            'and detach() to call opacity.removeListener(_updateOpacity). '
            '_updateOpacity recomputes the alpha integer in [0..255] and, if '
            'it changed, calls markNeedsPaint() (and possibly markNeedsCompositingBitsUpdate / '
            'markNeedsSemanticsUpdate when crossing 0/255 boundaries).',
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? _) {
              final double v = _controller.value;
              return Column(
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: 0.3 + 0.7 * v,
                    duration: const Duration(milliseconds: 80),
                    child: Container(
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Animation ticks: $_ticks  (alpha base = ${(0.3 + 0.7 * v).toStringAsFixed(2)})',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => _controller.repeat(reverse: true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Repeat'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: _controller.stop,
                        child: const Text('Stop'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => _controller.reset(),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — Crossfade
// =============================================================================

class _SectionTenCrossfade extends StatelessWidget {
  const _SectionTenCrossfade();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF00838F);
    return _SectionShell(
      index: 10,
      title: 'Crossfade',
      subtitle: 'Two stacked AnimatedOpacity widgets controlled by one switch',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          bool showA = true;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'A classic crossfade: two children stacked on top of each '
                    'other, with opposite AnimatedOpacity targets. While both '
                    'are mid-fade you have two OpacityLayers active; once one '
                    'hits 0 the mixin can short-circuit and skip painting that '
                    'subtree entirely.',
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AnimatedOpacity(
                          opacity: showA ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 700),
                          child: _GradientPanel(
                            colors: const <Color>[Color(0xFF00838F), Color(0xFF26C6DA)],
                            label: 'A — ocean',
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: showA ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 700),
                          child: _GradientPanel(
                            colors: const <Color>[Color(0xFFFF7043), Color(0xFFFFCA28)],
                            label: 'B — sunset',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: SwitchListTile(
                      value: showA,
                      onChanged: (bool v) => setInner(() => showA = v),
                      title: const Text('Show layer A'),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _GradientPanel extends StatelessWidget {
  const _GradientPanel({required this.colors, required this.label});
  final List<Color> colors;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 11 — Hero gallery
// =============================================================================

class _SectionElevenHeroGallery extends StatelessWidget {
  const _SectionElevenHeroGallery();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF455A64);
    final List<_HeroSpec> specs = <_HeroSpec>[
      const _HeroSpec('Aurora', Color(0xFF00BCD4), Icons.flare),
      const _HeroSpec('Ember', Color(0xFFFF5722), Icons.local_fire_department),
      const _HeroSpec('Forest', Color(0xFF388E3C), Icons.park),
      const _HeroSpec('Lavender', Color(0xFF7B1FA2), Icons.spa),
      const _HeroSpec('Sunbeam', Color(0xFFFBC02D), Icons.wb_sunny),
      const _HeroSpec('Glacier', Color(0xFF1976D2), Icons.ac_unit),
    ];
    return _SectionShell(
      index: 11,
      title: 'Hero Gallery',
      subtitle: 'Six themed cards reveal in sequence',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          List<bool> shown = List<bool>.filled(specs.length, false);
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              Future<void> revealAll() async {
                for (int i = 0; i < shown.length; i++) {
                  await Future<void>.delayed(const Duration(milliseconds: 220));
                  setInner(() => shown[i] = true);
                }
              }

              void resetAll() => setInner(() => shown = List<bool>.filled(specs.length, false));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'Each card is its own AnimatedOpacity. Pressing "Reveal '
                    'all" walks the list with a Future.delayed, switching each '
                    'card from 0.0 to 1.0. Each AnimatedOpacity has its own '
                    'render object and its own listener — the mixin scales out '
                    'fine to many independent animations on screen.',
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.05,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: <Widget>[
                      for (int i = 0; i < specs.length; i++)
                        AnimatedOpacity(
                          opacity: shown[i] ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutCubic,
                          child: Container(
                            decoration: BoxDecoration(
                              color: specs[i].color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(specs[i].icon, color: Colors.white, size: 28),
                                Text(
                                  specs[i].label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: revealAll,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Reveal all'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: resetAll,
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _HeroSpec {
  const _HeroSpec(this.label, this.color, this.icon);
  final String label;
  final Color color;
  final IconData icon;
}

// =============================================================================
// SECTION 12 — AnimatedOpacity + AnimatedScale "pop"
// =============================================================================

class _SectionTwelveOpacityScaleCombo extends StatelessWidget {
  const _SectionTwelveOpacityScaleCombo();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFFD81B60);
    return _SectionShell(
      index: 12,
      title: 'Pop! — AnimatedOpacity + AnimatedScale',
      subtitle: 'Composing two implicit animations on the same subtree',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          bool popped = false;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'The render mixin only takes care of opacity. Scale is '
                    'handled by RenderTransform via AnimatedScale. Stacking '
                    'AnimatedOpacity outside AnimatedScale (or vice-versa) '
                    'creates a "pop" effect with negligible cost: the engine '
                    'sees one OpacityLayer and one TransformLayer.',
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: AnimatedOpacity(
                      opacity: popped ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 350),
                      child: AnimatedScale(
                        scale: popped ? 1.0 : 0.4,
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.elasticOut,
                        child: Container(
                          width: 180,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(blurRadius: 12, color: Colors.black26),
                            ],
                          ),
                          child: const Text(
                            'POP!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => setInner(() => popped = !popped),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(popped ? 'Hide' : 'Pop'),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 13 — Performance note
// =============================================================================

class _SectionThirteenPerformanceNote extends StatelessWidget {
  const _SectionThirteenPerformanceNote();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF6D4C41);
    return _SectionShell(
      index: 13,
      title: 'Performance Note — OpacityLayer Short-Circuits',
      subtitle: 'Why alpha 0 and alpha 255 are special-cased',
      accent: accent,
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          double alpha = 0.5;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setInner) {
              final int alpha255 = (alpha * 255).round();
              String shortCircuit;
              Color tagColor;
              if (alpha255 == 0) {
                shortCircuit = 'alpha == 0  ->  paint() returns immediately, child is skipped';
                tagColor = Colors.red.shade700;
              } else if (alpha255 == 255) {
                shortCircuit = 'alpha == 255 ->  paint() calls super.paint(), no OpacityLayer pushed';
                tagColor = Colors.green.shade700;
              } else {
                shortCircuit =
                    'alpha in (0,255) ->  pushOpacityLayer(offset, alpha, super.paint, oldLayer)';
                tagColor = Colors.amber.shade700;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _Explainer(
                    'RenderAnimatedOpacityMixin maintains an integer _alpha in '
                    '[0..255]. In paint(), it short-circuits both endpoints:',
                  ),
                  const _Explainer('  alpha == 0   -> draw nothing (skip subtree entirely)'),
                  const _Explainer('  alpha == 255 -> draw subtree directly without an OpacityLayer'),
                  const _Explainer('  otherwise    -> pushOpacityLayer with the current alpha'),
                  const _Explainer(
                    'The mid-range case is where the engine actually has to '
                    'allocate an offscreen, render the subtree into it, and '
                    'blend it. Avoiding that work whenever possible is why the '
                    'mixin keeps the integer alpha cached and re-checks on '
                    'every animation tick.',
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: alpha,
                    onChanged: (double v) => setInner(() => alpha = v),
                  ),
                  Text('alpha = ${alpha.toStringAsFixed(3)}  ($alpha255 / 255)'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tagColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: tagColor),
                    ),
                    child: Text(
                      shortCircuit,
                      style: TextStyle(
                        color: tagColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Opacity(
                      opacity: alpha,
                      child: Container(
                        width: 220,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'preview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 14 — Decision card
// =============================================================================

class _SectionFourteenDecisionCard extends StatelessWidget {
  const _SectionFourteenDecisionCard();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF1565C0);
    return _SectionShell(
      index: 14,
      title: 'Decision Card',
      subtitle: 'Opacity vs AnimatedOpacity vs FadeTransition vs ImageFiltered',
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _Explainer(
            'Pick the right tool. They all involve transparency, but they '
            'differ in cost, control, and what the underlying render object '
            'mixes in.',
          ),
          SizedBox(height: 8),
          _DecisionRow(
            title: 'Opacity',
            subtitle:
                'Static alpha. Use for one-shot transparency that does not change frame-by-frame.',
            color: Color(0xFF1976D2),
          ),
          _DecisionRow(
            title: 'AnimatedOpacity',
            subtitle:
                'Implicit fade between two scalar targets. Powered by RenderAnimatedOpacityMixin.',
            color: Color(0xFF388E3C),
          ),
          _DecisionRow(
            title: 'FadeTransition',
            subtitle:
                'Explicit-animation fade — you own the AnimationController. Same render-time cost.',
            color: Color(0xFF6A1B9A),
          ),
          _DecisionRow(
            title: 'ImageFiltered',
            subtitle:
                'Pixel-level filters (blur, color matrix). Heavier, used for non-alpha effects.',
            color: Color(0xFFEF6C00),
          ),
          SizedBox(height: 8),
          _Explainer(
            'Rule of thumb: any time you write '
            '`AnimatedOpacity(opacity: x ? 1.0 : 0.0, duration: …, child: …)` '
            'you are using RenderAnimatedOpacityMixin under the hood. Reach for '
            'FadeTransition when you need the same engine path but with shared '
            'controllers (e.g. crossfade synced with another transition).',
          ),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 12,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12.5, height: 1.3),
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
// SECTION 15 — Reference table
// =============================================================================

class _SectionFifteenReferenceTable extends StatelessWidget {
  const _SectionFifteenReferenceTable();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF37474F);
    return _SectionShell(
      index: 15,
      title: 'Reference Table',
      subtitle: 'Widgets that ride the mixin (or its cousins)',
      accent: accent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(accent.withOpacity(0.12)),
          columns: const <DataColumn>[
            DataColumn(label: Text('Widget')),
            DataColumn(label: Text('Render Object')),
            DataColumn(label: Text('Mixes In')),
            DataColumn(label: Text('Use case')),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('AnimatedOpacity')),
              DataCell(Text('RenderAnimatedOpacity')),
              DataCell(Text('RenderAnimatedOpacityMixin<RenderBox>')),
              DataCell(Text('Implicit box-protocol fade')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('SliverAnimatedOpacity')),
              DataCell(Text('RenderSliverAnimatedOpacity')),
              DataCell(Text('RenderAnimatedOpacityMixin<RenderSliver>')),
              DataCell(Text('Implicit sliver-protocol fade')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Opacity')),
              DataCell(Text('RenderOpacity')),
              DataCell(Text('— (raw)')),
              DataCell(Text('Static alpha')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('FadeTransition')),
              DataCell(Text('RenderAnimatedOpacity')),
              DataCell(Text('RenderAnimatedOpacityMixin<RenderBox>')),
              DataCell(Text('Explicit-animation fade')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('SliverFadeTransition')),
              DataCell(Text('RenderSliverAnimatedOpacity')),
              DataCell(Text('RenderAnimatedOpacityMixin<RenderSliver>')),
              DataCell(Text('Explicit sliver-protocol fade')),
            ]),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 16 — Footer / references
// =============================================================================

class _SectionSixteenFooter extends StatelessWidget {
  const _SectionSixteenFooter();

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFF263238);
    return _SectionShell(
      index: 16,
      title: 'References',
      subtitle: 'Where to read more',
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Explainer(
            '• flutter/lib/src/rendering/proxy_box.dart — RenderAnimatedOpacityMixin and RenderAnimatedOpacity.',
          ),
          _Explainer(
            '• flutter/lib/src/rendering/sliver_padding.dart neighbours — RenderSliverAnimatedOpacity.',
          ),
          _Explainer(
            '• flutter/lib/src/widgets/implicit_animations.dart — AnimatedOpacity widget.',
          ),
          _Explainer(
            '• flutter/lib/src/widgets/sliver.dart — SliverAnimatedOpacity widget.',
          ),
          _Explainer(
            '• flutter/lib/src/widgets/transitions.dart — FadeTransition / SliverFadeTransition.',
          ),
          SizedBox(height: 8),
          _Explainer(
            'End of deep demo. The whole file is a single static build(BuildContext) tree — '
            'no main(), no runApp(), no testWidgets(). It is meant to be evaluated by the '
            'send-AST-via-HTTP harness.',
            bold: true,
          ),
        ],
      ),
    );
  }
}
