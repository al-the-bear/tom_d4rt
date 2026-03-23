// D4rt test script: Deep demo for PerformanceOverlayOption enum
//
// PerformanceOverlayOption is an enum that specifies which performance metrics
// should be displayed in the PerformanceOverlay widget. These options control
// the visual representation of frame timing data from both the rasterizer
// (GPU) thread and the engine (UI) thread.
//
// Enum values:
//   - displayRasterizerStatistics: Shows numeric histogram for GPU thread
//   - visualizeRasterizerStatistics: Shows visual graph overlay for GPU thread
//   - displayEngineStatistics: Shows numeric histogram for UI thread
//   - visualizeEngineStatistics: Shows visual graph overlay for UI thread
//
// Each option corresponds to a specific bit in the optionsMask used by
// PerformanceOverlayLayer. Options can be combined to show multiple metrics.
//
// Use cases:
//   - Profiling GPU frame rendering performance
//   - Identifying UI thread jank and stutters
//   - Visualizing frame budget utilization
//   - Debugging rendering pipeline bottlenecks
//
// This demo provides a comprehensive visual exploration of each option.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════════

Color _primaryBlue = Color(0xFF1565C0);
Color _primaryBlueLight = Color(0xFF42A5F5);
Color _primaryBluePale = Color(0xFFBBDEFB);

Color _gpuGreen = Color(0xFF2E7D32);
Color _gpuGreenLight = Color(0xFF66BB6A);
Color _gpuGreenPale = Color(0xFFC8E6C9);

Color _uiOrange = Color(0xFFEF6C00);
Color _uiOrangeLight = Color(0xFFFFA726);
Color _uiOrangePale = Color(0xFFFFE0B2);

Color _visualPurple = Color(0xFF6A1B9A);
Color _visualPurplePale = Color(0xFFE1BEE7);

Color _combinedTeal = Color(0xFF00695C);
Color _combinedTealLight = Color(0xFF26A69A);
Color _combinedTealPale = Color(0xFFB2DFDB);

Color _warningRed = Color(0xFFC62828);
Color _warningRedLight = Color(0xFFEF5350);

Color _textDark = Color(0xFF212121);
Color _textMedium = Color(0xFF616161);

Color _cardBg = Color(0xFFFFFFFF);
Color _surfaceBg = Color(0xFFFAFAFA);

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: _surfaceBg,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainHeader(),
          SizedBox(height: 24),
          _buildOverviewSection(),
          SizedBox(height: 20),
          _buildDisplayRasterizerSection(),
          SizedBox(height: 20),
          _buildVisualizeRasterizerSection(),
          SizedBox(height: 20),
          _buildDisplayEngineSection(),
          SizedBox(height: 20),
          _buildVisualizeEngineSection(),
          SizedBox(height: 20),
          _buildCombinedOptionsSection(),
          SizedBox(height: 20),
          _buildBitmaskCalculatorSection(),
          SizedBox(height: 20),
          _buildUseCasesSection(),
          SizedBox(height: 40),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// HEADER AND SECTION BUILDERS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_primaryBlue, _primaryBlueLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _primaryBlue.withAlpha(80),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.speed, size: 56, color: Colors.white),
        SizedBox(height: 16),
        Text(
          'PerformanceOverlayOption',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Enum for controlling performance overlay display options',
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(220)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'flutter/rendering/performance_overlay.dart',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(180)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(60),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGET BUILDERS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildEnumValueCard(
  String name,
  int bitValue,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(8),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: 2),
              Text(
                'Bit $bitValue',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color,
                ),
              ),
              SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: _textMedium, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: _textDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: _textMedium),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFF80CBC4),
        height: 1.5,
      ),
    ),
  );
}

Widget _buildFrameGraph(List<double> values, Color barColor, String label) {
  return Container(
    height: 80,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white.withAlpha(180)),
        ),
        SizedBox(height: 6),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: values.map((v) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  height: v * 50,
                  decoration: BoxDecoration(
                    color: v > 0.7 ? _warningRed : barColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'PerformanceOverlayOption Overview',
          Icons.info_outline,
          _primaryBlue,
        ),
        Text(
          'PerformanceOverlayOption is an enumeration that defines the available options '
          'for displaying performance statistics in Flutter\'s PerformanceOverlay widget. '
          'Each enum value corresponds to a specific performance visualization.',
          style: TextStyle(fontSize: 14, color: _textMedium, height: 1.6),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _primaryBluePale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.list_alt, color: _primaryBlue, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Enum Values (4 total)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _primaryBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow(
                'Value 0',
                'displayRasterizerStatistics',
                _gpuGreen,
              ),
              _buildInfoRow(
                'Value 1',
                'visualizeRasterizerStatistics',
                _gpuGreenLight,
              ),
              _buildInfoRow('Value 2', 'displayEngineStatistics', _uiOrange),
              _buildInfoRow(
                'Value 3',
                'visualizeEngineStatistics',
                _uiOrangeLight,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Enum Definition',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildCodeBlock(
          'enum PerformanceOverlayOption {\n'
          '  displayRasterizerStatistics,\n'
          '  visualizeRasterizerStatistics,\n'
          '  displayEngineStatistics,\n'
          '  visualizeEngineStatistics,\n'
          '}',
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Rasterizer Options',
                '2',
                _gpuGreen,
                Icons.memory,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Engine Options',
                '2',
                _uiOrange,
                Icons.developer_board,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatCard(String label, String value, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(label, style: TextStyle(fontSize: 11, color: _textMedium)),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: displayRasterizerStatistics
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildDisplayRasterizerSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'displayRasterizerStatistics',
          Icons.memory,
          _gpuGreen,
        ),
        _buildEnumValueCard(
          'displayRasterizerStatistics',
          1,
          'Displays the GPU rasterizer thread frame timing as a numeric histogram. '
              'Shows how long the rasterizer takes to paint each frame.',
          _gpuGreen,
          Icons.bar_chart,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _gpuGreenPale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.analytics, color: _gpuGreen, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'What It Shows',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _gpuGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow('Thread', 'GPU/Rasterizer Thread', _gpuGreen),
              _buildInfoRow('Format', 'Numeric histogram bars', _gpuGreen),
              _buildInfoRow(
                'Measures',
                'Frame paint duration in ms',
                _gpuGreen,
              ),
              _buildInfoRow('Target', '16.67ms for 60fps', _gpuGreen),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Simulated Display',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildFrameGraph(
          [0.3, 0.4, 0.35, 0.5, 0.3, 0.45, 0.38, 0.42, 0.3, 0.55, 0.4, 0.35],
          _gpuGreen,
          'GPU Rasterizer Frame Times',
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Using displayRasterizerStatistics\n'
          'PerformanceOverlay(\n'
          '  optionsMask: 1 << PerformanceOverlayOption\n'
          '      .displayRasterizerStatistics.index,\n'
          '  child: MyWidget(),\n'
          ')',
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: visualizeRasterizerStatistics
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVisualizeRasterizerSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'visualizeRasterizerStatistics',
          Icons.show_chart,
          _gpuGreenLight,
        ),
        _buildEnumValueCard(
          'visualizeRasterizerStatistics',
          2,
          'Displays the GPU rasterizer statistics as a visual graph overlay. '
              'Provides a continuous line graph showing frame timing trends.',
          _gpuGreenLight,
          Icons.auto_graph,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _gpuGreenPale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.timeline, color: _gpuGreenLight, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Visual Representation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _gpuGreenLight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow('Type', 'Continuous line graph', _gpuGreenLight),
              _buildInfoRow('Updates', 'Real-time per frame', _gpuGreenLight),
              _buildInfoRow(
                'Color',
                'Cyan/green for GPU metrics',
                _gpuGreenLight,
              ),
              _buildInfoRow(
                'Baseline',
                'Red line at 16ms threshold',
                _gpuGreenLight,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Visualization Preview',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildVisualGraphPreview(_gpuGreenLight, 'Rasterizer Visual Graph'),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _visualPurplePale.withAlpha(60),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _visualPurple.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _visualPurple, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'The visual graph is more intuitive for spotting frame drops as '
                  'sudden spikes are easily visible.',
                  style: TextStyle(fontSize: 12, color: _visualPurple),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildVisualGraphPreview(Color color, String label) {
  return Container(
    height: 100,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white.withAlpha(180)),
        ),
        SizedBox(height: 8),
        Expanded(
          child: CustomPaint(
            size: Size(double.infinity, 60),
            painter: _WaveGraphPainter(color),
          ),
        ),
        Container(height: 1, color: _warningRed.withAlpha(150)),
        Text(
          '16ms threshold',
          style: TextStyle(fontSize: 8, color: _warningRed.withAlpha(200)),
        ),
      ],
    ),
  );
}

class _WaveGraphPainter extends CustomPainter {
  final Color color;
  _WaveGraphPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height * 0.5);

    for (int i = 0; i < 20; i++) {
      double x = (i / 20) * size.width;
      double y =
          size.height * 0.5 + (i % 3 == 0 ? -15 : (i % 2 == 0 ? 10 : -5));
      if (i == 0) {
        path.lineTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: displayEngineStatistics
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildDisplayEngineSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'displayEngineStatistics',
          Icons.developer_board,
          _uiOrange,
        ),
        _buildEnumValueCard(
          'displayEngineStatistics',
          4,
          'Displays the UI thread (engine) frame timing as a numeric histogram. '
              'Shows build, layout, and paint phase timing information.',
          _uiOrange,
          Icons.bar_chart,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _uiOrangePale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.construction, color: _uiOrange, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'UI Thread Phases',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _uiOrange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow('Build', 'Widget tree construction', _uiOrange),
              _buildInfoRow(
                'Layout',
                'Size and position calculation',
                _uiOrange,
              ),
              _buildInfoRow('Paint', 'Drawing commands generation', _uiOrange),
              _buildInfoRow('Composite', 'Layer tree assembly', _uiOrange),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Simulated UI Thread Display',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildFrameGraph(
          [0.25, 0.3, 0.8, 0.4, 0.35, 0.3, 0.45, 0.3, 0.75, 0.35, 0.3, 0.4],
          _uiOrange,
          'UI Thread Frame Times',
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _warningRedLight.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _warningRed.withAlpha(60)),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: _warningRed, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Red bars indicate frames exceeding the 16ms budget',
                  style: TextStyle(fontSize: 11, color: _warningRed),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: visualizeEngineStatistics
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVisualizeEngineSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'visualizeEngineStatistics',
          Icons.auto_graph,
          _uiOrangeLight,
        ),
        _buildEnumValueCard(
          'visualizeEngineStatistics',
          8,
          'Displays the UI thread statistics as a visual graph overlay. '
              'Shows continuous frame timing with trend visualization.',
          _uiOrangeLight,
          Icons.trending_up,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _uiOrangePale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.insights, color: _uiOrangeLight, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Graph Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _uiOrangeLight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow('Update Rate', 'Per-frame refresh', _uiOrangeLight),
              _buildInfoRow(
                'History',
                'Recent frame history visible',
                _uiOrangeLight,
              ),
              _buildInfoRow(
                'Peaks',
                'Jank frames clearly visible',
                _uiOrangeLight,
              ),
              _buildInfoRow(
                'Trend',
                'Performance trend over time',
                _uiOrangeLight,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Engine Visualization Preview',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildVisualGraphPreview(_uiOrangeLight, 'Engine Visual Graph'),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Using visualizeEngineStatistics\n'
          'PerformanceOverlay(\n'
          '  optionsMask: 1 << PerformanceOverlayOption\n'
          '      .visualizeEngineStatistics.index,\n'
          '  child: MyWidget(),\n'
          ')',
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: COMBINED OPTIONS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCombinedOptionsSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Combined Options', Icons.dashboard, _combinedTeal),
        Text(
          'Multiple PerformanceOverlayOptions can be combined using bitwise OR to display '
          'several metrics simultaneously. This is useful for comprehensive profiling.',
          style: TextStyle(fontSize: 14, color: _textMedium, height: 1.6),
        ),
        SizedBox(height: 20),
        _buildCombinationCard(
          'GPU Full View',
          'Both rasterizer options',
          [_gpuGreen, _gpuGreenLight],
          'displayRasterizerStatistics | visualizeRasterizerStatistics',
          3,
        ),
        _buildCombinationCard(
          'UI Full View',
          'Both engine options',
          [_uiOrange, _uiOrangeLight],
          'displayEngineStatistics | visualizeEngineStatistics',
          12,
        ),
        _buildCombinationCard(
          'All Statistics',
          'Complete performance view',
          [_gpuGreen, _uiOrange],
          'All four options combined',
          15,
        ),
        SizedBox(height: 16),
        Text(
          'Visual Representation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 12),
        _buildDualGraphView(),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Combining all options\n'
          'int allOptions = \n'
          '    (1 << PerformanceOverlayOption.displayRasterizerStatistics.index) |\n'
          '    (1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index) |\n'
          '    (1 << PerformanceOverlayOption.displayEngineStatistics.index) |\n'
          '    (1 << PerformanceOverlayOption.visualizeEngineStatistics.index);\n'
          '\n'
          'PerformanceOverlay(\n'
          '  optionsMask: allOptions,  // = 15\n'
          '  child: MyWidget(),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildCombinationCard(
  String title,
  String subtitle,
  List<Color> colors,
  String options,
  int mask,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _combinedTealPale.withAlpha(60),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _combinedTeal.withAlpha(50)),
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              mask.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _combinedTeal,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: _textMedium),
              ),
              SizedBox(height: 4),
              Text(
                'Mask: $mask',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _combinedTealLight,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDualGraphView() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: Colors.white.withAlpha(180), size: 16),
            SizedBox(width: 8),
            Text(
              'Performance Overlay (All Options)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMiniGraph('GPU', _gpuGreen)),
            SizedBox(width: 8),
            Expanded(child: _buildMiniGraph('UI', _uiOrange)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMiniGraph(String label, Color color) {
  return Container(
    height: 60,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label Thread',
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(8, (i) {
              double h = (i % 3 == 0) ? 0.8 : 0.4 + (i * 0.05);
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  height: h * 30,
                  decoration: BoxDecoration(
                    color: h > 0.7 ? _warningRed : color,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 7: BITMASK CALCULATOR
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildBitmaskCalculatorSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Bitmask Reference',
          Icons.calculate,
          _visualPurple,
        ),
        Text(
          'Each enum value has an index that determines its bit position in the '
          'optionsMask. The mask is calculated as 1 << index.',
          style: TextStyle(fontSize: 14, color: _textMedium, height: 1.6),
        ),
        SizedBox(height: 20),
        _buildBitmaskRow(
          'displayRasterizerStatistics',
          0,
          1,
          '0001',
          _gpuGreen,
        ),
        _buildBitmaskRow(
          'visualizeRasterizerStatistics',
          1,
          2,
          '0010',
          _gpuGreenLight,
        ),
        _buildBitmaskRow('displayEngineStatistics', 2, 4, '0100', _uiOrange),
        _buildBitmaskRow(
          'visualizeEngineStatistics',
          3,
          8,
          '1000',
          _uiOrangeLight,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _visualPurplePale.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Mask Values',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _visualPurple,
                ),
              ),
              SizedBox(height: 10),
              _buildMaskExample('1', 'Display GPU only'),
              _buildMaskExample('3', 'Both GPU options'),
              _buildMaskExample('4', 'Display UI only'),
              _buildMaskExample('5', 'Display both threads'),
              _buildMaskExample('10', 'Visualize both'),
              _buildMaskExample('15', 'All options enabled'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBitmaskRow(
  String name,
  int index,
  int mask,
  String binary,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            binary,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '= $mask',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: _textDark,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMaskExample(String mask, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 36,
          padding: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: _visualPurple,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            mask,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 12),
        Text(description, style: TextStyle(fontSize: 12, color: _textMedium)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 8: USE CASES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildUseCasesSection() {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Use Cases', Icons.cases, _primaryBlue),
        _buildUseCaseCard(
          'GPU Bottleneck Detection',
          'Use displayRasterizerStatistics to identify expensive paint operations '
              'like complex shadows, clips, or shader effects.',
          Icons.memory,
          _gpuGreen,
        ),
        _buildUseCaseCard(
          'UI Thread Profiling',
          'Use displayEngineStatistics to find expensive build, layout, or paint '
              'operations in your widget tree.',
          Icons.developer_board,
          _uiOrange,
        ),
        _buildUseCaseCard(
          'Jank Investigation',
          'Enable visual graphs to spot sudden spikes indicating dropped frames '
              'and correlate with user interactions.',
          Icons.show_chart,
          _visualPurple,
        ),
        _buildUseCaseCard(
          'Production Debugging',
          'Toggle options dynamically using debug flags to enable profiling '
              'in specific scenarios without affecting release builds.',
          Icons.bug_report,
          _warningRed,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _primaryBluePale.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _primaryBlue.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates, color: _primaryBlue, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Combine PerformanceOverlay with DevTools Timeline for '
                  'comprehensive performance analysis.',
                  style: TextStyle(
                    fontSize: 13,
                    color: _primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color,
                ),
              ),
              SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _textMedium, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
