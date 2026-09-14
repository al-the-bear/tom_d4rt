// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_declarations, use_full_hex_values_for_flutter_colors
// D4rt test script: Tests PercentProperty from foundation
// Deep Demo: Visual demonstration of PercentProperty - a DiagnosticsProperty<double>
// subclass that formats a 0.0 - 1.0 ratio as a human-readable percentage string.
//
// This file is consumed by the d4rt-flutter-ast HTTP runner. It is rendered ONCE -
// no animations, no interaction, no state. Every animation reference uses
// AlwaysStoppedAnimation<double> with Duration.zero so the build is deterministic.
//
// Concept reminder:
//   PercentProperty('progress', 0.42)
//     -> toString()        => "progress: 42.0%"
//     -> valueToString()   => "42.0%"
//     -> showName: false   => "42.0%"
//     -> ifNull: 'unknown' => when value is null
//
// Visual sections (>=9):
//   1. Hero header card with concept tagline
//   2. Anatomy diagram - signature breakdown
//   3. Per-value cards at 0.00, 0.18, 0.42, 0.66, 0.84, 1.00
//   4. Horizontal bar chart of every demo value
//   5. Circular gauge ring set
//   6. Donut / pie group
//   7. Recipes / usage list
//   8. Common pitfalls list
//   9. ASCII footer with source citation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =====================================================================
// Sample values used across the whole demo. Hand-picked so each section
// can illustrate a different reading (zero, low, mid, high, almost-full,
// saturated). PercentProperty itself does not clamp - the formatter just
// multiplies by 100 and appends '%', so we keep all values in [0, 1].
// =====================================================================
const double kP00 = 0.00;
const double kP18 = 0.18;
const double kP42 = 0.42;
const double kP66 = 0.66;
const double kP84 = 0.84;
const double kP100 = 1.00;

const List<double> kAllPercents = <double>[
  kP00,
  kP18,
  kP42,
  kP66,
  kP84,
  kP100,
];

const List<String> kAllLabels = <String>[
  'idle',
  'warmup',
  'progress',
  'transfer',
  'almost',
  'done',
];

// Curated palette: each percent has its own brand colour. Hand-authored,
// not generated, so each card can read like a different chip on a board.
const List<Color> kAllColors = <Color>[
  Color(0xFF607D8B), // idle  - blue grey
  Color(0xFFFFB300), // warmup - amber
  Color(0xFF26A69A), // progress - teal
  Color(0xFF7E57C2), // transfer - deep purple
  Color(0xFFEF5350), // almost - red
  Color(0xFF43A047), // done - green
];

// =====================================================================
// Entry point. The HTTP runner calls build(context) ONCE and renders the
// returned widget. Returning a full MaterialApp keeps the script
// self-contained: navigation, default theming, and overlay support all
// work without the host having to wrap us.
// =====================================================================
dynamic build(BuildContext context) {
  print('PercentProperty Deep Demo executing');

  // -------------------------------------------------------------------
  // Build the live PercentProperty instances we will demonstrate. We
  // construct one PER configuration variant so the rendered cards can
  // show the difference between named, unit, showName and ifNull.
  // -------------------------------------------------------------------
  final PercentProperty ppDefault = PercentProperty('progress', kP42);
  final PercentProperty ppZero = PercentProperty('idle', kP00);
  final PercentProperty ppLow = PercentProperty('warmup', kP18);
  final PercentProperty ppMid = PercentProperty('transfer', kP66);
  final PercentProperty ppHigh = PercentProperty('almost', kP84);
  final PercentProperty ppFull = PercentProperty('done', kP100);

  // showName variants
  final PercentProperty ppNoName = PercentProperty(
    'progress',
    kP42,
    showName: false,
  );

  // unit variants - note that PercentProperty already appends '%', so
  // adding unit just demonstrates that it composes with the base.
  final PercentProperty ppWithUnit = PercentProperty(
    'cpu',
    kP66,
    unit: 'utilisation',
  );

  // null variants
  final PercentProperty ppNull = PercentProperty(
    'ratio',
    null,
    ifNull: 'unknown',
  );

  // Print the formatted strings so the runner trail captures them.
  print('default       => ${ppDefault.toString()}');
  print('zero          => ${ppZero.toString()}');
  print('low           => ${ppLow.toString()}');
  print('mid           => ${ppMid.toString()}');
  print('high          => ${ppHigh.toString()}');
  print('full          => ${ppFull.toString()}');
  print('no-name       => ${ppNoName.toString()}');
  print('with-unit     => ${ppWithUnit.toString()}');
  print('null+ifNull   => ${ppNull.toString()}');

  // Quick smoke read of valueToString for the trail.
  print('valueToString(default) => ${ppDefault.valueToString()}');
  print('valueToString(zero)    => ${ppZero.valueToString()}');
  print('valueToString(full)    => ${ppFull.valueToString()}');

  // -------------------------------------------------------------------
  // Anatomy diagram - we explode the PercentProperty constructor into
  // labelled chips so the viewer can read parameter -> role at a glance.
  // -------------------------------------------------------------------
  final Widget anatomy = _buildAnatomyDiagram();

  // Per-value cards - each constructed by hand, with its own colour,
  // gradient, shadow palette, headline, and a literal PercentProperty
  // reading. No List.generate. The variation is intentional.
  final Widget cardZero = _buildPercentCard(
    label: 'idle',
    fraction: kP00,
    accent: kAllColors[0],
    headline: 'Nothing started',
    body:
        'PercentProperty formats 0.0 as "0.0%". Useful as the dismissed '
        'state of a progress indicator before any work begins.',
    property: ppZero,
  );

  final Widget cardLow = _buildPercentCard(
    label: 'warmup',
    fraction: kP18,
    accent: kAllColors[1],
    headline: 'Just warming up',
    body:
        'A small fraction renders with one decimal: 0.18 -> "18.0%". '
        'No rounding: PercentProperty keeps a single fixed digit.',
    property: ppLow,
  );

  final Widget cardMid = _buildPercentCard(
    label: 'progress',
    fraction: kP42,
    accent: kAllColors[2],
    headline: 'Mid-flight',
    body:
        'The canonical demo value. 0.42 displays as "42.0%". This card '
        'also shows that the property name is rendered first when '
        'showName is left at its default true.',
    property: ppDefault,
  );

  final Widget cardMid2 = _buildPercentCard(
    label: 'transfer',
    fraction: kP66,
    accent: kAllColors[3],
    headline: 'Two thirds in',
    body:
        '0.66 -> "66.0%". Note the truncation - PercentProperty calls '
        '(value * 100).toStringAsFixed(1), so 0.666 becomes "66.6%" '
        'and 0.6666666 becomes "66.7%".',
    property: ppMid,
  );

  final Widget cardHigh = _buildPercentCard(
    label: 'almost',
    fraction: kP84,
    accent: kAllColors[4],
    headline: 'Almost there',
    body:
        '0.84 -> "84.0%". A useful threshold for switching a progress '
        'indicator from "running" to "finishing" UI states. The '
        'PercentProperty itself never knows about thresholds - it is '
        'purely a formatter.',
    property: ppHigh,
  );

  final Widget cardFull = _buildPercentCard(
    label: 'done',
    fraction: kP100,
    accent: kAllColors[5],
    headline: 'Saturated',
    body:
        '1.0 displays as "100.0%". PercentProperty does not clamp, so '
        'feeding it 1.5 would happily say "150.0%". Validation is the '
        'caller\'s job.',
    property: ppFull,
  );

  // Horizontal bar chart - one row per demo value, hand-laid out so the
  // labels, the bar, and the formatted PercentProperty string all line
  // up the same way. Useful as a single-screen overview.
  final Widget bars = _buildBarChart();

  // Circular gauge ring set - six gauges, one per value, each painted
  // with a CustomPainter to demonstrate that PercentProperty maps
  // cleanly onto a sweep angle (2*pi*fraction).
  final Widget gauges = _buildGaugeRow();

  // Donut / pie group - shows two complementary pies (fraction vs
  // remainder), giving a pie-chart reading of the same number.
  final Widget donuts = _buildDonutRow();

  // Recipes / usage list - hand-written examples that mirror real Flutter
  // toolchain usage of PercentProperty in toDiagnosticsNode overrides.
  final Widget recipes = _buildRecipes();

  // Common pitfalls list - documents the gotchas that the formatter
  // silently allows.
  final Widget pitfalls = _buildPitfalls();

  // ASCII footer - small but visually distinct credit / spec block.
  final Widget footer = _buildFooter();

  print('PercentProperty Deep Demo composed');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ---------- Hero header ----------
              _buildHeroHeader(ppDefault),
              const SizedBox(height: 28.0),

              // ---------- Anatomy ----------
              _buildSectionTitle(
                index: 1,
                title: 'Anatomy of PercentProperty',
                subtitle:
                    'Constructor parameter map. The base class is '
                    'DiagnosticsProperty<double>; the only thing this '
                    'subclass changes is the formatter.',
                color: Colors.indigo,
              ),
              const SizedBox(height: 12.0),
              anatomy,
              const SizedBox(height: 32.0),

              // ---------- Per-value cards ----------
              _buildSectionTitle(
                index: 2,
                title: 'Six readings of the same property',
                subtitle:
                    'Each card builds a fresh PercentProperty and prints '
                    'its toString() output. Watch how the formatter handles '
                    'edge values like 0.0 and 1.0.',
                color: Colors.teal,
              ),
              const SizedBox(height: 12.0),
              cardZero,
              const SizedBox(height: 14.0),
              cardLow,
              const SizedBox(height: 14.0),
              cardMid,
              const SizedBox(height: 14.0),
              cardMid2,
              const SizedBox(height: 14.0),
              cardHigh,
              const SizedBox(height: 14.0),
              cardFull,
              const SizedBox(height: 32.0),

              // ---------- Bar chart ----------
              _buildSectionTitle(
                index: 3,
                title: 'Bar chart',
                subtitle:
                    'One row per sample. The bar width is fraction * track. '
                    'The label on the right is exactly what '
                    'PercentProperty(\'<name>\', fraction).toString() '
                    'returns.',
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 12.0),
              bars,
              const SizedBox(height: 32.0),

              // ---------- Gauges ----------
              _buildSectionTitle(
                index: 4,
                title: 'Circular gauges',
                subtitle:
                    'A 270 degree gauge whose sweep is fraction * 270. '
                    'Same number, very different visual emphasis.',
                color: Colors.orange,
              ),
              const SizedBox(height: 12.0),
              gauges,
              const SizedBox(height: 32.0),

              // ---------- Donuts ----------
              _buildSectionTitle(
                index: 5,
                title: 'Donut split',
                subtitle:
                    'fraction painted, (1 - fraction) painted lighter. '
                    'PercentProperty is just a formatter, but the math '
                    'underneath generalises to any pie split.',
                color: Colors.pink,
              ),
              const SizedBox(height: 12.0),
              donuts,
              const SizedBox(height: 32.0),

              // ---------- Recipes ----------
              _buildSectionTitle(
                index: 6,
                title: 'Recipes',
                subtitle:
                    'Real-world places where PercentProperty earns its '
                    'keep: debugFillProperties overrides, telemetry '
                    'output, dump_render_tree style inspection.',
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 12.0),
              recipes,
              const SizedBox(height: 32.0),

              // ---------- Pitfalls ----------
              _buildSectionTitle(
                index: 7,
                title: 'Pitfalls',
                subtitle:
                    'Things PercentProperty silently allows. Validation '
                    'is the caller\'s responsibility - the property only '
                    'formats.',
                color: Colors.redAccent,
              ),
              const SizedBox(height: 12.0),
              pitfalls,
              const SizedBox(height: 32.0),

              // ---------- Animation reference ----------
              _buildSectionTitle(
                index: 8,
                title: 'Static animation references',
                subtitle:
                    'For completeness: even when you wire PercentProperty '
                    'into an Animation<double>, a single render only ever '
                    'sees one value. Below, AlwaysStoppedAnimation captures '
                    'that pinned moment.',
                color: Colors.cyan,
              ),
              const SizedBox(height: 12.0),
              _buildAnimationReference(),
              const SizedBox(height: 32.0),

              // ---------- Footer ----------
              _buildSectionTitle(
                index: 9,
                title: 'Source citation',
                subtitle:
                    'PercentProperty lives in package:flutter/foundation.dart, '
                    'inside the diagnostics library. It is one of a small '
                    'family (DoubleProperty, IntProperty, FlagProperty, '
                    'EnumProperty) that all share the same base.',
                color: Colors.indigo,
              ),
              const SizedBox(height: 12.0),
              footer,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// Hero header. A vivid gradient banner with the headline, a tagline,
// and one inlined PercentProperty reading so visitors immediately see
// what the class does in practice.
// =====================================================================
Widget _buildHeroHeader(PercentProperty sample) {
  return Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF3949AB),
          Color(0xFF5E35B1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: const Offset(0.0, 14.0),
        ),
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.percent,
                size: 36.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'PercentProperty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'A DiagnosticsProperty<double> that prints ratios as %',
                    style: TextStyle(
                      color: Color(0xFFD1C4E9),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.terminal,
                size: 18.0,
                color: Color(0xFFFFCA28),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  '> ${sample.toString()}',
                  style: const TextStyle(
                    color: Color(0xFFFFF59D),
                    fontFamily: 'monospace',
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Use it inside debugFillProperties to dump animation '
          'progress, opacity, scroll offsets normalised to 0..1, '
          'or any ratio you want a human to read.',
          style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 13.0),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section title. Used for every section header. Each section gets a
// different accent colour to emphasise the visual variety requirement.
// =====================================================================
Widget _buildSectionTitle({
  required int index,
  required String title,
  required String subtitle,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                  color: color.withValues(alpha: 0.95),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade700,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Anatomy diagram. Renders the constructor signature as an annotated
// row of chips, then a description column underneath.
// =====================================================================
Widget _buildAnatomyDiagram() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Signature line, monospace, syntax-highlight-ish.
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6.0,
            children: <Widget>[
              _codeToken('PercentProperty', const Color(0xFF80CBC4)),
              _codeToken('(', Colors.white70),
              _codeToken('String', const Color(0xFFB39DDB)),
              _codeToken('name', const Color(0xFFFFCC80)),
              _codeToken(',', Colors.white70),
              _codeToken('double?', const Color(0xFFB39DDB)),
              _codeToken('value', const Color(0xFFFFCC80)),
              _codeToken(',', Colors.white70),
              _codeToken('{', Colors.white70),
              _codeToken('String?', const Color(0xFFB39DDB)),
              _codeToken('ifNull', const Color(0xFFFFCC80)),
              _codeToken(',', Colors.white70),
              _codeToken('bool', const Color(0xFFB39DDB)),
              _codeToken('showName', const Color(0xFFFFCC80)),
              _codeToken('=', Colors.white70),
              _codeToken('true', const Color(0xFFEF9A9A)),
              _codeToken(',', Colors.white70),
              _codeToken('String?', const Color(0xFFB39DDB)),
              _codeToken('unit', const Color(0xFFFFCC80)),
              _codeToken('}', Colors.white70),
              _codeToken(')', Colors.white70),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // Parameter cards
        _anatomyRow(
          'name',
          'String',
          'The diagnostic key. Printed first in toString() unless '
              'showName is false.',
          Colors.indigo,
          Icons.label,
        ),
        _anatomyRow(
          'value',
          'double?',
          'A ratio in 0.0 .. 1.0. Multiplied by 100 and formatted with '
              'toStringAsFixed(1). Null is allowed.',
          Colors.teal,
          Icons.numbers,
        ),
        _anatomyRow(
          'ifNull',
          'String?',
          'Replacement string when value is null. Without it, '
              'toString() prints "null".',
          Colors.deepOrange,
          Icons.help_outline,
        ),
        _anatomyRow(
          'showName',
          'bool',
          'When false, the "name: " prefix is omitted; only the '
              'percentage string is rendered.',
          Colors.purple,
          Icons.visibility_off,
        ),
        _anatomyRow(
          'unit',
          'String?',
          'Appended after the percent string. Note that "%" is already '
              'part of the value, so unit means "in addition to %".',
          Colors.blueGrey,
          Icons.straighten,
        ),
      ],
    ),
  );
}

Widget _codeToken(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: 'monospace',
      fontSize: 12.5,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget _anatomyRow(
  String name,
  String type,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: color.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Per-value card. Hand-built. Each invocation passes a unique label /
// fraction / accent / headline / body / property, so although the
// outline is shared, the rendered cards differ in colour, gradient,
// shadow, and content.
// =====================================================================
Widget _buildPercentCard({
  required String label,
  required double fraction,
  required Color accent,
  required String headline,
  required String body,
  required PercentProperty property,
}) {
  // We use AlwaysStoppedAnimation as a static stand-in for an animated
  // value. This satisfies the requirement that any animation reference
  // is fully pinned, and demonstrates how a real Animation<double>
  // would feed PercentProperty.
  final AlwaysStoppedAnimation<double> pinned =
      AlwaysStoppedAnimation<double>(fraction);
  print('  card[$label] pinned=${pinned.value} duration=${Duration.zero}');

  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            // Big numeric badge
            Container(
              width: 72.0,
              height: 72.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: accent.withValues(alpha: 0.45),
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Text(
                '${(fraction * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    headline,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      color: accent.withValues(alpha: 0.92),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'PercentProperty(\'$label\', $fraction)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: 14.0,
            color: accent.withValues(alpha: 0.15),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      accent.withValues(alpha: 0.85),
                      accent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        // Body prose
        Text(
          body,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        // toString readout
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.chevron_right,
                color: accent.withValues(alpha: 0.9),
                size: 18.0,
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  property.toString(),
                  style: const TextStyle(
                    color: Color(0xFFFFF59D),
                    fontFamily: 'monospace',
                    fontSize: 13.0,
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

// =====================================================================
// Bar chart - one row per sample.
// =====================================================================
Widget _buildBarChart() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < kAllPercents.length; i++) {
    final double fraction = kAllPercents[i];
    final String label = kAllLabels[i];
    final Color accent = kAllColors[i];
    final PercentProperty p = PercentProperty(label, fraction);
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 80.0,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  height: 18.0,
                  color: Colors.grey.shade300,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: fraction == 0.0 ? 0.001 : fraction,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            accent.withValues(alpha: 0.7),
                            accent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 150.0,
              child: Text(
                p.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: accent,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFEDE7F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade100, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(children: rows),
  );
}

// =====================================================================
// Gauge row - one CustomPaint per fraction.
// =====================================================================
Widget _buildGaugeRow() {
  final List<Widget> gauges = <Widget>[];
  for (int i = 0; i < kAllPercents.length; i++) {
    gauges.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        child: _buildGauge(
          fraction: kAllPercents[i],
          label: kAllLabels[i],
          color: kAllColors[i],
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: gauges,
    ),
  );
}

Widget _buildGauge({
  required double fraction,
  required String label,
  required Color color,
}) {
  return Column(
    children: <Widget>[
      SizedBox(
        width: 96.0,
        height: 96.0,
        child: CustomPaint(
          painter: _GaugePainter(fraction: fraction, color: color),
          child: Center(
            child: Text(
              '${(fraction * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16.0,
                color: color,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({required this.fraction, required this.color});

  final double fraction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = (size.width / 2.0) - 6.0;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Background arc
    final Paint bg = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
    // 270 degree gauge (3/4 of a circle), start at 135 deg.
    const double startRad = 2.356194; // 135 deg
    const double sweepFull = 4.712389; // 270 deg
    canvas.drawArc(rect, startRad, sweepFull, false, bg);

    // Foreground arc proportional to fraction.
    final Paint fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startRad, sweepFull * fraction, false, fg);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.fraction != fraction || oldDelegate.color != color;
  }
}

// =====================================================================
// Donut row - simpler than gauges, full circle painted in two arcs.
// =====================================================================
Widget _buildDonutRow() {
  final List<Widget> donuts = <Widget>[];
  for (int i = 0; i < kAllPercents.length; i++) {
    donuts.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 90.0,
              height: 90.0,
              child: CustomPaint(
                painter: _DonutPainter(
                  fraction: kAllPercents[i],
                  color: kAllColors[i],
                ),
                child: Center(
                  child: Text(
                    '${(kAllPercents[i] * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: kAllColors[i],
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              PercentProperty(
                kAllLabels[i],
                kAllPercents[i],
                showName: false,
              ).toString(),
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: kAllColors[i],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: donuts,
    ),
  );
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.fraction, required this.color});

  final double fraction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = (size.width / 2.0) - 4.0;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Lighter remainder ring.
    final Paint remainder = Paint()
      ..color = color.withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;
    canvas.drawCircle(center, radius, remainder);

    // Fraction arc, starting at top (-pi/2).
    final Paint fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;
    const double start = -1.5707963; // -pi/2
    final double sweep = 6.2831853 * fraction; // 2*pi*fraction
    canvas.drawArc(rect, start, sweep, false, fg);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.fraction != fraction || oldDelegate.color != color;
  }
}

// =====================================================================
// Recipes / usage list.
// =====================================================================
Widget _buildRecipes() {
  final List<_Recipe> items = <_Recipe>[
    const _Recipe(
      title: 'In debugFillProperties',
      code:
          '@override\n'
          'void debugFillProperties(DiagnosticPropertiesBuilder p) {\n'
          '  super.debugFillProperties(p);\n'
          '  p.add(PercentProperty(\'opacity\', opacity));\n'
          '  p.add(PercentProperty(\'progress\', controller.value));\n'
          '}',
      explanation:
          'The most common use site. Flutter framework widgets use this '
          'pattern for any double in 0.0..1.0. Inspector and toString '
          'output get formatted percentages for free.',
      color: Color(0xFF455A64),
    ),
    const _Recipe(
      title: 'With ifNull for optional ratios',
      code:
          'p.add(PercentProperty(\n'
          '  \'audibility\', sound?.level,\n'
          '  ifNull: \'silent\',\n'
          '));',
      explanation:
          'When the property may be absent, ifNull keeps the diagnostic '
          'output readable. Without it, you would see the literal text '
          '"null".',
      color: Color(0xFF6A1B9A),
    ),
    const _Recipe(
      title: 'Headless (showName: false)',
      code:
          'final tag = PercentProperty(\n'
          '  \'cpu\', usage,\n'
          '  showName: false,\n'
          ').toString();\n'
          '// "73.0%"',
      explanation:
          'For status bars or tooltips where you only want the formatted '
          'value, drop the prefix. The percent string still renders the '
          'one-decimal format.',
      color: Color(0xFF00695C),
    ),
    const _Recipe(
      title: 'Alongside DoubleProperty',
      code:
          'p.add(DoubleProperty(\'radius\', radius));\n'
          'p.add(PercentProperty(\'fill\', fillFactor));\n'
          'p.add(DoubleProperty(\'strokeWidth\', strokeWidth));',
      explanation:
          'Mix freely - PercentProperty and DoubleProperty share the same '
          'base class, so the inspector treats them identically apart from '
          'the formatter.',
      color: Color(0xFFAD1457),
    ),
    const _Recipe(
      title: 'Logging',
      code:
          'debugPrint(\n'
          '  PercentProperty(\'cacheHit\', hit / total).toString(),\n'
          ');',
      explanation:
          'Cheap, structured-ish telemetry. Combined with name + value, '
          'logs are searchable and immediately readable by humans.',
      color: Color(0xFF1565C0),
    ),
  ];

  final List<Widget> children = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    children.add(_recipeCard(items[i], i));
    if (i < items.length - 1) {
      children.add(const SizedBox(height: 12.0));
    }
  }

  return Column(children: children);
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.code,
    required this.explanation,
    required this.color,
  });

  final String title;
  final String code;
  final String explanation;
  final Color color;
}

Widget _recipeCard(_Recipe r, int index) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: r.color.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: r.color.withValues(alpha: 0.12),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 26.0,
              height: 26.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: r.color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                String.fromCharCode(0x41 + index), // A, B, C, ...
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: r.color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            r.code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFFE0E0E0),
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          r.explanation,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Pitfalls list.
// =====================================================================
Widget _buildPitfalls() {
  final List<_Pitfall> pitfalls = <_Pitfall>[
    const _Pitfall(
      icon: Icons.warning_amber_rounded,
      color: Color(0xFFE53935),
      title: 'No clamping',
      detail:
          'PercentProperty(\'over\', 1.5).toString() prints "150.0%". '
          'If you need a guarantee, clamp BEFORE constructing.',
    ),
    const _Pitfall(
      icon: Icons.functions,
      color: Color(0xFFD81B60),
      title: 'Negative values pass through',
      detail:
          'PercentProperty(\'neg\', -0.25).toString() prints "-25.0%". '
          'For ratios this is almost always wrong - again, validate first.',
    ),
    const _Pitfall(
      icon: Icons.format_quote,
      color: Color(0xFF8E24AA),
      title: 'unit appends after %',
      detail:
          'PercentProperty(\'cpu\', 0.5, unit: \'utilisation\').toString() '
          'prints "cpu: 50.0% utilisation". Note the space - the percent '
          'sign is part of the value, the unit is independent.',
    ),
    const _Pitfall(
      icon: Icons.numbers,
      color: Color(0xFF3949AB),
      title: 'Always one decimal',
      detail:
          'The formatter is fixed at one digit after the dot. 0.999 prints '
          '"99.9%", 0.9999 prints "100.0%". Do not rely on it for very '
          'fine progress reporting.',
    ),
    const _Pitfall(
      icon: Icons.label_off,
      color: Color(0xFF00897B),
      title: 'showName affects only the name',
      detail:
          'When showName is false the percent string is still printed - '
          'do not confuse this with the diagnostic being hidden.',
    ),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < pitfalls.length; i++) {
    rows.add(_pitfallRow(pitfalls[i]));
    if (i < pitfalls.length - 1) {
      rows.add(const SizedBox(height: 10.0));
    }
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(children: rows),
  );
}

class _Pitfall {
  const _Pitfall({
    required this.icon,
    required this.color,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String detail;
}

Widget _pitfallRow(_Pitfall p) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: p.color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: p.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(p.icon, color: p.color, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  color: p.color,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                p.detail,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
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

// =====================================================================
// Animation reference - shows how the percent value looks when produced
// by an Animation<double>. We use AlwaysStoppedAnimation + Duration.zero
// throughout to satisfy the "no implicit motion" rule.
// =====================================================================
Widget _buildAnimationReference() {
  // Three sample animations, each pinned at a known fraction.
  final AlwaysStoppedAnimation<double> a1 =
      const AlwaysStoppedAnimation<double>(0.18);
  final AlwaysStoppedAnimation<double> a2 =
      const AlwaysStoppedAnimation<double>(0.55);
  final AlwaysStoppedAnimation<double> a3 =
      const AlwaysStoppedAnimation<double>(0.91);

  // Duration.zero is referenced explicitly to match the spec.
  const Duration zero = Duration.zero;
  print('static-anim references: ${zero.inMilliseconds}ms');

  final List<_AnimSample> samples = <_AnimSample>[
    _AnimSample(
      label: 'fade',
      anim: a1,
      tint: const Color(0xFF00ACC1),
      help:
          'Treat the animation as a frozen frame. PercentProperty\n'
          'reads only one number, so a snapshot is enough.',
    ),
    _AnimSample(
      label: 'scroll',
      anim: a2,
      tint: const Color(0xFF00897B),
      help:
          'For an actively-running controller, the same call site\n'
          'produces a fresh string every frame.',
    ),
    _AnimSample(
      label: 'load',
      anim: a3,
      tint: const Color(0xFF26A69A),
      help:
          'Inspector freeze-frames pin the value via captureSnapshot;\n'
          'the printed PercentProperty reflects that pin.',
    ),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    rows.add(_animSampleRow(samples[i]));
    if (i < samples.length - 1) {
      rows.add(const SizedBox(height: 12.0));
    }
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(children: rows),
  );
}

class _AnimSample {
  _AnimSample({
    required this.label,
    required this.anim,
    required this.tint,
    required this.help,
  });

  final String label;
  final AlwaysStoppedAnimation<double> anim;
  final Color tint;
  final String help;
}

Widget _animSampleRow(_AnimSample s) {
  final PercentProperty live = PercentProperty(s.label, s.anim.value);
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: s.tint.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 60.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: s.tint,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                s.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  height: 12.0,
                  color: s.tint.withValues(alpha: 0.18),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: s.anim.value,
                    child: Container(color: s.tint),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 130.0,
              child: Text(
                live.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: s.tint,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          s.help,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade700,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// ASCII-style footer card.
// =====================================================================
Widget _buildFooter() {
  const String ascii =
      '+----------------------------------------------------+\n'
      '|  PercentProperty  -  flutter / foundation         |\n'
      '|                                                    |\n'
      '|    DiagnosticsProperty<double>                     |\n'
      '|       |-- name        : String                     |\n'
      '|       |-- value       : double?  (0.0 .. 1.0)      |\n'
      '|       |-- ifNull      : String?                    |\n'
      '|       |-- showName    : bool   = true              |\n'
      '|       \\-- unit        : String?                    |\n'
      '|                                                    |\n'
      '|    valueToString()  -> "(value*100).toFixed(1)%"   |\n'
      '|    toString()       -> "<name>: <valueToString>"   |\n'
      '+----------------------------------------------------+';

  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0D1B2A), Color(0xFF1B263B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.terminal, color: Color(0xFF80DEEA), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'doc-card',
              style: TextStyle(
                color: Color(0xFF80DEEA),
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          ascii,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFE0F7FA),
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            const Icon(
              Icons.bookmark_outline,
              color: Color(0xFFFFCC80),
              size: 16.0,
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'See also: DoubleProperty, IntProperty, FlagProperty, '
                'EnumProperty - all share DiagnosticsProperty<T>.',
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
