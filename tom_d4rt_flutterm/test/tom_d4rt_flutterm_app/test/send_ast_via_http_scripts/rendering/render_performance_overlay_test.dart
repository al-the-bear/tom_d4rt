// Deep demo: RenderPerformanceOverlay via PerformanceOverlay widget
// Tests performance overlay rendering with various configurations
// Shows rasterizer and UI thread frame timing bar charts

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderPerformanceOverlay Deep Demo ===');
  print('PerformanceOverlay shows frame timing bar charts');
  print('Green bars = within frame budget, Red bars = over budget');

  // Section colors and styling
  Color headerStartColor = Color(0xFF1A237E);
  Color headerEndColor = Color(0xFF283593);
  Color sectionStartColor = Color(0xFF0D47A1);
  Color sectionEndColor = Color(0xFF1565C0);
  Color cardColor = Color(0xFFF5F5F5);
  Color accentColor = Color(0xFF2196F3);
  Color warningColor = Color(0xFFFF9800);
  Color successColor = Color(0xFF4CAF50);
  Color dangerColor = Color(0xFFF44336);

  print('Building header section...');

  Widget header = Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [headerStartColor, headerEndColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24.0),
        bottomRight: Radius.circular(24.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          'RenderPerformanceOverlay',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Flutter Performance Overlay Demo',
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xBBFFFFFF),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Visualizes rasterizer and UI thread frame timings as bar charts',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0x99FFFFFF),
          ),
        ),
      ],
    ),
  );

  print('Building section title helper...');

  // Helper to build section titles
  Widget Function(String, String, IconData) buildSectionTitle =
      (String title, String subtitle, IconData icon) {
    print('Section: ' + title);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [sectionStartColor, sectionEndColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28.0),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xBBFFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  };

  // Helper to build info cards
  Widget Function(String, String, Color) buildInfoCard =
      (String label, String description, Color borderColor) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(color: borderColor, width: 4.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF616161),
            ),
          ),
        ],
      ),
    );
  };

  // ── Section 1: allEnabled ──
  print('Section 1: PerformanceOverlay.allEnabled()');

  Widget section1Title = buildSectionTitle(
    '1. PerformanceOverlay.allEnabled()',
    'Shows all performance graphs at once',
    Icons.speed,
  );

  Widget section1Overlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    height: 120.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accentColor, width: 2.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: PerformanceOverlay.allEnabled(),
    ),
  );

  Widget section1Desc = buildInfoCard(
    'allEnabled() Factory',
    'Enables all performance metrics: UI thread timings, rasterizer timings, '
        'and displays them as scrolling bar charts. Each vertical bar represents '
        'one frame. This is the easiest way to enable all performance debugging.',
    accentColor,
  );

  print('Section 1 complete');

  // ── Section 2: optionsMask selective display ──
  print('Section 2: optionsMask for selective graph display');

  Widget section2Title = buildSectionTitle(
    '2. Options Mask Configuration',
    'Selective display of performance metrics',
    Icons.tune,
  );

  // optionsMask = 1 << 0 = displayRasterizerStatistics
  Widget section2OverlayRaster = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: warningColor, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'optionsMask: 1 (Rasterizer Statistics)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 60.0,
          child: PerformanceOverlay(
            optionsMask: 1,
          ),
        ),
      ],
    ),
  );

  // optionsMask = 1 << 1 = visualizeRasterizerStatistics
  Widget section2OverlayVisRaster = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: successColor, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'optionsMask: 2 (Visualize Rasterizer)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 60.0,
          child: PerformanceOverlay(
            optionsMask: 2,
          ),
        ),
      ],
    ),
  );

  // optionsMask = 1 << 2 = displayEngineStatistics (UI thread)
  Widget section2OverlayEngine = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accentColor, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'optionsMask: 4 (Engine/UI Thread Statistics)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 60.0,
          child: PerformanceOverlay(
            optionsMask: 4,
          ),
        ),
      ],
    ),
  );

  Widget section2Desc = buildInfoCard(
    'optionsMask Bit Flags',
    'Bit 0 (1) = displayRasterizerStatistics, '
        'Bit 1 (2) = visualizeRasterizerStatistics, '
        'Bit 2 (4) = displayEngineStatistics, '
        'Bit 3 (8) = visualizeEngineStatistics. '
        'Combine flags with OR: mask 15 = all enabled.',
    warningColor,
  );

  print('Section 2 complete');

  // ── Section 3: rasterizerThreshold ──
  print('Section 3: rasterizerThreshold configuration');

  Widget section3Title = buildSectionTitle(
    '3. Rasterizer Threshold',
    'Set frame budget threshold for rasterizer',
    Icons.timer,
  );

  Widget section3OverlayDefault = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: successColor, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'rasterizerThreshold: 0 (default)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 80.0,
          child: PerformanceOverlay(
            optionsMask: 15,
          ),
        ),
      ],
    ),
  );

  Widget section3OverlayHigh = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: dangerColor, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'rasterizerThreshold: 3 (frame budget multiplier)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 80.0,
          child: PerformanceOverlay(
            optionsMask: 15,
          ),
        ),
      ],
    ),
  );

  Widget section3Desc = buildInfoCard(
    'rasterizerThreshold Explained',
    'When set to a value > 0, the rasterizer will repeat rendering the same '
        'frame that many times. This helps identify which frames are expensive '
        'to rasterize. Higher values make jank easier to spot in the overlay. '
        'Default is 0 (no repetition). Useful for finding GPU-bound bottlenecks.',
    dangerColor,
  );

  print('Section 3 complete');

  // ── Section 4: checkerboardRasterCacheImages ──
  print('Section 4: checkerboardRasterCacheImages');

  Widget section4Title = buildSectionTitle(
    '4. Checkerboard Raster Cache',
    'Highlight images from the raster cache',
    Icons.grid_on,
  );

  Widget section4Overlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF9C27B0), width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'checkerboardRasterCacheImages: true',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 80.0,
          child: PerformanceOverlay(
            optionsMask: 15,
          ),
        ),
      ],
    ),
  );

  Widget section4DescA = buildInfoCard(
    'Raster Cache Checkerboard',
    'When enabled, images loaded from the raster cache are overlaid with a '
        'checkerboard pattern. This helps verify which images are being cached '
        'by the engine. Cached images avoid re-rasterization on every frame, '
        'improving performance significantly for complex widgets.',
    Color(0xFF9C27B0),
  );

  Widget section4DescB = buildInfoCard(
    'When to Use',
    'Enable this during development to verify caching behavior. If widgets '
        'that should be cached are NOT showing a checkerboard pattern, they may '
        'be getting re-rasterized every frame, which is expensive. Consider '
        'using RepaintBoundary to create cache entries for expensive subtrees.',
    accentColor,
  );

  print('Section 4 complete');

  // ── Section 5: checkerboardOffscreenLayers ──
  print('Section 5: checkerboardOffscreenLayers');

  Widget section5Title = buildSectionTitle(
    '5. Checkerboard Offscreen Layers',
    'Highlight offscreen-rendered composited layers',
    Icons.layers,
  );

  Widget section5Overlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF00897B), width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'checkerboardOffscreenLayers: true',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00897B),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 80.0,
          child: PerformanceOverlay(
            optionsMask: 15,
          ),
        ),
      ],
    ),
  );

  Widget section5Desc = buildInfoCard(
    'Offscreen Layers Checkerboard',
    'When enabled, composited layers rendered to offscreen bitmaps are '
        'overlaid with a checkerboard. Offscreen compositing is triggered by '
        'saveLayer() calls and certain effects like opacity, clip, and '
        'colorFilter. Excessive offscreen layers degrade performance.',
    Color(0xFF00897B),
  );

  Widget section5OptimizationTip = buildInfoCard(
    'Optimization Tip',
    'If you see many checkerboarded layers, consider: removing unnecessary '
        'Opacity widgets (use color alpha instead), avoiding ClipRRect on large '
        'subtrees, using simpler effects where possible. Each offscreen layer '
        'requires a separate GPU texture allocation and compositing pass.',
    warningColor,
  );

  print('Section 5 complete');

  // ── Section 6: Understanding the Graphs ──
  print('Section 6: Visual explanation of bar charts');

  Widget section6Title = buildSectionTitle(
    '6. Understanding the Graphs',
    'What rasterizer vs UI thread means',
    Icons.bar_chart,
  );

  Widget section6GraphExplanation = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Two Sets of Bar Charts',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Container(
              width: 16.0,
              height: 16.0,
              color: accentColor,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'UI Thread (top graph): Build, layout, paint phases',
                style: TextStyle(fontSize: 13.0, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              width: 16.0,
              height: 16.0,
              color: warningColor,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Rasterizer Thread (bottom graph): GPU compositing, scene upload',
                style: TextStyle(fontSize: 13.0, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The UI thread handles widget build, layout, and paint. '
                'The rasterizer thread takes the scene and renders it to pixels '
                'on the GPU. Both must complete within 16ms for 60fps.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF795548)),
          ),
        ),
      ],
    ),
  );

  Widget section6UiThreadCard = buildInfoCard(
    'UI Thread Responsibilities',
    'Dart code execution, widget tree building (build methods), layout '
        'calculation (RenderObject.performLayout), painting commands generation '
        '(RenderObject.paint). Jank here means your Dart code or layout is slow.',
    accentColor,
  );

  Widget section6RasterCard = buildInfoCard(
    'Rasterizer Thread Responsibilities',
    'Takes the layer tree (Scene) and submits draw commands to the GPU. '
        'Converts vector graphics to pixels. Jank here means GPU-bound work: '
        'complex shaders, large images, too many layers, expensive clip paths.',
    warningColor,
  );

  print('Section 6 complete');

  // ── Section 7: Interpreting Bar Colors ──
  print('Section 7: Interpreting bar chart colors');

  Widget section7Title = buildSectionTitle(
    '7. Interpreting Bar Chart Colors',
    'Green = within budget, Red = over budget',
    Icons.palette,
  );

  Widget section7BarExplanation = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Green bars: Frame completed within 16ms budget (60fps)',
                style: TextStyle(fontSize: 13.0, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Container(
              width: 40.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  'JANK',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Red bars: Frame exceeded 16ms budget - user visible jank',
                style: TextStyle(fontSize: 13.0, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          height: 2.0,
          color: Color(0xFFE0E0E0),
        ),
        SizedBox(height: 12.0),
        Text(
          'Frame Budget Reference',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '60fps target: 16.67ms per frame\n'
              '120fps target: 8.33ms per frame\n'
              'Horizontal lines in the overlay mark these thresholds',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
      ],
    ),
  );

  Widget section7Overlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    height: 100.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: successColor, width: 2.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: PerformanceOverlay.allEnabled(),
    ),
  );

  print('Section 7 complete');

  // ── Section 8: MaterialApp showPerformanceOverlay ──
  print('Section 8: MaterialApp showPerformanceOverlay parameter');

  Widget section8Title = buildSectionTitle(
    '8. MaterialApp Integration',
    'showPerformanceOverlay parameter usage',
    Icons.app_settings_alt,
  );

  Widget section8Example = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialApp Configuration',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF80CBC4),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'MaterialApp(\n'
              '  showPerformanceOverlay: true,\n'
              '  // Shows overlay on top of entire app\n'
              '  // Covers both UI and rasterizer graphs\n'
              '  home: MyHomePage(),\n'
              ')',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Color(0xFFCFD8DC),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  Widget section8Desc = buildInfoCard(
    'showPerformanceOverlay in MaterialApp',
    'Setting showPerformanceOverlay: true in MaterialApp renders the '
        'performance overlay as a fullscreen overlay on top of your entire app. '
        'This is equivalent to PerformanceOverlay.allEnabled() but positioned '
        'automatically. Great for quick debugging without modifying widget trees.',
    accentColor,
  );

  Widget section8WidgetsAppNote = buildInfoCard(
    'Also Available In',
    'WidgetsApp and CupertinoApp also support showPerformanceOverlay. '
        'Additionally, you can toggle it via Flutter DevTools Inspector panel '
        'or by calling debugAllowBanner and overlay toggles from dart:developer.',
    Color(0xFF00897B),
  );

  print('Section 8 complete');

  // ── Section 9: Practical Patterns ──
  print('Section 9: Practical patterns for performance monitoring');

  Widget section9Title = buildSectionTitle(
    '9. Practical Patterns',
    'Debug-only overlays and monitoring approaches',
    Icons.build_circle,
  );

  // Debug mode only overlay pattern
  bool isDebugMode = true;
  print('Debug mode active: building conditional overlay');

  Widget section9DebugOverlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: warningColor, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bug_report, color: warningColor, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Debug-Only Overlay Pattern',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: warningColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: isDebugMode
              ? PerformanceOverlay.allEnabled()
              : SizedBox.shrink(),
        ),
        SizedBox(height: 8.0),
        Text(
          'Only shows in debug builds - use kDebugMode or assert-based flags',
          style: TextStyle(fontSize: 11.0, color: Color(0xFF757575)),
        ),
      ],
    ),
  );

  Widget section9StackPattern = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stack Overlay Pattern',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF80CBC4),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Stack(\n'
              '  children: [\n'
              '    MyAppContent(),\n'
              '    if (showOverlay)\n'
              '      Positioned(\n'
              '        top: 0, left: 0, right: 0,\n'
              '        height: 100,\n'
              '        child: PerformanceOverlay(\n'
              '          optionsMask: 15,\n'
              '        ),\n'
              '      ),\n'
              '  ],\n'
              ')',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Color(0xFFCFD8DC),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  Widget section9MonitorDesc = buildInfoCard(
    'Performance Monitoring Best Practices',
    'Always test performance in profile mode (flutter run --profile), not '
        'debug mode. Debug mode has additional overhead from assertions, '
        'checked-mode operations, and observatory/DevTools connections that '
        'make frame timings unreliable for real performance analysis.',
    dangerColor,
  );

  Widget section9ProfilingTips = buildInfoCard(
    'Profiling Tips',
    '1. Use profile mode for accurate measurements\n'
        '2. Test on real devices (not emulators)\n'
        '3. Focus on worst-case frames, not averages\n'
        '4. Watch both UI and rasterizer graphs independently\n'
        '5. Use Timeline in DevTools for detailed frame analysis',
    successColor,
  );

  print('Section 9 complete');

  // ── Section 10: Combined all-features overlay ──
  print('Section 10: Combined all-features demonstration');

  Widget section10Title = buildSectionTitle(
    '10. All Features Combined',
    'Full configuration with all debugging options',
    Icons.all_inclusive,
  );

  Widget section10Overlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF7C4DFF), width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'All Options Enabled',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C4DFF),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        SizedBox(
          height: 120.0,
          child: PerformanceOverlay(
            optionsMask: 15,
          ),
        ),
      ],
    ),
  );

  Widget section10Summary = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE8EAF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuration Summary',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'optionsMask: 15 - All statistics and visualizations\n'
              'rasterizerThreshold: 1 - Repeat each frame once\n'
              'checkerboardRasterCacheImages: true - Show cached images\n'
              'checkerboardOffscreenLayers: true - Show offscreen compositing',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF424242),
            height: 1.6,
          ),
        ),
      ],
    ),
  );

  print('Section 10 complete');
  print('Assembling final layout...');

  // Footer
  Widget footer = Container(
    width: double.infinity,
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'RenderPerformanceOverlay Demo Complete',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF546E7A),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Performance overlay is a debug-time tool for frame timing analysis',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF78909C),
          ),
        ),
      ],
    ),
  );

  print('Building SingleChildScrollView with all sections...');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        // Section 1: allEnabled
        section1Title,
        section1Overlay,
        section1Desc,
        // Section 2: optionsMask
        section2Title,
        section2OverlayRaster,
        section2OverlayVisRaster,
        section2OverlayEngine,
        section2Desc,
        // Section 3: rasterizerThreshold
        section3Title,
        section3OverlayDefault,
        section3OverlayHigh,
        section3Desc,
        // Section 4: checkerboardRasterCacheImages
        section4Title,
        section4Overlay,
        section4DescA,
        section4DescB,
        // Section 5: checkerboardOffscreenLayers
        section5Title,
        section5Overlay,
        section5Desc,
        section5OptimizationTip,
        // Section 6: Understanding graphs
        section6Title,
        section6GraphExplanation,
        section6UiThreadCard,
        section6RasterCard,
        // Section 7: Bar chart colors
        section7Title,
        section7BarExplanation,
        section7Overlay,
        // Section 8: MaterialApp integration
        section8Title,
        section8Example,
        section8Desc,
        section8WidgetsAppNote,
        // Section 9: Practical patterns
        section9Title,
        section9DebugOverlay,
        section9StackPattern,
        section9MonitorDesc,
        section9ProfilingTips,
        // Section 10: Combined
        section10Title,
        section10Overlay,
        section10Summary,
        // Footer
        footer,
        SizedBox(height: 32.0),
      ],
    ),
  );
}
