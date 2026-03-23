// D4rt test script: Deep demo for PlatformViewRenderBox from rendering
//
// PlatformViewRenderBox is the render object responsible for embedding
// native platform views (Android, iOS, web) within Flutter's rendering
// pipeline. It bridges the gap between Flutter's compositing layer and
// the host platform's native view hierarchy.
//
// Key responsibilities:
//   - Sizes and lays out the platform view within Flutter constraints
//   - Manages hit testing to route touch events correctly
//   - Handles gesture disambiguation between Flutter and native
//   - Coordinates input events (pointer, keyboard) with the platform
//   - Composites visual overlay layers above the native content
//   - Integrates with the platform view lifecycle
//
// Related classes:
//   - PlatformViewSurface: Widget wrapper for platform views
//   - AndroidView / UiKitView: Platform-specific view widgets
//   - PlatformViewController: Controls the native view lifecycle
//   - PlatformViewHitTestBehavior: Enum for hit test modes
//   - RenderBox: Base class that PlatformViewRenderBox extends
//
// Use cases:
//   - Embedding Google Maps in Flutter
//   - Hosting native ad views
//   - Displaying WebView content
//   - Integrating camera preview surfaces

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF00695C).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.view_in_ar, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF00695C), size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00695C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF00695C),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF00796B),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(
  String label,
  Color color, {
  IconData? icon,
  double width = 110,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: color, size: 18),
        if (icon != null) SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrow({bool vertical = false, Color? color}) {
  Color arrowColor = color ?? Colors.grey;
  if (vertical) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 18, color: arrowColor),
        Icon(Icons.arrow_drop_down, color: arrowColor, size: 20),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 18, height: 2, color: arrowColor),
      Icon(Icons.arrow_right, color: arrowColor, size: 20),
    ],
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
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
        height: 1.5,
      ),
    ),
  );
}

Widget _buildChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: PLATFORM VIEW RENDER BOX OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('PlatformViewRenderBox Overview', Icons.widgets),
        Text(
          'PlatformViewRenderBox is the render object that integrates native '
          'platform views into the Flutter rendering pipeline. It extends '
          'RenderBox and manages sizing, painting, hit testing, and gesture '
          'forwarding for embedded native content.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Extends', 'RenderBox'),
        _buildInfoRow('Mixin', '_PlatformViewGestureMixin'),
        _buildInfoRow('Package', 'flutter/rendering.dart'),
        _buildInfoRow('Layer Type', 'PlatformViewLayer'),
        _buildInfoRow('Paint Mode', 'Composited (offscreen)'),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip('RenderBox', Color(0xFF00695C)),
            _buildChip('Composited', Color(0xFF1565C0)),
            _buildChip('Platform Layer', Color(0xFF6A1B9A)),
            _buildChip('Hit Testable', Color(0xFFC62828)),
            _buildChip('Gesture Aware', Color(0xFFE65100)),
          ],
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              _buildDiagramBox(
                'Flutter Widget Tree',
                Color(0xFF1565C0),
                icon: Icons.account_tree,
                width: 180,
              ),
              _buildArrow(vertical: true, color: Color(0xFF1565C0)),
              _buildDiagramBox(
                'PlatformViewRenderBox',
                Color(0xFF00695C),
                icon: Icons.view_in_ar,
                width: 180,
              ),
              _buildArrow(vertical: true, color: Color(0xFF00695C)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox(
                    'Platform\nView Layer',
                    Color(0xFF6A1B9A),
                    icon: Icons.layers,
                  ),
                  SizedBox(width: 12),
                  _buildDiagramBox(
                    'Native\nView Host',
                    Color(0xFFC62828),
                    icon: Icons.phone_android,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: SIZING AND LAYOUT BEHAVIOR
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSizingLayoutSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Sizing & Layout Behavior', Icons.aspect_ratio),
        Text(
          'PlatformViewRenderBox uses tight constraints by default to fill '
          'the available space. The native view is sized to match the render '
          'box dimensions exactly, ensuring pixel-perfect alignment between '
          'the Flutter compositing layer and the native view surface.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
        SizedBox(height: 12),
        _buildInfoRow('sizedByParent', 'false (measures child)'),
        _buildInfoRow('performLayout', 'Sizes to constraints.biggest'),
        _buildInfoRow('Min intrinsic width', '0.0'),
        _buildInfoRow('Max intrinsic width', 'constraints.maxWidth'),
        _buildInfoRow('Min intrinsic height', '0.0'),
        _buildInfoRow('Max intrinsic height', 'constraints.maxHeight'),
        SizedBox(height: 12),
        _buildCodeBlock(
          'void performLayout() {\n'
          '  // Platform view render box fills available space\n'
          '  size = constraints.biggest;\n'
          '  // Notify the platform controller of the new size\n'
          '  _controller.updateSize(size);\n'
          '}',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFB74D), width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFF57C00), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The render box always takes the biggest size allowed '
                  'by constraints. Use SizedBox or ConstrainedBox to limit '
                  'the platform view dimensions.',
                  style: TextStyle(fontSize: 12, color: Color(0xFFF57C00)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLayoutModeCard('Tight', 'Fills exact size', Icons.crop_square),
            _buildLayoutModeCard('Bounded', 'Takes max size', Icons.open_in_full),
            _buildLayoutModeCard('Unbounded', 'Zero size fallback', Icons.close_fullscreen),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLayoutModeCard(String title, String desc, IconData icon) {
  return Container(
    width: 95,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFF80CBC4), width: 1),
    ),
    child: Column(
      children: [
        Icon(icon, color: Color(0xFF00695C), size: 22),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
        SizedBox(height: 2),
        Text(
          desc,
          style: TextStyle(fontSize: 10, color: Color(0xFF00796B)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: HIT TESTING
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHitTestingSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Hit Testing', Icons.touch_app),
        Text(
          'Hit testing for platform views determines whether touch events '
          'are routed to the native view, to Flutter widgets, or to both. '
          'The PlatformViewHitTestBehavior enum controls this routing with '
          'three modes: opaque, translucent, and transparent.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
        SizedBox(height: 12),
        _buildHitTestModeRow(
          'Opaque',
          'Native view absorbs all hits. Flutter widgets behind cannot '
          'receive events.',
          Color(0xFFC62828),
          Icons.block,
        ),
        SizedBox(height: 8),
        _buildHitTestModeRow(
          'Translucent',
          'Both native view and Flutter widgets behind receive events. '
          'Used for overlay scenarios.',
          Color(0xFFE65100),
          Icons.blur_on,
        ),
        SizedBox(height: 8),
        _buildHitTestModeRow(
          'Transparent',
          'Native view ignores all hits. Only Flutter widgets receive '
          'touch events.',
          Color(0xFF1565C0),
          Icons.visibility_off,
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          'bool hitTestSelf(Offset position) {\n'
          '  switch (hitTestBehavior) {\n'
          '    case PlatformViewHitTestBehavior.opaque:\n'
          '      return true;\n'
          '    case PlatformViewHitTestBehavior.translucent:\n'
          '      return true;\n'
          '    case PlatformViewHitTestBehavior.transparent:\n'
          '      return false;\n'
          '  }\n'
          '}',
        ),
        SizedBox(height: 12),
        Center(
          child: Column(
            children: [
              _buildDiagramBox(
                'Touch Event',
                Color(0xFFC62828),
                icon: Icons.touch_app,
                width: 140,
              ),
              _buildArrow(vertical: true, color: Color(0xFFC62828)),
              _buildDiagramBox(
                'hitTestSelf()',
                Color(0xFF00695C),
                icon: Icons.filter_tilt_shift,
                width: 140,
              ),
              _buildArrow(vertical: true, color: Color(0xFF00695C)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox(
                    'Native\nHandler',
                    Color(0xFF6A1B9A),
                    icon: Icons.phone_android,
                  ),
                  SizedBox(width: 16),
                  _buildDiagramBox(
                    'Flutter\nHandler',
                    Color(0xFF1565C0),
                    icon: Icons.flutter_dash,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHitTestModeRow(
  String mode,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60), width: 1),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mode,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: GESTURE RECOGNITION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildGestureRecognitionSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Gesture Recognition', Icons.gesture),
        Text(
          'PlatformViewRenderBox participates in Flutter gesture disambiguation '
          'through the _PlatformViewGestureMixin. Gesture recognizers attached '
          'to the render box compete in the gesture arena alongside native '
          'gesture handlers from the platform view.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Gesture Mixin', '_PlatformViewGestureMixin'),
        _buildInfoRow('Arena Entry', 'Auto-registered on pointer down'),
        _buildInfoRow('Disambiguation', 'Platform vs Flutter arbitration'),
        _buildInfoRow('Forwarding', 'Events relayed to controller'),
        SizedBox(height: 12),
        _buildCodeBlock(
          '// Gesture arena participation\n'
          'void handleEvent(PointerEvent event, ...) {\n'
          '  if (event is PointerDownEvent) {\n'
          '    _gestureRecognizer.addPointer(event);\n'
          '  }\n'
          '}',
        ),
        SizedBox(height: 12),
        _buildGestureFlowDiagram(),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFCE93D8), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gesture Arena Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 6),
              _buildGestureStep('1', 'PointerDown arrives at render box'),
              _buildGestureStep('2', 'Recognizer joins gesture arena'),
              _buildGestureStep('3', 'Arena resolves winner'),
              _buildGestureStep('4', 'Winner receives subsequent events'),
              _buildGestureStep('5', 'Loser releases pointer claim'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildGestureFlowDiagram() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDiagramBox(
          'Pointer\nDown',
          Color(0xFFC62828),
          icon: Icons.touch_app,
        ),
        _buildArrow(color: Color(0xFFC62828)),
        _buildDiagramBox(
          'Gesture\nArena',
          Color(0xFFE65100),
          icon: Icons.sports_martial_arts,
        ),
        _buildArrow(color: Color(0xFFE65100)),
        _buildDiagramBox(
          'Winner\nClaimed',
          Color(0xFF2E7D32),
          icon: Icons.emoji_events,
        ),
      ],
    ),
  );
}

Widget _buildGestureStep(String number, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(0xFF6A1B9A),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Color(0xFF4A148C)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: INPUT HANDLING
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildInputHandlingSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Input Handling', Icons.keyboard),
        Text(
          'PlatformViewRenderBox coordinates multiple input channels between '
          'Flutter and the native platform view. Pointer events, keyboard '
          'input, and focus management all flow through the render box to '
          'ensure seamless integration with the host platform.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
        SizedBox(height: 12),
        _buildInputChannelCard(
          'Pointer Events',
          'Touch, mouse, and stylus events are intercepted and forwarded '
          'to the platform view controller based on hit test behavior.',
          Icons.mouse,
          Color(0xFFC62828),
        ),
        SizedBox(height: 8),
        _buildInputChannelCard(
          'Keyboard Input',
          'Key events are routed through the platform channel to the native '
          'view when it holds focus, enabling text input in native fields.',
          Icons.keyboard,
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8),
        _buildInputChannelCard(
          'Focus Management',
          'Focus transitions between Flutter and the native view are '
          'coordinated to ensure only one input target is active.',
          Icons.center_focus_strong,
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8),
        _buildInputChannelCard(
          'Accessibility Events',
          'Semantics actions from accessibility services are translated '
          'and forwarded to the native view accessibility tree.',
          Icons.accessibility_new,
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Input event forwarding\n'
          'void _handlePointerEvent(PointerEvent event) {\n'
          '  if (event is PointerDownEvent) {\n'
          '    _controller.dispatchPointerEvent(event);\n'
          '  } else if (event is PointerMoveEvent) {\n'
          '    _controller.dispatchPointerEvent(event);\n'
          '  } else if (event is PointerUpEvent) {\n'
          '    _controller.dispatchPointerEvent(event);\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}

Widget _buildInputChannelCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(50), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: VISUAL OVERLAY COMPOSITION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVisualOverlaySection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Visual Overlay Composition', Icons.layers),
        Text(
          'PlatformViewRenderBox composes visual overlays above the native '
          'content using Flutter compositing layers. This enables Flutter '
          'widgets to render on top of native views seamlessly, handling '
          'clipping, transforms, and opacity correctly.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Paint method', 'Pushes PlatformViewLayer'),
        _buildInfoRow('Clipping', 'Respects ancestor clip layers'),
        _buildInfoRow('Transforms', 'Applies matrix transform chain'),
        _buildInfoRow('Opacity', 'Supported via OpacityLayer parent'),
        _buildInfoRow('Overlay widgets', 'Painted after platform layer'),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              _buildLayerStackItem('Flutter Overlay Widgets', Color(0xFF1565C0), 4),
              _buildLayerStackItem('Clip / Transform Layers', Color(0xFFE65100), 3),
              _buildLayerStackItem('PlatformViewLayer', Color(0xFF00695C), 2),
              _buildLayerStackItem('Native View Surface', Color(0xFF6A1B9A), 1),
              _buildLayerStackItem('Host Platform Window', Color(0xFF424242), 0),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          'void paint(PaintingContext context, Offset offset) {\n'
          '  context.addLayer(PlatformViewLayer(\n'
          '    rect: offset & size,\n'
          '    viewId: _controller.viewId,\n'
          '    hittable: hitTestBehavior !=\n'
          '        PlatformViewHitTestBehavior.transparent,\n'
          '  ));\n'
          '}',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF81C784), width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF2E7D32), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Flutter overlay widgets are painted after the platform layer, '
                  'allowing tooltips, dialogs, and floating UI to appear above '
                  'native content.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayerStackItem(String label, Color color, int zIndex) {
  return Container(
    width: 240 + (zIndex * 10).toDouble(),
    margin: EdgeInsets.symmetric(vertical: 2),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: color.withAlpha(20 + zIndex * 10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          'z:$zIndex',
          style: TextStyle(fontSize: 10, color: color.withAlpha(150)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Color(0xFF00695C),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('PlatformViewRenderBox Deep Demo'),
        backgroundColor: Color(0xFF00695C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(
              'PlatformViewRenderBox',
              'Render object for platform views embedded in Flutter',
            ),
            SizedBox(height: 20),
            _buildOverviewSection(),
            SizedBox(height: 16),
            _buildSizingLayoutSection(),
            SizedBox(height: 16),
            _buildHitTestingSection(),
            SizedBox(height: 16),
            _buildGestureRecognitionSection(),
            SizedBox(height: 16),
            _buildInputHandlingSection(),
            SizedBox(height: 16),
            _buildVisualOverlaySection(),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF00695C), size: 36),
                  SizedBox(height: 8),
                  Text(
                    'PlatformViewRenderBox Deep Demo Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF00695C),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sizing, hit testing, gestures, input, and overlay composition explored',
                    style: TextStyle(fontSize: 12, color: Color(0xFF00796B)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
