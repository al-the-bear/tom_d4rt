// ignore_for_file: avoid_print
// D4rt deep demo: PlatformViewsService — the singleton that manages creation,
// configuration, and disposal of all platform views in a Flutter application.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Forest / Sage palette ───
  const Color forest = Color(0xFF2D6A4F);
  const Color sage = Color(0xFF95D5B2);
  const Color deepForest = Color(0xFF1B4332);
  const Color paleSage = Color(0xFFD8F3DC);
  const Color emerald = Color(0xFF40916C);
  const Color moss = Color(0xFF52B788);
  const Color fern = Color(0xFF74C69D);
  const Color pine = Color(0xFF1B4332);
  const Color mint = Color(0xFFB7E4C7);
  const Color ivy = Color(0xFF2D6A4F);

  print('[ps] ===== PLATFORM VIEWS SERVICE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget psBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [pine, deepForest],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: pine.withValues(alpha: 0.35),
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
              color: emerald,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sage, width: 1.5),
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

  Widget psNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleSage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mint),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepForest.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget psCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: pine.withValues(alpha: 0.06),
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
              color: forest.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepForest)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget psRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? forest.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: sage.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? deepForest : forest)),
          );
        }).toList(),
      ),
    );
  }

  Widget psFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? pine : deepForest,
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
          child: Icon(Icons.arrow_forward, size: 12, color: emerald),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is PlatformViewsService? ━━━━━━
  print('[ps-01] Section 1: What is PlatformViewsService?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('01', 'What Is PlatformViewsService?'),
      psNote(
        'PlatformViewsService is the singleton that manages all platform '
        'views in a Flutter application. It provides methods to create '
        'Android views (virtual display, surface, expensive) and iOS '
        'UiKitViews. It acts as the bridge between the Flutter framework '
        'and the engine\'s platform view support.',
      ),
      psCard(
        'Service Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            psFlow(['Flutter widget', 'PlatformViewsService', 'Engine channel',
                'Native view factory', 'OS view']),
            const SizedBox(height: 10),
            _psRoleBadge('Creates', 'Sends creation request to engine', pine),
            _psRoleBadge('Manages', 'Tracks viewId lifecycle', deepForest),
            _psRoleBadge('Dispatches', 'Forwards pointer events', emerald),
            _psRoleBadge('Disposes', 'Cleans up native resources', forest),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: initAndroidView ━━━━━━
  print('[ps-02] Section 2: initAndroidView');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('02', 'initAndroidView — Virtual Display'),
      psNote(
        'initAndroidView creates an Android platform view that renders '
        'via Virtual Display. The native view is drawn to an off-screen '
        'surface, which Flutter composites as a texture layer. This was '
        'the original rendering mode — good performance but some '
        'compatibility issues with keyboard and accessibility.',
      ),
      psCard(
        'Virtual Display Rendering',
        Column(
          children: [
            psRow(['Aspect', 'Detail', 'Impact'], isHeader: true),
            psRow(['Rendering', 'Off-screen surface', 'Texture composited']),
            psRow(['Keyboard', 'Limited support', 'May not show']),
            psRow(['Accessibility', 'Limited', 'Screen reader issues']),
            psRow(['Clipping', 'Full support', 'Clip paths work']),
            psRow(['Z-ordering', 'Correct', 'No overlap issues']),
            psRow(['Performance', 'Good', 'Low overhead']),
          ],
        ),
      ),
      psCard(
        'Creation Parameters',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleSage,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _psCodeLine('PlatformViewsService.initAndroidView(', pine),
              _psCodeLine('  id: uniqueId,', deepForest),
              _psCodeLine('  viewType: "my_native_view",', deepForest),
              _psCodeLine('  layoutDirection: TextDirection.ltr,', deepForest),
              _psCodeLine('  creationParams: <String, dynamic>{', deepForest),
              _psCodeLine('    "apiKey": "xxx",', emerald),
              _psCodeLine('  },', deepForest),
              _psCodeLine('  creationParamsCodec: StandardMessageCodec(),', deepForest),
              _psCodeLine(')', pine),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: initSurfaceAndroidView ━━━━━━
  print('[ps-03] Section 3: initSurfaceAndroidView');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('03', 'initSurfaceAndroidView — Hybrid Composition'),
      psNote(
        'initSurfaceAndroidView creates an Android view using Hybrid '
        'Composition mode. The native view is placed directly in the '
        'Android view hierarchy and synchronized with Flutter\'s frame. '
        'This provides full keyboard and accessibility support but may '
        'have performance overhead from thread synchronization.',
      ),
      psCard(
        'Hybrid Composition Benefits',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _psCompareRow('Keyboard', Icons.check_circle, 'Full support', forest),
            _psCompareRow('Accessibility', Icons.check_circle, 'Full support', forest),
            _psCompareRow('Text input', Icons.check_circle, 'Works natively', forest),
            _psCompareRow('Clipping', Icons.warning, 'May have issues', emerald),
            _psCompareRow('Z-ordering', Icons.warning, 'Complex layering', emerald),
            _psCompareRow('Performance', Icons.info, 'Thread sync cost', moss),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: initExpensiveAndroidView ━━━━━━
  print('[ps-04] Section 4: initExpensiveAndroidView');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('04', 'initExpensiveAndroidView'),
      psNote(
        'initExpensiveAndroidView creates a hybrid composition view, '
        'similar to initSurfaceAndroidView, but marks the view as '
        '"expensive" for the framework. The framework may optimize layout '
        'and painting around expensive views — for example, avoiding '
        'unnecessary recompositing of the surrounding layer tree.',
      ),
      psCard(
        'When to Use Expensive',
        Column(
          children: [
            psRow(['Scenario', 'Use Expensive?', 'Reason'], isHeader: true),
            psRow(['Google Maps', 'Yes', 'Heavy native rendering']),
            psRow(['WebView', 'Yes', 'Complex DOM rendering']),
            psRow(['Simple ad banner', 'No', 'Lightweight view']),
            psRow(['Video player', 'Yes', 'GPU-intensive']),
            psRow(['Custom form field', 'No', 'Simple input']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: initUiKitView ━━━━━━
  print('[ps-05] Section 5: initUiKitView');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('05', 'initUiKitView — iOS Platform View'),
      psNote(
        'initUiKitView creates an iOS platform view (UIView) embedded in '
        'the Flutter widget tree. The iOS compositor threads the UIView '
        'into the Impeller/Skia layer tree. iOS only has one composition '
        'mode — no virtual display or hybrid choice.',
      ),
      psCard(
        'iOS View Details',
        Column(
          children: [
            psRow(['Property', 'Value', 'Note'], isHeader: true),
            psRow(['Widget', 'UiKitView', 'iOS only']),
            psRow(['Composition', 'Layer insert', 'Single mode']),
            psRow(['Touch', 'UITouch forwarding', 'Intercepted by Flutter']),
            psRow(['Focus', 'Limited', 'No FocusNode bridge']),
            psRow(['Gesture', 'gestureRecognizers', 'Arena ownership']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Creation parameters in detail ━━━━━━
  print('[ps-06] Section 6: Creation parameters');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('06', 'Creation Parameters'),
      psNote(
        'All init methods accept creationParams — arbitrary data serialized '
        'with a MessageCodec and sent to the native factory. The codec '
        'determines encoding: StandardMessageCodec for maps/lists, '
        'JSONMessageCodec for JSON strings, or custom codecs.',
      ),
      psCard(
        'Codec Options',
        Column(
          children: [
            psRow(['Codec', 'Format', 'Best For'], isHeader: true),
            psRow(['StandardMessageCodec', 'Binary platform', 'Maps + primitives']),
            psRow(['JSONMessageCodec', 'JSON string', 'Web interop']),
            psRow(['StringCodec', 'UTF-8 string', 'Simple config']),
            psRow(['BinaryCodec', 'Raw bytes', 'Protobuf / custom']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: View rendering modes comparison ━━━━━━
  print('[ps-07] Section 7: Rendering modes');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('07', 'Rendering Mode Comparison'),
      psNote(
        'Three rendering modes exist for Android: Virtual Display (texture), '
        'Hybrid Composition (real view hierarchy), and Texture Layer '
        'Hybrid (render to texture). Each has different trade-offs for '
        'keyboard support, performance, and visual fidelity.',
      ),
      psCard(
        'Side-by-Side Comparison',
        Column(
          children: [
            psRow(['Feature', 'Virtual', 'Hybrid', 'Texture'], isHeader: true),
            psRow(['Keyboard', 'Issues', 'Full', 'Issues']),
            psRow(['Clipping', 'Full', 'Limited', 'Full']),
            psRow(['Z-order', 'Correct', 'Complex', 'Correct']),
            psRow(['Perf', 'Good', 'Variable', 'Best']),
            psRow(['A11y', 'Limited', 'Full', 'Limited']),
            psRow(['Opacity', 'Full', 'Per-view', 'Full']),
            psRow(['Transform', 'Full', 'Limited', 'Full']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Method channel communication ━━━━━━
  print('[ps-08] Section 8: Method channel');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('08', 'Platform Channel Communication'),
      psNote(
        'PlatformViewsService communicates with the engine through a '
        'SystemChannels.platform_views method channel. Creation, disposal, '
        'resize, and touch events are all sent as method calls. The '
        'engine\'s platform view handler processes them on the platform '
        'thread.',
      ),
      psCard(
        'Channel Messages',
        Column(
          children: [
            psRow(['Method', 'Direction', 'Purpose'], isHeader: true),
            psRow(['create', 'Dart→Engine', 'Instantiate native view']),
            psRow(['dispose', 'Dart→Engine', 'Destroy native view']),
            psRow(['resize', 'Dart→Engine', 'Update view dimensions']),
            psRow(['touch', 'Dart→Engine', 'Forward pointer events']),
            psRow(['setDirection', 'Dart→Engine', 'Layout direction']),
            psRow(['clearFocus', 'Dart→Engine', 'Remove input focus']),
            psRow(['offset', 'Dart→Engine', 'View position']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Event forwarding ━━━━━━
  print('[ps-09] Section 9: Event forwarding');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('09', 'Pointer Event Forwarding'),
      psNote(
        'When a pointer event hits a platform view area, Flutter must '
        'forward it to the native view. The service converts PointerEvent '
        'to the native format (MotionEvent for Android, UITouch on iOS) '
        'and sends it via the platform channel.',
      ),
      psCard(
        'Event Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            psFlow(['PointerDown', 'Hit test', 'Platform view?',
                'Forward to native', 'Native handles']),
            const SizedBox(height: 10),
            _psEventRow('PointerDownEvent', 'ACTION_DOWN / touchesBegan', pine),
            _psEventRow('PointerMoveEvent', 'ACTION_MOVE / touchesMoved', deepForest),
            _psEventRow('PointerUpEvent', 'ACTION_UP / touchesEnded', emerald),
            _psEventRow('PointerCancelEvent', 'ACTION_CANCEL / touchesCancelled', forest),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Focus handling ━━━━━━
  print('[ps-10] Section 10: Focus handling');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('10', 'Focus Handling'),
      psNote(
        'Platform views participate in focus management. When a native '
        'text input gets focus, the soft keyboard appears. When Flutter '
        'regains focus, clearFocus is sent to dismiss the native keyboard. '
        'Focus changes must be coordinated between both frameworks.',
      ),
      psCard(
        'Focus Scenarios',
        Column(
          children: [
            psRow(['Scenario', 'Action', 'Result'], isHeader: true),
            psRow(['Tap native field', 'Native claims focus', 'Keyboard shows']),
            psRow(['Tap Flutter field', 'clearFocus sent', 'Native loses focus']),
            psRow(['Back pressed', 'Both lose focus', 'Keyboard hides']),
            psRow(['Tab navigation', 'Focus moves', 'Coordinated switch']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: View disposal ━━━━━━
  print('[ps-11] Section 11: Disposal');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('11', 'View Disposal'),
      psNote(
        'When a platform view widget is removed from the tree, its '
        'controller calls dispose() which sends a dispose message through '
        'PlatformViewsService. The engine destroys the native view and '
        'releases the surface. Failing to dispose leaks native memory.',
      ),
      psCard(
        'Disposal Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _psCheckItem('Widget removed from tree', true, forest),
            _psCheckItem('State.dispose() called', true, forest),
            _psCheckItem('Controller.dispose() invoked', true, forest),
            _psCheckItem('Platform channel: dispose message', true, forest),
            _psCheckItem('Engine destroys native surface', true, forest),
            _psCheckItem('ViewId released for reuse', true, forest),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: View ID management ━━━━━━
  print('[ps-12] Section 12: View ID management');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('12', 'View ID Management'),
      psNote(
        'Each platform view gets a unique integer viewId assigned by '
        'PlatformViewsService. IDs are sequential and never reused during '
        'a session. The viewId is used for all subsequent operations: '
        'resize, touch dispatch, focus changes, and disposal.',
      ),
      psCard(
        'ID Lifecycle',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _psIdPhase(0, 'Next ID allocated', 'Auto-increment', pine),
            _psIdPhase(1, 'Sent in create message', 'Engine stores mapping', deepForest),
            _psIdPhase(2, 'Used for all ops', 'resize, touch, focus', emerald),
            _psIdPhase(3, 'Released on dispose', 'Not reused', forest),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: PlatformViewLink ━━━━━━
  print('[ps-13] Section 13: PlatformViewLink');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('13', 'PlatformViewLink Widget'),
      psNote(
        'PlatformViewLink is the widget that ties PlatformViewsService '
        'to the widget tree. It handles surfaceFactory (creating the '
        'rendering surface), onCreatePlatformView (creating the controller), '
        'and automatically manages lifecycle and sizing.',
      ),
      psCard(
        'PlatformViewLink Components',
        Column(
          children: [
            psRow(['Callback', 'Purpose', 'Returns'], isHeader: true),
            psRow(['surfaceFactory', 'Create surface widget', 'AndroidViewSurface']),
            psRow(['onCreatePlatformView', 'Init controller', 'PlatformViewController']),
            psRow(['viewType', 'Identify view factory', 'String']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Performance ━━━━━━
  print('[ps-14] Section 14: Performance');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('14', 'Performance Considerations'),
      psNote(
        'Platform views are one of the most expensive operations in '
        'Flutter. Each view requires native surface allocation, thread '
        'synchronization, and compositor integration. Minimize the number '
        'of simultaneous views and never place them in lazy lists.',
      ),
      psCard(
        'Performance Tips',
        Column(
          children: [
            psRow(['Tip', 'Reason', 'Impact'], isHeader: true),
            psRow(['Limit count', 'Each needs a surface', 'Memory']),
            psRow(['Avoid in ListView', 'Create/dispose churn', 'Jank']),
            psRow(['Use texture mode', 'Best compositing perf', 'FPS']),
            psRow(['Lazy create', 'Defer until visible', 'Startup time']),
            psRow(['Cache disposed', 'Reuse for same type', 'Allocation']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Debugging ━━━━━━
  print('[ps-15] Section 15: Debugging');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('15', 'Debugging Platform Views'),
      psNote(
        'Debug platform views with debugPaintSizeEnabled to visualize '
        'boundaries. Check the engine logs for platform channel messages. '
        'Common issues: blank view (factory not registered), no touch '
        'response (pointer forwarding broken), keyboard not showing '
        '(wrong composition mode).',
      ),
      psCard(
        'Common Issues',
        Column(
          children: [
            psRow(['Symptom', 'Likely Cause', 'Fix'], isHeader: true),
            psRow(['Blank view', 'Factory not registered', 'Register on native']),
            psRow(['No touch', 'Pointer dispatch off', 'Check gestureRecognizers']),
            psRow(['No keyboard', 'Virtual display mode', 'Switch to hybrid']),
            psRow(['Crash on dispose', 'Double dispose', 'Guard with flag']),
            psRow(['Size mismatch', 'Layout not forwarded', 'Check resize channel']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[ps-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      psBanner('16', 'Summary Dashboard'),
      psCard(
        'PlatformViewsService — Complete',
        Column(
          children: [
            psRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            psRow(['What', 'S01', 'Singleton view manager']),
            psRow(['Android Virtual', 'S02', 'Off-screen texture']),
            psRow(['Android Hybrid', 'S03', 'Real view hierarchy']),
            psRow(['Expensive', 'S04', 'Framework optimization hint']),
            psRow(['iOS', 'S05', 'UiKitView, single mode']),
            psRow(['Params', 'S06', 'Codec-encoded config']),
            psRow(['Modes', 'S07', 'Virtual/Hybrid/Texture']),
            psRow(['Channel', 'S08', 'platform_views methods']),
            psRow(['Events', 'S09', 'Pointer forwarding']),
            psRow(['Focus', 'S10', 'Coordinated keyboard']),
            psRow(['Dispose', 'S11', 'Native resource cleanup']),
            psRow(['View ID', 'S12', 'Sequential, never reused']),
            psRow(['PVLink', 'S13', 'Widget integration']),
            psRow(['Perf', 'S14', 'Minimize count']),
            psRow(['Debug', 'S15', 'Factory + channel logs']),
          ],
        ),
      ),
      psCard(
        'Forest / Sage Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _psColorSwatch('Forest', forest),
            _psColorSwatch('Sage', sage),
            _psColorSwatch('Emerald', emerald),
            _psColorSwatch('Moss', moss),
            _psColorSwatch('Pine', pine),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [pine, deepForest],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('PlatformViewsService — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From singleton architecture through Android rendering modes, '
              'iOS embedding, event forwarding, focus coordination, disposal, '
              'and performance — the full platform view management story.',
              style: TextStyle(color: mint, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[ps] palette: $ivy, $fern, $moss, $mint');
  print('[ps] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('PlatformViewsService — View Management'),
        backgroundColor: pine,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5FBF7),
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

Widget _psRoleBadge(String role, String desc, Color color) {
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

Widget _psCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}

Widget _psCompareRow(String label, IconData icon, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        SizedBox(
          width: 90,
          child: Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(detail,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _psEventRow(String flutterEvent, String nativeMapping, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(flutterEvent,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(nativeMapping,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _psCheckItem(String label, bool done, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Icon(
          done ? Icons.check_box : Icons.check_box_outline_blank,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(fontSize: 10, color: color)),
      ],
    ),
  );
}

Widget _psIdPhase(int num, String phase, String detail, Color color) {
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
              Text(phase,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(detail,
                  style: TextStyle(
                      fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _psColorSwatch(String name, Color color) {
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
