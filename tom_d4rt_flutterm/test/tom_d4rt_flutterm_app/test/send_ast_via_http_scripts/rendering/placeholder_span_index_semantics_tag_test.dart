// D4rt test script: Tests PlaceholderSpanIndexSemanticsTag from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderSpanIndexSemanticsTag test executing');

  // ========== Basic PlaceholderSpanIndexSemanticsTag creation ==========
  print('--- Basic PlaceholderSpanIndexSemanticsTag ---');
  final tag1 = PlaceholderSpanIndexSemanticsTag(0);
  print('  created: ${tag1.runtimeType}');
  print('  index: ${tag1.index}');

  // ========== Different index values ==========
  print('--- Different index values ---');
  final tag0 = PlaceholderSpanIndexSemanticsTag(0);
  print('  index = 0: ${tag0.index}');
  
  final tag1b = PlaceholderSpanIndexSemanticsTag(1);
  print('  index = 1: ${tag1b.index}');
  
  final tag5 = PlaceholderSpanIndexSemanticsTag(5);
  print('  index = 5: ${tag5.index}');
  
  final tag10 = PlaceholderSpanIndexSemanticsTag(10);
  print('  index = 10: ${tag10.index}');
  
  final tag100 = PlaceholderSpanIndexSemanticsTag(100);
  print('  index = 100: ${tag100.index}');

  // ========== SemanticsTag inheritance ==========
  print('--- SemanticsTag inheritance ---');
  print('  is SemanticsTag: ${tag1 is SemanticsTag}');
  print('  tag1.name: ${tag1.name}');

  // ========== name property ==========
  print('--- name property ---');
  print('  tag0.name: ${tag0.name}');
  print('  tag5.name: ${tag5.name}');
  print('  tag10.name: ${tag10.name}');

  // ========== Multiple tags for inline placeholders ==========
  print('--- Multiple tags for inline placeholders ---');
  final inlineTags = List.generate(5, (i) => PlaceholderSpanIndexSemanticsTag(i));
  for (int i = 0; i < inlineTags.length; i++) {
    print('  placeholder $i: index=${inlineTags[i].index}, name=${inlineTags[i].name}');
  }

  // ========== Equality comparison ==========
  print('--- Equality comparison ---');
  final tagA = PlaceholderSpanIndexSemanticsTag(3);
  final tagB = PlaceholderSpanIndexSemanticsTag(3);
  final tagC = PlaceholderSpanIndexSemanticsTag(4);
  print('  tagA.index = ${tagA.index}, tagB.index = ${tagB.index}');
  print('  tagA == tagB (same index): ${tagA == tagB}');
  print('  tagA == tagC (different index): ${tagA == tagC}');

  // ========== HashCode ==========
  print('--- HashCode ---');
  print('  tagA.hashCode: ${tagA.hashCode}');
  print('  tagB.hashCode: ${tagB.hashCode}');
  print('  tagC.hashCode: ${tagC.hashCode}');
  print('  hashCode match (same index): ${tagA.hashCode == tagB.hashCode}');

  // ========== Large index values ==========
  print('--- Large index values ---');
  final tagLarge1 = PlaceholderSpanIndexSemanticsTag(500);
  print('  index = 500: ${tagLarge1.index}');
  
  final tagLarge2 = PlaceholderSpanIndexSemanticsTag(1000);
  print('  index = 1000: ${tagLarge2.index}');

  // ========== Use case: Rich text with inline widgets ==========
  print('--- Use case: Rich text inline widgets ---');
  print('  PlaceholderSpanIndexSemanticsTag is used for accessibility');
  print('  Each inline placeholder in text gets a unique index');
  print('  Screen readers can identify embedded widgets');
  final richTextTags = [
    PlaceholderSpanIndexSemanticsTag(0), // First embedded widget
    PlaceholderSpanIndexSemanticsTag(1), // Second embedded widget
    PlaceholderSpanIndexSemanticsTag(2), // Third embedded widget
  ];
  for (int i = 0; i < richTextTags.length; i++) {
    print('  widget $i tag: ${richTextTags[i].name}');
  }

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  tag1.runtimeType: ${tag1.runtimeType}');
  print('  tagA.runtimeType: ${tagA.runtimeType}');

  // ========== toString ==========
  print('--- toString ---');
  print('  tag0.toString(): ${tag0.toString()}');
  print('  tag5.toString(): ${tag5.toString()}');
  print('  tag100.toString(): ${tag100.toString()}');

  print('PlaceholderSpanIndexSemanticsTag test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('PlaceholderSpanIndexSemanticsTag Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${tag1.runtimeType}'),
          Text('Inherits from: SemanticsTag'),
          SizedBox(height: 8.0),
          Text('Different indices:'),
          Text('  index 0: ${tag0.index}'),
          Text('  index 1: ${tag1b.index}'),
          Text('  index 5: ${tag5.index}'),
          Text('  index 10: ${tag10.index}'),
          Text('  index 100: ${tag100.index}'),
          SizedBox(height: 8.0),
          Text('Equality:'),
          Text('  tagA == tagB (same index): ${tagA == tagB}'),
          Text('  tagA == tagC (different): ${tagA == tagC}'),
          SizedBox(height: 8.0),
          Text('Purpose: Semantics for inline placeholders'),
          Text('Used in Text.rich() with WidgetSpan'),
          Text('Helps accessibility tools identify embedded widgets'),
          SizedBox(height: 8.0),
          Text.rich(
            TextSpan(
              text: 'Example: ',
              children: [
                TextSpan(text: 'Text with '),
                WidgetSpan(
                  child: Icon(Icons.star, size: 16.0, color: Color(0xFFFFC107)),
                ),
                TextSpan(text: ' inline widget'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
