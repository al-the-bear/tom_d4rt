// D4rt test script: Deep visual demo for PerformanceOverlayOption
//
// PerformanceOverlayOption is an enum defining display options for performance
// overlay visualization in Flutter applications:
//   - displayRasterizerStatistics: Show numeric GPU/raster thread stats
//   - visualizeRasterizerStatistics: Show GPU timing bar graph
//   - displayEngineStatistics: Show numeric UI thread stats
//   - visualizeEngineStatistics: Show UI thread timing bar graph
//
// This demo covers:
//   1. All enum values with visual cards
//   2. displayRasterizerStatistics deep dive
//   3. visualizeRasterizerStatistics deep dive
//   4. displayEngineStatistics deep dive
//   5. visualizeEngineStatistics deep dive
//   6. Combining options with bitmask operations
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _primaryDark = Color(0xFF0D47A1);
Color _primaryMedium = Color(0xFF1976D2);
Color _primaryPale = Color(0xFFBBDEFB);

Color _successDark = Color(0xFF1B5E20);
Color _successMedium = Color(0xFF388E3C);
Color _successPale = Color(0xFFC8E6C9);

Color _warnDark = Color(0xFFE65100);
Color _warnMedium = Color(0xFFFB8C00);
Color _warnPale = Color(0xFFFFE0B2);

Color _purpleDark = Color(0xFF4A148C);
Color _purpleMedium = Color(0xFF7B1FA2);

Color _tealMedium = Color(0xFF00897B);

Color _textPrimary = Color(0xFF212121);
Color _textSecondary = Color(0xFF616161);
Color _textTertiary = Color(0xFF9E9E9E);
Color _bgCard = Color(0xFFFFFFFF);
Color _bgPage = Color(0xFFF5F5F5);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 16, top: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(180)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(60),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(width: 12),
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

Widget _buildSubSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 12, top: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoBox(String title, String content, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 4,
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
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 13,
            color: _textSecondary,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildEnumValueCard(
  String enumName,
  int index,
  String description,
  String usageHint,
  IconData icon,
  Color primaryColor,
  Color secondaryColor,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: primaryColor.withAlpha(60), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withAlpha(25), secondaryColor.withAlpha(15)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withAlpha(50),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enumName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'index: $index',
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: secondaryColor.withAlpha(40)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: secondaryColor, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        usageHint,
                        style: TextStyle(
                          fontSize: 12,
                          color: _textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color accentColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withAlpha(80)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'monospace',
        color: Color(0xFFE0E0E0),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildBitmaskRow(String label, int value, bool isActive, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: isActive ? color.withAlpha(25) : Colors.grey.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isActive ? color.withAlpha(80) : Colors.grey.withAlpha(40),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.grey.withAlpha(40),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Icon(
              isActive ? Icons.check : Icons.remove,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? color : _textTertiary,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? color.withAlpha(40) : Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '1 << $value',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: isActive ? color : _textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBitmaskCombination(
  String title,
  List<String> options,
  int combinedValue,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(15),
          blurRadius: 6,
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
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.join_full, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'mask: $combinedValue',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: options.map((opt) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withAlpha(60)),
              ),
              child: Text(
                opt,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('────────────────────────────────────────────────────────────────');
  print('PerformanceOverlayOption Deep Demo');
  print('────────────────────────────────────────────────────────────────');

  // Enumerate all values
  print('\n[ENUM VALUES]');
  for (var option in PerformanceOverlayOption.values) {
    print('  ${option.name} (index: ${option.index})');
  }
  print('Total values: ${PerformanceOverlayOption.values.length}');

  // Demonstrate each option
  print('\n[displayRasterizerStatistics]');
  var displayRaster = PerformanceOverlayOption.displayRasterizerStatistics;
  print('  Name: ${displayRaster.name}');
  print('  Index: ${displayRaster.index}');
  print('  Bitmask: 1 << ${displayRaster.index} = ${1 << displayRaster.index}');
  print('  Purpose: Shows numeric GPU/raster thread timing stats');

  print('\n[visualizeRasterizerStatistics]');
  var visualizeRaster = PerformanceOverlayOption.visualizeRasterizerStatistics;
  print('  Name: ${visualizeRaster.name}');
  print('  Index: ${visualizeRaster.index}');
  print('  Bitmask: 1 << ${visualizeRaster.index} = ${1 << visualizeRaster.index}');
  print('  Purpose: Shows GPU timing as visual bar graph');

  print('\n[displayEngineStatistics]');
  var displayEngine = PerformanceOverlayOption.displayEngineStatistics;
  print('  Name: ${displayEngine.name}');
  print('  Index: ${displayEngine.index}');
  print('  Bitmask: 1 << ${displayEngine.index} = ${1 << displayEngine.index}');
  print('  Purpose: Shows numeric UI thread timing stats');

  print('\n[visualizeEngineStatistics]');
  var visualizeEngine = PerformanceOverlayOption.visualizeEngineStatistics;
  print('  Name: ${visualizeEngine.name}');
  print('  Index: ${visualizeEngine.index}');
  print('  Bitmask: 1 << ${visualizeEngine.index} = ${1 << visualizeEngine.index}');
  print('  Purpose: Shows UI thread timing as visual bar graph');

  // Demonstrate bitmask combinations
  print('\n[BITMASK COMBINATIONS]');

  int rasterOnly = (1 << displayRaster.index) | (1 << visualizeRaster.index);
  print('  Raster stats only: $rasterOnly (displayRaster | visualizeRaster)');

  int engineOnly = (1 << displayEngine.index) | (1 << visualizeEngine.index);
  print('  Engine stats only: $engineOnly (displayEngine | visualizeEngine)');

  int allStats = rasterOnly | engineOnly;
  print('  All stats: $allStats (all options combined)');

  int displayOnly = (1 << displayRaster.index) | (1 << displayEngine.index);
  print('  Display only (no visuals): $displayOnly');

  int visualOnly = (1 << visualizeRaster.index) | (1 << visualizeEngine.index);
  print('  Visualize only (graphs): $visualOnly');

  print('\n[PRACTICAL USAGE]');
  print('  PerformanceOverlay(optionsMask: 3)  // Display + visualize raster');
  print('  PerformanceOverlay(optionsMask: 12) // Display + visualize engine');
  print('  PerformanceOverlay(optionsMask: 15) // All options enabled');

  print('\n────────────────────────────────────────────────────────────────');
  print('Demo complete');
  print('────────────────────────────────────────────────────────────────');

  return Scaffold(
    backgroundColor: _bgPage,
    appBar: AppBar(
      title: Text('PerformanceOverlayOption'),
      backgroundColor: _primaryDark,
      elevation: 2,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ═══════════════════════════════════════════════════════════════
          // SECTION 1: ALL ENUM VALUES
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(
            'All Enum Values',
            Icons.list_alt,
            _primaryMedium,
          ),
          _buildInfoBox(
            'PerformanceOverlayOption Overview',
            'This enum defines the available options for configuring the '
                'performance overlay display in Flutter. Each option controls '
                'whether specific performance statistics are shown, either as '
                'numeric text or visual bar graphs. Options can be combined '
                'using bitmask operations.',
            Icons.info_outline,
            _primaryMedium,
          ),

          _buildEnumValueCard(
            'displayRasterizerStatistics',
            PerformanceOverlayOption.displayRasterizerStatistics.index,
            'Displays the rasterizer (GPU) thread timing statistics as numeric '
                'text. Shows frame timing data for the raster thread which handles '
                'compositing and GPU operations.',
            'Use this to see exact millisecond values for GPU frame times.',
            Icons.memory,
            _primaryMedium,
            _primaryDark,
          ),

          _buildEnumValueCard(
            'visualizeRasterizerStatistics',
            PerformanceOverlayOption.visualizeRasterizerStatistics.index,
            'Displays the rasterizer (GPU) thread timing as a visual bar graph. '
                'The graph shows frame times over recent frames, making it easy '
                'to spot spikes and jank visually.',
            'Use this for quick visual identification of GPU bottlenecks.',
            Icons.bar_chart,
            _successMedium,
            _successDark,
          ),

          _buildEnumValueCard(
            'displayEngineStatistics',
            PerformanceOverlayOption.displayEngineStatistics.index,
            'Displays the engine (UI) thread timing statistics as numeric text. '
                'Shows frame timing data for the UI thread which handles Dart '
                'code execution, layout, and painting.',
            'Use this to see exact millisecond values for UI frame times.',
            Icons.developer_board,
            _warnMedium,
            _warnDark,
          ),

          _buildEnumValueCard(
            'visualizeEngineStatistics',
            PerformanceOverlayOption.visualizeEngineStatistics.index,
            'Displays the engine (UI) thread timing as a visual bar graph. '
                'The graph shows UI frame times over recent frames, helping '
                'identify UI thread bottlenecks and jank.',
            'Use this for quick visual identification of UI thread issues.',
            Icons.show_chart,
            _purpleMedium,
            _purpleDark,
          ),

          SizedBox(height: 24),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 2: displayRasterizerStatistics DEEP DIVE
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(
            'displayRasterizerStatistics',
            Icons.memory,
            _primaryMedium,
          ),
          _buildInfoBox(
            'What is the Rasterizer Thread?',
            'The rasterizer (also called GPU or raster) thread is responsible '
                'for converting the scene description (layer tree) into actual '
                'GPU commands. It handles compositing layers, applying shaders, '
                'and uploading textures to the GPU. If this thread is slow, '
                'frames take longer to display even if the UI thread is fast.',
            Icons.settings_input_component,
            _primaryMedium,
          ),
          _buildSubSectionHeader(
            'Bitmask Value',
            Icons.code,
            _primaryMedium,
          ),
          _buildCodeBlock(
            '// Bitmask position\n'
                'index: ${PerformanceOverlayOption.displayRasterizerStatistics.index}\n'
                'bitmask: 1 << ${PerformanceOverlayOption.displayRasterizerStatistics.index} = ${1 << PerformanceOverlayOption.displayRasterizerStatistics.index}\n\n'
                '// Usage\n'
                'PerformanceOverlay(\n'
                '  optionsMask: 1 << PerformanceOverlayOption\n'
                '      .displayRasterizerStatistics.index,\n'
                ')',
            _primaryMedium,
          ),
          _buildInfoBox(
            'When to Use',
            'Enable this option when you need precise numeric timing data for '
                'GPU operations. Useful for debugging shader compilation stutter, '
                'texture upload delays, or compositing overhead. The numeric display '
                'shows worst, average, and current frame times.',
            Icons.psychology,
            _primaryMedium,
          ),

          SizedBox(height: 24),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 3: visualizeRasterizerStatistics DEEP DIVE
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(
            'visualizeRasterizerStatistics',
            Icons.bar_chart,
            _successMedium,
          ),
          _buildInfoBox(
            'Visual Frame Graph',
            'Instead of showing numeric values, this option displays a rolling '
                'bar graph of recent frame times for the rasterizer thread. Each '
                'bar represents one frame. Bars that exceed the target frame budget '
                '(16.6ms for 60fps) are highlighted, making it easy to spot jank.',
            Icons.assessment,
            _successMedium,
          ),
          _buildSubSectionHeader(
            'Bitmask Value',
            Icons.code,
            _successMedium,
          ),
          _buildCodeBlock(
            '// Bitmask position\n'
                'index: ${PerformanceOverlayOption.visualizeRasterizerStatistics.index}\n'
                'bitmask: 1 << ${PerformanceOverlayOption.visualizeRasterizerStatistics.index} = ${1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index}\n\n'
                '// Usage\n'
                'PerformanceOverlay(\n'
                '  optionsMask: 1 << PerformanceOverlayOption\n'
                '      .visualizeRasterizerStatistics.index,\n'
                ')',
            _successMedium,
          ),
          _buildInfoBox(
            'Graph Interpretation',
            'Green bars indicate frames rendered within budget. Red bars indicate '
                'frames that exceeded the target time. A horizontal line shows the '
                'target frame time. Consistent red bars suggest GPU-bound issues '
                'that need optimization of shaders, layers, or compositing.',
            Icons.insights,
            _successMedium,
          ),

          SizedBox(height: 24),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 4: displayEngineStatistics DEEP DIVE
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(
            'displayEngineStatistics',
            Icons.developer_board,
            _warnMedium,
          ),
          _buildInfoBox(
            'What is the Engine/UI Thread?',
            'The engine (also called UI) thread runs the Dart VM and executes '
                'your application code. It handles widget building, layout '
                'calculations, and painting to the layer tree. Slow Dart code, '
                'expensive builds, or complex layouts will show up here.',
            Icons.build_circle,
            _warnMedium,
          ),
          _buildSubSectionHeader(
            'Bitmask Value',
            Icons.code,
            _warnMedium,
          ),
          _buildCodeBlock(
            '// Bitmask position\n'
                'index: ${PerformanceOverlayOption.displayEngineStatistics.index}\n'
                'bitmask: 1 << ${PerformanceOverlayOption.displayEngineStatistics.index} = ${1 << PerformanceOverlayOption.displayEngineStatistics.index}\n\n'
                '// Usage\n'
                'PerformanceOverlay(\n'
                '  optionsMask: 1 << PerformanceOverlayOption\n'
                '      .displayEngineStatistics.index,\n'
                ')',
            _warnMedium,
          ),
          _buildInfoBox(
            'When to Use',
            'Enable this option when debugging slow builds, expensive layouts, '
                'or Dart code performance issues. The numeric display shows precise '
                'timing data that helps identify if the UI thread is the bottleneck. '
                'Compare with rasterizer stats to determine which thread needs work.',
            Icons.timeline,
            _warnMedium,
          ),

          SizedBox(height: 24),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 5: visualizeEngineStatistics DEEP DIVE
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(
            'visualizeEngineStatistics',
            Icons.show_chart,
            _purpleMedium,
          ),
          _buildInfoBox(
            'Visual UI Thread Graph',
            'Displays a rolling bar graph of recent frame times for the engine '
                '(UI) thread. Like the rasterizer graph, each bar represents one '
                'frame and exceeding the target budget is highlighted. This gives '
                'an at-a-glance view of UI thread performance.',
            Icons.trending_up,
            _purpleMedium,
          ),
          _buildSubSectionHeader(
            'Bitmask Value',
            Icons.code,
            _purpleMedium,
          ),
          _buildCodeBlock(
            '// Bitmask position\n'
                'index: ${PerformanceOverlayOption.visualizeEngineStatistics.index}\n'
                'bitmask: 1 << ${PerformanceOverlayOption.visualizeEngineStatistics.index} = ${1 << PerformanceOverlayOption.visualizeEngineStatistics.index}\n\n'
                '// Usage\n'
                'PerformanceOverlay(\n'
                '  optionsMask: 1 << PerformanceOverlayOption\n'
                '      .visualizeEngineStatistics.index,\n'
                ')',
            _purpleMedium,
          ),
          _buildInfoBox(
            'Spotting UI Jank',
            'Red bars in the UI thread graph indicate frames where Dart code, '
                'layout, or painting took too long. Common causes include expensive '
                'widget rebuilds, synchronous file I/O, or complex calculations in '
                'the build method. Use DevTools for deeper analysis.',
            Icons.analytics,
            _purpleMedium,
          ),

          SizedBox(height: 24),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 6: COMBINING OPTIONS WITH BITMASK
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(
            'Combining Options with Bitmask',
            Icons.join_inner,
            _tealMedium,
          ),
          _buildInfoBox(
            'How Bitmask Combination Works',
            'PerformanceOverlay uses an optionsMask integer where each bit '
                'represents one option. To enable multiple options, combine their '
                'bitmask values using the bitwise OR operator (|). Each enum value\'s '
                'index determines its bit position.',
            Icons.filter_list,
            _tealMedium,
          ),

          _buildSubSectionHeader(
            'Individual Bit Positions',
            Icons.grid_view,
            _tealMedium,
          ),
          _buildBitmaskRow(
            'displayRasterizerStatistics',
            PerformanceOverlayOption.displayRasterizerStatistics.index,
            true,
            _primaryMedium,
          ),
          _buildBitmaskRow(
            'visualizeRasterizerStatistics',
            PerformanceOverlayOption.visualizeRasterizerStatistics.index,
            true,
            _successMedium,
          ),
          _buildBitmaskRow(
            'displayEngineStatistics',
            PerformanceOverlayOption.displayEngineStatistics.index,
            true,
            _warnMedium,
          ),
          _buildBitmaskRow(
            'visualizeEngineStatistics',
            PerformanceOverlayOption.visualizeEngineStatistics.index,
            true,
            _purpleMedium,
          ),

          SizedBox(height: 16),

          _buildSubSectionHeader(
            'Common Combinations',
            Icons.layers,
            _tealMedium,
          ),
          _buildBitmaskCombination(
            'Rasterizer Only (Display + Graph)',
            ['displayRasterizerStatistics', 'visualizeRasterizerStatistics'],
            (1 << 0) | (1 << 1),
            _primaryMedium,
          ),
          _buildBitmaskCombination(
            'Engine Only (Display + Graph)',
            ['displayEngineStatistics', 'visualizeEngineStatistics'],
            (1 << 2) | (1 << 3),
            _warnMedium,
          ),
          _buildBitmaskCombination(
            'Display Only (Both Threads, No Graphs)',
            ['displayRasterizerStatistics', 'displayEngineStatistics'],
            (1 << 0) | (1 << 2),
            _purpleMedium,
          ),
          _buildBitmaskCombination(
            'Visualize Only (Both Graphs, No Numbers)',
            ['visualizeRasterizerStatistics', 'visualizeEngineStatistics'],
            (1 << 1) | (1 << 3),
            _successMedium,
          ),
          _buildBitmaskCombination(
            'All Options (Full Performance View)',
            [
              'displayRasterizerStatistics',
              'visualizeRasterizerStatistics',
              'displayEngineStatistics',
              'visualizeEngineStatistics',
            ],
            (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
            _tealMedium,
          ),

          _buildSubSectionHeader(
            'Code Examples',
            Icons.code,
            _tealMedium,
          ),
          _buildCodeBlock(
            '// Show all rasterizer stats\n'
                'int rasterMask = \n'
                '    (1 << PerformanceOverlayOption.displayRasterizerStatistics.index) |\n'
                '    (1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index);\n'
                '// Result: 3\n\n'
                '// Show all engine stats\n'
                'int engineMask = \n'
                '    (1 << PerformanceOverlayOption.displayEngineStatistics.index) |\n'
                '    (1 << PerformanceOverlayOption.visualizeEngineStatistics.index);\n'
                '// Result: 12\n\n'
                '// Show everything\n'
                'int allMask = rasterMask | engineMask;\n'
                '// Result: 15\n\n'
                '// Use with PerformanceOverlay\n'
                'PerformanceOverlay(optionsMask: allMask)',
            _tealMedium,
          ),

          _buildInfoBox(
            'Best Practices',
            'During development, use optionsMask: 15 to show all stats. For '
                'production debugging, start with graphs only (mask: 10) to quickly '
                'spot issues, then add numeric display for detailed analysis. '
                'Remember to remove or disable the overlay for release builds.',
            Icons.verified_user,
            _tealMedium,
          ),

          SizedBox(height: 32),

          // Summary footer
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryDark, _purpleDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _primaryDark.withAlpha(40),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.speed, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'PerformanceOverlayOption Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Total values: ${PerformanceOverlayOption.values.length} | '
                      'Max mask: ${(1 << PerformanceOverlayOption.values.length) - 1}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSummaryChip('Raster', '2 opts', _primaryPale),
                    _buildSummaryChip('Engine', '2 opts', _warnPale),
                    _buildSummaryChip('Total', '4 opts', _successPale),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    ),
  );
}

Widget _buildSummaryChip(String label, String value, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _textSecondary,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
      ],
    ),
  );
}
