// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Spectrum Lab - Gradient Rendering Deep Dive
// Comprehensive demonstration of LinearGradient, RadialGradient, SweepGradient,
// ShaderMask, ui.Gradient low-level shader API, gradient lerp, and gradient animation.
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

// ============================================================================
// PALETTE - Charcoal instrument body, spectrum-rainbow accents, cream paper
// ============================================================================
const Color kInk = Color(0xFF1A1B23);
const Color kCharcoal = Color(0xFF2A2C36);
const Color kSlate = Color(0xFF3C3F4D);
const Color kIron = Color(0xFF5A5F71);
const Color kFog = Color(0xFF8E94A6);
const Color kCream = Color(0xFFFAF6EC);
const Color kPaper = Color(0xFFF1ECD8);
const Color kTape = Color(0xFFE5DEC1);

// Spectrum accents
const Color kSpecRed = Color(0xFFE94F4F);
const Color kSpecOrange = Color(0xFFF59E3D);
const Color kSpecYellow = Color(0xFFF4D35E);
const Color kSpecGreen = Color(0xFF4FB286);
const Color kSpecCyan = Color(0xFF4FC3D9);
const Color kSpecBlue = Color(0xFF4F7DD9);
const Color kSpecIndigo = Color(0xFF6A4FD9);
const Color kSpecViolet = Color(0xFFB44FD9);
const Color kSpecPink = Color(0xFFE94FB0);

const List<Color> kRainbow = <Color>[
  kSpecRed,
  kSpecOrange,
  kSpecYellow,
  kSpecGreen,
  kSpecCyan,
  kSpecBlue,
  kSpecIndigo,
  kSpecViolet,
];

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION 1: HERO HEADER
  // ==========================================================================
  final hero = _buildHero();

  // ==========================================================================
  // SECTION 2: CONCEPT OVERVIEW
  // ==========================================================================
  final overview = _buildOverview();

  // ==========================================================================
  // SECTION 3: GRADIENT ABSTRACT ANATOMY
  // ==========================================================================
  final abstractAnatomy = _buildAbstractAnatomy();

  // ==========================================================================
  // SECTION 4: LINEARGRADIENT ANATOMY (8 specimens)
  // ==========================================================================
  final linearAnatomy = _buildLinearAnatomy();

  // ==========================================================================
  // SECTION 5: RADIALGRADIENT ANATOMY (8 specimens)
  // ==========================================================================
  final radialAnatomy = _buildRadialAnatomy();

  // ==========================================================================
  // SECTION 6: SWEEPGRADIENT ANATOMY (8 specimens)
  // ==========================================================================
  final sweepAnatomy = _buildSweepAnatomy();

  // ==========================================================================
  // SECTION 7: COLOR STOPS DEEP-DIVE
  // ==========================================================================
  final stopsSection = _buildStopsDeepDive();

  // ==========================================================================
  // SECTION 8: TILEMODE SHOWCASE
  // ==========================================================================
  final tileModeSection = _buildTileModeShowcase();

  // ==========================================================================
  // SECTION 9: GRADIENTTRANSFORM DEMO
  // ==========================================================================
  final transformSection = _buildTransformDemo();

  // ==========================================================================
  // SECTION 10: GRADIENT.LERP SHOWCASE
  // ==========================================================================
  final lerpSection = _buildLerpShowcase();

  // ==========================================================================
  // SECTION 11: SHADERMASK + GRADIENT
  // ==========================================================================
  final shaderMaskSection = _buildShaderMaskSection();

  // ==========================================================================
  // SECTION 12: BOXDECORATION vs SHAPEDECORATION
  // ==========================================================================
  final decorationCompare = _buildDecorationCompare();

  // ==========================================================================
  // SECTION 13: ui.Gradient LOW-LEVEL API
  // ==========================================================================
  final lowLevelSection = _buildLowLevelApi();

  // ==========================================================================
  // SECTION 14: PERFORMANCE & ARTIFACT NOTES
  // ==========================================================================
  final perfSection = _buildPerformanceNotes();

  // ==========================================================================
  // SECTION 15: COMPOSITE SHOWPIECES
  // ==========================================================================
  final composites = _buildComposites();

  // ==========================================================================
  // SECTION 16: RECIPE CARDS
  // ==========================================================================
  final recipes = _buildRecipes();

  // ==========================================================================
  // SECTION 17: COMPARISON TABLE
  // ==========================================================================
  final comparison = _buildComparisonTable();

  // ==========================================================================
  // SECTION 18: PITFALLS
  // ==========================================================================
  final pitfalls = _buildPitfalls();

  // ==========================================================================
  // SECTION 19: GLOSSARY
  // ==========================================================================
  final glossary = _buildGlossary();

  // ==========================================================================
  // SECTION 20: EPILOGUE
  // ==========================================================================
  final epilogue = _buildEpilogue();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Spectrum Lab — Gradient Rendering',
    home: Scaffold(
      backgroundColor: kCream,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hero,
            SizedBox(height: 24.0),
            overview,
            SizedBox(height: 24.0),
            abstractAnatomy,
            SizedBox(height: 24.0),
            linearAnatomy,
            SizedBox(height: 24.0),
            radialAnatomy,
            SizedBox(height: 24.0),
            sweepAnatomy,
            SizedBox(height: 24.0),
            stopsSection,
            SizedBox(height: 24.0),
            tileModeSection,
            SizedBox(height: 24.0),
            transformSection,
            SizedBox(height: 24.0),
            lerpSection,
            SizedBox(height: 24.0),
            shaderMaskSection,
            SizedBox(height: 24.0),
            decorationCompare,
            SizedBox(height: 24.0),
            lowLevelSection,
            SizedBox(height: 24.0),
            perfSection,
            SizedBox(height: 24.0),
            composites,
            SizedBox(height: 24.0),
            recipes,
            SizedBox(height: 24.0),
            comparison,
            SizedBox(height: 24.0),
            pitfalls,
            SizedBox(height: 24.0),
            glossary,
            SizedBox(height: 24.0),
            epilogue,
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO
// ============================================================================
Widget _buildHero() {
  return Container(
    padding: EdgeInsets.all(32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: kRainbow,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 24.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'SPECTRUM LAB',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 12.0,
            letterSpacing: 4.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Gradient — continuous color across a surface',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'A colorist\'s bench for Flutter\'s gradient family: Linear, Radial, Sweep — '
          'their shaders, stops, tile modes, transforms, and the ui.Gradient surface they rest on.',
          style: TextStyle(
            color: Color(0xEEFFFFFF),
            fontSize: 14.0,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _heroChip('LinearGradient'),
            SizedBox(width: 8.0),
            _heroChip('RadialGradient'),
            SizedBox(width: 8.0),
            _heroChip('SweepGradient'),
            SizedBox(width: 8.0),
            _heroChip('ui.Gradient'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Color(0x55FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================================
// OVERVIEW
// ============================================================================
Widget _buildOverview() {
  return _sectionCard(
    title: '01 · Concept Overview',
    subtitle: 'Gradient as an abstract Shader producer',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bodyText(
          'A Gradient (from painting.dart) is a description of how colors blend '
          'continuously across a 2D region. It is not pixels — it is a recipe. '
          'When painting, Flutter asks the Gradient to produce a Shader '
          '(via createShader(Rect, {TextDirection})), and that shader is then '
          'attached to a Paint and rasterized.',
        ),
        SizedBox(height: 12.0),
        _bodyText(
          'Three concrete shapes exist:',
        ),
        SizedBox(height: 8.0),
        _bullet('LinearGradient — colors interpolate along a straight axis from begin to end'),
        _bullet('RadialGradient — colors radiate from a center, optionally with a focal point'),
        _bullet('SweepGradient — colors sweep angularly around a center, like a clock'),
        SizedBox(height: 12.0),
        _bodyText(
          'Each shares: colors, stops, transform, tileMode. The differences are how '
          'they interpret position. The underlying shader is always a ui.Gradient — '
          'a low-level Dart:ui object created from raw doubles and Float64List matrices.',
        ),
      ],
    ),
  );
}

// ============================================================================
// ABSTRACT ANATOMY
// ============================================================================
Widget _buildAbstractAnatomy() {
  return _sectionCard(
    title: '02 · Anatomy of Gradient (abstract)',
    subtitle: 'Members shared by every concrete subtype',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _anatomyRow('colors', 'List<Color>', 'Required. At least two colors. Interpolated in linear-space.'),
        _anatomyRow('stops', 'List<double>?', 'Same length as colors, sorted ascending in [0,1]. If null, evenly distributed.'),
        _anatomyRow('transform', 'GradientTransform?', 'Optional shader-space transform (e.g. GradientRotation).'),
        _anatomyRow('createShader', 'Shader Function(Rect, {TextDirection?})', 'Concrete entry point — builds the dart:ui Shader.'),
        _anatomyRow('scale', 'Gradient Function(double factor)', 'Scales colors\' alpha by factor — used in implicit animation.'),
        _anatomyRow('lerp', 'static Gradient? Function(Gradient?, Gradient?, double)', 'Interpolates two gradients (same concrete type) by t in [0,1].'),
        SizedBox(height: 12.0),
        _calloutBox(
          title: 'Conceptual model',
          body: 'A Gradient is a parametric color function f: R^2 -> Color, '
              'sampled into a Shader bounded to a Rect when painted. The '
              'concrete subtype defines how (x, y) maps to a position along '
              'the stops array.',
        ),
      ],
    ),
  );
}

// ============================================================================
// LINEAR ANATOMY - 8 SPECIMENS
// ============================================================================
Widget _buildLinearAnatomy() {
  final List<_LinearSpec> specs = <_LinearSpec>[
    _LinearSpec(
      label: 'top → bottom',
      detail: 'begin: topCenter, end: bottomCenter',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[kSpecBlue, kSpecCyan],
      ),
    ),
    _LinearSpec(
      label: 'topLeft → bottomRight',
      detail: '45° diagonal axis',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kSpecIndigo, kSpecPink],
      ),
    ),
    _LinearSpec(
      label: 'custom Alignment(-1.5, 0)',
      detail: 'origin OUTSIDE the rect — extends shader space',
      gradient: LinearGradient(
        begin: Alignment(-1.5, 0.0),
        end: Alignment(1.5, 0.0),
        colors: <Color>[kSpecOrange, kSpecYellow, kSpecGreen],
      ),
    ),
    _LinearSpec(
      label: 'multi-stop rainbow',
      detail: 'colors=[…], stops=[0, .25, .5, .75, 1]',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: kRainbow,
        stops: <double>[0.0, 0.15, 0.30, 0.45, 0.60, 0.75, 0.90, 1.0],
      ),
    ),
    _LinearSpec(
      label: 'TileMode.clamp (default)',
      detail: 'edge colors extend past begin/end',
      gradient: LinearGradient(
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        colors: <Color>[kSpecRed, kSpecYellow],
        tileMode: TileMode.clamp,
      ),
    ),
    _LinearSpec(
      label: 'TileMode.repeated',
      detail: 'gradient tiles past its axis',
      gradient: LinearGradient(
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        colors: <Color>[kSpecRed, kSpecYellow],
        tileMode: TileMode.repeated,
      ),
    ),
    _LinearSpec(
      label: 'TileMode.mirror',
      detail: 'gradient reflects past its axis',
      gradient: LinearGradient(
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        colors: <Color>[kSpecRed, kSpecYellow],
        tileMode: TileMode.mirror,
      ),
    ),
    _LinearSpec(
      label: 'TileMode.decal',
      detail: 'gradient + transparent fill past axis',
      gradient: LinearGradient(
        begin: Alignment(-0.4, 0.0),
        end: Alignment(0.4, 0.0),
        colors: <Color>[kSpecRed, kSpecYellow],
        tileMode: TileMode.decal,
      ),
    ),
  ];

  return _sectionCard(
    title: '03 · LinearGradient anatomy',
    subtitle: 'begin, end, colors, stops, tileMode',
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: specs.map(_renderLinearSpec).toList(growable: false),
    ),
  );
}

Widget _renderLinearSpec(_LinearSpec spec) {
  return _specimenCard(
    label: spec.label,
    detail: spec.detail,
    swatch: Container(
      decoration: BoxDecoration(
        gradient: spec.gradient,
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

class _LinearSpec {
  const _LinearSpec({
    required this.label,
    required this.detail,
    required this.gradient,
  });
  final String label;
  final String detail;
  final LinearGradient gradient;
}

// ============================================================================
// RADIAL ANATOMY - 8 SPECIMENS
// ============================================================================
Widget _buildRadialAnatomy() {
  final List<_RadialSpec> specs = <_RadialSpec>[
    _RadialSpec(
      label: 'center, radius=0.5',
      detail: 'classic radial — spotlight in middle',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: <Color>[kSpecYellow, kSpecOrange, kInk],
      ),
    ),
    _RadialSpec(
      label: 'center, radius=1.2',
      detail: 'large radius — softer falloff',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 1.2,
        colors: <Color>[kSpecCyan, kSpecBlue, kSpecIndigo],
      ),
    ),
    _RadialSpec(
      label: 'center.topLeft, radius=1.0',
      detail: 'off-center sphere — sunrise corner',
      gradient: RadialGradient(
        center: Alignment.topLeft,
        radius: 1.0,
        colors: <Color>[kSpecYellow, kSpecOrange, kSpecRed],
      ),
    ),
    _RadialSpec(
      label: 'focal=topLeft, focalRadius=0.1',
      detail: 'spotlight effect — focal pulls highlight',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        focal: Alignment.topLeft,
        focalRadius: 0.1,
        colors: <Color>[Color(0xFFFFFFFF), kSpecBlue, kInk],
      ),
    ),
    _RadialSpec(
      label: 'multi-stop rainbow',
      detail: 'rainbow rings outward',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.85,
        colors: kRainbow,
      ),
    ),
    _RadialSpec(
      label: 'TileMode.repeated',
      detail: 'concentric repeating rings',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.18,
        colors: <Color>[kSpecPink, kSpecViolet],
        tileMode: TileMode.repeated,
      ),
    ),
    _RadialSpec(
      label: 'TileMode.mirror',
      detail: 'reflected rings — interference look',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.16,
        colors: <Color>[kSpecGreen, kSpecYellow],
        tileMode: TileMode.mirror,
      ),
    ),
    _RadialSpec(
      label: 'TileMode.decal',
      detail: 'one disk then transparent',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.35,
        colors: <Color>[kSpecOrange, Color(0x00000000)],
        tileMode: TileMode.decal,
      ),
    ),
  ];

  return _sectionCard(
    title: '04 · RadialGradient anatomy',
    subtitle: 'center, radius, focal, focalRadius, tileMode',
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: specs.map(_renderRadialSpec).toList(growable: false),
    ),
  );
}

Widget _renderRadialSpec(_RadialSpec spec) {
  return _specimenCard(
    label: spec.label,
    detail: spec.detail,
    swatch: Container(
      decoration: BoxDecoration(
        gradient: spec.gradient,
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

class _RadialSpec {
  const _RadialSpec({
    required this.label,
    required this.detail,
    required this.gradient,
  });
  final String label;
  final String detail;
  final RadialGradient gradient;
}

// ============================================================================
// SWEEP ANATOMY - 8 SPECIMENS
// ============================================================================
Widget _buildSweepAnatomy() {
  final List<_SweepSpec> specs = <_SweepSpec>[
    _SweepSpec(
      label: 'full circle 0 → 2π',
      detail: 'classic color wheel',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2.0,
        colors: <Color>[
          kSpecRed,
          kSpecOrange,
          kSpecYellow,
          kSpecGreen,
          kSpecCyan,
          kSpecBlue,
          kSpecIndigo,
          kSpecViolet,
          kSpecRed,
        ],
      ),
    ),
    _SweepSpec(
      label: '0 → π (half)',
      detail: 'angular semicircle',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi,
        colors: <Color>[kSpecBlue, kSpecPink],
      ),
    ),
    _SweepSpec(
      label: '0 → 2π/3 (third)',
      detail: 'narrow fan — pie-chart wedge',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2.0 / 3.0,
        colors: <Color>[kSpecGreen, kSpecYellow, kSpecRed],
      ),
    ),
    _SweepSpec(
      label: 'offset center (-0.4, 0)',
      detail: 'rotation hub shifted left',
      gradient: SweepGradient(
        center: Alignment(-0.4, 0.0),
        startAngle: 0.0,
        endAngle: math.pi * 2.0,
        colors: <Color>[kSpecCyan, kSpecBlue, kSpecIndigo, kSpecCyan],
      ),
    ),
    _SweepSpec(
      label: 'stops [0, .25, .5, .75, 1]',
      detail: 'controlled bands',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2.0,
        colors: <Color>[kSpecRed, kSpecYellow, kSpecGreen, kSpecBlue, kSpecRed],
        stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
      ),
    ),
    _SweepSpec(
      label: 'rotated π/4 transform',
      detail: 'GradientRotation(π/4) shifts start',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2.0,
        colors: <Color>[kSpecOrange, kSpecPink, kSpecViolet, kSpecOrange],
        transform: GradientRotation(math.pi / 4.0),
      ),
    ),
    _SweepSpec(
      label: 'TileMode.repeated',
      detail: 'sweep wraps to fill remainder',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi / 2.0,
        colors: <Color>[kSpecPink, kSpecViolet],
        tileMode: TileMode.repeated,
      ),
    ),
    _SweepSpec(
      label: 'TileMode.mirror',
      detail: 'sweep reflects after endAngle',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi / 2.0,
        colors: <Color>[kSpecGreen, kSpecCyan],
        tileMode: TileMode.mirror,
      ),
    ),
  ];

  return _sectionCard(
    title: '05 · SweepGradient anatomy',
    subtitle: 'center, startAngle, endAngle, transform, tileMode',
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: specs.map(_renderSweepSpec).toList(growable: false),
    ),
  );
}

Widget _renderSweepSpec(_SweepSpec spec) {
  return _specimenCard(
    label: spec.label,
    detail: spec.detail,
    swatch: Container(
      decoration: BoxDecoration(
        gradient: spec.gradient,
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

class _SweepSpec {
  const _SweepSpec({
    required this.label,
    required this.detail,
    required this.gradient,
  });
  final String label;
  final String detail;
  final SweepGradient gradient;
}

// ============================================================================
// COLOR STOPS DEEP-DIVE
// ============================================================================
Widget _buildStopsDeepDive() {
  final List<_StopSpec> specs = <_StopSpec>[
    _StopSpec(
      label: 'equal stops (implicit)',
      detail: 'stops=null → distributed evenly',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[kSpecRed, kSpecYellow, kSpecGreen, kSpecBlue, kSpecViolet],
      ),
    ),
    _StopSpec(
      label: 'weighted stops [0, .1, .9, 1]',
      detail: 'fast in/out, slow middle',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[kSpecRed, kSpecYellow, kSpecBlue, kSpecViolet],
        stops: <double>[0.0, 0.1, 0.9, 1.0],
      ),
    ),
    _StopSpec(
      label: 'multi-stop rainbow [0..8]',
      detail: 'eight bands, evenly spaced',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: kRainbow,
        stops: <double>[0.0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1.0],
      ),
    ),
    _StopSpec(
      label: 'two-tone with midpoint [0, .35, 1]',
      detail: 'control the blend center',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[kSpecBlue, kSpecCyan, kSpecGreen],
        stops: <double>[0.0, 0.35, 1.0],
      ),
    ),
    _StopSpec(
      label: 'hard-edge bands [0, .5, .5, 1]',
      detail: 'duplicate stops → instant transition',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[kSpecRed, kSpecRed, kSpecBlue, kSpecBlue],
        stops: <double>[0.0, 0.5, 0.5, 1.0],
      ),
    ),
  ];

  return _sectionCard(
    title: '06 · Color stops deep-dive',
    subtitle: 'How stops shape the perceived gradient',
    child: Column(
      children: specs.map((s) => _stopRow(s)).toList(growable: false),
    ),
  );
}

Widget _stopRow(_StopSpec spec) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 180.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                spec.label,
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                spec.detail,
                style: TextStyle(color: kFog, fontSize: 10.0),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            height: 44.0,
            decoration: BoxDecoration(
              gradient: spec.gradient,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: kTape, width: 1.0),
            ),
          ),
        ),
      ],
    ),
  );
}

class _StopSpec {
  const _StopSpec({
    required this.label,
    required this.detail,
    required this.gradient,
  });
  final String label;
  final String detail;
  final LinearGradient gradient;
}

// ============================================================================
// TILEMODE SHOWCASE - 3 types × 4 modes
// ============================================================================
Widget _buildTileModeShowcase() {
  return _sectionCard(
    title: '07 · TileMode showcase',
    subtitle: 'clamp / repeat / mirror / decal across all three families',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _tileGroupHeader('LinearGradient (compact axis)'),
        SizedBox(height: 8.0),
        _tileRow4(<Widget>[
          _tileCell('clamp', LinearGradient(
            begin: Alignment(-0.3, 0.0),
            end: Alignment(0.3, 0.0),
            colors: <Color>[kSpecBlue, kSpecPink],
            tileMode: TileMode.clamp,
          )),
          _tileCell('repeat', LinearGradient(
            begin: Alignment(-0.3, 0.0),
            end: Alignment(0.3, 0.0),
            colors: <Color>[kSpecBlue, kSpecPink],
            tileMode: TileMode.repeated,
          )),
          _tileCell('mirror', LinearGradient(
            begin: Alignment(-0.3, 0.0),
            end: Alignment(0.3, 0.0),
            colors: <Color>[kSpecBlue, kSpecPink],
            tileMode: TileMode.mirror,
          )),
          _tileCell('decal', LinearGradient(
            begin: Alignment(-0.3, 0.0),
            end: Alignment(0.3, 0.0),
            colors: <Color>[kSpecBlue, kSpecPink],
            tileMode: TileMode.decal,
          )),
        ]),
        SizedBox(height: 16.0),
        _tileGroupHeader('RadialGradient (small radius=0.18)'),
        SizedBox(height: 8.0),
        _tileRow4(<Widget>[
          _tileCell('clamp', RadialGradient(
            center: Alignment.center,
            radius: 0.18,
            colors: <Color>[kSpecGreen, kSpecYellow],
            tileMode: TileMode.clamp,
          )),
          _tileCell('repeat', RadialGradient(
            center: Alignment.center,
            radius: 0.18,
            colors: <Color>[kSpecGreen, kSpecYellow],
            tileMode: TileMode.repeated,
          )),
          _tileCell('mirror', RadialGradient(
            center: Alignment.center,
            radius: 0.18,
            colors: <Color>[kSpecGreen, kSpecYellow],
            tileMode: TileMode.mirror,
          )),
          _tileCell('decal', RadialGradient(
            center: Alignment.center,
            radius: 0.18,
            colors: <Color>[kSpecGreen, kSpecYellow],
            tileMode: TileMode.decal,
          )),
        ]),
        SizedBox(height: 16.0),
        _tileGroupHeader('SweepGradient (endAngle=π/2)'),
        SizedBox(height: 8.0),
        _tileRow4(<Widget>[
          _tileCell('clamp', SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: math.pi / 2.0,
            colors: <Color>[kSpecRed, kSpecOrange],
            tileMode: TileMode.clamp,
          )),
          _tileCell('repeat', SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: math.pi / 2.0,
            colors: <Color>[kSpecRed, kSpecOrange],
            tileMode: TileMode.repeated,
          )),
          _tileCell('mirror', SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: math.pi / 2.0,
            colors: <Color>[kSpecRed, kSpecOrange],
            tileMode: TileMode.mirror,
          )),
          _tileCell('decal', SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: math.pi / 2.0,
            colors: <Color>[kSpecRed, kSpecOrange],
            tileMode: TileMode.decal,
          )),
        ]),
      ],
    ),
  );
}

Widget _tileGroupHeader(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: kCharcoal,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: kCream,
        fontSize: 11.0,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _tileRow4(List<Widget> cells) {
  return Row(
    children: <Widget>[
      Expanded(child: cells[0]),
      SizedBox(width: 8.0),
      Expanded(child: cells[1]),
      SizedBox(width: 8.0),
      Expanded(child: cells[2]),
      SizedBox(width: 8.0),
      Expanded(child: cells[3]),
    ],
  );
}

Widget _tileCell(String label, Gradient g) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        height: 90.0,
        decoration: BoxDecoration(
          gradient: g,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: kTape, width: 1.0),
        ),
      ),
      SizedBox(height: 4.0),
      Center(
        child: Text(
          label,
          style: TextStyle(
            color: kIron,
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// GRADIENT TRANSFORM
// ============================================================================
Widget _buildTransformDemo() {
  final LinearGradient base = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: kRainbow,
  );

  final List<_TransformSpec> specs = <_TransformSpec>[
    _TransformSpec(
      label: 'no transform',
      detail: 'left → right rainbow baseline',
      gradient: base,
    ),
    _TransformSpec(
      label: 'GradientRotation(π/4)',
      detail: '45° rotation in shader space',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: kRainbow,
        transform: GradientRotation(math.pi / 4.0),
      ),
    ),
    _TransformSpec(
      label: 'GradientRotation(π/2)',
      detail: '90° rotation — now top → bottom',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: kRainbow,
        transform: GradientRotation(math.pi / 2.0),
      ),
    ),
    _TransformSpec(
      label: 'GradientRotation(3π/4)',
      detail: '135° rotation — counter-diagonal',
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: kRainbow,
        transform: GradientRotation(math.pi * 3.0 / 4.0),
      ),
    ),
  ];

  return _sectionCard(
    title: '08 · GradientTransform demo',
    subtitle: 'GradientRotation as the framework-provided concrete option',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _calloutBox(
          title: 'GradientTransform is abstract',
          body: 'Subclass it and implement transform(Rect, {TextDirection?}) → Matrix4? '
              'to define custom shader-space transforms. The framework ships '
              'GradientRotation as the most common concrete instance. The transform '
              'is applied to the shader\'s local matrix before sampling.',
        ),
        SizedBox(height: 12.0),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 1.6,
          children: specs.map((s) => _specimenCard(
            label: s.label,
            detail: s.detail,
            swatch: Container(
              decoration: BoxDecoration(
                gradient: s.gradient,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          )).toList(growable: false),
        ),
      ],
    ),
  );
}

class _TransformSpec {
  const _TransformSpec({
    required this.label,
    required this.detail,
    required this.gradient,
  });
  final String label;
  final String detail;
  final LinearGradient gradient;
}

// ============================================================================
// GRADIENT.LERP - 5 frozen frames
// ============================================================================
Widget _buildLerpShowcase() {
  final LinearGradient a = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[kSpecBlue, kSpecCyan],
  );
  final LinearGradient b = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[kSpecRed, kSpecOrange],
  );

  final List<double> frames = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final List<Widget> cells = <Widget>[];
  for (final double t in frames) {
    final Gradient? lerped = LinearGradient.lerp(a, b, t);
    final AlwaysStoppedAnimation<double> snapshot = AlwaysStoppedAnimation<double>(t);
    cells.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 70.0,
            decoration: BoxDecoration(
              gradient: lerped,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: kTape, width: 1.0),
            ),
          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
              't = ${snapshot.value.toStringAsFixed(2)}',
              style: TextStyle(
                color: kInk,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  return _sectionCard(
    title: '09 · Gradient.lerp showcase',
    subtitle: 'Five frozen frames interpolating blue→cyan into red→orange',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bodyText(
          'LinearGradient.lerp(a, b, t) returns a new gradient whose colors and '
          'alignment are interpolated. Both gradients must be the same concrete '
          'subtype. Mismatched stops are resolved by intermediate up-sampling.',
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < cells.length; i++) ...<Widget>[
              if (i > 0) SizedBox(width: 8.0),
              Expanded(child: cells[i]),
            ],
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SHADERMASK - 4 specimens
// ============================================================================
Widget _buildShaderMaskSection() {
  final LinearGradient titleGrad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[kSpecPink, kSpecViolet, kSpecBlue],
  );
  final RadialGradient iconGrad = RadialGradient(
    center: Alignment.center,
    radius: 0.6,
    colors: <Color>[kSpecYellow, kSpecOrange, kSpecRed],
  );
  final SweepGradient wheelGrad = SweepGradient(
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: math.pi * 2.0,
    colors: kRainbow + <Color>[kSpecRed],
  );
  final LinearGradient stripeGrad = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: kRainbow,
  );

  return _sectionCard(
    title: '10 · ShaderMask + gradient',
    subtitle: 'Apply a Shader to children via blend mode srcIn',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bodyText(
          'ShaderMask paints its child as the mask: pixels of the gradient '
          'replace child pixels through the chosen BlendMode (commonly srcIn). '
          'The result is a child silhouette filled with the gradient.',
        ),
        SizedBox(height: 16.0),
        _shaderMaskCard(
          title: 'LinearGradient → Text',
          mask: titleGrad,
          child: Text(
            'SPECTRUM',
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFFFFF),
              letterSpacing: 6.0,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _shaderMaskCard(
          title: 'RadialGradient → Icon',
          mask: iconGrad,
          child: Icon(
            Icons.wb_sunny,
            size: 80.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 12.0),
        _shaderMaskCard(
          title: 'SweepGradient → Color wheel Icon',
          mask: wheelGrad,
          child: Icon(
            Icons.refresh,
            size: 80.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 12.0),
        _shaderMaskCard(
          title: 'LinearGradient stripe → Title',
          mask: stripeGrad,
          child: Text(
            'GRADIENT TITLE',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
              letterSpacing: 3.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _shaderMaskCard({
  required String title,
  required Gradient mask,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kInk,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: kFog,
            fontSize: 10.0,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.0),
        Center(
          child: ShaderMask(
            shaderCallback: (Rect bounds) => mask.createShader(bounds),
            blendMode: BlendMode.srcIn,
            child: child,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// BOXDECORATION vs SHAPEDECORATION
// ============================================================================
Widget _buildDecorationCompare() {
  final LinearGradient g = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[kSpecIndigo, kSpecPink],
  );

  return _sectionCard(
    title: '11 · BoxDecoration vs ShapeDecoration',
    subtitle: 'Same gradient, two decoration slots',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _decorationDemo(
            label: 'BoxDecoration.gradient',
            note: 'Rect-shaped, optional borderRadius / shape / image',
            box: Container(
              height: 120.0,
              decoration: BoxDecoration(
                gradient: g,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: _decorationDemo(
            label: 'ShapeDecoration.gradient',
            note: 'Any ShapeBorder — stadium, rounded, beveled',
            box: Container(
              height: 120.0,
              decoration: ShapeDecoration(
                gradient: g,
                shape: StadiumBorder(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _decorationDemo({
  required String label,
  required String note,
  required Widget box,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kCream,
      border: Border.all(color: kTape, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: kInk,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(note, style: TextStyle(color: kFog, fontSize: 10.0)),
        SizedBox(height: 10.0),
        box,
      ],
    ),
  );
}

// ============================================================================
// LOW LEVEL ui.Gradient
// ============================================================================
Widget _buildLowLevelApi() {
  // Build real ui.Gradient shaders, attach via CustomPaint
  final ui.Gradient linear = ui.Gradient.linear(
    Offset(0.0, 0.0),
    Offset(200.0, 0.0),
    <Color>[kSpecBlue, kSpecPink],
  );
  final ui.Gradient radial = ui.Gradient.radial(
    Offset(100.0, 60.0),
    80.0,
    <Color>[kSpecYellow, kInk],
  );
  // ui.Gradient.sweep declares `double endAngle = math.pi * 2` as the
  // default — a non-const expression the bridge generator currently
  // marks as non-wrappable, so callers must specify it explicitly. We
  // also fill in the preceding optional positionals (colorStops,
  // tileMode, startAngle) because dart:ui.Gradient.sweep is positional-
  // only. dart:ui validates `colors.length == 2 || colorStops != null`,
  // so the 9-color rainbow needs an explicit evenly-spaced stop list.
  // See `interpreter_unfixable.md` (U2) for the underlying generator
  // limitation.
  final ui.Gradient sweep = ui.Gradient.sweep(
    Offset(100.0, 60.0),
    kRainbow + <Color>[kSpecRed],
    <double>[
      0.0,
      0.125,
      0.25,
      0.375,
      0.5,
      0.625,
      0.75,
      0.875,
      1.0,
    ], // 9 evenly-spaced stops for the 9-colour rainbow
    TileMode.clamp, // tileMode
    0.0, // startAngle
    math.pi * 2.0, // endAngle (non-wrappable default in generator)
  );

  return _sectionCard(
    title: '12 · ui.Gradient (low-level shader API)',
    subtitle: 'The dart:ui surface beneath painting.Gradient',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bodyText(
          'painting.LinearGradient.createShader(...) ultimately calls '
          'ui.Gradient.linear(Offset from, Offset to, List<Color>, [List<double> '
          'colorStops, TileMode tileMode, Float64List matrix4]). The high-level '
          'classes compute these arguments from semantic Alignment values.',
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _uiShaderCell('ui.Gradient.linear', linear)),
            SizedBox(width: 10.0),
            Expanded(child: _uiShaderCell('ui.Gradient.radial', radial)),
            SizedBox(width: 10.0),
            Expanded(child: _uiShaderCell('ui.Gradient.sweep', sweep)),
          ],
        ),
        SizedBox(height: 16.0),
        _calloutBox(
          title: 'Anatomy of ui.Gradient.linear',
          body: 'ui.Gradient.linear(from, to, colors, [stops, tileMode, matrix4]) '
              'returns a Shader. Pass that Shader to Paint.shader to paint anything '
              'with it — Path, drawRect, drawText, etc. No Rect required: the from→to '
              'segment defines the gradient axis in raw pixel space.',
        ),
      ],
    ),
  );
}

Widget _uiShaderCell(String label, ui.Gradient shader) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        height: 110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kTape, width: 1.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CustomPaint(
            painter: _ShaderFillPainter(shader),
            size: Size.infinite,
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Center(
        child: Text(
          label,
          style: TextStyle(
            color: kIron,
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

class _ShaderFillPainter extends CustomPainter {
  _ShaderFillPainter(this.shader);
  final ui.Shader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_ShaderFillPainter oldDelegate) =>
      oldDelegate.shader != shader;
}

// ============================================================================
// PERFORMANCE NOTES
// ============================================================================
Widget _buildPerformanceNotes() {
  return _sectionCard(
    title: '13 · Performance & artifact notes',
    subtitle: 'What goes wrong when, and why',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _perfRow(
          'aliasing on sharp stops',
          'Duplicate stops (0.5, 0.5) produce hard edges. On low-DPI screens '
          'this looks jagged. Mitigate by separating stops by ~0.005.',
        ),
        _perfRow(
          'banding on subtle gradients',
          'Two-color gradients across large surfaces with low contrast (e.g. '
          '0xFF1A1A1A → 0xFF1C1C1C) show step banding. Engine dithering helps; '
          'consider 8-bit noise overlay for hero surfaces.',
        ),
        _perfRow(
          'sRGB vs DisplayP3',
          'painting.Gradient interpolates in sRGB by default. On wide-gamut '
          'displays this can look dull. Future Flutter releases expose colorSpace '
          'on Gradient — when available, P3 produces more vibrant mid-tones.',
        ),
        _perfRow(
          'gradients vs custom shaders',
          'A LinearGradient is a single GPU-fast gradient draw call. A custom '
          'FragmentShader is significantly more expensive and recompiles on '
          'first use. Prefer gradients whenever you can express the effect with one.',
        ),
        _perfRow(
          'createShader allocation',
          'Every call to createShader allocates a new ui.Shader. Avoid building '
          'gradients inside paint() — build them once and cache, or use '
          'BoxDecoration which handles caching internally.',
        ),
      ],
    ),
  );
}

Widget _perfRow(String title, String body) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.only(top: 6.0, right: 10.0),
          decoration: BoxDecoration(
            color: kSpecOrange,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: kInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  color: kIron,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// COMPOSITE SHOWPIECES - 3 cards
// ============================================================================
Widget _buildComposites() {
  return _sectionCard(
    title: '14 · Composite specimens',
    subtitle: 'Three showpiece cards combining gradient, shadow, and overlay',
    child: Column(
      children: <Widget>[
        _showpieceCard(
          tag: 'showpiece · sunrise',
          title: 'Sunrise hero card',
          body: 'LinearGradient warm-orange to cool-violet, soft elevation shadow, '
              'inset highlight at top.',
          builder: () => Container(
            height: 160.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  kSpecYellow,
                  kSpecOrange,
                  kSpecPink,
                  kSpecViolet,
                ],
                stops: <double>[0.0, 0.3, 0.7, 1.0],
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x55E94F4F),
                  blurRadius: 20.0,
                  offset: Offset(0.0, 8.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  height: 40.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0x55FFFFFF),
                          Color(0x00FFFFFF),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _showpieceCard(
          tag: 'showpiece · neon',
          title: 'Neon glow strip',
          body: 'SweepGradient color wheel under a dark veil, with a thin glow ring '
              'and rounded body.',
          builder: () => Container(
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: kInk,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x664F7DD9),
                  blurRadius: 18.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: SweepGradient(
                      center: Alignment.center,
                      startAngle: 0.0,
                      endAngle: math.pi * 2.0,
                      colors: kRainbow + <Color>[kSpecRed],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x99000000),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Center(
                    child: Text(
                      'NEON',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 22.0,
                        letterSpacing: 6.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _showpieceCard(
          tag: 'showpiece · frost',
          title: 'Frosted gradient glass',
          body: 'Linear pastel gradient under a translucent white veil with cream '
              'frame, simulating a frosted card surface.',
          builder: () => Container(
            height: 130.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[kSpecCyan, kSpecBlue, kSpecIndigo],
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xAAFAF6EC),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Color(0x66FFFFFF), width: 2.0),
              ),
              child: Center(
                child: Text(
                  'frosted glass',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600,
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

Widget _showpieceCard({
  required String tag,
  required String title,
  required String body,
  required Widget Function() builder,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kCream,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kTape, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tag,
          style: TextStyle(
            color: kFog,
            fontSize: 9.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            color: kInk,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(color: kIron, fontSize: 11.5, height: 1.4),
        ),
        SizedBox(height: 12.0),
        builder(),
      ],
    ),
  );
}

// ============================================================================
// RECIPE CARDS - 6
// ============================================================================
Widget _buildRecipes() {
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Sunrise hero header',
      summary: 'LinearGradient topCenter→bottomCenter, warm-to-cool, 4 stops',
      snippet: 'LinearGradient(\n'
          '  begin: Alignment.topCenter,\n'
          '  end: Alignment.bottomCenter,\n'
          '  colors: [yellow, orange, pink, violet],\n'
          '  stops: [0.0, 0.3, 0.7, 1.0],\n'
          ')',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[kSpecYellow, kSpecOrange, kSpecPink, kSpecViolet],
        stops: <double>[0.0, 0.3, 0.7, 1.0],
      ),
    ),
    _Recipe(
      title: 'Neon glow strip',
      summary: 'SweepGradient rainbow + dark overlay, glow shadow',
      snippet: 'SweepGradient(\n'
          '  startAngle: 0,\n'
          '  endAngle: 2*pi,\n'
          '  colors: [...rainbow, red],\n'
          ')',
      gradient: SweepGradient(
        startAngle: 0.0,
        endAngle: math.pi * 2.0,
        colors: kRainbow + <Color>[kSpecRed],
      ),
    ),
    _Recipe(
      title: 'Color-wheel selector ring',
      summary: 'SweepGradient full circle, masked to ring shape via padding',
      snippet: 'SweepGradient(\n'
          '  center: Alignment.center,\n'
          '  startAngle: 0,\n'
          '  endAngle: 2*pi,\n'
          '  colors: rainbow,\n'
          ')\n'
          '+ inner circle hole',
      gradient: SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2.0,
        colors: <Color>[
          kSpecRed,
          kSpecOrange,
          kSpecYellow,
          kSpecGreen,
          kSpecCyan,
          kSpecBlue,
          kSpecViolet,
          kSpecRed,
        ],
      ),
    ),
    _Recipe(
      title: 'Frosted glass overlay',
      summary: 'LinearGradient pastel + Color(0xAAFAF6EC) veil + border 2px',
      snippet: 'Container(\n'
          '  decoration: BoxDecoration(\n'
          '    gradient: LinearGradient(...),\n'
          '  ),\n'
          '  child: veil with white border\n'
          ')',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kSpecCyan, kSpecIndigo],
      ),
    ),
    _Recipe(
      title: 'Gradient text title',
      summary: 'ShaderMask wraps Text, BlendMode.srcIn',
      snippet: 'ShaderMask(\n'
          '  shaderCallback: (b) => grad.createShader(b),\n'
          '  blendMode: BlendMode.srcIn,\n'
          '  child: Text(\'...\'),\n'
          ')',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kSpecPink, kSpecViolet, kSpecBlue],
      ),
    ),
    _Recipe(
      title: 'Spotlight focal radial',
      summary: 'RadialGradient with focal offset for off-center highlight',
      snippet: 'RadialGradient(\n'
          '  center: Alignment.center,\n'
          '  radius: 0.8,\n'
          '  focal: Alignment.topLeft,\n'
          '  focalRadius: 0.1,\n'
          '  colors: [white, blue, ink],\n'
          ')',
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        focal: Alignment.topLeft,
        focalRadius: 0.1,
        colors: <Color>[Color(0xFFFFFFFF), kSpecBlue, kInk],
      ),
    ),
  ];

  return _sectionCard(
    title: '15 · Recipe cards',
    subtitle: 'Six ready-to-use gradient compositions',
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 0.95,
      children: recipes.map(_recipeCard).toList(growable: false),
    ),
  );
}

Widget _recipeCard(_Recipe r) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kCream,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kTape, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            gradient: r.gradient,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          r.title,
          style: TextStyle(
            color: kInk,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          r.summary,
          style: TextStyle(color: kIron, fontSize: 10.0, height: 1.3),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: kInk,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            r.snippet,
            style: TextStyle(
              color: kCream,
              fontSize: 9.0,
              height: 1.3,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.summary,
    required this.snippet,
    required this.gradient,
  });
  final String title;
  final String summary;
  final String snippet;
  final Gradient gradient;
}

// ============================================================================
// COMPARISON TABLE
// ============================================================================
Widget _buildComparisonTable() {
  return _sectionCard(
    title: '16 · Comparison table',
    subtitle: 'Linear / Radial / Sweep — axis params, use cases, cost',
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: kTape, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          _cmpHeader(),
          _cmpRow(
            'LinearGradient',
            'begin, end',
            'headers, buttons, bg fills',
            'cheap — single linear pass',
          ),
          _cmpRow(
            'RadialGradient',
            'center, radius, focal, focalRadius',
            'spotlights, sun, glow halos',
            'cheap — single radial pass',
          ),
          _cmpRow(
            'SweepGradient',
            'center, startAngle, endAngle',
            'color wheel, progress arc, pie',
            'cheap — single sweep pass',
          ),
          _cmpRow(
            'ui.Gradient',
            'raw Offsets + matrix4',
            'custom painters, advanced fx',
            'cheap if cached, expensive if rebuilt',
          ),
        ],
      ),
    ),
  );
}

Widget _cmpHeader() {
  return Container(
    decoration: BoxDecoration(
      color: kCharcoal,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      children: <Widget>[
        _cmpHeadCell('Class', 2),
        _cmpHeadCell('Axis params', 3),
        _cmpHeadCell('Typical use', 3),
        _cmpHeadCell('Cost', 2),
      ],
    ),
  );
}

Widget _cmpHeadCell(String label, int flex) {
  return Expanded(
    flex: flex,
    child: Text(
      label,
      style: TextStyle(
        color: kCream,
        fontSize: 10.0,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget _cmpRow(String a, String b, String c, String d) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: kTape, width: 1.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(a, style: TextStyle(
            color: kInk,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
          )),
        ),
        Expanded(
          flex: 3,
          child: Text(b, style: TextStyle(color: kIron, fontSize: 11.0)),
        ),
        Expanded(
          flex: 3,
          child: Text(c, style: TextStyle(color: kIron, fontSize: 11.0)),
        ),
        Expanded(
          flex: 2,
          child: Text(d, style: TextStyle(color: kIron, fontSize: 11.0)),
        ),
      ],
    ),
  );
}

// ============================================================================
// PITFALLS
// ============================================================================
Widget _buildPitfalls() {
  return _sectionCard(
    title: '17 · Pitfalls',
    subtitle: 'Five recurring foot-guns when working with gradients',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _pitfall(
          'stops.length must equal colors.length',
          'If supplied, the lengths must match exactly. Mismatch throws AssertionError '
          'at construction time. Always cross-check after editing colors.',
        ),
        _pitfall(
          'TileMode.decal needs framework level support',
          'Older Skia/Impeller branches may fall back to clamp. Validate on target '
          'platforms; provide a clamp fallback for older Flutter channels.',
        ),
        _pitfall(
          'large gradients rebuilt every frame are expensive',
          'Building Gradient inside paint() per-frame allocates a Shader per call. '
          'Hoist into a field, or rely on BoxDecoration\'s built-in caching.',
        ),
        _pitfall(
          'transform expects unit space [-1, 1] × [-1, 1]',
          'Alignment-based gradients live in shader space normalized to the Rect. '
          'GradientTransform.transform receives the actual paint Rect — bridge them '
          'carefully.',
        ),
        _pitfall(
          'colors interpolate in sRGB',
          'A red→green linear gradient passes through muddy yellow, not vivid lime. '
          'Add an intermediate explicit color stop to control the perceived blend.',
        ),
      ],
    ),
  );
}

Widget _pitfall(String title, String body) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(color: kSpecRed, width: 4.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: kInk,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            body,
            style: TextStyle(color: kIron, fontSize: 11.5, height: 1.45),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// GLOSSARY
// ============================================================================
Widget _buildGlossary() {
  final List<List<String>> terms = <List<String>>[
    <String>['Gradient', 'Abstract parent for parametric color fields, produces a Shader.'],
    <String>['LinearGradient', 'Concrete gradient along a straight begin→end axis.'],
    <String>['RadialGradient', 'Concrete gradient radiating from a center, optional focal.'],
    <String>['SweepGradient', 'Concrete gradient sweeping angularly around a center.'],
    <String>['Shader', 'dart:ui object that fills pixels; attached to Paint.shader.'],
    <String>['GradientStop', 'A double in [0,1] paired with a color, defining where the color lives.'],
    <String>['TileMode', 'How a gradient repeats outside its primary axis: clamp/repeat/mirror/decal.'],
    <String>['GradientTransform', 'Abstract shader-space transform applied during createShader.'],
    <String>['GradientRotation', 'Concrete GradientTransform that rotates the gradient by radians.'],
    <String>['ColorSpace', 'How colors are interpolated; sRGB default, P3 future opt-in.'],
    <String>['dithering', 'Adding noise to mitigate banding on subtle gradients.'],
    <String>['banding', 'Visible stair-steps in low-contrast gradients on 8-bit displays.'],
    <String>['ShaderMask', 'Widget that uses a shader as a mask for its child via BlendMode.'],
    <String>['Alignment', 'Normalized 2D position in [-1, 1]² used by Gradient endpoints.'],
    <String>['ui.Gradient', 'Low-level dart:ui factory class for raw shader creation.'],
    <String>['createShader', 'Method on Gradient that materializes a Shader bound to a Rect.'],
    <String>['BoxDecoration.gradient', 'Decoration slot painting a gradient inside a Rect-shaped box.'],
    <String>['ShapeDecoration.gradient', 'Decoration slot painting a gradient inside a ShapeBorder.'],
  ];

  return _sectionCard(
    title: '18 · Glossary',
    subtitle: 'Eighteen terms for the gradient vocabulary',
    child: Column(
      children: terms.map((List<String> t) => _glossaryRow(t[0], t[1])).toList(growable: false),
    ),
  );
}

Widget _glossaryRow(String term, String def) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            term,
            style: TextStyle(
              color: kInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            def,
            style: TextStyle(color: kIron, fontSize: 11.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE
// ============================================================================
Widget _buildEpilogue() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kInk,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'EPILOGUE',
          style: TextStyle(
            color: kFog,
            fontSize: 10.0,
            letterSpacing: 3.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Gradients are the cheapest, most expressive shader you can paint in Flutter. '
          'Three shapes; one abstract Gradient parent; one underlying ui.Gradient surface. '
          'Understanding their stops, tile modes, and transforms is enough to express '
          'most ambient color effects without writing a single FragmentShader.',
          style: TextStyle(
            color: kCream,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 6.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: kRainbow),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(height: 12.0),
        Center(
          child: Text(
            'Spectrum Lab · Gradient Rendering · Flutter Painting',
            style: TextStyle(color: kFog, fontSize: 11.0),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SHARED HELPERS
// ============================================================================
Widget _sectionCard({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kTape, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: kInk,
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: kIron,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        child,
      ],
    ),
  );
}

Widget _specimenCard({
  required String label,
  required String detail,
  required Widget swatch,
}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kCream,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kTape, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: swatch),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            color: kInk,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          detail,
          style: TextStyle(color: kIron, fontSize: 10.0, height: 1.3),
        ),
      ],
    ),
  );
}

Widget _bodyText(String s) {
  return Text(
    s,
    style: TextStyle(color: kIron, fontSize: 12.5, height: 1.5),
  );
}

Widget _bullet(String s) {
  return Padding(
    padding: EdgeInsets.only(left: 6.0, bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('• ', style: TextStyle(color: kSpecBlue, fontSize: 12.5, fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            s,
            style: TextStyle(color: kIron, fontSize: 12.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(String name, String type, String desc) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            name,
            style: TextStyle(
              color: kInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 240.0,
          child: Text(
            type,
            style: TextStyle(
              color: kSpecBlue,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(color: kIron, fontSize: 11.5, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _calloutBox({required String title, required String body}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kInk,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color: kSpecYellow,
            fontSize: 10.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(color: kCream, fontSize: 12.0, height: 1.5),
        ),
      ],
    ),
  );
}
