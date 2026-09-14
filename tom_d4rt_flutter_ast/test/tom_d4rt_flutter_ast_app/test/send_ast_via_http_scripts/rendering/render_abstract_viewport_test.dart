// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// RenderAbstractViewport — Deep Demo
// ----------------------------------------------------------------------------
// `RenderAbstractViewport` is the abstract base class in flutter/rendering for
// every render object that acts as a SCROLLING VIEWPORT. The two production
// subclasses are `RenderViewport` (used by Viewport/CustomScrollView/ListView/
// GridView) and `RenderShrinkWrappingViewport` (used when a viewport must
// shrink-wrap its children). The class provides the framework-level
// machinery the rest of Flutter relies on for "scroll this thing into view":
//
//   * static RenderAbstractViewport? maybeOf(RenderObject? object)
//       Walks the parent chain looking for the nearest viewport ancestor.
//
//   * static RenderAbstractViewport of(RenderObject object)
//       Same as `maybeOf`, but asserts non-null.
//
//   * RevealedOffset getOffsetToReveal(
//         RenderObject target,
//         double alignment, {
//         Rect? rect,
//         Axis? axis,
//       })
//       Computes the SCROLL OFFSET the viewport must reach so that the given
//       descendant (optionally a sub-rect of it) is positioned at the
//       requested alignment within the viewport.
//
//   * double get defaultPaintOffset
//       The implicit paint offset (the painting bias inside the viewport).
//
// USER-FACING APIs that exercise this machinery:
//
//   * Scrollable.ensureVisible(BuildContext, {alignment, duration, curve, axis})
//   * RenderObject.showOnScreen({descendant, rect, duration, curve})
//   * Scrollable.of(context)         — to drive ScrollPosition.animateTo
//   * NestedScrollView, PageView, CustomScrollView, ListView, GridView
//
// This file is a hand-authored "deep demo" that scrolls real content,
// reveals real children, and explains the role of `RenderAbstractViewport`
// at every step. It is harness-safe: no main(), no runApp(), no testWidgets,
// only a single `dynamic build(BuildContext)` entry point that returns a
// MaterialApp wrapping a SafeArea > SingleChildScrollView > Column with
// per-section StatefulBuilders.
// ============================================================================

dynamic build(BuildContext context) {
  print('=== RenderAbstractViewport Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderAbstractViewport Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderAbstractViewport — Deep Demo'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _Section1HeroIntro(),
              SizedBox(height: 28),
              _Section2GetOffsetToReveal(),
              SizedBox(height: 28),
              _Section3AlignmentSlider(),
              SizedBox(height: 28),
              _Section4HorizontalViewport(),
              SizedBox(height: 28),
              _Section5MaybeOfDemo(),
              SizedBox(height: 28),
              _Section6RevealWithRect(),
              SizedBox(height: 28),
              _Section7PartialVsFull(),
              SizedBox(height: 28),
              _Section8NestedScrollView(),
              SizedBox(height: 28),
              _Section9PageViewReveal(),
              SizedBox(height: 28),
              _Section10CustomScrollViewSlivers(),
              SizedBox(height: 28),
              _Section11DecisionCard(),
              SizedBox(height: 28),
              _Section12ImplementationSketch(),
              SizedBox(height: 28),
              _Section13ReferenceTable(),
              SizedBox(height: 28),
              _SectionFooter(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// Shared chrome
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.color,
  });
  final int index;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.65),
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

class _Note extends StatelessWidget {
  const _Note(this.text, {this.color = Colors.indigo});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard({required this.code, this.title = 'Code'});
  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF313244),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SelectableText(
              code,
              style: const TextStyle(
                color: Color(0xFFCDD6F4),
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CustomPainters
// ============================================================================

class _ViewportDiagramPainter extends CustomPainter {
  _ViewportDiagramPainter({required this.scroll}) : super(repaint: scroll);
  final Animation<double> scroll;

  @override
  void paint(Canvas canvas, Size size) {
    final viewport = Rect.fromLTWH(20, 30, size.width - 40, size.height - 60);
    final paintViewport = Paint()
      ..color = Colors.indigo.shade100
      ..style = PaintingStyle.fill;
    final paintViewportBorder = Paint()
      ..color = Colors.indigo.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewport, const Radius.circular(8)),
      paintViewport,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewport, const Radius.circular(8)),
      paintViewportBorder,
    );

    // Long sliver content; only a window is visible.
    final contentHeight = viewport.height * 2.5;
    final yOffset = scroll.value * (contentHeight - viewport.height);
    final content = Rect.fromLTWH(
      viewport.left + 20,
      viewport.top - yOffset,
      viewport.width - 40,
      contentHeight,
    );
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(viewport, const Radius.circular(8)),
    );
    final paintContent = Paint()..color = Colors.amber.shade300;
    canvas.drawRRect(
      RRect.fromRectAndRadius(content, const Radius.circular(6)),
      paintContent,
    );

    // Stripes representing children.
    final stripe = Paint()..color = Colors.amber.shade700;
    for (int i = 0; i < 12; i++) {
      final r = Rect.fromLTWH(
        content.left + 8,
        content.top + 10 + i * (content.height / 12),
        content.width - 16,
        content.height / 12 - 6,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        stripe,
      );
    }
    canvas.restore();

    // Axis arrow.
    final axis = Paint()
      ..color = Colors.indigo.shade900
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width - 12, viewport.top),
      Offset(size.width - 12, viewport.bottom),
      axis,
    );
    final tip = Path()
      ..moveTo(size.width - 16, viewport.bottom - 6)
      ..lineTo(size.width - 12, viewport.bottom)
      ..lineTo(size.width - 8, viewport.bottom - 6);
    canvas.drawPath(tip, axis);

    final tp = TextPainter(
      text: const TextSpan(
        text: 'scroll axis',
        style: TextStyle(color: Colors.indigo, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.translate(size.width - 26, viewport.bottom - 8);
    canvas.rotate(-1.5708);
    tp.paint(canvas, Offset.zero);
    canvas.restore();

    // Label
    final tpLabel = TextPainter(
      text: const TextSpan(
        text: 'viewport rect',
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpLabel.paint(canvas, Offset(viewport.left + 6, viewport.top - 16));
  }

  @override
  bool shouldRepaint(covariant _ViewportDiagramPainter oldDelegate) =>
      oldDelegate.scroll != scroll;
}

class _RevealRectOverlayPainter extends CustomPainter {
  _RevealRectOverlayPainter({required this.alignment, required this.pulse})
      : super(repaint: pulse);
  final double alignment;
  final Animation<double> pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final viewport = Rect.fromLTWH(0, 0, size.width, size.height);
    final paintBg = Paint()..color = Colors.deepPurple.shade50;
    canvas.drawRect(viewport, paintBg);

    final targetH = 38.0;
    final targetW = size.width * 0.8;
    final targetX = (size.width - targetW) / 2;
    final scrollY = alignment * (size.height - targetH);
    final target = Rect.fromLTWH(targetX, scrollY, targetW, targetH);

    final pulseAlpha = (0.4 + 0.4 * pulse.value).clamp(0.0, 1.0);
    final paintTarget = Paint()
      ..color = Colors.deepPurple.withOpacity(pulseAlpha);
    canvas.drawRRect(
      RRect.fromRectAndRadius(target, const Radius.circular(6)),
      paintTarget,
    );

    final paintTargetBorder = Paint()
      ..color = Colors.deepPurple.shade700
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(target, const Radius.circular(6)),
      paintTargetBorder,
    );

    // alignment guide lines
    final guide = Paint()
      ..color = Colors.deepPurple.shade300
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, scrollY),
      Offset(size.width, scrollY),
      guide,
    );
    canvas.drawLine(
      Offset(0, scrollY + targetH),
      Offset(size.width, scrollY + targetH),
      guide,
    );

    final tp = TextPainter(
      text: TextSpan(
        text: 'alignment ${alignment.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(8, scrollY + targetH + 4));
  }

  @override
  bool shouldRepaint(covariant _RevealRectOverlayPainter oldDelegate) =>
      oldDelegate.alignment != alignment || oldDelegate.pulse != pulse;
}

class _AxisArrowsPainter extends CustomPainter {
  const _AxisArrowsPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // horizontal axis
    canvas.drawLine(
      Offset(8, size.height / 2),
      Offset(size.width - 8, size.height / 2),
      p,
    );
    final hHead = Path()
      ..moveTo(size.width - 12, size.height / 2 - 5)
      ..lineTo(size.width - 8, size.height / 2)
      ..lineTo(size.width - 12, size.height / 2 + 5);
    canvas.drawPath(hHead, p);

    // vertical axis
    canvas.drawLine(
      Offset(size.width / 2, 8),
      Offset(size.width / 2, size.height - 8),
      p,
    );
    final vHead = Path()
      ..moveTo(size.width / 2 - 5, size.height - 12)
      ..lineTo(size.width / 2, size.height - 8)
      ..lineTo(size.width / 2 + 5, size.height - 12);
    canvas.drawPath(vHead, p);

    final tpH = TextPainter(
      text: TextSpan(
        text: 'horizontal',
        style: TextStyle(color: color, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpH.paint(canvas, Offset(size.width - tpH.width - 12, size.height / 2 + 4));

    final tpV = TextPainter(
      text: TextSpan(
        text: 'vertical',
        style: TextStyle(color: color, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpV.paint(canvas, Offset(size.width / 2 + 4, 10));
  }

  @override
  bool shouldRepaint(covariant _AxisArrowsPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ============================================================================
// Section 1 — Hero intro
// ============================================================================

class _Section1HeroIntro extends StatefulWidget {
  const _Section1HeroIntro();

  @override
  State<_Section1HeroIntro> createState() => _Section1HeroIntroState();
}

class _Section1HeroIntroState extends State<_Section1HeroIntro>
    with TickerProviderStateMixin {
  late final AnimationController _scroll = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 1,
              title: 'What is a Viewport?',
              subtitle: 'Why an abstract base class exists',
              color: Colors.indigo,
            ),
            const _Note(
              'A viewport is a render object that paints a *window* onto a much '
              'larger area of "sliver" content. The viewport rectangle is bounded '
              '(its size is fixed by the parent), but the content inside can be '
              'arbitrarily long. Scrolling is implemented by translating the '
              'content within the viewport.\n\n'
              '`RenderAbstractViewport` is the abstract base class shared by '
              'every viewport render object. It centralises the protocol the '
              'rest of the framework relies on to:\n'
              '  • find the nearest enclosing viewport (`maybeOf`/`of`)\n'
              '  • translate "I want to see this widget" requests into a scroll '
              '    offset (`getOffsetToReveal`)\n'
              '  • know the implicit paint offset inside the viewport.',
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: CustomPaint(
                      painter: _ViewportDiagramPainter(scroll: _scroll),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: CustomPaint(
                      painter: const _AxisArrowsPainter(color: Colors.indigo),
                    ),
                  ),
                ),
              ],
            ),
            const _Note(
              'LEFT painter: an animated viewport rectangle clipping a long '
              'content strip. The rectangle does not change size; the content '
              'translates inside it. RIGHT painter: the two scroll axes the '
              'viewport understands (horizontal / vertical).',
              color: Colors.indigo,
            ),
            const _CodeCard(
              title: 'flutter/rendering — abstract surface',
              code: 'abstract class RenderAbstractViewport extends RenderObject {\n'
                  '  static RenderAbstractViewport? maybeOf(RenderObject? o);\n'
                  '  static RenderAbstractViewport of(RenderObject o);\n'
                  '\n'
                  '  RevealedOffset getOffsetToReveal(\n'
                  '    RenderObject target,\n'
                  '    double alignment, {\n'
                  '    Rect? rect,\n'
                  '    Axis? axis,\n'
                  '  });\n'
                  '\n'
                  '  double get defaultPaintOffset;\n'
                  '}\n',
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 2 — getOffsetToReveal interactive
// ============================================================================

class _Section2GetOffsetToReveal extends StatefulWidget {
  const _Section2GetOffsetToReveal();

  @override
  State<_Section2GetOffsetToReveal> createState() =>
      _Section2GetOffsetToRevealState();
}

class _Section2GetOffsetToRevealState
    extends State<_Section2GetOffsetToReveal> {
  final List<GlobalKey> _itemKeys = List<GlobalKey>.generate(
    30,
    (int i) => GlobalKey(debugLabel: 'sec2-card-$i'),
  );
  final ScrollController _controller = ScrollController();
  int _highlight = -1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _reveal(int index, double alignment) async {
    final BuildContext? c = _itemKeys[index].currentContext;
    if (c == null) {
      return;
    }
    setState(() => _highlight = index);
    await Scrollable.ensureVisible(
      c,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      alignment: alignment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 2,
              title: 'getOffsetToReveal — interactive',
              subtitle: 'ensureVisible() at alignment 0.0 / 0.5 / 1.0',
              color: Colors.teal,
            ),
            const _Note(
              'Clicking any "Reveal #N" button calls Scrollable.ensureVisible() '
              'on a GlobalKey-bearing card. Internally, Scrollable walks up to '
              'find the enclosing RenderAbstractViewport and asks it: '
              '"What scroll offset places this descendant at alignment a within '
              'me?" via `getOffsetToReveal(target, a)`. The returned '
              '`RevealedOffset.offset` is then animated by `ScrollPosition`.',
              color: Colors.teal,
            ),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final double a in <double>[0.0, 0.5, 1.0])
                  for (final int idx in <int>[5, 12, 20, 28])
                    OutlinedButton(
                      onPressed: () => _reveal(idx, a),
                      child: Text('Reveal #$idx @${a.toStringAsFixed(1)}'),
                    ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: ListView.builder(
                controller: _controller,
                itemCount: 30,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext c, int i) {
                  final bool hi = i == _highlight;
                  return Container(
                    key: _itemKeys[i],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: hi
                          ? Colors.teal.shade300
                          : Colors.white,
                      border: Border.all(
                        color: hi ? Colors.teal.shade800 : Colors.teal.shade100,
                        width: hi ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.teal.shade200,
                          child: Text('$i'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Card #$i — child of the viewport. '
                            'Has a GlobalKey so Scrollable.ensureVisible() can '
                            'find it.',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const _CodeCard(
              title: 'How a single button works',
              code: 'final BuildContext c = key.currentContext!;\n'
                  'await Scrollable.ensureVisible(\n'
                  '  c,\n'
                  '  alignment: 0.5, // 0=top, 0.5=center, 1=bottom\n'
                  '  duration: const Duration(milliseconds: 450),\n'
                  '  curve: Curves.easeOutCubic,\n'
                  ');\n'
                  '// internally: viewport.getOffsetToReveal(target, 0.5)\n'
                  '// -> RevealedOffset(offset, rect)\n'
                  '// -> position.animateTo(offset, ...);\n',
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 3 — Alignment slider
// ============================================================================

class _Section3AlignmentSlider extends StatefulWidget {
  const _Section3AlignmentSlider();

  @override
  State<_Section3AlignmentSlider> createState() =>
      _Section3AlignmentSliderState();
}

class _Section3AlignmentSliderState extends State<_Section3AlignmentSlider>
    with SingleTickerProviderStateMixin {
  double _alignment = 0.5;
  final List<GlobalKey> _keys = List<GlobalKey>.generate(
    20,
    (int i) => GlobalKey(debugLabel: 'sec3-$i'),
  );
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _tap(int i) async {
    final BuildContext? c = _keys[i].currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: _alignment,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 3,
              title: 'Alignment slider',
              subtitle: 'Tap a card to reveal it at the chosen alignment',
              color: Colors.deepPurple,
            ),
            const _Note(
              'The `alignment` parameter that ends up in `getOffsetToReveal` is '
              'a value in [0.0, 1.0] interpreted along the viewport\'s scroll '
              'axis. 0.0 means align the top of the target with the leading '
              'edge of the viewport; 1.0 means trailing; 0.5 centers it.',
              color: Colors.deepPurple,
            ),
            Row(
              children: <Widget>[
                const Text('alignment:'),
                Expanded(
                  child: Slider(
                    value: _alignment,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    label: _alignment.toStringAsFixed(2),
                    onChanged: (double v) =>
                        setSt(() => _alignment = v),
                  ),
                ),
                SizedBox(
                  width: 56,
                  child: Text(
                    _alignment.toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple.shade200),
                    ),
                    child: ListView.builder(
                      itemCount: 20,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (BuildContext c, int i) {
                        return InkWell(
                          onTap: () => _tap(i),
                          child: Container(
                            key: _keys[i],
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.deepPurple.shade100,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Tap to reveal card #$i at alignment '
                              '${_alignment.toStringAsFixed(2)}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 260,
                    child: CustomPaint(
                      painter: _RevealRectOverlayPainter(
                        alignment: _alignment,
                        pulse: _pulse,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const _Note(
              'The right-hand visual indicator shows where the target rect '
              'lands inside the viewport for the current alignment value. '
              'When alignment = 0.0 the rect sticks to the top, 0.5 → middle, '
              '1.0 → bottom.',
              color: Colors.deepPurple,
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 4 — Horizontal viewport
// ============================================================================

class _Section4HorizontalViewport extends StatefulWidget {
  const _Section4HorizontalViewport();

  @override
  State<_Section4HorizontalViewport> createState() =>
      _Section4HorizontalViewportState();
}

class _Section4HorizontalViewportState
    extends State<_Section4HorizontalViewport> {
  static const List<IconData> _icons = <IconData>[
    Icons.home, Icons.star, Icons.favorite, Icons.flag, Icons.bolt,
    Icons.cloud, Icons.cake, Icons.coffee, Icons.diamond, Icons.eco,
    Icons.face, Icons.fingerprint, Icons.fireplace, Icons.flight,
    Icons.gavel, Icons.gif, Icons.grass, Icons.hiking, Icons.icecream,
    Icons.inbox, Icons.key, Icons.label, Icons.language, Icons.lightbulb,
    Icons.local_florist, Icons.map, Icons.menu_book, Icons.movie,
    Icons.mood, Icons.music_note,
  ];
  late final List<GlobalKey> _keys =
      List<GlobalKey>.generate(_icons.length, (int i) => GlobalKey());

  Future<void> _reveal(int i, double alignment) async {
    final BuildContext? c = _keys[i].currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: alignment,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 4,
              title: 'Horizontal viewport',
              subtitle: 'Same getOffsetToReveal protocol, axis = horizontal',
              color: Colors.orange,
            ),
            const _Note(
              'A horizontal RenderViewport speaks the same protocol as a '
              'vertical one. The scroll axis is just rotated; the alignment '
              'parameter now ranges along the X axis.',
              color: Colors.orange,
            ),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final int idx in <int>[5, 14, 22, 28])
                  for (final double a in <double>[0.0, 0.5, 1.0])
                    OutlinedButton(
                      onPressed: () => _reveal(idx, a),
                      child: Text('icon #$idx @${a.toStringAsFixed(1)}'),
                    ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _icons.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext c, int i) {
                  return Container(
                    key: _keys[i],
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(_icons[i], size: 32),
                        const SizedBox(height: 4),
                        Text('#$i', style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 5 — maybeOf / of demo (nested scrollables)
// ============================================================================

class _Section5MaybeOfDemo extends StatefulWidget {
  const _Section5MaybeOfDemo();

  @override
  State<_Section5MaybeOfDemo> createState() => _Section5MaybeOfDemoState();
}

class _Section5MaybeOfDemoState extends State<_Section5MaybeOfDemo> {
  final GlobalKey _leafKey = GlobalKey(debugLabel: 'sec5-leaf');
  String _log = '(no walk yet)';

  Future<void> _revealLeaf() async {
    final BuildContext? c = _leafKey.currentContext;
    if (c == null) {
      return;
    }
    setState(() => _log = 'walking up from leaf widget...');
    await Scrollable.ensureVisible(
      c,
      alignment: 0.5,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
    if (!mounted) return;
    setState(() => _log =
        'Reached leaf via nested viewports.\n'
        'Framework called RenderAbstractViewport.maybeOf() repeatedly to find '
        'each enclosing viewport and chained ensureVisible calls.');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 5,
              title: 'maybeOf / of — nested viewports',
              subtitle: 'Outer vertical → inner horizontal → inner vertical',
              color: Colors.cyan,
            ),
            const _Note(
              '`Scrollable.ensureVisible` walks the parent chain of the target '
              'context. At each level it calls `RenderAbstractViewport.maybeOf` '
              'on the ancestor render object. Each enclosing viewport is '
              'asked to scroll its child into view, so deeply-nested children '
              'are reached one viewport at a time.',
              color: Colors.cyan,
            ),
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.cyan.shade200),
              ),
              child: ListView.builder(
                itemCount: 8,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext c, int outer) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.cyan.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'OUTER row #$outer',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (BuildContext c, int mid) {
                              return Container(
                                width: 130,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.cyan.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('inner #$mid',
                                        style: const TextStyle(fontSize: 11)),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 5,
                                        itemBuilder: (BuildContext c, int leaf) {
                                          final bool isTarget =
                                              outer == 6 && mid == 4 && leaf == 3;
                                          return Container(
                                            key: isTarget ? _leafKey : null,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: isTarget
                                                  ? Colors.deepOrange.shade300
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: Colors.cyan.shade300),
                                            ),
                                            child: Text(
                                              isTarget
                                                  ? '★ target leaf'
                                                  : 'leaf $leaf',
                                              style: const TextStyle(
                                                  fontSize: 10),
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _revealLeaf,
              icon: const Icon(Icons.find_in_page),
              label: const Text('Reveal target leaf (3 viewports deep)'),
            ),
            _Note(_log, color: Colors.cyan),
            const _CodeCard(
              title: 'Pseudocode of the framework walk',
              code: 'BuildContext? c = target;\n'
                  'while (c != null) {\n'
                  '  final ro = c.findRenderObject();\n'
                  '  final v  = RenderAbstractViewport.maybeOf(ro);\n'
                  '  if (v != null) {\n'
                  '    final reveal = v.getOffsetToReveal(ro, alignment);\n'
                  '    Scrollable.of(c).position.animateTo(reveal.offset, ...);\n'
                  '  }\n'
                  '  c = c.findAncestorOfType<Scrollable>()?.context;\n'
                  '}\n',
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 6 — Reveal with rect
// ============================================================================

class _Section6RevealWithRect extends StatefulWidget {
  const _Section6RevealWithRect();

  @override
  State<_Section6RevealWithRect> createState() =>
      _Section6RevealWithRectState();
}

class _Section6RevealWithRectState extends State<_Section6RevealWithRect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);
  double _alignment = 0.0;

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 6,
              title: 'Reveal with sub-rect',
              subtitle: 'getOffsetToReveal(rect: ...) for sub-region targeting',
              color: Colors.purple,
            ),
            const _Note(
              'getOffsetToReveal accepts an OPTIONAL `rect` argument. When '
              'provided, the viewport scrolls so that this sub-rectangle of '
              'the target descendant (rather than the descendant itself) '
              'lands at the requested alignment. This is essential for things '
              'like text editors which want to reveal a single line, or for '
              'media players which need to expose just a thumbnail strip.',
              color: Colors.purple,
            ),
            const _CodeCard(
              title: 'API surface',
              code: 'RevealedOffset rev = viewport.getOffsetToReveal(\n'
                  '  bigChild,                  // RenderObject\n'
                  '  0.0,                       // alignment\n'
                  '  rect: const Rect.fromLTWH(0, 200, 100, 30),\n'
                  '  axis: Axis.vertical,       // optional override\n'
                  ');\n'
                  '// rev.offset = scroll offset to use\n'
                  '// rev.rect   = the rect of the sub-region in viewport coords\n',
            ),
            Row(
              children: <Widget>[
                const Text('preview alignment:'),
                Expanded(
                  child: Slider(
                    value: _alignment,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    onChanged: (double v) =>
                        setSt(() => _alignment = v),
                    label: _alignment.toStringAsFixed(2),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 220,
              child: CustomPaint(
                painter: _RevealRectOverlayPainter(
                  alignment: _alignment,
                  pulse: _pulse,
                ),
              ),
            ),
            const _Note(
              'The pulsing rectangle represents the sub-rect being targeted. '
              'Alignment moves it within the viewport. This visualisation is '
              'a stand-in for what the framework would compute via '
              '`getOffsetToReveal(target, alignment, rect: ...)`.',
              color: Colors.purple,
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 7 — Reveal partial vs full
// ============================================================================

class _Section7PartialVsFull extends StatefulWidget {
  const _Section7PartialVsFull();

  @override
  State<_Section7PartialVsFull> createState() => _Section7PartialVsFullState();
}

class _Section7PartialVsFullState extends State<_Section7PartialVsFull> {
  final GlobalKey _topKey = GlobalKey();
  final GlobalKey _bottomKey = GlobalKey();
  final ScrollController _ctl = ScrollController();

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  Future<void> _scrollToStart() async {
    final BuildContext? c = _topKey.currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _scrollToEnd() async {
    final BuildContext? c = _bottomKey.currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: 1.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 7,
              title: 'Partial vs full reveal',
              subtitle: 'When the child is bigger than the viewport',
              color: Colors.green,
            ),
            const _Note(
              'If a child is taller than the viewport, you cannot reveal it '
              '"in full". Instead the viewport reveals the START or the END '
              'of the child depending on alignment 0.0 or 1.0. Two buttons '
              'below demonstrate the difference using a single tall card.',
              color: Colors.green,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: _scrollToStart,
                    child: const Text('Reveal START (alignment 0.0)'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _scrollToEnd,
                    child: const Text('Reveal END (alignment 1.0)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: SingleChildScrollView(
                controller: _ctl,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 240),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            key: _topKey,
                            color: Colors.green.shade400,
                            padding: const EdgeInsets.all(8),
                            child: const Text('TOP of tall child'),
                          ),
                          const SizedBox(height: 280),
                          Container(
                            key: _bottomKey,
                            color: Colors.green.shade700,
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                              'BOTTOM of tall child',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 240),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 8 — NestedScrollView
// ============================================================================

class _Section8NestedScrollView extends StatefulWidget {
  const _Section8NestedScrollView();

  @override
  State<_Section8NestedScrollView> createState() =>
      _Section8NestedScrollViewState();
}

class _Section8NestedScrollViewState extends State<_Section8NestedScrollView> {
  final List<GlobalKey> _keys =
      List<GlobalKey>.generate(40, (int i) => GlobalKey());

  Future<void> _reveal(int i) async {
    final BuildContext? c = _keys[i].currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 8,
              title: 'NestedScrollView',
              subtitle: 'SliverAppBar header + inner reveal',
              color: Colors.brown,
            ),
            const _Note(
              'A NestedScrollView coordinates an OUTER viewport (the SliverApp '
              'header) with an INNER viewport (the body list). Calling '
              'ensureVisible on a leaf still goes through '
              '`RenderAbstractViewport.maybeOf` — the framework finds the '
              'nearest viewport and may chain a parent-viewport reveal too.',
              color: Colors.brown,
            ),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final int i in <int>[3, 11, 22, 33])
                  OutlinedButton(
                    onPressed: () => _reveal(i),
                    child: Text('reveal #$i'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext c, bool inner) {
                    return <Widget>[
                      SliverAppBar(
                        title: const Text('Header'),
                        backgroundColor: Colors.brown.shade300,
                        pinned: true,
                        expandedHeight: 100,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            color: Colors.brown.shade100,
                            child: const Center(
                              child: Text(
                                'Outer SliverAppBar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: ListView.builder(
                    itemCount: 40,
                    itemBuilder: (BuildContext c, int i) {
                      return ListTile(
                        key: _keys[i],
                        leading: CircleAvatar(child: Text('$i')),
                        title: Text('Inner item #$i'),
                        subtitle: const Text('tap a button to reveal me'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 9 — PageView reveal
// ============================================================================

class _Section9PageViewReveal extends StatefulWidget {
  const _Section9PageViewReveal();

  @override
  State<_Section9PageViewReveal> createState() =>
      _Section9PageViewRevealState();
}

class _Section9PageViewRevealState extends State<_Section9PageViewReveal> {
  final PageController _pc = PageController(viewportFraction: 0.85);
  final List<GlobalKey> _keys =
      List<GlobalKey>.generate(8, (int i) => GlobalKey());

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  Future<void> _animateTo(int i) async {
    await _pc.animateToPage(
      i,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _ensureVisible(int i, double alignment) async {
    final BuildContext? c = _keys[i].currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: alignment,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 9,
              title: 'PageView reveal',
              subtitle: 'animateToPage vs ensureVisible alignment',
              color: Colors.pink,
            ),
            const _Note(
              'PageView is itself implemented on top of a horizontal '
              'RenderViewport (a subclass of RenderAbstractViewport). Calling '
              '`Scrollable.ensureVisible(pageContext, alignment: 0.5)` will '
              'compute the viewport scroll offset that centers the page; '
              '`animateToPage` is a higher-level shortcut that snaps to a '
              'specific page index via the PageController.',
              color: Colors.pink,
            ),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (int i = 0; i < 8; i++)
                  OutlinedButton(
                    onPressed: () => _animateTo(i),
                    child: Text('page #$i'),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final double a in <double>[0.0, 0.5, 1.0])
                  for (final int i in <int>[2, 5])
                    ElevatedButton(
                      onPressed: () => _ensureVisible(i, a),
                      child: Text('ensureVis #$i @${a.toStringAsFixed(1)}'),
                    ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pc,
                itemCount: 8,
                itemBuilder: (BuildContext c, int i) {
                  return Container(
                    key: _keys[i],
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'PAGE #$i',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 10 — CustomScrollView slivers
// ============================================================================

class _Section10CustomScrollViewSlivers extends StatefulWidget {
  const _Section10CustomScrollViewSlivers();

  @override
  State<_Section10CustomScrollViewSlivers> createState() =>
      _Section10CustomScrollViewSliversState();
}

class _Section10CustomScrollViewSliversState
    extends State<_Section10CustomScrollViewSlivers> {
  final List<GlobalKey> _listKeys =
      List<GlobalKey>.generate(15, (int i) => GlobalKey());
  final List<GlobalKey> _gridKeys =
      List<GlobalKey>.generate(20, (int i) => GlobalKey());

  Future<void> _reveal(GlobalKey k) async {
    final BuildContext? c = k.currentContext;
    if (c == null) {
      return;
    }
    await Scrollable.ensureVisible(
      c,
      alignment: 0.5,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 10,
              title: 'CustomScrollView with slivers',
              subtitle: 'SliverList + SliverGrid + ensureVisible',
              color: Colors.lime,
            ),
            const _Note(
              'A CustomScrollView is backed by a single RenderViewport (a '
              'RenderAbstractViewport). Each sliver is laid out as a sub-region '
              'of the same viewport. Revealing a child in a SliverGrid still '
              'goes through `getOffsetToReveal` of the SAME viewport.',
              color: Colors.lime,
            ),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () => _reveal(_listKeys[10]),
                  child: const Text('reveal list #10'),
                ),
                OutlinedButton(
                  onPressed: () => _reveal(_gridKeys[15]),
                  child: const Text('reveal grid #15'),
                ),
                OutlinedButton(
                  onPressed: () => _reveal(_listKeys[2]),
                  child: const Text('reveal list #2'),
                ),
                OutlinedButton(
                  onPressed: () => _reveal(_gridKeys[3]),
                  child: const Text('reveal grid #3'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.lime.shade50,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'SliverList region',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext c, int i) => Container(
                            key: _listKeys[i],
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.lime.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('list item #$i'),
                          ),
                          childCount: 15,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'SliverGrid region',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext c, int i) => Container(
                              key: _gridKeys[i],
                              decoration: BoxDecoration(
                                color: Colors.lime.shade400,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(child: Text('g$i')),
                            ),
                            childCount: 20,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
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
    );
  }
}

// ============================================================================
// Section 11 — Decision card
// ============================================================================

class _Section11DecisionCard extends StatelessWidget {
  const _Section11DecisionCard();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 11,
              title: 'Decision card',
              subtitle: 'Which API to call when',
              color: Colors.blueGrey,
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    _DecisionRow(
                      api: 'Scrollable.ensureVisible(context, alignment:)',
                      use: 'You have a BuildContext or RenderObject and want '
                          'to bring it on-screen at a given alignment. Walks '
                          'parent chain via RenderAbstractViewport.maybeOf.',
                    ),
                    Divider(),
                    _DecisionRow(
                      api: 'Scrollable.of(context).animateTo(offset)',
                      use: 'You already know the absolute scroll offset and '
                          'just want to drive ScrollPosition directly. Skips '
                          'the getOffsetToReveal computation.',
                    ),
                    Divider(),
                    _DecisionRow(
                      api: 'RenderObject.showOnScreen(descendant, rect)',
                      use: 'Lower-level: targets a sub-rect inside a render '
                          'object. The render object asks every enclosing '
                          'viewport (via maybeOf) to reveal that rect.',
                    ),
                    Divider(),
                    _DecisionRow(
                      api: 'PageController.animateToPage(i)',
                      use: 'PageView-only convenience that snaps to a page '
                          'index. Internally still drives the underlying '
                          'RenderViewport scroll position.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({required this.api, required this.use});
  final String api;
  final String use;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            api,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(use, style: const TextStyle(fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 12 — Implementation sketch
// ============================================================================

class _Section12ImplementationSketch extends StatelessWidget {
  const _Section12ImplementationSketch();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 12,
              title: 'Implementation sketch',
              subtitle: 'What getOffsetToReveal computes (illustrative)',
              color: Colors.amber,
            ),
            const _Note(
              'The exact implementation in `RenderViewport` is non-trivial '
              'because it must take into account the viewport main-axis '
              'extent, cross-axis extent, the cacheExtent, anchor, and the '
              'GrowthDirection of each sliver. The sketch below captures the '
              'core idea without any of the framework plumbing.',
              color: Colors.amber,
            ),
            const _CodeCard(
              title: 'getOffsetToReveal — illustrative pseudocode',
              code: 'RevealedOffset getOffsetToReveal(\n'
                  '  RenderObject target,\n'
                  '  double alignment, {\n'
                  '  Rect? rect,\n'
                  '  Axis? axis,\n'
                  '}) {\n'
                  '  // 1. Map [target] up to viewport-local coordinates.\n'
                  '  final transform = target.getTransformTo(this);\n'
                  '  final targetRect = MatrixUtils.transformRect(\n'
                  '    transform,\n'
                  '    rect ?? target.paintBounds,\n'
                  '  );\n'
                  '\n'
                  '  // 2. Pick the relevant axis extent.\n'
                  '  final mainAxis = axis ?? this.axis;\n'
                  '  final viewportExtent = mainAxis == Axis.vertical\n'
                  '      ? size.height : size.width;\n'
                  '  final targetExtent = mainAxis == Axis.vertical\n'
                  '      ? targetRect.height : targetRect.width;\n'
                  '  final targetStart  = mainAxis == Axis.vertical\n'
                  '      ? targetRect.top : targetRect.left;\n'
                  '\n'
                  '  // 3. Where, in viewport-local coords, do we want the\n'
                  '  //    target to start?\n'
                  '  final desiredStart =\n'
                  '      alignment * (viewportExtent - targetExtent);\n'
                  '\n'
                  '  // 4. The scroll-offset shift is the difference.\n'
                  '  final delta = targetStart - desiredStart;\n'
                  '  final newOffset =\n'
                  '      currentScrollOffset + delta;\n'
                  '\n'
                  '  return RevealedOffset(\n'
                  '    offset: newOffset,\n'
                  '    rect: targetRect.shift(Offset(0, -delta)),\n'
                  '  );\n'
                  '}\n',
            ),
            const _Note(
              'Two important corner cases the real implementation handles:\n'
              ' • The target is bigger than the viewport — alignment 0 reveals '
              '   the start, alignment 1 reveals the end; the framework does '
              '   not "shrink-to-fit" the request.\n'
              ' • Out-of-band rect — when `rect` lies outside the target\'s '
              '   own paint bounds, the viewport still respects it and may '
              '   over-scroll (clamped by ScrollPosition.physics).',
              color: Colors.amber,
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Section 13 — Reference table
// ============================================================================

class _Section13ReferenceTable extends StatelessWidget {
  const _Section13ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setSt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              index: 13,
              title: 'Reference table',
              subtitle: 'Static helpers + abstract methods',
              color: Colors.red,
            ),
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Symbol')),
                    DataColumn(label: Text('Kind')),
                    DataColumn(label: Text('Purpose')),
                  ],
                  rows: const <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text('maybeOf(RenderObject?)')),
                      DataCell(Text('static')),
                      DataCell(Text(
                          'Find the nearest RenderAbstractViewport ancestor; '
                          'returns null if none.')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('of(RenderObject)')),
                      DataCell(Text('static')),
                      DataCell(Text(
                          'Same as maybeOf; asserts non-null. Used when the '
                          'caller knows a viewport must exist.')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('getOffsetToReveal(...)')),
                      DataCell(Text('abstract')),
                      DataCell(Text(
                          'Compute the scroll offset that places `target` (or '
                          'a sub-rect) at `alignment` along `axis`.')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('defaultPaintOffset')),
                      DataCell(Text('getter')),
                      DataCell(Text(
                          'Implicit paint bias inside the viewport.')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('RevealedOffset')),
                      DataCell(Text('value type')),
                      DataCell(Text(
                          '{ offset: double, rect: Rect } — return type of '
                          'getOffsetToReveal.')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('RenderViewport')),
                      DataCell(Text('subclass')),
                      DataCell(Text(
                          'The standard scrolling viewport used by '
                          'CustomScrollView, ListView, GridView.')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('RenderShrinkWrappingViewport')),
                      DataCell(Text('subclass')),
                      DataCell(Text(
                          'Variant whose main-axis extent shrink-wraps its '
                          'children.')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Footer
// ============================================================================

class _SectionFooter extends StatelessWidget {
  const _SectionFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'References',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('• RenderViewport — flutter/rendering/viewport.dart'),
          Text('• RenderShrinkWrappingViewport — flutter/rendering/viewport.dart'),
          Text('• Scrollable, ScrollPosition — flutter/widgets/scrollable.dart'),
          Text('• Scrollable.ensureVisible — convenience that drives the above'),
          Text('• RenderObject.showOnScreen — flutter/rendering/object.dart'),
          Text('• NestedScrollView, PageView, CustomScrollView, ListView, GridView'),
          SizedBox(height: 8),
          Text(
            'RenderAbstractViewport is the abstract contract every scrolling '
            'viewport in Flutter satisfies. Whenever you call '
            'Scrollable.ensureVisible or RenderObject.showOnScreen, you are '
            'ultimately invoking getOffsetToReveal on one of its concrete '
            'subclasses — usually RenderViewport.',
            style: TextStyle(height: 1.4, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
