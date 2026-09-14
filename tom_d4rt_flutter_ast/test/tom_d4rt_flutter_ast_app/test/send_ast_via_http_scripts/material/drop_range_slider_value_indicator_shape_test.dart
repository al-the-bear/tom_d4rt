// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo for slider value indicator shapes.
//
// SUBJECT
// -------
// `DropSliderValueIndicatorShape` and its sibling shapes from
// `package:flutter/material.dart`:
//
//   * DropSliderValueIndicatorShape           (Slider, drop / teardrop pin)
//   * PaddleSliderValueIndicatorShape         (Slider, Material paddle)
//   * RectangularSliderValueIndicatorShape    (Slider, rounded rectangle)
//   * DropRangeSliderValueIndicatorShape      (RangeSlider, drop)
//   * PaddleRangeSliderValueIndicatorShape    (RangeSlider, paddle)
//   * RectangularRangeSliderValueIndicatorShape (RangeSlider, rectangle)
//
// FILENAME NOTE
// -------------
// The host file is `drop_range_slider_value_indicator_shape_test.dart`. Both
// `DropSliderValueIndicatorShape` (single-thumb) and
// `DropRangeSliderValueIndicatorShape` (two-thumb) ship in this Flutter version
// (see `package:flutter/lib/src/material/slider_parts.dart` line 780 and
// `range_slider_parts.dart` line 1334). The demo therefore covers BOTH the
// single-slider and range-slider drop shapes; the canonical "drop pin"
// indicator on `Slider` is the single-thumb `DropSliderValueIndicatorShape`.
//
// PRESENTATION
// ------------
// Each showcase wraps a live `Slider` or `RangeSlider` in a `SliderTheme`
// whose `SliderThemeData.valueIndicatorShape` (or
// `rangeValueIndicatorShape`) is bound to the shape under demonstration.
// `showValueIndicator: ShowValueIndicator.always` keeps the indicator
// permanently rendered so the visual difference between paddle / rectangle /
// drop is immediately legible without dragging.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// TOP-LEVEL ENTRY
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _ValueIndicatorShapeDossier();
}

// ===========================================================================
// HOST WIDGET (Stateful so the sliders are interactive and re-paint live)
// ===========================================================================
class _ValueIndicatorShapeDossier extends StatefulWidget {
  const _ValueIndicatorShapeDossier();

  @override
  State<_ValueIndicatorShapeDossier> createState() =>
      _ValueIndicatorShapeDossierState();
}

class _ValueIndicatorShapeDossierState
    extends State<_ValueIndicatorShapeDossier> {
  // --- Section 3: drop showcase (single Slider) ------------------------------
  double _dropContinuous = 0.42;
  double _dropDiscreteLow = 25.0;
  double _dropDiscreteMid = 55.0;
  double _dropDiscreteHigh = 80.0;

  // --- Section 4: paddle showcase --------------------------------------------
  double _paddleContinuous = 0.66;
  double _paddleDiscreteA = 30.0;
  double _paddleDiscreteB = 65.0;

  // --- Section 5: rectangular showcase ---------------------------------------
  double _rectContinuous = 0.28;
  double _rectDiscreteA = 15.0;
  double _rectDiscreteB = 72.0;

  // --- Section 6: RangeSlider variants ---------------------------------------
  RangeValues _paddleRange = const RangeValues(20.0, 70.0);
  RangeValues _rectRange = const RangeValues(15.0, 60.0);
  RangeValues _dropRange = const RangeValues(35.0, 85.0);

  // --- Section 7: showValueIndicator walkthrough -----------------------------
  double _swvAlways = 40.0;
  double _swvOnlyDiscrete = 60.0;
  double _swvOnlyContinuous = 0.5;
  double _swvNever = 25.0;

  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------
    // SECTION 2: ANATOMY TABLE ROWS
    // -----------------------------------------------------------------------
    const anatomyRows = <_AnatomyRow>[
      _AnatomyRow(
        symbol: 'SliderComponentShape',
        kind: 'abstract base',
        purpose: 'Base shape for single Slider visual parts (thumb, indicator).',
      ),
      _AnatomyRow(
        symbol: 'RangeSliderValueIndicatorShape',
        kind: 'abstract base',
        purpose: 'Base shape for the value indicator above RangeSlider thumbs.',
      ),
      _AnatomyRow(
        symbol: 'getPreferredSize(isEnabled, isDiscrete, {labelPainter, textScaleFactor})',
        kind: 'method',
        purpose: 'Reports the bounding size the indicator wants to occupy.',
      ),
      _AnatomyRow(
        symbol: 'paint(context, center, {activationAnimation, enableAnimation, ...})',
        kind: 'method',
        purpose: 'Draws the indicator onto the Canvas above the thumb.',
      ),
      _AnatomyRow(
        symbol: 'activationAnimation',
        kind: 'Animation<double>',
        purpose: 'Drives the show/hide of the indicator on press.',
      ),
      _AnatomyRow(
        symbol: 'enableAnimation',
        kind: 'Animation<double>',
        purpose: 'Drives the enabled/disabled colour interpolation.',
      ),
      _AnatomyRow(
        symbol: 'labelPainter',
        kind: 'TextPainter',
        purpose: 'Pre-laid-out label text that the indicator renders.',
      ),
      _AnatomyRow(
        symbol: 'sizeWithOverflow',
        kind: 'Size',
        purpose: 'Overflow box used so the indicator can extend beyond track.',
      ),
    ];

    // -----------------------------------------------------------------------
    // SECTION 8: RECIPE CARDS
    // -----------------------------------------------------------------------
    const recipes = <_RecipeCard>[
      _RecipeCard(
        title: 'Material 2 baseline',
        shape: 'PaddleSliderValueIndicatorShape',
        when: 'Default Material 2 look. Best when you stick to ThemeData.',
        snippet:
            'SliderTheme(data: SliderThemeData(valueIndicatorShape: PaddleSliderValueIndicatorShape()))',
        color: Color(0xFF1976D2),
      ),
      _RecipeCard(
        title: 'Modern dashboard',
        shape: 'DropSliderValueIndicatorShape',
        when: 'Compact UIs where the paddle feels too playful.',
        snippet:
            'valueIndicatorShape: const DropSliderValueIndicatorShape(),',
        color: Color(0xFF00838F),
      ),
      _RecipeCard(
        title: 'Settings panel',
        shape: 'RectangularSliderValueIndicatorShape',
        when: 'Long labels (currency, percentages with sign).',
        snippet:
            'valueIndicatorShape: const RectangularSliderValueIndicatorShape(),',
        color: Color(0xFF6A1B9A),
      ),
      _RecipeCard(
        title: 'Audio scrubber',
        shape: 'DropSliderValueIndicatorShape',
        when: 'Time labels like 03:14 read better in a narrow pin.',
        snippet:
            'showValueIndicator: ShowValueIndicator.always,',
        color: Color(0xFF2E7D32),
      ),
      _RecipeCard(
        title: 'Filter range',
        shape: 'RectangularRangeSliderValueIndicatorShape',
        when: 'RangeSlider for price/age filters with two large labels.',
        snippet:
            'rangeValueIndicatorShape: const RectangularRangeSliderValueIndicatorShape(),',
        color: Color(0xFFE65100),
      ),
      _RecipeCard(
        title: 'Photo edit ranges',
        shape: 'DropRangeSliderValueIndicatorShape',
        when: 'Two compact pins above two thumbs (exposure, gamma).',
        snippet:
            'rangeValueIndicatorShape: const DropRangeSliderValueIndicatorShape(),',
        color: Color(0xFF455A64),
      ),
      _RecipeCard(
        title: 'Discrete only',
        shape: 'showValueIndicator.onlyForDiscrete',
        when: 'Steps slider where indicator only matters at divisions.',
        snippet:
            'showValueIndicator: ShowValueIndicator.onlyForDiscrete,',
        color: Color(0xFFAD1457),
      ),
      _RecipeCard(
        title: 'No indicator',
        shape: 'showValueIndicator.never',
        when: 'When the value is rendered elsewhere on screen already.',
        snippet:
            'showValueIndicator: ShowValueIndicator.never,',
        color: Color(0xFF5D4037),
      ),
    ];

    // -----------------------------------------------------------------------
    // SECTION 9: COMPARISON TABLE
    // -----------------------------------------------------------------------
    const comparisonRows = <_ComparisonRow>[
      _ComparisonRow(
        shape: 'DropSliderValueIndicatorShape',
        height: '~32 dp',
        widthBehaviour: 'Hugs label, narrow stem',
        feel: 'Map-pin / teardrop',
        rangeVariant: 'DropRangeSliderValueIndicatorShape',
      ),
      _ComparisonRow(
        shape: 'PaddleSliderValueIndicatorShape',
        height: '~44 dp',
        widthBehaviour: 'Bulges around label',
        feel: 'Material 2 paddle',
        rangeVariant: 'PaddleRangeSliderValueIndicatorShape',
      ),
      _ComparisonRow(
        shape: 'RectangularSliderValueIndicatorShape',
        height: '~32 dp',
        widthBehaviour: 'Pure pill rectangle',
        feel: 'Tooltip-like',
        rangeVariant: 'RectangularRangeSliderValueIndicatorShape',
      ),
    ];

    // -----------------------------------------------------------------------
    // SECTION 10: GLOSSARY
    // -----------------------------------------------------------------------
    const glossary = <_GlossaryEntry>[
      _GlossaryEntry(
        term: 'Value indicator',
        definition:
            'Floating label above the thumb that shows the current value.',
      ),
      _GlossaryEntry(
        term: 'Thumb',
        definition:
            'The draggable handle a user grabs to change the slider value.',
      ),
      _GlossaryEntry(
        term: 'Track',
        definition:
            'The horizontal bar the thumb slides along, split into active / inactive halves.',
      ),
      _GlossaryEntry(
        term: 'Tick mark',
        definition:
            'Dot drawn at each discrete division on the track.',
      ),
      _GlossaryEntry(
        term: 'Divisions',
        definition:
            'Number of discrete steps. Setting divisions != null makes the slider discrete.',
      ),
      _GlossaryEntry(
        term: 'Discrete vs continuous',
        definition:
            'Discrete = stepped (divisions set). Continuous = smooth (divisions null).',
      ),
      _GlossaryEntry(
        term: 'ShowValueIndicator',
        definition:
            'Enum controlling when the indicator shows: always / onlyForDiscrete / onlyForContinuous / never.',
      ),
      _GlossaryEntry(
        term: 'SliderComponentShape',
        definition:
            'Abstract Material class. All single-slider indicator shapes extend it.',
      ),
      _GlossaryEntry(
        term: 'RangeSliderValueIndicatorShape',
        definition:
            'Abstract Material class for indicator shapes used by RangeSlider.',
      ),
      _GlossaryEntry(
        term: 'SliderTheme',
        definition:
            'InheritedWidget that supplies SliderThemeData to descendant sliders.',
      ),
      _GlossaryEntry(
        term: 'valueIndicatorShape',
        definition:
            'SliderThemeData field selecting the indicator shape for Slider.',
      ),
      _GlossaryEntry(
        term: 'rangeValueIndicatorShape',
        definition:
            'SliderThemeData field selecting the indicator shape for RangeSlider.',
      ),
      _GlossaryEntry(
        term: 'activationAnimation',
        definition:
            'Animation<double> driving the show/hide of the indicator on press.',
      ),
      _GlossaryEntry(
        term: 'enableAnimation',
        definition:
            'Animation<double> driving the colour transition between enabled/disabled.',
      ),
    ];

    // =======================================================================
    // RENDER
    // =======================================================================
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ---------------- HEADER -----------------------------------------
            _Header(),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 1: DOSSIER -----------------------------
            _SectionTitle(
              index: 1,
              title: 'Dossier — value indicators at a glance',
              accent: Color(0xFF1565C0),
            ),
            const SizedBox(height: 12.0),
            _DossierPanel(),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 2: ANATOMY -----------------------------
            _SectionTitle(
              index: 2,
              title: 'Anatomy — abstract API surface',
              accent: Color(0xFF6A1B9A),
            ),
            const SizedBox(height: 12.0),
            _AnatomyTable(rows: anatomyRows),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 3: DROP --------------------------------
            _SectionTitle(
              index: 3,
              title: 'Drop indicator — DropSliderValueIndicatorShape',
              accent: Color(0xFF00838F),
            ),
            const SizedBox(height: 12.0),
            _DropSection(
              continuousValue: _dropContinuous,
              onContinuousChanged: (v) =>
                  setState(() => _dropContinuous = v),
              lowValue: _dropDiscreteLow,
              midValue: _dropDiscreteMid,
              highValue: _dropDiscreteHigh,
              onLowChanged: (v) => setState(() => _dropDiscreteLow = v),
              onMidChanged: (v) => setState(() => _dropDiscreteMid = v),
              onHighChanged: (v) => setState(() => _dropDiscreteHigh = v),
            ),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 4: PADDLE ------------------------------
            _SectionTitle(
              index: 4,
              title: 'Paddle indicator — PaddleSliderValueIndicatorShape',
              accent: Color(0xFF1976D2),
            ),
            const SizedBox(height: 12.0),
            _PaddleSection(
              continuousValue: _paddleContinuous,
              onContinuousChanged: (v) =>
                  setState(() => _paddleContinuous = v),
              discreteA: _paddleDiscreteA,
              discreteB: _paddleDiscreteB,
              onDiscreteAChanged: (v) =>
                  setState(() => _paddleDiscreteA = v),
              onDiscreteBChanged: (v) =>
                  setState(() => _paddleDiscreteB = v),
            ),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 5: RECTANGULAR -------------------------
            _SectionTitle(
              index: 5,
              title: 'Rectangular — RectangularSliderValueIndicatorShape',
              accent: Color(0xFF6A1B9A),
            ),
            const SizedBox(height: 12.0),
            _RectSection(
              continuousValue: _rectContinuous,
              onContinuousChanged: (v) =>
                  setState(() => _rectContinuous = v),
              discreteA: _rectDiscreteA,
              discreteB: _rectDiscreteB,
              onDiscreteAChanged: (v) =>
                  setState(() => _rectDiscreteA = v),
              onDiscreteBChanged: (v) =>
                  setState(() => _rectDiscreteB = v),
            ),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 6: RANGE VARIANTS ----------------------
            _SectionTitle(
              index: 6,
              title: 'RangeSlider variants — paddle / rectangle / drop',
              accent: Color(0xFFE65100),
            ),
            const SizedBox(height: 12.0),
            _RangeSliderSection(
              paddleRange: _paddleRange,
              onPaddleChanged: (r) => setState(() => _paddleRange = r),
              rectRange: _rectRange,
              onRectChanged: (r) => setState(() => _rectRange = r),
              dropRange: _dropRange,
              onDropChanged: (r) => setState(() => _dropRange = r),
            ),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 7: showValueIndicator ------------------
            _SectionTitle(
              index: 7,
              title: 'ShowValueIndicator — always / discrete / continuous / never',
              accent: Color(0xFFAD1457),
            ),
            const SizedBox(height: 12.0),
            _ShowValueIndicatorSection(
              alwaysValue: _swvAlways,
              onAlwaysChanged: (v) => setState(() => _swvAlways = v),
              onlyDiscreteValue: _swvOnlyDiscrete,
              onOnlyDiscreteChanged: (v) =>
                  setState(() => _swvOnlyDiscrete = v),
              onlyContinuousValue: _swvOnlyContinuous,
              onOnlyContinuousChanged: (v) =>
                  setState(() => _swvOnlyContinuous = v),
              neverValue: _swvNever,
              onNeverChanged: (v) => setState(() => _swvNever = v),
            ),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 8: RECIPES -----------------------------
            _SectionTitle(
              index: 8,
              title: 'Recipe cards — picking a shape per design language',
              accent: Color(0xFF2E7D32),
            ),
            const SizedBox(height: 12.0),
            _RecipeGrid(cards: recipes),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 9: COMPARISON --------------------------
            _SectionTitle(
              index: 9,
              title: 'Comparison table — drop / paddle / rectangle',
              accent: Color(0xFF455A64),
            ),
            const SizedBox(height: 12.0),
            _ComparisonTable(rows: comparisonRows),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 10: GLOSSARY ---------------------------
            _SectionTitle(
              index: 10,
              title: 'Glossary',
              accent: Color(0xFF5D4037),
            ),
            const SizedBox(height: 12.0),
            _GlossaryList(entries: glossary),
            const SizedBox(height: 24.0),

            // ---------------- SECTION 11: FINAL COMPOSED ---------------------
            _SectionTitle(
              index: 11,
              title: 'Final composed widget tree',
              accent: Color(0xFF0D47A1),
            ),
            const SizedBox(height: 12.0),
            _FinalComposed(
              dropValue: _dropContinuous,
              paddleValue: _paddleContinuous,
              rectValue: _rectContinuous,
              range: _paddleRange,
            ),
            const SizedBox(height: 24.0),

            // ---------------- FOOTER -----------------------------------------
            Center(
              child: Text(
                'Deep Demo • Slider value indicator shapes • Flutter Material',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF9E9E9E),
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
// HEADER
// ===========================================================================
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF00838F), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Slider value indicator shapes',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'DropSliderValueIndicatorShape + paddle / rectangle / range variants',
            style: TextStyle(fontSize: 14.0, color: Color(0xFFE0F7FA)),
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: const <Widget>[
              _Pill(label: 'DropSliderValueIndicatorShape'),
              _Pill(label: 'PaddleSliderValueIndicatorShape'),
              _Pill(label: 'RectangularSliderValueIndicatorShape'),
              _Pill(label: 'DropRangeSliderValueIndicatorShape'),
              _Pill(label: 'PaddleRangeSliderValueIndicatorShape'),
              _Pill(label: 'RectangularRangeSliderValueIndicatorShape'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  const _Pill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION TITLE
// ===========================================================================
class _SectionTitle extends StatelessWidget {
  final int index;
  final String title;
  final Color accent;
  const _SectionTitle({
    required this.index,
    required this.title,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 1: DOSSIER PANEL
// ===========================================================================
class _DossierPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFF90CAF9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'What is a value indicator?',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'A small floating label that appears above the thumb of a Slider or '
            'RangeSlider. It surfaces the current value at the exact point the '
            'user is interacting with.',
            style: TextStyle(fontSize: 13.0, height: 1.4),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'When does it show?',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Controlled by SliderThemeData.showValueIndicator (ShowValueIndicator):\n'
            '  • always — visible whenever the slider is active.\n'
            '  • onlyForDiscrete — only when divisions is set.\n'
            '  • onlyForContinuous — only when divisions is null.\n'
            '  • never — suppressed entirely.',
            style: TextStyle(fontSize: 12.5, height: 1.5),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Three shipped shapes (single Slider):',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            '  • PaddleSliderValueIndicatorShape  — Material 2 paddle (default).\n'
            '  • RectangularSliderValueIndicatorShape — pill rectangle.\n'
            '  • DropSliderValueIndicatorShape  — narrow teardrop pin.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Three matching range shapes:',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            '  • PaddleRangeSliderValueIndicatorShape\n'
            '  • RectangularRangeSliderValueIndicatorShape\n'
            '  • DropRangeSliderValueIndicatorShape',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2: ANATOMY
// ===========================================================================
class _AnatomyRow {
  final String symbol;
  final String kind;
  final String purpose;
  const _AnatomyRow({
    required this.symbol,
    required this.kind,
    required this.purpose,
  });
}

class _AnatomyTable extends StatelessWidget {
  final List<_AnatomyRow> rows;
  const _AnatomyTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFCE93D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  'Symbol',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Kind',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'Purpose',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFCE93D8)),
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      r.symbol,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      r.kind,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      r.purpose,
                      style: const TextStyle(
                        fontSize: 11.5,
                        height: 1.35,
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

// ===========================================================================
// SECTION 3: DROP INDICATOR SHOWCASE
// ===========================================================================
class _DropSection extends StatelessWidget {
  final double continuousValue;
  final ValueChanged<double> onContinuousChanged;
  final double lowValue;
  final double midValue;
  final double highValue;
  final ValueChanged<double> onLowChanged;
  final ValueChanged<double> onMidChanged;
  final ValueChanged<double> onHighChanged;
  const _DropSection({
    required this.continuousValue,
    required this.onContinuousChanged,
    required this.lowValue,
    required this.midValue,
    required this.highValue,
    required this.onLowChanged,
    required this.onMidChanged,
    required this.onHighChanged,
  });

  @override
  Widget build(BuildContext context) {
    final SliderThemeData base = SliderTheme.of(context);
    final SliderThemeData dropTheme = base.copyWith(
      valueIndicatorShape: const DropSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
      activeTrackColor: const Color(0xFF00838F),
      inactiveTrackColor: const Color(0xFFB2EBF2),
      thumbColor: const Color(0xFF006064),
      valueIndicatorColor: const Color(0xFF006064),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFF4DD0E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'DropSliderValueIndicatorShape',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Color(0xFF00838F),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Narrow teardrop / map-pin shape that points down at the thumb. '
            'Great for dense UIs and time / percentage labels.',
            style: TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 16.0),

          // Continuous slider with drop indicator
          const _ShowcaseLabel(
            text: 'Continuous slider — value shown live in drop pin',
          ),
          SliderTheme(
            data: dropTheme,
            child: Slider(
              value: continuousValue,
              onChanged: onContinuousChanged,
              label: '${(continuousValue * 100).toStringAsFixed(0)}%',
            ),
          ),
          const SizedBox(height: 12.0),

          // Discrete sliders at low / mid / high values
          const _ShowcaseLabel(
            text: 'Discrete sliders (divisions: 10) — three different values',
          ),
          SliderTheme(
            data: dropTheme,
            child: Slider(
              value: lowValue,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: lowValue.toStringAsFixed(0),
              onChanged: onLowChanged,
            ),
          ),
          SliderTheme(
            data: dropTheme,
            child: Slider(
              value: midValue,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: midValue.toStringAsFixed(0),
              onChanged: onMidChanged,
            ),
          ),
          SliderTheme(
            data: dropTheme,
            child: Slider(
              value: highValue,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: highValue.toStringAsFixed(0),
              onChanged: onHighChanged,
            ),
          ),

          const SizedBox(height: 8.0),
          _CodeBlock(
            code:
                'SliderTheme(\n'
                '  data: SliderTheme.of(context).copyWith(\n'
                '    valueIndicatorShape: const DropSliderValueIndicatorShape(),\n'
                '    showValueIndicator: ShowValueIndicator.always,\n'
                '  ),\n'
                '  child: Slider(value: v, label: "\$v", onChanged: setV),\n'
                ')',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4: PADDLE INDICATOR SHOWCASE
// ===========================================================================
class _PaddleSection extends StatelessWidget {
  final double continuousValue;
  final ValueChanged<double> onContinuousChanged;
  final double discreteA;
  final double discreteB;
  final ValueChanged<double> onDiscreteAChanged;
  final ValueChanged<double> onDiscreteBChanged;
  const _PaddleSection({
    required this.continuousValue,
    required this.onContinuousChanged,
    required this.discreteA,
    required this.discreteB,
    required this.onDiscreteAChanged,
    required this.onDiscreteBChanged,
  });

  @override
  Widget build(BuildContext context) {
    final SliderThemeData base = SliderTheme.of(context);
    final SliderThemeData paddleTheme = base.copyWith(
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
      activeTrackColor: const Color(0xFF1976D2),
      inactiveTrackColor: const Color(0xFFBBDEFB),
      thumbColor: const Color(0xFF0D47A1),
      valueIndicatorColor: const Color(0xFF1976D2),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFF90CAF9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'PaddleSliderValueIndicatorShape',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Material 2 paddle shape — bulges around the label and tapers down '
            'to the thumb. This is the default for SliderThemeData.',
            style: TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 16.0),
          const _ShowcaseLabel(text: 'Continuous slider (paddle)'),
          SliderTheme(
            data: paddleTheme,
            child: Slider(
              value: continuousValue,
              onChanged: onContinuousChanged,
              label: '${(continuousValue * 100).toStringAsFixed(0)}%',
            ),
          ),
          const SizedBox(height: 12.0),
          const _ShowcaseLabel(
            text: 'Discrete sliders (paddle, divisions: 20)',
          ),
          SliderTheme(
            data: paddleTheme,
            child: Slider(
              value: discreteA,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              label: discreteA.toStringAsFixed(0),
              onChanged: onDiscreteAChanged,
            ),
          ),
          SliderTheme(
            data: paddleTheme,
            child: Slider(
              value: discreteB,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              label: discreteB.toStringAsFixed(0),
              onChanged: onDiscreteBChanged,
            ),
          ),
          const SizedBox(height: 8.0),
          _CodeBlock(
            code:
                'valueIndicatorShape: const PaddleSliderValueIndicatorShape(),',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 5: RECTANGULAR INDICATOR SHOWCASE
// ===========================================================================
class _RectSection extends StatelessWidget {
  final double continuousValue;
  final ValueChanged<double> onContinuousChanged;
  final double discreteA;
  final double discreteB;
  final ValueChanged<double> onDiscreteAChanged;
  final ValueChanged<double> onDiscreteBChanged;
  const _RectSection({
    required this.continuousValue,
    required this.onContinuousChanged,
    required this.discreteA,
    required this.discreteB,
    required this.onDiscreteAChanged,
    required this.onDiscreteBChanged,
  });

  @override
  Widget build(BuildContext context) {
    final SliderThemeData base = SliderTheme.of(context);
    final SliderThemeData rectTheme = base.copyWith(
      valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
      activeTrackColor: const Color(0xFF6A1B9A),
      inactiveTrackColor: const Color(0xFFE1BEE7),
      thumbColor: const Color(0xFF4A148C),
      valueIndicatorColor: const Color(0xFF4A148C),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFCE93D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'RectangularSliderValueIndicatorShape',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Color(0xFF6A1B9A),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Rounded rectangle / pill — neutral tooltip look. Good for long '
            'labels (e.g. currency, percent with sign).',
            style: TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 16.0),
          const _ShowcaseLabel(text: 'Continuous slider (rectangle)'),
          SliderTheme(
            data: rectTheme,
            child: Slider(
              value: continuousValue,
              onChanged: onContinuousChanged,
              label: '\$${(continuousValue * 1000).toStringAsFixed(0)}',
            ),
          ),
          const SizedBox(height: 12.0),
          const _ShowcaseLabel(
            text: 'Discrete sliders (rectangle, divisions: 8)',
          ),
          SliderTheme(
            data: rectTheme,
            child: Slider(
              value: discreteA,
              min: 0.0,
              max: 100.0,
              divisions: 8,
              label: '${discreteA.toStringAsFixed(0)}%',
              onChanged: onDiscreteAChanged,
            ),
          ),
          SliderTheme(
            data: rectTheme,
            child: Slider(
              value: discreteB,
              min: 0.0,
              max: 100.0,
              divisions: 8,
              label: '${discreteB.toStringAsFixed(0)}%',
              onChanged: onDiscreteBChanged,
            ),
          ),
          const SizedBox(height: 8.0),
          _CodeBlock(
            code:
                'valueIndicatorShape: const RectangularSliderValueIndicatorShape(),',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 6: RANGESLIDER VARIANTS
// ===========================================================================
class _RangeSliderSection extends StatelessWidget {
  final RangeValues paddleRange;
  final ValueChanged<RangeValues> onPaddleChanged;
  final RangeValues rectRange;
  final ValueChanged<RangeValues> onRectChanged;
  final RangeValues dropRange;
  final ValueChanged<RangeValues> onDropChanged;
  const _RangeSliderSection({
    required this.paddleRange,
    required this.onPaddleChanged,
    required this.rectRange,
    required this.onRectChanged,
    required this.dropRange,
    required this.onDropChanged,
  });

  @override
  Widget build(BuildContext context) {
    final SliderThemeData base = SliderTheme.of(context);

    final SliderThemeData paddleTheme = base.copyWith(
      rangeValueIndicatorShape:
          const PaddleRangeSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
      activeTrackColor: const Color(0xFFE65100),
      inactiveTrackColor: const Color(0xFFFFCCBC),
      thumbColor: const Color(0xFFBF360C),
      valueIndicatorColor: const Color(0xFFBF360C),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
      ),
    );
    final SliderThemeData rectTheme = base.copyWith(
      rangeValueIndicatorShape:
          const RectangularRangeSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
      activeTrackColor: const Color(0xFFAD1457),
      inactiveTrackColor: const Color(0xFFF8BBD9),
      thumbColor: const Color(0xFF880E4F),
      valueIndicatorColor: const Color(0xFF880E4F),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
      ),
    );
    final SliderThemeData dropTheme = base.copyWith(
      rangeValueIndicatorShape:
          const DropRangeSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
      activeTrackColor: const Color(0xFF2E7D32),
      inactiveTrackColor: const Color(0xFFC8E6C9),
      thumbColor: const Color(0xFF1B5E20),
      valueIndicatorColor: const Color(0xFF1B5E20),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
      ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFFFB74D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'RangeSlider variants',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Color(0xFFE65100),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'RangeSlider draws TWO indicators — one above each thumb. The '
            'shape is selected via rangeValueIndicatorShape (not '
            'valueIndicatorShape).',
            style: TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 16.0),
          const _ShowcaseLabel(
            text: 'PaddleRangeSliderValueIndicatorShape',
          ),
          SliderTheme(
            data: paddleTheme,
            child: RangeSlider(
              values: paddleRange,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              labels: RangeLabels(
                paddleRange.start.toStringAsFixed(0),
                paddleRange.end.toStringAsFixed(0),
              ),
              onChanged: onPaddleChanged,
            ),
          ),
          const SizedBox(height: 12.0),
          const _ShowcaseLabel(
            text: 'RectangularRangeSliderValueIndicatorShape',
          ),
          SliderTheme(
            data: rectTheme,
            child: RangeSlider(
              values: rectRange,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              labels: RangeLabels(
                '\$${rectRange.start.toStringAsFixed(0)}',
                '\$${rectRange.end.toStringAsFixed(0)}',
              ),
              onChanged: onRectChanged,
            ),
          ),
          const SizedBox(height: 12.0),
          const _ShowcaseLabel(
            text: 'DropRangeSliderValueIndicatorShape',
          ),
          SliderTheme(
            data: dropTheme,
            child: RangeSlider(
              values: dropRange,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              labels: RangeLabels(
                dropRange.start.toStringAsFixed(0),
                dropRange.end.toStringAsFixed(0),
              ),
              onChanged: onDropChanged,
            ),
          ),
          const SizedBox(height: 8.0),
          _CodeBlock(
            code:
                'rangeValueIndicatorShape:\n'
                '  const DropRangeSliderValueIndicatorShape(),',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7: showValueIndicator ENUM WALKTHROUGH
// ===========================================================================
class _ShowValueIndicatorSection extends StatelessWidget {
  final double alwaysValue;
  final ValueChanged<double> onAlwaysChanged;
  final double onlyDiscreteValue;
  final ValueChanged<double> onOnlyDiscreteChanged;
  final double onlyContinuousValue;
  final ValueChanged<double> onOnlyContinuousChanged;
  final double neverValue;
  final ValueChanged<double> onNeverChanged;
  const _ShowValueIndicatorSection({
    required this.alwaysValue,
    required this.onAlwaysChanged,
    required this.onlyDiscreteValue,
    required this.onOnlyDiscreteChanged,
    required this.onlyContinuousValue,
    required this.onOnlyContinuousChanged,
    required this.neverValue,
    required this.onNeverChanged,
  });

  @override
  Widget build(BuildContext context) {
    final SliderThemeData base = SliderTheme.of(context);

    SliderThemeData mk(ShowValueIndicator mode, Color colour) {
      return base.copyWith(
        valueIndicatorShape: const DropSliderValueIndicatorShape(),
        showValueIndicator: mode,
        activeTrackColor: colour,
        inactiveTrackColor: colour.withOpacity(0.25),
        thumbColor: colour,
        valueIndicatorColor: colour,
        valueIndicatorTextStyle: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
          fontSize: 11.0,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFF06292)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ShowValueIndicator enum',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Color(0xFFAD1457),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Four modes determine when the value indicator becomes visible. '
            'The shape (drop / paddle / rectangle) is unchanged — only its '
            'visibility schedule changes.',
            style: TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 16.0),

          const _ShowcaseLabel(
            text: 'ShowValueIndicator.always (discrete, divisions: 10)',
          ),
          SliderTheme(
            data: mk(ShowValueIndicator.always, const Color(0xFF1976D2)),
            child: Slider(
              value: alwaysValue,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: alwaysValue.toStringAsFixed(0),
              onChanged: onAlwaysChanged,
            ),
          ),

          const _ShowcaseLabel(
            text: 'ShowValueIndicator.onlyForDiscrete (visible)',
          ),
          SliderTheme(
            data: mk(
              ShowValueIndicator.onlyForDiscrete,
              const Color(0xFF2E7D32),
            ),
            child: Slider(
              value: onlyDiscreteValue,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: onlyDiscreteValue.toStringAsFixed(0),
              onChanged: onOnlyDiscreteChanged,
            ),
          ),

          const _ShowcaseLabel(
            text: 'ShowValueIndicator.onlyForContinuous (visible)',
          ),
          SliderTheme(
            data: mk(
              ShowValueIndicator.onlyForContinuous,
              const Color(0xFFE65100),
            ),
            child: Slider(
              value: onlyContinuousValue,
              label:
                  '${(onlyContinuousValue * 100).toStringAsFixed(0)}%',
              onChanged: onOnlyContinuousChanged,
            ),
          ),

          const _ShowcaseLabel(
            text: 'ShowValueIndicator.never (suppressed)',
          ),
          SliderTheme(
            data: mk(ShowValueIndicator.never, const Color(0xFF5D4037)),
            child: Slider(
              value: neverValue,
              min: 0.0,
              max: 100.0,
              divisions: 10,
              label: neverValue.toStringAsFixed(0),
              onChanged: onNeverChanged,
            ),
          ),

          const SizedBox(height: 8.0),
          _CodeBlock(
            code:
                'showValueIndicator: ShowValueIndicator.onlyForDiscrete,',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8: RECIPE GRID
// ===========================================================================
class _RecipeCard {
  final String title;
  final String shape;
  final String when;
  final String snippet;
  final Color color;
  const _RecipeCard({
    required this.title,
    required this.shape,
    required this.when,
    required this.snippet,
    required this.color,
  });
}

class _RecipeGrid extends StatelessWidget {
  final List<_RecipeCard> cards;
  const _RecipeGrid({required this.cards});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 600
            ? (constraints.maxWidth - 16.0) / 2.0
            : constraints.maxWidth;
        return Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: <Widget>[
            for (final card in cards)
              SizedBox(
                width: cardWidth,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: card.color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: card.color.withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: card.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              card.title,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: card.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        card.shape,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        card.when,
                        style: const TextStyle(
                          fontSize: 12.0,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      _CodeBlock(code: card.snippet),
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

// ===========================================================================
// SECTION 9: COMPARISON TABLE
// ===========================================================================
class _ComparisonRow {
  final String shape;
  final String height;
  final String widthBehaviour;
  final String feel;
  final String rangeVariant;
  const _ComparisonRow({
    required this.shape,
    required this.height,
    required this.widthBehaviour,
    required this.feel,
    required this.rangeVariant,
  });
}

class _ComparisonTable extends StatelessWidget {
  final List<_ComparisonRow> rows;
  const _ComparisonTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFB0BEC5)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  'Single Slider shape',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Height',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Width',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Feel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Range variant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFB0BEC5)),
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      r.shape,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      r.height,
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      r.widthBehaviour,
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      r.feel,
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      r.rangeVariant,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
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

// ===========================================================================
// SECTION 10: GLOSSARY
// ===========================================================================
class _GlossaryEntry {
  final String term;
  final String definition;
  const _GlossaryEntry({required this.term, required this.definition});
}

class _GlossaryList extends StatelessWidget {
  final List<_GlossaryEntry> entries;
  const _GlossaryList({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEBE9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFA1887F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 160.0,
                    child: Text(
                      e.term,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color(0xFF5D4037),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      e.definition,
                      style: const TextStyle(
                        fontSize: 12.0,
                        height: 1.4,
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

// ===========================================================================
// SECTION 11: FINAL COMPOSED
// ===========================================================================
class _FinalComposed extends StatelessWidget {
  final double dropValue;
  final double paddleValue;
  final double rectValue;
  final RangeValues range;
  const _FinalComposed({
    required this.dropValue,
    required this.paddleValue,
    required this.rectValue,
    required this.range,
  });

  @override
  Widget build(BuildContext context) {
    final SliderThemeData base = SliderTheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF0D47A1), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A single SliderTheme can be reused across all sliders',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Below: drop, paddle, rectangular, plus a paddle RangeSlider, all '
            'reading from the same live state.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFFBBDEFB)),
          ),
          const SizedBox(height: 16.0),
          _MiniSlider(
            label: 'Drop',
            colour: const Color(0xFF26C6DA),
            shape: const DropSliderValueIndicatorShape(),
            value: dropValue,
            base: base,
          ),
          _MiniSlider(
            label: 'Paddle',
            colour: const Color(0xFF42A5F5),
            shape: const PaddleSliderValueIndicatorShape(),
            value: paddleValue,
            base: base,
          ),
          _MiniSlider(
            label: 'Rectangle',
            colour: const Color(0xFFAB47BC),
            shape: const RectangularSliderValueIndicatorShape(),
            value: rectValue,
            base: base,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Range: ${range.start.toStringAsFixed(0)} → '
            '${range.end.toStringAsFixed(0)}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SliderTheme(
            data: base.copyWith(
              rangeValueIndicatorShape:
                  const PaddleRangeSliderValueIndicatorShape(),
              showValueIndicator: ShowValueIndicator.always,
              activeTrackColor: const Color(0xFF80DEEA),
              inactiveTrackColor: const Color(0x55FFFFFF),
              thumbColor: const Color(0xFFFFFFFF),
              valueIndicatorColor: const Color(0xFF26C6DA),
              valueIndicatorTextStyle: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            child: RangeSlider(
              values: range,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              labels: RangeLabels(
                range.start.toStringAsFixed(0),
                range.end.toStringAsFixed(0),
              ),
              onChanged: (_) {},
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Tip: prefer ThemeData.sliderTheme on your MaterialApp so every '
              'Slider/RangeSlider in the tree inherits one consistent shape '
              'without repeated SliderTheme wrappers.',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFFFFFFFF),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniSlider extends StatelessWidget {
  final String label;
  final Color colour;
  final SliderComponentShape shape;
  final double value;
  final SliderThemeData base;
  const _MiniSlider({
    required this.label,
    required this.colour,
    required this.shape,
    required this.value,
    required this.base,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPercent = value <= 1.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SliderTheme(
            data: base.copyWith(
              valueIndicatorShape: shape,
              showValueIndicator: ShowValueIndicator.always,
              activeTrackColor: colour,
              inactiveTrackColor: const Color(0x55FFFFFF),
              thumbColor: const Color(0xFFFFFFFF),
              valueIndicatorColor: colour,
              valueIndicatorTextStyle: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
            child: Slider(
              value: isPercent ? value : value / 100.0,
              label: isPercent
                  ? '${(value * 100).toStringAsFixed(0)}%'
                  : value.toStringAsFixed(0),
              onChanged: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SHARED UI HELPERS
// ===========================================================================
class _ShowcaseLabel extends StatelessWidget {
  final String text;
  const _ShowcaseLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
          color: Color(0xFF455A64),
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF263238),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.5,
          color: Color(0xFFB2DFDB),
          height: 1.4,
        ),
      ),
    );
  }
}
