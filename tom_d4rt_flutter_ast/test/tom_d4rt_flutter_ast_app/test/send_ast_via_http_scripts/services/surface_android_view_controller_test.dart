// ignore_for_file: avoid_print
// Deep demo: SurfaceAndroidViewController — Android SurfaceView platform views
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Deep Ocean / Seafoam
// ─────────────────────────────────────────────────────────────
const Color _svOcean = Color(0xFF0D47A1);
const Color _svSeafoam = Color(0xFFE3F2FD);
const Color _svDarkNavy = Color(0xFF0A1929);
const Color _svMedBlue = Color(0xFF1565C0);
const Color _svLightBlue = Color(0xFF90CAF9);
const Color _svWhite = Color(0xFFFFFFFF);
const Color _svGray = Color(0xFF546E7A);
const Color _svDarkGray = Color(0xFF263238);
const Color _svAccentCyan = Color(0xFF00838F);
const Color _svAccentGreen = Color(0xFF2E7D32);
const Color _svAccentOrange = Color(0xFFEF6C00);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _svSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _svWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _svLightBlue, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A0D47A1), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _svOcean,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _svWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _svLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _svDarkNavy, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _svBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _svGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _svChip(String label, Color color) {
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

Widget _svInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(key,
              style: const TextStyle(
                  color: _svDarkNavy, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _svGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _svDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _svLightBlue.withValues(alpha: 0.5),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  SurfaceAndroidViewController — Deep Demo');
  print('  Android SurfaceView-based platform view compositing');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _svSeafoam,
      appBarTheme: const AppBarTheme(
        backgroundColor: _svOcean,
        foregroundColor: _svWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SurfaceAndroidViewController'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildThreeStrategiesComparison(),
            _buildSurfaceViewFundamentals(),
            _buildCreationAndInit(),
            _buildRenderingPipeline(),
            _buildZOrdering(),
            _buildPerformanceCharacteristics(),
            _buildTouchEventRouting(),
            _buildLifecycleManagement(),
            _buildUseCases(),
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
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_svOcean, _svMedBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x400D47A1), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.layers, size: 52, color: _svWhite),
        const SizedBox(height: 12),
        const Text('SurfaceAndroidViewController',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _svWhite, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _svWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'SurfaceView · Platform Views · Z-Order Compositing',
            style: TextStyle(color: _svWhite, fontSize: 11),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _svChip('services', _svWhite),
            _svChip('Android', _svWhite),
            _svChip('SurfaceView', _svWhite),
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
  print('[Section 2] What is SurfaceAndroidViewController?');
  return _svSection('What Is SurfaceAndroidViewController?', [
    _svBody(
      'SurfaceAndroidViewController manages an Android platform view '
      'that uses a SurfaceView for rendering. SurfaceView provides a '
      'dedicated drawing surface embedded in the view hierarchy, rendered '
      'on a separate thread from the main UI.',
    ),
    _svDivider(),
    _svLabel('Key Characteristics'),
    _svBody(
      '• Uses Android\'s SurfaceView (separate window surface)\n'
      '• Hardware-accelerated rendering on dedicated thread\n'
      '• Best for high-performance content (video, camera, OpenGL)\n'
      '• Has Z-ordering constraints (appears behind or in front of View hierarchy)\n'
      '• Part of Flutter\'s platform view embedding system',
    ),
    _svDivider(),
    _svLabel('Class Hierarchy'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _svSeafoam,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClassItem('PlatformViewController', _svGray, 0),
          _buildClassItem('├── AndroidViewController', _svMedBlue, 1),
          _buildClassItem('│   ├── SurfaceAndroidViewController  ★', _svOcean, 2),
          _buildClassItem('│   ├── TextureAndroidViewController', _svGray, 2),
          _buildClassItem('│   └── HybridAndroidViewController', _svGray, 2),
          _buildClassItem('└── UiKitViewController', _svGray, 1),
        ],
      ),
    ),
  ]);
}

Widget _buildClassItem(String text, Color color, int indent) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 10.0, bottom: 3),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: text.contains('★') ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'monospace')),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — Three Strategies Comparison
// ═══════════════════════════════════════════════════════════════
Widget _buildThreeStrategiesComparison() {
  print('[Section 3] Three Android view strategies');
  return _svSection('Android Platform View Strategies', [
    _svBody(
      'Flutter offers three ways to embed native Android views. Each has '
      'different trade-offs:',
    ),
    _svDivider(),
    _buildStrategyCard(
      'TextureAndroidViewController',
      Icons.texture,
      _svGray,
      'Renders to a SurfaceTexture, copies pixels into Flutter\'s texture layer.',
      ['+ Full compositing flexibility', '+ Can be clipped, transformed, layered',
       '- Extra GPU copy per frame', '- Higher memory usage'],
    ),
    _buildStrategyCard(
      'SurfaceAndroidViewController ★',
      Icons.layers,
      _svOcean,
      'Uses a SurfaceView with its own windowing surface, composited by Z-order.',
      ['+ No GPU copy overhead', '+ Best for video/OpenGL/camera',
       '+ Dedicated rendering thread', '- Z-ordering constraints',
       '- Cannot be clipped by Flutter widgets'],
    ),
    _buildStrategyCard(
      'HybridAndroidViewController',
      Icons.merge_type,
      _svAccentCyan,
      'Combines both approaches, switching based on the compositing needs.',
      ['+ Adapts to context', '+ Managed automatically by the engine',
       '- Slight switching overhead', '- More complex internals'],
    ),
  ]);
}

Widget _buildStrategyCard(
    String name, IconData icon, Color color, String desc, List<String> points) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: color.withValues(alpha: name.contains('★') ? 0.6 : 0.2),
        width: name.contains('★') ? 2 : 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(name,
                  style: TextStyle(
                      color: color, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        _svBody(desc),
        ...points.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 4),
              child: Text(p,
                  style: TextStyle(
                      color: p.startsWith('+') ? _svAccentGreen : _svAccentOrange,
                      fontSize: 11)),
            )),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — SurfaceView Fundamentals
// ═══════════════════════════════════════════════════════════════
Widget _buildSurfaceViewFundamentals() {
  print('[Section 4] SurfaceView fundamentals');
  return _svSection('SurfaceView Fundamentals', [
    _svBody(
      'SurfaceView is a core Android class that provides a dedicated '
      'drawing surface (a "window") within the View hierarchy:',
    ),
    _svDivider(),
    // SurfaceView vs TextureView
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _svOcean.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _svOcean, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.layers, size: 24, color: _svOcean),
                const SizedBox(height: 4),
                const Text('SurfaceView',
                    style: TextStyle(
                        color: _svOcean, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                _svBody('Separate window surface'),
                _svBody('Composited by WindowManager'),
                _svBody('Z-ordered (behind/in front)'),
                _svBody('No View hierarchy clipping'),
                _svBody('Hardware overlay path'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _svGray.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _svGray.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.texture, size: 24, color: _svGray),
                const SizedBox(height: 4),
                const Text('TextureView',
                    style: TextStyle(
                        color: _svGray, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                _svBody('Part of View hierarchy'),
                _svBody('Rendered as a texture'),
                _svBody('Full clipping support'),
                _svBody('Can be transformed'),
                _svBody('Extra copy per frame'),
              ],
            ),
          ),
        ),
      ],
    ),
    _svDivider(),
    _svLabel('SurfaceHolder'),
    _svBody(
      'SurfaceView exposes its drawing surface via SurfaceHolder. The '
      'holder provides callbacks for surface creation, change, and destruction. '
      'Rendering code draws to the Surface obtained from the holder.',
    ),
    _svInfoRow('surfaceCreated', 'Surface allocated, safe to start rendering'),
    _svInfoRow('surfaceChanged', 'Size or format changed, reconfigure rendering'),
    _svInfoRow('surfaceDestroyed', 'Surface being released, stop all rendering'),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Creation and Initialization
// ═══════════════════════════════════════════════════════════════
Widget _buildCreationAndInit() {
  print('[Section 5] Creation and initialization');
  return _svSection('Creation & Initialization', [
    _svBody(
      'Creating a SurfaceAndroidViewController involves registering the '
      'view type and factory on the Android side:',
    ),
    _svDivider(),
    _buildInitStep(1, 'Register ViewFactory',
        'Android side: PlatformViewRegistry.registerViewFactory("my-view", factory)',
        _svOcean),
    _buildInitStep(2, 'Dart creates controller',
        'PlatformViewsService.initSurfaceAndroidView(viewType: "my-view", ...)',
        _svMedBlue),
    _buildInitStep(3, 'Platform creates SurfaceView',
        'Android creates the native SurfaceView and attaches it',
        _svAccentCyan),
    _buildInitStep(4, 'Surface allocated',
        'SurfaceHolder.Callback.surfaceCreated fires, rendering can begin',
        _svAccentGreen),
    _buildInitStep(5, 'Size configured',
        'setSize() or resize() calls match Flutter\'s layout constraints',
        _svAccentOrange),
    _svDivider(),
    _svLabel('initSurfaceAndroidView Parameters'),
    _svInfoRow('id', 'Unique view ID for platform channel communication'),
    _svInfoRow('viewType', 'String matching the registered factory name'),
    _svInfoRow('layoutDirection', 'TextDirection.ltr or TextDirection.rtl'),
    _svInfoRow('creationParams', 'Optional parameters passed to the factory'),
    _svInfoRow('creationParamsCodec', 'Codec for serializing creation params'),
  ]);
}

Widget _buildInitStep(int num, String title, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _svWhite, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _svGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Rendering Pipeline
// ═══════════════════════════════════════════════════════════════
Widget _buildRenderingPipeline() {
  print('[Section 6] Rendering pipeline');
  return _svSection('Rendering Pipeline', [
    _svBody(
      'SurfaceAndroidViewController\'s rendering path differs from '
      'texture-based approaches because the SurfaceView has its own '
      'window surface:',
    ),
    _svDivider(),
    // Pipeline visualization
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _svDarkNavy.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPipelineNode('Native Android Renderer', 'Draws directly to SurfaceView\'s Surface',
              _svOcean, Icons.brush),
          _buildPipelineArrowDown(),
          _buildPipelineNode('SurfaceFlinger (Android)',
              'Composites all window surfaces at system level',
              _svMedBlue, Icons.layers),
          _buildPipelineArrowDown(),
          _buildPipelineNode('Display Hardware', 'Final frame shown on screen',
              _svAccentGreen, Icons.monitor),
        ],
      ),
    ),
    _svDivider(),
    _svLabel('Contrast: Texture-Based Pipeline'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _svGray.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPipelineNode('Native Renderer', 'Draws to SurfaceTexture',
              _svGray, Icons.brush),
          _buildPipelineArrowDown(),
          _buildPipelineNode('GPU Copy', 'Texture copied to Flutter\'s OpenGL context',
              _svAccentOrange, Icons.copy),
          _buildPipelineArrowDown(),
          _buildPipelineNode('Flutter Composition', 'Composited with Flutter widgets',
              _svGray, Icons.layers),
          _buildPipelineArrowDown(),
          _buildPipelineNode('SurfaceFlinger', 'Final compositing',
              _svGray, Icons.monitor),
        ],
      ),
    ),
    _svDivider(),
    _svBody(
      'The SurfaceView path skips the GPU copy step, which is why it '
      'performs better for high-throughput content like video and camera.',
    ),
  ]);
}

Widget _buildPipelineNode(String name, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _svGray, fontSize: 10.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineArrowDown() {
  return Container(
    margin: const EdgeInsets.only(left: 20),
    height: 16,
    width: 2,
    color: _svLightBlue.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Z-Ordering
// ═══════════════════════════════════════════════════════════════
Widget _buildZOrdering() {
  print('[Section 7] Z-ordering');
  return _svSection('Z-Ordering & Compositing', [
    _svBody(
      'SurfaceView\'s biggest constraint is Z-ordering. Since it lives '
      'in its own window surface, it can only be placed behind or on top '
      'of the app\'s main View hierarchy — not between layers:',
    ),
    _svDivider(),
    // Z-order visualization
    Container(
      height: 200,
      decoration: BoxDecoration(
        color: _svDarkGray.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _svLightBlue),
      ),
      child: Stack(
        children: [
          // Background layer label
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _svGray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Z-Order Stack',
                  style: TextStyle(color: _svGray, fontSize: 9)),
            ),
          ),
          // Layer 1: Behind (SurfaceView area)
          Positioned(
            left: 20,
            right: 20,
            top: 40,
            bottom: 40,
            child: Container(
              decoration: BoxDecoration(
                color: _svOcean.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _svOcean, width: 2),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.video_library, size: 32, color: _svOcean),
                    SizedBox(height: 4),
                    Text('SurfaceView (Z-behind)',
                        style: TextStyle(color: _svOcean, fontSize: 11,
                            fontWeight: FontWeight.w700)),
                    Text('Native video content',
                        style: TextStyle(color: _svGray, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
          // Layer 2: Flutter overlay on top
          Positioned(
            right: 30,
            top: 50,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _svWhite.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: _svDarkGray.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Flutter Overlay',
                      style: TextStyle(color: _svMedBlue, fontSize: 10,
                          fontWeight: FontWeight.w700)),
                  Text('Z-above: visible',
                      style: TextStyle(color: _svGray, fontSize: 9)),
                ],
              ),
            ),
          ),
          // Flutter widget that would be obscured
          Positioned(
            left: 30,
            bottom: 50,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _svAccentOrange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _svAccentOrange,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Flutter Below',
                      style: TextStyle(color: _svAccentOrange, fontSize: 10,
                          fontWeight: FontWeight.w700)),
                  Text('Z-behind: obscured!',
                      style: TextStyle(color: _svAccentOrange, fontSize: 9)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    _svDivider(),
    _svLabel('Z-Order Options'),
    _svInfoRow('setZOrderOnTop(true)', 'SurfaceView renders in front of View hierarchy'),
    _svInfoRow('setZOrderOnTop(false)', 'SurfaceView renders behind View hierarchy'),
    _svInfoRow('setZOrderMediaOverlay', 'Puts between normal and on-top surfaces'),
    _svDivider(),
    _svBody(
      'This is the primary trade-off: SurfaceView gets better performance '
      'but cannot be arbitrarily layered with Flutter widgets. If you '
      'need a native view clipped or sandwiched between Flutter layers, '
      'use Texture or Hybrid mode instead.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Performance
// ═══════════════════════════════════════════════════════════════
Widget _buildPerformanceCharacteristics() {
  print('[Section 8] Performance characteristics');
  return _svSection('Performance Characteristics', [
    _svBody(
      'SurfaceAndroidViewController excels in performance-critical '
      'scenarios:',
    ),
    _svDivider(),
    _buildPerfCard('Memory', 'No extra texture buffer needed. The native '
        'view draws directly to its own surface without copying.',
        Icons.memory, _svOcean, '✓ Lower'),
    _buildPerfCard('GPU', 'No GPU copy per frame. SurfaceFlinger handles '
        'compositing at the system level with hardware overlays.',
        Icons.speed, _svAccentGreen, '✓ Minimal'),
    _buildPerfCard('Latency', 'Direct path from native renderer to display. '
        'One less compositing step than texture-based.',
        Icons.timer, _svMedBlue, '✓ Lower'),
    _buildPerfCard('Threading', 'SurfaceView supports rendering from any thread, '
        'including a dedicated rendering thread.',
        Icons.lan, _svAccentCyan, '✓ Flexible'),
    _buildPerfCard('Compositing', 'Z-order only. Cannot clip or transform. '
        'This is the trade-off for performance gains.',
        Icons.warning_amber, _svAccentOrange, '✗ Limited'),
    _svDivider(),
    _svLabel('When to Choose SurfaceAndroidViewController'),
    _svBody(
      '• Video playback (ExoPlayer, MediaPlayer)\n'
      '• Camera preview (CameraX, Camera2)\n'
      '• OpenGL/Vulkan rendering (games, 3D content)\n'
      '• WebView with hardware acceleration\n'
      '• Any content that needs 60fps native rendering',
    ),
  ]);
}

Widget _buildPerfCard(
    String metric, String desc, IconData icon, Color color, String rating) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(metric,
                      style: TextStyle(
                          color: color, fontSize: 12, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(rating,
                        style: TextStyle(color: color, fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(desc,
                  style: const TextStyle(color: _svGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Touch Event Routing
// ═══════════════════════════════════════════════════════════════
Widget _buildTouchEventRouting() {
  print('[Section 9] Touch event routing');
  return _svSection('Touch Event Routing', [
    _svBody(
      'Handling touch events with SurfaceView requires special routing '
      'because the view lives in a separate window surface:',
    ),
    _svDivider(),
    // Touch routing diagram
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _svSeafoam,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTouchStep('User touches screen', Icons.touch_app, _svOcean),
          _buildTouchArrow(),
          _buildTouchStep('Flutter receives MotionEvent', Icons.flutter_dash, _svMedBlue),
          _buildTouchArrow(),
          _buildTouchStep('Hit test: is touch in platform view area?', Icons.gps_fixed, _svAccentCyan),
          _buildTouchArrow(),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _svAccentGreen.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _svAccentGreen.withValues(alpha: 0.3)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.check, size: 16, color: _svAccentGreen),
                      Text('Yes → Forward',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _svAccentGreen, fontSize: 10,
                              fontWeight: FontWeight.w700)),
                      Text('Send to native view\nvia platform channel',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _svGray, fontSize: 9)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _svAccentOrange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _svAccentOrange.withValues(alpha: 0.3)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.close, size: 16, color: _svAccentOrange),
                      Text('No → Flutter',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _svAccentOrange, fontSize: 10,
                              fontWeight: FontWeight.w700)),
                      Text('Handle in Flutter\ngesture system',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _svGray, fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    _svDivider(),
    _svLabel('Gesture Policies'),
    _svInfoRow('Opaque', 'All touches go to the platform view'),
    _svInfoRow('Translucent', 'Platform view gets touches, Flutter also receives'),
    _svInfoRow('Eager', 'Flutter handles first, then forwards to native'),
  ]);
}

Widget _buildTouchStep(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _svWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget _buildTouchArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 20),
    height: 12,
    width: 2,
    color: _svLightBlue.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Lifecycle Management
// ═══════════════════════════════════════════════════════════════
Widget _buildLifecycleManagement() {
  print('[Section 10] Lifecycle management');

  Widget state(String name, String desc, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 14, color: _svWhite),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: color, fontSize: 12, fontWeight: FontWeight.w700)),
                Text(desc,
                    style: const TextStyle(color: _svGray, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _svSection('Lifecycle Management', [
    _svBody(
      'SurfaceAndroidViewController manages the full lifecycle of the '
      'native SurfaceView:',
    ),
    _svDivider(),
    state('Uninitialized', 'Controller created but view not yet attached',
        _svGray, Icons.hourglass_empty),
    state('Creating', 'Platform is creating the native SurfaceView',
        _svMedBlue, Icons.build),
    state('Created', 'SurfaceView exists, surface allocated',
        _svOcean, Icons.check_circle),
    state('Sized', 'Layout constraints applied, rendering active',
        _svAccentGreen, Icons.aspect_ratio),
    state('Disposed', 'dispose() called, SurfaceView destroyed',
        _svAccentOrange, Icons.delete),
    _svDivider(),
    _svLabel('Important Lifecycle Rules'),
    _svBody(
      '• Always call dispose() when the view is no longer needed\n'
      '• Await creation before calling setSize()\n'
      '• Do not render to a disposed surface\n'
      '• Handle app lifecycle pauses (surface may be released)',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Use Cases
// ═══════════════════════════════════════════════════════════════
Widget _buildUseCases() {
  print('[Section 11] Use cases');
  return _svSection('Real-World Use Cases', [
    _svBody(
      'SurfaceAndroidViewController is ideal for embedding native '
      'content that requires high performance:',
    ),
    _svDivider(),
    _buildUseCaseCard('Video Player', Icons.play_circle,
        'ExoPlayer or MediaPlayer rendering directly to SurfaceView. '
        'No frame-by-frame GPU copy means smooth 4K/60fps playback.',
        _svOcean, _buildVideoPreview()),
    _buildUseCaseCard('Camera Preview', Icons.camera_alt,
        'CameraX or Camera2 renders the viewfinder to SurfaceView. '
        'Real-time camera feed at full native frame rate.',
        _svAccentCyan, _buildCameraPreview()),
    _buildUseCaseCard('OpenGL / Vulkan', Icons.threed_rotation,
        'Custom 3D rendering engine draws directly to the Surface. '
        'Zero-copy path from GPU to display.',
        _svMedBlue, _buildGLPreview()),
    _buildUseCaseCard('Maps (MapView)', Icons.map,
        'Google Maps or Mapbox renders tile layers to SurfaceView. '
        'Smooth panning and zooming at native performance.',
        _svAccentGreen, _buildMapPreview()),
  ]);
}

Widget _buildUseCaseCard(
    String name, IconData icon, String desc, Color color, Widget preview) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            color: color, fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 3),
                    Text(desc,
                        style: const TextStyle(color: _svGray, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
        preview,
      ],
    ),
  );
}

Widget _buildVideoPreview() {
  return Container(
    height: 60,
    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    decoration: BoxDecoration(
      color: _svDarkGray,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      children: [
        const Center(
          child: Icon(Icons.play_arrow, size: 30, color: _svWhite),
        ),
        Positioned(
          bottom: 6,
          left: 8,
          right: 8,
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: _svGray.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.4,
              child: Container(
                decoration: BoxDecoration(
                  color: _svOcean,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCameraPreview() {
  return Container(
    height: 60,
    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _svAccentCyan.withValues(alpha: 0.2),
          _svAccentGreen.withValues(alpha: 0.1),
        ],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera, size: 20, color: _svAccentCyan),
          SizedBox(width: 8),
          Text('Camera Viewfinder',
              style: TextStyle(color: _svAccentCyan, fontSize: 11)),
        ],
      ),
    ),
  );
}

Widget _buildGLPreview() {
  return Container(
    height: 60,
    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    decoration: BoxDecoration(
      color: _svDarkNavy.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(8),
    ),
    child: CustomPaint(
      size: const Size(double.infinity, 60),
      painter: _GLGridPainter(),
    ),
  );
}

Widget _buildMapPreview() {
  return Container(
    height: 60,
    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    decoration: BoxDecoration(
      color: _svAccentGreen.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _svAccentGreen.withValues(alpha: 0.2)),
    ),
    child: Stack(
      children: [
        CustomPaint(
          size: const Size(double.infinity, 60),
          painter: _MapRoadPainter(),
        ),
        const Positioned(
          top: 8,
          right: 8,
          child: Icon(Icons.my_location, size: 16, color: _svAccentGreen),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('SurfaceAndroidViewController deep demo complete.');
  return _svSection('Summary', [
    _svBody(
      'SurfaceAndroidViewController provides the highest-performance '
      'path for embedding native Android views in Flutter. By using '
      'a SurfaceView, it avoids per-frame GPU copies at the cost of '
      'Z-ordering flexibility.',
    ),
    _svDivider(),
    _svLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _svOcean.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _svBody('✦ Uses SurfaceView — separate window surface in Android'),
          _svBody('✦ No GPU copy per frame (best performance)'),
          _svBody('✦ Z-ordering only (behind or in front, not between)'),
          _svBody('✦ Ideal for video, camera, OpenGL, maps'),
          _svBody('✦ Rendering on dedicated thread supported'),
          _svBody('✦ Touch events forwarded via platform channel'),
          _svBody('✦ Part of AndroidViewController hierarchy'),
          _svBody('✦ Use TextureAndroidViewController if you need clipping'),
        ],
      ),
    ),
    _svDivider(),
    Wrap(
      children: [
        _svChip('SurfaceAndroidViewController', _svOcean),
        _svChip('SurfaceView', _svMedBlue),
        _svChip('Z-Order', _svAccentCyan),
        _svChip('No GPU Copy', _svAccentGreen),
        _svChip('Platform Views', _svAccentOrange),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Custom painters
// ═══════════════════════════════════════════════════════════════
class _GLGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _svMedBlue.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    // Perspective grid
    for (int i = 1; i < 8; i++) {
      final y = size.height * i / 8;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final cx = size.width / 2;
    for (int i = -4; i <= 4; i++) {
      final x = cx + i * 20.0;
      canvas.drawLine(Offset(x, 0), Offset(cx + i * 40.0, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapRoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = _svGray.withValues(alpha: 0.15)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // Horizontal road
    canvas.drawLine(
        Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.6),
        roadPaint);
    // Vertical road
    canvas.drawLine(
        Offset(size.width * 0.3, 0),
        Offset(size.width * 0.5, size.height),
        roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
