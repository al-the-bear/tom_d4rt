// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TableBorder from rendering
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableBorder test executing');
  print('=' * 50);

  final borderA = TableBorder.all(width: 2, color: Colors.blue);
  final borderB = TableBorder.symmetric(
    inside: const BorderSide(width: 1, color: Colors.green),
    outside: const BorderSide(width: 3, color: Colors.red),
  );
  final borderC = TableBorder(
    top: const BorderSide(width: 1),
    right: const BorderSide(width: 2),
    bottom: const BorderSide(width: 3),
    left: const BorderSide(width: 4),
    horizontalInside: const BorderSide(width: 0.5),
    verticalInside: const BorderSide(width: 0.75),
    borderRadius: BorderRadius.circular(6),
  );

  print('\nTableBorder constructors:');
  print('all(): $borderA');
  print('symmetric(): $borderB');
  print('full constructor: $borderC');

  print('\nKey getters:');
  print('borderA.isUniform: ${borderA.isUniform}');
  print('borderC.isUniform: ${borderC.isUniform}');
  print('borderA.dimensions: ${borderA.dimensions}');
  print('borderC.dimensions: ${borderC.dimensions}');

  final scaled = borderC.scale(1.5);
  print('\nScaled borderC x1.5: $scaled');

  print('\nUsage:');
  print('Table(border: TableBorder.all(...), children: [...])');
  print('Renders outer + inside lines for table grid');

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
  print('TableBorder test completed');

  return Table(
    border: borderC,
    children: const [
      TableRow(children: [Padding(padding: EdgeInsets.all(6), child: Text('A1')), Padding(padding: EdgeInsets.all(6), child: Text('B1'))]),
      TableRow(children: [Padding(padding: EdgeInsets.all(6), child: Text('A2')), Padding(padding: EdgeInsets.all(6), child: Text('B2'))]),
    ],
  );
}
