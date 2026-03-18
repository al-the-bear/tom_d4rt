// D4rt test script: Deep Demo for FlutterView from dart:ui
// FlutterView is the primary rendering surface that connects
// to a physical Display with configuration, size, padding, insets
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FlutterView Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ACCESSING THE VIEW
  // ═══════════════════════════════════════════════════════════════════════════

  // Primary access method in Flutter framework
  final view = View.of(context);
  print('View obtained via View.of(context)');

  // Also available via PlatformDispatcher
  final dispatcher = ui.PlatformDispatcher.instance;
  final views = dispatcher.views;
  print('Number of views: ${views.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: VIEW PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('View properties:');
  print('  viewId: ${view.viewId}');
  print('  physicalSize: ${view.physicalSize}');
  print('  devicePixelRatio: ${view.devicePixelRatio}');
  final logicalW = view.physicalSize.width / view.devicePixelRatio;
  final logicalH = view.physicalSize.height / view.devicePixelRatio;
  print('  logicalSize: ${logicalW.round()} × ${logicalH.round()}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: PADDING & INSETS
  // ═══════════════════════════════════════════════════════════════════════════

  print('Padding (safe area):');
  print('  top: ${view.padding.top}');
  print('  bottom: ${view.padding.bottom}');
  print('  left: ${view.padding.left}');
  print('  right: ${view.padding.right}');

  print('viewInsets (keyboard, etc.):');
  print('  top: ${view.viewInsets.top}');
  print('  bottom: ${view.viewInsets.bottom}');

  print('viewPadding:');
  print('  top: ${view.viewPadding.top}');
  print('  bottom: ${view.viewPadding.bottom}');

  print('systemGestureInsets:');
  print('  left: ${view.systemGestureInsets.left}');
  print('  right: ${view.systemGestureInsets.right}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final display = view.display;
  print('Backing display:');
  print('  id: ${display.id}');
  print('  size: ${display.size}');
  print('  refreshRate: ${display.refreshRate} Hz');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: DISPLAY FEATURES
  // ═══════════════════════════════════════════════════════════════════════════

  final features = view.displayFeatures;
  print('display features: ${features.length}');
  for (final f in features) {
    print('  type=${f.type}, bounds=${f.bounds}');
  }

  print('FlutterView demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.window, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FlutterView',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Rendering surface: size, padding, insets, display linkage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'viewId: ${view.viewId}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: Properties Overview ──
              _sectionTitle('1. VIEW PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _propRow(
                      'viewId',
                      '${view.viewId}',
                      'Unique identifier',
                      Icons.fingerprint,
                      Color(0xFF1B5E20),
                    ),
                    _propRow(
                      'physicalSize',
                      '${view.physicalSize.width.toInt()}×${view.physicalSize.height.toInt()}',
                      'Size in physical pixels',
                      Icons.aspect_ratio,
                      Color(0xFF0D47A1),
                    ),
                    _propRow(
                      'devicePixelRatio',
                      '${view.devicePixelRatio}',
                      'Physical px / logical px',
                      Icons.zoom_in,
                      Color(0xFFE65100),
                    ),
                    _propRow(
                      'logicalSize',
                      '${logicalW.round()}×${logicalH.round()}',
                      'Calculated logical size',
                      Icons.crop,
                      Color(0xFF6A1B9A),
                    ),
                    _propRow(
                      'gestureSettings',
                      '${view.gestureSettings}',
                      'Touch slop settings',
                      Icons.touch_app,
                      Color(0xFF00695C),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Visual Size Comparison ──
              _sectionTitle('2. PHYSICAL vs LOGICAL SIZE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _sizeBar(
                      'Physical',
                      view.physicalSize.width,
                      view.physicalSize.width,
                      Color(0xFF0D47A1),
                    ),
                    SizedBox(height: 6),
                    _sizeBar(
                      'Logical',
                      logicalW,
                      view.physicalSize.width,
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _sizeBox(
                          '${view.physicalSize.width.toInt()} px',
                          'Physical',
                          Color(0xFF0D47A1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '÷ ${view.devicePixelRatio}x →',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        _sizeBox(
                          '${logicalW.round()} lp',
                          'Logical',
                          Color(0xFF2E7D32),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 3: Padding Diagram ──
              _sectionTitle('3. PADDING & INSETS DIAGRAM'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFFECEFF1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFF455A64), width: 2),
                  ),
                  child: Stack(
                    children: [
                      // Top padding
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          color: Color(0xFF1B5E20).withValues(alpha: 0.2),
                          child: Center(
                            child: Text(
                              'padding.top: ${view.padding.top}',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Bottom padding
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          color: Color(0xFF1B5E20).withValues(alpha: 0.2),
                          child: Center(
                            child: Text(
                              'padding.bottom: ${view.padding.bottom}',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Left padding
                      Positioned(
                        top: 30,
                        bottom: 30,
                        left: 0,
                        child: Container(
                          width: 30,
                          color: Color(0xFF0D47A1).withValues(alpha: 0.15),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Center(
                              child: Text(
                                'L: ${view.padding.left}',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF0D47A1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Right padding
                      Positioned(
                        top: 30,
                        bottom: 30,
                        right: 0,
                        child: Container(
                          width: 30,
                          color: Color(0xFF0D47A1).withValues(alpha: 0.15),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Center(
                              child: Text(
                                'R: ${view.padding.right}',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF0D47A1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Safe area (center)
                      Positioned(
                        top: 32,
                        bottom: 32,
                        left: 32,
                        right: 32,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFF2E7D32),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Safe Area',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Section 4: Insets Detail ──
              _sectionTitle('4. PADDING TYPES COMPARED'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _insetRow(
                      'padding',
                      'System UI overlay area',
                      'Status bar, notch, nav bar',
                      Color(0xFF1B5E20),
                    ),
                    _insetRow(
                      'viewPadding',
                      'Always full system insets',
                      'Does not reduce when keyboard appears',
                      Color(0xFF0D47A1),
                    ),
                    _insetRow(
                      'viewInsets',
                      'Occluded by input methods',
                      'Keyboard, bottom sheet',
                      Color(0xFFE65100),
                    ),
                    _insetRow(
                      'systemGestureInsets',
                      'System gesture zones',
                      'Back swipe, home gesture areas',
                      Color(0xFF6A1B9A),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'padding = viewPadding - consumed portion. When keyboard opens, '
                        'padding.bottom becomes 0 but viewPadding.bottom remains.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Display Link ──
              _sectionTitle('5. BACKING DISPLAY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.window,
                              color: Color(0xFF1B5E20),
                              size: 24,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'FlutterView',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'viewId: ${view.viewId}',
                              style: TextStyle(
                                fontSize: 9,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.grey[400],
                          size: 16,
                        ),
                        Text(
                          '.display',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.monitor,
                              color: Color(0xFF0D47A1),
                              size: 24,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Display',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'id: ${display.id}',
                              style: TextStyle(
                                fontSize: 9,
                                fontFamily: 'monospace',
                              ),
                            ),
                            Text(
                              '${display.refreshRate.toInt()} Hz',
                              style: TextStyle(fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Architecture ──
              _sectionTitle('6. FLUTTER VIEW ARCHITECTURE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _archLayer(
                      'Widget Tree',
                      'build() methods',
                      Color(0xFF1B5E20),
                    ),
                    _archArrow(),
                    _archLayer(
                      'RenderObject',
                      'layout & paint',
                      Color(0xFF0D47A1),
                    ),
                    _archArrow(),
                    _archLayer(
                      'Scene → FlutterView',
                      'view.render(scene)',
                      Color(0xFFE65100),
                    ),
                    _archArrow(),
                    _archLayer(
                      'Engine → Display',
                      'GPU compositing',
                      Color(0xFF6A1B9A),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _propRow(
  String name,
  String value,
  String desc,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 9, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sizeBar(String label, double value, double max, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 60,
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
              height: 16,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            FractionallySizedBox(
              widthFactor: (value / max).clamp(0.0, 1.0),
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 8),
      Text(
        '${value.round()}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

Widget _sizeBox(String value, String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Widget _insetRow(String name, String title, String sub, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 10)),
              Text(sub, style: TextStyle(fontSize: 9, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _archLayer(String label, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color,
            ),
          ),
        ),
        Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _archArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[300]),
  );
}
