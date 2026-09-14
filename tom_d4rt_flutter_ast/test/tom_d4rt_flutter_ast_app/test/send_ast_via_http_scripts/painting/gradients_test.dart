// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demonstration of the painting Gradient family.
// Covers Gradient (abstract), LinearGradient, RadialGradient, SweepGradient,
// TileMode interaction, GradientRotation, Gradient.lerp and real-world usage.
import 'package:flutter/material.dart';

// ============================================================
// Helper: section header banner
// ============================================================
Widget _sectionHeader(
  String number,
  String title,
  String subtitle,
  IconData icon,
  List<Color> colors,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: colors.last.withValues(alpha: 0.45),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 24.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      number,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: gradient swatch card with caption + code line
// ============================================================
Widget _swatchCard({
  required String title,
  required String code,
  required Gradient gradient,
  double width = 180.0,
  double height = 110.0,
  Color accent = const Color(0xFF6750A4),
}) {
  return Container(
    width: width + 24.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.35),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: Colors.grey.shade800,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: labeled property pill for anatomy diagram
// ============================================================
Widget _propertyPill(String label, String value, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: color.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: footgun card
// ============================================================
Widget _footgunCard(
  String title,
  String body,
  String fix,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: color.withValues(alpha: 0.5),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14.0,
                      color: Colors.green.shade700,
                    ),
                    SizedBox(width: 6.0),
                    Flexible(
                      child: Text(
                        fix,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: Colors.green.shade900,
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

// ============================================================
// Helper: recap row item
// ============================================================
Widget _recapRow(String label, String text, Color color, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.0, color: color),
        SizedBox(width: 8.0),
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Build entry point
// ============================================================
dynamic build(BuildContext context) {
  print('Gradients Deep Demo executing');

  // Vibrant prismatic palette used throughout.
  final Color prismPink = Color(0xFFFF3D8A);
  final Color prismOrange = Color(0xFFFF8A3D);
  final Color prismAmber = Color(0xFFFFC93D);
  final Color prismTeal = Color(0xFF2DD4BF);
  final Color prismViolet = Color(0xFF8B5CF6);
  final Color prismBlue = Color(0xFF3D6EFF);
  final Color prismLime = Color(0xFFA3E635);
  final Color prismMagenta = Color(0xFFD946EF);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.only(bottom: 20.0),
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          prismMagenta,
          prismPink,
          prismOrange,
          prismAmber,
          prismTeal,
          prismViolet,
        ],
        stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: prismViolet.withValues(alpha: 0.55),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: prismPink.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, -4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.gradient,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Painting Gradients',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Linear / Radial / Sweep — visual deep dive',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          children: [
            _propertyPill('class', 'Gradient', Colors.white),
            _propertyPill('subtype', 'LinearGradient', Colors.white),
            _propertyPill('subtype', 'RadialGradient', Colors.white),
            _propertyPill('subtype', 'SweepGradient', Colors.white),
            _propertyPill('lib', 'painting.dart', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyGradient = LinearGradient(
    colors: [prismPink, prismAmber, prismTeal, prismViolet],
    stops: [0.0, 0.35, 0.7, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.clamp,
    transform: GradientRotation(0.15),
  );
  print('Anatomy gradient colors: ${anatomyGradient.colors.length}');
  print('Anatomy gradient stops: ${anatomyGradient.stops}');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a Gradient',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Every Gradient subclass shares this skeleton.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 140.0,
          decoration: BoxDecoration(
            gradient: anatomyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'sample swatch',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: [
            _propertyPill('colors', '4 colors', prismPink),
            _propertyPill('stops', '[0.0, .35, .7, 1.0]', prismAmber),
            _propertyPill('begin/end', 'topLeft → bottomRight', prismTeal),
            _propertyPill('tileMode', 'clamp', prismViolet),
            _propertyPill('transform', 'GradientRotation(0.15)', prismBlue),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'LinearGradient(\n'
            '  colors: [pink, amber, teal, violet],\n'
            '  stops:  [0.0, 0.35, 0.7, 1.0],\n'
            '  begin:  Alignment.topLeft,\n'
            '  end:    Alignment.bottomRight,\n'
            '  tileMode: TileMode.clamp,\n'
            '  transform: GradientRotation(0.15),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: LinearGradient showcase (6 cards)
  // ============================================================
  print('=== Section 3: LinearGradient Showcase ===');

  final linearCards = <Widget>[
    _swatchCard(
      title: 'Horizontal',
      code: 'begin: centerLeft\nend:   centerRight',
      accent: prismPink,
      gradient: LinearGradient(
        colors: [prismPink, prismAmber],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    _swatchCard(
      title: 'Vertical',
      code: 'begin: topCenter\nend:   bottomCenter',
      accent: prismOrange,
      gradient: LinearGradient(
        colors: [prismAmber, prismOrange],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    _swatchCard(
      title: 'Diagonal',
      code: 'begin: topLeft\nend:   bottomRight',
      accent: prismTeal,
      gradient: LinearGradient(
        colors: [prismTeal, prismBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    _swatchCard(
      title: 'Multi-stop (explicit)',
      code: 'stops: [0, .15, .85, 1]',
      accent: prismViolet,
      gradient: LinearGradient(
        colors: [prismViolet, prismMagenta, prismOrange, prismAmber],
        stops: [0.0, 0.15, 0.85, 1.0],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    _swatchCard(
      title: '3-color triad',
      code: 'colors: [pink, teal, violet]',
      accent: prismMagenta,
      gradient: LinearGradient(
        colors: [prismPink, prismTeal, prismViolet],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    _swatchCard(
      title: '5-color rainbow',
      code: '5 prismatic stops',
      accent: prismBlue,
      gradient: LinearGradient(
        colors: [
          prismPink,
          prismOrange,
          prismAmber,
          prismTeal,
          prismViolet,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ];
  print('Created ${linearCards.length} LinearGradient cards');

  // ============================================================
  // SECTION 4: RadialGradient showcase (5 cards)
  // ============================================================
  print('=== Section 4: RadialGradient Showcase ===');

  final radialCards = <Widget>[
    _swatchCard(
      title: 'Default center',
      code: 'center: Alignment.center\nradius: 0.5',
      accent: prismAmber,
      gradient: RadialGradient(
        colors: [prismAmber, prismOrange, prismPink],
        center: Alignment.center,
        radius: 0.5,
      ),
    ),
    _swatchCard(
      title: 'Wide radius',
      code: 'radius: 1.2',
      accent: prismTeal,
      gradient: RadialGradient(
        colors: [Colors.white, prismTeal, prismBlue],
        center: Alignment.center,
        radius: 1.2,
      ),
    ),
    _swatchCard(
      title: 'Off-center focal',
      code: 'focal: (-0.5, -0.5)\nfocalRadius: 0.05',
      accent: prismMagenta,
      gradient: RadialGradient(
        colors: [Colors.white, prismMagenta, prismViolet],
        center: Alignment(0.2, 0.2),
        focal: Alignment(-0.5, -0.5),
        focalRadius: 0.05,
        radius: 0.9,
      ),
    ),
    _swatchCard(
      title: 'Ring (mid stops)',
      code: 'stops: [0, .55, .65, 1]',
      accent: prismViolet,
      gradient: RadialGradient(
        colors: [
          Colors.transparent,
          prismViolet,
          prismMagenta,
          Colors.transparent,
        ],
        stops: [0.0, 0.55, 0.65, 1.0],
        radius: 0.7,
      ),
    ),
    _swatchCard(
      title: '4-color glow',
      code: '4 stops, white core',
      accent: prismPink,
      gradient: RadialGradient(
        colors: [Colors.white, prismAmber, prismPink, prismViolet],
        stops: [0.0, 0.35, 0.7, 1.0],
        radius: 0.85,
      ),
    ),
  ];
  print('Created ${radialCards.length} RadialGradient cards');

  // ============================================================
  // SECTION 5: SweepGradient showcase (4 cards)
  // ============================================================
  print('=== Section 5: SweepGradient Showcase ===');

  final twoPi = 6.283185307179586;
  final sweepCards = <Widget>[
    _swatchCard(
      title: 'Full sweep (0 → 2π)',
      code: 'startAngle: 0\nendAngle:   2π',
      accent: prismBlue,
      gradient: SweepGradient(
        colors: [prismPink, prismAmber, prismTeal, prismViolet, prismPink],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        startAngle: 0.0,
        endAngle: twoPi,
      ),
    ),
    _swatchCard(
      title: 'Half sweep',
      code: '0 → π (180°)',
      accent: prismOrange,
      gradient: SweepGradient(
        colors: [prismOrange, prismMagenta, prismViolet],
        startAngle: 0.0,
        endAngle: twoPi / 2.0,
      ),
    ),
    _swatchCard(
      title: 'Color wheel',
      code: '6-stop rainbow',
      accent: prismMagenta,
      gradient: SweepGradient(
        colors: [
          prismPink,
          prismOrange,
          prismAmber,
          prismLime,
          prismTeal,
          prismViolet,
          prismPink,
        ],
        stops: [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1.0],
        startAngle: 0.0,
        endAngle: twoPi,
      ),
    ),
    _swatchCard(
      title: 'Diagonal sweep',
      code: 'transform: rotate(π/4)',
      accent: prismViolet,
      gradient: SweepGradient(
        colors: [prismTeal, prismBlue, prismViolet, prismMagenta, prismTeal],
        startAngle: 0.0,
        endAngle: twoPi,
        transform: GradientRotation(twoPi / 8.0),
      ),
    ),
  ];
  print('Created ${sweepCards.length} SweepGradient cards');

  // ============================================================
  // SECTION 6: TileMode family (4 cards)
  // ============================================================
  print('=== Section 6: TileMode Family ===');

  final tileBase = [prismPink, prismAmber];
  final tileCards = <Widget>[
    _swatchCard(
      title: 'TileMode.clamp',
      code: 'edge color extends',
      accent: prismPink,
      gradient: LinearGradient(
        colors: tileBase,
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        tileMode: TileMode.clamp,
      ),
    ),
    _swatchCard(
      title: 'TileMode.repeated',
      code: 'pattern repeats',
      accent: prismOrange,
      gradient: LinearGradient(
        colors: tileBase,
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        tileMode: TileMode.repeated,
      ),
    ),
    _swatchCard(
      title: 'TileMode.mirror',
      code: 'pattern mirrors',
      accent: prismTeal,
      gradient: LinearGradient(
        colors: tileBase,
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        tileMode: TileMode.mirror,
      ),
    ),
    _swatchCard(
      title: 'TileMode.decal',
      code: 'transparent outside',
      accent: prismViolet,
      gradient: LinearGradient(
        colors: tileBase,
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        tileMode: TileMode.decal,
      ),
    ),
  ];
  print('Created ${tileCards.length} TileMode cards');

  // ============================================================
  // SECTION 7: GradientRotation transform (4 cards)
  // ============================================================
  print('=== Section 7: GradientRotation ===');

  final rotationBase = LinearGradient(
    colors: [prismPink, prismAmber, prismTeal],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  print('rotationBase colors: ${rotationBase.colors.length}');

  final rotationCards = <Widget>[
    _swatchCard(
      title: '0° (no rotation)',
      code: 'transform: GradientRotation(0)',
      accent: prismPink,
      gradient: LinearGradient(
        colors: rotationBase.colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        transform: GradientRotation(0.0),
      ),
    ),
    _swatchCard(
      title: '45°',
      code: 'GradientRotation(π/4)',
      accent: prismAmber,
      gradient: LinearGradient(
        colors: rotationBase.colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        transform: GradientRotation(twoPi / 8.0),
      ),
    ),
    _swatchCard(
      title: '90°',
      code: 'GradientRotation(π/2)',
      accent: prismTeal,
      gradient: LinearGradient(
        colors: rotationBase.colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        transform: GradientRotation(twoPi / 4.0),
      ),
    ),
    _swatchCard(
      title: '180°',
      code: 'GradientRotation(π)',
      accent: prismViolet,
      gradient: LinearGradient(
        colors: rotationBase.colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        transform: GradientRotation(twoPi / 2.0),
      ),
    ),
  ];
  print('Created ${rotationCards.length} rotation cards');

  // ============================================================
  // SECTION 8: Gradient.lerp showcase (5 progress cards)
  // ============================================================
  print('=== Section 8: Gradient.lerp ===');

  final lerpFrom = LinearGradient(
    colors: [prismPink, prismOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final lerpTo = LinearGradient(
    colors: [prismTeal, prismViolet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('lerp endpoints prepared');

  final lerpTs = [0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpCards = <Widget>[];
  for (final t in lerpTs) {
    final blended = Gradient.lerp(lerpFrom, lerpTo, t);
    print('Gradient.lerp t=$t');
    if (blended != null) {
      lerpCards.add(
        _swatchCard(
          title: 't = ${t.toStringAsFixed(2)}',
          code: 'Gradient.lerp(a, b, $t)',
          accent: prismMagenta,
          width: 150.0,
          height: 90.0,
          gradient: blended,
        ),
      );
    }
  }
  print('Created ${lerpCards.length} lerp cards');

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world Mocks ===');

  final sunsetBanner = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 130.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1B1464),
          Color(0xFF843B62),
          Color(0xFFFF6F3C),
          Color(0xFFFFC93D),
        ],
        stops: [0.0, 0.45, 0.8, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF843B62).withValues(alpha: 0.5),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: 30.0,
          top: 22.0,
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.white, prismAmber, prismOrange],
                radius: 0.6,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: prismAmber.withValues(alpha: 0.7),
                  blurRadius: 18.0,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Text(
            'Sunset Banner',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  final beveledButton = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    width: 240.0,
    height: 56.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          prismViolet,
          prismMagenta,
          prismPink,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: prismMagenta.withValues(alpha: 0.55),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.4),
          blurRadius: 4.0,
          offset: Offset(0.0, -2.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'Beveled Button',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.6,
      ),
    ),
  );

  final glassCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 130.0,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.55),
          Colors.white.withValues(alpha: 0.18),
          prismTeal.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.45),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: prismTeal.withValues(alpha: 0.3),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, prismTeal],
              radius: 0.7,
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Glassmorphism',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Translucent gradient + frosted edge',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Glass needs a backdrop to be visible.
  final glassBackdrop = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [prismViolet, prismBlue, prismMagenta],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: glassCard,
  );

  final podiumChart = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Podium Chart',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60.0,
              height: 80.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [prismTeal, prismBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 6.0),
              child: Text(
                '2nd',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 60.0,
              height: 110.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [prismAmber, prismOrange, prismPink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: prismOrange.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 6.0),
              child: Text(
                '1st',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [prismViolet, prismMagenta],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 6.0),
              child: Text(
                '3rd',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final heroOverlay = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 150.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      gradient: LinearGradient(
        colors: [prismPink, prismOrange, prismAmber],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.05),
            Colors.black.withValues(alpha: 0.75),
          ],
          stops: [0.0, 0.55, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hero Image Overlay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'transparent → black gradient as readability scrim',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Widget>[
    _footgunCard(
      'stops length must match colors',
      'If you supply stops, the list length must equal colors.length, '
          'otherwise Flutter throws at paint time.',
      'colors.length == stops.length',
      Icons.error_outline,
      Colors.red.shade600,
    ),
    _footgunCard(
      'Alignment is in [-1, 1], not pixels',
      'Alignment(2, 2) is valid but places the begin/end far outside the box; '
          'use values inside [-1, 1] for predictable results.',
      'Alignment(-1, 0) … Alignment(1, 0)',
      Icons.straighten,
      Colors.orange.shade700,
    ),
    _footgunCard(
      'TileMode only affects out-of-range space',
      'clamp/repeated/mirror/decal control what happens beyond begin/end. '
          'If begin/end span the full box, you will see no difference.',
      'begin/end inside the box → tileMode visible',
      Icons.grid_4x4,
      Colors.blue.shade700,
    ),
    _footgunCard(
      'Gradient.lerp is concrete-type sensitive',
      'Mixing LinearGradient with RadialGradient via lerp falls back to a '
          'crossfade with begin/end of one side; lerp like-with-like.',
      'lerp(LinearGradient, LinearGradient, t)',
      Icons.compare_arrows,
      Colors.purple.shade700,
    ),
    _footgunCard(
      'Shaders are recreated each frame',
      'Building a new Gradient instance every frame defeats Flutter\'s '
          'shader cache; hoist gradients to top-level finals or const.',
      'final myGradient = LinearGradient(...);',
      Icons.speed,
      Colors.teal.shade700,
    ),
  ];
  print('Created ${footguns.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          prismViolet.withValues(alpha: 0.12),
          prismTeal.withValues(alpha: 0.12),
          prismAmber.withValues(alpha: 0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: prismViolet.withValues(alpha: 0.45),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: prismViolet.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: prismViolet, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: prismViolet,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapRow(
          'Gradient',
          'Abstract base — colors, stops, transform.',
          prismViolet,
          Icons.layers,
        ),
        _recapRow(
          'LinearGradient',
          'Straight axis from begin → end alignments.',
          prismPink,
          Icons.linear_scale,
        ),
        _recapRow(
          'RadialGradient',
          'Concentric rings around center / focal.',
          prismOrange,
          Icons.radio_button_checked,
        ),
        _recapRow(
          'SweepGradient',
          'Conic sweep startAngle → endAngle.',
          prismTeal,
          Icons.refresh,
        ),
        _recapRow(
          'TileMode',
          'clamp / repeated / mirror / decal — outside-range fill.',
          prismBlue,
          Icons.grid_4x4,
        ),
        _recapRow(
          'GradientRotation',
          'Rotate the gradient axis without changing alignments.',
          prismAmber,
          Icons.rotate_right,
        ),
        _recapRow(
          'Gradient.lerp',
          'Smooth crossfade between two like-typed gradients.',
          prismMagenta,
          Icons.compare_arrows,
        ),
      ],
    ),
  );

  print('Gradients Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF7F5FB),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1: title banner
          titleBanner,

          // Section 2: anatomy
          _sectionHeader(
            '02',
            'Anatomy',
            'Fields shared by every Gradient subtype.',
            Icons.architecture,
            [prismViolet, prismMagenta],
          ),
          anatomy,

          // Section 3: linear
          _sectionHeader(
            '03',
            'LinearGradient',
            'Straight-axis interpolation between two alignments.',
            Icons.linear_scale,
            [prismPink, prismOrange],
          ),
          Wrap(alignment: WrapAlignment.center, children: linearCards),

          // Section 4: radial
          _sectionHeader(
            '04',
            'RadialGradient',
            'Concentric rings around a center / focal point.',
            Icons.radio_button_checked,
            [prismOrange, prismAmber],
          ),
          Wrap(alignment: WrapAlignment.center, children: radialCards),

          // Section 5: sweep
          _sectionHeader(
            '05',
            'SweepGradient',
            'Conic sweep from startAngle to endAngle.',
            Icons.refresh,
            [prismTeal, prismBlue],
          ),
          Wrap(alignment: WrapAlignment.center, children: sweepCards),

          // Section 6: tile mode
          _sectionHeader(
            '06',
            'TileMode',
            'Same gradient under clamp / repeated / mirror / decal.',
            Icons.grid_4x4,
            [prismBlue, prismViolet],
          ),
          Wrap(alignment: WrapAlignment.center, children: tileCards),

          // Section 7: rotation
          _sectionHeader(
            '07',
            'GradientRotation',
            'Rotate axis without touching begin / end.',
            Icons.rotate_right,
            [prismAmber, prismPink],
          ),
          Wrap(alignment: WrapAlignment.center, children: rotationCards),

          // Section 8: lerp
          _sectionHeader(
            '08',
            'Gradient.lerp',
            'Crossfade between two LinearGradients at t = 0.0 → 1.0.',
            Icons.compare_arrows,
            [prismMagenta, prismViolet],
          ),
          Wrap(alignment: WrapAlignment.center, children: lerpCards),

          // Section 9: real-world mocks
          _sectionHeader(
            '09',
            'Real-world Mocks',
            'Sunset, button bevel, glass, podium, hero overlay.',
            Icons.auto_awesome,
            [prismPink, prismAmber, prismTeal],
          ),
          sunsetBanner,
          beveledButton,
          glassBackdrop,
          podiumChart,
          heroOverlay,

          // Section 10: footguns
          _sectionHeader(
            '10',
            'Footguns',
            'Common mistakes and the safe alternative.',
            Icons.warning_amber,
            [Colors.red.shade400, Colors.deepOrange.shade400],
          ),
          ...footguns,

          // Section 11: recap
          _sectionHeader(
            '11',
            'Recap',
            'One-line summary of every member of the family.',
            Icons.summarize,
            [prismViolet, prismBlue, prismTeal],
          ),
          recap,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}
