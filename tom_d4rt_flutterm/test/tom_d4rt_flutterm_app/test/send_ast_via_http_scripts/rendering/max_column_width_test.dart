// D4rt test script: Tests MaxColumnWidth from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MaxColumnWidth test executing');

  // MaxColumnWidth - Table column width using maximum of two widths
  // Combines two TableColumnWidth strategies, using the larger result

  // Create with two different column widths
  final maxWidth = MaxColumnWidth(
    const FixedColumnWidth(100.0),
    const FractionColumnWidth(0.3),
  );

  print('MaxColumnWidth created: $maxWidth');

  // Note: flex/minIntrinsicWidth/maxIntrinsicWidth take List<RenderBox>
  // which requires a render tree. We test configuration instead.
  print('MaxColumnWidth properties:');
  print('- Takes max of two column widths');
  print('- a: FixedColumnWidth(100.0)');
  print('- b: FractionColumnWidth(0.3)');
  print('- flex returns max of both flex values');
  print('- minIntrinsicWidth returns max of both min widths');
  print('- maxIntrinsicWidth returns max of both max widths');

  // Related column width types
  print('\nTableColumnWidth subclasses:');
  print('- IntrinsicColumnWidth: Based on content');
  print('- FixedColumnWidth: Fixed pixel width');
  print('- FractionColumnWidth: Fraction of table');
  print('- FlexColumnWidth: Flex-based sizing');
  print('- MaxColumnWidth: Maximum of two widths');
  print('- MinColumnWidth: Minimum of two widths');

  // Type hierarchy
  print('\nType hierarchy:');
  print('MaxColumnWidth extends TableColumnWidth');
  print('TableColumnWidth is abstract base class');

  // Use cases
  print('\nUse cases:');
  print('- Responsive table column sizing');
  print('- Minimum width with content-based scaling');
  print('- Combining fixed and flexible widths');

  print('\nMaxColumnWidth test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaxColumnWidth Tests'),
      Text('Combines FixedColumnWidth(100) + FractionColumnWidth(0.3)'),
      Text('Uses the larger of two widths'),
    ],
  );
}
