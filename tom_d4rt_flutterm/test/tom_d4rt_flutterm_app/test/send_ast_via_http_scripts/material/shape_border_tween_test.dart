// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShapeBorderTween - animates between two ShapeBorder values
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildShapePreview(String label, ShapeBorder shape, Color fillColor) {
  print('Building shape preview: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Center(
          child: Container(
            width: 120,
            height: 80,
            decoration: ShapeDecoration(
              color: fillColor,
              shape: shape,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Type: ${shape.runtimeType}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildTweenDemo(
  String label,
  ShapeBorderTween tween,
  double t,
  Color fillColor,
) {
  print('Building tween demo: $label at t=$t');
  ShapeBorder? interpolatedShape = tween.lerp(t);
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                't = ${t.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: Container(
            width: 140,
            height: 90,
            decoration: ShapeDecoration(
              color: fillColor,
              shape: interpolatedShape ?? RoundedRectangleBorder(),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Interpolated type: ${interpolatedShape?.runtimeType ?? "null"}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildAnimationTimeline(
  String title,
  ShapeBorderTween tween,
  Color fillColor,
  List<double> tValues,
) {
  print('Building animation timeline: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tValues.map((t) {
              ShapeBorder? shape = tween.lerp(t);
              return Container(
                margin: EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: fillColor.withAlpha((255 * (0.4 + t * 0.6)).toInt()),
                        shape: shape ?? RoundedRectangleBorder(),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      't=${t.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget buildBeginEndComparison(
  String label,
  ShapeBorderTween tween,
  Color beginColor,
  Color endColor,
) {
  print('Building begin/end comparison: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Begin',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 70,
                    decoration: ShapeDecoration(
                      color: beginColor,
                      shape: tween.begin ?? RoundedRectangleBorder(),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${tween.begin?.runtimeType ?? "null"}',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Icon(Icons.arrow_forward, color: Colors.grey.shade500, size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'End',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 70,
                    decoration: ShapeDecoration(
                      color: endColor,
                      shape: tween.end ?? RoundedRectangleBorder(),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${tween.end?.runtimeType ?? "null"}',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTransformDemo(
  String label,
  ShapeBorderTween tween,
  double t,
  Color color,
) {
  print('Building transform demo: $label');
  ShapeBorder? transformed = tween.transform(t);
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'transform($t)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Center(
          child: Container(
            width: 130,
            height: 85,
            decoration: ShapeDecoration(
              color: color,
              shape: transformed ?? RoundedRectangleBorder(),
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Result: ${transformed?.runtimeType ?? "null"}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildContinuousCornersDemo(
  String label,
  double radius,
  double cornerSmoothing,
  Color color,
) {
  print('Building continuous corners demo: $label');
  RoundedRectangleBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Radius: ${radius.toInt()}px, Smoothing: ${(cornerSmoothing * 100).toInt()}%',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10),
        Center(
          child: Container(
            width: 120,
            height: 80,
            decoration: ShapeDecoration(
              color: color,
              shape: shape,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBeveledBorderDemo(
  String label,
  BorderRadius borderRadius,
  Color color,
  BorderSide side,
) {
  print('Building beveled border demo: $label');
  BeveledRectangleBorder shape = BeveledRectangleBorder(
    borderRadius: borderRadius,
    side: side,
  );
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Center(
          child: Container(
            width: 130,
            height: 85,
            decoration: ShapeDecoration(
              color: color,
              shape: shape,
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Border radius: $borderRadius',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildStadiumTweenDemo(
  String label,
  ShapeBorderTween tween,
  List<double> tValues,
  Color baseColor,
) {
  print('Building stadium tween demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: tValues.map((t) {
            ShapeBorder? shape = tween.lerp(t);
            return SizedBox(
              width: 100,
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: baseColor.withAlpha((200 + t * 55).toInt()),
                      shape: shape ?? StadiumBorder(),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    't = ${t.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget buildInterpolationProgressBar(double t, Color color) {
  return Container(
    height: 24,
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        FractionallySizedBox(
          widthFactor: t,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Center(
          child: Text(
            '${(t * 100).toInt()}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: t > 0.5 ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget main() {
  print('ShapeBorderTween Deep Demo - Starting');
  print('Demonstrating animation between ShapeBorder values');
  
  // Create various shape borders
  RoundedRectangleBorder roundedRect = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: BorderSide(color: Colors.blue, width: 2),
  );
  
  CircleBorder circleBorder = CircleBorder(
    side: BorderSide(color: Colors.purple, width: 2),
  );
  
  StadiumBorder stadiumBorder = StadiumBorder(
    side: BorderSide(color: Colors.green, width: 2),
  );
  
  BeveledRectangleBorder beveledRect = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.orange, width: 2),
  );
  
  RoundedRectangleBorder smallRounded = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );
  
  RoundedRectangleBorder largeRounded = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32),
  );
  
  // Create tweens
  ShapeBorderTween roundedToCircleTween = ShapeBorderTween(
    begin: roundedRect,
    end: circleBorder,
  );
  
  ShapeBorderTween stadiumTween = ShapeBorderTween(
    begin: smallRounded,
    end: stadiumBorder,
  );
  
  ShapeBorderTween beveledTween = ShapeBorderTween(
    begin: roundedRect,
    end: beveledRect,
  );
  
  ShapeBorderTween cornerRadiusTween = ShapeBorderTween(
    begin: smallRounded,
    end: largeRounded,
  );
  
  ShapeBorderTween circleToBevelTween = ShapeBorderTween(
    begin: circleBorder,
    end: beveledRect,
  );
  
  List<double> standardTValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  List<double> detailedTValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  
  print('Created ${standardTValues.length} standard t-values');
  print('Created ${detailedTValues.length} detailed t-values');
  
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('ShapeBorderTween Deep Demo'),
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: ShapeBorderTween basics
            buildSectionHeader('ShapeBorderTween Basics'),
            buildInfoCard('Class', 'ShapeBorderTween extends Tween<ShapeBorder?>'),
            buildInfoCard('Purpose', 'Interpolates between two ShapeBorder values'),
            buildInfoCard('Key Method', 'lerp(double t) - returns interpolated shape'),
            buildInfoCard('Range', 't from 0.0 (begin) to 1.0 (end)'),
            SizedBox(height: 8),
            buildShapePreview('RoundedRectangleBorder', roundedRect, Colors.blue.shade100),
            buildShapePreview('CircleBorder', circleBorder, Colors.purple.shade100),
            buildShapePreview('StadiumBorder', stadiumBorder, Colors.green.shade100),
            buildShapePreview('BeveledRectangleBorder', beveledRect, Colors.orange.shade100),
            
            // Section 2: Lerp between RoundedRectangleBorder and CircleBorder
            buildSectionHeader('RoundedRectangle to Circle Lerp'),
            buildInfoCard('Begin', 'RoundedRectangleBorder with 16px radius'),
            buildInfoCard('End', 'CircleBorder'),
            buildInfoCard('Interpolation', 'Shape morphs between rectangle and circle'),
            SizedBox(height: 8),
            buildBeginEndComparison(
              'Rounded to Circle Transition',
              roundedToCircleTween,
              Colors.blue.shade200,
              Colors.purple.shade200,
            ),
            buildTweenDemo('At t=0.0 (begin)', roundedToCircleTween, 0.0, Colors.blue.shade100),
            buildTweenDemo('At t=0.25', roundedToCircleTween, 0.25, Colors.blue.shade200),
            buildTweenDemo('At t=0.5 (middle)', roundedToCircleTween, 0.5, Colors.indigo.shade200),
            buildTweenDemo('At t=0.75', roundedToCircleTween, 0.75, Colors.purple.shade100),
            buildTweenDemo('At t=1.0 (end)', roundedToCircleTween, 1.0, Colors.purple.shade200),
            buildAnimationTimeline(
              'Full Timeline: Rounded to Circle',
              roundedToCircleTween,
              Colors.indigo.shade300,
              detailedTValues,
            ),
            
            // Section 3: Tweening StadiumBorder
            buildSectionHeader('Tweening StadiumBorder'),
            buildInfoCard('Stadium Shape', 'Pill-shaped border with circular ends'),
            buildInfoCard('Transition', 'Small rounded corners to stadium shape'),
            buildInfoCard('Use Case', 'Button shape animations'),
            SizedBox(height: 8),
            buildShapePreview('Initial Small Rounded', smallRounded, Colors.grey.shade200),
            buildShapePreview('Target Stadium', stadiumBorder, Colors.green.shade200),
            buildStadiumTweenDemo(
              'Stadium Tween Progress',
              stadiumTween,
              standardTValues,
              Colors.green.shade300,
            ),
            buildTweenDemo('Stadium at t=0.0', stadiumTween, 0.0, Colors.grey.shade200),
            buildTweenDemo('Stadium at t=0.33', stadiumTween, 0.33, Colors.green.shade100),
            buildTweenDemo('Stadium at t=0.66', stadiumTween, 0.66, Colors.green.shade200),
            buildTweenDemo('Stadium at t=1.0', stadiumTween, 1.0, Colors.green.shade300),
            buildAnimationTimeline(
              'Stadium Transition Timeline',
              stadiumTween,
              Colors.green.shade400,
              standardTValues,
            ),
            
            // Section 4: BeveledRectangleBorder interpolation
            buildSectionHeader('BeveledRectangleBorder Interpolation'),
            buildInfoCard('Beveled Shape', 'Rectangle with cut corners'),
            buildInfoCard('Application', 'Material design card transitions'),
            buildInfoCard('Corner Style', 'Diagonal cuts instead of curves'),
            SizedBox(height: 8),
            buildBeveledBorderDemo(
              'Small Beveled Corners',
              BorderRadius.circular(8),
              Colors.orange.shade100,
              BorderSide(color: Colors.orange, width: 2),
            ),
            buildBeveledBorderDemo(
              'Medium Beveled Corners',
              BorderRadius.circular(16),
              Colors.orange.shade200,
              BorderSide(color: Colors.deepOrange, width: 2),
            ),
            buildBeveledBorderDemo(
              'Large Beveled Corners',
              BorderRadius.circular(24),
              Colors.orange.shade300,
              BorderSide(color: Colors.red.shade600, width: 2),
            ),
            buildBeginEndComparison(
              'Rounded to Beveled',
              beveledTween,
              Colors.blue.shade200,
              Colors.orange.shade200,
            ),
            buildTweenDemo('Beveled at t=0.0', beveledTween, 0.0, Colors.blue.shade100),
            buildTweenDemo('Beveled at t=0.5', beveledTween, 0.5, Colors.amber.shade100),
            buildTweenDemo('Beveled at t=1.0', beveledTween, 1.0, Colors.orange.shade200),
            buildAnimationTimeline(
              'Beveled Border Timeline',
              beveledTween,
              Colors.orange.shade400,
              standardTValues,
            ),
            
            // Section 5: begin/end properties
            buildSectionHeader('Begin/End Properties'),
            buildInfoCard('begin property', 'Starting ShapeBorder (null allowed)'),
            buildInfoCard('end property', 'Ending ShapeBorder (null allowed)'),
            buildInfoCard('Null handling', 'lerp returns null if both are null'),
            buildInfoCard('Type check', 'begin.runtimeType shows actual type'),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tween Properties Inspection',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  buildInfoCard('roundedToCircle.begin', '${roundedToCircleTween.begin?.runtimeType}'),
                  buildInfoCard('roundedToCircle.end', '${roundedToCircleTween.end?.runtimeType}'),
                  buildInfoCard('stadiumTween.begin', '${stadiumTween.begin?.runtimeType}'),
                  buildInfoCard('stadiumTween.end', '${stadiumTween.end?.runtimeType}'),
                  buildInfoCard('beveledTween.begin', '${beveledTween.begin?.runtimeType}'),
                  buildInfoCard('beveledTween.end', '${beveledTween.end?.runtimeType}'),
                ],
              ),
            ),
            buildBeginEndComparison(
              'Circle to Bevel Properties',
              circleToBevelTween,
              Colors.purple.shade200,
              Colors.orange.shade200,
            ),
            
            // Section 6: transform method
            buildSectionHeader('Transform Method'),
            buildInfoCard('Method', 'transform(double t) -> ShapeBorder?'),
            buildInfoCard('Behavior', 'Calls lerp(t) internally'),
            buildInfoCard('Use with', 'Animation.drive() or direct calls'),
            buildInfoCard('Clamping', 'Values outside 0-1 extrapolate'),
            SizedBox(height: 8),
            buildTransformDemo('transform(0.0)', roundedToCircleTween, 0.0, Colors.blue.shade100),
            buildTransformDemo('transform(0.25)', roundedToCircleTween, 0.25, Colors.blue.shade200),
            buildTransformDemo('transform(0.5)', roundedToCircleTween, 0.5, Colors.indigo.shade200),
            buildTransformDemo('transform(0.75)', roundedToCircleTween, 0.75, Colors.purple.shade100),
            buildTransformDemo('transform(1.0)', roundedToCircleTween, 1.0, Colors.purple.shade200),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transform Progress Visualization',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text('t = 0.0', style: TextStyle(fontSize: 12)),
                  buildInterpolationProgressBar(0.0, Colors.teal),
                  Text('t = 0.33', style: TextStyle(fontSize: 12)),
                  buildInterpolationProgressBar(0.33, Colors.teal),
                  Text('t = 0.66', style: TextStyle(fontSize: 12)),
                  buildInterpolationProgressBar(0.66, Colors.teal),
                  Text('t = 1.0', style: TextStyle(fontSize: 12)),
                  buildInterpolationProgressBar(1.0, Colors.teal),
                ],
              ),
            ),
            
            // Section 7: Continuous corners
            buildSectionHeader('Continuous Corners'),
            buildInfoCard('Concept', 'Smooth corner radius transitions'),
            buildInfoCard('Implementation', 'BorderRadius.circular() for uniform'),
            buildInfoCard('iOS Style', 'Squircle-like continuous curves'),
            buildInfoCard('Animation', 'Radius lerps linearly by default'),
            SizedBox(height: 8),
            buildContinuousCornersDemo('Sharp corners (radius 0)', 0, 0.0, Colors.red.shade100),
            buildContinuousCornersDemo('Small corners (radius 8)', 8, 0.3, Colors.orange.shade100),
            buildContinuousCornersDemo('Medium corners (radius 16)', 16, 0.5, Colors.yellow.shade200),
            buildContinuousCornersDemo('Large corners (radius 24)', 24, 0.7, Colors.green.shade100),
            buildContinuousCornersDemo('Very large corners (radius 32)', 32, 1.0, Colors.blue.shade100),
            buildBeginEndComparison(
              'Corner Radius Transition',
              cornerRadiusTween,
              Colors.grey.shade200,
              Colors.blue.shade200,
            ),
            buildAnimationTimeline(
              'Continuous Corner Animation',
              cornerRadiusTween,
              Colors.blue.shade400,
              detailedTValues,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Corner Radius Progression',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.blue.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('0px', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.blue.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('8px', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.blue.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('16px', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.blue.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('24px', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.blue.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('25px (circle)', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Summary section
            buildSectionHeader('Summary'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoCard('ShapeBorderTween', 'Animates between ShapeBorder values'),
                  buildInfoCard('Supported Shapes', 'RoundedRectangle, Circle, Stadium, Beveled'),
                  buildInfoCard('Key Methods', 'lerp(), transform()'),
                  buildInfoCard('Properties', 'begin, end (both nullable)'),
                  buildInfoCard('t Range', '0.0 (start) to 1.0 (end)'),
                  buildInfoCard('Integration', 'Works with AnimationController'),
                ],
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                'ShapeBorderTween Demo Complete',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
