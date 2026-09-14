// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — UiKitView
// Demonstrates UiKitView, a Flutter widget that embeds native iOS
// UIKit views within the Flutter widget tree via platform views.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UiKitView Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.phone_iphone,
      'title': 'What is UiKitView?',
      'body': 'UiKitView is the iOS-specific widget that embeds a native '
          'UIKit view inside Flutter\u0027s widget tree. It bridges the '
          'gap between Flutter\u0027s rendering engine and the iOS native '
          'view hierarchy.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.view_in_ar,
      'title': 'Platform View Mechanism',
      'body': 'Under the hood, a platform view allocates a native iOS '
          'UIView and composites it into Flutter\u0027s rendering. The '
          'Flutter engine positions the native view to align with '
          'the widget\u0027s layout coordinates.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.factory,
      'title': 'View Factories',
      'body': 'iOS registers a factory for each viewType string. When '
          'Flutter requests a platform view of that type, the factory '
          'creates and returns a new UIView. This is the native '
          'counterpart of Widget.build().',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.compare,
      'title': 'iOS vs Android',
      'body': 'UiKitView is the iOS twin of AndroidView. On Android, '
          'AndroidView embeds a native Android View. On Web, '
          'HtmlElementView embeds DOM elements. Each uses the same '
          'concept but targets different platforms.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'viewType',
      'type': 'String',
      'desc': 'Identifier for the native view factory. Must match the '
          'string registered in the iOS app delegate via '
          'registerViewFactory. This is how Flutter finds which '
          'native view to create.',
    },
    {
      'name': 'onPlatformViewCreated',
      'type': 'PlatformViewCreatedCallback?',
      'desc': 'Called when the native UIView has been created. Receives '
          'the platform view ID (int) that can be used to communicate '
          'with the native view through method channels.',
    },
    {
      'name': 'hitTestBehavior',
      'type': 'PlatformViewHitTestBehavior',
      'desc': 'Controls how touches are routed to the native view. '
          'opaque: all touches go to native. translucent: both '
          'Flutter and native receive touches. transparent: '
          'Flutter gets all touches.',
    },
    {
      'name': 'layoutDirection',
      'type': 'TextDirection?',
      'desc': 'Controls the directionality of the native view. If null '
          'the ambient directionality from the widget tree is used. '
          'Affects RTL layout behavior of the embedded UIView.',
    },
    {
      'name': 'creationParams',
      'type': 'dynamic',
      'desc': 'Optional parameters passed to the native factory when '
          'creating the view. Encoded using creationParamsCodec '
          'before sending over the platform channel.',
    },
    {
      'name': 'creationParamsCodec',
      'type': 'MessageCodec?',
      'desc': 'Codec for serializing creationParams. Common options: '
          'StandardMessageCodec (default), JSONMessageCodec, '
          'StringCodec, or BinaryCodec for raw bytes.',
    },
    {
      'name': 'gestureRecognizers',
      'type': 'Set<Factory<OneSequenceGestureRecognizer>>?',
      'desc': 'Gesture recognizers that should be applied to the '
          'platform view. These compete in the gesture arena with '
          'Flutter gestures to determine who handles touch events.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.indigo.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ae['type']!,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Platform Channels
  // ============================================================
  print('=== Section 3: Platform Channels ===');

  final channelSteps = <Map<String, dynamic>>[
    {
      'step': '1. Register Factory (Swift)',
      'desc': 'In AppDelegate.swift or a plugin, call '
          'registrar.register(factory, withId: "my-view"). The factory '
          'conforms to FlutterPlatformViewFactory and returns a UIView.',
      'icon': Icons.app_registration,
      'color': Colors.indigo,
    },
    {
      'step': '2. Create UiKitView (Dart)',
      'desc': 'In your Flutter widget tree, add UiKitView(viewType: '
          '"my-view"). Flutter sends a create message to iOS over the '
          'platform view channel.',
      'icon': Icons.widgets,
      'color': Colors.blue,
    },
    {
      'step': '3. Factory Invoked (iOS)',
      'desc': 'iOS receives the create request and calls the registered '
          'factory. The factory returns a UIView instance. '
          'creationParams (if any) are deserialized and passed in.',
      'icon': Icons.build_circle,
      'color': Colors.green,
    },
    {
      'step': '4. View Composited (Engine)',
      'desc': 'The Flutter engine composites the native UIView into its '
          'rendering surface. The view appears at the correct position '
          'and size dictated by Flutter\u0027s layout.',
      'icon': Icons.layers,
      'color': Colors.orange,
    },
    {
      'step': '5. Method Channel (Bidirectional)',
      'desc': 'The platform view ID from onPlatformViewCreated enables '
          'two-way communication. Dart sends commands to the native '
          'view; the native view can send events back.',
      'icon': Icons.swap_horiz,
      'color': Colors.purple,
    },
    {
      'step': '6. Dispose (Dart/iOS)',
      'desc': 'When the UiKitView widget is removed from the tree, '
          'Flutter sends a dispose message. The iOS side deallocates '
          'the UIView and cleans up resources.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
  ];

  final channelWidgets = <Widget>[];
  for (var i = 0; i < channelSteps.length; i++) {
    final cs = channelSteps[i];
    final csColor = cs['color'] as Color;
    print('Channel ${i + 1}: ${cs['step']}');
    channelWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: csColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    cs['icon'] as IconData,
                    color: csColor,
                    size: 18,
                  ),
                ),
                if (i < channelSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: csColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: csColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: csColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cs['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: csColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      cs['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
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

  // ============================================================
  // SECTION 4: Lifecycle
  // ============================================================
  print('=== Section 4: Lifecycle ===');

  final lifecyclePhases = <Map<String, dynamic>>[
    {
      'phase': 'Initialization',
      'events': [
        'Widget inserted into tree',
        'PlatformViewsService.initUiKitView() called',
        'Native factory produces UIView',
        'onPlatformViewCreated fires with view ID',
      ],
      'color': Colors.indigo,
    },
    {
      'phase': 'Active',
      'events': [
        'UIView composited into Flutter surface',
        'Touch events routed per hitTestBehavior',
        'Method channels active for communication',
        'Layout updates forwarded to native sizing',
      ],
      'color': Colors.green,
    },
    {
      'phase': 'Update',
      'events': [
        'Widget rebuilt with new parameters',
        'creationParams changes trigger view recreation',
        'hitTestBehavior changes update touch routing',
        'layoutDirection updates forwarded to native',
      ],
      'color': Colors.orange,
    },
    {
      'phase': 'Disposal',
      'events': [
        'Widget removed from tree',
        'Dispose message sent to iOS',
        'Native UIView deallocated',
        'Method channel cleaned up',
      ],
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecyclePhases.length; i++) {
    final lp = lifecyclePhases[i];
    final lpColor = lp['color'] as Color;
    final events = lp['events'] as List<dynamic>;
    print('Lifecycle ${i + 1}: ${lp['phase']}');

    final eventWidgets = <Widget>[];
    for (var j = 0; j < events.length; j++) {
      eventWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lpColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  events[j] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: lpColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: lpColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: lpColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: lpColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  lp['phase'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: lpColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...eventWidgets,
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Gesture Handling
  // ============================================================
  print('=== Section 5: Gesture Handling ===');

  final gestureTopics = <Map<String, dynamic>>[
    {
      'title': 'opaque',
      'subtitle': 'PlatformViewHitTestBehavior.opaque',
      'desc': 'All touch events go to the native view. Flutter widgets '
          'behind the platform view receive no touches. Use this '
          'when the native view needs full touch control.',
      'useCase': 'MKMapView, in-app browser, native video player',
      'color': Colors.indigo,
    },
    {
      'title': 'translucent',
      'subtitle': 'PlatformViewHitTestBehavior.translucent',
      'desc': 'Both the native view and Flutter receive touches. The '
          'gesture arena decides the winner. Use for native views '
          'that need touches but Flutter also has gesture handlers.',
      'useCase': 'Interactive native chart with Flutter overlay controls',
      'color': Colors.blue,
    },
    {
      'title': 'transparent',
      'subtitle': 'PlatformViewHitTestBehavior.transparent',
      'desc': 'All touch events go to Flutter. The native view is purely '
          'visual and does not receive any touches. Use for display-only '
          'native views like a WKWebView showing static content.',
      'useCase': 'Native ad view, static native label, preview panels',
      'color': Colors.green,
    },
    {
      'title': 'Custom Recognizers',
      'subtitle': 'gestureRecognizers parameter',
      'desc': 'You can pass a set of gesture recognizer factories to '
          'compete in Flutter\u0027s gesture arena. A HorizontalDragGR '
          'or PanGR can be used to ensure the platform view wins '
          'specific gestures.',
      'useCase': 'Map view that must handle pan but allows Flutter scroll',
      'color': Colors.orange,
    },
  ];

  final gestureWidgets = <Widget>[];
  for (var i = 0; i < gestureTopics.length; i++) {
    final gt = gestureTopics[i];
    final gtColor = gt['color'] as Color;
    print('Gesture ${i + 1}: ${gt['title']}');
    gestureWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: gtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: gtColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: gtColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      gt['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: gtColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                gt['subtitle'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                gt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: gtColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '\u2714 ${gt['useCase']}',
                  style: TextStyle(
                    fontSize: 10,
                    color: gtColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Composition Modes
  // ============================================================
  print('=== Section 6: Composition Modes ===');

  final compositionModes = <Map<String, dynamic>>[
    {
      'title': 'Hybrid Composition',
      'desc': 'The default on iOS. The native UIView is placed in the '
          'native view hierarchy and Flutter paints over/under using '
          'multiple layers. Supports all UIKit features but may have '
          'slight performance overhead from layer composition.',
      'pros': [
        'Full native accessibility support',
        'Correct z-ordering with all native APIs',
        'Keyboard input works reliably',
        'Supports native animations',
      ],
      'cons': [
        'Additional compositing cost per frame',
        'Thread synchronization between UI and raster',
        'Memory overhead for extra layers',
      ],
      'color': Colors.indigo,
    },
    {
      'title': 'Virtual Display (Android-only)',
      'desc': 'Android can render platform views into a texture which '
          'Flutter composites. This mode is NOT used by UiKitView on '
          'iOS. Mentioned here for completeness when comparing '
          'AndroidView strategies.',
      'pros': [
        'Lower compositing overhead',
        'Better integration with flutter rendering pipeline',
        'No z-ordering issues',
      ],
      'cons': [
        'Not available on iOS',
        'Accessibility may be limited',
        'Some native views render incorrectly',
        'No keyboard support',
      ],
      'color': Colors.grey,
    },
  ];

  final compositionWidgets = <Widget>[];
  for (var i = 0; i < compositionModes.length; i++) {
    final cm = compositionModes[i];
    final cmColor = cm['color'] as Color;
    final pros = cm['pros'] as List<dynamic>;
    final cons = cm['cons'] as List<dynamic>;
    print('Composition ${i + 1}: ${cm['title']}');

    final prosWidgets = <Widget>[];
    for (final p in pros) {
      prosWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('\u2714 ', style: TextStyle(
                color: Colors.green, fontSize: 11)),
              Expanded(
                child: Text(
                  p as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final consWidgets = <Widget>[];
    for (final c in cons) {
      consWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('\u2718 ', style: TextStyle(
                color: Colors.red, fontSize: 11)),
              Expanded(
                child: Text(
                  c as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    compositionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: cmColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cmColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cm['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: cmColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cm['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advantages',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...prosWidgets,
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Limitations',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...consWidgets,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Cross-Platform Comparison
  // ============================================================
  print('=== Section 7: Comparison ===');

  final platformViews = <Map<String, dynamic>>[
    {
      'widget': 'UiKitView',
      'platform': 'iOS',
      'native': 'UIView (UIKit)',
      'composition': 'Hybrid',
      'color': Colors.indigo,
    },
    {
      'widget': 'AndroidView',
      'platform': 'Android',
      'native': 'android.view.View',
      'composition': 'Hybrid / Virtual Display',
      'color': Colors.green,
    },
    {
      'widget': 'HtmlElementView',
      'platform': 'Web',
      'native': 'HTML Element (DOM)',
      'composition': 'CSS overlay',
      'color': Colors.blue,
    },
    {
      'widget': 'AppKitView',
      'platform': 'macOS',
      'native': 'NSView (AppKit)',
      'composition': 'Hybrid',
      'color': Colors.purple,
    },
  ];

  final comparisonWidgets = <Widget>[];
  for (var i = 0; i < platformViews.length; i++) {
    final pv = platformViews[i];
    final pvColor = pv['color'] as Color;
    print('Comparison ${i + 1}: ${pv['widget']}');
    comparisonWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: pvColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: pvColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: pvColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  pv['platform'] as String,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: pvColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pv['widget'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: pvColor,
                    ),
                  ),
                  Text(
                    'Native: ${pv['native']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'Composition: ${pv['composition']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Maps (MKMapView / Google Maps)',
      'desc': 'Embed native map controls with gesture support.',
      'color': Colors.indigo,
    },
    {
      'title': 'WebView (WKWebView)',
      'desc': 'Display web content with full browser capabilities.',
      'color': Colors.blue,
    },
    {
      'title': 'Native Camera Preview',
      'desc': 'Show camera feed using AVCaptureVideoPreviewLayer.',
      'color': Colors.green,
    },
    {
      'title': 'Ad SDKs (GADBannerView)',
      'desc': 'Render native ads from iOS SDKs like AdMob.',
      'color': Colors.orange,
    },
    {
      'title': 'Video Player (AVPlayerViewController)',
      'desc': 'Embed native video playback with system controls.',
      'color': Colors.purple,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: ucColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ucColor.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: ucColor, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ucColor,
                    ),
                  ),
                  Text(
                    uc['desc'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.phone_iphone,
      'text': 'UiKitView embeds native iOS UIKit views in the '
          'Flutter widget tree via platform view composition.',
    },
    {
      'icon': Icons.factory,
      'text': 'viewType string maps to a native factory registered '
          'in iOS code. The factory creates UIView instances.',
    },
    {
      'icon': Icons.swap_horiz,
      'text': 'onPlatformViewCreated callback provides the view ID '
          'for bidirectional Method Channel communication.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'hitTestBehavior (opaque/translucent/transparent) and '
          'gestureRecognizers control touch routing.',
    },
    {
      'icon': Icons.layers,
      'text': 'iOS uses Hybrid Composition: native view in view hierarchy '
          'with Flutter layers above and below.',
    },
    {
      'icon': Icons.compare,
      'text': 'Counterparts: AndroidView (Android), HtmlElementView (Web), '
          'AppKitView (macOS) — same concept, different platforms.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('UiKitView'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.cable), text: 'Channels'),
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.touch_app), text: 'Gestures'),
            Tab(icon: Icon(Icons.layers), text: 'Compose'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1 — Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'UiKitView: embed native iOS UIKit views in Flutter\u0027s '
                  'widget tree using platform view composition.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2 — API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor parameters for UiKitView widget.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3 — Channels
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How Flutter communicates with the native iOS view.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...channelWidgets,
            ],
          ),
          // Tab 4 — Lifecycle
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Platform view lifecycle from creation to disposal.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
            ],
          ),
          // Tab 5 — Gestures
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Touch routing between Flutter and native iOS views.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...gestureWidgets,
            ],
          ),
          // Tab 6 — Composition
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How native views are composited into the Flutter surface.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compositionWidgets,
            ],
          ),
          // Tab 7 — Comparison
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Platform view widgets across iOS, Android, Web, and macOS.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...comparisonWidgets,
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common use cases for UiKitView:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),
          // Tab 8 — Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about UiKitView.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
