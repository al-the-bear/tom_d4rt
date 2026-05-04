// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests StringProperty from foundation
// Deep Demo: Visual exploration of StringProperty knobs (quoted, defaultValue,
// ifEmpty, showName, level) and the diagnostics tree they participate in.
//
// This script is intentionally hand-written, ~800+ lines, single-file, and
// rendered through the AST -> HTTP -> d4rt visual pipeline. It does not call
// test()/expect(); the goal is rich on-screen prose and visualisation that
// teach how StringProperty formats its output.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StringProperty Deep Demo executing');

  // Motion is not the focus here; we use a single zero-duration animation
  // wrapper so callers can plug it into Stagger / Tween widgets without
  // changing the visual layout.
  final AlwaysStoppedAnimation<double> staticPulse =
      AlwaysStoppedAnimation<double>(1.0);
  final Duration zeroMotion = Duration.zero;
  print('staticPulse=${staticPulse.value} zeroMotion=$zeroMotion');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final Widget heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.deepPurple.shade500,
          Colors.pink.shade300,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, size: 48.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StringProperty',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'A DiagnosticsProperty<String> with knobs',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'StringProperty is a leaf in the diagnostics tree. Its toString()\n'
            'output depends on four orthogonal knobs (quoted, defaultValue,\n'
            'ifEmpty, showName) and one filter (level). This demo walks each\n'
            'knob in isolation, then shows them combined in tree and inspector\n'
            'previews.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Hero header built');

  // ============================================================
  // SECTION 2: Anatomy / constructor signature breakdown
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.4),
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
            Icon(Icons.architecture, color: Colors.cyan.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'StringProperty(\n'
          '  String name,            // label printed before the value\n'
          '  String? value,          // the actual string (nullable)\n'
          '  {String? description,   // free-form annotation\n'
          '   String? tooltip,       // hover/tooltip metadata\n'
          '   String? ifEmpty,       // shown when value is "" (not null)\n'
          '   bool showName = true,  // hide "name: " prefix when false\n'
          '   Object? defaultValue,  // hides node when value matches it\n'
          '   bool quoted = true,    // wraps value in "..." when true\n'
          '   DiagnosticsTreeStyle? style,\n'
          '   DiagnosticLevel level = DiagnosticLevel.info});',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.blueGrey.shade900,
            height: 1.45,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Each knob is independent. The interesting interactions happen when\n'
          'defaultValue == kNoDefaultValue (the explicit "no default" sentinel)\n'
          'or when ifEmpty collides with a non-null but empty value.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.blueGrey.shade700,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
  print('Anatomy built');

  // ============================================================
  // SECTION 3: Per-instance cards — one variation per knob combination
  // ============================================================
  print('=== Section 3: Per-instance cards ===');

  // Build a representative gallery. Each entry gets its own card with the
  // resulting toString() and valueToString() rendered as the "wire output".
  final List<_PropCase> cases = <_PropCase>[
    _PropCase(
      title: 'Plain quoted (default)',
      property: StringProperty('label', 'Hello'),
      hint: 'Default knobs: quoted=true, showName=true. Value gets wrapped in\n'
          'double quotes; the property name is shown as a prefix.',
      tone: Colors.indigo,
    ),
    _PropCase(
      title: 'Unquoted',
      property: StringProperty('label', 'Hello', quoted: false),
      hint:
          'quoted:false suppresses the surrounding quotes. Useful for tokens\n'
          'or identifiers that should look "raw" in the tree.',
      tone: Colors.teal,
    ),
    _PropCase(
      title: 'showName: false',
      property: StringProperty('label', 'Hello', showName: false),
      hint: 'showName:false drops the leading "label: ", which is handy when\n'
          'the name is redundant with the surrounding diagnostic context.',
      tone: Colors.deepPurple,
    ),
    _PropCase(
      title: 'Null value (no ifEmpty)',
      property: StringProperty('caption', null),
      hint:
          'When value is null and no ifEmpty/defaultValue is set the property\n'
          'still renders — the framework prints `null` (unquoted).',
      tone: Colors.orange,
    ),
    _PropCase(
      title: 'Empty value, ifEmpty fallback',
      property: StringProperty('subtitle', '', ifEmpty: '<empty>'),
      hint:
          'An empty (but non-null) value triggers ifEmpty. Without ifEmpty,\n'
          'the output would just be `subtitle: ""` which is easy to miss.',
      tone: Colors.brown,
    ),
    _PropCase(
      title: 'defaultValue equals value (hidden in tree)',
      property: StringProperty('mode', 'auto', defaultValue: 'auto'),
      hint:
          'When the value equals the defaultValue, level downgrades to fine —\n'
          'so most tools hide it. The toString() still renders for debug.',
      tone: Colors.blueGrey,
    ),
    _PropCase(
      title: 'defaultValue differs (visible)',
      property: StringProperty('mode', 'manual', defaultValue: 'auto'),
      hint:
          'When value differs from defaultValue the property is fully visible.\n'
          'Inspector tooling typically annotates it as a "changed" entry.',
      tone: Colors.green,
    ),
    _PropCase(
      title: 'kNoDefaultValue sentinel',
      property:
          StringProperty('mode', 'auto', defaultValue: kNoDefaultValue),
      hint: 'kNoDefaultValue means "there is intentionally no default". Do\n'
          'not pass null when you mean "no default" — null IS a valid default.',
      tone: Colors.pink,
    ),
    _PropCase(
      title: 'level: hidden',
      property: StringProperty('secret', 'hidden-token',
          level: DiagnosticLevel.hidden),
      hint:
          'level:hidden removes the property from default tree dumps. It is\n'
          'still reachable via debugFillProperties for explicit access.',
      tone: Colors.red,
    ),
    _PropCase(
      title: 'Multi-line value',
      property: StringProperty(
        'banner',
        'line one\nline two\nline three',
      ),
      hint:
          'Newlines are preserved. The renderer below shows escape sequences\n'
          'rather than raw line breaks so the card stays compact.',
      tone: Colors.cyan,
    ),
    _PropCase(
      title: 'description annotation',
      property: StringProperty(
        'token',
        'abc123',
        description: 'opaque session id, do not log',
      ),
      hint: 'description is metadata for tooling; it is NOT in toString(),\n'
          'but inspector panes may show it as a tooltip.',
      tone: Colors.amber,
    ),
    _PropCase(
      title: 'Combined: unquoted + showName false + ifEmpty',
      property: StringProperty(
        'route',
        '',
        quoted: false,
        showName: false,
        ifEmpty: '/',
      ),
      hint: 'Knobs compose. An empty unquoted value with no name and an\n'
          'ifEmpty fallback collapses to a single token: `/`.',
      tone: Colors.lime,
    ),
  ];

  final List<Widget> caseCards = <Widget>[];
  for (final _PropCase c in cases) {
    print(
        'Case "${c.title}" -> toString() = ${c.property.toString()}');
    caseCards.add(_buildCaseCard(c));
  }
  print('Built ${caseCards.length} case cards');

  // ============================================================
  // SECTION 4: Diagnostics tree mock — render several properties as a tree
  // ============================================================
  print('=== Section 4: Diagnostics tree mock ===');

  final List<DiagnosticsNode> mockTreeNodes = <DiagnosticsNode>[
    StringProperty('runtimeType', 'MyWidget'),
    StringProperty('title', 'Welcome'),
    StringProperty('subtitle', '', ifEmpty: '<no subtitle>'),
    StringProperty('mode', 'auto', defaultValue: 'auto'),
    StringProperty('mode', 'manual', defaultValue: 'auto'),
    StringProperty('routeName', '/home', quoted: false),
    StringProperty('caption', null),
    StringProperty('secret', 'token-omitted', level: DiagnosticLevel.fine),
  ];

  final Widget diagnosticsTree = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
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
            Icon(Icons.account_tree,
                color: Colors.lightGreenAccent.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'debugFillProperties tree dump',
              style: TextStyle(
                color: Colors.lightGreenAccent.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'MyWidget',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (int i = 0; i < mockTreeNodes.length; i++)
          _buildTreeRow(
            mockTreeNodes[i] as DiagnosticsProperty,
            isLast: i == mockTreeNodes.length - 1,
          ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Lines printed in dim grey are filtered (level <= fine) by the\n'
            'default DiagnosticsTreeStyle but still emitted by toString().',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white70,
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Diagnostics tree mock built (${mockTreeNodes.length} nodes)');

  // ============================================================
  // SECTION 5: Inspector pane preview
  // ============================================================
  print('=== Section 5: Inspector pane preview ===');

  final Widget inspectorPane = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Inspector title bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.indigo.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 18.0, color: Colors.indigo.shade700),
              SizedBox(width: 8.0),
              Text(
                'Inspector — Properties',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.indigo.shade900,
                ),
              ),
              Spacer(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '${cases.length} props',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Column headers
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          color: Colors.grey.shade200,
          child: Row(
            children: [
              _inspectorHeader('Name', 110.0),
              _inspectorHeader('toString()', 220.0),
              _inspectorHeader('valueToString()', 140.0),
              _inspectorHeader('level', 70.0),
            ],
          ),
        ),
        for (int i = 0; i < cases.length; i++)
          _buildInspectorRow(cases[i], i.isEven),
      ],
    ),
  );
  print('Inspector pane built');

  // ============================================================
  // SECTION 6: debugFillProperties recipe
  // ============================================================
  print('=== Section 6: debugFillProperties recipe ===');

  final Widget recipe = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.green.shade800, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Recipe: integrate StringProperty in debugFillProperties',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '@override\n'
          'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
          '  super.debugFillProperties(properties);\n'
          '  properties.add(StringProperty(\'title\', title));\n'
          '  properties.add(StringProperty(\n'
          '    \'subtitle\',\n'
          '    subtitle,\n'
          '    ifEmpty: \'<no subtitle>\',\n'
          '  ));\n'
          '  properties.add(StringProperty(\n'
          '    \'mode\',\n'
          '    mode,\n'
          '    defaultValue: \'auto\',\n'
          '  ));\n'
          '  properties.add(StringProperty(\n'
          '    \'token\',\n'
          '    token,\n'
          '    quoted: false,\n'
          '    level: DiagnosticLevel.fine,\n'
          '  ));\n'
          '}',
        ),
        SizedBox(height: 10.0),
        Text(
          'Order matters only for human readability — Flutter renders the\n'
          'tree in insertion order. Group related properties (identity, then\n'
          'state, then debug-only).',
          style:
              TextStyle(fontSize: 12.0, color: Colors.green.shade900),
        ),
      ],
    ),
  );
  print('Recipe built');

  // ============================================================
  // SECTION 7: Pitfalls — kNoDefaultValue, level filtering, null vs empty
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _pitfallRow(
          'kNoDefaultValue is a sentinel, not null',
          'Passing null as defaultValue means "the default is null". Pass\n'
              'kNoDefaultValue when there genuinely is no default. The two are\n'
              'NOT interchangeable — they produce different inspector output.',
        ),
        _pitfallRow(
          'ifEmpty fires for empty strings, not null',
          'On StringProperty, ifEmpty replaces empty (length-zero) values but\n'
              'does NOT replace null values — null prints as the literal `null`.\n'
              'Coalesce upstream if you need a unified placeholder.',
        ),
        _pitfallRow(
          'level:fine hides from default dumps',
          'Properties at level fine or below are filtered by toStringDeep().\n'
              'Use them for noisy debug-only diagnostics, but remember consumers\n'
              'must explicitly request them.',
        ),
        _pitfallRow(
          'quoted:false changes parseability',
          'Unquoted output is harder to parse from logs. Prefer quoted:true\n'
              'unless the value is a path, identifier, or already-quoted token.',
        ),
        _pitfallRow(
          'description is invisible in toString()',
          'description metadata appears only in tooling. Do not rely on it for\n'
              'log forensics; put critical context into the value itself.',
        ),
      ],
    ),
  );
  print('Pitfalls built');

  // ============================================================
  // SECTION 8: Side-by-side comparison ribbon (visual recap)
  // ============================================================
  print('=== Section 8: Comparison ribbon ===');

  final Widget ribbon = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.deepOrange.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Knob-by-knob recap',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _knobChip('quoted', 'wraps in "..."'),
            _knobChip('showName', 'prints "name: " prefix'),
            _knobChip('ifEmpty', 'fallback for ""'),
            _knobChip('tooltip', 'inspector tooltip'),
            _knobChip('defaultValue', 'hides equal values'),
            _knobChip('level', 'filters from dumps'),
            _knobChip('description', 'tooling metadata'),
            _knobChip('kNoDefaultValue', 'explicit "no default"'),
          ],
        ),
      ],
    ),
  );
  print('Ribbon built');

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  const String asciiArt = '''
   _____ _        _             ____                            _
  / ____| |      (_)           |  _ \\                          | |
 | (___ | |_ _ __ _ _ __   __ _| |_) |_ __ ___  _ __   ___ _ __| |_ _   _
  \\___ \\| __| \'__| | \'_ \\ / _\` |  _ <| \'__/ _ \\| \'_ \\ / _ \\ \'__| __| | | |
  ____) | |_| |  | | | | | (_| | |_) | | | (_) | |_) |  __/ |  | |_| |_| |
 |_____/ \\__|_|  |_|_| |_|\\__, |____/|_|  \\___/| .__/ \\___|_|   \\__|\\__, |
                           __/ |               | |                   __/ |
                          |___/                |_|                  |___/
''';

  final Widget footer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
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
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.greenAccent.shade400,
            height: 1.05,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '// end of demo — staticPulse=${staticPulse.value.toStringAsFixed(2)} '
          'duration=${zeroMotion.inMilliseconds}ms',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );
  print('Footer built');

  print('StringProperty Deep Demo build phase complete');

  // ============================================================
  // Final assembly
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
            children: <Widget>[
              heroHeader,
              SizedBox(height: 20.0),
              _sectionLabel('1. Anatomy'),
              anatomy,
              SizedBox(height: 20.0),
              _sectionLabel('2. Per-instance gallery'),
              SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 12.0,
                runSpacing: 12.0,
                children: caseCards,
              ),
              SizedBox(height: 20.0),
              _sectionLabel('3. Diagnostics tree mock'),
              diagnosticsTree,
              SizedBox(height: 20.0),
              _sectionLabel('4. Inspector pane preview'),
              inspectorPane,
              SizedBox(height: 20.0),
              _sectionLabel('5. debugFillProperties recipe'),
              recipe,
              SizedBox(height: 20.0),
              _sectionLabel('6. Pitfalls'),
              pitfalls,
              SizedBox(height: 20.0),
              _sectionLabel('7. Knob recap'),
              ribbon,
              SizedBox(height: 20.0),
              _sectionLabel('8. Footer'),
              footer,
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Data class for property cases
// ----------------------------------------------------------------------
class _PropCase {
  _PropCase({
    required this.title,
    required this.property,
    required this.hint,
    required this.tone,
  });
  final String title;
  final StringProperty property;
  final String hint;
  final MaterialColor tone;
}

// ----------------------------------------------------------------------
// Helper: section label
// ----------------------------------------------------------------------
Widget _sectionLabel(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: Colors.indigo.shade400,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
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

// ----------------------------------------------------------------------
// Helper: per-case card
// ----------------------------------------------------------------------
Widget _buildCaseCard(_PropCase c) {
  final String stringified = _safeToString(c.property);
  final String valueOnly = _safeValueToString(c.property);

  return Container(
    width: 320.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          c.tone.shade50,
          c.tone.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: c.tone.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: c.tone.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: c.tone.shade700,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                c.title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: c.tone.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'toString()\n${_escape(stringified)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.greenAccent.shade400,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'valueToString() => ${_escape(valueOnly)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.amberAccent.shade200,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          c.hint,
          style: TextStyle(
            fontSize: 11.0,
            color: c.tone.shade900,
            height: 1.35,
          ),
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            _miniBadge('level', c.property.level.name, c.tone),
            SizedBox(width: 6.0),
            _miniBadge('isFiltered',
                c.property.level.index <= DiagnosticLevel.fine.index
                    ? 'yes'
                    : 'no',
                c.tone),
          ],
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: tree row in mock console
// ----------------------------------------------------------------------
Widget _buildTreeRow(DiagnosticsProperty node, {required bool isLast}) {
  final bool dim = node.level.index <= DiagnosticLevel.fine.index;
  final Color color =
      dim ? Colors.white38 : Colors.lightGreenAccent.shade100;
  final String connector = isLast ? '└── ' : '├── ';
  return Padding(
    padding: EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
    child: Text(
      '$connector${_safeToString(node)}',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: color,
        height: 1.35,
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: inspector header cell
// ----------------------------------------------------------------------
Widget _inspectorHeader(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: inspector row
// ----------------------------------------------------------------------
Widget _buildInspectorRow(_PropCase c, bool stripe) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: stripe ? Colors.grey.shade50 : Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            c.property.name ?? '<unnamed>',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: c.tone.shade900,
            ),
          ),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            _escape(_safeToString(c.property)),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            _escape(_safeValueToString(c.property)),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ),
        SizedBox(
          width: 70.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: _levelColor(c.property.level).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _levelColor(c.property.level),
                width: 1.0,
              ),
            ),
            child: Text(
              c.property.level.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: _levelColor(c.property.level),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: pitfall row
// ----------------------------------------------------------------------
Widget _pitfallRow(String headline, String body) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline,
                color: Colors.red.shade400, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                headline,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(left: 22.0),
          child: Text(
            body,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.red.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: knob chip
// ----------------------------------------------------------------------
Widget _knobChip(String label, String hint) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          hint,
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.deepOrange.shade700,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: code block
// ----------------------------------------------------------------------
Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.lightGreenAccent.shade400,
        height: 1.4,
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: mini badge
// ----------------------------------------------------------------------
Widget _miniBadge(String label, String value, MaterialColor tone) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: tone.shade200.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: tone.shade400, width: 0.8),
    ),
    child: Text(
      '$label=$value',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9.5,
        color: tone.shade900,
      ),
    ),
  );
}

// ----------------------------------------------------------------------
// Helper: defensive toString — DiagnosticsProperty.toString() throws on
// some platforms when called outside a Flutter binding. Catch and fall
// back to a manual rendering so the demo never crashes.
// ----------------------------------------------------------------------
String _safeToString(DiagnosticsProperty node) {
  try {
    return node.toString();
  } catch (_) {
    final String name = node.name ?? '';
    final String v = _safeValueToString(node);
    return name.isEmpty ? v : '$name: $v';
  }
}

String _safeValueToString(DiagnosticsProperty node) {
  try {
    return node.valueToString();
  } catch (_) {
    final Object? v = node.value;
    if (v == null) {
      return 'null';
    }
    return v.toString();
  }
}

// ----------------------------------------------------------------------
// Helper: escape control characters for compact display
// ----------------------------------------------------------------------
String _escape(String input) {
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('\n', '\\n')
      .replaceAll('\r', '\\r')
      .replaceAll('\t', '\\t');
}

// ----------------------------------------------------------------------
// Helper: level -> color
// ----------------------------------------------------------------------
Color _levelColor(DiagnosticLevel level) {
  switch (level) {
    case DiagnosticLevel.hidden:
      return Colors.grey.shade600;
    case DiagnosticLevel.fine:
      return Colors.blueGrey.shade400;
    case DiagnosticLevel.debug:
      return Colors.teal.shade600;
    case DiagnosticLevel.info:
      return Colors.indigo.shade600;
    case DiagnosticLevel.warning:
      return Colors.orange.shade700;
    case DiagnosticLevel.hint:
      return Colors.amber.shade700;
    case DiagnosticLevel.summary:
      return Colors.purple.shade600;
    case DiagnosticLevel.error:
      return Colors.red.shade700;
    case DiagnosticLevel.off:
      return Colors.black54;
  }
}
