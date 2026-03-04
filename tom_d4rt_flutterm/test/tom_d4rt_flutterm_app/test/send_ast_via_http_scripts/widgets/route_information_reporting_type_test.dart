// D4rt test script: Tests RouteInformationReportingType from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RouteInformationReportingType test executing');

  // Enumerate all RouteInformationReportingType values
  print('RouteInformationReportingType values:');
  for (final value in RouteInformationReportingType.values) {
    print('  ${value.name}: $value');
  }
  print('RouteInformationReportingType has ${ RouteInformationReportingType.values.length} values');

  final first = RouteInformationReportingType.values.first;
  final last = RouteInformationReportingType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RouteInformationReportingType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RouteInformationReportingType Tests'),
      Text('Values: ${ RouteInformationReportingType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
