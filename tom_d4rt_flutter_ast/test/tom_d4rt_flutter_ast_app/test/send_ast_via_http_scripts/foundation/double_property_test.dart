// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of DoubleProperty from package:flutter/foundation.dart
// DoubleProperty is a DiagnosticsProperty<double> with optional unit, formatting,
// and lazy evaluation. It extends _NumProperty<double> and uses debugFormatDouble.
// Constructors:
//   - DoubleProperty(name, value, {ifNull, unit, tooltip, defaultValue, showName, style, level})
//   - DoubleProperty.lazy(name, computeValue, {ifNull, showName, unit, tooltip, defaultValue, level})
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Static motion only: AlwaysStoppedAnimation + Duration.zero
  // ============================================================
  final AlwaysStoppedAnimation<double> staticPulse =
      AlwaysStoppedAnimation<double>(0.0);
  final Duration noMotion = Duration.zero;

  // ============================================================
  // SECTION 0: Build canonical DoubleProperty samples
  // ============================================================
  final DoubleProperty heroProp = DoubleProperty(
    'opacity',
    0.875,
    unit: '%',
    tooltip: 'Alpha channel multiplier in [0..1]',
  );

  final DoubleProperty namedProp = DoubleProperty('width', 320.0, unit: 'px');
  final DoubleProperty defaultedProp =
      DoubleProperty('scale', 1.0, defaultValue: 1.0);
  final DoubleProperty nullProp =
      DoubleProperty('height', null, ifNull: 'unbounded');
  final DoubleProperty hiddenNameProp =
      DoubleProperty('density', 2.5, showName: false);
  final DoubleProperty fineProp =
      DoubleProperty('debugValue', 1.0e-9, level: DiagnosticLevel.fine);
  final DoubleProperty errorProp = DoubleProperty(
    'corruption',
    double.nan,
    ifNull: '<unset>',
    level: DiagnosticLevel.error,
  );
  final DoubleProperty infiniteProp = DoubleProperty(
    'limit',
    double.infinity,
    unit: 'px',
  );
  final DoubleProperty negInfProp = DoubleProperty(
    'lowerBound',
    double.negativeInfinity,
    unit: 'px',
  );
  final DoubleProperty zeroProp = DoubleProperty('offset', 0.0, unit: 'dp');

  final DoubleProperty lazyOk = DoubleProperty.lazy(
    'lazyComputed',
    () => 42.42,
    unit: 'units',
    tooltip: 'Evaluated lazily on demand',
  );

  // Demonstrate that .lazy can shield the inspector from heavy work; when
  // the level is fine it may be elided entirely.
  final DoubleProperty lazyFine = DoubleProperty.lazy(
    'lazyDeep',
    () => 3.1415926535,
    level: DiagnosticLevel.fine,
    unit: 'rad',
  );

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final Widget hero = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF512DA8),
          Color(0xFFAD1457),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 60.0,
          offset: Offset(0.0, 30.0),
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
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: Icon(
                Icons.linear_scale,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DoubleProperty',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'A DiagnosticsProperty<double> with optional unit, ifNull, tooltip,\n'
          'defaultValue, showName, level, and a .lazy() factory.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _heroPill('toString', heroProp.toString()),
            SizedBox(width: 8.0),
            _heroPill('isFiltered(info)',
                heroProp.isFiltered(DiagnosticLevel.info).toString()),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a DoubleProperty
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a DoubleProperty',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            "DoubleProperty(\n"
            "  'opacity',          // name (positional)\n"
            "  0.875,              // value (positional, double?)\n"
            "  ifNull: 'unset',    // text when value == null\n"
            "  unit: '%',          // suffix unit string\n"
            "  tooltip: '...',     // hover help text\n"
            "  defaultValue: 1.0,  // hide if value matches\n"
            "  showName: true,     // include 'opacity:' prefix\n"
            "  level: DiagnosticLevel.info,\n"
            ")",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent.shade100,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _anatomyChip('name', Icons.label_outline, Colors.indigo),
            _anatomyChip('value', Icons.numbers, Colors.deepPurple),
            _anatomyChip('unit', Icons.straighten, Colors.teal),
            _anatomyChip('ifNull', Icons.block, Colors.red),
            _anatomyChip('tooltip', Icons.info_outline, Colors.amber.shade700),
            _anatomyChip('defaultValue', Icons.flag, Colors.green),
            _anatomyChip('showName', Icons.visibility, Colors.blue),
            _anatomyChip('level', Icons.tune, Colors.pink),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-parameter cards (name, value, ifNull, tooltip,
  //                                 unit, showName, defaultValue, level)
  // ============================================================
  final List<Widget> parameterCards = <Widget>[
    _parameterCard(
      title: 'name',
      icon: Icons.label_outline,
      accent: Colors.indigo,
      summary: 'Required positional. Identifies the property in dumps.',
      examples: <_PropExample>[
        _PropExample(
          label: "DoubleProperty('width', 320.0)",
          property: DoubleProperty('width', 320.0),
        ),
        _PropExample(
          label: "DoubleProperty('height', 240.0)",
          property: DoubleProperty('height', 240.0),
        ),
        _PropExample(
          label: "DoubleProperty('alpha', 0.5)",
          property: DoubleProperty('alpha', 0.5),
        ),
      ],
    ),
    _parameterCard(
      title: 'value',
      icon: Icons.numbers,
      accent: Colors.deepPurple,
      summary:
          'The double? rendered via debugFormatDouble. Handles NaN / +inf / -inf / 0 / fractional / integral.',
      examples: <_PropExample>[
        _PropExample(
          label: "value = 0.0",
          property: DoubleProperty('zero', 0.0),
        ),
        _PropExample(
          label: "value = 12.5",
          property: DoubleProperty('frac', 12.5),
        ),
        _PropExample(
          label: "value = double.nan",
          property: DoubleProperty('nan', double.nan),
        ),
        _PropExample(
          label: "value = double.infinity",
          property: DoubleProperty('inf', double.infinity),
        ),
        _PropExample(
          label: "value = double.negativeInfinity",
          property: DoubleProperty('-inf', double.negativeInfinity),
        ),
        _PropExample(
          label: "value = 1.0e-9",
          property: DoubleProperty('tiny', 1.0e-9),
        ),
      ],
    ),
    _parameterCard(
      title: 'defaultValue',
      icon: Icons.flag,
      accent: Colors.green,
      summary:
          'When value equals defaultValue the property is filtered (hidden) at info level.',
      examples: <_PropExample>[
        _PropExample(
          label: 'defaultValue: 1.0, value: 1.0  (filtered)',
          property: DoubleProperty('scale', 1.0, defaultValue: 1.0),
        ),
        _PropExample(
          label: 'defaultValue: 1.0, value: 2.0  (visible)',
          property: DoubleProperty('scale', 2.0, defaultValue: 1.0),
        ),
        _PropExample(
          label: 'defaultValue: 0.0, value: 0.0  (filtered)',
          property: DoubleProperty('offset', 0.0, defaultValue: 0.0),
        ),
      ],
    ),
    _parameterCard(
      title: 'ifNull',
      icon: Icons.block,
      accent: Colors.red,
      summary: 'Replacement string when value is null.',
      examples: <_PropExample>[
        _PropExample(
          label: "value: null, ifNull: 'unbounded'",
          property: DoubleProperty('height', null, ifNull: 'unbounded'),
        ),
        _PropExample(
          label: "value: null, ifNull: '<unset>'",
          property: DoubleProperty('alpha', null, ifNull: '<unset>'),
        ),
        _PropExample(
          label: "value: null, no ifNull (default 'null')",
          property: DoubleProperty('weight', null),
        ),
      ],
    ),
    _parameterCard(
      title: 'tooltip',
      icon: Icons.info_outline,
      accent: Colors.amber.shade700,
      summary: 'Optional help string shown beside the property in inspectors.',
      examples: <_PropExample>[
        _PropExample(
          label: "tooltip: 'fraction in [0..1]'",
          property: DoubleProperty('opacity', 0.5,
              tooltip: 'fraction in [0..1]'),
        ),
        _PropExample(
          label: "tooltip: 'logical pixels'",
          property:
              DoubleProperty('size', 24.0, tooltip: 'logical pixels'),
        ),
        _PropExample(
          label: "no tooltip",
          property: DoubleProperty('plain', 9.0),
        ),
      ],
    ),
    _parameterCard(
      title: 'unit',
      icon: Icons.straighten,
      accent: Colors.teal,
      summary: 'Suffix appended to formatted value (px, %, ms, dp, rad, ...).',
      examples: <_PropExample>[
        _PropExample(
          label: "unit: 'px'",
          property: DoubleProperty('width', 320.0, unit: 'px'),
        ),
        _PropExample(
          label: "unit: '%'",
          property: DoubleProperty('opacity', 0.875, unit: '%'),
        ),
        _PropExample(
          label: "unit: 'ms'",
          property: DoubleProperty('duration', 16.7, unit: 'ms'),
        ),
        _PropExample(
          label: "unit: 'rad'",
          property: DoubleProperty('rotation', 1.5708, unit: 'rad'),
        ),
        _PropExample(
          label: "unit: 'dp'",
          property: DoubleProperty('elevation', 8.0, unit: 'dp'),
        ),
      ],
    ),
    _parameterCard(
      title: 'showName',
      icon: Icons.visibility,
      accent: Colors.blue,
      summary:
          'When false, the leading "name:" prefix is omitted. Useful for inline values.',
      examples: <_PropExample>[
        _PropExample(
          label: 'showName: true (default)',
          property:
              DoubleProperty('density', 2.5, showName: true),
        ),
        _PropExample(
          label: 'showName: false',
          property:
              DoubleProperty('density', 2.5, showName: false),
        ),
        _PropExample(
          label: 'showName: false + unit',
          property: DoubleProperty('width', 320.0,
              showName: false, unit: 'px'),
        ),
      ],
    ),
    _parameterCard(
      title: 'level',
      icon: Icons.tune,
      accent: Colors.pink,
      summary:
          'DiagnosticLevel controls visibility. info is default; fine/debug/hidden trim noise; warning/error highlight.',
      examples: <_PropExample>[
        _PropExample(
          label: 'level: DiagnosticLevel.info',
          property: DoubleProperty('a', 1.1, level: DiagnosticLevel.info),
        ),
        _PropExample(
          label: 'level: DiagnosticLevel.fine',
          property: DoubleProperty('b', 2.2, level: DiagnosticLevel.fine),
        ),
        _PropExample(
          label: 'level: DiagnosticLevel.debug',
          property:
              DoubleProperty('c', 3.3, level: DiagnosticLevel.debug),
        ),
        _PropExample(
          label: 'level: DiagnosticLevel.warning',
          property: DoubleProperty('d', 4.4,
              level: DiagnosticLevel.warning),
        ),
        _PropExample(
          label: 'level: DiagnosticLevel.error',
          property:
              DoubleProperty('e', 5.5, level: DiagnosticLevel.error),
        ),
      ],
    ),
  ];

  // ============================================================
  // SECTION 4: Lazy factory recipe
  // ============================================================
  final Widget lazyRecipe = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt,
                color: Colors.deepOrange.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'DoubleProperty.lazy',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Use .lazy when the value is expensive to compute or may throw.\n'
          'The compute closure runs only when the value is actually rendered.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.brown.shade800,
            height: 1.5,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.brown.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            "DoubleProperty.lazy(\n"
            "  'lazyComputed',\n"
            "  () => expensiveCompute(),  // ComputePropertyValueCallback<double>\n"
            "  ifNull: '<failed>',\n"
            "  showName: true,\n"
            "  unit: 'units',\n"
            "  tooltip: 'evaluated lazily',\n"
            "  defaultValue: kNoDefaultValue,\n"
            "  level: DiagnosticLevel.fine,\n"
            ")",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.amberAccent.shade100,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _renderProperty(lazyOk, accent: Colors.deepOrange),
        _renderProperty(lazyFine, accent: Colors.amber.shade800),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Diagnostics dump recipes
  // ============================================================
  final List<DoubleProperty> dumpProps = <DoubleProperty>[
    namedProp,
    heroProp,
    defaultedProp,
    nullProp,
    hiddenNameProp,
    fineProp,
    errorProp,
    infiniteProp,
    negInfProp,
    zeroProp,
    lazyOk,
  ];

  final Widget dumpRecipes = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Color(0xFF263238)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal,
                color: Colors.greenAccent.shade400, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Diagnostics dump preview',
              style: TextStyle(
                color: Colors.greenAccent.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final DoubleProperty p in dumpProps)
          Padding(
            padding: EdgeInsets.only(bottom: 6.0),
            child: Text(
              '  ${p.toString()}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.lightGreenAccent.shade200,
              ),
            ),
          ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
                color: Colors.greenAccent.withValues(alpha: 0.3),
                width: 1.0),
          ),
          child: Text(
            '// dumpProps.forEach((p) => print(p.toString()));',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Pitfalls
  // ============================================================
  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade800, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallEntry(
          'NaN values',
          'NaN is rendered through debugFormatDouble. Equality with NaN is '
              'false, so a defaultValue of double.nan never filters anything.',
          Icons.do_disturb_alt,
        ),
        _pitfallEntry(
          'Null + missing ifNull',
          'When value is null and ifNull is null too, the property is shown '
              'with the literal "null" — usually unhelpful. Provide ifNull.',
          Icons.help_outline,
        ),
        _pitfallEntry(
          'lazy + thrown exceptions',
          'If the compute callback throws, the value is captured as the '
              'thrown error string. Prefer wrapping in try / fallback.',
          Icons.bolt,
        ),
        _pitfallEntry(
          'level: hidden',
          'Hidden properties are filtered out of toString completely. Use '
              'fine for muted-but-inspectable diagnostics instead.',
          Icons.visibility_off,
        ),
        _pitfallEntry(
          'Unit string trust',
          'unit is a free-form suffix; nothing converts your value. Make '
              'sure stored value already matches the unit you advertise.',
          Icons.straighten,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison with related Property classes
  // ============================================================
  final Widget comparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.16),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows,
                color: Colors.indigo.shade700, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Related Property classes',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _comparisonRow(
          'DoubleProperty',
          'double? + unit, formatted by debugFormatDouble',
          Icons.linear_scale,
          Colors.deepPurple,
          isHighlighted: true,
        ),
        _comparisonRow(
          'IntProperty',
          'int? + unit, no fractional formatting',
          Icons.pin,
          Colors.indigo,
        ),
        _comparisonRow(
          'PercentProperty',
          'extends DoubleProperty; clamps [0..1] and renders as %',
          Icons.percent,
          Colors.teal,
        ),
        _comparisonRow(
          'StringProperty',
          'String? value with optional quoting',
          Icons.text_fields,
          Colors.brown,
        ),
        _comparisonRow(
          'FlagProperty',
          'bool flag with ifTrue / ifFalse phrasing',
          Icons.flag,
          Colors.pink,
        ),
        _comparisonRow(
          'EnumProperty',
          'enum value rendered by .name',
          Icons.list_alt,
          Colors.green,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Quick reference
  // ============================================================
  final Widget quickRef = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.green.shade300, width: 1.3),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book,
                color: Colors.green.shade800, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _quickRow('Library', 'package:flutter/foundation.dart'),
        _quickRow('Extends', '_NumProperty<double>'),
        _quickRow('Default level', 'DiagnosticLevel.info'),
        _quickRow('Default style', 'DiagnosticsTreeStyle.singleLine'),
        _quickRow('Filter when', 'value == defaultValue (and not kNoDefault)'),
        _quickRow('Number format', 'debugFormatDouble(value)'),
        _quickRow('Lazy form', 'DoubleProperty.lazy(name, () => v, ...)'),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '+--------------------------------------------+\n'
          '|             DoubleProperty                 |\n'
          '|  name : value [unit]   (if !=  defaultValue)|\n'
          '|  null  -> ifNull                            |\n'
          '|  lazy  -> compute on demand                 |\n'
          '|  level -> info | fine | debug | warn | err  |\n'
          '+--------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade400,
            height: 1.35,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.greenAccent.withValues(alpha: 0.7),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'static motion: ${staticPulse.value} / Duration.zero=$noMotion',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Compose the page
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            _sectionTitle('1. Anatomy'),
            anatomy,
            _sectionTitle('2. Parameter cards'),
            ...parameterCards,
            _sectionTitle('3. Lazy factory recipe'),
            lazyRecipe,
            _sectionTitle('4. Diagnostics dump recipes'),
            dumpRecipes,
            _sectionTitle('5. Pitfalls'),
            pitfalls,
            _sectionTitle('6. Related Property classes'),
            comparison,
            _sectionTitle('7. Quick reference'),
            quickRef,
            _sectionTitle('8. ASCII footer'),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
// Helpers
// ===========================================================================

class _PropExample {
  _PropExample({required this.label, required this.property});
  final String label;
  final DoubleProperty property;
}

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 6.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
        color: Colors.indigo.shade900,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _heroPill(String key, String value) {
  return Flexible(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$key:',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white70,
            ),
          ),
          SizedBox(width: 6.0),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _anatomyChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _parameterCard({
  required String title,
  required IconData icon,
  required Color accent,
  required String summary,
  required List<_PropExample> examples,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.06),
          accent.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: accent, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                color: accent,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          summary,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black87,
            height: 1.45,
          ),
        ),
        SizedBox(height: 12.0),
        for (final _PropExample ex in examples)
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: accent.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ex.label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.0),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    '> ${ex.property.toString()}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    _miniBadge(
                      'isFiltered(info)=${ex.property.isFiltered(DiagnosticLevel.info)}',
                      Colors.indigo,
                    ),
                    SizedBox(width: 6.0),
                    _miniBadge(
                      'level=${ex.property.level.name}',
                      Colors.teal,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _miniBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9.5,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _renderProperty(DoubleProperty p, {required Color accent}) {
  return Container(
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.arrow_right, color: accent, size: 18.0),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            p.toString(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallEntry(String title, String body, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.red.shade600, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.brown.shade900,
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

Widget _comparisonRow(
  String name,
  String desc,
  IconData icon,
  Color color, {
  bool isHighlighted = false,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isHighlighted
          ? color.withValues(alpha: 0.18)
          : Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: isHighlighted ? 0.7 : 0.3),
        width: isHighlighted ? 2.0 : 1.0,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        if (isHighlighted)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'THIS',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _quickRow(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.green.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}
