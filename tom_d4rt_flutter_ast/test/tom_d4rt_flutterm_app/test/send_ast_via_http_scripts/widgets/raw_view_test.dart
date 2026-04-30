// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawView
// Demonstrates RawView — the lowest-level widget that establishes a
// render pipeline for a FlutterView. RawView is the foundation beneath
// View, WidgetsApp, and MaterialApp. It provides the bridge between
// the widget layer and the engine's native render surface.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawView Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is RawView?
  // ============================================================
  print('=== Section 1: Concept ===');

  // RawView is the widget that creates a PipelineOwner and
  // establishes the rendering pipeline for a FlutterView.
  // Every Flutter app has at least one RawView (inserted by
  // View or MaterialApp). RawView:
  //   - Registers the app with the engine's view
  //   - Creates the render pipeline (layout, paint, compositing)
  //   - Provides access to view properties (DPR, padding, size)
  //   - Enables multi-view/multi-window scenarios
  //
  // Hierarchy:
  //   RawView → View → WidgetsApp → MaterialApp

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF283593), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, size: 36.0, color: Color(0xFF283593)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'RawView',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'The lowest-level widget that establishes a rendering '
          'pipeline for a FlutterView. It bridges the widget tree '
          'and the engine\'s native render surface. Every Flutter '
          'app has at least one RawView — it is the root of all '
          'visual output.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF283593)),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key responsibilities:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 8.0),
              _buildRawViewBullet(
                'Creates PipelineOwner for layout/paint/compositing',
                Color(0xFF1565C0),
              ),
              _buildRawViewBullet(
                'Registers with the engine\'s FlutterView',
                Color(0xFF2E7D32),
              ),
              _buildRawViewBullet(
                'Provides view metrics (size, DPR, padding)',
                Color(0xFFE65100),
              ),
              _buildRawViewBullet(
                'Enables multi-view / multi-window apps',
                Color(0xFF6A1B9A),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Widget Hierarchy — Where RawView Lives
  // ============================================================
  print('=== Section 2: Widget hierarchy ===');

  // Show the layered hierarchy from engine to MaterialApp.
  // Each layer adds convenience on top of the previous one.

  Widget buildHierarchyLayer(
    String name,
    String description,
    Color color,
    int depth,
    IconData icon,
    bool isHighlighted,
  ) {
    return Container(
      margin: EdgeInsets.only(
        left: depth * 20.0,
        top: 4.0,
        bottom: 4.0,
        right: 8.0,
      ),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isHighlighted
            ? color.withValues(alpha: 0.25)
            : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isHighlighted ? color : color.withValues(alpha: 0.4),
          width: isHighlighted ? 2.5 : 1.0,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 8.0,
                  offset: Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isHighlighted ? 14.0 : 12.0,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          if (isHighlighted)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'THIS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  final hierarchySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Widget Hierarchy',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each layer adds convenience on top of the previous one.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildHierarchyLayer(
          'FlutterView (Engine)',
          'Native window from the platform — not a widget',
          Colors.grey.shade700,
          0,
          Icons.desktop_windows,
          false,
        ),
        Center(
          child: Icon(Icons.arrow_downward,
              color: Colors.grey.shade400, size: 18),
        ),
        buildHierarchyLayer(
          'RawView',
          'Creates PipelineOwner, registers with engine view',
          Color(0xFF283593),
          0,
          Icons.layers,
          true,
        ),
        Center(
          child: Icon(Icons.arrow_downward,
              color: Colors.grey.shade400, size: 18),
        ),
        buildHierarchyLayer(
          'View',
          'Adds FocusScope + automatic MediaQuery from view metrics',
          Color(0xFF1565C0),
          1,
          Icons.filter_frames,
          false,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(Icons.arrow_downward,
                color: Colors.grey.shade400, size: 18),
          ),
        ),
        buildHierarchyLayer(
          'WidgetsApp',
          'Adds routing, localization, default text style',
          Color(0xFF0277BD),
          2,
          Icons.widgets,
          false,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Icon(Icons.arrow_downward,
                color: Colors.grey.shade400, size: 18),
          ),
        ),
        buildHierarchyLayer(
          'MaterialApp / CupertinoApp',
          'Adds Material theming, navigation, scaffold support',
          Color(0xFF00838F),
          3,
          Icons.phone_android,
          false,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: View Properties — What RawView Provides
  // ============================================================
  print('=== Section 3: View properties ===');

  // RawView's underlying FlutterView exposes metrics about
  // the display surface. These get funneled through MediaQuery.

  final view = View.of(context);
  final dpr = view.devicePixelRatio;
  final physSize = view.physicalSize;
  final logicalSize = physSize / dpr;
  final viewPadding = view.viewPadding;
  final viewInsets = view.viewInsets;

  print('  devicePixelRatio: $dpr');
  print('  physicalSize: $physSize');
  print('  logicalSize: $logicalSize');
  print('  viewPadding: $viewPadding');
  print('  viewInsets: $viewInsets');

  Widget buildPropertyRow(
    String label,
    String value,
    IconData icon,
    Color color,
    String explanation,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0),
                Text(
                  explanation,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final propertiesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'View Properties (Live)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Properties provided by the underlying FlutterView:',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildPropertyRow(
          'devicePixelRatio',
          dpr.toStringAsFixed(2),
          Icons.aspect_ratio,
          Color(0xFF1565C0),
          'Physical pixels per logical pixel — affects rendering crispness',
        ),
        buildPropertyRow(
          'physicalSize',
          '${physSize.width.toInt()} × ${physSize.height.toInt()} px',
          Icons.photo_size_select_actual,
          Color(0xFF2E7D32),
          'Raw pixel dimensions of the render surface',
        ),
        buildPropertyRow(
          'logicalSize',
          '${logicalSize.width.toInt()} × '
              '${logicalSize.height.toInt()} dp',
          Icons.straighten,
          Color(0xFFE65100),
          'Device-independent size = physicalSize / devicePixelRatio',
        ),
        buildPropertyRow(
          'viewPadding.top',
          viewPadding.top.toStringAsFixed(1),
          Icons.vertical_align_top,
          Color(0xFF6A1B9A),
          'Top safe area (status bar, notch) — always present',
        ),
        buildPropertyRow(
          'viewPadding.bottom',
          viewPadding.bottom.toStringAsFixed(1),
          Icons.vertical_align_bottom,
          Color(0xFF00838F),
          'Bottom safe area (home indicator, nav bar)',
        ),
        buildPropertyRow(
          'viewInsets.bottom',
          viewInsets.bottom.toStringAsFixed(1),
          Icons.keyboard,
          Color(0xFFC62828),
          'Keyboard height — changes when soft keyboard appears',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Physical vs Logical Pixels — Visual
  // ============================================================
  print('=== Section 4: Physical vs logical pixels ===');

  // Demonstrate how devicePixelRatio relates physical to logical.

  Widget buildDprDemo(double demoDpr, String label) {
    final gridCount = (demoDpr * 3).toInt();
    return Container(
      width: 130.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFF283593).withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFF283593),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Show a grid of "physical pixels" inside one "logical pixel"
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF283593),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: GridView.count(
                    crossAxisCount: gridCount,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      gridCount * gridCount,
                      (i) => Container(
                        decoration: BoxDecoration(
                          color: i % 2 == 0
                              ? Color(0xFF283593).withValues(alpha: 0.2)
                              : Color(0xFF283593).withValues(alpha: 0.06),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  '1 logical pixel',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  '= $gridCount×$gridCount physical',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final dprSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Device Pixel Ratio Explained',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How many physical pixels fill one logical pixel.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDprDemo(1.0, '@1x (mdpi)'),
            buildDprDemo(2.0, '@2x (xhdpi)'),
            buildDprDemo(3.0, '@3x (xxhdpi)'),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFF9A825)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Color(0xFFF9A825), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'This device: ${dpr.toStringAsFixed(1)}x — '
                  'one 10×10 dp square is '
                  '${(10 * dpr).toInt()}×${(10 * dpr).toInt()} physical pixels.',
                  style:
                      TextStyle(fontSize: 11.0, color: Color(0xFF795548)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: View Padding & Insets — Safe Area Visual
  // ============================================================
  print('=== Section 5: View padding and insets ===');

  // Visualize how viewPadding and viewInsets carve out
  // the usable area of the screen.

  final safeAreaVisual = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'View Padding vs View Insets',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How safe areas and system UI affect available space.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 16.0),
        // Phone outline with regions marked
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Phone 1: No keyboard
            Column(
              children: [
                Text(
                  'No keyboard',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                SizedBox(height: 6.0),
                Container(
                  width: 120.0,
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: Colors.grey.shade800,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Status bar (viewPadding.top)
                      Container(
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFE65100).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'viewPadding.top',
                            style: TextStyle(
                              fontSize: 7.0,
                              color: Color(0xFFE65100),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Content area
                      Expanded(
                        child: Container(
                          color: Color(0xFF1565C0).withValues(alpha: 0.08),
                          child: Center(
                            child: Text(
                              'Content\nArea',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Home indicator (viewPadding.bottom)
                      Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF6A1B9A).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'viewPadding.bottom',
                            style: TextStyle(
                              fontSize: 7.0,
                              color: Color(0xFF6A1B9A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Phone 2: With keyboard
            Column(
              children: [
                Text(
                  'Keyboard open',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                SizedBox(height: 6.0),
                Container(
                  width: 120.0,
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: Colors.grey.shade800,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Status bar
                      Container(
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFE65100).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'viewPadding.top',
                            style: TextStyle(
                              fontSize: 7.0,
                              color: Color(0xFFE65100),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Reduced content area
                      Expanded(
                        child: Container(
                          color: Color(0xFF1565C0).withValues(alpha: 0.08),
                          child: Center(
                            child: Text(
                              'Reduced\nContent',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Keyboard (viewInsets.bottom)
                      Container(
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFC62828).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.keyboard,
                                size: 20.0,
                                color: Color(0xFFC62828)),
                            Text(
                              'viewInsets.bottom',
                              style: TextStyle(
                                fontSize: 7.0,
                                color: Color(0xFFC62828),
                                fontWeight: FontWeight.bold,
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
          ],
        ),
        SizedBox(height: 12.0),
        // Legend
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRawViewLegendItem(
                'viewPadding',
                'Always reserved (notch, home indicator)',
                Color(0xFFE65100),
              ),
              SizedBox(height: 4.0),
              _buildRawViewLegendItem(
                'viewInsets',
                'Consumed by system UI (keyboard)',
                Color(0xFFC62828),
              ),
              SizedBox(height: 4.0),
              _buildRawViewLegendItem(
                'padding',
                'viewPadding minus any consumed viewInsets',
                Color(0xFF1565C0),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Multi-View Architecture
  // ============================================================
  print('=== Section 6: Multi-view architecture ===');

  // In multi-view/multi-window scenarios, each window has
  // its own RawView + FlutterView combination.

  Widget buildWindowCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    double width,
    double height,
  ) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title bar
          Container(
            height: 22.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0),
                topRight: Radius.circular(6.0),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 6.0),
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 3.0),
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 3.0),
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 20.0),
                  SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 8.0, color: color),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final multiViewSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Multi-View Architecture',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each window gets its own RawView + FlutterView pair.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 16.0),
        // Desktop multi-window scenario
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Text(
                'Desktop Multi-Window App',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildWindowCard(
                    'Main Editor',
                    'RawView #1\nFlutterView #1',
                    Icons.edit,
                    Color(0xFF1565C0),
                    110.0,
                    100.0,
                  ),
                  buildWindowCard(
                    'Inspector',
                    'RawView #2\nFlutterView #2',
                    Icons.search,
                    Color(0xFF2E7D32),
                    90.0,
                    80.0,
                  ),
                  buildWindowCard(
                    'Preview',
                    'RawView #3\nFlutterView #3',
                    Icons.preview,
                    Color(0xFFE65100),
                    90.0,
                    80.0,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Color(0xFF283593)),
                ),
                child: Text(
                  'Shared Widget Tree (single Dart isolate)',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF283593),
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
  // SECTION 7: RawView vs View Comparison
  // ============================================================
  print('=== Section 7: RawView vs View comparison ===');

  Widget buildComparisonRow(
    String feature,
    bool rawViewHas,
    bool viewHas,
    String note,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                rawViewHas ? Icons.check_circle : Icons.cancel,
                color: rawViewHas ? Color(0xFF2E7D32) : Color(0xFFC62828),
                size: 18.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                viewHas ? Icons.check_circle : Icons.cancel,
                color: viewHas ? Color(0xFF2E7D32) : Color(0xFFC62828),
                size: 18.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              note,
              style: TextStyle(
                fontSize: 9.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'RawView vs View',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Color(0xFF283593).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'RawView',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Color(0xFF283593),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        buildComparisonRow(
          'PipelineOwner',
          true,
          true,
          'Both create render pipeline',
        ),
        buildComparisonRow(
          'Render surface',
          true,
          true,
          'Both attach to engine view',
        ),
        buildComparisonRow(
          'MediaQuery',
          false,
          true,
          'View auto-creates MediaQuery',
        ),
        buildComparisonRow(
          'FocusScope',
          false,
          true,
          'View wraps child in FocusScope',
        ),
        buildComparisonRow(
          'Focus traversal',
          false,
          true,
          'View sets up traversal group',
        ),
        buildComparisonRow(
          'Custom pipeline',
          true,
          false,
          'RawView allows custom owners',
        ),
        buildComparisonRow(
          'Embedding engines',
          true,
          false,
          'For custom rendering engines',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Code Patterns
  // ============================================================
  print('=== Section 8: Code patterns ===');

  Widget buildCodePattern(
    String title,
    String code,
    String whenToUse,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF263238),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    code,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: Color(0xFF80CBC4),
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  whenToUse,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final codeSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Code Patterns',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        buildCodePattern(
          'Access the FlutterView',
          'final view = View.of(context);\n'
              'final dpr = view.devicePixelRatio;\n'
              'final size = view.physicalSize;',
          'When you need low-level view metrics (not via MediaQuery).',
          Color(0xFF1565C0),
          Icons.visibility,
        ),
        buildCodePattern(
          'Multi-view iteration',
          'for (final view in\n'
              '    WidgetsBinding.instance.platformDispatcher\n'
              '        .views) {\n'
              '  print(view.viewId);\n'
              '}',
          'When building multi-window desktop apps.',
          Color(0xFF2E7D32),
          Icons.grid_view,
        ),
        buildCodePattern(
          'Custom RawView usage',
          'RawView(\n'
              '  view: myFlutterView,\n'
              '  builder: (ctx, owner) {\n'
              '    return MyCustomRenderTree();\n'
              '  },\n'
              ')',
          'Embedding custom render pipelines (rare, advanced).',
          Color(0xFFE65100),
          Icons.architecture,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF283593), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF283593), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRawViewSummaryItem(
          Icons.layers,
          'Foundation widget',
          'RawView is the lowest widget that creates a render pipeline',
          Color(0xFF283593),
        ),
        SizedBox(height: 8.0),
        _buildRawViewSummaryItem(
          Icons.aspect_ratio,
          'View metrics',
          'Provides DPR, physical size, padding, and insets',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _buildRawViewSummaryItem(
          Icons.filter_frames,
          'View builds on it',
          'View adds MediaQuery, FocusScope, and traversal',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildRawViewSummaryItem(
          Icons.grid_view,
          'Multi-view ready',
          'Each window gets its own RawView + FlutterView pair',
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildRawViewSummaryItem(
          Icons.code,
          'Rarely used directly',
          'Most apps use View or MaterialApp — RawView is for engines',
          Color(0xFF6A1B9A),
        ),
      ],
    ),
  );

  print('RawView Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A237E),
                Color(0xFF283593),
                Color(0xFF3949AB),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.layers, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RawView',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'The foundation of Flutter\'s rendering pipeline',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Widget Hierarchy',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        hierarchySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. View Properties',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        propertiesSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Device Pixel Ratio',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        dprSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Safe Areas',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        safeAreaVisual,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Multi-View Architecture',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        multiViewSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. RawView vs View',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparisonSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Code Patterns',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        codeSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '9. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildRawViewBullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRawViewLegendItem(String label, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(color: color),
        ),
      ),
      SizedBox(width: 8.0),
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
          color: color,
        ),
      ),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          desc,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
        ),
      ),
    ],
  );
}

Widget _buildRawViewSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
