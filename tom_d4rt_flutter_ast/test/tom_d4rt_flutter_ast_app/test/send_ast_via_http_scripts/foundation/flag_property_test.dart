// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last
// D4rt deep-visual demo: Tests FlagProperty from package:flutter/foundation.dart
// FlagProperty is a DiagnosticsProperty<bool> subclass used to render boolean
// flags inside diagnostic dumps using descriptive ifTrue/ifFalse strings rather
// than the bare value true/false. This file is a hand-authored, deep visual
// demonstration of every constructor parameter and rendering path.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Boot trace -- emitted before any widget construction so that
  // the harness sees evidence of execution in transcript logs.
  // ============================================================
  print('FlagProperty Deep Demo executing');
  print('FlagProperty extends DiagnosticsProperty<bool>');
  print('Asserts ifTrue != null || ifFalse != null');

  // ============================================================
  // Build a representative library of FlagProperty values that
  // exercise every parameter combination supported by the API.
  // We keep them outside the widget tree so the section cards
  // can render their .toString() output deterministically.
  // ============================================================

  final fpEnabledTrue = FlagProperty('enabled', value: true, ifTrue: 'ENABLED');
  print('fpEnabledTrue: ${fpEnabledTrue.toString()}');

  final fpEnabledFalse = FlagProperty(
    'enabled',
    value: false,
    ifTrue: 'ENABLED',
  );
  print('fpEnabledFalse: ${fpEnabledFalse.toString()}');

  final fpVisibleHiddenTrue = FlagProperty(
    'visible',
    value: true,
    ifFalse: 'HIDDEN',
  );
  print('fpVisibleHiddenTrue: ${fpVisibleHiddenTrue.toString()}');

  final fpVisibleHiddenFalse = FlagProperty(
    'visible',
    value: false,
    ifFalse: 'HIDDEN',
  );
  print('fpVisibleHiddenFalse: ${fpVisibleHiddenFalse.toString()}');

  final fpActiveTrue = FlagProperty(
    'active',
    value: true,
    ifTrue: 'active',
    ifFalse: 'inactive',
  );
  final fpActiveFalse = FlagProperty(
    'active',
    value: false,
    ifTrue: 'active',
    ifFalse: 'inactive',
  );
  print('fpActiveTrue: ${fpActiveTrue.toString()}');
  print('fpActiveFalse: ${fpActiveFalse.toString()}');

  final fpCheckYesShown = FlagProperty(
    'check',
    value: false,
    ifTrue: 'yes',
    ifFalse: 'no',
    showName: true,
  );
  final fpCheckNoShown = FlagProperty(
    'check',
    value: true,
    ifTrue: 'yes',
    ifFalse: 'no',
    showName: true,
  );
  print('fpCheckYesShown: ${fpCheckYesShown.toString()}');
  print('fpCheckNoShown: ${fpCheckNoShown.toString()}');

  final fpDefaultEqualsValue = FlagProperty(
    'autofocus',
    value: false,
    ifTrue: 'autofocus',
    defaultValue: false,
  );
  final fpDefaultDiffersValue = FlagProperty(
    'autofocus',
    value: true,
    ifTrue: 'autofocus',
    defaultValue: false,
  );
  print('fpDefaultEqualsValue: ${fpDefaultEqualsValue.toString()}');
  print('fpDefaultDiffersValue: ${fpDefaultDiffersValue.toString()}');

  final fpLevelInfo = FlagProperty(
    'mounted',
    value: true,
    ifTrue: 'mounted',
    level: DiagnosticLevel.info,
  );
  final fpLevelDebug = FlagProperty(
    'mounted',
    value: true,
    ifTrue: 'mounted',
    level: DiagnosticLevel.debug,
  );
  final fpLevelFine = FlagProperty(
    'mounted',
    value: true,
    ifTrue: 'mounted',
    level: DiagnosticLevel.fine,
  );
  print('fpLevelInfo: level=${fpLevelInfo.level}');
  print('fpLevelDebug: level=${fpLevelDebug.level}');
  print('fpLevelFine: level=${fpLevelFine.level}');

  final fpNullValue = FlagProperty(
    'optional',
    value: null,
    ifTrue: 'present',
    ifFalse: 'absent',
  );
  print('fpNullValue: ${fpNullValue.toString()}');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  print('=== Section 1: Hero header ===');
  final heroHeader = Container(
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
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.flag_circle, size: 64.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'FlagProperty',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'package:flutter/foundation.dart',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white70,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white54, width: 1.0),
          ),
          child: Text(
            'extends DiagnosticsProperty<bool>',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a FlagProperty
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
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
            Icon(Icons.architecture, color: Colors.teal.shade700),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a FlagProperty',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'FlagProperty(\n'
            '  String name,                       // diagnostic key\n'
            '  required bool? value,              // current flag value\n'
            '  String? ifTrue,                    // text when true\n'
            '  String? ifFalse,                   // text when false\n'
            '  bool showName = false,             // emit "name: " prefix\n'
            '  Object? defaultValue,              // hide when matches\n'
            '  DiagnosticLevel level = info,      // verbosity bucket\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent.shade100,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Invariant: ifTrue != null || ifFalse != null. The constructor '
          'asserts that at least one description is provided so that the '
          'flag has something meaningful to render.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.teal.shade900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-parameter cards
  // Each card visualises one constructor parameter and shows
  // a true/false rendering pair so you see the effect on output.
  // ============================================================
  print('=== Section 3: Per-parameter cards ===');

  final paramCardName = _buildParamCard(
    name: 'name',
    type: 'String',
    purpose:
        'Diagnostic identifier. Always the first positional argument. Used '
        'as the dotted key inside diagnostic trees and JSON dumps.',
    accent: Colors.indigo,
    icon: Icons.label,
    trueExample: FlagProperty('enabled', value: true, ifTrue: 'ENABLED'),
    falseExample: FlagProperty('enabled', value: false, ifTrue: 'ENABLED'),
    code: "FlagProperty('enabled', value: flag, ifTrue: 'ENABLED')",
  );

  final paramCardValue = _buildParamCard(
    name: 'value',
    type: 'bool?',
    purpose:
        'The current state of the flag. Required. May be null, in which '
        'case FlagProperty falls back to "name: null" rendering and forces '
        'showName to true.',
    accent: Colors.deepOrange,
    icon: Icons.toggle_on,
    trueExample: FlagProperty(
      'active',
      value: true,
      ifTrue: 'active',
      ifFalse: 'inactive',
    ),
    falseExample: FlagProperty(
      'active',
      value: false,
      ifTrue: 'active',
      ifFalse: 'inactive',
    ),
    code: "FlagProperty('active', value: bool, ifTrue: ..., ifFalse: ...)",
  );

  final paramCardIfTrue = _buildParamCard(
    name: 'ifTrue',
    type: 'String?',
    purpose:
        'Text emitted when value == true. If null and the flag is true, '
        'the property is hidden (DiagnosticLevel.hidden) by default so the '
        'truthy state contributes nothing visible to the dump.',
    accent: Colors.green,
    icon: Icons.thumb_up,
    trueExample: FlagProperty('selected', value: true, ifTrue: 'selected'),
    falseExample: FlagProperty('selected', value: false, ifTrue: 'selected'),
    code: "FlagProperty('selected', value: flag, ifTrue: 'selected')",
  );

  final paramCardIfFalse = _buildParamCard(
    name: 'ifFalse',
    type: 'String?',
    purpose:
        'Text emitted when value == false. If null and the flag is false, '
        'the property hides itself. Pair with ifTrue when both states '
        'should render distinct strings.',
    accent: Colors.red,
    icon: Icons.thumb_down,
    trueExample: FlagProperty('visible', value: true, ifFalse: 'hidden'),
    falseExample: FlagProperty('visible', value: false, ifFalse: 'hidden'),
    code: "FlagProperty('visible', value: flag, ifFalse: 'hidden')",
  );

  final paramCardShowName = _buildParamCard(
    name: 'showName',
    type: 'bool = false',
    purpose:
        'Whether to prefix the rendered string with "name: ". Defaults to '
        'false because ifTrue/ifFalse are normally descriptive enough on '
        'their own. Force-enabled when value is null or when only one of '
        'ifTrue/ifFalse is provided.',
    accent: Colors.purple,
    icon: Icons.text_fields,
    trueExample: FlagProperty(
      'check',
      value: true,
      ifTrue: 'yes',
      ifFalse: 'no',
      showName: true,
    ),
    falseExample: FlagProperty(
      'check',
      value: false,
      ifTrue: 'yes',
      ifFalse: 'no',
      showName: true,
    ),
    code: "FlagProperty('check', value: f, ifTrue: 'yes', ifFalse: 'no', showName: true)",
  );

  final paramCardDefault = _buildParamCard(
    name: 'defaultValue',
    type: 'Object?',
    purpose:
        'Compared against value to decide whether the property is at the '
        'default (DiagnosticLevel.fine) or has been changed. Useful in '
        'widget diagnostics so unchanged flags fade into the background.',
    accent: Colors.amber.shade800,
    icon: Icons.bookmark_outline,
    trueExample: FlagProperty(
      'autofocus',
      value: true,
      ifTrue: 'autofocus',
      defaultValue: false,
    ),
    falseExample: FlagProperty(
      'autofocus',
      value: false,
      ifTrue: 'autofocus',
      defaultValue: false,
    ),
    code: "FlagProperty('autofocus', value: f, ifTrue: 'autofocus', defaultValue: false)",
  );

  final paramCardLevel = _buildParamCard(
    name: 'level',
    type: 'DiagnosticLevel',
    purpose:
        'Initial verbosity bucket. May be promoted to hidden when the '
        'description for the current value is missing, or to fine when '
        'value matches defaultValue. Common values: info, debug, fine.',
    accent: Colors.blueGrey,
    icon: Icons.tune,
    trueExample: FlagProperty(
      'mounted',
      value: true,
      ifTrue: 'mounted',
      level: DiagnosticLevel.info,
    ),
    falseExample: FlagProperty(
      'mounted',
      value: false,
      ifTrue: 'mounted',
      level: DiagnosticLevel.info,
    ),
    code: "FlagProperty('mounted', value: f, ifTrue: 'mounted', level: DiagnosticLevel.info)",
  );

  // ============================================================
  // SECTION 4: Rendering Matrix
  // Cross product of value x descriptions captured in a table.
  // ============================================================
  print('=== Section 4: Rendering matrix ===');

  final matrixRows = <List<String>>[
    ['true', 'enabled', '(none)', 'enabled'],
    ['false', 'enabled', '(none)', '<hidden>'],
    ['true', '(none)', 'hidden', '<hidden>'],
    ['false', '(none)', 'hidden', 'hidden'],
    ['true', 'active', 'inactive', 'active'],
    ['false', 'active', 'inactive', 'inactive'],
    ['null', 'present', 'absent', 'optional: null'],
  ];

  final renderingMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue.shade50, Colors.blue.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.2),
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
            Icon(Icons.grid_on, color: Colors.blue.shade700),
            SizedBox(width: 8.0),
            Text(
              'Rendering matrix: value x ifTrue x ifFalse',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _buildMatrixHeader('value', 70.0),
              _buildMatrixHeader('ifTrue', 100.0),
              _buildMatrixHeader('ifFalse', 100.0),
              _buildMatrixHeader('renders as', 140.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (final row in matrixRows)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.blue.shade100, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                _buildMatrixCell(row[0], 70.0, Colors.blue.shade900),
                _buildMatrixCell(row[1], 100.0, Colors.green.shade800),
                _buildMatrixCell(row[2], 100.0, Colors.red.shade800),
                _buildMatrixCell(row[3], 140.0, Colors.deepPurple.shade700),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Recipes -- diagnostic-dump style output
  // ============================================================
  print('=== Section 5: Diagnostic dump recipes ===');

  final recipeWidgets = <Widget>[];
  final recipes = <Map<String, Object>>[
    {
      'title': 'Recipe 1 -- single ifTrue',
      'flagTrue': fpEnabledTrue,
      'flagFalse': fpEnabledFalse,
      'description':
          'Only ifTrue provided. False values are hidden, so a list of '
          'flags collapses to "ENABLED" only when the toggle is on.',
      'gradient': [Colors.green.shade50, Colors.green.shade100],
      'accent': Colors.green,
    },
    {
      'title': 'Recipe 2 -- single ifFalse',
      'flagTrue': fpVisibleHiddenTrue,
      'flagFalse': fpVisibleHiddenFalse,
      'description':
          'Only ifFalse provided. Mirrors recipe 1 -- the truthy state is '
          'hidden because the flag is the absence of a marker.',
      'gradient': [Colors.red.shade50, Colors.red.shade100],
      'accent': Colors.red,
    },
    {
      'title': 'Recipe 3 -- both descriptions',
      'flagTrue': fpActiveTrue,
      'flagFalse': fpActiveFalse,
      'description':
          'Both ifTrue and ifFalse describe the state. Always renders '
          'something. Common for state machines (active/inactive).',
      'gradient': [Colors.deepPurple.shade50, Colors.deepPurple.shade100],
      'accent': Colors.deepPurple,
    },
    {
      'title': 'Recipe 4 -- showName',
      'flagTrue': fpCheckNoShown,
      'flagFalse': fpCheckYesShown,
      'description':
          'showName: true keeps the property name visible alongside the '
          'value description. Useful when the name carries semantic meaning '
          'beyond the description.',
      'gradient': [Colors.purple.shade50, Colors.purple.shade100],
      'accent': Colors.purple,
    },
    {
      'title': 'Recipe 5 -- defaultValue',
      'flagTrue': fpDefaultDiffersValue,
      'flagFalse': fpDefaultEqualsValue,
      'description':
          'defaultValue lets the diagnostics framework demote the property '
          'when value equals the default. The "differs" case stays at info '
          'level, the "equals" case drops to fine.',
      'gradient': [Colors.amber.shade50, Colors.amber.shade100],
      'accent': Colors.amber.shade800,
    },
    {
      'title': 'Recipe 6 -- null value',
      'flagTrue': fpNullValue,
      'flagFalse': fpNullValue,
      'description':
          'A null value forces showName to true and renders "name: null" '
          'so the consumer sees the absence rather than guessing at it.',
      'gradient': [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
      'accent': Colors.blueGrey,
    },
  ];

  for (final r in recipes) {
    final accent = r['accent'] as Color;
    final flagTrue = r['flagTrue'] as FlagProperty;
    final flagFalse = r['flagFalse'] as FlagProperty;
    final gradientColors = (r['gradient'] as List).cast<Color>();
    print('Recipe: ${r['title']}');
    print('  true  -> ${flagTrue.toString()}');
    print('  false -> ${flagFalse.toString()}');

    recipeWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.18),
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
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  r['title'] as String,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              r['description'] as String,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
            ),
            SizedBox(height: 10.0),
            _buildDumpLine('flag = true ', flagTrue.toString(), accent),
            SizedBox(height: 4.0),
            _buildDumpLine('flag = false', flagFalse.toString(), accent),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Pitfalls and gotchas
  // ============================================================
  print('=== Section 6: Pitfalls ===');

  final pitfalls = <Map<String, String>>[
    {
      'title': 'Both ifTrue and ifFalse null',
      'detail':
          'Constructor asserts. FlagProperty requires at least one of ifTrue '
          'or ifFalse to be non-null so it always has something to render.',
    },
    {
      'title': 'Forgetting ifFalse',
      'detail':
          'When ifFalse is omitted, the property silently disappears in '
          'diagnostic dumps for the false case. Sometimes intentional '
          '(presence-only flags), sometimes confusing.',
    },
    {
      'title': 'Null value without showName',
      'detail':
          'showName is force-enabled when value is null. Do not rely on '
          'showName: false to hide null states -- the framework overrides it.',
    },
    {
      'title': 'defaultValue ignored at hidden',
      'detail':
          'If the property is already hidden because the matching '
          'description is null, defaultValue cannot make it visible. The '
          'description controls visibility first.',
    },
    {
      'title': 'level downgraded to fine',
      'detail':
          'Setting level: info has no effect when value matches '
          'defaultValue -- the diagnostics framework will downgrade it.',
    },
  ];

  final pitfallSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.2),
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
            Icon(Icons.warning_amber, color: Colors.deepOrange.shade700),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and gotchas',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final p in pitfalls)
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepOrange.shade100, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 14.0,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        p['title'] ?? '',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  p['detail'] ?? '',
                  style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison with bool / IterableProperty
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.lightBlue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
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
            Icon(Icons.compare_arrows, color: Colors.cyan.shade800),
            SizedBox(width: 8.0),
            Text(
              'When to use FlagProperty vs alternatives',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildCompareCard(
                title: 'FlagProperty',
                accent: Colors.indigo,
                icon: Icons.flag,
                summary: 'Boolean flag with descriptive labels.',
                bullets: [
                  'Boolean state',
                  'Custom ifTrue / ifFalse strings',
                  'Hides when description missing',
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildCompareCard(
                title: 'DiagnosticsProperty<bool>',
                accent: Colors.teal,
                icon: Icons.check_box,
                summary: 'Plain boolean property.',
                bullets: [
                  'Renders true / false literally',
                  'No custom labels',
                  'Always shows name by default',
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildCompareCard(
                title: 'IterableProperty<T>',
                accent: Colors.deepPurple,
                icon: Icons.list,
                summary: 'List/iterable rendering.',
                bullets: [
                  'For collections, not flags',
                  'Renders each item',
                  'Different formatting rules',
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Rule of thumb: prefer FlagProperty whenever the audience cares '
            'about the meaning of true/false rather than the literal token. '
            'Reach for plain DiagnosticsProperty<bool> only for low-level '
            'diagnostics where the literal helps debugging.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.cyan.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Static motion demo (AlwaysStoppedAnimation)
  // Uses Duration.zero and AlwaysStoppedAnimation<double>(value)
  // to satisfy the "static motion only" rule of the test corpus.
  // ============================================================
  print('=== Section 8: Static motion ===');

  final stoppedFade = AlwaysStoppedAnimation<double>(1.0);
  final stoppedHalf = AlwaysStoppedAnimation<double>(0.5);
  final stoppedZero = AlwaysStoppedAnimation<double>(0.0);
  final zeroDuration = Duration.zero;
  print('stoppedFade.value = ${stoppedFade.value}');
  print('stoppedHalf.value = ${stoppedHalf.value}');
  print('stoppedZero.value = ${stoppedZero.value}');
  print('zeroDuration = $zeroDuration');

  final staticMotion = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.pink.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.motion_photos_paused, color: Colors.pink.shade700),
            SizedBox(width: 8.0),
            Text(
              'Static motion frames',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeTransition(
              opacity: stoppedFade,
              child: _buildMotionFrame(
                'opacity 1.0',
                fpEnabledTrue,
                Colors.green,
              ),
            ),
            FadeTransition(
              opacity: stoppedHalf,
              child: _buildMotionFrame(
                'opacity 0.5',
                fpActiveTrue,
                Colors.deepPurple,
              ),
            ),
            FadeTransition(
              opacity: stoppedFade,
              child: _buildMotionFrame(
                'opacity 1.0',
                fpVisibleHiddenFalse,
                Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.purple.shade200, width: 1.0),
          ),
          child: Text(
            'Driven by AlwaysStoppedAnimation<double>(value) and '
            'Duration.zero -- no real animation frames are pumped.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Quick reference
  // ============================================================
  print('=== Section 9: Quick reference ===');

  final quickRef = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.cyanAccent.shade100),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRefLine('name', 'String -- diagnostic key'),
        _buildRefLine('value', 'bool? -- current state'),
        _buildRefLine('ifTrue', 'String? -- text when true'),
        _buildRefLine('ifFalse', 'String? -- text when false'),
        _buildRefLine('showName', 'bool = false -- prefix with name:'),
        _buildRefLine('defaultValue', 'Object? -- demote to fine when equal'),
        _buildRefLine(
          'level',
          'DiagnosticLevel = info -- verbosity bucket',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            "FlagProperty('mounted', value: true, ifTrue: 'mounted')",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: ASCII footer
  // ============================================================
  print('=== Section 10: ASCII footer ===');

  final asciiFooter = Container(
    margin: EdgeInsets.only(top: 16.0, bottom: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      '+--------------------------------------------------+\n'
      '|   FlagProperty -- foundation/diagnostics.dart    |\n'
      '|--------------------------------------------------|\n'
      '|   ifTrue   -> rendered when value == true        |\n'
      '|   ifFalse  -> rendered when value == false       |\n'
      '|   showName -> prefix with "name: "               |\n'
      '|   default  -> demote to fine when value matches  |\n'
      '|   level    -> info | debug | fine | hidden | ... |\n'
      "|   assert   -> ifTrue != null || ifFalse != null  |\n"
      '+--------------------------------------------------+',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: Colors.greenAccent.shade100,
        height: 1.4,
      ),
    ),
  );

  print('FlagProperty Deep Demo completed successfully');

  // ============================================================
  // Wrap the entire visual in MaterialApp/Scaffold per signature.
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 24.0),
            Text(
              '1. Anatomy',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            anatomy,
            SizedBox(height: 16.0),
            Text(
              '2. Per-parameter cards',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            paramCardName,
            paramCardValue,
            paramCardIfTrue,
            paramCardIfFalse,
            paramCardShowName,
            paramCardDefault,
            paramCardLevel,
            SizedBox(height: 16.0),
            Text(
              '3. Rendering matrix',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            renderingMatrix,
            SizedBox(height: 16.0),
            Text(
              '4. Diagnostic dump recipes',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            ...recipeWidgets,
            SizedBox(height: 16.0),
            Text(
              '5. Pitfalls',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            pitfallSection,
            SizedBox(height: 16.0),
            Text(
              '6. Comparison',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            comparison,
            SizedBox(height: 16.0),
            Text(
              '7. Static motion',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            staticMotion,
            SizedBox(height: 16.0),
            Text(
              '8. Quick reference',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            quickRef,
            SizedBox(height: 16.0),
            Text(
              '9. ASCII footer',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            asciiFooter,
          ],
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helper: per-parameter card with true/false rendering preview.
// ----------------------------------------------------------------
Widget _buildParamCard({
  required String name,
  required String type,
  required String purpose,
  required Color accent,
  required IconData icon,
  required FlagProperty trueExample,
  required FlagProperty falseExample,
  required String code,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.06),
          accent.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 10.0,
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
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: accent,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: accent.withValues(alpha: 0.8),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          purpose,
          style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.cyanAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: _buildRenderPreview(
                label: 'value: true',
                rendering: trueExample.toString(),
                accent: Colors.green,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildRenderPreview(
                label: 'value: false',
                rendering: falseExample.toString(),
                accent: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildRenderPreview({
  required String label,
  required String rendering,
  required Color accent,
}) {
  final displayed = rendering.isEmpty ? '<hidden>' : rendering;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          displayed,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMatrixHeader(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.blue.shade900,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildMatrixCell(String label, double width, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildDumpLine(String label, String rendering, Color accent) {
  final displayed = rendering.isEmpty ? '<hidden>' : rendering;
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            displayed,
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

Widget _buildCompareCard({
  required String title,
  required Color accent,
  required IconData icon,
  required String summary,
  required List<String> bullets,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          summary,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade800,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 6.0),
        for (final bullet in bullets)
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade900,
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

Widget _buildMotionFrame(String label, FlagProperty flag, Color color) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
    ),
    child: Column(
      children: [
        Icon(Icons.flag, color: color, size: 22.0),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          flag.toString().isEmpty ? '<hidden>' : flag.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRefLine(String key, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent.shade100,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
