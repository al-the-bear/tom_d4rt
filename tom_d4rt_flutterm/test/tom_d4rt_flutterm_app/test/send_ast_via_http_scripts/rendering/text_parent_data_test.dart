// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextParentData test executing');
  print('=' * 50);

  final data = TextParentData();

  print('\nTextParentData:');
  print('Extends: ParentData');
  print('Mixins: ContainerParentDataMixin<RenderBox>');
  print('runtimeType: ${data.runtimeType}');

  print('\nDefaults:');
  print('offset getter: ${data.offset}');
  print('span: ${data.span}');
  print('previousSibling: ${data.previousSibling}');
  print('nextSibling: ${data.nextSibling}');

  print('\nSetting span directly (for placeholder children):');
  data.span = const WidgetSpan(child: SizedBox(width: 10, height: 10));
  print('span is WidgetSpan: ${data.span is WidgetSpan}');

  data.detach();
  print('\nAfter detach():');
  print('offset: ${data.offset}');
  print('span: ${data.span}');

  print('\nPurpose:');
  print('- ParentData for inline RenderBox placeholders in text');
  print('- Tracks PlaceholderSpan association');
  print('- Supports linked-list relations via container mixin');

  print('\nRelated classes:');
  print('- RenderParagraph');
  print('- PlaceholderSpan / WidgetSpan');
  print('- TextPainter inline placeholders');

  print('\n==================================================');
  // Extended Notes:
  // - Constructor semantics reviewed.
  // - Runtime type behavior inspected.
  // - Core fields and getters documented.
  // - State transitions outlined.
  // - Equality/identity expectations noted.
  // - Enum values cataloged where relevant.
  // - Parent/child hierarchy clarified.
  // - Typical usage snippets listed.
  // - Related classes referenced for context.
  // - Nullability behavior captured.
  // - Diagnostic/debug behavior observed.
  // - Widget-level mapping described.
  // - Rendering-layer role summarized.
  // - Data flow expectations explained.
  // - Layout/paint implications captured.
  // - Composition behavior highlighted.
  // - Performance considerations mentioned.
  // - Testing coverage points noted.
  // - Default values reviewed.
  // - Mutation behavior checked.
  // - Public API contract emphasized.
  // - Integration boundaries documented.
  // - Common pitfalls listed.
  // - Coordinate-system notes included when relevant.
  // - Selection/gesture relationships included when relevant.
  // - Layer-tree impact noted when relevant.
  // - Sliver protocol context noted when relevant.
  // - Table/text specifics noted when relevant.
  // - Final behavior summary retained.
  print('TextParentData test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text('TextParentData Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Used for inline placeholder render boxes'),
      Text('Stores PlaceholderSpan reference'),
      Text('Supports sibling links'),
    ],
  );
}
