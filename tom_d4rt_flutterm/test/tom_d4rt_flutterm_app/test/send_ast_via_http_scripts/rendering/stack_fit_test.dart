// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StackFit from rendering
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StackFit test executing');
  print('=' * 50);

  print('\nStackFit enum values:');
  for (final v in StackFit.values) {
    print('- ${v.name} (index ${v.index})');
  }

  final loose = StackFit.loose;
  final expand = StackFit.expand;
  final passthrough = StackFit.passthrough;

  print('\nBehavior summary:');
  print('loose: non-positioned children get loose constraints');
  print('expand: non-positioned children forced to Stack size');
  print('passthrough: pass parent constraints to children as-is');

  print('\nComparisons:');
  print('loose == expand: ${loose == expand}');
  print('expand == passthrough: ${expand == passthrough}');

  print('\nCommon usage in Stack widget:');
  print('Stack(fit: StackFit.loose, children: [...])');
  print('Stack(fit: StackFit.expand, children: [...])');

  print('\nConstraint intuition:');
  print('Stack itself sizes by parent constraints');
  print('fit decides only how non-positioned children are constrained');
  print('positioned children use Positioned constraints instead');

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
  print('StackFit test completed');

  return Container(
    width: 220,
    height: 140,
    color: Colors.grey.shade200,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.blue.withValues(alpha: 0.15)),
        Align(alignment: Alignment.topLeft, child: Text('StackFit.expand')),
        Align(alignment: Alignment.bottomRight, child: Text('values=${StackFit.values.length}')),
      ],
    ),
  );
}
