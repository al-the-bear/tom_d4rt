// ignore_for_file: avoid_print
// Deep demo: HybridAndroidViewController — hybrid-composition Android platform views
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Warm Terracotta / Peach
// ─────────────────────────────────────────────────────────────
const Color _hvTerracotta = Color(0xFFBF360C);
const Color _hvPeach = Color(0xFFFBE9E7);
const Color _hvDarkBrown = Color(0xFF4E342E);
const Color _hvMedBrown = Color(0xFF795548);
const Color _hvLightBrown = Color(0xFFBCAAA4);
const Color _hvAccent = Color(0xFFFF6E40);
const Color _hvWhite = Color(0xFFFFFFFF);
const Color _hvPlatformGreen = Color(0xFF43A047);
const Color _hvTextureBlue = Color(0xFF1565C0);
const Color _hvVirtualPurple = Color(0xFF6A1B9A);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _hvSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _hvWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _hvLightBrown, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _hvTerracotta,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _hvWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _hvLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _hvDarkBrown, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _hvBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _hvMedBrown, fontSize: 12.5, height: 1.5)),
  );
}

Widget _hvChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _hvInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(key,
              style: const TextStyle(
                  color: _hvDarkBrown,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _hvMedBrown, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _hvDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _hvLightBrown.withValues(alpha: 0.5),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  HybridAndroidViewController — Deep Demo');
  print('  Hybrid-composition Android platform views');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _hvPeach,
      appBarTheme: const AppBarTheme(
        backgroundColor: _hvTerracotta,
        foregroundColor: _hvWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('HybridAndroidViewController'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildThreeCompositingModes(),
            _buildCreationParameters(),
            _buildRenderingPipeline(),
            _buildLifecycleStates(),
            _buildSurfaceManagement(),
            _buildTouchForwarding(),
            _buildZOrderingOverlays(),
            _buildPerformanceTradeoffs(),
            _buildRealEmbeddingDemo(),
            _buildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner — visual header');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_hvTerracotta, Color(0xFFD84315)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x40BF360C), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.android, size: 52, color: _hvWhite),
        const SizedBox(height: 12),
        const Text('HybridAndroidViewController',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _hvWhite, fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _hvWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Hybrid Composition · Android Platform Views',
            style: TextStyle(color: _hvWhite, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hvChip('services', _hvWhite),
            _hvChip('Android', _hvWhite),
            _hvChip('PlatformView', _hvWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is HybridAndroidViewController?');
  return _hvSection('What Is HybridAndroidViewController?', [
    _hvBody(
      'HybridAndroidViewController is the controller that manages Android '
      'platform views using the "hybrid composition" approach. This is the '
      'recommended mode for Android platform views since Flutter 3.0, as it '
      'combines the best aspects of virtual display and texture rendering.',
    ),
    _hvDivider(),
    _hvLabel('Key Characteristics'),
    _hvBody(
      '• Renders the native Android View using a SurfaceView\n'
      '• Composites the native surface directly into the Flutter layer tree\n'
      '• Supports accessibility, input, and platform view gestures\n'
      '• Uses a FlutterMutatorView for clip/transform synchronization\n'
      '• Falls back gracefully when hardware acceleration is unavailable',
    ),
    _hvDivider(),
    _hvLabel('Class Hierarchy'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hvPeach,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hvBody('PlatformViewController  (abstract base)'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _hvBody('└─ AndroidViewController  (abstract Android base)'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: _hvBody('├─ SurfaceAndroidViewController  (virtual display)'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: _hvBody('├─ TextureAndroidViewController  (texture layer)'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: _hvBody(
                '└─ HybridAndroidViewController  (hybrid composition) ◄'),
          ),
        ],
      ),
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — Three Compositing Modes
// ═══════════════════════════════════════════════════════════════
Widget _buildThreeCompositingModes() {
  print('[Section 3] Three compositing modes compared');
  return _hvSection('Android Compositing Modes', [
    _hvBody(
      'Flutter supports three different modes of compositing native Android '
      'views into the Flutter scene. Each mode handles rendering, z-ordering, '
      'and input differently.',
    ),
    _hvDivider(),
    // Virtual Display mode
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _hvVirtualPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _hvVirtualPurple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.monitor, size: 20, color: _hvVirtualPurple),
            const SizedBox(width: 8),
            const Text('Virtual Display',
                style: TextStyle(
                    color: _hvVirtualPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 8),
          _hvBody(
            'Creates an off-screen VirtualDisplay and renders the native view '
            'into it. The pixels are then read back as a texture. This was the '
            'original Android platform view approach.',
          ),
          Wrap(children: [
            _hvChip('Off-screen rendering', _hvVirtualPurple),
            _hvChip('Texture readback', _hvVirtualPurple),
            _hvChip('Accessibility issues', _hvVirtualPurple),
          ]),
        ],
      ),
    ),
    // Texture mode
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _hvTextureBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _hvTextureBlue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.texture, size: 20, color: _hvTextureBlue),
            const SizedBox(width: 8),
            const Text('Texture Layer',
                style: TextStyle(
                    color: _hvTextureBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 8),
          _hvBody(
            'Renders the native view into a Surface whose contents are '
            'backed by a SurfaceTexture. Flutter paints this texture as '
            'part of its own rendering pipeline. Better than virtual display '
            'but still one frame behind.',
          ),
          Wrap(children: [
            _hvChip('Surface → Texture', _hvTextureBlue),
            _hvChip('One-frame latency', _hvTextureBlue),
            _hvChip('Good z-ordering', _hvTextureBlue),
          ]),
        ],
      ),
    ),
    // Hybrid mode (highlighted)
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _hvTerracotta.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _hvTerracotta, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.layers, size: 20, color: _hvTerracotta),
            const SizedBox(width: 8),
            const Text('Hybrid Composition ★',
                style: TextStyle(
                    color: _hvTerracotta,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 8),
          _hvBody(
            'Composites the native Android View directly into the Flutter '
            'view hierarchy. The native view is added to a FlutterMutatorView '
            'that synchronizes position, clip, and transform. This is the '
            'recommended approach since Flutter 3.0.',
          ),
          Wrap(children: [
            _hvChip('Direct composition', _hvTerracotta),
            _hvChip('No latency', _hvTerracotta),
            _hvChip('Full accessibility', _hvTerracotta),
            _hvChip('Recommended ★', _hvTerracotta),
          ]),
        ],
      ),
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — Creation Parameters
// ═══════════════════════════════════════════════════════════════
Widget _buildCreationParameters() {
  print('[Section 4] Creation parameters');
  return _hvSection('Creation Parameters', [
    _hvBody(
      'When creating an AndroidViewController for hybrid composition, '
      'several parameters control how the platform view is initialized:',
    ),
    _hvDivider(),
    _hvInfoRow('viewType', 'String identifier registered with the platform view factory'),
    _hvInfoRow('id', 'Unique integer ID for the platform view instance'),
    _hvInfoRow('layoutDirection', 'TextDirection.ltr or TextDirection.rtl for the view'),
    _hvInfoRow('creationParams', 'Opaque data passed to the native view factory'),
    _hvInfoRow('creationParamsCodec', 'MessageCodec to encode creationParams'),
    _hvDivider(),
    _hvLabel('Factory Method'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hvPeach,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _hvLightBrown),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hvBody('PlatformViewsService.initHybridAndroidView('),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _hvBody('id: viewId,'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _hvBody("viewType: 'native-map-view',"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _hvBody('layoutDirection: TextDirection.ltr,'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _hvBody("creationParams: {'apiKey': '...'},"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _hvBody('creationParamsCodec:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: _hvBody('const StandardMessageCodec(),'),
          ),
          _hvBody(')'),
        ],
      ),
    ),
    const SizedBox(height: 8),
    _hvBody(
      'The factory method returns a TextureAndroidViewController that is '
      'then wrapped with hybrid composition behavior. The creationParams '
      'are encoded and sent to the platform side via a platform channel.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Rendering Pipeline
// ═══════════════════════════════════════════════════════════════
Widget _buildRenderingPipeline() {
  print('[Section 5] Rendering pipeline visualization');

  Widget pipelineStep(int step, String label, String detail, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, size: 20, color: _hvWhite),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Step $step: $label',
                    style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(detail,
                    style: const TextStyle(color: _hvMedBrown, fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _hvSection('Rendering Pipeline', [
    _hvBody(
      'In hybrid composition, the rendering pipeline differs significantly '
      'from texture or virtual display modes. The native view lives in the '
      'same view hierarchy as the Flutter engine surface.',
    ),
    _hvDivider(),
    pipelineStep(1, 'Create platform view',
        'Flutter sends a create message to the platform with viewType and params',
        Icons.add_circle_outline, _hvTerracotta),
    Container(
      margin: const EdgeInsets.only(left: 20, bottom: 8),
      height: 20,
      width: 2,
      color: _hvLightBrown,
    ),
    pipelineStep(2, 'Allocate FlutterMutatorView',
        'The engine creates a FlutterMutatorView to host the native Android View',
        Icons.view_in_ar, _hvAccent),
    Container(
      margin: const EdgeInsets.only(left: 20, bottom: 8),
      height: 20,
      width: 2,
      color: _hvLightBrown,
    ),
    pipelineStep(3, 'Sync transforms & clips',
        'On each frame, Flutter sends matrix4 transforms and clip rects to the mutator view',
        Icons.transform, _hvPlatformGreen),
    Container(
      margin: const EdgeInsets.only(left: 20, bottom: 8),
      height: 20,
      width: 2,
      color: _hvLightBrown,
    ),
    pipelineStep(4, 'Composite into scene',
        'The Skia / Impeller compositor merges the native surface with Flutter layers',
        Icons.layers, _hvTextureBlue),
    Container(
      margin: const EdgeInsets.only(left: 20, bottom: 8),
      height: 20,
      width: 2,
      color: _hvLightBrown,
    ),
    pipelineStep(5, 'Display to screen',
        'The final composited frame is presented to the Android SurfaceFlinger',
        Icons.phone_android, _hvVirtualPurple),
    _hvDivider(),
    _hvBody(
      'The key advantage is that the native view never goes through a texture '
      'readback, so there is zero additional frame latency compared to the '
      'texture approach.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Lifecycle States
// ═══════════════════════════════════════════════════════════════
Widget _buildLifecycleStates() {
  print('[Section 6] Lifecycle state machine');

  Widget stateBox(String name, String description, Color color, {bool isCurrent = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
          width: isCurrent ? 2.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(description,
                    style: const TextStyle(color: _hvMedBrown, fontSize: 11.5)),
              ],
            ),
          ),
          if (isCurrent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('ACTIVE',
                  style: TextStyle(color: _hvWhite, fontSize: 9, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }

  return _hvSection('View Lifecycle', [
    _hvBody(
      'An AndroidViewController goes through several lifecycle states. '
      'Understanding these states is critical for managing resources and '
      'avoiding native memory leaks.',
    ),
    _hvDivider(),
    stateBox('Uninitialized', 'Controller created but create() not yet called',
        const Color(0xFF9E9E9E)),
    Row(
      children: [
        const SizedBox(width: 16),
        const Icon(Icons.arrow_downward, size: 16, color: _hvLightBrown),
        const SizedBox(width: 8),
        Text('await controller.create()',
            style: TextStyle(color: _hvMedBrown.withValues(alpha: 0.7), fontSize: 11)),
      ],
    ),
    const SizedBox(height: 4),
    stateBox('Created', 'Native view exists, surface allocated, ready for compositing',
        _hvPlatformGreen, isCurrent: true),
    Row(
      children: [
        const SizedBox(width: 16),
        const Icon(Icons.arrow_downward, size: 16, color: _hvLightBrown),
        const SizedBox(width: 8),
        Text('controller.setSize(size)',
            style: TextStyle(color: _hvMedBrown.withValues(alpha: 0.7), fontSize: 11)),
      ],
    ),
    const SizedBox(height: 4),
    stateBox('Sized', 'View has been given a layout size, ready to render',
        _hvTextureBlue),
    Row(
      children: [
        const SizedBox(width: 16),
        const Icon(Icons.arrow_downward, size: 16, color: _hvLightBrown),
        const SizedBox(width: 8),
        Text('await controller.dispose()',
            style: TextStyle(color: _hvMedBrown.withValues(alpha: 0.7), fontSize: 11)),
      ],
    ),
    const SizedBox(height: 4),
    stateBox('Disposed', 'Native view destroyed, surface released, controller inactive',
        const Color(0xFFE53935)),
    _hvDivider(),
    _hvBody(
      'In hybrid composition, the create() call allocates the FlutterMutatorView '
      'and adds the native Android View as its child. The dispose() call removes '
      'the view from the hierarchy and releases the native resources.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Surface Management
// ═══════════════════════════════════════════════════════════════
Widget _buildSurfaceManagement() {
  print('[Section 7] Surface management details');
  return _hvSection('Surface Management', [
    _hvBody(
      'The hybrid controller manages a native Android Surface that the '
      'native view draws into. This surface is then composited by the '
      'Flutter engine alongside Flutter-rendered content.',
    ),
    _hvDivider(),
    _hvLabel('Surface Types'),
    // Surface type comparison
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _hvTextureBlue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _hvTextureBlue.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.texture, size: 28, color: _hvTextureBlue),
                const SizedBox(height: 6),
                const Text('SurfaceTexture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _hvTextureBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _hvBody('Used by texture mode.\nGPU texture readback.\nOne frame latency.'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _hvTerracotta.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _hvTerracotta, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.layers, size: 28, color: _hvTerracotta),
                const SizedBox(height: 6),
                const Text('SurfaceView',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _hvTerracotta,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _hvBody('Used by hybrid mode.\nDirect composition.\nZero frame latency.'),
              ],
            ),
          ),
        ),
      ],
    ),
    _hvDivider(),
    _hvLabel('Surface Callbacks'),
    _hvInfoRow('surfaceCreated', 'Called when the SurfaceView surface is available'),
    _hvInfoRow('surfaceChanged', 'Called when size or format changes'),
    _hvInfoRow('surfaceDestroyed', 'Called when surface is being released'),
    _hvDivider(),
    _hvBody(
      'The FlutterMutatorView listens for surface lifecycle callbacks and '
      'coordinates with the engine to start or stop compositing the native '
      'surface. This ensures frames are only composited when the surface '
      'is actually valid.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Touch Forwarding
// ═══════════════════════════════════════════════════════════════
Widget _buildTouchForwarding() {
  print('[Section 8] Touch event forwarding');
  return _hvSection('Touch Event Forwarding', [
    _hvBody(
      'One of the most complex aspects of platform views is coordinating '
      'touch events between Flutter\'s gesture system and the native '
      'Android view\'s touch handling.',
    ),
    _hvDivider(),
    _hvLabel('Touch Processing Pipeline'),
    // Visual pipeline for touch events
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hvPeach,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Step 1
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _hvAccent.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              const Icon(Icons.touch_app, size: 18, color: _hvAccent),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('User touches screen',
                    style: TextStyle(color: _hvDarkBrown, fontSize: 12)),
              ),
            ]),
          ),
          const Icon(Icons.arrow_downward, size: 16, color: _hvLightBrown),
          // Step 2
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvTerracotta.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _hvTerracotta.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              const Icon(Icons.filter_tilt_shift, size: 18, color: _hvTerracotta),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Flutter gesture arena decides ownership',
                    style: TextStyle(color: _hvDarkBrown, fontSize: 12)),
              ),
            ]),
          ),
          const Icon(Icons.arrow_downward, size: 16, color: _hvLightBrown),
          // Step 3 — branch
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _hvPlatformGreen.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _hvPlatformGreen.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          size: 18, color: _hvPlatformGreen),
                      const SizedBox(height: 4),
                      const Text('Forward to native view',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _hvDarkBrown, fontSize: 11)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: const Color(0xFFE53935).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.cancel_outlined,
                          size: 18, color: Color(0xFFE53935)),
                      const SizedBox(height: 4),
                      const Text('Handle in Flutter',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _hvDarkBrown, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    _hvDivider(),
    _hvLabel('Gesture Policies'),
    _hvInfoRow('opaque', 'All gestures go to native view, Flutter gets nothing'),
    _hvInfoRow('translucent', 'Both Flutter and native view receive events'),
    _hvInfoRow('eager', 'Flutter accepts immediately, native only if Flutter rejects'),
    _hvDivider(),
    _hvBody(
      'In hybrid mode, touch events are forwarded via the MotionEvent '
      'mechanism. The FlutterMutatorView intercepts dispatchTouchEvent '
      'and routes events to the native child view based on the current '
      'gesture policy set by the HybridAndroidViewController.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Z-Ordering & Overlays
// ═══════════════════════════════════════════════════════════════
Widget _buildZOrderingOverlays() {
  print('[Section 9] Z-ordering and overlay layers');
  return _hvSection('Z-Ordering & Overlays', [
    _hvBody(
      'When Flutter widgets need to appear above a platform view, the engine '
      'creates overlay surfaces. Understanding z-ordering is essential for '
      'proper visual layering.',
    ),
    _hvDivider(),
    _hvLabel('Layer Stack Visualization'),
    // Stack diagram
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hvPeach,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Top layer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvAccent.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: Border.all(color: _hvAccent),
            ),
            child: const Text('Flutter Overlay Surface (AppBar, FAB, dialogs)',
                textAlign: TextAlign.center,
                style: TextStyle(color: _hvAccent, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          // Platform view layer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvPlatformGreen.withValues(alpha: 0.15),
              border: Border.all(color: _hvPlatformGreen),
            ),
            child: const Text('Native Android View (MapView, WebView, etc.)',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _hvPlatformGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          // Bottom Flutter layer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvTextureBlue.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(color: _hvTextureBlue),
            ),
            child: const Text('Flutter Main Surface (background, content below PV)',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _hvTextureBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    ),
    _hvDivider(),
    _hvLabel('Overlay Behavior'),
    _hvBody(
      '• Each overlay adds a separate SurfaceView (performance cost)\n'
      '• Overlay count should be minimized for performance\n'
      '• Transparent overlays allow native view to show through\n'
      '• Multiple platform views may share overlay surfaces\n'
      '• The engine automatically manages overlay lifecycle',
    ),
    _hvDivider(),
    _hvLabel('Hybrid vs Virtual Display Z-Order'),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvVirtualPurple.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _hvVirtualPurple.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Virtual Display',
                    style: TextStyle(
                        color: _hvVirtualPurple,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _hvBody('Always behind Flutter.\nNo overlay needed.\nNo z-ordering issues.'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hvTerracotta.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _hvTerracotta, width: 2),
            ),
            child: Column(
              children: [
                const Text('Hybrid',
                    style: TextStyle(
                        color: _hvTerracotta,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _hvBody('Has real z-depth.\nOverlays needed.\nBetter fidelity.'),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Performance Trade-offs
// ═══════════════════════════════════════════════════════════════
Widget _buildPerformanceTradeoffs() {
  print('[Section 10] Performance trade-offs');

  Widget tradeoffCard(String title, String positive, String negative,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(title,
                style: TextStyle(
                    color: color, fontSize: 13, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.add_circle, size: 14, color: _hvPlatformGreen),
              const SizedBox(width: 4),
              Expanded(
                child: Text(positive,
                    style: const TextStyle(color: _hvPlatformGreen, fontSize: 11.5)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.remove_circle, size: 14, color: Color(0xFFE53935)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(negative,
                    style: const TextStyle(color: Color(0xFFE53935), fontSize: 11.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  return _hvSection('Performance Trade-offs', [
    _hvBody(
      'Hybrid composition is the recommended approach but comes with '
      'trade-offs. Understanding these helps make informed architecture decisions.',
    ),
    _hvDivider(),
    tradeoffCard(
      'Frame Latency',
      'Zero additional frame delay — native content appears immediately',
      'Requires more GPU memory for overlay surfaces',
      Icons.timer, _hvTerracotta,
    ),
    tradeoffCard(
      'Thread Coordination',
      'Native view renders on its own thread, no Flutter UI thread blocking',
      'Synchronizing transforms requires cross-thread signaling',
      Icons.sync, _hvTextureBlue,
    ),
    tradeoffCard(
      'Memory Overhead',
      'No texture copy needed, lower overall memory bandwidth',
      'Each overlay surface allocates its own GPU buffers',
      Icons.memory, _hvVirtualPurple,
    ),
    tradeoffCard(
      'Accessibility',
      'Full native accessibility tree is preserved and merged with Flutter',
      'Slightly more complex accessibility merging logic',
      Icons.accessibility, _hvPlatformGreen,
    ),
    tradeoffCard(
      'Animation Smoothness',
      'Native animations play at native refresh rate',
      'Flutter animations over platform views may have slight tearing',
      Icons.animation, _hvAccent,
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Simulated Embedding Demo
// ═══════════════════════════════════════════════════════════════
Widget _buildRealEmbeddingDemo() {
  print('[Section 11] Simulated real Android view embedding');
  return _hvSection('Simulated Platform View Embedding', [
    _hvBody(
      'Below is a visual simulation of what a hybrid-composited Android '
      'platform view looks like when embedded in a Flutter layout. The '
      '"native view" area represents where the actual Android View would '
      'render, while the Flutter widgets above and below demonstrate '
      'the z-ordering behavior.',
    ),
    _hvDivider(),
    // Simulated app with platform view
    Container(
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _hvDarkBrown, width: 2),
      ),
      child: Column(
        children: [
          // Simulated AppBar (Flutter overlay)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: _hvTerracotta,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: _hvWhite, size: 18),
                const SizedBox(width: 8),
                const Text('Flutter AppBar (overlay above)',
                    style: TextStyle(color: _hvWhite, fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          // Flutter content below platform view
          Container(
            padding: const EdgeInsets.all(8),
            color: _hvTextureBlue.withValues(alpha: 0.06),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 14, color: _hvTextureBlue),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text('Flutter content (main surface, below PV)',
                      style: TextStyle(color: _hvTextureBlue, fontSize: 11)),
                ),
              ],
            ),
          ),
          // The "native" platform view
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: _hvPlatformGreen.withValues(alpha: 0.08),
                border: Border.all(color: _hvPlatformGreen, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Fake map grid
                  Positioned.fill(
                    child: CustomPaint(painter: _MapGridPainter()),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.map, size: 48, color: _hvPlatformGreen),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _hvPlatformGreen.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Native Android MapView',
                              style: TextStyle(
                                  color: _hvWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(height: 4),
                        const Text('(Hybrid Composited)',
                            style: TextStyle(
                                color: _hvPlatformGreen, fontSize: 11)),
                      ],
                    ),
                  ),
                  // Touch indicator
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _hvAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.touch_app, size: 12, color: _hvWhite),
                          const SizedBox(width: 4),
                          const Text('Touch forwarded',
                              style: TextStyle(color: _hvWhite, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Flutter FAB overlay
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: _hvAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40FF6E40),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.my_location,
                      color: _hvWhite, size: 20),
                ),
                const SizedBox(width: 8),
                const Text('Flutter FAB (overlay)',
                    style: TextStyle(color: _hvMedBrown, fontSize: 11)),
              ],
            ),
          ),
          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: _hvDarkBrown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.explore, color: _hvWhite, size: 16),
                    const Text('Explore',
                        style: TextStyle(color: _hvWhite, fontSize: 10)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.directions, color: _hvLightBrown, size: 16),
                    const Text('Directions',
                        style: TextStyle(color: _hvLightBrown, fontSize: 10)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bookmark_outline, color: _hvLightBrown, size: 16),
                    const Text('Saved',
                        style: TextStyle(color: _hvLightBrown, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    _hvDivider(),
    _hvBody(
      'In this simulation, the green-bordered area represents the native '
      'Android MapView composited via hybrid composition. The AppBar, FAB, '
      'and bottom bar are Flutter overlay surfaces rendered above the platform '
      'view. The blue strip below the AppBar is Flutter main-surface content '
      'that appears behind the platform view in the z-stack.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('HybridAndroidViewController deep demo complete.');
  return _hvSection('Summary', [
    _hvBody(
      'HybridAndroidViewController is the recommended way to embed native '
      'Android views in Flutter. It provides the best balance of rendering '
      'fidelity, performance, and accessibility.',
    ),
    _hvDivider(),
    _hvLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hvTerracotta.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hvBody('✦ Uses direct surface composition (no texture readback)'),
          _hvBody('✦ Zero additional frame latency'),
          _hvBody('✦ Full native accessibility preserved'),
          _hvBody('✦ FlutterMutatorView manages position, clip, and transforms'),
          _hvBody('✦ Overlays needed for Flutter content above platform views'),
          _hvBody('✦ Recommended since Flutter 3.0 for Android platform views'),
          _hvBody('✦ Part of AndroidViewController hierarchy alongside Texture and Surface modes'),
        ],
      ),
    ),
    _hvDivider(),
    Wrap(
      children: [
        _hvChip('Hybrid Composition', _hvTerracotta),
        _hvChip('PlatformViewsService', _hvAccent),
        _hvChip('FlutterMutatorView', _hvPlatformGreen),
        _hvChip('SurfaceView', _hvTextureBlue),
        _hvChip('Zero Latency', _hvVirtualPurple),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Custom painter — fake map grid for the embedding demo
// ═══════════════════════════════════════════════════════════════
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _hvPlatformGreen.withValues(alpha: 0.12)
      ..strokeWidth = 0.5;

    // Horizontal lines
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // "Road" lines
    final roadPaint = Paint()
      ..color = _hvPlatformGreen.withValues(alpha: 0.2)
      ..strokeWidth = 2;
    canvas.drawLine(
        Offset(size.width * 0.2, 0),
        Offset(size.width * 0.6, size.height),
        roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.3),
        Offset(size.width, size.height * 0.5),
        roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.7, 0),
        Offset(size.width * 0.4, size.height),
        roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
