// D4rt test script: Deep Demo - DecoratedBox & Decoration Family
// Comprehensive visual showcase of DecoratedBox, BoxDecoration, ShapeDecoration,
// FlutterLogoDecoration, DecorationPosition, DecoratedBoxTransition, custom
// Decoration subclasses, gradient gallery, shadow cookbook, border styles,
// and real-world card design patterns.
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================================
// SECTION HEADER HELPER
// Re-usable visual section header with chip-style label and rule line.
// ============================================================================
Widget sectionHeader(String number, String title, String tagline, Color accent) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4.0, 24.0, 4.0, 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.35),
                blurRadius: 10.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16.0,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                tagline,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// NARRATIVE PARAGRAPH HELPER
// ============================================================================
Widget narrative(String text, Color tint) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: tint, width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.0,
        color: Colors.grey.shade800,
        height: 1.45,
      ),
    ),
  );
}

// ============================================================================
// CAPTION CHIP HELPER
// ============================================================================
Widget captionChip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ============================================================================
// LABELLED SAMPLE WRAPPER
// Renders a decorated box sample with caption underneath it.
// ============================================================================
Widget labelledSample(Widget sample, String label, Color labelColor) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sample,
        const SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            color: labelColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// CUSTOM DECORATION: DiagonalStripesDecoration
// Demonstrates extending the abstract Decoration class.
// ============================================================================
class DiagonalStripesDecoration extends Decoration {
  final Color stripeA;
  final Color stripeB;
  final double stripeWidth;
  final double angleDegrees;
  final BorderRadius borderRadius;

  const DiagonalStripesDecoration({
    required this.stripeA,
    required this.stripeB,
    this.stripeWidth = 14.0,
    this.angleDegrees = 45.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(0.0)),
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DiagonalStripesPainter(this);
  }
}

class _DiagonalStripesPainter extends BoxPainter {
  final DiagonalStripesDecoration deco;
  _DiagonalStripesPainter(this.deco);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Size size = configuration.size ?? Size.zero;
    final Rect rect = offset & size;
    final Path clipPath = Path()
      ..addRRect(deco.borderRadius.toRRect(rect));
    canvas.save();
    canvas.clipPath(clipPath);
    final Paint paintA = Paint()..color = deco.stripeA;
    final Paint paintB = Paint()..color = deco.stripeB;
    canvas.drawRect(rect, paintA);
    final double radians = deco.angleDegrees * math.pi / 180.0;
    final double dx = math.cos(radians);
    final double dy = math.sin(radians);
    final double diag = math.sqrt(size.width * size.width + size.height * size.height) * 2.0;
    final Offset center = rect.center;
    final int stripes = (diag / (deco.stripeWidth * 2.0)).ceil() + 4;
    for (int i = -stripes; i < stripes; i++) {
      final double t = i * deco.stripeWidth * 2.0;
      final Offset p1 = Offset(center.dx + t * dx - dy * diag, center.dy + t * dy + dx * diag);
      final Offset p2 = Offset(center.dx + t * dx + dy * diag, center.dy + t * dy - dx * diag);
      final Paint stripePaint = Paint()
        ..color = paintB.color
        ..strokeWidth = deco.stripeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawLine(p1, p2, stripePaint);
    }
    canvas.restore();
  }
}

// ============================================================================
// MAIN BUILD ENTRY POINT
// ============================================================================
dynamic build(BuildContext context) {
  // --------------------------------------------------------------------------
  // PALETTE DEFINITIONS
  // --------------------------------------------------------------------------
  const Color paletteIndigo = Color(0xFF3F51B5);
  const Color paletteRose = Color(0xFFE91E63);
  const Color paletteTeal = Color(0xFF009688);
  const Color paletteAmber = Color(0xFFFFB300);
  const Color paletteViolet = Color(0xFF7B1FA2);
  const Color paletteEmerald = Color(0xFF2E7D32);
  const Color paletteSlate = Color(0xFF455A64);
  const Color paletteCoral = Color(0xFFFF7043);

  // --------------------------------------------------------------------------
  // SECTION 1 - INTRODUCTION CARD
  // High-level overview of the DecoratedBox family.
  // --------------------------------------------------------------------------
  final Widget introHero = Container(
    margin: const EdgeInsets.only(bottom: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF512DA8), Color(0xFFC2185B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: paletteViolet.withValues(alpha: 0.4),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.style,
                size: 32.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DecoratedBox Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    'Decoration anatomy, gallery, shadows, gradients, shapes.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            captionChip('BoxDecoration', Colors.white),
            captionChip('ShapeDecoration', Colors.white),
            captionChip('FlutterLogoDecoration', Colors.white),
            captionChip('DecoratedBoxTransition', Colors.white),
            captionChip('Custom Decoration', Colors.white),
          ],
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 2 - COLOR FILLS
  // Build a row of decorated boxes showing solid color variations and the
  // distinction between DecoratedBox(BoxDecoration(color:)) and ColoredBox.
  // --------------------------------------------------------------------------
  final List<Color> fillPalette = <Color>[
    paletteIndigo,
    paletteRose,
    paletteTeal,
    paletteAmber,
    paletteViolet,
    paletteEmerald,
    paletteSlate,
    paletteCoral,
  ];

  final List<Widget> fillSamples = List<Widget>.generate(fillPalette.length, (int i) {
    final Color c = fillPalette[i];
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: 84.0,
          height: 64.0,
          child: Center(
            child: Text(
              '#${c.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11.0,
              ),
            ),
          ),
        ),
      ),
      'fill ${i + 1}',
      Colors.grey.shade800,
    );
  });

  // --------------------------------------------------------------------------
  // SECTION 3 - BORDER STYLE COOKBOOK
  // Demonstrates Border.all, individual BorderSide, dashed-like (BorderStyle),
  // outline + radius combinations.
  // --------------------------------------------------------------------------
  final Widget borderThin = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: paletteIndigo, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('thin 1.0px')),
    ),
  );

  final Widget borderMedium = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: paletteRose, width: 3.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('medium 3.0px')),
    ),
  );

  final Widget borderThick = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: paletteTeal, width: 6.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('thick 6.0px')),
    ),
  );

  final Widget borderMixed = DecoratedBox(
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: paletteAmber, width: 6.0),
        right: BorderSide(color: paletteTeal, width: 3.0),
        bottom: BorderSide(color: paletteRose, width: 6.0),
        left: BorderSide(color: paletteIndigo, width: 3.0),
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('mixed sides')),
    ),
  );

  final Widget borderTopOnly = DecoratedBox(
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: paletteViolet, width: 4.0),
      ),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('top accent')),
    ),
  );

  final Widget borderLeftOnly = DecoratedBox(
    decoration: const BoxDecoration(
      color: Color(0xFFF5F5F5),
      border: Border(
        left: BorderSide(color: paletteEmerald, width: 6.0),
      ),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('left rail')),
    ),
  );

  final Widget borderNoneStyle = DecoratedBox(
    decoration: BoxDecoration(
      color: paletteSlate.withValues(alpha: 0.08),
      border: Border.all(
        color: paletteSlate,
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('solid style')),
    ),
  );

  final Widget borderAsymmetricRadius = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: paletteCoral, width: 2.5),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        bottomRight: Radius.circular(20.0),
      ),
    ),
    child: const SizedBox(
      width: 130.0,
      height: 72.0,
      child: Center(child: Text('asym radius')),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 4 - BORDER RADIUS COOKBOOK
  // From sharp corners to fully pill / circular.
  // --------------------------------------------------------------------------
  final List<double> radiusValues = <double>[0.0, 4.0, 12.0, 20.0, 32.0, 999.0];
  final List<Widget> radiusSamples = List<Widget>.generate(radiusValues.length, (int i) {
    final double r = radiusValues[i];
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              paletteIndigo.withValues(alpha: 0.85),
              paletteViolet.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(r),
        ),
        child: const SizedBox(
          width: 90.0,
          height: 60.0,
        ),
      ),
      'r=${r == 999.0 ? "pill" : r.toStringAsFixed(0)}',
      paletteViolet,
    );
  });

  // --------------------------------------------------------------------------
  // SECTION 5 - SHADOW COOKBOOK
  // Soft, hard, lifted, inner-like, neon, double-layer.
  // --------------------------------------------------------------------------
  Widget shadowSample(String label, List<BoxShadow> shadows, Color labelColor) {
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: shadows,
        ),
        child: SizedBox(
          width: 130.0,
          height: 84.0,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: labelColor,
              ),
            ),
          ),
        ),
      ),
      label,
      labelColor,
    );
  }

  final Widget shadowSoft = shadowSample(
    'soft',
    <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 12.0,
        offset: const Offset(0.0, 4.0),
      ),
    ],
    paletteSlate,
  );

  final Widget shadowHard = shadowSample(
    'hard',
    <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.5),
        blurRadius: 2.0,
        offset: const Offset(4.0, 4.0),
      ),
    ],
    paletteSlate,
  );

  final Widget shadowLifted = shadowSample(
    'lifted',
    <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.18),
        blurRadius: 22.0,
        spreadRadius: 1.0,
        offset: const Offset(0.0, 12.0),
      ),
    ],
    paletteSlate,
  );

  final Widget shadowGlow = shadowSample(
    'glow',
    <BoxShadow>[
      BoxShadow(
        color: paletteRose.withValues(alpha: 0.6),
        blurRadius: 20.0,
        spreadRadius: 2.0,
      ),
    ],
    paletteRose,
  );

  final Widget shadowNeon = shadowSample(
    'neon',
    <BoxShadow>[
      BoxShadow(
        color: paletteTeal.withValues(alpha: 0.7),
        blurRadius: 10.0,
        spreadRadius: 0.5,
      ),
      BoxShadow(
        color: paletteTeal.withValues(alpha: 0.4),
        blurRadius: 24.0,
        spreadRadius: 4.0,
      ),
    ],
    paletteTeal,
  );

  final Widget shadowDouble = shadowSample(
    'double',
    <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 4.0,
        offset: const Offset(0.0, 2.0),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.10),
        blurRadius: 16.0,
        offset: const Offset(0.0, 10.0),
      ),
    ],
    paletteSlate,
  );

  final Widget shadowEmboss = shadowSample(
    'emboss',
    <BoxShadow>[
      BoxShadow(
        color: Colors.white,
        blurRadius: 6.0,
        offset: const Offset(-3.0, -3.0),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.25),
        blurRadius: 6.0,
        offset: const Offset(3.0, 3.0),
      ),
    ],
    paletteSlate,
  );

  final Widget shadowColoredTrio = shadowSample(
    'tri-tone',
    <BoxShadow>[
      BoxShadow(
        color: paletteIndigo.withValues(alpha: 0.4),
        blurRadius: 10.0,
        offset: const Offset(-6.0, 0.0),
      ),
      BoxShadow(
        color: paletteRose.withValues(alpha: 0.4),
        blurRadius: 10.0,
        offset: const Offset(6.0, 0.0),
      ),
      BoxShadow(
        color: paletteAmber.withValues(alpha: 0.4),
        blurRadius: 10.0,
        offset: const Offset(0.0, 8.0),
      ),
    ],
    paletteAmber,
  );

  // --------------------------------------------------------------------------
  // SECTION 6 - GRADIENT LAB: LINEAR
  // Cover different directions, color counts, stops.
  // --------------------------------------------------------------------------
  Widget linearGradientTile(LinearGradient gradient, String caption) {
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const SizedBox(width: 110.0, height: 80.0),
      ),
      caption,
      Colors.grey.shade800,
    );
  }

  final Widget linearTopBottom = linearGradientTile(
    const LinearGradient(
      colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    'top→bottom',
  );

  final Widget linearLeftRight = linearGradientTile(
    const LinearGradient(
      colors: [Color(0xFFFFCA28), Color(0xFFFF6F00)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    'left→right',
  );

  final Widget linearDiagonal = linearGradientTile(
    const LinearGradient(
      colors: [Color(0xFF26C6DA), Color(0xFF00838F)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'topL→botR',
  );

  final Widget linearAntiDiagonal = linearGradientTile(
    const LinearGradient(
      colors: [Color(0xFFAB47BC), Color(0xFF4A148C)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    'topR→botL',
  );

  final Widget linearTriColor = linearGradientTile(
    const LinearGradient(
      colors: [
        Color(0xFFEF5350),
        Color(0xFFFFEE58),
        Color(0xFF66BB6A),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'tri-color',
  );

  final Widget linearStops = linearGradientTile(
    const LinearGradient(
      colors: [
        Color(0xFF1E88E5),
        Color(0xFF1E88E5),
        Color(0xFFE53935),
        Color(0xFFE53935),
      ],
      stops: [0.0, 0.5, 0.5, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    'stops split',
  );

  final Widget linearRainbow = linearGradientTile(
    const LinearGradient(
      colors: [
        Color(0xFFE53935),
        Color(0xFFFB8C00),
        Color(0xFFFDD835),
        Color(0xFF43A047),
        Color(0xFF1E88E5),
        Color(0xFF8E24AA),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    'rainbow',
  );

  final Widget linearSubtle = linearGradientTile(
    LinearGradient(
      colors: [
        paletteSlate.withValues(alpha: 0.06),
        paletteSlate.withValues(alpha: 0.20),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    'subtle gray',
  );

  // --------------------------------------------------------------------------
  // SECTION 7 - GRADIENT LAB: RADIAL
  // --------------------------------------------------------------------------
  Widget radialGradientTile(RadialGradient gradient, String caption) {
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const SizedBox(width: 110.0, height: 80.0),
      ),
      caption,
      Colors.grey.shade800,
    );
  }

  final Widget radialCenter = radialGradientTile(
    const RadialGradient(
      colors: [Color(0xFFFFE082), Color(0xFFFF6F00)],
      center: Alignment.center,
      radius: 0.8,
    ),
    'center',
  );

  final Widget radialOffset = radialGradientTile(
    const RadialGradient(
      colors: [Color(0xFFB3E5FC), Color(0xFF01579B)],
      center: Alignment(-0.6, -0.6),
      radius: 1.0,
    ),
    'top-left',
  );

  final Widget radialFocal = radialGradientTile(
    const RadialGradient(
      colors: [Color(0xFFF8BBD0), Color(0xFFAD1457)],
      center: Alignment.center,
      radius: 1.2,
      focal: Alignment(0.4, 0.4),
      focalRadius: 0.05,
    ),
    'focal point',
  );

  final Widget radialThreeStop = radialGradientTile(
    const RadialGradient(
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFF80DEEA),
        Color(0xFF006064),
      ],
      stops: [0.0, 0.4, 1.0],
      radius: 0.85,
    ),
    '3-stop',
  );

  final Widget radialTight = radialGradientTile(
    const RadialGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFF000000)],
      radius: 0.4,
    ),
    'tight',
  );

  final Widget radialWide = radialGradientTile(
    const RadialGradient(
      colors: [Color(0xFFE1BEE7), Color(0xFF4A148C)],
      radius: 1.4,
    ),
    'wide',
  );

  // --------------------------------------------------------------------------
  // SECTION 8 - GRADIENT LAB: SWEEP
  // --------------------------------------------------------------------------
  Widget sweepGradientTile(SweepGradient gradient, String caption) {
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const SizedBox(width: 110.0, height: 80.0),
      ),
      caption,
      Colors.grey.shade800,
    );
  }

  final Widget sweepFull = sweepGradientTile(
    const SweepGradient(
      colors: [
        Color(0xFFE53935),
        Color(0xFFFB8C00),
        Color(0xFFFDD835),
        Color(0xFF43A047),
        Color(0xFF1E88E5),
        Color(0xFF8E24AA),
        Color(0xFFE53935),
      ],
    ),
    'full sweep',
  );

  final Widget sweepHalf = sweepGradientTile(
    SweepGradient(
      colors: <Color>[paletteIndigo, paletteRose],
      startAngle: 0.0,
      endAngle: math.pi,
    ),
    'half',
  );

  final Widget sweepQuarter = sweepGradientTile(
    SweepGradient(
      colors: <Color>[paletteTeal, paletteAmber],
      startAngle: 0.0,
      endAngle: math.pi / 2.0,
    ),
    'quarter',
  );

  final Widget sweepDuo = sweepGradientTile(
    const SweepGradient(
      colors: [
        Color(0xFF00ACC1),
        Color(0xFFEF5350),
        Color(0xFF00ACC1),
      ],
    ),
    'duo loop',
  );

  // --------------------------------------------------------------------------
  // SECTION 9 - SHAPE: CIRCLE & PILL
  // Demonstrates BoxShape.circle and pill-shaped boxes.
  // --------------------------------------------------------------------------
  final List<Color> circlePalette = <Color>[
    paletteIndigo,
    paletteRose,
    paletteTeal,
    paletteAmber,
    paletteViolet,
    paletteEmerald,
  ];

  final List<Widget> circleSamples = List<Widget>.generate(circlePalette.length, (int i) {
    final Color c = circlePalette[i];
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.5),
              blurRadius: 12.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: SizedBox(
          width: 64.0,
          height: 64.0,
          child: Center(
            child: Text(
              '${i + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  });

  final List<Widget> pillSamples = List<Widget>.generate(4, (int i) {
    final List<Color> tones = <Color>[paletteIndigo, paletteRose, paletteTeal, paletteAmber];
    final List<String> labels = <String>['NEW', 'HOT', 'BETA', 'PRO'];
    final Color c = tones[i];
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[c, c.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(999.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            labels[i],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  });

  // --------------------------------------------------------------------------
  // SECTION 10 - SHAPEDECORATION SHAPES
  // CircleBorder, BeveledRectangleBorder, StadiumBorder, StarBorder,
  // RoundedRectangleBorder.
  // --------------------------------------------------------------------------
  Widget shapeDecoSample(ShapeBorder shape, Color color, String label) {
    return labelledSample(
      DecoratedBox(
        decoration: ShapeDecoration(
          color: color,
          shape: shape,
          shadows: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 12.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: SizedBox(
          width: 90.0,
          height: 90.0,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      label,
      Colors.grey.shade800,
    );
  }

  final Widget shapeCircle = shapeDecoSample(
    const CircleBorder(),
    paletteIndigo,
    'circle',
  );

  final Widget shapeStadium = shapeDecoSample(
    const StadiumBorder(),
    paletteRose,
    'stadium',
  );

  final Widget shapeBeveled = shapeDecoSample(
    const BeveledRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    paletteTeal,
    'beveled',
  );

  final Widget shapeRounded = shapeDecoSample(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18.0)),
    ),
    paletteAmber,
    'rounded',
  );

  final Widget shapeStar5 = shapeDecoSample(
    const StarBorder(points: 5.0, innerRadiusRatio: 0.5),
    paletteViolet,
    'star-5',
  );

  final Widget shapeStar7 = shapeDecoSample(
    const StarBorder(points: 7.0, innerRadiusRatio: 0.6),
    paletteEmerald,
    'star-7',
  );

  final Widget shapeStarPoly = shapeDecoSample(
    const StarBorder.polygon(sides: 6.0),
    paletteCoral,
    'hex polygon',
  );

  final Widget shapeStarPoly8 = shapeDecoSample(
    const StarBorder.polygon(sides: 8.0),
    paletteSlate,
    'octa polygon',
  );

  // --------------------------------------------------------------------------
  // SECTION 11 - SHAPEDECORATION WITH GRADIENT
  // --------------------------------------------------------------------------
  final Widget gradientShapeRounded = labelledSample(
    DecoratedBox(
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7E57C2), Color(0xFFEC407A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      child: const SizedBox(width: 130.0, height: 80.0),
    ),
    'rounded + gradient',
    Colors.grey.shade800,
  );

  final Widget gradientShapeStadium = labelledSample(
    DecoratedBox(
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00B0FF), Color(0xFF00E5FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: StadiumBorder(),
      ),
      child: const SizedBox(width: 130.0, height: 60.0),
    ),
    'stadium + gradient',
    Colors.grey.shade800,
  );

  final Widget gradientShapeCircle = labelledSample(
    DecoratedBox(
      decoration: const ShapeDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFFFFEB3B), Color(0xFFFF5722)],
          radius: 0.9,
        ),
        shape: CircleBorder(),
      ),
      child: const SizedBox(width: 90.0, height: 90.0),
    ),
    'circle + radial',
    Colors.grey.shade800,
  );

  final Widget gradientShapeStar = labelledSample(
    DecoratedBox(
      decoration: const ShapeDecoration(
        gradient: SweepGradient(
          colors: [
            Color(0xFFFF5252),
            Color(0xFFFFEB3B),
            Color(0xFF69F0AE),
            Color(0xFF448AFF),
            Color(0xFFFF5252),
          ],
        ),
        shape: StarBorder(points: 6.0, innerRadiusRatio: 0.5),
      ),
      child: const SizedBox(width: 110.0, height: 110.0),
    ),
    'star + sweep',
    Colors.grey.shade800,
  );

  // --------------------------------------------------------------------------
  // SECTION 12 - DECORATIONPOSITION: background vs foreground
  // Compare DecorationPosition.background (default) and foreground overlays.
  // --------------------------------------------------------------------------
  final Widget positionBackground = DecoratedBox(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF26C6DA), Color(0xFF7E57C2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    position: DecorationPosition.background,
    child: const SizedBox(
      width: 180.0,
      height: 100.0,
      child: Center(
        child: Text(
          'background\nDecorationPosition',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13.0,
          ),
        ),
      ),
    ),
  );

  final Widget positionForeground = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14.0),
      gradient: LinearGradient(
        colors: <Color>[
          Colors.black.withValues(alpha: 0.0),
          Colors.black.withValues(alpha: 0.55),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    position: DecorationPosition.foreground,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: paletteAmber,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: const SizedBox(
        width: 180.0,
        height: 100.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'foreground overlay\ndarkens the child',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 13 - BACKGROUND BLEND MODES
  // --------------------------------------------------------------------------
  Widget blendModeTile(BlendMode mode, String name) {
    return labelledSample(
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFCDD2), Color(0xFFBBDEFB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: paletteIndigo.withValues(alpha: 0.6),
          backgroundBlendMode: mode,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const SizedBox(width: 96.0, height: 64.0),
      ),
      name,
      Colors.grey.shade800,
    );
  }

  final Widget blendSrcOver = blendModeTile(BlendMode.srcOver, 'srcOver');
  final Widget blendMultiply = blendModeTile(BlendMode.multiply, 'multiply');
  final Widget blendScreen = blendModeTile(BlendMode.screen, 'screen');
  final Widget blendOverlay = blendModeTile(BlendMode.overlay, 'overlay');
  final Widget blendDarken = blendModeTile(BlendMode.darken, 'darken');
  final Widget blendLighten = blendModeTile(BlendMode.lighten, 'lighten');
  final Widget blendDifference = blendModeTile(BlendMode.difference, 'difference');
  final Widget blendExclusion = blendModeTile(BlendMode.exclusion, 'exclusion');

  // --------------------------------------------------------------------------
  // SECTION 14 - FLUTTERLOGODECORATION
  // Three logo styles: markOnly, horizontal, stacked.
  // --------------------------------------------------------------------------
  final Widget logoMark = labelledSample(
    DecoratedBox(
      decoration: const FlutterLogoDecoration(
        style: FlutterLogoStyle.markOnly,
      ),
      child: const SizedBox(width: 96.0, height: 96.0),
    ),
    'markOnly',
    Colors.grey.shade800,
  );

  final Widget logoHorizontal = labelledSample(
    DecoratedBox(
      decoration: const FlutterLogoDecoration(
        style: FlutterLogoStyle.horizontal,
        textColor: Color(0xFF455A64),
      ),
      child: const SizedBox(width: 160.0, height: 80.0),
    ),
    'horizontal',
    Colors.grey.shade800,
  );

  final Widget logoStacked = labelledSample(
    DecoratedBox(
      decoration: const FlutterLogoDecoration(
        style: FlutterLogoStyle.stacked,
        textColor: Color(0xFF1A237E),
      ),
      child: const SizedBox(width: 128.0, height: 128.0),
    ),
    'stacked',
    Colors.grey.shade800,
  );

  // --------------------------------------------------------------------------
  // SECTION 15 - DECORATEDBOXTRANSITION DEMO
  // Animate between two BoxDecoration states using a static AnimationController
  // proxy: AlwaysStoppedAnimation drives a snapshot for non-stateful demo.
  // --------------------------------------------------------------------------
  final DecorationTween decoTween = DecorationTween(
    begin: BoxDecoration(
      color: paletteIndigo,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteIndigo.withValues(alpha: 0.5),
          blurRadius: 8.0,
        ),
      ],
    ),
    end: BoxDecoration(
      color: paletteRose,
      borderRadius: BorderRadius.circular(48.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteRose.withValues(alpha: 0.6),
          blurRadius: 24.0,
          spreadRadius: 2.0,
        ),
      ],
    ),
  );

  Widget transitionFrame(double t, String caption) {
    final AlwaysStoppedAnimation<double> anim = AlwaysStoppedAnimation<double>(t);
    final Animation<Decoration> decorationAnim = decoTween.animate(anim);
    return labelledSample(
      DecoratedBoxTransition(
        decoration: decorationAnim,
        child: const SizedBox(width: 96.0, height: 64.0),
      ),
      caption,
      Colors.grey.shade800,
    );
  }

  final List<Widget> transitionFrames = List<Widget>.generate(6, (int i) {
    final double t = i / 5.0;
    return transitionFrame(t, 't=${t.toStringAsFixed(2)}');
  });

  // --------------------------------------------------------------------------
  // SECTION 16 - CUSTOM DECORATION (DiagonalStripesDecoration)
  // --------------------------------------------------------------------------
  final Widget customStripeA = labelledSample(
    DecoratedBox(
      decoration: DiagonalStripesDecoration(
        stripeA: paletteIndigo,
        stripeB: paletteAmber,
        stripeWidth: 10.0,
        angleDegrees: 45.0,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const SizedBox(width: 130.0, height: 80.0),
    ),
    'custom 45°',
    Colors.grey.shade800,
  );

  final Widget customStripeB = labelledSample(
    DecoratedBox(
      decoration: DiagonalStripesDecoration(
        stripeA: paletteRose,
        stripeB: Colors.white,
        stripeWidth: 6.0,
        angleDegrees: 25.0,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const SizedBox(width: 130.0, height: 80.0),
    ),
    'custom 25°',
    Colors.grey.shade800,
  );

  final Widget customStripeC = labelledSample(
    DecoratedBox(
      decoration: DiagonalStripesDecoration(
        stripeA: paletteTeal,
        stripeB: paletteEmerald,
        stripeWidth: 16.0,
        angleDegrees: 90.0,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const SizedBox(width: 130.0, height: 80.0),
    ),
    'custom 90°',
    Colors.grey.shade800,
  );

  // --------------------------------------------------------------------------
  // SECTION 17 - REAL-WORLD CARD DESIGNS
  // Bordered + shadowed product cards, glass card, ticket card, info banner.
  // --------------------------------------------------------------------------
  final Widget productCard = Container(
    width: 280.0,
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF42A5F5), Color(0xFFAB47BC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: const SizedBox(
            height: 120.0,
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'PRODUCT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Decoration Toolkit',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'A curated set of gradients, shadows and shapes for modern Flutter UI.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  captionChip('NEW', paletteRose),
                  const SizedBox(width: 6.0),
                  captionChip('PRO', paletteTeal),
                  const Spacer(),
                  const Text(
                    '\$24',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: paletteIndigo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget glassCard = Container(
    width: 280.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.white.withValues(alpha: 0.7),
          Colors.white.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.8),
        width: 1.4,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteIndigo.withValues(alpha: 0.18),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF26C6DA), Color(0xFF7E57C2)],
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: paletteViolet.withValues(alpha: 0.4),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: const SizedBox(
                width: 42.0,
                height: 42.0,
                child: Icon(Icons.bolt, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Glass Surface',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Frosted decoration sample',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF607D8B)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          height: 6.0,
          decoration: BoxDecoration(
            color: paletteSlate.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.65,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF26C6DA), Color(0xFF7E57C2)],
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  final Widget ticketCard = Container(
    width: 280.0,
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFF7043), Color(0xFFE53935)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteCoral.withValues(alpha: 0.4),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BOARDING PASS',
          style: TextStyle(
            color: Colors.white70,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w700,
            fontSize: 11.0,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'BER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Berlin',
                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                ),
              ],
            ),
            Icon(
              Icons.flight,
              color: Colors.white.withValues(alpha: 0.9),
              size: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'NRT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Tokyo',
                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          height: 1.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'GATE  A12',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            Text(
              'SEAT  14C',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget infoBanner = Container(
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: paletteAmber.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: paletteAmber, width: 5.0),
      ),
    ),
    padding: const EdgeInsets.all(14.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.lightbulb_outline,
          color: paletteAmber,
          size: 22.0,
        ),
        const SizedBox(width: 10.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Decoration tip',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: paletteAmber,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Use DecoratedBox over Container when you only need a decoration. '
                'It avoids the layout overhead of Container.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 18 - FOREGROUND OVERLAY GALLERY
  // Show decoration position foreground used to add overlay text / shadow.
  // --------------------------------------------------------------------------
  Widget posterTile(Color baseColor, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.transparent,
              Colors.black.withValues(alpha: 0.65),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(14.0),
        ),
        position: DecorationPosition.foreground,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: SizedBox(
            width: 140.0,
            height: 130.0,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: Icon(
                    icon,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 36.0,
                  ),
                ),
                Positioned(
                  left: 12.0,
                  bottom: 12.0,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> posters = <Widget>[
    posterTile(paletteIndigo, Icons.cloud, 'Cloud'),
    posterTile(paletteRose, Icons.local_florist, 'Spring'),
    posterTile(paletteTeal, Icons.spa, 'Calm'),
    posterTile(paletteAmber, Icons.wb_sunny, 'Summer'),
    posterTile(paletteViolet, Icons.nights_stay, 'Night'),
    posterTile(paletteEmerald, Icons.forest, 'Forest'),
  ];

  // --------------------------------------------------------------------------
  // SECTION 19 - SUMMARY METRICS BAR
  // Show the counts produced by the demo using DecoratedBox metric pills.
  // --------------------------------------------------------------------------
  Widget metricPill(String value, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[color, color.withValues(alpha: 0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 12.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: SizedBox(
          width: 130.0,
          height: 84.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Widget metricsBar = Wrap(
    alignment: WrapAlignment.center,
    children: <Widget>[
      metricPill('${fillSamples.length}', 'fills', paletteIndigo),
      metricPill('${radiusSamples.length}', 'radii', paletteRose),
      metricPill('8', 'shadows', paletteTeal),
      metricPill('22', 'gradients', paletteAmber),
      metricPill('${circleSamples.length}', 'circles', paletteViolet),
      metricPill('8', 'shapes', paletteEmerald),
      metricPill('${transitionFrames.length}', 'frames', paletteCoral),
      metricPill('3', 'logos', paletteSlate),
    ],
  );

  // --------------------------------------------------------------------------
  // SECTION 20 - KEY TAKEAWAYS LIST
  // --------------------------------------------------------------------------
  final List<String> takeaways = <String>[
    'DecoratedBox is the lightweight render-only sibling of Container.',
    'BoxDecoration combines color/gradient/border/borderRadius/boxShadow/shape/backgroundBlendMode.',
    'ShapeDecoration accepts any ShapeBorder: circle, stadium, beveled, rounded, star, polygon.',
    'FlutterLogoDecoration ships three styles: markOnly, horizontal, stacked.',
    'DecorationPosition.foreground paints OVER the child; background paints UNDER it.',
    'DecoratedBoxTransition animates between two Decoration states via a DecorationTween.',
    'You can subclass Decoration & BoxPainter to define entirely custom paints.',
    'Use withValues(alpha:) instead of withOpacity for correct color channel handling.',
    'Prefer DecoratedBox + SizedBox over Container when no padding/margin is needed.',
    'Multiple BoxShadow entries stack to produce neon, embossed, or layered effects.',
  ];

  final List<Widget> takeawayItems = List<Widget>.generate(takeaways.length, (int i) {
    final List<Color> tints = <Color>[
      paletteIndigo,
      paletteRose,
      paletteTeal,
      paletteAmber,
      paletteViolet,
      paletteEmerald,
      paletteSlate,
      paletteCoral,
    ];
    final Color tint = tints[i % tints.length];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: tint.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 26.0,
              height: 26.0,
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              takeaways[i],
              style: const TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  });

  // --------------------------------------------------------------------------
  // BUILD THE COMPLETE SCROLLABLE LAYOUT
  // --------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFA),
    appBar: AppBar(
      title: const Text(
        'DecoratedBox Deep Demo',
        style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.4),
      ),
      backgroundColor: paletteIndigo,
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          introHero,
          sectionHeader('01', 'Color Fills', 'BoxDecoration.color basics', paletteIndigo),
          narrative(
            'A simple solid color is the foundation of every decoration. Below we render '
            'eight palette swatches inside DecoratedBox wrappers. Each tile prints its '
            'hex value so you can copy/paste the design tokens directly.',
            paletteIndigo,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: fillSamples,
          ),
          sectionHeader('02', 'Border Cookbook', 'Border.all and asymmetric sides', paletteRose),
          narrative(
            'Borders can be applied uniformly with Border.all, or per-side using the '
            'Border() constructor. Combine with borderRadius for soft corners — and use '
            'asymmetric BorderRadius.only for distinctive shapes.',
            paletteRose,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: <Widget>[
              borderThin,
              borderMedium,
              borderThick,
              borderMixed,
              borderTopOnly,
              borderLeftOnly,
              borderNoneStyle,
              borderAsymmetricRadius,
            ],
          ),
          sectionHeader('03', 'Border Radius', 'From sharp to fully pill', paletteTeal),
          narrative(
            'The borderRadius parameter accepts any BorderRadius geometry. Pass a very '
            'large value (or BorderRadius.circular(999)) to produce a fully pill or '
            'circular shape from rectangular bounds.',
            paletteTeal,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: radiusSamples,
          ),
          sectionHeader('04', 'Shadow Cookbook', 'Soft, hard, glow, neon and emboss', paletteSlate),
          narrative(
            'BoxShadow is composed of color, blurRadius, spreadRadius and offset. '
            'Stack multiple shadows to build neon halos, embossed buttons, or layered '
            'depth. Animate alpha through withValues for hover/focus states.',
            paletteSlate,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              shadowSoft,
              shadowHard,
              shadowLifted,
              shadowGlow,
              shadowNeon,
              shadowDouble,
              shadowEmboss,
              shadowColoredTrio,
            ],
          ),
          sectionHeader('05', 'Linear Gradients', 'Direction, stops, rainbow', paletteAmber),
          narrative(
            'LinearGradient flows in a straight line between begin and end Alignment '
            'points. Add explicit stops to create hard color transitions or stripes. '
            'Up to as many colors as your palette demands.',
            paletteAmber,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              linearTopBottom,
              linearLeftRight,
              linearDiagonal,
              linearAntiDiagonal,
              linearTriColor,
              linearStops,
              linearRainbow,
              linearSubtle,
            ],
          ),
          sectionHeader('06', 'Radial Gradients', 'Center, focal, multi-stop', paletteViolet),
          narrative(
            'RadialGradient blooms outward from a center point. Provide a focal point '
            'for an off-center light source effect, or shrink the radius for a tightly '
            'concentrated spotlight.',
            paletteViolet,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              radialCenter,
              radialOffset,
              radialFocal,
              radialThreeStop,
              radialTight,
              radialWide,
            ],
          ),
          sectionHeader('07', 'Sweep Gradients', 'Conic & color wheels', paletteEmerald),
          narrative(
            'SweepGradient rotates colors around a center, creating conic / pie / color '
            'wheel effects. Constrain startAngle and endAngle to draw only an arc.',
            paletteEmerald,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              sweepFull,
              sweepHalf,
              sweepQuarter,
              sweepDuo,
            ],
          ),
          sectionHeader('08', 'Circle & Pill', 'BoxShape.circle and large radii', paletteCoral),
          narrative(
            'BoxShape.circle turns any DecoratedBox into a perfect circle (clipping to '
            'the shortest side). For pills, use BoxShape.rectangle plus a borderRadius '
            'of half the height.',
            paletteCoral,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: circleSamples,
          ),
          const SizedBox(height: 6.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: pillSamples,
          ),
          sectionHeader('09', 'ShapeDecoration', 'Stadium, beveled, star, polygon', paletteIndigo),
          narrative(
            'ShapeDecoration accepts a ShapeBorder, opening the door to stadiums, '
            'beveled rectangles, n-pointed stars, and polygonal silhouettes. Combine '
            'with gradients to make award badges and stickers.',
            paletteIndigo,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              shapeCircle,
              shapeStadium,
              shapeBeveled,
              shapeRounded,
              shapeStar5,
              shapeStar7,
              shapeStarPoly,
              shapeStarPoly8,
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              gradientShapeRounded,
              gradientShapeStadium,
              gradientShapeCircle,
              gradientShapeStar,
            ],
          ),
          sectionHeader('10', 'DecorationPosition', 'background vs foreground', paletteRose),
          narrative(
            'DecorationPosition.background (default) paints the decoration UNDER the '
            'child. DecorationPosition.foreground paints it OVER the child — useful '
            'for top-bottom gradient scrims that improve text legibility.',
            paletteRose,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14.0,
            runSpacing: 14.0,
            children: <Widget>[
              positionBackground,
              positionForeground,
            ],
          ),
          sectionHeader('11', 'Foreground Posters', 'Real overlay scrim use-cases', paletteSlate),
          narrative(
            'A common pattern is to apply a foreground gradient that darkens the bottom '
            'of an image-like surface, then position text on top for guaranteed contrast.',
            paletteSlate,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: posters,
          ),
          sectionHeader('12', 'Blend Modes', 'backgroundBlendMode showcase', paletteTeal),
          narrative(
            'When BoxDecoration has both a color and a gradient (or image), the '
            'backgroundBlendMode controls how they combine. Multiply darkens, screen '
            'lightens, overlay enhances contrast.',
            paletteTeal,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              blendSrcOver,
              blendMultiply,
              blendScreen,
              blendOverlay,
              blendDarken,
              blendLighten,
              blendDifference,
              blendExclusion,
            ],
          ),
          sectionHeader('13', 'FlutterLogoDecoration', 'Built-in logo decoration', paletteViolet),
          narrative(
            'FlutterLogoDecoration paints the Flutter logo as a Decoration. It has '
            'three styles — markOnly, horizontal, stacked — and supports textColor '
            'customization for use on any background.',
            paletteViolet,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: <Widget>[
              logoMark,
              logoHorizontal,
              logoStacked,
            ],
          ),
          sectionHeader('14', 'DecoratedBoxTransition', 'Tween between decorations', paletteAmber),
          narrative(
            'DecoratedBoxTransition rebuilds when the bound Animation<Decoration> ticks. '
            'Here we sample six static frames from a DecorationTween that morphs from '
            'a square indigo card with subtle shadow to a pill-shaped rose card with a '
            'glowing shadow.',
            paletteAmber,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: transitionFrames,
          ),
          sectionHeader('15', 'Custom Decoration', 'Subclassing Decoration & BoxPainter', paletteEmerald),
          narrative(
            'For unique looks, subclass Decoration and provide a BoxPainter. The painter '
            'receives the canvas and the size, and is free to draw anything. Below: a '
            'DiagonalStripesDecoration that paints adjustable angle stripes.',
            paletteEmerald,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: <Widget>[
              customStripeA,
              customStripeB,
              customStripeC,
            ],
          ),
          sectionHeader('16', 'Real-World Cards', 'Production-grade compositions', paletteCoral),
          narrative(
            'The previous sections covered atoms. Below: complete molecules — a product '
            'card, a glass surface, an airline ticket and an info banner — each built '
            'with stacked DecoratedBox and BoxDecoration primitives.',
            paletteCoral,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              productCard,
              glassCard,
              ticketCard,
            ],
          ),
          infoBanner,
          sectionHeader('17', 'Metrics', 'Counts produced by this demo', paletteIndigo),
          metricsBar,
          sectionHeader('18', 'Key Takeaways', 'Quick reference for the decoration family', paletteRose),
          Column(
            children: takeawayItems,
          ),
          const SizedBox(height: 24.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: paletteSlate.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: paletteSlate.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: const Text(
              'End of DecoratedBox deep demo. Scroll back to revisit any section, '
              'or extend the script with image-backed decorations and rounded '
              'super-ellipse shapes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: paletteSlate,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
