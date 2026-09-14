// ignore_for_file: avoid_print
// D4rt deep demo: PlatformViewController — abstract base for controlling
// embedded platform views (Android Views, iOS UIViews) within Flutter.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Violet / Lavender palette ───
  const Color violet = Color(0xFF7C3AED);
  const Color lavender = Color(0xFFC4B5FD);
  const Color deepViolet = Color(0xFF5B21B6);
  const Color paleViolet = Color(0xFFEDE9FE);
  const Color amethyst = Color(0xFF8B5CF6);
  const Color plum = Color(0xFF6D28D9);
  const Color wisteria = Color(0xFFA78BFA);
  const Color grape = Color(0xFF4C1D95);
  const Color lilac = Color(0xFFF5F3FF);
  const Color orchid = Color(0xFFDDD6FE);

  print('[pv] ===== PLATFORM VIEW CONTROLLER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget pvBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [grape, deepViolet],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grape.withValues(alpha: 0.35),
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
              color: violet,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: lavender, width: 1.5),
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

  Widget pvNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleViolet,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lavender),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: grape.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget pvCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lavender.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: grape.withValues(alpha: 0.06),
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
              color: violet.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: grape)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget pvRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? violet.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: lavender.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? grape : deepViolet)),
          );
        }).toList(),
      ),
    );
  }

  Widget pvFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? grape : deepViolet,
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
          child: Icon(Icons.arrow_forward, size: 12, color: violet),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is PlatformViewController? ━━━━━━
  print('[pv-01] Section 1: What is PlatformViewController?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('01', 'What Is PlatformViewController?'),
      pvNote(
        'PlatformViewController is the abstract base class for controlling '
        'a platform view — a native OS view embedded inside the Flutter '
        'widget tree. Android uses AndroidView, iOS uses UiKitView, and '
        'each has a controller conforming to this interface.',
      ),
      pvCard(
        'Controller Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pvFlow(['PlatformViewController', 'Platform channel', 'Native view',
                'OS rendering']),
            const SizedBox(height: 10),
            _pvRoleBadge('Creates', 'Instantiates the native view', grape),
            _pvRoleBadge('Resizes', 'Sends new size to platform', deepViolet),
            _pvRoleBadge('Dispatches', 'Forwards pointer events', plum),
            _pvRoleBadge('Disposes', 'Destroys native resource', violet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Lifecycle ━━━━━━
  print('[pv-02] Section 2: Lifecycle');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('02', 'Platform View Lifecycle'),
      pvNote(
        'A platform view goes through create → resize → display → dispose. '
        'The create call sends creation params and a viewType string to '
        'the platform. The engine returns a viewId used for all subsequent '
        'operations.',
      ),
      pvCard(
        'Lifecycle Phases',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pvPhaseItem(1, 'create()', 'Send viewType + params', grape),
            _pvPhaseItem(2, 'Receive viewId', 'Engine assigns unique ID', deepViolet),
            _pvPhaseItem(3, 'clearFocus()', 'Called when losing focus', plum),
            _pvPhaseItem(4, 'dispatchPointerEvent()', 'Forward touches', violet),
            _pvPhaseItem(5, 'dispose()', 'Destroy native view', amethyst),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Android implementation ━━━━━━
  print('[pv-03] Section 3: Android implementation');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('03', 'Android Platform Views'),
      pvNote(
        'On Android, platform views use either Virtual Display (legacy) '
        'or Hybrid Composition. Virtual Display renders to an off-screen '
        'surface that Flutter composites. Hybrid Composition places the '
        'view directly in the view hierarchy.',
      ),
      pvCard(
        'Android Rendering Modes',
        Column(
          children: [
            pvRow(['Mode', 'How', 'Perf', 'Compat'], isHeader: true),
            pvRow(['Virtual Display', 'Off-screen surface', 'Good', 'Some issues']),
            pvRow(['Hybrid Composition', 'Real view hierarchy', 'Varies', 'Full']),
            pvRow(['Texture Layer', 'Draw to texture', 'Best', 'Limited']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: iOS implementation ━━━━━━
  print('[pv-04] Section 4: iOS implementation');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('04', 'iOS Platform Views (UiKitView)'),
      pvNote(
        'On iOS, UiKitView embeds a UIView. Composition happens via '
        'the Skia/Impeller compositor which threads the UIView into the '
        'Flutter layer tree. The controller manages the UIView reference '
        'and handles hit testing.',
      ),
      pvCard(
        'iOS vs Android',
        Column(
          children: [
            pvRow(['Aspect', 'Android', 'iOS'], isHeader: true),
            pvRow(['Widget', 'AndroidView', 'UiKitView']),
            pvRow(['View', 'android.view.View', 'UIView']),
            pvRow(['Composition', 'Hybrid/Virtual', 'Layer insert']),
            pvRow(['Focus', 'Full support', 'Limited']),
            pvRow(['Touch', 'MotionEvent', 'UITouch forwarding']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: viewType and factory ━━━━━━
  print('[pv-05] Section 5: viewType and factory');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('05', 'ViewType and PlatformViewFactory'),
      pvNote(
        'Each platform view is identified by a viewType string. The native '
        'side registers a PlatformViewFactory for that type. Flutter sends '
        'the viewType + creation params; the factory creates the native '
        'view and returns it.',
      ),
      pvCard(
        'Registration Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pvFlow(['Register factory', 'Flutter creates widget',
                'Engine calls factory', 'Native view returned']),
            const SizedBox(height: 10),
            _pvKeyValue('viewType', '"my_google_map"', grape),
            _pvKeyValue('Registration', 'registerViewFactory(type, factory)', deepViolet),
            _pvKeyValue('Params', 'creationParams + codec', plum),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Pointer event dispatch ━━━━━━
  print('[pv-06] Section 6: Pointer events');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('06', 'Pointer Event Dispatching'),
      pvNote(
        'Touch events that hit the platform view area must be forwarded '
        'to the native view. dispatchPointerEvent() converts Flutter\'s '
        'PointerEvent to the platform format (MotionEvent on Android, '
        'UITouch on iOS) and sends it through the channel.',
      ),
      pvCard(
        'Event Translation',
        Column(
          children: [
            pvRow(['Flutter Event', 'Android', 'iOS'], isHeader: true),
            pvRow(['PointerDownEvent', 'ACTION_DOWN', 'touchesBegan']),
            pvRow(['PointerMoveEvent', 'ACTION_MOVE', 'touchesMoved']),
            pvRow(['PointerUpEvent', 'ACTION_UP', 'touchesEnded']),
            pvRow(['PointerCancelEvent', 'ACTION_CANCEL', 'touchesCancelled']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Focus management ━━━━━━
  print('[pv-07] Section 7: Focus management');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('07', 'Focus Management'),
      pvNote(
        'clearFocus() tells the platform view to resign its input focus. '
        'Platform views must cooperate with Flutter\'s focus system — when '
        'Flutter\'s FocusNode requests focus away, the controller calls '
        'clearFocus to unfocus the native view.',
      ),
      pvCard(
        'Focus Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pvPhaseItem(1, 'User taps Flutter widget', 'Focus moves to Flutter', grape),
            _pvPhaseItem(2, 'FocusNode.requestFocus()', 'Flutter widget gets focus', deepViolet),
            _pvPhaseItem(3, 'controller.clearFocus()', 'Native view loses focus', plum),
            _pvPhaseItem(4, 'Native keyboard dismissed', 'If applicable', violet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Creation parameters ━━━━━━
  print('[pv-08] Section 8: Creation parameters');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('08', 'Creation Parameters'),
      pvNote(
        'Creation parameters are passed from Dart to native when the view '
        'is created. They are encoded using a MessageCodec (usually '
        'StandardMessageCodec). The native factory receives these bytes '
        'and decodes them to configure the view.',
      ),
      pvCard(
        'Parameter Options',
        Column(
          children: [
            pvRow(['Parameter', 'Type', 'Purpose'], isHeader: true),
            pvRow(['creationParams', 'dynamic', 'Configuration data']),
            pvRow(['creationParamsCodec', 'MessageCodec', 'Serialization']),
            pvRow(['layoutDirection', 'TextDirection', 'RTL/LTR']),
            pvRow(['gestureRecognizers', 'Set<Factory>', 'Touch ownership']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Gesture recognizers ━━━━━━
  print('[pv-09] Section 9: Gesture recognizers');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('09', 'Gesture Recognizer Integration'),
      pvNote(
        'gestureRecognizers controls which gestures the platform view '
        'claims vs which Flutter handles. By default, the platform view '
        'accepts all touches. Adding specific recognizers like panGesture '
        'lets Flutter win the gesture arena for those.',
      ),
      pvCard(
        'Gesture Ownership',
        Column(
          children: [
            pvRow(['Configuration', 'Behavior', 'Use Case'], isHeader: true),
            pvRow(['Empty set', 'Platform gets all', 'Maps, WebView']),
            pvRow(['HorizontalDrag', 'Flutter gets horizontal', 'Side swipe']),
            pvRow(['VerticalDrag', 'Flutter gets vertical', 'Scrollable host']),
            pvRow(['LongPress', 'Flutter gets long press', 'Context menu']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Sizing and layout ━━━━━━
  print('[pv-10] Section 10: Sizing and layout');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('10', 'Sizing and Layout'),
      pvNote(
        'The Flutter layout system determines the size of the platform '
        'view. The controller receives the new size and forwards it to '
        'the native view. On Android with Virtual Display the surface is '
        'recreated; Hybrid Composition adjusts the layout params.',
      ),
      pvCard(
        'Size Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pvFlow(['Flutter layout', 'RenderBox.size', 'Controller resize',
                'Native layout', 'Render']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Platform channels ━━━━━━
  print('[pv-11] Section 11: Platform channels');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('11', 'Communication via Platform Channels'),
      pvNote(
        'Platform views communicate using MethodChannel calls. The view '
        'controller sends method calls to create, resize, dispose the '
        'native view. The native side can also send events back (e.g., '
        'map camera changed, WebView page loaded).',
      ),
      pvCard(
        'Channel Messages',
        Column(
          children: [
            pvRow(['Direction', 'Message', 'Purpose'], isHeader: true),
            pvRow(['Dart → Native', 'create', 'Instantiate view']),
            pvRow(['Dart → Native', 'dispose', 'Destroy view']),
            pvRow(['Dart → Native', 'resize', 'Set new size']),
            pvRow(['Dart → Native', 'touch', 'Forward pointer']),
            pvRow(['Native → Dart', 'onEvent', 'View callbacks']),
            pvRow(['Native → Dart', 'focusChanged', 'Focus state']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Composition strategies ━━━━━━
  print('[pv-12] Section 12: Composition strategies');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('12', 'Composition Strategies'),
      pvNote(
        'Flutter must composite native views with its own rendering. Three '
        'strategies exist: texture (render to texture, most efficient), '
        'hybrid (real view in hierarchy), virtual display (off-screen '
        'surface). The strategy affects z-ordering and clipping.',
      ),
      pvCard(
        'Strategy Comparison',
        Column(
          children: [
            pvRow(['Aspect', 'Texture', 'Hybrid', 'Virtual'], isHeader: true),
            pvRow(['Z-order', 'Correct', 'May break', 'Correct']),
            pvRow(['Clipping', 'Full', 'Limited', 'Full']),
            pvRow(['Perf', 'Best', 'Variable', 'Good']),
            pvRow(['Accessibility', 'Limited', 'Full', 'Limited']),
            pvRow(['Keyboard', 'Issues', 'Full', 'Issues']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Common platform views ━━━━━━
  print('[pv-13] Section 13: Common platform views');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('13', 'Common Platform View Widgets'),
      pvNote(
        'Several popular Flutter packages use platform views: Google Maps '
        '(native map), WebView (browser), video player, ad views, and '
        'camera preview. Each registers a viewType and a native factory.',
      ),
      pvCard(
        'Ecosystem',
        Column(
          children: [
            pvRow(['Package', 'Native View', 'Platform'], isHeader: true),
            pvRow(['google_maps_flutter', 'MapView', 'Both']),
            pvRow(['webview_flutter', 'WKWebView/WebView', 'Both']),
            pvRow(['video_player', 'PlayerView', 'Both']),
            pvRow(['camera', 'CameraPreview', 'Both']),
            pvRow(['google_mobile_ads', 'BannerAdView', 'Both']),
            pvRow(['pdfx', 'PDFView', 'Both']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Performance ━━━━━━
  print('[pv-14] Section 14: Performance');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('14', 'Performance Considerations'),
      pvNote(
        'Platform views are expensive. Each view requires a native surface, '
        'synchronization between rendering engines, and thread hopping. '
        'Minimize the number of simultaneous platform views. Avoid placing '
        'them in scrollable lists.',
      ),
      pvCard(
        'Performance Tips',
        Column(
          children: [
            pvRow(['Problem', 'Cause', 'Mitigation'], isHeader: true),
            pvRow(['Jank on scroll', 'Surface sync', 'Avoid in ListView']),
            pvRow(['Memory spike', 'Native surface alloc', 'Limit count']),
            pvRow(['Thread contention', 'Main/UI thread', 'Async init']),
            pvRow(['Slow creation', 'Native init', 'Lazy instantiate']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Web platform views ━━━━━━
  print('[pv-15] Section 15: Web platform views');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('15', 'Platform Views on Web'),
      pvNote(
        'On web, platform views embed HTML elements (iframes, divs, canvas) '
        'into the Flutter rendering. HtmlElementView is the widget. The '
        'browser handles composition naturally. Performance is generally '
        'better than mobile platform views.',
      ),
      pvCard(
        'Web Platform View',
        Column(
          children: [
            pvRow(['Aspect', 'Mobile', 'Web'], isHeader: true),
            pvRow(['Widget', 'AndroidView/UiKitView', 'HtmlElementView']),
            pvRow(['Element', 'Native view', 'HTML element']),
            pvRow(['Composition', 'Surface sync', 'CSS z-index']),
            pvRow(['Performance', 'Expensive', 'Lightweight']),
            pvRow(['Interaction', 'Event forwarding', 'Native DOM events']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[pv-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pvBanner('16', 'Summary Dashboard'),
      pvCard(
        'PlatformViewController — Complete',
        Column(
          children: [
            pvRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            pvRow(['What', 'S01', 'Abstract native view controller']),
            pvRow(['Lifecycle', 'S02', 'create → resize → dispose']),
            pvRow(['Android', 'S03', 'Virtual/Hybrid/Texture']),
            pvRow(['iOS', 'S04', 'UiKitView + layer insert']),
            pvRow(['viewType', 'S05', 'Factory registration']),
            pvRow(['Pointer', 'S06', 'dispatchPointerEvent']),
            pvRow(['Focus', 'S07', 'clearFocus coordination']),
            pvRow(['Params', 'S08', 'creationParams + codec']),
            pvRow(['Gestures', 'S09', 'Recognizer ownership']),
            pvRow(['Sizing', 'S10', 'Flutter layout → native']),
            pvRow(['Channels', 'S11', 'Two-way method calls']),
            pvRow(['Composition', 'S12', 'Texture/Hybrid/Virtual']),
            pvRow(['Ecosystem', 'S13', 'Maps, WebView, Camera...']),
            pvRow(['Perf', 'S14', 'Minimize count, avoid lists']),
            pvRow(['Web', 'S15', 'HtmlElementView, lightweight']),
          ],
        ),
      ),
      pvCard(
        'Violet / Lavender Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pvColorSwatch('Violet', violet),
            _pvColorSwatch('Lavender', lavender),
            _pvColorSwatch('Amethyst', amethyst),
            _pvColorSwatch('Plum', plum),
            _pvColorSwatch('Grape', grape),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [grape, deepViolet],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('PlatformViewController — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From abstract controller through Android/iOS implementations, '
              'touch dispatch, focus management, composition strategies, '
              'and web platform views — the full embedding story.',
              style: TextStyle(color: orchid, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[pv] palette: $wisteria, $orchid, $lilac, $amethyst');
  print('[pv] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('PlatformViewController — Native View Embedding'),
        backgroundColor: grape,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFCFBFF),
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

Widget _pvRoleBadge(String role, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
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
        SizedBox(
          width: 70,
          child: Text(role,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _pvPhaseItem(int num, String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 9,
                      color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pvKeyValue(String key, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(key,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 10, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _pvColorSwatch(String name, Color color) {
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
