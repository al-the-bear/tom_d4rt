// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: ScaleStartDetails, ScaleUpdateDetails, ScaleEndDetails,
// ScaleGestureRecognizer, GestureDetector.onScale* from package:flutter/gestures
// Deep Demo theme: a cartographer's brass pantograph & drafting-compass set —
// the pinch-zoom gesture is rendered as a surveying instrument with a focal
// anchor pin, dual scale slides (horizontal & vertical), a rotation collar,
// pointer-count flags, and a velocity needle.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=========================================================');
  print('  Scale Details Deep Demo — Brass Pantograph Edition');
  print('  Coverage: ScaleStartDetails / ScaleUpdateDetails /');
  print('            ScaleEndDetails + ScaleGestureRecognizer');
  print('=========================================================');

  // ============================================================
  // Theme palette — brass, parchment, ink
  // ============================================================
  final Color brass = Color(0xFFB08D57);
  final Color brassDark = Color(0xFF7A5C2E);
  final Color brassLight = Color(0xFFE6C98A);
  final Color parchment = Color(0xFFF5ECD7);
  final Color parchmentDeep = Color(0xFFE9DCB8);
  final Color ink = Color(0xFF2A1F12);
  final Color compassRed = Color(0xFFB23A2A);
  final Color compassGreen = Color(0xFF3F7A4A);
  final Color compassBlue = Color(0xFF274B6E);

  print('Palette mounted: brass=$brass, parchment=$parchment, ink=$ink');

  // ============================================================
  // SECTION 1 — Lifecycle anatomy: Start → Update → End
  // ============================================================
  print('--- Section 1: Gesture lifecycle anatomy ---');

  final lifecyclePhases = <Map<String, Object>>[
    {
      'phase': 'onScaleStart',
      'detailsType': 'ScaleStartDetails',
      'icon': Icons.adjust,
      'color': compassGreen,
      'fields': <String>[
        'pointerCount',
        'focalPoint',
        'localFocalPoint',
        'sourceTimeStamp',
      ],
      'role': 'Calipers strike the chart',
    },
    {
      'phase': 'onScaleUpdate',
      'detailsType': 'ScaleUpdateDetails',
      'icon': Icons.open_with,
      'color': compassBlue,
      'fields': <String>[
        'pointerCount',
        'focalPoint',
        'localFocalPoint',
        'focalPointDelta',
        'scale',
        'horizontalScale',
        'verticalScale',
        'rotation',
      ],
      'role': 'Pantograph arms travel & pivot',
    },
    {
      'phase': 'onScaleEnd',
      'detailsType': 'ScaleEndDetails',
      'icon': Icons.flag,
      'color': compassRed,
      'fields': <String>[
        'pointerCount',
        'velocity',
        'scaleVelocity',
        'pointerCount',
      ],
      'role': 'Hands lift; needle records terminal velocity',
    },
  ];

  final List<Widget> lifecycleCards = <Widget>[];
  for (int i = 0; i < lifecyclePhases.length; i++) {
    final phase = lifecyclePhases[i];
    final color = phase['color'] as Color;
    final fields = phase['fields'] as List<String>;
    print(
      'Phase ${i + 1}: ${phase['phase']} → ${phase['detailsType']} '
      '(${fields.length} fields)',
    );

    final List<Widget> fieldChips = <Widget>[];
    for (int f = 0; f < fields.length; f++) {
      fieldChips.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color.withValues(alpha: 0.7), width: 1.0),
          ),
          child: Text(
            fields[f],
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    lifecycleCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              parchment,
              color.withValues(alpha: 0.10),
              parchmentDeep,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
            BoxShadow(
              color: brassDark.withValues(alpha: 0.20),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(phase['icon'] as IconData, color: color, size: 30.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    phase['phase'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              phase['detailsType'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: brassDark,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                phase['role'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(children: fieldChips),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2 — Field reference cards (all 9 fields)
  // ============================================================
  print('--- Section 2: Field reference (9 cards) ---');

  final fieldRefs = <Map<String, Object>>[
    {
      'name': 'pointerCount',
      'type': 'int',
      'icon': Icons.touch_app,
      'color': compassGreen,
      'note': 'Number of fingers currently down',
    },
    {
      'name': 'focalPoint',
      'type': 'Offset',
      'icon': Icons.gps_fixed,
      'color': compassBlue,
      'note': 'Centroid of pointers in global coords',
    },
    {
      'name': 'localFocalPoint',
      'type': 'Offset',
      'icon': Icons.center_focus_strong,
      'color': compassBlue,
      'note': 'Centroid mapped into local coords',
    },
    {
      'name': 'focalPointDelta',
      'type': 'Offset',
      'icon': Icons.arrow_outward,
      'color': brassDark,
      'note': 'Movement of focal point since last update',
    },
    {
      'name': 'scale',
      'type': 'double',
      'icon': Icons.zoom_out_map,
      'color': compassRed,
      'note': 'Uniform scale factor (1.0 = identity)',
    },
    {
      'name': 'horizontalScale',
      'type': 'double',
      'icon': Icons.swap_horiz,
      'color': compassRed,
      'note': 'Horizontal-only scale factor',
    },
    {
      'name': 'verticalScale',
      'type': 'double',
      'icon': Icons.swap_vert,
      'color': compassRed,
      'note': 'Vertical-only scale factor',
    },
    {
      'name': 'rotation',
      'type': 'double',
      'icon': Icons.rotate_right,
      'color': brass,
      'note': 'Rotation in radians since gesture start',
    },
    {
      'name': 'velocity',
      'type': 'Velocity',
      'icon': Icons.speed,
      'color': compassRed,
      'note': 'Final pointer velocity (Pan/Drag flavor)',
    },
  ];

  final List<Widget> fieldRefCards = <Widget>[];
  for (int i = 0; i < fieldRefs.length; i++) {
    final fr = fieldRefs[i];
    final color = fr['color'] as Color;
    print('Field ${i + 1}: ${fr['name']}: ${fr['type']} — ${fr['note']}');
    fieldRefCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              parchment,
              color.withValues(alpha: 0.12),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: brass, width: 1.2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: brassDark.withValues(alpha: 0.22),
              blurRadius: 4.0,
              offset: Offset(1.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(fr['icon'] as IconData, color: color, size: 20.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    fr['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: brassDark.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                fr['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: parchment,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              fr['note'] as String,
              style: TextStyle(
                fontSize: 10.0,
                color: ink,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3 — ScaleStartDetails instrument readouts
  // ============================================================
  print('--- Section 3: ScaleStartDetails readouts ---');

  final List<ScaleStartDetails> startSamples = <ScaleStartDetails>[
    ScaleStartDetails(
      focalPoint: Offset(120.0, 80.0),
      localFocalPoint: Offset(60.0, 40.0),
      pointerCount: 1,
    ),
    ScaleStartDetails(
      focalPoint: Offset(200.0, 150.0),
      localFocalPoint: Offset(100.0, 75.0),
      pointerCount: 2,
    ),
    ScaleStartDetails(
      focalPoint: Offset(340.5, 215.25),
      localFocalPoint: Offset(170.25, 107.6),
      pointerCount: 3,
    ),
  ];

  final List<Widget> startCards = <Widget>[];
  for (int i = 0; i < startSamples.length; i++) {
    final s = startSamples[i];
    print(
      'Start[$i]: pointers=${s.pointerCount} '
      'focal=${s.focalPoint} local=${s.localFocalPoint}',
    );
    startCards.add(
      _buildReadoutCard(
        title: 'ScaleStartDetails #${i + 1}',
        accent: compassGreen,
        parchment: parchment,
        brass: brass,
        brassDark: brassDark,
        ink: ink,
        rows: <List<String>>[
          <String>['pointerCount', '${s.pointerCount}'],
          <String>['focalPoint', _fmtOffset(s.focalPoint)],
          <String>['localFocalPoint', _fmtOffset(s.localFocalPoint)],
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 4 — ScaleUpdateDetails instrument readouts
  // ============================================================
  print('--- Section 4: ScaleUpdateDetails readouts ---');

  final List<ScaleUpdateDetails> updateSamples = <ScaleUpdateDetails>[
    ScaleUpdateDetails(
      focalPoint: Offset(125.0, 82.0),
      localFocalPoint: Offset(62.5, 41.0),
      focalPointDelta: Offset(5.0, 2.0),
      scale: 1.10,
      horizontalScale: 1.10,
      verticalScale: 1.10,
      rotation: 0.0,
      pointerCount: 2,
    ),
    ScaleUpdateDetails(
      focalPoint: Offset(210.0, 158.0),
      localFocalPoint: Offset(105.0, 79.0),
      focalPointDelta: Offset(10.0, 8.0),
      scale: 1.45,
      horizontalScale: 1.60,
      verticalScale: 1.30,
      rotation: 0.25,
      pointerCount: 2,
    ),
    ScaleUpdateDetails(
      focalPoint: Offset(180.0, 140.0),
      localFocalPoint: Offset(90.0, 70.0),
      focalPointDelta: Offset(-4.0, -3.0),
      scale: 0.85,
      horizontalScale: 0.90,
      verticalScale: 0.80,
      rotation: -0.40,
      pointerCount: 2,
    ),
    ScaleUpdateDetails(
      focalPoint: Offset(355.0, 220.0),
      localFocalPoint: Offset(177.5, 110.0),
      focalPointDelta: Offset(15.0, 5.0),
      scale: 2.00,
      horizontalScale: 2.20,
      verticalScale: 1.80,
      rotation: 0.78,
      pointerCount: 3,
    ),
  ];

  final List<Widget> updateCards = <Widget>[];
  for (int i = 0; i < updateSamples.length; i++) {
    final u = updateSamples[i];
    print(
      'Update[$i]: scale=${u.scale.toStringAsFixed(2)} '
      'h=${u.horizontalScale.toStringAsFixed(2)} '
      'v=${u.verticalScale.toStringAsFixed(2)} '
      'rot=${u.rotation.toStringAsFixed(2)} '
      'delta=${_fmtOffset(u.focalPointDelta)} '
      'pointers=${u.pointerCount}',
    );
    updateCards.add(
      _buildReadoutCard(
        title: 'ScaleUpdateDetails #${i + 1}',
        accent: compassBlue,
        parchment: parchment,
        brass: brass,
        brassDark: brassDark,
        ink: ink,
        rows: <List<String>>[
          <String>['pointerCount', '${u.pointerCount}'],
          <String>['focalPoint', _fmtOffset(u.focalPoint)],
          <String>['localFocalPoint', _fmtOffset(u.localFocalPoint)],
          <String>['focalPointDelta', _fmtOffset(u.focalPointDelta)],
          <String>['scale', u.scale.toStringAsFixed(3)],
          <String>['horizontalScale', u.horizontalScale.toStringAsFixed(3)],
          <String>['verticalScale', u.verticalScale.toStringAsFixed(3)],
          <String>['rotation (rad)', u.rotation.toStringAsFixed(3)],
          <String>['rotation (deg)', (u.rotation * 57.2958).toStringAsFixed(2)],
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 5 — ScaleEndDetails instrument readouts
  // ============================================================
  print('--- Section 5: ScaleEndDetails readouts ---');

  final List<ScaleEndDetails> endSamples = <ScaleEndDetails>[
    ScaleEndDetails(
      velocity: Velocity(pixelsPerSecond: Offset(0.0, 0.0)),
      scaleVelocity: 0.0,
      pointerCount: 0,
    ),
    ScaleEndDetails(
      velocity: Velocity(pixelsPerSecond: Offset(120.5, -45.0)),
      scaleVelocity: 1.25,
      pointerCount: 1,
    ),
    ScaleEndDetails(
      velocity: Velocity(pixelsPerSecond: Offset(-300.0, 220.0)),
      scaleVelocity: -0.85,
      pointerCount: 0,
    ),
  ];

  final List<Widget> endCards = <Widget>[];
  for (int i = 0; i < endSamples.length; i++) {
    final e = endSamples[i];
    final pps = e.velocity.pixelsPerSecond;
    print(
      'End[$i]: velocity=$pps '
      'scaleVelocity=${e.scaleVelocity.toStringAsFixed(2)} '
      'pointers=${e.pointerCount}',
    );
    endCards.add(
      _buildReadoutCard(
        title: 'ScaleEndDetails #${i + 1}',
        accent: compassRed,
        parchment: parchment,
        brass: brass,
        brassDark: brassDark,
        ink: ink,
        rows: <List<String>>[
          <String>['pointerCount', '${e.pointerCount}'],
          <String>['velocity.pixelsPerSecond', _fmtOffset(pps)],
          <String>['scaleVelocity', e.scaleVelocity.toStringAsFixed(3)],
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 6 — Focal point + delta vector diagram
  // ============================================================
  print('--- Section 6: Focal point + delta vector diagram ---');

  final focalDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[parchment, parchmentDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brassDark, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: brassDark.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Focal Point & focalPointDelta',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Two pointers establish a centroid; its frame-to-frame movement is the delta.',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: brassDark,
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 220.0,
          child: Stack(
            children: <Widget>[
              // chart background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: parchmentDeep.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: brass, width: 1.0),
                  ),
                ),
              ),
              // pointer A (start)
              Positioned(
                left: 40.0,
                top: 60.0,
                child: _buildPointerDot('A', compassGreen),
              ),
              // pointer B (start)
              Positioned(
                left: 200.0,
                top: 140.0,
                child: _buildPointerDot('B', compassGreen),
              ),
              // focal point (start centroid)
              Positioned(
                left: 120.0,
                top: 100.0,
                child: _buildFocalPin('focal₀', compassBlue),
              ),
              // pointer A' (after move)
              Positioned(
                left: 50.0,
                top: 30.0,
                child: _buildPointerDot('A\'', compassRed),
              ),
              // pointer B' (after move)
              Positioned(
                left: 240.0,
                top: 130.0,
                child: _buildPointerDot('B\'', compassRed),
              ),
              // focal point' (new centroid)
              Positioned(
                left: 145.0,
                top: 80.0,
                child: _buildFocalPin('focal₁', compassRed),
              ),
              // delta arrow label
              Positioned(
                right: 12.0,
                bottom: 12.0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: brassDark,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'focalPointDelta = focal₁ − focal₀',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: parchment,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 — Scale axes diagram (horizontal vs vertical vs uniform)
  // ============================================================
  print('--- Section 7: Scale axes diagram ---');

  final scaleAxesDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          compassRed.withValues(alpha: 0.08),
          parchment,
          compassRed.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: compassRed, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: compassRed.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'scale  vs  horizontalScale  vs  verticalScale',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The pantograph slides on two axes; uniform scale is their geometric harmony.',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: brassDark,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildScaleAxisGauge(
              label: 'horizontalScale',
              factor: 1.6,
              color: compassRed,
              orientation: Axis.horizontal,
              parchment: parchment,
              brassDark: brassDark,
              ink: ink,
            ),
            _buildScaleAxisGauge(
              label: 'verticalScale',
              factor: 1.3,
              color: compassBlue,
              orientation: Axis.vertical,
              parchment: parchment,
              brassDark: brassDark,
              ink: ink,
            ),
            _buildScaleAxisGauge(
              label: 'scale (uniform)',
              factor: 1.45,
              color: compassGreen,
              orientation: Axis.horizontal,
              parchment: parchment,
              brassDark: brassDark,
              ink: ink,
              isUniform: true,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 — Rotation collar dial
  // ============================================================
  print('--- Section 8: Rotation collar ---');

  final rotationDials = <Widget>[];
  final List<double> rotationSamples = <double>[
    0.0,
    0.4,
    -0.6,
    1.2,
    -1.5,
  ];
  for (int i = 0; i < rotationSamples.length; i++) {
    final r = rotationSamples[i];
    print(
      'Rotation sample $i: ${r.toStringAsFixed(2)} rad '
      '(${(r * 57.2958).toStringAsFixed(1)}°)',
    );
    rotationDials.add(
      _buildRotationDial(
        radians: r,
        brass: brass,
        brassDark: brassDark,
        parchment: parchment,
        ink: ink,
        accent: compassRed,
      ),
    );
  }

  final rotationDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[parchment, brassLight.withValues(alpha: 0.5)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brass, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: brassDark.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'rotation — measured in radians since gesture start',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Positive = counter-clockwise (Flutter math convention)',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: brassDark,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: rotationDials,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 — ScaleGestureRecognizer anatomy
  // ============================================================
  print('--- Section 9: ScaleGestureRecognizer anatomy ---');

  // Construct a recognizer to demonstrate it can be instantiated.
  final ScaleGestureRecognizer recognizer = ScaleGestureRecognizer(
    debugOwner: 'scale_details_test',
    dragStartBehavior: DragStartBehavior.start,
  );
  print(
    'Built ScaleGestureRecognizer: kind=${recognizer.runtimeType} '
    'dragStartBehavior=${recognizer.dragStartBehavior}',
  );

  final recognizerAnatomy = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          parchment,
          brassLight.withValues(alpha: 0.55),
          parchment,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brassDark, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: brassDark.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ScaleGestureRecognizer',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Owns the four onScale* callbacks and arbitrates pointer ownership.',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: brassDark,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCallbackPort('onStart', 'ScaleStartDetails', compassGreen),
            _buildCallbackArrow(brassDark),
            _buildCallbackPort('onUpdate', 'ScaleUpdateDetails', compassBlue),
            _buildCallbackArrow(brassDark),
            _buildCallbackPort('onEnd', 'ScaleEndDetails', compassRed),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: parchmentDeep,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: brass, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Notable properties:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: ink,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '• dragStartBehavior — when the drag is "officially" started',
                style: TextStyle(fontSize: 11.0, color: ink),
              ),
              Text(
                '• debugOwner — diagnostic-only owner reference',
                style: TextStyle(fontSize: 11.0, color: ink),
              ),
              Text(
                '• onStart / onUpdate / onEnd / onScaleStart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: ink,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Dispose recognizer to keep the script self-contained.
  recognizer.dispose();
  print('Recognizer disposed cleanly.');

  // ============================================================
  // SECTION 10 — GestureDetector callback signatures
  // ============================================================
  print('--- Section 10: GestureDetector callback signatures ---');

  final callbackSignatures = <Map<String, String>>[
    <String, String>{
      'name': 'onScaleStart',
      'sig': 'void Function(ScaleStartDetails details)',
      'when': 'Two pointers contact and gesture is recognized',
    },
    <String, String>{
      'name': 'onScaleUpdate',
      'sig': 'void Function(ScaleUpdateDetails details)',
      'when': 'Pointers move while gesture is active',
    },
    <String, String>{
      'name': 'onScaleEnd',
      'sig': 'void Function(ScaleEndDetails details)',
      'when': 'All pointers are lifted',
    },
  ];

  final List<Widget> sigRows = <Widget>[];
  for (int i = 0; i < callbackSignatures.length; i++) {
    final cs = callbackSignatures[i];
    print('Signature: ${cs['name']} — ${cs['sig']}');
    sigRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: parchmentDeep,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: brass, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              cs['name'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: brassDark,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              cs['sig'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: ink,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              cs['when'] as String,
              style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: brassDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final callbackBlock = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[parchment, parchmentDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brassDark, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: brassDark.withValues(alpha: 0.20),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'GestureDetector.onScale*  callback signatures',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 10.0),
        ...sigRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 11 — Code examples (engraver's plate)
  // ============================================================
  print('--- Section 11: Code examples ---');

  final codePlate = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: ink,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: brass, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: brassDark.withValues(alpha: 0.40),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.architecture, color: brassLight, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Engraver\'s Plate — Usage',
              style: TextStyle(
                fontFamily: 'serif',
                color: brassLight,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          'GestureDetector(\n'
          '  onScaleStart: (ScaleStartDetails d) {\n'
          '    print(\'pointers: \${d.pointerCount}\');\n'
          '    print(\'focal: \${d.localFocalPoint}\');\n'
          '  },\n'
          '  onScaleUpdate: (ScaleUpdateDetails d) {\n'
          '    print(\'scale: \${d.scale}\');\n'
          '    print(\'rotation: \${d.rotation}\');\n'
          '    print(\'h/v: \${d.horizontalScale}/\${d.verticalScale}\');\n'
          '  },\n'
          '  onScaleEnd: (ScaleEndDetails d) {\n'
          '    print(\'velocity: \${d.velocity.pixelsPerSecond}\');\n'
          '  },\n'
          '  child: ChartCanvas(),\n'
          ')',
          Color(0xFF8AD3FF),
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Construct details directly (e.g. from a synthetic test):\n'
          'final start = ScaleStartDetails(\n'
          '  focalPoint: Offset(120, 80),\n'
          '  localFocalPoint: Offset(60, 40),\n'
          '  pointerCount: 2,\n'
          ');\n'
          'final update = ScaleUpdateDetails(\n'
          '  focalPoint: Offset(125, 82),\n'
          '  localFocalPoint: Offset(62.5, 41),\n'
          '  focalPointDelta: Offset(5, 2),\n'
          '  scale: 1.10,\n'
          '  horizontalScale: 1.10,\n'
          '  verticalScale: 1.10,\n'
          '  rotation: 0.0,\n'
          '  pointerCount: 2,\n'
          ');\n'
          'final end = ScaleEndDetails(\n'
          '  velocity: Velocity(pixelsPerSecond: Offset(120, -45)),\n'
          '  scaleVelocity: 1.25,\n'
          '  pointerCount: 0,\n'
          ');',
          Color(0xFFB8E8C4),
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Wire a raw recognizer:\n'
          'final r = ScaleGestureRecognizer(debugOwner: this)\n'
          '  ..onStart = (ScaleStartDetails d) { /* ... */ }\n'
          '  ..onUpdate = (ScaleUpdateDetails d) { /* ... */ }\n'
          '  ..onEnd = (ScaleEndDetails d) { /* ... */ };\n'
          '// remember to r.dispose() when done',
          Color(0xFFE8C28A),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12 — Closing brass plate
  // ============================================================
  print('--- Section 12: Closing brass plate ---');

  final closingPlate = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[brassDark, brass, brassLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: ink, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ink.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(Icons.verified, color: parchment, size: 36.0),
        SizedBox(height: 6.0),
        Text(
          'Pantograph Calibrated',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: parchment,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Start ▸ Update ▸ End — every field surveyed.',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: parchment,
          ),
        ),
      ],
    ),
  );

  print('Scale Details Deep Demo completed successfully');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Header — brass instrument case
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[brassDark, brass, brassLight, brass, brassDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: ink, width: 2.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ink.withValues(alpha: 0.45),
                blurRadius: 14.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.architecture, size: 56.0, color: parchment),
              SizedBox(height: 8.0),
              Text(
                'Scale Gesture Details',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: parchment,
                ),
              ),
              Text(
                'A cartographer\'s pantograph — Start · Update · End',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                  color: parchment,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1 — Lifecycle anatomy
        Text(
          '1. Gesture Lifecycle Anatomy',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: lifecycleCards),
        SizedBox(height: 28.0),

        // Section 2 — Field reference
        Text(
          '2. Field Reference (9 fields)',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: fieldRefCards),
        SizedBox(height: 28.0),

        // Section 6 — Focal + delta diagram (placed early for context)
        Text(
          '3. focalPoint  &  focalPointDelta',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        focalDiagram,
        SizedBox(height: 28.0),

        // Section 7 — Scale axes diagram
        Text(
          '4. Scale Axes — uniform, horizontal, vertical',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        scaleAxesDiagram,
        SizedBox(height: 28.0),

        // Section 8 — Rotation collar
        Text(
          '5. Rotation Collar',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        rotationDiagram,
        SizedBox(height: 28.0),

        // Section 3 — ScaleStartDetails
        Text(
          '6. ScaleStartDetails — Instrument Readouts',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: startCards),
        SizedBox(height: 28.0),

        // Section 4 — ScaleUpdateDetails
        Text(
          '7. ScaleUpdateDetails — Instrument Readouts',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: updateCards),
        SizedBox(height: 28.0),

        // Section 5 — ScaleEndDetails
        Text(
          '8. ScaleEndDetails — Instrument Readouts',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: endCards),
        SizedBox(height: 28.0),

        // Section 9 — Recognizer anatomy
        Text(
          '9. ScaleGestureRecognizer',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        recognizerAnatomy,
        SizedBox(height: 28.0),

        // Section 10 — Callback signatures
        Text(
          '10. GestureDetector.onScale* Signatures',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        callbackBlock,
        SizedBox(height: 28.0),

        // Section 11 — Code plate
        Text(
          '11. Engraver\'s Code Plate',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        codePlate,
        SizedBox(height: 28.0),

        // Section 12 — Closing
        closingPlate,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// HELPERS
// ----------------------------------------------------------------

String _fmtOffset(Offset o) =>
    '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';

Widget _buildReadoutCard({
  required String title,
  required Color accent,
  required Color parchment,
  required Color brass,
  required Color brassDark,
  required Color ink,
  required List<List<String>> rows,
}) {
  final List<Widget> rowWidgets = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final row = rows[i];
    final bool zebra = i % 2 == 0;
    rowWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: zebra
            ? accent.withValues(alpha: 0.07)
            : parchment.withValues(alpha: 0.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 130.0,
              child: Text(
                row[0],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: brassDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: ink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    width: 280.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          parchment,
          accent.withValues(alpha: 0.06),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.6),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Card "engraved" title bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.science, color: parchment, size: 16.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: parchment,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        ...rowWidgets,
        SizedBox(height: 4.0),
        Container(
          height: 4.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                accent.withValues(alpha: 0.8),
                accent.withValues(alpha: 0.0),
              ],
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPointerDot(String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 18.0,
        height: 18.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
      SizedBox(height: 2.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _buildFocalPin(String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 22.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2.5),
        ),
        child: Center(
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
      SizedBox(height: 2.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _buildScaleAxisGauge({
  required String label,
  required double factor,
  required Color color,
  required Axis orientation,
  required Color parchment,
  required Color brassDark,
  required Color ink,
  bool isUniform = false,
}) {
  final double base = 80.0;
  final double scaled = base * factor;
  // For uniform scaling, both axes change; for one-axis, only that one.
  final double width = (isUniform || orientation == Axis.horizontal)
      ? scaled
      : base;
  final double height =
      (isUniform || orientation == Axis.vertical) ? scaled : base;
  return SizedBox(
    width: 110.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: brassDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          height: 100.0,
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Center(
              child: Text(
                '×${factor.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            isUniform ? 'both axes' : '1 axis',
            style: TextStyle(
              fontSize: 9.0,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRotationDial({
  required double radians,
  required Color brass,
  required Color brassDark,
  required Color parchment,
  required Color ink,
  required Color accent,
}) {
  final double degrees = radians * 57.2958;
  return Container(
    width: 110.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[parchment, brass.withValues(alpha: 0.20)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: brassDark, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: brassDark.withValues(alpha: 0.25),
          blurRadius: 4.0,
          offset: Offset(1.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[parchment, brass.withValues(alpha: 0.4)],
            ),
            border: Border.all(color: brassDark, width: 2.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Tick marks at cardinal points
              Container(
                width: 4.0,
                height: 60.0,
                alignment: Alignment.topCenter,
                child: Container(
                  width: 2.0,
                  height: 8.0,
                  color: brassDark,
                ),
              ),
              // Needle (rotated)
              Transform.rotate(
                angle: radians,
                child: Container(
                  width: 3.0,
                  height: 50.0,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 3.0,
                        height: 25.0,
                        color: accent,
                      ),
                    ],
                  ),
                ),
              ),
              // Center cap
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: brassDark,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          '${radians.toStringAsFixed(2)} rad',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        Text(
          '${degrees.toStringAsFixed(1)}°',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: brassDark,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCallbackPort(String name, String detailsType, Color color) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: <Widget>[
        Icon(Icons.cable, color: color, size: 18.0),
        SizedBox(height: 4.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          detailsType,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCallbackArrow(Color color) {
  return Icon(Icons.arrow_forward, color: color, size: 22.0);
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1A1208),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF7A5C2E), width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
