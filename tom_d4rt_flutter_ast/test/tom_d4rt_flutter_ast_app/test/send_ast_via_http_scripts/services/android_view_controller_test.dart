// ignore_for_file: avoid_print
// D4rt deep demo: AndroidViewController & Platform Views
// Demonstrates how Flutter embeds native Android views — lifecycle, rendering
// modes, touch forwarding, sizing, and the full PlatformView architecture.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Terracotta / Clay palette ───
  const Color terracotta = Color(0xFFCC5533);
  const Color clay = Color(0xFFA0522D);
  const Color adobe = Color(0xFFE2725B);
  const Color sandstone = Color(0xFFF4E3C9);
  const Color umber = Color(0xFF635147);
  const Color rawSienna = Color(0xFFD68A59);
  const Color brickRed = Color(0xFF993322);
  const Color paleEarth = Color(0xFFFFF5EB);
  const Color kiln = Color(0xFF7A3B2E);
  const Color warmTan = Color(0xFFD2B48C);

  print('[av] ===== ANDROID VIEW CONTROLLER DEEP DEMO =====');

  // ─── Helpers declared before use ───

  Widget avBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [brickRed, terracotta],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: brickRed.withValues(alpha: 0.35),
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
              color: kiln,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: rawSienna, width: 1.5),
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

  Widget avNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleEarth,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: warmTan.withValues(alpha: 0.6)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: umber.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget avCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: sandstone.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: terracotta, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: brickRed,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: umber)),
          ),
        ],
      ),
    );
  }

  Widget avChip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget avCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: warmTan.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: umber.withValues(alpha: 0.06),
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
              color: clay.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: brickRed)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget avRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? clay.withValues(alpha: 0.08) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: warmTan.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? brickRed : umber)),
          );
        }).toList(),
      ),
    );
  }

  Widget avFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? brickRed : terracotta,
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
          child: Icon(Icons.east, size: 12, color: clay),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget avLayerBox(String label, Color color, double height) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color.computeLuminance() > 0.5
                    ? umber
                    : Colors.white)),
      ),
    );
  }

  // ━━━━━━ SECTION 1: What are platform views? ━━━━━━
  print('[av-01] Section 1: What are platform views?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('01', 'What Are Platform Views?'),
      avNote(
        'Platform views allow embedding native UI components (Android Views, '
        'iOS UIViews) directly into Flutter\'s widget tree. This is how Flutter '
        'hosts Google Maps, WebViews, video players, camera previews, and other '
        'native components that can\'t be replicated in Dart alone.',
      ),
      avCard(
        'The Platform View Concept',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avLayerBox('Flutter Widget Tree', terracotta.withValues(alpha: 0.15), 40),
            avLayerBox('Platform View Slot', adobe, 50),
            avLayerBox('Native Android View', brickRed, 40),
            avLayerBox('Android Activity', umber.withValues(alpha: 0.15), 40),
            const SizedBox(height: 10),
            avFlow([
              'Flutter requests',
              'Engine creates',
              'Native renders',
              'Texture composited',
            ]),
          ],
        ),
      ),
      avCard(
        'Why Platform Views Exist',
        Column(
          children: [
            avRow(['Use Case', 'Native Widget', 'Why Not Pure Flutter'],
                isHeader: true),
            avRow(['Maps', 'MapView', 'Google Maps SDK is native-only']),
            avRow(['WebView', 'WebView', 'Full browser engine needed']),
            avRow(['Camera', 'CameraPreview', 'Hardware-accelerated preview']),
            avRow(['Ads', 'AdView', 'AdMob SDK requires native views']),
            avRow(['Video', 'VideoView', 'Hardware codec integration']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: AndroidViewController lifecycle ━━━━━━
  print('[av-02] Section 2: AndroidViewController lifecycle');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('02', 'AndroidViewController — Lifecycle'),
      avNote(
        'AndroidViewController manages the complete lifecycle of a native '
        'Android view embedded in Flutter. It handles creation, resizing, '
        'touch event forwarding, and disposal. The controller communicates '
        'with the Android side through platform channels.',
      ),
      avCard(
        'Lifecycle Stages',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avLifecycleStep('1', 'CREATE', 'PlatformViewsService.initAndroidView()',
                'System creates the native view via a factory', brickRed),
            _avLifecycleStep('2', 'AWAIT', 'await controller.create()',
                'Waits for the native view to be fully initialized', terracotta),
            _avLifecycleStep('3', 'RESIZE', 'controller.setSize(Size(w, h))',
                'Matches the native view to Flutter\'s layout size', clay),
            _avLifecycleStep('4', 'OFFSET', 'controller.setOffset(Offset(x, y))',
                'Positions the native view on screen', umber),
            _avLifecycleStep('5', 'INTERACT', 'Touch forwarding active',
                'MotionEvents routed from Flutter to native view', rawSienna),
            _avLifecycleStep('6', 'DISPOSE', 'controller.dispose()',
                'Releases native resources, removes from scene', kiln),
          ],
        ),
      ),
      avCard(
        'Key Properties',
        Column(
          children: [
            avCode('viewId', 'Unique integer ID assigned by the platform'),
            avCode('awaitingCreation', 'True while create() hasn\'t completed'),
            avCode('isCreated', 'True after the native view is ready'),
            avCode('viewType', 'String key matching the registered factory'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Creation parameters ━━━━━━
  print('[av-03] Section 3: Creation parameters');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('03', 'Creation Parameters'),
      avNote(
        'When creating an AndroidViewController, several parameters control '
        'how the native view is initialized. The viewType must match a '
        'registered PlatformViewFactory on the Android side. CreationParams '
        'can send initial configuration data encoded via a MessageCodec.',
      ),
      avCard(
        'PlatformViewsService.initAndroidView() Parameters',
        Column(
          children: [
            avRow(['Parameter', 'Type', 'Purpose'], isHeader: true),
            avRow(['id', 'int', 'Unique view ID']),
            avRow(['viewType', 'String', 'Factory lookup key']),
            avRow(['layoutDirection', 'TextDirection', 'LTR or RTL layout']),
            avRow(['creationParams', 'dynamic', 'Init data for native side']),
            avRow(['creationParamsCodec', 'MessageCodec', 'Serialization codec']),
            avRow(['onFocus', 'VoidCallback?', 'Called when native gets focus']),
          ],
        ),
      ),
      avCard(
        'Creation Flow Diagram',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avFlow([
              'viewType string',
              'Platform channel',
              'PlatformViewFactory',
              'Android View created',
            ]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: sandstone,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dart Side',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: brickRed)),
                        const SizedBox(height: 4),
                        Text('AndroidView(\n  viewType: "my_map",\n  creationParams: {...}\n)',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: umber)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.swap_horiz, color: terracotta, size: 24),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: brickRed.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Android Side',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: brickRed)),
                        const SizedBox(height: 4),
                        Text('registry.register(\n  "my_map",\n  MyMapFactory()\n)',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: umber)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Rendering modes ━━━━━━
  print('[av-04] Section 4: Rendering modes');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('04', 'Rendering Modes — Virtual Display vs Hybrid'),
      avNote(
        'Flutter offers two rendering modes for platform views on Android:\n\n'
        '• Virtual Display (legacy): Renders the native view into an off-screen '
        'virtual display, then copies the pixels as a texture into Flutter\'s scene.\n\n'
        '• Hybrid Composition (recommended): Places the native Android view directly '
        'in the view hierarchy, composited with Flutter layers.',
      ),
      avCard(
        'Virtual Display Mode',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: umber.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  avLayerBox('Flutter Scene', terracotta.withValues(alpha: 0.2), 30),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: warmTan.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: rawSienna, style: BorderStyle.solid),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Texture (pixels copied)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: clay)),
                        Icon(Icons.image, size: 16, color: clay),
                      ],
                    ),
                  ),
                  avLayerBox('VirtualDisplay (off-screen)', adobe.withValues(alpha: 0.3), 30),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                avChip('Pros: perf isolation', sandstone, brickRed),
                const SizedBox(width: 6),
                avChip('Cons: touch issues, no a11y', warmTan, umber),
              ],
            ),
          ],
        ),
      ),
      avCard(
        'Hybrid Composition Mode',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: umber.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  avLayerBox('Flutter Overlay Layer', terracotta.withValues(alpha: 0.2), 28),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [brickRed.withValues(alpha: 0.15), adobe.withValues(alpha: 0.2)],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: brickRed, width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Native View (in-place)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: brickRed)),
                        Icon(Icons.android, size: 16, color: brickRed),
                      ],
                    ),
                  ),
                  avLayerBox('Flutter Background Layer', terracotta.withValues(alpha: 0.2), 28),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                avChip('Pros: correct touch, a11y', sandstone, brickRed),
                const SizedBox(width: 6),
                avChip('Cons: thread sync cost', warmTan, umber),
              ],
            ),
          ],
        ),
      ),
      avCard(
        'Mode Comparison',
        Column(
          children: [
            avRow(['Aspect', 'Virtual Display', 'Hybrid Composition'],
                isHeader: true),
            avRow(['Rendering', 'Off-screen texture', 'In-place native']),
            avRow(['Touch events', 'May have issues', 'Correct']),
            avRow(['Accessibility', 'Limited', 'Full']),
            avRow(['Performance', 'Good isolation', 'Thread sync cost']),
            avRow(['Keyboard', 'Issues possible', 'Works correctly']),
            avRow(['Recommended', 'Legacy only', 'Yes (default)']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Touch event forwarding ━━━━━━
  print('[av-05] Section 5: Touch event forwarding');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('05', 'Touch Event Forwarding'),
      avNote(
        'When a user touches a platform view, Flutter intercepts the touch '
        'event and must forward it to the native view. The AndroidViewController '
        'handles this via sendMotionEvent(), translating Flutter pointer events '
        'into Android MotionEvent objects. Hybrid composition makes this easier '
        'since the native view is in the real view hierarchy.',
      ),
      avCard(
        'Touch Forwarding Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avFlow([
              'User taps screen',
              'Flutter GestureArena',
              'PlatformViewSurface',
              'AndroidMotionEvent',
              'Native Android View',
            ]),
            const SizedBox(height: 14),
            _avTouchDemo('Tap', Icons.touch_app, 'MotionEvent.ACTION_DOWN + UP',
                terracotta),
            _avTouchDemo('Long Press', Icons.pan_tool, 'ACTION_DOWN + delay + UP',
                clay),
            _avTouchDemo('Drag/Swipe', Icons.swipe, 'ACTION_DOWN + MOVEs + UP',
                umber),
            _avTouchDemo('Pinch Zoom', Icons.pinch, 'Multiple pointers + MOVEs',
                brickRed),
          ],
        ),
      ),
      avCard(
        'AndroidMotionEvent Properties',
        Column(
          children: [
            avRow(['Property', 'Type', 'Description'], isHeader: true),
            avRow(['downTime', 'int', 'When finger first touched']),
            avRow(['eventTime', 'int', 'When this event occurred']),
            avRow(['action', 'int', 'ACTION_DOWN, UP, MOVE, etc.']),
            avRow(['pointerCount', 'int', 'Number of active pointers']),
            avRow(['pointerCoords', 'List', 'x, y for each pointer']),
            avRow(['source', 'int', 'Touch screen, mouse, stylus']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: AndroidView widget ━━━━━━
  print('[av-06] Section 6: AndroidView widget');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('06', 'AndroidView Widget — High-Level API'),
      avNote(
        'AndroidView is the high-level widget that wraps AndroidViewController. '
        'Most developers use AndroidView directly rather than managing the controller. '
        'It handles creation, sizing, hit testing, and disposal automatically.',
      ),
      avCard(
        'AndroidView Widget Structure',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simulated AndroidView placeholder
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: sandstone,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: clay, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: brickRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('AndroidView',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                  const SizedBox(height: 8),
                  Text('viewType: "google_maps"',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: umber)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, color: clay, size: 20),
                      const SizedBox(width: 4),
                      Text('Native MapView renders here',
                          style: TextStyle(fontSize: 11, color: clay)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            avCode('viewType', 'String matching registered PlatformViewFactory'),
            avCode('onPlatformViewCreated', 'Callback with viewId when ready'),
            avCode('creationParams', 'Map or object to pass to the factory'),
            avCode('creationParamsCodec', 'StandardMessageCodec (default)'),
            avCode('hitTestBehavior', 'How to handle hit testing (opaque, translucent)'),
            avCode('gestureRecognizers', 'Set of gesture recognizers for the view'),
            avCode('clipBehavior', 'Clip.hardEdge by default for native content'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: PlatformViewLink architecture ━━━━━━
  print('[av-07] Section 7: PlatformViewLink architecture');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('07', 'PlatformViewLink — Low-Level Architecture'),
      avNote(
        'PlatformViewLink is the lower-level widget that gives developers full '
        'control over platform view creation and surface building. It connects '
        'three parts: a controller factory, a surface factory, and an onDispose '
        'callback. AndroidView uses PlatformViewLink internally.',
      ),
      avCard(
        'Three-Part Architecture',
        Row(
          children: [
            Expanded(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: brickRed.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: brickRed),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.build, color: brickRed, size: 20),
                    const SizedBox(height: 4),
                    Text('Controller\nFactory',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: brickRed)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: terracotta.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: terracotta),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.layers, color: terracotta, size: 20),
                    const SizedBox(height: 4),
                    Text('Surface\nFactory',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: terracotta)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: clay.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: clay),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline, color: clay, size: 20),
                    const SizedBox(height: 4),
                    Text('onDispose\nCallback',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: clay)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      avCard(
        'PlatformViewLink connects...',
        Column(
          children: [
            avRow(['Component', 'Responsibility'], isHeader: true),
            avRow(['viewType', 'String key for the native factory']),
            avRow(['surfaceFactory', 'Builds PlatformViewSurface widget']),
            avRow(['onCreatePlatformView', 'Creates the PlatformViewController']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Sizing & layout constraints ━━━━━━
  print('[av-08] Section 8: Sizing & layout');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('08', 'Sizing & Layout Constraints'),
      avNote(
        'Platform views participate in Flutter\'s layout system but have special '
        'considerations. The native view must be explicitly sized — it can\'t '
        'intrinsically size itself like a Flutter widget. The controller\'s '
        'setSize() syncs the Flutter layout dimensions to the native view.',
      ),
      avCard(
        'Sizing Strategies',
        Column(
          children: [
            // Expand to fill
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: terracotta.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: terracotta),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fullscreen, color: terracotta, size: 22),
                        Text('Expanded',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: terracotta)),
                        Text('Fills parent constraints',
                            style: TextStyle(fontSize: 9, color: clay)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: brickRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: brickRed),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.aspect_ratio, color: brickRed, size: 22),
                        Text('Fixed Size',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: brickRed)),
                        Text('SizedBox wrapping',
                            style: TextStyle(fontSize: 9, color: clay)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: clay.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: clay),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.height, color: clay, size: 22),
                        Text('AspectRatio',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: clay)),
                        Text('16:9, 4:3, etc.',
                            style: TextStyle(fontSize: 9, color: umber)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            avCode('setSize()', 'Tells native view to resize to match layout'),
            avCode('setOffset()', 'Positions native view at the correct screen coordinates'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Platform channels ━━━━━━
  print('[av-09] Section 9: Platform channels');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('09', 'Platform Channel Communication'),
      avNote(
        'AndroidViewController communicates with native code through platform '
        'channels. The view creation, resizing, and event forwarding all happen '
        'via MethodChannel calls. Developers can create additional channels to '
        'communicate custom data between Dart and the native view instance.',
      ),
      avCard(
        'Communication Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dart ←→ Native visual
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: sandstone,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.code, size: 24, color: Color(0xFF1565C0)),
                            const SizedBox(height: 4),
                            Text('Dart',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: brickRed)),
                            Text('MethodChannel\n.invokeMethod()',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'monospace',
                                    color: umber)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_forward, size: 16, color: terracotta),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: terracotta.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('MethodChannel',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: terracotta)),
                    ),
                    Icon(Icons.arrow_back, size: 16, color: terracotta),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: brickRed.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.android, size: 24, color: const Color(0xFF2E7D32)),
                            const SizedBox(height: 4),
                            Text('Android',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: brickRed)),
                            Text('MethodChannel\n.setMethodCallHandler()',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'monospace',
                                    color: umber)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            avRow(['Channel', 'Direction', 'Purpose'], isHeader: true),
            avRow(['flutter/platform_views', 'Dart → Native', 'Create/dispose views']),
            avRow(['flutter/platform_views/N', 'Bidirectional', 'View-specific messages']),
            avRow(['Custom channel', 'Bidirectional', 'App-specific communication']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: iOS vs Android comparison ━━━━━━
  print('[av-10] Section 10: iOS vs Android comparison');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('10', 'Android vs iOS Platform Views'),
      avNote(
        'Flutter provides similar but platform-specific controllers for each OS. '
        'AndroidViewController manages Android views; UiKitViewController manages '
        'iOS UIViews. The API surface is similar, but the rendering strategies and '
        'limitations differ.',
      ),
      avCard(
        'Cross-Platform Comparison',
        Column(
          children: [
            avRow(['Aspect', 'Android', 'iOS'], isHeader: true),
            avRow(['Controller', 'AndroidViewController', 'UiKitViewController']),
            avRow(['Widget', 'AndroidView', 'UiKitView']),
            avRow(['Rendering', 'Hybrid / VirtualDisplay', 'Hybrid only']),
            avRow(['Touch', 'MotionEvent forwarding', 'UIEvent forwarding']),
            avRow(['Registry', 'PlatformViewRegistry', 'Same (framework)']),
            avRow(['Textile mode?', 'Yes (legacy)', 'No']),
          ],
        ),
      ),
      avCard(
        'Platform-Adaptive Pattern',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: brickRed.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.android, color: const Color(0xFF2E7D32), size: 28),
                        const SizedBox(height: 4),
                        Text('AndroidView',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: brickRed)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text('Platform\n.isAndroid?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9, color: umber)),
                      Icon(Icons.device_unknown, size: 18, color: clay),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: umber.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.apple, color: umber, size: 28),
                        const SizedBox(height: 4),
                        Text('UiKitView',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: umber)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Gesture recognizers ━━━━━━
  print('[av-11] Section 11: Gesture recognizers');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('11', 'Gesture Recognizer Configuration'),
      avNote(
        'Platform views can conflict with Flutter\'s gesture system. By default, '
        'touch events go to the native view. Use gestureRecognizers on AndroidView '
        'to specify which Flutter gestures should win. For example, if the view is '
        'inside a scrollable, you need to let vertical drag gestures pass through.',
      ),
      avCard(
        'Gesture Conflict Scenarios',
        Column(
          children: [
            _avGestureConflict(
              'Map in ScrollView',
              'Vertical drag: scroll or map pan?',
              Icons.map,
              terracotta,
            ),
            const SizedBox(height: 8),
            _avGestureConflict(
              'WebView with Links',
              'Tap: navigate or Flutter onTap?',
              Icons.web,
              clay,
            ),
            const SizedBox(height: 8),
            _avGestureConflict(
              'Camera in PageView',
              'Horizontal swipe: page or camera?',
              Icons.camera_alt,
              brickRed,
            ),
          ],
        ),
      ),
      avCard(
        'Resolution Strategy',
        Column(
          children: [
            avCode('EagerGestureRecognizer', 'Flutter always wins gesture arena'),
            avCode('VerticalDragGestureRecognizer', 'Flutter handles vertical drags'),
            avCode('Empty set {}', 'All gestures go to native view (default)'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Common use cases ━━━━━━
  print('[av-12] Section 12: Common use cases');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('12', 'Common Platform View Use Cases'),
      avNote(
        'Platform views are used when Flutter can\'t replicate native functionality. '
        'Each major use case has its own Flutter plugin that wraps the native SDK.',
      ),
      avCard(
        'Popular Platform View Plugins',
        Column(
          children: [
            _avUseCaseRow(Icons.map, 'Google Maps', 'google_maps_flutter',
                'Full native Google Maps SDK', terracotta),
            _avUseCaseRow(Icons.web, 'WebView', 'webview_flutter',
                'Chromium-based web rendering', clay),
            _avUseCaseRow(Icons.camera_alt, 'Camera Preview', 'camera',
                'Hardware-accelerated camera feed', brickRed),
            _avUseCaseRow(Icons.monetization_on, 'Ads', 'google_mobile_ads',
                'AdMob & Ad Manager native ads', umber),
            _avUseCaseRow(Icons.play_circle, 'Video Player', 'video_player',
                'Native video playback engine', rawSienna),
            _avUseCaseRow(Icons.fingerprint, 'Biometrics', 'local_auth',
                'Fingerprint/face prompt (iOS only)', kiln),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Performance considerations ━━━━━━
  print('[av-13] Section 13: Performance');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('13', 'Performance Considerations'),
      avNote(
        'Platform views add overhead. Each view requires maintaining a separate '
        'rendering context and synchronizing between Flutter\'s compositor and '
        'the native view system. Minimize the number of concurrent platform views '
        'and prefer Flutter widgets where possible.',
      ),
      avCard(
        'Performance Impact Areas',
        Column(
          children: [
            _avPerfBar('Memory overhead', 0.6, terracotta, 'Moderate'),
            const SizedBox(height: 6),
            _avPerfBar('Frame sync cost', 0.45, clay, 'Low-Moderate'),
            const SizedBox(height: 6),
            _avPerfBar('Thread switching', 0.7, brickRed, 'Moderate-High'),
            const SizedBox(height: 6),
            _avPerfBar('GPU context sharing', 0.5, umber, 'Moderate'),
            const SizedBox(height: 6),
            _avPerfBar('Startup time per view', 0.35, rawSienna, 'Low'),
          ],
        ),
      ),
      avCard(
        'Best Practices',
        Column(
          children: [
            avRow(['Practice', 'Impact'], isHeader: true),
            avRow(['Minimize concurrent views', 'Reduces memory & sync']),
            avRow(['Use hybrid composition', 'Better touch & a11y']),
            avRow(['Lazy-load views', 'Faster initial render']),
            avRow(['Dispose when off-screen', 'Recovers resources']),
            avRow(['Avoid in lists', 'Prevents recycler issues']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Error handling ━━━━━━
  print('[av-14] Section 14: Error handling');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('14', 'Error Handling & Edge Cases'),
      avNote(
        'Platform view creation can fail if the viewType isn\'t registered, '
        'if the native factory throws, or if the platform doesn\'t support '
        'the requested rendering mode. Proper error handling is essential.',
      ),
      avCard(
        'Common Failure Modes',
        Column(
          children: [
            _avErrorRow('Unregistered viewType', 'PlatformException',
                'Ensure registerViewFactory is called on native side'),
            _avErrorRow('Factory exception', 'PlatformException',
                'Debug native factory code; check logcat'),
            _avErrorRow('Disposed controller', 'StateError',
                'Null-check controller before method calls'),
            _avErrorRow('Size mismatch', 'Visual glitch',
                'Always constrain size in Flutter layout'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Debugging tools ━━━━━━
  print('[av-15] Section 15: Debugging');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('15', 'Debugging Platform Views'),
      avNote(
        'Debugging platform views requires tools from both Flutter and native '
        'sides. Flutter DevTools shows the widget tree, but the native content '
        'appears as an opaque surface. Use platform-specific tools for the native '
        'view internals.',
      ),
      avCard(
        'Debugging Toolkit',
        Column(
          children: [
            avRow(['Tool', 'Side', 'What It Shows'], isHeader: true),
            avRow(['DevTools Inspector', 'Flutter', 'Widget tree, PlatformView node']),
            avRow(['Layout Explorer', 'Flutter', 'Size & position of the view']),
            avRow(['Android Studio', 'Native', 'Layout Inspector for native views']),
            avRow(['Logcat', 'Native', 'Native error messages and traces']),
            avRow(['adb shell dumpsys', 'Native', 'View hierarchy dump']),
            avRow(['Profile mode', 'Flutter', 'Frame timing with platform views']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[av-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avBanner('16', 'Summary Dashboard'),
      avCard(
        'Platform View Architecture — Complete',
        Column(
          children: [
            avRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            avRow(['Concept', 'S01', 'Embed native views in Flutter']),
            avRow(['Lifecycle', 'S02', 'Create → Resize → Interact → Dispose']),
            avRow(['Params', 'S03', 'viewType, creationParams, codec']),
            avRow(['Rendering', 'S04', 'Virtual Display vs Hybrid']),
            avRow(['Touch', 'S05', 'MotionEvent forwarding pipeline']),
            avRow(['Widget', 'S06', 'AndroidView high-level API']),
            avRow(['PlatformViewLink', 'S07', 'Low-level 3-part architecture']),
            avRow(['Sizing', 'S08', 'setSize/setOffset sync']),
            avRow(['Channels', 'S09', 'Platform channel communication']),
            avRow(['iOS comparison', 'S10', 'Android vs UiKit controllers']),
            avRow(['Gestures', 'S11', 'Conflict resolution via recognizers']),
            avRow(['Use cases', 'S12', 'Maps, WebView, Camera, Ads']),
            avRow(['Performance', 'S13', 'Minimize views, hybrid mode']),
            avRow(['Errors', 'S14', 'Factory, disposal, size failures']),
            avRow(['Debugging', 'S15', 'DevTools + native tools']),
          ],
        ),
      ),
      avCard(
        'Terracotta / Clay Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _avColorSwatch('Terracotta', terracotta),
            _avColorSwatch('Clay', clay),
            _avColorSwatch('Adobe', adobe),
            _avColorSwatch('Brick Red', brickRed),
            _avColorSwatch('Umber', umber),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [brickRed, terracotta],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('AndroidViewController — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From creation to disposal, rendering modes to gesture conflict '
              'resolution — covering the full architecture of embedding native '
              'Android views in Flutter.',
              style: TextStyle(color: sandstone, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[av] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AndroidViewController & Platform Views'),
        backgroundColor: brickRed,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFAF5F0),
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

Widget _avLifecycleStep(String num, String phase, String code,
    String desc, Color accent) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(num,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phase,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accent)),
              Text(code,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: accent.withValues(alpha: 0.7))),
              Text(desc,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF635147))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _avTouchDemo(String gesture, IconData icon, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(gesture,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: color.withValues(alpha: 0.7))),
          ),
        ],
      ),
    ),
  );
}

Widget _avGestureConflict(String title, String conflict,
    IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(conflict,
                  style: TextStyle(fontSize: 11, color: const Color(0xFF635147))),
            ],
          ),
        ),
        Icon(Icons.warning_amber, size: 18, color: color.withValues(alpha: 0.6)),
      ],
    ),
  );
}

Widget _avUseCaseRow(IconData icon, String name, String plugin,
    String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(plugin,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: color.withValues(alpha: 0.7))),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF635147))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _avPerfBar(String label, double fraction, Color color, String level) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF635147))),
          Text(level,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
      const SizedBox(height: 3),
      Stack(
        children: [
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          FractionallySizedBox(
            widthFactor: fraction,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _avErrorRow(String error, String type, String fix) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, size: 16, color: const Color(0xFFCC5533)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(error,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              Text('Throws: $type',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: const Color(0xFF993322))),
              Text('Fix: $fix',
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF635147))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _avColorSwatch(String name, Color color) {
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
