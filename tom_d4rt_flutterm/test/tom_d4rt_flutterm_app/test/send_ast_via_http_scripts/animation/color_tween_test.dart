// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ColorTween from animation
// Deep Demo: Visual demonstration of color interpolation, gradients, and animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorTween Deep Demo executing');

  // ============================================================
  // SECTION 1: ColorTween Fundamentals
  // ============================================================
  print('=== Section 1: ColorTween Fundamentals ===');

  // Create fundamental tweens to demonstrate
  final basicTween = ColorTween(begin: Colors.red, end: Colors.blue);
  final warmTween = ColorTween(begin: Colors.orange, end: Colors.yellow);
  final coolTween = ColorTween(begin: Colors.cyan, end: Colors.purple);
  final earthTween = ColorTween(begin: Colors.brown, end: Colors.green);

  print('basicTween: ${basicTween.begin} → ${basicTween.end}');
  print('warmTween: ${warmTween.begin} → ${warmTween.end}');
  print('coolTween: ${coolTween.begin} → ${coolTween.end}');
  print('earthTween: ${earthTween.begin} → ${earthTween.end}');

  final fundamentalCards = <Widget>[];
  final tweenData = [
    {'name': 'Basic (Red→Blue)', 'tween': basicTween, 'icon': Icons.palette},
    {'name': 'Warm (Orange→Yellow)', 'tween': warmTween, 'icon': Icons.wb_sunny},
    {'name': 'Cool (Cyan→Purple)', 'tween': coolTween, 'icon': Icons.ac_unit},
    {'name': 'Earth (Brown→Green)', 'tween': earthTween, 'icon': Icons.park},
  ];

  for (final data in tweenData) {
    final tween = data['tween'] as ColorTween;
    final name = data['name'] as String;
    final icon = data['icon'] as IconData;
    final beginColor = tween.begin!;
    final endColor = tween.end!;

    fundamentalCards.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [beginColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: beginColor.withValues(alpha: 0.4),
              blurRadius: 12.0,
              offset: Offset(-4.0, 4.0),
            ),
            BoxShadow(
              color: endColor.withValues(alpha: 0.4),
              blurRadius: 12.0,
              offset: Offset(4.0, -4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(icon, size: 40.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 4.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Show the gradient strip clearly
            Container(
              height: 20.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [beginColor, tween.lerp(0.5)!, endColor],
                ),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.white54, width: 1.0),
              ),
            ),
            SizedBox(height: 12.0),
            // Show color values
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Begin:', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
                      Container(
                        width: 50.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: beginColor,
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('End:', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
                      Container(
                        width: 50.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: endColor,
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${fundamentalCards.length} fundamental tween cards');

  // ============================================================
  // SECTION 2: Color Interpolation (lerp) Visualization
  // ============================================================
  print('=== Section 2: Color Interpolation (lerp) ===');

  final lerpValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  final lerpDemoTween = ColorTween(begin: Colors.red, end: Colors.blue);

  final lerpStrips = <Widget>[];
  for (final t in lerpValues) {
    final interpolatedColor = lerpDemoTween.lerp(t)!;
    print('lerp($t) = $interpolatedColor');

    lerpStrips.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                't = ${t.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 32.0,
                decoration: BoxDecoration(
                  color: interpolatedColor,
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: interpolatedColor.withValues(alpha: 0.5),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'RGBA(${interpolatedColor.red}, ${interpolatedColor.green}, ${interpolatedColor.blue}, ${interpolatedColor.alpha})',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                      color: t > 0.5 ? Colors.white : Colors.white,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 2.0)],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final lerpVisualization = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gradient, color: Colors.indigo, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'ColorTween.lerp(t) Visualization',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The lerp() method linearly interpolates between begin and end colors.\n'
          't=0.0 returns begin color, t=1.0 returns end color.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        ...lerpStrips,
      ],
    ),
  );
  print('Created lerp visualization with ${lerpStrips.length} steps');

  // ============================================================
  // SECTION 3: Multiple ColorTween Comparison Grid
  // ============================================================
  print('=== Section 3: Multiple Tween Comparison ===');

  final comparisonTweens = [
    {'name': 'Primary', 'tween': ColorTween(begin: Colors.red, end: Colors.blue)},
    {'name': 'Secondary', 'tween': ColorTween(begin: Colors.green, end: Colors.amber)},
    {'name': 'Accent', 'tween': ColorTween(begin: Colors.purple, end: Colors.pink)},
    {'name': 'Neutral', 'tween': ColorTween(begin: Colors.grey.shade800, end: Colors.grey.shade200)},
    {'name': 'Sunset', 'tween': ColorTween(begin: Colors.deepOrange, end: Colors.yellow)},
    {'name': 'Ocean', 'tween': ColorTween(begin: Colors.blue.shade900, end: Colors.cyan.shade200)},
    {'name': 'Forest', 'tween': ColorTween(begin: Colors.green.shade900, end: Colors.lightGreen.shade300)},
    {'name': 'Neon', 'tween': ColorTween(begin: Colors.pinkAccent, end: Colors.cyanAccent)},
  ];

  final comparisonGrid = <Widget>[];
  for (final item in comparisonTweens) {
    final name = item['name'] as String;
    final tween = item['tween'] as ColorTween;
    print('Comparison tween: $name');

    // Build color strip with 10 steps
    final colorCells = <Widget>[];
    for (var i = 0; i <= 10; i++) {
      final t = i / 10;
      colorCells.add(
        Expanded(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: tween.lerp(t),
            ),
          ),
        ),
      );
    }

    comparisonGrid.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: tween.begin!.withValues(alpha: 0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: tween.begin,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.0),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Icon(Icons.arrow_forward, size: 12.0, color: Colors.grey.shade600),
                  SizedBox(width: 6.0),
                  Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: tween.end,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.0),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              child: Row(children: colorCells),
            ),
          ],
        ),
      ),
    );
  }
  print('Created comparison grid with ${comparisonGrid.length} tweens');

  // ============================================================
  // SECTION 4: Null Color Handling (Transparency)
  // ============================================================
  print('=== Section 4: Null Color Handling ===');

  final nullBeginTween = ColorTween(begin: null, end: Colors.blue);
  final nullEndTween = ColorTween(begin: Colors.red, end: null);
  final bothNullTween = ColorTween(begin: null, end: null);

  // When begin is null, it interpolates from transparent
  final nullBeginSamples = <Widget>[];
  for (var t = 0.0; t <= 1.0; t += 0.2) {
    final color = nullBeginTween.lerp(t);
    nullBeginSamples.add(
      Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade400, width: 1.0),
        ),
        child: Center(
          child: Text(
            t.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: t > 0.5 ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
  print('nullBeginTween samples: ${nullBeginSamples.length}');

  final nullEndSamples = <Widget>[];
  for (var t = 0.0; t <= 1.0; t += 0.2) {
    final color = nullEndTween.lerp(t);
    nullEndSamples.add(
      Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade400, width: 1.0),
        ),
        child: Center(
          child: Text(
            t.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: t < 0.5 ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
  print('nullEndTween samples: ${nullEndSamples.length}');

  // Test both null
  final bothNullResult = bothNullTween.lerp(0.5);
  print('bothNullTween.lerp(0.5) = $bothNullResult');

  final nullHandlingCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.amber.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Null Color Handling',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'ColorTween treats null colors as fully transparent. This enables smooth\n'
          'fade-in and fade-out animations without explicit alpha management.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 20.0),
        // Null begin demo
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'begin: null → end: Colors.blue (Fade In)',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  // Checkerboard pattern to show transparency
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: nullBeginSamples,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        // Null end demo
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'begin: Colors.red → end: null (Fade Out)',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: nullEndSamples,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        // Both null info
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'When both begin and end are null, lerp returns null.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created null handling visualization');

  // ============================================================
  // SECTION 5: Transform Method vs Lerp
  // ============================================================
  print('=== Section 5: Transform vs Lerp ===');

  final transformTween = ColorTween(begin: Colors.green, end: Colors.teal);
  final transformValues = [0.0, 0.25, 0.5, 0.75, 1.0];

  final transformComparison = <Widget>[];
  for (final t in transformValues) {
    final lerpResult = transformTween.lerp(t)!;
    final transformResult = transformTween.transform(t)!;
    final areEqual = lerpResult == transformResult;
    print('t=$t: lerp=$lerpResult, transform=$transformResult, equal=$areEqual');

    transformComparison.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: areEqual ? Colors.green.shade300 : Colors.red.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60.0,
              child: Text(
                't = $t',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('lerp()', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                      SizedBox(height: 4.0),
                      Container(
                        width: 80.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: lerpResult,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('transform()', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                      SizedBox(height: 4.0),
                      Container(
                        width: 80.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: transformResult,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.0),
                  Icon(
                    areEqual ? Icons.check_circle : Icons.cancel,
                    color: areEqual ? Colors.green : Colors.red,
                    size: 24.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final transformCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.teal.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'transform() vs lerp()',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'The transform() method internally calls lerp(). For ColorTween,\n'
          'they produce identical results. transform() exists for Animatable interface compatibility.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 16.0),
        ...transformComparison,
      ],
    ),
  );
  print('Created transform comparison');

  // ============================================================
  // SECTION 6: Practical Use Cases
  // ============================================================
  print('=== Section 6: Practical Use Cases ===');

  // Use Case 1: Status Indicator
  final statusColors = [
    ColorTween(begin: Colors.grey, end: Colors.green),  // inactive → success
    ColorTween(begin: Colors.grey, end: Colors.red),    // inactive → error
    ColorTween(begin: Colors.grey, end: Colors.amber),  // inactive → warning
    ColorTween(begin: Colors.grey, end: Colors.blue),   // inactive → info
  ];

  final statusLabels = ['Success', 'Error', 'Warning', 'Info'];
  final statusIcons = [Icons.check_circle, Icons.error, Icons.warning, Icons.info];

  final statusIndicators = <Widget>[];
  for (var i = 0; i < statusColors.length; i++) {
    final tween = statusColors[i];
    statusIndicators.add(
      Container(
        width: 120.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tween.begin!.withValues(alpha: 0.3),
              tween.end!.withValues(alpha: 0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: tween.end!, width: 2.0),
        ),
        child: Column(
          children: [
            Icon(statusIcons[i], color: tween.end, size: 32.0),
            SizedBox(height: 8.0),
            Text(
              statusLabels[i],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: tween.end,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 8.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [tween.begin!, tween.end!]),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${statusIndicators.length} status indicators');

  // Use Case 2: Temperature Visualization
  final tempTween = ColorTween(begin: Colors.blue, end: Colors.red);
  final temperatures = [-10, 0, 10, 20, 30, 40];

  final tempBars = <Widget>[];
  for (final temp in temperatures) {
    // Normalize temperature to 0-1 range (-10 to 40 = 50 degree range)
    final normalizedT = ((temp + 10) / 50).clamp(0.0, 1.0);
    final tempColor = tempTween.lerp(normalizedT)!;

    tempBars.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: tempColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '$temp°C',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tempColor,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: normalizedT,
                  child: Container(
                    decoration: BoxDecoration(
                      color: tempColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(
              temp < 10 ? Icons.ac_unit : (temp > 25 ? Icons.wb_sunny : Icons.cloud),
              color: tempColor,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
  print('Created temperature visualization');

  // Use Case 3: Button Hover States
  final buttonStates = [
    {'label': 'Normal', 't': 0.0},
    {'label': 'Hover Start', 't': 0.25},
    {'label': 'Hover Mid', 't': 0.5},
    {'label': 'Hover End', 't': 0.75},
    {'label': 'Pressed', 't': 1.0},
  ];
  final buttonTween = ColorTween(begin: Colors.blue.shade400, end: Colors.blue.shade800);

  final buttonStateDemo = <Widget>[];
  for (final state in buttonStates) {
    final t = state['t'] as double;
    final label = state['label'] as String;
    final stateColor = buttonTween.lerp(t)!;

    buttonStateDemo.add(
      Column(
        children: [
          Container(
            width: 100.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: stateColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: stateColor.withValues(alpha: 0.4),
                  blurRadius: 4.0 + (t * 4.0),
                  offset: Offset(0.0, 2.0 + (t * 2.0)),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Button',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
  print('Created button state demo');

  final useCasesCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.build, color: Colors.purple.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Practical Use Cases',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        // Status indicators
        Text(
          '1. Status Indicators',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(children: statusIndicators),
        SizedBox(height: 24.0),
        // Temperature
        Text(
          '2. Temperature Scale Visualization',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(children: tempBars),
        ),
        SizedBox(height: 24.0),
        // Button states
        Text(
          '3. Button Hover State Progression',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttonStateDemo,
          ),
        ),
      ],
    ),
  );
  print('Created use cases card');

  // ============================================================
  // SECTION 7: ColorTween API Summary
  // ============================================================
  print('=== Section 7: API Summary ===');

  final apiMethods = [
    {
      'method': 'ColorTween(begin, end)',
      'description': 'Constructor - creates a tween between two colors',
      'icon': Icons.add_circle_outline,
    },
    {
      'method': 'lerp(double t)',
      'description': 'Interpolates between begin and end at position t (0.0 to 1.0)',
      'icon': Icons.linear_scale,
    },
    {
      'method': 'transform(double t)',
      'description': 'Same as lerp() - exists for Animatable interface',
      'icon': Icons.transform,
    },
    {
      'method': 'begin',
      'description': 'The starting color (can be null for transparent)',
      'icon': Icons.first_page,
    },
    {
      'method': 'end',
      'description': 'The ending color (can be null for transparent)',
      'icon': Icons.last_page,
    },
    {
      'method': 'toString()',
      'description': 'Returns string representation of the tween',
      'icon': Icons.text_fields,
    },
  ];

  final apiCards = <Widget>[];
  for (final api in apiMethods) {
    apiCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.indigo.shade100, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                api['icon'] as IconData,
                color: Colors.indigo,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    api['method'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    api['description'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
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

  final apiSummaryCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.indigo.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'ColorTween API Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...apiCards,
      ],
    ),
  );
  print('Created API summary card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('ColorTween Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.color_lens, size: 48.0, color: Colors.white),
              SizedBox(height: 12.0),
              Text(
                'ColorTween Deep Demo',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Smooth color interpolation for Flutter animations',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section 1: Fundamentals
        SizedBox(height: 24.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.school, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 1: ColorTween Fundamentals',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: fundamentalCards,
        ),

        // Section 2: Lerp Visualization
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.gradient, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 2: Linear Interpolation',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        lerpVisualization,

        // Section 3: Comparison Grid
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.grid_view, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 3: Tween Comparison',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        ...comparisonGrid,

        // Section 4: Null Handling
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.visibility_off, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 4: Transparency Handling',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        nullHandlingCard,

        // Section 5: Transform vs Lerp
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.compare_arrows, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 5: Method Comparison',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        transformCard,

        // Section 6: Use Cases
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.build, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 6: Practical Applications',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        useCasesCard,

        // Section 7: API Summary
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.api, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'Section 7: API Reference',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        apiSummaryCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}
