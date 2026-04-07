// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RelativePositionedTransition
// Demonstrates RelativePositionedTransition — an animated widget that
// transitions its child's position within a Stack according to a
// RelativeRectTween driven by an Animation<double>. Unlike
// PositionedTransition (which uses raw pixel offsets), this widget
// expresses positions relative to the parent's size, making it ideal
// for responsive animated layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RelativePositionedTransition Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What Is RelativePositionedTransition?
  // ============================================================
  print('=== Section 1: Concept ===');

  // RelativePositionedTransition animates a Positioned child
  // inside a Stack using RelativeRect values.
  //
  // Key ideas:
  //  - RelativeRect defines left, top, right, bottom insets from
  //    the parent boundaries.
  //  - The widget takes a RectTween and an Animation<double> to
  //    interpolate between the start and end rects.
  //  - It is the "relative" counterpart to PositionedTransition
  //    and animates layout rather than painting.
  //  - Perfect for responsive designs because positions are
  //    expressed as offsets from edges, not absolute coordinates.

  final conceptExplanation = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF1565C0), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.animation, size: 36.0, color: Color(0xFF1565C0)),
            SizedBox(width: 12.0),
            Text(
              'RelativePositionedTransition',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'An animated version of Positioned whose position within a '
          'Stack is expressed relative to the parent\'s edges. It '
          'transitions smoothly from one RelativeRect to another.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Constructor signature:\n'
            'RelativePositionedTransition({\n'
            '  required Animation<RelativeRect> rect,\n'
            '  required Widget child,\n'
            '})\n\n'
            'The rect animation drives the transition between\n'
            'two RelativeRect positions inside the parent Stack.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: RelativeRect Explained Visually
  // ============================================================
  print('=== Section 2: RelativeRect properties ===');

  // RelativeRect has four properties:
  //   left  — distance from parent's left edge to child's left edge
  //   top   — distance from parent's top edge to child's top edge
  //   right — distance from parent's right edge to child's right edge
  //   bottom — distance from parent's bottom edge to child's bottom edge
  //
  // When all four are 0, the child fills the entire parent.
  // When left=10, top=10, right=10, bottom=10, there's a 10px margin.

  Widget buildRectProperty(
    String name,
    String description,
    Color color,
    IconData icon,
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return Container(
      width: 260.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                ),
                SizedBox(height: 8.0),
                // Mini diagram: a Stack with a positioned child
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Stack(
                    children: [
                      // Edge labels
                      Positioned(
                        left: 0.0,
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          height: top > 0 ? 14.0 : 0.0,
                          color: top > 0
                              ? Colors.purple.withValues(alpha: 0.2)
                              : Colors.transparent,
                          alignment: Alignment.center,
                          child: top > 0
                              ? Text(
                                  'top: ${top.toInt()}',
                                  style: TextStyle(
                                    fontSize: 8.0,
                                    color: Colors.purple,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                      ),
                      // The positioned child itself
                      Positioned(
                        left: left,
                        top: top,
                        right: right,
                        bottom: bottom,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: color, width: 1.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Child',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'RelativeRect.fromLTRB(${left.toInt()}, ${top.toInt()}, '
                  '${right.toInt()}, ${bottom.toInt()})',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final rectProperties = Wrap(
    alignment: WrapAlignment.center,
    children: [
      buildRectProperty(
        'left',
        'Distance from parent\'s left edge. Pushing the child inward from the left.',
        Color(0xFF2196F3),
        Icons.arrow_forward,
        60.0,
        10.0,
        10.0,
        10.0,
      ),
      buildRectProperty(
        'top',
        'Distance from parent\'s top edge. Pushing the child downward.',
        Color(0xFF4CAF50),
        Icons.arrow_downward,
        10.0,
        50.0,
        10.0,
        10.0,
      ),
      buildRectProperty(
        'right',
        'Distance from parent\'s right edge. Constraining the child from the right.',
        Color(0xFFFF9800),
        Icons.arrow_back,
        10.0,
        10.0,
        60.0,
        10.0,
      ),
      buildRectProperty(
        'bottom',
        'Distance from parent\'s bottom edge. Constraining from the bottom.',
        Color(0xFFF44336),
        Icons.arrow_upward,
        10.0,
        10.0,
        10.0,
        50.0,
      ),
    ],
  );

  // ============================================================
  // SECTION 3: Static Positions — Before Animation
  // ============================================================
  print('=== Section 3: Static positions (start & end) ===');

  // Before showing the animated version, display the start and
  // end states side by side so the viewer can see what the
  // animation interpolates between.

  final startRect = RelativeRect.fromLTRB(10.0, 10.0, 150.0, 150.0);
  final endRect = RelativeRect.fromLTRB(150.0, 100.0, 10.0, 10.0);

  print('Start rect: left=${startRect.left}, top=${startRect.top}, '
      'right=${startRect.right}, bottom=${startRect.bottom}');
  print('End rect: left=${endRect.left}, top=${endRect.top}, '
      'right=${endRect.right}, bottom=${endRect.bottom}');

  Widget buildStaticRectDisplay(
    String label,
    RelativeRect rect,
    Color boxColor,
    Color borderColor,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: borderColor,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade400, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              // Grid lines for visual reference
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPainter(color: Colors.grey.shade200),
                ),
              ),
              // Positioned child at the given RelativeRect
              Positioned(
                left: rect.left,
                top: rect.top,
                right: rect.right,
                bottom: rect.bottom,
                child: Container(
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: borderColor, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: borderColor.withValues(alpha: 0.3),
                        blurRadius: 6.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.crop_square, color: borderColor, size: 20.0),
                      Text(
                        label,
                        style: TextStyle(fontSize: 9.0, color: borderColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'LTRB(${rect.left.toInt()}, ${rect.top.toInt()}, '
          '${rect.right.toInt()}, ${rect.bottom.toInt()})',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  final staticComparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Start & End Positions',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'RelativePositionedTransition interpolates between these two states:',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildStaticRectDisplay(
              'Start',
              startRect,
              Color(0xFF4CAF50).withValues(alpha: 0.3),
              Color(0xFF2E7D32),
            ),
            Column(
              children: [
                Icon(Icons.arrow_forward, size: 32.0, color: Colors.grey),
                Text(
                  'animates to',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            buildStaticRectDisplay(
              'End',
              endRect,
              Color(0xFFFF9800).withValues(alpha: 0.3),
              Color(0xFFE65100),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Multiple Transition Paths
  // ============================================================
  print('=== Section 4: Multiple transition paths ===');

  // Show several different RelativeRect transitions
  // happening simultaneously inside one Stack to illustrate
  // different movement patterns.

  final transitionData = <Map<String, dynamic>>[
    {
      'label': 'Corner to Corner',
      'description': 'Moves from top-left to bottom-right',
      'startLeft': 5.0,
      'startTop': 5.0,
      'startRight': 130.0,
      'startBottom': 130.0,
      'endLeft': 130.0,
      'endTop': 130.0,
      'endRight': 5.0,
      'endBottom': 5.0,
      'color': Color(0xFFE91E63),
    },
    {
      'label': 'Expand',
      'description': 'Grows from small center to fill',
      'startLeft': 60.0,
      'startTop': 60.0,
      'startRight': 60.0,
      'startBottom': 60.0,
      'endLeft': 5.0,
      'endTop': 5.0,
      'endRight': 5.0,
      'endBottom': 5.0,
      'color': Color(0xFF2196F3),
    },
    {
      'label': 'Slide Right',
      'description': 'Slides horizontally while keeping size',
      'startLeft': 5.0,
      'startTop': 40.0,
      'startRight': 100.0,
      'startBottom': 80.0,
      'endLeft': 100.0,
      'endTop': 40.0,
      'endRight': 5.0,
      'endBottom': 80.0,
      'color': Color(0xFF4CAF50),
    },
    {
      'label': 'Shrink Down',
      'description': 'Collapses from full to a small area',
      'startLeft': 5.0,
      'startTop': 5.0,
      'startRight': 5.0,
      'startBottom': 5.0,
      'endLeft': 50.0,
      'endTop': 50.0,
      'endRight': 50.0,
      'endBottom': 50.0,
      'color': Color(0xFFFF9800),
    },
  ];

  final pathCards = <Widget>[];
  for (final data in transitionData) {
    final sLeft = data['startLeft'] as double;
    final sTop = data['startTop'] as double;
    final sRight = data['startRight'] as double;
    final sBottom = data['startBottom'] as double;
    final eLeft = data['endLeft'] as double;
    final eTop = data['endTop'] as double;
    final eRight = data['endRight'] as double;
    final eBottom = data['endBottom'] as double;
    final color = data['color'] as Color;
    final label = data['label'] as String;
    final desc = data['description'] as String;

    print('Path "$label": ($sLeft,$sTop,$sRight,$sBottom) -> '
        '($eLeft,$eTop,$eRight,$eBottom)');

    // Show two snapshots: start and end overlaid in the same Stack
    pathCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: color,
              ),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  // Start position (dashed-look with opacity)
                  Positioned(
                    left: sLeft,
                    top: sTop,
                    right: sRight,
                    bottom: sBottom,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: color.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: color.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                  // End position (solid)
                  Positioned(
                    left: eLeft,
                    top: eTop,
                    right: eRight,
                    bottom: eBottom,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: color, width: 2.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'End',
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Arrow overlay
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 4.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '→ transition →',
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Interpolation at Multiple Progress Values
  // ============================================================
  print('=== Section 5: Interpolation snapshots ===');

  // Show what the rect looks like at 0%, 25%, 50%, 75%, 100%
  // This demonstrates the linear interpolation of RelativeRect.

  final interpStart = RelativeRect.fromLTRB(10.0, 10.0, 160.0, 130.0);
  final interpEnd = RelativeRect.fromLTRB(160.0, 130.0, 10.0, 10.0);

  final progressValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final snapshots = <Widget>[];

  for (final t in progressValues) {
    final lerped = RelativeRect.lerp(interpStart, interpEnd, t)!;
    final pct = (t * 100).toInt();

    print('  t=$t → left=${lerped.left.toStringAsFixed(1)}, '
        'top=${lerped.top.toStringAsFixed(1)}, '
        'right=${lerped.right.toStringAsFixed(1)}, '
        'bottom=${lerped.bottom.toStringAsFixed(1)}');

    snapshots.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color.lerp(
                  Color(0xFF4CAF50),
                  Color(0xFFFF5722),
                  t,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '$pct%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              height: 130.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: lerped.left * 0.65,
                    top: lerped.top * 0.65,
                    right: lerped.right * 0.65,
                    bottom: lerped.bottom * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.lerp(
                              Color(0xFF4CAF50),
                              Color(0xFFFF5722),
                              t,
                            )!
                                .withValues(alpha: 0.6),
                            Color.lerp(
                              Color(0xFF4CAF50),
                              Color(0xFFFF5722),
                              t,
                            )!
                                .withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: Color.lerp(
                            Color(0xFF4CAF50),
                            Color(0xFFFF5722),
                            t,
                          )!,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              'L:${lerped.left.toInt()} T:${lerped.top.toInt()}\n'
              'R:${lerped.right.toInt()} B:${lerped.bottom.toInt()}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 8.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final interpolationSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.deepOrange.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'RelativeRect.lerp Interpolation',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each snapshot shows the interpolated rect at a progress value.\n'
          'The color transitions from green (0%) to orange (100%).',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: snapshots,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison — Positioned vs Relative
  // ============================================================
  print('=== Section 6: Positioned vs RelativePositioned ===');

  // Side-by-side showing how Positioned uses absolute pixel
  // values while RelativePositionedTransition uses edge-relative
  // insets. This distinction matters for responsive layouts.

  Widget buildComparisonBox(
    String title,
    String subtitle,
    List<Map<String, dynamic>> items,
    Color accentColor,
  ) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accentColor, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.compare_arrows,
                  color: accentColor,
                  size: 22.0,
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: accentColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: accentColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...items.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      item['icon'] as IconData,
                      color: accentColor,
                      size: 14.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  final comparisonRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: buildComparisonBox(
            'PositionedTransition',
            'Absolute pixel coordinates',
            [
              {
                'icon': Icons.straighten,
                'title': 'Absolute Rect',
                'desc': 'Uses Rect(left, top, width, height) in pixels',
              },
              {
                'icon': Icons.devices,
                'title': 'Fixed layout',
                'desc': 'Does not adapt to parent size changes',
              },
              {
                'icon': Icons.speed,
                'title': 'Direct',
                'desc': 'Good when exact pixel positions are known',
              },
            ],
            Color(0xFF9C27B0),
          ),
        ),
        Expanded(
          child: buildComparisonBox(
            'RelativePositionedTransition',
            'Edge-relative insets',
            [
              {
                'icon': Icons.fullscreen,
                'title': 'RelativeRect',
                'desc': 'Uses insets from parent edges (left, top, right, bottom)',
              },
              {
                'icon': Icons.aspect_ratio,
                'title': 'Responsive',
                'desc': 'Adapts when parent size changes',
              },
              {
                'icon': Icons.widgets,
                'title': 'Stack-friendly',
                'desc': 'Perfect for Stack-based animated layouts',
              },
            ],
            Color(0xFF00897B),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Use-Case Gallery — Dashboard Cards
  // ============================================================
  print('=== Section 7: Dashboard card rearrangement ===');

  // Simulate a dashboard where cards rearrange themselves.
  // Show several "states" of the dashboard at different t values.

  Widget buildDashboardCard(
    String title,
    IconData icon,
    Color color,
    String value,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22.0),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white70, fontSize: 9.0),
          ),
        ],
      ),
    );
  }

  // Layout A: cards in quadrants
  final dashboardA = Container(
    height: 180.0,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 5.0,
          top: 5.0,
          right: 120.0,
          bottom: 95.0,
          child: buildDashboardCard(
            'Revenue',
            Icons.attach_money,
            Color(0xFF4CAF50),
            '\$42K',
          ),
        ),
        Positioned(
          left: 120.0,
          top: 5.0,
          right: 5.0,
          bottom: 95.0,
          child: buildDashboardCard(
            'Users',
            Icons.people,
            Color(0xFF2196F3),
            '1.2K',
          ),
        ),
        Positioned(
          left: 5.0,
          top: 95.0,
          right: 120.0,
          bottom: 5.0,
          child: buildDashboardCard(
            'Orders',
            Icons.shopping_cart,
            Color(0xFFFF9800),
            '356',
          ),
        ),
        Positioned(
          left: 120.0,
          top: 95.0,
          right: 5.0,
          bottom: 5.0,
          child: buildDashboardCard(
            'Rating',
            Icons.star,
            Color(0xFFE91E63),
            '4.8',
          ),
        ),
      ],
    ),
  );

  // Layout B: cards rearranged (horizontal strip)
  final dashboardB = Container(
    height: 120.0,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 5.0,
          top: 10.0,
          right: 180.0,
          bottom: 10.0,
          child: buildDashboardCard(
            'Revenue',
            Icons.attach_money,
            Color(0xFF4CAF50),
            '\$42K',
          ),
        ),
        Positioned(
          left: 65.0,
          top: 10.0,
          right: 120.0,
          bottom: 10.0,
          child: buildDashboardCard(
            'Users',
            Icons.people,
            Color(0xFF2196F3),
            '1.2K',
          ),
        ),
        Positioned(
          left: 125.0,
          top: 10.0,
          right: 60.0,
          bottom: 10.0,
          child: buildDashboardCard(
            'Orders',
            Icons.shopping_cart,
            Color(0xFFFF9800),
            '356',
          ),
        ),
        Positioned(
          left: 185.0,
          top: 10.0,
          right: 5.0,
          bottom: 10.0,
          child: buildDashboardCard(
            'Rating',
            Icons.star,
            Color(0xFFE91E63),
            '4.8',
          ),
        ),
      ],
    ),
  );

  final dashboardSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Use Case: Dashboard Card Rearrangement',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'RelativePositionedTransition animates cards from one layout to another.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Text(
          'Layout A — Grid',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        dashboardA,
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_vert, color: Colors.grey),
            SizedBox(width: 8.0),
            Text(
              'RelativePositionedTransition animates between these',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Layout B — Horizontal Strip',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        dashboardB,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Edge-Relative vs Absolute — Visual Proof
  // ============================================================
  print('=== Section 8: Edge-relative vs absolute proof ===');

  // Show the SAME RelativeRect in two containers of different
  // sizes to prove that edge-relative positioning adapts.

  Widget buildSizedContainer(double width, double height, String sizeLabel) {
    final rr = RelativeRect.fromLTRB(10.0, 10.0, 10.0, 10.0);
    return Column(
      children: [
        Text(
          sizeLabel,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: Color(0xFF5D4037),
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFF8F00), width: 1.5),
          ),
          child: Stack(
            children: [
              Positioned(
                left: rr.left,
                top: rr.top,
                right: rr.right,
                bottom: rr.bottom,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFF8F00).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Color(0xFFFF8F00)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'LTRB(10,10,10,10)',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          '${width.toInt()} × ${height.toInt()} parent',
          style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  final responsiveProof = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFF8F00)),
    ),
    child: Column(
      children: [
        Text(
          'Responsive Proof: Same RelativeRect, Different Parents',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'RelativeRect.fromLTRB(10, 10, 10, 10) gives a 10px margin '
          'regardless of parent size. The child automatically fills '
          'the remaining space — proving edge-relative layout.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buildSizedContainer(100.0, 80.0, 'Small'),
            buildSizedContainer(160.0, 120.0, 'Medium'),
            buildSizedContainer(220.0, 160.0, 'Large'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: RelativeRect.fill and fromSize
  // ============================================================
  print('=== Section 9: Factory constructors ===');

  final factoryExamples = <Widget>[
    // fill
    Container(
      width: 260.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFF7B1FA2), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'RelativeRect.fill',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Color(0xFF7B1FA2),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'All insets are 0 — child fills the entire parent.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF7B1FA2).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Color(0xFF7B1FA2)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Fills parent completely',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xFF4A148C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'const RelativeRect.fill\n'
              '// == RelativeRect.fromLTRB(0, 0, 0, 0)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color(0xFF4A148C),
              ),
            ),
          ),
        ],
      ),
    ),
    // fromSize
    Container(
      width: 260.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFF00695C), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'RelativeRect.fromSize',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Color(0xFF00695C),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Creates a RelativeRect from a child Rect within a '
            'parent of given Size.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20.0,
                  top: 15.0,
                  right: 60.0,
                  bottom: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF00695C).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Color(0xFF00695C)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Child rect',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xFF004D40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'RelativeRect.fromSize(\n'
              '  Rect.fromLTWH(20, 15, w, h),\n'
              '  Size(parentW, parentH),\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color(0xFF004D40),
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  // ============================================================
  // SECTION 10: Practical Code Patterns
  // ============================================================
  print('=== Section 10: Code patterns ===');

  final codePatterns = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Practical Code Pattern',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283593),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1A237E),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// 1. Create an AnimationController\n'
            'final controller = AnimationController(\n'
            '  duration: Duration(milliseconds: 600),\n'
            '  vsync: this,\n'
            ');\n\n'
            '// 2. Define a RelativeRectTween\n'
            'final rectTween = RelativeRectTween(\n'
            '  begin: RelativeRect.fromLTRB(0, 0, 200, 200),\n'
            '  end: RelativeRect.fromLTRB(200, 200, 0, 0),\n'
            ');\n\n'
            '// 3. Build the transition widget\n'
            'Stack(\n'
            '  children: [\n'
            '    RelativePositionedTransition(\n'
            '      rect: rectTween.animate(\n'
            '        CurvedAnimation(\n'
            '          parent: controller,\n'
            '          curve: Curves.easeInOut,\n'
            '        ),\n'
            '      ),\n'
            '      child: MyAnimatedCard(),\n'
            '    ),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF90CAF9),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _buildCodeStep(
          '1',
          'AnimationController',
          'Drives the animation. Provide vsync and duration.',
          Color(0xFF283593),
        ),
        SizedBox(height: 6.0),
        _buildCodeStep(
          '2',
          'RelativeRectTween',
          'Defines start and end rects. Each value is an edge inset.',
          Color(0xFF283593),
        ),
        SizedBox(height: 6.0),
        _buildCodeStep(
          '3',
          'RelativePositionedTransition',
          'Place inside a Stack. It reads the animated RelativeRect '
              'and positions its child accordingly each frame.',
          Color(0xFF283593),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Curve Comparison Visual
  // ============================================================
  print('=== Section 11: Curves affect transition feel ===');

  final curveData = <Map<String, dynamic>>[
    {'name': 'linear', 'value': 0.3, 'color': Color(0xFF616161)},
    {'name': 'easeIn', 'value': 0.09, 'color': Color(0xFF2196F3)},
    {'name': 'easeOut', 'value': 0.51, 'color': Color(0xFF4CAF50)},
    {'name': 'easeInOut', 'value': 0.15, 'color': Color(0xFFFF9800)},
    {'name': 'bounceOut', 'value': 0.3, 'color': Color(0xFFE91E63)},
  ];

  final curveWidgets = <Widget>[];
  for (final curve in curveData) {
    final cName = curve['name'] as String;
    final cValue = curve['value'] as double;
    final cColor = curve['color'] as Color;

    final lerpedRect = RelativeRect.lerp(
      RelativeRect.fromLTRB(5.0, 5.0, 95.0, 70.0),
      RelativeRect.fromLTRB(95.0, 70.0, 5.0, 5.0),
      cValue,
    )!;

    curveWidgets.add(
      Container(
        width: 150.0,
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: cColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                cName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              height: 90.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: lerpedRect.left,
                    top: lerpedRect.top,
                    right: lerpedRect.right,
                    bottom: lerpedRect.bottom,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: cColor, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'at t=0.3 → ${(cValue * 100).toInt()}% progress',
              style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  final curveSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Curve Impact on Transition',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Same animation time t=0.3, but different curves produce '
          'different progress values. This changes how far the element '
          'has moved at any given moment.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: curveWidgets),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Summary & Best Practices
  // ============================================================
  print('=== Section 12: Summary ===');

  final summaryItems = <Widget>[
    _buildSummaryItem(
      Icons.layers,
      'Stack-based',
      'Must be used inside a Stack widget; positions via '
          'RelativeRect edge insets',
      Color(0xFF1565C0),
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.aspect_ratio,
      'Responsive',
      'Positions adapt to parent size because they are '
          'distances from edges, not absolute coordinates',
      Color(0xFF2E7D32),
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.animation,
      'Animation-driven',
      'Takes an Animation<RelativeRect> — typically created from '
          'a RelativeRectTween and AnimationController',
      Color(0xFFE65100),
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.compare,
      'vs PositionedTransition',
      'PositionedTransition uses absolute Rect; '
          'RelativePositionedTransition uses relative edge insets',
      Color(0xFF7B1FA2),
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.dashboard,
      'Use cases',
      'Dashboard rearrangement, adaptive panels, drawer animations, '
          'layout mode transitions',
      Color(0xFF00838F),
    ),
  ];

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFA000), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFFFF8F00), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary & Best Practices',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...summaryItems,
      ],
    ),
  );

  print('RelativePositionedTransition Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1976D2)],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.animation, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RelativePositionedTransition',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Animated Stack positioning with edge-relative rects',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        // Section 1: Concept
        conceptExplanation,
        SizedBox(height: 16.0),

        // Section 2: RelativeRect properties
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. RelativeRect Properties',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: rectProperties,
        ),
        SizedBox(height: 24.0),

        // Section 3: Start & End states
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Static Start & End Positions',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        staticComparison,
        SizedBox(height: 24.0),

        // Section 4: Multiple paths
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Transition Path Gallery',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: pathCards,
          ),
        ),
        SizedBox(height: 24.0),

        // Section 5: Interpolation
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Interpolation Snapshots',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        interpolationSection,
        SizedBox(height: 24.0),

        // Section 6: Comparison
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Positioned vs RelativePositioned',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparisonRow,
        SizedBox(height: 24.0),

        // Section 7: Dashboard
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Dashboard Rearrangement',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        dashboardSection,
        SizedBox(height: 24.0),

        // Section 8: Responsive proof
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Responsive Layout Proof',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        responsiveProof,
        SizedBox(height: 24.0),

        // Section 9: Factory constructors
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '9. Factory Constructors',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: factoryExamples,
          ),
        ),
        SizedBox(height: 24.0),

        // Section 10: Code patterns
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '10. Code Pattern',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        codePatterns,
        SizedBox(height: 24.0),

        // Section 11: Curves
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '11. Curve Impact',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        curveSection,
        SizedBox(height: 24.0),

        // Section 12: Summary
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '12. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helper: Grid painter for visual reference
// ================================================================
class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    for (double x = 0; x <= size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ================================================================
// Helper: Code step label
// ================================================================
Widget _buildCodeStep(
  String number,
  String title,
  String description,
  Color color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );
}

// ================================================================
// Helper: Summary item
// ================================================================
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
