// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ProgressIndicator family from material
// Deep Demo: Visual demonstration of LinearProgressIndicator, CircularProgressIndicator, RefreshProgressIndicator
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ProgressIndicator Family Deep Demo executing');

  // ============================================================
  // SECTION 1: ProgressIndicator family concept overview
  // ============================================================
  print('=== Section 1: ProgressIndicator Family Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: ProgressIndicator (abstract)
  conceptCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.donut_large, size: 40.0, color: Colors.indigo),
          SizedBox(height: 8.0),
          Text(
            'ProgressIndicator',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Abstract base for all progress widgets',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Linear
  conceptCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.linear_scale, size: 40.0, color: Colors.teal),
          SizedBox(height: 8.0),
          Text(
            'LinearProgressIndicator',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.0),
          Text(
            'Horizontal bar — best for known step ranges',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Circular
  conceptCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.refresh, size: 40.0, color: Colors.deepPurple),
          SizedBox(height: 8.0),
          Text(
            'CircularProgressIndicator',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.0),
          Text(
            'Compact disc — best for inline or unbounded waits',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.deepPurple.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 4: Refresh
  conceptCards.add(
    Container(
      width: 180.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.sync, size: 40.0, color: Colors.orange.shade800),
          SizedBox(height: 8.0),
          Text(
            'RefreshProgressIndicator',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.0),
          Text(
            'Compact pull-to-refresh circular variant',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: LinearProgressIndicator determinate gallery
  // ============================================================
  print('=== Section 2: LinearProgressIndicator Determinate Gallery ===');

  // Five determinate steps: 0%, 25%, 50%, 75%, 100%
  final linearSteps = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final linearStepLabels = <String>[
    'Empty',
    'Quarter',
    'Half',
    'Three-Quarter',
    'Complete',
  ];

  final linearDeterminateCards = <Widget>[];
  for (int i = 0; i < linearSteps.length; i++) {
    final v = linearSteps[i];
    final label = linearStepLabels[i];
    final percent = (v * 100).toInt();
    print('LinearProgressIndicator step $i value=$v -> $percent%');

    final bar = LinearProgressIndicator(
      value: v,
      backgroundColor: Colors.blueGrey.shade100,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
      minHeight: 8.0,
      semanticsLabel: '$label progress',
      // Fix(H23): Flutter's accessibility-semantics check parses the
      // progress value as a number against minValue/maxValue. Strings
      // like "0 percent" or "0%" fail the parse and emit
      // "Progress bar value, minValue, and maxValue must be valid
      // numbers." Pass the bare numeric string. See
      // doc/testlog_20260522-1328-issue-analysis entry #23.
      semanticsValue: '$percent',
    );

    linearDeterminateCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blue.shade100, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.shade300, width: 2.0),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '$percent%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: bar,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${linearDeterminateCards.length} linear determinate cards');

  // ============================================================
  // SECTION 3: LinearProgressIndicator indeterminate
  // ============================================================
  print('=== Section 3: LinearProgressIndicator Indeterminate (value: null) ===');

  final indeterminateLinear = LinearProgressIndicator(
    backgroundColor: Colors.purple.shade50,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple.shade600),
    minHeight: 6.0,
    semanticsLabel: 'Indeterminate progress',
  );

  final indeterminateLinearPanel = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.all_inclusive, color: Colors.purple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Indeterminate frame (single still snapshot)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'When value is null, the bar animates a sweeping motion in a real app. '
          'Here we render the static frame produced by the test runner.',
          style: TextStyle(fontSize: 12.0, color: Colors.purple.shade700),
        ),
        SizedBox(height: 12.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: indeterminateLinear,
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'value: null  -> indeterminate',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created indeterminate linear panel');

  // ============================================================
  // SECTION 4: Styled Linear variants
  // ============================================================
  print('=== Section 4: Styled Linear Variants ===');

  // Variant A: minHeight stack
  final minHeightVariants = <Widget>[];
  final heights = <double>[2.0, 6.0, 10.0, 16.0];
  for (final h in heights) {
    minHeightVariants.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                'h=${h.toInt()}px',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: LinearProgressIndicator(
                  value: 0.6,
                  minHeight: h,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final styledLinearCards = <Widget>[];

  styledLinearCards.add(
    Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.height, color: Colors.indigo, size: 20.0),
              SizedBox(width: 6.0),
              Text(
                'minHeight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ...minHeightVariants,
        ],
      ),
    ),
  );

  // Variant B: backgroundColor
  styledLinearCards.add(
    Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.pink.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_color_fill, color: Colors.pink, size: 20.0),
              SizedBox(width: 6.0),
              Text(
                'backgroundColor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: 0.55,
              minHeight: 10.0,
              backgroundColor: Colors.pink.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade700),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'value: 0.55 (55%)',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );

  // Variant C: color
  styledLinearCards.add(
    Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: Colors.green, size: 20.0),
              SizedBox(width: 6.0),
              Text(
                'color (direct)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: 0.8,
              minHeight: 10.0,
              color: Colors.green.shade600,
              backgroundColor: Colors.green.shade50,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'color: Colors.green.shade600 (80%)',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
  );

  // Variant D: valueColor (AlwaysStoppedAnimation)
  styledLinearCards.add(
    Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.animation, color: Colors.deepOrange, size: 20.0),
              SizedBox(width: 6.0),
              Text(
                'valueColor (Animation<Color>)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: 0.35,
              minHeight: 10.0,
              backgroundColor: Colors.deepOrange.shade50,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.deepOrange.shade700,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'AlwaysStoppedAnimation<Color>(Colors.deepOrange.shade700)',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
  );

  print('Created ${styledLinearCards.length} styled linear cards');

  // ============================================================
  // SECTION 5: CircularProgressIndicator determinate gallery
  // ============================================================
  print('=== Section 5: CircularProgressIndicator Determinate Gallery ===');

  final circularSteps = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final circularStepLabels = <String>[
    'Empty',
    'Quarter',
    'Half',
    'Three-Quarter',
    'Complete',
  ];

  final circularDeterminateCards = <Widget>[];
  for (int i = 0; i < circularSteps.length; i++) {
    final v = circularSteps[i];
    final percent = (v * 100).toInt();
    final label = circularStepLabels[i];
    print('CircularProgressIndicator step $i value=$v -> $percent%');

    final indicator = CircularProgressIndicator(
      value: v,
      strokeWidth: 6.0,
      backgroundColor: Colors.deepPurple.shade50,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade600),
      semanticsLabel: '$label progress',
      // Fix(H23): same as the linear case above — bare numeric string.
      semanticsValue: '$percent',
    );

    circularDeterminateCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Colors.deepPurple.shade100, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.deepPurple.shade900,
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: 64.0,
              height: 64.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(width: 64.0, height: 64.0, child: indicator),
                  Text(
                    '$percent%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'value: $v',
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print(
    'Created ${circularDeterminateCards.length} circular determinate cards',
  );

  // ============================================================
  // SECTION 6: CircularProgressIndicator styled
  // ============================================================
  print('=== Section 6: CircularProgressIndicator Styled ===');

  final styledCircularCards = <Widget>[];

  // Stroke width variants
  styledCircularCards.add(
    Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade200, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'strokeWidth: 2',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              backgroundColor: Colors.blue.shade50,
            ),
          ),
          SizedBox(height: 6.0),
          Text('70%', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    ),
  );

  styledCircularCards.add(
    Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'strokeWidth: 10',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 10.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
              backgroundColor: Colors.blue.shade50,
            ),
          ),
          SizedBox(height: 6.0),
          Text('70%', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    ),
  );

  // Stroke cap variants
  styledCircularCards.add(
    Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade200, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'strokeCap: round',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(
              value: 0.65,
              strokeWidth: 8.0,
              strokeCap: StrokeCap.round,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              backgroundColor: Colors.teal.shade50,
            ),
          ),
          SizedBox(height: 6.0),
          Text('65%', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    ),
  );

  styledCircularCards.add(
    Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'strokeCap: square',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(
              value: 0.65,
              strokeWidth: 8.0,
              strokeCap: StrokeCap.square,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade800),
              backgroundColor: Colors.teal.shade50,
            ),
          ),
          SizedBox(height: 6.0),
          Text('65%', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    ),
  );

  // Stroke align variants
  styledCircularCards.add(
    Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.amber.shade300, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'strokeAlign: -1 (inside)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(
              value: 0.5,
              strokeWidth: 8.0,
              strokeAlign: -1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber.shade800),
              backgroundColor: Colors.amber.shade50,
            ),
          ),
          SizedBox(height: 6.0),
          Text('50%', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    ),
  );

  styledCircularCards.add(
    Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.amber.shade400, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'strokeAlign: 1 (outside)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: CircularProgressIndicator(
              value: 0.5,
              strokeWidth: 8.0,
              strokeAlign: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber.shade900),
              backgroundColor: Colors.amber.shade50,
            ),
          ),
          SizedBox(height: 6.0),
          Text('50%', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    ),
  );

  print('Created ${styledCircularCards.length} styled circular cards');

  // ============================================================
  // SECTION 7: RefreshProgressIndicator gallery
  // ============================================================
  print('=== Section 7: RefreshProgressIndicator Gallery ===');

  final refreshCards = <Widget>[];

  // Default
  refreshCards.add(
    Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'Default',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: RefreshProgressIndicator(),
          ),
          SizedBox(height: 8.0),
          Text(
            'indeterminate',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  // Colored
  refreshCards.add(
    Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'Colored',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: RefreshProgressIndicator(
              backgroundColor: Colors.orange.shade50,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
              strokeWidth: 3.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'orange theme',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  // Determinate
  refreshCards.add(
    Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade400, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'Determinate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: RefreshProgressIndicator(
              value: 0.45,
              backgroundColor: Colors.orange.shade50,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              strokeWidth: 3.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '45% pulled',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  // Padded
  refreshCards.add(
    Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade500, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'Custom padding',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 56.0,
            height: 56.0,
            child: RefreshProgressIndicator(
              value: 0.85,
              backgroundColor: Colors.amber.shade50,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber.shade800),
              strokeWidth: 4.0,
              semanticsLabel: 'Refreshing',
              // Fix(H23): bare numeric semantics value (see top of file).
              semanticsValue: '85',
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'thicker stroke',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${refreshCards.length} refresh indicator cards');

  // ============================================================
  // SECTION 8: Themed gallery via ProgressIndicatorThemeData
  // ============================================================
  print('=== Section 8: Themed via ProgressIndicatorThemeData ===');

  final themedTheme = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.pink.shade700,
      linearTrackColor: Colors.pink.shade50,
      linearMinHeight: 12.0,
      circularTrackColor: Colors.pink.shade50,
      refreshBackgroundColor: Colors.pink.shade50,
    ),
  );

  final themedDefaultTheme = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.blueGrey.shade500,
      linearTrackColor: Colors.blueGrey.shade100,
      linearMinHeight: 4.0,
      circularTrackColor: Colors.blueGrey.shade100,
    ),
  );

  final themedPanel = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.pink.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.style, color: Colors.pink.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ProgressIndicatorThemeData override',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Theme(
                data: themedDefaultTheme,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blueGrey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Default theme',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade800,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      LinearProgressIndicator(value: 0.55),
                      SizedBox(height: 12.0),
                      SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: CircularProgressIndicator(value: 0.55),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '55%',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Theme(
                data: themedTheme,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.pink.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Pink theme',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade800,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      LinearProgressIndicator(value: 0.55),
                      SizedBox(height: 12.0),
                      SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: CircularProgressIndicator(value: 0.55),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '55%',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.pink.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Theme(data: ThemeData(progressIndicatorTheme: ...))\n'
            '  color, linearTrackColor, linearMinHeight,\n'
            '  circularTrackColor, refreshBackgroundColor',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.pink.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  print('Created themed gallery panel');

  // ============================================================
  // SECTION 9: Real-world layouts
  // ============================================================
  print('=== Section 9: Real-world Layouts ===');

  // Download card
  final downloadValue = 0.62;
  final downloadCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.cloud_download,
                color: Colors.blue.shade700,
                size: 24.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'flutter_sdk_3.24.5.tar.xz',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    '380 MB of 612 MB',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${(downloadValue * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: LinearProgressIndicator(
            value: downloadValue,
            minHeight: 6.0,
            backgroundColor: Colors.blue.shade50,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
            semanticsLabel: 'Download progress',
            // Fix(H23): bare numeric semantics value (see top of file).
            semanticsValue: '${(downloadValue * 100).toInt()}',
          ),
        ),
      ],
    ),
  );

  // Upload card with circular
  final uploadValue = 0.28;
  final uploadCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.08),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 56.0,
              height: 56.0,
              child: CircularProgressIndicator(
                value: uploadValue,
                strokeWidth: 5.0,
                strokeCap: StrokeCap.round,
                backgroundColor: Colors.green.shade50,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
              ),
            ),
            Text(
              '${(uploadValue * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uploading photos.zip',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
              SizedBox(height: 4.0),
              Text(
                '$uploadValue • estimated 4 minutes left',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'in progress',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Multi-step wizard
  final wizardStep = 2; // 0-based, of 4 total steps
  final wizardTotal = 4;
  final wizardValue = (wizardStep + 1) / wizardTotal;
  final wizardCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account setup',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.deepPurple.shade900,
              ),
            ),
            Text(
              'Step ${wizardStep + 1} of $wizardTotal',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: LinearProgressIndicator(
            value: wizardValue,
            minHeight: 8.0,
            backgroundColor: Colors.deepPurple.shade50,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.deepPurple.shade600,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(wizardTotal, (i) {
            final done = i <= wizardStep;
            return Column(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: done
                        ? Colors.deepPurple.shade600
                        : Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.deepPurple.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: done
                        ? Icon(Icons.check, color: Colors.white, size: 16.0)
                        : Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade700,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  ['Profile', 'Email', 'Plan', 'Done'][i],
                  style: TextStyle(
                    fontSize: 10.0,
                    color: done
                        ? Colors.deepPurple.shade800
                        : Colors.grey.shade600,
                    fontWeight: done ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    ),
  );

  print('Created real-world layout cards');

  // ============================================================
  // SECTION 10: Code examples
  // ============================================================
  print('=== Section 10: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Linear determinate\n'
            'LinearProgressIndicator(\n'
            '  value: 0.5,\n'
            '  minHeight: 8.0,\n'
            '  backgroundColor: Colors.grey.shade200,\n'
            '  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),\n'
            '  semanticsLabel: "Half complete",\n'
            '  semanticsValue: "50%",\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Circular styled\n'
            'CircularProgressIndicator(\n'
            '  value: 0.75,\n'
            '  strokeWidth: 6.0,\n'
            '  strokeCap: StrokeCap.round,\n'
            '  strokeAlign: 1.0,\n'
            '  backgroundColor: Colors.purple.shade50,\n'
            '  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyan.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Refresh inset variant\n'
            'RefreshProgressIndicator(\n'
            '  value: 0.45,\n'
            '  strokeWidth: 3.0,\n'
            '  backgroundColor: Colors.orange.shade50,\n'
            '  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.orange.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Themed via ProgressIndicatorThemeData\n'
            'Theme(\n'
            '  data: ThemeData(\n'
            '    progressIndicatorTheme: ProgressIndicatorThemeData(\n'
            '      color: Colors.pink.shade700,\n'
            '      linearTrackColor: Colors.pink.shade50,\n'
            '      linearMinHeight: 12.0,\n'
            '      circularTrackColor: Colors.pink.shade50,\n'
            '      refreshBackgroundColor: Colors.pink.shade50,\n'
            '    ),\n'
            '  ),\n'
            '  child: LinearProgressIndicator(value: 0.55),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.pink.shade200,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code example panels');

  // ============================================================
  // SECTION 11: Summary
  // ============================================================
  print('=== Section 11: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.linear_scale,
          'Linear vs Circular',
          'Linear for long known ranges, circular for compact or unbounded waits',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.all_inclusive,
          'Determinate vs Indeterminate',
          'value: 0.0..1.0 shows progress; value: null sweeps',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.palette,
          'Color trio: color / backgroundColor / valueColor',
          'valueColor takes precedence; use AlwaysStoppedAnimation<Color> for static',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'Stroke controls',
          'strokeWidth, strokeCap, strokeAlign tune the circular ring shape',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.style,
          'ProgressIndicatorThemeData',
          'Apply consistent styling across the app via Theme',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.accessibility_new,
          'Semantics',
          'semanticsLabel + semanticsValue make progress screen-reader friendly',
          Colors.green,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('ProgressIndicator Family Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.25),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.donut_large, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ProgressIndicator Family',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Linear • Circular • Refresh',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. ProgressIndicator family overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. LinearProgressIndicator determinate gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...linearDeterminateCards,
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. LinearProgressIndicator indeterminate',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        indeterminateLinearPanel,
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. Styled Linear variants',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: styledLinearCards),
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. CircularProgressIndicator determinate gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: circularDeterminateCards,
        ),
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. CircularProgressIndicator styled',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: styledCircularCards),
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. RefreshProgressIndicator',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: refreshCards),
        SizedBox(height: 32.0),

        // Section 8
        Text(
          '8. Themed via ProgressIndicatorThemeData',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        themedPanel,
        SizedBox(height: 32.0),

        // Section 9
        Text(
          '9. Real-world layouts',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        downloadCard,
        uploadCard,
        wizardCard,
        SizedBox(height: 32.0),

        // Section 10
        Text(
          '10. Code examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 11
        Text(
          '11. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
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
