// D4rt test script: Comprehensive deep demo for PerformanceOverlayLayer
//
// PerformanceOverlayLayer displays performance statistics directly in the UI:
//   - Shows GPU/UI frame timing graphs
//   - Displays raster cache checkerboard patterns
//   - Helps identify rendering bottlenecks
//   - Configurable via optionsMask bitmask
//
// This demo covers:
//   1. PerformanceOverlay widget basics
//   2. optionsMask bits explanation
//   3. visualizeRasterizer vs checkerboardRasterCacheImages
//   4. overlayRect configuration
//   5. Performance mode usage scenarios
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _primaryDark = Color(0xFF0D47A1);
Color _primaryMedium = Color(0xFF1976D2);
Color _primaryPale = Color(0xFFBBDEFB);
Color _primaryBg = Color(0xFFE3F2FD);

Color _accentDark = Color(0xFFB71C1C);
Color _accentMedium = Color(0xFFD32F2F);

Color _successDark = Color(0xFF1B5E20);
Color _successMedium = Color(0xFF388E3C);
Color _successPale = Color(0xFFC8E6C9);

Color _warnDark = Color(0xFFE65100);
Color _warnMedium = Color(0xFFFB8C00);

Color _purpleDark = Color(0xFF4A148C);
Color _purpleMedium = Color(0xFF7B1FA2);
Color _purplePale = Color(0xFFE1BEE7);

Color _textPrimary = Color(0xFF212121);
Color _textSecondary = Color(0xFF616161);
Color _bgCard = Color(0xFFFFFFFF);

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

Widget _buildCodeDisplay(String title, String code, Color headerColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: headerColor.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: headerColor.withAlpha(20),
            borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: headerColor, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: headerColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(11)),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFE0E0E0),
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(String title, Widget diagram) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _primaryPale),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _primaryDark,
          ),
        ),
        SizedBox(height: 12),
        diagram,
      ],
    ),
  );
}

Widget _buildAsciiDiagram(String ascii) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Text(
      ascii,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: _textPrimary,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildBitRow(String bit, String name, String description, bool alternate, Color bitColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: alternate ? _primaryBg.withAlpha(100) : Colors.white,
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: bitColor.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            bit,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: bitColor,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _textPrimary,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: _textSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonCard(String title, String description, List<String> features, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
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
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: _textSecondary,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: features.map((feature) {
            return Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: color, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 11,
                        color: _textPrimary,
                      ),
                    ),
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

Widget _buildScenarioCard(String scenario, String use, String mask, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scenario,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        Text(
          use,
          style: TextStyle(
            fontSize: 12,
            color: _textSecondary,
            height: 1.4,
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            mask,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('PerformanceOverlayLayer Deep Demo - Comprehensive Test');
  print('═' * 60);

  // -------------------------------------------------------------------------
  // SECTION 1: PerformanceOverlay Widget Basics
  // -------------------------------------------------------------------------
  print('\n[SECTION 1] PerformanceOverlay Widget Basics');
  print('-' * 50);

  print('\nPerformanceOverlay is a widget that displays performance graphs:');
  print('  - Shows frame timing information visually');
  print('  - Displays GPU and UI thread performance');
  print('  - Helps detect rendering bottlenecks');
  print('  - Creates PerformanceOverlayLayer in the layer tree');

  print('\nPerformanceOverlay widget structure:');
  print('''
  PerformanceOverlay({
    int optionsMask = 0,
    int rasterizerThreshold = 0,
    bool checkerboardRasterCacheImages = false,
    bool checkerboardOffscreenLayers = false,
  })
  ''');

  print('\nUsage with MaterialApp:');
  print('''
  MaterialApp(
    showPerformanceOverlay: true,  // Shows both graphs
    // Creates PerformanceOverlay internally
  )
  ''');

  print('\nDirect PerformanceOverlay usage:');
  print('''
  Stack(
    children: [
      MyApp(),
      PerformanceOverlay.allEnabled(),  // All stats
    ],
  )
  ''');

  print('\nConvenience constructors:');
  print('  PerformanceOverlay.allEnabled()');
  print('    - Shows all performance statistics');
  print('    - optionsMask = 0x1F (all bits set)');
  print('');
  print('  PerformanceOverlay(optionsMask: mask)');
  print('    - Custom configuration via bitmask');
  print('    - Fine-grained control over what to display');

  // -------------------------------------------------------------------------
  // SECTION 2: optionsMask Bits Explanation
  // -------------------------------------------------------------------------
  print('\n[SECTION 2] optionsMask Bits Explanation');
  print('-' * 50);

  print('\nThe optionsMask is a bitmask controlling overlay features:');
  print('  Each bit enables a specific visualization feature');
  print('  Combine bits with bitwise OR (|) operator');

  print('\nPerformanceOverlayOption enum values:');
  print('''
  enum PerformanceOverlayOption {
    displayRasterizerStatistics,    // Bit 0: GPU timing graph
    visualizeRasterizerStatistics,  // Bit 1: GPU histogram bars
    displayEngineStatistics,        // Bit 2: UI timing graph
    visualizeEngineStatistics,      // Bit 3: UI histogram bars
  }
  ''');

  print('\nBit positions and values:');
  print('''
  ┌──────┬──────────────────────────────────┬────────┐
  │ Bit  │ Option                           │ Value  │
  ├──────┼──────────────────────────────────┼────────┤
  │  0   │ displayRasterizerStatistics      │ 1<<0=1 │
  │  1   │ visualizeRasterizerStatistics    │ 1<<1=2 │
  │  2   │ displayEngineStatistics          │ 1<<2=4 │
  │  3   │ visualizeEngineStatistics        │ 1<<3=8 │
  └──────┴──────────────────────────────────┴────────┘
  ''');

  int displayRasterizer = 1 << 0;
  int visualizeRasterizer = 1 << 1;
  int displayEngine = 1 << 2;
  int visualizeEngine = 1 << 3;

  print('\nComputed option values:');
  print('  displayRasterizerStatistics  = ${displayRasterizer}');
  print('  visualizeRasterizerStatistics = ${visualizeRasterizer}');
  print('  displayEngineStatistics      = ${displayEngine}');
  print('  visualizeEngineStatistics    = ${visualizeEngine}');

  int gpuOnly = displayRasterizer | visualizeRasterizer;
  int uiOnly = displayEngine | visualizeEngine;
  int allOptions = gpuOnly | uiOnly;

  print('\nCombined masks:');
  print('  GPU only (bits 0,1):  ${gpuOnly}');
  print('  UI only (bits 2,3):   ${uiOnly}');
  print('  All options (0-3):    ${allOptions}');

  print('\nMask composition diagram:');
  print('''
  optionsMask = 0b1111 = 15 = 0xF
  
                 ┌─ visualizeEngineStatistics (bit 3)
                 │  ┌─ displayEngineStatistics (bit 2)
                 │  │  ┌─ visualizeRasterizerStatistics (bit 1)
                 │  │  │  ┌─ displayRasterizerStatistics (bit 0)
                 ▼  ▼  ▼  ▼
                 1  1  1  1
                 
  Reading: UI histogram │ UI graph │ GPU histogram │ GPU graph
  ''');

  // -------------------------------------------------------------------------
  // SECTION 3: visualizeRasterizer vs checkerboardRasterCacheImages
  // -------------------------------------------------------------------------
  print('\n[SECTION 3] visualizeRasterizer vs checkerboardRasterCacheImages');
  print('-' * 50);

  print('\nThese are two different debugging tools:');
  print('');
  print('visualizeRasterizerStatistics (optionsMask bit 1):');
  print('  - Shows histogram of GPU frame times');
  print('  - Each bar = one frame render time');
  print('  - Visual timeline of rasterization performance');
  print('  - Helps identify frames that took too long to rasterize');

  print('\ncheckerboardRasterCacheImages (separate property):');
  print('  - Overlays checkerboard pattern on cached images');
  print('  - Shows which parts are being cached by raster cache');
  print('  - Purple/gold checkerboard = raster cached');
  print('  - Helps verify caching strategy');

  print('\nRender difference visualization:');
  print('''
  ┌─────────────────────────────────────────────────────────┐
  │  visualizeRasterizerStatistics                          │
  │  ┌─────────────────────────────────────────────────┐    │
  │  │        Frame Timing Histogram                   │    │
  │  │  ██                                             │    │
  │  │  ██  █                                          │    │
  │  │  ██  ██  █   █                                  │    │
  │  │  ██  ██  ██  ██  █   █                          │    │
  │  │  ██  ██  ██  ██  ██  ██  █   █   █              │    │
  │  │──────────────────────────────────── 16ms line   │    │
  │  │  F1  F2  F3  F4  F5  F6  F7  F8  F9  (frames)   │    │
  │  └─────────────────────────────────────────────────┘    │
  └─────────────────────────────────────────────────────────┘
  
  ┌─────────────────────────────────────────────────────────┐
  │  checkerboardRasterCacheImages                          │
  │  ┌─────────────────────────────────────────────────┐    │
  │  │  Normal Widget     │  ▓▒▓▒▓▒▓▒▓▒│               │    │
  │  │  (no pattern)      │  ▒▓▒▓▒▓▒▓▒▓│ <- Cached     │    │
  │  │                    │  ▓▒▓▒▓▒▓▒▓▒│    Image      │    │
  │  │                    │  ▒▓▒▓▒▓▒▓▒▓│               │    │
  │  └─────────────────────────────────────────────────┘    │
  └─────────────────────────────────────────────────────────┘
  ''');

  print('\nWhen to use each:');
  print('  visualizeRasterizerStatistics:');
  print('    - Debugging frame drops during animations');
  print('    - Identifying expensive GPU operations');
  print('    - Profiling shader compilation hitches');
  print('');
  print('  checkerboardRasterCacheImages:');
  print('    - Verifying RepaintBoundary effectiveness');
  print('    - Finding widgets that should be cached');
  print('    - Debugging unnecessary repaints');

  print('\nUsage example:');
  print('''
  // Histogram overlay
  PerformanceOverlay(
    optionsMask: 1 << 1,  // visualizeRasterizerStatistics
  )
  
  // Checkerboard overlay
  PerformanceOverlay(
    checkerboardRasterCacheImages: true,
  )
  
  // Both overlays
  PerformanceOverlay(
    optionsMask: 1 << 1,
    checkerboardRasterCacheImages: true,
  )
  ''');

  // -------------------------------------------------------------------------
  // SECTION 4: overlayRect Configuration
  // -------------------------------------------------------------------------
  print('\n[SECTION 4] overlayRect Configuration');
  print('-' * 50);

  print('\nPerformanceOverlayLayer uses overlayRect for positioning:');
  print('  - Defines the rectangular area for the overlay');
  print('  - Set during layer creation via constructor');
  print('  - Typically fills the available screen space');

  print('\nPerformanceOverlayLayer constructor:');
  print('''
  PerformanceOverlayLayer({
    required Rect overlayRect,
    required int optionsMask,
    int rasterizerThreshold = 0,
    bool checkerboardRasterCacheImages = false,
    bool checkerboardOffscreenLayers = false,
  })
  ''');

  Rect exampleRect = Rect.fromLTWH(0, 0, 400, 200);
  print('\nExample overlayRect:');
  print('  Rect.fromLTWH(0, 0, 400, 200)');
  print('  Left: ${exampleRect.left}');
  print('  Top: ${exampleRect.top}');
  print('  Width: ${exampleRect.width}');
  print('  Height: ${exampleRect.height}');
  print('  Right: ${exampleRect.right}');
  print('  Bottom: ${exampleRect.bottom}');

  print('\nOverlay positioning patterns:');
  print('''
  Full screen overlay:
  ┌────────────────────────────────────┐
  │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
  │▒▒▒▒▒▒ Performance Stats ▒▒▒▒▒▒▒▒▒▒│
  │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│
  │                                    │
  │             App Content            │
  │                                    │
  └────────────────────────────────────┘
  overlayRect = Rect.fromLTWH(0, 0, width, height)
  
  Top-only overlay:
  ┌────────────────────────────────────┐
  │▒▒▒▒▒▒▒▒▒ Stats Here ▒▒▒▒▒▒▒▒▒▒▒▒▒│
  ├────────────────────────────────────┤
  │                                    │
  │             App Content            │
  │                                    │
  └────────────────────────────────────┘
  overlayRect = Rect.fromLTWH(0, 0, width, 100)
  ''');

  print('\nRenderPerformanceOverlay layout:');
  print('''
  class RenderPerformanceOverlay extends RenderBox {
    @override
    void performLayout() {
      // Takes all available space from constraints
      size = constraints.biggest;
    }
    
    @override
    void paint(PaintingContext context, Offset offset) {
      // Appends PerformanceOverlayLayer to the layer tree
      context.addLayer(
        PerformanceOverlayLayer(
          overlayRect: Rect.fromLTWH(
            offset.dx,
            offset.dy,
            size.width,
            size.height,
          ),
          optionsMask: optionsMask,
          rasterizerThreshold: rasterizerThreshold,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        ),
      );
    }
  }
  ''');

  Rect customRect1 = Rect.fromLTRB(10, 10, 300, 150);
  Rect customRect2 = Rect.fromCenter(center: Offset(200, 100), width: 300, height: 100);

  print('\nAlternative rect creation methods:');
  print('  fromLTRB: ${customRect1}');
  print('  fromCenter: ${customRect2}');

  // -------------------------------------------------------------------------
  // SECTION 5: Performance Mode Usage Scenarios
  // -------------------------------------------------------------------------
  print('\n[SECTION 5] Performance Mode Usage Scenarios');
  print('-' * 50);

  print('\nScenario 1: Animation Jank Investigation');
  print('  Problem: List scrolling feels choppy');
  print('  Goal: Find which frames exceed 16ms');
  print('''
  Solution:
    PerformanceOverlay(
      optionsMask: (1 << 0) | (1 << 1),  // GPU display + histogram
    )
  
  Look for:
    - Tall bars in histogram (> 16ms line)
    - Patterns during specific scroll positions
    - Spikes correlating with content changes
  ''');

  print('\nScenario 2: UI Thread Bottleneck');
  print('  Problem: Build methods taking too long');
  print('  Goal: Identify expensive widget builds');
  print('''
  Solution:
    PerformanceOverlay(
      optionsMask: (1 << 2) | (1 << 3),  // UI display + histogram
    )
  
  Look for:
    - UI thread spikes during state changes
    - High bars when navigating between screens
    - Correlation with setState() calls
  ''');

  print('\nScenario 3: Raster Cache Optimization');
  print('  Problem: Widgets being repainted unnecessarily');
  print('  Goal: Verify cache boundaries are effective');
  print('''
  Solution:
    PerformanceOverlay(
      checkerboardRasterCacheImages: true,
    )
  
  Look for:
    - Complex widgets WITHOUT checkerboard = not cached
    - Add RepaintBoundary to static complex widgets
    - Verify animations only repaint needed areas
  ''');

  print('\nScenario 4: Offscreen Layer Investigation');
  print('  Problem: Offscreen compositing using too much memory');
  print('  Goal: Find unnecessary saveLayer calls');
  print('''
  Solution:
    PerformanceOverlay(
      checkerboardOffscreenLayers: true,
    )
  
  Look for:
    - Unexpected checkerboard areas
    - Opacity widgets (can trigger saveLayer)
    - ClipPath without needing antialiasing
  ''');

  print('\nScenario 5: Production Performance Baseline');
  print('  Problem: Need performance metrics without affecting users');
  print('  Goal: Set threshold alerts');
  print('''
  Solution:
    PerformanceOverlay(
      rasterizerThreshold: 0,  // Log to console when exceeded
    )
  
  Log analysis:
    - Collect timing data in release builds
    - Identify performance regressions
    - Track metrics across app versions
  ''');

  print('\nScenario 6: Full Debug Mode');
  print('  Problem: General performance audit needed');
  print('  Goal: See all available information');
  print('''
  Solution:
    PerformanceOverlay.allEnabled()
    
    // Or via MaterialApp
    MaterialApp(
      showPerformanceOverlay: true,
      checkerboardRasterCacheImages: true,
      checkerboardOffscreenLayers: true,
    )
  ''');

  int scenario1Mask = (1 << 0) | (1 << 1);
  int scenario2Mask = (1 << 2) | (1 << 3);
  int scenario6Mask = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3);

  print('\nComputed masks for scenarios:');
  print('  Scenario 1 (GPU stats): ${scenario1Mask}');
  print('  Scenario 2 (UI stats):  ${scenario2Mask}');
  print('  Scenario 6 (All stats): ${scenario6Mask}');

  // -------------------------------------------------------------------------
  // SECTION 6: Layer Tree Integration
  // -------------------------------------------------------------------------
  print('\n[SECTION 6] Layer Tree Integration');
  print('-' * 50);

  print('\nPerformanceOverlayLayer in the layer tree:');
  print('''
  Layer Tree Structure:
  
  TransformLayer (root)
    │
    ├── OffsetLayer
    │     │
    │     ├── PictureLayer (app content)
    │     │
    │     └── ContainerLayer
    │           │
    │           └── PerformanceOverlayLayer
    │                 │
    │                 ├── overlayRect: Rect(0,0,400,200)
    │                 ├── optionsMask: 15
    │                 ├── rasterizerThreshold: 0
    │                 ├── checkerboardRasterCacheImages: false
    │                 └── checkerboardOffscreenLayers: false
    │
    └── Other layers...
  ''');

  print('\nLayer composition during painting:');
  print('''
  Frame rendering order:
  
  1. Engine begins frame
     ├── Clear previous frame buffer
     └── Start scene building
  
  2. Paint layers in tree order
     ├── TransformLayer applies root transform
     ├── OffsetLayer applies offset
     ├── PictureLayer draws app content
     └── PerformanceOverlayLayer draws stats
  
  3. PerformanceOverlayLayer execution
     ├── Read frame timing from engine
     ├── Update histogram data
     ├── Draw GPU graph (if enabled)
     ├── Draw GPU histogram (if enabled)
     ├── Draw UI graph (if enabled)
     ├── Draw UI histogram (if enabled)
     └── Apply checkerboard patterns (if enabled)
  
  4. Scene submitted to GPU
     └── Composited and displayed
  ''');

  print('\nZ-ordering behavior:');
  print('  - PerformanceOverlayLayer draws on top of content');
  print('  - Not affected by transforms (draws in screen space)');
  print('  - Always visible regardless of clipping');
  print('  - Multiple overlays stack (avoid in production)');

  // -------------------------------------------------------------------------
  // Console Summary
  // -------------------------------------------------------------------------
  print('\n' + '═' * 60);
  print('PerformanceOverlayLayer Demo Summary');
  print('═' * 60);
  print('\nKey takeaways:');
  print('  1. optionsMask uses bitmask (bits 0-3)');
  print('  2. visualize* shows histograms, display* shows graphs');
  print('  3. checkerboard* properties are separate from mask');
  print('  4. overlayRect defines positioning bounds');
  print('  5. Use specific masks for targeted debugging');
  print('\nDemo completed successfully.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI WIDGET
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title Card
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryDark, _primaryMedium],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _primaryDark.withAlpha(80),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.speed, color: Colors.white, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'PerformanceOverlayLayer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Layer that displays performance statistics including GPU and UI frame timing graphs, '
                    'rasterization histograms, and cache visualization.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // Section 1: Widget Basics
        _buildSectionHeader(
          'PerformanceOverlay Widget Basics',
          Icons.widgets,
          _primaryDark,
        ),

        _buildInfoBox(
          'What is PerformanceOverlay?',
          'PerformanceOverlay is a diagnostic widget that displays performance graphs '
              'directly in the UI. It creates a PerformanceOverlayLayer in the layer tree '
              'during painting. The overlay shows frame timing information to help identify '
              'rendering bottlenecks and performance issues.',
          Icons.info_outline,
          _primaryDark,
        ),

        _buildCodeDisplay('Basic Usage', '''
// Via MaterialApp
MaterialApp(
  showPerformanceOverlay: true,
)

// Direct widget usage
Stack(
  children: [
    MyApp(),
    PerformanceOverlay.allEnabled(),
  ],
)

// Custom configuration
PerformanceOverlay(
  optionsMask: 0x0F,  // All statistics
  rasterizerThreshold: 0,
  checkerboardRasterCacheImages: false,
  checkerboardOffscreenLayers: false,
)''', _primaryDark),

        _buildDiagramBox(
          'Widget to Layer Relationship',
          _buildAsciiDiagram('''
  Widget Tree:        Render Tree:        Layer Tree:
  
  Stack               RenderStack         ContainerLayer
    │                   │                   │
    ├── MyApp           ├── ...             ├── PictureLayer
    │                   │                   │
    └── Performance     └── RenderPerf      └── Performance
        Overlay             Overlay             OverlayLayer
        
  Widget creates RenderObject which appends Layer'''),
        ),

        // Section 2: optionsMask Bits
        _buildSectionHeader(
          'optionsMask Bits Explanation',
          Icons.tune,
          _purpleDark,
        ),

        _buildInfoBox(
          'Understanding the Bitmask',
          'The optionsMask property uses a bitmask where each bit enables a specific visualization feature. '
              'Combine bits using bitwise OR (|) to enable multiple features simultaneously. '
              'Bits 0-1 control GPU statistics, bits 2-3 control UI thread statistics.',
          Icons.memory,
          _purpleDark,
        ),

        Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _purplePale),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _purpleDark,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Bit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Option Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildBitRow('0 (1)', 'displayRasterizerStats', 'GPU frame timing graph', false, _primaryMedium),
              _buildBitRow('1 (2)', 'visualizeRasterizerStats', 'GPU histogram bars', true, _primaryMedium),
              _buildBitRow('2 (4)', 'displayEngineStats', 'UI thread timing graph', false, _successMedium),
              _buildBitRow('3 (8)', 'visualizeEngineStats', 'UI histogram bars', true, _successMedium),
            ],
          ),
        ),

        _buildDiagramBox(
          'Bitmask Composition',
          _buildAsciiDiagram('''
  optionsMask = 0b1111 = 15 = 0x0F
  
                   ┌─ bit 3: visualizeEngineStatistics
                   │  ┌─ bit 2: displayEngineStatistics
                   │  │  ┌─ bit 1: visualizeRasterizerStatistics
                   │  │  │  ┌─ bit 0: displayRasterizerStatistics
                   ▼  ▼  ▼  ▼
                   1  1  1  1
                   
  Example combinations:
    GPU only:  0b0011 = 3   (bits 0,1)
    UI only:   0b1100 = 12  (bits 2,3)
    All:       0b1111 = 15  (bits 0-3)
    Graphs:    0b0101 = 5   (bits 0,2)
    Histograms:0b1010 = 10  (bits 1,3)'''),
        ),

        // Section 3: Comparison
        _buildSectionHeader(
          'visualizeRasterizer vs checkerboardRasterCacheImages',
          Icons.compare,
          _accentDark,
        ),

        _buildComparisonCard(
          'visualizeRasterizerStatistics',
          'Shows a histogram of GPU frame rendering times. Each bar represents one frame, '
              'with height indicating render duration.',
          [
            'Enabled via optionsMask bit 1 (value 2)',
            'Shows timeline of frame rendering performance',
            'Helps identify frames exceeding 16ms target',
            'Useful for animation jank debugging',
          ],
          _primaryMedium,
          Icons.bar_chart,
        ),

        _buildComparisonCard(
          'checkerboardRasterCacheImages',
          'Overlays a checkerboard pattern on widgets that are being cached by the raster cache. '
              'Helps verify that RepaintBoundary is working correctly.',
          [
            'Controlled via separate boolean property',
            'Shows purple/gold pattern on cached areas',
            'Identifies widgets eligible for caching',
            'Helps optimize static complex widgets',
          ],
          _warnDark,
          Icons.grid_on,
        ),

        _buildDiagramBox(
          'Visual Comparison',
          _buildAsciiDiagram('''
  visualizeRasterizerStatistics:
  ┌──────────────────────────────────────────┐
  │      ██                                  │
  │      ██  █                               │
  │   █  ██  ██  █                           │
  │   ██ ██  ██  ██  █   █                   │
  │   ██ ██  ██  ██  ██  ██  █   █   █       │
  │ ─────────────────────────────── 16ms     │
  │   F1 F2  F3  F4  F5  F6  F7  F8  F9      │
  └──────────────────────────────────────────┘
  
  checkerboardRasterCacheImages:
  ┌──────────────────────────────────────────┐
  │  Normal         │ ▓▒▓▒▓▒▓│               │
  │  Widget         │ ▒▓▒▓▒▓▒│ Cached Image  │
  │  (no overlay)   │ ▓▒▓▒▓▒▓│ (checkered)   │
  └──────────────────────────────────────────┘'''),
        ),

        // Section 4: overlayRect
        _buildSectionHeader(
          'overlayRect Configuration',
          Icons.crop_square,
          _successDark,
        ),

        _buildInfoBox(
          'Positioning the Overlay',
          'The overlayRect property defines the rectangular bounds where the performance overlay '
              'will be drawn. This is set during layer creation and typically matches the render '
              'object size. The overlay uses this rect to position graphs and histograms.',
          Icons.photo_size_select_large,
          _successDark,
        ),

        _buildCodeDisplay('Rect Configuration', '''
// Layer constructor
PerformanceOverlayLayer(
  overlayRect: Rect.fromLTWH(0, 0, 400, 200),
  optionsMask: 15,
  rasterizerThreshold: 0,
  checkerboardRasterCacheImages: false,
  checkerboardOffscreenLayers: false,
)

// Different Rect creation methods
Rect.fromLTWH(left, top, width, height)
Rect.fromLTRB(left, top, right, bottom)
Rect.fromCenter(center: Offset, width, height)
Rect.fromPoints(Offset a, Offset b)
Rect.fromCircle(center: Offset, radius)''', _successDark),

        _buildDiagramBox(
          'Overlay Positioning Patterns',
          _buildAsciiDiagram('''
  Full Screen:                   Top Only:
  ┌──────────────────┐           ┌──────────────────┐
  │▓▓▓▓▓ Stats ▓▓▓▓▓▓│           │▓▓▓▓▓ Stats ▓▓▓▓▓▓│
  │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│           ├──────────────────┤
  │                  │           │                  │
  │    App Content   │           │    App Content   │
  │                  │           │                  │
  └──────────────────┘           └──────────────────┘
  Rect(0,0,w,h)                  Rect(0,0,w,100)
  
  Inset:                         Custom Position:
  ┌──────────────────┐           ┌──────────────────┐
  │  ┌────────────┐  │           │                  │
  │  │Stats (inset│  │           │   ┌───────┐      │
  │  └────────────┘  │           │   │ Stats │      │
  │    App Content   │           │   └───────┘      │
  │                  │           │    App Content   │
  └──────────────────┘           └──────────────────┘
  Rect(10,10,w-20,100)           Rect(50,100,150,60)'''),
        ),

        // Section 5: Usage Scenarios
        _buildSectionHeader(
          'Performance Mode Usage Scenarios',
          Icons.build_circle,
          _warnDark,
        ),

        _buildInfoBox(
          'Targeted Debugging',
          'Different scenarios require different overlay configurations. Use specific optionsMask '
              'values to focus on the relevant metrics. Combining all features can be overwhelming '
              'and may itself impact performance measurements.',
          Icons.track_changes,
          _warnDark,
        ),

        _buildScenarioCard(
          'Animation Jank Investigation',
          'Problem: Scrolling feels choppy. Show GPU timing to identify frames exceeding 16ms budget.',
          'optionsMask: (1<<0) | (1<<1) = 3',
          _primaryMedium,
        ),

        _buildScenarioCard(
          'UI Thread Bottleneck',
          'Problem: Slow widget builds. Show UI thread stats to identify expensive setState calls.',
          'optionsMask: (1<<2) | (1<<3) = 12',
          _successMedium,
        ),

        _buildScenarioCard(
          'Raster Cache Optimization',
          'Problem: Unnecessary repaints. Use checkerboard to verify RepaintBoundary effectiveness.',
          'checkerboardRasterCacheImages: true',
          _warnMedium,
        ),

        _buildScenarioCard(
          'Offscreen Layer Analysis',
          'Problem: High GPU memory from saveLayer. Find unexpected offscreen compositing.',
          'checkerboardOffscreenLayers: true',
          _purpleMedium,
        ),

        _buildScenarioCard(
          'Full Debug Mode',
          'Problem: General performance audit needed. Enable all statistics for comprehensive view.',
          'PerformanceOverlay.allEnabled()',
          _accentMedium,
        ),

        // Visual Demo
        _buildSectionHeader(
          'Live Overlay Demo',
          Icons.preview,
          _primaryDark,
        ),

        Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _primaryPale),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Simulated Performance Graph',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _primaryDark,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 120,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF4CAF50).withAlpha(50),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'GPU',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '60 FPS',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 10,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF2196F3).withAlpha(50),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'UI',
                            style: TextStyle(
                              color: Color(0xFF2196F3),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '60 FPS',
                          style: TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(24, (index) {
                          double gpuHeight = (index % 3 == 0) ? 0.8 : (index % 5 == 0 ? 0.9 : 0.5);
                          double uiHeight = (index % 4 == 0) ? 0.6 : (index % 7 == 0 ? 0.7 : 0.4);
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FractionallySizedBox(
                                      heightFactor: gpuHeight,
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF4CAF50).withAlpha(180),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 1),
                                  Expanded(
                                    child: FractionallySizedBox(
                                      heightFactor: uiHeight,
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2196F3).withAlpha(180),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 1,
                      color: Color(0xFF616161),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '16ms target line',
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Green bars = GPU frame time, Blue bars = UI frame time',
                style: TextStyle(
                  fontSize: 11,
                  color: _textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Summary
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successPale,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successMedium),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: _successDark, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'PerformanceOverlayLayer demo complete. Covered: widget basics, optionsMask bits, '
                      'rasterizer vs checkerboard comparison, overlayRect configuration, and usage scenarios.',
                  style: TextStyle(
                    fontSize: 13,
                    color: _successDark,
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
