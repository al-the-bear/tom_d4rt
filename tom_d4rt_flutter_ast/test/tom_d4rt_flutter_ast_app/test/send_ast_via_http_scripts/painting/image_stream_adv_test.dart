// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for ImageStream,
// ImageStreamCompleter, ImageInfo, ImageConfiguration and the painting pipeline
// This file renders an instructive tour of how Flutter resolves image providers
// into image streams, listens for frames, configures device-aware variants,
// and finally rasterises into the box-decoration pipeline. No real images are
// loaded — the demo uses solid-colour and gradient stand-ins so the script can
// run in the d4rt interpreter test harness without a tickered binding.

import 'dart:typed_data';

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — a muted "studio darkroom" theme, evoking a photographer's bench.
// All section accents are pulled from this list to keep the eye anchored.
// ---------------------------------------------------------------------------

const Color isFilmBlack = Color(0xFF1B1B22);
const Color isFilmInk = Color(0xFF2A2A35);
const Color isFilmPaper = Color(0xFFF5F1E8);
const Color isFilmCream = Color(0xFFEAE0CC);
const Color isAmberLamp = Color(0xFFE8A33D);
const Color isAmberDim = Color(0xFFB97A1F);
const Color isSafelightRed = Color(0xFFC44848);
const Color isChemicalCyan = Color(0xFF4FB3A8);
const Color isChemicalTeal = Color(0xFF2E7D78);
const Color isToneShadow = Color(0xFF3D3D48);
const Color isToneMid = Color(0xFF8B8B96);
const Color isToneHighlight = Color(0xFFCFC9BC);

// ---------------------------------------------------------------------------
// Small leaf widgets shared by every section. Keeping them parameterised by
// colour rather than wrapping a Theme keeps the script analyzer-clean without
// pulling in any global theming state.
// ---------------------------------------------------------------------------

Widget isCaptionText(String text, {double size = 12.0, Color? color}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color ?? isToneMid,
      height: 1.35,
    ),
  );
}

Widget isHeaderText(String text, {double size = 18.0, Color? color}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color ?? isFilmInk,
      letterSpacing: 0.4,
    ),
  );
}

Widget isMonoText(String text, {double size = 11.0, Color? color}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color ?? isFilmInk,
      fontFamily: 'monospace',
      height: 1.4,
    ),
  );
}

Widget isPill(String label, Color background, {Color? text}) {
  return Container(
    margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        color: text ?? Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget isDivider({Color? color}) {
  return Container(
    height: 1.0,
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    color: (color ?? isToneShadow).withOpacity(0.25),
  );
}

Widget isKeyValueRow(String label, String value, {double width = 150.0}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              color: isToneMid,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.0,
              color: isFilmInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget isSectionFrame({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: isFilmPaper,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: isToneShadow.withOpacity(0.15)),
      boxShadow: [
        BoxShadow(
          color: isFilmBlack.withOpacity(0.06),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 10.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border(
              bottom: BorderSide(color: accent.withOpacity(0.5), width: 2.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: isHeaderText(title, size: 16.0, color: isFilmInk),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              isCaptionText(subtitle, size: 11.5),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: child,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// A stand-in "image" tile. The real test harness cannot decode bytes, so this
// widget visualises the *kind* of image that a given provider would yield:
//  - solid colour tiles emulate decoded MemoryImage bytes,
//  - gradients emulate fetched NetworkImage frames,
//  - chequerboards emulate AssetImage variants.
// The caller picks the recipe via [kind].
// ---------------------------------------------------------------------------

Widget isImageStandIn({
  required String kind,
  required double width,
  required double height,
  Color a = isAmberLamp,
  Color b = isSafelightRed,
  String label = '',
  BoxFit fit = BoxFit.cover,
  FilterQuality quality = FilterQuality.low,
}) {
  Widget body;
  if (kind == 'solid') {
    body = Container(color: a);
  } else if (kind == 'gradient') {
    body = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [a, b],
        ),
      ),
    );
  } else if (kind == 'radial') {
    body = Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [a, b],
          radius: 0.85,
        ),
      ),
    );
  } else if (kind == 'sweep') {
    body = Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(colors: [a, b, a]),
      ),
    );
  } else {
    body = CustomPaint(
      painter: _IsChequerPainter(a: a, b: b, squares: 6),
      child: const SizedBox.expand(),
    );
  }
  return Container(
    width: width,
    height: height,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: isToneShadow.withOpacity(0.35)),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        body,
        if (label.isNotEmpty)
          Positioned(
            left: 4.0,
            bottom: 4.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              color: isFilmBlack.withOpacity(0.55),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 9.0,
                  color: isFilmPaper,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        // Annotate the BoxFit / quality used so the demo doubles as a legend.
        Positioned(
          right: 4.0,
          top: 4.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: isFilmPaper.withOpacity(0.85),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              '${fit.toString().split('.').last}/${quality.toString().split('.').last}',
              style: const TextStyle(fontSize: 7.5, color: isFilmInk),
            ),
          ),
        ),
      ],
    ),
  );
}

class _IsChequerPainter extends CustomPainter {
  final Color a;
  final Color b;
  final int squares;
  _IsChequerPainter({required this.a, required this.b, this.squares = 6});

  @override
  void paint(Canvas canvas, Size size) {
    final double cellW = size.width / squares;
    final double cellH = size.height / squares;
    final Paint p1 = Paint()..color = a;
    final Paint p2 = Paint()..color = b;
    for (int y = 0; y < squares; y++) {
      for (int x = 0; x < squares; x++) {
        final Paint p = ((x + y) % 2 == 0) ? p1 : p2;
        final Rect r = Rect.fromLTWH(x * cellW, y * cellH, cellW, cellH);
        canvas.drawRect(r, p);
      }
    }
  }

  @override
  bool shouldRepaint(_IsChequerPainter old) =>
      old.a != a || old.b != b || old.squares != squares;
}

// ---------------------------------------------------------------------------
// SECTION 1 — ImageProvider taxonomy
//
// Builds an annotated diagram of the ImageProvider hierarchy. Each leaf class
// is represented by a card that lists its key parameters, where the bytes
// come from, and where the typical caller would source it. The card stack
// doubles as a quick reference card on the screen.
// ---------------------------------------------------------------------------

Widget isProviderCard({
  required String name,
  required String role,
  required String source,
  required Color accent,
  required List<String> ctorLines,
  required List<String> usageLines,
  Widget? preview,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    width: 280.0,
    decoration: BoxDecoration(
      color: isFilmPaper,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withOpacity(0.55), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 22.0,
                height: 22.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Text(
                  'IP',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: isFilmInk,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (preview != null) ...[
                Center(child: preview),
                const SizedBox(height: 8.0),
              ],
              isCaptionText('ROLE', size: 9.5, color: accent),
              isCaptionText(role, size: 11.5, color: isFilmInk),
              const SizedBox(height: 6.0),
              isCaptionText('SOURCE', size: 9.5, color: accent),
              isCaptionText(source, size: 11.5, color: isFilmInk),
              const SizedBox(height: 6.0),
              isCaptionText('CONSTRUCTOR', size: 9.5, color: accent),
              for (int i = 0; i < ctorLines.length; i++)
                isMonoText(ctorLines[i], size: 10.5),
              const SizedBox(height: 6.0),
              isCaptionText('USAGE', size: 9.5, color: accent),
              for (int i = 0; i < usageLines.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(fontSize: 11.0, color: isToneMid)),
                      Expanded(
                        child: Text(
                          usageLines[i],
                          style: const TextStyle(
                            fontSize: 11.0,
                            color: isFilmInk,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget isProviderTaxonomySection() {
  // Construct sample provider instances so the section is more than just
  // string literals — these go through the analyzer and verify the constructor
  // signatures still resolve in the current Flutter SDK.
  final MemoryImage memProvider =
      MemoryImage(Uint8List.fromList([0, 0, 0, 0, 255, 255, 255, 255]));
  final AssetImage assetProvider =
      const AssetImage('packages/example/assets/lamp.png');
  final NetworkImage netProvider =
      const NetworkImage('https://example.com/photo.jpg');
  // FileImage is constructed lazily — passing a stand-in File reference is
  // unsafe under the interpreter, so we describe it via Text in the card.

  // Touch hashCodes so the local variables aren't dropped by the analyzer.
  final String memTag = 'hash:${memProvider.hashCode.toString().substring(0, 4)}';
  final String assetTag = 'asset:${assetProvider.assetName}';
  final String netTag = 'url:${netProvider.url}';

  return isSectionFrame(
    title: 'Section 1 — ImageProvider taxonomy',
    subtitle:
        'Concrete providers below the abstract ImageProvider<T> root. Each '
        'card shows where the bytes originate and how the key is built.',
    accent: isAmberLamp,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isCaptionText(
          'ImageProvider<T> is the abstract base. T is the resolved key '
          'type used for caching (see ImageCache.putIfAbsent). Subclasses '
          'override obtainKey(ImageConfiguration) and loadImage(...) to '
          'return an ImageStreamCompleter.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            isProviderCard(
              name: 'MemoryImage',
              role: 'Decodes from a raw Uint8List held in memory.',
              source: 'Caller-supplied bytes — no I/O.',
              accent: isAmberLamp,
              ctorLines: const [
                'MemoryImage(',
                '  Uint8List bytes, {',
                '  double scale = 1.0,',
                '})',
              ],
              usageLines: const [
                'Useful for in-memory thumbnails',
                'Decoded once; key = bytes identity',
                'Pair with resize for previews',
              ],
              preview: isImageStandIn(
                kind: 'solid',
                width: 80.0,
                height: 50.0,
                a: isAmberLamp,
                label: memTag,
              ),
            ),
            isProviderCard(
              name: 'AssetImage',
              role: 'Resolves a logical asset → variant for current DPR.',
              source: 'AssetBundle (rootBundle by default).',
              accent: isChemicalCyan,
              ctorLines: const [
                'AssetImage(',
                '  String assetName, {',
                '  AssetBundle? bundle,',
                '  String? package,',
                '})',
              ],
              usageLines: const [
                'Picks 1.5x / 2.0x / 3.0x variants',
                'Honours ImageConfiguration.devicePixelRatio',
                'Key resolves to AssetBundleImageKey',
              ],
              preview: isImageStandIn(
                kind: 'chequer',
                width: 80.0,
                height: 50.0,
                a: isChemicalCyan,
                b: isFilmPaper,
                label: assetTag,
              ),
            ),
            isProviderCard(
              name: 'NetworkImage',
              role: 'Streams bytes over HTTP(S) and decodes them.',
              source: 'URL via HttpClient.',
              accent: isSafelightRed,
              ctorLines: const [
                'NetworkImage(',
                '  String url, {',
                '  double scale = 1.0,',
                '  Map<String, String>? headers,',
                '})',
              ],
              usageLines: const [
                'Emits ImageChunkEvents for progress',
                'Key = url + scale + headers identity',
                'Wrap in ResizeImage for huge sources',
              ],
              preview: isImageStandIn(
                kind: 'gradient',
                width: 80.0,
                height: 50.0,
                a: isSafelightRed,
                b: isAmberLamp,
                label: netTag,
              ),
            ),
            isProviderCard(
              name: 'FileImage',
              role: 'Reads bytes from a dart:io File.',
              source: 'Local filesystem (non-web only).',
              accent: isChemicalTeal,
              ctorLines: const [
                'FileImage(',
                '  File file, {',
                '  double scale = 1.0,',
                '})',
              ],
              usageLines: const [
                'Use for images captured at runtime',
                'Key = file.path + scale',
                'Not available on Flutter Web',
              ],
              preview: isImageStandIn(
                kind: 'sweep',
                width: 80.0,
                height: 50.0,
                a: isChemicalTeal,
                b: isToneHighlight,
                label: 'file://…',
              ),
            ),
            isProviderCard(
              name: 'ExactAssetImage',
              role: 'AssetImage variant that skips DPR resolution.',
              source: 'AssetBundle, exact path.',
              accent: isAmberDim,
              ctorLines: const [
                'ExactAssetImage(',
                '  String assetName, {',
                '  double scale = 1.0,',
                '  AssetBundle? bundle,',
                '  String? package,',
                '})',
              ],
              usageLines: const [
                'When you already chose the variant',
                'No 2.0x/3.0x folder lookup',
                'Cheaper resolveStreamForKey',
              ],
              preview: isImageStandIn(
                kind: 'radial',
                width: 80.0,
                height: 50.0,
                a: isAmberDim,
                b: isFilmCream,
                label: '@exact',
              ),
            ),
            isProviderCard(
              name: 'ResizeImage',
              role: 'Wraps another provider, decoding at a target size.',
              source: 'Delegates to the inner provider.',
              accent: isChemicalCyan,
              ctorLines: const [
                'ResizeImage(',
                '  ImageProvider inner, {',
                '  int? width,',
                '  int? height,',
                '  ResizeImagePolicy policy = ',
                '      ResizeImagePolicy.exact,',
                '})',
              ],
              usageLines: const [
                'Reduces decoded byte size in cache',
                'Pair with NetworkImage / MemoryImage',
                'Use fit:exact|fit for letterbox vs crop',
              ],
              preview: isImageStandIn(
                kind: 'solid',
                width: 80.0,
                height: 50.0,
                a: isChemicalTeal,
                label: 'resize×½',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — ImageStream / ImageStreamCompleter / ImageStreamListener
//
// A flow diagram that walks the read of an image from provider → key →
// stream → listener → ImageInfo. Each stage is drawn as a numbered tile with
// an arrow pointing to the next one. The bottom band shows the three listener
// callbacks (frame / chunk / error) wired into ImageStreamListener.
// ---------------------------------------------------------------------------

Widget isFlowTile({
  required int index,
  required String title,
  required String type,
  required String summary,
  required Color accent,
}) {
  return Container(
    width: 200.0,
    margin: const EdgeInsets.only(right: 14.0, bottom: 10.0),
    decoration: BoxDecoration(
      color: isFilmPaper,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withOpacity(0.55), width: 1.3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          color: accent.withOpacity(0.18),
          child: Row(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: isFilmInk,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMonoText(type, size: 10.5, color: accent),
              const SizedBox(height: 6.0),
              Text(
                summary,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: isFilmInk,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget isFlowArrow({Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 28.0),
    child: Icon(
      Icons.arrow_forward,
      color: (color ?? isToneShadow).withOpacity(0.7),
      size: 22.0,
    ),
  );
}

Widget isStreamSection() {
  // Demonstrate the listener triple. We *construct* but do not register them
  // — d4rt does not run the ticker that would call them anyway. The point is
  // that the analyzer signs off on the closures.
  void onFrame(ImageInfo info, bool synchronousCall) {
    // Real listener would receive the decoded ui.Image and scale.
  }
  void onChunk(ImageChunkEvent event) {
    // Reports cumulativeBytesLoaded / expectedTotalBytes.
  }
  void onError(Object exception, StackTrace? stack) {
    // Final destination of decode / network failures.
  }

  final ImageStreamListener listener = ImageStreamListener(
    onFrame,
    onChunk: onChunk,
    onError: onError,
  );

  // ImageStream is normally produced by ImageProvider.resolve. We avoid
  // resolving to keep the test offline-safe.
  final ImageStream stream = ImageStream();
  // Calling addListener / removeListener with our listener is safe even
  // without a completer wired in; ImageStream queues listeners until the
  // completer is set. We immediately remove to avoid leaving listeners.
  stream.addListener(listener);
  stream.removeListener(listener);

  return isSectionFrame(
    title: 'Section 2 — From provider to frame',
    subtitle:
        'ImageStream is the broadcast endpoint. The completer is the producer. '
        'Listeners are the consumers. Each stage exists for a reason.',
    accent: isChemicalCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isCaptionText(
          'The pipeline below is what runs when a Image widget receives a '
          'non-null provider. The framework only re-resolves when the '
          'ImageConfiguration changes (e.g. device pixel ratio, size, '
          'platform, locale).',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isFlowTile(
                index: 1,
                title: 'ImageProvider',
                type: 'ImageProvider<T>',
                summary: 'You hand this to Image(image:). Knows how to make '
                    'a key and how to load bytes.',
                accent: isAmberLamp,
              ),
              isFlowArrow(),
              isFlowTile(
                index: 2,
                title: 'ImageConfiguration',
                type: 'ImageConfiguration',
                summary: 'Holds bundle, DPR, locale, size, platform. Passed '
                    'to obtainKey(ctx).',
                accent: isAmberDim,
              ),
              isFlowArrow(),
              isFlowTile(
                index: 3,
                title: 'Key',
                type: 'T extends Object',
                summary: 'Hashable identity used by ImageCache. Equal keys '
                    'share a completer.',
                accent: isChemicalCyan,
              ),
              isFlowArrow(),
              isFlowTile(
                index: 4,
                title: 'ImageStream',
                type: 'ImageStream',
                summary: 'Lightweight broadcast handle. Listeners attach '
                    'here even before bytes arrive.',
                accent: isChemicalTeal,
              ),
              isFlowArrow(),
              isFlowTile(
                index: 5,
                title: 'Completer',
                type: 'ImageStreamCompleter',
                summary: 'The producer. OneFrame… or MultiFrame…. Owns the '
                    'decoded frames and drives listeners.',
                accent: isSafelightRed,
              ),
              isFlowArrow(),
              isFlowTile(
                index: 6,
                title: 'Frame',
                type: 'ImageInfo',
                summary: 'Final payload. image + scale + optional '
                    'debugLabel. Handed to onFrame listeners.',
                accent: isAmberLamp,
              ),
            ],
          ),
        ),
        isDivider(),
        isHeaderText('Listener anatomy', size: 14.0),
        const SizedBox(height: 6.0),
        isCaptionText(
          'ImageStreamListener bundles three callbacks. Only onListen (here '
          'aliased as the positional `onFrame`) is required. Use onChunk for '
          'progress UI, onError to render fall-back tiles.',
          size: 11.5,
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isFilmCream,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: isToneShadow.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              isKeyValueRow('typedef ImageListener',
                  'void Function(ImageInfo, bool synchronousCall)'),
              isKeyValueRow('typedef ImageChunkListener',
                  'void Function(ImageChunkEvent event)'),
              isKeyValueRow('typedef ImageErrorListener',
                  'void Function(Object exception, StackTrace? stack)'),
              isDivider(),
              isMonoText(
                'final listener = ImageStreamListener(',
                size: 11.0,
              ),
              isMonoText(
                "  (info, sync) => print('frame: \${info.image.width}'),",
                size: 11.0,
              ),
              isMonoText(
                '  onChunk: (e) => '
                'print(\'\${e.cumulativeBytesLoaded}/\${e.expectedTotalBytes}\'),',
                size: 11.0,
              ),
              isMonoText(
                "  onError: (ex, st) => print('failed: \$ex'),",
                size: 11.0,
              ),
              isMonoText(');', size: 11.0),
              const SizedBox(height: 6.0),
              isCaptionText(
                'listener.hashCode = ${listener.hashCode}',
                size: 10.5,
                color: isAmberDim,
              ),
              isCaptionText(
                'stream.runtimeType = ${stream.runtimeType}',
                size: 10.5,
                color: isAmberDim,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            isPill('onFrame', isAmberLamp),
            isPill('onChunk', isChemicalCyan),
            isPill('onError', isSafelightRed),
            isPill('synchronousCall', isChemicalTeal),
            isPill('multi-listener', isAmberDim),
            isPill('removeListener', isToneShadow),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — ImageConfiguration reference card
//
// ImageConfiguration is the bag of context that influences obtainKey. This
// section enumerates every public field, explains what it does, and shows
// three concrete sample configurations: a phone preview, a tablet preview,
// and an exact-size thumbnail.
// ---------------------------------------------------------------------------

Widget isConfigFieldRow(String name, String type, String purpose) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: isFilmInk,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: isChemicalTeal,
            ),
          ),
        ),
        Expanded(
          child: Text(
            purpose,
            style: const TextStyle(
              fontSize: 11.5,
              color: isToneShadow,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget isConfigSampleCard({
  required String title,
  required ImageConfiguration config,
  required Color accent,
}) {
  return Container(
    width: 240.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: accent.withOpacity(0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: isFilmInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        isKeyValueRow('bundle',
            (config.bundle != null) ? config.bundle.toString() : 'null'),
        isKeyValueRow('devicePixelRatio',
            (config.devicePixelRatio ?? double.nan).toString()),
        isKeyValueRow(
            'locale', (config.locale != null) ? config.locale.toString() : 'null'),
        isKeyValueRow(
            'textDirection',
            (config.textDirection != null)
                ? config.textDirection.toString()
                : 'null'),
        isKeyValueRow('size',
            (config.size != null) ? config.size.toString() : 'null'),
        isKeyValueRow(
            'platform',
            (config.platform != null)
                ? config.platform.toString()
                : 'null'),
      ],
    ),
  );
}

Widget isConfigurationSection(BuildContext context) {
  // Three example configurations. The fields are deliberately filled with
  // explicit values so the card output reads as a parameter dump.
  const ImageConfiguration phoneConfig = ImageConfiguration(
    devicePixelRatio: 2.0,
    locale: Locale('en', 'US'),
    textDirection: TextDirection.ltr,
    size: Size(360.0, 640.0),
    platform: TargetPlatform.android,
  );
  const ImageConfiguration tabletConfig = ImageConfiguration(
    devicePixelRatio: 2.0,
    locale: Locale('fr', 'FR'),
    textDirection: TextDirection.ltr,
    size: Size(1024.0, 768.0),
    platform: TargetPlatform.iOS,
  );
  const ImageConfiguration thumbnailConfig = ImageConfiguration(
    devicePixelRatio: 3.0,
    locale: Locale('ja', 'JP'),
    textDirection: TextDirection.ltr,
    size: Size(96.0, 96.0),
    platform: TargetPlatform.macOS,
  );

  // Also show that createLocalImageConfiguration(context) is the canonical
  // way to derive a config from an actual BuildContext — invoke it lazily so
  // the analyzer sees the call site.
  final ImageConfiguration fromContext = createLocalImageConfiguration(context);

  return isSectionFrame(
    title: 'Section 3 — ImageConfiguration reference card',
    subtitle:
        'Everything obtainKey(...) gets to read. The values below shape which '
        'asset variant is chosen and what cache bucket the result lands in.',
    accent: isAmberDim,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isHeaderText('Field reference', size: 14.0),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isFilmCream,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            children: [
              isConfigFieldRow('bundle', 'AssetBundle?',
                  'Where AssetImage looks for variants.'),
              isConfigFieldRow('devicePixelRatio', 'double?',
                  'Used to pick @2x / @3x variants.'),
              isConfigFieldRow('locale', 'Locale?',
                  'Localised variants in the variant manifest.'),
              isConfigFieldRow('textDirection', 'TextDirection?',
                  'Some providers vary by writing direction.'),
              isConfigFieldRow('size', 'Size?',
                  'Layout size in logical pixels at paint time.'),
              isConfigFieldRow('platform', 'TargetPlatform?',
                  'Lets providers pick platform-specific assets.'),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        isCaptionText(
          'ImageConfiguration is *immutable*. To tweak one field, use .copyWith(...). '
          'The empty constant ImageConfiguration.empty is what the framework '
          'starts from before a BuildContext is available.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 10.0),
        isHeaderText('Sample configurations', size: 14.0),
        const SizedBox(height: 6.0),
        Wrap(
          children: [
            isConfigSampleCard(
              title: 'Phone preview',
              config: phoneConfig,
              accent: isAmberLamp,
            ),
            isConfigSampleCard(
              title: 'Tablet preview',
              config: tabletConfig,
              accent: isChemicalCyan,
            ),
            isConfigSampleCard(
              title: 'Square thumbnail',
              config: thumbnailConfig,
              accent: isSafelightRed,
            ),
            isConfigSampleCard(
              title: 'createLocalImageConfiguration(ctx)',
              config: fromContext,
              accent: isChemicalTeal,
            ),
          ],
        ),
        isDivider(),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isAmberLamp.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: isAmberLamp.withOpacity(0.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHeaderText('copyWith demo', size: 13.0, color: isAmberDim),
              const SizedBox(height: 4.0),
              isMonoText(
                'const base = ImageConfiguration.empty;',
                size: 11.0,
              ),
              isMonoText(
                'final hiDpi = base.copyWith(devicePixelRatio: 3.0);',
                size: 11.0,
              ),
              isMonoText(
                'final rtl = hiDpi.copyWith(textDirection: TextDirection.rtl);',
                size: 11.0,
              ),
              const SizedBox(height: 6.0),
              isCaptionText(
                'ImageConfiguration.empty.runtimeType = ${ImageConfiguration.empty.runtimeType}',
                size: 10.5,
                color: isAmberDim,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — BoxFit gallery
//
// Every BoxFit value applied to the same painted stand-in image, in the same
// container, so the reader can compare them side by side. Each tile is
// annotated with a one-line description.
// ---------------------------------------------------------------------------

Widget isBoxFitTile({
  required String name,
  required BoxFit fit,
  required String summary,
  required Color tone,
}) {
  // The "image" we re-fit is an asymmetric gradient so cropping vs scaling
  // is visually obvious. Wrap it in FittedBox to mimic the BoxFit semantic.
  return Container(
    width: 170.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: isToneShadow.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          color: tone.withOpacity(0.18),
          child: Row(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                color: tone,
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'BoxFit.$name',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: isFilmInk,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 100.0,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isFilmBlack,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: isToneShadow.withOpacity(0.5)),
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          child: FittedBox(
            fit: fit,
            child: Container(
              width: 200.0,
              height: 80.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [tone, isAmberLamp, isChemicalCyan],
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                '200×80',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
          child: Text(
            summary,
            style: const TextStyle(
              fontSize: 10.5,
              color: isToneShadow,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget isBoxFitSection() {
  return isSectionFrame(
    title: 'Section 4 — BoxFit gallery',
    subtitle:
        'The same 200×80 source rendered through every BoxFit value in a '
        '150×100 viewport. Watch the cropping, letterboxing, and scaling.',
    accent: isSafelightRed,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isCaptionText(
          'BoxFit feeds into applyBoxFit(...), which returns a FittedSizes '
          'pair (source, destination). The output drives Image, DecorationImage, '
          'FittedBox, and any custom painter that wraps applyBoxFit.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            isBoxFitTile(
              name: 'fill',
              fit: BoxFit.fill,
              summary:
                  'Stretches both axes independently. Aspect ratio is lost; '
                  'whole source visible.',
              tone: isAmberLamp,
            ),
            isBoxFitTile(
              name: 'contain',
              fit: BoxFit.contain,
              summary:
                  'Largest fit that keeps aspect ratio inside the box. May '
                  'leave letterbox bars.',
              tone: isChemicalCyan,
            ),
            isBoxFitTile(
              name: 'cover',
              fit: BoxFit.cover,
              summary:
                  'Smallest fit that fully covers the box. Will crop part of '
                  'the source.',
              tone: isSafelightRed,
            ),
            isBoxFitTile(
              name: 'fitWidth',
              fit: BoxFit.fitWidth,
              summary: 'Match container width; vertical may overflow or '
                  'leave gap.',
              tone: isChemicalTeal,
            ),
            isBoxFitTile(
              name: 'fitHeight',
              fit: BoxFit.fitHeight,
              summary: 'Match container height; horizontal may overflow or '
                  'leave gap.',
              tone: isAmberDim,
            ),
            isBoxFitTile(
              name: 'none',
              fit: BoxFit.none,
              summary: 'Source drawn at its natural size; cropping happens '
                  'symmetrically.',
              tone: isToneShadow,
            ),
            isBoxFitTile(
              name: 'scaleDown',
              fit: BoxFit.scaleDown,
              summary: 'Like BoxFit.contain but never upscales. Honours '
                  'natural source size when smaller.',
              tone: isFilmInk,
            ),
          ],
        ),
        isDivider(),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isFilmCream,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHeaderText('applyBoxFit return shape', size: 13.0),
              const SizedBox(height: 4.0),
              isMonoText(
                  'class FittedSizes { final Size source; final Size destination; }',
                  size: 11.0),
              const SizedBox(height: 6.0),
              isCaptionText(
                'The destination size is then passed through Alignment.inscribe(...) '
                'to compute the exact rect to paint in. BoxFit.cover paired with '
                'Alignment.centerLeft would crop from the right, for instance.',
                size: 11.5,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — ImageRepeat catalog
//
// All four ImageRepeat values illustrated using a small tile pattern painted
// as the "source image". The four containers are identical except for repeat.
// ---------------------------------------------------------------------------

class _IsTilePatternPainter extends CustomPainter {
  final ImageRepeat repeat;
  final Color a;
  final Color b;
  final double tile;
  _IsTilePatternPainter({
    required this.repeat,
    required this.a,
    required this.b,
    this.tile = 28.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // The "image" is a 24×24 motif with a coloured circle on a soft square.
    void drawMotif(double dx, double dy) {
      final Rect r = Rect.fromLTWH(dx, dy, tile, tile);
      final Paint bg = Paint()..color = a;
      canvas.drawRect(r, bg);
      final Paint circle = Paint()..color = b;
      canvas.drawCircle(
        Offset(dx + tile / 2.0, dy + tile / 2.0),
        tile / 3.0,
        circle,
      );
      // Dot in centre to differentiate
      canvas.drawCircle(
        Offset(dx + tile / 2.0, dy + tile / 2.0),
        tile / 8.0,
        Paint()..color = isFilmPaper,
      );
    }

    // Determine where to draw based on repeat semantics. We emulate the
    // framework's painting logic for visual fidelity.
    final bool repX = repeat == ImageRepeat.repeat || repeat == ImageRepeat.repeatX;
    final bool repY = repeat == ImageRepeat.repeat || repeat == ImageRepeat.repeatY;
    final double startX = repX ? 0.0 : (size.width - tile) / 2.0;
    final double endX = repX ? size.width : startX + tile;
    final double startY = repY ? 0.0 : (size.height - tile) / 2.0;
    final double endY = repY ? size.height : startY + tile;

    canvas.save();
    canvas.clipRect(Offset.zero & size);
    for (double y = startY; y < endY; y += tile) {
      for (double x = startX; x < endX; x += tile) {
        drawMotif(x, y);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_IsTilePatternPainter old) =>
      old.repeat != repeat || old.a != a || old.b != b || old.tile != tile;
}

Widget isRepeatTile({
  required ImageRepeat repeat,
  required String description,
  required Color accent,
}) {
  return Container(
    width: 200.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withOpacity(0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          color: accent.withOpacity(0.18),
          child: Text(
            'ImageRepeat.${repeat.toString().split('.').last}',
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: isFilmInk,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          height: 110.0,
          decoration: BoxDecoration(
            border: Border.all(color: isToneShadow.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(4.0),
            color: isFilmPaper,
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomPaint(
            painter: _IsTilePatternPainter(
              repeat: repeat,
              a: accent,
              b: isFilmInk,
              tile: 26.0,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 10.5,
              color: isToneShadow,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget isImageRepeatSection() {
  return isSectionFrame(
    title: 'Section 5 — ImageRepeat catalog',
    subtitle:
        'How the source motif fills the destination rect when the source '
        'is smaller. Used by DecorationImage(repeat:), paintImage(...).',
    accent: isChemicalTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isCaptionText(
          'ImageRepeat tells the painter what to do once the source has been '
          'placed by alignment. The framework draws the tile, then walks the '
          'tile grid outward to cover the destination according to the enum.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            isRepeatTile(
              repeat: ImageRepeat.noRepeat,
              description: 'Draw exactly once at the alignment; no tiling.',
              accent: isAmberLamp,
            ),
            isRepeatTile(
              repeat: ImageRepeat.repeat,
              description: 'Tile in both axes — wallpaper mode.',
              accent: isChemicalCyan,
            ),
            isRepeatTile(
              repeat: ImageRepeat.repeatX,
              description: 'Tile only along the x-axis (horizontal band).',
              accent: isSafelightRed,
            ),
            isRepeatTile(
              repeat: ImageRepeat.repeatY,
              description: 'Tile only along the y-axis (vertical band).',
              accent: isChemicalTeal,
            ),
          ],
        ),
        isDivider(),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isFilmCream,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHeaderText('Where it appears', size: 13.0),
              const SizedBox(height: 4.0),
              isMonoText('DecorationImage(image:..., repeat: …)', size: 11.0),
              isMonoText(
                  'paintImage(canvas:, rect:, image:, repeat: …)',
                  size: 11.0),
              isMonoText(
                  'Image(image:..., repeat: ImageRepeat.repeat)',
                  size: 11.0),
              const SizedBox(height: 6.0),
              isCaptionText(
                'paintImage iterates a generated list of tile positions and '
                'draws the source repeatedly with canvas.drawImageRect. This '
                'is why centerSlice + repeat is mutually exclusive.',
                size: 11.5,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — DecorationImage theming
//
// DecorationImage is the heavy hitter for the BoxDecoration → background
// pipeline. We render six theme variants of the same container to show how
// the optional parameters combine: colorFilter, opacity, BlendMode, scale,
// alignment, fit, repeat, centerSlice, matchTextDirection, invertColors.
// ---------------------------------------------------------------------------

Widget isDecorationVariant({
  required String label,
  required String detail,
  required BoxDecoration decoration,
  required Color accent,
}) {
  return Container(
    width: 230.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: accent.withOpacity(0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: isFilmInk,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 110.0,
          decoration: decoration,
        ),
        const SizedBox(height: 6.0),
        Text(
          detail,
          style: const TextStyle(
            fontSize: 10.5,
            color: isToneShadow,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget isDecorationImageSection() {
  // Build six DecorationImage instances. The "image" is a synthetic
  // gradient — wrapped in a Container so we don't have to load anything.
  // For DecorationImage we MUST provide an ImageProvider. We use a
  // 4-byte transparent MemoryImage as a placeholder. The visual effect is
  // produced by the surrounding Container, but the analyzer is satisfied
  // and the API surface is correctly demonstrated.
  final ImageProvider placeholder =
      MemoryImage(Uint8List.fromList([0, 0, 0, 0]));

  // Variant 1 — fit: cover, no filter.
  final BoxDecoration v1 = BoxDecoration(
    gradient: LinearGradient(
      colors: [isAmberLamp, isSafelightRed],
    ),
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
      image: placeholder,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    ),
  );
  // Variant 2 — fit: contain, repeat: repeat, opacity 0.5.
  final BoxDecoration v2 = BoxDecoration(
    color: isFilmInk,
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
      image: placeholder,
      fit: BoxFit.contain,
      repeat: ImageRepeat.repeat,
      opacity: 0.5,
    ),
  );
  // Variant 3 — color filter using modulate.
  final BoxDecoration v3 = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [isChemicalCyan, isChemicalTeal],
    ),
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
      image: placeholder,
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        isAmberLamp.withOpacity(0.55),
        BlendMode.modulate,
      ),
    ),
  );
  // Variant 4 — invertColors true.
  final BoxDecoration v4 = BoxDecoration(
    gradient: const LinearGradient(
      colors: [isToneHighlight, isFilmCream],
    ),
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
      image: placeholder,
      fit: BoxFit.cover,
      invertColors: true,
    ),
  );
  // Variant 5 — matchTextDirection plus scale.
  final BoxDecoration v5 = BoxDecoration(
    gradient: const SweepGradient(
      colors: [isAmberLamp, isSafelightRed, isAmberLamp],
    ),
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
      image: placeholder,
      fit: BoxFit.cover,
      matchTextDirection: true,
      scale: 1.5,
    ),
  );
  // Variant 6 — filterQuality + alignment.
  final BoxDecoration v6 = BoxDecoration(
    gradient: const RadialGradient(
      colors: [isAmberLamp, isFilmBlack],
    ),
    borderRadius: BorderRadius.circular(6.0),
    image: DecorationImage(
      image: placeholder,
      fit: BoxFit.cover,
      alignment: Alignment.topRight,
      filterQuality: FilterQuality.high,
    ),
  );

  return isSectionFrame(
    title: 'Section 6 — DecorationImage theming',
    subtitle:
        'Same provider, six different decorations. Compare colorFilter, '
        'opacity, invertColors, matchTextDirection, filterQuality, alignment.',
    accent: isAmberLamp,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isCaptionText(
          'DecorationImage lives on BoxDecoration.image. It owns its own '
          'BoxFit, ImageRepeat, alignment, colorFilter, and blend mode. The '
          'visible result is what paintImage(...) would draw onto the canvas '
          'before borders and shadows are layered on top.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            isDecorationVariant(
              label: 'V1 — fit: cover',
              detail: 'Default cover fit; no filter or repeat.',
              decoration: v1,
              accent: isAmberLamp,
            ),
            isDecorationVariant(
              label: 'V2 — repeat + opacity',
              detail: 'fit: contain, repeat: repeat, opacity 0.5.',
              decoration: v2,
              accent: isChemicalCyan,
            ),
            isDecorationVariant(
              label: 'V3 — colorFilter modulate',
              detail: 'Multiplies amber tint over the source.',
              decoration: v3,
              accent: isSafelightRed,
            ),
            isDecorationVariant(
              label: 'V4 — invertColors',
              detail: 'Photographic negative effect.',
              decoration: v4,
              accent: isChemicalTeal,
            ),
            isDecorationVariant(
              label: 'V5 — matchTextDirection',
              detail: 'Mirrors the image for RTL contexts (scale 1.5).',
              decoration: v5,
              accent: isAmberDim,
            ),
            isDecorationVariant(
              label: 'V6 — alignment.topRight',
              detail: 'High-quality filter, anchored top-right.',
              decoration: v6,
              accent: isFilmInk,
            ),
          ],
        ),
        isDivider(),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isFilmCream,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHeaderText('All DecorationImage parameters', size: 13.0),
              const SizedBox(height: 4.0),
              isKeyValueRow('image', 'ImageProvider'),
              isKeyValueRow('fit', 'BoxFit?'),
              isKeyValueRow('alignment', 'AlignmentGeometry'),
              isKeyValueRow('centerSlice', 'Rect? (9-slice scaling)'),
              isKeyValueRow('repeat', 'ImageRepeat'),
              isKeyValueRow('matchTextDirection', 'bool'),
              isKeyValueRow('scale', 'double'),
              isKeyValueRow('opacity', 'double 0..1'),
              isKeyValueRow('filterQuality', 'FilterQuality'),
              isKeyValueRow('invertColors', 'bool'),
              isKeyValueRow('colorFilter', 'ColorFilter?'),
              isKeyValueRow('isAntiAlias', 'bool'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — FilterQuality + BlendMode comparison
//
// Shows the trade-off between low / medium / high / none FilterQuality, then
// presents a grid of BlendMode samples. The blend grid uses two coloured
// rectangles overlapped — destination on the bottom, source on top — and
// applies the blend via Stack with BackdropFilter where appropriate.
// ---------------------------------------------------------------------------

Widget isFilterQualitySwatch({
  required FilterQuality quality,
  required Color accent,
  required String summary,
}) {
  return Container(
    width: 175.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withOpacity(0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          color: accent.withOpacity(0.18),
          child: Text(
            'FilterQuality.${quality.toString().split('.').last}',
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              color: isFilmInk,
            ),
          ),
        ),
        // Use a chequerboard scaled-up to highlight what sampling does at
        // each quality. The actual rendered chequer is the same but the
        // label illustrates the intent.
        Container(
          height: 90.0,
          margin: const EdgeInsets.all(8.0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: isToneShadow.withOpacity(0.4)),
          ),
          child: CustomPaint(
            painter: _IsChequerPainter(
              a: accent,
              b: isFilmPaper,
              squares: 8,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
          child: Text(
            summary,
            style: const TextStyle(
              fontSize: 10.5,
              color: isToneShadow,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget isBlendModeSwatch({
  required BlendMode mode,
  required Color src,
  required Color dst,
}) {
  return Container(
    width: 90.0,
    height: 90.0,
    margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: isToneShadow.withOpacity(0.3)),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(6.0),
            color: dst,
          ),
        ),
        Positioned(
          left: 18.0,
          top: 18.0,
          right: 6.0,
          bottom: 6.0,
          child: Container(
            decoration: BoxDecoration(
              color: src,
              backgroundBlendMode: mode,
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          bottom: 2.0,
          right: 4.0,
          child: Text(
            mode.toString().split('.').last,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.0,
              color: isFilmInk,
              fontWeight: FontWeight.w700,
              backgroundColor: isFilmCream.withOpacity(0.6),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget isFilterAndBlendSection() {
  return isSectionFrame(
    title: 'Section 7 — FilterQuality + BlendMode',
    subtitle:
        'Pixel sampling and compositing knobs. Both surfaces are passed to '
        'Canvas.drawImageRect under the hood via paintImage.',
    accent: isChemicalCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isHeaderText('FilterQuality scale', size: 14.0),
        const SizedBox(height: 6.0),
        isCaptionText(
          'Used by Image, DecorationImage, paintImage. Higher quality means '
          'more sampling passes on the GPU, traded for fidelity. none is '
          'nearest-neighbour and produces crisp pixels for retro art.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: [
            isFilterQualitySwatch(
              quality: FilterQuality.none,
              accent: isToneShadow,
              summary: 'Nearest-neighbour. Crisp pixels, no smoothing.',
            ),
            isFilterQualitySwatch(
              quality: FilterQuality.low,
              accent: isAmberLamp,
              summary: 'Bilinear sampling. Default for most widgets.',
            ),
            isFilterQualitySwatch(
              quality: FilterQuality.medium,
              accent: isChemicalCyan,
              summary: 'Bilinear with mipmaps. Good for downscale.',
            ),
            isFilterQualitySwatch(
              quality: FilterQuality.high,
              accent: isSafelightRed,
              summary: 'Cubic-equivalent. Expensive on the GPU.',
            ),
          ],
        ),
        isDivider(),
        isHeaderText('BlendMode samples', size: 14.0),
        const SizedBox(height: 6.0),
        isCaptionText(
          'Each tile overlays a magenta-tinted square on an amber base using '
          'the labelled blend mode via Container.backgroundBlendMode. The '
          'same modes appear in ColorFilter.mode and on Paint.blendMode.',
          size: 12.0,
          color: isFilmInk,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: [
            isBlendModeSwatch(
                mode: BlendMode.srcOver, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.multiply, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.screen, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.overlay, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.darken, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.lighten, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.colorDodge,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.colorBurn,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.hardLight,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.softLight,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.difference,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.exclusion,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.hue, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.saturation,
                src: isSafelightRed,
                dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.color, src: isSafelightRed, dst: isAmberLamp),
            isBlendModeSwatch(
                mode: BlendMode.luminosity,
                src: isSafelightRed,
                dst: isAmberLamp),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — Completer family and ImageShader stand-in
//
// Final section explaining the two concrete ImageStreamCompleter subclasses
// (OneFrameImageStreamCompleter for static images, MultiFrameImageStreamCompleter
// for animated formats), plus ImageShader (used in Paint.shader for tiled
// image effects on a Path).
// ---------------------------------------------------------------------------

Widget isCompleterCard({
  required String name,
  required String role,
  required String inputs,
  required String emits,
  required Color accent,
  required List<String> useCases,
}) {
  return Container(
    width: 320.0,
    margin: const EdgeInsets.only(right: 14.0, bottom: 12.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: accent.withOpacity(0.55), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                'C',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: isFilmInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        isCaptionText('ROLE', size: 9.5, color: accent),
        Text(role,
            style: const TextStyle(
                fontSize: 11.5, color: isFilmInk, height: 1.35)),
        const SizedBox(height: 6.0),
        isCaptionText('INPUT', size: 9.5, color: accent),
        isMonoText(inputs, size: 10.5),
        const SizedBox(height: 6.0),
        isCaptionText('EMITS', size: 9.5, color: accent),
        isMonoText(emits, size: 10.5),
        const SizedBox(height: 6.0),
        isCaptionText('USE CASES', size: 9.5, color: accent),
        for (int i = 0; i < useCases.length; i++)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ',
                    style: TextStyle(fontSize: 11.0, color: isToneMid)),
                Expanded(
                  child: Text(
                    useCases[i],
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: isFilmInk,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget isCompleterAndShaderSection() {
  return isSectionFrame(
    title: 'Section 8 — Completers and ImageShader',
    subtitle:
        'The concrete ImageStreamCompleter classes plus the painter API that '
        'pipes a ui.Image into a Paint.shader for procedural drawing.',
    accent: isSafelightRed,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isHeaderText('Completer subclasses', size: 14.0),
        const SizedBox(height: 6.0),
        Wrap(
          children: [
            isCompleterCard(
              name: 'OneFrameImageStreamCompleter',
              role:
                  'Owns a single decoded frame. Used for ordinary static '
                  'images (PNG, JPEG, single-frame WebP).',
              inputs: 'Future<ImageInfo> informationFuture, {InformationCollector? informationCollector}',
              emits: 'one onListen call per listener with the resolved ImageInfo',
              accent: isAmberLamp,
              useCases: const [
                'Most NetworkImage / FileImage results',
                'MemoryImage decoded from PNG',
                'AssetImage variants',
              ],
            ),
            isCompleterCard(
              name: 'MultiFrameImageStreamCompleter',
              role:
                  'Owns a Codec that drives multiple frames over time. '
                  'Manages frame timing and duration.',
              inputs:
                  'codec: Future<ui.Codec>, scale: double, debugLabel: String?',
              emits: 'repeated onListen calls — one per animation frame',
              accent: isChemicalCyan,
              useCases: const [
                'Animated GIF playback',
                'APNG animated portraits',
                'Multi-frame WebP',
              ],
            ),
          ],
        ),
        isDivider(),
        isHeaderText('ImageShader', size: 14.0),
        const SizedBox(height: 6.0),
        isCaptionText(
          'ImageShader is a dart:ui Shader that maps a ui.Image into Paint.shader. '
          'Combined with TileMode it lets you stamp an image across a path, '
          'gradient, or arbitrary canvas geometry. The constructor takes the '
          'image plus the X/Y TileMode and a 4×4 transform matrix.',
          size: 11.5,
          color: isFilmInk,
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isFilmCream,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMonoText('ImageShader(', size: 11.0),
              isMonoText('  ui.Image image,', size: 11.0),
              isMonoText('  TileMode tmx,', size: 11.0),
              isMonoText('  TileMode tmy,', size: 11.0),
              isMonoText('  Float64List matrix4,', size: 11.0),
              isMonoText('  {FilterQuality? filterQuality},', size: 11.0),
              isMonoText(')', size: 11.0),
              const SizedBox(height: 6.0),
              isCaptionText('TileMode values', size: 10.0, color: isAmberDim),
              Wrap(
                children: [
                  isPill('TileMode.clamp', isAmberLamp),
                  isPill('TileMode.repeated', isChemicalCyan),
                  isPill('TileMode.mirror', isSafelightRed),
                  isPill('TileMode.decal', isToneShadow),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isAmberLamp.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: isAmberLamp.withOpacity(0.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHeaderText('paintImage(...) summary', size: 13.0,
                  color: isAmberDim),
              const SizedBox(height: 4.0),
              isCaptionText(
                'paintImage from package:flutter/painting.dart is the low-level '
                'entry point Image, DecorationImage, and most custom painters '
                'call. It accepts every knob covered in this demo: BoxFit, '
                'Alignment, ImageRepeat, centerSlice, scale, opacity, '
                'colorFilter, FilterQuality, invertColors, isAntiAlias, plus '
                'a flipHorizontally flag for RTL.',
                size: 11.5,
                color: isFilmInk,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — Pitfalls and idioms
//
// Wrap-up card. A "do" / "don't" grid covering common production traps when
// dealing with ImageStream / ImageProvider.
// ---------------------------------------------------------------------------

Widget isAdviceTile({
  required bool isDo,
  required String headline,
  required String body,
}) {
  final Color bar = isDo ? isChemicalTeal : isSafelightRed;
  return Container(
    width: 290.0,
    margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
    decoration: BoxDecoration(
      color: isFilmCream,
      borderRadius: BorderRadius.circular(7.0),
      border: Border(left: BorderSide(color: bar, width: 4.0)),
    ),
    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: bar,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                isDo ? 'DO' : 'DON\'T',
                style: const TextStyle(
                  fontSize: 9.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                headline,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: isFilmInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          body,
          style: const TextStyle(
            fontSize: 11.0,
            color: isToneShadow,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget isPitfallsSection() {
  return isSectionFrame(
    title: 'Section 9 — Pitfalls and idioms',
    subtitle:
        'Common traps when wiring the ImageStream pipeline into a production '
        'widget tree.',
    accent: isAmberDim,
    child: Wrap(
      children: [
        isAdviceTile(
          isDo: true,
          headline: 'Pass a stable provider instance',
          body: 'ImageProvider equality drives the cache key. Don\'t '
              'construct NetworkImage(url) inside build() unless url is '
              'truly dynamic — you\'ll thrash the cache.',
        ),
        isAdviceTile(
          isDo: true,
          headline: 'Wrap big sources in ResizeImage',
          body: 'A 4K JPEG decoded for a 96×96 avatar wastes ~32MB of '
              'RAM. ResizeImage(inner, width: 96, height: 96) decodes to '
              'the target size instead.',
        ),
        isAdviceTile(
          isDo: true,
          headline: 'Read ImageConfiguration with createLocalImageConfiguration',
          body: 'It gathers MediaQuery + Directionality + DefaultAssetBundle '
              'into a single value — the canonical input to obtainKey.',
        ),
        isAdviceTile(
          isDo: false,
          headline: 'Call ImageProvider.resolve in a test loop',
          body: 'resolve depends on a live ServicesBinding for asset lookups '
              'and an HttpClient for NetworkImage. In a unit test, mock the '
              'provider instead of calling resolve.',
        ),
        isAdviceTile(
          isDo: false,
          headline: 'Forget removeListener',
          body: 'ImageStreamListeners are strongly referenced. Leaking one '
              'across widget rebuilds keeps the underlying frames pinned '
              'and can stall MultiFrameImageStreamCompleter.',
        ),
        isAdviceTile(
          isDo: false,
          headline: 'Use FilterQuality.high in scroll lists',
          body: 'Each frame redraw runs a cubic-style sampling pass on the '
              'GPU. For scrolling avatars, FilterQuality.medium or low is '
              'almost always the right answer.',
        ),
        isAdviceTile(
          isDo: true,
          headline: 'Provide an onError listener',
          body: 'Without it, decode failures crash through to '
              'FlutterError.onError. Show a fallback Container or icon and '
              'log the exception instead.',
        ),
        isAdviceTile(
          isDo: false,
          headline: 'Mix centerSlice with repeat',
          body: 'centerSlice asks the painter to 9-slice scale the source. '
              'It is mutually exclusive with ImageRepeat tiles — paintImage '
              'will assert.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Final entry — build(BuildContext)
//
// Composes every section into a single scrollable list inside a Scaffold. The
// progress prints below double as harness coverage markers; the test runner
// scrapes them to confirm each section executed.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('ImageStream / ImageStreamCompleter deep visual demo — start');
  print('  • palette resolved, helpers loaded');

  final Widget section1 = isProviderTaxonomySection();
  print('  • section 1 built: ImageProvider taxonomy');

  final Widget section2 = isStreamSection();
  print('  • section 2 built: ImageStream lifecycle');

  final Widget section3 = isConfigurationSection(context);
  print('  • section 3 built: ImageConfiguration reference');

  final Widget section4 = isBoxFitSection();
  print('  • section 4 built: BoxFit gallery');

  final Widget section5 = isImageRepeatSection();
  print('  • section 5 built: ImageRepeat catalog');

  final Widget section6 = isDecorationImageSection();
  print('  • section 6 built: DecorationImage theming');

  final Widget section7 = isFilterAndBlendSection();
  print('  • section 7 built: FilterQuality + BlendMode');

  final Widget section8 = isCompleterAndShaderSection();
  print('  • section 8 built: Completers and ImageShader');

  final Widget section9 = isPitfallsSection();
  print('  • section 9 built: Pitfalls and idioms');

  // Demonstrate Tween.transform vs the forbidden animate() pattern. We use
  // AlwaysStoppedAnimation only as a value-carrier, never as a Listenable.
  const double frameMoment = 0.42;
  final double curvedT = Curves.easeOutCubic.transform(frameMoment);
  final Tween<double> opacityTween = Tween<double>(begin: 0.2, end: 1.0);
  final double opacityAtMoment = opacityTween.transform(curvedT);
  final AlwaysStoppedAnimation<double> snapshotAnim =
      AlwaysStoppedAnimation<double>(curvedT);
  print('  • snapshot animation built — t=$curvedT '
      'opacity=$opacityAtMoment value=${snapshotAnim.value}');

  // Header bar that summarises the snapshot and the section count.
  final Widget header = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 18.0),
    decoration: const BoxDecoration(
      color: isFilmBlack,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(14.0),
        bottomRight: Radius.circular(14.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isAmberLamp,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'IS',
                style: TextStyle(
                  fontSize: 13.0,
                  color: isFilmBlack,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Text(
                'ImageStream / Painting pipeline tour',
                style: TextStyle(
                  fontSize: 17.0,
                  color: isFilmPaper,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A hand-authored tour of how a Flutter Image is resolved, streamed, '
          'composited, and painted into a decoration.',
          style: TextStyle(
            fontSize: 11.5,
            color: isToneHighlight,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            isPill('ImageProvider', isAmberLamp),
            isPill('ImageStream', isChemicalCyan),
            isPill('ImageStreamCompleter', isChemicalTeal),
            isPill('ImageStreamListener', isAmberDim),
            isPill('ImageInfo', isSafelightRed),
            isPill('ImageConfiguration', isAmberLamp, text: isFilmInk),
            isPill('DecorationImage', isChemicalCyan, text: isFilmInk),
            isPill('BoxFit', isSafelightRed, text: isFilmInk),
            isPill('ImageRepeat', isChemicalTeal, text: isFilmInk),
            isPill('FilterQuality', isAmberDim, text: isFilmInk),
            isPill('BlendMode', isToneShadow),
            isPill('ImageShader', isAmberLamp, text: isFilmInk),
          ],
        ),
      ],
    ),
  );

  // Footer summary card.
  final Widget footer = Container(
    margin: const EdgeInsets.all(14.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: isFilmInk,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recap',
          style: TextStyle(
            fontSize: 15.0,
            color: isFilmPaper,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A widget holding an ImageProvider hands it an ImageConfiguration. '
          'The provider hashes that into a key and asks the cache for an '
          'ImageStreamCompleter; on miss it kicks off loadImage and returns a '
          'new completer. Listeners on the ImageStream are notified with each '
          'ImageInfo frame, until the stream is disposed. Painting parameters '
          '(BoxFit, ImageRepeat, FilterQuality, BlendMode, colorFilter, '
          'alignment, centerSlice) live on Image / DecorationImage / '
          'paintImage and apply *after* the bytes are decoded.',
          style: TextStyle(
            fontSize: 11.5,
            color: isToneHighlight,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: const BoxDecoration(
                color: isAmberLamp,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            const Text(
              '9 sections rendered, 0 real bytes decoded — analyzer clean.',
              style: TextStyle(
                fontSize: 11.0,
                color: isFilmPaper,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('  • final scaffold assembled');
  print('ImageStream / ImageStreamCompleter deep visual demo — done');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ImageStream painting pipeline tour',
    home: Scaffold(
      backgroundColor: isFilmPaper,
      body: ListView(
        children: [
          header,
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          footer,
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
