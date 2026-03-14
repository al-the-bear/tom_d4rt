// D4rt test script: Comprehensive PathMetrics access and iteration tests
// Tests various ways to iterate and access PathMetrics from dart:ui
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetrics access test executing');

  // ========== BASIC PATHMETRICS ACCESS ==========
  print('--- Basic PathMetrics Access ---');

  // Create a simple path
  final rectPath = Path()..addRect(Rect.fromLTWH(0, 0, 100, 50));
  final metrics = rectPath.computeMetrics();
  print('PathMetrics type: ${metrics.runtimeType}');
  print('PathMetrics iterator type: ${metrics.iterator.runtimeType}');

  // Test .first access
  final firstMetric = metrics.first;
  print('First metric length: ${firstMetric.length}');
  print('First metric isClosed: ${firstMetric.isClosed}');
  print('First metric contourIndex: ${firstMetric.contourIndex}');

  // ========== ITERATOR PATTERN ==========
  print('--- Iterator Pattern ---');
  final iterPath = Path()
    ..addRect(Rect.fromLTWH(0, 0, 80, 40))
    ..addOval(Rect.fromCircle(center: Offset(100, 100), radius: 30));

  final iterMetrics = iterPath.computeMetrics();
  final iterator = iterMetrics.iterator;
  var contourCount = 0;
  while (iterator.moveNext()) {
    final m = iterator.current;
    print(
      'Contour $contourCount: length=${m.length.toStringAsFixed(1)}, closed=${m.isClosed}',
    );
    contourCount++;
  }
  print('Total contours via iterator: $contourCount');

  // ========== FOR-IN PATTERN ==========
  print('--- For-in Pattern ---');
  final forInPath = Path()
    ..moveTo(0, 0)
    ..lineTo(50, 0)
    ..lineTo(50, 50)
    ..close()
    ..moveTo(100, 0)
    ..lineTo(150, 0)
    ..lineTo(125, 50)
    ..close();

  var forInCount = 0;
  for (final metric in forInPath.computeMetrics()) {
    print('For-in contour $forInCount: ${metric.length.toStringAsFixed(1)}');
    forInCount++;
  }
  print('Total contours via for-in: $forInCount');

  // ========== .FIRST, .LAST, .SINGLE ==========
  print('--- Collection Methods ---');

  // Single contour path
  final singlePath = Path()..addOval(Rect.fromLTWH(0, 0, 60, 60));
  final singleMetrics = singlePath.computeMetrics();
  final single = singleMetrics.single;
  print('Single metric: ${single.length.toStringAsFixed(1)}');

  // First and last on multi-contour
  final multiPath = Path()
    ..addRect(Rect.fromLTWH(0, 0, 30, 30))
    ..addRect(Rect.fromLTWH(50, 0, 40, 40))
    ..addRect(Rect.fromLTWH(100, 0, 50, 50));

  final multiMetrics = multiPath.computeMetrics();
  print('First: ${multiMetrics.first.length.toStringAsFixed(1)}');
  print('Last: ${multiMetrics.last.length.toStringAsFixed(1)}');
  print('Length (count): ${multiMetrics.length}');

  // ========== TOLIST ==========
  print('--- toList Pattern ---');
  final listPath = Path()
    ..addOval(Rect.fromLTWH(0, 0, 20, 20))
    ..addOval(Rect.fromLTWH(30, 0, 30, 30))
    ..addOval(Rect.fromLTWH(70, 0, 40, 40));

  final metricsList = listPath.computeMetrics().toList();
  print('List length: ${metricsList.length}');
  for (var i = 0; i < metricsList.length; i++) {
    print('List[$i]: ${metricsList[i].length.toStringAsFixed(1)}');
  }

  // ========== TANGENT ACCESS ==========
  print('--- Tangent Access ---');
  final tangentPath = Path()..addRect(Rect.fromLTWH(0, 0, 100, 100));
  for (final metric in tangentPath.computeMetrics()) {
    // Get tangent at various positions
    final t0 = metric.getTangentForOffset(0);
    final tMid = metric.getTangentForOffset(metric.length / 2);
    final tEnd = metric.getTangentForOffset(metric.length);

    if (t0 != null) {
      print(
        'Tangent at 0: pos=${t0.position}, angle=${t0.angle.toStringAsFixed(2)}',
      );
    }
    if (tMid != null) {
      print('Tangent at mid: pos=${tMid.position}');
    }
    if (tEnd != null) {
      print('Tangent at end: pos=${tEnd.position}');
    }
  }

  // ========== EXTRACTPATH ==========
  print('--- extractPath Tests ---');
  final extractPath = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 40));
  for (final metric in extractPath.computeMetrics()) {
    final quarter = metric.extractPath(0, metric.length / 4);
    final half = metric.extractPath(0, metric.length / 2);
    final full = metric.extractPath(0, metric.length);

    print('Quarter path bounds: ${quarter.getBounds()}');
    print('Half path bounds: ${half.getBounds()}');
    print('Full path bounds: ${full.getBounds()}');
  }

  // ========== FORCECLOSED PARAMETER ==========
  print('--- forceClosed Parameter ---');
  final openPath = Path()
    ..moveTo(0, 0)
    ..lineTo(100, 0)
    ..lineTo(100, 100);
  // Not closed explicitly

  final openMetrics = openPath.computeMetrics(forceClosed: false);
  final closedMetrics = openPath.computeMetrics(forceClosed: true);

  print('Open metrics isClosed: ${openMetrics.first.isClosed}');
  print('Open metrics length: ${openMetrics.first.length.toStringAsFixed(1)}');
  print('Forced closed isClosed: ${closedMetrics.first.isClosed}');
  print(
    'Forced closed length: ${closedMetrics.first.length.toStringAsFixed(1)}',
  );

  // Store results for display
  final results = <String>[
    'Rect: ${firstMetric.length.toStringAsFixed(1)} (closed: ${firstMetric.isClosed})',
    'Circle circumference: ${(math.pi * 60).toStringAsFixed(1)}',
    'Multi-contour count: $forInCount',
    'List access works: ${metricsList.length} items',
  ];

  print('PathMetrics access test completed');

  // ========== RETURN WIDGET ==========
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PathMetrics Access Tests',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        // Results display
        ...results.map(
          (r) =>
              Padding(padding: EdgeInsets.only(bottom: 4), child: Text('• $r')),
        ),
        SizedBox(height: 16),

        // Visual path demo
        Text(
          'Path Visualizations:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        CustomPaint(size: Size(300, 200), painter: _PathMetricsPainter()),
        SizedBox(height: 16),

        // Access patterns summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Access Patterns:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text('• path.computeMetrics().first'),
              Text('• path.computeMetrics().last'),
              Text('• path.computeMetrics().single'),
              Text('• path.computeMetrics().toList()'),
              Text('• for (final m in path.computeMetrics())'),
              Text('• path.computeMetrics().iterator'),
              Text('• path.computeMetrics(forceClosed: true)'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PathMetricsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw path with extracted segments
    final path = Path()
      ..addOval(
        Rect.fromCenter(center: Offset(80, 80), width: 100, height: 100),
      );

    final metrics = path.computeMetrics().first;

    // Draw quarters in different colors
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.orange];
    final quarterLen = metrics.length / 4;

    for (var i = 0; i < 4; i++) {
      final segment = metrics.extractPath(i * quarterLen, (i + 1) * quarterLen);
      paint.color = colors[i];
      canvas.drawPath(segment, paint);
    }

    // Draw tangent indicators
    paint.color = Colors.black;
    paint.strokeWidth = 1.0;
    for (var i = 0; i < 8; i++) {
      final offset = (i / 8) * metrics.length;
      final tangent = metrics.getTangentForOffset(offset);
      if (tangent != null) {
        final pos = tangent.position;
        final dir = tangent.vector * 15;
        canvas.drawLine(pos, pos + dir, paint);
      }
    }

    // Label
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Segmented Circle',
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(30, 150));

    // Draw second path - rectangle
    final rectPath = Path()..addRect(Rect.fromLTWH(180, 30, 80, 80));
    paint.color = Colors.purple;
    paint.strokeWidth = 2.0;
    canvas.drawPath(rectPath, paint);

    final rectTextPainter = TextPainter(
      text: TextSpan(
        text: 'Rect Path',
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    rectTextPainter.paint(canvas, Offset(190, 120));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
