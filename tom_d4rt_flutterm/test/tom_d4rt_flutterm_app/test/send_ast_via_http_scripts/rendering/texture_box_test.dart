// ignore_for_file: avoid_print
// Deep demo: TextureBox
// Demonstrates the TextureBox render object — a RenderBox that displays
// a platform texture identified by an integer ID. Used for video, camera,
// platform views, and other native content composited into Flutter.
import 'package:flutter/material.dart';

// ─── palette: Steel Blue / Ice ────────────────────────────────────
const Color _txSteel = Color(0xFF37474F);
const Color _txIce = Color(0xFFECEFF1);
const Color _txAccent = Color(0xFF546E7A);
const Color _txDark = Color(0xFF191919);
const Color _txGreen = Color(0xFF2E7D32);
const Color _txOrange = Color(0xFFEF6C00);
const Color _txBlue = Color(0xFF1565C0);
const Color _txPurple = Color(0xFF6A1B9A);
const Color _txRed = Color(0xFFC62828);

// ─── text helpers ─────────────────────────────────────────────────
Widget _txTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _txSteel,
              letterSpacing: 0.3)),
    );

Widget _txSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _txAccent)),
    );

Widget _txBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _txCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _txDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFB0BEC5),
              height: 1.5)),
    );

Widget _txNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _txIce,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _txSteel.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _txSteel),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _txSteel, height: 1.4)),
          ),
        ],
      ),
    );

Widget _txDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _txSteel.withValues(alpha: 0.12)),
    );

Widget _txBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _txAccent, shape: BoxShape.circle),
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

Widget _txTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _txLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _txSteel,
        letterSpacing: 0.2));

Widget _txSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── texture visual helpers ───────────────────────────────────────

/// A mock "texture frame" showing the concept of a native texture slot.
Widget _txFrame(String label, int textureId, Color borderColor,
    {double width = double.infinity, double height = 100}) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: _txDark.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: borderColor, width: 2),
    ),
    child: Stack(
      children: [
        // Scanlines effect
        ...List.generate(
          (height ~/ 8),
          (i) => Positioned(
            top: i * 8.0,
            left: 0,
            right: 0,
            child: Container(
                height: 1,
                color: borderColor.withValues(alpha: 0.06)),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.videocam_outlined, size: 28, color: borderColor),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: borderColor)),
              const SizedBox(height: 2),
              Text('textureId: $textureId',
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'monospace',
                      color: borderColor.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

/// A pipeline step indicator.
Widget _txPipe(String num, String desc, Color c) => Padding(
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

/// A property card showing a TextureBox property with value.
Widget _txPropCard(String name, String type, String desc, Color c) =>
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
Widget _txBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_txSteel, Color(0xFF455A64)],
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
          const Icon(Icons.tv_outlined, size: 48, color: _txIce),
          const SizedBox(height: 10),
          const Text('TextureBox',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('A RenderBox that displays a platform texture',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _txTag('rendering', _txAccent),
              _txTag('RenderBox', _txBlue),
              _txTag('platform texture', _txPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _txWhatIs() => [
      _txTitle('§2  What Is TextureBox?'),
      _txBody(
          'TextureBox is a RenderBox that composites a backend texture '
          'into the Flutter rendering pipeline. The texture is identified '
          'by an integer textureId registered with the engine. This is '
          'how Flutter displays native content like video players, camera '
          'previews, and platform views.'),
      _txCode(
          'class TextureBox extends RenderBox {\n'
          '  TextureBox({\n'
          '    required int textureId,\n'
          '    bool freeze = false,\n'
          '    FilterQuality filterQuality = FilterQuality.low,\n'
          '  });\n'
          '}'),
      _txBody(
          'Unlike most render objects that paint Dart-side graphics, '
          'TextureBox delegates painting to the engine, which composites '
          'the platform texture directly into the scene.'),
    ];

// ─── §3 Properties ───────────────────────────────────────────────
List<Widget> _txProperties() => [
      _txDivider(),
      _txTitle('§3  Properties'),
      _txBody(
          'TextureBox has three key properties that control what texture '
          'is displayed and how it appears:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _txPropCard('textureId', 'int',
                'Engine-assigned ID identifying the native texture', _txBlue),
            _txPropCard('freeze', 'bool',
                'When true, paints the last frame instead of updating', _txOrange),
            _txPropCard('filterQuality', 'FilterQuality',
                'Scaling quality: none, low, medium, high', _txPurple),
          ],
        ),
      ),
      _txCode(
          '// Create a TextureBox for texture #42\n'
          'final box = TextureBox(\n'
          '  textureId: 42,\n'
          '  freeze: false,          // keep updating\n'
          '  filterQuality: FilterQuality.low,\n'
          ');'),
    ];

// ─── §4 Texture ID ───────────────────────────────────────────────
List<Widget> _txTextureId() => [
      _txDivider(),
      _txTitle('§4  The Texture ID'),
      _txBody(
          'The textureId is an integer that the Flutter engine uses to '
          'find the platform texture in its registry. Platform channels '
          'or plugins create textures on the native side and return '
          'integer IDs to Dart code.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _txLabel('Texture ID lifecycle'),
            const SizedBox(height: 10),
            _txPipe('1', 'Native code creates a texture surface', _txSteel),
            _txPipe('2', 'Engine registers texture, assigns integer ID', _txBlue),
            _txPipe('3', 'ID sent to Dart via platform channel', _txPurple),
            _txPipe('4', 'Dart creates TextureBox with that ID', _txOrange),
            _txPipe('5', 'Engine composites native texture into scene', _txGreen),
          ],
        ),
      ),
      _txFrame('Camera Preview', 1, _txBlue),
      _txFrame('Video Player', 2, _txPurple),
      _txCode(
          '// Plugin creates texture on native side:\n'
          '// Android: textureEntry = textureRegistry.createSurfaceTexture()\n'
          '// iOS:     textureId = registry.register(pixelBuffer)\n'
          '\n'
          '// Dart receives the ID:\n'
          'final id = await methodChannel.invokeMethod<int>(\'create\');\n'
          '\n'
          '// Widget uses it:\n'
          'Texture(textureId: id)  // wraps TextureBox internally'),
      _txNote(
          'The Texture widget (in package:flutter/widgets.dart) is the '
          'widget-level wrapper around TextureBox. You rarely create '
          'TextureBox directly — use the Texture widget instead.'),
    ];

// ─── §5 Freeze behavior ─────────────────────────────────────────
List<Widget> _txFreeze() => [
      _txDivider(),
      _txTitle('§5  Freeze Behavior'),
      _txBody(
          'The freeze property tells TextureBox to stop updating and '
          'keep displaying the last rendered frame. This is useful '
          'when you want to show a snapshot of the texture without '
          'consuming resources for continuous updates.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _txFreezeCard(false, 'Live', 'Texture updates every '
                      'frame, reflecting native content changes'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _txFreezeCard(true, 'Frozen', 'Last frame is '
                      'displayed, no updates consumed'),
                ),
              ],
            ),
          ],
        ),
      ),
      _txCode(
          '// Start live\n'
          'box.freeze = false;  // animate, render new frames\n'
          '\n'
          '// Freeze to show snapshot\n'
          'box.freeze = true;   // stop updating, show last frame\n'
          '\n'
          '// Resume\n'
          'box.freeze = false;  // back to live updates'),
      _txSubtitle('Common freeze scenarios'),
      _txBullet('Paused video', 'Freeze while paused to save GPU cycles'),
      _txBullet('Screenshot mode', 'Freeze before capturing the current frame'),
      _txBullet('Background', 'Freeze when app goes to background'),
      _txBullet('Transition',
          'Freeze during page transition animations for stability'),
    ];

Widget _txFreezeCard(bool frozen, String title, String desc) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: frozen
            ? _txOrange.withValues(alpha: 0.08)
            : _txGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: frozen
                ? _txOrange.withValues(alpha: 0.3)
                : _txGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            frozen ? Icons.pause_circle_outline : Icons.play_circle_outline,
            size: 28,
            color: frozen ? _txOrange : _txGreen,
          ),
          const SizedBox(height: 6),
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: frozen ? _txOrange : _txGreen)),
          const SizedBox(height: 4),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10, color: Colors.black54)),
        ],
      ),
    );

// ─── §6 Filter quality ──────────────────────────────────────────
List<Widget> _txFilterQuality() => [
      _txDivider(),
      _txTitle('§6  Filter Quality'),
      _txBody(
          'The filterQuality property controls how the texture is '
          'scaled when the TextureBox size differs from the native '
          'texture resolution:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _txLabel('FilterQuality values'),
            const SizedBox(height: 10),
            _txQualRow('none', 'Nearest-neighbor', 'Fastest, pixelated',
                _txRed),
            _txQualRow('low', 'Bilinear', 'Default, good balance',
                _txOrange),
            _txQualRow('medium', 'Bilinear + mipmaps', 'Smoother minification',
                _txBlue),
            _txQualRow('high', 'Bicubic', 'Smoothest, most expensive',
                _txGreen),
          ],
        ),
      ),
      _txCode(
          '// For a video player — low is usually fine\n'
          'box.filterQuality = FilterQuality.low;\n'
          '\n'
          '// For a high-resolution camera preview\n'
          'box.filterQuality = FilterQuality.medium;\n'
          '\n'
          '// For a thumbnail (heavily downscaled)\n'
          'box.filterQuality = FilterQuality.high;'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _txLabel('Performance vs. quality trade-off'),
            const SizedBox(height: 8),
            _txTradeRow('none', 5, 1),
            _txTradeRow('low', 4, 2),
            _txTradeRow('medium', 2, 4),
            _txTradeRow('high', 1, 5),
          ],
        ),
      ),
    ];

Widget _txQualRow(String name, String algo, String note, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 58,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(name,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: c,
                      fontFamily: 'monospace')),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(algo,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                Text(note,
                    style: const TextStyle(
                        fontSize: 10, color: Colors.black45)),
              ],
            ),
          ),
        ],
      ),
    );

Widget _txTradeRow(String level, int perf, int qual) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            child: Text(level,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: _txSteel)),
          ),
          _txSmall('Perf: '),
          ...List.generate(
              5,
              (i) => Container(
                    width: 10,
                    height: 8,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: i < perf
                          ? _txGreen
                          : _txSteel.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )),
          const SizedBox(width: 12),
          _txSmall('Qual: '),
          ...List.generate(
              5,
              (i) => Container(
                    width: 10,
                    height: 8,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: i < qual
                          ? _txBlue
                          : _txSteel.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )),
        ],
      ),
    );

// ─── §7 Paint pipeline ──────────────────────────────────────────
List<Widget> _txPaintPipeline() => [
      _txDivider(),
      _txTitle('§7  How TextureBox Paints'),
      _txBody(
          'TextureBox does not paint pixels directly. Instead, it adds '
          'a texture layer to the compositing scene, which the engine '
          'resolves at rasterization time:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _txLabel('TextureBox.paint() flow'),
            const SizedBox(height: 10),
            _txPipe('1', 'paint() called with PaintingContext', _txSteel),
            _txPipe('2', 'context.addLayer(TextureLayer(...))', _txBlue),
            _txPipe('3', 'TextureLayer carries textureId + rect', _txPurple),
            _txPipe('4', 'Engine looks up texture by ID', _txOrange),
            _txPipe('5', 'Native texture composited at rect', _txGreen),
          ],
        ),
      ),
      _txCode(
          '@override\n'
          'void paint(PaintingContext context, Offset offset) {\n'
          '  if (_textureId == null) return;\n'
          '  context.addLayer(TextureLayer(\n'
          '    rect: Rect.fromLTWH(\n'
          '      offset.dx, offset.dy,\n'
          '      size.width, size.height,\n'
          '    ),\n'
          '    textureId: _textureId!,\n'
          '    freeze: freeze,\n'
          '    filterQuality: filterQuality,\n'
          '  ));\n'
          '}'),
      _txNote(
          'Because TextureBox uses a compositing layer (TextureLayer) '
          'rather than canvas draw calls, the texture content bypasses '
          'the Flutter canvas entirely. This is why video and camera '
          'content can render at full native performance.'),
    ];

// ─── §8 Sizing behavior ─────────────────────────────────────────
List<Widget> _txSizing() => [
      _txDivider(),
      _txTitle('§8  Sizing Behavior'),
      _txBody(
          'TextureBox does not have an intrinsic size — it takes '
          'whatever size its parent gives it. The parent is responsible '
          'for constraining the texture to the desired dimensions:'),
      _txCode(
          '// TextureBox sizing:\n'
          '@override\n'
          'bool get sizedByParent => true;\n'
          '\n'
          '@override\n'
          'Size computeDryLayout(BoxConstraints constraints) {\n'
          '  return constraints.biggest;\n'
          '}'),
      _txBody(
          'This means TextureBox always fills the maximum available '
          'space. To control the size, wrap the Texture widget:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _txLabel('Sizing patterns'),
            const SizedBox(height: 8),
            _txSizeRow('SizedBox', 'Fixed width/height', _txBlue),
            _txSizeRow('AspectRatio', 'Maintain W:H ratio (e.g. 16:9)', _txPurple),
            _txSizeRow('Expanded', 'Fill remaining space in Flex', _txGreen),
            _txSizeRow('FittedBox', 'Scale with fit option', _txOrange),
          ],
        ),
      ),
      _txCode(
          '// 16:9 video with fixed height\n'
          'SizedBox(\n'
          '  width: 320,\n'
          '  height: 180,\n'
          '  child: Texture(textureId: id),\n'
          ')\n'
          '\n'
          '// Aspect-ratio-preserved video\n'
          'AspectRatio(\n'
          '  aspectRatio: 16 / 9,\n'
          '  child: Texture(textureId: id),\n'
          ')'),
    ];

Widget _txSizeRow(String wid, String desc, Color c) => Padding(
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
            width: 90,
            child: Text(wid,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: c,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 11, color: Colors.black54)),
          ),
        ],
      ),
    );

// ─── §9 Common use cases ─────────────────────────────────────────
List<Widget> _txUseCases() => [
      _txDivider(),
      _txTitle('§9  Common Use Cases'),
      _txBody(
          'TextureBox (via the Texture widget) is used wherever native '
          'content needs to appear in the Flutter UI:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _txUseCase(Icons.videocam, 'Video Player',
                'Display decoded video frames from ExoPlayer / AVPlayer',
                _txBlue),
            _txUseCase(Icons.camera_alt, 'Camera Preview',
                'Live viewfinder from CameraX / AVCaptureSession',
                _txPurple),
            _txUseCase(Icons.map, 'Map View',
                'Native map rendering (Google Maps, Mapbox)',
                _txGreen),
            _txUseCase(Icons.web, 'WebView',
                'Web content rendered via native browser engine',
                _txOrange),
            _txUseCase(Icons.gamepad, 'Game Engine',
                'OpenGL/Vulkan/Metal rendered game content',
                _txRed),
            _txUseCase(Icons.brush, 'Custom Rendering',
                'Any native surface registered as a Flutter texture',
                _txSteel),
          ],
        ),
      ),
      _txNote(
          'Platform views (AndroidView, UiKitView) can use either texture '
          'composition or hybrid composition. TextureBox is the texture '
          'composition path — it is faster but has limitations with '
          'touch events and z-ordering.'),
    ];

Widget _txUseCase(IconData icon, String title, String desc, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: c),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §10 Texture vs. HybridComposition ──────────────────────────
List<Widget> _txVsHybrid() => [
      _txDivider(),
      _txTitle('§10  Texture vs. Hybrid Composition'),
      _txBody(
          'Flutter offers two ways to embed native content. TextureBox '
          'is the texture composition approach:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _txIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _txVsRow('Aspect', 'Texture (TextureBox)', 'Hybrid',
                isHeader: true),
            _txVsRow('Rendering', 'Offscreen, composited',
                'Native view in hierarchy'),
            _txVsRow('Performance', 'Faster compositing',
                'Slightly slower'),
            _txVsRow('Touch', 'Requires forwarding',
                'Native touch handling'),
            _txVsRow('Z-ordering', 'Limited (always behind Flutter)',
                'Full native z-order'),
            _txVsRow('Platform', 'Android + iOS + Web',
                'Android + iOS'),
            _txVsRow('Use case', 'Video, camera, games',
                'Maps, WebView, complex UI'),
          ],
        ),
      ),
      _txCode(
          '// Texture composition (uses TextureBox internally)\n'
          'Texture(textureId: id)\n'
          '\n'
          '// Hybrid composition (uses native view hierarchy)\n'
          'AndroidView(viewType: \'map-view\')\n'
          'UiKitView(viewType: \'map-view\')'),
    ];

Widget _txVsRow(String aspect, String tex, String hyb,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10.5,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _txSteel : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 72, child: Text(aspect, style: style)),
        Expanded(
          child: Text(tex,
              style: style.copyWith(
                  color: isHeader ? _txSteel : _txBlue)),
        ),
        Expanded(
          child: Text(hyb,
              style: style.copyWith(
                  color: isHeader ? _txSteel : _txOrange)),
        ),
      ],
    ),
  );
}

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _txSummary() => [
      _txDivider(),
      _txTitle('§11  Summary'),
      _txBody(
          'TextureBox is the rendering-layer component that bridges '
          'native platform textures into the Flutter compositing '
          'pipeline. It is simple — just an ID, a freeze flag, and '
          'a filter quality — but it enables some of the most '
          'demanding visual features in Flutter apps.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _txSteel.withValues(alpha: 0.08),
              _txIce,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _txSteel.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _txSteel)),
            const SizedBox(height: 10),
            _txSumPt('textureId', 'Integer ID linking to engine-registered '
                'native texture'),
            _txSumPt('freeze', 'Boolean to pause updates and show last frame'),
            _txSumPt('filterQuality', 'Controls scaling interpolation '
                '(none/low/medium/high)'),
            _txSumPt('TextureLayer', 'Paints via compositing layer, not '
                'canvas draw calls'),
            _txSumPt('sizedByParent', 'Always fills parent constraints — '
                'wrap with SizedBox/AspectRatio'),
            _txSumPt('Texture widget', 'Widget-level wrapper — preferred '
                'over using TextureBox directly'),
            _txSumPt('Use cases', 'Video, camera, maps, WebView, games, '
                'any native surface'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _txSteel,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of TextureBox Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _txSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _txGreen),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _txSteel)),
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
        _txBanner(),
        const SizedBox(height: 20),
        ..._txWhatIs(),
        ..._txProperties(),
        ..._txTextureId(),
        ..._txFreeze(),
        ..._txFilterQuality(),
        ..._txPaintPipeline(),
        ..._txSizing(),
        ..._txUseCases(),
        ..._txVsHybrid(),
        ..._txSummary(),
      ],
    ),
  );
}
