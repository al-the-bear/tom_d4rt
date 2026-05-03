// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element

// =============================================================================
// Deep visual demo: AnimatedFractionallySizedBox
// -----------------------------------------------------------------------------
// This script is intentionally hand-authored as a teaching artifact. The d4rt
// interpreter calls `build(context)` exactly once and renders a deterministic
// snapshot — there is no animation controller, no setState, and no timers.
// AnimatedFractionallySizedBox is therefore configured with `Duration.zero`
// so that each instance immediately resolves to its target fraction.
//
// Read top to bottom: every section explains a different facet of how
// fractional sizing interacts with parent constraints, alignment, animation
// duration, curves, and practical UI patterns. Each section is structurally
// distinct — gradients, palettes and layouts are deliberately varied so a
// junior reading the rendered output can build a strong mental model of
// AnimatedFractionallySizedBox without needing to scrub a controller.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Top-level palette + decoration helpers.
// Plain top-level functions (no classes, no extensions) so the script is
// fully compatible with the bridged interpreter execution model.
// -----------------------------------------------------------------------------

const Color kBgDeep = Color(0xFF0F1A2E);
const Color kPanel = Color(0xFF1A2742);
const Color kPanelHi = Color(0xFF223255);
const Color kInk = Color(0xFFE8EEFC);
const Color kInkDim = Color(0xFFA8B3CC);
const Color kInkFaint = Color(0xFF6E7A99);
const Color kAccentTeal = Color(0xFF22D3CC);
const Color kAccentMag = Color(0xFFE83E8C);
const Color kAccentAmber = Color(0xFFFFB347);
const Color kAccentLime = Color(0xFFA8E063);
const Color kAccentSky = Color(0xFF60A5FA);
const Color kAccentRose = Color(0xFFFB7185);
const Color kAccentViolet = Color(0xFFA78BFA);
const Color kAccentCoral = Color(0xFFFF8A65);

BoxDecoration _panelDecoration({Color? color, double radius = 16.0}) {
  return BoxDecoration(
    color: color ?? kPanel,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    border: Border.all(color: kPanelHi, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Color(0x66000000),
        blurRadius: 18,
        offset: Offset(0, 10),
      ),
    ],
  );
}

BoxDecoration _gradientHeader(List<Color> colors,
    {double radius = 14.0, Color? shadow}) {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: shadow ?? Color(0x55000000),
        blurRadius: 20,
        offset: Offset(0, 8),
      ),
    ],
  );
}

Widget _sectionTitle(String index, String title, String subtitle,
    List<Color> gradient) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
    decoration: _gradientHeader(gradient),
    child: Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Color(0x55FFFFFF), width: 1),
          ),
          child: Text(
            index,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xFFEAF2FF),
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _prose(String text, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
    child: Text(
      text,
      style: TextStyle(
        color: color ?? kInk,
        fontSize: 13.5,
        height: 1.55,
      ),
    ),
  );
}

Widget _kvRow(String key, String value,
    {Color? keyColor, Color? valueColor, double keyWidth = 140}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: keyWidth,
          child: Text(
            key,
            style: TextStyle(
              color: keyColor ?? kInkDim,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? kInk,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _label(String text, {Color? color, double size = 11.5}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? kInkDim,
      fontSize: size,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
  );
}

// -----------------------------------------------------------------------------
// build entry point
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0F1A2E),
      appBar: AppBar(
        title: const Text('AnimatedFractionallySizedBox'),
        backgroundColor: const Color(0xFF1A2742),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildIntroSection(),
            const SizedBox(height: 28),
            _buildAnatomySection(),
            const SizedBox(height: 28),
            _buildWidthLadderSection(),
            const SizedBox(height: 28),
            _buildHeightLadderSection(),
            const SizedBox(height: 28),
            _buildAlignmentGridSection(),
            const SizedBox(height: 28),
            _buildCombinedMatrixSection(),
            const SizedBox(height: 28),
            _buildCurvesShowcaseSection(),
            const SizedBox(height: 28),
            _buildComparisonSection(),
            const SizedBox(height: 28),
            _buildRecipeGallerySection(),
            const SizedBox(height: 28),
            _buildFootgunSection(),
            const SizedBox(height: 28),
            _buildApiSummarySection(),
            const SizedBox(height: 28),
            _buildClosingSection(),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 0 — Intro card
// =============================================================================

Widget _buildIntroSection() {
  return Container(
    decoration: _panelDecoration(),
    padding: const EdgeInsets.all(0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: _gradientHeader(<Color>[
            Color(0xFF0EA5E9),
            Color(0xFF6366F1),
            Color(0xFF8B5CF6),
          ], radius: 16, shadow: Color(0x556366F1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _chip('IMPLICIT', kAccentTeal),
                  const SizedBox(width: 8),
                  _chip('LAYOUT', kAccentAmber),
                  const SizedBox(width: 8),
                  _chip('FRACTION', kAccentLime),
                  const SizedBox(width: 8),
                  _chip('ANIMATED', kAccentMag),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'AnimatedFractionallySizedBox',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'An implicit-animation widget that smoothly tweens its '
                'widthFactor and heightFactor (and alignment) when those '
                'values change between builds.',
                style: TextStyle(
                  color: Color(0xFFE6EDFF),
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _prose(
          'AnimatedFractionallySizedBox is the implicit cousin of '
          'FractionallySizedBox. Where FractionallySizedBox snaps to a new '
          'fraction the moment its property changes, this widget interpolates '
          'between the previous and next fraction over a configurable '
          'duration and curve. It is ideal for resize ribbons, expanding '
          'panels, progress meters, and any UI where you want the child to '
          'occupy a percentage of the parent rather than a fixed pixel size.',
        ),
        _prose(
          'Three properties control its layout: widthFactor (0..1+), '
          'heightFactor (0..1+) and alignment. The factors are multiplied '
          'against the maximum constraints supplied by the parent, so the '
          'parent must provide bounded constraints for that axis. If the '
          'parent has unbounded width (e.g. inside a Row), widthFactor is '
          'effectively ignored and the child takes its intrinsic width '
          'instead — a frequent footgun documented in the panel below.',
        ),
        _prose(
          'In this snapshot demo every instance uses Duration.zero so the '
          'animator resolves immediately to its target. Read each section as '
          'a frozen frame from a hypothetical animation: the rectangle you '
          'see is the steady-state geometry the implicit animation would '
          'converge to.',
          color: kInkDim,
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 — Anatomy diagram
// =============================================================================

Widget _buildAnatomySection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '1',
          'Anatomy',
          'Parent constraints, fractional rectangle and the alignment dot.',
          <Color>[Color(0xFF0F766E), Color(0xFF14B8A6), Color(0xFF22D3CC)],
        ),
        _prose(
          'The widget receives the parent\'s maxWidth and maxHeight, multiplies '
          'each by the corresponding factor, and then positions the resulting '
          'rectangle within the parent using the alignment property. The '
          'unused space around the child is left empty — the parent itself '
          'still claims the full constraint, only the child is shrunk.',
        ),
        _prose(
          'Below, three labelled diagrams show: (a) parent-only with no '
          'child, (b) child sized to 0.6 × 0.5 aligned center, and (c) the '
          'same fraction aligned bottomRight. The dotted alignment dot in '
          'each diagram marks the conceptual anchor point used by the '
          'underlying RenderPositionedBox.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _anatomyDiagram(
                title: '(a) parent only — no fraction yet',
                widthFactor: 1.0,
                heightFactor: 1.0,
                alignment: Alignment.center,
                showChild: false,
                accent: kAccentTeal,
              ),
              const SizedBox(height: 14),
              _anatomyDiagram(
                title: '(b) widthFactor: 0.6, heightFactor: 0.5, center',
                widthFactor: 0.6,
                heightFactor: 0.5,
                alignment: Alignment.center,
                showChild: true,
                accent: kAccentAmber,
              ),
              const SizedBox(height: 14),
              _anatomyDiagram(
                title: '(c) widthFactor: 0.6, heightFactor: 0.5, bottomRight',
                widthFactor: 0.6,
                heightFactor: 0.5,
                alignment: Alignment.bottomRight,
                showChild: true,
                accent: kAccentMag,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyDiagram({
  required String title,
  required double widthFactor,
  required double heightFactor,
  required Alignment alignment,
  required bool showChild,
  required Color accent,
}) {
  return Container(
    decoration: BoxDecoration(
      color: kPanelHi,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: Color(0xFF334466), width: 1),
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: accent.withValues(alpha: 0.6),
                      blurRadius: 8,
                      offset: Offset(0, 0)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: kInk,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 170,
          child: Stack(
            children: <Widget>[
              // The "parent" rectangle — visualized as the dashed frame.
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF0E1A30),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: accent.withValues(alpha: 0.7), width: 2),
                  ),
                ),
              ),
              // Parent label (top-left).
              Positioned(
                left: 8,
                top: 6,
                child: Text(
                  'parent constraints',
                  style: TextStyle(
                    color: accent,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              // The fractional child via AnimatedFractionallySizedBox.
              if (showChild)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: AnimatedFractionallySizedBox(
                    duration: Duration.zero,
                    widthFactor: widthFactor,
                    heightFactor: heightFactor,
                    alignment: alignment,
                    child: Container(
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border:
                            Border.all(color: accent, width: 1.4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'child\n${(widthFactor * 100).toInt()}% × '
                        '${(heightFactor * 100).toInt()}%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kInk,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              // Alignment dot (purely informational overlay).
              if (showChild)
                Positioned.fill(
                  child: Align(
                    alignment: alignment,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: accent, width: 2),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0x99000000),
                              blurRadius: 4,
                              offset: Offset(0, 1)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _kvRow('widthFactor:', widthFactor.toStringAsFixed(2)),
        _kvRow('heightFactor:', heightFactor.toStringAsFixed(2)),
        _kvRow('alignment:', _alignmentName(alignment)),
      ],
    ),
  );
}

String _alignmentName(Alignment a) {
  if (a == Alignment.topLeft) return 'Alignment.topLeft  (-1, -1)';
  if (a == Alignment.topCenter) return 'Alignment.topCenter (0, -1)';
  if (a == Alignment.topRight) return 'Alignment.topRight  (1, -1)';
  if (a == Alignment.centerLeft) return 'Alignment.centerLeft (-1, 0)';
  if (a == Alignment.center) return 'Alignment.center    (0,  0)';
  if (a == Alignment.centerRight) return 'Alignment.centerRight (1, 0)';
  if (a == Alignment.bottomLeft) return 'Alignment.bottomLeft (-1, 1)';
  if (a == Alignment.bottomCenter) return 'Alignment.bottomCenter (0, 1)';
  if (a == Alignment.bottomRight) return 'Alignment.bottomRight (1, 1)';
  return 'Alignment(${a.x.toStringAsFixed(2)}, ${a.y.toStringAsFixed(2)})';
}

// =============================================================================
// SECTION 2 — WidthFactor ladder
// =============================================================================

Widget _buildWidthLadderSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '2',
          'WidthFactor ladder',
          'How the child fills horizontally as widthFactor climbs from 0.10 to 1.00.',
          <Color>[Color(0xFF7C3AED), Color(0xFFA855F7), Color(0xFFEC4899)],
        ),
        _prose(
          'WidthFactor multiplies the parent\'s maxWidth. A factor of 0.25 '
          'means the child is exactly one quarter of the parent\'s available '
          'horizontal space. The unused space remains visually empty inside '
          'the parent — it is not collapsed and the parent\'s width does '
          'not change. This is the property you most commonly animate to '
          'create a smooth resize-from-the-side effect.',
        ),
        _prose(
          'Each row below uses heightFactor: 1.0 and alignment: centerLeft, '
          'so the rectangle grows rightward from the left edge. Notice how '
          'the labelled fraction precisely matches the visible width — there '
          'is no padding compensation or rounding.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _widthLadderRow(0.10, kAccentSky),
              const SizedBox(height: 10),
              _widthLadderRow(0.25, kAccentTeal),
              const SizedBox(height: 10),
              _widthLadderRow(0.40, kAccentLime),
              const SizedBox(height: 10),
              _widthLadderRow(0.55, kAccentAmber),
              const SizedBox(height: 10),
              _widthLadderRow(0.70, kAccentCoral),
              const SizedBox(height: 10),
              _widthLadderRow(0.85, kAccentRose),
              const SizedBox(height: 10),
              _widthLadderRow(1.00, kAccentMag),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _widthLadderRow(double factor, Color accent) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        width: 64,
        child: Text(
          '${(factor * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            color: accent,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFF0E1A30),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Color(0xFF334466), width: 1.5),
          ),
          padding: const EdgeInsets.all(3),
          child: AnimatedFractionallySizedBox(
            duration: Duration.zero,
            widthFactor: factor,
            heightFactor: 1.0,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    accent.withValues(alpha: 0.95),
                    accent.withValues(alpha: 0.55),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: Offset(0, 2)),
                ],
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'w=${factor.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Color(0xFF0F1A2E),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 3 — HeightFactor ladder
// =============================================================================

Widget _buildHeightLadderSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '3',
          'HeightFactor ladder',
          'Vertical fraction growth with bottom alignment for a column-of-bars feel.',
          <Color>[Color(0xFF065F46), Color(0xFF10B981), Color(0xFFA8E063)],
        ),
        _prose(
          'HeightFactor mirrors widthFactor on the vertical axis. The parent '
          'must provide a bounded height for it to take effect — inside a '
          'Column with unconstrained vertical space the property is silently '
          'ignored. In the row of bars below the parent\'s height is fixed '
          'so heightFactor maps cleanly onto a percentage of that 200 px '
          'frame. This is the classic shape used by bar-chart bars that '
          'animate in from the bottom.',
        ),
        _prose(
          'Each bar uses bottomCenter alignment, which is critical: with '
          'topCenter the bar would shrink upward and leave empty space at '
          'the bottom — visually wrong for a chart but exactly right for a '
          'drop-down panel. Alignment is what gives a fractional box its '
          '"anchor" meaning.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Color(0xFF0E1A30),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Color(0xFF334466), width: 1),
            ),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 28),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 6,
                  top: 6,
                  child: _label('parent height = 200px',
                      color: kInkFaint, size: 10.5),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _heightBar(0.15, '15%', kAccentSky),
                    _heightBar(0.30, '30%', kAccentTeal),
                    _heightBar(0.45, '45%', kAccentLime),
                    _heightBar(0.60, '60%', kAccentAmber),
                    _heightBar(0.75, '75%', kAccentCoral),
                    _heightBar(0.90, '90%', kAccentRose),
                    _heightBar(1.00, '100%', kAccentMag),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _heightBar(double factor, String label, Color accent) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedFractionallySizedBox(
              duration: Duration.zero,
              widthFactor: 1.0,
              heightFactor: factor,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      accent.withValues(alpha: 0.95),
                      accent.withValues(alpha: 0.45),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: accent.withValues(alpha: 0.30),
                        blurRadius: 4,
                        offset: Offset(0, -2)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 4 — Alignment grid (3x3)
// =============================================================================

Widget _buildAlignmentGridSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '4',
          'Alignment grid',
          'Same fraction (0.5 × 0.5), nine alignment anchors.',
          <Color>[Color(0xFFB45309), Color(0xFFD97706), Color(0xFFFFB347)],
        ),
        _prose(
          'When width- and heightFactor are both 0.5 the child occupies a '
          'quarter of the parent\'s area, leaving three quarters of empty '
          'space. The alignment property decides where that quarter lives. '
          'Each cell below has identical fractions — only the alignment '
          'changes — so you can see the anchor system at a glance.',
        ),
        _prose(
          'Alignment uses a normalized coordinate system where (-1, -1) is '
          'top-left, (0, 0) is centre, and (1, 1) is bottom-right. The nine '
          'named constants below are the most common, but any double in '
          '[-1, 1] for x and y is legal — useful for "slightly off centre" '
          'callouts.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _alignmentGridRow(<Alignment>[
                Alignment.topLeft,
                Alignment.topCenter,
                Alignment.topRight,
              ], <String>[
                'topLeft',
                'topCenter',
                'topRight',
              ], kAccentSky),
              const SizedBox(height: 10),
              _alignmentGridRow(<Alignment>[
                Alignment.centerLeft,
                Alignment.center,
                Alignment.centerRight,
              ], <String>[
                'centerLeft',
                'center',
                'centerRight',
              ], kAccentLime),
              const SizedBox(height: 10),
              _alignmentGridRow(<Alignment>[
                Alignment.bottomLeft,
                Alignment.bottomCenter,
                Alignment.bottomRight,
              ], <String>[
                'bottomLeft',
                'bottomCenter',
                'bottomRight',
              ], kAccentRose),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _alignmentGridRow(
    List<Alignment> aligns, List<String> names, Color accent) {
  return Row(
    children: <Widget>[
      Expanded(child: _alignmentCell(aligns[0], names[0], accent)),
      const SizedBox(width: 10),
      Expanded(child: _alignmentCell(aligns[1], names[1], accent)),
      const SizedBox(width: 10),
      Expanded(child: _alignmentCell(aligns[2], names[2], accent)),
    ],
  );
}

Widget _alignmentCell(Alignment a, String name, Color accent) {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: Color(0xFF0E1A30),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Color(0xFF334466), width: 1),
    ),
    padding: const EdgeInsets.all(4),
    child: Stack(
      children: <Widget>[
        AnimatedFractionallySizedBox(
          duration: Duration.zero,
          widthFactor: 0.5,
          heightFactor: 0.5,
          alignment: a,
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: accent.withValues(alpha: 0.45),
                    blurRadius: 6,
                    offset: Offset(0, 2)),
              ],
            ),
          ),
        ),
        Positioned(
          left: 6,
          bottom: 4,
          child: Text(
            name,
            style: TextStyle(
              color: kInk,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Positioned(
          right: 6,
          top: 4,
          child: Text(
            '(${a.x.toStringAsFixed(0)}, ${a.y.toStringAsFixed(0)})',
            style: TextStyle(
              color: kInkFaint,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5 — Combined factors matrix (4x4)
// =============================================================================

Widget _buildCombinedMatrixSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '5',
          'Combined factors matrix',
          'Width × Height grid showing how both factors interact.',
          <Color>[Color(0xFF1E3A8A), Color(0xFF2563EB), Color(0xFF60A5FA)],
        ),
        _prose(
          'Width and height factors compose multiplicatively against the '
          'parent\'s area. A 0.5 × 0.5 child claims one quarter of the '
          'parent area; a 0.25 × 0.25 child claims a sixteenth. The matrix '
          'below holds the parent cell size constant and varies both '
          'factors so you can build intuition for compound fractions.',
        ),
        _prose(
          'Each cell uses alignment: bottomLeft so growth is monotonic from '
          'a single anchor; this is the easiest configuration for reading '
          'a matrix. The diagonal from top-left (0.25 × 0.25) to '
          'bottom-right (1.0 × 1.0) is the "everything scales together" '
          'progression most often seen when animating a thumbnail to full '
          'size.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 32),
              _matrixHeader('w=0.25'),
              _matrixHeader('w=0.50'),
              _matrixHeader('w=0.75'),
              _matrixHeader('w=1.00'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _matrixRow('h=0.25', 0.25, kAccentTeal),
              const SizedBox(height: 8),
              _matrixRow('h=0.50', 0.50, kAccentLime),
              const SizedBox(height: 8),
              _matrixRow('h=0.75', 0.75, kAccentAmber),
              const SizedBox(height: 8),
              _matrixRow('h=1.00', 1.00, kAccentRose),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _matrixHeader(String label) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kInkDim,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

Widget _matrixRow(String hLabel, double h, Color accent) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 32,
        child: Text(
          hLabel,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: kInkDim,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
      Expanded(child: _matrixCell(0.25, h, accent)),
      Expanded(child: _matrixCell(0.50, h, accent)),
      Expanded(child: _matrixCell(0.75, h, accent)),
      Expanded(child: _matrixCell(1.00, h, accent)),
    ],
  );
}

Widget _matrixCell(double w, double h, Color accent) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF0E1A30),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xFF26324F), width: 1),
      ),
      padding: const EdgeInsets.all(3),
      child: AnimatedFractionallySizedBox(
        duration: Duration.zero,
        widthFactor: w,
        heightFactor: h,
        alignment: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                accent.withValues(alpha: 0.9),
                accent.withValues(alpha: 0.5),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          alignment: Alignment.center,
          child: Text(
            '${(w * h * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              color: Color(0xFF0F1A2E),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 6 — Curves showcase
// =============================================================================

Widget _buildCurvesShowcaseSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '6',
          'Curves showcase',
          'The curve property does not change the snapshot — only the path.',
          <Color>[Color(0xFF831843), Color(0xFFBE185D), Color(0xFFE83E8C)],
        ),
        _prose(
          'AnimatedFractionallySizedBox accepts a Curve via its curve: '
          'parameter. The curve does not alter the steady-state geometry '
          'shown in this snapshot — it only changes the *trajectory* the '
          'animated value follows between two factors. Choosing a good '
          'curve is mostly about feel: bouncy curves communicate '
          'playfulness, decelerate curves communicate "settling", linear '
          'curves communicate mechanical or measured progress.',
        ),
        _prose(
          'The reference table below documents the most useful curves '
          'shipped with Flutter, paired with a note about when each is '
          'idiomatic. If you need a curve outside this list consider '
          'CurveTween or a custom Cubic — but reach for the named '
          'constants first; they are battle-tested across Material and '
          'Cupertino components.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Container(
            decoration: BoxDecoration(
              color: kPanelHi,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Color(0xFF334466), width: 1),
            ),
            child: Column(
              children: <Widget>[
                _curveHeaderRow(),
                _curveTableRow('Curves.linear',
                    'Constant velocity. Mechanical, indicators, metronomes.',
                    kAccentSky),
                _curveTableRow('Curves.easeIn',
                    'Slow start, fast finish. Things leaving the screen.',
                    kAccentTeal),
                _curveTableRow('Curves.easeOut',
                    'Fast start, slow finish. Things arriving on screen.',
                    kAccentLime),
                _curveTableRow(
                    'Curves.easeInOut',
                    'Symmetric. The default for most resize transitions.',
                    kAccentAmber),
                _curveTableRow(
                    'Curves.fastOutSlowIn',
                    'Material standard easing. Use for deliberate motion.',
                    kAccentCoral),
                _curveTableRow('Curves.bounceOut',
                    'Playful settle. Onboarding flourishes, success states.',
                    kAccentRose),
                _curveTableRow(
                    'Curves.elasticOut',
                    'Overshoot + settle. Use sparingly — easy to overdo.',
                    kAccentMag),
                _curveTableRow('Curves.decelerate',
                    'Inertial finish. Paginated lists, scrollers.',
                    kAccentViolet,
                    isLast: true),
              ],
            ),
          ),
        ),
        _prose(
          'To prove the curve does not affect the resolved value, the row '
          'below renders four AnimatedFractionallySizedBox instances at '
          'widthFactor 0.7 with four different curves. They are visually '
          'identical because each has already converged to its target.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _curveProofRow('linear', Curves.linear, kAccentSky),
              const SizedBox(height: 8),
              _curveProofRow('easeInOut', Curves.easeInOut, kAccentTeal),
              const SizedBox(height: 8),
              _curveProofRow('bounceOut', Curves.bounceOut, kAccentRose),
              const SizedBox(height: 8),
              _curveProofRow('elasticOut', Curves.elasticOut, kAccentMag),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _curveHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF26324F),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 150,
          child: Text(
            'curve',
            style: TextStyle(
              color: kInk,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            'when to reach for it',
            style: TextStyle(
              color: kInk,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _curveTableRow(String name, String note, Color accent,
    {bool isLast = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(
              bottom: BorderSide(color: Color(0xFF26324F), width: 1),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 5, right: 8),
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 138,
          child: Text(
            name,
            style: TextStyle(
              color: accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: TextStyle(
              color: kInk,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _curveProofRow(String name, Curve curve, Color accent) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 90,
        child: Text(
          name,
          style: TextStyle(
            color: accent,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xFF0E1A30),
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: Color(0xFF26324F), width: 1),
          ),
          padding: const EdgeInsets.all(2),
          child: AnimatedFractionallySizedBox(
            duration: Duration.zero,
            curve: curve,
            widthFactor: 0.7,
            heightFactor: 1.0,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 — Comparison vs FractionallySizedBox
// =============================================================================

Widget _buildComparisonSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '7',
          'Animated vs plain FractionallySizedBox',
          'Same geometry, different update behaviour.',
          <Color>[Color(0xFF312E81), Color(0xFF6D28D9), Color(0xFFA78BFA)],
        ),
        _prose(
          'FractionallySizedBox is the layout primitive: it takes its '
          'factors and immediately produces a child of the requested '
          'fraction. AnimatedFractionallySizedBox wraps that primitive in '
          'an ImplicitlyAnimatedWidget so changes to the factors tween '
          'instead of snapping. Pick the animated version any time the '
          'factor will change in response to user input or app state — '
          'use the plain version for static layouts.',
        ),
        _prose(
          'The two cards below render identical geometry. In a live app '
          'with a controller toggling the factor between 0.4 and 0.8, the '
          'left card would jump and the right card would smoothly resize. '
          'Because this snapshot is frozen they look identical — the '
          'difference is purely behavioural, not visual.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _comparisonCard(
                title: 'FractionallySizedBox',
                badge: 'snaps',
                badgeColor: kAccentAmber,
                summary:
                    'Pure layout. No tween. Cheap. Use when the factor '
                    'never changes after first build.',
                widget: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[kAccentAmber, kAccentCoral],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                accent: kAccentAmber,
              )),
              const SizedBox(width: 12),
              Expanded(child: _comparisonCard(
                title: 'AnimatedFractionallySizedBox',
                badge: 'tweens',
                badgeColor: kAccentTeal,
                summary:
                    'Implicit tween. Pass new factors and the change is '
                    'animated over duration:.',
                widget: AnimatedFractionallySizedBox(
                  duration: Duration.zero,
                  widthFactor: 0.7,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[kAccentTeal, kAccentSky],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                accent: kAccentTeal,
              )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kPanelHi,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Color(0xFF334466), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _label('Decision rule', color: kAccentSky, size: 12),
                const SizedBox(height: 6),
                _kvRow('static fraction',
                    'FractionallySizedBox — no controller, no rebuild.',
                    keyWidth: 130),
                _kvRow('reactive fraction',
                    'AnimatedFractionallySizedBox — let setState drive the tween.',
                    keyWidth: 130),
                _kvRow('frame-perfect control',
                    'FractionallySizedBox + your own AnimationController.',
                    keyWidth: 130),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonCard({
  required String title,
  required String badge,
  required Color badgeColor,
  required String summary,
  required Widget widget,
  required Color accent,
}) {
  return Container(
    decoration: BoxDecoration(
      color: kPanelHi,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: Color(0xFF334466), width: 1),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _chip(badge, badgeColor),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          summary,
          style: TextStyle(
            color: kInkDim,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: Color(0xFF0E1A30),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: accent.withValues(alpha: 0.4), width: 1),
          ),
          padding: const EdgeInsets.all(4),
          child: widget,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 — Real-world recipe gallery
// =============================================================================

Widget _buildRecipeGallerySection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '8',
          'Real-world recipes',
          'Three production-shaped uses you can lift directly.',
          <Color>[Color(0xFF065F46), Color(0xFF0E7490), Color(0xFF22D3CC)],
        ),
        _prose(
          'These recipes show AnimatedFractionallySizedBox in the wild. Each '
          'card is a snapshot of a state most apps reach via setState or a '
          'ValueNotifier — the implicit animation handles the in-between '
          'frames automatically. Treat the markup as a starting template; '
          'wire the factors to your own state and you have a smooth, '
          'controller-free transition.',
        ),
        _prose(
          'The recipes cover the three patterns you will reach for most '
          'often: a width cap that respects the parent, a peek/expand panel '
          'attached to the bottom of a Stack, and a percent-based progress '
          'meter. All three rely on the parent providing bounded '
          'constraints — without that, the fraction has nothing to multiply '
          'against.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _recipeCard(
                title: 'Recipe A — Responsive image cap',
                tag: 'cap @ 80%',
                accent: kAccentTeal,
                description:
                    'A hero image that fills the parent on phones but caps '
                    'at 80% width on wider devices. Animate widthFactor as '
                    'a function of MediaQuery breakpoints and the change '
                    'between layouts becomes a soft resize instead of a '
                    'jarring snap.',
                preview: _recipeImageCapPreview(),
              ),
              const SizedBox(height: 14),
              _recipeCard(
                title: 'Recipe B — Expandable bottom sheet stub',
                tag: 'peek ↔ open',
                accent: kAccentAmber,
                description:
                    'A bottom-anchored panel that sits at heightFactor 0.18 '
                    'in its peek state and expands to 0.55 when opened. '
                    'Alignment.bottomCenter pins it to the bottom edge so '
                    'the growth happens upward, exactly like a draggable '
                    'sheet — but with no controller wiring.',
                preview: _recipeBottomSheetPreview(),
              ),
              const SizedBox(height: 14),
              _recipeCard(
                title: 'Recipe C — Inline progress meter',
                tag: '0..1 progress',
                accent: kAccentMag,
                description:
                    'A horizontal progress bar where widthFactor is bound '
                    'directly to a 0..1 progress value. Because '
                    'AnimatedFractionallySizedBox tweens, you can update '
                    'progress in chunky increments (0.0 → 0.4 → 1.0) and '
                    'the bar still glides smoothly between values.',
                preview: _recipeProgressPreview(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required String tag,
  required Color accent,
  required String description,
  required Widget preview,
}) {
  return Container(
    decoration: BoxDecoration(
      color: kPanelHi,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: Offset(0, 6)),
      ],
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            _chip(tag, accent),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: kInkDim,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        preview,
      ],
    ),
  );
}

Widget _recipeImageCapPreview() {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: Color(0xFF0E1A30),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Color(0xFF334466), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: AnimatedFractionallySizedBox(
      duration: Duration.zero,
      widthFactor: 0.8,
      heightFactor: 1.0,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0EA5E9),
              Color(0xFF22D3CC),
              Color(0xFFA8E063),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0x6622D3CC),
                blurRadius: 14,
                offset: Offset(0, 4)),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'hero image · 80% width cap',
          style: TextStyle(
            color: Color(0xFF0F1A2E),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}

Widget _recipeBottomSheetPreview() {
  return Container(
    height: 160,
    decoration: BoxDecoration(
      color: Color(0xFF0E1A30),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Color(0xFF334466), width: 1),
    ),
    child: Stack(
      children: <Widget>[
        // Background "page" content.
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _label('page content behind sheet', color: kInkFaint),
              const SizedBox(height: 6),
              Container(
                  height: 8,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFF26324F),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  )),
              const SizedBox(height: 4),
              Container(
                  height: 8,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color(0xFF26324F),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  )),
              const SizedBox(height: 4),
              Container(
                  height: 8,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFF26324F),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  )),
            ],
          ),
        ),
        // The sheet itself, opened to ~0.55 of the parent height.
        AnimatedFractionallySizedBox(
          duration: Duration.zero,
          widthFactor: 1.0,
          heightFactor: 0.55,
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFFFB347),
                  Color(0xFFFF8A65),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 12,
                    offset: Offset(0, -3)),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0x880F1A2E),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sheet — opened state',
                  style: TextStyle(
                    color: Color(0xFF0F1A2E),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'heightFactor: 0.55 · alignment: bottomCenter',
                  style: TextStyle(
                    color: Color(0xCC0F1A2E),
                    fontSize: 11,
                    fontFamily: 'monospace',
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

Widget _recipeProgressPreview() {
  return Column(
    children: <Widget>[
      _progressMeterRow('Step 1', 0.20, kAccentSky),
      const SizedBox(height: 8),
      _progressMeterRow('Step 2', 0.55, kAccentTeal),
      const SizedBox(height: 8),
      _progressMeterRow('Step 3', 0.85, kAccentLime),
      const SizedBox(height: 8),
      _progressMeterRow('Done',   1.00, kAccentMag),
    ],
  );
}

Widget _progressMeterRow(String label, double progress, Color accent) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 64,
        child: Text(
          label,
          style: TextStyle(
            color: kInkDim,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 14,
          decoration: BoxDecoration(
            color: Color(0xFF0E1A30),
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: Color(0xFF26324F), width: 1),
          ),
          padding: const EdgeInsets.all(2),
          child: AnimatedFractionallySizedBox(
            duration: Duration.zero,
            widthFactor: progress,
            heightFactor: 1.0,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[accent, accent.withValues(alpha: 0.55)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      SizedBox(
        width: 44,
        child: Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: accent,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 9 — Footgun panel
// =============================================================================

Widget _buildFootgunSection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '9',
          'Footguns',
          'Failure modes you will eventually meet — written down so you can skip the meeting.',
          <Color>[Color(0xFF7F1D1D), Color(0xFFB91C1C), Color(0xFFFB7185)],
        ),
        _prose(
          'Three classes of bug dominate AnimatedFractionallySizedBox usage. '
          'First, factors greater than 1.0 are technically legal — the child '
          'simply overflows the parent — but rarely what you want. Second, '
          'placing the widget inside an unbounded axis (Row, ListView, '
          'Wrap) causes the corresponding factor to be ignored. Third, '
          'forgetting that the implicit animation is duration-bounded means '
          'rapid factor changes can pile up if your duration is longer '
          'than the change cadence.',
        ),
        _prose(
          'The cards below render each footgun as a "wrong / right" pair so '
          'you can recognise the symptom in your own code. Treat the red '
          'samples as illustrative — they intentionally overflow or render '
          'oddly to make the failure mode visible.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _footgunCard(
                title: 'A — widthFactor > 1.0',
                wrongLabel: 'widthFactor: 1.4 → child overflows parent',
                rightLabel: 'widthFactor: 1.0 → child fills parent',
                wrong: AnimatedFractionallySizedBox(
                  duration: Duration.zero,
                  widthFactor: 1.4,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFB91C1C), Color(0xFFFB7185)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '140% wide → overflow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                right: AnimatedFractionallySizedBox(
                  duration: Duration.zero,
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[kAccentLime, kAccentTeal],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '100% wide → fits',
                      style: TextStyle(
                        color: Color(0xFF0F1A2E),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _footgunCard(
                title: 'B — unbounded parent constraints',
                wrongLabel:
                    'inside a Row without Expanded → factor ignored',
                rightLabel:
                    'wrap in Expanded / SizedBox to give bounded width',
                wrong: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'no bounded width → AnimatedFractionallySizedBox '
                    'collapses to its child\'s intrinsic width.',
                    style: TextStyle(
                      color: Color(0xFFFB7185),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                right: AnimatedFractionallySizedBox(
                  duration: Duration.zero,
                  widthFactor: 0.6,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[kAccentSky, kAccentTeal],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'bounded → 60% works',
                      style: TextStyle(
                        color: Color(0xFF0F1A2E),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _footgunCard(
                title: 'C — null factor surprises',
                wrongLabel: 'widthFactor: null → uses child intrinsic width',
                rightLabel: 'widthFactor: 0.5 → predictable half',
                wrong: AnimatedFractionallySizedBox(
                  duration: Duration.zero,
                  widthFactor: null,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xFFFB7185),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'null = intrinsic',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                right: AnimatedFractionallySizedBox(
                  duration: Duration.zero,
                  widthFactor: 0.5,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[kAccentAmber, kAccentCoral],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '0.5 = predictable',
                      style: TextStyle(
                        color: Color(0xFF0F1A2E),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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

Widget _footgunCard({
  required String title,
  required String wrongLabel,
  required String rightLabel,
  required Widget wrong,
  required Widget right,
}) {
  return Container(
    decoration: BoxDecoration(
      color: kPanelHi,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: Color(0xFF334466), width: 1),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: kInk,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _footgunSlot(
                badge: 'WRONG',
                badgeColor: Color(0xFFFB7185),
                label: wrongLabel,
                child: wrong,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _footgunSlot(
                badge: 'RIGHT',
                badgeColor: kAccentLime,
                label: rightLabel,
                child: right,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _footgunSlot({
  required String badge,
  required Color badgeColor,
  required String label,
  required Widget child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF0E1A30),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: badgeColor.withValues(alpha: 0.55), width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _chip(badge, badgeColor),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: kInk,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 36,
          child: child,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 — API summary table
// =============================================================================

Widget _buildApiSummarySection() {
  return Container(
    decoration: _panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          '10',
          'API summary',
          'Constructor parameters at a glance.',
          <Color>[Color(0xFF111827), Color(0xFF374151), Color(0xFF6B7280)],
        ),
        _prose(
          'AnimatedFractionallySizedBox is a thin extension over '
          'ImplicitlyAnimatedWidget, so it inherits duration, curve, '
          'onEnd, and the standard widget contract. The fields specific to '
          'fractional sizing are widthFactor, heightFactor, and alignment. '
          'All three are nullable — passing null disables the corresponding '
          'fraction and falls back to the child\'s intrinsic size on that '
          'axis.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            decoration: BoxDecoration(
              color: kPanelHi,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Color(0xFF334466), width: 1),
            ),
            child: Column(
              children: <Widget>[
                _apiTableHeader(),
                _apiTableRow('widthFactor', 'double?', 'null',
                    'Fraction of parent maxWidth.', kAccentTeal),
                _apiTableRow('heightFactor', 'double?', 'null',
                    'Fraction of parent maxHeight.', kAccentLime),
                _apiTableRow('alignment', 'AlignmentGeometry',
                    'Alignment.center',
                    'Anchor inside the parent.', kAccentAmber),
                _apiTableRow('duration', 'Duration', '— required',
                    'Tween duration. Use Duration.zero for snapshots.',
                    kAccentSky),
                _apiTableRow('curve', 'Curve', 'Curves.linear',
                    'Easing applied to the tween.', kAccentMag),
                _apiTableRow('child', 'Widget?', 'null',
                    'The widget being fractionally sized.', kAccentRose),
                _apiTableRow('onEnd', 'VoidCallback?', 'null',
                    'Fires once the tween settles.', kAccentViolet,
                    isLast: true),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _apiTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF26324F),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text('field',
              style: TextStyle(
                color: kInk,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              )),
        ),
        SizedBox(
          width: 100,
          child: Text('type',
              style: TextStyle(
                color: kInk,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              )),
        ),
        SizedBox(
          width: 90,
          child: Text('default',
              style: TextStyle(
                color: kInk,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              )),
        ),
        Expanded(
          child: Text('purpose',
              style: TextStyle(
                color: kInk,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              )),
        ),
      ],
    ),
  );
}

Widget _apiTableRow(String field, String type, String def, String purpose,
    Color accent,
    {bool isLast = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(
              bottom: BorderSide(color: Color(0xFF26324F), width: 1),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            field,
            style: TextStyle(
              color: accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: TextStyle(
              color: kInk,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            def,
            style: TextStyle(
              color: kInkDim,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            purpose,
            style: TextStyle(
              color: kInk,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11 — Closing card
// =============================================================================

Widget _buildClosingSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0F766E),
          Color(0xFF1E3A8A),
          Color(0xFF6D28D9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(16)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color(0x666D28D9),
            blurRadius: 24,
            offset: Offset(0, 10)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _chip('SUMMARY', kAccentTeal),
            const SizedBox(width: 8),
            _chip('CHEATSHEET', kAccentAmber),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Three things to remember',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        _closingPoint('1.',
            'Width- and heightFactor are multipliers against the parent\'s '
            'bounded constraints. Without bounded constraints there is '
            'nothing to multiply.'),
        _closingPoint('2.',
            'Alignment is the anchor; pick it for the direction of growth, '
            'not for where the child "ends up".'),
        _closingPoint('3.',
            'Use the implicit version when state changes drive the '
            'fraction; reach for FractionallySizedBox + a controller when '
            'you need frame-level control.'),
      ],
    ),
  );
}

Widget _closingPoint(String index, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 24,
          child: Text(
            index,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFFE6EDFF),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}
