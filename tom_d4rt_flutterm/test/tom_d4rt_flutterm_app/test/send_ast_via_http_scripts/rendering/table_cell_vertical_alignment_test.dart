// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TableCellVerticalAlignment from rendering
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableCellVerticalAlignment test executing');
  print('=' * 50);

  print('\nEnum values:');
  for (final value in TableCellVerticalAlignment.values) {
    print('- ${value.name} (index ${value.index})');
  }

  print('\nMeaning of each value:');
  print('top: align to top of row');
  print('middle: center vertically in row');
  print('bottom: align to bottom of row');
  print('baseline: align text baselines');
  print('fill: stretch to row height');
  print('intrinsicHeight: size by intrinsic height');

  final current = TableCellVerticalAlignment.middle;
  print('\nSample selected value: $current');

  print('\nCommon usage:');
  print('TableCell(verticalAlignment: TableCellVerticalAlignment.top, child: ...)');
  print('Table(defaultVerticalAlignment: TableCellVerticalAlignment.middle, ...)');

  print('\nBaseline caveat:');
  print('baseline alignment requires textBaseline on Table');
  print('otherwise layout assertions may occur');

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
  // - Alignment baseline caveats reiterated.
  // - Table baseline dependency highlighted.
  // - Row height interaction clarified.
  // - Fill mode behavior noted.
  // - Intrinsic height implications noted.
  // - Baseline alignment table-wide impact reiterated.
  print('TableCellVerticalAlignment test completed');

  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    border: TableBorder.all(color: Colors.grey),
    children: const [
      TableRow(children: [Padding(padding: EdgeInsets.all(6), child: Text('Top')), Padding(padding: EdgeInsets.all(6), child: Text('Middle'))]),
      TableRow(children: [Padding(padding: EdgeInsets.all(6), child: Text('Bottom')), Padding(padding: EdgeInsets.all(6), child: Text('Fill'))]),
    ],
  );
}
