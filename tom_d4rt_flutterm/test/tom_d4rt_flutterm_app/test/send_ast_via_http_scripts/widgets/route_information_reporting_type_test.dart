// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RouteInformationReportingType from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RouteInformationReportingType test executing');
  print('=' * 50);

  // RouteInformationReportingType indicates Router's intent when reporting
  print('\nRouteInformationReportingType Analysis:');
  print('  Type: enum');
  print('  Purpose: Indicates Router intent when reporting RouteInformation');
  print('  Used by: Router.navigate, Router.neglect');

  // Enumerate all values
  print('\nRouteInformationReportingType values:');
  for (final value in RouteInformationReportingType.values) {
    print('  \${value.name}: index=\${value.index}');
  }
  print('RouteInformationReportingType has \${RouteInformationReportingType.values.length} values');

  // Test each value
  print('\nDetailed Value Analysis:');
  
  // none
  final none = RouteInformationReportingType.none;
  print('\n1. RouteInformationReportingType.none:');
  print('   Name: \${none.name}');
  print('   Index: \${none.index}');
  print('   Purpose: No specific intention');
  print('   When: Default if neither navigate nor neglect used');

  // neglect
  final neglect = RouteInformationReportingType.neglect;
  print('\n2. RouteInformationReportingType.neglect:');
  print('   Name: \${neglect.name}');
  print('   Index: \${neglect.index}');
  print('   Purpose: Generated during Router.neglect call');
  print('   Effect: Route info should not be pushed to history');

  // navigate  
  final navigate = RouteInformationReportingType.navigate;
  print('\n3. RouteInformationReportingType.navigate:');
  print('   Name: \${navigate.name}');
  print('   Index: \${navigate.index}');
  print('   Purpose: Generated during Router.navigate call');
  print('   Effect: Route info should be pushed to history');

  // First and last
  print('\nBoundary Values:');
  final first = RouteInformationReportingType.values.first;
  final last = RouteInformationReportingType.values.last;
  print('  First: \$first (index \${first.index})');
  print('  Last: \$last (index \${last.index})');

  // Equality tests
  print('\nEquality Tests:');
  print('  none == none: \${none == RouteInformationReportingType.none}');
  print('  none == neglect: \${none == neglect}');
  print('  navigate == navigate: \${navigate == RouteInformationReportingType.navigate}');

  print('\n' + '=' * 50);
  print('RouteInformationReportingType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RouteInformationReportingType Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Value count: \${RouteInformationReportingType.values.length}'),
      Text('none index: \${none.index}'),
      Text('neglect index: \${neglect.index}'),
      Text('navigate index: \${navigate.index}'),
    ],
  );
}
