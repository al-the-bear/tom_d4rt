// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
//
// =====================================================================
// D4RT DEEP DEMO  --  ImageProvider family from package:flutter/painting
// =====================================================================
//
// Subject:    AssetImage / ExactAssetImage / NetworkImage / MemoryImage /
//             FileImage (referenced only) / ResizeImage / ImageProvider<T>
// Theme:      "Darkroom / Photo-Lab"  (sepia, charcoal, kodak-yellow,
//             cyanotype, magenta, ivory, silver-halide).
// Audience:   Developers learning what an ImageProvider actually IS
//             before any pixels ever land on the screen.
//
// ---------------------------------------------------------------------
// What is an ImageProvider?
// ---------------------------------------------------------------------
// An `ImageProvider<T>` is a *recipe* for producing an image stream.
// It is NOT the image, NOT the bytes, NOT a widget.  It is a small,
// hashable, equatable description of "where the pixels come from".
//
// The framework calls `obtainKey(ImageConfiguration)` to derive a
// cache-key of type T (e.g. `AssetBundleImageKey`, `NetworkImage`
// itself, `MemoryImage` itself, ...).  That key indexes the global
// `ImageCache`.  Only when no cached entry exists does the provider
// actually fetch / decode bytes through its `loadImage` (or legacy
// `load`) method.
//
// The lifecycle, from declaration to first frame, is:
//
//      [ ImageProvider<T> ]   declarative recipe
//             |
//             |  obtainKey(configuration)
//             v
//      [ T  cache-key      ]   equatable+hashable
//             |
//             |  ImageCache.putIfAbsent
//             v
//      [ ImageStreamCompleter ] decodes bytes
//             |
//             |  notifies listeners
//             v
//      [ ImageStream / ImageInfo ]
//             |
//             v
//      [ Painter renders frame  ]
//
// ---------------------------------------------------------------------
// D4rt-AST sandbox notes
// ---------------------------------------------------------------------
// This script is hand-authored to be sent over HTTP to a D4rt-AST
// renderer.  The sandbox is STATIC: there is no event loop, no Future,
// no Timer, no setState.  So this demo:
//   * Constructs ImageProviders.
//   * Inspects their public state (assetName, scale, url, headers, ...).
//   * Compares equality and hashCode.
//   * Renders a documentary about the family using coloured Containers
//     as visual stand-ins for the would-be image content.
// It DOES NOT call `provider.resolve(...)`, `obtainKey(...)`, or wrap
// any provider in an `Image` widget — the sandbox would not load
// asset bundles or network resources.
// ---------------------------------------------------------------------

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// ---------------------------------------------------------------------
// Darkroom / Photo-Lab palette
// ---------------------------------------------------------------------
const Color kInkBlack = Color(0xFF14110F);
const Color kCharcoal = Color(0xFF2A2724);
const Color kSepiaDeep = Color(0xFF6B4423);
const Color kSepiaLight = Color(0xFFC9A77A);
const Color kKodakYellow = Color(0xFFF5C518);
const Color kSafelightRed = Color(0xFF8E1A1A);
const Color kCyanotype = Color(0xFF1F5673);
const Color kMagentaProc = Color(0xFFB9377F);
const Color kIvoryPaper = Color(0xFFF3EBD8);
const Color kSilverHalide = Color(0xFFB8B8B0);
const Color kEmulsion = Color(0xFF38322E);
const Color kRedFilter = Color(0xFFD13B2C);

// ---------------------------------------------------------------------
// Helpers — top-level, no class subclassing
// ---------------------------------------------------------------------
Widget kPanel({
  required Widget child,
  Color background = kIvoryPaper,
  Color border = kCharcoal,
  double radius = 10.0,
  EdgeInsets padding = const EdgeInsets.all(14.0),
  EdgeInsets margin = const EdgeInsets.symmetric(vertical: 6.0),
  List<BoxShadow>? shadows,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border, width: 1.2),
      boxShadow: shadows,
    ),
    child: child,
  );
}

Widget kSectionTitle(String index, String title, Color accent) {
  return Container(
    margin: const EdgeInsets.only(top: 18.0, bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42.0,
          height: 42.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [accent, kInkBlack],
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x55000000),
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: kIvoryPaper,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: kInkBlack,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget kKeyValue(String key, String value, {Color color = kCharcoal}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            key,
            style: TextStyle(
              color: color,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: kEmulsion,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget kBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4.0, right: 8.0),
          child: Icon(Icons.circle, size: 6.0, color: kSepiaDeep),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: kEmulsion,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget kArrowDown(Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Icon(Icons.arrow_downward, size: 18.0, color: color),
  );
}

Widget kPipelineNode(String label, String sub, Color color) {
  return Container(
    width: 320.0,
    margin: const EdgeInsets.symmetric(vertical: 2.0),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [color.withOpacity(0.95), color.withOpacity(0.65)],
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: kInkBlack, width: 1.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(1.5, 1.5),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kIvoryPaper,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          sub,
          style: const TextStyle(
            color: Color(0xFFEFE7D2),
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}

Widget kImageStandIn({
  required double width,
  required double height,
  required List<Color> colors,
  required String caption,
  String? cornerTag,
  AlignmentGeometry begin = Alignment.topLeft,
  AlignmentGeometry end = Alignment.bottomRight,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(6.0),
    child: Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: colors,
            ),
            border: Border.all(color: kCharcoal, width: 1.0),
          ),
        ),
        Positioned(
          left: 6.0,
          bottom: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            color: const Color(0xCC14110F),
            child: Text(
              caption,
              style: const TextStyle(
                color: kIvoryPaper,
                fontSize: 10.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        if (cornerTag != null)
          Positioned(
            right: 6.0,
            top: 6.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: kKodakYellow,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                cornerTag,
                style: const TextStyle(
                  color: kInkBlack,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget kProviderCard({
  required String title,
  required String typeName,
  required Color accent,
  required List<Color> standInColors,
  required String standInCaption,
  required List<Widget> kvRows,
  String? cornerTag,
}) {
  return Container(
    width: 300.0,
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: kIvoryPaper,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.4),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(2.0, 3.0),
          blurRadius: 5.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kIvoryPaper,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                typeName,
                style: const TextStyle(
                  color: kIvoryPaper,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: kImageStandIn(
            width: 280.0,
            height: 110.0,
            colors: standInColors,
            caption: standInCaption,
            cornerTag: cornerTag,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: kvRows,
          ),
        ),
      ],
    ),
  );
}

Widget kComparisonRow(List<String> cells, {bool header = false}) {
  return Container(
    decoration: BoxDecoration(
      color: header ? kCharcoal : kIvoryPaper,
      border: const Border(
        bottom: BorderSide(color: kSepiaLight, width: 0.6),
      ),
    ),
    child: Row(
      children: [
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == 0 ? 2 : 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 6.0,
              ),
              child: Text(
                cells[i],
                style: TextStyle(
                  color: header ? kIvoryPaper : kEmulsion,
                  fontSize: 11.5,
                  fontWeight:
                      header ? FontWeight.w800 : FontWeight.w400,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget kCheatRow(String when, String pick, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.0,
          height: 28.0,
          color: color,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 3,
          child: Text(
            when,
            style: const TextStyle(
              color: kCharcoal,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 2,
          child: Text(
            pick,
            style: const TextStyle(
              color: kInkBlack,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// build()  —  single entry point
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('[image_providers_test] starting deep demo of ImageProvider family');
  print('[image_providers_test] palette: darkroom/photo-lab');
  print('[image_providers_test] sandbox: D4rt-AST renderer (static)');
  print('[image_providers_test] no resolve/loadImage will be invoked');

  // -------------------------------------------------------------------
  // SECTION 0 — Anchor instances
  // -------------------------------------------------------------------
  print('--- section 0: anchor instances ---');

  const String kAssetPath = 'assets/photo_lab/contact_sheet.png';
  const String kAssetBar = 'assets/photo_lab/test_strip.png';
  const String kAssetPackage = 'demo_photo_lab';

  final AssetImage assetA = const AssetImage(
    kAssetPath,
    package: kAssetPackage,
  );
  final AssetImage assetATwin = const AssetImage(
    kAssetPath,
    package: kAssetPackage,
  );
  final AssetImage assetB = const AssetImage(kAssetBar);

  print('AssetImage assetA.assetName       = ${assetA.assetName}');
  print('AssetImage assetA.package         = ${assetA.package}');
  print('AssetImage assetA.toString        = ${assetA.toString()}');
  print('AssetImage assetA.hashCode        = ${assetA.hashCode}');
  print('AssetImage assetA == assetATwin   = ${assetA == assetATwin}');
  print('AssetImage assetA == assetB       = ${assetA == assetB}');
  print('AssetImage assetA.runtimeType     = ${assetA.runtimeType}');

  final NetworkImage netA = const NetworkImage(
    'https://example.com/lab/roll-A.jpg',
    scale: 1.0,
    headers: <String, String>{
      'Accept': 'image/jpeg',
      'X-Lab-Roll': 'A',
    },
  );
  final NetworkImage netATwin = const NetworkImage(
    'https://example.com/lab/roll-A.jpg',
    scale: 1.0,
    headers: <String, String>{
      'Accept': 'image/jpeg',
      'X-Lab-Roll': 'A',
    },
  );
  final NetworkImage netB = const NetworkImage(
    'https://example.com/lab/roll-B.jpg',
    scale: 2.0,
  );

  print('NetworkImage netA.url         = ${netA.url}');
  print('NetworkImage netA.scale       = ${netA.scale}');
  print('NetworkImage netA.headers     = ${netA.headers}');
  print('NetworkImage netA.toString    = ${netA.toString()}');
  print('NetworkImage netA.hashCode    = ${netA.hashCode}');
  print('NetworkImage netA == netATwin = ${netA == netATwin}');
  print('NetworkImage netA == netB     = ${netA == netB}');

  final Uint8List memBytes = Uint8List.fromList(<int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  ]);
  final MemoryImage memA = MemoryImage(memBytes, scale: 1.5);
  final MemoryImage memATwin = MemoryImage(memBytes, scale: 1.5);
  final MemoryImage memB =
      MemoryImage(Uint8List.fromList(<int>[1, 2, 3]));

  print('MemoryImage memA.bytes.length = ${memA.bytes.length}');
  print('MemoryImage memA.scale        = ${memA.scale}');
  print('MemoryImage memA.toString     = ${memA.toString()}');
  print('MemoryImage memA.hashCode     = ${memA.hashCode}');
  print('MemoryImage memA == memATwin  = ${memA == memATwin}');
  print('MemoryImage memA == memB      = ${memA == memB}');

  final ExactAssetImage exactA = const ExactAssetImage(
    'assets/photo_lab/grain_2x.png',
    scale: 2.0,
    package: kAssetPackage,
  );
  final ExactAssetImage exactATwin = const ExactAssetImage(
    'assets/photo_lab/grain_2x.png',
    scale: 2.0,
    package: kAssetPackage,
  );
  final ExactAssetImage exactB = const ExactAssetImage(
    'assets/photo_lab/grain_3x.png',
    scale: 3.0,
  );

  print('ExactAssetImage exactA.assetName   = ${exactA.assetName}');
  print('ExactAssetImage exactA.scale       = ${exactA.scale}');
  print('ExactAssetImage exactA.package     = ${exactA.package}');
  print('ExactAssetImage exactA.toString    = ${exactA.toString()}');
  print('ExactAssetImage exactA == twin     = ${exactA == exactATwin}');
  print('ExactAssetImage exactA == exactB   = ${exactA == exactB}');

  final ResizeImage resizeA = ResizeImage(
    assetA,
    width: 256,
    height: 256,
    policy: ResizeImagePolicy.fit,
    allowUpscaling: false,
  );
  final ResizeImage resizeAExact = ResizeImage(
    assetA,
    width: 256,
    height: 256,
    policy: ResizeImagePolicy.exact,
    allowUpscaling: true,
  );
  final ResizeImage resizeOnNet = ResizeImage(
    netA,
    width: 512,
    policy: ResizeImagePolicy.fit,
  );

  print('ResizeImage resizeA.width        = ${resizeA.width}');
  print('ResizeImage resizeA.height       = ${resizeA.height}');
  print('ResizeImage resizeA.policy       = ${resizeA.policy}');
  print('ResizeImage resizeA.allowUpscaling=${resizeA.allowUpscaling}');
  print('ResizeImage resizeA.imageProvider=${resizeA.imageProvider}');
  print('ResizeImage resizeA.toString     = ${resizeA.toString()}');

  // Treat them as the abstract base type.
  final List<ImageProvider<Object>> providers = <ImageProvider<Object>>[
    assetA,
    assetB,
    netA,
    netB,
    memA,
    memB,
    exactA,
    exactB,
    resizeA,
    resizeAExact,
    resizeOnNet,
  ];
  print('total providers under analysis = ${providers.length}');
  for (int i = 0; i < providers.length; i++) {
    print('providers[$i].runtimeType = ${providers[i].runtimeType}');
  }

  // -------------------------------------------------------------------
  // SECTION 1 — Title banner
  // -------------------------------------------------------------------
  print('--- section 1: title banner ---');
  final Widget titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kInkBlack, kSepiaDeep, kKodakYellow],
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          offset: Offset(3.0, 5.0),
          blurRadius: 10.0,
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: 12.0,
          top: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: kSafelightRed,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              'DARKROOM',
              style: TextStyle(
                color: kIvoryPaper,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'ImageProvider Family',
              style: TextStyle(
                color: kIvoryPaper,
                fontSize: 26.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Where pixels come from in package:flutter/painting',
              style: TextStyle(
                color: Color(0xFFE8DFC2),
                fontSize: 13.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Asset · ExactAsset · Network · Memory · File · Resize',
              style: TextStyle(
                color: kKodakYellow,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 2 — Anatomy / lifecycle diagram
  // -------------------------------------------------------------------
  print('--- section 2: lifecycle diagram ---');
  print('lifecycle nodes: configuration -> key -> cache -> completer -> frame');
  print('the provider itself is just a recipe; nothing happens until resolve()');
  print('we therefore inspect providers WITHOUT invoking the loader');

  final Widget lifecycleDiagram = kPanel(
    background: kCharcoal,
    border: kSepiaDeep,
    shadows: const [
      BoxShadow(
        color: Color(0x55000000),
        offset: Offset(2.0, 3.0),
        blurRadius: 6.0,
      ),
    ],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ImageProvider<T> lifecycle',
          style: TextStyle(
            color: kKodakYellow,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          '(declarative recipe → cache key → bytes → frame)',
          style: TextStyle(
            color: kSilverHalide,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12.0),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              kPipelineNode(
                'ImageProvider<T>',
                'AssetImage / NetworkImage / MemoryImage / ResizeImage',
                kSepiaDeep,
              ),
              kArrowDown(kKodakYellow),
              kPipelineNode(
                'obtainKey(ImageConfiguration)',
                'returns Future<T>  (T = AssetBundleImageKey, ...)',
                kCyanotype,
              ),
              kArrowDown(kKodakYellow),
              kPipelineNode(
                'ImageCache.putIfAbsent(key)',
                'global LRU cache, T must be == and hashCode',
                kMagentaProc,
              ),
              kArrowDown(kKodakYellow),
              kPipelineNode(
                'ImageStreamCompleter',
                'decodes bytes via loadImage / load',
                kSepiaLight,
              ),
              kArrowDown(kKodakYellow),
              kPipelineNode(
                'ImageStream → ImageInfo',
                'frame delivered to listeners',
                kKodakYellow,
              ),
              kArrowDown(kKodakYellow),
              kPipelineNode(
                'Painter',
                'pixels finally rendered onto canvas',
                kSafelightRed,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 3 — Provider gallery (six cards)
  // -------------------------------------------------------------------
  print('--- section 3: provider gallery ---');
  print('card 1: AssetImage with package');
  print('card 2: AssetImage without package');
  print('card 3: NetworkImage with headers + scale');
  print('card 4: MemoryImage from a tiny Uint8List');
  print('card 5: ExactAssetImage with scale=2');
  print('card 6: ResizeImage wrapping AssetImage');

  final Widget cardAsset1 = kProviderCard(
    title: 'AssetImage (with package)',
    typeName: 'ImageProvider<AssetBundleImageKey>',
    accent: kSepiaDeep,
    standInColors: const [kSepiaDeep, kSepiaLight, kIvoryPaper],
    standInCaption: 'asset · sepia bundle',
    cornerTag: 'pkg',
    kvRows: [
      kKeyValue('assetName', assetA.assetName),
      kKeyValue('package', '${assetA.package}'),
      kKeyValue('runtimeType', '${assetA.runtimeType}'),
      kKeyValue('hashCode', '${assetA.hashCode}'),
    ],
  );

  final Widget cardAsset2 = kProviderCard(
    title: 'AssetImage (no package)',
    typeName: 'ImageProvider<AssetBundleImageKey>',
    accent: kCyanotype,
    standInColors: const [kCyanotype, Color(0xFF6FA8C6), kIvoryPaper],
    standInCaption: 'asset · default bundle',
    kvRows: [
      kKeyValue('assetName', assetB.assetName),
      kKeyValue('package', '${assetB.package}'),
      kKeyValue('hashCode', '${assetB.hashCode}'),
      kKeyValue('toString', assetB.toString()),
    ],
  );

  final Widget cardNetwork = kProviderCard(
    title: 'NetworkImage (headers)',
    typeName: 'ImageProvider<NetworkImage>',
    accent: kMagentaProc,
    standInColors: const [kMagentaProc, kSafelightRed, kKodakYellow],
    standInCaption: 'network · roll-A.jpg',
    cornerTag: 'GET',
    kvRows: [
      kKeyValue('url', netA.url),
      kKeyValue('scale', '${netA.scale}'),
      kKeyValue('headers', '${netA.headers?.length ?? 0} entries'),
      kKeyValue('hashCode', '${netA.hashCode}'),
    ],
  );

  final Widget cardMemory = kProviderCard(
    title: 'MemoryImage (Uint8List)',
    typeName: 'ImageProvider<MemoryImage>',
    accent: kKodakYellow,
    standInColors: const [kKodakYellow, kSepiaLight, kIvoryPaper],
    standInCaption: 'memory · 16 bytes (PNG header)',
    cornerTag: 'RAM',
    kvRows: [
      kKeyValue('bytes.length', '${memA.bytes.length}'),
      kKeyValue('scale', '${memA.scale}'),
      kKeyValue('runtimeType', '${memA.runtimeType}'),
      kKeyValue('hashCode', '${memA.hashCode}'),
    ],
  );

  final Widget cardExact = kProviderCard(
    title: 'ExactAssetImage (scale=2)',
    typeName: 'ImageProvider<AssetBundleImageKey>',
    accent: kSafelightRed,
    standInColors: const [kSafelightRed, kSepiaDeep, kCharcoal],
    standInCaption: 'exact · grain_2x.png',
    cornerTag: '@2x',
    kvRows: [
      kKeyValue('assetName', exactA.assetName),
      kKeyValue('scale', '${exactA.scale}'),
      kKeyValue('package', '${exactA.package}'),
      kKeyValue('hashCode', '${exactA.hashCode}'),
    ],
  );

  final Widget cardResize = kProviderCard(
    title: 'ResizeImage (wraps AssetImage)',
    typeName: 'ImageProvider<ResizeImageKey>',
    accent: kEmulsion,
    standInColors: const [kEmulsion, kSepiaDeep, kSepiaLight],
    standInCaption: 'resize · 256×256 fit',
    cornerTag: 'fit',
    kvRows: [
      kKeyValue('width', '${resizeA.width}'),
      kKeyValue('height', '${resizeA.height}'),
      kKeyValue('policy', '${resizeA.policy}'),
      kKeyValue('upscaling', '${resizeA.allowUpscaling}'),
    ],
  );

  final Widget gallerySection = kPanel(
    background: const Color(0xFFEDE3CC),
    border: kSepiaDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Provider gallery — six representative cards',
          style: TextStyle(
            color: kInkBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 0.0,
          runSpacing: 0.0,
          children: [
            cardAsset1,
            cardAsset2,
            cardNetwork,
            cardMemory,
            cardExact,
            cardResize,
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 4 — ResizeImage in depth
  // -------------------------------------------------------------------
  print('--- section 4: ResizeImage policies ---');
  print('policy.fit  : preserves aspect, fits within bounds');
  print('policy.exact: forces exact pixel dimensions (may distort)');
  print('allowUpscaling=false prevents enlarging beyond intrinsic size');
  print('null width/height becomes a target hint, not a clamp');

  final Widget resizeFitVisual = Container(
    width: 220.0,
    height: 130.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kIvoryPaper,
      border: Border.all(color: kCyanotype, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    alignment: Alignment.center,
    child: Container(
      width: 130.0,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [kKodakYellow, kSepiaDeep],
          radius: 0.9,
        ),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x44000000),
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        'fit · keep AR',
        style: TextStyle(
          color: kInkBlack,
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  final Widget resizeExactVisual = Container(
    width: 220.0,
    height: 130.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kIvoryPaper,
      border: Border.all(color: kSafelightRed, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    alignment: Alignment.center,
    child: Container(
      width: 200.0,
      height: 110.0,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [kSafelightRed, kEmulsion],
          radius: 0.9,
        ),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x44000000),
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        'exact · stretched',
        style: TextStyle(
          color: kIvoryPaper,
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  final Widget resizeSection = kPanel(
    background: kIvoryPaper,
    border: kCyanotype,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ResizeImage — decoding at a target size',
          style: TextStyle(
            color: kInkBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Wrap any ImageProvider to ask the decoder to produce a smaller '
          'frame. The cache key includes (width, height, policy, allowUpscaling).',
          style: TextStyle(color: kEmulsion, fontSize: 12.0),
        ),
        const SizedBox(height: 12.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #63, P12):
        // The two inline Column children are wrapped in Expanded so the
        // outer Row hands them a bounded width. Without Expanded, Row
        // propagates an unbounded width constraint to its non-flex
        // children, and the kKeyValue rows nested inside (Padding > Row >
        // Expanded(Text)) then fail with "RenderFlex children have
        // non-zero flex but incoming width constraints are unbounded".
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'policy: ResizeImagePolicy.fit',
                    style: TextStyle(
                      color: kCyanotype,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  resizeFitVisual,
                  const SizedBox(height: 6.0),
                  kKeyValue('width', '${resizeA.width}'),
                  kKeyValue('height', '${resizeA.height}'),
                  kKeyValue('upscaling', '${resizeA.allowUpscaling}'),
                  kKeyValue('wraps', '${resizeA.imageProvider.runtimeType}'),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'policy: ResizeImagePolicy.exact',
                    style: TextStyle(
                      color: kSafelightRed,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  resizeExactVisual,
                  const SizedBox(height: 6.0),
                  kKeyValue('width', '${resizeAExact.width}'),
                  kKeyValue('height', '${resizeAExact.height}'),
                  kKeyValue('upscaling', '${resizeAExact.allowUpscaling}'),
                  kKeyValue(
                    'wraps',
                    '${resizeAExact.imageProvider.runtimeType}',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kCharcoal,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'When to wrap with ResizeImage',
                style: TextStyle(
                  color: kKodakYellow,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '• Showing a 4096×4096 source in a 64×64 thumbnail slot.\n'
                '• Reducing memory pressure on long lists.\n'
                '• Avoiding shipping multiple asset variants when a single '
                'source can be decoded smaller on the fly.',
                style: TextStyle(color: kIvoryPaper, fontSize: 11.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 5 — Equality semantics
  // -------------------------------------------------------------------
  print('--- section 5: equality semantics ---');
  print('AssetImage equality is by (assetName, bundle, package).');
  print('NetworkImage equality is by (url, scale).');
  print('MemoryImage equality is by (bytes-identity, scale).');
  print('Two providers with equal cache-keys share a cache entry.');

  final bool eqAsset = assetA == assetATwin;
  final bool eqAssetCross = assetA == assetB;
  final bool eqNet = netA == netATwin;
  final bool eqNetCross = netA == netB;
  final bool eqMem = memA == memATwin;
  final bool eqMemCross = memA == memB;
  final bool eqExact = exactA == exactATwin;
  final bool eqExactCross = exactA == exactB;

  print('assetA == assetATwin   = $eqAsset');
  print('assetA == assetB       = $eqAssetCross');
  print('netA   == netATwin     = $eqNet');
  print('netA   == netB         = $eqNetCross');
  print('memA   == memATwin     = $eqMem');
  print('memA   == memB         = $eqMemCross');
  print('exactA == exactATwin   = $eqExact');
  print('exactA == exactB       = $eqExactCross');

  Widget eqRow(String label, bool result, String left, String right) {
    final Color c = result ? kCyanotype : kSafelightRed;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: c.withOpacity(0.10),
        border: Border.all(color: c, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130.0,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                color: kCharcoal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$left  ==  $right',
              style: const TextStyle(
                fontSize: 11.5,
                fontFamily: 'monospace',
                color: kEmulsion,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              result ? 'TRUE' : 'FALSE',
              style: const TextStyle(
                color: kIvoryPaper,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget equalitySection = kPanel(
    background: kIvoryPaper,
    border: kMagentaProc,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Equality and hashCode',
          style: TextStyle(
            color: kInkBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Two providers compare equal iff they describe the same source. '
          'This is what makes the global ImageCache work.',
          style: TextStyle(color: kEmulsion, fontSize: 12.0),
        ),
        const SizedBox(height: 10.0),
        eqRow('asset (twin)', eqAsset, 'AssetImage($kAssetPath)',
            'AssetImage($kAssetPath)'),
        eqRow('asset (cross)', eqAssetCross,
            'AssetImage($kAssetPath)', 'AssetImage($kAssetBar)'),
        eqRow('network (twin)', eqNet, 'NetworkImage(roll-A.jpg)',
            'NetworkImage(roll-A.jpg)'),
        eqRow('network (cross)', eqNetCross, 'NetworkImage(roll-A.jpg)',
            'NetworkImage(roll-B.jpg)'),
        eqRow('memory (twin)', eqMem, 'MemoryImage(bytes#A,1.5)',
            'MemoryImage(bytes#A,1.5)'),
        eqRow('memory (cross)', eqMemCross, 'MemoryImage(bytes#A,1.5)',
            'MemoryImage(bytes#B,1.0)'),
        eqRow('exactAsset (twin)', eqExact,
            'ExactAssetImage(grain_2x@2)', 'ExactAssetImage(grain_2x@2)'),
        eqRow('exactAsset (cross)', eqExactCross,
            'ExactAssetImage(grain_2x@2)', 'ExactAssetImage(grain_3x@3)'),
        const SizedBox(height: 8.0),
        kKeyValue('hash(assetA)', '${assetA.hashCode}'),
        kKeyValue('hash(twin)', '${assetATwin.hashCode}'),
        kKeyValue('hash(netA)', '${netA.hashCode}'),
        kKeyValue('hash(memA)', '${memA.hashCode}'),
        kKeyValue('hash(exactA)', '${exactA.hashCode}'),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 6 — Comparison table
  // -------------------------------------------------------------------
  print('--- section 6: provider comparison table ---');
  print('axes: source, key type, blocking?, typical use');
  print('FileImage skipped at runtime (no file IO in sandbox)');
  print('ResizeImage is a *decorator* — its key composes the inner key');

  final Widget comparisonSection = kPanel(
    background: kIvoryPaper,
    border: kSepiaDeep,
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          color: kSepiaDeep,
          child: const Text(
            'Provider comparison',
            style: TextStyle(
              color: kIvoryPaper,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        kComparisonRow(
          ['Provider', 'Source', 'Cache-key type', 'Notes'],
          header: true,
        ),
        kComparisonRow([
          'AssetImage',
          'AssetBundle',
          'AssetBundleImageKey',
          'auto-picks variant by devicePixelRatio',
        ]),
        kComparisonRow([
          'ExactAssetImage',
          'AssetBundle',
          'AssetBundleImageKey',
          'forces explicit scale; bypasses variant picking',
        ]),
        kComparisonRow([
          'NetworkImage',
          'HTTP(s) URL',
          'NetworkImage (itself)',
          'supports headers; uses HttpClient',
        ]),
        kComparisonRow([
          'MemoryImage',
          'Uint8List',
          'MemoryImage (itself)',
          'identity-based; bytes are the source of truth',
        ]),
        kComparisonRow([
          'FileImage',
          'dart:io File',
          'FileImage (itself)',
          'NOT usable in web/sandbox; needs file IO',
        ]),
        kComparisonRow([
          'ResizeImage',
          'wraps another provider',
          'ResizeImageKey',
          'decodes at target size; key composes inner key',
        ]),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 7 — Cache-key concept (no obtainKey call)
  // -------------------------------------------------------------------
  print('--- section 7: cache-key concept ---');
  print('obtainKey returns Future<T> — we do NOT call it in the sandbox');
  print('we describe T conceptually for each provider variant');
  print('keys must be == and hashCode for ImageCache to dedupe correctly');

  Widget keyDiagram(String providerName, String keyType, String keyParts,
      Color color) {
    return Container(
      width: 340.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: kIvoryPaper,
        border: Border.all(color: color, width: 1.4),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Container(
            width: 110.0,
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 6.0,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignment: Alignment.center,
            child: Text(
              providerName,
              style: const TextStyle(
                color: kIvoryPaper,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(Icons.arrow_forward, size: 16.0, color: kCharcoal),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  keyType,
                  style: const TextStyle(
                    color: kInkBlack,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  keyParts,
                  style: const TextStyle(
                    color: kEmulsion,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget keySection = kPanel(
    background: const Color(0xFFEDE3CC),
    border: kCyanotype,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'obtainKey — the cache identity of an ImageProvider',
          style: TextStyle(
            color: kInkBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Each provider declares how to derive its cache key from an '
          'ImageConfiguration. We DO NOT invoke obtainKey here — the '
          'sandbox is static. Below is the conceptual mapping.',
          style: TextStyle(color: kEmulsion, fontSize: 12.0),
        ),
        const SizedBox(height: 10.0),
        keyDiagram(
          'AssetImage',
          'Future<AssetBundleImageKey>',
          '{ bundle, name (with variant), scale }',
          kSepiaDeep,
        ),
        keyDiagram(
          'ExactAssetImage',
          'Future<AssetBundleImageKey>',
          '{ bundle, name, scale (forced) }',
          kSafelightRed,
        ),
        keyDiagram(
          'NetworkImage',
          'Future<NetworkImage>',
          'the provider itself (url, scale, headers)',
          kMagentaProc,
        ),
        keyDiagram(
          'MemoryImage',
          'Future<MemoryImage>',
          'the provider itself (bytes-identity, scale)',
          kKodakYellow,
        ),
        keyDiagram(
          'FileImage',
          'Future<FileImage>',
          'the provider itself (file path, scale)',
          kEmulsion,
        ),
        keyDiagram(
          'ResizeImage',
          'Future<ResizeImageKey>',
          '{ innerKey, width, height, policy, allowUpscaling }',
          kCyanotype,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kCharcoal,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Why the key matters',
                style: TextStyle(
                  color: kKodakYellow,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '• ImageCache stores ImageStreamCompleter by key.\n'
                '• Two equal keys → one decode, one frame, shared listeners.\n'
                '• Two different keys → two decodes, two cache slots.\n'
                '• So overriding == / hashCode wrong = a memory leak.',
                style: TextStyle(
                  color: kIvoryPaper,
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 8 — Cheat-sheet: pick the right provider
  // -------------------------------------------------------------------
  print('--- section 8: cheat-sheet ---');
  print('rule of thumb: pick the cheapest source that matches the lifecycle');
  print('shipped with the app   -> AssetImage / ExactAssetImage');
  print('fetched from internet  -> NetworkImage');
  print('already in RAM         -> MemoryImage');
  print('on local disk          -> FileImage (mobile/desktop only)');
  print('any of the above big   -> wrap in ResizeImage');

  final Widget cheatSection = kPanel(
    background: kIvoryPaper,
    border: kKodakYellow,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cheat-sheet: which provider when?',
          style: TextStyle(
            color: kInkBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        kCheatRow(
          'Image is bundled in the app and you trust the bundle to '
          'pick the right scale variant for you.',
          'AssetImage',
          kSepiaDeep,
        ),
        kCheatRow(
          'Image is bundled but you must override the variant logic and '
          'pin a specific scale.',
          'ExactAssetImage',
          kSafelightRed,
        ),
        kCheatRow(
          'Image lives on a remote server and you may need request '
          'headers (auth, content-type).',
          'NetworkImage',
          kMagentaProc,
        ),
        kCheatRow(
          'Bytes are already in memory — generated, decompressed, or '
          'received over a non-HTTP channel.',
          'MemoryImage',
          kKodakYellow,
        ),
        kCheatRow(
          'Image lives on the local filesystem (camera capture, '
          'downloaded asset, cached blob).',
          'FileImage',
          kEmulsion,
        ),
        kCheatRow(
          'Source is much larger than the slot you will paint into.',
          'ResizeImage(...)',
          kCyanotype,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [kInkBlack, kSepiaDeep],
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Anti-patterns',
                style: TextStyle(
                  color: kKodakYellow,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '• Building a new MemoryImage(bytes) on every build() — the '
                'identity of the Uint8List is part of the cache key.\n'
                '• Using NetworkImage for an asset that ships with the app.\n'
                '• Wrapping with ResizeImage when the painter already scales.\n'
                '• Using FileImage on web (not supported).',
                style: TextStyle(
                  color: kIvoryPaper,
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 9 — Signature card
  // -------------------------------------------------------------------
  print('--- section 9: signature card ---');
  print('demo total providers: ${providers.length}');
  print('demo equality checks: 8');
  print('demo cards rendered : 6');
  print('demo finished');

  final Widget signatureCard = Container(
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kCharcoal, kInkBlack],
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          offset: Offset(2.0, 4.0),
          blurRadius: 6.0,
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              colors: [kKodakYellow, kSepiaDeep],
              radius: 0.9,
            ),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x55000000),
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: const Icon(
            Icons.photo_camera,
            color: kInkBlack,
            size: 28.0,
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'D4rt Deep Demo · ImageProvider Family',
                style: TextStyle(
                  color: kIvoryPaper,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'package:flutter/painting · static analysis only · '
                'no resolve(), no obtainKey(), no decode',
                style: TextStyle(
                  color: kSilverHalide,
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Sections: 0 anchors · 1 banner · 2 lifecycle · 3 gallery · '
                '4 resize · 5 equality · 6 table · 7 keys · 8 cheats · 9 sig',
                style: TextStyle(
                  color: kKodakYellow,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // Compose the document
  // -------------------------------------------------------------------
  print('--- composing root widget tree ---');

  final Widget root = Container(
    color: const Color(0xFFE3D8BD),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleBanner,
        kSectionTitle('0', 'Anchor instances (constructed, not resolved)',
            kSepiaDeep),
        kPanel(
          background: kIvoryPaper,
          border: kSepiaDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kKeyValue('AssetImage A',
                  '${assetA.assetName} (pkg=${assetA.package})'),
              kKeyValue('AssetImage B', assetB.assetName),
              kKeyValue('NetworkImage A', netA.url),
              kKeyValue('NetworkImage B',
                  '${netB.url} @${netB.scale}x'),
              kKeyValue('MemoryImage A',
                  'bytes=${memA.bytes.length}, scale=${memA.scale}'),
              kKeyValue('ExactAssetImage', '${exactA.assetName} @${exactA.scale}x'),
              kKeyValue('ResizeImage',
                  'wraps ${resizeA.imageProvider.runtimeType}'),
              kKeyValue('total providers', '${providers.length}'),
            ],
          ),
        ),
        kSectionTitle('1', 'Title — what this document is about', kKodakYellow),
        kPanel(
          background: kIvoryPaper,
          border: kSepiaDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kBullet('ImageProvider<T> is a *recipe*, not an image.'),
              kBullet('Each subclass declares how to derive a cache key.'),
              kBullet('The cache key controls deduplication in ImageCache.'),
              kBullet('We illustrate construction, equality, and hashing only.'),
            ],
          ),
        ),
        kSectionTitle('2', 'Anatomy — provider lifecycle', kCyanotype),
        lifecycleDiagram,
        kSectionTitle('3', 'Provider gallery — six representative cards',
            kMagentaProc),
        gallerySection,
        kSectionTitle('4', 'ResizeImage — fit vs exact', kCyanotype),
        resizeSection,
        kSectionTitle('5', 'Equality semantics', kMagentaProc),
        equalitySection,
        kSectionTitle('6', 'Provider comparison table', kSepiaDeep),
        comparisonSection,
        kSectionTitle('7', 'obtainKey — cache identity (concept only)',
            kCyanotype),
        keySection,
        kSectionTitle('8', 'Cheat-sheet — picking the right provider',
            kKodakYellow),
        cheatSection,
        kSectionTitle('9', 'Signature', kSafelightRed),
        signatureCard,
      ],
    ),
  );

  print('[image_providers_test] root composed; returning to renderer');
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #63, P2):
  // The composed document is ~5200 logical pixels tall and overflowed the
  // 800×600 test viewport by 4637 px on the bottom after the P12 fix above
  // resolved the unbounded-width error and let the tree finally lay out.
  // Wrap the root in Scaffold > SafeArea > SingleChildScrollView so the
  // long demo scrolls inside a bounded viewport. None of the inner Rows
  // use CrossAxisAlignment.stretch, so the now-unbounded vertical
  // constraint does not propagate to a stretch-Row (which would have
  // tripped a follow-up "BoxConstraints forces an infinite height").
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: root,
      ),
    ),
  );
}
