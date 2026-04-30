// ignore_for_file: avoid_print
// Deep demo: TextureAndroidViewController — Texture-based Android platform views
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Forest Pine / Mint
// ─────────────────────────────────────────────────────────────
const Color _tvPine = Color(0xFF1B5E20);
const Color _tvMint = Color(0xFFE8F5E9);
const Color _tvDarkForest = Color(0xFF0D3311);
const Color _tvMedGreen = Color(0xFF2E7D32);
const Color _tvLightGreen = Color(0xFFA5D6A7);
const Color _tvWhite = Color(0xFFFFFFFF);
const Color _tvGray = Color(0xFF455A48);
const Color _tvAccentBlue = Color(0xFF1565C0);
const Color _tvAccentOrange = Color(0xFFEF6C00);
const Color _tvAccentPurple = Color(0xFF6A1B9A);
const Color _tvAccentRed = Color(0xFFC62828);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _tvSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tvWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _tvLightGreen, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A1B5E20), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _tvPine,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _tvWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _tvLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _tvDarkForest, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _tvBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _tvGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _tvChip(String label, Color color) {
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

Widget _tvInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key,
              style: const TextStyle(
                  color: _tvDarkForest, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _tvGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _tvDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _tvLightGreen.withValues(alpha: 0.5),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  TextureAndroidViewController — Deep Demo');
  print('  Texture-based Android platform view compositing');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _tvMint,
      appBarTheme: const AppBarTheme(
        backgroundColor: _tvPine,
        foregroundColor: _tvWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TextureAndroidViewController'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildVirtualDisplay(),
            _buildSurfaceTexturePipeline(),
            _buildCreationFlow(),
            _buildTextureCompositing(),
            _buildClippingTransforms(),
            _buildPerformanceTradeoffs(),
            _buildMemoryManagement(),
            _buildAccessibility(),
            _buildComparisonMatrix(),
            _buildSimulatedView(),
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
        colors: [_tvPine, _tvMedGreen],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x401B5E20), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.texture, size: 52, color: _tvWhite),
        const SizedBox(height: 12),
        const Text('TextureAndroidViewController',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _tvWhite, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _tvWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Virtual Display · SurfaceTexture · GPU Copy',
            style: TextStyle(color: _tvWhite, fontSize: 11),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            _tvChip('services', _tvWhite),
            _tvChip('Android', _tvWhite),
            _tvChip('Texture', _tvWhite),
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
  print('[Section 2] What is TextureAndroidViewController?');
  return _tvSection('What Is TextureAndroidViewController?', [
    _tvBody(
      'TextureAndroidViewController manages an Android platform view '
      'that renders to a SurfaceTexture. The native view\'s pixels are '
      'captured as an OpenGL texture and composited into Flutter\'s '
      'rendering pipeline as a texture layer.',
    ),
    _tvDivider(),
    _tvLabel('Key Characteristics'),
    _tvBody(
      '• Renders native views via Virtual Display → SurfaceTexture\n'
      '• Full compositing flexibility (clip, transform, layer)\n'
      '• Per-frame GPU copy from native surface to Flutter texture\n'
      '• Was the original (and only) Android platform view strategy\n'
      '• Higher memory usage due to texture buffer',
    ),
    _tvDivider(),
    _tvLabel('Class Hierarchy'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tvMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHierarchyItem('PlatformViewController', _tvGray, 0),
          _buildHierarchyItem('├── AndroidViewController', _tvMedGreen, 1),
          _buildHierarchyItem('│   ├── SurfaceAndroidViewController', _tvGray, 2),
          _buildHierarchyItem('│   ├── TextureAndroidViewController  ★', _tvPine, 2),
          _buildHierarchyItem('│   └── HybridAndroidViewController', _tvGray, 2),
          _buildHierarchyItem('└── UiKitViewController', _tvGray, 1),
        ],
      ),
    ),
  ]);
}

Widget _buildHierarchyItem(String text, Color color, int indent) {
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
// Section 3 — Virtual Display Mechanism
// ═══════════════════════════════════════════════════════════════
Widget _buildVirtualDisplay() {
  print('[Section 3] Virtual Display mechanism');
  return _tvSection('Virtual Display Mechanism', [
    _tvBody(
      'TextureAndroidViewController uses Android\'s VirtualDisplay API '
      'to create an off-screen display where the native view renders. '
      'The VirtualDisplay captures the view\'s output to a Surface '
      'backed by a SurfaceTexture.',
    ),
    _tvDivider(),
    _tvLabel('What is VirtualDisplay?'),
    _tvBody(
      'VirtualDisplay is an Android API that creates a virtual screen. '
      'It has its own width, height, and pixel density. Views attached '
      'to it render as if they were on a real display, but their output '
      'goes to a Surface of your choosing.',
    ),
    _tvDivider(),
    // VirtualDisplay anatomy
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tvPine.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildVDComponent('VirtualDisplay', 'Off-screen display surface',
              Icons.monitor, _tvPine),
          const SizedBox(height: 6),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(child: _buildVDComponent('Presentation',
                  'Window attached to VirtualDisplay',
                  Icons.window, _tvMedGreen)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const SizedBox(width: 40),
              Expanded(child: _buildVDComponent('Native View',
                  'The actual Android view rendering',
                  Icons.widgets, _tvAccentBlue)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(child: _buildVDComponent('Surface / SurfaceTexture',
                  'Receives the rendered pixels',
                  Icons.image, _tvAccentPurple)),
            ],
          ),
        ],
      ),
    ),
    _tvDivider(),
    _tvLabel('VirtualDisplay Parameters'),
    _tvInfoRow('name', 'Debug identifier for the virtual display'),
    _tvInfoRow('width', 'Pixel width matching Flutter layout'),
    _tvInfoRow('height', 'Pixel height matching Flutter layout'),
    _tvInfoRow('densityDpi', 'Pixel density of the virtual display'),
    _tvInfoRow('surface', 'Target Surface backed by SurfaceTexture'),
    _tvInfoRow('flags', 'PUBLIC or SECURE display flags'),
  ]);
}

Widget _buildVDComponent(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _tvGray, fontSize: 10.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — SurfaceTexture Pipeline
// ═══════════════════════════════════════════════════════════════
Widget _buildSurfaceTexturePipeline() {
  print('[Section 4] SurfaceTexture pipeline');
  return _tvSection('SurfaceTexture Pipeline', [
    _tvBody(
      'The SurfaceTexture is the key component that bridges the native '
      'view\'s rendering to Flutter\'s OpenGL context:',
    ),
    _tvDivider(),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tvDarkForest.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPipeNode('Native View renders', 'Draw calls go to Surface',
              Icons.brush, _tvPine),
          _buildPipeArrow(),
          _buildPipeNode('SurfaceTexture captures', 'Pixels stored as GL texture',
              Icons.image, _tvMedGreen),
          _buildPipeArrow(),
          _buildPipeNode('updateTexImage()', 'Latest frame made available',
              Icons.sync, _tvAccentBlue),
          _buildPipeArrow(),
          _buildPipeNode('Flutter reads texture', 'GPU copy into Flutter\'s GL context',
              Icons.copy, _tvAccentOrange),
          _buildPipeArrow(),
          _buildPipeNode('Composited as TextureLayer', 'Appears in Flutter scene graph',
              Icons.layers, _tvAccentPurple),
        ],
      ),
    ),
    _tvDivider(),
    _tvLabel('Frame Synchronization'),
    _tvBody(
      'onFrameAvailable callback signals when a new frame is ready. '
      'Flutter\'s engine calls updateTexImage() to consume it. If '
      'frames arrive faster than Flutter renders, some are dropped.',
    ),
    _tvInfoRow('Producer', 'Native view rendering to Surface'),
    _tvInfoRow('Buffer', 'SurfaceTexture\'s internal BufferQueue'),
    _tvInfoRow('Consumer', 'Flutter engine calling updateTexImage()'),
  ]);
}

Widget _buildPipeNode(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
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
                  style: const TextStyle(color: _tvGray, fontSize: 10.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipeArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 24),
    height: 14,
    width: 2,
    color: _tvLightGreen.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Creation Flow
// ═══════════════════════════════════════════════════════════════
Widget _buildCreationFlow() {
  print('[Section 5] Creation flow');
  return _tvSection('Creation Flow', [
    _tvBody(
      'Creating a TextureAndroidViewController involves multiple steps '
      'across Dart and the Android platform:',
    ),
    _tvDivider(),
    _buildCreationStep(1, 'Register factory',
        'Android: PlatformViewRegistry.registerViewFactory("type", factory)',
        _tvPine),
    _buildCreationStep(2, 'Dart requests view',
        'PlatformViewsService.initAndroidView(viewType: "type", ...)',
        _tvMedGreen),
    _buildCreationStep(3, 'Engine creates VirtualDisplay',
        'Off-screen display created at requested size',
        _tvAccentBlue),
    _buildCreationStep(4, 'Factory creates native view',
        'View attached to VirtualDisplay\'s Presentation',
        _tvAccentPurple),
    _buildCreationStep(5, 'SurfaceTexture allocated',
        'Texture buffer created, linked to VirtualDisplay\'s Surface',
        _tvAccentOrange),
    _buildCreationStep(6, 'Texture ID returned',
        'Dart receives textureId for TextureLayer compositing',
        _tvPine),
    _tvDivider(),
    _tvLabel('initAndroidView Parameters'),
    _tvInfoRow('id', 'Unique view ID for platform channel messages'),
    _tvInfoRow('viewType', 'String matching the Android factory name'),
    _tvInfoRow('layoutDirection', 'TextDirection.ltr or TextDirection.rtl'),
    _tvInfoRow('creationParams', 'Parameters passed to the view factory'),
    _tvInfoRow('creationParamsCodec', 'Codec for serializing params'),
    _tvInfoRow('onFocus', 'Callback when native view requests focus'),
  ]);
}

Widget _buildCreationStep(int num, String title, String desc, Color color) {
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
                    color: _tvWhite, fontSize: 12, fontWeight: FontWeight.w800)),
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
                  style: const TextStyle(color: _tvGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Texture Compositing
// ═══════════════════════════════════════════════════════════════
Widget _buildTextureCompositing() {
  print('[Section 6] Texture compositing');
  return _tvSection('Texture Compositing in Flutter', [
    _tvBody(
      'Once the textureId is obtained, Flutter composites the native '
      'view\'s output using a TextureLayer in the scene graph:',
    ),
    _tvDivider(),
    _tvLabel('Scene Graph Integration'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tvMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSceneItem('Scene', _tvGray, 0),
          _buildSceneItem('├── PictureLayer (Flutter widgets above)', _tvGray, 1),
          _buildSceneItem('├── TextureLayer (platform view) ★', _tvPine, 1),
          _buildSceneItem('│   textureId: 42', _tvMedGreen, 2),
          _buildSceneItem('│   rect: (0, 200, 400, 500)', _tvMedGreen, 2),
          _buildSceneItem('└── PictureLayer (Flutter widgets below)', _tvGray, 1),
        ],
      ),
    ),
    _tvDivider(),
    _tvLabel('How TextureLayer Works'),
    _tvBody(
      '• References the GL texture by its integer ID\n'
      '• Positioned and sized by the Rect parameter\n'
      '• Flutter\'s compositor reads the texture during rasterization\n'
      '• The texture is blended with other layers in Z-order\n'
      '• Allows Flutter widgets to appear both above and below',
    ),
    _tvDivider(),
    _tvLabel('Advantage Over SurfaceView'),
    _tvBody(
      'Because the native content is a texture within Flutter\'s '
      'compositor, it can be freely interleaved with Flutter widgets. '
      'SurfaceView can only appear entirely behind or in front.',
    ),
  ]);
}

Widget _buildSceneItem(String text, Color color, int indent) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 12.0, bottom: 3),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: text.contains('★') ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'monospace')),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Clipping and Transformations
// ═══════════════════════════════════════════════════════════════
Widget _buildClippingTransforms() {
  print('[Section 7] Clipping and transformations');
  return _tvSection('Clipping & Transformations', [
    _tvBody(
      'A major advantage of texture-based compositing: the platform '
      'view can be clipped, transformed, and layered like any Flutter '
      'widget.',
    ),
    _tvDivider(),
    // Clipping demonstrations
    Row(
      children: [
        Expanded(child: _buildTransformCard('Clip Rect',
            Icons.crop, _tvPine, _buildClipRectDemo())),
        const SizedBox(width: 8),
        Expanded(child: _buildTransformCard('Clip RRect',
            Icons.rounded_corner, _tvMedGreen, _buildClipRRectDemo())),
      ],
    ),
    const SizedBox(height: 8),
    Row(
      children: [
        Expanded(child: _buildTransformCard('Rotation',
            Icons.rotate_right, _tvAccentBlue, _buildRotateDemo())),
        const SizedBox(width: 8),
        Expanded(child: _buildTransformCard('Scale',
            Icons.zoom_in, _tvAccentPurple, _buildScaleDemo())),
      ],
    ),
    const SizedBox(height: 8),
    Row(
      children: [
        Expanded(child: _buildTransformCard('Opacity',
            Icons.opacity, _tvAccentOrange, _buildOpacityDemo())),
        const SizedBox(width: 8),
        Expanded(child: _buildTransformCard('Stacking',
            Icons.layers, _tvGray, _buildStackDemo())),
      ],
    ),
    _tvDivider(),
    _tvLabel('SurfaceView Cannot Do This'),
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tvAccentRed.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tvAccentRed.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber, size: 16, color: _tvAccentRed),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'SurfaceView has its own window and cannot be clipped '
              'or transformed by Flutter. This is the primary reason '
              'to choose Texture mode.',
              style: TextStyle(color: _tvAccentRed, fontSize: 11),
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildTransformCard(
    String name, IconData icon, Color color, Widget demo) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(name,
                style: TextStyle(
                    color: color, fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(height: 50, child: demo),
      ],
    ),
  );
}

Widget _buildClipRectDemo() {
  return ClipRect(
    child: Container(
      color: _tvPine.withValues(alpha: 0.2),
      child: const Center(
        child: Text('Clipped', style: TextStyle(color: _tvPine, fontSize: 10)),
      ),
    ),
  );
}

Widget _buildClipRRectDemo() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      color: _tvMedGreen.withValues(alpha: 0.2),
      child: const Center(
        child: Text('Rounded', style: TextStyle(color: _tvMedGreen, fontSize: 10)),
      ),
    ),
  );
}

Widget _buildRotateDemo() {
  return Center(
    child: Transform.rotate(
      angle: 0.2,
      child: Container(
        width: 40,
        height: 30,
        color: _tvAccentBlue.withValues(alpha: 0.2),
        child: const Center(
          child: Text('15°', style: TextStyle(color: _tvAccentBlue, fontSize: 10)),
        ),
      ),
    ),
  );
}

Widget _buildScaleDemo() {
  return Center(
    child: Transform.scale(
      scale: 0.8,
      child: Container(
        color: _tvAccentPurple.withValues(alpha: 0.2),
        child: const Center(
          child: Text('0.8x', style: TextStyle(color: _tvAccentPurple, fontSize: 10)),
        ),
      ),
    ),
  );
}

Widget _buildOpacityDemo() {
  return Stack(
    children: [
      Container(color: _tvAccentOrange.withValues(alpha: 0.3)),
      Center(
        child: Opacity(
          opacity: 0.5,
          child: Container(
            width: 30,
            height: 30,
            color: _tvAccentOrange,
            child: const Center(
              child: Text('50%', style: TextStyle(color: _tvWhite, fontSize: 9)),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildStackDemo() {
  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 8, left: 4),
        color: _tvGray.withValues(alpha: 0.15),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 8, right: 4),
        color: _tvGray.withValues(alpha: 0.25),
        child: const Center(
          child: Text('Z', style: TextStyle(color: _tvGray, fontSize: 10)),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Performance Trade-offs
// ═══════════════════════════════════════════════════════════════
Widget _buildPerformanceTradeoffs() {
  print('[Section 8] Performance trade-offs');
  return _tvSection('Performance Trade-offs', [
    _tvBody(
      'TextureAndroidViewController trades performance for compositing '
      'flexibility:',
    ),
    _tvDivider(),
    _buildTradeoffCard('GPU Copy Overhead', 'Every frame is copied from the '
        'native SurfaceTexture into Flutter\'s GL context. This copy '
        'costs time and GPU bandwidth.',
        Icons.copy, _tvAccentOrange, '✗ Extra cost'),
    _buildTradeoffCard('Memory Usage', 'Requires a texture buffer large '
        'enough to hold the full view output. At 1080p with 4 bytes per '
        'pixel = ~8MB per view.',
        Icons.memory, _tvAccentRed, '✗ Higher'),
    _buildTradeoffCard('Compositing Flexibility', 'Full support for '
        'clipping, transforms, opacity, and layering with Flutter widgets.',
        Icons.layers, _tvPine, '✓ Full'),
    _buildTradeoffCard('Latency', 'One extra frame of latency due to '
        'the texture copy step. Native rendering is one frame ahead of '
        'Flutter display.',
        Icons.timer, _tvAccentBlue, '~ Slight'),
    _buildTradeoffCard('Thread Safety', 'VirtualDisplay rendering happens '
        'on the platform thread. Heavy native views can compete with '
        'Flutter\'s platform channel work.',
        Icons.lan, _tvAccentPurple, '~ Consider'),
    _tvDivider(),
    _tvLabel('When to Use TextureAndroidViewController'),
    _tvBody(
      '• Native views that need to be clipped by Flutter widgets\n'
      '• Views that must appear between Flutter layers\n'
      '• Scroll views containing platform views\n'
      '• When visual quality > raw frame throughput\n'
      '• Simple or moderately complex native views',
    ),
  ]);
}

Widget _buildTradeoffCard(
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
                        style: TextStyle(
                            color: color, fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(desc,
                  style: const TextStyle(color: _tvGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Memory Management
// ═══════════════════════════════════════════════════════════════
Widget _buildMemoryManagement() {
  print('[Section 9] Memory management');
  return _tvSection('Memory Management', [
    _tvBody(
      'TextureAndroidViewController allocates significant native memory '
      'that must be properly released:',
    ),
    _tvDivider(),
    _tvLabel('Memory Allocations'),
    _buildMemRow('VirtualDisplay', '~2MB', 'Off-screen display metadata', _tvPine),
    _buildMemRow('SurfaceTexture', '~8MB @1080p', 'Pixel buffer (RGBA)', _tvMedGreen),
    _buildMemRow('Native View', 'Variable', 'View hierarchy + rendered content', _tvAccentBlue),
    _buildMemRow('Platform Channel', '~1KB', 'Message buffers', _tvGray),
    _tvDivider(),
    _tvLabel('Disposal Sequence'),
    _buildCreationStep(1, 'dispose() called on controller',
        'Starts the teardown process', _tvPine),
    _buildCreationStep(2, 'Native view detached',
        'View removed from VirtualDisplay presentation', _tvMedGreen),
    _buildCreationStep(3, 'VirtualDisplay released',
        'Off-screen display destroyed', _tvAccentBlue),
    _buildCreationStep(4, 'SurfaceTexture released',
        'GL texture and buffer freed', _tvAccentOrange),
    _buildCreationStep(5, 'Texture ID unregistered',
        'Flutter compositor stops referencing the texture', _tvAccentPurple),
    _tvDivider(),
    _tvLabel('Memory Leak Prevention'),
    _tvBody(
      '• Always call dispose() when the widget is removed\n'
      '• Use StatefulWidget.dispose() as the trigger\n'
      '• Don\'t store references to disposed controllers\n'
      '• Monitor with Android Profiler for texture leaks',
    ),
  ]);
}

Widget _buildMemRow(String label, String size, String note, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(label,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(size,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(note,
              style: const TextStyle(color: _tvGray, fontSize: 10)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Accessibility
// ═══════════════════════════════════════════════════════════════
Widget _buildAccessibility() {
  print('[Section 10] Accessibility bridging');
  return _tvSection('Accessibility Bridging', [
    _tvBody(
      'Platform views need accessibility bridging to allow screen '
      'readers to interact with native content embedded in Flutter:',
    ),
    _tvDivider(),
    _tvLabel('Accessibility Tree'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tvMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAccessItem('Flutter Semantics Tree', _tvGray, false),
          _buildAccessItem('├── Flutter widget semantics', _tvGray, false),
          _buildAccessItem('├── Platform View Bridge ★', _tvPine, true),
          _buildAccessItem('│   ├── Native AccessibilityNodeInfo', _tvMedGreen, false),
          _buildAccessItem('│   ├── TalkBack focus handling', _tvMedGreen, false),
          _buildAccessItem('│   └── Touch exploration routing', _tvMedGreen, false),
          _buildAccessItem('└── More Flutter semantics', _tvGray, false),
        ],
      ),
    ),
    _tvDivider(),
    _tvLabel('Challenges'),
    _tvBody(
      '• VirtualDisplay lives off-screen, confusing accessibility services\n'
      '• Touch coordinates must be translated between virtual and real\n'
      '• Focus traversal must bridge Flutter and native focus systems\n'
      '• Screen reader announcements need coordination',
    ),
    _tvDivider(),
    _tvInfoRow('AccessibilityBridge', 'Translates between Flutter and Android a11y'),
    _tvInfoRow('AccessibilityDelegate', 'Handles native view\'s a11y events'),
    _tvInfoRow('SemanticsNode', 'Flutter side of platform view semantics'),
  ]);
}

Widget _buildAccessItem(String text, Color color, bool highlight) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'monospace')),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Comparison Matrix
// ═══════════════════════════════════════════════════════════════
Widget _buildComparisonMatrix() {
  print('[Section 11] Comparison matrix');
  return _tvSection('Comparison Matrix', [
    _tvBody(
      'Side-by-side comparison of all three Android platform view '
      'strategies:',
    ),
    _tvDivider(),
    // Header
    Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _tvDarkForest.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 80),
          Expanded(child: _buildMatrixHeader('Texture ★', _tvPine)),
          Expanded(child: _buildMatrixHeader('Surface', _tvAccentBlue)),
          Expanded(child: _buildMatrixHeader('Hybrid', _tvAccentPurple)),
        ],
      ),
    ),
    // Rows
    _buildMatrixRow('GPU Copy', '✗ Yes', '✓ No', '~ Auto', 0),
    _buildMatrixRow('Clipping', '✓ Full', '✗ No', '✓ Full', 1),
    _buildMatrixRow('Transform', '✓ Full', '✗ No', '✓ Full', 0),
    _buildMatrixRow('Opacity', '✓ Yes', '✗ No', '✓ Yes', 1),
    _buildMatrixRow('Z-Order', '✓ Free', '~ Limited', '✓ Free', 0),
    _buildMatrixRow('Memory', '✗ Higher', '✓ Lower', '~ Medium', 1),
    _buildMatrixRow('Latency', '~ +1 frame', '✓ Direct', '~ Varies', 0),
    _buildMatrixRow('Video', '~ OK', '✓ Best', '✓ Good', 1),
    _buildMatrixRow('ScrollView', '✓ Works', '✗ Issues', '✓ Works', 0),
  ]);
}

Widget _buildMatrixHeader(String text, Color color) {
  return Center(
    child: Text(text,
        style: TextStyle(
            color: color, fontSize: 10, fontWeight: FontWeight.w700)),
  );
}

Widget _buildMatrixRow(
    String label, String texture, String surface, String hybrid, int alt) {
  final bg = alt == 1
      ? _tvPine.withValues(alpha: 0.03)
      : Colors.transparent;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    color: bg,
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label,
              style: const TextStyle(
                  color: _tvDarkForest, fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        Expanded(child: _buildMatrixCell(texture, _tvPine)),
        Expanded(child: _buildMatrixCell(surface, _tvAccentBlue)),
        Expanded(child: _buildMatrixCell(hybrid, _tvAccentPurple)),
      ],
    ),
  );
}

Widget _buildMatrixCell(String text, Color color) {
  final isGood = text.startsWith('✓');
  final isBad = text.startsWith('✗');
  final cellColor = isGood
      ? _tvPine
      : isBad
          ? _tvAccentRed
          : _tvGray;
  return Center(
    child: Text(text,
        style: TextStyle(
            color: cellColor, fontSize: 10, fontWeight: FontWeight.w600)),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Simulated View
// ═══════════════════════════════════════════════════════════════
Widget _buildSimulatedView() {
  print('[Section 12] Simulated texture view');
  return _tvSection('Simulated Texture View Embedding', [
    _tvBody(
      'This UI simulates a Flutter screen containing a texture-based '
      'platform view, showing how the native content is clipped and '
      'composited inside a scroll view:',
    ),
    _tvDivider(),
    Container(
      height: 280,
      decoration: BoxDecoration(
        color: _tvDarkForest.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _tvLightGreen),
      ),
      child: Column(
        children: [
          // Simulated app bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _tvPine,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(11)),
            ),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, size: 16, color: _tvWhite),
                SizedBox(width: 8),
                Text('My App',
                    style: TextStyle(
                        color: _tvWhite, fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          // Content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flutter widget above
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _tvWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Flutter widget above',
                        style: TextStyle(color: _tvGray, fontSize: 10)),
                  ),
                  const SizedBox(height: 6),
                  // Platform view (clipped in scroll)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: _tvPine, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            // Simulated native map
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _tvLightGreen.withValues(alpha: 0.3),
                                    _tvMint,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: CustomPaint(
                                size: const Size(double.infinity, double.infinity),
                                painter: _SimMapPainter(),
                              ),
                            ),
                            // Label
                            Positioned(
                              top: 4,
                              left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _tvPine.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('TextureLayer (MapView)',
                                    style: TextStyle(
                                        color: _tvWhite, fontSize: 9,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            // Pin
                            const Positioned(
                              top: 30,
                              left: 60,
                              child: Icon(Icons.location_pin, size: 20,
                                  color: _tvAccentRed),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Flutter widget below
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _tvWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Flutter widget below (overlaps clipped view)',
                        style: TextStyle(color: _tvGray, fontSize: 10)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 13 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 13] Summary');
  print('TextureAndroidViewController deep demo complete.');
  return _tvSection('Summary', [
    _tvBody(
      'TextureAndroidViewController was Flutter\'s original strategy for '
      'embedding native Android views. It provides full compositing '
      'flexibility at the cost of per-frame GPU copies. Use it when '
      'clipping, transforms, or layering with Flutter widgets is required.',
    ),
    _tvDivider(),
    _tvLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tvPine.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tvBody('✦ Uses VirtualDisplay → SurfaceTexture → TextureLayer'),
          _tvBody('✦ Full compositing: clip, transform, opacity, layering'),
          _tvBody('✦ Per-frame GPU copy (main performance cost)'),
          _tvBody('✦ ~8MB texture buffer at 1080p per view'),
          _tvBody('✦ Works correctly in scroll views'),
          _tvBody('✦ Original Android platform view strategy'),
          _tvBody('✦ Use SurfaceAndroidViewController for video/camera/GL'),
          _tvBody('✦ Proper dispose() essential to prevent texture leaks'),
        ],
      ),
    ),
    _tvDivider(),
    Wrap(
      children: [
        _tvChip('TextureAndroidViewController', _tvPine),
        _tvChip('VirtualDisplay', _tvMedGreen),
        _tvChip('SurfaceTexture', _tvAccentBlue),
        _tvChip('TextureLayer', _tvAccentPurple),
        _tvChip('GPU Copy', _tvAccentOrange),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Custom painter
// ═══════════════════════════════════════════════════════════════
class _SimMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = _tvGray.withValues(alpha: 0.12)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Horizontal roads
    canvas.drawLine(
        Offset(0, size.height * 0.3),
        Offset(size.width, size.height * 0.35),
        roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.7),
        Offset(size.width, size.height * 0.65),
        roadPaint);

    // Vertical roads
    canvas.drawLine(
        Offset(size.width * 0.25, 0),
        Offset(size.width * 0.3, size.height),
        roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.7, 0),
        Offset(size.width * 0.65, size.height),
        roadPaint);

    // Park (green area)
    final parkPaint = Paint()
      ..color = _tvMedGreen.withValues(alpha: 0.1);
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.5),
        size.width * 0.15,
        parkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
