import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// -----------------------------------------------------------------------------
// Visual demo for ScrollIncrementDetails.
//
// ScrollIncrementDetails is the small, read-only record Flutter hands to a
// Scrollable's incrementCalculator. It carries two things:
//
//   - type:    a ScrollIncrementType (line or page)
//   - metrics: a ScrollMetrics snapshot of the current scroll position
//
// The calculator's job is to look at those two inputs and return a double
// (in pixels) that describes how far the scrollable should move for *this*
// particular increment request. Defaults in Flutter:
//
//   - line  -> ~50 logical pixels
//   - page  -> viewportDimension * 0.8
//
// This file builds a long "Increment Calculator" page that teaches the API
// with live controls, a side-by-side comparison, a real working custom
// incrementCalculator inside a Scrollable + Shortcuts + Actions tree, a
// ScrollMetrics field reference, formula galleries, teaching tiles, and
// use-case strips.
//
// Constraints followed:
//   - Only package:flutter/material.dart and package:flutter/services.dart.
//   - No main(), no runApp(); a top-level `build(BuildContext)` returns
//     MaterialApp(home: ...).
//   - No avoid_print ignores: uses debugPrint.
//   - Color transparency uses withValues(alpha: ...).
// -----------------------------------------------------------------------------

// -------- Palette ------------------------------------------------------------
const Color _slate = Color(0xFF2E384D);
const Color _mint = Color(0xFF4ECDC4);
const Color _sun = Color(0xFFFFE66D);
const Color _paper = Color(0xFFF7F7F2);
const Color _ink = Color(0xFF1C2230);
const Color _ash = Color(0xFF8892A6);

// Monospace font stack for number / formula panels.
const String _mono = 'monospace';

// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollIncrementDetails — Increment Calculator',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _paper,
      colorScheme: const ColorScheme.light(
        primary: _slate,
        secondary: _mint,
        surface: _paper,
        onPrimary: _paper,
        onSecondary: _ink,
        onSurface: _ink,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _slate,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleLarge: TextStyle(color: _slate, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: _slate, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: _ink, height: 1.35),
        bodySmall: TextStyle(color: _ash, height: 1.3),
        labelSmall: TextStyle(
          color: _slate,
          fontFamily: _mono,
          letterSpacing: 0.6,
        ),
      ),
    ),
    home: const _IncrementCalculatorPage(),
  );
}

// =============================================================================
// Page scaffold
// =============================================================================

class _IncrementCalculatorPage extends StatelessWidget {
  const _IncrementCalculatorPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _slate,
        foregroundColor: _paper,
        elevation: 0,
        title: const Text(
          'ScrollIncrementDetails',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _mint),
                ),
                child: const Text(
                  'flutter 3.41.6',
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _paper,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // D6: replaced `SingleChildScrollView(child: Column(...))` with
      // a `ListView` whose children are individually wrapped in
      // `Center+ConstrainedBox(maxWidth: 1100)`. The previous structure
      // allowed unbounded-height constraints to reach inner
      // `LayoutBuilder` widgets, which fail on infinite vertical
      // bounds. ListView gives each child a bounded slot, which closes
      // the infinite-height cascade (same C22 pattern).
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _HeroHeader(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _LiveCalculatorSection(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _TypeComparisonSection(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _CustomCalculatorDemoSection(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _ScrollMetricsReferenceCard(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _FormulaGallerySection(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _TeachingPanelSection(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _UseCasesStrip(),
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: _FooterSummaryCard(),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

// =============================================================================
// 1) Hero header — a decorative caliper / ruler made of nested Containers
// =============================================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: _slate,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _slate.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _mint.withValues(alpha: 0.6)),
                ),
                child: const Text(
                  'scrollable · input record',
                  style: TextStyle(
                    color: _mint,
                    fontFamily: _mono,
                    fontSize: 11,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _sun.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _sun.withValues(alpha: 0.6)),
                ),
                child: const Text(
                  'read-only · value-like',
                  style: TextStyle(
                    color: _sun,
                    fontFamily: _mono,
                    fontSize: 11,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'ScrollIncrementDetails',
            style: TextStyle(
              color: _paper,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'the input to your scroll math',
            style: TextStyle(
              color: _paper.withValues(alpha: 0.72),
              fontSize: 17,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 22),
          const _DecorativeCaliper(),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeroPill(
                label: 'type',
                value: 'ScrollIncrementType',
                valueColor: _mint,
              ),
              _HeroPill(
                label: 'metrics',
                value: 'ScrollMetrics',
                valueColor: _sun,
              ),
              _HeroPill(
                label: 'used by',
                value: 'incrementCalculator',
                valueColor: _paper,
              ),
              _HeroPill(
                label: 'returns',
                value: 'double (pixels)',
                valueColor: _paper,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _HeroPill({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _ink.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _paper.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: _paper.withValues(alpha: 0.5),
              fontFamily: _mono,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontFamily: _mono,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCaliper extends StatelessWidget {
  const _DecorativeCaliper();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _ink.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _paper.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'viewport',
                style: TextStyle(
                  color: _paper.withValues(alpha: 0.6),
                  fontFamily: _mono,
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              Text(
                'scrollExtent',
                style: TextStyle(
                  color: _paper.withValues(alpha: 0.6),
                  fontFamily: _mono,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const ticks = 41;
                final tickSpacing = constraints.maxWidth / (ticks - 1);
                return Stack(
                  children: [
                    // Ruler bar.
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _slate,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _mint.withValues(alpha: 0.35),
                          ),
                        ),
                      ),
                    ),
                    // Tick marks.
                    for (int i = 0; i < ticks; i++)
                      Positioned(
                        left: i * tickSpacing,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 1,
                          color: i % 5 == 0
                              ? _paper.withValues(alpha: 0.7)
                              : _paper.withValues(alpha: 0.25),
                        ),
                      ),
                    // "line" delta — a short segment near left.
                    Positioned(
                      left: tickSpacing * 2,
                      top: 10,
                      height: 28,
                      width: tickSpacing * 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _mint.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'line ≈ 50',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 10,
                            fontFamily: _mono,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // "page" delta — a long segment spanning most of the bar.
                    Positioned(
                      left: tickSpacing * 8,
                      top: 10,
                      height: 28,
                      width: tickSpacing * 24,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _sun.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'page ≈ viewport * 0.8',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 10,
                            fontFamily: _mono,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 2) Live interactive calculator
// =============================================================================

class _LiveCalculatorSection extends StatefulWidget {
  const _LiveCalculatorSection();

  @override
  State<_LiveCalculatorSection> createState() => _LiveCalculatorSectionState();
}

class _LiveCalculatorSectionState extends State<_LiveCalculatorSection> {
  ScrollIncrementType _type = ScrollIncrementType.line;
  double _viewport = 600;
  double _pixels = 420;
  double _minExtent = 0;
  double _maxExtent = 4800;
  double _boost = 1.2;

  double _defaultIncrement() {
    switch (_type) {
      case ScrollIncrementType.line:
        return 50;
      case ScrollIncrementType.page:
        return _viewport * 0.8;
    }
  }

  double _customIncrement() {
    switch (_type) {
      case ScrollIncrementType.line:
        return 50 * _boost;
      case ScrollIncrementType.page:
        return _viewport * (0.8 * _boost).clamp(0.1, 2.0);
    }
  }

  // Build a real FixedScrollMetrics so the demo value can be constructed.
  ScrollMetrics _metrics() {
    return FixedScrollMetrics(
      minScrollExtent: _minExtent,
      maxScrollExtent: _maxExtent,
      pixels: _pixels.clamp(_minExtent, _maxExtent),
      viewportDimension: _viewport,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 1.0,
    );
  }

  ScrollIncrementDetails _details() {
    return ScrollIncrementDetails(type: _type, metrics: _metrics());
  }

  @override
  Widget build(BuildContext context) {
    final details = _details();
    final metrics = details.metrics;
    final defaultDelta = _defaultIncrement();
    final customDelta = _customIncrement();

    return _SectionCard(
      title: 'Live interactive calculator',
      subtitle:
          'Dial in type + metrics, then watch a default and a custom incrementCalculator '
          'compute their deltas. Uses FixedScrollMetrics so the demo record is real.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 820;
          final form = _CalculatorForm(
            type: _type,
            viewport: _viewport,
            pixels: _pixels,
            minExtent: _minExtent,
            maxExtent: _maxExtent,
            boost: _boost,
            onType: (t) => setState(() => _type = t),
            onViewport: (v) => setState(() => _viewport = v),
            onPixels: (v) => setState(() => _pixels = v),
            onMin: (v) => setState(() => _minExtent = v),
            onMax: (v) => setState(() => _maxExtent = v),
            onBoost: (v) => setState(() => _boost = v),
          );
          final output = _CalculatorOutput(
            details: details,
            metrics: metrics,
            defaultDelta: defaultDelta,
            customDelta: customDelta,
            boost: _boost,
          );
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: form),
                const SizedBox(width: 20),
                Expanded(flex: 4, child: output),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [form, const SizedBox(height: 20), output],
          );
        },
      ),
    );
  }
}

class _CalculatorForm extends StatelessWidget {
  final ScrollIncrementType type;
  final double viewport;
  final double pixels;
  final double minExtent;
  final double maxExtent;
  final double boost;
  final ValueChanged<ScrollIncrementType> onType;
  final ValueChanged<double> onViewport;
  final ValueChanged<double> onPixels;
  final ValueChanged<double> onMin;
  final ValueChanged<double> onMax;
  final ValueChanged<double> onBoost;

  const _CalculatorForm({
    required this.type,
    required this.viewport,
    required this.pixels,
    required this.minExtent,
    required this.maxExtent,
    required this.boost,
    required this.onType,
    required this.onViewport,
    required this.onPixels,
    required this.onMin,
    required this.onMax,
    required this.onBoost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _slate.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _FormSectionTitle(label: 'type', suffix: 'ScrollIncrementType'),
          const SizedBox(height: 8),
          SegmentedButton<ScrollIncrementType>(
            segments: const [
              ButtonSegment(
                value: ScrollIncrementType.line,
                label: Text('line'),
                icon: Icon(Icons.density_small),
              ),
              ButtonSegment(
                value: ScrollIncrementType.page,
                label: Text('page'),
                icon: Icon(Icons.vertical_align_center),
              ),
            ],
            selected: {type},
            onSelectionChanged: (s) => onType(s.first),
            showSelectedIcon: false,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return _slate;
                return _paper;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return _paper;
                return _slate;
              }),
              side: WidgetStatePropertyAll(
                BorderSide(color: _slate.withValues(alpha: 0.25)),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _FormSectionTitle(
            label: 'metrics',
            suffix: 'FixedScrollMetrics',
          ),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'viewportDimension',
            value: viewport,
            min: 100,
            max: 1200,
            divisions: 110,
            unit: 'px',
            accent: _mint,
            onChanged: onViewport,
          ),
          _LabeledSlider(
            label: 'pixels',
            value: pixels,
            min: minExtent,
            max: maxExtent,
            divisions: 100,
            unit: 'px',
            accent: _sun,
            onChanged: onPixels,
          ),
          _LabeledSlider(
            label: 'minScrollExtent',
            value: minExtent,
            min: -500,
            max: 0,
            divisions: 50,
            unit: 'px',
            accent: _slate,
            onChanged: onMin,
          ),
          _LabeledSlider(
            label: 'maxScrollExtent',
            value: maxExtent,
            min: 1000,
            max: 12000,
            divisions: 110,
            unit: 'px',
            accent: _slate,
            onChanged: onMax,
          ),
          const SizedBox(height: 14),
          const _FormSectionTitle(
            label: 'custom formula',
            suffix: 'boost × default',
          ),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'boost',
            value: boost,
            min: 0.25,
            max: 2.5,
            divisions: 45,
            unit: '×',
            accent: _mint,
            onChanged: onBoost,
          ),
        ],
      ),
    );
  }
}

class _FormSectionTitle extends StatelessWidget {
  final String label;
  final String suffix;
  const _FormSectionTitle({required this.label, required this.suffix});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: _mono,
            fontSize: 11,
            color: _slate,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Container(height: 1, color: _slate.withValues(alpha: 0.12))),
        const SizedBox(width: 8),
        Text(
          suffix,
          style: const TextStyle(
            fontFamily: _mono,
            fontSize: 11,
            color: _ash,
          ),
        ),
      ],
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String unit;
  final Color accent;
  final ValueChanged<double> onChanged;

  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.unit,
    required this.accent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: _mono,
                  fontSize: 12,
                  color: _slate,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${value.toStringAsFixed(unit == '×' ? 2 : 0)} $unit',
                  style: const TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              activeTrackColor: accent,
              inactiveTrackColor: accent.withValues(alpha: 0.18),
              thumbColor: _slate,
              overlayColor: accent.withValues(alpha: 0.15),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _CalculatorOutput extends StatelessWidget {
  final ScrollIncrementDetails details;
  final ScrollMetrics metrics;
  final double defaultDelta;
  final double customDelta;
  final double boost;

  const _CalculatorOutput({
    required this.details,
    required this.metrics,
    required this.defaultDelta,
    required this.customDelta,
    required this.boost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _slate,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: _slate.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _mint.withValues(alpha: 0.5)),
                ),
                child: const Text(
                  'compute',
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _mint,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'ScrollIncrementDetails',
                style: TextStyle(
                  fontFamily: _mono,
                  fontSize: 11,
                  color: _paper.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ReadoutRow(label: 'details.type', value: details.type.name),
          _ReadoutRow(
            label: 'metrics.pixels',
            value: metrics.pixels.toStringAsFixed(1),
          ),
          _ReadoutRow(
            label: 'metrics.minScrollExtent',
            value: metrics.minScrollExtent.toStringAsFixed(1),
          ),
          _ReadoutRow(
            label: 'metrics.maxScrollExtent',
            value: metrics.maxScrollExtent.toStringAsFixed(1),
          ),
          _ReadoutRow(
            label: 'metrics.viewportDimension',
            value: metrics.viewportDimension.toStringAsFixed(1),
          ),
          _ReadoutRow(
            label: 'metrics.extentBefore',
            value: metrics.extentBefore.toStringAsFixed(1),
          ),
          _ReadoutRow(
            label: 'metrics.extentAfter',
            value: metrics.extentAfter.toStringAsFixed(1),
          ),
          _ReadoutRow(label: 'metrics.atEdge', value: metrics.atEdge.toString()),
          const SizedBox(height: 14),
          Container(height: 1, color: _paper.withValues(alpha: 0.08)),
          const SizedBox(height: 14),
          _DeltaCard(
            label: 'default Flutter calculator',
            formula: details.type == ScrollIncrementType.line
                ? '→ 50'
                : '→ viewport * 0.8',
            value: defaultDelta,
            color: _sun,
          ),
          const SizedBox(height: 10),
          _DeltaCard(
            label: 'custom boosted calculator',
            formula: details.type == ScrollIncrementType.line
                ? '→ 50 * ${boost.toStringAsFixed(2)}'
                : '→ viewport * 0.8 * ${boost.toStringAsFixed(2)}',
            value: customDelta,
            color: _mint,
          ),
        ],
      ),
    );
  }
}

class _ReadoutRow extends StatelessWidget {
  final String label;
  final String value;
  const _ReadoutRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: _mono,
              fontSize: 12,
              color: _paper.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 1,
              color: _paper.withValues(alpha: 0.05),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: _mono,
              fontSize: 12,
              color: _paper,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeltaCard extends StatelessWidget {
  final String label;
  final String formula;
  final double value;
  final Color color;

  const _DeltaCard({
    required this.label,
    required this.formula,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _paper.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formula,
                  style: const TextStyle(
                    fontFamily: _mono,
                    fontSize: 13,
                    color: _paper,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${value.toStringAsFixed(1)} px',
              style: TextStyle(
                fontFamily: _mono,
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3) Type comparison — line vs page side by side
// =============================================================================

class _TypeComparisonSection extends StatelessWidget {
  const _TypeComparisonSection();

  @override
  Widget build(BuildContext context) {
    const viewport = 600.0;
    const lineDefault = 50.0;
    final pageDefault = viewport * 0.8;
    return _SectionCard(
      title: 'line vs page',
      subtitle:
          'The two values of ScrollIncrementType produce radically different '
          'default deltas. Here is how they compare on a 600 px viewport.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 680;
          final line = _TypeCard(
            type: ScrollIncrementType.line,
            title: 'line',
            subtitle: 'small, steady nudges',
            description:
                'One arrow-key tap, one VoiceOver flick, one "increment" call. '
                'Default: ~50 px. Think one row of a table or one line of text.',
            delta: lineDefault,
            maxVisual: viewport,
            accent: _mint,
          );
          final page = _TypeCard(
            type: ScrollIncrementType.page,
            title: 'page',
            subtitle: 'viewport-sized leaps',
            description:
                'PageUp / PageDown, Space on a document, next-screen gestures. '
                'Default: viewport * 0.8. Keeps context so the user does not '
                'lose their place.',
            delta: pageDefault,
            maxVisual: viewport,
            accent: _sun,
          );
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: line),
                const SizedBox(width: 16),
                Expanded(child: page),
              ],
            );
          }
          return Column(children: [line, const SizedBox(height: 16), page]);
        },
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final ScrollIncrementType type;
  final String title;
  final String subtitle;
  final String description;
  final double delta;
  final double maxVisual;
  final Color accent;

  const _TypeCard({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.delta,
    required this.maxVisual,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'ScrollIncrementType.${type.name}',
                  style: const TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              color: _slate,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: _ash,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(color: _ink, fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _slate.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text(
                      'default delta',
                      style: TextStyle(
                        fontFamily: _mono,
                        fontSize: 11,
                        color: _slate,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${delta.toStringAsFixed(0)} px on 600 viewport',
                      style: const TextStyle(
                        fontFamily: _mono,
                        fontSize: 11,
                        color: _slate,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                LayoutBuilder(
                  builder: (context, c) {
                    final fill = (delta / maxVisual).clamp(0.0, 1.0);
                    return Stack(
                      children: [
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: _slate.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: fill == 0 ? 0.01 : fill,
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '${(fill * 100).toStringAsFixed(0)}% of viewport',
                                style: const TextStyle(
                                  color: _ink,
                                  fontFamily: _mono,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 4) Custom incrementCalculator demo — real Scrollable w/ Shortcuts+Actions
// =============================================================================

class _CustomCalculatorDemoSection extends StatefulWidget {
  const _CustomCalculatorDemoSection();

  @override
  State<_CustomCalculatorDemoSection> createState() =>
      _CustomCalculatorDemoSectionState();
}

class _CustomCalculatorDemoSectionState
    extends State<_CustomCalculatorDemoSection> {
  final ScrollController _controller = ScrollController();
  final FocusNode _focus = FocusNode(debugLabel: 'incrementCalculatorDemo');

  String _lastEvent = 'idle — focus the panel and press ↓, ↑, PageDown, PageUp';
  ScrollIncrementType? _lastType;
  double _lastDelta = 0;
  int _eventCount = 0;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  // The star of the show. Called when the ScrollAction asks "how far?".
  double _customCalculator(ScrollIncrementDetails details) {
    final m = details.metrics;
    final double delta;
    switch (details.type) {
      case ScrollIncrementType.line:
        delta = 25; // quieter line step
        break;
      case ScrollIncrementType.page:
        delta = m.viewportDimension * 1.2; // bigger page leap
        break;
    }
    // Surface the event to the UI.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _lastType = details.type;
        _lastDelta = delta;
        _eventCount++;
        _lastEvent = '#$_eventCount · type=${details.type.name} · '
            'viewport=${m.viewportDimension.toStringAsFixed(0)} · '
            'pixels=${m.pixels.toStringAsFixed(0)} · '
            'Δ=${delta.toStringAsFixed(1)}px';
      });
      debugPrint(
        'incrementCalculator fired: type=${details.type.name}, '
        'delta=${delta.toStringAsFixed(1)}',
      );
    });
    return delta;
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Custom incrementCalculator — live',
      subtitle:
          'Click the scroll panel to focus it, then use the keyboard. '
          'Each arrow / Page key triggers ScrollAction, which asks our '
          'custom calculator for a delta.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'line → 25 px',
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _slate,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _sun.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'page → viewport × 1.2',
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _slate,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 260,
            child: Shortcuts(
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.arrowDown):
                    ScrollIntent(direction: AxisDirection.down),
                SingleActivator(LogicalKeyboardKey.arrowUp):
                    ScrollIntent(direction: AxisDirection.up),
                SingleActivator(LogicalKeyboardKey.pageDown): ScrollIntent(
                  direction: AxisDirection.down,
                  type: ScrollIncrementType.page,
                ),
                SingleActivator(LogicalKeyboardKey.pageUp): ScrollIntent(
                  direction: AxisDirection.up,
                  type: ScrollIncrementType.page,
                ),
              },
              child: Actions(
                actions: <Type, Action<Intent>>{
                  ScrollIntent: _LoggingScrollAction(_customCalculator),
                },
                child: Focus(
                  focusNode: _focus,
                  autofocus: false,
                  child: GestureDetector(
                    onTap: () => _focus.requestFocus(),
                    behavior: HitTestBehavior.opaque,
                    child: _ScrollTargetPanel(
                      controller: _controller,
                      focused: _focus.hasFocus,
                      lastType: _lastType,
                      lastDelta: _lastDelta,
                      lastEvent: _lastEvent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _slate.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: _slate, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _lastEvent,
                    style: const TextStyle(
                      fontFamily: _mono,
                      fontSize: 12,
                      color: _slate,
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

// A ScrollAction subclass that lets us inject a custom incrementCalculator and
// record whenever it fires. We override invoke so we can read the intent's
// type, compute the delta via our calculator, and animate the controller.
class _LoggingScrollAction extends ScrollAction {
  final double Function(ScrollIncrementDetails) calculator;
  _LoggingScrollAction(this.calculator);

  @override
  void invoke(ScrollIntent intent, [BuildContext? context]) {
    final ctx = context;
    if (ctx == null) return;
    final state = Scrollable.maybeOf(ctx);
    if (state == null) return;
    final position = state.position;
    final metrics = FixedScrollMetrics(
      minScrollExtent: position.minScrollExtent,
      maxScrollExtent: position.maxScrollExtent,
      pixels: position.pixels,
      viewportDimension: position.viewportDimension,
      axisDirection: position.axisDirection,
      devicePixelRatio: position.devicePixelRatio,
    );
    final details = ScrollIncrementDetails(type: intent.type, metrics: metrics);
    final base = calculator(details);
    final signed = intent.direction == AxisDirection.up ||
            intent.direction == AxisDirection.left
        ? -base
        : base;
    final target = (position.pixels + signed)
        .clamp(position.minScrollExtent, position.maxScrollExtent);
    position.animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }
}

class _ScrollTargetPanel extends StatelessWidget {
  final ScrollController controller;
  final bool focused;
  final ScrollIncrementType? lastType;
  final double lastDelta;
  final String lastEvent;

  const _ScrollTargetPanel({
    required this.controller,
    required this.focused,
    required this.lastType,
    required this.lastDelta,
    required this.lastEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _slate,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: focused
              ? _mint
              : _paper.withValues(alpha: 0.08),
          width: focused ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ListView.builder(
          controller: controller,
          itemCount: 60,
          itemBuilder: (context, i) {
            final isLastLine =
                lastType == ScrollIncrementType.line && i == 0;
            final isLastPage =
                lastType == ScrollIncrementType.page && i == 0;
            final tileColor = isLastLine
                ? _mint.withValues(alpha: 0.22)
                : isLastPage
                    ? _sun.withValues(alpha: 0.22)
                    : _ink.withValues(alpha: 0.4);
            return Container(
              height: 44,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _paper.withValues(alpha: 0.05),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'row ${i.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontFamily: _mono,
                      fontSize: 12,
                      color: _paper,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      i == 0
                          ? lastEvent
                          : 'some list row content — arrow / page keys to scroll',
                      style: TextStyle(
                        color: _paper.withValues(alpha: 0.75),
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (i == 0 && lastDelta != 0)
                    Text(
                      '${lastDelta.toStringAsFixed(0)}px',
                      style: const TextStyle(
                        fontFamily: _mono,
                        fontSize: 11,
                        color: _mint,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// 5) ScrollMetrics reference card
// =============================================================================

class _ScrollMetricsReferenceCard extends StatelessWidget {
  const _ScrollMetricsReferenceCard();

  @override
  Widget build(BuildContext context) {
    const rows = <_MetricsRow>[
      _MetricsRow(
        name: 'pixels',
        type: 'double',
        notes: 'current scroll offset, in pixels',
      ),
      _MetricsRow(
        name: 'minScrollExtent',
        type: 'double',
        notes: 'smallest valid pixels; usually 0 or slightly negative',
      ),
      _MetricsRow(
        name: 'maxScrollExtent',
        type: 'double',
        notes: 'largest valid pixels; the end of the content',
      ),
      _MetricsRow(
        name: 'viewportDimension',
        type: 'double',
        notes: 'visible size along the scroll axis',
      ),
      _MetricsRow(
        name: 'axis',
        type: 'Axis',
        notes: 'horizontal or vertical, derived from axisDirection',
      ),
      _MetricsRow(
        name: 'axisDirection',
        type: 'AxisDirection',
        notes: 'up/down/left/right, tells you orientation + flip',
      ),
      _MetricsRow(
        name: 'outOfRange',
        type: 'bool',
        notes: 'pixels < min or > max (overscroll)',
      ),
      _MetricsRow(
        name: 'atEdge',
        type: 'bool',
        notes: 'pixels == min or pixels == max',
      ),
      _MetricsRow(
        name: 'extentBefore',
        type: 'double',
        notes: 'pixels already scrolled past (pixels - min)',
      ),
      _MetricsRow(
        name: 'extentAfter',
        type: 'double',
        notes: 'pixels still below the viewport (max - pixels)',
      ),
      _MetricsRow(
        name: 'extentInside',
        type: 'double',
        notes: 'portion of the viewport filled by content',
      ),
      _MetricsRow(
        name: 'devicePixelRatio',
        type: 'double',
        notes: 'pixel density, rarely needed by calculators',
      ),
    ];

    return _SectionCard(
      title: 'ScrollMetrics reference',
      subtitle:
          'The fields available on details.metrics. A calculator that reads '
          'more than just viewportDimension is a calculator that reacts to '
          'context — ideal for "snap" behaviors.',
      child: LayoutBuilder(
        builder: (context, c) {
          final twoCols = c.maxWidth > 680;
          if (twoCols) {
            final half = (rows.length / 2).ceil();
            final left = rows.sublist(0, half);
            final right = rows.sublist(half);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _MetricsColumn(rows: left)),
                const SizedBox(width: 16),
                Expanded(child: _MetricsColumn(rows: right)),
              ],
            );
          }
          return _MetricsColumn(rows: rows);
        },
      ),
    );
  }
}

class _MetricsRow {
  final String name;
  final String type;
  final String notes;
  const _MetricsRow({
    required this.name,
    required this.type,
    required this.notes,
  });
}

class _MetricsColumn extends StatelessWidget {
  final List<_MetricsRow> rows;
  const _MetricsColumn({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final r in rows)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _paper,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _slate.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      r.name,
                      style: const TextStyle(
                        fontFamily: _mono,
                        fontSize: 13,
                        color: _slate,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _mint.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        r.type,
                        style: const TextStyle(
                          fontFamily: _mono,
                          fontSize: 11,
                          color: _ink,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  r.notes,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 12.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// 6) Formula gallery
// =============================================================================

class _FormulaGallerySection extends StatelessWidget {
  const _FormulaGallerySection();

  @override
  Widget build(BuildContext context) {
    const formulas = <_FormulaCardData>[
      _FormulaCardData(
        title: 'page-size shy-of-viewport (for ListView)',
        purpose:
            'When scrolling by page, keep one tile of overlap so users do '
            'not lose context at the boundary.',
        snippet: '''
double shyPage(ScrollIncrementDetails d, double tile) {
  if (d.type == ScrollIncrementType.line) return 50;
  return d.metrics.viewportDimension - tile;
}''',
        accent: _mint,
      ),
      _FormulaCardData(
        title: 'line that doubles at high velocity',
        purpose:
            'Combine a velocity hint (tracked elsewhere) with the default '
            'line step to accelerate auto-repeat.',
        snippet: '''
double fastLine(ScrollIncrementDetails d, double velocity) {
  if (d.type != ScrollIncrementType.line) {
    return d.metrics.viewportDimension * 0.8;
  }
  return velocity.abs() > 1200 ? 100 : 50;
}''',
        accent: _sun,
      ),
      _FormulaCardData(
        title: 'page that clamps at end-of-list',
        purpose:
            'Stop the last page from overscrolling by taking the remaining '
            'extent into account.',
        snippet: '''
double clampedPage(ScrollIncrementDetails d) {
  final m = d.metrics;
  if (d.type == ScrollIncrementType.line) return 50;
  final remaining = m.maxScrollExtent - m.pixels;
  return remaining <= 0
      ? 0
      : (m.viewportDimension * 0.8).clamp(0, remaining).toDouble();
}''',
        accent: _slate,
      ),
    ];

    return _SectionCard(
      title: 'Formula gallery',
      subtitle:
          'Three realistic incrementCalculator bodies. Each reads '
          'details.type + details.metrics and returns a double.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final f in formulas)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _FormulaCard(data: f),
            ),
        ],
      ),
    );
  }
}

class _FormulaCardData {
  final String title;
  final String purpose;
  final String snippet;
  final Color accent;
  const _FormulaCardData({
    required this.title,
    required this.purpose,
    required this.snippet,
    required this.accent,
  });
}

class _FormulaCard extends StatelessWidget {
  final _FormulaCardData data;
  const _FormulaCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _slate.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: data.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    color: _slate,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            data.purpose,
            style: const TextStyle(color: _ink, fontSize: 13, height: 1.35),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _slate,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data.snippet,
              style: TextStyle(
                fontFamily: _mono,
                color: _paper,
                fontSize: 12,
                height: 1.45,
                letterSpacing: 0.2,
                backgroundColor: _slate.withValues(alpha: 0.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 7) Teaching panel
// =============================================================================

class _TeachingPanelSection extends StatelessWidget {
  const _TeachingPanelSection();

  @override
  Widget build(BuildContext context) {
    const tiles = <_TeachingTile>[
      _TeachingTile(
        icon: Icons.keyboard_alt_outlined,
        title: 'Use incrementCalculator...',
        body:
            'when you need non-default keyboard or assistive scroll jumps — '
            'snap-to-row tables, paginated carousels, reader views with '
            'chapter-sized leaps.',
        accent: _mint,
      ),
      _TeachingTile(
        icon: Icons.rule_outlined,
        title: 'Do not fight platform norms',
        body:
            'Users expect line ≈ 50 and page ≈ viewport. Deviate with '
            'intent, not reflex. A calculator that returns 8 px per line '
            'will feel broken on every platform.',
        accent: _sun,
      ),
      _TeachingTile(
        icon: Icons.lock_outlined,
        title: 'Read-only record → one double',
        body:
            'ScrollIncrementDetails is a tiny value. Read type, read '
            'metrics, return the number of pixels to move. Keep '
            'calculators pure; do not mutate state from inside them.',
        accent: _slate,
      ),
    ];

    return _SectionCard(
      title: 'Teaching panel',
      subtitle: 'The three rules of incrementCalculator.',
      child: LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth > 820;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < tiles.length; i++) ...[
                  Expanded(child: _TeachingTileCard(tile: tiles[i])),
                  if (i < tiles.length - 1) const SizedBox(width: 12),
                ],
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final t in tiles)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _TeachingTileCard(tile: t),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TeachingTile {
  final IconData icon;
  final String title;
  final String body;
  final Color accent;
  const _TeachingTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });
}

class _TeachingTileCard extends StatelessWidget {
  final _TeachingTile tile;
  const _TeachingTileCard({required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tile.accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: tile.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(tile.icon, color: _slate, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            tile.title,
            style: const TextStyle(
              fontSize: 15,
              color: _slate,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tile.body,
            style: const TextStyle(color: _ink, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 8) Use cases strip
// =============================================================================

class _UseCasesStrip extends StatelessWidget {
  const _UseCasesStrip();

  @override
  Widget build(BuildContext context) {
    const cases = <_UseCase>[
      _UseCase(
        icon: Icons.grid_on_outlined,
        title: 'Spreadsheets',
        subtitle: 'snap to row boundaries',
        body:
            'Use line → rowHeight, page → rowHeight × visibleRows so arrows '
            'land cleanly on cell edges instead of splitting rows in two.',
        accent: _mint,
      ),
      _UseCase(
        icon: Icons.view_carousel_outlined,
        title: 'Carousels',
        subtitle: 'page → one card',
        body:
            'Return line = cardWidth / 2, page = cardWidth + gutter so '
            'PageDown always reveals exactly the next card without drift.',
        accent: _sun,
      ),
      _UseCase(
        icon: Icons.forum_outlined,
        title: 'Chat logs',
        subtitle: 'jump to message boundaries',
        body:
            'Custom calculator can snap to the nearest message by peeking '
            'at pixels + viewport and rounding to the closest bubble edge.',
        accent: _slate,
      ),
    ];

    return _SectionCard(
      title: 'Use cases',
      subtitle: 'Where a custom incrementCalculator earns its keep.',
      child: LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth > 820;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < cases.length; i++) ...[
                  Expanded(child: _UseCaseCard(useCase: cases[i])),
                  if (i < cases.length - 1) const SizedBox(width: 12),
                ],
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final u in cases)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _UseCaseCard(useCase: u),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _UseCase {
  final IconData icon;
  final String title;
  final String subtitle;
  final String body;
  final Color accent;
  const _UseCase({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.accent,
  });
}

class _UseCaseCard extends StatelessWidget {
  final _UseCase useCase;
  const _UseCaseCard({required this.useCase});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _slate,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _slate.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: useCase.accent.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(useCase.icon, color: useCase.accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      useCase.title,
                      style: const TextStyle(
                        color: _paper,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      useCase.subtitle,
                      style: TextStyle(
                        color: _paper.withValues(alpha: 0.65),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            useCase.body,
            style: TextStyle(
              color: _paper.withValues(alpha: 0.85),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 9) Footer summary card
// =============================================================================

class _FooterSummaryCard extends StatelessWidget {
  const _FooterSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _slate,
            _slate.withValues(alpha: 0.88),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'summary',
                  style: TextStyle(
                    fontFamily: _mono,
                    fontSize: 11,
                    color: _mint,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'ScrollIncrementDetails is the tiny input; your calculator is '
            'the brain; the returned double is the scroll.',
            style: TextStyle(
              color: _paper,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Grab it with Scrollable.incrementCalculator, read details.type '
            'and details.metrics, and return pixels. Respect platform '
            'defaults, make exceptions deliberately, and always keep the '
            'calculator pure.',
            style: TextStyle(
              color: _paper.withValues(alpha: 0.78),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _FooterChip(label: 'line ≈ 50', color: _mint),
              _FooterChip(label: 'page ≈ viewport × 0.8', color: _sun),
              _FooterChip(label: 'pure function', color: _paper),
              _FooterChip(label: 'read-only record', color: _paper),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final String label;
  final Color color;
  const _FooterChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: _mono,
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// =============================================================================
// Shared section card
// =============================================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _slate.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: _slate.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _slate,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: _ash, fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
