// ignore_for_file: avoid_print
// D4rt deep demo: ExpensiveAndroidViewController — Android platform views
// using the virtual display rendering strategy (pre-Hybrid Composition).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Navy / Steel palette ───
  const Color navy = Color(0xFF001F3F);
  const Color steel = Color(0xFF607D8B);
  const Color deepNavy = Color(0xFF001529);
  const Color paleNavy = Color(0xFFF0F4F8);
  const Color midSteel = Color(0xFF78909C);
  const Color lightSteel = Color(0xFFB0BEC5);
  const Color darkSlate = Color(0xFF263238);
  const Color blueGrey = Color(0xFF455A64);
  const Color icyBlue = Color(0xFFE3F2FD);
  const Color metallic = Color(0xFF90A4AE);

  print('[ea] ===== EXPENSIVE ANDROID VIEW CONTROLLER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget eaBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [navy, darkSlate],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.35),
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
              border: Border.all(color: metallic, width: 1.5),
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

  Widget eaNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleNavy,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: icyBlue),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: navy.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget eaCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: icyBlue),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.06),
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
              color: steel.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: navy)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget eaRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? steel.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: icyBlue.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? navy : blueGrey)),
          );
        }).toList(),
      ),
    );
  }

  Widget eaFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? navy : darkSlate,
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
          child: Icon(Icons.east, size: 12, color: steel),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is ExpensiveAndroidViewController? ━━━━━━
  print('[ea-01] Section 1: What is ExpensiveAndroidViewController?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('01', 'What Is ExpensiveAndroidViewController?'),
      eaNote(
        'ExpensiveAndroidViewController manages Android platform views that '
        'use the Virtual Display rendering approach. It\'s called "expensive" '
        'because virtual displays carry significant memory and GPU overhead '
        'compared to Hybrid Composition. Each view gets its own off-screen '
        'virtual display whose pixels are composited into Flutter\'s rendering.',
      ),
      eaCard(
        'Why "Expensive"?',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eaCostItem('Virtual display GPU allocation', Icons.memory, navy),
            _eaCostItem('Off-screen texture composition', Icons.layers, steel),
            _eaCostItem('Extra draw calls per frame', Icons.draw, blueGrey),
            _eaCostItem('Thread synchronization overhead', Icons.sync, darkSlate),
            _eaCostItem('Memory for full-size texture buffer', Icons.storage, midSteel),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Virtual display architecture ━━━━━━
  print('[ea-02] Section 2: Virtual display architecture');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('02', 'Virtual Display Architecture'),
      eaNote(
        'Virtual Display mode creates an off-screen Android Display object. '
        'The native view renders into this virtual display, which produces '
        'a Surface backed by a texture. Flutter\'s engine then composites '
        'that texture into the scene graph at the correct position.',
      ),
      eaCard(
        'Rendering Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eaFlow(['Native View', 'Virtual Display', 'Surface Texture',
                'Flutter Engine', 'Scene Graph']),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: paleNavy,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _eaPipelineStep(1, 'Android creates VirtualDisplay', navy),
                  _eaPipelineStep(2, 'Native view renders to virtual surface', steel),
                  _eaPipelineStep(3, 'Surface content captured as texture', blueGrey),
                  _eaPipelineStep(4, 'Flutter composites texture into frame', darkSlate),
                  _eaPipelineStep(5, 'Result appears at widget position', midSteel),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Lifecycle ━━━━━━
  print('[ea-03] Section 3: Controller lifecycle');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('03', 'Controller Lifecycle'),
      eaNote(
        'The lifecycle follows: create → awaitingCreation → created → disposed. '
        'Platform view creation is asynchronous because the virtual display '
        'must be allocated on the platform thread. The controller manages '
        'this entire process transparently.',
      ),
      eaCard(
        'State Machine',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleNavy,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _eaStateBox('Uninitialized', 'Not yet created', Icons.circle_outlined, metallic),
              _eaArrow(),
              _eaStateBox('Creating', 'Platform call in flight', Icons.hourglass_empty, steel),
              _eaArrow(),
              _eaStateBox('Created', 'Virtual display active', Icons.check_circle, const Color(0xFF2E7D32)),
              _eaArrow(),
              _eaStateBox('Disposed', 'Resources released', Icons.cancel, const Color(0xFFC62828)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Comparison with Hybrid Composition ━━━━━━
  print('[ea-04] Section 4: Virtual Display vs Hybrid Composition');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('04', 'Virtual Display vs Hybrid Composition'),
      eaNote(
        'Flutter offers two Android platform view strategies. Virtual Display '
        '(ExpensiveAndroidViewController) renders off-screen, while Hybrid '
        'Composition interleaves native views into the Flutter view hierarchy.',
      ),
      eaCard(
        'Feature Comparison',
        Column(
          children: [
            eaRow(['Feature', 'Virtual Display', 'Hybrid Composition'], isHeader: true),
            eaRow(['Controller', 'ExpensiveAndroid…', 'Standard PlatformView']),
            eaRow(['Rendering', 'Off-screen texture', 'In-view hierarchy']),
            eaRow(['Memory', 'Higher (texture buf)', 'Lower']),
            eaRow(['Performance', 'GPU overhead', 'Thread sync']),
            eaRow(['Touch events', 'Forwarded', 'Native routing']),
            eaRow(['Accessibility', 'Limited', 'Full native']),
            eaRow(['Z-ordering', 'Flutter controls', 'Platform controls']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Texture management ━━━━━━
  print('[ea-05] Section 5: Texture management');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('05', 'Texture Management'),
      eaNote(
        'The virtual display produces a SurfaceTexture that Flutter\'s engine '
        'registers as a texture layer. The controller manages texture '
        'creation, size updates, and cleanup. Resizing requires recreating '
        'the virtual display — an expensive operation.',
      ),
      eaCard(
        'Texture Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eaFlow(['Allocate Texture', 'Bind to VDisplay',
                'Render Frame', 'Composite']),
            const SizedBox(height: 10),
            eaRow(['Operation', 'Cost', 'Frequency'], isHeader: true),
            eaRow(['Texture create', 'High', 'Once at init']),
            eaRow(['Frame render', 'Medium', 'Every frame']),
            eaRow(['Resize', 'Very high', 'On layout change']),
            eaRow(['Dispose', 'Low', 'Once at teardown']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Touch event forwarding ━━━━━━
  print('[ea-06] Section 6: Touch events');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('06', 'Touch Event Forwarding'),
      eaNote(
        'Since the native view renders off-screen, touch events must be '
        'intercepted by Flutter and forwarded to the virtual display. '
        'The controller translates Flutter pointer events to Android '
        'MotionEvents at the correct coordinates.',
      ),
      eaCard(
        'Event Translation',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eaFlow(['Flutter PointerEvent', 'Coordinate Transform',
                'Android MotionEvent', 'Native View']),
            const SizedBox(height: 10),
            _eaTouchRow('pointerDown', 'ACTION_DOWN', navy),
            _eaTouchRow('pointerMove', 'ACTION_MOVE', steel),
            _eaTouchRow('pointerUp', 'ACTION_UP', blueGrey),
            _eaTouchRow('pointerCancel', 'ACTION_CANCEL', darkSlate),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Size constraints ━━━━━━
  print('[ea-07] Section 7: Size constraints');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('07', 'Size Constraints & Layout'),
      eaNote(
        'The controller must know the exact pixel size to create the virtual '
        'display. Size is determined by the parent widget\'s constraints. '
        'If size changes, the virtual display must be torn down and rebuilt, '
        'causing a brief flicker.',
      ),
      eaCard(
        'Size Flow',
        Column(
          children: [
            eaRow(['Step', 'Action', 'Impact'], isHeader: true),
            eaRow(['1', 'Parent provides BoxConstraints', 'Size determined']),
            eaRow(['2', 'Create VirtualDisplay at size', 'GPU allocation']),
            eaRow(['3', 'Resize detected', 'Dispose old display']),
            eaRow(['4', 'Recreate at new size', 'Brief flicker']),
            eaRow(['5', 'New texture registered', 'Render continues']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Memory cost ━━━━━━
  print('[ea-08] Section 8: Memory cost analysis');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('08', 'Memory Cost Analysis'),
      eaNote(
        'Each virtual display allocates a texture buffer proportional to '
        'the view size. For a 1080×1920 view at RGBA (4 bytes/pixel), '
        'that\'s ~8 MB per view. Multiple platform views multiply this cost.',
      ),
      eaCard(
        'Memory per View',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _eaMemBox('720p', '~4 MB', steel)),
                const SizedBox(width: 6),
                Expanded(child: _eaMemBox('1080p', '~8 MB', navy)),
                const SizedBox(width: 6),
                Expanded(child: _eaMemBox('1440p', '~15 MB', darkSlate)),
              ],
            ),
            const SizedBox(height: 8),
            eaRow(['Views', '720p Total', '1080p Total'], isHeader: true),
            eaRow(['1', '~4 MB', '~8 MB']),
            eaRow(['3', '~12 MB', '~24 MB']),
            eaRow(['5', '~20 MB', '~40 MB']),
            eaRow(['10', '~40 MB', '~80 MB']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Platform channel protocol ━━━━━━
  print('[ea-09] Section 9: Platform channel protocol');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('09', 'Platform Channel Protocol'),
      eaNote(
        'The controller communicates with the Android side via platform '
        'channels. It sends create/dispose/resize messages and receives '
        'texture IDs and event callbacks. The protocol is internal to '
        'the Flutter framework.',
      ),
      eaCard(
        'Message Flow',
        Column(
          children: [
            eaRow(['Direction', 'Message', 'Payload'], isHeader: true),
            eaRow(['→ Platform', 'create', 'viewType, size, params']),
            eaRow(['← Flutter', 'created', 'textureId']),
            eaRow(['→ Platform', 'resize', 'newWidth, newHeight']),
            eaRow(['← Flutter', 'resized', 'new textureId']),
            eaRow(['→ Platform', 'touch', 'MotionEvent data']),
            eaRow(['→ Platform', 'dispose', '(none)']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: When to use ━━━━━━
  print('[ea-10] Section 10: When to use');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('10', 'When to Use Virtual Display'),
      eaNote(
        'Virtual Display is appropriate when you need Flutter widgets to '
        'render on top of the native view (Z-ordering control), when the '
        'native view doesn\'t need accessible semantics, or when using '
        'older Android APIs that don\'t support Hybrid Composition.',
      ),
      eaCard(
        'Decision Matrix',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eaDecisionItem('Need Flutter overlays on native view', 'Virtual Display', true, navy),
            _eaDecisionItem('Accessibility required', 'Hybrid Composition', false, steel),
            _eaDecisionItem('Performance-sensitive (many views)', 'Hybrid Composition', false, blueGrey),
            _eaDecisionItem('Old Android API compatibility', 'Virtual Display', true, darkSlate),
            _eaDecisionItem('Single small view (map, camera)', 'Either works', true, midSteel),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Accessibility implications ━━━━━━
  print('[ea-11] Section 11: Accessibility');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('11', 'Accessibility Implications'),
      eaNote(
        'Virtual Display mode has limited accessibility support. The native '
        'view is off-screen, so Android\'s accessibility framework can\'t '
        'discover or interact with it directly. Semantic annotations must '
        'be provided manually through Flutter\'s Semantics widget.',
      ),
      eaCard(
        'Accessibility Comparison',
        Column(
          children: [
            eaRow(['Feature', 'Virtual Display', 'Hybrid Comp.'], isHeader: true),
            eaRow(['TalkBack discovery', 'Manual', 'Automatic']),
            eaRow(['Focus traversal', 'Manual', 'Native']),
            eaRow(['Content description', 'Via Semantics', 'Native']),
            eaRow(['Touch exploration', 'Forwarded', 'Direct']),
            eaRow(['Screen reader', 'Limited', 'Full support']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Threading model ━━━━━━
  print('[ea-12] Section 12: Threading');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('12', 'Threading Model'),
      eaNote(
        'Virtual display rendering involves multiple threads: the UI thread '
        '(Flutter), the platform/main thread (Android), and the raster '
        'thread. Synchronization between these threads contributes to the '
        '"expensive" nature of this controller.',
      ),
      eaCard(
        'Thread Interactions',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleNavy,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _eaThreadRow('UI Thread', 'Widget build, layout', navy),
              _eaThreadRow('Platform Thread', 'Native view render', steel),
              _eaThreadRow('Raster Thread', 'Texture compositing', blueGrey),
              _eaThreadRow('IO Thread', 'Texture upload', midSteel),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Each frame: platform thread renders → texture uploaded → '
                  'raster thread composites → UI thread displays',
                  style: TextStyle(fontSize: 10, color: darkSlate),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Common use cases ━━━━━━
  print('[ea-13] Section 13: Common use cases');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('13', 'Common Use Cases'),
      eaNote(
        'The most common use cases for Virtual Display mode include Google Maps, '
        'WebView, video players, and camera previews — native views that '
        'Flutter can\'t easily replicate.',
      ),
      eaCard(
        'Use Case Gallery',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eaUseCaseItem('Google Maps', 'MapView rendered via virtual display', Icons.map, navy),
            _eaUseCaseItem('WebView', 'Browser content in Flutter layout', Icons.web, steel),
            _eaUseCaseItem('Camera Preview', 'Live camera feed composited', Icons.camera_alt, blueGrey),
            _eaUseCaseItem('Video Player', 'Native player with Flutter overlay', Icons.videocam, darkSlate),
            _eaUseCaseItem('Ad Views', 'AdMob banner in Flutter', Icons.campaign, midSteel),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Optimizations ━━━━━━
  print('[ea-14] Section 14: Optimization strategies');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('14', 'Optimization Strategies'),
      eaNote(
        'When stuck with virtual display mode, several strategies can reduce '
        'the performance impact: fixed sizes to avoid resize rebuilds, '
        'lazy creation, off-screen culling, and recycling controllers.',
      ),
      eaCard(
        'Optimization Tactics',
        Column(
          children: [
            eaRow(['Tactic', 'Benefit', 'Trade-off'], isHeader: true),
            eaRow(['Fixed size', 'No resize rebuild', 'Less flexible']),
            eaRow(['Lazy create', 'Defer GPU cost', 'Initial delay']),
            eaRow(['Off-screen cull', 'Skip hidden frames', 'Re-create on show']),
            eaRow(['Controller reuse', 'Skip re-allocation', 'Stale state risk']),
            eaRow(['Reduce view count', 'Linear mem savings', 'UX limitations']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Error handling ━━━━━━
  print('[ea-15] Section 15: Error handling');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('15', 'Error Handling'),
      eaNote(
        'Virtual display creation can fail when the device runs out of GPU '
        'resources, when the view type is unregistered, or when the platform '
        'channel times out. Robust apps must handle these failures.',
      ),
      eaCard(
        'Error Scenarios',
        Column(
          children: [
            eaRow(['Error', 'Cause', 'Recovery'], isHeader: true),
            eaRow(['Creation timeout', 'Platform overloaded', 'Retry with backoff']),
            eaRow(['Invalid viewType', 'Missing registration', 'Check plugin init']),
            eaRow(['Texture alloc fail', 'Low GPU memory', 'Reduce view count']),
            eaRow(['Dispose after reparent', 'Widget tree change', 'Guard lifecycle']),
            eaRow(['Resize flicker', 'Display rebuild', 'Use fixed size']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[ea-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eaBanner('16', 'Summary Dashboard'),
      eaCard(
        'ExpensiveAndroidViewController — Complete',
        Column(
          children: [
            eaRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            eaRow(['What', 'S01', 'Virtual display platform views']),
            eaRow(['Architecture', 'S02', 'Off-screen texture pipeline']),
            eaRow(['Lifecycle', 'S03', 'Create → active → disposed']),
            eaRow(['vs Hybrid', 'S04', 'Z-ordering vs perf trade-offs']),
            eaRow(['Textures', 'S05', 'GPU allocation & resizing cost']),
            eaRow(['Touch', 'S06', 'Pointer → MotionEvent forwarding']),
            eaRow(['Sizing', 'S07', 'Resize = recreate display']),
            eaRow(['Memory', 'S08', '~8 MB per 1080p view']),
            eaRow(['Protocol', 'S09', 'Platform channel messages']),
            eaRow(['When', 'S10', 'Z-order & legacy API needs']),
            eaRow(['A11y', 'S11', 'Limited, needs manual Semantics']),
            eaRow(['Threads', 'S12', 'UI + platform + raster sync']),
            eaRow(['Use cases', 'S13', 'Maps, WebView, camera, video']),
            eaRow(['Optimize', 'S14', 'Fixed size, lazy create, cull']),
            eaRow(['Errors', 'S15', 'Timeout, GPU fail, viewType']),
          ],
        ),
      ),
      eaCard(
        'Navy / Steel Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _eaColorSwatch('Navy', navy),
            _eaColorSwatch('Steel', steel),
            _eaColorSwatch('Dark', darkSlate),
            _eaColorSwatch('Blue', blueGrey),
            _eaColorSwatch('Metal', metallic),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [navy, darkSlate],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('ExpensiveAndroidViewController — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Virtual display rendering, texture management, touch forwarding, '
              'memory costs, accessibility trade-offs, and optimization — '
              'the full Android platform view architecture.',
              style: TextStyle(color: icyBlue, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[ea] palette: $deepNavy, $lightSteel');
  print('[ea] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ExpensiveAndroidViewController Demo'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F8FA),
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

Widget _eaCostItem(String text, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget _eaPipelineStep(int num, String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 11, color: color)),
        ),
      ],
    ),
  );
}

Widget _eaStateBox(String label, String desc, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _eaArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Center(
      child: Icon(Icons.arrow_downward, size: 16, color: const Color(0xFF90A4AE)),
    ),
  );
}

Widget _eaTouchRow(String flutter, String android, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(flutter,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: color)),
        ),
        Icon(Icons.arrow_forward, size: 12, color: color.withValues(alpha: 0.5)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(android,
              style: TextStyle(
                  fontSize: 10, fontFamily: 'monospace', color: color)),
        ),
      ],
    ),
  );
}

Widget _eaMemBox(String resolution, String size, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(size,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: color)),
        Text(resolution,
            style: TextStyle(fontSize: 10, color: color)),
      ],
    ),
  );
}

Widget _eaDecisionItem(String scenario, String recommendation, bool virtualDisplay, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(
          virtualDisplay ? Icons.check_circle : Icons.arrow_forward,
          size: 16,
          color: virtualDisplay ? const Color(0xFF2E7D32) : const Color(0xFFFF6F00),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(scenario,
              style: TextStyle(fontSize: 10, color: color)),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(recommendation,
                style: TextStyle(
                    fontSize: 9, fontWeight: FontWeight.w600, color: color)),
          ),
        ),
      ],
    ),
  );
}

Widget _eaThreadRow(String thread, String role, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
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
          width: 100,
          child: Text(thread,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(role,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _eaUseCaseItem(String name, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _eaColorSwatch(String name, Color color) {
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
