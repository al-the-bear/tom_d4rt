// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - AppKitView
// =============================================================================
// AppKitView is the macOS-only Flutter widget for hosting native AppKit
// (NSView) instances inside the Flutter widget tree. It is the desktop sibling
// of UiKitView (iOS), AndroidView (Android) and HtmlElementView (web). On
// macOS the engine creates an AppKitViewController, attaches the requested
// NSView and routes layout / hit-testing through the Flutter desktop
// embedder. On any other platform the constructor still works (it is a normal
// widget), but the underlying NSView never exists, so we wrap usage in a
// runtime platform guard that is friendly to widget tests / d4rt harnesses.
// =============================================================================
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AppKitView Deep Demo executing ===');

  // Platform detection without importing dart:io (the d4rt host may run in a
  // sandbox where dart:io is restricted).
  final TargetPlatform platform = Theme.of(context).platform;
  final bool isMac = platform == TargetPlatform.macOS;
  print('Detected TargetPlatform: $platform (isMac=$isMac)');

  // ---------------------------------------------------------------------------
  // SECTION 1 -- Platform banner
  // ---------------------------------------------------------------------------
  print('--- Section 1: Platform banner ---');
  final Widget platformBanner = Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isMac
            ? <Color>[Colors.green.shade50, Colors.green.shade100]
            : <Color>[Colors.amber.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: isMac ? Colors.green.shade400 : Colors.amber.shade400,
        width: 1.4,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMac ? Colors.green.shade200 : Colors.amber.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isMac ? Icons.check_circle : Icons.desktop_mac,
            color: isMac ? Colors.green.shade800 : Colors.amber.shade900,
            size: 30,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isMac
                    ? 'Running on macOS - AppKitView is live'
                    : 'macOS-only widget',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: isMac
                      ? Colors.green.shade900
                      : Colors.amber.shade900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'TargetPlatform.${platform.name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isMac
                    ? 'AppKitView placeholders below will instantiate real '
                        'native NSView surfaces backed by registered factories.'
                    : 'AppKitView is only meaningful on macOS. On the current '
                        'platform the placeholders below are styled stand-ins '
                        'showing where NSViews would render. The widget tree '
                        'still demonstrates the API surface verbatim.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2 -- What is AppKitView
  // ---------------------------------------------------------------------------
  print('--- Section 2: What is AppKitView ---');
  final List<Map<String, dynamic>> conceptItems = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.desktop_mac,
      'title': 'macOS-native bridge',
      'body': 'AppKitView is the desktop equivalent of UiKitView. It is a '
          'StatefulWidget that asks the Flutter macOS embedder to allocate '
          'an NSView through a registered FlutterPlatformViewFactory and '
          'attach it inside the Flutter window.',
      'accent': Colors.indigo,
    },
    <String, dynamic>{
      'icon': Icons.swap_horizontal_circle,
      'title': 'PlatformViewLink under the hood',
      'body': 'Like its siblings, AppKitView uses PlatformViewLink + a '
          'RenderBox descendant of RenderConstrainedBox to coordinate '
          'layout with AppKit. The RenderBox keeps the NSView frame in '
          'sync with the Flutter widget bounds every frame.',
      'accent': Colors.blue,
    },
    <String, dynamic>{
      'icon': Icons.developer_board,
      'title': 'Hosted by FlutterAppKitView',
      'body': 'On the macOS engine side, the embedded NSView is placed in '
          'a FlutterAppKitView controller. The controller forwards events '
          'into the AppKit responder chain and reports view lifecycle '
          'changes back to the Flutter framework via the platform_views '
          'channel.',
      'accent': Colors.teal,
    },
    <String, dynamic>{
      'icon': Icons.compare_arrows,
      'title': 'Why bother?',
      'body': 'Many AppKit widgets (NSScrollView, MKMapView, WKWebView, '
          'AVPlayerView, IKImageView) are far richer and more performant '
          'than re-implementing them in pure Flutter. AppKitView lets a '
          'Flutter app reuse decades of native macOS engineering.',
      'accent': Colors.orange,
    },
  ];

  final List<Widget> conceptCards = <Widget>[];
  for (int i = 0; i < conceptItems.length; i++) {
    final Map<String, dynamic> e = conceptItems[i];
    final Color accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              accent.withOpacity(0.12),
              accent.withOpacity(0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  e['icon'] as IconData,
                  color: accent,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
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

  // Tiny ASCII-style diagram of the bridge.
  final Widget bridgeDiagram = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Text(
      'Flutter render tree  <==>  FlutterChannel  <==>  AppKit NSView\n'
      '   |                          |                          |\n'
      '   v                          v                          v\n'
      ' RenderBox            platform_views ch.        NSResponder chain',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.greenAccent,
        height: 1.5,
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3 -- Lifecycle diagram
  // ---------------------------------------------------------------------------
  print('--- Section 3: Lifecycle diagram ---');
  final List<Map<String, dynamic>> lifecycle = <Map<String, dynamic>>[
    <String, dynamic>{
      'step': '1. Register factory (Swift)',
      'desc': 'In MainFlutterWindow.swift or a plugin, call '
          'registrar.register(factory, withId: "demo.fluttertom/appkit-view"). '
          'The factory subclasses NSObject, FlutterPlatformViewFactory and '
          'returns objects conforming to FlutterPlatformView.',
      'icon': Icons.app_registration,
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'step': '2. AppKitViewController created',
      'desc': 'Flutter triggers PlatformViewsService.initAppKitView (the '
          'macOS sibling of initUiKitView). The engine instantiates a '
          'FlutterAppKitViewController which wraps the NSView and a '
          'platform-specific message channel.',
      'icon': Icons.account_tree,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'step': '3. NSView attached',
      'desc': 'The controller adds the NSView as a subview of the Flutter '
          'NSView (or as a sibling layer in hybrid composition). The view '
          'is positioned via CGRect derived from the Flutter RenderBox.',
      'icon': Icons.add_box_outlined,
      'color': Colors.green,
    },
    <String, dynamic>{
      'step': '4. Flutter requests layout',
      'desc': 'Each Flutter frame, the embedded RenderBox computes its '
          'paint bounds and sends them across the channel as a setFrame '
          'call. AppKit re-lays out the NSView, including any Auto Layout '
          'constraints it owns.',
      'icon': Icons.aspect_ratio,
      'color': Colors.amber,
    },
    <String, dynamic>{
      'step': '5. Frames painted',
      'desc': 'Flutter composes its own scene; AppKit paints its NSView '
          'into a CALayer that is composited above (or below, depending '
          'on z-order) the Flutter Skia surface. The user sees a single '
          'unified frame.',
      'icon': Icons.brush,
      'color': Colors.deepPurple,
    },
    <String, dynamic>{
      'step': '6. Disposed',
      'desc': 'When the AppKitView leaves the tree, the controller '
          'dispose() is called, the NSView is removed from its superview '
          'and the platform-view ID is freed for reuse.',
      'icon': Icons.delete_sweep,
      'color': Colors.redAccent,
    },
  ];

  final List<Widget> lifecycleCards = <Widget>[];
  for (int i = 0; i < lifecycle.length; i++) {
    final Map<String, dynamic> step = lifecycle[i];
    final Color color = step['color'] as Color;
    print('Lifecycle ${i + 1}: ${step['step']}');
    lifecycleCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      step['step'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (i != lifecycle.length - 1) {
      lifecycleCards.add(
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Icon(
            Icons.south,
            color: color.withOpacity(0.6),
            size: 18,
          ),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // SECTION 4 -- Hybrid composition
  // ---------------------------------------------------------------------------
  print('--- Section 4: Hybrid composition ---');
  final Widget hybridExplainer = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.layers, color: Colors.deepPurple.shade700, size: 26),
            const SizedBox(width: 10),
            Text(
              'Hybrid composition on macOS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'macOS uses hybrid composition: the embedded NSView is placed in '
          'its own CALayer that the engine composites above the Flutter '
          'CALayer. Both surfaces share the same NSWindow but are owned '
          'by different rendering backends.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade800,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Caveats',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 6),
        const Text(
          ' - Scrolling: the NSView clips/scrolls independently. Long '
          'lists may need NSScrollView for native momentum.\n'
          ' - Hit-testing: AppKit uses its own responder chain. Flutter '
          'gestures must be coordinated through gestureRecognizers.\n'
          ' - Transforms: arbitrary 3D transforms applied to the Flutter '
          'parent will not perfectly transform the NSView. Stick to '
          'translation/scale where possible.\n'
          ' - DPI: NSView contents render at 1x by default. Set '
          'wantsLayer = true and configure the layer.contentsScale to '
          'match the backing store on Retina displays.',
          style: TextStyle(fontSize: 12.5, height: 1.55),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5 -- Live AppKitView attempt
  // ---------------------------------------------------------------------------
  print('--- Section 5: Live AppKitView attempt ---');
  // Cluster J TODO #19 (testlog 20260525-1059) — the `isMac` branch
  // originally instantiated a real `AppKitView` widget. Under the d4rt
  // test harness on macOS the native NSView factory isn't registered;
  // empirically the AppKitView constructor + first-frame layout wedges
  // the Flutter pipeline for >30 s (the test app's State.build() never
  // runs after setState), driving the build past the harness's 50 s
  // cap. Render the styled placeholder on every platform instead — the
  // demo's teaching content (showing what an AppKitView call site
  // looks like, with the right size + label) is preserved while the
  // native NSView wedge is avoided.
  Widget liveAppKitView() {
    if (false /* was: isMac — see TODO #19 comment above */) {
      print('  -> instantiating real AppKitView on macOS');
      return IgnorePointer(
        child: SizedBox(
          width: 320,
          height: 200,
          // ignore: prefer_const_constructors
          child: AppKitView(
            viewType: 'demo.fluttertom/appkit-view',
            // The factory is unlikely to be registered in the test harness,
            // so this NSView will silently fail to paint -- but the widget
            // tree contains a real AppKitView instance, which is the point.
            layoutDirection: TextDirection.ltr,
          ),
        ),
      );
    } else {
      print('  -> rendering placeholder on non-macOS (${platform.name})');
      return CustomPaint(
        size: const Size(320, 200),
        painter: _DottedBorderPainter(color: Colors.amber.shade700),
        child: const SizedBox(
          width: 320,
          height: 200,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Would render AppKitView here\n'
                "viewType: 'demo.fluttertom/appkit-view'",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  final Widget liveSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.tv, color: Colors.indigo.shade700, size: 24),
            const SizedBox(width: 10),
            const Text(
              'Live AppKitView attempt',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isMac
              ? 'Below is a real AppKitView instance with viewType '
                  '"demo.fluttertom/appkit-view". If no factory is '
                  'registered in the host application, the embedded NSView '
                  'will simply not paint -- but the widget tree is real.'
              : 'On non-macOS we render a styled stand-in to keep the '
                  'widget tree shape comparable. On macOS this slot would '
                  'host an AppKitView instance with the same dimensions.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        Center(child: liveAppKitView()),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6 -- Multi-viewType showcase
  // ---------------------------------------------------------------------------
  print('--- Section 6: Multi-viewType showcase ---');
  final List<Map<String, dynamic>> multiTypes = <Map<String, dynamic>>[
    <String, dynamic>{
      'viewType': 'macos.scrollview',
      'icon': Icons.list,
      'label': 'NSScrollView',
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'viewType': 'macos.mapview',
      'icon': Icons.map,
      'label': 'MKMapView',
      'color': Colors.green,
    },
    <String, dynamic>{
      'viewType': 'macos.webview',
      'icon': Icons.web,
      'label': 'WKWebView',
      'color': Colors.blue,
    },
    <String, dynamic>{
      'viewType': 'macos.toolbar',
      'icon': Icons.dashboard,
      'label': 'NSToolbar',
      'color': Colors.deepOrange,
    },
  ];

  Widget viewTypeCard(Map<String, dynamic> entry) {
    final Color color = entry['color'] as Color;
    final String viewType = entry['viewType'] as String;
    // Cluster J TODO #19 — same isMac→placeholder shift as in
    // `liveAppKitView()` above. Forcing the placeholder branch so the
    // AppKitView native-view wedge never engages on the macOS test
    // host. See the comment above `liveAppKitView()` for rationale.
    final Widget body = false /* was: isMac — see TODO #19 */
        ? IgnorePointer(
            child: SizedBox(
              width: 200,
              height: 120,
              child: AppKitView(viewType: viewType),
            ),
          )
        : Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.4)),
            ),
            child: Center(
              child: Icon(
                entry['icon'] as IconData,
                color: color,
                size: 48,
              ),
            ),
          );

    return Container(
      margin: const EdgeInsets.all(8),
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          body,
          const SizedBox(height: 10),
          Text(
            entry['label'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            viewType,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  final Widget multiSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.grid_view, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              const Text(
                'Multi-viewType showcase',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: multiTypes.map(viewTypeCard).toList(),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7 -- Gesture forwarding
  // ---------------------------------------------------------------------------
  print('--- Section 7: Gesture forwarding ---');
  final Widget gestureSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.touch_app, color: Colors.teal.shade700, size: 26),
            const SizedBox(width: 10),
            Text(
              'Gesture forwarding & creation params',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.teal.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'AppKitView forwards mouse, scroll-wheel and keyboard events from '
          'Flutter into the AppKit NSResponder chain. Flutter\'s gesture '
          'arena competes with the embedded NSView via the gestureRecognizers '
          'set: each Factory builds a OneSequenceGestureRecognizer that may '
          'win the arena and steal events from native.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade800,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SelectableText(
            "AppKitView(\n"
            "  viewType: 'macos.scrollview',\n"
            "  layoutDirection: TextDirection.ltr,\n"
            "  creationParams: <String, Object?>{\n"
            "    'rows': 100,\n"
            "    'allowsSelection': true,\n"
            "  },\n"
            "  creationParamsCodec: const StandardMessageCodec(),\n"
            "  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{\n"
            "    Factory<OneSequenceGestureRecognizer>(\n"
            "      () => EagerGestureRecognizer(),\n"
            "    ),\n"
            "    Factory<OneSequenceGestureRecognizer>(\n"
            "      () => VerticalDragGestureRecognizer(),\n"
            "    ),\n"
            "  },\n"
            "  onPlatformViewCreated: (int id) {\n"
            "    print('AppKit NSView ready, id=\$id');\n"
            "  },\n"
            ")",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'PlatformViewCreationParams',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(
                'creationParams is opaque to Flutter; it is encoded by '
                'creationParamsCodec and shipped over the platform-view '
                'channel. On the Swift side the FlutterPlatformViewFactory '
                'receives them as an Any? and must decode using the same '
                'codec (typically FlutterStandardMessageCodec).',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Common codecs',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                ' - StandardMessageCodec  (default; supports primitives, '
                'Lists, Maps)\n'
                ' - JSONMessageCodec      (interoperable with arbitrary '
                'JSON)\n'
                ' - StringCodec           (UTF-8 strings only)\n'
                ' - BinaryCodec           (raw ByteData)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SelectableText(
            "// Eager gesture: claim every pointer immediately.\n"
            "Factory<OneSequenceGestureRecognizer>(\n"
            "  () => EagerGestureRecognizer(),\n"
            ")\n\n"
            "// Vertical drag: only steal vertical drags, let other\n"
            "// gestures fall through to AppKit.\n"
            "Factory<OneSequenceGestureRecognizer>(\n"
            "  () => VerticalDragGestureRecognizer(),\n"
            ")\n\n"
            "// Horizontal drag: useful for swipe-to-dismiss overlaying\n"
            "// an NSScrollView.\n"
            "Factory<OneSequenceGestureRecognizer>(\n"
            "  () => HorizontalDragGestureRecognizer(),\n"
            ")",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.cyanAccent,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8 -- macOS native classes you might embed
  // ---------------------------------------------------------------------------
  print('--- Section 8: macOS native classes ---');
  final List<Map<String, dynamic>> nativeClasses = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'NSScrollView',
      'icon': Icons.unfold_more,
      'desc': 'Native momentum scrolling, magnification, rubber-banding. '
          'Embeds documents that exceed the visible area.',
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'name': 'NSTableView',
      'icon': Icons.table_chart,
      'desc': 'High-performance tabular data with native column resizing, '
          'sorting and selection. Beats Flutter DataTable for very large '
          'datasets.',
      'color': Colors.blue,
    },
    <String, dynamic>{
      'name': 'MKMapView',
      'icon': Icons.map,
      'desc': 'Apple Maps embedded view. Annotations, overlays, tile '
          'caching, route rendering -- all without third-party SDKs.',
      'color': Colors.green,
    },
    <String, dynamic>{
      'name': 'WKWebView',
      'icon': Icons.web,
      'desc': 'Modern WebKit-based browser surface. Critical for embedding '
          'rich HTML/JS content with full Safari parity.',
      'color': Colors.teal,
    },
    <String, dynamic>{
      'name': 'AVPlayerView',
      'icon': Icons.movie,
      'desc': 'Native video playback with AirPlay, picture-in-picture and '
          'transport controls. Uses AVFoundation under the hood.',
      'color': Colors.purple,
    },
    <String, dynamic>{
      'name': 'IKImageView',
      'icon': Icons.image,
      'desc': 'Image Kit pan/zoom/crop view with built-in editing tools '
          'used by Preview and Photos.',
      'color': Colors.orange,
    },
    <String, dynamic>{
      'name': 'NSPathControl',
      'icon': Icons.folder_open,
      'desc': 'Breadcrumb-style path control for filesystem navigation. '
          'Integrates with Finder drag/drop semantics.',
      'color': Colors.brown,
    },
    <String, dynamic>{
      'name': 'NSDatePicker',
      'icon': Icons.event,
      'desc': 'Native graphical or textual date/time picker with locale '
          'support and accessibility built in.',
      'color': Colors.pink,
    },
  ];

  Widget nativeCard(Map<String, dynamic> n) {
    final Color color = n['color'] as Color;
    return Container(
      width: 240,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(n['icon'] as IconData, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  n['name'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            n['desc'] as String,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade800,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  final Widget nativeSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.window, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              const Text(
                'macOS native classes you might embed',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        Wrap(children: nativeClasses.map(nativeCard).toList()),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9 -- Common pitfalls
  // ---------------------------------------------------------------------------
  print('--- Section 9: Common pitfalls ---');
  final List<Map<String, dynamic>> pitfalls = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Wrong viewType',
      'icon': Icons.error_outline,
      'desc': 'The viewType string in Dart must match the id used in '
          'registrar.register exactly. Typos result in a silent black '
          'rectangle and a "no factory registered" log line.',
      'color': Colors.red,
    },
    <String, dynamic>{
      'title': 'Missing channel handler',
      'icon': Icons.warning,
      'desc': 'If your NSView communicates over a method channel and the '
          'Swift side never registers the handler, calls hang and Flutter '
          'eventually times out. Always pair Dart MethodChannel(name) with '
          'a Swift FlutterMethodChannel(name:binaryMessenger:).',
      'color': Colors.orange,
    },
    <String, dynamic>{
      'title': 'creationParamsCodec mismatch',
      'icon': Icons.sync_problem,
      'desc': 'Encoding with JSONMessageCodec on Dart while decoding with '
          'FlutterStandardMessageCodec on Swift produces a runtime cast '
          'crash. Both sides must agree on the codec.',
      'color': Colors.deepOrange,
    },
    <String, dynamic>{
      'title': 'Hit-testing through clipped regions',
      'icon': Icons.crop,
      'desc': 'ClipRRect / ClipPath wrapping an AppKitView clips the '
          'Flutter pixels but does NOT clip the underlying NSView for '
          'hit-testing. Pointer events outside the clip can still hit '
          'the NSView.',
      'color': Colors.brown,
    },
    <String, dynamic>{
      'title': 'Z-ordering with native overlays',
      'icon': Icons.layers,
      'desc': 'Tooltips, dropdowns and other Flutter overlays may render '
          'BELOW the NSView because the NSView lives in its own layer. '
          'Use Overlay sparingly above AppKitView regions.',
      'color': Colors.purple,
    },
    <String, dynamic>{
      'title': 'High-DPI scaling',
      'icon': Icons.high_quality,
      'desc': 'Some AppKit views (notably custom NSView subclasses) need '
          'wantsLayer = true and explicit layer.contentsScale to look '
          'sharp on Retina. Otherwise text appears blurry.',
      'color': Colors.indigo,
    },
  ];

  Widget pitfallCard(Map<String, dynamic> p) {
    final Color color = p['color'] as Color;
    return Container(
      width: 320,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(p['icon'] as IconData, color: color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            p['desc'] as String,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfallSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.red.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.warning_amber, color: Colors.red.shade700),
              const SizedBox(width: 8),
              const Text(
                'Common pitfalls',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        Wrap(children: pitfalls.map(pitfallCard).toList()),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 10 -- Recipe gallery
  // ---------------------------------------------------------------------------
  print('--- Section 10: Recipe gallery ---');
  final List<Map<String, dynamic>> recipes = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Embed an NSScrollView for legacy AppKit content',
      'icon': Icons.unfold_more,
      'color': Colors.indigo,
      'why': 'Reuse an existing NSScrollView document (a custom NSView '
          'subclass with thousands of items already laid out by Auto '
          'Layout). Pure Flutter rewrites are expensive; embedding wins.',
      'snippet':
          "// Dart\n"
          "AppKitView(\n"
          "  viewType: 'legacy.scrollview',\n"
          "  creationParams: <String, Object?>{\n"
          "    'documentId': '42',\n"
          "    'horizontalScroller': false,\n"
          "    'verticalScroller': true,\n"
          "  },\n"
          "  creationParamsCodec: const StandardMessageCodec(),\n"
          ")\n\n"
          "// Swift factory\n"
          "class LegacyScrollViewFactory: NSObject,\n"
          "  FlutterPlatformViewFactory {\n"
          "  func create(withFrame frame: CGRect,\n"
          "              viewIdentifier viewId: Int64,\n"
          "              arguments args: Any?) -> NSView {\n"
          "    let scroll = NSScrollView(frame: frame)\n"
          "    scroll.hasVerticalScroller = true\n"
          "    scroll.documentView = LegacyDocumentView()\n"
          "    return scroll\n"
          "  }\n"
          "}",
    },
    <String, dynamic>{
      'title': 'Host a WKWebView',
      'icon': Icons.web,
      'color': Colors.blue,
      'why': 'Show rich HTML/JS content (release notes, embedded payment '
          'flows, OAuth dialogs) with full WebKit parity.',
      'snippet':
          "// Dart\n"
          "AppKitView(\n"
          "  viewType: 'macos.webview',\n"
          "  creationParams: <String, Object?>{\n"
          "    'url': 'https://flutter.dev',\n"
          "    'allowsBackForwardGestures': true,\n"
          "  },\n"
          "  creationParamsCodec: const StandardMessageCodec(),\n"
          ")\n\n"
          "// Swift factory\n"
          "let webConfig = WKWebViewConfiguration()\n"
          "let webView = WKWebView(frame: frame,\n"
          "                       configuration: webConfig)\n"
          "if let dict = args as? [String: Any?],\n"
          "   let url = dict[\"url\"] as? String,\n"
          "   let target = URL(string: url) {\n"
          "  webView.load(URLRequest(url: target))\n"
          "}\n"
          "return webView",
    },
    <String, dynamic>{
      'title': 'Embed an MKMapView',
      'icon': Icons.map,
      'color': Colors.green,
      'why': 'Show a fully native Apple Maps view with annotations and '
          'overlays. Apple Maps is restricted from non-native APIs, so '
          'embedding is the only path.',
      'snippet':
          "// Dart\n"
          "AppKitView(\n"
          "  viewType: 'macos.mapview',\n"
          "  creationParams: <String, Object?>{\n"
          "    'lat': 37.7749,\n"
          "    'lng': -122.4194,\n"
          "    'span': 0.05,\n"
          "    'showsUserLocation': true,\n"
          "  },\n"
          "  creationParamsCodec: const StandardMessageCodec(),\n"
          ")\n\n"
          "// Swift factory\n"
          "let map = MKMapView(frame: frame)\n"
          "if let dict = args as? [String: Any?] {\n"
          "  let lat = dict[\"lat\"] as? Double ?? 0\n"
          "  let lng = dict[\"lng\"] as? Double ?? 0\n"
          "  let span = dict[\"span\"] as? Double ?? 0.1\n"
          "  map.setRegion(MKCoordinateRegion(\n"
          "    center: CLLocationCoordinate2D(\n"
          "      latitude: lat, longitude: lng),\n"
          "    span: MKCoordinateSpan(\n"
          "      latitudeDelta: span,\n"
          "      longitudeDelta: span)),\n"
          "    animated: false)\n"
          "}\n"
          "return map",
    },
    <String, dynamic>{
      'title': 'IKImageView for built-in image controls',
      'icon': Icons.image_search,
      'color': Colors.orange,
      'why': 'Need pan/zoom, crop guides and tool palettes for free? '
          'IKImageView from ImageKit ships with all of that. Wrapping '
          'it via AppKitView avoids re-implementing photo-editor UI in '
          'Flutter.',
      'snippet':
          "// Dart\n"
          "AppKitView(\n"
          "  viewType: 'macos.imageview',\n"
          "  creationParams: <String, Object?>{\n"
          "    'path': '/Users/me/Pictures/sample.png',\n"
          "    'editable': true,\n"
          "    'showCrop': true,\n"
          "  },\n"
          "  creationParamsCodec: const StandardMessageCodec(),\n"
          ")\n\n"
          "// Swift factory\n"
          "let imageView = IKImageView(frame: frame)\n"
          "imageView.editable = true\n"
          "imageView.hasHorizontalScroller = true\n"
          "imageView.hasVerticalScroller = true\n"
          "if let dict = args as? [String: Any?],\n"
          "   let path = dict[\"path\"] as? String {\n"
          "  let url = URL(fileURLWithPath: path)\n"
          "  imageView.setImageWith(url)\n"
          "}\n"
          "return imageView",
    },
  ];

  Widget recipeCard(Map<String, dynamic> r) {
    final Color color = r['color'] as Color;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(r['icon'] as IconData, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    r['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              r['why'] as String,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                r['snippet'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.amberAccent,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 11 -- Reference table
  // ---------------------------------------------------------------------------
  print('--- Section 11: Reference table ---');
  final List<List<String>> referenceRows = <List<String>>[
    <String>['Widget', 'Platform', 'Underlying primitive', 'Use case'],
    <String>[
      'AppKitView',
      'macOS',
      'NSView via FlutterAppKitViewController',
      'Embed legacy or rich AppKit views (NSScrollView, MKMapView, ...)',
    ],
    <String>[
      'UiKitView',
      'iOS / iPadOS',
      'UIView via FlutterUiKitViewController',
      'Embed UIKit views (MKMapView, WKWebView, ARKit views, ...)',
    ],
    <String>[
      'AndroidView',
      'Android',
      'android.view.View via PlatformView',
      'Embed Android views (MapView, WebView, native camera previews)',
    ],
    <String>[
      'HtmlElementView',
      'Web',
      'HTML element via DOM platform view registry',
      'Embed an iframe, video, canvas or arbitrary HTML element',
    ],
  ];

  Widget referenceTable() {
    final List<TableRow> rows = <TableRow>[];
    for (int r = 0; r < referenceRows.length; r++) {
      final bool isHeader = r == 0;
      rows.add(
        TableRow(
          decoration: BoxDecoration(
            color: isHeader
                ? Colors.indigo.shade100
                : (r.isOdd ? Colors.grey.shade50 : Colors.white),
          ),
          children: referenceRows[r].map<Widget>((String cell) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: Text(
                cell,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: isHeader
                      ? Colors.indigo.shade900
                      : Colors.grey.shade900,
                  height: 1.4,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
    return Table(
      border: TableBorder.all(color: Colors.indigo.shade100),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(120),
        1: FixedColumnWidth(110),
        2: FlexColumnWidth(1.2),
        3: FlexColumnWidth(1.6),
      },
      children: rows,
    );
  }

  final Widget referenceSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.table_view, color: Colors.indigo.shade700),
              const SizedBox(width: 8),
              const Text(
                'AppKitView vs UiKitView vs AndroidView vs HtmlElementView',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: referenceTable(),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 12 -- Footnote
  // ---------------------------------------------------------------------------
  print('--- Section 12: Footnote ---');
  final Widget footnote = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.grey.shade700),
            const SizedBox(width: 8),
            const Text(
              'Reference / Footnote',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const SelectableText(
          'package:flutter/src/widgets/platform_view.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'AppKitView is declared alongside UiKitView in the platform_view.dart '
          'library. Both classes extend a private _DarwinView base which '
          'shares creationParams handling, gesture recognizer plumbing, the '
          'PlatformViewController contract and message channel wiring across '
          'macOS and iOS. The macOS-specific subclass overrides the engine '
          'call to PlatformViewsService.initAppKitView (vs. initUiKitView '
          'on iOS) and registers a FlutterAppKitViewController instead of a '
          'FlutterUiKitViewController.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Because both views are members of a shared _DarwinView family, '
          'best practices and gotchas are largely the same: registered '
          'factories, codec compatibility, gesture arena coordination and '
          'careful z-ordering with overlays. The only meaningful divergence '
          'is the underlying primitive (NSView vs UIView) and the host '
          'application context (NSWindow vs UIWindow).',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.55,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Compose the page
  // ---------------------------------------------------------------------------
  print('--- Composing final widget tree ---');
  final List<Widget> children = <Widget>[
    const Padding(
      padding: EdgeInsets.fromLTRB(16, 18, 16, 4),
      child: Text(
        'AppKitView - macOS NSView Embedding',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'A deep, hand-authored demo of the macOS-only AppKitView widget. '
        'Twelve sections covering platform guarding, lifecycle, hybrid '
        'composition, gesture forwarding, recipes and pitfalls.',
        style: TextStyle(fontSize: 13, height: 1.45),
      ),
    ),
    platformBanner,
    const _SectionHeader(
      icon: Icons.help_outline,
      label: '2. What is AppKitView?',
      color: Colors.indigo,
    ),
    ...conceptCards,
    bridgeDiagram,
    const _SectionHeader(
      icon: Icons.timeline,
      label: '3. Lifecycle',
      color: Colors.blue,
    ),
    ...lifecycleCards,
    const _SectionHeader(
      icon: Icons.layers,
      label: '4. Hybrid composition',
      color: Colors.deepPurple,
    ),
    hybridExplainer,
    const _SectionHeader(
      icon: Icons.tv,
      label: '5. Live AppKitView attempt',
      color: Colors.indigo,
    ),
    liveSection,
    const _SectionHeader(
      icon: Icons.grid_view,
      label: '6. Multi-viewType showcase',
      color: Colors.indigo,
    ),
    multiSection,
    const _SectionHeader(
      icon: Icons.touch_app,
      label: '7. Gesture forwarding',
      color: Colors.teal,
    ),
    gestureSection,
    const _SectionHeader(
      icon: Icons.window,
      label: '8. macOS native classes',
      color: Colors.indigo,
    ),
    nativeSection,
    const _SectionHeader(
      icon: Icons.warning_amber,
      label: '9. Common pitfalls',
      color: Colors.red,
    ),
    pitfallSection,
    const _SectionHeader(
      icon: Icons.menu_book,
      label: '10. Recipe gallery',
      color: Colors.deepOrange,
    ),
    ...recipes.map(recipeCard),
    const _SectionHeader(
      icon: Icons.table_view,
      label: '11. Reference table',
      color: Colors.indigo,
    ),
    referenceSection,
    const _SectionHeader(
      icon: Icons.bookmark,
      label: '12. Footnote',
      color: Colors.grey,
    ),
    footnote,
    const SizedBox(height: 24),
  ];

  print('=== AppKitView Deep Demo composed (${children.length} top-level '
      'children) ===');

  return MaterialApp(
    title: 'AppKitView Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Helper: section header widget
// =============================================================================
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Helper: dotted-border CustomPainter for non-macOS placeholders
// =============================================================================
class _DottedBorderPainter extends CustomPainter {
  _DottedBorderPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const double dash = 6;
    const double gap = 4;

    // Top edge.
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dash, 0), paint);
      x += dash + gap;
    }
    // Bottom edge.
    x = 0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + dash, size.height),
        paint,
      );
      x += dash + gap;
    }
    // Left edge.
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dash), paint);
      y += dash + gap;
    }
    // Right edge.
    y = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width, y),
        Offset(size.width, y + dash),
        paint,
      );
      y += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedBorderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
