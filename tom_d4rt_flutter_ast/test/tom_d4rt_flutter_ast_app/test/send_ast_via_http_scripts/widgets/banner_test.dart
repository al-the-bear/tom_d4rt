// D4rt deep visual demo: Flutter Banner widget anatomy and usage gallery.
//
// This script is consumed by the D4rt-AST interpreter test harness. The
// harness wraps the returned widget in its own MaterialApp/Scaffold context,
// so this file deliberately does not declare main() or runApp(). The build
// function is invoked once per render and must return a fully composed
// Widget tree.
//
// Banner is the diagonal corner overlay used by MaterialApp's
// debugShowCheckedModeBanner machinery. It is a runtime overlay, not a
// layout-affecting widget: it paints over the foreground after children
// finish painting. This demo explores every visible facet of the
// constructor surface (message, location, color, messageStyle,
// textDirection, layoutDirection, child) and the BannerPainter that backs
// it.
import 'package:flutter/material.dart';

// =============================================================================
// PALETTE
// =============================================================================
//
// Red / crimson family. Each section gets a slightly shifted accent so the
// gallery does not feel uniform while still keeping the Banner aesthetic.

const Color kRedHero = Color(0xFFB71C1C);
const Color kRedHeroDeep = Color(0xFF7F0000);
const Color kRedAnatomy = Color(0xFFC62828);
const Color kRedLocation = Color(0xFFD32F2F);
const Color kRedColorSweep = Color(0xFFE53935);
const Color kRedMessage = Color(0xFFEF5350);
const Color kRedDirection = Color(0xFFAD1457);
const Color kRedPainter = Color(0xFF880E4F);
const Color kRedRealWorld = Color(0xFF6A1B1A);
const Color kRedCaveats = Color(0xFF4E0A0A);

const Color kInk = Color(0xFF1A0606);
const Color kInkSoft = Color(0xFF3C1212);
const Color kInkMute = Color(0xFF7A4444);
const Color kPaper = Color(0xFFFFF7F5);
const Color kPaperDeep = Color(0xFFFCE9E6);
const Color kFrame = Color(0xFFE6BFB8);

// =============================================================================
// build()
// =============================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaper,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          HeroHeader(),
          SectionGap(),
          AnatomyDiagram(),
          SectionGap(),
          LocationShowcase(),
          SectionGap(),
          ColorSweep(),
          SectionGap(),
          MessageVariants(),
          SectionGap(),
          DirectionShowcase(),
          SectionGap(),
          PainterDirectUsage(),
          SectionGap(),
          RealWorldExamples(),
          SectionGap(),
          CaveatsBoard(),
          SectionGap(),
          GradientFooter(),
          SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// =============================================================================
// COMMON HELPERS
// =============================================================================

class SectionGap extends StatelessWidget {
  const SectionGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 28);
  }
}

class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final Color accent;
  final String title;
  final String subtitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: kPaper,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: 0.3), width: 1),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: accent.withValues(alpha: 0.10),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 30,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(3),
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
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: accent,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: kInkMute,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            body,
          ],
        ),
      ),
    );
  }
}

class CaptionChip extends StatelessWidget {
  const CaptionChip({
    super.key,
    required this.label,
    required this.tone,
  });

  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: tone.withValues(alpha: 0.45), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: tone,
        ),
      ),
    );
  }
}

class FramedSurface extends StatelessWidget {
  const FramedSurface({
    super.key,
    required this.size,
    required this.label,
    this.background = kPaperDeep,
    this.borderColor = kFrame,
    this.child,
  });

  final double size;
  final String label;
  final Color background;
  final Color borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: kInkSoft,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ?child,
          ],
        ),
      ),
    );
  }
}

class ProseBlock extends StatelessWidget {
  const ProseBlock({
    super.key,
    required this.text,
    this.tone = kInkSoft,
  });

  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        height: 1.45,
        color: tone,
      ),
    );
  }
}

// =============================================================================
// SECTION 1 — HERO HEADER
// =============================================================================

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[kRedHero, kRedHeroDeep],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kRedHero.withValues(alpha: 0.45),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: kRedHeroDeep.withValues(alpha: 0.30),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const HeroBadge(),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'flutter/material.dart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'overlay-only',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Banner — diagonal corner overlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'A purely cosmetic widget that paints a 45° text strip across '
                    'one corner of its child. Used by MaterialApp to badge '
                    'debug builds; useful anywhere you want a non-intrusive '
                    'corner watermark.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 12.8,
                      height: 1.45,
                    ),
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

class HeroBadge extends StatelessWidget {
  const HeroBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.2,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: const Banner(
              message: 'DEBUG',
              location: BannerLocation.topEnd,
              color: Color(0xFFFFFFFF),
              textStyle: TextStyle(
                color: kRedHeroDeep,
                fontSize: 8.5,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
              child: SizedBox.expand(),
            ),
          ),
          const Center(
            child: Icon(
              Icons.flag_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — ANATOMY DIAGRAM
// =============================================================================

class AnatomyDiagram extends StatelessWidget {
  const AnatomyDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedAnatomy,
      title: '1 · Anatomy',
      subtitle:
          'A Banner wraps a child and paints a diagonal text strip across one '
          'corner. Each callout points at one constructor argument.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 320,
              height: 320,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(60),
                      decoration: BoxDecoration(
                        color: kPaperDeep,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kFrame, width: 1.2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: const Banner(
                          message: 'DEBUG',
                          location: BannerLocation.topEnd,
                          color: kRedAnatomy,
                          child: Center(
                            child: Text(
                              'child',
                              style: TextStyle(
                                color: kInkSoft,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Callout: message
                  Positioned(
                    top: 14,
                    right: 4,
                    child: AnatomyCallout(
                      label: 'message',
                      detail: '"DEBUG" string',
                      tone: kRedAnatomy,
                    ),
                  ),
                  // Callout: color
                  Positioned(
                    top: 90,
                    right: 0,
                    child: AnatomyCallout(
                      label: 'color',
                      detail: 'fill of strip',
                      tone: kRedAnatomy,
                    ),
                  ),
                  // Callout: messageStyle
                  Positioned(
                    bottom: 10,
                    left: 6,
                    child: AnatomyCallout(
                      label: 'messageStyle',
                      detail: 'TextStyle?',
                      tone: kRedAnatomy,
                    ),
                  ),
                  // Callout: location
                  Positioned(
                    bottom: 90,
                    left: 4,
                    child: AnatomyCallout(
                      label: 'location',
                      detail: 'BannerLocation',
                      tone: kRedAnatomy,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const ProseBlock(
            text:
                'The diagonal strip is painted by BannerPainter as a foreground '
                'layer on top of the child. Banner does not change layout; the '
                'strip overdraws whatever lands underneath. Width and offset '
                'are computed from the painter\'s _kBannerWidth and '
                '_kBannerOffset constants and cannot be tuned via the public '
                'API.',
          ),
        ],
      ),
    );
  }
}

class AnatomyCallout extends StatelessWidget {
  const AnatomyCallout({
    super.key,
    required this.label,
    required this.detail,
    required this.tone,
  });

  final String label;
  final String detail;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: tone.withValues(alpha: 0.55), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: tone,
              letterSpacing: 0.4,
            ),
          ),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 10,
              color: kInkMute,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — LOCATION SHOWCASE (2x2 grid)
// =============================================================================

class LocationShowcase extends StatelessWidget {
  const LocationShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedLocation,
      title: '2 · BannerLocation showcase',
      subtitle:
          'Four corners — topStart, topEnd, bottomStart, bottomEnd. The '
          'strip always runs at 45° but slants in the direction that suits '
          'the corner.',
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              LocationCell(
                label: 'topStart',
                location: BannerLocation.topStart,
              ),
              LocationCell(
                label: 'topEnd',
                location: BannerLocation.topEnd,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              LocationCell(
                label: 'bottomStart',
                location: BannerLocation.bottomStart,
              ),
              LocationCell(
                label: 'bottomEnd',
                location: BannerLocation.bottomEnd,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ProseBlock(
            text:
                'BannerLocation values resolve through Directionality; "start" '
                'becomes "left" under TextDirection.ltr and "right" under '
                'TextDirection.rtl. To bypass the ambient Directionality, '
                'pass an explicit textDirection.',
          ),
        ],
      ),
    );
  }
}

class LocationCell extends StatelessWidget {
  const LocationCell({
    super.key,
    required this.label,
    required this.location,
  });

  final String label;
  final BannerLocation location;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Banner(
            message: 'DEBUG',
            location: location,
            color: kRedLocation,
            child: const FramedSurface(
              size: 130,
              label: 'child',
            ),
          ),
        ),
        const SizedBox(height: 8),
        CaptionChip(label: label, tone: kRedLocation),
      ],
    );
  }
}

// =============================================================================
// SECTION 4 — COLOR SWEEP
// =============================================================================

class ColorSweep extends StatelessWidget {
  const ColorSweep({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedColorSweep,
      title: '3 · Color sweep',
      subtitle:
          'Six different `color` values over a uniform child. The text '
          'is auto-styled white-on-color; pass messageStyle to override.',
      body: Wrap(
        spacing: 14,
        runSpacing: 14,
        alignment: WrapAlignment.center,
        children: const <Widget>[
          ColorSwatchTile(label: 'red', tone: Color(0xFFD32F2F)),
          ColorSwatchTile(label: 'blue', tone: Color(0xFF1976D2)),
          ColorSwatchTile(label: 'green', tone: Color(0xFF2E7D32)),
          ColorSwatchTile(label: 'purple', tone: Color(0xFF6A1B9A)),
          ColorSwatchTile(label: 'amber', tone: Color(0xFFF57F17)),
          ColorSwatchTile(label: 'slate', tone: Color(0xFF455A64)),
        ],
      ),
    );
  }
}

class ColorSwatchTile extends StatelessWidget {
  const ColorSwatchTile({
    super.key,
    required this.label,
    required this.tone,
  });

  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Banner(
            message: label.toUpperCase(),
            location: BannerLocation.topEnd,
            color: tone,
            child: const FramedSurface(
              size: 110,
              label: 'child',
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: tone.withValues(alpha: 0.55)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: tone,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 5 — MESSAGE VARIANTS
// =============================================================================

class MessageVariants extends StatelessWidget {
  const MessageVariants({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedMessage,
      title: '4 · Message variants',
      subtitle:
          'Override messageStyle for typographic variation: bold, italic, '
          'larger size, custom letter spacing.',
      body: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: const <Widget>[
          MessagePanel(
            message: 'DEBUG',
            badgeColor: Color(0xFFE53935),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
            note: 'extra-bold + tracking',
          ),
          MessagePanel(
            message: 'BETA',
            badgeColor: Color(0xFF6A1B9A),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
            note: 'italic, larger',
          ),
          MessagePanel(
            message: 'PROD',
            badgeColor: Color(0xFF2E7D32),
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
            ),
            note: 'wide letter-spacing',
          ),
          MessagePanel(
            message: 'v2.0',
            badgeColor: Color(0xFF455A64),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamilyFallback: <String>['monospace'],
            ),
            note: 'mono-style version tag',
          ),
        ],
      ),
    );
  }
}

class MessagePanel extends StatelessWidget {
  const MessagePanel({
    super.key,
    required this.message,
    required this.badgeColor,
    required this.style,
    required this.note,
  });

  final String message;
  final Color badgeColor;
  final TextStyle style;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Banner(
            message: message,
            location: BannerLocation.topEnd,
            color: badgeColor,
            textStyle: style,
            child: FramedSurface(
              size: 120,
              label: message,
              borderColor: badgeColor.withValues(alpha: 0.3),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 120,
          child: Text(
            note,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              color: kInkMute,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 6 — DIRECTION SHOWCASE
// =============================================================================

class DirectionShowcase extends StatelessWidget {
  const DirectionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedDirection,
      title: '5 · textDirection / layoutDirection',
      subtitle:
          'When textDirection is set explicitly, it overrides the ambient '
          'Directionality. layoutDirection controls how "start" / "end" '
          'resolve for the BannerLocation.',
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: const <Widget>[
                DirectionPanel(
                  textDirection: TextDirection.ltr,
                  layoutDirection: TextDirection.ltr,
                  caption: 'LTR text · LTR layout',
                  message: 'LTR',
                ),
                SizedBox(height: 10),
                ProseBlock(
                  text:
                      'BannerLocation.topStart resolves to top-LEFT under '
                      'LTR. The label reads naturally left-to-right along '
                      'the diagonal.',
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: const <Widget>[
                DirectionPanel(
                  textDirection: TextDirection.rtl,
                  layoutDirection: TextDirection.rtl,
                  caption: 'RTL text · RTL layout',
                  message: 'RTL',
                ),
                SizedBox(height: 10),
                ProseBlock(
                  text:
                      'Under RTL, BannerLocation.topStart resolves to '
                      'top-RIGHT. Useful when wrapping a child that is '
                      'itself RTL-laid-out.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DirectionPanel extends StatelessWidget {
  const DirectionPanel({
    super.key,
    required this.textDirection,
    required this.layoutDirection,
    required this.caption,
    required this.message,
  });

  final TextDirection textDirection;
  final TextDirection layoutDirection;
  final String caption;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Banner(
            message: message,
            location: BannerLocation.topStart,
            color: kRedDirection,
            textDirection: textDirection,
            layoutDirection: layoutDirection,
            child: const FramedSurface(
              size: 130,
              label: 'child',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: kRedDirection,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 7 — BANNERPAINTER DIRECT USAGE
// =============================================================================

class PainterDirectUsage extends StatelessWidget {
  const PainterDirectUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedPainter,
      title: '6 · BannerPainter direct usage',
      subtitle:
          'Banner is a thin wrapper around BannerPainter. You can drop the '
          'painter into any CustomPaint to get the strip without a child.',
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 240,
                height: 240,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: kPaperDeep,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kFrame, width: 1.2),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomPaint(
                        painter: BannerPainter(
                          message: 'RAW PAINTER',
                          textDirection: TextDirection.ltr,
                          layoutDirection: TextDirection.ltr,
                          location: BannerLocation.topEnd,
                          color: kRedPainter,
                        ),
                        child: const Center(
                          child: Text(
                            '240×240\nCustomPaint surface',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kInkSoft,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: CaptionChip(
                        label: 'raw painter',
                        tone: kRedPainter,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Why bypass Banner?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: kRedPainter,
                      ),
                    ),
                    SizedBox(height: 6),
                    ProseBlock(
                      text:
                          'BannerPainter is a CustomPainter, so it composes '
                          'into any paint pipeline. Wrap it in a CustomPaint '
                          'when you want the diagonal strip in a place where '
                          'a Banner widget would not fit cleanly — e.g. '
                          'inside a CustomPaint layer that already paints '
                          'other things.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Required arguments',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: kRedPainter,
                      ),
                    ),
                    SizedBox(height: 6),
                    ProseBlock(
                      text:
                          '• message (String)\n'
                          '• textDirection (TextDirection)\n'
                          '• layoutDirection (TextDirection)\n'
                          '• location (BannerLocation)\n'
                          '• color (optional, defaults to red)\n'
                          '• textStyle (optional)',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — REAL-WORLD EXAMPLES
// =============================================================================

class RealWorldExamples extends StatelessWidget {
  const RealWorldExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedRealWorld,
      title: '7 · Real-world examples',
      subtitle:
          'Three patterns where Banner ships in production: app-icon DEBUG '
          'tag, BETA preview build, internal-build watermark.',
      body: Wrap(
        spacing: 14,
        runSpacing: 14,
        alignment: WrapAlignment.center,
        children: const <Widget>[
          RealWorldCard(
            title: 'App icon · DEBUG',
            description:
                'A 96×96 launcher tile with a corner DEBUG strip. '
                'The same trick MaterialApp uses internally.',
            child: AppIconTile(),
          ),
          RealWorldCard(
            title: 'Preview build · BETA',
            description:
                'Mark a screenshot rendered in a preview build so QA can '
                'tell at a glance which channel produced it.',
            child: PreviewBuildTile(),
          ),
          RealWorldCard(
            title: 'Internal build · INTERNAL',
            description:
                'Watermark every screen with a low-priority corner banner '
                'on internal-only builds. Hide on release with kReleaseMode.',
            child: InternalBuildTile(),
          ),
        ],
      ),
    );
  }
}

class RealWorldCard extends StatelessWidget {
  const RealWorldCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kFrame, width: 1),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kRedRealWorld.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: child),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: kRedRealWorld,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11.5,
                color: kInkMute,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppIconTile extends StatelessWidget {
  const AppIconTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Banner(
        message: 'DEBUG',
        location: BannerLocation.topEnd,
        color: kRedRealWorld,
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF42A5F5), Color(0xFF1565C0)],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(
            child: Icon(
              Icons.flutter_dash,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class PreviewBuildTile extends StatelessWidget {
  const PreviewBuildTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Banner(
        message: 'BETA',
        location: BannerLocation.topStart,
        color: const Color(0xFF6A1B9A),
        child: Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            border: Border.all(color: const Color(0xFFCE93D8)),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Preview screen',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Build #4271 · channel beta',
                style: TextStyle(fontSize: 10.5, color: Color(0xFF6A1B9A)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InternalBuildTile extends StatelessWidget {
  const InternalBuildTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Banner(
        message: 'INTERNAL',
        location: BannerLocation.bottomEnd,
        color: const Color(0xFF455A64),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 8.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
        child: Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFECEFF1),
            border: Border.all(color: const Color(0xFFB0BEC5)),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Internal screen',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: Color(0xFF263238),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Hide on kReleaseMode',
                style: TextStyle(fontSize: 10.5, color: Color(0xFF455A64)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 9 — CAVEATS
// =============================================================================

class CaveatsBoard extends StatelessWidget {
  const CaveatsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      accent: kRedCaveats,
      title: '8 · Caveats',
      subtitle:
          'Banner is cosmetic and unintrusive — but it has a few sharp edges '
          'that catch first-timers.',
      body: Wrap(
        spacing: 14,
        runSpacing: 14,
        alignment: WrapAlignment.start,
        children: const <Widget>[
          CaveatCard(
            number: 'a',
            title: 'Runtime overlay only',
            body:
                'Banner paints unconditionally. Gate it behind kReleaseMode '
                '(or your own debug flag) so production users do not see it.',
          ),
          CaveatCard(
            number: 'b',
            title: 'The diagonal eats real-estate',
            body:
                'On a small child the strip can dominate. The painter '
                'constants (_kBannerWidth ≈ 26.0, _kBannerOffset ≈ 40.0) '
                'are private — pick a child large enough that the strip '
                'looks proportional.',
          ),
          CaveatCard(
            number: 'c',
            title: 'MaterialApp uses Banner',
            body:
                'MaterialApp.debugShowCheckedModeBanner: true wraps the '
                'whole app in CheckedModeBanner, which is a Banner with '
                'message: "DEBUG" at topEnd. Set it to false to suppress.',
          ),
          CaveatCard(
            number: 'd',
            title: 'No hit-test absorption',
            body:
                'Banner does not absorb pointer events. Taps under the '
                'strip still reach the child. Wrap the area with '
                'IgnorePointer if you need different hit-test behavior.',
          ),
        ],
      ),
    );
  }
}

class CaveatCard extends StatelessWidget {
  const CaveatCard({
    super.key,
    required this.number,
    required this.title,
    required this.body,
  });

  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kRedCaveats.withValues(alpha: 0.25)),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: kRedCaveats.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: kRedCaveats.withValues(alpha: 0.55),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: kRedCaveats,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: kRedCaveats,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: kInkSoft,
                      height: 1.4,
                    ),
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

// =============================================================================
// SECTION 10 — FOOTER
// =============================================================================

class GradientFooter extends StatelessWidget {
  const GradientFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[kRedHeroDeep, kInk],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kRedHeroDeep.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bookmark_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Takeaways',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const FooterBullet(
              text:
                  'Banner is a one-shot overlay: wrap a child, get a 45° '
                  'corner strip — no layout side effects.',
            ),
            const FooterBullet(
              text:
                  'Use BannerLocation + textDirection / layoutDirection to '
                  'pin the strip exactly where you want it, regardless of '
                  'ambient Directionality.',
            ),
            const FooterBullet(
              text:
                  'For non-widget contexts, drop BannerPainter directly into '
                  'a CustomPaint. The painter is the real workhorse.',
            ),
            const FooterBullet(
              text:
                  'Always gate Banner on debug-only flags in production '
                  'apps; MaterialApp already does this for you via '
                  'debugShowCheckedModeBanner.',
            ),
          ],
        ),
      ),
    );
  }
}

class FooterBullet extends StatelessWidget {
  const FooterBullet({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
