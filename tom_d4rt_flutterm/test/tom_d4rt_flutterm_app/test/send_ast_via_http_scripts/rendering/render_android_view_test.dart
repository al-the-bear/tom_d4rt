// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for RenderAndroidView from rendering
//
// RenderAndroidView is Flutters render object responsible for embedding
// native Android views (platform views) within the Flutter widget tree.
// It acts as the bridge between the Flutter rendering pipeline and the
// Android SurfaceView/TextureView system, handling compositing, hit
// testing, gesture forwarding, and layout constraints for native views.
//
// Key characteristics:
//   - Embeds native Android views in the Flutter layer tree
//   - Supports Hybrid Composition and Virtual Display modes
//   - Forwards gestures from Flutter to native Android views
//   - Manages PlatformViewHitTestBehavior for hit testing
//   - Handles sizing via BoxConstraints from parent widgets
//   - Used internally by the AndroidView widget
//
// Common use cases:
//   - Google Maps integration via platform views
//   - WebView embedding for web content
//   - Camera preview surfaces
//   - Ad views from third-party SDKs
//   - Native video players
//   - Custom Android UI components
//
// This demo visualizes RenderAndroidView architecture and patterns.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

Color _kPrimary600 = Color(0xFF43A047);
Color _kPrimary700 = Color(0xFF388E3C);
Color _kPrimary800 = Color(0xFF2E7D32);

Color _kSecondary500 = Color(0xFF2196F3);
Color _kSecondary600 = Color(0xFF1E88E5);
Color _kSecondary700 = Color(0xFF1976D2);

Color _kAccent500 = Color(0xFFFF5722);
Color _kAccent600 = Color(0xFFF4511E);
Color _kAccent700 = Color(0xFFE64A19);

Color _kTertiary500 = Color(0xFF9C27B0);
Color _kTertiary600 = Color(0xFF8E24AA);

Color _kWarning500 = Color(0xFFFF9800);
Color _kWarning600 = Color(0xFFFB8C00);
Color _kWarning700 = Color(0xFFF57C00);

Color _kSlate100 = Color(0xFFF1F5F9);
Color _kSlate200 = Color(0xFFE2E8F0);
Color _kSlate300 = Color(0xFFCBD5E1);
Color _kSlate500 = Color(0xFF64748B);
Color _kSlate600 = Color(0xFF475569);
Color _kSlate700 = Color(0xFF334155);
Color _kSlate800 = Color(0xFF1E293B);

Color _kAndroidGreen = Color(0xFF3DDC84);
Color _kAndroidDark = Color(0xFF073042);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kAndroidDark, _kPrimary800, _kPrimary600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _kAndroidDark.withAlpha(140),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.android, color: _kAndroidGreen, size: 64),
        SizedBox(height: 16),
        Text(
          'RenderAndroidView',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Render object for embedding native Android views',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withAlpha(210),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Platform View Integration Layer',
          style: TextStyle(
            fontSize: 13,
            color: _kAndroidGreen.withAlpha(200),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBadge('AndroidView', Icons.phone_android, _kAndroidGreen),
            SizedBox(width: 12),
            _buildBadge('RenderBox', Icons.crop_square, _kSecondary500),
            SizedBox(width: 12),
            _buildBadge('Platform', Icons.layers, _kWarning500),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBadge(String label, IconData icon, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: bgColor.withAlpha(160),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withAlpha(80), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(170)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(80),
          blurRadius: 12,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
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

Widget _buildInfoCard(String title, Widget content, {Color? accentColor}) {
  Color color = accentColor ?? _kPrimary600;
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(60), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _kSlate700,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _kSlate600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildArchitectureLayerRow(
  String layer, String detail, IconData icon, Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(18),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60), width: 1),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                layer,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                detail,
                style: TextStyle(color: _kSlate600, fontSize: 12),
              ),
            ],
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
      color: _kSlate800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: _kAndroidGreen,
        height: 1.5,
      ),
    ),
  );
}

Widget _buildComparisonColumn(
  String title,
  List<String> items,
  Color color,
  IconData icon,
) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(60), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\u2022 ', style: TextStyle(color: color, fontSize: 12)),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(color: _kSlate600, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTableRow(List<String> cells, {bool isHeader = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(
      color: isHeader ? _kSlate200 : Colors.white,
      border: Border(bottom: BorderSide(color: _kSlate300, width: 1)),
    ),
    child: Row(
      children: cells.map(
        (cell) => Expanded(
          child: Text(
            cell,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? _kSlate800 : _kSlate600,
            ),
          ),
        ),
      ).toList(),
    ),
  );
}

Widget _buildPatternCard(
  String title,
  String description,
  String example,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withAlpha(12), color.withAlpha(30)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(50), width: 1),
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
              child: Icon(icon, color: color, size: 22),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(color: _kSlate600, fontSize: 13, height: 1.4),
        ),
        SizedBox(height: 12),
        _buildCodeBlock(example),
      ],
    ),
  );
}

Widget _buildHitTestBehaviorCard(
  String name,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(color: _kSlate600, fontSize: 12, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildArrowConnector(Color color) {
  return SizedBox(
    height: 30,
    child: Column(
      children: [
        Container(width: 2, height: 18, color: color.withAlpha(120)),
        Icon(Icons.arrow_drop_down, color: color, size: 16),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  print('--- Section 1: RenderAndroidView Overview ---');
  print('RenderAndroidView is the render object for AndroidView widget');
  print('It embeds native Android views in the Flutter widget tree');
  print('Uses platform channels to communicate with native Android layer');
  print('Each platform view has a unique viewId for identification');
  print('Flutter composes native views using TextureLayer or PlatformViewLayer');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '1. RenderAndroidView Overview',
        Icons.phone_android,
        _kPrimary700,
      ),
      _buildInfoCard(
        'What is RenderAndroidView?',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RenderAndroidView is Flutter\'s render object responsible for '
              'embedding native Android views (platform views) into the '
              'Flutter rendering pipeline. It bridges the gap between '
              'Flutter\'s Skia-based rendering and Android\'s native '
              'View system.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.5),
            ),
            SizedBox(height: 16),
            _buildInfoRow('Widget', 'AndroidView'),
            _buildInfoRow('Render Object', 'RenderAndroidView'),
            _buildInfoRow('Parent Class', 'RenderBox'),
            _buildInfoRow('Platform', 'Android only'),
            _buildInfoRow('View ID', 'Unique int per native view'),
            _buildInfoRow('Composition', 'TextureLayer / PlatformViewLayer'),
          ],
        ),
        accentColor: _kPrimary600,
      ),
      _buildInfoCard(
        'Type Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeBlock(
              'RenderObject\n'
              '  \u2514\u2500 RenderBox\n'
              '       \u2514\u2500 PlatformViewRenderBox\n'
              '            \u2514\u2500 RenderAndroidView\n'
              '\n'
              'Key Mixins:\n'
              '  - _PlatformViewGestureMixin\n'
              '  - RenderObjectWithChildMixin<RenderBox>',
            ),
            SizedBox(height: 12),
            Text(
              'RenderAndroidView inherits from PlatformViewRenderBox '
              'which provides the common platform view rendering '
              'infrastructure shared with RenderUiKitView on iOS.',
              style: TextStyle(color: _kSlate600, fontSize: 12, height: 1.4),
            ),
          ],
        ),
        accentColor: _kAndroidDark,
      ),
      _buildInfoCard(
        'AndroidView Widget Usage',
        _buildCodeBlock(
          'AndroidView(\n'
          '  viewType: "my-native-view",\n'
          '  onPlatformViewCreated: (int viewId) {\n'
          '    print("Native view created: \$viewId");\n'
          '  },\n'
          '  creationParams: <String, dynamic>{\n'
          '    "apiKey": "your-api-key",\n'
          '    "darkMode": true,\n'
          '  },\n'
          '  creationParamsCodec: StandardMessageCodec(),\n'
          '  gestureRecognizers: <Factory<\n'
          '      OneSequenceGestureRecognizer>>{\n'
          '    Factory<PanGestureRecognizer>(\n'
          '      () => PanGestureRecognizer(),\n'
          '    ),\n'
          '  },\n'
          ')',
        ),
        accentColor: _kSecondary600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: PLATFORM VIEW ARCHITECTURE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildArchitectureSection() {
  print('--- Section 2: Platform View Architecture ---');
  print('Flutter Layer -> Platform View Layer -> Android SurfaceView');
  print('Three main layers in the platform view compositing stack');
  print('Communication flows through platform channels');
  print('TextureLayer for Virtual Display, PlatformViewLayer for Hybrid');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '2. Platform View Architecture',
        Icons.layers,
        _kSecondary700,
      ),
      _buildInfoCard(
        'Compositing Stack Visualization',
        Column(
          children: [
            _buildArchitectureLayerRow(
              'Flutter Widget Tree',
              'AndroidView widget, BoxConstraints, gesture handling',
              Icons.widgets,
              _kSecondary600,
            ),
            _buildArrowConnector(_kSecondary600),
            _buildArchitectureLayerRow(
              'RenderAndroidView',
              'Render object: layout, paint, hit test, compositing',
              Icons.account_tree,
              _kPrimary700,
            ),
            _buildArrowConnector(_kPrimary700),
            _buildArchitectureLayerRow(
              'Platform View Layer',
              'TextureLayer (Virtual Display) or PlatformViewLayer (Hybrid)',
              Icons.view_in_ar,
              _kTertiary600,
            ),
            _buildArrowConnector(_kTertiary600),
            _buildArchitectureLayerRow(
              'Platform Channel',
              'MethodChannel communication with native Android code',
              Icons.swap_horiz,
              _kWarning600,
            ),
            _buildArrowConnector(_kWarning600),
            _buildArchitectureLayerRow(
              'Android SurfaceView',
              'Native Android View rendered by the Android framework',
              Icons.phone_android,
              _kAndroidDark,
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Internal Communication Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableRow(['Step', 'Component', 'Action'], isHeader: true),
            _buildTableRow(['1', 'AndroidView', 'Widget created in tree']),
            _buildTableRow(['2', 'Framework', 'Creates render object']),
            _buildTableRow(['3', 'RenderAndroidView', 'Receives constraints']),
            _buildTableRow(['4', 'Platform Channel', 'Sends size to native']),
            _buildTableRow(['5', 'Android Runtime', 'Creates SurfaceView']),
            _buildTableRow(['6', 'Compositor', 'Composites native texture']),
            _buildTableRow(['7', 'Skia Engine', 'Renders final frame']),
          ],
        ),
        accentColor: _kTertiary600,
      ),
      _buildInfoCard(
        'View ID System',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Every native platform view gets a unique integer viewId '
              'that identifies it throughout its lifecycle. This ID is '
              'used for all communication between Flutter and the '
              'native Android view.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 14),
            _buildInfoRow('Generation', 'Auto-incremented integer'),
            _buildInfoRow('Scope', 'Unique per Flutter engine instance'),
            _buildInfoRow('Lifecycle', 'Created once, destroyed with view'),
            _buildInfoRow('Usage', 'Platform channel message routing'),
            SizedBox(height: 12),
            _buildCodeBlock(
              'onPlatformViewCreated: (int viewId) {\n'
              '  // viewId is unique across all\n'
              '  // platform views in this engine\n'
              '  print("View ID: \$viewId");\n'
              '  // Use viewId to send messages\n'
              '  // to this specific native view\n'
              '}',
            ),
          ],
        ),
        accentColor: _kPrimary700,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: HIT TESTING AND GESTURE RECOGNITION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHitTestSection() {
  print('--- Section 3: Hit Testing and Gesture Recognition ---');
  print('PlatformViewHitTestBehavior controls gesture forwarding');
  print('Three modes: opaque, translucent, transparent');
  print('gestureRecognizers specify which gestures the platform view handles');
  print('Hit test results determine event routing between Flutter and native');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '3. Hit Testing & Gesture Recognition',
        Icons.touch_app,
        _kAccent600,
      ),
      _buildInfoCard(
        'PlatformViewHitTestBehavior',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Controls how hit test events are dispatched between '
              'the Flutter framework and the native Android view. '
              'The behavior determines whether touches are forwarded '
              'to the platform view, Flutter widgets, or both.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 16),
            _buildHitTestBehaviorCard(
              'opaque',
              'The platform view absorbs all touch events. '
              'Flutter widgets behind it receive no events. '
              'Best for full-screen native views like maps or video.',
              Icons.block,
              _kAccent600,
            ),
            _buildHitTestBehaviorCard(
              'translucent',
              'Both the platform view and Flutter widgets can '
              'receive events. The hit test allows events through '
              'to widgets below. Good for overlapping content.',
              Icons.blur_on,
              _kSecondary600,
            ),
            _buildHitTestBehaviorCard(
              'transparent',
              'Events pass through to Flutter widgets below. '
              'The platform view does not participate in hit testing. '
              'Use for decorative or non-interactive native views.',
              Icons.visibility_off,
              _kSlate500,
            ),
          ],
        ),
        accentColor: _kAccent600,
      ),
      _buildInfoCard(
        'Gesture Recognizer Configuration',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'gestureRecognizers define which gesture types the platform '
              'view should claim. When gestures compete in the arena, '
              'recognizers listed here win over Flutter gesture detectors.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 14),
            _buildCodeBlock(
              'AndroidView(\n'
              '  viewType: "map-view",\n'
              '  gestureRecognizers: <Factory<\n'
              '      OneSequenceGestureRecognizer>>{\n'
              '    // Pan gestures go to native map\n'
              '    Factory<PanGestureRecognizer>(\n'
              '      () => PanGestureRecognizer(),\n'
              '    ),\n'
              '    // Scale gestures for pinch zoom\n'
              '    Factory<ScaleGestureRecognizer>(\n'
              '      () => ScaleGestureRecognizer(),\n'
              '    ),\n'
              '  },\n'
              ')',
            ),
            SizedBox(height: 14),
            _buildTableRow(
              ['Recognizer', 'Gesture', 'Use Case'],
              isHeader: true,
            ),
            _buildTableRow([
              'PanGestureRecognizer',
              'Drag/Pan',
              'Map panning',
            ]),
            _buildTableRow([
              'ScaleGestureRecognizer',
              'Pinch',
              'Map zoom',
            ]),
            _buildTableRow([
              'TapGestureRecognizer',
              'Tap',
              'Button clicks',
            ]),
            _buildTableRow([
              'LongPressGestureRecognizer',
              'Long press',
              'Context menus',
            ]),
            _buildTableRow([
              'VerticalDragGestureRecognizer',
              'V-Drag',
              'Native scroll',
            ]),
            _buildTableRow([
              'HorizontalDragGestureRecognizer',
              'H-Drag',
              'Horizontal lists',
            ]),
          ],
        ),
        accentColor: _kTertiary600,
      ),
      _buildInfoCard(
        'Gesture Arena Resolution',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'When a touch event occurs over a platform view, the '
              'gesture arena determines who wins the gesture:',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 12),
            _buildArchitectureLayerRow(
              'Touch Event Arrives',
              'PointerDownEvent hits the RenderAndroidView',
              Icons.touch_app,
              _kAccent600,
            ),
            _buildArchitectureLayerRow(
              'Hit Test Evaluation',
              'PlatformViewHitTestBehavior checked',
              Icons.search,
              _kSecondary600,
            ),
            _buildArchitectureLayerRow(
              'Arena Entry',
              'Both Flutter and native recognizers enter the arena',
              Icons.sports_mma,
              _kWarning600,
            ),
            _buildArchitectureLayerRow(
              'Resolution',
              'gestureRecognizers list determines priority',
              Icons.check_circle,
              _kPrimary600,
            ),
          ],
        ),
        accentColor: _kWarning600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: SIZING AND LAYOUT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSizingSection() {
  print('--- Section 4: Sizing and Layout ---');
  print('RenderAndroidView receives BoxConstraints from parent');
  print('Typically fills all available space unless constrained');
  print('Size communicated to native via platform channel');
  print('Native view resized to match Flutter constraints');
  print('Layout protocol follows standard RenderBox contract');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '4. Sizing & Layout',
        Icons.aspect_ratio,
        _kTertiary600,
      ),
      _buildInfoCard(
        'Constraint Forwarding',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RenderAndroidView follows the standard RenderBox layout '
              'protocol. Parent widgets provide BoxConstraints, and the '
              'render object determines its size within those constraints. '
              'The resulting size is then communicated to the native '
              'Android view via platform channels.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 16),
            _buildTableRow(
              ['Phase', 'Action', 'Owner'],
              isHeader: true,
            ),
            _buildTableRow([
              'performLayout()',
              'Receives constraints',
              'Flutter Framework',
            ]),
            _buildTableRow([
              'Size calculation',
              'Picks size within constraints',
              'RenderAndroidView',
            ]),
            _buildTableRow([
              'Size propagation',
              'Sends size to native via channel',
              'Platform Channel',
            ]),
            _buildTableRow([
              'Native resize',
              'Android view resized to match',
              'Android Framework',
            ]),
            _buildTableRow([
              'Texture update',
              'New frame at updated size',
              'Compositor',
            ]),
          ],
        ),
        accentColor: _kTertiary600,
      ),
      _buildInfoCard(
        'Layout Best Practices',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              'Fixed size',
              'Wrap in SizedBox to control dimensions',
            ),
            _buildInfoRow(
              'Aspect ratio',
              'Use AspectRatio widget for proportional sizing',
            ),
            _buildInfoRow(
              'Flexible',
              'Place in Expanded or Flexible for responsive sizing',
            ),
            _buildInfoRow(
              'Max size',
              'Use ConstrainedBox with maxWidth / maxHeight',
            ),
            SizedBox(height: 14),
            _buildCodeBlock(
              '// Fixed size platform view\n'
              'SizedBox(\n'
              '  width: 300,\n'
              '  height: 200,\n'
              '  child: AndroidView(\n'
              '    viewType: "map-view",\n'
              '  ),\n'
              ')\n'
              '\n'
              '// Responsive platform view\n'
              'Expanded(\n'
              '  child: AndroidView(\n'
              '    viewType: "video-player",\n'
              '  ),\n'
              ')',
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Size Change Handling',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'When the Flutter layout changes (e.g., orientation change, '
              'keyboard appearing), the render object receives new '
              'constraints. It recalculates its size and notifies the '
              'native view to resize accordingly.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kWarning500.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kWarning500.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: _kWarning600, size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Frequent size changes can cause performance issues '
                      'as each resize requires native view recreation or '
                      'texture reallocation.',
                      style: TextStyle(
                        color: _kWarning700,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kWarning600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: COMPOSITION MODES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCompositionSection() {
  print('--- Section 5: Composition Modes ---');
  print('Hybrid Composition: native view in the Flutter view hierarchy');
  print('Virtual Display: renders native view to a texture');
  print('Hybrid Composition has better compatibility but lower performance');
  print('Virtual Display has better performance but some input issues');
  print('initAndroidView() for Virtual Display, initSurfaceAndroidView() for Hybrid');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '5. Composition Modes',
        Icons.compare,
        _kWarning600,
      ),
      _buildInfoCard(
        'Two Composition Strategies',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter offers two distinct approaches for compositing '
              'native Android views. Each has different trade-offs '
              'regarding performance, compatibility, and behavior.',
              style: TextStyle(color: _kSlate700, fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComparisonColumn(
                  'Hybrid Composition',
                  [
                    'Native view in FlutterView hierarchy',
                    'Better input handling',
                    'Supports accessibility',
                    'Higher memory usage',
                    'Some UI thread overhead',
                    'Best for interactive views',
                    'Uses PlatformViewLayer',
                    'initSurfaceAndroidView()',
                  ],
                  _kSecondary600,
                  Icons.merge_type,
                ),
                SizedBox(width: 12),
                _buildComparisonColumn(
                  'Virtual Display',
                  [
                    'Renders to off-screen texture',
                    'Better scrolling performance',
                    'Lower memory footprint',
                    'Some input quirks',
                    'Text input issues possible',
                    'Best for static content',
                    'Uses TextureLayer',
                    'initAndroidView()',
                  ],
                  _kTertiary600,
                  Icons.tv,
                ),
              ],
            ),
          ],
        ),
        accentColor: _kWarning600,
      ),
      _buildInfoCard(
        'Hybrid Composition Details',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArchitectureLayerRow(
              'Flutter View',
              'FlutterView hosts the entire Flutter UI',
              Icons.layers,
              _kSecondary500,
            ),
            _buildArchitectureLayerRow(
              'Platform View',
              'Native Android View added as child of FlutterView',
              Icons.phone_android,
              _kPrimary600,
            ),
            _buildArchitectureLayerRow(
              'Synchronization',
              'Flutter compositor synchronizes draw order',
              Icons.sync,
              _kWarning600,
            ),
            SizedBox(height: 12),
            _buildCodeBlock(
              '// Hybrid composition (recommended)\n'
              '// Uses initSurfaceAndroidView\n'
              'AndroidView(\n'
              '  viewType: "plugins.example/view",\n'
              '  // Hybrid is the default mode\n'
              '  // since Flutter 3.0\n'
              ')',
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Virtual Display Details',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArchitectureLayerRow(
              'Virtual Display',
              'Off-screen Android Display renders the native view',
              Icons.desktop_windows,
              _kTertiary500,
            ),
            _buildArchitectureLayerRow(
              'Texture Capture',
              'Frame buffer captured as a texture',
              Icons.photo_library,
              _kAccent600,
            ),
            _buildArchitectureLayerRow(
              'Flutter Compositing',
              'Texture composited into Flutter scene',
              Icons.image,
              _kPrimary600,
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kAccent500.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kAccent500.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: _kAccent600, size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Virtual Display mode can cause issues with text '
                      'input fields, accessibility services, and some '
                      'keyboard interactions on older Android versions.',
                      style: TextStyle(
                        color: _kAccent700,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kTertiary600,
      ),
      _buildInfoCard(
        'Comparison Table',
        Column(
          children: [
            _buildTableRow(
              ['Feature', 'Hybrid', 'Virtual Display'],
              isHeader: true,
            ),
            _buildTableRow(['Performance', 'Good', 'Better']),
            _buildTableRow(['Memory', 'Higher', 'Lower']),
            _buildTableRow(['Input handling', 'Excellent', 'Good']),
            _buildTableRow(['Accessibility', 'Full', 'Limited']),
            _buildTableRow(['Text input', 'Reliable', 'Quirky']),
            _buildTableRow(['Scroll perf', 'Medium', 'High']),
            _buildTableRow(['API level req', '19+', '20+']),
            _buildTableRow(['Default since', 'Flutter 3.0', 'Legacy']),
          ],
        ),
        accentColor: _kAndroidDark,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: COMMON PATTERNS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCommonPatternsSection() {
  print('--- Section 6: Common Patterns ---');
  print('Google Maps: most common platform view use case');
  print('WebView: embedding web content in Flutter');
  print('Camera preview: live camera feed in Flutter');
  print('Ad views: third-party ad SDK integration');
  print('Video player: native video playback');
  print('Custom native views: any Android View subclass');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '6. Common Patterns',
        Icons.pattern,
        _kPrimary800,
      ),
      _buildPatternCard(
        'Google Maps Integration',
        'The most common platform view use case. GoogleMap widget '
        'internally uses AndroidView to render the native Google Maps '
        'SDK. Requires gesture recognizers for pan and zoom.',
        'GoogleMap(\n'
        '  initialCameraPosition:\n'
        '    CameraPosition(\n'
        '      target: LatLng(37.42, -122.08),\n'
        '      zoom: 14.0,\n'
        '    ),\n'
        '  onMapCreated: (controller) {\n'
        '    print("Map ready");\n'
        '  },\n'
        '  // Internally uses AndroidView\n'
        '  // with pan + scale recognizers\n'
        ')',
        Icons.map,
        _kPrimary700,
      ),
      _buildPatternCard(
        'WebView Embedding',
        'WebView plugins use platform views to embed a native Android '
        'WebView. Supports JavaScript interaction, navigation callbacks, '
        'and cookie management through platform channels.',
        'WebViewWidget(\n'
        '  controller: WebViewController()\n'
        '    ..setJavaScriptMode(\n'
        '        JavaScriptMode.unrestricted)\n'
        '    ..loadRequest(\n'
        '        Uri.parse("https://flutter.dev")),\n'
        '  // Uses AndroidView internally\n'
        '  // with custom gesture handling\n'
        ')',
        Icons.language,
        _kSecondary600,
      ),
      _buildPatternCard(
        'Camera Preview Surface',
        'Camera plugins render the live camera preview using a platform '
        'view. The native CameraX or Camera2 API renders to a '
        'SurfaceView that Flutter composites into the widget tree.',
        'CameraPreview(\n'
        '  controller: cameraController,\n'
        '  // Native TextureView or\n'
        '  // SurfaceView underneath\n'
        '  // Platform view handles\n'
        '  // orientation and aspect ratio\n'
        ')',
        Icons.camera_alt,
        _kAccent600,
      ),
      _buildPatternCard(
        'Ad Views',
        'Mobile ad SDKs (Google AdMob, Facebook Ads) use platform views '
        'to display native ads. The ad content is rendered in a native '
        'view and composited into Flutter layout.',
        'SizedBox(\n'
        '  width: double.infinity,\n'
        '  height: 250,\n'
        '  child: AndroidView(\n'
        '    viewType: "ad-banner-view",\n'
        '    creationParams: {\n'
        '      "adUnitId": "ca-app-pub-xxx",\n'
        '      "adSize": "MEDIUM_RECTANGLE",\n'
        '    },\n'
        '    creationParamsCodec:\n'
        '      StandardMessageCodec(),\n'
        '  ),\n'
        ')',
        Icons.ad_units,
        _kWarning600,
      ),
      _buildPatternCard(
        'Custom Native View Registration',
        'Register a custom Android View as a platform view type. '
        'The native side creates the View instance, and Flutter '
        'embeds it using AndroidView with the registered type.',
        '// Android side (Kotlin):\n'
        '// class MyViewFactory :\n'
        '//   PlatformViewFactory(\n'
        '//     StandardMessageCodec()) {\n'
        '//   override fun create(\n'
        '//     ctx: Context,\n'
        '//     viewId: Int,\n'
        '//     args: Any?\n'
        '//   ): PlatformView {\n'
        '//     return MyView(ctx, viewId, args)\n'
        '//   }\n'
        '// }\n'
        '\n'
        '// Flutter side:\n'
        'AndroidView(\n'
        '  viewType: "my-custom-view",\n'
        ')',
        Icons.extension,
        _kTertiary600,
      ),
      _buildInfoCard(
        'Performance Tips',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              'Limit count',
              'Avoid more than 2-3 platform views per screen',
              valueColor: _kAccent600,
            ),
            _buildInfoRow(
              'Clip behavior',
              'Set clipBehavior carefully, clipping is expensive',
              valueColor: _kAccent600,
            ),
            _buildInfoRow(
              'Size stability',
              'Avoid frequent size changes to prevent re-creation',
              valueColor: _kAccent600,
            ),
            _buildInfoRow(
              'Caching',
              'Keep controllers alive when views go off-screen',
              valueColor: _kAccent600,
            ),
            _buildInfoRow(
              'Lazy creation',
              'Use platform views only when actually needed',
              valueColor: _kAccent600,
            ),
            _buildInfoRow(
              'Test on device',
              'Emulator performance differs from real devices',
              valueColor: _kAccent600,
            ),
          ],
        ),
        accentColor: _kPrimary800,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('RenderAndroidView deep demo executing');
  print('=' * 60);
  print('Topic: Native Android platform view rendering in Flutter');
  print('Render Object: RenderAndroidView');
  print('Widget: AndroidView');
  print('Platform: Android only');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _kSlate100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainHeader(),
            SizedBox(height: 24),
            _buildOverviewSection(),
            SizedBox(height: 24),
            _buildArchitectureSection(),
            SizedBox(height: 24),
            _buildHitTestSection(),
            SizedBox(height: 24),
            _buildSizingSection(),
            SizedBox(height: 24),
            _buildCompositionSection(),
            SizedBox(height: 24),
            _buildCommonPatternsSection(),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kAndroidDark, _kPrimary800],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: _kAndroidGreen, size: 40),
                  SizedBox(height: 12),
                  Text(
                    'RenderAndroidView Deep Demo Complete',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Platform view embedding for native Android integration',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
