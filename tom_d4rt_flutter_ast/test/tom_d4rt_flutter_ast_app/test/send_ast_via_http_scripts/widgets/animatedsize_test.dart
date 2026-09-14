// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demonstration of the Flutter AnimatedSize
// widget. Renders a static snapshot illustrating duration, curve, alignment,
// reverseDuration, clipBehavior, anatomy, real-world use-cases, and footguns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedSize Deep Demo executing');

  // ============================================================
  // SHARED STYLE HELPERS
  // ============================================================
  // We assemble several reusable BoxDecorations & TextStyles up front so the
  // section bodies stay focused on AnimatedSize itself rather than chrome.

  final headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A237E).withValues(alpha: 0.9),
      Color(0xFF3949AB).withValues(alpha: 0.85),
      Color(0xFF5C6BC0).withValues(alpha: 0.8),
    ],
  );

  final accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF00897B).withValues(alpha: 0.85),
      Color(0xFF26A69A).withValues(alpha: 0.75),
    ],
  );

  final warmGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFF7043).withValues(alpha: 0.85),
      Color(0xFFFFA726).withValues(alpha: 0.85),
      Color(0xFFFFCA28).withValues(alpha: 0.85),
    ],
  );

  final coolGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0288D1).withValues(alpha: 0.85),
      Color(0xFF26C6DA).withValues(alpha: 0.85),
    ],
  );

  final mutedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFECEFF1),
      Color(0xFFCFD8DC),
    ],
  );

  final dangerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB71C1C).withValues(alpha: 0.85),
      Color(0xFFD32F2F).withValues(alpha: 0.85),
      Color(0xFFE57373).withValues(alpha: 0.85),
    ],
  );

  final softShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.12),
    blurRadius: 8.0,
    offset: Offset(0.0, 3.0),
  );

  final mediumShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.18),
    blurRadius: 12.0,
    offset: Offset(0.0, 5.0),
  );

  final deepShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.28),
    blurRadius: 18.0,
    offset: Offset(0.0, 8.0),
  );

  final indigoShadow = BoxShadow(
    color: Color(0xFF3949AB).withValues(alpha: 0.35),
    blurRadius: 16.0,
    offset: Offset(0.0, 6.0),
  );

  final tealShadow = BoxShadow(
    color: Color(0xFF00897B).withValues(alpha: 0.35),
    blurRadius: 16.0,
    offset: Offset(0.0, 6.0),
  );

  final amberShadow = BoxShadow(
    color: Color(0xFFFFA726).withValues(alpha: 0.35),
    blurRadius: 14.0,
    offset: Offset(0.0, 5.0),
  );

  // ============================================================
  // SECTION 1: TITLE / INTRODUCTION
  // ============================================================
  print('=== Section 1: Introduction ===');

  final introCard = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: headerGradient,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [deepShadow, indigoShadow],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(Icons.aspect_ratio, color: Colors.white, size: 36.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AnimatedSize',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Implicitly animates between child sizes',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'AnimatedSize watches the intrinsic size of its child and animates '
          'its own bounds between the previous size and the new size. It is '
          'the simplest way to make layout changes feel fluid without '
          'wiring up an AnimationController.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Note: this demo renders snapshots; animation triggers when the '
            'child rebuilds with new dimensions.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white.withValues(alpha: 0.95),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY DIAGRAM
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: accentGradient,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [tealShadow],
    ),
    child: Row(
      children: [
        Icon(Icons.architecture, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 2: Anatomy of AnimatedSize',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Constructor parameters explained visually.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final anatomyParams = <Widget>[];
  final anatomyData = <List<dynamic>>[
    ['child', Icons.widgets, 'The single child whose intrinsic size is observed.', Color(0xFF1976D2)],
    ['duration', Icons.timer, 'How long the size transition takes when expanding.', Color(0xFF388E3C)],
    ['reverseDuration', Icons.timer_off, 'Optional separate duration for shrinking.', Color(0xFFF57C00)],
    ['curve', Icons.show_chart, 'Easing function applied to the size tween.', Color(0xFF7B1FA2)],
    ['alignment', Icons.center_focus_strong, 'Anchors the child while the box resizes.', Color(0xFFD81B60)],
    ['clipBehavior', Icons.crop, 'How content extending past the box is clipped.', Color(0xFF00796B)],
  ];

  for (final row in anatomyData) {
    final label = row[0] as String;
    final icon = row[1] as IconData;
    final desc = row[2] as String;
    final color = row[3] as Color;
    anatomyParams.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border(left: BorderSide(color: color, width: 4.0)),
          boxShadow: [softShadow],
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF455A64),
                      height: 1.3,
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

  // Visual anatomy diagram: bounding box, alignment anchor, clip area, child.
  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: mutedGradient,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [softShadow],
    ),
    child: Column(
      children: [
        Text(
          'Bounding box, anchor & clip',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: 260.0,
          height: 180.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFF1976D2), width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 8.0,
                top: 8.0,
                child: Text(
                  'AnimatedSize bounds',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 30.0,
                top: 36.0,
                child: Container(
                  width: 200.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF00796B).withValues(alpha: 0.08),
                    border: Border.all(
                      color: Color(0xFF00796B),
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 4.0,
                        top: 2.0,
                        child: Text(
                          'clipBehavior region',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFF00796B),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 90.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            gradient: warmGradient,
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [amberShadow],
                          ),
                          child: Center(
                            child: Text(
                              'child',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 6.0,
                        bottom: 4.0,
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFD81B60),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.gps_fixed,
                            size: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Outer blue = AnimatedSize box; teal = clip area; orange = child; '
          'pink dot = alignment anchor.',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF455A64),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: BASELINE ANIMATEDSIZE
  // ============================================================
  print('=== Section 3: Baseline ===');

  final baselineHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: coolGradient,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [mediumShadow],
    ),
    child: Row(
      children: [
        Icon(Icons.play_circle_fill, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 3: Baseline AnimatedSize',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'A fixed-size child wrapped statically.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final baselineDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [softShadow],
    ),
    child: Column(
      children: [
        Text(
          'AnimatedSize(duration: 300ms, child: 120x80 container)',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Color(0xFF37474F),
          ),
        ),
        SizedBox(height: 12.0),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: Container(
            width: 120.0,
            height: 80.0,
            decoration: BoxDecoration(
              gradient: coolGradient,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [mediumShadow],
            ),
            child: Center(
              child: Text(
                '120x80',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: DIFFERENT DURATIONS
  // ============================================================
  print('=== Section 4: Durations ===');

  final durationHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: warmGradient,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [amberShadow],
    ),
    child: Row(
      children: [
        Icon(Icons.timer, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 4: Duration variants',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '100ms, 300ms, 800ms, 2000ms snapshots.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final durationCards = <Widget>[];
  final durationData = <List<dynamic>>[
    [100, 'Snappy', Color(0xFFE53935), 70.0, 50.0],
    [300, 'Default-ish', Color(0xFF1E88E5), 90.0, 60.0],
    [800, 'Cinematic', Color(0xFF8E24AA), 110.0, 70.0],
    [2000, 'Slow-mo', Color(0xFF00897B), 130.0, 80.0],
  ];

  for (final d in durationData) {
    final ms = d[0] as int;
    final label = d[1] as String;
    final color = d[2] as Color;
    final w = d[3] as double;
    final h = d[4] as double;
    durationCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [softShadow],
        ),
        child: Column(
          children: [
            Text(
              '${ms}ms',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF607D8B),
              ),
            ),
            SizedBox(height: 10.0),
            AnimatedSize(
              duration: Duration(milliseconds: ms),
              curve: Curves.easeInOut,
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final durationRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: durationCards),
    ),
  );

  // ============================================================
  // SECTION 5: CURVES
  // ============================================================
  print('=== Section 5: Curves ===');

  final curveHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6A1B9A).withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.show_chart, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 5: Curve variants',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Linear, easeIn, easeOut, easeInOut, bounceOut, elasticOut.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final curveCards = <Widget>[];
  final curveData = <List<dynamic>>[
    ['linear', Curves.linear, Color(0xFF455A64)],
    ['easeIn', Curves.easeIn, Color(0xFF1976D2)],
    ['easeOut', Curves.easeOut, Color(0xFF388E3C)],
    ['easeInOut', Curves.easeInOut, Color(0xFFF57C00)],
    ['bounceOut', Curves.bounceOut, Color(0xFFD32F2F)],
    ['elasticOut', Curves.elasticOut, Color(0xFF7B1FA2)],
  ];

  for (final c in curveData) {
    final name = c[0] as String;
    final curve = c[1] as Curve;
    final color = c[2] as Color;
    curveCards.add(
      Container(
        width: 160.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [softShadow],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            AnimatedSize(
              duration: Duration(milliseconds: 500),
              curve: curve,
              child: Container(
                width: 100.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [softShadow],
                ),
                child: Center(
                  child: Icon(
                    Icons.timeline,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Curves.$name',
              style: TextStyle(
                fontSize: 10.0,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  final curveGrid = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: curveCards,
    ),
  );

  // ============================================================
  // SECTION 6: ALIGNMENT
  // ============================================================
  print('=== Section 6: Alignment ===');

  final alignmentHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFAD1457), Color(0xFFEC407A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFAD1457).withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.center_focus_strong, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 6: Alignment anchors',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'topLeft, topCenter, center, bottomRight.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final alignmentNote = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: Color(0xFFFB8C00), width: 4.0)),
    ),
    child: Text(
      'Alignment determines where the child sits while the AnimatedSize box '
      'grows or shrinks. With topLeft, growth happens to the right & down. '
      'With center, growth happens evenly outward.',
      style: TextStyle(fontSize: 12.0, color: Color(0xFF5D4037), height: 1.4),
    ),
  );

  final alignmentCards = <Widget>[];
  final alignmentData = <List<dynamic>>[
    ['topLeft', Alignment.topLeft, Color(0xFF1976D2)],
    ['topCenter', Alignment.topCenter, Color(0xFF388E3C)],
    ['center', Alignment.center, Color(0xFFF57C00)],
    ['bottomRight', Alignment.bottomRight, Color(0xFFD32F2F)],
  ];

  for (final a in alignmentData) {
    final name = a[0] as String;
    final align = a[1] as AlignmentGeometry;
    final color = a[2] as Color;
    alignmentCards.add(
      Container(
        width: 160.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [softShadow],
        ),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 130.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: AnimatedSize(
                duration: Duration(milliseconds: 400),
                alignment: align,
                child: Container(
                  width: 70.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [softShadow],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final alignmentRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: alignmentCards,
    ),
  );

  // ============================================================
  // SECTION 7: CLIP BEHAVIOR
  // ============================================================
  print('=== Section 7: Clip Behavior ===');

  final clipHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF004D40), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [tealShadow],
    ),
    child: Row(
      children: [
        Icon(Icons.crop, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 7: clipBehavior modes',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Clip.none, Clip.hardEdge, Clip.antiAlias, '
                'Clip.antiAliasWithSaveLayer.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final clipCards = <Widget>[];
  final clipData = <List<dynamic>>[
    ['Clip.none', Clip.none, Color(0xFF455A64)],
    ['Clip.hardEdge', Clip.hardEdge, Color(0xFF1976D2)],
    ['Clip.antiAlias', Clip.antiAlias, Color(0xFF388E3C)],
    ['Clip.antiAliasWithSaveLayer', Clip.antiAliasWithSaveLayer, Color(0xFF7B1FA2)],
  ];

  for (final c in clipData) {
    final name = c[0] as String;
    final clip = c[1] as Clip;
    final color = c[2] as Color;
    clipCards.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
          boxShadow: [softShadow],
        ),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 10.0),
            AnimatedSize(
              duration: Duration(milliseconds: 350),
              clipBehavior: clip,
              child: Container(
                width: 140.0,
                height: 70.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.crop_square,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              clip == Clip.hardEdge
                  ? 'Default; cheapest clipping.'
                  : clip == Clip.none
                      ? 'No clipping; child can overflow.'
                      : clip == Clip.antiAlias
                          ? 'Smooth edges, slightly costlier.'
                          : 'Smoothest, requires save layer.',
              style: TextStyle(
                fontSize: 10.0,
                color: Color(0xFF607D8B),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  final clipGrid = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: clipCards,
    ),
  );

  // ============================================================
  // SECTION 8: REVERSE DURATION
  // ============================================================
  print('=== Section 8: Reverse Duration ===');

  final reverseHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF607D8B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [mediumShadow],
    ),
    child: Row(
      children: [
        Icon(Icons.swap_horiz, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 8: reverseDuration',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Asymmetric expand vs shrink timing.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final reverseDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [softShadow],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pattern:',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'AnimatedSize(\n'
            '  duration: Duration(milliseconds: 600),     // expand\n'
            '  reverseDuration: Duration(milliseconds: 200), // shrink fast\n'
            '  curve: Curves.easeOut,\n'
            '  child: ...\n'
            ')',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF263238),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedSize(
              duration: Duration(milliseconds: 600),
              reverseDuration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Container(
                width: 110.0,
                height: 70.0,
                decoration: BoxDecoration(
                  gradient: accentGradient,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [tealShadow],
                ),
                child: Center(
                  child: Text(
                    'expand 600ms\nshrink 200ms',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              reverseDuration: Duration(milliseconds: 800),
              curve: Curves.easeIn,
              child: Container(
                width: 110.0,
                height: 70.0,
                decoration: BoxDecoration(
                  gradient: warmGradient,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [amberShadow],
                ),
                child: Center(
                  child: Text(
                    'expand 200ms\nshrink 800ms',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: USE CASES
  // ============================================================
  print('=== Section 9: Use Cases ===');

  final useCaseHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF01579B), Color(0xFF0288D1), Color(0xFF4FC3F7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF01579B).withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.lightbulb, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 9: When to reach for AnimatedSize',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Common UI patterns this widget solves.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final useCases = <Widget>[];
  final useCaseData = <List<dynamic>>[
    [
      Icons.unfold_more,
      Color(0xFF1976D2),
      'Collapse / expand panels',
      'Settings sections, advanced options drawers, "more details" toggles.',
    ],
    [
      Icons.help_outline,
      Color(0xFF388E3C),
      'FAQ items',
      'Question stays visible while answer slides into place beneath it.',
    ],
    [
      Icons.image,
      Color(0xFFF57C00),
      'Image lightbox',
      'Thumbnail grows to a preview without a hard layout jump.',
    ],
    [
      Icons.chat_bubble_outline,
      Color(0xFF7B1FA2),
      'Dialog content swap',
      'Step-based dialogs whose body grows or shrinks per step.',
    ],
    [
      Icons.notifications_active,
      Color(0xFFD81B60),
      'Notification cards',
      'Cards expand when extra metadata or actions become available.',
    ],
    [
      Icons.text_fields,
      Color(0xFF00897B),
      'Textfield error messages',
      'Reserves no space until validation message appears, then animates in.',
    ],
  ];

  for (final u in useCaseData) {
    final icon = u[0] as IconData;
    final color = u[1] as Color;
    final title = u[2] as String;
    final desc = u[3] as String;
    useCases.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [softShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF455A64),
                      height: 1.35,
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
  // SECTION 10: REAL-WORLD MOCK (FAQ)
  // ============================================================
  print('=== Section 10: FAQ Mock ===');

  final faqHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFF5E35B1), Color(0xFF9575CD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF311B92).withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.live_help, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 10: FAQ list (real-world mock)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Each item wraps its body in AnimatedSize.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final faqItems = <Widget>[];
  final faqData = <List<dynamic>>[
    [
      'What does AnimatedSize do?',
      'It watches the intrinsic size of its single child and animates its '
          'own bounds between the previous and the new value of that size.',
      true,
    ],
    [
      'Do I need an AnimationController?',
      'No. AnimatedSize is an implicit animation widget; rebuilds with a '
          'differently sized child are enough to trigger the transition.',
      true,
    ],
    [
      'How is it different from AnimatedContainer?',
      'AnimatedContainer animates explicit sizes you supply. AnimatedSize '
          'animates whatever size the child reports — you do not have to '
          'know the dimensions ahead of time.',
      false,
    ],
    [
      'Will it animate on first build?',
      'No. The first child size is taken as-is; only subsequent size '
          'changes are animated.',
      false,
    ],
  ];

  for (final f in faqData) {
    final question = f[0] as String;
    final answer = f[1] as String;
    final expanded = f[2] as bool;
    faqItems.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [softShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: expanded
                    ? LinearGradient(
                        colors: [
                          Color(0xFF5E35B1).withValues(alpha: 0.08),
                          Color(0xFF9575CD).withValues(alpha: 0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.0),
                  bottom: expanded ? Radius.zero : Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: Color(0xFF5E35B1),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF311B92),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: expanded
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(14.0, 4.0, 14.0, 14.0),
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF455A64),
                          height: 1.4,
                        ),
                      ),
                    )
                  : SizedBox(width: double.infinity, height: 0.0),
            ),
          ],
        ),
      ),
    );
  }

  final faqExplain = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: Color(0xFF8E24AA), width: 4.0)),
    ),
    child: Text(
      'Snapshot rendering: each item is shown in either an "expanded" or '
      '"collapsed" state. In a real app, toggling that state on a tap would '
      'cause AnimatedSize to fluidly transition the body height.',
      style: TextStyle(fontSize: 12.0, color: Color(0xFF4A148C), height: 1.4),
    ),
  );

  // ============================================================
  // SECTION 11: FOOTGUNS
  // ============================================================
  print('=== Section 11: Footguns ===');

  final footgunHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: dangerGradient,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB71C1C).withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: Colors.white, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 11: Footguns',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Common pitfalls when wrapping things in AnimatedSize.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final footgunCards = <Widget>[];
  final footgunData = <List<dynamic>>[
    [
      'Single child only',
      'AnimatedSize wraps exactly one child. Wrap a Column or Row inside if '
          'you need multiple children.',
      Icons.looks_one,
    ],
    [
      'Intrinsic size must change',
      'If the child is constrained from outside (e.g. a fixed-height parent), '
          'its reported size will not change and there is nothing to animate.',
      Icons.straighten,
    ],
    [
      'IntrinsicHeight / IntrinsicWidth parents',
      'Parents that already coerce the child to one fixed pass of intrinsic '
          'sizing can suppress the visible animation.',
      Icons.height,
    ],
    [
      'clipBehavior defaults to hardEdge',
      'During growth, content slightly outside the previous bounds will be '
          'clipped. Use Clip.none if you actually want overflow visible.',
      Icons.crop_din,
    ],
    [
      'No first-build animation',
      'The first frame establishes the baseline. Don\'t expect entry '
          'animation on initial layout — use a separate widget for that.',
      Icons.first_page,
    ],
    [
      'Beware of unbounded constraints',
      'AnimatedSize requires bounded constraints in the relevant axis. '
          'Wrapping inside a scroll view without sizing can fail at layout.',
      Icons.all_out,
    ],
  ];

  for (final fg in footgunData) {
    final title = fg[0] as String;
    final desc = fg[1] as String;
    final icon = fg[2] as IconData;
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: Color(0xFFD32F2F), width: 4.0),
          ),
          boxShadow: [softShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Color(0xFFD32F2F), size: 22.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF5D4037),
                      height: 1.35,
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
  // SECTION 12: SUMMARY / RECAP
  // ============================================================
  print('=== Section 12: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1B5E20).withValues(alpha: 0.92),
          Color(0xFF2E7D32).withValues(alpha: 0.85),
          Color(0xFF66BB6A).withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1B5E20).withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'AnimatedSize is a small but powerful implicit animation. Wrap a '
          'single child whose intrinsic size changes; pick a duration, '
          'optional reverseDuration, a curve, an alignment anchor, and a '
          'clip behavior. Avoid sticking it underneath parents that strip '
          'the size signal and remember the first build is not animated.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.95),
            height: 1.45,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Rule of thumb: reach for AnimatedSize whenever a layout chunk '
            'changes its size in response to user input or data, and you '
            'want the change to feel intentional rather than abrupt.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLY
  // ============================================================
  print('=== Assembling final scaffold ===');

  final allChildren = <Widget>[];
  allChildren.add(introCard);
  allChildren.add(anatomyHeader);
  for (final w in anatomyParams) {
    allChildren.add(w);
  }
  allChildren.add(anatomyDiagram);
  allChildren.add(baselineHeader);
  allChildren.add(baselineDemo);
  allChildren.add(durationHeader);
  allChildren.add(durationRow);
  allChildren.add(curveHeader);
  allChildren.add(curveGrid);
  allChildren.add(alignmentHeader);
  allChildren.add(alignmentNote);
  allChildren.add(alignmentRow);
  allChildren.add(clipHeader);
  allChildren.add(clipGrid);
  allChildren.add(reverseHeader);
  allChildren.add(reverseDemo);
  allChildren.add(useCaseHeader);
  for (final w in useCases) {
    allChildren.add(w);
  }
  allChildren.add(faqHeader);
  for (final w in faqItems) {
    allChildren.add(w);
  }
  allChildren.add(faqExplain);
  allChildren.add(footgunHeader);
  for (final w in footgunCards) {
    allChildren.add(w);
  }
  allChildren.add(recapCard);
  allChildren.add(SizedBox(height: 24.0));

  print('AnimatedSize Deep Demo build complete: ${allChildren.length} blocks');

  return Scaffold(
    backgroundColor: Color(0xFFF5F7FA),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: allChildren,
      ),
    ),
  );
}
