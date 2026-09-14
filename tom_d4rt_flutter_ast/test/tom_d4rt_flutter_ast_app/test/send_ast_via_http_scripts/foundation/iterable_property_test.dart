// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Tests IterableProperty<T> from package:flutter/foundation.dart
// Deep visual demonstration of the IterableProperty diagnostic node — its
// purpose, its constructor surface, and the rendering rules it applies to
// produce a single-line or multi-line diagnostics string for a collection.
//
// Constructor reference (verified against package:flutter/foundation.dart):
//   IterableProperty<T>(
//     String name,
//     Iterable<T>? value, {
//     Iterable<T>? defaultValue,
//     String? ifNull,
//     String? ifEmpty = '[]',
//     DiagnosticsTreeStyle? style,
//     bool showName = true,
//     bool showSeparator = true,
//     DiagnosticLevel level = DiagnosticLevel.info,
//   })
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IterableProperty Deep Demo executing');

  // ============================================================
  // Live IterableProperty instances we will exhibit visually
  // ============================================================
  final propStrings = IterableProperty<String>(
    'children',
    <String>['Header', 'Body', 'Footer'],
  );
  final propInts = IterableProperty<int>(
    'pageBreaks',
    <int>[1, 14, 27, 42, 55],
  );
  final propDoubles = IterableProperty<double>(
    'weights',
    <double>[0.125, 0.25, 0.5, 1.0],
  );
  final propEmpty = IterableProperty<String>(
    'tags',
    <String>[],
    ifEmpty: '<no tags>',
  );
  final propEmptyNoMessage = IterableProperty<String>(
    'flags',
    <String>[],
  );
  final propNull = IterableProperty<String>(
    'optionalRoutes',
    null,
    ifNull: '<unbound>',
  );
  final propWithDefault = IterableProperty<int>(
    'breakpoints',
    <int>[600, 1024, 1440],
    defaultValue: <int>[600, 1024, 1440],
  );
  final propStyledFlat = IterableProperty<String>(
    'channels',
    <String>['alpha', 'beta', 'gamma'],
    style: DiagnosticsTreeStyle.flat,
  );
  final propStyledSingleLine = IterableProperty<String>(
    'segments',
    <String>['intro', 'verse', 'chorus', 'outro'],
    style: DiagnosticsTreeStyle.singleLine,
  );
  final propHiddenName = IterableProperty<String>(
    'hidden',
    <String>['only', 'values'],
    showName: false,
  );
  final propNoSeparator = IterableProperty<String>(
    'compact',
    <String>['x', 'y', 'z'],
    showSeparator: false,
  );
  final propFineLevel = IterableProperty<String>(
    'verboseList',
    <String>['debug', 'trace'],
    level: DiagnosticLevel.fine,
  );
  final propDebugLevel = IterableProperty<String>(
    'inspectList',
    <String>['scan', 'audit'],
    level: DiagnosticLevel.debug,
  );

  print('children=${propStrings.toString()}');
  print('pageBreaks=${propInts.toString()}');
  print('weights=${propDoubles.toString()}');
  print('tags=${propEmpty.toString()}');
  print('flags=${propEmptyNoMessage.toString()}');
  print('optionalRoutes=${propNull.toString()}');
  print('channels=${propStyledFlat.toString()}');
  print('segments=${propStyledSingleLine.toString()}');
  print('hidden=${propHiddenName.toString()}');
  print('compact=${propNoSeparator.toString()}');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  print('=== Section 1: Hero header ===');
  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 32.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: Colors.cyanAccent, size: 56.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IterableProperty<T>',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.cyanAccent,
                      fontFamily: 'monospace',
                    ),
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
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Text(
            'A DiagnosticsProperty<Iterable<T>> that knows how to render a '
            'collection in either a comma-separated single line, an empty-state '
            'placeholder, or a one-element-per-line tree expansion — driven '
            'entirely by ifEmpty, ifNull, style, and level.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _heroBadge('extends', 'DiagnosticsProperty<Iterable<T>>',
                Colors.deepPurpleAccent),
            SizedBox(width: 8.0),
            _heroBadge('since', 'Flutter 1.0', Colors.tealAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a property tree node
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFFDE7), Color(0xFFFFF3E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
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
            Icon(Icons.account_tree_outlined,
                color: Colors.amber.shade900, size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a Diagnostics Node',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _anatomyRow('name', 'children', 'identifier shown left of separator',
            Colors.indigo),
        _anatomyRow('separator', ': ', 'shown when showSeparator is true',
            Colors.brown),
        _anatomyRow('value', '[Header, Body, Footer]',
            'rendered by valueToString()', Colors.green),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'children: [Header, Body, Footer]',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.greenAccent.shade100,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'When parentConfiguration.lineBreakProperties is true, the same node '
          'becomes a vertical list, each element on its own line.',
          style: TextStyle(
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
            color: Colors.brown.shade700,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-parameter cards (one card per ctor parameter)
  // ============================================================
  print('=== Section 3: Per-parameter cards ===');
  final paramCards = <Widget>[
    _paramCard(
      icon: Icons.label_important_outline,
      color: Colors.indigo,
      paramName: 'name',
      paramType: 'String (positional, required)',
      purpose:
          'The identifier rendered to the left of the value. Must be non-null. '
          'Conventionally matches the field name on the host object.',
      example: "IterableProperty<String>('children', value)",
      rendering: 'children: [Header, Body, Footer]',
    ),
    _paramCard(
      icon: Icons.list_outlined,
      color: Colors.teal,
      paramName: 'value',
      paramType: 'Iterable<T>? (positional, required)',
      purpose:
          'The collection itself. May be null. Each element is rendered via '
          'toString(); doubles use debugFormatDouble for stable formatting.',
      example: "IterableProperty<int>('breaks', [1, 14, 27])",
      rendering: 'breaks: [1, 14, 27]',
    ),
    _paramCard(
      icon: Icons.bookmark_added_outlined,
      color: Colors.deepPurple,
      paramName: 'defaultValue',
      paramType: 'Iterable<T>? = kNoDefaultValue',
      purpose:
          'When the live value equals defaultValue, the node may be filtered '
          'or rendered in a muted style — a reliable way to keep diagnostics '
          'output focused on differences from defaults.',
      example: "defaultValue: const <int>[600, 1024, 1440]",
      rendering: '(omitted when value == defaultValue)',
    ),
    _paramCard(
      icon: Icons.help_outline,
      color: Colors.blueGrey,
      paramName: 'ifNull',
      paramType: 'String?',
      purpose:
          'Replacement string used in place of the value when value is null. '
          'Pairs naturally with optional fields whose absence carries meaning.',
      example: "IterableProperty<String>('routes', null, ifNull: '<unbound>')",
      rendering: 'routes: <unbound>',
    ),
    _paramCard(
      icon: Icons.inventory_2_outlined,
      color: Colors.orange,
      paramName: 'ifEmpty',
      paramType: "String? = '[]'",
      purpose:
          'Replacement string used when value is non-null but empty. If left '
          'as null and the value is empty, the node demotes itself to '
          'DiagnosticLevel.fine (effectively hidden by default).',
      example: "IterableProperty<String>('tags', [], ifEmpty: '<no tags>')",
      rendering: 'tags: <no tags>',
    ),
    _paramCard(
      icon: Icons.style_outlined,
      color: Colors.pink,
      paramName: 'style',
      paramType: 'DiagnosticsTreeStyle?',
      purpose:
          'Picks how the node lays out its children — singleLine collapses '
          'to a comma-separated list, while sparse / dense / flat affect '
          'newlines and indentation in the textual tree.',
      example: 'style: DiagnosticsTreeStyle.singleLine',
      rendering: 'segments: intro, verse, chorus, outro',
    ),
    _paramCard(
      icon: Icons.label_off_outlined,
      color: Colors.brown,
      paramName: 'showName',
      paramType: 'bool = true',
      purpose:
          'When false, the property name and separator are suppressed and '
          'only the value text is emitted — useful inside ad-hoc lines.',
      example: 'showName: false',
      rendering: '[only, values]',
    ),
    _paramCard(
      icon: Icons.short_text,
      color: Colors.cyan,
      paramName: 'showSeparator',
      paramType: 'bool = true',
      purpose:
          'Controls the colon-space joining the name and value. Disabling '
          'lets you compose names that already contain punctuation.',
      example: 'showSeparator: false',
      rendering: 'compact [x, y, z]',
    ),
    _paramCard(
      icon: Icons.layers_outlined,
      color: Colors.green,
      paramName: 'level',
      paramType: 'DiagnosticLevel = info',
      purpose:
          'Filtering knob: hidden < fine < debug < info < warning < hint < '
          'summary < error. The IterableProperty also auto-demotes empty '
          'values with no ifEmpty to fine.',
      example: 'level: DiagnosticLevel.debug',
      rendering: '(filtered unless verbose mode)',
    ),
  ];

  // ============================================================
  // SECTION 4: Recipes for diagnostics — concrete debug-print
  //             rendering for each property we built above
  // ============================================================
  print('=== Section 4: Recipes ===');
  final recipeRows = <Widget>[
    _recipeRow(
      title: 'A simple list of strings',
      code: "IterableProperty<String>('children', ['Header', 'Body', 'Footer'])",
      output: 'children: ${propStrings.toString()}',
      tone: Colors.indigo,
    ),
    _recipeRow(
      title: 'Integer page breaks',
      code: "IterableProperty<int>('pageBreaks', [1, 14, 27, 42, 55])",
      output: 'pageBreaks: ${propInts.toString()}',
      tone: Colors.teal,
    ),
    _recipeRow(
      title: 'Doubles use debugFormatDouble',
      code: "IterableProperty<double>('weights', [0.125, 0.25, 0.5, 1.0])",
      output: 'weights: ${propDoubles.toString()}',
      tone: Colors.deepPurple,
    ),
    _recipeRow(
      title: 'Empty list with custom placeholder',
      code: "IterableProperty<String>('tags', [], ifEmpty: '<no tags>')",
      output: 'tags: ${propEmpty.toString()}',
      tone: Colors.orange,
    ),
    _recipeRow(
      title: 'Empty list, no ifEmpty (auto-demoted)',
      code: "IterableProperty<String>('flags', [])",
      output: 'flags: ${propEmptyNoMessage.toString()}',
      tone: Colors.amber,
    ),
    _recipeRow(
      title: 'Null value with ifNull placeholder',
      code: "IterableProperty<String>('optionalRoutes', null, ifNull: '<unbound>')",
      output: 'optionalRoutes: ${propNull.toString()}',
      tone: Colors.blueGrey,
    ),
    _recipeRow(
      title: 'Hidden name (showName: false)',
      code: "IterableProperty<String>('hidden', ['only', 'values'], showName: false)",
      output: propHiddenName.toString(),
      tone: Colors.brown,
    ),
    _recipeRow(
      title: 'No separator (showSeparator: false)',
      code: "IterableProperty<String>('compact', ['x', 'y', 'z'], showSeparator: false)",
      output: propNoSeparator.toString(),
      tone: Colors.cyan,
    ),
    _recipeRow(
      title: 'Style: singleLine collapses children',
      code: "IterableProperty<String>('segments', ['intro', 'verse', 'chorus', 'outro'], style: DiagnosticsTreeStyle.singleLine)",
      output: 'segments: ${propStyledSingleLine.toString()}',
      tone: Colors.pink,
    ),
    _recipeRow(
      title: 'Level: fine (visible only in verbose mode)',
      code: "IterableProperty<String>('verboseList', ['debug', 'trace'], level: DiagnosticLevel.fine)",
      output: 'verboseList: ${propFineLevel.toString()}',
      tone: Colors.green,
    ),
  ];

  // ============================================================
  // SECTION 5: Pitfalls and gotchas
  // ============================================================
  print('=== Section 5: Pitfalls ===');
  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
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
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and Gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallEntry(
          'Empty lists vanish silently',
          'If you leave ifEmpty: null and the list is empty, the property '
              'is auto-demoted to DiagnosticLevel.fine and will not appear in '
              "the default debug dump. Set ifEmpty: '<empty>' to keep it.",
        ),
        _pitfallEntry(
          'Iterable, not List',
          'value is typed Iterable<T>?. A lazy iterable will be enumerated '
              'each time toString() is called — wrap with .toList() for hot '
              'iterables you must not consume twice.',
        ),
        _pitfallEntry(
          'Type parameter affects rendering',
          'IterableProperty<double> uses debugFormatDouble for stable '
              'output (no scientific noise); IterableProperty<dynamic> falls '
              "back to plain v.toString().",
        ),
        _pitfallEntry(
          'defaultValue uses == on the iterable',
          'List equality is reference equality by default. Use a const list '
              'or override == on a custom collection to make defaultValue '
              'matching reliable.',
        ),
        _pitfallEntry(
          'showName / showSeparator are independent',
          'Setting showName: false still emits the separator unless you '
              'also set showSeparator: false. They are not coupled.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison with related Property classes
  // ============================================================
  print('=== Section 6: Comparison ===');
  final comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
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
            Icon(Icons.compare_arrows,
                color: Colors.green.shade800, size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'IterableProperty vs Friends',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _compareCard(
          'IterableProperty<T>',
          'Iterable<T>?',
          'Comma list or vertical list per parentConfiguration. '
              'Auto-demotes empty values without ifEmpty.',
          Colors.indigo,
          highlight: true,
        ),
        SizedBox(height: 8.0),
        _compareCard(
          'DiagnosticsProperty<T>',
          'T?',
          'Generic single-value property. IterableProperty is its '
              'iterable-aware specialization.',
          Colors.blueGrey,
        ),
        SizedBox(height: 8.0),
        _compareCard(
          'EnumProperty<T extends Enum?>',
          'T?',
          'Renders a single enum value by .name. No iteration.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _compareCard(
          'StringProperty',
          'String?',
          'Single string with optional quoting. Use for scalar text.',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _compareCard(
          'FlagProperty',
          'bool',
          'Renders only when the flag is set; uses ifTrue/ifFalse text.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _compareCard(
          'ObjectFlagProperty<T>',
          'T?',
          "Renders 'has X' / 'no X' based on whether value is non-null.",
          Colors.pink,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Animation snapshot — static motion only
  // ============================================================
  print('=== Section 7: Animation snapshot ===');
  final snapshotAnim1 = AlwaysStoppedAnimation<double>(0.0);
  final snapshotAnim2 = AlwaysStoppedAnimation<double>(0.33);
  final snapshotAnim3 = AlwaysStoppedAnimation<double>(0.66);
  final snapshotAnim4 = AlwaysStoppedAnimation<double>(1.0);
  final zeroDuration = Duration.zero;
  print('snapshot animations created with values: '
      '${snapshotAnim1.value}, ${snapshotAnim2.value}, '
      '${snapshotAnim3.value}, ${snapshotAnim4.value} '
      'over ${zeroDuration.inMilliseconds}ms');

  final snapshot = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.18),
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
            Icon(Icons.tune, color: Colors.blue.shade800, size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Static Motion Snapshot',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Diagnostics are read at frozen points in time. The snapshots below '
          'use AlwaysStoppedAnimation<double> with Duration.zero — exactly the '
          'mode the inspector uses when capturing a property tree.',
          style: TextStyle(fontSize: 13.0, color: Colors.blue.shade900),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _snapshotBar('frame 0', snapshotAnim1.value, Colors.blue),
            _snapshotBar('frame 1', snapshotAnim2.value, Colors.indigo),
            _snapshotBar('frame 2', snapshotAnim3.value, Colors.deepPurple),
            _snapshotBar('frame 3', snapshotAnim4.value, Colors.purple),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Quick reference card
  // ============================================================
  print('=== Section 8: Quick reference ===');
  final quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.2),
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
            Icon(Icons.menu_book_outlined,
                color: Colors.deepPurple.shade800, size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _quickRefRow('class', 'IterableProperty<T>'),
        _quickRefRow('extends', 'DiagnosticsProperty<Iterable<T>>'),
        _quickRefRow('library', 'package:flutter/foundation.dart'),
        _quickRefRow('positional 1', 'String name'),
        _quickRefRow('positional 2', 'Iterable<T>? value'),
        _quickRefRow('named', 'defaultValue, ifNull, ifEmpty (default \'[]\')'),
        _quickRefRow('named', 'style, showName, showSeparator, level'),
        _quickRefRow('main override', 'valueToString({parentConfiguration})'),
        _quickRefRow('level rule',
            'fine when ifEmpty == null && value.isEmpty'),
        _quickRefRow('json key', "'values' added to toJsonMap when non-null"),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  print('=== Section 9: ASCII footer ===');
  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
      gradient: LinearGradient(
        colors: [Color(0xFF1B1B1B), Color(0xFF2C2C2C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      r'''
+----------------------------------------------------------+
|  IterableProperty<T>                                     |
|                                                          |
|  name -+-- separator -+--------- valueToString ----+     |
|        |              |                            |     |
|        v              v                            v     |
|     children    :          [Header, Body, Footer]        |
|                                                          |
|  empty ---> ifEmpty   |   null ---> ifNull               |
|  doubles ---> debugFormatDouble                          |
|                                                          |
|  level: hidden  fine  debug  [info]  warning  hint  err  |
+----------------------------------------------------------+
''',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: Colors.greenAccent.shade100,
        height: 1.25,
      ),
    ),
  );

  print('IterableProperty Deep Demo completed successfully');

  // ============================================================
  // Compose final layout
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
              '1. Anatomy of a Property Tree Node',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            anatomy,
            SizedBox(height: 24.0),
            Text(
              '2. Constructor Parameters',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            ...paramCards,
            SizedBox(height: 24.0),
            Text(
              '3. Recipes — Live Renderings',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            ...recipeRows,
            SizedBox(height: 24.0),
            Text(
              '4. Pitfalls',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            pitfalls,
            SizedBox(height: 24.0),
            Text(
              '5. Comparison with Related Property Classes',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            comparison,
            SizedBox(height: 24.0),
            Text(
              '6. Static Motion Snapshot',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            snapshot,
            SizedBox(height: 24.0),
            Text(
              '7. Quick Reference',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            quickReference,
            SizedBox(height: 16.0),
            asciiFooter,
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// Helpers
// =====================================================================

Widget _heroBadge(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.25),
          color.withValues(alpha: 0.45),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(String label, String token, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90.0,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey.shade400, width: 1.0),
          ),
          child: Text(
            token,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _paramCard({
  required IconData icon,
  required Color color,
  required String paramName,
  required String paramType,
  required String purpose,
  required String example,
  required String rendering,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.06),
          color.withValues(alpha: 0.16),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paramName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    paramType,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          purpose,
          style: TextStyle(
            fontSize: 13.0,
            height: 1.45,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.code,
                      color: Colors.cyan.shade300, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'example',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.cyan.shade300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                example,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.greenAccent.shade100,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.print_outlined,
                      color: Colors.amber.shade300, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'debug-print rendering',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.amber.shade300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                rendering,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.amber.shade100,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeRow({
  required String title,
  required String code,
  required String output,
  required Color tone,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tone.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.16),
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
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tone,
                boxShadow: [
                  BoxShadow(
                    color: tone.withValues(alpha: 0.5),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: tone,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
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
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: tone.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_right_alt, color: tone, size: 18.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  output,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
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

Widget _pitfallEntry(String title, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.report_problem_outlined,
            color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.red.shade900.withValues(alpha: 0.85),
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

Widget _compareCard(
  String name,
  String type,
  String description,
  Color color, {
  bool highlight = false,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: highlight ? color.withValues(alpha: 0.18) : Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: highlight ? 0.85 : 0.45),
        width: highlight ? 2.0 : 1.0,
      ),
      boxShadow: [
        if (highlight)
          BoxShadow(
            color: color.withValues(alpha: 0.3),
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
            Icon(
              highlight ? Icons.star : Icons.circle_outlined,
              color: color,
              size: 16.0,
            ),
            SizedBox(width: 6.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _snapshotBar(String label, double value, Color color) {
  return SizedBox(
    width: 60.0,
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 4.0),
        Container(
          height: 70.0,
          width: 26.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70.0 * value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.6),
                    color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _quickRefRow(String key, String value) {
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
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}
