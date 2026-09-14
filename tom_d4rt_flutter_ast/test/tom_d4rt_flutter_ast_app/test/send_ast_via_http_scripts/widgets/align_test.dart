// D4rt deep-demo: a hand-authored visual exploration of the Align widget.
//
// The script is intended to be sent over the AST/HTTP bridge, evaluated by
// the d4rt interpreter, and rendered inside the test host application. It
// avoids any imperative concurrency primitives (no Future/Timer/await), no
// stateful widgets, no animation controllers, and no print statements. The
// build() function returns a Scaffold whose body is a SingleChildScrollView
// with a long, sectioned column showcasing every facet of Align.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color kBgPage = Color(0xFFF6F7FB);
const Color kBgPanel = Color(0xFFFFFFFF);
const Color kBgPanelAlt = Color(0xFFEFF1F7);
const Color kBgFrame = Color(0xFFE3E7F1);
const Color kBgInk = Color(0xFF1B1F2A);
const Color kInkPrimary = Color(0xFF1E2541);
const Color kInkSecondary = Color(0xFF44506B);
const Color kInkMuted = Color(0xFF6E7793);
const Color kAccentBlue = Color(0xFF3B6BE0);
const Color kAccentTeal = Color(0xFF1FA9A1);
const Color kAccentCoral = Color(0xFFE0653B);
const Color kAccentAmber = Color(0xFFE0A23B);
const Color kAccentPlum = Color(0xFF8C3BE0);
const Color kAccentGrass = Color(0xFF54B83B);
const Color kAccentRose = Color(0xFFE03B7A);
const Color kAccentSlate = Color(0xFF5F6F88);
const Color kBorderSoft = Color(0xFFD3D8E5);
const Color kBorderStrong = Color(0xFFA9B0C2);

// ---------------------------------------------------------------------------
// Tiny value classes (top-level, no leading underscore inside members).
// ---------------------------------------------------------------------------

class NamedAlignSample {
  final String label;
  final Alignment alignment;
  final Color tint;
  const NamedAlignSample(this.label, this.alignment, this.tint);
}

class FractionalAlignSample {
  final String label;
  final double x;
  final double y;
  final Color tint;
  final String note;
  const FractionalAlignSample(
      this.label, this.x, this.y, this.tint, this.note);
}

class FactorSample {
  final String title;
  final double? widthFactor;
  final double? heightFactor;
  final String description;
  final Color tint;
  const FactorSample(this.title, this.widthFactor, this.heightFactor,
      this.description, this.tint);
}

class LerpFrame {
  final double t;
  final Color tint;
  const LerpFrame(this.t, this.tint);
}

// ---------------------------------------------------------------------------
// Master build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kBgPage,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeroHeader(),
          const SizedBox(height: 24.0),
          buildIntroParagraph(),
          const SizedBox(height: 32.0),
          buildAnatomySection(),
          const SizedBox(height: 32.0),
          buildNamedConstantsSection(),
          const SizedBox(height: 32.0),
          buildFractionalShowcase(),
          const SizedBox(height: 32.0),
          buildFactorShowcase(),
          const SizedBox(height: 32.0),
          buildDirectionalShowcase(),
          const SizedBox(height: 32.0),
          buildLerpStrip(),
          const SizedBox(height: 32.0),
          buildComparisonPanel(),
          const SizedBox(height: 32.0),
          buildCommonPatterns(),
          const SizedBox(height: 32.0),
          buildTipsAndGotchas(),
          const SizedBox(height: 32.0),
          buildFooter(),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero header
// ---------------------------------------------------------------------------

Widget buildHeroHeader() {
  return Container(
    height: 168.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF243B7C),
          Color(0xFF3B6BE0),
          Color(0xFF1FA9A1),
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF1E2541).withValues(alpha: 0.25),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: const Color(0xFF3B6BE0).withValues(alpha: 0.18),
          blurRadius: 36.0,
          offset: const Offset(0.0, 18.0),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          right: -32.0,
          top: -32.0,
          child: Container(
            width: 220.0,
            height: 220.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),
        Positioned(
          right: 48.0,
          bottom: -48.0,
          child: Container(
            width: 180.0,
            height: 180.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999.0),
                ),
                child: const Text(
                  'WIDGETS / LAYOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              const Text(
                'Align — placing children with intent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'A visual atlas of named, fractional, directional, and '
                'factor-based alignment, side-by-side with the alternatives.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.82),
                  fontSize: 13.5,
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

Widget buildIntroParagraph() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: kAccentBlue,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'What is Align?',
              style: TextStyle(
                color: kInkPrimary,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Align positions a single child within itself using an '
          'AlignmentGeometry. By default it expands to fill its parent\'s '
          'bounded constraints and places the child at the requested '
          'fractional coordinate, where (-1, -1) is top-left and (1, 1) is '
          'bottom-right. With widthFactor or heightFactor, Align instead '
          'sizes itself relative to the child.',
          style: TextStyle(
            color: kInkSecondary,
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section helpers
// ---------------------------------------------------------------------------

Widget buildSectionHeader(String number, String title, String subtitle,
    {Color accent = kAccentBlue}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: accent,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kInkMuted,
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

Widget buildPanelShell({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kBorderSoft),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkPrimary.withValues(alpha: 0.04),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: child,
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — Anatomy diagram (coordinate system)
// ---------------------------------------------------------------------------

Widget buildAnatomySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '02',
        'The coordinate system',
        'Alignment uses fractional coordinates from -1 to 1 on both axes.',
        accent: kAccentTeal,
      ),
      buildPanelShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 280.0,
              decoration: BoxDecoration(
                color: kBgFrame,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: kBorderStrong, width: 1.2),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: buildAxisLines()),
                  buildCornerLabel(
                      Alignment.topLeft, '(-1, -1)', 'topLeft', kAccentBlue),
                  buildCornerLabel(Alignment.topCenter, '(0, -1)', 'topCenter',
                      kAccentTeal),
                  buildCornerLabel(Alignment.topRight, '(1, -1)', 'topRight',
                      kAccentCoral),
                  buildCornerLabel(Alignment.centerLeft, '(-1, 0)',
                      'centerLeft', kAccentAmber),
                  buildCornerLabel(
                      Alignment.center, '(0, 0)', 'center', kAccentPlum),
                  buildCornerLabel(Alignment.centerRight, '(1, 0)',
                      'centerRight', kAccentRose),
                  buildCornerLabel(Alignment.bottomLeft, '(-1, 1)',
                      'bottomLeft', kAccentGrass),
                  buildCornerLabel(Alignment.bottomCenter, '(0, 1)',
                      'bottomCenter', kAccentSlate),
                  buildCornerLabel(Alignment.bottomRight, '(1, 1)',
                      'bottomRight', kAccentBlue),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(64.0),
                      child: Text(
                        'x ∈ [-1, 1]\ny ∈ [-1, 1]',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kInkSecondary,
                          fontSize: 12.0,
                          fontFamily: 'monospace',
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Origin (0, 0) is the visual center; -1 is the leading/top edge, '
              '+1 is the trailing/bottom edge. Values outside that range push '
              'the child past the parent\'s bounds.',
              style: TextStyle(
                color: kInkSecondary,
                fontSize: 13.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildAxisLines() {
  return Stack(
    children: const <Widget>[
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: 1.0,
          child: ColoredBox(color: kBorderStrong),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 1.0,
          height: double.infinity,
          child: ColoredBox(color: kBorderStrong),
        ),
      ),
    ],
  );
}

Widget buildCornerLabel(
    Alignment alignment, String coords, String name, Color tint) {
  return Align(
    alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.16),
          border: Border.all(color: tint.withValues(alpha: 0.55)),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: tint,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              coords,
              style: const TextStyle(
                color: kInkSecondary,
                fontSize: 9.5,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — 9-grid named constants
// ---------------------------------------------------------------------------

Widget buildNamedConstantsSection() {
  const List<NamedAlignSample> samples = <NamedAlignSample>[
    NamedAlignSample('topLeft', Alignment.topLeft, kAccentBlue),
    NamedAlignSample('topCenter', Alignment.topCenter, kAccentTeal),
    NamedAlignSample('topRight', Alignment.topRight, kAccentCoral),
    NamedAlignSample('centerLeft', Alignment.centerLeft, kAccentAmber),
    NamedAlignSample('center', Alignment.center, kAccentPlum),
    NamedAlignSample('centerRight', Alignment.centerRight, kAccentRose),
    NamedAlignSample('bottomLeft', Alignment.bottomLeft, kAccentGrass),
    NamedAlignSample('bottomCenter', Alignment.bottomCenter, kAccentSlate),
    NamedAlignSample('bottomRight', Alignment.bottomRight, kAccentBlue),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '03',
        'The nine named constants',
        'A 3×3 grid of every Alignment.* constant with a circle child placed '
            'at the corresponding position.',
        accent: kAccentPlum,
      ),
      buildPanelShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildNamedRow(samples.sublist(0, 3)),
            const SizedBox(height: 12.0),
            buildNamedRow(samples.sublist(3, 6)),
            const SizedBox(height: 12.0),
            buildNamedRow(samples.sublist(6, 9)),
            const SizedBox(height: 16.0),
            const Text(
              'Each frame is 120×120. The Align widget fills the frame and '
              'positions the 24×24 circle at the named alignment.',
              style: TextStyle(
                color: kInkMuted,
                fontSize: 12.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildNamedRow(List<NamedAlignSample> row) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: row.map<Widget>(buildNamedCell).toList(),
  );
}

Widget buildNamedCell(NamedAlignSample sample) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: kBgFrame,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: kBorderStrong),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: buildGridGuides()),
            Align(
              alignment: sample.alignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: sample.tint,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: sample.tint.withValues(alpha: 0.35),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Text(
        sample.label,
        style: const TextStyle(
          color: kInkSecondary,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget buildGridGuides() {
  return Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: 1.0,
          child: ColoredBox(color: kBorderSoft.withValues(alpha: 0.6)),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 1.0,
          height: double.infinity,
          child: ColoredBox(color: kBorderSoft.withValues(alpha: 0.6)),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — Fractional alignment showcase
// ---------------------------------------------------------------------------

Widget buildFractionalShowcase() {
  const List<FractionalAlignSample> samples = <FractionalAlignSample>[
    FractionalAlignSample(
        'A', -0.7, 0.3, kAccentBlue, 'Slightly left, just below middle.'),
    FractionalAlignSample(
        'B', 0.5, -0.5, kAccentTeal, 'Halfway between center and topRight.'),
    FractionalAlignSample(
        'C', 0.0, -1.0, kAccentCoral, 'Same as Alignment.topCenter.'),
    FractionalAlignSample(
        'D', 0.85, 0.85, kAccentAmber, 'Almost bottomRight, but inset.'),
    FractionalAlignSample('E', -0.3, -0.8, kAccentPlum,
        'Mostly top, a little to the left.'),
    FractionalAlignSample('F', 0.4, 0.0, kAccentGrass,
        'Centered vertically, biased right horizontally.'),
    FractionalAlignSample(
        'G', -1.0, 0.0, kAccentRose, 'Same as Alignment.centerLeft.'),
    FractionalAlignSample(
        'H', 0.0, 0.6, kAccentSlate, 'Center horizontally, lower third.'),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '04',
        'Fractional alignment',
        'Alignment(x, y) lets you place a child at any sub-pixel-precise '
            'location within the parent.',
        accent: kAccentCoral,
      ),
      buildPanelShell(
        child: Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: samples.map<Widget>(buildFractionalCell).toList(),
        ),
      ),
    ],
  );
}

Widget buildFractionalCell(FractionalAlignSample sample) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 24.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: sample.tint,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                sample.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Alignment(${sample.x}, ${sample.y})',
                style: const TextStyle(
                  color: kInkSecondary,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: kBgFrame,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kBorderStrong),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: buildGridGuides()),
              Align(
                alignment: Alignment(sample.x, sample.y),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      color: sample.tint,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          sample.note,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 11.0,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — widthFactor / heightFactor showcase
// ---------------------------------------------------------------------------

Widget buildFactorShowcase() {
  const List<FactorSample> samples = <FactorSample>[
    FactorSample(
      'widthFactor: 0.5',
      0.5,
      null,
      'Align reports its width as 0.5× the child width when the parent does '
          'not impose a fixed width.',
      kAccentBlue,
    ),
    FactorSample(
      'heightFactor: 1.5',
      null,
      1.5,
      'Align reports its height as 1.5× the child height — extra space falls '
          'around the child.',
      kAccentTeal,
    ),
    FactorSample(
      'both: 2.0 / 2.0',
      2.0,
      2.0,
      'Both axes shrink-wrap relative to the child, multiplied by 2.',
      kAccentPlum,
    ),
    FactorSample(
      'no factor (parent-bound)',
      null,
      null,
      'Without a factor, Align fills its parent\'s constraints in both axes.',
      kAccentCoral,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '05',
        'widthFactor & heightFactor',
        'Multipliers that make Align size itself relative to the child '
            'instead of filling the parent.',
        accent: kAccentAmber,
      ),
      buildPanelShell(
        child: Column(
          children: <Widget>[
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: samples.map<Widget>(buildFactorCell).toList(),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: kAccentAmber.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border:
                    Border.all(color: kAccentAmber.withValues(alpha: 0.35)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.info_outline,
                      color: kAccentAmber, size: 18.0),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'When the parent imposes tight constraints, the factor '
                      'is ignored on that axis — Align cannot shrink below '
                      'the minimum the parent demands.',
                      style: TextStyle(
                        color: kInkSecondary,
                        fontSize: 12.5,
                        height: 1.45,
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

Widget buildFactorCell(FactorSample sample) {
  return Container(
    width: 240.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: sample.tint,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sample.title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 130.0,
          decoration: BoxDecoration(
            color: kBgFrame,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kBorderStrong),
          ),
          alignment: Alignment.topLeft,
          child: Container(
            color: sample.tint.withValues(alpha: 0.08),
            child: Align(
              alignment: Alignment.center,
              widthFactor: sample.widthFactor,
              heightFactor: sample.heightFactor,
              child: Container(
                width: 36.0,
                height: 36.0,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: sample.tint,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          sample.description,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — AlignmentDirectional showcase
// ---------------------------------------------------------------------------

Widget buildDirectionalShowcase() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '06',
        'AlignmentDirectional (RTL aware)',
        'Use start/end instead of left/right when your layout should flip in '
            'right-to-left languages.',
        accent: kAccentRose,
      ),
      buildPanelShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: buildDirectionalFrame(
                    title: 'TextDirection.ltr',
                    direction: TextDirection.ltr,
                    accent: kAccentBlue,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: buildDirectionalFrame(
                    title: 'TextDirection.rtl',
                    direction: TextDirection.rtl,
                    accent: kAccentRose,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Both frames use the same alignment value: '
              'AlignmentDirectional.topStart. In LTR it resolves to topLeft, '
              'in RTL it resolves to topRight.',
              style: TextStyle(
                color: kInkSecondary,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildDirectionalFrame({
  required String title,
  required TextDirection direction,
  required Color accent,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Directionality(
        textDirection: direction,
        child: Container(
          height: 160.0,
          decoration: BoxDecoration(
            color: kBgFrame,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kBorderStrong),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: buildGridGuides()),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'topStart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'bottomEnd',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.85),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — Lerp strip
// ---------------------------------------------------------------------------

Widget buildLerpStrip() {
  const List<LerpFrame> frames = <LerpFrame>[
    LerpFrame(0.0, kAccentBlue),
    LerpFrame(0.25, kAccentTeal),
    LerpFrame(0.5, kAccentPlum),
    LerpFrame(0.75, kAccentCoral),
    LerpFrame(1.0, kAccentRose),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '07',
        'Alignment.lerp — frozen frames',
        'Five static snapshots of Alignment.lerp(topLeft, bottomRight, t) at '
            't ∈ {0, 0.25, 0.5, 0.75, 1.0}.',
        accent: kAccentGrass,
      ),
      buildPanelShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: frames.map<Widget>(buildLerpCell).toList(),
            ),
            const SizedBox(height: 14.0),
            const Text(
              'lerp linearly interpolates each axis. At t = 0.5 the child '
              'lands exactly at center — equivalent to Alignment.center.',
              style: TextStyle(
                color: kInkMuted,
                fontSize: 12.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLerpCell(LerpFrame frame) {
  final Alignment? lerped =
      Alignment.lerp(Alignment.topLeft, Alignment.bottomRight, frame.t);
  final Alignment alignment = lerped ?? Alignment.center;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 110.0,
        height: 110.0,
        decoration: BoxDecoration(
          color: kBgFrame,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: kBorderStrong),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: buildGridGuides()),
            Align(
              alignment: alignment,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: frame.tint,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: frame.tint.withValues(alpha: 0.4),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 6.0),
      Text(
        't = ${frame.t}',
        style: const TextStyle(
          color: kInkSecondary,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — Comparison panel: Align vs Center vs Padding vs Positioned
// ---------------------------------------------------------------------------

Widget buildComparisonPanel() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '08',
        'Align vs Center vs Padding vs Positioned',
        'Same child, four different positioning approaches — compare '
            'behaviours and constraints.',
        accent: kAccentSlate,
      ),
      buildPanelShell(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: buildComparisonCard(
                  title: 'Align',
                  body: 'Align(alignment: Alignment.topRight, child: ...)',
                  accent: kAccentBlue,
                  demo: Container(
                    height: 120.0,
                    color: kBgFrame,
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: _Pill(
                          color: kAccentBlue,
                          label: 'child',
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(width: 12.0),
                Expanded(child: buildComparisonCard(
                  title: 'Center',
                  body: 'Center(child: ...) — equivalent to '
                      'Align(alignment: Alignment.center).',
                  accent: kAccentTeal,
                  demo: Container(
                    height: 120.0,
                    color: kBgFrame,
                    child: const Center(
                      child: _Pill(
                        color: kAccentTeal,
                        label: 'child',
                      ),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: buildComparisonCard(
                  title: 'Padding',
                  body: 'Padding pushes the child by a fixed inset — it '
                      'cannot center within remaining space.',
                  accent: kAccentAmber,
                  demo: Container(
                    height: 120.0,
                    color: kBgFrame,
                    child: const Padding(
                      padding:
                          EdgeInsets.only(left: 28.0, top: 28.0),
                      child: _Pill(
                        color: kAccentAmber,
                        label: 'child',
                      ),
                    ),
                  ),
                )),
                const SizedBox(width: 12.0),
                Expanded(child: buildComparisonCard(
                  title: 'Stack + Positioned',
                  body: 'Positioned attaches the child to specific edge '
                      'offsets within a Stack.',
                  accent: kAccentPlum,
                  demo: Container(
                    height: 120.0,
                    color: kBgFrame,
                    child: const Stack(
                      children: <Widget>[
                        Positioned(
                          right: 12.0,
                          bottom: 12.0,
                          child: _Pill(
                            color: kAccentPlum,
                            label: 'child',
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: kBgPanelAlt,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: kBorderSoft),
              ),
              child: const Text(
                'Rule of thumb: reach for Align when you want a single child '
                'placed fractionally; Center is just sugar for '
                'Alignment.center; Padding is for fixed insets; '
                'Stack/Positioned is for explicit pixel offsets relative to '
                'edges.',
                style: TextStyle(
                  color: kInkSecondary,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildComparisonCard({
  required String title,
  required String body,
  required Color accent,
  required Widget demo,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                color: kInkPrimary,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: demo,
        ),
        const SizedBox(height: 8.0),
        Text(
          body,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

class _Pill extends StatelessWidget {
  final Color color;
  final String label;
  const _Pill({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999.0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 — Common patterns
// ---------------------------------------------------------------------------

Widget buildCommonPatterns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '09',
        'Real-world patterns',
        'Combinations of Stack and Align that crop up over and over in real '
            'apps.',
        accent: kAccentTeal,
      ),
      buildPanelShell(
        child: Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            buildPatternBadgeInCorner(),
            buildPatternWatermark(),
            buildPatternFabAtBottomCenter(),
            buildPatternLogoTopCenter(),
          ],
        ),
      ),
    ],
  );
}

Widget buildPatternCard(
    {required String title,
    required String description,
    required Color accent,
    required Widget visual}) {
  return Container(
    width: 260.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bolt, size: 16.0, color: accent),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: const TextStyle(
                color: kInkPrimary,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: visual,
        ),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildPatternBadgeInCorner() {
  return buildPatternCard(
    title: 'Badge in top-right corner',
    description: 'Stack + Align(topRight) — perfect for unread counts.',
    accent: kAccentRose,
    visual: Container(
      height: 120.0,
      color: kBgFrame,
      child: Stack(
        children: <Widget>[
          const Center(
            child: Icon(Icons.notifications_outlined,
                size: 48.0, color: kAccentSlate),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: kAccentRose,
                  borderRadius: BorderRadius.circular(999.0),
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildPatternWatermark() {
  return buildPatternCard(
    title: 'Watermark in bottom-right',
    description: 'A subtle Align(bottomRight) signature on a hero image.',
    accent: kAccentSlate,
    visual: Container(
      height: 120.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF243B7C), Color(0xFF1FA9A1)],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '© tom_d4rt',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildPatternFabAtBottomCenter() {
  return buildPatternCard(
    title: 'FAB at bottom-center',
    description:
        'Align(bottomCenter) inside a Stack to mimic Scaffold.floatingActionButton.',
    accent: kAccentBlue,
    visual: Container(
      height: 120.0,
      color: kBgFrame,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: kAccentBlue,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: kAccentBlue.withValues(alpha: 0.45),
                      blurRadius: 12.0,
                      offset: const Offset(0.0, 6.0),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildPatternLogoTopCenter() {
  return buildPatternCard(
    title: 'Logo top-center',
    description: 'Common splash-screen layout: Align(topCenter) + Padding.',
    accent: kAccentPlum,
    visual: Container(
      height: 120.0,
      color: kBgFrame,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[kAccentPlum, kAccentRose],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.bolt,
                        size: 20.0, color: Colors.white),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'tom',
                    style: TextStyle(
                      color: kInkSecondary,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
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

// ---------------------------------------------------------------------------
// SECTION 10 — Tips & gotchas
// ---------------------------------------------------------------------------

Widget buildTipsAndGotchas() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionHeader(
        '10',
        'Tips & gotchas',
        'Things that surprise people the first few times they reach for '
            'Align.',
        accent: kAccentCoral,
      ),
      buildPanelShell(
        child: Column(
          children: <Widget>[
            buildTipRow(
              icon: Icons.straighten,
              accent: kAccentBlue,
              title: 'Bounded constraints required',
              body: 'Align needs a parent that gives it a finite size on the '
                  'axis you care about. Inside an unbounded Column, an '
                  'Align(alignment: centerLeft) won\'t do anything horizontal '
                  'unless you wrap it in something that bounds the width.',
            ),
            buildTipDivider(),
            buildTipRow(
              icon: Icons.compress,
              accent: kAccentTeal,
              title: 'widthFactor + tight parent = no effect',
              body: 'If the parent imposes tight constraints on width, '
                  'widthFactor is ignored on that axis — the parent always '
                  'wins when constraints are tight.',
            ),
            buildTipDivider(),
            buildTipRow(
              icon: Icons.swap_horiz,
              accent: kAccentRose,
              title: 'Directional vs absolute',
              body: 'Prefer AlignmentDirectional.* in i18n-aware UIs so that '
                  'start/end flip in RTL. Use Alignment.* when you really '
                  'mean visual left/right regardless of language direction.',
            ),
            buildTipDivider(),
            buildTipRow(
              icon: Icons.layers_outlined,
              accent: kAccentPlum,
              title: 'Stack + Align is idiomatic',
              body: 'Inside a Stack, Align is often clearer than Positioned '
                  'when you only need a fractional placement (no specific '
                  'pixel offsets). It also adapts to the Stack size '
                  'automatically.',
            ),
            buildTipDivider(),
            buildTipRow(
              icon: Icons.center_focus_strong,
              accent: kAccentAmber,
              title: 'Center is just sugar',
              body: 'Center is a one-line subclass of Align with '
                  'Alignment.center as default. Reach for whichever reads '
                  'better in the surrounding code.',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildTipRow(
    {required IconData icon,
    required Color accent,
    required String title,
    required String body}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          child: Icon(icon, size: 18.0, color: accent),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  color: kInkSecondary,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTipDivider() {
  return Container(
    height: 1.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    color: kBorderSoft.withValues(alpha: 0.6),
  );
}

// ---------------------------------------------------------------------------
// SECTION 11 — Footer
// ---------------------------------------------------------------------------

Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kBgInk,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kBgInk.withValues(alpha: 0.3),
          blurRadius: 20.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 24.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[kAccentTeal, kAccentBlue],
                ),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFooterBullet(
            'Align places one child fractionally inside its parent.'),
        buildFooterBullet(
            'Use named constants when possible; reach for Alignment(x, y) '
            'only when fractional precision matters.'),
        buildFooterBullet(
            'widthFactor / heightFactor change Align from a "fill the parent" '
            'box into a "shrink-wrap the child × N" box.'),
        buildFooterBullet(
            'Use AlignmentDirectional in localized UIs so layouts flip '
            'correctly in RTL.'),
        buildFooterBullet(
            'Combine Align with Stack for badges, FABs, watermarks, and '
            'overlays — it is almost always cleaner than Positioned for '
            'fractional placement.'),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          ),
          child: Text(
            'd4rt-flutter-ast · widgets/Align · deep demo',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11.0,
              fontFamily: 'monospace',
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildFooterBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0, right: 10.0),
          width: 6.0,
          height: 6.0,
          decoration: const BoxDecoration(
            color: kAccentTeal,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}
