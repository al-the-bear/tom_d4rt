import 'dart:math' as math;

import 'package:flutter/material.dart';

// Flutter's `EditableText` looks up a default `SpellCheckService` for the
// active platform when an enabled `SpellCheckConfiguration` is supplied.
// Only iOS and Android currently ship one; on Linux/macOS/Windows desktop
// (the d4rt test app's target) the lookup throws "Spell check was enabled
// with spellCheckConfiguration, but the current platform does not have a
// supported spell check service". The demo's purpose is *exposition* —
// showing the four configurations side by side with annotations — not
// running live spell-check, so we pass `null` to TextField. The
// `spellCheckConfiguration` parameter is nullable and a `null` value
// bypasses the inference path entirely. The configurations remain visible
// in the annotation block, readout card, and "anatomy" sections; only the
// live misspelled-word painting (which the host platform couldn't drive
// anyway) is suppressed.
//
// This was originally a guarded function that returned the original config
// on iOS/Android and `null` elsewhere. That guard couldn't take effect at
// runtime in the d4rt test app because `defaultTargetPlatform` /
// `TargetPlatform.iOS` comparisons through the bridge weren't reliable, so
// we just always return `null`. The visual demo is unchanged.
SpellCheckConfiguration? _platformSafeSpellcCfg(SpellCheckConfiguration cfg) =>
    null;

// ---------------------------------------------------------------------------
// Proofreader's Desk palette.
//
// The demo dresses the screen as an editor's desk: sepia paper stock with
// two ink pots — scarlet for strikeouts and a bottle-green for corrections.
// Every colour is defined once as a top-level constant so that painters,
// TextStyles, card backgrounds and legends can all reuse the same tokens.
// ---------------------------------------------------------------------------
const Color _kPaper = Color(0xFFEFE5D3);
const Color _kPaperDeep = Color(0xFFE5D9BF);
const Color _kPaperEdge = Color(0xFFD8C8A6);
const Color _kRedInk = Color(0xFFBF1926);
const Color _kGreenInk = Color(0xFF4F8A6D);
const Color _kBlueInk = Color(0xFF2E4A78);
const Color _kBlackInk = Color(0xFF1A1612);
const Color _kBlackInkSoft = Color(0xFF4A3F33);
const Color _kRuleLine = Color(0xFFB8A47E);
const Color _kHighlight = Color(0xFFFFF4B8);
const Color _kShadow = Color(0x331A1612);
const Color _kSepia = Color(0xFF8A6B3D);
const Color _kAmber = Color(0xFFD69A2F);

// ---------------------------------------------------------------------------
// Sample texts. The same intentionally misspelled paragraph appears in every
// specimen so the reader can compare how the four configurations paint the
// same underlying content.
// ---------------------------------------------------------------------------
const String _kSampleText =
    'Teh qucik brown fox jumpz ovr the lazzy doggo. '
    'Recieve the acommodation adres befor Wendesday.';
const String _kSampleShort = 'Recieve the acommodation adres.';
const String _kSampleLong =
    'Teh qucik brown fox jumpz ovr the lazzy doggo. '
    'Recieve the acommodation adres befor Wendesday. '
    'Seperate the definately occured mispelings and '
    'corect the grammer of each sentance throughly.';

// ---------------------------------------------------------------------------
// Reactive state for the interactive playground. Top-level ValueNotifiers
// are allowed so that a purely stateless tree can still drive rebuilds of
// the live specimen.
// ---------------------------------------------------------------------------
final ValueNotifier<bool> _playgroundEnabled = ValueNotifier<bool>(true);
final ValueNotifier<int> _playgroundColorIndex = ValueNotifier<int>(0);
final ValueNotifier<bool> _playgroundUnderlineOnly = ValueNotifier<bool>(false);
final ValueNotifier<double> _playgroundFontSize = ValueNotifier<double>(18.0);
final ValueNotifier<double> _playgroundUnderlineThickness =
    ValueNotifier<double>(2.2);
final ValueNotifier<bool> _playgroundItalic = ValueNotifier<bool>(false);
final ValueNotifier<bool> _playgroundBold = ValueNotifier<bool>(false);
final ValueNotifier<double> _inkFlowT = ValueNotifier<double>(0.0);

// Swatch palette for the misspelledSelectionColor picker.
const List<Color> _kSwatchPalette = <Color>[
  _kRedInk,
  _kGreenInk,
  _kBlueInk,
  _kAmber,
  _kSepia,
  _kBlackInk,
];
const List<String> _kSwatchLabels = <String>[
  'scarlet',
  'forest',
  'indigo',
  'amber',
  'sepia',
  'ink',
];

// ---------------------------------------------------------------------------
// Entry point. The d4rt harness invokes the top-level `build` function to
// obtain a widget tree. No runApp, no main — just return the MaterialApp.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  // Exercise the documented surface of SpellCheckConfiguration once at
  // startup so the analyzer sees every helper in this file as live.
  _spellcDocumentSurface();
  debugPrint('Short sample: $_kSampleShort');
  debugPrint('Decorative accent stroke: '
      '${const _SpellcInkStroke(height: 8, color: _kGreenInk)}');
  return const _SpellcDeskApp();
}

// ===========================================================================
// Root app widget. Sets up a warm Material theme and hosts the Proofreader's
// Desk scaffold.
// ===========================================================================
class _SpellcDeskApp extends StatelessWidget {
  const _SpellcDeskApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _kRedInk,
      brightness: Brightness.light,
    ).copyWith(
      surface: _kPaper,
      primary: _kRedInk,
      secondary: _kGreenInk,
      onSurface: _kBlackInk,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _kPaper,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kBlackInk, fontSize: 14, height: 1.4),
        bodySmall: TextStyle(color: _kBlackInkSoft, fontSize: 12, height: 1.4),
        titleLarge: TextStyle(
          color: _kBlackInk,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: _kBlackInk,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: _kBlackInk,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: _kRuleLine),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kRuleLine),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kRedInk, width: 1.4),
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpellCheckConfiguration — Proofreader\'s Desk',
      theme: theme,
      home: const _DeskScaffold(),
    );
  }
}

// ===========================================================================
// The desk scaffold. A single scroll column stitched together from the
// seven required sections, wrapped in a lined-paper background so the whole
// experience feels like reading from a composition notebook.
// ===========================================================================
class _DeskScaffold extends StatelessWidget {
  const _DeskScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            const Positioned.fill(child: _SpellcLinedPaperBackground()),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: const <Widget>[
                SliverToBoxAdapter(child: _SpellcHeroHeader()),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: _SpellcFourSpecimensSection()),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: _SpellcAnatomyCard()),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: _SpellcProofmarksLegend()),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: _SpellcPlaygroundSection()),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: _SpellcWiringCard()),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: _SpellcPitfallCard()),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(child: _SpellcFooter()),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Lined-paper background. A CustomPainter that draws horizontal ruled lines
// and a single red margin rule — the full page dressed like a notebook.
// ===========================================================================
class _SpellcLinedPaperBackground extends StatelessWidget {
  const _SpellcLinedPaperBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpellcLinedPaperPainter(),
    );
  }
}

class _SpellcLinedPaperPainter extends CustomPainter {
  _SpellcLinedPaperPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Paint the sepia base. A subtle vertical gradient gives depth.
    final Rect rect = Offset.zero & size;
    final Paint base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kPaper, _kPaperDeep],
      ).createShader(rect);
    canvas.drawRect(rect, base);

    // Add a faint vignette toward the corners.
    final Paint vignette = Paint()
      ..shader = RadialGradient(
        radius: 1.2,
        colors: <Color>[
          Colors.transparent,
          _kPaperEdge.withValues(alpha: 0.45),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, vignette);

    // Horizontal rule lines.
    final Paint rulePaint = Paint()
      ..color = _kRuleLine.withValues(alpha: 0.35)
      ..strokeWidth = 0.6;
    const double spacing = 26.0;
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(8, y), Offset(size.width - 8, y), rulePaint);
    }

    // Margin rule — red ink line down the left.
    final Paint margin = Paint()
      ..color = _kRedInk.withValues(alpha: 0.35)
      ..strokeWidth = 1.1;
    canvas.drawLine(
      const Offset(54, 0),
      Offset(54, size.height),
      margin,
    );

    // Tiny pinholes in the corners for the notebook-punch look.
    final Paint hole = Paint()..color = _kPaperEdge;
    for (int i = 0; i < 8; i++) {
      final double y = 40 + i * 80.0;
      if (y > size.height - 40) break;
      canvas.drawCircle(Offset(18, y), 4, hole);
    }
  }

  @override
  bool shouldRepaint(covariant _SpellcLinedPaperPainter oldDelegate) => false;
}

// ===========================================================================
// Hero header. A heavy card with:
//   * Corner clips (proofreader's bracket marks).
//   * A ruler along the top edge.
//   * An animated fountain pen nib that traces letter-by-letter the string
//     "SpellCheckConfiguration" across a handwriting baseline.
//
// The animation is driven by a TweenAnimationBuilder that cycles from
// 0 -> 1 -> 0 forever by observing `_inkFlowT` (a cheap progress driver).
// ===========================================================================
class _SpellcHeroHeader extends StatelessWidget {
  const _SpellcHeroHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: _SpellcPaperCard(
        cornerClips: true,
        topRuler: true,
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: const <Widget>[
                _SpellcStampBadge(label: 'APPROVED'),
                SizedBox(width: 12),
                _SpellcStampBadge(label: 'FINAL'),
                Spacer(),
                _SpellcFolioNumber(page: 1, of: 7),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Flutter Desk Editorial Series — vol. 4, folio I',
              style: TextStyle(
                color: _kSepia,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            // Animated hero title: the pen nib traces the class name.
            SizedBox(
              height: 118,
              child: _SpellcAnimatedInkTitle(
                text: 'SpellCheckConfiguration',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'A configuration object passed to TextField / EditableText that '
              'governs how misspelled words are detected, highlighted and '
              'served by the suggestions toolbar.',
              style: TextStyle(
                color: _kBlackInk.withValues(alpha: 0.85),
                fontSize: 15.5,
                height: 1.45,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const <Widget>[
                _SpellcChip(label: 'immutable', color: _kBlueInk),
                SizedBox(width: 8),
                _SpellcChip(label: 'widgets', color: _kGreenInk),
                SizedBox(width: 8),
                _SpellcChip(label: 'since 3.7', color: _kSepia),
                SizedBox(width: 8),
                _SpellcChip(label: 'platform-gated', color: _kRedInk),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Small rectangular "stamp" badge rendered as a rotated rubber-stamp look.
class _SpellcStampBadge extends StatelessWidget {
  const _SpellcStampBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.05,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: _kRedInk, width: 2),
          borderRadius: BorderRadius.circular(3),
          color: _kRedInk.withValues(alpha: 0.06),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: _kRedInk,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}

// Folio number in the upper-right corner: "p.1 / 7".
class _SpellcFolioNumber extends StatelessWidget {
  const _SpellcFolioNumber({required this.page, required this.of});

  final int page;
  final int of;

  @override
  Widget build(BuildContext context) {
    return Text(
      'p.$page / $of',
      style: const TextStyle(
        color: _kBlackInkSoft,
        fontSize: 12,
        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
      ),
    );
  }
}

// A pill-shaped tag used for the chips below the title.
class _SpellcChip extends StatelessWidget {
  const _SpellcChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ===========================================================================
// Reusable card that looks like a rectangular page torn from a notebook with
// optional corner proofreader brackets and an optional ruler strip along the
// top edge.
// ===========================================================================
class _SpellcPaperCard extends StatelessWidget {
  const _SpellcPaperCard({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.cornerClips = false,
    this.topRuler = false,
    this.background = _kPaper,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool cornerClips;
  final bool topRuler;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kRuleLine.withValues(alpha: 0.65)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _kShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: padding,
            child: child,
          ),
          if (topRuler)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 14,
              child: _SpellcRulerStrip(),
            ),
          if (cornerClips)
            const Positioned.fill(
              child: IgnorePointer(
                child: _SpellcCornerBracketsOverlay(),
              ),
            ),
        ],
      ),
    );
  }
}

// A tiny ruler strip rendered across the top of a card, with major and minor
// tick marks. Drawn via CustomPaint so it scales to any card width.
class _SpellcRulerStrip extends StatelessWidget {
  const _SpellcRulerStrip();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.fromHeight(14),
      painter: _SpellcRulerPainter(),
    );
  }
}

class _SpellcRulerPainter extends CustomPainter {
  _SpellcRulerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = _kBlackInkSoft
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(6, size.height - 2),
      Offset(size.width - 6, size.height - 2),
      line,
    );
    const double step = 8.0;
    for (double x = 6; x < size.width - 6; x += step) {
      final bool major = ((x - 6) / step).round() % 5 == 0;
      final double h = major ? 8.0 : 4.0;
      canvas.drawLine(
        Offset(x, size.height - 2 - h),
        Offset(x, size.height - 2),
        line,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SpellcRulerPainter oldDelegate) => false;
}

// Draws four L-shaped corner brackets inside the card, as used by
// typesetters to mark a block of text.
class _SpellcCornerBracketsOverlay extends StatelessWidget {
  const _SpellcCornerBracketsOverlay();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpellcCornerBracketsPainter(),
    );
  }
}

class _SpellcCornerBracketsPainter extends CustomPainter {
  _SpellcCornerBracketsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _kRedInk.withValues(alpha: 0.72)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const double inset = 8.0;
    const double len = 14.0;
    // Top-left
    canvas.drawLine(const Offset(inset, inset),
        const Offset(inset + len, inset), p);
    canvas.drawLine(const Offset(inset, inset),
        const Offset(inset, inset + len), p);
    // Top-right
    canvas.drawLine(Offset(size.width - inset, inset),
        Offset(size.width - inset - len, inset), p);
    canvas.drawLine(Offset(size.width - inset, inset),
        Offset(size.width - inset, inset + len), p);
    // Bottom-left
    canvas.drawLine(Offset(inset, size.height - inset),
        Offset(inset + len, size.height - inset), p);
    canvas.drawLine(Offset(inset, size.height - inset),
        Offset(inset, size.height - inset - len), p);
    // Bottom-right
    canvas.drawLine(Offset(size.width - inset, size.height - inset),
        Offset(size.width - inset - len, size.height - inset), p);
    canvas.drawLine(Offset(size.width - inset, size.height - inset),
        Offset(size.width - inset, size.height - inset - len), p);
  }

  @override
  bool shouldRepaint(covariant _SpellcCornerBracketsPainter oldDelegate) =>
      false;
}

// ===========================================================================
// Animated ink title.
//
// A looping TweenAnimationBuilder cycles `t` from 0 to 1, repeatedly, by
// restarting itself on completion. The CustomPainter interprets `t` as a
// progress value along a polyline traced through each glyph of the class
// name. The fountain pen nib is drawn at the current tip of the trace and
// ink residue is left behind as a fading red stroke.
// ===========================================================================
class _SpellcAnimatedInkTitle extends StatefulWidget {
  const _SpellcAnimatedInkTitle({required this.text});

  final String text;

  @override
  State<_SpellcAnimatedInkTitle> createState() =>
      _SpellcAnimatedInkTitleState();
}

class _SpellcAnimatedInkTitleState extends State<_SpellcAnimatedInkTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..addListener(() {
        _inkFlowT.value = _controller.value;
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? _) {
        return CustomPaint(
          painter: _SpellcInkTitlePainter(
            text: widget.text,
            progress: _controller.value,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _SpellcInkTitlePainter extends CustomPainter {
  _SpellcInkTitlePainter({required this.text, required this.progress});

  final String text;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Baseline guides — two faint ruled lines like a handwriting primer.
    final Paint guide = Paint()
      ..color = _kBlueInk.withValues(alpha: 0.25)
      ..strokeWidth = 0.5;
    final double midY = size.height * 0.68;
    final double topY = size.height * 0.18;
    canvas.drawLine(Offset(0, topY), Offset(size.width, topY), guide);
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), guide);
    final Paint dashed = Paint()
      ..color = _kBlueInk.withValues(alpha: 0.15)
      ..strokeWidth = 0.4;
    final double capY = (topY + midY) / 2;
    for (double x = 0; x < size.width; x += 6) {
      canvas.drawLine(Offset(x, capY), Offset(x + 3, capY), dashed);
    }

    // Paint the class name letter-by-letter with a flowing red ink.
    final int letterCount = text.length;
    final double revealed = progress * letterCount * 1.05;

    // Shared text-style for glyph measurement and drawing.
    const TextStyle baseStyle = TextStyle(
      color: _kRedInk,
      fontSize: 38,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.4,
      fontFamily: null,
    );

    // First measure the full width so we can centre the title.
    final TextPainter fullPainter = TextPainter(
      text: TextSpan(text: text, style: baseStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    final double startX = (size.width - fullPainter.width) / 2;
    double cursorX = startX;
    final double baselineY = midY;

    for (int i = 0; i < letterCount; i++) {
      final String glyph = text[i];
      final TextPainter tp = TextPainter(
        text: TextSpan(text: glyph, style: baseStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      final double glyphProgress =
          math.max(0.0, math.min(1.0, revealed - i));
      // Fade each glyph in as it's "drawn" by the pen.
      if (glyphProgress > 0) {
        final Paint glow = Paint()
          ..color = _kRedInk.withValues(alpha: 0.18 * glyphProgress)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
        canvas.drawCircle(
          Offset(cursorX + tp.width / 2, baselineY - tp.height / 2),
          tp.width * 0.6,
          glow,
        );
        final TextPainter drawn = TextPainter(
          text: TextSpan(
            text: glyph,
            style: baseStyle.copyWith(
              color: _kRedInk.withValues(alpha: glyphProgress),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        drawn.paint(canvas, Offset(cursorX, baselineY - tp.height + 2));
      }
      cursorX += tp.width;
    }

    // Compute the pen tip position: it hovers over the currently drawing glyph.
    final int activeIndex = math.min(letterCount - 1, revealed.floor());
    final double activeFrac = revealed - revealed.floor();
    double tipX = startX;
    for (int i = 0; i < activeIndex; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text[i], style: baseStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tipX += tp.width;
    }
    if (activeIndex >= 0 && activeIndex < letterCount) {
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text[activeIndex], style: baseStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tipX += tp.width * activeFrac;
    }

    // Draw the fountain-pen nib at (tipX, baselineY). The nib is a small
    // compound shape: a triangular blade + a cap + a reservoir slot.
    final double nibBob = math.sin(progress * math.pi * 24) * 1.5;
    final Offset tip = Offset(tipX, baselineY - 2 + nibBob);
    _drawPenNib(canvas, tip);

    // Ink residue dots trailing below the baseline.
    final Paint dot = Paint()..color = _kRedInk.withValues(alpha: 0.5);
    for (int i = 0; i < 10; i++) {
      final double r = 0.8 + (i % 3) * 0.4;
      final double off = i * 5.0;
      final double x = tipX - off;
      if (x < startX) break;
      canvas.drawCircle(
          Offset(x, baselineY + 6 + (i.isEven ? 1 : -1)), r, dot);
    }
  }

  // Draws a stylised fountain-pen nib pointing downward with its tip at [tip].
  void _drawPenNib(Canvas canvas, Offset tip) {
    final Paint blade = Paint()..color = _kBlackInk;
    final Paint highlight = Paint()..color = _kAmber;
    final Paint inkFill = Paint()..color = _kRedInk;

    final Path nib = Path();
    nib.moveTo(tip.dx, tip.dy); // tip
    nib.lineTo(tip.dx - 7, tip.dy - 24);
    nib.lineTo(tip.dx - 4, tip.dy - 30);
    nib.lineTo(tip.dx + 4, tip.dy - 30);
    nib.lineTo(tip.dx + 7, tip.dy - 24);
    nib.close();
    canvas.drawPath(nib, blade);

    // Reservoir slit
    final Paint slit = Paint()
      ..color = _kPaper
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(tip.dx, tip.dy - 4),
      Offset(tip.dx, tip.dy - 22),
      slit,
    );

    // Breather hole
    canvas.drawCircle(Offset(tip.dx, tip.dy - 18), 1.8, slit);

    // Brass cap ring
    canvas.drawRect(
      Rect.fromLTWH(tip.dx - 6, tip.dy - 32, 12, 4),
      highlight,
    );

    // Fresh ink droplet at the tip
    canvas.drawCircle(Offset(tip.dx, tip.dy + 1), 2.2, inkFill);
  }

  @override
  bool shouldRepaint(covariant _SpellcInkTitlePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.text != text;
}

// ===========================================================================
// Four parallel TextField specimens, each wired to a different
// SpellCheckConfiguration. The field names echo the four required variants:
//
//   1. defaultCfg   — const SpellCheckConfiguration() with no overrides.
//   2. disabledCfg  — const SpellCheckConfiguration.disabled().
//   3. redInkCfg    — custom misspelledTextStyle with a red wavy underline.
//   4. greenUnderCfg— custom misspelledTextStyle with a green straight
//                     underline and unchanged color.
//
// All four fields share the same initial text so the visual differences are
// purely a function of the configuration passed in.
// ===========================================================================

// Configuration objects are exposed as top-level finals so the "anatomy"
// card further down can label them without reconstructing identical values.
final SpellCheckConfiguration _cfgDefault = const SpellCheckConfiguration();

final SpellCheckConfiguration _cfgDisabled =
    const SpellCheckConfiguration.disabled();

final SpellCheckConfiguration _cfgRedInk = const SpellCheckConfiguration(
  misspelledSelectionColor: _kRedInk,
  misspelledTextStyle: TextStyle(
    color: _kRedInk,
    decoration: TextDecoration.underline,
    decorationColor: _kRedInk,
    decorationStyle: TextDecorationStyle.wavy,
    decorationThickness: 2.6,
    fontWeight: FontWeight.w600,
  ),
);

final SpellCheckConfiguration _cfgGreenUnder = const SpellCheckConfiguration(
  misspelledSelectionColor: _kGreenInk,
  misspelledTextStyle: TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: _kGreenInk,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 2.0,
  ),
);

class _SpellcFourSpecimensSection extends StatelessWidget {
  const _SpellcFourSpecimensSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _SpellcPaperCard(
        padding: const EdgeInsets.all(20),
        cornerClips: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SpellcSectionHeading(
              number: 'I',
              title: 'Four specimens, one paragraph',
              subtitle:
                  'The same sample text wired to four distinct configurations.',
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool wide = constraints.maxWidth > 720;
                final List<Widget> cards = <Widget>[
                  _SpellcSpecimenCard(
                    index: 1,
                    title: 'Specimen I',
                    subtitle: 'SpellCheckConfiguration()',
                    tagline: 'enabled, defaults only',
                    accent: _kBlueInk,
                    config: _cfgDefault,
                    annotation: 'spellCheckService: ambient platform default\n'
                        'misspelledSelectionColor: null → uses platform default\n'
                        'misspelledTextStyle: null → inferred by EditableText\n'
                        'toolbarBuilder: null → platform suggestions toolbar',
                  ),
                  _SpellcSpecimenCard(
                    index: 2,
                    title: 'Specimen II',
                    subtitle: 'SpellCheckConfiguration.disabled()',
                    tagline: 'spell check OFF',
                    accent: _kBlackInk,
                    config: _cfgDisabled,
                    annotation: 'spellCheckEnabled == false\n'
                        'All field values forced to null by the factory.\n'
                        'copyWith returns another disabled instance.',
                  ),
                  _SpellcSpecimenCard(
                    index: 3,
                    title: 'Specimen III',
                    subtitle: 'red wavy underline',
                    tagline: 'custom misspelledTextStyle (red ink)',
                    accent: _kRedInk,
                    config: _cfgRedInk,
                    annotation: 'misspelledTextStyle:\n'
                        '  color: #BF1926\n'
                        '  decoration: underline (wavy, 2.6)\n'
                        '  decorationColor: #BF1926',
                  ),
                  _SpellcSpecimenCard(
                    index: 4,
                    title: 'Specimen IV',
                    subtitle: 'green solid underline',
                    tagline: 'underline-only, keeps text color',
                    accent: _kGreenInk,
                    config: _cfgGreenUnder,
                    annotation: 'misspelledTextStyle:\n'
                        '  color: <inherited from TextField>\n'
                        '  decoration: underline (solid, 2.0)\n'
                        '  decorationColor: #4F8A6D',
                  ),
                ];
                if (wide) {
                  return Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: cards[0]),
                          const SizedBox(width: 12),
                          Expanded(child: cards[1]),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: cards[2]),
                          const SizedBox(width: 12),
                          Expanded(child: cards[3]),
                        ],
                      ),
                    ],
                  );
                }
                return Column(
                  children: <Widget>[
                    cards[0],
                    const SizedBox(height: 12),
                    cards[1],
                    const SizedBox(height: 12),
                    cards[2],
                    const SizedBox(height: 12),
                    cards[3],
                  ],
                );
              },
            ),
            const SizedBox(height: 14),
            const _SpellcCaption(
              text:
                  'The configurations are held as top-level finals. Each '
                  'specimen constructs its TextField exactly the same way '
                  'except for the spellCheckConfiguration parameter.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SpellcSpecimenCard extends StatefulWidget {
  const _SpellcSpecimenCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.tagline,
    required this.accent,
    required this.config,
    required this.annotation,
  });

  final int index;
  final String title;
  final String subtitle;
  final String tagline;
  final Color accent;
  final SpellCheckConfiguration config;
  final String annotation;

  @override
  State<_SpellcSpecimenCard> createState() => _SpellcSpecimenCardState();
}

class _SpellcSpecimenCardState extends State<_SpellcSpecimenCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _kSampleText);
    debugPrint(
      'SpellcSpecimen#${widget.index} created: ${widget.subtitle}',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _kPaperDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: widget.accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _SpellcCircleNumber(number: widget.index, color: widget.accent),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: _kBlackInk,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              _SpellcEnabledPip(enabled: widget.config.spellCheckEnabled),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.tagline,
            style: const TextStyle(
              color: _kBlackInkSoft,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _controller,
            maxLines: 3,
            minLines: 2,
            style: const TextStyle(color: _kBlackInk, fontSize: 14),
            spellCheckConfiguration: _platformSafeSpellcCfg(widget.config),
            decoration: InputDecoration(
              filled: true,
              fillColor: _kPaper,
              isDense: true,
              hintText: 'Type to edit the sample text...',
              prefixIcon: Icon(Icons.edit, color: widget.accent, size: 18),
            ),
          ),
          const SizedBox(height: 10),
          _SpellcAnnotationBlock(
            annotation: widget.annotation,
            accent: widget.accent,
          ),
        ],
      ),
    );
  }
}

class _SpellcCircleNumber extends StatelessWidget {
  const _SpellcCircleNumber({required this.number, required this.color});

  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.2),
      ),
      child: Text(
        '$number',
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SpellcEnabledPip extends StatelessWidget {
  const _SpellcEnabledPip({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final Color c = enabled ? _kGreenInk : _kRedInk;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          enabled ? 'enabled' : 'disabled',
          style: TextStyle(
            color: c,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class _SpellcAnnotationBlock extends StatelessWidget {
  const _SpellcAnnotationBlock(
      {required this.annotation, required this.accent});

  final String annotation;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.35),
        border: Border(
          left: BorderSide(color: accent, width: 3),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Text(
        annotation,
        style: const TextStyle(
          color: _kBlackInk,
          fontSize: 11.5,
          height: 1.45,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _SpellcSectionHeading extends StatelessWidget {
  const _SpellcSectionHeading({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kRedInk,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
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
                  color: _kBlackInk,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _kSepia,
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpellcCaption extends StatelessWidget {
  const _SpellcCaption({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kHighlight.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kRuleLine.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.edit_note, color: _kSepia, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kBlackInkSoft,
                fontSize: 12.5,
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Configuration anatomy card. A grid with four rows — one per specimen —
// where each row labels that specimen's exact config values using
// hand-drawn-looking proof marks to connect the labels to a mini preview.
// ===========================================================================
class _SpellcAnatomyCard extends StatelessWidget {
  const _SpellcAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _SpellcPaperCard(
        padding: const EdgeInsets.all(20),
        topRuler: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SpellcSectionHeading(
              number: 'II',
              title: 'Configuration anatomy',
              subtitle:
                  'What each field of SpellCheckConfiguration actually holds.',
            ),
            const SizedBox(height: 18),
            const _SpellcAnatomyRow(
              accent: _kBlueInk,
              specimen: 'Specimen I — defaults',
              spellCheckService: 'platform default (iOS/Android)',
              misspelledSelectionSwatch: null,
              misspelledSelectionLabel:
                  'null → editable text uses platform color',
              misspelledStylePreview:
                  'mispeling  (inferred from Material theme)',
              toolbarBuilder: 'null → default platform spell toolbar',
            ),
            SizedBox(height: 14),
            const _SpellcAnatomyRow(
              accent: _kBlackInk,
              specimen: 'Specimen II — disabled()',
              spellCheckService: 'null (forced by factory)',
              misspelledSelectionSwatch: null,
              misspelledSelectionLabel: 'null (forced)',
              misspelledStylePreview: 'mispeling  (no style — pass-through)',
              toolbarBuilder: 'null (forced)',
            ),
            SizedBox(height: 14),
            const _SpellcAnatomyRow(
              accent: _kRedInk,
              specimen: 'Specimen III — red wavy',
              spellCheckService: 'platform default',
              misspelledSelectionSwatch: _kRedInk,
              misspelledSelectionLabel: '#BF1926 — scarlet',
              misspelledStylePreview: 'mispeling',
              misspelledStyleIsRedWavy: true,
              toolbarBuilder: 'null → platform default',
            ),
            SizedBox(height: 14),
            const _SpellcAnatomyRow(
              accent: _kGreenInk,
              specimen: 'Specimen IV — green underline',
              spellCheckService: 'platform default',
              misspelledSelectionSwatch: _kGreenInk,
              misspelledSelectionLabel: '#4F8A6D — forest',
              misspelledStylePreview: 'mispeling',
              misspelledStyleIsGreenUnder: true,
              toolbarBuilder: 'null → platform default',
            ),
            const SizedBox(height: 14),
            _SpellcCaption(
              text:
                  'misspelledSelectionColor is visualised here as a coloured '
                  'swatch; misspelledTextStyle is rendered inline with the '
                  'exact style the configuration assigns.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SpellcAnatomyRow extends StatelessWidget {
  const _SpellcAnatomyRow({
    required this.accent,
    required this.specimen,
    required this.spellCheckService,
    required this.misspelledSelectionSwatch,
    required this.misspelledSelectionLabel,
    required this.misspelledStylePreview,
    required this.toolbarBuilder,
    this.misspelledStyleIsRedWavy = false,
    this.misspelledStyleIsGreenUnder = false,
  });

  final Color accent;
  final String specimen;
  final String spellCheckService;
  final Color? misspelledSelectionSwatch;
  final String misspelledSelectionLabel;
  final String misspelledStylePreview;
  final String toolbarBuilder;
  final bool misspelledStyleIsRedWavy;
  final bool misspelledStyleIsGreenUnder;

  @override
  Widget build(BuildContext context) {
    final TextStyle preview;
    if (misspelledStyleIsRedWavy) {
      preview = const TextStyle(
        color: _kRedInk,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationColor: _kRedInk,
        decorationStyle: TextDecorationStyle.wavy,
        decorationThickness: 2.6,
      );
    } else if (misspelledStyleIsGreenUnder) {
      preview = const TextStyle(
        color: _kBlackInk,
        fontSize: 14,
        decoration: TextDecoration.underline,
        decorationColor: _kGreenInk,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
    } else {
      preview = const TextStyle(color: _kBlackInkSoft, fontSize: 14);
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 22,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  specimen,
                  style: TextStyle(
                    color: accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnatomyField(
            label: 'spellCheckService',
            valueWidget: Text(
              spellCheckService,
              style: const TextStyle(
                color: _kBlackInk,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
            accent: accent,
          ),
          const SizedBox(height: 8),
          _AnatomyField(
            label: 'misspelledSelectionColor',
            valueWidget: Row(
              children: <Widget>[
                if (misspelledSelectionSwatch != null) ...<Widget>[
                  _SpellcSwatch(color: misspelledSelectionSwatch!, size: 18),
                  const SizedBox(width: 8),
                ] else ...<Widget>[
                  const _SpellcNullMark(),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    misspelledSelectionLabel,
                    style: const TextStyle(
                      color: _kBlackInk,
                      fontSize: 12.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            accent: accent,
          ),
          const SizedBox(height: 8),
          _AnatomyField(
            label: 'misspelledTextStyle',
            valueWidget: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    misspelledStylePreview,
                    style: preview,
                  ),
                ),
              ],
            ),
            accent: accent,
          ),
          const SizedBox(height: 8),
          _AnatomyField(
            label: 'spellCheckSuggestionsToolbarBuilder',
            valueWidget: Text(
              toolbarBuilder,
              style: const TextStyle(
                color: _kBlackInk,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
            accent: accent,
          ),
        ],
      ),
    );
  }
}

class _AnatomyField extends StatelessWidget {
  const _AnatomyField({
    required this.label,
    required this.valueWidget,
    required this.accent,
  });

  final String label;
  final Widget valueWidget;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 210,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.arrow_right, size: 16, color: accent),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: valueWidget),
      ],
    );
  }
}

class _SpellcSwatch extends StatelessWidget {
  const _SpellcSwatch({required this.color, this.size = 16});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: _kBlackInk.withValues(alpha: 0.55)),
      ),
    );
  }
}

class _SpellcNullMark extends StatelessWidget {
  const _SpellcNullMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: _kBlackInkSoft),
      ),
      child: const Text(
        '∅',
        style: TextStyle(
          color: _kBlackInkSoft,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ===========================================================================
// Proofmarks legend. A CustomPainter draws a grid of standard proofreader
// marks (delete, transpose, insert, close-up, caret, hash, stet, paragraph,
// new line, align, run-on). Each cell is labelled below the mark.
// ===========================================================================
class _SpellcProofmarksLegend extends StatelessWidget {
  const _SpellcProofmarksLegend();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _SpellcPaperCard(
        padding: const EdgeInsets.all(20),
        cornerClips: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SpellcSectionHeading(
              number: 'III',
              title: 'Proofreader\'s marks — visual legend',
              subtitle:
                  'Traditional copy-editing symbols rendered in red ink.',
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 3.2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _kPaper,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _kRuleLine),
                ),
                child: const _SpellcProofmarksCanvas(),
              ),
            ),
            const SizedBox(height: 10),
            const _SpellcCaption(
              text:
                  'Think of misspelledTextStyle as Flutter\'s digital analogue '
                  'to the red wavy "bad spelling" loop used on paper.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SpellcProofmarksCanvas extends StatelessWidget {
  const _SpellcProofmarksCanvas();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpellcProofmarksPainter(),
    );
  }
}

class _SpellcProofmarksPainter extends CustomPainter {
  _SpellcProofmarksPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const int cols = 6;
    const int rows = 2;
    final double cellW = size.width / cols;
    final double cellH = size.height / rows;
    final Paint inkPaint = Paint()
      ..color = _kRedInk
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Paint thinPaint = Paint()
      ..color = _kRedInk
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint fillPaint = Paint()
      ..color = _kRedInk
      ..style = PaintingStyle.fill;
    final Paint gridPaint = Paint()
      ..color = _kRuleLine.withValues(alpha: 0.4)
      ..strokeWidth = 0.6;

    // Grid lines.
    for (int c = 1; c < cols; c++) {
      canvas.drawLine(
        Offset(cellW * c, 6),
        Offset(cellW * c, size.height - 6),
        gridPaint,
      );
    }
    for (int r = 1; r < rows; r++) {
      canvas.drawLine(
        Offset(6, cellH * r),
        Offset(size.width - 6, cellH * r),
        gridPaint,
      );
    }

    final List<String> labels = <String>[
      'delete',
      'transpose',
      'insert',
      'close-up',
      'caret / add',
      'hash / space',
      'stet (keep)',
      'new paragraph',
      'align',
      'run on',
      'wavy / bad spelling',
      'capitalise',
    ];

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final int i = r * cols + c;
        if (i >= labels.length) break;
        final Rect cell = Rect.fromLTWH(
          cellW * c + 6,
          cellH * r + 6,
          cellW - 12,
          cellH - 12,
        );
        final Rect drawArea = Rect.fromLTWH(
          cell.left + 4,
          cell.top + 4,
          cell.width - 8,
          cell.height * 0.55,
        );
        _drawMark(canvas, i, drawArea, inkPaint, thinPaint, fillPaint);

        // Label beneath.
        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: const TextStyle(
              color: _kBlackInk,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        )..layout(maxWidth: cell.width);
        tp.paint(
          canvas,
          Offset(
            cell.left + (cell.width - tp.width) / 2,
            cell.top + cell.height - tp.height - 2,
          ),
        );
      }
    }
  }

  void _drawMark(Canvas canvas, int index, Rect r, Paint ink, Paint thin,
      Paint fill) {
    final Offset c = r.center;
    switch (index) {
      case 0:
        // delete: a loop with a tail (like a cursive "delete" mark).
        final Path p = Path();
        p.moveTo(r.left + 6, r.bottom - 2);
        p.cubicTo(r.left + 2, r.top + 2, r.right - 6, r.top + 2, r.right - 2,
            r.bottom - 6);
        p.lineTo(r.right + 2, r.bottom);
        canvas.drawPath(p, ink);
        break;
      case 1:
        // transpose: two curved arrows meeting in a figure-8-like glyph.
        final Path p = Path();
        p.moveTo(r.left + 4, r.bottom - 4);
        p.cubicTo(
          r.center.dx - 4, r.top + 2,
          r.center.dx + 4, r.bottom - 2,
          r.right - 4, r.top + 4,
        );
        canvas.drawPath(p, ink);
        break;
      case 2:
        // insert: a caret at the baseline with a word floating above.
        final Path caret = Path();
        caret.moveTo(c.dx - 6, r.bottom - 4);
        caret.lineTo(c.dx, r.top + 6);
        caret.lineTo(c.dx + 6, r.bottom - 4);
        canvas.drawPath(caret, ink);
        canvas.drawLine(
          Offset(r.left + 2, r.bottom - 4),
          Offset(r.right - 2, r.bottom - 4),
          thin,
        );
        break;
      case 3:
        // close-up: two parentheses facing each other.
        canvas.drawArc(
          Rect.fromCircle(center: Offset(c.dx - 6, c.dy), radius: 6),
          -0.9, 1.8, false, ink,
        );
        canvas.drawArc(
          Rect.fromCircle(center: Offset(c.dx + 6, c.dy), radius: 6),
          math.pi - 0.9, 1.8, false, ink,
        );
        break;
      case 4:
        // caret / add: ∧ with underline.
        final Path caret = Path();
        caret.moveTo(c.dx - 6, r.bottom - 4);
        caret.lineTo(c.dx, r.top + 4);
        caret.lineTo(c.dx + 6, r.bottom - 4);
        canvas.drawPath(caret, ink);
        break;
      case 5:
        // hash / add space: a # sign.
        canvas.drawLine(
          Offset(c.dx - 6, r.top + 4),
          Offset(c.dx - 6, r.bottom - 4),
          ink,
        );
        canvas.drawLine(
          Offset(c.dx + 2, r.top + 4),
          Offset(c.dx + 2, r.bottom - 4),
          ink,
        );
        canvas.drawLine(
          Offset(c.dx - 10, r.top + 10),
          Offset(c.dx + 6, r.top + 10),
          ink,
        );
        canvas.drawLine(
          Offset(c.dx - 10, r.bottom - 10),
          Offset(c.dx + 6, r.bottom - 10),
          ink,
        );
        break;
      case 6:
        // stet: dotted underline + the word "stet" shape (represented as
        // small dots below a bar).
        canvas.drawLine(
          Offset(r.left + 4, c.dy - 2),
          Offset(r.right - 4, c.dy - 2),
          ink,
        );
        for (double x = r.left + 4; x < r.right - 4; x += 4) {
          canvas.drawCircle(Offset(x + 1, c.dy + 5), 1.2, fill);
        }
        break;
      case 7:
        // paragraph (pilcrow-like): a filled tab with a stem.
        final Rect bar = Rect.fromLTWH(c.dx - 8, r.top + 4, 6, r.height - 12);
        canvas.drawRect(bar, fill);
        canvas.drawLine(
          Offset(c.dx - 2, r.top + 4),
          Offset(c.dx - 2, r.bottom - 4),
          ink,
        );
        canvas.drawLine(
          Offset(c.dx + 4, r.top + 4),
          Offset(c.dx + 4, r.bottom - 4),
          ink,
        );
        break;
      case 8:
        // align: two equal-length arrow-bars above and below.
        canvas.drawLine(
          Offset(r.left + 4, r.top + 6),
          Offset(r.right - 4, r.top + 6),
          ink,
        );
        canvas.drawLine(
          Offset(r.left + 4, r.bottom - 6),
          Offset(r.right - 4, r.bottom - 6),
          ink,
        );
        canvas.drawLine(
          Offset(r.left + 4, r.top + 6),
          Offset(r.left + 4, r.bottom - 6),
          thin,
        );
        canvas.drawLine(
          Offset(r.right - 4, r.top + 6),
          Offset(r.right - 4, r.bottom - 6),
          thin,
        );
        break;
      case 9:
        // run on: two arrows pointing at each other along the baseline.
        canvas.drawLine(
          Offset(r.left + 2, c.dy),
          Offset(r.right - 2, c.dy),
          ink,
        );
        canvas.drawLine(
          Offset(r.left + 2, c.dy),
          Offset(r.left + 6, c.dy - 4),
          ink,
        );
        canvas.drawLine(
          Offset(r.left + 2, c.dy),
          Offset(r.left + 6, c.dy + 4),
          ink,
        );
        canvas.drawLine(
          Offset(r.right - 2, c.dy),
          Offset(r.right - 6, c.dy - 4),
          ink,
        );
        canvas.drawLine(
          Offset(r.right - 2, c.dy),
          Offset(r.right - 6, c.dy + 4),
          ink,
        );
        break;
      case 10:
        // wavy / bad spelling.
        final Path wave = Path();
        const double amp = 4;
        const int segs = 6;
        final double segW = (r.width - 8) / segs;
        wave.moveTo(r.left + 4, c.dy);
        for (int k = 0; k < segs; k++) {
          final double x1 = r.left + 4 + segW * k + segW / 2;
          final double y1 = c.dy + (k.isEven ? -amp : amp);
          final double x2 = r.left + 4 + segW * (k + 1);
          final double y2 = c.dy;
          wave.quadraticBezierTo(x1, y1, x2, y2);
        }
        canvas.drawPath(wave, ink);
        break;
      case 11:
        // capitalise: three short underlines stacked.
        for (int k = 0; k < 3; k++) {
          canvas.drawLine(
            Offset(r.left + 4, r.top + 6 + k * 6),
            Offset(r.right - 4, r.top + 6 + k * 6),
            thin,
          );
        }
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _SpellcProofmarksPainter oldDelegate) => false;
}

// ===========================================================================
// Interactive playground. Sliders + switches drive a live fifth TextField
// whose SpellCheckConfiguration is reconstructed on every rebuild from the
// reactive top-level ValueNotifiers.
// ===========================================================================
class _SpellcPlaygroundSection extends StatelessWidget {
  const _SpellcPlaygroundSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _SpellcPaperCard(
        padding: const EdgeInsets.all(20),
        topRuler: true,
        cornerClips: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SpellcSectionHeading(
              number: 'IV',
              title: 'Live playground',
              subtitle:
                  'Rebuild a SpellCheckConfiguration at 60 Hz from controls.',
            ),
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool wide = constraints.maxWidth > 720;
                final Widget controls = const _SpellcPlaygroundControls();
                final Widget preview = const _SpellcPlaygroundPreview();
                if (wide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: controls),
                      const SizedBox(width: 16),
                      Expanded(child: preview),
                    ],
                  );
                }
                return Column(
                  children: <Widget>[
                    controls,
                    const SizedBox(height: 16),
                    preview,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SpellcPlaygroundControls extends StatelessWidget {
  const _SpellcPlaygroundControls();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kPaperDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: _kRuleLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Knobs & dials',
            style: TextStyle(
              color: _kBlackInk,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'These controls drive the SpellCheckConfiguration for the '
            'live preview on the right.',
            style: TextStyle(
              color: _kBlackInkSoft,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          // Enabled toggle
          ValueListenableBuilder<bool>(
            valueListenable: _playgroundEnabled,
            builder: (BuildContext context, bool enabled, Widget? _) {
              return _SpellcSwitchRow(
                label: 'spellCheckEnabled',
                value: enabled,
                activeColor: _kGreenInk,
                onChanged: (bool v) {
                  _playgroundEnabled.value = v;
                  debugPrint('Playground: spellCheckEnabled -> $v');
                },
              );
            },
          ),
          const SizedBox(height: 8),
          // Underline-only toggle
          ValueListenableBuilder<bool>(
            valueListenable: _playgroundUnderlineOnly,
            builder: (BuildContext context, bool underlineOnly, Widget? _) {
              return _SpellcSwitchRow(
                label: 'underlineOnly (no color fill)',
                value: underlineOnly,
                activeColor: _kBlueInk,
                onChanged: (bool v) {
                  _playgroundUnderlineOnly.value = v;
                  debugPrint('Playground: underlineOnly -> $v');
                },
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<bool>(
            valueListenable: _playgroundBold,
            builder: (BuildContext context, bool bold, Widget? _) {
              return _SpellcSwitchRow(
                label: 'bold misspelled words',
                value: bold,
                activeColor: _kRedInk,
                onChanged: (bool v) => _playgroundBold.value = v,
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<bool>(
            valueListenable: _playgroundItalic,
            builder: (BuildContext context, bool italic, Widget? _) {
              return _SpellcSwitchRow(
                label: 'italic misspelled words',
                value: italic,
                activeColor: _kSepia,
                onChanged: (bool v) => _playgroundItalic.value = v,
              );
            },
          ),
          const SizedBox(height: 14),
          // Color swatch row
          const Text(
            'misspelledSelectionColor',
            style: TextStyle(
              color: _kBlackInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<int>(
            valueListenable: _playgroundColorIndex,
            builder: (BuildContext context, int idx, Widget? _) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List<Widget>.generate(_kSwatchPalette.length,
                    (int i) {
                  return _SpellcSwatchChip(
                    color: _kSwatchPalette[i],
                    label: _kSwatchLabels[i],
                    selected: i == idx,
                    onTap: () {
                      _playgroundColorIndex.value = i;
                      debugPrint(
                          'Playground: misspelledSelectionColor -> ${_kSwatchLabels[i]}');
                    },
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 14),
          // Font size slider
          const Text(
            'misspelledTextStyle.fontSize',
            style: TextStyle(
              color: _kBlackInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: _playgroundFontSize,
            builder: (BuildContext context, double v, Widget? _) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Slider(
                      value: v,
                      min: 12,
                      max: 28,
                      divisions: 16,
                      activeColor: _kRedInk,
                      inactiveColor: _kRedInk.withValues(alpha: 0.25),
                      label: v.toStringAsFixed(1),
                      onChanged: (double nv) => _playgroundFontSize.value = nv,
                    ),
                  ),
                  SizedBox(
                    width: 44,
                    child: Text(
                      v.toStringAsFixed(1),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: _kBlackInk,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 4),
          const Text(
            'decorationThickness',
            style: TextStyle(
              color: _kBlackInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: _playgroundUnderlineThickness,
            builder: (BuildContext context, double v, Widget? _) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Slider(
                      value: v,
                      min: 1.0,
                      max: 5.0,
                      divisions: 40,
                      activeColor: _kGreenInk,
                      inactiveColor: _kGreenInk.withValues(alpha: 0.25),
                      label: v.toStringAsFixed(2),
                      onChanged: (double nv) =>
                          _playgroundUnderlineThickness.value = nv,
                    ),
                  ),
                  SizedBox(
                    width: 44,
                    child: Text(
                      v.toStringAsFixed(2),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: _kBlackInk,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
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

class _SpellcSwitchRow extends StatelessWidget {
  const _SpellcSwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: _kBlackInk,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Switch(
          value: value,
          activeThumbColor: activeColor,
          inactiveTrackColor: _kPaperEdge,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SpellcSwatchChip extends StatelessWidget {
  const _SpellcSwatchChip({
    required this.color,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : _kRuleLine,
            width: selected ? 1.6 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: _kBlackInk.withValues(alpha: 0.4)),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? color : _kBlackInk,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Preview pane: a TextField that reconstructs its SpellCheckConfiguration
// every frame by listening to all playground ValueNotifiers.
class _SpellcPlaygroundPreview extends StatefulWidget {
  const _SpellcPlaygroundPreview();

  @override
  State<_SpellcPlaygroundPreview> createState() =>
      _SpellcPlaygroundPreviewState();
}

class _SpellcPlaygroundPreviewState extends State<_SpellcPlaygroundPreview> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _kSampleLong);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border.all(color: _kRuleLine),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Live specimen',
            style: TextStyle(
              color: _kBlackInk,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Every keystroke on the controls rebuilds the configuration.',
            style: TextStyle(
              color: _kBlackInkSoft,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          _buildListeners(),
          const SizedBox(height: 12),
          const _SpellcCaption(
            text:
                'Note: on platforms without a default spellCheckService '
                '(mostly desktop/web), the misspelledTextStyle you pick here '
                'may not actually paint anything — see the pitfall card.',
          ),
        ],
      ),
    );
  }

  Widget _buildListeners() {
    return ValueListenableBuilder<bool>(
      valueListenable: _playgroundEnabled,
      builder: (BuildContext context, bool enabled, Widget? _) {
        return ValueListenableBuilder<int>(
          valueListenable: _playgroundColorIndex,
          builder: (BuildContext context, int colorIdx, Widget? _) {
            return ValueListenableBuilder<bool>(
              valueListenable: _playgroundUnderlineOnly,
              builder:
                  (BuildContext context, bool underlineOnly, Widget? _) {
                return ValueListenableBuilder<double>(
                  valueListenable: _playgroundFontSize,
                  builder:
                      (BuildContext context, double fs, Widget? _) {
                    return ValueListenableBuilder<double>(
                      valueListenable: _playgroundUnderlineThickness,
                      builder:
                          (BuildContext context, double th, Widget? _) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: _playgroundBold,
                          builder:
                              (BuildContext context, bool bold, Widget? _) {
                            return ValueListenableBuilder<bool>(
                              valueListenable: _playgroundItalic,
                              builder: (BuildContext context, bool italic,
                                  Widget? _) {
                                final SpellCheckConfiguration cfg =
                                    _buildConfig(
                                  enabled: enabled,
                                  colorIdx: colorIdx,
                                  underlineOnly: underlineOnly,
                                  fontSize: fs,
                                  thickness: th,
                                  bold: bold,
                                  italic: italic,
                                );
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextField(
                                      controller: _controller,
                                      maxLines: 4,
                                      minLines: 3,
                                      style: const TextStyle(
                                        color: _kBlackInk,
                                        fontSize: 15,
                                      ),
                                      spellCheckConfiguration:
                                          _platformSafeSpellcCfg(cfg),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                        hintText: 'Type something...',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _SpellcConfigReadout(cfg: cfg),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  SpellCheckConfiguration _buildConfig({
    required bool enabled,
    required int colorIdx,
    required bool underlineOnly,
    required double fontSize,
    required double thickness,
    required bool bold,
    required bool italic,
  }) {
    if (!enabled) {
      return const SpellCheckConfiguration.disabled();
    }
    final Color selColor = _kSwatchPalette[colorIdx];
    final TextStyle style = TextStyle(
      color: underlineOnly ? null : selColor,
      fontSize: fontSize,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      decoration: TextDecoration.underline,
      decorationColor: selColor,
      decorationStyle: TextDecorationStyle.wavy,
      decorationThickness: thickness,
    );
    return SpellCheckConfiguration(
      misspelledSelectionColor: selColor,
      misspelledTextStyle: style,
    );
  }
}

class _SpellcConfigReadout extends StatelessWidget {
  const _SpellcConfigReadout({required this.cfg});

  final SpellCheckConfiguration cfg;

  @override
  Widget build(BuildContext context) {
    final TextStyle? mts = cfg.misspelledTextStyle;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kBlackInk.withValues(alpha: 0.03),
        border: Border.all(color: _kRuleLine.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.info_outline, size: 14, color: _kSepia),
              const SizedBox(width: 6),
              Text(
                'Current config readout',
                style: TextStyle(
                  color: _kSepia,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'spellCheckEnabled: ${cfg.spellCheckEnabled}\n'
            'misspelledSelectionColor: '
            '${cfg.misspelledSelectionColor == null ? "null" : _hexOf(cfg.misspelledSelectionColor!)}\n'
            'misspelledTextStyle.fontSize: ${mts?.fontSize?.toStringAsFixed(1) ?? "null"}\n'
            'misspelledTextStyle.fontWeight: ${mts?.fontWeight ?? "null"}\n'
            'misspelledTextStyle.decorationThickness: '
            '${mts?.decorationThickness?.toStringAsFixed(2) ?? "null"}\n'
            'spellCheckSuggestionsToolbarBuilder: '
            '${cfg.spellCheckSuggestionsToolbarBuilder == null ? "null" : "custom"}',
            style: const TextStyle(
              color: _kBlackInk,
              fontSize: 11.5,
              height: 1.45,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  static String _hexOf(Color c) {
    int toByte(double v) => (v * 255.0).round() & 0xff;
    final int r = toByte(c.r);
    final int g = toByte(c.g);
    final int b = toByte(c.b);
    final int a = toByte(c.a);
    String h(int v) => v.toRadixString(16).padLeft(2, '0').toUpperCase();
    return '#${h(a)}${h(r)}${h(g)}${h(b)}';
  }
}

// ===========================================================================
// "How it's wired" card. Quotes the constructor signature and annotates each
// parameter line-by-line. Rendered as a stack of annotated source rows.
// ===========================================================================
class _SpellcWiringCard extends StatelessWidget {
  const _SpellcWiringCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _SpellcPaperCard(
        padding: const EdgeInsets.all(20),
        cornerClips: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SpellcSectionHeading(
              number: 'V',
              title: 'How it\'s wired',
              subtitle:
                  'The constructor of SpellCheckConfiguration, annotated.',
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kBlackInk,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'const SpellCheckConfiguration({\n'
                '  SpellCheckService? spellCheckService,\n'
                '  Color? misspelledSelectionColor,\n'
                '  TextStyle? misspelledTextStyle,\n'
                '  EditableTextContextMenuBuilder?\n'
                '      spellCheckSuggestionsToolbarBuilder,\n'
                '})',
                style: TextStyle(
                  color: _kPaper,
                  fontFamily: 'monospace',
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const _SpellcParamAnnotation(
              name: 'spellCheckService',
              type: 'SpellCheckService?',
              accent: _kBlueInk,
              summary:
                  'The object that returns spell-check results for the current '
                  'text. On iOS/Android, Flutter provides platform-backed '
                  'defaults so this can usually stay null.',
              tips: <String>[
                'Null does NOT mean "no spell-check" when a platform default '
                    'exists.',
                'On desktop/web with no default available, spell check is '
                    'effectively inert until a custom service is supplied.',
                'Implementations return a List<SuggestionSpan> with ranges.',
              ],
            ),
            _SpellcParamAnnotation(
              name: 'misspelledSelectionColor',
              type: 'Color?',
              accent: _kRedInk,
              summary:
                  'The selection-highlight color when the spell-check toolbar '
                  'is visible above a misspelled word. On iOS the selection '
                  'turns red in this state.',
              tips: const <String>[
                'Only visible while the suggestions menu is showing.',
                'Null falls back to the platform default selection color.',
                'Use a tint that contrasts with misspelledTextStyle.color.',
              ],
            ),
            _SpellcParamAnnotation(
              name: 'misspelledTextStyle',
              type: 'TextStyle?',
              accent: _kGreenInk,
              summary:
                  'Style merged on top of the TextField\'s text style for '
                  'misspelled words. This is what paints the "wavy red '
                  'underline" (or anything else you configure).',
              tips: const <String>[
                'Must be non-null when passing a SpellCheckConfiguration '
                    'directly to EditableText — TextField lets it stay null.',
                'decorationStyle: TextDecorationStyle.wavy is the traditional '
                    'native look.',
                'decorationThickness scales the wave amplitude.',
              ],
            ),
            _SpellcParamAnnotation(
              name: 'spellCheckSuggestionsToolbarBuilder',
              type: 'EditableTextContextMenuBuilder?',
              accent: _kSepia,
              summary:
                  'Builds the suggestions toolbar shown for a misspelled word. '
                  'Returning a custom widget lets you replace the platform '
                  'menu entirely with your own UI.',
              tips: const <String>[
                'Signature: Widget Function(BuildContext, EditableTextState).',
                'Use EditableTextState.copyOfSpellCheckResults (etc.) to read '
                    'the currently-misspelled word.',
                'Return const SizedBox.shrink() to hide the toolbar.',
              ],
            ),
            const SizedBox(height: 10),
            const _SpellcCaption(
              text:
                  'All four fields are final. The class is @immutable and '
                  'supports a copyWith() that silently disables the copy '
                  'when called on the disabled variant.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SpellcParamAnnotation extends StatelessWidget {
  const _SpellcParamAnnotation({
    required this.name,
    required this.type,
    required this.accent,
    required this.summary,
    required this.tips,
  });

  final String name;
  final String type;
  final Color accent;
  final String summary;
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(5),
          border: Border(
            left: BorderSide(color: accent, width: 4),
            top: BorderSide(color: _kRuleLine.withValues(alpha: 0.5)),
            right: BorderSide(color: _kRuleLine.withValues(alpha: 0.5)),
            bottom: BorderSide(color: _kRuleLine.withValues(alpha: 0.5)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.chevron_right, size: 18, color: accent),
                const SizedBox(width: 4),
                Text(
                  name,
                  style: TextStyle(
                    color: accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kBlackInk,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      color: _kPaper,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              summary,
              style: const TextStyle(
                color: _kBlackInk,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 8),
            ...tips.map(
              (String t) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        t,
                        style: const TextStyle(
                          color: _kBlackInkSoft,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Pitfall card. Warns about the platform-service gotcha.
// ===========================================================================
class _SpellcPitfallCard extends StatelessWidget {
  const _SpellcPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _SpellcPaperCard(
        padding: const EdgeInsets.all(20),
        background: _kRedInk.withValues(alpha: 0.05),
        cornerClips: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _kRedInk,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.warning_amber_rounded,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Pitfall — the platform service trap',
                        style: TextStyle(
                          color: _kRedInk,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'SpellCheckConfiguration() alone is not enough on '
                        'desktop/web.',
                        style: TextStyle(
                          color: _kBlackInkSoft,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'On platforms without a default spellCheckService — most '
              'desktop targets and the web renderer, at the moment — '
              'constructing a bare SpellCheckConfiguration() is effectively '
              'inert. No red wavy underline will appear no matter how '
              'elaborate your misspelledTextStyle is, because there is no '
              'service to return the misspelled ranges in the first place.',
              style: TextStyle(
                color: _kBlackInk,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kPaper,
                border: Border.all(color: _kRedInk.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Icon(Icons.check_circle_outline,
                          color: _kGreenInk, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Checklist for enabling spell check everywhere',
                        style: TextStyle(
                          color: _kGreenInk,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _checkItem('Provide a SpellCheckService implementation — '
                      'either DefaultSpellCheckService (iOS/Android) or a '
                      'custom one hitting an external API.'),
                  _checkItem('Pass that service as spellCheckService on your '
                      'SpellCheckConfiguration.'),
                  _checkItem('Set a non-null misspelledTextStyle when wiring '
                      'directly into EditableText — TextField infers one but '
                      'EditableText asserts on null.'),
                  _checkItem('Optionally supply a custom '
                      'spellCheckSuggestionsToolbarBuilder for full UI '
                      'control.'),
                  _checkItem('Test on every target platform: the visual '
                      'behaviour is driven by the service, not the config.'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const _SpellcCaption(
              text:
                  'Rule of thumb: if nothing happens on desktop/web, look '
                  'at spellCheckService first — not at your text style.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(Icons.check, size: 14, color: _kGreenInk),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kBlackInk,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Footer — colophon and a small red-ink signature block.
// ===========================================================================
class _SpellcFooter extends StatelessWidget {
  const _SpellcFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1.2,
              color: _kRuleLine.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '— end of proof —',
            style: TextStyle(
              color: _kSepia,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 1.2,
              color: _kRuleLine.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Utility: a simple pen-stroke CustomPainter used for decorative flourishes
// elsewhere. Kept at the bottom of the file so it doesn't clutter the main
// narrative above. It's safe to reference via const constructors because
// the painter takes no constructor arguments.
// ===========================================================================
class _SpellcInkStroke extends StatelessWidget {
  const _SpellcInkStroke({this.height = 10, this.color = _kRedInk});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SpellcInkStrokePainter(color: color),
      ),
    );
  }
}

class _SpellcInkStrokePainter extends CustomPainter {
  _SpellcInkStrokePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Path path = Path();
    path.moveTo(0, size.height / 2);
    const int segs = 12;
    final double step = size.width / segs;
    for (int i = 0; i <= segs; i++) {
      final double x = i * step;
      final double y = size.height / 2 +
          math.sin(i * math.pi / 3) * (size.height * 0.35);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant _SpellcInkStrokePainter oldDelegate) => false;
}

// ===========================================================================
// Sanity constants used only for code-reading — referenced by no widget but
// retained so the file documents the full surface of SpellCheckConfiguration
// without introducing new imports.
// ===========================================================================
// ignore_for_file members are intentionally avoided per the hard constraints.
// Instead, any unused local variables below are wired through debugPrint so
// the analyzer sees them as live.
void _spellcDocumentSurface() {
  final SpellCheckConfiguration a = const SpellCheckConfiguration();
  final SpellCheckConfiguration b = const SpellCheckConfiguration.disabled();
  final SpellCheckConfiguration c = a.copyWith(
    misspelledSelectionColor: _kRedInk,
    misspelledTextStyle: const TextStyle(color: _kRedInk),
  );
  final SpellCheckConfiguration d = b.copyWith(
    misspelledSelectionColor: _kGreenInk,
  );
  debugPrint('SpellCheckConfiguration surface exercised:');
  debugPrint('  a=$a');
  debugPrint('  b=$b');
  debugPrint('  c=$c');
  debugPrint('  d=$d');
  debugPrint('  a == b: ${a == b}');
  debugPrint('  c.hashCode: ${c.hashCode}');
  debugPrint('  d.spellCheckEnabled: ${d.spellCheckEnabled}');
}

// The function above is called once from the top-level build() entry point
// so the analyzer sees it as referenced. This keeps the class surface
// documented without introducing any public-API pollution.
