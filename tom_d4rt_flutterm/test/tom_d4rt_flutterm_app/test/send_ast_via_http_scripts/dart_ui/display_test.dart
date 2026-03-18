// D4rt test script: Deep Demo for Display from dart:ui
// Display represents a physical display/monitor with size, pixel ratio,
// and refresh rate information
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Display Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ACCESSING DISPLAYS
  // ═══════════════════════════════════════════════════════════════════════════

  // Display is obtained from PlatformDispatcher or FlutterView, not constructed directly
  final dispatcher = ui.PlatformDispatcher.instance;
  final displays = dispatcher.displays;
  final displayList = displays.toList();
  print('Number of connected displays: ${displayList.length}');

  for (var i = 0; i < displayList.length; i++) {
    final d = displayList[i];
    print('Display $i:');
    print('  id: ${d.id}');
    print('  size: ${d.size}');
    print('  devicePixelRatio: ${d.devicePixelRatio}');
    print('  refreshRate: ${d.refreshRate}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: DISPLAY PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  if (displays.isNotEmpty) {
    final primary = displays.first;
    print('Primary display properties:');
    print('  id: ${primary.id}');
    print('  size: ${primary.size} (physical pixels)');
    print('  devicePixelRatio: ${primary.devicePixelRatio}');
    print('  logical size: ${primary.size / primary.devicePixelRatio}');
    print('  refreshRate: ${primary.refreshRate} Hz');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: MULTI-DISPLAY SCENARIOS
  // ═══════════════════════════════════════════════════════════════════════════

  print('Multi-display usage:');
  print('  for (final display in PlatformDispatcher.instance.displays) {');
  print('    if (display.size.width > 2000) { ... large display ... }');
  print('    if (display.refreshRate >= 120) { ... high refresh ... }');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DISPLAY vs VIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('Display vs FlutterView:');
  print('  Display: physical screen hardware properties');
  print('  FlutterView: rendering surface that maps to a display');
  print('  A view has a display property: view.display');

  print('Display demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  // Simulated display info data for visualization
  final displayInfos = <_DisplayInfo>[
    _DisplayInfo(0, Size(2560, 1440), 2.0, 60),
    _DisplayInfo(1, Size(1920, 1080), 1.5, 144),
    _DisplayInfo(2, Size(3840, 2160), 3.0, 120),
    _DisplayInfo(3, Size(1080, 2400), 2.5, 90),
  ];

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
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.monitor, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Display',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Physical display properties: size, pixel ratio, refresh rate',
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
                        '${displays.length} connected display(s)',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: API Overview ──
              _sectionTitle('1. DISPLAY API PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _propertyRow(
                      'id',
                      'int',
                      'Unique identifier for the display',
                      Icons.fingerprint,
                      Color(0xFF0D47A1),
                    ),
                    _propertyRow(
                      'size',
                      'Size',
                      'Physical resolution in pixels',
                      Icons.aspect_ratio,
                      Color(0xFF2E7D32),
                    ),
                    _propertyRow(
                      'devicePixelRatio',
                      'double',
                      'Physical px per logical px',
                      Icons.zoom_in,
                      Color(0xFFE65100),
                    ),
                    _propertyRow(
                      'refreshRate',
                      'double',
                      'Screen refresh rate in Hz',
                      Icons.speed,
                      Color(0xFF6A1B9A),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Display Cards ──
              _sectionTitle('2. SIMULATED DISPLAYS'),
              ...displayInfos.map((d) => _displayCard(d)),

              // ── Section 3: Resolution Comparison ──
              _sectionTitle('3. RESOLUTION COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: displayInfos.map((d) => _resolutionBar(d)).toList(),
                ),
              ),

              // ── Section 4: Pixel Ratio Visualization ──
              _sectionTitle('4. DEVICE PIXEL RATIO'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    ...displayInfos.map(
                      (d) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                'Display ${d.id}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: d.dpr / 4.0,
                                    child: Container(
                                      height: 18,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFE65100),
                                            Color(0xFFFF8F00),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${d.dpr}x',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFFE65100),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1 logical pixel = DPR × physical pixels',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Refresh Rate ──
              _sectionTitle('5. REFRESH RATE CATEGORIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _refreshRow('Standard', '60 Hz', 60, Color(0xFF2E7D32)),
                    _refreshRow('Smooth', '90 Hz', 90, Color(0xFF0D47A1)),
                    _refreshRow('High', '120 Hz', 120, Color(0xFF6A1B9A)),
                    _refreshRow('Gaming', '144 Hz', 144, Color(0xFFBF360C)),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 14,
                            color: Color(0xFFE65100),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Higher refresh rates improve animation smoothness. '
                              'Flutter automatically adapts frame scheduling.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFFE65100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Display vs View ──
              _sectionTitle('6. DISPLAY vs FLUTTER VIEW'),
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
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.monitor,
                              color: Color(0xFF0D47A1),
                              size: 28,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Display',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Physical hardware',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text('Resolution', style: TextStyle(fontSize: 10)),
                            Text('Pixel ratio', style: TextStyle(fontSize: 10)),
                            Text(
                              'Refresh rate',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.compare_arrows,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ),
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
                              color: Color(0xFF2E7D32),
                              size: 28,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'FlutterView',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Render surface',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Padding/insets',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Platform config',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              '.display property',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 7: Access Patterns ──
              _sectionTitle('7. ACCESSING DISPLAYS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _accessRow(
                      1,
                      'PlatformDispatcher',
                      'PlatformDispatcher.instance.displays',
                      'List of all connected displays',
                      Color(0xFF0D47A1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.grey[300],
                        size: 14,
                      ),
                    ),
                    _accessRow(
                      2,
                      'FlutterView',
                      'view.display',
                      'Display backing this view',
                      Color(0xFF2E7D32),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.grey[300],
                        size: 14,
                      ),
                    ),
                    _accessRow(
                      3,
                      'MediaQuery',
                      'MediaQuery.sizeOf(context)',
                      'Logical size (already adjusted)',
                      Color(0xFFE65100),
                    ),
                  ],
                ),
              ),

              // ── Section 8: Logical vs Physical ──
              _sectionTitle('8. LOGICAL vs PHYSICAL SIZE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    ...displayInfos.map((d) {
                      final logW = (d.size.width / d.dpr).round();
                      final logH = (d.size.height / d.dpr).round();
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 22,
                              child: Text(
                                '#${d.id}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${d.size.width.toInt()}×${d.size.height.toInt()}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF0D47A1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                '÷ ${d.dpr}x →',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${logW}×$logH',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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

// ─── DATA CLASS ────────────────────────────────────────────────────────────

class _DisplayInfo {
  final int id;
  final Size size;
  final double dpr;
  final double refreshRate;
  _DisplayInfo(this.id, this.size, this.dpr, this.refreshRate);
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

Widget _propertyRow(
  String name,
  String type,
  String desc,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(type, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _displayCard(_DisplayInfo d) {
  final isPortrait = d.size.height > d.size.width;
  final color = [
    Color(0xFF0D47A1),
    Color(0xFF2E7D32),
    Color(0xFF6A1B9A),
    Color(0xFFBF360C),
  ][d.id % 4];
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: isPortrait ? 30 : 50,
          height: isPortrait ? 50 : 30,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              '${d.id}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Display ${d.id}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  _propChip(
                    '${d.size.width.toInt()}×${d.size.height.toInt()}',
                    color,
                  ),
                  SizedBox(width: 4),
                  _propChip('${d.dpr}x', Color(0xFFE65100)),
                  SizedBox(width: 4),
                  _propChip('${d.refreshRate.toInt()} Hz', Color(0xFF6A1B9A)),
                ],
              ),
            ],
          ),
        ),
        Icon(
          isPortrait ? Icons.phone_android : Icons.desktop_windows,
          color: color,
          size: 22,
        ),
      ],
    ),
  );
}

Widget _propChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

Widget _resolutionBar(_DisplayInfo d) {
  final color = [
    Color(0xFF0D47A1),
    Color(0xFF2E7D32),
    Color(0xFF6A1B9A),
    Color(0xFFBF360C),
  ][d.id % 4];
  final maxWidth = 3840.0;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 22,
          child: Text(
            '#${d.id}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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
                widthFactor: d.size.width / maxWidth,
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.6)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${d.size.width.toInt()}px',
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _refreshRow(String label, String hz, int rate, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 65,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              FractionallySizedBox(
                widthFactor: rate / 160.0,
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Text(
          hz,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _accessRow(
  int step,
  String label,
  String code,
  String desc,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                code,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
