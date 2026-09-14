// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — TransformationController
// Demonstrates TransformationController — a ValueNotifier<Matrix4>
// that drives InteractiveViewer pan/zoom. Covers matrix operations,
// coordinate mapping, programmatic zoom, boundary constraints, and
// the relationship with InteractiveViewer.
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('TransformationController Deep Demo executing');

  // ============================================================
  // SECTION 1: What is TransformationController?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.zoom_in,
      'title': 'ValueNotifier<Matrix4>',
      'body': 'TransformationController extends ValueNotifier<Matrix4> '
          'and holds the current 4×4 transformation matrix that '
          'controls pan and zoom state. Listeners are notified on '
          'every matrix update.',
      'accent': Colors.deepOrange[800]!,
    },
    {
      'icon': Icons.open_with,
      'title': 'InteractiveViewer Driver',
      'body': 'InteractiveViewer uses TransformationController as its '
          'state holder. The controller lets you read the current '
          'transform, programmatically zoom/pan, or reset the view.',
      'accent': Colors.cyan[800]!,
    },
    {
      'icon': Icons.grid_on,
      'title': 'Matrix4 Transform',
      'body': 'The value is a 4×4 affine transformation Matrix4. '
          'Translation (pan) is in matrix entries [12] and [13]. '
          'Scale (zoom) is in entries [0] and [5]. Entry [15] is '
          'always 1.0 for 2D transforms.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.map,
      'title': 'Coordinate Mapping',
      'body': 'The toScene() method converts viewport coordinates to '
          'scene coordinates by inverting the matrix. Essential for '
          'mapping tap positions to the actual content location.',
      'accent': Colors.cyan[700]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Matrix4 Anatomy
  // ============================================================
  print('=== Section 2: Matrix4 Anatomy ===');

  // Build a sample matrix showing scale 2x and translation (50, 80)
  final sampleMatrix = Matrix4.identity()
    ..scale(2.0, 2.0)
    ..setTranslationRaw(50, 80, 0);

  final matrixEntries = <Map<String, dynamic>>[
    {'row': 0, 'col': 0, 'label': 'scaleX', 'value': sampleMatrix.entry(0, 0), 'highlight': true},
    {'row': 0, 'col': 1, 'label': 'shearY', 'value': sampleMatrix.entry(0, 1), 'highlight': false},
    {'row': 0, 'col': 2, 'label': '-', 'value': sampleMatrix.entry(0, 2), 'highlight': false},
    {'row': 0, 'col': 3, 'label': 'transX', 'value': sampleMatrix.entry(0, 3), 'highlight': true},
    {'row': 1, 'col': 0, 'label': 'shearX', 'value': sampleMatrix.entry(1, 0), 'highlight': false},
    {'row': 1, 'col': 1, 'label': 'scaleY', 'value': sampleMatrix.entry(1, 1), 'highlight': true},
    {'row': 1, 'col': 2, 'label': '-', 'value': sampleMatrix.entry(1, 2), 'highlight': false},
    {'row': 1, 'col': 3, 'label': 'transY', 'value': sampleMatrix.entry(1, 3), 'highlight': true},
    {'row': 2, 'col': 0, 'label': '-', 'value': sampleMatrix.entry(2, 0), 'highlight': false},
    {'row': 2, 'col': 1, 'label': '-', 'value': sampleMatrix.entry(2, 1), 'highlight': false},
    {'row': 2, 'col': 2, 'label': 'scaleZ', 'value': sampleMatrix.entry(2, 2), 'highlight': false},
    {'row': 2, 'col': 3, 'label': '-', 'value': sampleMatrix.entry(2, 3), 'highlight': false},
    {'row': 3, 'col': 0, 'label': '-', 'value': sampleMatrix.entry(3, 0), 'highlight': false},
    {'row': 3, 'col': 1, 'label': '-', 'value': sampleMatrix.entry(3, 1), 'highlight': false},
    {'row': 3, 'col': 2, 'label': '-', 'value': sampleMatrix.entry(3, 2), 'highlight': false},
    {'row': 3, 'col': 3, 'label': 'w', 'value': sampleMatrix.entry(3, 3), 'highlight': false},
  ];

  print('  Matrix entries: ${matrixEntries.length}');

  // Key extraction helpers
  final scaleX = sampleMatrix.entry(0, 0);
  final scaleY = sampleMatrix.entry(1, 1);
  final transX = sampleMatrix.entry(0, 3);
  final transY = sampleMatrix.entry(1, 3);
  print('  Sample: scaleX=$scaleX, scaleY=$scaleY, tx=$transX, ty=$transY');

  // ============================================================
  // SECTION 3: API Surface
  // ============================================================
  print('=== Section 3: API ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'value',
      'type': 'Matrix4 (getter/setter)',
      'description': 'The current 4×4 transformation matrix. Setting '
          'a new matrix notifies all listeners and updates the '
          'InteractiveViewer. Default is Matrix4.identity().',
      'icon': Icons.grid_4x4,
      'color': Colors.deepOrange[800]!,
    },
    {
      'name': 'toScene(Offset viewportPoint)',
      'type': 'Offset',
      'description': 'Converts a point from viewport coordinates to '
          'scene (content) coordinates by applying the inverse of '
          'the current matrix. Essential for mapping user taps.',
      'icon': Icons.transform,
      'color': Colors.cyan[800]!,
    },
    {
      'name': 'addListener / removeListener',
      'type': 'void (inherited)',
      'description': 'Register callbacks for matrix changes. Fired '
          'during every pan/zoom gesture update and when value '
          'is set programmatically.',
      'icon': Icons.hearing,
      'color': Colors.deepOrange[700]!,
    },
    {
      'name': 'dispose()',
      'type': 'void (inherited)',
      'description': 'Cleans up listeners. Always call in State.dispose '
          'to avoid memory leaks. After dispose, the controller '
          'must not be used.',
      'icon': Icons.delete_sweep,
      'color': Colors.cyan[700]!,
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 4: Common Operations
  // ============================================================
  print('=== Section 4: Operations ===');

  final operations = <Map<String, dynamic>>[
    {
      'title': 'Reset to Identity',
      'code': 'controller.value = Matrix4.identity();',
      'description': 'Returns to 1x zoom at origin (0,0). The simplest '
          'way to reset pan and zoom.',
      'color': Colors.deepOrange[800]!,
    },
    {
      'title': 'Programmatic Zoom',
      'code': 'final zoomed = Matrix4.identity()\n'
          '  ..translate(focalX, focalY)\n'
          '  ..scale(newScale)\n'
          '  ..translate(-focalX, -focalY);\n'
          'controller.value = zoomed;',
      'description': 'Zoom around a focal point. The translate-scale-'
          'untranslate pattern keeps the focal point stationary.',
      'color': Colors.cyan[800]!,
    },
    {
      'title': 'Programmatic Pan',
      'code': 'final m = controller.value.clone()\n'
          '  ..translate(dx, dy);\n'
          'controller.value = m;',
      'description': 'Pan by (dx, dy) pixels relative to current '
          'position. Clone the existing matrix first to preserve '
          'the current zoom level.',
      'color': Colors.deepOrange[700]!,
    },
    {
      'title': 'Read Current State',
      'code': 'final m = controller.value;\n'
          'final zoom = m.getMaxScaleOnAxis();\n'
          'final tx = m.getTranslation().x;\n'
          'final ty = m.getTranslation().y;',
      'description': 'Extract current zoom level and translation from '
          'the matrix. getMaxScaleOnAxis() returns the largest '
          'scale factor.',
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Animate to Transform',
      'code': 'final begin = controller.value;\n'
          'final end = Matrix4.identity();\n'
          'final anim = Matrix4Tween(\n'
          '  begin: begin, end: end,\n'
          ').animate(curve);',
      'description': 'Animate between two transforms using '
          'Matrix4Tween. Assign anim.value to controller.value '
          'in a listener for smooth transitions.',
      'color': Colors.deepOrange[600]!,
    },
  ];

  print('  Operations: ${operations.length}');

  // ============================================================
  // SECTION 5: toScene() Coordinate Mapping
  // ============================================================
  print('=== Section 5: Coordinate Mapping ===');

  // Demonstrate coordinate conversion at various scales
  final coordExamples = <Map<String, dynamic>>[];
  for (final zoomLevel in [1.0, 2.0, 3.0, 0.5]) {
    final ctrlMatrix = Matrix4.identity()..scale(zoomLevel, zoomLevel);
    final ctrl = TransformationController(ctrlMatrix);
    final viewportPoint = Offset(100, 100);
    final scenePoint = ctrl.toScene(viewportPoint);
    coordExamples.add({
      'zoom': zoomLevel,
      'viewportX': viewportPoint.dx,
      'viewportY': viewportPoint.dy,
      'sceneX': scenePoint.dx.toStringAsFixed(1),
      'sceneY': scenePoint.dy.toStringAsFixed(1),
    });
    ctrl.dispose();
  }

  print('  Coordinate examples: ${coordExamples.length}');

  // ============================================================
  // SECTION 6: InteractiveViewer Integration
  // ============================================================
  print('=== Section 6: InteractiveViewer ===');

  final viewerProperties = <Map<String, dynamic>>[
    {
      'name': 'transformationController',
      'description': 'The TransformationController to use. If not '
          'provided, InteractiveViewer creates an internal one. '
          'Provide yours for external state access.',
      'icon': Icons.settings_remote,
      'color': Colors.deepOrange[800]!,
    },
    {
      'name': 'minScale / maxScale',
      'description': 'Clamping range for the zoom level. Controller '
          'value stays within these bounds during gestures.',
      'icon': Icons.zoom_out_map,
      'color': Colors.cyan[800]!,
    },
    {
      'name': 'boundaryMargin',
      'description': 'Extra space beyond the child bounds that the '
          'user can pan into. EdgeInsets.all(double.infinity) '
          'allows infinite panning.',
      'icon': Icons.border_outer,
      'color': Colors.deepOrange[700]!,
    },
    {
      'name': 'constrained',
      'description': 'When true (default), the child cannot be smaller '
          'than the viewport. When false, allows zooming out past '
          'the child size.',
      'icon': Icons.lock,
      'color': Colors.cyan[700]!,
    },
    {
      'name': 'onInteractionStart/Update/End',
      'description': 'Callbacks fired during gesture lifecycle. Receive '
          'ScaleStartDetails/UpdateDetails/EndDetails with focal '
          'point, scale, and pointer count.',
      'icon': Icons.touch_app,
      'color': Colors.deepOrange[600]!,
    },
  ];

  print('  Viewer properties: ${viewerProperties.length}');

  // ============================================================
  // SECTION 7: Zoom Level Visualization
  // ============================================================
  print('=== Section 7: Zoom Levels ===');

  final zoomLevels = <Map<String, dynamic>>[];
  for (final z in [0.25, 0.5, 1.0, 1.5, 2.0, 3.0, 4.0]) {
    final pct = (z * 100).toInt();
    zoomLevels.add({
      'zoom': z,
      'label': '$pct%',
      'barWidth': math.min(z / 4.0, 1.0),
      'color': Color.lerp(Colors.cyan[200], Colors.deepOrange[800], (z - 0.25) / 3.75)!,
    });
  }

  print('  Zoom levels: ${zoomLevels.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Store in State, Not Build',
      'detail': 'Create the TransformationController as a field in '
          'your State class. Creating in build() would lose the '
          'current transform on every rebuild.',
      'icon': Icons.save,
      'color': Colors.deepOrange[800]!,
    },
    {
      'title': 'Clone Before Modifying',
      'detail': 'Always clone() the matrix before applying operations. '
          'Direct mutation without assignment won\'t trigger '
          'notifyListeners.',
      'icon': Icons.copy,
      'color': Colors.cyan[800]!,
    },
    {
      'title': 'Respect minScale / maxScale',
      'detail': 'When setting the value programmatically, ensure the '
          'scale stays within InteractiveViewer\'s bounds. The '
          'viewer won\'t clamp external assignments.',
      'icon': Icons.rule,
      'color': Colors.deepOrange[700]!,
    },
    {
      'title': 'Use toScene for Hit Testing',
      'detail': 'Map tap positions through toScene() to get actual '
          'content coordinates. Raw viewport positions are wrong '
          'when zoomed or panned.',
      'icon': Icons.gps_fixed,
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Animate with Matrix4Tween',
      'detail': 'For smooth programmatic transitions, use '
          'Matrix4Tween with AnimationController. Assign the '
          'animated value in a listener.',
      'icon': Icons.animation,
      'color': Colors.deepOrange[600]!,
    },
  ];

  print('  Practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange[800]!, Colors.cyan[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.zoom_in, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('TransformationController',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'A ValueNotifier<Matrix4> that drives pan and zoom '
                'for InteractiveViewer — giving you full control over '
                '2D affine transformations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Matrix4 Anatomy ----
        _sectionHeader('2. Matrix4 Anatomy', Icons.grid_4x4, Colors.cyan[800]!),
        SizedBox(height: 10),
        Text('Sample matrix: scale(2.0) + translate(50, 80)',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: List.generate(4, (row) {
              return Container(
                color: row.isEven ? Colors.white : Colors.deepOrange[50],
                child: Row(
                  children: List.generate(4, (col) {
                    final idx = row * 4 + col;
                    final entry = matrixEntries[idx];
                    final isHighlight = entry['highlight'] as bool;
                    final val = (entry['value'] as double).toStringAsFixed(1);
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!, width: 0.5),
                          color: isHighlight ? Colors.deepOrange[100] : null,
                        ),
                        child: Column(
                          children: [
                            Text(val,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'monospace',
                                  fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                                  color: isHighlight ? Colors.deepOrange[900] : Colors.grey[700],
                                )),
                            SizedBox(height: 2),
                            Text(entry['label'] as String,
                                style: TextStyle(fontSize: 9, color: Colors.grey[500])),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _matrixChip('scaleX', '$scaleX', Colors.deepOrange[800]!),
            _matrixChip('scaleY', '$scaleY', Colors.deepOrange[700]!),
            _matrixChip('transX', '$transX', Colors.cyan[800]!),
            _matrixChip('transY', '$transY', Colors.cyan[700]!),
          ],
        ),

        SizedBox(height: 20),

        // ---- Section 3: API ----
        _sectionHeader('3. API Surface', Icons.api, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        ...apiEntries.map((a) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(a['icon'] as IconData, color: a['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(a['name'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: a['color'] as Color)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(a['type'] as String,
                                    style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(a['description'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Operations ----
        _sectionHeader('4. Common Operations', Icons.code, Colors.cyan[800]!),
        SizedBox(height: 10),
        ...operations.map((o) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(o['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: o['color'] as Color)),
                    SizedBox(height: 4),
                    Text(o['description'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(o['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.orangeAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Coordinate Mapping ----
        _sectionHeader('5. toScene() Mapping', Icons.transform, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        Text('Viewport point (100, 100) mapped to scene at different zoom levels:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.deepOrange[800],
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text('Zoom', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Viewport', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Scene (toScene)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Effect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(coordExamples.length, (i) {
                final e = coordExamples[i];
                final zoom = e['zoom'] as double;
                final effect = zoom > 1
                    ? 'Zoomed in: smaller scene coords'
                    : zoom < 1
                        ? 'Zoomed out: larger scene coords'
                        : 'Identity: 1:1 mapping';
                return Container(
                  color: i.isEven ? Colors.white : Colors.deepOrange[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text('${zoom}x', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                      Expanded(flex: 2, child: Text('(${e['viewportX']}, ${e['viewportY']})', style: TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                      Expanded(flex: 2, child: Text('(${e['sceneX']}, ${e['sceneY']})', style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.deepOrange[700]))),
                      Expanded(flex: 2, child: Text(effect, style: TextStyle(fontSize: 10))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: InteractiveViewer Props ----
        _sectionHeader('6. InteractiveViewer', Icons.open_with, Colors.cyan[800]!),
        SizedBox(height: 10),
        ...viewerProperties.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: p['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(p['icon'] as IconData, color: p['color'] as Color, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: p['color'] as Color)),
                          SizedBox(height: 3),
                          Text(p['description'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Zoom Levels ----
        _sectionHeader('7. Zoom Level Visualization', Icons.zoom_out_map, Colors.deepOrange[800]!),
        SizedBox(height: 10),
        ...zoomLevels.map((z) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 44,
                    child: Text(z['label'] as String,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        final barW = constraints.maxWidth * (z['barWidth'] as double);
                        return Stack(
                          children: [
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              height: 24,
                              width: barW,
                              decoration: BoxDecoration(
                                color: z['color'] as Color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '${z['zoom']}x',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: (z['zoom'] as double) >= 1.5 ? Colors.white : Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Colors.cyan[800]!),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.zoom_in, color: Colors.deepOrange[600], size: 28),
              SizedBox(height: 6),
              Text(
                'TransformationController: full matrix control over '
                'pan and zoom — the ValueNotifier that makes '
                'InteractiveViewer programmable.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}

Widget _matrixChip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        SizedBox(width: 4),
        Text('= $value', style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color)),
      ],
    ),
  );
}
