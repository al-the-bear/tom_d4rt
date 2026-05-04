// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for ColorProperty (foundation diagnostics)
// Demonstrates ColorProperty construction, defaultValue collapsing, ifNull
// fallback, DiagnosticLevel variants, swatch grid, anatomy diagram and
// comparison vs DiagnosticsProperty<Color>.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorProperty Deep Demo executing');

  // ============================================================
  // SECTION 1: Header & Conceptual Introduction
  // ============================================================
  print('=== Section 1: Conceptual Introduction ===');

  final introCard = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
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
            Icon(Icons.palette, size: 32.0, color: Colors.indigo.shade700),
            SizedBox(width: 10.0),
            Text(
              'ColorProperty',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'A specialised DiagnosticsProperty<Color> that stringifies '
          'a Color to its hex form (e.g. Color(0xff42a5f5)) for use in '
          'debugFillProperties() / toStringDeep() output of widgets and '
          'render objects.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.indigo.shade900,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ColorProperty(String name, Color? value, {showName, '
            'defaultValue, style, level})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created intro card');

  // ============================================================
  // SECTION 2: Basic ColorProperty Examples + Visual Swatch
  // ============================================================
  print('=== Section 2: Basic Construction ===');

  final basicSamples = <_Sample>[
    _Sample('primary', Colors.blue, 'Solid material primary'),
    _Sample('accent', Colors.orange, 'Solid accent'),
    _Sample('background', Color(0xFFF5F5F5), 'Custom hex (light grey)'),
    _Sample('overlay', Color(0x80000000), 'Semi-transparent black 50%'),
    _Sample('clear', Color(0x00000000), 'Fully transparent'),
    _Sample('brand', Color(0xFF6A1B9A), 'Custom hex (purple)'),
  ];

  final basicCards = <Widget>[];
  for (final s in basicSamples) {
    final prop = ColorProperty(s.name, s.color);
    print('Basic: name=${prop.name} value=${prop.value}');
    basicCards.add(_buildPropertyCard(prop, s.description, s.color));
  }
  print('Created ${basicCards.length} basic property cards');

  // ============================================================
  // SECTION 3: ifNull Fallback Demonstration
  // ============================================================
  print('=== Section 3: ifNull Fallback ===');

  // ColorProperty itself does not expose `ifNull` in its constructor; the
  // behaviour is inherited from DiagnosticsProperty<Color>. We demonstrate
  // the parent's `ifNull` here using DiagnosticsProperty<Color>, since
  // ColorProperty IS-A DiagnosticsProperty<Color>.
  final ifNullProp =
      DiagnosticsProperty<Color>('tint', null, ifNull: '<unset>');
  final ifNullProp2 = DiagnosticsProperty<Color>(
    'shadow',
    null,
    ifNull: '(none provided)',
  );
  final ifNullProp3 =
      DiagnosticsProperty<Color>('cursor', null, ifNull: 'default');
  print('ifNull tint: name=${ifNullProp.name} value=${ifNullProp.value}');
  print('ifNull shadow: ${ifNullProp2.name}');
  print('ifNull cursor: ${ifNullProp3.name}');

  final ifNullSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ifNull fallback',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'When value is literally null, the property prints the ifNull '
          'string instead of "null".',
          style: TextStyle(fontSize: 12.0, color: Colors.orange.shade900),
        ),
        SizedBox(height: 12.0),
        _buildIfNullRow(ifNullProp, '<unset>'),
        SizedBox(height: 8.0),
        _buildIfNullRow(ifNullProp2, '(none provided)'),
        SizedBox(height: 8.0),
        _buildIfNullRow(ifNullProp3, 'default'),
      ],
    ),
  );
  print('Created ifNull section');

  // ============================================================
  // SECTION 4: defaultValue Collapsing
  // ============================================================
  print('=== Section 4: defaultValue Collapsing ===');

  final defaultProp = ColorProperty(
    'color',
    Colors.red,
    defaultValue: Colors.red,
  );
  final nonDefaultProp = ColorProperty(
    'color',
    Colors.blue,
    defaultValue: Colors.red,
  );
  print('defaultProp value=${defaultProp.value} matches default');
  print('nonDefaultProp value=${nonDefaultProp.value} differs from default');

  final defaultValueSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'defaultValue collapsing',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'When value == defaultValue, the diagnostics output marks the '
          'property as "default", letting tooling collapse it from view.',
          style: TextStyle(fontSize: 12.0, color: Colors.teal.shade900),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildDefaultValuePanel(
                'Matches default',
                defaultProp,
                Colors.red,
                Colors.red,
                true,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildDefaultValuePanel(
                'Differs from default',
                nonDefaultProp,
                Colors.blue,
                Colors.red,
                false,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created defaultValue section');

  // ============================================================
  // SECTION 5: DiagnosticLevel Variants
  // ============================================================
  print('=== Section 5: DiagnosticLevel Variants ===');

  final levels = <_LevelEntry>[
    _LevelEntry(
      DiagnosticLevel.hidden,
      Colors.grey,
      Icons.visibility_off,
      'Suppressed unless explicitly requested.',
    ),
    _LevelEntry(
      DiagnosticLevel.fine,
      Colors.lightBlue,
      Icons.bubble_chart,
      'Fine-grained, only shown at verbose level.',
    ),
    _LevelEntry(
      DiagnosticLevel.debug,
      Colors.cyan,
      Icons.bug_report,
      'Debug-level, shown in debug builds.',
    ),
    _LevelEntry(
      DiagnosticLevel.info,
      Colors.green,
      Icons.info,
      'Default level, regular property output.',
    ),
    _LevelEntry(
      DiagnosticLevel.warning,
      Colors.orange,
      Icons.warning_amber,
      'Highlighted as a warning in tooling.',
    ),
    _LevelEntry(
      DiagnosticLevel.error,
      Colors.red,
      Icons.error,
      'Highlighted as an error in tooling.',
    ),
  ];

  final levelCards = <Widget>[];
  for (final entry in levels) {
    final prop = ColorProperty(
      'tint',
      Colors.deepPurple,
      level: entry.level,
    );
    print('Level ${entry.level.name}: ${prop.name} -> ${prop.value}');
    levelCards.add(_buildLevelCard(entry, prop));
  }
  print('Created ${levelCards.length} level cards');

  // ============================================================
  // SECTION 6: Swatch Grid (12 colors with ColorProperty strings)
  // ============================================================
  print('=== Section 6: Swatch Grid ===');

  final swatchEntries = <_SwatchEntry>[
    _SwatchEntry('red100', Colors.red.shade100),
    _SwatchEntry('red500', Colors.red.shade500),
    _SwatchEntry('red900', Colors.red.shade900),
    _SwatchEntry('blue100', Colors.blue.shade100),
    _SwatchEntry('blue500', Colors.blue.shade500),
    _SwatchEntry('blue900', Colors.blue.shade900),
    _SwatchEntry('green100', Colors.green.shade100),
    _SwatchEntry('green500', Colors.green.shade500),
    _SwatchEntry('green900', Colors.green.shade900),
    _SwatchEntry('amber300', Colors.amber.shade300),
    _SwatchEntry('purple700', Colors.purple.shade700),
    _SwatchEntry('teal500', Colors.teal.shade500),
  ];

  final swatchCells = <Widget>[];
  for (final e in swatchEntries) {
    final prop = ColorProperty(e.name, e.color);
    print('Swatch ${e.name} -> ${prop.value}');
    swatchCells.add(_buildSwatchCell(prop, e.color));
  }
  print('Created ${swatchCells.length} swatch cells');

  // ============================================================
  // SECTION 7: Anatomy Diagram
  // ============================================================
  print('=== Section 7: Anatomy Diagram ===');

  final anatomyProp = ColorProperty(
    'background',
    Color(0xFF42A5F5),
    defaultValue: Color(0xFFFFFFFF),
    showName: true,
    level: DiagnosticLevel.info,
  );
  print('Anatomy property name=${anatomyProp.name} value=${anatomyProp.value}');

  final anatomyDiagram = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy: ColorProperty constructor',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
          ),
          child: Text(
            'ColorProperty(\n'
            '  "background",          // name\n'
            '  Color(0xFF42A5F5),     // value\n'
            '  defaultValue: Color(0xFFFFFFFF),\n'
            '  ifNull: "<unset>",\n'
            '  showName: true,\n'
            '  level: DiagnosticLevel.info,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.blueGrey.shade900,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _buildAnatomyRow('name', '"background"', 'Property name shown in output',
            Colors.indigo),
        _buildAnatomyRow('value', 'Color(0xFF42A5F5)',
            'Concrete color value, may be null', Colors.blue),
        _buildAnatomyRow('defaultValue', 'Color(0xFFFFFFFF)',
            'Compared with == to mark as default', Colors.teal),
        _buildAnatomyRow('ifNull*', '"<unset>"',
            'Inherited from DiagnosticsProperty — ColorProperty does not '
                're-expose it; create the parent type when needed.',
            Colors.amber),
        _buildAnatomyRow(
            'showName', 'true', 'Print "name: value" or just "value"',
            Colors.green),
        _buildAnatomyRow('level', 'DiagnosticLevel.info',
            'Verbosity / severity classification', Colors.deepPurple),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 8: Use-cases & Code Examples
  // ============================================================
  print('=== Section 8: Use Cases ===');

  final useCases = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Use-cases',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Inside RenderObject.debugFillProperties\n'
          '@override\n'
          'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
          '  super.debugFillProperties(properties);\n'
          '  properties.add(ColorProperty("color", color));\n'
          '}',
          Colors.lightGreenAccent.shade200,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Custom widget with default-collapse\n'
          'properties.add(ColorProperty(\n'
          '  "background",\n'
          '  background,\n'
          '  defaultValue: Colors.white,\n'
          '));',
          Colors.lightBlueAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Diagnostic with ifNull fallback (parent type)\n'
          'properties.add(DiagnosticsProperty<Color>(\n'
          '  "selectionColor",\n'
          '  selectionColor,\n'
          '  ifNull: "<theme>",\n'
          '));',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Surface as warning when something looks off\n'
          'properties.add(ColorProperty(\n'
          '  "errorTint",\n'
          '  errorTint,\n'
          '  level: DiagnosticLevel.warning,\n'
          '));',
          Colors.orangeAccent.shade100,
        ),
      ],
    ),
  );
  print('Created use-cases panel');

  // ============================================================
  // SECTION 9: ColorProperty vs DiagnosticsProperty<Color>
  // ============================================================
  print('=== Section 9: Comparison ===');

  final genericProp = DiagnosticsProperty<Color>('background', Colors.blue);
  final specialisedProp = ColorProperty('background', Colors.blue);
  print('Generic: ${genericProp.name} value=${genericProp.value}');
  print('Specialised: ${specialisedProp.name} value=${specialisedProp.value}');

  final comparisonSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue.shade50, Colors.indigo.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ColorProperty vs DiagnosticsProperty<Color>',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Both wrap a Color, but ColorProperty stringifies to the canonical '
          'hex form (Color(0xff42a5f5)) which the rest of the Flutter '
          'tooling recognises and pretty-prints. Prefer ColorProperty.',
          style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade900),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildComparisonPanel(
                'DiagnosticsProperty<Color>',
                'background: Color(alpha: 1.0000, red: 0.1294, ...)',
                'Generic Object.toString() formatting',
                Colors.grey,
                Icons.text_snippet,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildComparisonPanel(
                'ColorProperty (preferred)',
                'background: Color(0xff2196f3)',
                'Hex form, alpha-aware, tool-friendly',
                Colors.indigo,
                Icons.star,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created comparison section');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.25),
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
            Icon(Icons.warning_amber,
                color: Colors.deepOrange.shade900, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'defaultValue uses ==',
          'Comparison checks ARGB exactly. Color(0xFFFF0000) is NOT equal to '
              'Color(0xFEFF0000) — even a 1-bit alpha difference defeats '
              'collapsing.',
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'Semi-transparent != opaque',
          'Colors.red.withValues(alpha: 0.5) does not equal Colors.red. '
              'Set defaultValue to the exact same Color you check against.',
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'ifNull only fires for literal null',
          'A Color with zero ARGB (Color(0x00000000)) is still a real value, '
              'so ifNull will NOT show — the property prints its hex form.',
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'Color subclasses can confuse equality',
          'MaterialColor and CupertinoDynamicColor wrap a primary value; '
              'compare against the underlying Color, not the swatch.',
        ),
      ],
    ),
  );
  print('Created footguns panel');

  // ============================================================
  // SECTION 11: Summary footer
  // ============================================================
  print('=== Section 11: Summary ===');

  final summary = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade400, Colors.indigo.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.0),
        _buildBullet('Use ColorProperty for any Color in debugFillProperties.'),
        _buildBullet('It stringifies to canonical hex form Color(0xAARRGGBB).'),
        _buildBullet('defaultValue collapses output when value matches.'),
        _buildBullet('ifNull only fires when value is literally null.'),
        _buildBullet('DiagnosticLevel controls visibility / severity.'),
        _buildBullet('Prefer over DiagnosticsProperty<Color> for tooling.'),
      ],
    ),
  );
  print('Created summary');

  print('ColorProperty Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade700, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withValues(alpha: 0.4),
                  blurRadius: 16.0,
                  offset: Offset(0.0, 8.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.format_color_fill,
                    size: 56.0, color: Colors.white),
                SizedBox(height: 8.0),
                Text(
                  'ColorProperty Deep Demo',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'foundation diagnostics — DiagnosticsProperty<Color>',
                  style: TextStyle(fontSize: 14.0, color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),

          // Section 1: Intro
          Text(
            '1. What is ColorProperty?',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          introCard,
          SizedBox(height: 24.0),

          // Section 2: Basic
          Text(
            '2. Basic Construction & Visual Swatches',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.start, children: basicCards),
          SizedBox(height: 24.0),

          // Section 3: ifNull
          Text(
            '3. ifNull Fallback',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          ifNullSection,
          SizedBox(height: 24.0),

          // Section 4: defaultValue
          Text(
            '4. defaultValue Collapsing',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          defaultValueSection,
          SizedBox(height: 24.0),

          // Section 5: DiagnosticLevel
          Text(
            '5. DiagnosticLevel Variants',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.start, children: levelCards),
          SizedBox(height: 24.0),

          // Section 6: Swatch grid
          Text(
            '6. Swatch Grid (12 colors)',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.start, children: swatchCells),
          SizedBox(height: 24.0),

          // Section 7: Anatomy
          Text(
            '7. Constructor Anatomy',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          anatomyDiagram,
          SizedBox(height: 24.0),

          // Section 8: Use-cases
          Text(
            '8. Use-cases / Code Examples',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          useCases,
          SizedBox(height: 24.0),

          // Section 9: Comparison
          Text(
            '9. ColorProperty vs DiagnosticsProperty<Color>',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          comparisonSection,
          SizedBox(height: 24.0),

          // Section 10: Footguns
          Text(
            '10. Footguns',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          footguns,
          SizedBox(height: 24.0),

          // Section 11: Summary
          summary,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Const value-holder classes (allowed under the contract)
// ============================================================

class _Sample {
  final String name;
  final Color color;
  final String description;
  const _Sample(this.name, this.color, this.description);
}

class _LevelEntry {
  final DiagnosticLevel level;
  final Color color;
  final IconData icon;
  final String description;
  const _LevelEntry(this.level, this.color, this.icon, this.description);
}

class _SwatchEntry {
  final String name;
  final Color color;
  const _SwatchEntry(this.name, this.color);
}

// ============================================================
// Helpers
// ============================================================

Widget _buildPropertyCard(
    ColorProperty prop, String description, Color color) {
  return Container(
    width: 180.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
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
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Swatch
        Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: prop.value,
            borderRadius: BorderRadius.circular(6.0),
            border:
                Border.all(color: Colors.grey.shade400, width: 1.0),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          prop.name ?? '<unnamed>',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 10.0, color: Colors.black54),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            prop.value.toString(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildIfNullRow(DiagnosticsProperty<Color> prop, String fallback) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.0),
    ),
    child: Row(
      children: [
        // Hatched "null" swatch
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.grey.shade500, width: 1.0),
          ),
          child: Icon(Icons.block, size: 20.0, color: Colors.grey.shade600),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'name: ${prop.name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.orange.shade900,
                ),
              ),
              Text(
                'output: ${prop.name}: $fallback',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDefaultValuePanel(
  String title,
  ColorProperty prop,
  Color value,
  Color defaultValue,
  bool collapsed,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: collapsed ? Colors.teal : Colors.cyan.shade700,
        width: 1.5,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: value,
                borderRadius: BorderRadius.circular(4.0),
                border:
                    Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
            ),
            SizedBox(width: 6.0),
            Icon(Icons.compare_arrows, size: 18.0, color: Colors.grey.shade600),
            SizedBox(width: 6.0),
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: defaultValue,
                borderRadius: BorderRadius.circular(4.0),
                border:
                    Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'name: ${prop.name}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.black87,
          ),
        ),
        Text(
          collapsed ? 'collapsed (default)' : 'shown (non-default)',
          style: TextStyle(
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
            color: collapsed ? Colors.teal : Colors.cyan.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLevelCard(_LevelEntry entry, ColorProperty prop) {
  return Container(
    width: 200.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          entry.color.withValues(alpha: 0.1),
          entry.color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: entry.color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: entry.color.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(entry.icon, color: entry.color, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              entry.level.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: entry.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          entry.description,
          style: TextStyle(fontSize: 10.0, color: Colors.black87),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 24.0,
          decoration: BoxDecoration(
            color: prop.value,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey.shade400, width: 1.0),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          '${prop.name} @ ${entry.level.name}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSwatchCell(ColorProperty prop, Color color) {
  return Container(
    width: 130.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.grey.shade400, width: 1.0),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          prop.name ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          prop.value.toString(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow(
    String label, String example, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
            border:
                Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                example,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonPanel(
  String title,
  String sample,
  String note,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            sample,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFootgun(String title, String body) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.report_problem,
            color: Colors.deepOrange.shade700, size: 20.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.deepOrange.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(fontSize: 11.0, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
