// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual tour of the advanced Decoration family from
// package:flutter/painting.dart. Walks through BoxDecoration, ShapeDecoration,
// the gradient family, BoxShadow stacks, Border/BorderRadius variants, the
// ShapeBorder gallery, DecorationImage property surfacing, blend modes, lerp
// transitions and a sheaf of recipe cards. Each specimen is a real Container
// rendered in a Scaffold ListView so the painter's intent is visible at a
// glance — like leafing through an interior designer's swatch book.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ============================================================================
// PALETTES — cream, charcoal, dusty rose, and accent jewel tones. Defined as
// top-level constants so every section can reach in for a coordinated look.
// ============================================================================

const Color _cream = Color(0xFFF6EFE3);
const Color _creamDeep = Color(0xFFEADFC8);
const Color _charcoal = Color(0xFF2A2A2A);
const Color _charcoalSoft = Color(0xFF4A4A4A);
const Color _dustyRose = Color(0xFFC9A0A6);
const Color _dustyRoseDeep = Color(0xFFA77B82);
const Color _ink = Color(0xFF14171F);
const Color _sage = Color(0xFF9CAF88);
const Color _ochre = Color(0xFFD4A24C);
const Color _midnight = Color(0xFF1B2A41);
const Color _porcelain = Color(0xFFFAF7F2);
const Color _claret = Color(0xFF7A2E3D);
const Color _verdigris = Color(0xFF4C7A6E);
const Color _amber = Color(0xFFE3A857);
const Color _slate = Color(0xFF5B6A77);

// ============================================================================
// TEXT STYLES — section headings, body, callouts, code snippets. Kept here so
// the section helpers stay focused on layout rather than typography.
// ============================================================================

const TextStyle _kHero = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w900,
  letterSpacing: 1.2,
  color: _charcoal,
);

const TextStyle _kSection = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w800,
  color: _charcoal,
  letterSpacing: 0.4,
);

const TextStyle _kSubsection = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: _charcoalSoft,
);

const TextStyle _kBody = TextStyle(
  fontSize: 13.5,
  height: 1.55,
  color: _charcoal,
);

const TextStyle _kCaption = TextStyle(
  fontSize: 11.5,
  fontStyle: FontStyle.italic,
  color: _charcoalSoft,
);

const TextStyle _kCode = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  height: 1.45,
  color: _ink,
);

const TextStyle _kLabel = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.8,
  color: _claret,
);

// ============================================================================
// MAIN ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('advanced_decorations_test: opening the painter\'s swatch book');
  print('Sections: hero, concept, anatomy, color, gradients, stops,');
  print('  shadows, borders, radii, shapes, image, blend, side-by-side,');
  print('  composite, lerp, recipes, comparison, pitfalls, glossary, colophon');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Advanced Decorations — Swatch Book',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _cream,
      primaryColor: _charcoal,
      textTheme: const TextTheme(bodyMedium: _kBody),
    ),
    home: Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 60),
          children: <Widget>[
            _heroHeader(),
            const SizedBox(height: 32),
            _conceptOverview(),
            const SizedBox(height: 32),
            _anatomyOfBoxDecoration(),
            const SizedBox(height: 32),
            _colorSlotShowcase(),
            const SizedBox(height: 32),
            _gradientGallery(),
            const SizedBox(height: 32),
            _stopsAndAlignment(),
            const SizedBox(height: 32),
            _shadowStacks(),
            const SizedBox(height: 32),
            _borderFamily(),
            const SizedBox(height: 32),
            _borderRadiusVariants(),
            const SizedBox(height: 32),
            _shapeBorderGallery(),
            const SizedBox(height: 32),
            _decorationImageShowcase(),
            const SizedBox(height: 32),
            _blendModeDemo(),
            const SizedBox(height: 32),
            _shapeVsBoxComparison(),
            const SizedBox(height: 32),
            _compositeLuxuryCard(),
            const SizedBox(height: 32),
            _lerpAndTween(),
            const SizedBox(height: 32),
            _recipeCards(),
            const SizedBox(height: 32),
            _comparisonTable(),
            const SizedBox(height: 32),
            _pitfalls(),
            const SizedBox(height: 32),
            _glossary(),
            const SizedBox(height: 32),
            _colophon(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// REUSABLE BUILDING BLOCKS
// ============================================================================

Widget _sectionHeader(String number, String title, String subtitle) {
  return Container(
    decoration: BoxDecoration(
      color: _porcelain,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _creamDeep, width: 1.4),
    ),
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: _claret,
                shape: BoxShape.circle,
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: _porcelain,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: _kSection)),
          ],
        ),
        const SizedBox(height: 8),
        Text(subtitle, style: _kCaption),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFF1ECE0),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _creamDeep),
    ),
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
    child: Text(code, style: _kCode),
  );
}

Widget _specimenLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Text(text, style: _kLabel, textAlign: TextAlign.center),
  );
}

Widget _specimenCaption(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: Text(text, style: _kCaption, textAlign: TextAlign.center),
  );
}

Widget _specimenTile({
  required String label,
  required String caption,
  required Widget swatch,
}) {
  return SizedBox(
    width: 160,
    child: Column(
      children: <Widget>[
        swatch,
        _specimenLabel(label),
        _specimenCaption(caption),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1 — HERO HEADER
// ============================================================================

Widget _heroHeader() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 32, 28, 30),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_dustyRose, _claret, _charcoal],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _porcelain.withOpacity(0.18),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _porcelain.withOpacity(0.4)),
          ),
          child: const Text(
            'PAINTING · DECORATION FAMILY',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w800,
              color: _porcelain,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'BoxDecoration & friends',
          style: _kHero.copyWith(color: _porcelain),
        ),
        const SizedBox(height: 4),
        Text(
          'the painter\'s palette',
          style: _kHero.copyWith(
            color: _cream,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'A deep visual tour of Flutter\'s decoration system — gradients, '
          'shadows, borders, shapes and the quiet art of painting inside a '
          'rectangular box. Leaf through this swatch book like a fabric '
          'sample binder in a designer\'s atelier.',
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.55,
            color: _porcelain,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — CONCEPT OVERVIEW
// ============================================================================

Widget _conceptOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '02',
        'Concept overview',
        'Decoration is abstract — concrete classes plug into DecoratedBox.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Decoration is the abstract base. BoxDecoration paints inside a '
              'rectangular box (with optional circle shape). ShapeDecoration '
              'delegates the outline to a ShapeBorder. FlutterLogoDecoration '
              'and UnderlineTabIndicator are specialised siblings.',
              style: _kBody,
            ),
            const SizedBox(height: 14),
            const Text('Painting order inside one decoration:', style: _kSubsection),
            const SizedBox(height: 8),
            _paintingOrderRow(),
            const SizedBox(height: 14),
            const Text(
              'Each layer is optional. Shadows fire first so the rest of the '
              'paint lands cleanly on top; borders are stroked last so they '
              'sit on the outermost pixels.',
              style: _kBody,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _paintingOrderRow() {
  final List<_OrderStep> steps = <_OrderStep>[
    _OrderStep('1', 'Shadows', _slate),
    _OrderStep('2', 'Color / Gradient', _dustyRose),
    _OrderStep('3', 'Image', _ochre),
    _OrderStep('4', 'Border', _charcoal),
  ];
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: <Widget>[
      for (final _OrderStep s in steps)
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: s.color.withOpacity(0.14),
            borderRadius: BorderRadius.circular(8),
            border: Border(left: BorderSide(color: s.color, width: 4)),
          ),
          child: Row(
            children: <Widget>[
              Text(s.number,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: s.color,
                  )),
              const SizedBox(width: 10),
              Text(s.label, style: _kSubsection),
            ],
          ),
        ),
    ],
  );
}

class _OrderStep {
  final String number;
  final String label;
  final Color color;
  const _OrderStep(this.number, this.label, this.color);
}

// ============================================================================
// SECTION 3 — ANATOMY OF BOXDECORATION
// ============================================================================

Widget _anatomyOfBoxDecoration() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '03',
        'Anatomy of a BoxDecoration',
        'Eight named slots, each demonstrated in isolation.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 22,
          children: <Widget>[
            _anatomySlot('color',
                'Solid fill applied behind everything else.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: _dustyRose,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
            _anatomySlot('gradient',
                'Overrides color when both are set — paints linear/radial/sweep.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[_amber, _claret],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
            _anatomySlot('image',
                'DecorationImage — paints above color/gradient.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: _verdigris,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, color: _porcelain, size: 36),
                )),
            _anatomySlot('border',
                'Stroked outline drawn last; supports per-side configuration.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: _cream,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _charcoal, width: 4),
                  ),
                )),
            _anatomySlot('borderRadius',
                'Only valid for rectangle shape; rounds each corner.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: _ochre,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                )),
            _anatomySlot('boxShadow',
                'A list — each shadow layered, painted before the box.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: _porcelain,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x44000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                )),
            _anatomySlot('shape',
                'BoxShape.rectangle (default) or circle.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: const BoxDecoration(
                    color: _sage,
                    shape: BoxShape.circle,
                  ),
                )),
            _anatomySlot('backgroundBlendMode',
                'How the color/gradient blends with anything beneath.',
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: _claret.withOpacity(0.85),
                    backgroundBlendMode: BlendMode.multiply,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
          ],
        ),
      ),
    ],
  );
}

Widget _anatomySlot(String name, String description, Widget swatch) {
  return SizedBox(
    width: 200,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        swatch,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: _kLabel),
              const SizedBox(height: 4),
              Text(description, style: _kCaption),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — COLOR SLOT SHOWCASE
// ============================================================================

Widget _colorSlotShowcase() {
  final List<_ColorSwatch> swatches = <_ColorSwatch>[
    _ColorSwatch('warm sand', const Color(0xFFE8C9A3)),
    _ColorSwatch('cool slate', _slate),
    _ColorSwatch('mono noir', _ink),
    _ColorSwatch('jewel emerald', const Color(0xFF1F6E55)),
    _ColorSwatch('pastel mint', const Color(0xFFCDE7DA)),
    _ColorSwatch('dusty rose', _dustyRose),
    _ColorSwatch('claret', _claret),
    _ColorSwatch('amber sun', _amber),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '04',
        'The color slot',
        'A simple fill — but choice of hue carries the mood.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 18,
          runSpacing: 18,
          children: <Widget>[
            for (final _ColorSwatch s in swatches)
              _specimenTile(
                label: s.name,
                caption: '0x${s.color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                swatch: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: s.color,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class _ColorSwatch {
  final String name;
  final Color color;
  const _ColorSwatch(this.name, this.color);
}

// ============================================================================
// SECTION 5 — GRADIENT GALLERY
// ============================================================================

Widget _gradientGallery() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '05',
        'Gradient gallery',
        'Linear, radial and sweep — three shapes of color motion.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('LinearGradient — four angles', style: _kSubsection),
            const SizedBox(height: 12),
            _linearGradientRow(),
            const SizedBox(height: 24),
            const Text('RadialGradient — four configs', style: _kSubsection),
            const SizedBox(height: 12),
            _radialGradientRow(),
            const SizedBox(height: 24),
            const Text('SweepGradient — four configs', style: _kSubsection),
            const SizedBox(height: 12),
            _sweepGradientRow(),
          ],
        ),
      ),
    ],
  );
}

Widget _linearGradientRow() {
  final List<_LinearSpec> specs = <_LinearSpec>[
    _LinearSpec(
      'horizontal',
      const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[_dustyRose, _claret],
      ),
      'LinearGradient(centerLeft → centerRight, [rose, claret])',
    ),
    _LinearSpec(
      'vertical',
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_amber, _ochre, _claret],
      ),
      'LinearGradient(topCenter → bottomCenter, 3 stops)',
    ),
    _LinearSpec(
      'diagonal',
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_verdigris, _midnight],
      ),
      'LinearGradient(topLeft → bottomRight)',
    ),
    _LinearSpec(
      'reverse diag',
      const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: <Color>[_sage, _ochre, _claret],
        stops: <double>[0.0, 0.4, 1.0],
      ),
      'LinearGradient(bottomLeft → topRight, weighted)',
    ),
  ];
  return Wrap(
    spacing: 18,
    runSpacing: 18,
    children: <Widget>[
      for (final _LinearSpec s in specs)
        _specimenTile(
          label: s.name,
          caption: s.code,
          swatch: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: s.gradient,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
    ],
  );
}

class _LinearSpec {
  final String name;
  final LinearGradient gradient;
  final String code;
  const _LinearSpec(this.name, this.gradient, this.code);
}

Widget _radialGradientRow() {
  final List<_RadialSpec> specs = <_RadialSpec>[
    _RadialSpec(
      'centred',
      const RadialGradient(
        center: Alignment.center,
        radius: 0.6,
        colors: <Color>[_porcelain, _dustyRoseDeep],
      ),
      'RadialGradient(center, radius: 0.6)',
    ),
    _RadialSpec(
      'top-left bias',
      const RadialGradient(
        center: Alignment(-0.6, -0.6),
        radius: 0.9,
        colors: <Color>[_amber, _claret, _midnight],
        stops: <double>[0.0, 0.5, 1.0],
      ),
      'center: (-0.6, -0.6), 3 stops',
    ),
    _RadialSpec(
      'focal offset',
      const RadialGradient(
        center: Alignment.center,
        radius: 0.7,
        focal: Alignment(0.3, -0.3),
        focalRadius: 0.05,
        colors: <Color>[_cream, _verdigris, _midnight],
      ),
      'focal: (0.3, -0.3), focalRadius: 0.05',
    ),
    _RadialSpec(
      'mirror tile',
      const RadialGradient(
        center: Alignment.center,
        radius: 0.25,
        tileMode: TileMode.mirror,
        colors: <Color>[_porcelain, _claret],
      ),
      'tileMode: mirror, radius: 0.25',
    ),
  ];
  return Wrap(
    spacing: 18,
    runSpacing: 18,
    children: <Widget>[
      for (final _RadialSpec s in specs)
        _specimenTile(
          label: s.name,
          caption: s.code,
          swatch: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: s.gradient,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
    ],
  );
}

class _RadialSpec {
  final String name;
  final RadialGradient gradient;
  final String code;
  const _RadialSpec(this.name, this.gradient, this.code);
}

Widget _sweepGradientRow() {
  final double tau = math.pi * 2;
  final List<_SweepSpec> specs = <_SweepSpec>[
    _SweepSpec(
      'full circle',
      SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: tau,
        colors: const <Color>[_claret, _amber, _verdigris, _midnight, _claret],
      ),
      'startAngle: 0, endAngle: 2π',
    ),
    _SweepSpec(
      'half sweep',
      SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi,
        colors: const <Color>[_dustyRose, _claret],
        tileMode: TileMode.clamp,
      ),
      'startAngle: 0, endAngle: π, clamp',
    ),
    _SweepSpec(
      'offset start',
      SweepGradient(
        center: Alignment.center,
        startAngle: math.pi / 4,
        endAngle: math.pi / 4 + tau * 0.75,
        colors: const <Color>[_amber, _ochre, _claret, _midnight],
      ),
      'start: π/4, length: 3/4 turn',
    ),
    _SweepSpec(
      'repeat tile',
      SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi / 2,
        tileMode: TileMode.repeated,
        colors: const <Color>[_porcelain, _verdigris],
      ),
      'endAngle: π/2, tileMode: repeated',
    ),
  ];
  return Wrap(
    spacing: 18,
    runSpacing: 18,
    children: <Widget>[
      for (final _SweepSpec s in specs)
        _specimenTile(
          label: s.name,
          caption: s.code,
          swatch: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: s.gradient,
              shape: BoxShape.circle,
            ),
          ),
        ),
    ],
  );
}

class _SweepSpec {
  final String name;
  final SweepGradient gradient;
  final String code;
  const _SweepSpec(this.name, this.gradient, this.code);
}

// ============================================================================
// SECTION 6 — STOPS & ALIGNMENT
// ============================================================================

Widget _stopsAndAlignment() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '06',
        'Stops & alignment',
        'How weighted stops, multi-color stops and transforms shift the look.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 18,
          runSpacing: 18,
          children: <Widget>[
            _specimenTile(
              label: 'equal stops',
              caption: 'stops: [0.0, 0.5, 1.0]',
              swatch: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[_dustyRose, _amber, _verdigris],
                    stops: <double>[0.0, 0.5, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            _specimenTile(
              label: 'weighted stops',
              caption: 'stops: [0.0, 0.85, 1.0] — rose dominates',
              swatch: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[_dustyRose, _claret, _midnight],
                    stops: <double>[0.0, 0.85, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            _specimenTile(
              label: 'multi-color',
              caption: '5 colors, even spacing',
              swatch: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      _claret,
                      _amber,
                      _sage,
                      _verdigris,
                      _midnight,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            _specimenTile(
              label: 'transform',
              caption: 'GradientRotation(π/4)',
              swatch: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: const <Color>[_amber, _claret],
                    transform: GradientRotation(math.pi / 4),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 7 — BOXSHADOW STACKS
// ============================================================================

Widget _shadowStacks() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '07',
        'BoxShadow stacks',
        'A list of shadows, painted before the box. Combine for depth.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 26,
          children: <Widget>[
            _shadowSpecimen(
              'single drop',
              'one offset (0, 6), blur 14',
              const <BoxShadow>[
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            _shadowSpecimen(
              'multi-layer',
              'near + far shadows for depth',
              const <BoxShadow>[
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 18,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            _shadowSpecimen(
              'inner glow',
              'spreadRadius negative on tight blur',
              const <BoxShadow>[
                BoxShadow(
                  color: Color(0x55FFFFFF),
                  blurRadius: 6,
                  spreadRadius: -2,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            _shadowSpecimen(
              'neumorphism',
              'paired light + dark offsets',
              const <BoxShadow>[
                BoxShadow(
                  color: Color(0x55FFFFFF),
                  blurRadius: 12,
                  offset: Offset(-6, -6),
                ),
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 12,
                  offset: Offset(6, 6),
                ),
              ],
            ),
            _shadowSpecimen(
              'ambient + dir',
              'soft ambient + directional drop',
              const <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Color(0x44000000),
                  blurRadius: 10,
                  offset: Offset(4, 8),
                ),
              ],
            ),
            _shadowSpecimen(
              'colored shadow',
              'BoxShadow(color: claret, blur 18)',
              const <BoxShadow>[
                BoxShadow(
                  color: Color(0x667A2E3D),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shadowSpecimen(String name, String caption, List<BoxShadow> shadows) {
  return SizedBox(
    width: 170,
    child: Column(
      children: <Widget>[
        Container(
          width: 120,
          height: 80,
          decoration: BoxDecoration(
            color: _porcelain,
            borderRadius: BorderRadius.circular(10),
            boxShadow: shadows,
          ),
        ),
        const SizedBox(height: 12),
        Text(name, style: _kLabel, textAlign: TextAlign.center),
        const SizedBox(height: 2),
        Text(caption, style: _kCaption, textAlign: TextAlign.center),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 — BORDER FAMILY
// ============================================================================

Widget _borderFamily() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '08',
        'Border family',
        'Border.all, mixed sides, BorderDirectional, fromBorderSide.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 22,
          children: <Widget>[
            _borderSpecimen(
              'Border.all',
              Border.all(color: _charcoal, width: 3),
              'uniform 3px',
            ),
            _borderSpecimen(
              'mixed sides',
              const Border(
                top: BorderSide(color: _claret, width: 4),
                right: BorderSide(color: _amber, width: 2),
                bottom: BorderSide(color: _verdigris, width: 4),
                left: BorderSide(color: _midnight, width: 2),
              ),
              'distinct colors + widths',
            ),
            _borderSpecimen(
              'BorderDirectional',
              const BorderDirectional(
                start: BorderSide(color: _claret, width: 5),
                end: BorderSide(color: _sage, width: 5),
                top: BorderSide(color: _charcoal, width: 1),
                bottom: BorderSide(color: _charcoal, width: 1),
              ),
              'start/end respect text direction',
            ),
            _borderSpecimen(
              'fromBorderSide',
              Border.fromBorderSide(
                const BorderSide(
                  color: _charcoal,
                  width: 2.5,
                  style: BorderStyle.solid,
                ),
              ),
              'shorthand for uniform side',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _borderSpecimen(String name, BoxBorder border, String caption) {
  return SizedBox(
    width: 170,
    child: Column(
      children: <Widget>[
        Container(
          width: 130,
          height: 80,
          decoration: BoxDecoration(
            color: _cream,
            border: border,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 10),
        Text(name, style: _kLabel, textAlign: TextAlign.center),
        const SizedBox(height: 2),
        Text(caption, style: _kCaption, textAlign: TextAlign.center),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — BORDER RADIUS VARIANTS
// ============================================================================

Widget _borderRadiusVariants() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '09',
        'BorderRadius variants',
        'Six ways to round the corners of a rectangular box.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 22,
          children: <Widget>[
            _radiusSpecimen(
              'BorderRadius.zero',
              BorderRadius.zero,
              'sharp 90° corners',
            ),
            _radiusSpecimen(
              'circular(20)',
              BorderRadius.circular(20),
              'uniform 20px on all corners',
            ),
            _radiusSpecimen(
              'only TL+BR',
              const BorderRadius.only(
                topLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              'diagonal asymmetry',
            ),
            _radiusSpecimen(
              'elliptical',
              const BorderRadius.all(Radius.elliptical(40, 12)),
              'Radius.elliptical(40, 12)',
            ),
            _radiusSpecimen(
              'vertical',
              const BorderRadius.vertical(top: Radius.circular(28)),
              'BorderRadius.vertical(top)',
            ),
            _radiusSpecimen(
              'horizontal',
              const BorderRadius.horizontal(right: Radius.circular(28)),
              'BorderRadius.horizontal(right)',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _radiusSpecimen(String name, BorderRadius radius, String caption) {
  return SizedBox(
    width: 170,
    child: Column(
      children: <Widget>[
        Container(
          width: 130,
          height: 80,
          decoration: BoxDecoration(
            color: _dustyRose,
            borderRadius: radius,
          ),
        ),
        const SizedBox(height: 10),
        Text(name, style: _kLabel, textAlign: TextAlign.center),
        const SizedBox(height: 2),
        Text(caption, style: _kCaption, textAlign: TextAlign.center),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — SHAPEBORDER GALLERY
// ============================================================================

Widget _shapeBorderGallery() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '10',
        'ShapeBorder gallery via ShapeDecoration',
        'Six outline shapes that ShapeDecoration knows how to fill.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 22,
          children: <Widget>[
            _shapeSpecimen(
              'RoundedRectangleBorder',
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: _charcoal, width: 2),
              ),
            ),
            _shapeSpecimen(
              'BeveledRectangleBorder',
              BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: _charcoal, width: 2),
              ),
            ),
            _shapeSpecimen(
              'ContinuousRectangleBorder',
              ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: const BorderSide(color: _charcoal, width: 2),
              ),
            ),
            _shapeSpecimen(
              'StadiumBorder',
              const StadiumBorder(
                side: BorderSide(color: _charcoal, width: 2),
              ),
            ),
            _shapeSpecimen(
              'CircleBorder',
              const CircleBorder(
                side: BorderSide(color: _charcoal, width: 2),
              ),
            ),
            _shapeSpecimen(
              'OvalBorder',
              const OvalBorder(
                side: BorderSide(color: _charcoal, width: 2),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shapeSpecimen(String name, ShapeBorder shape) {
  return SizedBox(
    width: 170,
    child: Column(
      children: <Widget>[
        Container(
          width: 140,
          height: 90,
          decoration: ShapeDecoration(
            color: _amber,
            shape: shape,
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(name, style: _kLabel, textAlign: TextAlign.center),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — DECORATION IMAGE SHOWCASE (PROPERTY-TABLE STYLE)
// ============================================================================

Widget _decorationImageShowcase() {
  // No asset bundle here — we surface DecorationImage's *configured* slots
  // in a property table card. The synthetic ImageProvider trick is honest:
  // we construct the DecorationImage objects, then describe them.
  final List<_ImageRow> rows = <_ImageRow>[
    _ImageRow('fit: cover',
        'BoxFit.cover',
        'fills entirely, may clip',
        BoxFit.cover,
        Alignment.center,
        ImageRepeat.noRepeat,
        null),
    _ImageRow('fit: contain',
        'BoxFit.contain',
        'fits inside, letterboxes',
        BoxFit.contain,
        Alignment.center,
        ImageRepeat.noRepeat,
        null),
    _ImageRow('fit: fitWidth',
        'BoxFit.fitWidth',
        'matches width, may overflow vertically',
        BoxFit.fitWidth,
        Alignment.topCenter,
        ImageRepeat.noRepeat,
        null),
    _ImageRow('fit: fitHeight',
        'BoxFit.fitHeight',
        'matches height, may overflow horizontally',
        BoxFit.fitHeight,
        Alignment.centerLeft,
        ImageRepeat.noRepeat,
        null),
    _ImageRow('colorFilter',
        'ColorFilter.mode(claret, modulate)',
        'tints the image during paint',
        BoxFit.cover,
        Alignment.center,
        ImageRepeat.noRepeat,
        const ColorFilter.mode(_claret, BlendMode.modulate)),
    _ImageRow('repeatX',
        'ImageRepeat.repeatX',
        'tiles only along the X axis',
        BoxFit.none,
        Alignment.topLeft,
        ImageRepeat.repeatX,
        null),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '11',
        'DecorationImage — property table',
        'No asset bundle available; surfacing configured slots instead.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'In this scripted environment there is no AssetImage bundle and '
              'we deliberately avoid NetworkImage. Each row below configures '
              'a real DecorationImage and prints back its slot values — like '
              'a designer\'s spec card without the printed fabric stapled on.',
              style: _kBody,
            ),
            const SizedBox(height: 14),
            for (final _ImageRow r in rows) _imageRow(r),
          ],
        ),
      ),
    ],
  );
}

class _ImageRow {
  final String name;
  final String slot;
  final String description;
  final BoxFit fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final ColorFilter? colorFilter;
  const _ImageRow(this.name, this.slot, this.description, this.fit,
      this.alignment, this.repeat, this.colorFilter);
}

Widget _imageRow(_ImageRow r) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF1ECE0),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: _ochre, width: 4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(r.name, style: _kLabel),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(r.slot, style: _kCode),
              const SizedBox(height: 2),
              Text(r.description, style: _kCaption),
              const SizedBox(height: 4),
              Text(
                'fit: ${r.fit.name} · alignment: ${r.alignment} · '
                'repeat: ${r.repeat.name}'
                '${r.colorFilter != null ? ' · colorFilter: set' : ''}',
                style: _kCaption,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 — BACKGROUND BLEND MODE DEMO
// ============================================================================

Widget _blendModeDemo() {
  // Show blend modes via Stack + ColorFiltered overlays since a real
  // DecorationImage isn't available. Each tile shows the same base swatch
  // with a colored overlay blended on top.
  final List<_BlendSpec> specs = <_BlendSpec>[
    _BlendSpec('multiply', BlendMode.multiply),
    _BlendSpec('overlay', BlendMode.overlay),
    _BlendSpec('screen', BlendMode.screen),
    _BlendSpec('srcOver', BlendMode.srcOver),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '12',
        'backgroundBlendMode — overlay demo',
        'Same base, four different BlendMode overlays.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 22,
          children: <Widget>[
            for (final _BlendSpec s in specs)
              _specimenTile(
                label: s.name,
                caption: 'BlendMode.${s.mode.name}',
                swatch: Stack(
                  children: <Widget>[
                    Container(
                      width: 140,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[_amber, _claret, _midnight],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(_dustyRose, s.mode),
                      child: Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _porcelain,
                          borderRadius: BorderRadius.circular(10),
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
  );
}

class _BlendSpec {
  final String name;
  final BlendMode mode;
  const _BlendSpec(this.name, this.mode);
}

// ============================================================================
// SECTION 13 — SHAPE DECORATION VS BOX DECORATION
// ============================================================================

Widget _shapeVsBoxComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '13',
        'ShapeDecoration vs BoxDecoration',
        'Same visual goal, two different decoration classes.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('BoxDecoration', style: _kSubsection),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[_dustyRose, _claret],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: _charcoal, width: 1.5),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _codeBlock(
                    'BoxDecoration(\n'
                    '  gradient: LinearGradient(...),\n'
                    '  borderRadius: BorderRadius.circular(18),\n'
                    '  border: Border.all(width: 1.5),\n'
                    '  boxShadow: [BoxShadow(...)],\n'
                    ')',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('ShapeDecoration', style: _kSubsection),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 110,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[_dustyRose, _claret],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(color: _charcoal, width: 1.5),
                      ),
                      shadows: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _codeBlock(
                    'ShapeDecoration(\n'
                    '  gradient: LinearGradient(...),\n'
                    '  shape: RoundedRectangleBorder(\n'
                    '    borderRadius: BorderRadius.circular(18),\n'
                    '    side: BorderSide(width: 1.5),\n'
                    '  ),\n'
                    '  shadows: [BoxShadow(...)],\n'
                    ')',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 14 — COMPOSITE LUXURY CARD
// ============================================================================

Widget _compositeLuxuryCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '14',
        'Composite specimen — luxury card',
        'Gradient + shadow stack + border + radius, in concert.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 230,
              height: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[_midnight, _claret, _dustyRoseDeep],
                  stops: <double>[0.0, 0.6, 1.0],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: _amber.withOpacity(0.5),
                  width: 1.2,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 22,
                    offset: Offset(0, 14),
                  ),
                  BoxShadow(
                    color: Color(0x227A2E3D),
                    blurRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'ATELIER',
                        style: TextStyle(
                          color: _porcelain,
                          fontSize: 10,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: <Color>[_amber, _claret],
                          ),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color(0x55E3A857),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Velvet\nMaison',
                    style: TextStyle(
                      color: _porcelain,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                    ),
                  ),
                  const Text(
                    '· est. 2024 ·',
                    style: TextStyle(
                      color: _cream,
                      fontSize: 11,
                      letterSpacing: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _codeBlock(
                'Container(\n'
                '  decoration: BoxDecoration(\n'
                '    gradient: LinearGradient(\n'
                '      begin: Alignment.topLeft,\n'
                '      end: Alignment.bottomRight,\n'
                '      colors: [midnight, claret, dustyRoseDeep],\n'
                '      stops: [0.0, 0.6, 1.0],\n'
                '    ),\n'
                '    borderRadius: BorderRadius.circular(22),\n'
                '    border: Border.all(\n'
                '      color: amber.withOpacity(0.5),\n'
                '      width: 1.2,\n'
                '    ),\n'
                '    boxShadow: const [\n'
                '      BoxShadow(\n'
                '        color: Color(0x33000000),\n'
                '        blurRadius: 22,\n'
                '        offset: Offset(0, 14),\n'
                '      ),\n'
                '      BoxShadow(\n'
                '        color: Color(0x227A2E3D),\n'
                '        blurRadius: 8,\n'
                '      ),\n'
                '    ],\n'
                '  ),\n'
                ')',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 15 — LERP & DECORATION TWEEN
// ============================================================================

Widget _lerpAndTween() {
  final BoxDecoration a = BoxDecoration(
    color: _dustyRose,
    borderRadius: BorderRadius.circular(6),
    border: Border.all(color: _charcoal, width: 1),
  );
  final BoxDecoration b = BoxDecoration(
    gradient: const LinearGradient(
      colors: <Color>[_midnight, _claret],
    ),
    borderRadius: BorderRadius.circular(34),
    border: Border.all(color: _amber, width: 3),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: Color(0x55000000),
        blurRadius: 14,
        offset: Offset(0, 6),
      ),
    ],
  );
  final List<double> ts = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '15',
        'BoxDecoration.lerp & DecorationTween',
        'Five still frames of t ∈ {0, 0.25, 0.5, 0.75, 1.0}.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'DecorationTween(begin: a, end: b).evaluate(AlwaysStoppedAnimation(t))',
              style: _kCode,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 18,
              runSpacing: 18,
              children: <Widget>[
                for (final double t in ts)
                  _specimenTile(
                    label: 't = $t',
                    caption: 'BoxDecoration.lerp(a, b, $t)',
                    swatch: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration.lerp(a, b, t),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 16 — RECIPE CARDS
// ============================================================================

Widget _recipeCards() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '16',
        'Recipe cards',
        'Cookbook-style specimens for common decoration patterns.',
      ),
      const SizedBox(height: 16),
      _recipeSoftElevatedCard(),
      const SizedBox(height: 16),
      _recipeInkStampChip(),
      const SizedBox(height: 16),
      _recipeNeumorphicButton(),
      const SizedBox(height: 16),
      _recipeGradientProgressBg(),
      const SizedBox(height: 16),
      _recipeStainedGlassPanel(),
      const SizedBox(height: 16),
      _recipeHairlineDividerShadow(),
    ],
  );
}

Widget _recipeFrame(String title, String why, Widget specimen, String code) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _porcelain,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _kSubsection),
        const SizedBox(height: 4),
        Text(why, style: _kCaption),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            specimen,
            const SizedBox(width: 20),
            Expanded(child: _codeBlock(code)),
          ],
        ),
      ],
    ),
  );
}

Widget _recipeSoftElevatedCard() {
  final Widget specimen = Container(
    width: 200,
    height: 110,
    decoration: BoxDecoration(
      color: _porcelain,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 18,
          offset: Offset(0, 10),
        ),
      ],
    ),
  );
  return _recipeFrame(
    'Soft elevated card',
    'Two-layer shadow — close + far — for a Material-like float.',
    specimen,
    'BoxDecoration(\n'
    '  color: porcelain,\n'
    '  borderRadius: BorderRadius.circular(14),\n'
    '  boxShadow: [\n'
    '    BoxShadow(blurRadius: 6, offset: Offset(0, 2)),\n'
    '    BoxShadow(blurRadius: 18, offset: Offset(0, 10)),\n'
    '  ],\n'
    ')',
  );
}

Widget _recipeInkStampChip() {
  final Widget specimen = Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: _cream,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _claret, width: 2),
    ),
    child: const Text(
      'INK · STAMP',
      style: TextStyle(
        color: _claret,
        fontWeight: FontWeight.w900,
        letterSpacing: 2,
      ),
    ),
  );
  return _recipeFrame(
    'Ink-stamp bordered chip',
    'Bold 2px border + low radius + uppercase letterforms.',
    specimen,
    'BoxDecoration(\n'
    '  color: cream,\n'
    '  borderRadius: BorderRadius.circular(4),\n'
    '  border: Border.all(color: claret, width: 2),\n'
    ')',
  );
}

Widget _recipeNeumorphicButton() {
  final Widget specimen = Container(
    width: 130,
    height: 50,
    decoration: BoxDecoration(
      color: _cream,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0xFFFFFFFF),
          blurRadius: 10,
          offset: Offset(-4, -4),
        ),
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 10,
          offset: Offset(4, 4),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: const Text(
      'PRESS',
      style: TextStyle(
        color: _charcoal,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
      ),
    ),
  );
  return _recipeFrame(
    'Neumorphic button',
    'Paired light + dark shadow on each side conjures the soft 3D look.',
    specimen,
    'BoxDecoration(\n'
    '  color: cream,\n'
    '  borderRadius: BorderRadius.circular(14),\n'
    '  boxShadow: [\n'
    '    BoxShadow(color: 0xFFFFFFFF, offset: (-4,-4), blur: 10),\n'
    '    BoxShadow(color: 0x33000000, offset: (4,4), blur: 10),\n'
    '  ],\n'
    ')',
  );
}

Widget _recipeGradientProgressBg() {
  final Widget specimen = Container(
    width: 220,
    height: 14,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_amber, _claret, _midnight],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
  );
  return _recipeFrame(
    'Gradient progress bar',
    'A horizontal LinearGradient mapped onto a tall, narrow rounded box.',
    specimen,
    'BoxDecoration(\n'
    '  gradient: LinearGradient(\n'
    '    colors: [amber, claret, midnight],\n'
    '  ),\n'
    '  borderRadius: BorderRadius.circular(8),\n'
    '  boxShadow: [BoxShadow(blurRadius: 4, offset: Offset(0, 2))],\n'
    ')',
  );
}

Widget _recipeStainedGlassPanel() {
  final Widget specimen = Container(
    width: 200,
    height: 120,
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        center: Alignment(-0.3, -0.2),
        radius: 0.9,
        colors: <Color>[_amber, _claret, _midnight],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _ink, width: 4),
    ),
  );
  return _recipeFrame(
    'Stained-glass panel',
    'Heavy black "leaded" border + radial gradient with off-center focal.',
    specimen,
    'BoxDecoration(\n'
    '  gradient: RadialGradient(\n'
    '    center: Alignment(-0.3, -0.2),\n'
    '    radius: 0.9,\n'
    '    colors: [amber, claret, midnight],\n'
    '  ),\n'
    '  borderRadius: BorderRadius.circular(6),\n'
    '  border: Border.all(color: ink, width: 4),\n'
    ')',
  );
}

Widget _recipeHairlineDividerShadow() {
  final Widget specimen = Column(
    children: <Widget>[
      Container(
        width: 220,
        height: 1,
        decoration: const BoxDecoration(
          color: _charcoal,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    ],
  );
  return _recipeFrame(
    'Hairline divider with shadow',
    'A 1px divider that still casts a soft shadow — useful for sticky headers.',
    specimen,
    'BoxDecoration(\n'
    '  color: charcoal,\n'
    '  boxShadow: [\n'
    '    BoxShadow(blurRadius: 4, offset: Offset(0, 2)),\n'
    '  ],\n'
    ')',
  );
}

// ============================================================================
// SECTION 17 — COMPARISON TABLE
// ============================================================================

Widget _comparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['Class', 'Primary use', 'Slot set', 'ShapeBorder?', 'Image?'],
    <String>[
      'BoxDecoration',
      'rect/circle box paint',
      'color, gradient, image, border, borderRadius, boxShadow, shape, blendMode',
      'no (only rect/circle)',
      'yes',
    ],
    <String>[
      'ShapeDecoration',
      'arbitrary ShapeBorder',
      'color, gradient, image, shape, shadows',
      'yes',
      'yes',
    ],
    <String>[
      'FlutterLogoDecoration',
      'paint the Flutter logo',
      'textColor, style, margin, size',
      'no',
      'no',
    ],
    <String>[
      'UnderlineTabIndicator',
      'tab bar underline',
      'borderSide, insets, borderRadius',
      'no',
      'no',
    ],
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '17',
        'Comparison table',
        'Four sibling Decoration classes side by side.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < rows.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: i == 0
                      ? _charcoal
                      : (i.isEven ? _cream : _porcelain),
                  border: i == 0
                      ? null
                      : const Border(
                          bottom: BorderSide(color: _creamDeep),
                        ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int j = 0; j < rows[i].length; j++)
                      Expanded(
                        flex: j == 2 ? 3 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            rows[i][j],
                            style: i == 0
                                ? const TextStyle(
                                    color: _porcelain,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11,
                                    letterSpacing: 0.8,
                                  )
                                : _kBody.copyWith(fontSize: 12),
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
  );
}

// ============================================================================
// SECTION 18 — PITFALLS
// ============================================================================

Widget _pitfalls() {
  final List<_Pitfall> items = <_Pitfall>[
    const _Pitfall(
      'shape: circle + borderRadius',
      'Asserts at runtime — BoxShape.circle does not accept a borderRadius. '
      'Use BoxShape.rectangle with BorderRadius, or switch to ShapeDecoration '
      'with CircleBorder.',
    ),
    const _Pitfall(
      'DecorationImage vs Image widget',
      'BoxFit on DecorationImage paints at the box bounds and clips with '
      'the decoration\'s shape. The Image widget instead sizes itself to '
      'its parent constraints — different sizing math.',
    ),
    const _Pitfall(
      'Shadow ordering',
      'BoxShadows paint in list order, beneath the box. Later entries paint '
      'on top of earlier ones — important when stacking near and far layers.',
    ),
    const _Pitfall(
      'ColorFilter on image vs ColorFiltered widget',
      'DecorationImage.colorFilter affects only the image during decoration '
      'paint. ColorFiltered wraps any widget subtree — broader scope but '
      'extra paint pass.',
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '18',
        'Pitfalls',
        'Four sharp edges that bite even experienced painters.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          children: <Widget>[
            for (final _Pitfall p in items) _pitfallCard(p),
          ],
        ),
      ),
    ],
  );
}

class _Pitfall {
  final String title;
  final String body;
  const _Pitfall(this.title, this.body);
}

Widget _pitfallCard(_Pitfall p) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF5F1),
      borderRadius: BorderRadius.circular(8),
      border: const Border(
        left: BorderSide(color: _claret, width: 4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(p.title, style: _kLabel),
        const SizedBox(height: 4),
        Text(p.body, style: _kBody),
      ],
    ),
  );
}

// ============================================================================
// SECTION 19 — GLOSSARY
// ============================================================================

Widget _glossary() {
  final List<List<String>> entries = <List<String>>[
    <String>['Decoration', 'Abstract base class for what paints inside a DecoratedBox.'],
    <String>['BoxDecoration', 'Paints inside a rectangular (or circular) box.'],
    <String>['ShapeDecoration', 'Delegates the outline to a ShapeBorder.'],
    <String>['ShapeBorder', 'Describes a closed shape; can be lerped between siblings.'],
    <String>['BoxShape', 'rectangle or circle — restricts BoxDecoration outline.'],
    <String>['BoxShadow', 'Color + blur + spread + offset, painted under the box.'],
    <String>['BoxBorder', 'Base of Border and BorderDirectional.'],
    <String>['BorderRadius', 'Per-corner Radius values for rectangle shapes.'],
    <String>['BorderRadiusDirectional', 'start/end variant for RTL-aware layouts.'],
    <String>['Gradient', 'Abstract — Linear, Radial, Sweep are concrete subclasses.'],
    <String>['TileMode', 'How gradients extend past their start/end stops.'],
    <String>['DecorationImage', 'Image painted as part of a decoration.'],
    <String>['BoxFit', 'How DecorationImage scales inside its box.'],
    <String>['DecorationTween', 'Linearly interpolates between two Decorations.'],
    <String>['BlendMode', 'How background paint composites with what is beneath.'],
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        '19',
        'Glossary',
        'Fifteen terms a decoration-author should keep at hand.',
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _porcelain,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _creamDeep),
        ),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < entries.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: i.isEven ? _cream : _porcelain,
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: Text(entries[i][0], style: _kLabel),
                    ),
                    Expanded(
                      child: Text(entries[i][1], style: _kBody),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 20 — COLOPHON
// ============================================================================

Widget _colophon() {
  return Container(
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_charcoal, _midnight],
      ),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Colophon',
          style: _kSection.copyWith(color: _porcelain),
        ),
        const SizedBox(height: 8),
        const Text(
          'Set in the workspace cream + claret palette. Specimens hand-arranged '
          'with no animation controllers, no asset bundles, no network — every '
          'swatch is a real Container with a real Decoration so the painter\'s '
          'intent can be inspected at rest. Like a fabric sample book on the '
          'cutting table, ready for the next garment to be drawn from.',
          style: TextStyle(
            color: _porcelain,
            fontSize: 13,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _amber.withOpacity(0.18),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _amber.withOpacity(0.5)),
          ),
          child: const Text(
            '— END OF SWATCH BOOK —',
            style: TextStyle(
              fontSize: 10,
              color: _amber,
              letterSpacing: 2,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}
