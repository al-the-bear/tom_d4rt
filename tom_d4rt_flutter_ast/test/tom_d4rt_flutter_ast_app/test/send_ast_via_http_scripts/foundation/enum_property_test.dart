// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: EnumProperty<T extends Enum?> from package:flutter/foundation.dart
//
// Constructor (verified against flutter source):
//   EnumProperty(String name, T value, {T? defaultValue, DiagnosticLevel level})
//
// EnumProperty extends DiagnosticsProperty<T> where T extends Enum?. It is a
// specialized diagnostics property that uses Enum.name for valueToString,
// instead of the default toString() (which would return "EnumType.value").
//
// This file is a hand-authored deep walkthrough of:
//   1. EnumProperty hero header
//   2. Anatomy of a DiagnosticsProperty / EnumProperty
//   3. Per-parameter visual cards: name, value, defaultValue, level
//   4. Live debug-print recipe with TextDirection
//   5. Live debug-print recipe with TargetPlatform
//   6. Live debug-print recipe with Brightness
//   7. Live debug-print recipe with DiagnosticLevel itself
//   8. Pitfalls and common mistakes
//   9. Comparison with related Property classes
//  10. Quick reference cheatsheet
//  11. ASCII footer
//
// Static motion only: AlwaysStoppedAnimation<double>(value) and Duration.zero.
// No test()/expect()/group() and no main() function.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== EnumProperty Deep Visual Demo: BEGIN ===');

  // ============================================================
  // Construct a representative gallery of EnumProperty<T> values.
  // These are referenced from various sections below.
  // ============================================================
  final EnumProperty<TextDirection> epTextDir = EnumProperty<TextDirection>(
    'textDirection',
    TextDirection.ltr,
  );
  print('ep textDirection: ${epTextDir.toString()}');

  final EnumProperty<TextDirection?> epTextDirNullDefault =
      EnumProperty<TextDirection?>(
        'textDirection',
        null,
        defaultValue: null,
      );
  print('ep textDirection null/default null: ${epTextDirNullDefault.toString()}');

  final EnumProperty<TargetPlatform> epPlatform = EnumProperty<TargetPlatform>(
    'platform',
    TargetPlatform.android,
    defaultValue: TargetPlatform.android,
  );
  print('ep platform with default: ${epPlatform.toString()}');

  final EnumProperty<Brightness> epBrightness = EnumProperty<Brightness>(
    'brightness',
    Brightness.dark,
  );
  print('ep brightness: ${epBrightness.toString()}');

  final EnumProperty<DiagnosticLevel> epLevel = EnumProperty<DiagnosticLevel>(
    'level',
    DiagnosticLevel.info,
    level: DiagnosticLevel.fine,
  );
  print('ep level (fine): ${epLevel.toString()}');

  // The static motion handle, used to demonstrate that EnumProperty cards
  // can be embedded in animation-driven scaffolding without ticking.
  final AlwaysStoppedAnimation<double> staticMotion =
      AlwaysStoppedAnimation<double>(1.0);
  final Duration zero = Duration.zero;
  print('staticMotion.value = ${staticMotion.value}, duration = $zero');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('--- Section 1: Hero header ---');
  final Widget hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade500,
          Colors.blue.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.label_important, size: 64.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'EnumProperty<T extends Enum?>',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'foundation.diagnostics — print enum.name instead of "Type.value"',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, color: Colors.white70),
        ),
        SizedBox(height: 18.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('extends DiagnosticsProperty<T>', Colors.white),
            _heroChip('valueToString → value?.name ?? "null"', Colors.white),
            _heroChip('used by debugFillProperties()', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of an EnumProperty
  // ============================================================
  print('--- Section 2: Anatomy ---');
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
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
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Class anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _anatomyRow(
          'Diagnosticable',
          'Marker for objects that contribute to debug trees',
          Colors.blueGrey,
        ),
        _anatomyArrow(),
        _anatomyRow(
          'DiagnosticsNode',
          'Abstract node carried in widget/render diagnostic trees',
          Colors.teal,
        ),
        _anatomyArrow(),
        _anatomyRow(
          'DiagnosticsProperty<T>',
          'Generic property: name + value + defaultValue + level + style',
          Colors.deepPurple,
        ),
        _anatomyArrow(),
        _anatomyRow(
          'EnumProperty<T extends Enum?>',
          'Overrides valueToString → value?.name ?? "null"',
          Colors.indigo,
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            'EnumProperty(\n'
            '  String name,\n'
            '  T value, {\n'
            '  T? defaultValue,\n'
            '  DiagnosticLevel level = DiagnosticLevel.info,\n'
            '})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyan.shade100,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-parameter visual cards
  // ============================================================
  print('--- Section 3: Per-parameter cards ---');
  final List<Widget> paramCards = [
    _paramCard(
      paramName: 'name',
      paramType: 'String',
      tagline: 'Property label as it appears in dumps',
      detail:
          'The first positional argument. Used as the left side of the\n'
          'name=value pair when the property is rendered to a string.\n'
          'Conventionally the same as the field name on your object.',
      examplePairs: [
        ['EnumProperty<TextDirection>(\'textDirection\', value)', 'textDirection: ltr'],
        ['EnumProperty<TargetPlatform>(\'platform\', value)', 'platform: android'],
        ['EnumProperty<Brightness>(\'brightness\', value)', 'brightness: dark'],
      ],
      tint: Colors.teal,
      icon: Icons.label,
    ),
    _paramCard(
      paramName: 'value',
      paramType: 'T (extends Enum?)',
      tagline: 'The enum value to display (or null)',
      detail:
          'The second positional argument. EnumProperty overrides\n'
          'valueToString() to return value?.name when value is non-null,\n'
          'and the literal "null" when it is null.',
      examplePairs: [
        ['value: TextDirection.ltr', 'textDirection: ltr'],
        ['value: TextDirection.rtl', 'textDirection: rtl'],
        ['value: null', 'textDirection: null'],
      ],
      tint: Colors.indigo,
      icon: Icons.input,
    ),
    _paramCard(
      paramName: 'defaultValue',
      paramType: 'T? (named, optional)',
      tagline: 'Hide property when value matches the default',
      detail:
          'When defaultValue is provided AND equal to value, the property\n'
          'reports level==fine and is hidden from concise diagnostics dumps.\n'
          'Use kNoDefaultValue to mean "no default" explicitly.',
      examplePairs: [
        ['defaultValue: TargetPlatform.android (matches)', 'platform: android (hidden in default dump)'],
        ['defaultValue: TextDirection.ltr (mismatches rtl)', 'textDirection: rtl'],
        ['defaultValue: null  +  value: null', 'textDirection: null (hidden)'],
      ],
      tint: Colors.deepOrange,
      icon: Icons.flag_outlined,
    ),
    _paramCard(
      paramName: 'level',
      paramType: 'DiagnosticLevel (named, default: info)',
      tagline: 'Verbosity gating for the property',
      detail:
          'DiagnosticLevel orders: hidden < fine < debug < info < warning <\n'
          'hint < summary < error < off. Properties below the dump cutoff\n'
          'are skipped. EnumProperty defaults to DiagnosticLevel.info.',
      examplePairs: [
        ['level: DiagnosticLevel.info  (default)', 'shown in normal dumps'],
        ['level: DiagnosticLevel.fine', 'shown only with toStringDeep / verbose'],
        ['level: DiagnosticLevel.warning', 'highlighted in dumps'],
      ],
      tint: Colors.purple,
      icon: Icons.tune,
    ),
  ];

  // ============================================================
  // SECTION 4: Live print recipe — TextDirection
  // ============================================================
  print('--- Section 4: TextDirection recipe ---');
  final List<Widget> textDirectionRows = [];
  for (final TextDirection td in TextDirection.values) {
    final EnumProperty<TextDirection> p = EnumProperty<TextDirection>(
      'textDirection',
      td,
    );
    print('TextDirection ${td.name}: ${p.toString()}');
    textDirectionRows.add(_recipeRow(
      enumLabel: 'TextDirection.${td.name}',
      printed: p.toString(),
      accent: td == TextDirection.ltr ? Colors.blue : Colors.deepPurple,
      icon: td == TextDirection.ltr
          ? Icons.format_textdirection_l_to_r
          : Icons.format_textdirection_r_to_l,
    ));
  }

  // ============================================================
  // SECTION 5: Live print recipe — TargetPlatform
  // ============================================================
  print('--- Section 5: TargetPlatform recipe ---');
  final List<Widget> targetPlatformRows = [];
  final Map<TargetPlatform, IconData> platformIcons = {
    TargetPlatform.android: Icons.android,
    TargetPlatform.iOS: Icons.phone_iphone,
    TargetPlatform.fuchsia: Icons.bubble_chart,
    TargetPlatform.linux: Icons.laptop_chromebook,
    TargetPlatform.macOS: Icons.laptop_mac,
    TargetPlatform.windows: Icons.laptop_windows,
  };
  for (final TargetPlatform tp in TargetPlatform.values) {
    final EnumProperty<TargetPlatform> p = EnumProperty<TargetPlatform>(
      'platform',
      tp,
      defaultValue: TargetPlatform.android,
    );
    print('TargetPlatform ${tp.name}: ${p.toString()}');
    final bool isDefault = tp == TargetPlatform.android;
    targetPlatformRows.add(_recipeRow(
      enumLabel: 'TargetPlatform.${tp.name}',
      printed: '${p.toString()}${isDefault ? '   [== defaultValue]' : ''}',
      accent: isDefault ? Colors.green : Colors.orange,
      icon: platformIcons[tp] ?? Icons.devices,
    ));
  }

  // ============================================================
  // SECTION 6: Live print recipe — Brightness
  // ============================================================
  print('--- Section 6: Brightness recipe ---');
  final List<Widget> brightnessRows = [];
  for (final Brightness b in Brightness.values) {
    final EnumProperty<Brightness> p = EnumProperty<Brightness>(
      'brightness',
      b,
    );
    print('Brightness ${b.name}: ${p.toString()}');
    brightnessRows.add(_recipeRow(
      enumLabel: 'Brightness.${b.name}',
      printed: p.toString(),
      accent: b == Brightness.light ? Colors.amber.shade700 : Colors.blueGrey,
      icon: b == Brightness.light ? Icons.light_mode : Icons.dark_mode,
    ));
  }

  // ============================================================
  // SECTION 7: Live print recipe — DiagnosticLevel itself
  // ============================================================
  print('--- Section 7: DiagnosticLevel recipe ---');
  final List<Widget> diagnosticLevelRows = [];
  for (final DiagnosticLevel dl in DiagnosticLevel.values) {
    final EnumProperty<DiagnosticLevel> p = EnumProperty<DiagnosticLevel>(
      'level',
      dl,
    );
    print('DiagnosticLevel ${dl.name}: ${p.toString()}');
    diagnosticLevelRows.add(_recipeRow(
      enumLabel: 'DiagnosticLevel.${dl.name}',
      printed: p.toString(),
      accent: _levelTint(dl),
      icon: _levelIcon(dl),
    ));
  }

  // ============================================================
  // SECTION 8: Pitfalls and common mistakes
  // ============================================================
  print('--- Section 8: Pitfalls ---');
  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & common mistakes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _pitfallTile(
          title: 'Using StringProperty for an enum',
          bad: "StringProperty('axis', Axis.vertical.toString())",
          good: "EnumProperty<Axis>('axis', Axis.vertical)",
          why: 'StringProperty prints "Axis.vertical"; EnumProperty prints "vertical".',
        ),
        _pitfallTile(
          title: 'Forgetting a generic on a nullable enum',
          bad: "EnumProperty('dir', maybeNull, defaultValue: null)",
          good: "EnumProperty<TextDirection?>('dir', maybeNull, defaultValue: null)",
          why: 'Without an explicit T, T extends Enum? cannot accept dynamic null.',
        ),
        _pitfallTile(
          title: 'defaultValue with a non-matching value',
          bad: "EnumProperty<Brightness>('b', Brightness.dark, defaultValue: Brightness.light)",
          good: "EnumProperty<Brightness>('b', Brightness.dark)  // when no meaningful default exists",
          why: 'Mismatching defaults never hide the property; remove if unintended.',
        ),
        _pitfallTile(
          title: 'Setting level: DiagnosticLevel.hidden by hand',
          bad: "EnumProperty<TextDirection>('d', value, level: DiagnosticLevel.hidden)",
          good: "EnumProperty<TextDirection>('d', value, defaultValue: TextDirection.ltr)",
          why: 'Let defaultValue handle hiding; manual hidden defeats diagnostics.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Comparison with related Property classes
  // ============================================================
  print('--- Section 9: Comparison ---');
  final Widget comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.lightBlue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.cyan.shade800, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'EnumProperty vs siblings',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _comparisonRow(
          'EnumProperty<T>',
          'enum',
          'value?.name',
          'EnumProperty<TextDirection>(\'d\', TextDirection.ltr) → d: ltr',
          Colors.indigo,
        ),
        _comparisonRow(
          'StringProperty',
          'String',
          'quoted string',
          'StringProperty(\'name\', \'Tom\') → name: "Tom"',
          Colors.green,
        ),
        _comparisonRow(
          'IntProperty',
          'int',
          'integer literal',
          'IntProperty(\'count\', 42) → count: 42',
          Colors.blue,
        ),
        _comparisonRow(
          'DoubleProperty',
          'double',
          'fixed-point number',
          'DoubleProperty(\'opacity\', 0.5) → opacity: 0.5',
          Colors.purple,
        ),
        _comparisonRow(
          'FlagProperty',
          'bool',
          'ifTrue / ifFalse string',
          'FlagProperty(\'enabled\', value: true, ifTrue: \'on\') → on',
          Colors.orange,
        ),
        _comparisonRow(
          'IterableProperty<T>',
          'Iterable<T>',
          'comma-separated items',
          'IterableProperty<int>(\'ids\', [1,2,3]) → ids: 1, 2, 3',
          Colors.teal,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Quick reference cheatsheet
  // ============================================================
  print('--- Section 10: Quick reference ---');
  final Widget cheatsheet = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _cheatLine('Type', 'EnumProperty<T extends Enum?> extends DiagnosticsProperty<T>'),
        _cheatLine('Library', 'package:flutter/foundation.dart'),
        _cheatLine('Constructor', 'EnumProperty(name, value, {defaultValue, level})'),
        _cheatLine('valueToString()', 'value?.name ?? "null"'),
        _cheatLine('Default level', 'DiagnosticLevel.info'),
        _cheatLine('Hides when', 'value == defaultValue (and defaultValue provided)'),
        _cheatLine('Use inside', 'Widget.debugFillProperties(DiagnosticPropertiesBuilder)'),
        _cheatLine('Typical caller', 'properties.add(EnumProperty<MyEnum>("kind", kind));'),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.cyan.shade700, width: 1.0),
          ),
          child: Text(
            '@override\n'
            'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
            '  super.debugFillProperties(properties);\n'
            '  properties.add(EnumProperty<TextDirection>(\n'
            '    \'textDirection\',\n'
            '    textDirection,\n'
            '    defaultValue: TextDirection.ltr,\n'
            '  ));\n'
            '  properties.add(EnumProperty<Brightness>(\n'
            '    \'brightness\',\n'
            '    brightness,\n'
            '    level: DiagnosticLevel.fine,\n'
            '  ));\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent.shade200,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: ASCII footer
  // ============================================================
  print('--- Section 11: ASCII footer ---');
  final String asciiArt = ''
      '   _____                       ____                            _\n'
      '  | ____|_ __  _   _ _ __ ___ |  _ \\ _ __ ___  _ __   ___ _ __| |_ _   _\n'
      "  |  _| | '_ \\| | | | '_ ` _ \\| |_) | '__/ _ \\| '_ \\ / _ \\ '__| __| | | |\n"
      '  | |___| | | | |_| | | | | | |  __/| | | (_) | |_) |  __/ |  | |_| |_| |\n'
      '  |_____|_| |_|\\__,_|_| |_| |_|_|   |_|  \\___/| .__/ \\___|_|   \\__|\\__, |\n'
      '                                               |_|                  |___/\n'
      '          extends DiagnosticsProperty<T extends Enum?>\n'
      '          name=value · defaultValue · level\n';
  print(asciiArt);
  final Widget footer = Container(
    margin: EdgeInsets.only(top: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.grey.shade900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      asciiArt,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.5,
        color: Colors.greenAccent.shade200,
        height: 1.25,
      ),
    ),
  );

  print('=== EnumProperty Deep Visual Demo: END ===');

  // ============================================================
  // Compose final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hero,
              SizedBox(height: 24.0),
              _sectionTitle('1. Anatomy', Icons.account_tree),
              anatomy,
              SizedBox(height: 12.0),
              _sectionTitle('2. Constructor parameters', Icons.tune),
              ...paramCards,
              SizedBox(height: 12.0),
              _sectionTitle('3. TextDirection — debug print recipe', Icons.text_format),
              _recipePanel(textDirectionRows, Colors.blue),
              SizedBox(height: 12.0),
              _sectionTitle('4. TargetPlatform — debug print recipe', Icons.devices),
              _recipePanel(targetPlatformRows, Colors.orange),
              SizedBox(height: 12.0),
              _sectionTitle('5. Brightness — debug print recipe', Icons.brightness_6),
              _recipePanel(brightnessRows, Colors.amber),
              SizedBox(height: 12.0),
              _sectionTitle('6. DiagnosticLevel — debug print recipe', Icons.layers),
              _recipePanel(diagnosticLevelRows, Colors.purple),
              SizedBox(height: 12.0),
              _sectionTitle('7. Pitfalls', Icons.warning_amber),
              pitfalls,
              SizedBox(height: 12.0),
              _sectionTitle('8. Comparison with sibling properties', Icons.compare_arrows),
              comparison,
              SizedBox(height: 12.0),
              _sectionTitle('9. Quick reference', Icons.menu_book),
              cheatsheet,
              SizedBox(height: 12.0),
              footer,
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Helper widgets — purely presentational, no animation ticks.
// ============================================================

Widget _sectionTitle(String label, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.white],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: Colors.indigo, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.indigo.shade700, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _anatomyRow(String name, String description, Color tint) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.only(top: 5.0, right: 10.0),
          decoration: BoxDecoration(
            color: tint,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: tint.withValues(alpha: 0.5),
                blurRadius: 4.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: tint,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                description,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Center(
      child: Icon(
        Icons.arrow_downward,
        size: 16.0,
        color: Colors.indigo.shade400,
      ),
    ),
  );
}

Widget _paramCard({
  required String paramName,
  required String paramType,
  required String tagline,
  required String detail,
  required List<List<String>> examplePairs,
  required Color tint,
  required IconData icon,
}) {
  final List<Widget> exampleWidgets = [];
  for (final List<String> pair in examplePairs) {
    exampleWidgets.add(
      Container(
        margin: EdgeInsets.only(top: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 3.0,
              offset: Offset(0.0, 1.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, color: tint, size: 14.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    pair[0],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.cyan.shade100,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Icon(Icons.arrow_right, color: Colors.greenAccent, size: 16.0),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    pair[1],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.greenAccent.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          tint.withValues(alpha: 0.06),
          tint.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tint.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
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
                color: tint.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: tint.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Icon(icon, color: tint, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paramName,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: tint,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    paramType,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            tagline,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          detail,
          style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 6.0),
        ...exampleWidgets,
      ],
    ),
  );
}

Widget _recipePanel(List<Widget> rows, Color tint) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          tint.withValues(alpha: 0.05),
          tint.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _recipeRow({
  required String enumLabel,
  required String printed,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: accent, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 2,
          child: Text(
            enumLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Icon(Icons.arrow_right_alt, color: accent, size: 18.0),
        SizedBox(width: 6.0),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              printed,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallTile({
  required String title,
  required String bad,
  required String good,
  required String why,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.red.shade200, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.close, color: Colors.red, size: 14.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  bad,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.green.shade200, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check, color: Colors.green, size: 14.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  good,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            'Why: $why',
            style: TextStyle(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(
  String typeName,
  String dartType,
  String renderRule,
  String example,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                typeName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'covers $dartType',
              style: TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          'render: $renderRule',
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          example,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _cheatLine(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent.shade100,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Color _levelTint(DiagnosticLevel dl) {
  switch (dl) {
    case DiagnosticLevel.hidden:
      return Colors.grey;
    case DiagnosticLevel.fine:
      return Colors.blueGrey;
    case DiagnosticLevel.debug:
      return Colors.lightBlue;
    case DiagnosticLevel.info:
      return Colors.indigo;
    case DiagnosticLevel.warning:
      return Colors.orange;
    case DiagnosticLevel.hint:
      return Colors.teal;
    case DiagnosticLevel.summary:
      return Colors.deepPurple;
    case DiagnosticLevel.error:
      return Colors.red;
    case DiagnosticLevel.off:
      return Colors.black54;
  }
}

IconData _levelIcon(DiagnosticLevel dl) {
  switch (dl) {
    case DiagnosticLevel.hidden:
      return Icons.visibility_off;
    case DiagnosticLevel.fine:
      return Icons.grain;
    case DiagnosticLevel.debug:
      return Icons.bug_report;
    case DiagnosticLevel.info:
      return Icons.info_outline;
    case DiagnosticLevel.warning:
      return Icons.warning_amber;
    case DiagnosticLevel.hint:
      return Icons.lightbulb_outline;
    case DiagnosticLevel.summary:
      return Icons.summarize;
    case DiagnosticLevel.error:
      return Icons.error_outline;
    case DiagnosticLevel.off:
      return Icons.power_settings_new;
  }
}
