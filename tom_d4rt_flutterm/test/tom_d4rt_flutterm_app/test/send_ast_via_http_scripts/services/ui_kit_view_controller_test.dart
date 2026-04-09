// ignore_for_file: avoid_print
// D4rt deep demo: UiKitViewController — the controller that manages
// native iOS UIKit views embedded inside Flutter via platform views.
// Covers view lifecycle, configuration, sizing, hit testing, and
// how the native view composites into the Flutter layer tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Steel / Pewter palette ───
  const Color steel = Color(0xFF6B7280);
  const Color pewter = Color(0xFF9CA3AF);
  const Color deepSteel = Color(0xFF374151);
  const Color paleSmoke = Color(0xFFF3F4F6);
  const Color gunmetal = Color(0xFF4B5563);
  const Color silver = Color(0xFFE5E7EB);
  const Color charcoal = Color(0xFF1F2937);
  const Color ash = Color(0xFFD1D5DB);
  const Color fog = Color(0xFFF9FAFB);
  const Color slate = Color(0xFF475569);

  print('===== UI KIT VIEW CONTROLLER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [charcoal, deepSteel],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: charcoal.withValues(alpha: 0.3),
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
              color: steel,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: pewter, width: 1.5),
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

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fog,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepSteel.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver),
        boxShadow: [
          BoxShadow(
            color: steel.withValues(alpha: 0.07),
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
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: fog,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: charcoal)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: charcoal)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: deepSteel)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: charcoal.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: charcoal),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: charcoal)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: ash,
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget layerDiagram(String label, Color color, double indent) {
    return Padding(
      padding: EdgeInsets.only(left: indent, bottom: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
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
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      ),
    );
  }

  Widget nativeViewPlaceholder(String viewType, double width, double height, Color accent) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone_iphone, size: 28, color: accent),
          const SizedBox(height: 6),
          Text(viewType,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: accent)),
          Text('Native UIKit View',
              style: TextStyle(fontSize: 10, color: accent.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  // ─── Section 1: Overview & Purpose ───
  print('[Section 1] Overview & Purpose');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'UiKitViewController is the controller for managing native iOS '
          'UIKit views that are embedded inside a Flutter widget tree. On '
          'iOS, when you need to display a native view (like MKMapView, '
          'WKWebView, or a camera preview), Flutter creates a platform '
          'view backed by UiKitViewController. It handles view lifecycle, '
          'sizing, hit testing, and compositing the native layer into the '
          'Flutter rendering pipeline.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Class (controller)'),
              dataRow('Package', 'flutter/services'),
              dataRow('Platform', 'iOS only'),
              dataRow('Purpose', 'Manage native UIKit view embedding'),
              dataRow('Created by', 'PlatformViewsService'),
            ],
          )),
      infoCard(
          'Why It Exists',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Native content', 'Maps, WebViews, camera, ads'),
              dataRow('Compositing', 'Merge native + Flutter layers'),
              dataRow('Touch', 'Forward gestures correctly'),
              dataRow('Lifecycle', 'Create/dispose native resources'),
            ],
          )),
    ],
  );

  // ─── Section 2: Platform View Architecture ───
  print('[Section 2] Platform View Architecture');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Platform View Architecture'),
      noteBox(
          'Platform views use a layered architecture where the native view '
          'is inserted into the Flutter compositing tree. On iOS, this uses '
          'the "hybrid composition" approach where native UIKit views are '
          'overlaid or embedded alongside Flutter-rendered content.'),
      infoCard(
          'Layer Stack',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              layerDiagram('Flutter UI Layer (top)', steel, 0),
              layerDiagram('Platform View Layer', gunmetal, 20),
              layerDiagram('Flutter Background Layer', slate, 40),
              layerDiagram('Skia/Impeller Canvas', charcoal, 60),
            ],
          )),
      infoCard(
          'Composition Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Hybrid Composition', 'Native view in Flutter tree'),
              dataRow('Virtual Display', 'Android only, not iOS'),
              dataRow('Texture Layer', 'Renders to texture (performance)'),
              dataRow('iOS Default', 'Hybrid with UiKitView'),
            ],
          )),
      infoCard(
          'Widget Integration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('UiKitView', 'Widget that hosts a UIKit view'),
              dataRow('viewType', 'Registered factory identifier'),
              dataRow('creationParams', 'Initial data for the native view'),
              dataRow('Controller', 'UiKitViewController manages it'),
            ],
          )),
    ],
  );

  // ─── Section 3: View Creation ───
  print('[Section 3] View Creation');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'View Creation'),
      noteBox(
          'Creating a UiKitViewController happens through '
          'PlatformViewsService. The service sends a create message to '
          'the platform side, where a registered factory instantiates '
          'the native UIKit view. The controller receives an ID that '
          'references the native view.'),
      infoCard(
          'Creation Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Step 1', 'Register factory on native side'),
              dataRow('Step 2', 'Flutter calls initUiKitView()'),
              dataRow('Step 3', 'Platform creates native UIView'),
              dataRow('Step 4', 'Returns UiKitViewController'),
              dataRow('Step 5', 'Controller holds view ID'),
            ],
          )),
      infoCard(
          'Creation Parameters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('id', 'Unique view identifier'),
              dataRow('viewType', 'Factory key (e.g., "map_view")'),
              dataRow('creationParams', 'Config data (any format)'),
              dataRow('creationParamsCodec', 'Serialization codec'),
              dataRow('layoutDirection', 'LTR or RTL'),
            ],
          )),
      infoCard(
          'Common View Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nativeViewPlaceholder('MKMapView', double.infinity, 80, steel),
              nativeViewPlaceholder('WKWebView', double.infinity, 80, gunmetal),
              nativeViewPlaceholder('AVCapturePreview', double.infinity, 80, slate),
            ],
          )),
    ],
  );

  // ─── Section 4: View Lifecycle ───
  print('[Section 4] View Lifecycle');

  final lifecycleStages = <Map<String, String>>[
    {'stage': 'Create', 'description': 'Native view instantiated', 'state': 'Alive'},
    {'stage': 'Attach', 'description': 'Added to Flutter compositing', 'state': 'Visible'},
    {'stage': 'Resize', 'description': 'Size updated from layout', 'state': 'Active'},
    {'stage': 'Detach', 'description': 'Removed from compositing', 'state': 'Hidden'},
    {'stage': 'Dispose', 'description': 'Native view destroyed', 'state': 'Dead'},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'View Lifecycle'),
      noteBox(
          'A UiKitViewController manages the full lifecycle of its native '
          'view. From creation to disposal, the controller ensures resources '
          'are properly allocated and freed.'),
      for (final stage in lifecycleStages)
        infoCard(
            '${stage['stage']} → ${stage['state']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Stage', stage['stage']!),
                dataRow('Description', stage['description']!),
                dataRow('View State', stage['state']!),
              ],
            )),
      infoCard(
          'Disposal Importance',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Memory', 'Native views hold GPU textures'),
              dataRow('Camera', 'Must release capture sessions'),
              dataRow('WebView', 'JS context and cookies'),
              dataRow('Maps', 'Tile cache and location services'),
            ],
          )),
    ],
  );

  // ─── Section 5: Size & Layout ───
  print('[Section 5] Size & Layout');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Size & Layout'),
      noteBox(
          'The controller must keep the native view sized correctly as '
          'Flutter layout changes. When the Flutter widget tree relayouts, '
          'the controller sends size updates to the native side so the '
          'UIKit view matches the allocated space.'),
      infoCard(
          'setSize()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'setSize(Size size)'),
              dataRow('When called', 'On layout changes'),
              dataRow('Sends to', 'Platform channel → native'),
              dataRow('Native action', 'UIView.frame updated'),
            ],
          )),
      infoCard(
          'Size Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: steel.withValues(alpha: 0.1),
                  border: Border.all(color: steel),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text('Full Width: 360 × 60',
                      style: TextStyle(fontSize: 11, color: deepSteel)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(right: 4, bottom: 6),
                      decoration: BoxDecoration(
                        color: gunmetal.withValues(alpha: 0.1),
                        border: Border.all(color: gunmetal),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('Half Width',
                            style: TextStyle(fontSize: 10, color: deepSteel)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(left: 4, bottom: 6),
                      decoration: BoxDecoration(
                        color: slate.withValues(alpha: 0.1),
                        border: Border.all(color: slate),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('Half Width',
                            style: TextStyle(fontSize: 10, color: deepSteel)),
                      ),
                    ),
                  ),
                ],
              ),
              dataRow('Constraint-based', 'Respects BoxConstraints'),
              dataRow('Pixel ratio', 'Accounts for device scale'),
              dataRow('Rotation', 'Size recalculated on orientation'),
            ],
          )),
    ],
  );

  // ─── Section 6: Hit Testing ───
  print('[Section 6] Hit Testing');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Hit Testing & Touch'),
      noteBox(
          'Hit testing determines whether touch events go to the native '
          'UIKit view or to Flutter widgets. The controller can be '
          'configured to accept hits (opaque), reject hits (transparent), '
          'or let the platform decide (translucent).'),
      infoCard(
          'acceptsGesture()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'acceptsGesture()'),
              dataRow('Returns bool', 'Whether view accepts touch'),
              dataRow('Opaque', 'All touches go to native view'),
              dataRow('Transparent', 'All touches go to Flutter'),
            ],
          )),
      infoCard(
          'Hit Test Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: paleSmoke,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: steel),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Opaque',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: charcoal)),
                    Text('Native view captures all touches',
                        style: TextStyle(fontSize: 11, color: deepSteel)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: paleSmoke,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: gunmetal),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Translucent',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: charcoal)),
                    Text('Both native and Flutter receive touches',
                        style: TextStyle(fontSize: 11, color: deepSteel)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: paleSmoke,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: slate),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transparent',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: charcoal)),
                    Text('Flutter captures all touches',
                        style: TextStyle(fontSize: 11, color: deepSteel)),
                  ],
                ),
              ),
            ],
          )),
      infoCard(
          'Gesture Forwarding',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tap', 'Forward to native or Flutter'),
              dataRow('Pan/Drag', 'Map scrolling needs native pan'),
              dataRow('Pinch', 'Map zoom needs native pinch'),
              dataRow('Long press', 'Context menus in native views'),
            ],
          )),
    ],
  );

  // ─── Section 7: Platform Channels ───
  print('[Section 7] Platform Channels');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Platform Channels'),
      noteBox(
          'UiKitViewController communicates with the native side through '
          'platform channels. These channels carry create/dispose messages, '
          'size updates, and touch events between Flutter and UIKit.'),
      infoCard(
          'Channel Messages',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('create', 'Instantiate native view'),
              dataRow('dispose', 'Destroy native view'),
              dataRow('resize', 'Update view frame'),
              dataRow('touch', 'Forward touch events'),
              dataRow('setDirection', 'Set layout direction'),
            ],
          )),
      infoCard(
          'Message Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              layerDiagram('Flutter (Dart)', steel, 0),
              layerDiagram('Method Channel', gunmetal, 15),
              layerDiagram('Platform (ObjC/Swift)', charcoal, 30),
              layerDiagram('UIKit View', slate, 45),
            ],
          )),
    ],
  );

  // ─── Section 8: Compositing in Render Tree ───
  print('[Section 8] Compositing in Render Tree');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Compositing in Render Tree'),
      noteBox(
          'The native UIKit view is composited into the Flutter render tree '
          'using a PlatformViewLayer. This layer tells the compositor where '
          'to place the native view relative to Flutter-rendered content.'),
      infoCard(
          'Render Object Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              layerDiagram('RenderView (root)', charcoal, 0),
              layerDiagram('RenderFlex (layout)', deepSteel, 15),
              layerDiagram('RenderUiKitView', steel, 30),
              layerDiagram('PlatformViewLayer', gunmetal, 45),
              dataRow('RenderUiKitView', 'Special render object'),
              dataRow('PlatformViewLayer', 'Inserts native view in scene'),
            ],
          )),
      infoCard(
          'Clipping & Transforms',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Clip', 'Native view clipped to bounds'),
              dataRow('Transform', 'Rotation/scale applied via CALayer'),
              dataRow('Opacity', 'Applied through CALayer.opacity'),
              dataRow('Stacking', 'Z-index via addRetained/addPerformanceOverlay'),
            ],
          )),
    ],
  );

  // ─── Section 9: Use Case — Embedded Map ───
  print('[Section 9] Use Case — Embedded Map');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Use Case — Embedded Map'),
      noteBox(
          'One of the most common uses of UiKitViewController is embedding '
          'Apple Maps (MKMapView) inside a Flutter app. The controller '
          'manages the map lifecycle, forwards pan/zoom gestures, and '
          'keeps the map sized to its container.'),
      infoCard(
          'Map Integration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nativeViewPlaceholder('MKMapView', double.infinity, 120, steel),
              dataRow('viewType', '"apple_maps_view"'),
              dataRow('Gestures', 'Pan, pinch-zoom, double-tap'),
              dataRow('Controller manages', 'Size, visibility, dispose'),
              dataRow('Data flow', 'Annotations via method channel'),
            ],
          )),
      infoCard(
          'Map Lifecycle',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Create', 'MKMapView initialized with region'),
              dataRow('Configure', 'Set map type, annotations, overlays'),
              dataRow('Interact', 'User pans/zooms (native gestures)'),
              dataRow('Update', 'Flutter sends new annotations'),
              dataRow('Dispose', 'Stop location updates, free tiles'),
            ],
          )),
    ],
  );

  // ─── Section 10: Use Case — WebView ───
  print('[Section 10] Use Case — WebView');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Use Case — WebView'),
      noteBox(
          'WKWebView embedding uses UiKitViewController to display web '
          'content inside Flutter. The web view handles its own scrolling '
          'and touch, which must be coordinated with Flutter gestures.'),
      infoCard(
          'WebView Integration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nativeViewPlaceholder('WKWebView', double.infinity, 120, gunmetal),
              dataRow('viewType', '"web_view"'),
              dataRow('Challenges', 'Nested scrolling, keyboard, JS'),
              dataRow('Gestures', 'Tap links, scroll, pinch zoom'),
              dataRow('Communication', 'JavaScript bridge via channels'),
            ],
          )),
    ],
  );

  // ─── Section 11: Performance ───
  print('[Section 11] Performance');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Performance'),
      noteBox(
          'Platform views have a performance cost because the compositor '
          'must merge native and Flutter layers. Understanding these costs '
          'helps decide when to use native views vs Flutter equivalents.'),
      infoCard(
          'Performance Costs',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Layer compositing', 0.6, steel),
              progressBar('Thread synchronization', 0.45, gunmetal),
              progressBar('Memory (native + Flutter)', 0.5, slate),
              progressBar('Touch forwarding', 0.2, charcoal),
            ],
          )),
      infoCard(
          'Optimization Tips',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Limit count', 'Few platform views per screen'),
              dataRow('Avoid animation', 'Reduce compositing during anim'),
              dataRow('Prefer Flutter', 'Use Flutter widgets when possible'),
              dataRow('Lazy creation', 'Create views only when visible'),
              dataRow('Dispose early', 'Release when offscreen'),
            ],
          )),
    ],
  );

  // ─── Section 12: Error Handling ───
  print('[Section 12] Error Handling');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Error Handling'),
      noteBox(
          'Platform view creation can fail for various reasons. The '
          'controller must handle missing factories, codec mismatches, '
          'and platform-specific restrictions gracefully.'),
      infoCard(
          'Common Errors',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Unregistered type', 'Factory not found on native side'),
              dataRow('Codec mismatch', 'Params encoded differently'),
              dataRow('Wrong platform', 'UiKitView on Android'),
              dataRow('Disposed twice', 'Double-dispose throws'),
              dataRow('Timeout', 'Native view creation too slow'),
            ],
          )),
      infoCard(
          'Graceful Fallback',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Error widget', 'Show placeholder on failure'),
              dataRow('Retry logic', 'Attempt recreation once'),
              dataRow('Logging', 'Report to crash analytics'),
              dataRow('Feature flags', 'Conditionally use native views'),
            ],
          )),
    ],
  );

  // ─── Section 13: Android Counterpart ───
  print('[Section 13] Android Counterpart');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Android Counterpart'),
      noteBox(
          'On Android, the equivalent is AndroidViewController (and its '
          'subclasses). Understanding the difference helps write cross-'
          'platform code that uses the right controller per platform.'),
      infoCard(
          'Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iOS', 'UiKitViewController'),
              dataRow('Android', 'AndroidViewController'),
              dataRow('Android subtypes', 'SurfaceAndroid..., TextureAndroid...'),
              dataRow('Widget(iOS)', 'UiKitView'),
              dataRow('Widget(Android)', 'AndroidView'),
              dataRow('Cross-platform', 'PlatformViewLink (unified)'),
            ],
          )),
    ],
  );

  // ─── Section 14: Testing ───
  print('[Section 14] Testing');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Testing'),
      noteBox(
          'Testing platform views requires mocking the platform channel '
          'responses. In widget tests, a FakePlatformViewsController '
          'simulates the native side without actual UIKit views.'),
      infoCard(
          'Test Setup',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Fake controller', 'Simulates native responses'),
              dataRow('Channel mock', 'Return success for create/dispose'),
              dataRow('Size assertions', 'Verify setSize() called'),
              dataRow('Lifecycle', 'Verify create → dispose order'),
            ],
          )),
      infoCard(
          'Widget Test',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Build UiKitView', 'In test widget tree'),
              dataRow('Pump frames', 'Allow async creation'),
              dataRow('Verify render', 'PlatformViewLayer in tree'),
              dataRow('Dispose', 'Remove from tree, verify cleanup'),
            ],
          )),
    ],
  );

  // ─── Section 15: Best Practices ───
  print('[Section 15] Best Practices');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Best Practices'),
      noteBox(
          'Guidelines for working with UiKitViewController to achieve '
          'the best user experience and performance.'),
      infoCard(
          'Do',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Dispose properly', 'Always call dispose()'),
              dataRow('Lazy load', 'Create when visible'),
              dataRow('Size correctly', 'Set precise constraints'),
              dataRow('Handle errors', 'Catch creation failures'),
              dataRow('Limit quantity', 'One or two per screen max'),
            ],
          )),
      infoCard(
          'Avoid',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Many views', 'Performance degrades quickly'),
              dataRow('Frequent resize', 'Causes re-compositing'),
              dataRow('Animate underneath', 'Flutter layers below are slow'),
              dataRow('Forget dispose', 'Memory leaks from native side'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the UiKitViewController deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Steel', steel),
              colorSwatch('Pewter', pewter),
              colorSwatch('Deep Steel', deepSteel),
              colorSwatch('Pale Smoke', paleSmoke),
              colorSwatch('Gunmetal', gunmetal),
              colorSwatch('Silver', silver),
              colorSwatch('Charcoal', charcoal),
              colorSwatch('Ash', ash),
              colorSwatch('Fog', fog),
              colorSwatch('Slate', slate),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, steel),
              progressBar('Architecture', 1.0, gunmetal),
              progressBar('View Creation', 1.0, slate),
              progressBar('View Lifecycle', 1.0, charcoal),
              progressBar('Size & Layout', 1.0, steel),
              progressBar('Hit Testing', 1.0, gunmetal),
              progressBar('Platform Channels', 1.0, slate),
              progressBar('Compositing', 1.0, charcoal),
              progressBar('Map Use Case', 1.0, steel),
              progressBar('WebView Use Case', 1.0, gunmetal),
              progressBar('Performance', 1.0, slate),
              progressBar('Error Handling', 1.0, charcoal),
              progressBar('Android Counterpart', 1.0, steel),
              progressBar('Testing', 1.0, gunmetal),
              progressBar('Best Practices', 1.0, slate),
              progressBar('Dashboard', 1.0, charcoal),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Steel / Pewter'),
              dataRow('Palette colors', '10'),
              dataRow('Lifecycle stages', '${lifecycleStages.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('UiKitViewController', steel, Colors.white),
          tag('Platform Views', gunmetal, Colors.white),
          tag('iOS UIKit', charcoal, Colors.white),
          tag('Compositing', slate, Colors.white),
          tag('Hit Testing', pewter, charcoal),
          tag('Native Embed', deepSteel, Colors.white),
        ],
      ),
    ],
  );

  print('===== END UI KIT VIEW CONTROLLER DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
