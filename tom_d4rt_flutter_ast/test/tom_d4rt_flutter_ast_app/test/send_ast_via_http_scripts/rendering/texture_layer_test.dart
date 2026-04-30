// ignore_for_file: avoid_print
// Deep demo: TextureLayer
// Demonstrates the TextureLayer compositing layer — the low-level node
// in the compositing tree that tells the engine to composite a platform
// texture into a specific rectangle of the scene.
import 'package:flutter/material.dart';

// ─── palette: Charcoal / Warm Gray ────────────────────────────────
const Color _tlCharcoal = Color(0xFF263238);
const Color _tlGray = Color(0xFFF5F5F5);
const Color _tlAccent = Color(0xFF455A64);
const Color _tlDark = Color(0xFF1A1A1A);
const Color _tlBlue = Color(0xFF1565C0);
const Color _tlGreen = Color(0xFF2E7D32);
const Color _tlOrange = Color(0xFFEF6C00);
const Color _tlPurple = Color(0xFF7B1FA2);
const Color _tlRed = Color(0xFFC62828);
const Color _tlTeal = Color(0xFF00695C);

// ─── text helpers ─────────────────────────────────────────────────
Widget _tlTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _tlCharcoal,
              letterSpacing: 0.3)),
    );

Widget _tlSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _tlAccent)),
    );

Widget _tlBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _tlCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tlDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFB0BEC5),
              height: 1.5)),
    );

Widget _tlNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tlGray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tlCharcoal.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _tlCharcoal),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _tlCharcoal, height: 1.4)),
          ),
        ],
      ),
    );

Widget _tlDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _tlCharcoal.withValues(alpha: 0.1)),
    );

Widget _tlBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _tlAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _tlTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _tlLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _tlCharcoal,
        letterSpacing: 0.2));

Widget _tlSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── compositing tree node visual ─────────────────────────────────
Widget _tlTreeNode(String name, Color c,
    {List<Widget> children = const [], bool highlighted = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: highlighted ? c : c.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: c.withValues(alpha: 0.5)),
          ),
          child: Text(name,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: highlighted ? Colors.white : c,
                  fontFamily: 'monospace')),
        ),
        ...children,
      ],
    ),
  );
}

/// A step in a pipeline.
Widget _tlStep(String num, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(num,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 12, color: Colors.black87)),
          ),
        ],
      ),
    );

/// A property card.
Widget _tlPropCard(String name, String type, String desc, Color c) =>
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: c,
                            fontFamily: 'monospace')),
                    const SizedBox(width: 8),
                    Text(type,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black45,
                            fontFamily: 'monospace')),
                  ],
                ),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _tlBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_tlCharcoal, Color(0xFF37474F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.layers_outlined, size: 48, color: _tlGray),
          const SizedBox(height: 10),
          const Text('TextureLayer',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('A compositing layer that displays a platform texture',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _tlTag('rendering', _tlAccent),
              _tlTag('compositing', _tlBlue),
              _tlTag('Layer', _tlPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _tlWhatIs() => [
      _tlTitle('§2  What Is TextureLayer?'),
      _tlBody(
          'TextureLayer is a compositing layer that tells the Flutter '
          'engine to composite a platform-provided texture into a '
          'specific rectangle of the scene. It is the layer-level '
          'counterpart to TextureBox — while TextureBox is the '
          'RenderBox, TextureLayer is the Layer node added to the '
          'compositing tree during painting.'),
      _tlCode(
          'class TextureLayer extends Layer {\n'
          '  TextureLayer({\n'
          '    required this.rect,\n'
          '    required this.textureId,\n'
          '    this.freeze = false,\n'
          '    this.filterQuality = FilterQuality.low,\n'
          '  });\n'
          '}'),
      _tlBody(
          'When the engine rasterizes the compositing tree, it encounters '
          'this layer and composites the native texture (identified by '
          'textureId) into the specified rect.'),
    ];

// ─── §3 Properties ───────────────────────────────────────────────
List<Widget> _tlProperties() => [
      _tlDivider(),
      _tlTitle('§3  The Four Properties'),
      _tlBody(
          'TextureLayer carries exactly the information the engine needs '
          'to place a native texture in the scene:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _tlPropCard('rect', 'Rect',
                'Screen rectangle where the texture is drawn', _tlBlue),
            _tlPropCard('textureId', 'int',
                'Engine-assigned ID of the native texture', _tlPurple),
            _tlPropCard('freeze', 'bool',
                'If true, show last frame instead of updating', _tlOrange),
            _tlPropCard('filterQuality', 'FilterQuality',
                'Scaling interpolation quality', _tlGreen),
          ],
        ),
      ),
      _tlSubtitle('rect'),
      _tlBody(
          'The rect property defines where in the scene the texture '
          'appears. It is specified in the coordinate space of the '
          'layer. The engine stretches or compresses the texture to '
          'fill this rectangle exactly.'),
      _tlCode(
          '// Place texture at (10, 20) with size 300x200\n'
          'TextureLayer(\n'
          '  rect: const Rect.fromLTWH(10, 20, 300, 200),\n'
          '  textureId: 42,\n'
          ')'),
      _tlSubtitle('textureId'),
      _tlBody(
          'An integer identifying which platform texture to display. '
          'The native side registers textures with the engine and '
          'returns this ID through platform channels.'),
      _tlSubtitle('freeze'),
      _tlBody(
          'When freeze is true, the engine uses the last rendered frame '
          'of the texture instead of pulling a new one. Useful during '
          'pauses, transitions, or when the texture producer is '
          'temporarily unavailable.'),
      _tlSubtitle('filterQuality'),
      _tlBody(
          'Controls how the texture is interpolated when scaled. '
          'Ranges from FilterQuality.none (fastest, pixelated) to '
          'FilterQuality.high (slowest, smoothest).'),
    ];

// ─── §4 How paint adds it ────────────────────────────────────────
List<Widget> _tlPaintFlow() => [
      _tlDivider(),
      _tlTitle('§4  How TextureLayer Gets Into The Scene'),
      _tlBody(
          'TextureLayer is created during the paint phase. The '
          'RenderObject (typically TextureBox) adds it to the '
          'PaintingContext as a compositing layer:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tlLabel('Paint → Layer → Scene flow'),
            const SizedBox(height: 10),
            _tlStep('1', 'TextureBox.paint() is called', _tlCharcoal),
            _tlStep('2', 'Creates TextureLayer with rect + textureId',
                _tlBlue),
            _tlStep('3', 'Calls context.addLayer(textureLayer)', _tlPurple),
            _tlStep(
                '4', 'Layer is attached to the compositing tree', _tlOrange),
            _tlStep(
                '5', 'Engine traverses tree and composites texture', _tlGreen),
          ],
        ),
      ),
      _tlCode(
          '// Inside TextureBox.paint():\n'
          '@override\n'
          'void paint(PaintingContext context, Offset offset) {\n'
          '  context.addLayer(TextureLayer(\n'
          '    rect: Rect.fromLTWH(\n'
          '        offset.dx, offset.dy,\n'
          '        size.width, size.height),\n'
          '    textureId: _textureId,\n'
          '    freeze: freeze,\n'
          '    filterQuality: filterQuality,\n'
          '  ));\n'
          '}'),
      _tlNote(
          'Because TextureLayer is a leaf layer (no children), it is '
          'added with addLayer() rather than pushLayer(). The engine '
          'handles compositing without any Dart-side canvas operations.'),
    ];

// ─── §5 Visual: layer in the compositing tree ────────────────────
List<Widget> _tlTreePosition() => [
      _tlDivider(),
      _tlTitle('§5  Position In The Compositing Tree'),
      _tlBody(
          'TextureLayer sits as a leaf node in the compositing tree. '
          'It has no children — it simply tells the engine "put texture '
          'X in rectangle Y":'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tlLabel('Compositing tree with TextureLayer'),
            const SizedBox(height: 8),
            _tlTreeNode('TransformLayer (root)', _tlCharcoal, children: [
              _tlTreeNode('OffsetLayer', _tlBlue, children: [
                _tlTreeNode('PictureLayer (Flutter UI)', _tlGreen),
                _tlTreeNode('TextureLayer (native video)', _tlOrange,
                    highlighted: true),
                _tlTreeNode('PictureLayer (overlays)', _tlGreen),
              ]),
            ]),
          ],
        ),
      ),
      _tlBody(
          'The TextureLayer can appear between PictureLayers. This is '
          'how Flutter interleaves native content with its own '
          'rendered widgets. The engine resolves z-ordering based on '
          'the order layers appear in the tree.'),
      _tlNote(
          'PictureLayer contains Dart-painted content (Canvas). '
          'TextureLayer contains engine-composited native content. '
          'They are siblings in the layer tree.'),
    ];

// ─── §6 Rect geometry ────────────────────────────────────────────
List<Widget> _tlRectGeometry() => [
      _tlDivider(),
      _tlTitle('§6  Rect Geometry'),
      _tlBody(
          'The rect property defines the destination rectangle for the '
          'texture. The native texture is stretched to fill this rect:'),
      Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(painter: _TlRectPainter()),
      ),
      _tlCode(
          '// Small rect — texture is compressed\n'
          'TextureLayer(\n'
          '  rect: const Rect.fromLTWH(10, 10, 80, 60),\n'
          '  textureId: 1,\n'
          ')\n'
          '\n'
          '// Large rect — texture is stretched\n'
          'TextureLayer(\n'
          '  rect: const Rect.fromLTWH(10, 10, 400, 300),\n'
          '  textureId: 1,\n'
          ')'),
      _tlBody(
          'The texture aspect ratio is not preserved automatically — '
          'the texture fills the entire rect. To maintain aspect ratio, '
          'the parent widget must calculate the correct rect dimensions.'),
      _tlBullet('Exactly sized', 'Rect matches native texture dimensions'),
      _tlBullet('Stretched', 'Rect is wider/taller than native resolution'),
      _tlBullet('Compressed', 'Rect is smaller than native resolution'),
    ];

class _TlRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Scene background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF5F5F5),
    );

    // Small rect
    final smallRect = Rect.fromLTWH(20, 30, 100, 70);
    canvas.drawRect(
        smallRect,
        Paint()
          ..color = const Color(0xFF1565C0)
          ..style = PaintingStyle.fill);
    canvas.drawRect(
        smallRect,
        Paint()
          ..color = const Color(0xFF0D47A1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    _drawText(canvas, 'rect: 100x70', Offset(smallRect.left + 8, smallRect.top + 26),
        const Color(0xFFFFFFFF));
    _drawText(canvas, 'Small', Offset(smallRect.left + 8, smallRect.top + 6),
        const Color(0xFFBBDEFB));

    // Large rect
    final largeRect = Rect.fromLTWH(150, 20, 180, 140);
    canvas.drawRect(
        largeRect,
        Paint()
          ..color = const Color(0xFFEF6C00)
          ..style = PaintingStyle.fill);
    canvas.drawRect(
        largeRect,
        Paint()
          ..color = const Color(0xFFE65100)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    _drawText(canvas, 'rect: 180x140',
        Offset(largeRect.left + 12, largeRect.top + 55),
        const Color(0xFFFFFFFF));
    _drawText(canvas, 'Large',
        Offset(largeRect.left + 12, largeRect.top + 10),
        const Color(0xFFFFE0B2));

    // Label
    _drawText(canvas, 'Same textureId, different rects',
        Offset(20, size.height - 18), const Color(0xFF455A64));
  }

  void _drawText(Canvas canvas, String text, Offset pos, Color color) {
    final tp = TextPainter(
      text: TextSpan(
          text: text,
          style: TextStyle(fontSize: 10, color: color)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── §7 Freeze vs. live ──────────────────────────────────────────
List<Widget> _tlFreezeVsLive() => [
      _tlDivider(),
      _tlTitle('§7  Freeze vs. Live'),
      _tlBody(
          'The freeze flag controls whether the engine fetches a new '
          'frame from the native texture or reuses the last one:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: _tlStateCard(
                  'freeze: false',
                  Icons.play_circle_outline,
                  'Engine pulls new frame\neach vsync',
                  _tlGreen),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _tlStateCard(
                  'freeze: true',
                  Icons.pause_circle_outline,
                  'Engine reuses the\nlast composited frame',
                  _tlOrange),
            ),
          ],
        ),
      ),
      _tlBody(
          'When creating the TextureLayer, the freeze flag is passed '
          'straight through from the TextureBox:'),
      _tlCode(
          '// Live texture (default)\n'
          'TextureLayer(\n'
          '  rect: rect,\n'
          '  textureId: 42,\n'
          '  freeze: false,\n'
          ')\n'
          '\n'
          '// Frozen texture (snapshot)\n'
          'TextureLayer(\n'
          '  rect: rect,\n'
          '  textureId: 42,\n'
          '  freeze: true,\n'
          ')'),
      _tlSubtitle('When to freeze'),
      _tlBullet('App backgrounded', 'Save GPU cycles while invisible'),
      _tlBullet('Video paused', 'Stop pulling frames from decoder'),
      _tlBullet('Scene transition', 'Avoid visual artifacts during animation'),
      _tlBullet('Screenshot', 'Capture stable frame before saving'),
    ];

Widget _tlStateCard(String title, IconData icon, String desc, Color c) =>
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: c),
          const SizedBox(height: 6),
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: c,
                  fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10.5, color: Colors.black54, height: 1.3)),
        ],
      ),
    );

// ─── §8 Filter quality visual ────────────────────────────────────
List<Widget> _tlFilterQuality() => [
      _tlDivider(),
      _tlTitle('§8  Filter Quality Comparison'),
      _tlBody(
          'FilterQuality affects how the texture looks when scaled. '
          'Higher quality uses more GPU resources but produces '
          'smoother images:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _tlQualCard('none', 'Nearest', _tlRed)),
                const SizedBox(width: 6),
                Expanded(child: _tlQualCard('low', 'Bilinear', _tlOrange)),
                const SizedBox(width: 6),
                Expanded(child: _tlQualCard('medium', 'Mipmap', _tlBlue)),
                const SizedBox(width: 6),
                Expanded(child: _tlQualCard('high', 'Bicubic', _tlGreen)),
              ],
            ),
            const SizedBox(height: 10),
            _tlQualBar('Speed', [5, 4, 2, 1], _tlGreen),
            const SizedBox(height: 4),
            _tlQualBar('Quality', [1, 2, 4, 5], _tlBlue),
            const SizedBox(height: 4),
            _tlQualBar('GPU cost', [1, 2, 3, 5], _tlRed),
          ],
        ),
      ),
      _tlCode(
          '// Each TextureLayer can have different quality:\n'
          'TextureLayer(\n'
          '  rect: thumbnailRect,\n'
          '  textureId: id,\n'
          '  filterQuality: FilterQuality.high,  // small, needs smooth\n'
          ')\n'
          '\n'
          'TextureLayer(\n'
          '  rect: fullScreenRect,\n'
          '  textureId: id,\n'
          '  filterQuality: FilterQuality.low,   // 1:1, low is fine\n'
          ')'),
    ];

Widget _tlQualCard(String name, String algo, Color c) => Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(name,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: c,
                  fontFamily: 'monospace')),
          const SizedBox(height: 2),
          Text(algo,
              style: const TextStyle(fontSize: 9, color: Colors.black45)),
        ],
      ),
    );

Widget _tlQualBar(String label, List<int> values, Color c) => Row(
      children: [
        SizedBox(
          width: 50,
          child: _tlSmall(label),
        ),
        ...values.expand((v) => [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => Container(
                      width: 8,
                      height: 6,
                      margin: const EdgeInsets.only(right: 1),
                      decoration: BoxDecoration(
                        color: i < v
                            ? c
                            : _tlCharcoal.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ],
    );

// ─── §9 Relationship to TextureBox ───────────────────────────────
List<Widget> _tlRelationship() => [
      _tlDivider(),
      _tlTitle('§9  Relationship To TextureBox'),
      _tlBody(
          'TextureBox and TextureLayer work in tandem. TextureBox is '
          'the RenderBox (part of the render tree), while TextureLayer '
          'is the Layer (part of the compositing tree):'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tlLabel('Widget → RenderBox → Layer mapping'),
            const SizedBox(height: 10),
            _tlMappingRow('Texture', 'TextureBox', 'TextureLayer',
                isHeader: true),
            const SizedBox(height: 4),
            _tlMappingRow('Widget tree', 'Render tree', 'Layer tree',
                isHeader: false),
          ],
        ),
      ),
      _tlCode(
          '// The chain:\n'
          '// Texture (widget)\n'
          '//   └── _TextureBox (element → render object)\n'
          '//         └── paint() adds TextureLayer to scene\n'
          '\n'
          '// Texture widget creates TextureBox:\n'
          '@override\n'
          'RenderBox createRenderObject(BuildContext context) {\n'
          '  return TextureBox(textureId: textureId);\n'
          '}\n'
          '\n'
          '// TextureBox creates TextureLayer:\n'
          '@override\n'
          'void paint(PaintingContext ctx, Offset off) {\n'
          '  ctx.addLayer(TextureLayer(\n'
          '    rect: off & size,\n'
          '    textureId: _textureId,\n'
          '  ));\n'
          '}'),
      _tlNote(
          'You never need to create TextureLayer manually — TextureBox '
          'handles it. Understanding TextureLayer is useful for '
          'debugging compositing issues and understanding how native '
          'content gets into the scene.'),
    ];

Widget _tlMappingRow(String w, String r, String l,
    {required bool isHeader}) {
  final style = TextStyle(
    fontSize: isHeader ? 12 : 10,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _tlCharcoal : Colors.black54,
    fontFamily: isHeader ? 'monospace' : null,
  );
  final colors = isHeader
      ? [_tlPurple, _tlBlue, _tlOrange]
      : [Colors.black54, Colors.black54, Colors.black54];
  return Row(
    children: [
      Expanded(
          child: Text(w, style: style.copyWith(color: colors[0]))),
      Expanded(
          child: Text(r, style: style.copyWith(color: colors[1]))),
      Expanded(
          child: Text(l, style: style.copyWith(color: colors[2]))),
    ],
  );
}

// ─── §10 Other layer types for comparison ────────────────────────
List<Widget> _tlComparison() => [
      _tlDivider(),
      _tlTitle('§10  TextureLayer Among Other Layer Types'),
      _tlBody(
          'TextureLayer is one of several Layer subclasses in the '
          'compositing system. Each handles a different kind of '
          'compositing operation:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tlGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tlCompRow('TextureLayer', 'Native texture compositing',
                'Leaf', _tlOrange),
            _tlCompRow('PictureLayer', 'Canvas-drawn Flutter content',
                'Leaf', _tlBlue),
            _tlCompRow('PlatformViewLayer', 'Platform view slot',
                'Leaf', _tlPurple),
            _tlCompRow('TransformLayer', 'Applies matrix transform',
                'Container', _tlGreen),
            _tlCompRow('OpacityLayer', 'Applies opacity to children',
                'Container', _tlTeal),
            _tlCompRow('ClipRectLayer', 'Clips children to rectangle',
                'Container', _tlRed),
          ],
        ),
      ),
      _tlBody(
          'TextureLayer is a leaf layer — it has no children. Container '
          'layers (like TransformLayer, OpacityLayer) can have children '
          'and apply effects to them.'),
      _tlSubtitle('Key distinction'),
      _tlBody(
          'PictureLayer draws content painted by Dart code (via Canvas). '
          'TextureLayer composites content produced by native code '
          '(via the engine texture registry). They are complementary '
          'paths for getting pixels on screen.'),
    ];

Widget _tlCompRow(String name, String desc, String kind, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: Text(name,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: c,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 10.5, color: Colors.black87)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(kind,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
        ],
      ),
    );

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _tlSummary() => [
      _tlDivider(),
      _tlTitle('§11  Summary'),
      _tlBody(
          'TextureLayer is the compositing-tree mechanism for embedding '
          'native textures into a Flutter scene. It is simple, focused, '
          'and essential for any plugin that renders native content.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _tlCharcoal.withValues(alpha: 0.07),
              _tlGray,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _tlCharcoal.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _tlCharcoal)),
            const SizedBox(height: 10),
            _tlSumPt('rect',
                'Destination rectangle for the texture in scene coordinates'),
            _tlSumPt('textureId',
                'Integer linking to the engine texture registry'),
            _tlSumPt('freeze', 'Pause updates — reuse last composited frame'),
            _tlSumPt('filterQuality',
                'Scaling interpolation: none/low/medium/high'),
            _tlSumPt('Leaf layer',
                'No children — just instructs engine to composite'),
            _tlSumPt('Created by TextureBox',
                'Added during paint() via context.addLayer()'),
            _tlSumPt('Complementary to PictureLayer',
                'Native texture vs. Dart canvas content'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _tlCharcoal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of TextureLayer Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _tlSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _tlGreen),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _tlCharcoal)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tlBanner(),
        const SizedBox(height: 20),
        ..._tlWhatIs(),
        ..._tlProperties(),
        ..._tlPaintFlow(),
        ..._tlTreePosition(),
        ..._tlRectGeometry(),
        ..._tlFreezeVsLive(),
        ..._tlFilterQuality(),
        ..._tlRelationship(),
        ..._tlComparison(),
        ..._tlSummary(),
      ],
    ),
  );
}
