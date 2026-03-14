// D4rt test script: Tests TreeSliverIndentationType from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverIndentationType test executing');

  // ========== TreeSliverIndentationType Static Values ==========
  print('--- TreeSliverIndentationType Static Values ---');
  final standard = TreeSliverIndentationType.standard;
  print('  standard: $standard');
  print('  standard type: ${standard.runtimeType}');

  final none = TreeSliverIndentationType.none;
  print('  none: $none');
  print('  none type: ${none.runtimeType}');

  // ========== TreeSliverIndentationType.custom ==========
  print('--- TreeSliverIndentationType.custom ---');
  final customSmall = TreeSliverIndentationType.custom(10.0);
  print('  custom(10.0): $customSmall');

  final customMedium = TreeSliverIndentationType.custom(20.0);
  print('  custom(20.0): $customMedium');

  final customLarge = TreeSliverIndentationType.custom(40.0);
  print('  custom(40.0): $customLarge');

  final customZero = TreeSliverIndentationType.custom(0.0);
  print('  custom(0.0): $customZero');

  final customNegative = TreeSliverIndentationType.custom(-5.0);
  print('  custom(-5.0): $customNegative');

  // ========== TreeSliverIndentationType Equality ==========
  print('--- TreeSliverIndentationType Equality ---');
  print('  standard == standard: ${standard == TreeSliverIndentationType.standard}');
  print('  none == none: ${none == TreeSliverIndentationType.none}');
  print('  standard == none: ${standard == none}');

  final custom1 = TreeSliverIndentationType.custom(15.0);
  final custom2 = TreeSliverIndentationType.custom(15.0);
  final custom3 = TreeSliverIndentationType.custom(25.0);
  print('  custom(15) == custom(15): ${custom1 == custom2}');
  print('  custom(15) == custom(25): ${custom1 == custom3}');

  // ========== TreeSliverIndentationType HashCode ==========
  print('--- TreeSliverIndentationType HashCode ---');
  print('  standard.hashCode: ${standard.hashCode}');
  print('  none.hashCode: ${none.hashCode}');
  print('  custom(10.0).hashCode: ${customSmall.hashCode}');
  print('  custom(20.0).hashCode: ${customMedium.hashCode}');

  // ========== TreeSliverIndentationType toString ==========
  print('--- TreeSliverIndentationType toString ---');
  print('  standard.toString(): ${standard.toString()}');
  print('  none.toString(): ${none.toString()}');
  print('  customSmall.toString(): ${customSmall.toString()}');

  // ========== TreeSliverIndentationType Usage Patterns ==========
  print('--- TreeSliverIndentationType Usage Patterns ---');
  final List<TreeSliverIndentationType> indentations = [
    TreeSliverIndentationType.standard,
    TreeSliverIndentationType.none,
    TreeSliverIndentationType.custom(8.0),
    TreeSliverIndentationType.custom(16.0),
    TreeSliverIndentationType.custom(24.0),
    TreeSliverIndentationType.custom(32.0),
  ];
  for (int i = 0; i < indentations.length; i++) {
    print('  indentations[$i]: ${indentations[i]}');
  }

  // ========== TreeSliverIndentationType Various Custom Values ==========
  print('--- TreeSliverIndentationType Various Custom Values ---');
  final customValues = [1.0, 5.0, 10.0, 15.0, 20.0, 50.0, 100.0];
  for (final value in customValues) {
    final custom = TreeSliverIndentationType.custom(value);
    print('  custom($value): $custom');
  }

  // ========== TreeSliverIndentationType Decimal Values ==========
  print('--- TreeSliverIndentationType Decimal Values ---');
  final customDecimal1 = TreeSliverIndentationType.custom(12.5);
  print('  custom(12.5): $customDecimal1');

  final customDecimal2 = TreeSliverIndentationType.custom(7.25);
  print('  custom(7.25): $customDecimal2');

  final customDecimal3 = TreeSliverIndentationType.custom(0.5);
  print('  custom(0.5): $customDecimal3');

  print('TreeSliverIndentationType test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('TreeSliverIndentationType Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Static values: standard, none'),
          Text('Custom values: custom(double)'),
          Text('Standard: $standard'),
          Text('None: $none'),
          Text('Custom(10.0): $customSmall'),
          Text('Custom(20.0): $customMedium'),
          Text('Equality tested for same/different values'),
          Text('HashCode tested for uniqueness'),
        ],
      ),
    ),
  );
}
