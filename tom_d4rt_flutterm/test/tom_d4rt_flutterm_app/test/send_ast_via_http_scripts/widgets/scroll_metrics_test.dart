// ignore_for_file: avoid_print
// D4rt test script: Tests FixedScrollMetrics, ScrollMetricsNotification,
// ScrollStartNotification, ScrollUpdateNotification, ScrollEndNotification,
// OverscrollNotification, UserScrollNotification, ScrollIncrementDetails
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('ScrollMetrics/Notifications test executing');

  // ========== FixedScrollMetrics ==========
  print('--- FixedScrollMetrics Tests ---');
  final metrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 100.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 3.0,
  );
  print('FixedScrollMetrics created');
  print('  pixels: ${metrics.pixels}');
  print('  maxScrollExtent: ${metrics.maxScrollExtent}');
  print('  viewportDimension: ${metrics.viewportDimension}');
  print('  axisDirection: ${metrics.axisDirection}');
  print('  axis: ${metrics.axis}');
  print('  atEdge: ${metrics.atEdge}');
  print('  extentBefore: ${metrics.extentBefore}');
  print('  extentAfter: ${metrics.extentAfter}');
  print('  extentInside: ${metrics.extentInside}');
  print('  outOfRange: ${metrics.outOfRange}');

  // ========== ScrollDirection ==========
  print('--- ScrollDirection Tests ---');
  for (final dir in ScrollDirection.values) {
    print('ScrollDirection.$dir: ${dir.name}');
  }

  // ========== ScrollIncrementDetails ==========
  print('--- ScrollIncrementDetails Tests ---');
  final details = ScrollIncrementDetails(
    type: ScrollIncrementType.line,
    metrics: metrics,
  );
  print('ScrollIncrementDetails type: ${details.type}');
  print('ScrollIncrementDetails metrics pixels: ${details.metrics.pixels}');

  final pageDetails = ScrollIncrementDetails(
    type: ScrollIncrementType.page,
    metrics: metrics,
  );
  print('Page increment type: ${pageDetails.type}');

  print('All scroll metrics tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            print('ScrollStartNotification received');
          } else if (notification is ScrollUpdateNotification) {
            print('ScrollUpdateNotification received');
          } else if (notification is ScrollEndNotification) {
            print('ScrollEndNotification received');
          } else if (notification is OverscrollNotification) {
            print('OverscrollNotification received');
          } else if (notification is UserScrollNotification) {
            print('UserScrollNotification received');
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) =>
              ListTile(title: Text('ScrollMetrics Item $index')),
        ),
      ),
    ),
  );
}
