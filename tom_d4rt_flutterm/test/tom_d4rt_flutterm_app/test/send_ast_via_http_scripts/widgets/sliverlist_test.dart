// D4rt deep visual demo: SliverList — anatomy, composition, comparison.
// Stateless-only harness entry. No main(), no runApp().
// Entry point: dynamic build(BuildContext context).
//
// Scenes in order:
//   1. _AnatomyHero       — CustomPainter diagram of the SliverList anatomy.
//   2. _AvatarSliverCard  — SliverList.builder with 200 avatar rows + SliverAppBar.large.
//   3. _SeparatedChatCard — SliverList.separated with divider variations.
//   4. _ComposedScrollCard — SliverAppBar.large + SliverToBoxAdapter + SliverList.list + SliverFillRemaining.
//   5. _FixedVsVariableCompare — side-by-side SliverList vs SliverFixedExtentList.
//   6. _FieldReferenceTable  — constructor / delegate reference table.
//   7. _WhenToPreferSliver   — instructional panel.
//
// Palette — parchment, brick red, ink.

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ============================================================================
// Palette & shared tokens.
// ============================================================================

const Color kParchment = Color(0xFFF4F1DE);
const Color kParchmentDeep = Color(0xFFE9E2C6);
const Color kBrick = Color(0xFFC0392B);
const Color kBrickDark = Color(0xFF922B21);
const Color kBrickFade = Color(0xFFE6B0AA);
const Color kInk = Color(0xFF264653);
const Color kInkSoft = Color(0xFF3F6470);
const Color kInkMuted = Color(0xFF5B7884);
const Color kAccentGold = Color(0xFFE9C46A);
const Color kAccentSage = Color(0xFF6A9A6C);

// Spacing tokens.
const double kGapXS = 4;
const double kGapS = 8;
const double kGapM = 12;
const double kGapL = 20;
const double kGapXL = 32;

// Typography presets (built from Material base).
TextStyle _heroTitle() => const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w800,
  color: kInk,
  letterSpacing: 0.2,
);

TextStyle _sectionTitle() => const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: kInk,
  letterSpacing: 0.1,
);

TextStyle _bodyInk() => const TextStyle(
  fontSize: 13.5,
  color: kInk,
  height: 1.35,
);

TextStyle _bodyMuted() => const TextStyle(
  fontSize: 12.5,
  color: kInkMuted,
  height: 1.35,
);

TextStyle _mono() => const TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: kBrickDark,
  height: 1.3,
);

TextStyle _brickTag() => const TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: kParchment,
  letterSpacing: 0.6,
);

// ============================================================================
// Entry point.
// ============================================================================

dynamic build(BuildContext context) {
  debugPrint('sliverlist_test: build entry');
  return MaterialApp(
    title: 'SliverList Anatomy',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kBrick,
        brightness: Brightness.light,
        primary: kBrick,
        secondary: kAccentGold,
        surface: kParchment,
      ),
      scaffoldBackgroundColor: kParchment,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kInk),
      ),
      dividerColor: kBrickFade,
      appBarTheme: const AppBarTheme(
        backgroundColor: kBrick,
        foregroundColor: kParchment,
        elevation: 0,
      ),
    ),
    home: const _SliverListStory(),
  );
}

// ============================================================================
// Root orchestrator. Holds every scene inside one long scroll view.
// ============================================================================

class _SliverListStory extends StatelessWidget {
  const _SliverListStory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kParchment,
      appBar: AppBar(
        title: const Text(
          'SliverList Anatomy — deep visual demo',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(6),
          child: _BrickAccentBar(),
        ),
      ),
      body: const _StoryScrollBody(),
    );
  }
}

class _BrickAccentBar extends StatelessWidget {
  const _BrickAccentBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kBrickDark,
            kBrick,
            kAccentGold,
            kBrick,
            kBrickDark,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}

class _StoryScrollBody extends StatelessWidget {
  const _StoryScrollBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: const <Widget>[
        _SceneHeader(
          index: 1,
          title: 'Hero — SliverList Anatomy',
          blurb:
              'A labeled anatomy of a SliverList: the lazy builder, the child delegate, the viewport window, and the lead/trail edges that drive recycling.',
        ),
        SizedBox(height: kGapM),
        _AnatomyHero(),
        SizedBox(height: kGapXL),

        _SceneHeader(
          index: 2,
          title: 'SliverList.builder — 200 avatar rows',
          blurb:
              'A CustomScrollView with SliverAppBar.large on top and a SliverList.builder underneath producing 200 avatar cards on demand.',
        ),
        SizedBox(height: kGapM),
        _AvatarSliverCard(),
        SizedBox(height: kGapXL),

        _SceneHeader(
          index: 3,
          title: 'SliverList.separated — chat feed',
          blurb:
              'Thirty chat messages separated by three divider flavors: a thin hair line, a breathing gap, and a branded section break.',
        ),
        SizedBox(height: kGapM),
        _SeparatedChatCard(),
        SizedBox(height: kGapXL),

        _SceneHeader(
          index: 4,
          title: 'Composed scroll — App bar + banner + list + footer',
          blurb:
              'SliverAppBar.large collapses over a hero SliverToBoxAdapter banner, then SliverList.list renders eight pinned items, and SliverFillRemaining pads the end.',
        ),
        SizedBox(height: kGapM),
        _ComposedScrollCard(),
        SizedBox(height: kGapXL),

        _SceneHeader(
          index: 5,
          title: 'SliverList vs SliverFixedExtentList',
          blurb:
              'Two columns. Left builds variable-height rows with SliverList. Right builds a fixed-extent 64 px list. A stopwatch note explains why the right side is cheaper.',
        ),
        SizedBox(height: kGapM),
        _FixedVsVariableCompare(),
        SizedBox(height: kGapXL),

        _SceneHeader(
          index: 6,
          title: 'Field reference — constructors & delegates',
          blurb:
              'A compact reference for SliverList, its builder / separated / list sugar, and the SliverChildDelegate pair.',
        ),
        SizedBox(height: kGapM),
        _FieldReferenceTable(),
        SizedBox(height: kGapXL),

        _SceneHeader(
          index: 7,
          title: 'When to prefer Sliver over ListView',
          blurb:
              'A checklist of situations where you should reach for SliverList instead of ListView, ListView.builder, or Column+SingleChildScrollView.',
        ),
        SizedBox(height: kGapM),
        _WhenToPreferSliver(),
        SizedBox(height: kGapXL),

        _FooterStamp(),
      ],
    );
  }
}

// ============================================================================
// Shared building blocks.
// ============================================================================

class _SceneHeader extends StatelessWidget {
  final int index;
  final String title;
  final String blurb;

  const _SceneHeader({
    required this.index,
    required this.title,
    required this.blurb,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: kBrick,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kBrickDark.withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              color: kParchment,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: kGapM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _heroTitle()),
              const SizedBox(height: 4),
              Text(blurb, style: _bodyMuted()),
            ],
          ),
        ),
      ],
    );
  }
}

class _BrickFrame extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color frameColor;

  const _BrickFrame({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.frameColor = kBrick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: frameColor, width: 3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const _Tag({
    required this.label,
    this.bg = kBrick,
    this.fg = kParchment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: _brickTag().copyWith(color: fg),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  final String keyLabel;
  final String value;
  const _KeyValueRow({
    required this.keyLabel,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              keyLabel,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: kInkSoft,
                fontSize: 12.5,
                letterSpacing: 0.1,
              ),
            ),
          ),
          const SizedBox(width: kGapS),
          Expanded(
            child: Text(value, style: _bodyInk()),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  final Color dot;
  const _Bullet({required this.text, this.dot = kBrick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 8),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dot,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(child: Text(text, style: _bodyInk())),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  final String label;
  const _SectionDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kGapM),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Divider(
              color: kBrickFade,
              thickness: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kGapM),
            child: Text(
              label,
              style: const TextStyle(
                color: kBrickDark,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              color: kBrickFade,
              thickness: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterStamp extends StatelessWidget {
  const _FooterStamp();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kGapL, horizontal: kGapM),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kParchmentDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBrickFade, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'End of anatomy — SliverList, end-to-end.',
            style: _sectionTitle(),
          ),
          const SizedBox(height: 6),
          Text(
            'Seven scenes · one stateless composition · no main(), no runApp().',
            style: _bodyMuted(),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Scene 1 — _AnatomyHero: CustomPainter diagram.
// ============================================================================

class _AnatomyHero extends StatelessWidget {
  const _AnatomyHero();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'ANATOMY'),
              SizedBox(width: kGapS),
              _Tag(
                label: 'CUSTOM PAINTER',
                bg: kInk,
                fg: kParchment,
              ),
              SizedBox(width: kGapS),
              _Tag(
                label: 'DIAGRAM',
                bg: kAccentGold,
                fg: kInk,
              ),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            'A SliverList is a lazy, viewport-aware column. It asks its '
            'SliverChildDelegate to produce only those children that intersect '
            'with the viewport, plus a small headroom above and below.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Container(
              decoration: BoxDecoration(
                color: kParchmentDeep,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBrickFade, width: 1),
              ),
              child: CustomPaint(
                painter: _AnatomyPainter(),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          const SizedBox(height: kGapM),
          const _SectionDivider(label: 'LEGEND'),
          const _AnatomyLegend(),
        ],
      ),
    );
  }
}

class _AnatomyLegend extends StatelessWidget {
  const _AnatomyLegend();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _LegendRow(
          color: kBrick,
          term: 'Viewport',
          description:
              'The visible window inside a CustomScrollView or similar. '
              'Only children intersecting this band are kept alive.',
        ),
        _LegendRow(
          color: kInk,
          term: 'Lazy builder',
          description:
              'A function (BuildContext, int) -> Widget? invoked on demand. '
              'Returns null to terminate the virtual list.',
        ),
        _LegendRow(
          color: kAccentGold,
          term: 'Child delegate',
          description:
              'SliverChildBuilderDelegate (dynamic count) or '
              'SliverChildListDelegate (fixed children). Drives element reuse.',
        ),
        _LegendRow(
          color: kAccentSage,
          term: 'Lead / trail edge',
          description:
              'The scroll offsets above and below the viewport where preloaded '
              'children live so momentum scroll stays smooth.',
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String term;
  final String description;
  const _LegendRow({
    required this.color,
    required this.term,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 2, right: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: _bodyInk(),
                children: <InlineSpan>[
                  TextSpan(
                    text: '$term — ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kInk,
                    ),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = kParchment;
    final RRect bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
      const Radius.circular(8),
    );
    canvas.drawRRect(bgRect, bg);

    // Viewport band.
    final double vpLeft = size.width * 0.24;
    final double vpRight = size.width * 0.72;
    final double vpTop = size.height * 0.14;
    final double vpBottom = size.height * 0.86;
    final Paint viewportFill = Paint()
      ..color = kBrick.withValues(alpha: 0.12);
    final Paint viewportStroke = Paint()
      ..color = kBrick
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Rect viewportRect = Rect.fromLTRB(vpLeft, vpTop, vpRight, vpBottom);
    canvas.drawRect(viewportRect, viewportFill);
    canvas.drawRect(viewportRect, viewportStroke);

    // Lead/trail edge zones (above / below viewport).
    final Paint edgeFill = Paint()
      ..color = kAccentSage.withValues(alpha: 0.18);
    final Rect leadRect = Rect.fromLTRB(vpLeft, vpTop - 36, vpRight, vpTop);
    final Rect trailRect =
        Rect.fromLTRB(vpLeft, vpBottom, vpRight, vpBottom + 36);
    canvas.drawRect(leadRect, edgeFill);
    canvas.drawRect(trailRect, edgeFill);

    // Dashed edge borders.
    _drawDashedRect(canvas, leadRect, kAccentSage);
    _drawDashedRect(canvas, trailRect, kAccentSage);

    // Children — rows inside and beyond the viewport.
    final double rowHeight = 22;
    final double rowGap = 8;
    final double rowLeft = vpLeft + 14;
    final double rowRight = vpRight - 14;
    final double firstRowTop = vpTop - 70;
    final Paint rowFill = Paint()..color = kInk;
    final Paint phantomFill = Paint()
      ..color = kInkSoft.withValues(alpha: 0.35);
    final Paint stroke = Paint()
      ..color = kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 16; i++) {
      final double top = firstRowTop + i * (rowHeight + rowGap);
      final Rect row = Rect.fromLTRB(rowLeft, top, rowRight, top + rowHeight);
      final bool insideViewport = row.top >= vpTop && row.bottom <= vpBottom;
      final bool inEdge =
          (row.bottom >= leadRect.top && row.top <= leadRect.bottom) ||
              (row.bottom >= trailRect.top && row.top <= trailRect.bottom);
      final Paint fill = insideViewport
          ? rowFill
          : (inEdge ? phantomFill : Paint()
            ..color = kInkMuted.withValues(alpha: 0.15));
      canvas.drawRRect(
        RRect.fromRectAndRadius(row, const Radius.circular(3)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(row, const Radius.circular(3)),
        stroke,
      );
    }

    // Left-side gutter: scroll axis arrow.
    final Paint axisPaint = Paint()
      ..color = kInk
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final Offset axisTop = Offset(vpLeft - 28, vpTop - 20);
    final Offset axisBottom = Offset(vpLeft - 28, vpBottom + 20);
    canvas.drawLine(axisTop, axisBottom, axisPaint);
    // Arrow head bottom.
    canvas.drawLine(
      axisBottom,
      axisBottom + const Offset(-6, -8),
      axisPaint,
    );
    canvas.drawLine(
      axisBottom,
      axisBottom + const Offset(6, -8),
      axisPaint,
    );

    _drawLabel(
      canvas,
      Offset(vpLeft - 28, vpTop + (vpBottom - vpTop) / 2),
      'scroll axis',
      color: kInk,
      rotate: -math.pi / 2,
    );

    // Labels.
    _drawCallout(
      canvas,
      from: Offset(vpRight - 4, vpTop + 8),
      to: Offset(vpRight + 70, vpTop - 10),
      text: 'viewport\nintersection',
      color: kBrick,
    );
    _drawCallout(
      canvas,
      from: Offset(vpLeft + 12, leadRect.center.dy),
      to: Offset(vpLeft - 70, leadRect.center.dy - 30),
      text: 'lead edge',
      color: kAccentSage,
    );
    _drawCallout(
      canvas,
      from: Offset(vpLeft + 12, trailRect.center.dy),
      to: Offset(vpLeft - 70, trailRect.center.dy + 30),
      text: 'trail edge',
      color: kAccentSage,
    );
    _drawCallout(
      canvas,
      from: Offset(rowRight - 20, vpTop + rowHeight),
      to: Offset(vpRight + 80, vpTop + rowHeight + 20),
      text: 'lazy builder\n(context,i)→Widget?',
      color: kInk,
    );
    _drawCallout(
      canvas,
      from: Offset(vpLeft + 40, vpBottom - 30),
      to: Offset(vpLeft - 90, vpBottom + 10),
      text: 'SliverChildDelegate',
      color: kAccentGold,
    );
  }

  void _drawDashedRect(Canvas canvas, Rect rect, Color color) {
    final Paint p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    const double dash = 4;
    const double gap = 3;
    // Top.
    for (double x = rect.left; x < rect.right; x += dash + gap) {
      canvas.drawLine(
        Offset(x, rect.top),
        Offset(math.min(x + dash, rect.right), rect.top),
        p,
      );
    }
    // Bottom.
    for (double x = rect.left; x < rect.right; x += dash + gap) {
      canvas.drawLine(
        Offset(x, rect.bottom),
        Offset(math.min(x + dash, rect.right), rect.bottom),
        p,
      );
    }
    // Left.
    for (double y = rect.top; y < rect.bottom; y += dash + gap) {
      canvas.drawLine(
        Offset(rect.left, y),
        Offset(rect.left, math.min(y + dash, rect.bottom)),
        p,
      );
    }
    // Right.
    for (double y = rect.top; y < rect.bottom; y += dash + gap) {
      canvas.drawLine(
        Offset(rect.right, y),
        Offset(rect.right, math.min(y + dash, rect.bottom)),
        p,
      );
    }
  }

  void _drawCallout(
    Canvas canvas, {
    required Offset from,
    required Offset to,
    required String text,
    required Color color,
  }) {
    final Paint line = Paint()
      ..color = color
      ..strokeWidth = 1.2;
    canvas.drawLine(from, to, line);
    canvas.drawCircle(from, 3, Paint()..color = color);
    _drawLabel(canvas, to, text, color: color);
  }

  void _drawLabel(
    Canvas canvas,
    Offset pos,
    String text, {
    Color color = kInk,
    double rotate = 0,
  }) {
    final TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        height: 1.15,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: 3,
    )..layout(maxWidth: 120);
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    if (rotate != 0) {
      canvas.rotate(rotate);
    }
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AnatomyPainter oldDelegate) => false;
}

// ============================================================================
// Scene 2 — _AvatarSliverCard: SliverList.builder with 200 items.
// ============================================================================

class _AvatarSliverCard extends StatelessWidget {
  const _AvatarSliverCard();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'SliverList.builder'),
              SizedBox(width: kGapS),
              _Tag(label: '200 items', bg: kInk, fg: kParchment),
              SizedBox(width: kGapS),
              _Tag(label: 'SliverAppBar.large', bg: kAccentGold, fg: kInk),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            '.builder feeds a SliverChildBuilderDelegate under the hood. '
            'It can honour a finite childCount or terminate by returning '
            'null. Items are lazily created and kept alive only when '
            'visible.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          SizedBox(
            height: 420,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar.large(
                    backgroundColor: kBrick,
                    foregroundColor: kParchment,
                    pinned: true,
                    expandedHeight: 160,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        'Roster (200)',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      background: _AvatarAppBarBackground(),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          debugPrint('Avatar roster: search');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_alt_outlined),
                        onPressed: () {
                          debugPrint('Avatar roster: filter');
                        },
                      ),
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    sliver: SliverList.builder(
                      itemCount: 200,
                      itemBuilder: (BuildContext context, int index) {
                        return _AvatarRow(index: index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: kGapM),
          const _SectionDivider(label: 'DELEGATE DETAIL'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _KeyValueRow(
                  keyLabel: 'itemCount',
                  value: '200 — fixed, so SliverChildBuilderDelegate knows '
                      'the end of the list without asking builder for null.',
                ),
                _KeyValueRow(
                  keyLabel: 'itemBuilder',
                  value: '(context, i) → _AvatarRow(index: i). Called '
                      'only when i is within or near the viewport.',
                ),
                _KeyValueRow(
                  keyLabel: 'findChildIndexCallback',
                  value: 'Optional — used for stable keys across reorders.',
                ),
                _KeyValueRow(
                  keyLabel: 'addAutomaticKeepAlives',
                  value: 'True by default — children with KeepAliveNotification '
                      'stay alive outside the viewport.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarAppBarBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[kBrickDark, kBrick, kAccentGold],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              opacity: 0.22,
              child: CustomPaint(painter: _AvatarBannerPainter()),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 56,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: kParchment.withValues(alpha: 0.28),
                shape: BoxShape.circle,
                border: Border.all(color: kParchment, width: 2),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.people_alt, color: kParchment),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = kParchment.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (int i = 0; i < 14; i++) {
      final double r = 18.0 + i * 14;
      canvas.drawCircle(
        Offset(-40, size.height * 0.7),
        r,
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AvatarRow extends StatelessWidget {
  final int index;
  const _AvatarRow({required this.index});

  @override
  Widget build(BuildContext context) {
    final String name = _avatarName(index);
    final String role = _avatarRole(index);
    final Color tile = _avatarTileColor(index);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: tile,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBrickFade, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: <Widget>[
            _AvatarDisc(index: index),
            const SizedBox(width: kGapM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: kInk,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(role, style: _bodyMuted()),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '#${index.toString().padLeft(3, '0')}',
                  style: _mono(),
                ),
                const SizedBox(height: 2),
                _Dot(active: index % 3 == 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color _avatarTileColor(int i) {
  final int cycle = i % 4;
  switch (cycle) {
    case 0:
      return kParchment;
    case 1:
      return kParchmentDeep;
    case 2:
      return const Color(0xFFFBF5E5);
    default:
      return const Color(0xFFEFE7C8);
  }
}

String _avatarName(int i) {
  const List<String> first = <String>[
    'Ada',
    'Bjorn',
    'Cleo',
    'Dara',
    'Ezra',
    'Faye',
    'Gus',
    'Hana',
    'Ivo',
    'Juno',
    'Kenji',
    'Lena',
    'Mori',
    'Nell',
    'Olek',
    'Pia',
    'Quinn',
    'Rami',
    'Saga',
    'Tomo',
  ];
  const List<String> last = <String>[
    'Okafor',
    'Lindqvist',
    'Marín',
    'Kawasaki',
    'Heinonen',
    'Volkov',
    'Beltran',
    'Nair',
    'O’Connor',
    'Bastien',
  ];
  return '${first[i % first.length]} ${last[(i ~/ first.length) % last.length]}';
}

String _avatarRole(int i) {
  const List<String> roles = <String>[
    'Sliver researcher',
    'Viewport analyst',
    'Delegate tuner',
    'Scroll physicist',
    'Render tree archaeologist',
    'Paint phase alchemist',
    'Gesture choreographer',
    'Lifecycle cartographer',
    'Frame budget auditor',
    'Widget anatomist',
  ];
  return roles[i % roles.length];
}

class _AvatarDisc extends StatelessWidget {
  final int index;
  const _AvatarDisc({required this.index});

  @override
  Widget build(BuildContext context) {
    final Color shell = index.isEven ? kBrick : kInk;
    final Color inner = index.isEven ? kAccentGold : kBrickFade;
    final String initials = _initials(_avatarName(index));
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: shell,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shell.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: inner, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: const TextStyle(
            color: kInk,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

String _initials(String name) {
  final List<String> parts = name.split(' ');
  if (parts.isEmpty) {
    return '??';
  }
  if (parts.length == 1) {
    return parts.first.substring(0, math.min(2, parts.first.length));
  }
  return '${parts.first[0]}${parts.last[0]}';
}

class _Dot extends StatelessWidget {
  final bool active;
  const _Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: active ? kAccentSage : kInkMuted.withValues(alpha: 0.4),
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? kAccentSage : kInkMuted,
          width: 1,
        ),
      ),
    );
  }
}

// ============================================================================
// Scene 3 — _SeparatedChatCard: SliverList.separated with 30 messages.
// ============================================================================

class _SeparatedChatCard extends StatelessWidget {
  const _SeparatedChatCard();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'SliverList.separated'),
              SizedBox(width: kGapS),
              _Tag(label: '30 messages', bg: kInk, fg: kParchment),
              SizedBox(width: kGapS),
              _Tag(label: '3 divider styles', bg: kAccentGold, fg: kInk),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            '.separated builds two delegates: one for items, one for the '
            'separators at odd indices. The example below rotates through '
            'three separator flavors so the pattern stays readable.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          SizedBox(
            height: 460,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: kParchmentDeep,
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _ChatChannelHeader(),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      sliver: SliverList.separated(
                        itemCount: 30,
                        itemBuilder: (BuildContext context, int index) {
                          return _ChatBubble(
                            index: index,
                            text: _chatLines[index % _chatLines.length],
                            incoming: index % 2 == 0,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          final int flavor = index % 3;
                          if (flavor == 0) {
                            return const _ThinLineSeparator();
                          }
                          if (flavor == 1) {
                            return const SizedBox(height: 12);
                          }
                          return _BrandedBreakSeparator(
                            label:
                                '— ${_chatTimestamps[index % _chatTimestamps.length]} —',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: kGapM),
          const _SectionDivider(label: 'SEPARATOR FLAVORS'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _SeparatorRecipe(
                title: 'Thin line',
                description:
                    'A 1 px brick-fade line with 10 px horizontal insets.',
                sample: const _ThinLineSeparator(),
              ),
              _SeparatorRecipe(
                title: 'Breathing gap',
                description:
                    'Nothing but a 12 px SizedBox — avoids visual fatigue.',
                sample: const SizedBox(
                  height: 12,
                  width: double.infinity,
                ),
              ),
              _SeparatorRecipe(
                title: 'Branded break',
                description:
                    'A centered caption between two hair lines — used for '
                    'timestamps and date changes.',
                sample: _BrandedBreakSeparator(label: '— 09:12 —'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatChannelHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[kBrick, kBrickDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: kParchment,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.chat_bubble, color: kBrick, size: 20),
          ),
          const SizedBox(width: kGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  '#sliver-anatomy',
                  style: TextStyle(
                    color: kParchment,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '30 messages · last seen 09:14',
                  style: TextStyle(
                    color: kBrickFade,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: kParchment,
            ),
            onPressed: () {
              debugPrint('Chat header: more tapped');
            },
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final int index;
  final String text;
  final bool incoming;
  const _ChatBubble({
    required this.index,
    required this.text,
    required this.incoming,
  });

  @override
  Widget build(BuildContext context) {
    final String who = incoming
        ? _avatarName(index).split(' ').first
        : 'You';
    return Row(
      mainAxisAlignment:
          incoming ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        if (incoming) _AvatarDisc(index: index),
        if (incoming) const SizedBox(width: kGapS),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: incoming ? kParchment : kBrick,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: Radius.circular(incoming ? 4 : 14),
                bottomRight: Radius.circular(incoming ? 14 : 4),
              ),
              border: Border.all(
                color: incoming ? kBrickFade : kBrickDark,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  who,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    color: incoming ? kBrickDark : kParchment,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: TextStyle(
                    color: incoming ? kInk : kParchment,
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!incoming) const SizedBox(width: kGapS),
        if (!incoming) _AvatarDisc(index: index + 1),
      ],
    );
  }
}

class _ThinLineSeparator extends StatelessWidget {
  const _ThinLineSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        height: 1,
        color: kBrickFade,
      ),
    );
  }
}

class _BrandedBreakSeparator extends StatelessWidget {
  final String label;
  const _BrandedBreakSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Divider(color: kBrickFade, thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: kBrickDark,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: kBrickFade, thickness: 1),
          ),
        ],
      ),
    );
  }
}

class _SeparatorRecipe extends StatelessWidget {
  final String title;
  final String description;
  final Widget sample;
  const _SeparatorRecipe({
    required this.title,
    required this.description,
    required this.sample,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kParchmentDeep,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kBrickFade),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: kInk,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(description, style: _bodyMuted()),
            const SizedBox(height: 6),
            sample,
          ],
        ),
      ),
    );
  }
}

const List<String> _chatLines = <String>[
  'Sliver = segment of a CustomScrollView.',
  'SliverList is the lazy one. Build as scroll demands.',
  'SliverFixedExtentList is cheaper when every row is the same height.',
  'SliverToBoxAdapter wraps a non-sliver in a sliver.',
  'SliverFillRemaining fills whatever space is left.',
  'SliverList.builder ≡ SliverChildBuilderDelegate sugar.',
  'SliverList.separated ≡ alternating item/separator delegate.',
  'SliverList.list ≡ SliverChildListDelegate sugar (fixed children).',
  'Prefer builder for large or dynamic lists.',
  'Prefer .list for a short, static list inside a bigger scroll.',
];

const List<String> _chatTimestamps = <String>[
  '09:01',
  '09:03',
  '09:07',
  '09:12',
  '09:18',
  '09:22',
];

// ============================================================================
// Scene 4 — _ComposedScrollCard: SliverAppBar + hero + SliverList.list + footer.
// ============================================================================

class _ComposedScrollCard extends StatelessWidget {
  const _ComposedScrollCard();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'CustomScrollView'),
              SizedBox(width: kGapS),
              _Tag(label: 'SliverList.list', bg: kInk, fg: kParchment),
              SizedBox(width: kGapS),
              _Tag(label: 'SliverFillRemaining', bg: kAccentGold, fg: kInk),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            'SliverList.list is the static cousin of .builder. It forwards '
            'a Dart List<Widget> to SliverChildListDelegate. Use it for '
            'pinned, finite sections inside a larger scroll.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          SizedBox(
            height: 560,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar.large(
                    backgroundColor: kInk,
                    foregroundColor: kParchment,
                    expandedHeight: 160,
                    pinned: true,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'Release notes',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      background: _InkComposedBackground(),
                    ),
                  ),
                  SliverToBoxAdapter(child: _HeroBanner()),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Highlights',
                        style: _sectionTitle(),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    sliver: SliverList.list(
                      children: _composedReleaseItems
                          .map((_ComposedItem it) =>
                              _ComposedItemTile(item: it))
                          .toList(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: _ComposedFooterNotice(),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 16),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            kParchmentDeep,
                            kParchment,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        'end of scroll · SliverFillRemaining',
                        style: _bodyMuted(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InkComposedBackground extends StatelessWidget {
  const _InkComposedBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[kInk, kInkSoft, kInk],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _InkWavePainter()),
    );
  }
}

class _InkWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = kParchment.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    for (int i = 0; i < 6; i++) {
      final Path path = Path();
      final double y0 = 18.0 + i * 20;
      path.moveTo(0, y0);
      for (double x = 0; x <= size.width; x += 8) {
        final double y = y0 + math.sin((x + i * 18) * math.pi / 50) * 6;
        path.lineTo(x, y);
      }
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[kBrickDark, kBrick],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kBrickDark.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kParchment.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(color: kParchment, width: 2),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.rocket_launch,
              color: kParchment,
              size: 28,
            ),
          ),
          const SizedBox(width: kGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Version 2.0 — Sliver Suite',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kParchment,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Eight hand-tuned sliver recipes, one composed scroll.',
                  style: TextStyle(
                    color: kBrickFade,
                    fontSize: 12.5,
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

class _ComposedItem {
  final String title;
  final String summary;
  final IconData icon;
  final Color color;
  const _ComposedItem({
    required this.title,
    required this.summary,
    required this.icon,
    required this.color,
  });
}

const List<_ComposedItem> _composedReleaseItems = <_ComposedItem>[
  _ComposedItem(
    title: 'Lazy delegates',
    summary: 'Only build rows that touch the viewport.',
    icon: Icons.visibility_outlined,
    color: kBrick,
  ),
  _ComposedItem(
    title: 'Keep-alive children',
    summary: 'Children that notify stay alive when scrolled off.',
    icon: Icons.memory,
    color: kInk,
  ),
  _ComposedItem(
    title: 'Fixed extent path',
    summary: 'Switch to SliverFixedExtentList when every row is the same.',
    icon: Icons.straighten,
    color: kAccentSage,
  ),
  _ComposedItem(
    title: 'Grid cousin',
    summary: 'SliverGrid shares the same delegate surface.',
    icon: Icons.grid_view,
    color: kAccentGold,
  ),
  _ComposedItem(
    title: 'Persistent headers',
    summary: 'SliverPersistentHeader for pinned category bars.',
    icon: Icons.push_pin,
    color: kBrickDark,
  ),
  _ComposedItem(
    title: 'Padding slivers',
    summary: 'SliverPadding instead of Padding inside SliverToBoxAdapter.',
    icon: Icons.format_indent_increase,
    color: kInkSoft,
  ),
  _ComposedItem(
    title: 'Cross axis constraint',
    summary:
        'SliverConstrainedCrossAxis caps width inside a full-width viewport.',
    icon: Icons.swap_horiz,
    color: kInk,
  ),
  _ComposedItem(
    title: 'Fill remaining',
    summary: 'Close a scroll with SliverFillRemaining for tall footers.',
    icon: Icons.south,
    color: kBrick,
  ),
];

class _ComposedItemTile extends StatelessWidget {
  final _ComposedItem item;
  const _ComposedItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBrickFade),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: item.color, width: 1),
            ),
            alignment: Alignment.center,
            child: Icon(item.icon, color: item.color, size: 20),
          ),
          const SizedBox(width: kGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kInk,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(item.summary, style: _bodyMuted()),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: kBrick,
          ),
        ],
      ),
    );
  }
}

class _ComposedFooterNotice extends StatelessWidget {
  const _ComposedFooterNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kParchmentDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBrickFade),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: kBrick),
          const SizedBox(width: kGapM),
          Expanded(
            child: Text(
              'Tip — Close your scroll with SliverFillRemaining '
              '(hasScrollBody: false) to get a tall, pinned footer area '
              'that participates in the scroll view geometry.',
              style: _bodyInk(),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Scene 5 — _FixedVsVariableCompare: SliverList vs SliverFixedExtentList.
// ============================================================================

class _FixedVsVariableCompare extends StatelessWidget {
  const _FixedVsVariableCompare();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'SliverList'),
              SizedBox(width: kGapS),
              _Tag(
                label: 'SliverFixedExtentList',
                bg: kInk,
                fg: kParchment,
              ),
              SizedBox(width: kGapS),
              _Tag(
                label: 'Performance note',
                bg: kAccentGold,
                fg: kInk,
              ),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            'Both walk the same SliverChildDelegate, but '
            'SliverFixedExtentList skips a full layout pass per child — '
            'it knows each child occupies exactly itemExtent.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool stacked = constraints.maxWidth < 640;
              final Widget left = _VariableColumn();
              final Widget right = _FixedColumn();
              if (stacked) {
                return Column(
                  children: <Widget>[
                    left,
                    const SizedBox(height: kGapM),
                    right,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: left),
                  const SizedBox(width: kGapM),
                  Expanded(child: right),
                ],
              );
            },
          ),
          const SizedBox(height: kGapM),
          const _StopwatchNote(),
        ],
      ),
    );
  }
}

class _VariableColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kParchmentDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBrickFade),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'VARIABLE'),
              SizedBox(width: kGapS),
              Expanded(
                child: Text(
                  'SliverList — rows vary in height',
                  style: TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kGapS),
          SizedBox(
            height: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return _VariableRow(index: index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VariableRow extends StatelessWidget {
  final int index;
  const _VariableRow({required this.index});

  @override
  Widget build(BuildContext context) {
    final int h = 48 + (index % 5) * 16;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      height: h.toDouble(),
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kBrickFade),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: kBrick,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: kGapS),
          Expanded(
            child: Text(
              'Row $index · height ${h}px',
              style: _bodyInk(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FixedColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kParchmentDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBrickFade),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'FIXED', bg: kInk, fg: kParchment),
              SizedBox(width: kGapS),
              Expanded(
                child: Text(
                  'SliverFixedExtentList — 64 px rows',
                  style: TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kGapS),
          SizedBox(
            height: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverFixedExtentList(
                    itemExtent: 64,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _FixedRow(index: index);
                      },
                      childCount: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FixedRow extends StatelessWidget {
  final int index;
  const _FixedRow({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kBrickFade),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: kInk,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: kGapS),
          Expanded(
            child: Text(
              'Row $index · exactly 64 px',
              style: _bodyInk(),
            ),
          ),
          const Icon(Icons.lock_outline, size: 16, color: kInkSoft),
        ],
      ),
    );
  }
}

class _StopwatchNote extends StatelessWidget {
  const _StopwatchNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kParchment,
              shape: BoxShape.circle,
              border: Border.all(color: kAccentGold, width: 3),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.timer_outlined,
              color: kBrick,
              size: 22,
            ),
          ),
          const SizedBox(width: kGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Stopwatch — variable vs fixed',
                  style: TextStyle(
                    color: kParchment,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Per scroll tick, SliverList has to lay out every newly '
                  'revealed child to learn its height. '
                  'SliverFixedExtentList knows the size ahead of time, so '
                  'it only has to paint — no layout pass per child. On a '
                  'cold start with 1 000 rows, fixed extent typically '
                  'trims about 35–55% of CPU time in the layout phase.',
                  style: TextStyle(
                    color: kBrickFade,
                    fontSize: 12.5,
                    height: 1.4,
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

// ============================================================================
// Scene 6 — _FieldReferenceTable: constructors & delegates.
// ============================================================================

class _FieldReferenceTable extends StatelessWidget {
  const _FieldReferenceTable();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'REFERENCE'),
              SizedBox(width: kGapS),
              _Tag(
                label: 'CONSTRUCTORS',
                bg: kInk,
                fg: kParchment,
              ),
              SizedBox(width: kGapS),
              _Tag(
                label: 'DELEGATES',
                bg: kAccentGold,
                fg: kInk,
              ),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            'A compact lookup — each entry describes one constructor or '
            'delegate, its signature, and its sweet spot.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          const _ConstructorCard(
            name: 'SliverList(delegate: …)',
            signature: 'SliverList({Key? key, required SliverChildDelegate delegate})',
            when:
                'When you want full control over the delegate '
                '(custom delegate, recycler, keep-alive semantics).',
            tip:
                'Reach for .builder / .list / .separated first; '
                'drop down to the plain constructor when you need a custom delegate.',
          ),
          _ConstructorCard(
            name: 'SliverList.builder',
            signature:
                'SliverList.builder({required NullableIndexedWidgetBuilder itemBuilder, int? itemCount, …})',
            when:
                'Long or unbounded lists — thousands of rows, '
                'paginated feeds, virtualised tables.',
            tip:
                'Set itemCount when you know the end; leave it null and '
                'return null from the builder to terminate on demand.',
          ),
          _ConstructorCard(
            name: 'SliverList.separated',
            signature:
                'SliverList.separated({required itemBuilder, required separatorBuilder, required int itemCount, …})',
            when:
                'Feeds with interleaved dividers, branded section '
                'breaks, or sticky date headers between items.',
            tip:
                'separatorBuilder runs at odd positions. Return '
                'different widgets based on index to cycle flavors.',
          ),
          _ConstructorCard(
            name: 'SliverList.list',
            signature:
                'SliverList.list({required List<Widget> children, …})',
            when:
                'Small, static sections inside a bigger scroll — for '
                'example a pinned "highlights" block of 6–12 tiles.',
            tip:
                'Backed by SliverChildListDelegate. The whole list is '
                'kept in memory, so do not feed thousands of children.',
          ),
          const _SectionDivider(label: 'DELEGATES'),
          const _ConstructorCard(
            name: 'SliverChildBuilderDelegate',
            signature:
                'SliverChildBuilderDelegate(NullableIndexedWidgetBuilder builder, {int? childCount, …})',
            when:
                'Powering SliverList.builder / SliverList.separated / '
                'SliverGrid.builder. The workhorse of lazy sliver content.',
            tip:
                'Pass findChildIndexCallback when you use '
                'ValueKey-based children and the list can reorder.',
          ),
          _ConstructorCard(
            name: 'SliverChildListDelegate',
            signature:
                'SliverChildListDelegate(List<Widget> children, {bool addAutomaticKeepAlives = true, …})',
            when:
                'Powering SliverList.list / SliverGrid(children: …). '
                'Fine for small, fixed children counts.',
            tip:
                'addAutomaticKeepAlives / addRepaintBoundaries / '
                'addSemanticIndexes default to true — turn them off when '
                'you profile a heavy tile.',
          ),
          const _SectionDivider(label: 'COMPOSITION PATTERNS'),
          const _PatternCard(
            title: 'Sticky header + list',
            body:
                'Use SliverPersistentHeader(pinned: true) above a '
                'SliverList for a category bar that stays visible.',
          ),
          _PatternCard(
            title: 'Top banner + list + footer',
            body:
                'SliverAppBar.large → SliverToBoxAdapter banner → '
                'SliverList.builder → SliverFillRemaining footer.',
          ),
          _PatternCard(
            title: 'Masonry-style mix',
            body:
                'Alternate SliverList and SliverGrid for editorial '
                'layouts — tall rich rows, then a grid of thumbnails, '
                'then another list.',
          ),
          _PatternCard(
            title: 'Fixed extent for hot paths',
            body:
                'When every row has a strict, shared height, swap '
                'SliverList for SliverFixedExtentList. Saves layout time.',
          ),
        ],
      ),
    );
  }
}

class _ConstructorCard extends StatelessWidget {
  final String name;
  final String signature;
  final String when;
  final String tip;
  const _ConstructorCard({
    required this.name,
    required this.signature,
    required this.when,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kParchmentDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBrickFade),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.code, color: kBrickDark, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kInk,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kParchment,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: kBrickFade),
            ),
            width: double.infinity,
            child: Text(signature, style: _mono()),
          ),
          const SizedBox(height: 8),
          _KeyValueRow(keyLabel: 'When', value: when),
          _KeyValueRow(keyLabel: 'Tip', value: tip),
        ],
      ),
    );
  }
}

class _PatternCard extends StatelessWidget {
  final String title;
  final String body;
  const _PatternCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBrick, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 48,
            decoration: const BoxDecoration(
              color: kBrick,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          const SizedBox(width: kGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kInk,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(body, style: _bodyInk()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Scene 7 — _WhenToPreferSliver: instructional panel.
// ============================================================================

class _WhenToPreferSliver extends StatelessWidget {
  const _WhenToPreferSliver();

  @override
  Widget build(BuildContext context) {
    return _BrickFrame(
      padding: const EdgeInsets.all(14),
      frameColor: kInk,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              _Tag(label: 'WHEN TO PREFER', bg: kInk, fg: kParchment),
              SizedBox(width: kGapS),
              _Tag(label: 'SLIVERS vs LISTVIEW'),
              SizedBox(width: kGapS),
              _Tag(label: 'CHEATSHEET', bg: kAccentGold, fg: kInk),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            'ListView, SingleChildScrollView, and GridView are convenient, '
            'but they wrap a single sliver under the hood. Once you need '
            'two or more scroll segments, pinned headers, or mixed '
            'content, reach for a CustomScrollView of slivers.',
            style: _bodyInk(),
          ),
          const SizedBox(height: kGapM),
          const _SectionDivider(label: 'PREFER A SLIVER STACK'),
          const _Bullet(
            text:
                'You need a collapsing or pinned SliverAppBar — ListView '
                'alone cannot host one; you need a CustomScrollView.',
          ),
          _Bullet(
            text:
                'You want a hero banner, a list, then a footer — three '
                'distinct segments. Use SliverToBoxAdapter + SliverList + '
                'SliverFillRemaining.',
          ),
          _Bullet(
            text:
                'You mix a list and a grid in the same scroll. Sliver '
                'slivers compose; two ListViews and a GridView in a '
                'Column do not.',
          ),
          _Bullet(
            text:
                'You need section headers that stay pinned while their '
                'section scrolls — SliverPersistentHeader is the right '
                'primitive.',
          ),
          _Bullet(
            text:
                'You care about SliverOverlapAbsorber / '
                'SliverOverlapInjector for NestedScrollView parity — '
                'requires a sliver stack.',
          ),
          const _SectionDivider(label: 'STICK WITH LISTVIEW'),
          _Bullet(
            dot: kInk,
            text:
                'A single, standalone scrollable list with no app bar '
                'collapse, no mixed segments, no pinned headers. '
                'ListView.builder is terser.',
          ),
          _Bullet(
            dot: kInk,
            text:
                'Throwaway prototypes. Slivers shine when the layout '
                'is deliberate and sustained.',
          ),
          _Bullet(
            dot: kInk,
            text:
                'Legacy widgets that expect a ListView/ScrollController '
                'pair (drag handles, reorderables) — though most now '
                'also expose sliver-friendly variants.',
          ),
          const _SectionDivider(label: 'RED FLAGS'),
          _Bullet(
            dot: kAccentGold,
            text:
                'A Column with a SingleChildScrollView and a '
                'shrinkWrap: true ListView inside — you are rebuilding '
                'a sliver stack by hand. Refactor to CustomScrollView.',
          ),
          _Bullet(
            dot: kAccentGold,
            text:
                'A SliverList.list with thousands of children — revert '
                'to SliverList.builder. The .list delegate holds all '
                'widgets in memory.',
          ),
          _Bullet(
            dot: kAccentGold,
            text:
                'A SliverList whose itemBuilder does heavy synchronous '
                'work — move loads into a future, then show '
                'placeholders during fetch.',
          ),
          const SizedBox(height: kGapM),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.lightbulb, color: kAccentGold),
                const SizedBox(width: kGapM),
                Expanded(
                  child: Text(
                    'Rule of thumb — if the screen needs two or more '
                    'scrollable segments or any collapsing header, pick '
                    'a CustomScrollView of slivers from the start. '
                    'Converting later is always more painful than '
                    'starting sliver-first.',
                    style: _bodyInk().copyWith(
                      color: kParchment,
                      fontWeight: FontWeight.w600,
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
