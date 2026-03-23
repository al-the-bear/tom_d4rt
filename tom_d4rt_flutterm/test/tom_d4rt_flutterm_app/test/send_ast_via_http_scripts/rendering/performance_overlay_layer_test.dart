// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for PerformanceOverlayLayer
//
// PerformanceOverlayLayer is a specialized layer that displays performance
// statistics directly on the rendering surface. It provides visual feedback
// about GPU and UI thread timing, raster cache usage, and rendering performance.
//
// Key Properties:
//   - optionsMask: Bitmask controlling which performance metrics to display
//   - rasterizerThreshold: Threshold for the rasterizer timing display
//   - checkerboardRasterCacheImages: Highlights cached images with checkerboard
//   - checkerboardOffscreenLayers: Highlights offscreen-rendered layers
//
// The overlay can display:
//   - GPU thread frame timing graph
//   - UI thread frame timing graph
//   - Raster cache statistics
//   - Offscreen layer indicators
//
// This demo visualizes the PerformanceOverlayLayer and PerformanceOverlay widget.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════════

Color _primaryColor = Color(0xFF1565C0);
Color _primaryLight = Color(0xFF42A5F5);
Color _primaryPale = Color(0xFFBBDEFB);

Color _accentColor = Color(0xFFFF5722);
Color _accentLight = Color(0xFFFF8A65);

Color _successColor = Color(0xFF2E7D32);
Color _successLight = Color(0xFF66BB6A);
Color _successPale = Color(0xFFC8E6C9);

Color _warningColor = Color(0xFFEF6C00);
Color _warningLight = Color(0xFFFFA726);
Color _warningPale = Color(0xFFFFE0B2);

Color _errorColor = Color(0xFFC62828);
Color _errorLight = Color(0xFFEF5350);

Color _purpleColor = Color(0xFF6A1B9A);
Color _purpleLight = Color(0xFFAB47BC);
Color _purplePale = Color(0xFFE1BEE7);

Color _tealColor = Color(0xFF00695C);
Color _tealPale = Color(0xFFB2DFDB);

Color _textDark = Color(0xFF212121);
Color _textMedium = Color(0xFF616161);
Color _textLight = Color(0xFF9E9E9E);

Color _cardBg = Color(0xFFFFFFFF);
Color _dividerColor = Color(0xFFE0E0E0);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGET BUILDERS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_primaryColor, _primaryLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _primaryColor.withAlpha(80),
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
          'PerformanceOverlayLayer',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Layer displaying performance statistics for debugging',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(220),
          ),
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
            'flutter/rendering/layer.dart',
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(8),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
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
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _textMedium,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(String property, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 180,
          child: Text(
            property,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: _textMedium,
            ),
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

Widget _buildBitMaskRow(int bit, String name, String description, Color color) {
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
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              bit.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: _textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildThresholdIndicator(int value, String label, Color color, bool isActive) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: isActive ? color : _dividerColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: isActive
          ? [
              BoxShadow(
                color: color.withAlpha(60),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ]
          : [],
    ),
    child: Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : _textLight,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white.withAlpha(200) : _textLight,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: PERFORMANCEOVERLAYLAYER OVERVIEW
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
        _buildSectionHeader('PerformanceOverlayLayer Overview', Icons.info_outline, _primaryColor),
        Text(
          'PerformanceOverlayLayer is a specialized compositing layer that renders '
          'performance statistics directly into the scene. It integrates with Flutter\'s '
          'Skia-based rendering engine to provide real-time metrics visualization.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                'Layer Type',
                'Compositing Layer',
                Icons.layers,
                _primaryColor,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                'Renders',
                'Performance Graphs',
                Icons.show_chart,
                _successColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                'Engine',
                'Skia Integration',
                Icons.memory,
                _purpleColor,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                'Purpose',
                'Debug & Profile',
                Icons.bug_report,
                _warningColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _primaryPale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.architecture, color: _primaryColor, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Layer Hierarchy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildPropertyRow('Layer', 'Base class for all compositing layers', _primaryColor),
              _buildPropertyRow('ContainerLayer', 'Layer that can contain child layers', _primaryColor),
              _buildPropertyRow('PerformanceOverlayLayer', 'Displays performance metrics', _primaryLight),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Constructor Signature',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildCodeBlock(
          'PerformanceOverlayLayer({\n'
          '  required Rect overlayRect,\n'
          '  required int optionsMask,\n'
          '  required int rasterizerThreshold,\n'
          '  required bool checkerboardRasterCacheImages,\n'
          '  required bool checkerboardOffscreenLayers,\n'
          '})',
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: OPTIONS MASK PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOptionsMaskSection() {
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
        _buildSectionHeader('optionsMask Property', Icons.tune, _accentColor),
        Text(
          'The optionsMask is a bitmask integer that controls which performance metrics '
          'are displayed in the overlay. Each bit corresponds to a specific performance '
          'visualization option.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _accentLight.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _accentLight.withAlpha(60)),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: _accentColor, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Options are combined using bitwise OR (|) to enable multiple metrics.',
                  style: TextStyle(
                    fontSize: 13,
                    color: _accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Available Option Bits',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 14),
        _buildBitMaskRow(
          1,
          'displayRasterizerStatistics',
          'Display GPU thread frame timing histogram',
          _successColor,
        ),
        _buildBitMaskRow(
          2,
          'visualizeRasterizerStatistics',
          'Display GPU thread timing as visual graph overlay',
          _successLight,
        ),
        _buildBitMaskRow(
          4,
          'displayEngineStatistics',
          'Display UI thread frame timing histogram',
          _primaryColor,
        ),
        _buildBitMaskRow(
          8,
          'visualizeEngineStatistics',
          'Display UI thread timing as visual graph overlay',
          _primaryLight,
        ),
        SizedBox(height: 20),
        Text(
          'Common Combinations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 12),
        _buildCodeBlock(
          '// Show both GPU and UI timing graphs\n'
          'int optionsMask = 1 | 2 | 4 | 8;  // = 15\n'
          '\n'
          '// Show only GPU timing\n'
          'int gpuOnly = 1 | 2;  // = 3\n'
          '\n'
          '// Show only UI timing\n'
          'int uiOnly = 4 | 8;  // = 12',
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryPale, _successPale],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Visual Breakdown: optionsMask = 15',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _textDark,
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMaskBitVisual(8, 'UI Viz', true, _primaryColor),
                  _buildMaskBitVisual(4, 'UI Stat', true, _primaryLight),
                  _buildMaskBitVisual(2, 'GPU Viz', true, _successColor),
                  _buildMaskBitVisual(1, 'GPU Stat', true, _successLight),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '1111 (binary) = 15 (decimal)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: _textMedium,
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

Widget _buildMaskBitVisual(int bit, String label, bool enabled, Color color) {
  return Column(
    children: [
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: enabled ? color : _dividerColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            enabled ? '1' : '0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: _textMedium,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        '($bit)',
        style: TextStyle(
          fontSize: 9,
          color: _textLight,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: RASTERIZER THRESHOLD PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildRasterizerThresholdSection() {
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
        _buildSectionHeader('rasterizerThreshold Property', Icons.timer, _warningColor),
        Text(
          'The rasterizerThreshold property sets the frame budget threshold in milliseconds. '
          'Frames exceeding this threshold are visually highlighted, helping identify '
          'performance bottlenecks in the rendering pipeline.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _warningPale.withAlpha(80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: _warningColor, size: 22),
                  SizedBox(width: 10),
                  Text(
                    'Frame Budget Reference',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildFrameBudgetCard('60 FPS', '16.67 ms', _successColor),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildFrameBudgetCard('120 FPS', '8.33 ms', _primaryColor),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildFrameBudgetCard('30 FPS', '33.33 ms', _errorColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Threshold Values',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildThresholdIndicator(0, 'Off', _textLight, false),
              _buildThresholdIndicator(8, '8ms', _successColor, true),
              _buildThresholdIndicator(16, '16ms', _successLight, true),
              _buildThresholdIndicator(24, '24ms', _warningColor, true),
              _buildThresholdIndicator(32, '32ms', _warningLight, false),
              _buildThresholdIndicator(100, 'High', _errorColor, false),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Usage Example',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildCodeBlock(
          '// Set threshold for 60 FPS monitoring\n'
          'PerformanceOverlayLayer(\n'
          '  overlayRect: Rect.fromLTWH(0, 0, 300, 100),\n'
          '  optionsMask: 15,\n'
          '  rasterizerThreshold: 16,\n'
          '  checkerboardRasterCacheImages: false,\n'
          '  checkerboardOffscreenLayers: false,\n'
          ')',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _primaryPale.withAlpha(60),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _primaryLight.withAlpha(60)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _primaryColor, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'A threshold of 0 disables threshold highlighting entirely.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _primaryColor,
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

Widget _buildFrameBudgetCard(String fps, String budget, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      children: [
        Text(
          fps,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          budget,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: _textMedium,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: CHECKERBOARD RASTER CACHE IMAGES PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCheckerboardSection() {
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
        _buildSectionHeader('checkerboardRasterCacheImages', Icons.grid_4x4, _purpleColor),
        Text(
          'When enabled, checkerboardRasterCacheImages overlays a checkerboard pattern '
          'on images that are being cached by the raster cache. This helps identify '
          'which images are benefiting from caching optimization.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildCheckerStateCard(
                'Disabled',
                'Normal rendering without visual indicators',
                false,
                Icons.visibility_off,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildCheckerStateCard(
                'Enabled',
                'Cached images show checkerboard overlay',
                true,
                Icons.grid_on,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _purplePale.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.memory, color: _purpleColor, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Raster Cache Benefits',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _purpleColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildBenefitRow('Reduced GPU work', 'Cached images skip re-rasterization'),
              _buildBenefitRow('Faster compositing', 'Pre-rendered textures composite quickly'),
              _buildBenefitRow('Memory tradeoff', 'Uses GPU memory to store cached images'),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Checkerboard Visualization',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 12),
        _buildCheckerboardPreview(),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Enable raster cache checkerboard\n'
          'PerformanceOverlayLayer(\n'
          '  overlayRect: overlayBounds,\n'
          '  optionsMask: 15,\n'
          '  rasterizerThreshold: 0,\n'
          '  checkerboardRasterCacheImages: true,  // <-- enabled\n'
          '  checkerboardOffscreenLayers: false,\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildCheckerStateCard(String title, String description, bool enabled, IconData icon) {
  Color color = enabled ? _purpleColor : _textLight;
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: enabled ? _purplePale.withAlpha(40) : _dividerColor.withAlpha(40),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: enabled ? _purpleColor.withAlpha(60) : _dividerColor,
        width: enabled ? 2 : 1,
      ),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            fontSize: 11,
            color: _textMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildBenefitRow(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: _purpleLight, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: _textDark,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: _textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCheckerboardPreview() {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dividerColor),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: _primaryPale,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: _primaryColor, size: 24),
                    SizedBox(height: 4),
                    Text(
                      'Normal Image',
                      style: TextStyle(fontSize: 10, color: _primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(width: 1, color: _dividerColor),
          Expanded(
            child: Stack(
              children: [
                Container(color: _primaryPale),
                _buildSimpleCheckerboard(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: _purpleColor, size: 24),
                      SizedBox(height: 4),
                      Text(
                        'Cached Image',
                        style: TextStyle(fontSize: 10, color: _purpleColor),
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

Widget _buildSimpleCheckerboard() {
  return Opacity(
    opacity: 0.3,
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 64,
      itemBuilder: (context, index) {
        int row = index ~/ 8;
        int col = index % 8;
        bool isEven = (row + col) % 2 == 0;
        return Container(
          color: isEven ? _purpleColor : Colors.transparent,
        );
      },
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: VISUAL OVERLAY REPRESENTATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVisualOverlaySection() {
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
        _buildSectionHeader('Visual Overlay Representation', Icons.bar_chart, _tealColor),
        Text(
          'The performance overlay displays two main sections: GPU thread timing at '
          'the top and UI thread timing at the bottom. Each section shows a histogram '
          'of recent frame times with color coding for performance status.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        _buildOverlayDiagram(),
        SizedBox(height: 20),
        Text(
          'Color Indicators',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildColorIndicator('Green', 'Under budget', _successColor)),
            SizedBox(width: 10),
            Expanded(child: _buildColorIndicator('Yellow', 'Near budget', _warningColor)),
            SizedBox(width: 10),
            Expanded(child: _buildColorIndicator('Red', 'Over budget', _errorColor)),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _tealPale.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.analytics, color: _tealColor, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Reading the Overlay',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _tealColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildReadingGuideRow('Bar Height', 'Frame time duration'),
              _buildReadingGuideRow('Horizontal Line', 'Target frame budget (16.67ms)'),
              _buildReadingGuideRow('Bars Above Line', 'Frames that missed budget'),
              _buildReadingGuideRow('Scrolling Graph', 'Recent frame history'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverlayDiagram() {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'Performance Overlay Layout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(60),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildOverlayBarSection('GPU Thread', _successColor),
              SizedBox(height: 6),
              Divider(color: Colors.white24, height: 1),
              SizedBox(height: 6),
              _buildOverlayBarSection('UI Thread', _primaryLight),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverlayBarSection(String label, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 10,
        ),
      ),
      SizedBox(height: 6),
      Stack(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              color: Colors.white38,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildFrameBar(20, color),
              _buildFrameBar(18, color),
              _buildFrameBar(32, _errorColor),
              _buildFrameBar(14, color),
              _buildFrameBar(16, color),
              _buildFrameBar(22, _warningColor),
              _buildFrameBar(15, color),
              _buildFrameBar(12, color),
              _buildFrameBar(19, color),
              _buildFrameBar(28, _warningColor),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildFrameBar(int height, Color color) {
  double displayHeight = height.toDouble().clamp(5, 38);
  return Container(
    width: 8,
    height: displayHeight,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      ),
    ),
  );
}

Widget _buildColorIndicator(String label, String meaning, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: color,
                ),
              ),
              Text(
                meaning,
                style: TextStyle(
                  fontSize: 9,
                  color: _textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildReadingGuideRow(String term, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            term,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: _tealColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: _textMedium,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: PERFORMANCEOVERLAY WIDGET DEMOS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildWidgetDemosSection() {
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
        _buildSectionHeader('PerformanceOverlay Widget Demos', Icons.widgets, _successColor),
        Text(
          'The PerformanceOverlay widget provides a convenient way to add performance '
          'statistics display to your Flutter application. It wraps the underlying '
          'PerformanceOverlayLayer and provides widget-friendly configuration.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        _buildDemoCard(
          'Basic PerformanceOverlay',
          'Shows both UI and GPU timing graphs',
          'PerformanceOverlay.allEnabled()',
          Icons.show_chart,
          _primaryColor,
        ),
        SizedBox(height: 12),
        _buildDemoCard(
          'Rasterizer Stats Only',
          'Displays GPU thread timing histogram',
          'PerformanceOverlay(\n'
          '  optionsMask:\n'
          '    PerformanceOverlayOption\n'
          '      .displayRasterizerStatistics.index |\n'
          '    PerformanceOverlayOption\n'
          '      .visualizeRasterizerStatistics.index,\n'
          ')',
          Icons.memory,
          _successColor,
        ),
        SizedBox(height: 12),
        _buildDemoCard(
          'Engine Stats Only',
          'Displays UI thread timing histogram',
          'PerformanceOverlay(\n'
          '  optionsMask:\n'
          '    PerformanceOverlayOption\n'
          '      .displayEngineStatistics.index |\n'
          '    PerformanceOverlayOption\n'
          '      .visualizeEngineStatistics.index,\n'
          ')',
          Icons.speed,
          _accentColor,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _successPale.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.integration_instructions, color: _successColor, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Integration Patterns',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              _buildIntegrationPattern(
                'Stack Overlay',
                'Stack(children: [YourApp(), PerformanceOverlay.allEnabled()])',
              ),
              SizedBox(height: 8),
              _buildIntegrationPattern(
                'Material App',
                'MaterialApp(showPerformanceOverlay: true)',
              ),
              SizedBox(height: 8),
              _buildIntegrationPattern(
                'Debug Flag',
                'if (kDebugMode) PerformanceOverlay.allEnabled()',
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Complete Widget Example',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _textDark,
          ),
        ),
        SizedBox(height: 10),
        _buildCodeBlock(
          'MaterialApp(\n'
          '  home: Stack(\n'
          '    children: [\n'
          '      Scaffold(\n'
          '        appBar: AppBar(title: Text(\'My App\')),\n'
          '        body: MyContent(),\n'
          '      ),\n'
          '      Positioned(\n'
          '        top: 0,\n'
          '        left: 0,\n'
          '        right: 0,\n'
          '        child: PerformanceOverlay.allEnabled(),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildDemoCard(String title, String description, String code, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
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
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: _textMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF80CBC4),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntegrationPattern(String name, String code) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.arrow_right, color: _successColor, size: 18),
      SizedBox(width: 6),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: _textDark,
              ),
            ),
            Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _textMedium,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADDITIONAL SECTIONS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOffscreenLayersSection() {
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
        _buildSectionHeader('checkerboardOffscreenLayers', Icons.layers_clear, _errorColor),
        Text(
          'The checkerboardOffscreenLayers property highlights layers that are being '
          'rendered to an offscreen buffer before being composited. This can help '
          'identify unnecessary offscreen rendering that impacts performance.',
          style: TextStyle(
            fontSize: 14,
            color: _textMedium,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _errorLight.withAlpha(15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _errorLight.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: _errorColor, size: 22),
                  SizedBox(width: 10),
                  Text(
                    'Offscreen Rendering Triggers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _errorColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              _buildTriggerRow('Opacity', 'Opacity widget with value < 1.0'),
              _buildTriggerRow('ClipPath', 'Complex clipping operations'),
              _buildTriggerRow('ShaderMask', 'Custom shader effects'),
              _buildTriggerRow('ColorFilter', 'Color transformation filters'),
              _buildTriggerRow('BackdropFilter', 'Blur and filter effects'),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildComparisonCard(
                'With saveLayer',
                'Renders to offscreen buffer first',
                Icons.layers,
                _errorColor,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildComparisonCard(
                'Direct Render',
                'Renders directly to screen',
                Icons.straighten,
                _successColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTriggerRow(String widget, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            widget,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: _errorColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: _textMedium,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonCard(String title, String description, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 10,
            color: _textMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildBestPracticesSection() {
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
        _buildSectionHeader('Best Practices', Icons.check_circle_outline, _primaryColor),
        _buildPracticeItem(
          'Debug Mode Only',
          'Only enable performance overlay in debug builds to avoid overhead in production.',
          Icons.bug_report,
          _warningColor,
        ),
        _buildPracticeItem(
          'Focus on Spikes',
          'Look for bars that exceed the budget line rather than average frame times.',
          Icons.trending_up,
          _errorColor,
        ),
        _buildPracticeItem(
          'Profile Real Devices',
          'Always profile on actual devices as emulator performance differs significantly.',
          Icons.phone_android,
          _primaryColor,
        ),
        _buildPracticeItem(
          'Cache Analysis',
          'Use checkerboard options to verify expensive widgets are being cached properly.',
          Icons.cached,
          _purpleColor,
        ),
        _buildPracticeItem(
          'Iterative Optimization',
          'Fix one performance issue at a time and re-measure after each change.',
          Icons.loop,
          _successColor,
        ),
      ],
    ),
  );
}

Widget _buildPracticeItem(String title, String description, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
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
                  color: _textDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: _textMedium,
                  height: 1.4,
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
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

Widget build() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainHeader(),
            SizedBox(height: 24),
            _buildOverviewSection(),
            SizedBox(height: 20),
            _buildOptionsMaskSection(),
            SizedBox(height: 20),
            _buildRasterizerThresholdSection(),
            SizedBox(height: 20),
            _buildCheckerboardSection(),
            SizedBox(height: 20),
            _buildVisualOverlaySection(),
            SizedBox(height: 20),
            _buildOffscreenLayersSection(),
            SizedBox(height: 20),
            _buildWidgetDemosSection(),
            SizedBox(height: 20),
            _buildBestPracticesSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
