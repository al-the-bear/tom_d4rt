// ignore_for_file: avoid_print
// D4rt test script: Tests SemanticsData, SemanticsHintOverrides, SemanticsTag, OrdinalSortKey, AttributedString from semantics
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Semantics data test executing');

  // ========== SEMANTICSTAG ==========
  print('--- SemanticsTag Tests ---');

  final tag1 = SemanticsTag('button-tag');
  print('SemanticsTag("button-tag"): $tag1');
  print('  name: ${tag1.name}');
  print('  runtimeType: ${tag1.runtimeType}');

  final tag2 = SemanticsTag('header-tag');
  print('SemanticsTag("header-tag"): $tag2');
  print('  name: ${tag2.name}');

  final tag3 = SemanticsTag('custom-role');
  print('SemanticsTag("custom-role"): $tag3');

  // RenderViewport.excludeFromScrolling
  print('Built-in tag: RenderViewport.excludeFromScrolling exists');

  // ========== ORDINALSORTKEY ==========
  print('--- OrdinalSortKey Tests ---');

  final sortKey1 = OrdinalSortKey(1.0);
  print('OrdinalSortKey(1.0): $sortKey1');
  print('  order: ${sortKey1.order}');
  print('  name: ${sortKey1.name}');
  print('  runtimeType: ${sortKey1.runtimeType}');

  final sortKey2 = OrdinalSortKey(2.0);
  print('OrdinalSortKey(2.0): $sortKey2');
  print('  order: ${sortKey2.order}');

  final sortKey3 = OrdinalSortKey(0.5, name: 'header');
  print('OrdinalSortKey(0.5, name: "header"):');
  print('  order: ${sortKey3.order}');
  print('  name: ${sortKey3.name}');

  // Compare sort keys
  final cmp = sortKey1.compareTo(sortKey2);
  print('sortKey1.compareTo(sortKey2): $cmp');

  final cmpEqual = sortKey1.compareTo(OrdinalSortKey(1.0));
  print('sortKey1.compareTo(OrdinalSortKey(1.0)): $cmpEqual');

  // ========== SEMANTICSHINTOVERRIDES ==========
  print('--- SemanticsHintOverrides Tests ---');

  final hintOverrides1 = SemanticsHintOverrides(
    onTapHint: 'Activate button',
    onLongPressHint: 'Show options',
  );
  print('SemanticsHintOverrides:');
  print('  onTapHint: ${hintOverrides1.onTapHint}');
  print('  onLongPressHint: ${hintOverrides1.onLongPressHint}');
  print('  isNotEmpty: ${hintOverrides1.isNotEmpty}');
  print('  runtimeType: ${hintOverrides1.runtimeType}');

  final hintOverridesEmpty = SemanticsHintOverrides();
  print('Empty SemanticsHintOverrides:');
  print('  onTapHint: ${hintOverridesEmpty.onTapHint}');
  print('  onLongPressHint: ${hintOverridesEmpty.onLongPressHint}');
  print('  isNotEmpty: ${hintOverridesEmpty.isNotEmpty}');

  final tapOnly = SemanticsHintOverrides(onTapHint: 'Submit form');
  print('Tap-only hint: onTapHint="${tapOnly.onTapHint}"');

  // ========== ATTRIBUTEDSTRING ==========
  print('--- AttributedString Tests ---');

  final attrStr1 = AttributedString('Hello World');
  print('AttributedString("Hello World"):');
  print('  string: ${attrStr1.string}');
  print('  runtimeType: ${attrStr1.runtimeType}');

  final attrStr2 = AttributedString('Spell check test');
  print('AttributedString("Spell check test"):');
  print('  string: ${attrStr2.string}');

  // With locale attribute
  final attrStr3 = AttributedString(
    'Multilingual text',
    attributes: [
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 12),
        locale: Locale('en', 'US'),
      ),
    ],
  );
  print('AttributedString with locale attribute:');
  print('  string: ${attrStr3.string}');
  print('  attributes count: ${attrStr3.attributes.length}');

  // With spell out attribute
  final attrStr4 = AttributedString(
    'ABC123',
    attributes: [SpellOutStringAttribute(range: TextRange(start: 0, end: 6))],
  );
  print('AttributedString with spell-out:');
  print('  string: ${attrStr4.string}');
  print('  attributes count: ${attrStr4.attributes.length}');

  // Concatenation
  final combined = attrStr1 + attrStr2;
  print('Concatenated: "${combined.string}"');

  // ========== SEMANTICSDATA NOTE ==========
  print('--- SemanticsData Notes ---');

  print('SemanticsData is typically created by the framework');
  print('  Contains all semantics information for a node');
  print('  Properties: flags, actions, attributedLabel, attributedValue');
  print('  attributedHint, attributedIncreasedValue, attributedDecreasedValue');
  print('  tooltip, textDirection, rect, elevation, thickness');
  print('  textSelection, scrollIndex, scrollChildCount, scrollPosition');
  print('  scrollExtentMax, scrollExtentMin, tags, transform');

  // ========== RETURN WIDGET ==========
  print('Semantics data test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semantics Data Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SemanticsTag - semantic annotation tag'),
          Text('• OrdinalSortKey - ordering for accessibility'),
          Text('• SemanticsHintOverrides - hint text overrides'),
          Text('• AttributedString - string with attributes'),
          SizedBox(height: 16.0),

          Text(
            'Framework-Only:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SemanticsData - full node data (framework-created)'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE0F7FA),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tag: ${tag1.name}'),
                Text('SortKey: order=${sortKey1.order}'),
                Text('Hints: tap="${hintOverrides1.onTapHint}"'),
                Text('AttrString: "${attrStr1.string}"'),
                Text('Combined: "${combined.string}"'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
