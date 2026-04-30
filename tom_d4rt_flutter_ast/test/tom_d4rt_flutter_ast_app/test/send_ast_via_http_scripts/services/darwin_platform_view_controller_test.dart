// ignore_for_file: avoid_print
// D4rt deep demo: DarwinPlatformViewController — hosting native iOS/macOS
// views inside Flutter's widget tree via platform view integration.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Plum / Orchid palette ───
  const Color plum = Color(0xFF8E4585);
  const Color orchid = Color(0xFFDA70D6);
  const Color deepPlum = Color(0xFF5C2D5E);
  const Color paleOrchid = Color(0xFFFAF0FA);
  const Color darkPlum = Color(0xFF3C1441);
  const Color lavender = Color(0xFFE6E6FA);
  const Color mauve = Color(0xFFE0B0FF);
  const Color fuchsia = Color(0xFFFF00FF);
  const Color mulberry = Color(0xFFC54B8C);
  const Color lilac = Color(0xFFC8A2C8);

  print('[dp] ===== DARWIN PLATFORM VIEW CONTROLLER DEEP DEMO =====');
  print('[dp] palette: $fuchsia');

  // ─── Local helpers ───

  Widget dpBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkPlum, deepPlum],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkPlum.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: plum,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: orchid, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget dpNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleOrchid,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lavender),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkPlum.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget dpCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: lavender.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: plum, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkPlum,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: deepPlum)),
          ),
        ],
      ),
    );
  }

  Widget dpCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lavender.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: darkPlum.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: plum.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkPlum)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget dpRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? plum.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: lavender.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkPlum : deepPlum)),
          );
        }).toList(),
      ),
    );
  }

  Widget dpFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkPlum : deepPlum,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.east, size: 12, color: orchid),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is DarwinPlatformViewController? ━━━━━━
  print('[dp-01] Section 1: What is DarwinPlatformViewController?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('01', 'What Is DarwinPlatformViewController?'),
      dpNote(
        'DarwinPlatformViewController is the base controller for hosting '
        'native Apple platform views (UIKit on iOS, AppKit on macOS) inside '
        'Flutter\'s widget tree. It extends PlatformViewController and provides '
        'the Darwin-specific lifecycle: creation, sizing, event forwarding, '
        'and disposal of native views on Apple platforms.',
      ),
      dpCard(
        'Class Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dpHierarchyItem(0, 'PlatformViewController', 'Abstract base', plum),
            _dpHierarchyItem(1, 'DarwinPlatformViewController', 'Apple base', deepPlum),
            _dpHierarchyItem(2, 'UiKitViewController', 'iOS (UIView)', mulberry),
            _dpHierarchyItem(2, 'AppKitViewController', 'macOS (NSView)', orchid),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: iOS vs macOS ━━━━━━
  print('[dp-02] Section 2: iOS vs macOS platform views');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('02', 'iOS vs macOS Platform Views'),
      dpNote(
        'iOS uses UIView through UiKitView/UiKitViewController, while macOS '
        'uses NSView through AppKitView/AppKitViewController. '
        'DarwinPlatformViewController unifies the shared logic for both.',
      ),
      dpCard(
        'Platform Comparison',
        Column(
          children: [
            dpRow(['Aspect', 'iOS', 'macOS'], isHeader: true),
            dpRow(['Native view', 'UIView', 'NSView']),
            dpRow(['Widget', 'UiKitView', 'AppKitView']),
            dpRow(['Controller', 'UiKitViewController', 'AppKitViewController']),
            dpRow(['Rendering', 'Texture / Hybrid', 'Texture']),
            dpRow(['Touch events', 'UIEvent forwarding', 'NSEvent forwarding']),
            dpRow(['Framework', 'UIKit', 'AppKit']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Creation params ━━━━━━
  print('[dp-03] Section 3: Creation parameters');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('03', 'Creation Parameters'),
      dpNote(
        'When creating a platform view, you supply a viewType string and '
        'optional creation params. The viewType is registered on the native '
        'side with a PlatformViewFactory. Creation params are serialized '
        'and sent to the native factory via a platform message codec.',
      ),
      dpCard(
        'Creation Parameter Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dpFlow(['Register factory', 'Build widget', 'Send params',
                'Create native view', 'Return texture ID']),
            const SizedBox(height: 12),
            dpCode('viewType', 'String identifier matching native factory'),
            dpCode('creationParams', 'Dynamic data sent to native factory'),
            dpCode('creationParamsCodec', 'MessageCodec for serialization'),
            dpCode('layoutDirection', 'TextDirection for native view'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Texture-based rendering ━━━━━━
  print('[dp-04] Section 4: Texture-based rendering');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('04', 'Texture-Based Rendering'),
      dpNote(
        'Platform views on Darwin use texture-based composition. The native '
        'view renders to a CALayer/IOSurface, which is shared with Flutter\'s '
        'compositor as a texture. This avoids placing native views in the '
        'actual view hierarchy on some render paths.',
      ),
      dpCard(
        'Rendering Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dpLayerBox('Flutter Compositor', 'Composites all layers', plum),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: _dpLayerBox('Flutter layers', 'Skia / Impeller', deepPlum),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _dpLayerBox('Texture layer', 'Native view snapshot', mulberry),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _dpLayerBox('Metal / CALayer', 'GPU-backed surface', darkPlum),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Hybrid composition ━━━━━━
  print('[dp-05] Section 5: Hybrid composition');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('05', 'Hybrid Composition (iOS)'),
      dpNote(
        'iOS also supports hybrid composition, which places the native UIView '
        'directly in the view hierarchy alongside Flutter content. This is '
        'needed when the native view requires real touch events (keyboard, '
        'gesture recognizers) or accessibility tree integration.',
      ),
      dpCard(
        'Texture vs Hybrid',
        Column(
          children: [
            dpRow(['Feature', 'Texture', 'Hybrid'], isHeader: true),
            dpRow(['Performance', 'Better', 'Thread sync overhead']),
            dpRow(['Touch events', 'Forwarded', 'Native UIKit']),
            dpRow(['Accessibility', 'Manual', 'Automatic']),
            dpRow(['Z-ordering', 'Limited', 'Full control']),
            dpRow(['Keyboard', 'Limited', 'Full native']),
            dpRow(['Platform', 'iOS + macOS', 'iOS only']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Event forwarding ━━━━━━
  print('[dp-06] Section 6: Event forwarding');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('06', 'Touch & Event Forwarding'),
      dpNote(
        'DarwinPlatformViewController handles forwarding touch/pointer events '
        'from Flutter to the native view. On iOS, PointerEvents are converted '
        'to UITouch events. On macOS, they become NSEvent mouse events.',
      ),
      dpCard(
        'Event Translation',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dpEventMap('PointerDown', 'touchesBegan / mouseDown', plum),
            _dpEventMap('PointerMove', 'touchesMoved / mouseDragged', deepPlum),
            _dpEventMap('PointerUp', 'touchesEnded / mouseUp', mulberry),
            _dpEventMap('PointerCancel', 'touchesCancelled / -', orchid),
            _dpEventMap('PointerScroll', '- / scrollWheel', lilac),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Disposal and lifecycle ━━━━━━
  print('[dp-07] Section 7: Lifecycle');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('07', 'View Lifecycle & Disposal'),
      dpNote(
        'The controller manages the full lifecycle: creation, resizing, event '
        'handling, and disposal. When Flutter disposes the widget, the '
        'controller sends a dispose message to destroy the native view and '
        'free GPU resources (textures, CALayers).',
      ),
      dpCard(
        'Lifecycle Stages',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dpLifecycleStep(1, 'Create', 'Factory receives params, creates native view', plum),
            _dpLifecycleStep(2, 'Size', 'View sized to match Flutter layout', deepPlum),
            _dpLifecycleStep(3, 'Render', 'Native content composited via texture', mulberry),
            _dpLifecycleStep(4, 'Events', 'Touch/pointer forwarded to native', orchid),
            _dpLifecycleStep(5, 'Resize', 'Size updates sent on layout change', lilac),
            _dpLifecycleStep(6, 'Dispose', 'Native view + texture destroyed', darkPlum),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Use case — Maps ━━━━━━
  print('[dp-08] Section 8: Maps');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('08', 'Use Case: Native Maps'),
      dpNote(
        'The most common platform view use case is embedding MKMapView (iOS) '
        'or MapKit (macOS). The native map provides smooth rendering, '
        'standard gestures, and full Apple Maps features.',
      ),
      dpCard(
        'Map Integration',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: lavender.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF90CAF9),
                      const Color(0xFF81C784),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  children: [
                    Center(child: Icon(Icons.map, size: 28,
                        color: Colors.white.withValues(alpha: 0.5))),
                    Positioned(left: 30, top: 20,
                      child: Icon(Icons.location_on, size: 18,
                          color: const Color(0xFFE53935))),
                    Positioned(right: 40, top: 30,
                      child: Icon(Icons.location_on, size: 18,
                          color: const Color(0xFF1565C0))),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              dpCode('viewType', '\'apple_maps\''),
              dpCode('creationParams', '{lat: 37.7749, lng: -122.4194, zoom: 12}'),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Use case — WebView ━━━━━━
  print('[dp-09] Section 9: WebView');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('09', 'Use Case: Native WebView'),
      dpNote(
        'WKWebView on iOS/macOS can be embedded as a platform view. This gives '
        'the full Safari rendering engine inside Flutter — for auth flows, '
        'content display, or web-based UI components.',
      ),
      dpCard(
        'WebView Platform View',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dpRow(['Feature', 'Value'], isHeader: true),
            dpRow(['iPhone WebView', 'WKWebView (UIKit)']),
            dpRow(['Mac WebView', 'WKWebView (AppKit)']),
            dpRow(['JavaScript', 'Full support']),
            dpRow(['Cookies', 'Shared with Safari']),
            dpRow(['Gestures', 'Scroll, pinch, tap']),
            dpRow(['Auth flows', 'OAuth/SSO supported']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Use case — Camera preview ━━━━━━
  print('[dp-10] Section 10: Camera');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('10', 'Use Case: Camera Preview'),
      dpNote(
        'AVCaptureVideoPreviewLayer displays the live camera feed. As a '
        'platform view, it integrates directly with Flutter\'s rendering '
        'pipeline for real-time video display without frame-by-frame copies.',
      ),
      dpCard(
        'Camera Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dpFlow(['AVCaptureSession', 'PreviewLayer', 'PlatformView',
                'Flutter texture', 'Screen']),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _dpMetricBox('Latency', '<16ms', plum)),
                const SizedBox(width: 6),
                Expanded(child: _dpMetricBox('FPS', '30/60', deepPlum)),
                const SizedBox(width: 6),
                Expanded(child: _dpMetricBox('Quality', 'Native', mulberry)),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Sizing and constraints ━━━━━━
  print('[dp-11] Section 11: Sizing');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('11', 'Sizing & Layout Constraints'),
      dpNote(
        'The native view is sized by Flutter\'s layout system. When the '
        'widget\'s size changes (e.g., orientation change), the controller '
        'sends a resize message to update the native view\'s frame.',
      ),
      dpCard(
        'Size Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dpCode('setSize(Size)', 'Called by framework on layout'),
            dpCode('acceptGesture()', 'Claim gesture ownership'),
            dpCode('rejectGesture()', 'Release gesture to parent'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: lavender.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Size constraints propagate:',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold,
                          color: darkPlum)),
                  Text('Flutter layout → setSize() → native frame update → re-render texture',
                      style: TextStyle(fontSize: 10, color: deepPlum)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Gesture disambiguation ━━━━━━
  print('[dp-12] Section 12: Gesture disambiguation');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('12', 'Gesture Disambiguation'),
      dpNote(
        'When a platform view and Flutter widgets both want a gesture, '
        'the gestureRecognizers parameter on UiKitView/AppKitView controls '
        'which gestures the platform view claims. This prevents conflicts '
        'between Flutter scrolling and native map panning, for example.',
      ),
      dpCard(
        'Disambiguation Modes',
        Column(
          children: [
            dpRow(['Mode', 'Behavior', 'Use Case'], isHeader: true),
            dpRow(['eager', 'Claims all gestures', 'Standalone map']),
            dpRow(['none', 'Claims nothing', 'Static display']),
            dpRow(['vertical drag', 'Claims vertical only', 'Scrollable map']),
            dpRow(['horizontal drag', 'Claims horizontal only', 'Carousel']),
            dpRow(['scale', 'Claims pinch', 'Zoomable view']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Performance ━━━━━━
  print('[dp-13] Section 13: Performance');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('13', 'Performance Considerations'),
      dpNote(
        'Platform views have performance costs: texture copy overhead, '
        'synchronization between Flutter and native render threads, and '
        'potential jank during resizing. Minimize the number of platform '
        'views and prefer Flutter alternatives when possible.',
      ),
      dpCard(
        'Performance Impact',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _dpMetricBox('1 view', 'Minimal', const Color(0xFF4CAF50))),
                const SizedBox(width: 6),
                Expanded(child: _dpMetricBox('2-3 views', 'Moderate', const Color(0xFFFFA726))),
                const SizedBox(width: 6),
                Expanded(child: _dpMetricBox('4+ views', 'Significant', const Color(0xFFE53935))),
              ],
            ),
            const SizedBox(height: 8),
            _dpPerfItem('Texture copy', 'Each frame syncs GPU surface', orchid),
            _dpPerfItem('Thread sync', 'Platform thread ↔ raster thread', plum),
            _dpPerfItem('Resize jank', 'Visible during orientation change', mulberry),
            _dpPerfItem('Memory', 'CALayer + IOSurface per view', deepPlum),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Error handling ━━━━━━
  print('[dp-14] Section 14: Error handling');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('14', 'Error Handling'),
      dpNote(
        'Platform view creation can fail: unregistered viewType, codec '
        'mismatch, or factory error. The controller reports these through '
        'PlatformException. Missing factories are the most common error.',
      ),
      dpCard(
        'Common Errors',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dpErrorItem('Unregistered viewType',
                'Factory not registered in AppDelegate / MainFlutterWindow', plum),
            _dpErrorItem('Codec mismatch',
                'creationParamsCodec differs from encoding on native side', deepPlum),
            _dpErrorItem('View creation failed',
                'Native factory threw exception during init', mulberry),
            _dpErrorItem('Disposal race',
                'Widget disposed while view still creating', orchid),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing ━━━━━━
  print('[dp-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('15', 'Testing Platform Views'),
      dpNote(
        'Widget tests can verify platform view creation using '
        'TestDefaultBinaryMessengerBinding to mock platform channels. '
        'Integration tests on real devices are needed for rendering and '
        'gesture verification.',
      ),
      dpCard(
        'Test Approaches',
        Column(
          children: [
            dpRow(['Test Type', 'Scope', 'Real Device?'], isHeader: true),
            dpRow(['Widget test', 'View creation + params', 'No (mocked)']),
            dpRow(['Integration', 'Full rendering + gestures', 'Yes']),
            dpRow(['Platform test', 'Native factory logic', 'Yes (XCTest)']),
            dpRow(['Golden test', 'Layout only (no native)', 'No']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[dp-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dpBanner('16', 'Summary Dashboard'),
      dpCard(
        'DarwinPlatformViewController — Complete',
        Column(
          children: [
            dpRow(['Topic', 'Section', 'Key Point'], isHeader: true),
            dpRow(['What', 'S01', 'Apple platform view base controller']),
            dpRow(['Platforms', 'S02', 'iOS (UIKit) + macOS (AppKit)']),
            dpRow(['Params', 'S03', 'viewType + creationParams + codec']),
            dpRow(['Texture', 'S04', 'CALayer/IOSurface GPU stream']),
            dpRow(['Hybrid', 'S05', 'iOS: native UIView in hierarchy']),
            dpRow(['Events', 'S06', 'Pointer → UITouch/NSEvent']),
            dpRow(['Lifecycle', 'S07', 'Create → size → render → dispose']),
            dpRow(['Maps', 'S08', 'MKMapView integration']),
            dpRow(['WebView', 'S09', 'WKWebView embedding']),
            dpRow(['Camera', 'S10', 'AVCapturePreviewLayer']),
            dpRow(['Sizing', 'S11', 'Flutter layout drives native frame']),
            dpRow(['Gestures', 'S12', 'gestureRecognizers disambiguation']),
            dpRow(['Perf', 'S13', 'Minimize views, watch texture cost']),
            dpRow(['Errors', 'S14', 'Unregistered type, codec mismatch']),
            dpRow(['Testing', 'S15', 'Mock channels + device tests']),
          ],
        ),
      ),
      dpCard(
        'Plum / Orchid Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _dpColorSwatch('Plum', plum),
            _dpColorSwatch('Orchid', orchid),
            _dpColorSwatch('Deep', deepPlum),
            _dpColorSwatch('Mauve', mauve),
            _dpColorSwatch('Dark', darkPlum),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkPlum, deepPlum],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('DarwinPlatformViewController — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From UIKit and AppKit view hosting through texture composition, '
              'hybrid rendering, gesture disambiguation, maps, WebView, camera '
              'integration, and performance optimization — Apple platform views.',
              style: TextStyle(color: lavender, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[dp] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DarwinPlatformView — Apple Views'),
        backgroundColor: darkPlum,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFAF5FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _dpHierarchyItem(int indent, String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        Text(name,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace')),
        const SizedBox(width: 6),
        Text(desc,
            style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _dpLayerBox(String name, String sub, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color)),
        Text(sub,
            style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _dpEventMap(String flutter, String native, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(flutter,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: color)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 12, color: color),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(native,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: color)),
          ),
        ),
      ],
    ),
  );
}

Widget _dpLifecycleStep(int num, String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF3C1441))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dpMetricBox(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color)),
        Text(label,
            style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Widget _dpPerfItem(String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(Icons.speed, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 9, color: Color(0xFF5C2D5E))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dpErrorItem(String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF5C2D5E))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dpColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
