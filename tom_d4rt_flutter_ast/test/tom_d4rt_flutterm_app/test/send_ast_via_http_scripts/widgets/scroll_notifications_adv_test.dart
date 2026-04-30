// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollStartNotification, ScrollUpdateNotification,
// ScrollEndNotification, OverscrollNotification, UserScrollNotification,
// OverscrollIndicatorNotification, ScrollMetricsNotification
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('ScrollNotifications advanced test executing');

  // ========== FixedScrollMetrics for notification constructors ==========
  print('--- FixedScrollMetrics for notifications ---');
  final metrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 500.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 1.0,
  );
  print('FixedScrollMetrics created: pixels=${metrics.pixels}');

  // ========== ScrollStartNotification ==========
  print('--- ScrollStartNotification Tests ---');
  final startNotif = ScrollStartNotification(
    metrics: metrics,
    context: context,
  );
  print('ScrollStartNotification created');
  print('  depth: ${startNotif.depth}');
  print('  metrics.pixels: ${startNotif.metrics.pixels}');

  // ========== ScrollUpdateNotification ==========
  print('--- ScrollUpdateNotification Tests ---');
  final updateNotif = ScrollUpdateNotification(
    metrics: metrics,
    context: context,
    scrollDelta: 10.0,
  );
  print('ScrollUpdateNotification created');
  print('  scrollDelta: ${updateNotif.scrollDelta}');

  // ========== ScrollEndNotification ==========
  print('--- ScrollEndNotification Tests ---');
  final endNotif = ScrollEndNotification(metrics: metrics, context: context);
  print('ScrollEndNotification created');
  print('  depth: ${endNotif.depth}');

  // ========== OverscrollNotification ==========
  print('--- OverscrollNotification Tests ---');
  final overscrollNotif = OverscrollNotification(
    metrics: metrics,
    context: context,
    overscroll: 25.0,
  );
  print('OverscrollNotification created');
  print('  overscroll: ${overscrollNotif.overscroll}');

  // ========== UserScrollNotification ==========
  print('--- UserScrollNotification Tests ---');
  final userNotif = UserScrollNotification(
    metrics: metrics,
    context: context,
    direction: ScrollDirection.forward,
  );
  print('UserScrollNotification created');
  print('  direction: ${userNotif.direction}');

  // ========== OverscrollIndicatorNotification ==========
  print('--- OverscrollIndicatorNotification Tests ---');
  final indicatorNotif = OverscrollIndicatorNotification(leading: true);
  print('OverscrollIndicatorNotification created');
  print('  leading: ${indicatorNotif.leading}');
  indicatorNotif.disallowIndicator();
  print('  disallowIndicator called');

  // ========== ScrollMetricsNotification ==========
  print('--- ScrollMetricsNotification Tests ---');
  final metricsNotif = ScrollMetricsNotification(
    metrics: metrics,
    context: context,
  );
  print('ScrollMetricsNotification created');
  print('  metrics.maxScrollExtent: ${metricsNotif.metrics.maxScrollExtent}');

  print('All scroll notification tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          print('Received: ${notification.runtimeType}');
          return false;
        },
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        ),
      ),
    ),
  );
}
