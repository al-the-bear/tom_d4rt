// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - Image Pipeline Atelier from widgets/Image
// Theme: "Image Pipeline Atelier" - a visual atelier touring the Image widget,
// BoxFit modes, Alignment, ImageRepeat, ColorBlendMode, FilterQuality,
// Image.memory with synthetic byte data, errorBuilder/loadingBuilder/frameBuilder
// previews, FadeInImage stages and DecorationImage compositions. Because the
// D4rt sandbox cannot fetch network or asset bytes, we use Containers and
// CustomPainters as stand-ins so reviewers can SEE what each property does to
// the layout and compositing of a bitmap source.

import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';

// =============================================================================
// PALETTE CONSTANTS - one signature palette per atelier room. The Image
// Pipeline Atelier leans into a warm sunset-on-cyan duotone for cohesion with
// dialed-in accents per section.
// =============================================================================

const Color _atelierDeep = Color(0xFF4A148C);
const Color _atelierMid = Color(0xFF7B1FA2);
const Color _atelierSoft = Color(0xFFE1BEE7);
const Color _atelierPale = Color(0xFFF3E5F5);

const Color _fitStart = Color(0xFFBF360C);
const Color _fitEnd = Color(0xFFFF7043);
const Color _fitSoft = Color(0xFFFFCCBC);

const Color _alignStart = Color(0xFF1B5E20);
const Color _alignEnd = Color(0xFF66BB6A);
const Color _alignSoft = Color(0xFFC8E6C9);

const Color _repeatStart = Color(0xFF0D47A1);
const Color _repeatEnd = Color(0xFF42A5F5);
const Color _repeatSoft = Color(0xFFBBDEFB);

const Color _blendStart = Color(0xFFAD1457);
const Color _blendEnd = Color(0xFFEC407A);
const Color _blendSoft = Color(0xFFF8BBD0);

const Color _qualityStart = Color(0xFF263238);
const Color _qualityEnd = Color(0xFF546E7A);
const Color _qualitySoft = Color(0xFFCFD8DC);

const Color _memoryStart = Color(0xFF006064);
const Color _memoryEnd = Color(0xFF26C6DA);
const Color _memorySoft = Color(0xFFB2EBF2);

const Color _errorStart = Color(0xFFB71C1C);
const Color _errorEnd = Color(0xFFEF5350);
const Color _errorSoft = Color(0xFFFFCDD2);

const Color _loadingStart = Color(0xFFE65100);
const Color _loadingEnd = Color(0xFFFFB74D);
const Color _loadingSoft = Color(0xFFFFE0B2);

const Color _frameStart = Color(0xFF4527A0);
const Color _frameEnd = Color(0xFF7E57C2);
const Color _frameSoft = Color(0xFFD1C4E9);

const Color _decoStart = Color(0xFF00695C);
const Color _decoEnd = Color(0xFF26A69A);
const Color _decoSoft = Color(0xFFB2DFDB);

const Color _fadeStart = Color(0xFF3E2723);
const Color _fadeEnd = Color(0xFF8D6E63);
const Color _fadeSoft = Color(0xFFD7CCC8);

// =============================================================================
// MAIN ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  print('[image_test] Image Pipeline Atelier launching...');

  // ===========================================================================
  // BOOTSTRAP: build a synthetic Uint8List that holds the bytes of a minimal
  // 1x1 transparent PNG. We use it later via Image.memory inside fallback
  // previews. The literal byte sequence below is the well-known smallest valid
  // PNG (89 50 4E 47 ...). It will decode if we ever push it through a real
  // ImageProvider but is mainly here to demonstrate the API shape.
  // ===========================================================================

  final Uint8List tinyPngBytes = Uint8List.fromList(<int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
    0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41,
    0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
    0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
    0x42, 0x60, 0x82,
  ]);
  final int tinyPngLength = tinyPngBytes.length;
  print('[image_test] synthetic PNG bytes prepared: $tinyPngLength bytes');

  // ===========================================================================
  // SECTION 0: PIPELINE NARRATIVE - the conceptual sequence behind every
  // displayed Image, from provider to compositing in the render tree.
  // ===========================================================================

  final List<Map<String, String>> pipelineSteps = <Map<String, String>>[
    <String, String>{
      'step': '1',
      'op': 'ImageProvider',
      'detail': 'Resolves a bytes source (network/asset/memory/file)',
    },
    <String, String>{
      'step': '2',
      'op': 'ImageStream',
      'detail': 'Connects listeners to decoding progress + frames',
    },
    <String, String>{
      'step': '3',
      'op': 'instantiateImageCodec',
      'detail': 'Decodes bytes into one or more ui.FrameInfo',
    },
    <String, String>{
      'step': '4',
      'op': 'frameBuilder',
      'detail': 'Optional hook to wrap each frame as it arrives',
    },
    <String, String>{
      'step': '5',
      'op': 'loadingBuilder',
      'detail': 'Placeholder while bytes are still streaming',
    },
    <String, String>{
      'step': '6',
      'op': 'errorBuilder',
      'detail': 'Fallback widget when decoding/loading fails',
    },
    <String, String>{
      'step': '7',
      'op': 'RawImage / RenderImage',
      'detail': 'Final paint via BoxFit, Alignment, ImageRepeat',
    },
  ];

  // ===========================================================================
  // SECTION 1: BoxFit ATLAS - the 9 BoxFit modes, each represented by a
  // canonical example painted via CustomPainter inside a fixed-size frame.
  // ===========================================================================

  final List<Map<String, dynamic>> boxFitAtlas = <Map<String, dynamic>>[
    <String, dynamic>{
      'fit': BoxFit.fill,
      'name': 'fill',
      'desc': 'Distort to exactly fill the frame',
      'sx': 1.0,
      'sy': 1.0,
      'crop': false,
    },
    <String, dynamic>{
      'fit': BoxFit.contain,
      'name': 'contain',
      'desc': 'Letterbox - preserve aspect ratio inside',
      'sx': 0.85,
      'sy': 0.85,
      'crop': false,
    },
    <String, dynamic>{
      'fit': BoxFit.cover,
      'name': 'cover',
      'desc': 'Crop - preserve aspect ratio outside',
      'sx': 1.2,
      'sy': 1.2,
      'crop': true,
    },
    <String, dynamic>{
      'fit': BoxFit.fitWidth,
      'name': 'fitWidth',
      'desc': 'Fill horizontally, let height overflow / shrink',
      'sx': 1.0,
      'sy': 0.7,
      'crop': false,
    },
    <String, dynamic>{
      'fit': BoxFit.fitHeight,
      'name': 'fitHeight',
      'desc': 'Fill vertically, let width overflow / shrink',
      'sx': 0.7,
      'sy': 1.0,
      'crop': false,
    },
    <String, dynamic>{
      'fit': BoxFit.none,
      'name': 'none',
      'desc': 'Original size, cropped to frame',
      'sx': 0.5,
      'sy': 0.5,
      'crop': false,
    },
    <String, dynamic>{
      'fit': BoxFit.scaleDown,
      'name': 'scaleDown',
      'desc': 'Like contain, but never larger than source',
      'sx': 0.45,
      'sy': 0.45,
      'crop': false,
    },
  ];

  // ===========================================================================
  // SECTION 2: ALIGNMENT GRID - the 9 named Alignment cells, plus a free-form
  // example. Each preview shows a small rectangle anchored to that alignment.
  // ===========================================================================

  final List<Map<String, dynamic>> alignmentGrid = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'topLeft',
      'alignment': Alignment.topLeft,
      'ax': -1.0,
      'ay': -1.0,
    },
    <String, dynamic>{
      'name': 'topCenter',
      'alignment': Alignment.topCenter,
      'ax': 0.0,
      'ay': -1.0,
    },
    <String, dynamic>{
      'name': 'topRight',
      'alignment': Alignment.topRight,
      'ax': 1.0,
      'ay': -1.0,
    },
    <String, dynamic>{
      'name': 'centerLeft',
      'alignment': Alignment.centerLeft,
      'ax': -1.0,
      'ay': 0.0,
    },
    <String, dynamic>{
      'name': 'center',
      'alignment': Alignment.center,
      'ax': 0.0,
      'ay': 0.0,
    },
    <String, dynamic>{
      'name': 'centerRight',
      'alignment': Alignment.centerRight,
      'ax': 1.0,
      'ay': 0.0,
    },
    <String, dynamic>{
      'name': 'bottomLeft',
      'alignment': Alignment.bottomLeft,
      'ax': -1.0,
      'ay': 1.0,
    },
    <String, dynamic>{
      'name': 'bottomCenter',
      'alignment': Alignment.bottomCenter,
      'ax': 0.0,
      'ay': 1.0,
    },
    <String, dynamic>{
      'name': 'bottomRight',
      'alignment': Alignment.bottomRight,
      'ax': 1.0,
      'ay': 1.0,
    },
    <String, dynamic>{
      'name': 'Alignment(0.5,-0.3)',
      'alignment': const Alignment(0.5, -0.3),
      'ax': 0.5,
      'ay': -0.3,
    },
  ];

  // ===========================================================================
  // SECTION 3: ImageRepeat PATTERNS - the 4 ImageRepeat modes plus tile-size
  // metadata to drive the synthetic tile painter.
  // ===========================================================================

  final List<Map<String, dynamic>> repeatModes = <Map<String, dynamic>>[
    <String, dynamic>{
      'mode': ImageRepeat.noRepeat,
      'name': 'noRepeat',
      'desc': 'Source painted once, no tiling',
      'tileX': 1,
      'tileY': 1,
    },
    <String, dynamic>{
      'mode': ImageRepeat.repeat,
      'name': 'repeat',
      'desc': 'Tile horizontally and vertically',
      'tileX': 4,
      'tileY': 3,
    },
    <String, dynamic>{
      'mode': ImageRepeat.repeatX,
      'name': 'repeatX',
      'desc': 'Tile only along the horizontal axis',
      'tileX': 4,
      'tileY': 1,
    },
    <String, dynamic>{
      'mode': ImageRepeat.repeatY,
      'name': 'repeatY',
      'desc': 'Tile only along the vertical axis',
      'tileX': 1,
      'tileY': 3,
    },
  ];

  // ===========================================================================
  // SECTION 4: ColorBlendMode STUDIO - sample of BlendMode values that are
  // commonly paired with Image.color. We display each as overlapping shapes.
  // ===========================================================================

  final List<Map<String, dynamic>> blendStudio = <Map<String, dynamic>>[
    <String, dynamic>{
      'mode': BlendMode.srcOver,
      'name': 'srcOver',
      'desc': 'Default - source over destination',
      'tint': Color(0xCC42A5F5),
    },
    <String, dynamic>{
      'mode': BlendMode.multiply,
      'name': 'multiply',
      'desc': 'Darken overlapping regions',
      'tint': Color(0xCCEC407A),
    },
    <String, dynamic>{
      'mode': BlendMode.screen,
      'name': 'screen',
      'desc': 'Brighten overlapping regions',
      'tint': Color(0xCC66BB6A),
    },
    <String, dynamic>{
      'mode': BlendMode.overlay,
      'name': 'overlay',
      'desc': 'Contrast-preserving blend',
      'tint': Color(0xCCFFB74D),
    },
    <String, dynamic>{
      'mode': BlendMode.modulate,
      'name': 'modulate',
      'desc': 'Component-wise multiply, no opacity',
      'tint': Color(0xFFAB47BC),
    },
    <String, dynamic>{
      'mode': BlendMode.difference,
      'name': 'difference',
      'desc': 'Invert overlap colors',
      'tint': Color(0xCC26A69A),
    },
  ];

  // ===========================================================================
  // SECTION 5: FilterQuality COMPARISON - the 4 levels, with a comment on how
  // they map to skia sampling. Each preview shows the same source painted at
  // slightly different fidelity (we mimic with painter parameters).
  // ===========================================================================

  final List<Map<String, dynamic>> filterQualityLevels = <Map<String, dynamic>>[
    <String, dynamic>{
      'level': FilterQuality.none,
      'name': 'none',
      'desc': 'Nearest neighbor (pixel art friendly)',
      'pixelStep': 14.0,
      'jitter': 0.0,
    },
    <String, dynamic>{
      'level': FilterQuality.low,
      'name': 'low',
      'desc': 'Bilinear filtering (fastest smoothing)',
      'pixelStep': 8.0,
      'jitter': 0.5,
    },
    <String, dynamic>{
      'level': FilterQuality.medium,
      'name': 'medium',
      'desc': 'Bilinear with mipmaps (downscaling)',
      'pixelStep': 4.0,
      'jitter': 0.25,
    },
    <String, dynamic>{
      'level': FilterQuality.high,
      'name': 'high',
      'desc': 'Bicubic sampling (highest quality)',
      'pixelStep': 2.0,
      'jitter': 0.1,
    },
  ];

  // ===========================================================================
  // SECTION 6: errorBuilder GALLERY - example fallback widgets rendered as if
  // the image had failed. We materialize each fallback exactly the way an
  // errorBuilder would return it.
  // ===========================================================================

  final List<Map<String, String>> errorFallbacks = <Map<String, String>>[
    <String, String>{
      'title': '404 - not found',
      'message': 'The server could not locate the requested asset.',
      'iconCode': 'image_not_supported',
    },
    <String, String>{
      'title': 'Decode failed',
      'message': 'Bytes were received but not a valid image codec.',
      'iconCode': 'broken_image',
    },
    <String, String>{
      'title': 'Timeout',
      'message': 'The image stream did not produce a frame in time.',
      'iconCode': 'hourglass_disabled',
    },
    <String, String>{
      'title': 'Offline',
      'message': 'No network. We will retry when connectivity returns.',
      'iconCode': 'wifi_off',
    },
  ];

  // ===========================================================================
  // SECTION 7: loadingBuilder INDICATORS - sample placeholders shown while
  // bytes are streaming in. Each fragment is the exact shape a loadingBuilder
  // would emit.
  // ===========================================================================

  final List<Map<String, dynamic>> loadingFragments = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Linear progress',
      'progress': 0.18,
      'kind': 'linear',
    },
    <String, dynamic>{
      'title': 'Mid-way bar',
      'progress': 0.55,
      'kind': 'linear',
    },
    <String, dynamic>{
      'title': 'Almost done',
      'progress': 0.92,
      'kind': 'linear',
    },
    <String, dynamic>{
      'title': 'Indeterminate ring',
      'progress': -1.0,
      'kind': 'spinner',
    },
    <String, dynamic>{
      'title': 'Pulsing skeleton',
      'progress': -1.0,
      'kind': 'skeleton',
    },
  ];

  // ===========================================================================
  // SECTION 8: frameBuilder STAGES - the conceptual states a frameBuilder
  // walks through. We render each as a still snapshot of "what it would show".
  // ===========================================================================

  final List<Map<String, dynamic>> frameBuilderStages = <Map<String, dynamic>>[
    <String, dynamic>{
      'stage': '0',
      'title': 'wasSynchronouslyLoaded == false, frame == null',
      'desc': 'Decoding has not yet emitted any frame',
      'opacity': 0.0,
    },
    <String, dynamic>{
      'stage': '1',
      'title': 'frame == 0 (first frame just arrived)',
      'desc': 'Cross-fade should begin from the placeholder',
      'opacity': 0.3,
    },
    <String, dynamic>{
      'stage': '2',
      'title': 'frame == 1',
      'desc': 'Continuing animation if multi-frame source',
      'opacity': 0.6,
    },
    <String, dynamic>{
      'stage': '3',
      'title': 'frame == n (steady state)',
      'desc': 'Final composited frame visible at full opacity',
      'opacity': 1.0,
    },
    <String, dynamic>{
      'stage': 'S',
      'title': 'wasSynchronouslyLoaded == true',
      'desc': 'Bytes were available immediately - no animation',
      'opacity': 1.0,
    },
  ];

  // ===========================================================================
  // SECTION 9: DecorationImage COMPOSITIONS - typical DecorationImage configs
  // baked into BoxDecoration so reviewers can read the property salad.
  // ===========================================================================

  final List<Map<String, dynamic>> decorationCompositions =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Cover - banner hero',
      'fit': BoxFit.cover,
      'fitName': 'cover',
      'alignment': Alignment.center,
      'alignName': 'center',
      'repeat': ImageRepeat.noRepeat,
      'repeatName': 'noRepeat',
      'colorBlendMode': BlendMode.darken,
      'blendName': 'darken',
      'opacity': 0.85,
      'gradient': const <Color>[Color(0xFF26A69A), Color(0xFF004D40)],
    },
    <String, dynamic>{
      'title': 'Contain - product shot',
      'fit': BoxFit.contain,
      'fitName': 'contain',
      'alignment': Alignment.center,
      'alignName': 'center',
      'repeat': ImageRepeat.noRepeat,
      'repeatName': 'noRepeat',
      'colorBlendMode': BlendMode.srcOver,
      'blendName': 'srcOver',
      'opacity': 1.0,
      'gradient': const <Color>[Color(0xFFFFAB91), Color(0xFFBF360C)],
    },
    <String, dynamic>{
      'title': 'Tiled - wallpaper',
      'fit': BoxFit.none,
      'fitName': 'none',
      'alignment': Alignment.topLeft,
      'alignName': 'topLeft',
      'repeat': ImageRepeat.repeat,
      'repeatName': 'repeat',
      'colorBlendMode': BlendMode.srcOver,
      'blendName': 'srcOver',
      'opacity': 0.95,
      'gradient': const <Color>[Color(0xFFB39DDB), Color(0xFF4527A0)],
    },
    <String, dynamic>{
      'title': 'Cover + multiply tint',
      'fit': BoxFit.cover,
      'fitName': 'cover',
      'alignment': Alignment.bottomCenter,
      'alignName': 'bottomCenter',
      'repeat': ImageRepeat.noRepeat,
      'repeatName': 'noRepeat',
      'colorBlendMode': BlendMode.multiply,
      'blendName': 'multiply',
      'opacity': 0.9,
      'gradient': const <Color>[Color(0xFFFFCC80), Color(0xFFE65100)],
    },
  ];

  // ===========================================================================
  // SECTION 10: FadeInImage PHASES - the four canonical stages of a
  // FadeInImage cross-fade: placeholder shown, placeholder fading out, target
  // fading in, target fully visible.
  // ===========================================================================

  final List<Map<String, dynamic>> fadeInPhases = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Phase 0',
      'placeholderOpacity': 1.0,
      'imageOpacity': 0.0,
      'note': 'Placeholder shown, target not yet decoded',
    },
    <String, dynamic>{
      'name': 'Phase 1',
      'placeholderOpacity': 0.75,
      'imageOpacity': 0.25,
      'note': 'Target arrives, fade begins (fadeInDuration)',
    },
    <String, dynamic>{
      'name': 'Phase 2',
      'placeholderOpacity': 0.40,
      'imageOpacity': 0.60,
      'note': 'Cross-fade midpoint',
    },
    <String, dynamic>{
      'name': 'Phase 3',
      'placeholderOpacity': 0.10,
      'imageOpacity': 0.90,
      'note': 'Placeholder almost gone',
    },
    <String, dynamic>{
      'name': 'Phase 4',
      'placeholderOpacity': 0.0,
      'imageOpacity': 1.0,
      'note': 'Steady state - only target visible',
    },
  ];

  // ===========================================================================
  // SECTION 11: Image.memory RECIPE - we walk through the call signature of
  // Image.memory(bytes, ...) and pair it with a stand-in preview using our
  // synthetic PNG bytes encoded above.
  // ===========================================================================

  final List<Map<String, String>> memoryRecipe = <Map<String, String>>[
    <String, String>{
      'arg': 'bytes',
      'type': 'Uint8List',
      'note': 'The decoded image bytes (PNG/JPEG/WEBP/etc)',
    },
    <String, String>{
      'arg': 'scale',
      'type': 'double',
      'note': 'Logical-to-physical ratio (defaults to 1.0)',
    },
    <String, String>{
      'arg': 'fit',
      'type': 'BoxFit?',
      'note': 'How to size into the layout slot',
    },
    <String, String>{
      'arg': 'alignment',
      'type': 'AlignmentGeometry',
      'note': 'Anchor when fit leaves empty space',
    },
    <String, String>{
      'arg': 'repeat',
      'type': 'ImageRepeat',
      'note': 'Tile mode when image is smaller than slot',
    },
    <String, String>{
      'arg': 'color',
      'type': 'Color?',
      'note': 'Tint to mix with the image via colorBlendMode',
    },
    <String, String>{
      'arg': 'colorBlendMode',
      'type': 'BlendMode?',
      'note': 'Compositing rule used with color',
    },
    <String, String>{
      'arg': 'filterQuality',
      'type': 'FilterQuality',
      'note': 'Sampling fidelity when scaling',
    },
    <String, String>{
      'arg': 'gaplessPlayback',
      'type': 'bool',
      'note': 'Reuse previous frame while a new one decodes',
    },
    <String, String>{
      'arg': 'frameBuilder',
      'type': 'ImageFrameBuilder?',
      'note': 'Wrap each frame as it arrives',
    },
    <String, String>{
      'arg': 'errorBuilder',
      'type': 'ImageErrorWidgetBuilder?',
      'note': 'Fallback when decoding fails',
    },
  ];

  // ===========================================================================
  // SECTION 12: ENUM ROSTERS - inventory BoxFit, ImageRepeat, FilterQuality
  // and selected BlendModes so the runtime confirms each value is bridged.
  // ===========================================================================

  final List<Map<String, dynamic>> boxFitRoster = <Map<String, dynamic>>[];
  for (final BoxFit fit in BoxFit.values) {
    boxFitRoster.add(<String, dynamic>{
      'name': fit.name,
      'index': fit.index,
    });
  }

  final List<Map<String, dynamic>> repeatRoster = <Map<String, dynamic>>[];
  for (final ImageRepeat rep in ImageRepeat.values) {
    repeatRoster.add(<String, dynamic>{
      'name': rep.name,
      'index': rep.index,
    });
  }

  final List<Map<String, dynamic>> filterRoster = <Map<String, dynamic>>[];
  for (final FilterQuality q in FilterQuality.values) {
    filterRoster.add(<String, dynamic>{
      'name': q.name,
      'index': q.index,
    });
  }

  final List<Map<String, dynamic>> blendRoster = <Map<String, dynamic>>[
    <String, dynamic>{'name': 'srcOver', 'use': 'default compositing'},
    <String, dynamic>{'name': 'multiply', 'use': 'darken overlap'},
    <String, dynamic>{'name': 'screen', 'use': 'brighten overlap'},
    <String, dynamic>{'name': 'overlay', 'use': 'contrast-preserving'},
    <String, dynamic>{'name': 'modulate', 'use': 'component multiply'},
    <String, dynamic>{'name': 'difference', 'use': 'invert overlap'},
    <String, dynamic>{'name': 'darken', 'use': 'pick darker channel'},
    <String, dynamic>{'name': 'lighten', 'use': 'pick brighter channel'},
    <String, dynamic>{'name': 'colorBurn', 'use': 'crush highlights'},
    <String, dynamic>{'name': 'colorDodge', 'use': 'lift shadows'},
  ];

  // ===========================================================================
  // SECTION 13: RECIPE CARDS - hand-rolled how-to snippets that map our visual
  // demos back to concrete Flutter constructor calls.
  // ===========================================================================

  final List<Map<String, String>> recipes = <Map<String, String>>[
    <String, String>{
      'title': 'Recipe: Image.network with full safety net',
      'body':
          'Image.network(url, fit: BoxFit.cover, alignment: Alignment.center, '
              'loadingBuilder: (c, w, p) => p == null ? w : Spinner(), '
              'errorBuilder: (c, e, s) => ErrorTile(error: e));',
    },
    <String, String>{
      'title': 'Recipe: Image.memory from cached bytes',
      'body':
          'final bytes = await rootBundle.load(path); '
              'Image.memory(bytes.buffer.asUint8List(), fit: BoxFit.contain);',
    },
    <String, String>{
      'title': 'Recipe: tinted icon-like image',
      'body':
          'Image.asset(path, color: brand, colorBlendMode: BlendMode.modulate, '
              'fit: BoxFit.contain, filterQuality: FilterQuality.high);',
    },
    <String, String>{
      'title': 'Recipe: pixel-art friendly scaling',
      'body':
          'Image.asset(path, fit: BoxFit.fill, '
              'filterQuality: FilterQuality.none); // nearest neighbor',
    },
    <String, String>{
      'title': 'Recipe: tiled background',
      'body':
          'Container(decoration: BoxDecoration(image: DecorationImage('
              'image: AssetImage(path), repeat: ImageRepeat.repeat)));',
    },
    <String, String>{
      'title': 'Recipe: FadeInImage with low-resolution placeholder',
      'body':
          'FadeInImage.memoryNetwork(placeholder: kTransparentImage, '
              'image: url, fit: BoxFit.cover, fadeInDuration: '
              'Duration(milliseconds: 350));',
    },
  ];

  // ===========================================================================
  // SECTION 14: GLOSSARY ROWS - canonical definitions for the Image widget
  // family used throughout this atelier.
  // ===========================================================================

  final List<Map<String, String>> glossary = <Map<String, String>>[
    <String, String>{
      'term': 'Image',
      'definition':
          'A widget that displays an image resolved by an ImageProvider.',
    },
    <String, String>{
      'term': 'ImageProvider',
      'definition':
          'Abstract source of bytes: NetworkImage, AssetImage, MemoryImage, '
              'FileImage. Decoupled from the widget.',
    },
    <String, String>{
      'term': 'BoxFit',
      'definition':
          'Enum that decides how the bitmap is scaled into its layout slot.',
    },
    <String, String>{
      'term': 'ImageRepeat',
      'definition':
          'Enum controlling tiling when the bitmap is smaller than the slot.',
    },
    <String, String>{
      'term': 'ColorBlendMode',
      'definition':
          'BlendMode used together with Image.color to tint pixels.',
    },
    <String, String>{
      'term': 'FilterQuality',
      'definition':
          'Sampling fidelity when scaling the bitmap during rasterization.',
    },
    <String, String>{
      'term': 'frameBuilder',
      'definition':
          'Optional hook to wrap each decoded frame in a widget.',
    },
    <String, String>{
      'term': 'loadingBuilder',
      'definition':
          'Placeholder widget shown while bytes are being fetched/decoded.',
    },
    <String, String>{
      'term': 'errorBuilder',
      'definition':
          'Fallback widget shown when the provider or decoder fails.',
    },
    <String, String>{
      'term': 'DecorationImage',
      'definition':
          'Configuration record used inside BoxDecoration.image.',
    },
    <String, String>{
      'term': 'FadeInImage',
      'definition':
          'Convenience widget that cross-fades a placeholder into a target.',
    },
  ];

  print('[image_test] sections built - rendering atelier...');

  // ===========================================================================
  // RETURN A MaterialApp WITH THE FULL VISUAL ATLAS
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _atelierPale,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _heroHeader(),
            const SizedBox(height: 20.0),
            _conceptOverview(),
            const SizedBox(height: 20.0),
            _pipelineNarrative(pipelineSteps, tinyPngLength),
            const SizedBox(height: 20.0),
            _section1BoxFit(boxFitAtlas),
            const SizedBox(height: 20.0),
            _section2Alignment(alignmentGrid),
            const SizedBox(height: 20.0),
            _section3Repeat(repeatModes),
            const SizedBox(height: 20.0),
            _section4Blend(blendStudio),
            const SizedBox(height: 20.0),
            _section5FilterQuality(filterQualityLevels),
            const SizedBox(height: 20.0),
            _section6ErrorBuilder(errorFallbacks),
            const SizedBox(height: 20.0),
            _section7LoadingBuilder(loadingFragments),
            const SizedBox(height: 20.0),
            _section8FrameBuilder(frameBuilderStages),
            const SizedBox(height: 20.0),
            _section9DecorationImage(decorationCompositions),
            const SizedBox(height: 20.0),
            _section10FadeIn(fadeInPhases),
            const SizedBox(height: 20.0),
            _section11ImageMemory(memoryRecipe, tinyPngLength),
            const SizedBox(height: 20.0),
            _section12Enums(boxFitRoster, repeatRoster, filterRoster,
                blendRoster),
            const SizedBox(height: 20.0),
            _section13Recipes(recipes),
            const SizedBox(height: 20.0),
            _section14Glossary(glossary),
            const SizedBox(height: 20.0),
            _epilogue(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// HERO HEADER
// =============================================================================

Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_atelierDeep, _atelierMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Image Pipeline Atelier',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A guided tour through Flutter\'s Image widget: providers, BoxFit, '
          'Alignment, ImageRepeat, ColorBlendMode, FilterQuality, '
          'errorBuilder, loadingBuilder, frameBuilder and FadeInImage.',
          style: TextStyle(fontSize: 14.0, color: _atelierSoft),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroChip('Image'),
            _heroChip('BoxFit'),
            _heroChip('Alignment'),
            _heroChip('ImageRepeat'),
            _heroChip('BlendMode'),
            _heroChip('FilterQuality'),
            _heroChip('errorBuilder'),
            _heroChip('loadingBuilder'),
            _heroChip('frameBuilder'),
            _heroChip('FadeInImage'),
            _heroChip('DecorationImage'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 12.0, color: Colors.white),
    ),
  );
}

// =============================================================================
// CONCEPT OVERVIEW
// =============================================================================

Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _atelierSoft, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _atelierMid,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.image, color: Colors.white, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: _atelierDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'The Image widget is a thin presenter on top of an ImageProvider. '
          'The provider resolves bytes, a codec decodes them into one or more '
          'frames, and Image paints those frames into the layout slot using '
          'BoxFit, Alignment and ImageRepeat. Callback hooks — errorBuilder, '
          'loadingBuilder and frameBuilder — let you customise every stage.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Atelier rooms:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 6.0),
        _bulletText('Pipeline narrative - provider/stream/codec/painter'),
        _bulletText('BoxFit atlas - all 7 fit modes side by side'),
        _bulletText('Alignment grid - 9 named cells plus a free-form anchor'),
        _bulletText('ImageRepeat patterns - none / repeat / repeatX / repeatY'),
        _bulletText('ColorBlendMode studio - tinting & overlap effects'),
        _bulletText('FilterQuality comparison - sampling fidelity'),
        _bulletText('errorBuilder gallery - fallback widgets in situ'),
        _bulletText('loadingBuilder indicators - progress patterns'),
        _bulletText('frameBuilder stages - the 5 conceptual frames'),
        _bulletText('DecorationImage compositions - the property salad'),
        _bulletText('FadeInImage phases - the cross-fade in 5 snapshots'),
        _bulletText('Image.memory recipe - the constructor argument tour'),
        _bulletText('Enums, recipes, glossary, epilogue'),
      ],
    ),
  );
}

Widget _bulletText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('  - ', style: TextStyle(fontSize: 13.0)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13.0))),
      ],
    ),
  );
}

// =============================================================================
// PIPELINE NARRATIVE (numbered section 0)
// =============================================================================

Widget _pipelineNarrative(
  List<Map<String, String>> steps,
  int tinyPngLength,
) {
  return _benchCard(
    headerColorStart: _atelierDeep,
    headerColorEnd: _atelierMid,
    softColor: _atelierPale,
    accentColor: _atelierSoft,
    sectionNumber: '0',
    title: 'Image rendering pipeline',
    subtitle: 'From provider bytes to a painted frame',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final Map<String, String> step in steps)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 26.0,
                  height: 26.0,
                  decoration: BoxDecoration(
                    color: _atelierMid,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Center(
                    child: Text(
                      step['step']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        step['op']!,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: _atelierDeep,
                        ),
                      ),
                      Text(
                        step['detail']!,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['key', 'value'],
          headerColor: _atelierMid,
          rowColor: _atelierPale,
          rows: <List<String>>[
            <String>['Synthetic PNG bytes', '$tinyPngLength'],
            <String>['Codec target', 'instantiateImageCodec'],
            <String>['Provider candidates', 'Network / Asset / Memory / File'],
            <String>['Builders', 'frame / loading / error'],
            <String>['Output surface', 'RawImage -> RenderImage'],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: end-to-end Image.network',
    recipeBody:
        'Image.network(url, fit: BoxFit.cover, loadingBuilder: ..., '
            'errorBuilder: ..., frameBuilder: ...);',
  );
}

// =============================================================================
// SECTION 1: BoxFit ATLAS
// =============================================================================

Widget _section1BoxFit(List<Map<String, dynamic>> atlas) {
  return _benchCard(
    headerColorStart: _fitStart,
    headerColorEnd: _fitEnd,
    softColor: _fitSoft,
    accentColor: _fitEnd,
    sectionNumber: '1',
    title: 'BoxFit atlas',
    subtitle: 'fill / contain / cover / fitWidth / fitHeight / none / scaleDown',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in atlas)
              _boxFitTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['fit', 'description', 'crop'],
          headerColor: _fitStart,
          rowColor: _fitSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in atlas)
              <String>[
                entry['name'] as String,
                entry['desc'] as String,
                '${entry['crop']}',
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: hero card',
    recipeBody:
        'Image.network(url, fit: BoxFit.cover, alignment: Alignment.center); '
            '// crops + centers, never distorts',
  );
}

Widget _boxFitTile(Map<String, dynamic> entry) {
  return Container(
    width: 150.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _fitSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 150.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
            child: CustomPaint(
              painter: _BoxFitPainter(
                sx: entry['sx'] as double,
                sy: entry['sy'] as double,
                crop: entry['crop'] as bool,
              ),
              size: Size.infinite,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'BoxFit.${entry['name']}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: _fitStart,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                entry['desc'] as String,
                style: const TextStyle(fontSize: 10.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2: ALIGNMENT GRID
// =============================================================================

Widget _section2Alignment(List<Map<String, dynamic>> cells) {
  return _benchCard(
    headerColorStart: _alignStart,
    headerColorEnd: _alignEnd,
    softColor: _alignSoft,
    accentColor: _alignEnd,
    sectionNumber: '2',
    title: 'Alignment grid',
    subtitle: 'How Alignment anchors a smaller image inside its slot',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in cells)
              _alignmentTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['name', 'ax', 'ay'],
          headerColor: _alignStart,
          rowColor: _alignSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in cells)
              <String>[
                entry['name'] as String,
                (entry['ax'] as double).toStringAsFixed(2),
                (entry['ay'] as double).toStringAsFixed(2),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: stage left poster',
    recipeBody:
        'Image.asset(path, alignment: Alignment.centerLeft, fit: BoxFit.none); '
            '// useful for hero illustrations',
  );
}

Widget _alignmentTile(Map<String, dynamic> entry) {
  return Container(
    width: 120.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _alignSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 120.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: CustomPaint(
            painter: _AlignmentPainter(
              ax: entry['ax'] as double,
              ay: entry['ay'] as double,
            ),
            size: Size.infinite,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 8.0),
          child: Text(
            entry['name'] as String,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: _alignStart,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3: IMAGE REPEAT
// =============================================================================

Widget _section3Repeat(List<Map<String, dynamic>> modes) {
  return _benchCard(
    headerColorStart: _repeatStart,
    headerColorEnd: _repeatEnd,
    softColor: _repeatSoft,
    accentColor: _repeatEnd,
    sectionNumber: '3',
    title: 'ImageRepeat patterns',
    subtitle: 'Tile in both axes, one axis, or not at all',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in modes)
              _repeatTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['mode', 'description', 'tile X/Y'],
          headerColor: _repeatStart,
          rowColor: _repeatSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in modes)
              <String>[
                entry['name'] as String,
                entry['desc'] as String,
                '${entry['tileX']} / ${entry['tileY']}',
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: wallpaper background',
    recipeBody:
        'Container(decoration: BoxDecoration(image: DecorationImage('
            'image: AssetImage(path), repeat: ImageRepeat.repeat)));',
  );
}

Widget _repeatTile(Map<String, dynamic> entry) {
  return Container(
    width: 170.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _repeatSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 170.0,
          height: 110.0,
          decoration: const BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
            child: CustomPaint(
              painter: _RepeatPainter(
                tileX: entry['tileX'] as int,
                tileY: entry['tileY'] as int,
              ),
              size: Size.infinite,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ImageRepeat.${entry['name']}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: _repeatStart,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                entry['desc'] as String,
                style: const TextStyle(fontSize: 10.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4: COLOR BLEND MODE STUDIO
// =============================================================================

Widget _section4Blend(List<Map<String, dynamic>> studio) {
  return _benchCard(
    headerColorStart: _blendStart,
    headerColorEnd: _blendEnd,
    softColor: _blendSoft,
    accentColor: _blendEnd,
    sectionNumber: '4',
    title: 'ColorBlendMode studio',
    subtitle: 'Six representative blend modes for Image.color tinting',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in studio)
              _blendTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['mode', 'description', 'tint'],
          headerColor: _blendStart,
          rowColor: _blendSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in studio)
              <String>[
                entry['name'] as String,
                entry['desc'] as String,
                _formatColor(entry['tint'] as Color),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: branded icon',
    recipeBody:
        'Image.asset(iconPath, color: brand, colorBlendMode: BlendMode.modulate);',
  );
}

Widget _blendTile(Map<String, dynamic> entry) {
  return Container(
    width: 160.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _blendSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 160.0,
          height: 100.0,
          decoration: const BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
            child: CustomPaint(
              painter: _BlendPainter(
                tint: entry['tint'] as Color,
                mode: entry['mode'] as BlendMode,
              ),
              size: Size.infinite,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'BlendMode.${entry['name']}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: _blendStart,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                entry['desc'] as String,
                style: const TextStyle(fontSize: 10.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5: FILTER QUALITY
// =============================================================================

Widget _section5FilterQuality(List<Map<String, dynamic>> levels) {
  return _benchCard(
    headerColorStart: _qualityStart,
    headerColorEnd: _qualityEnd,
    softColor: _qualitySoft,
    accentColor: _qualityEnd,
    sectionNumber: '5',
    title: 'FilterQuality comparison',
    subtitle: 'Nearest vs bilinear vs mipmapped vs bicubic',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in levels)
              _filterTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['level', 'description', 'pixel step'],
          headerColor: _qualityStart,
          rowColor: _qualitySoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in levels)
              <String>[
                entry['name'] as String,
                entry['desc'] as String,
                (entry['pixelStep'] as double).toStringAsFixed(1),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: pixel art preservation',
    recipeBody:
        'Image.asset(pixelArt, filterQuality: FilterQuality.none, '
            'fit: BoxFit.fill); // do NOT smooth',
  );
}

Widget _filterTile(Map<String, dynamic> entry) {
  return Container(
    width: 160.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _qualitySoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 160.0,
          height: 100.0,
          decoration: const BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
            child: CustomPaint(
              painter: _FilterQualityPainter(
                pixelStep: entry['pixelStep'] as double,
                jitter: entry['jitter'] as double,
              ),
              size: Size.infinite,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'FilterQuality.${entry['name']}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: _qualityStart,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                entry['desc'] as String,
                style: const TextStyle(fontSize: 10.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6: ERROR BUILDER GALLERY
// =============================================================================

Widget _section6ErrorBuilder(List<Map<String, String>> fallbacks) {
  return _benchCard(
    headerColorStart: _errorStart,
    headerColorEnd: _errorEnd,
    softColor: _errorSoft,
    accentColor: _errorEnd,
    sectionNumber: '6',
    title: 'errorBuilder gallery',
    subtitle: 'Fallbacks that an errorBuilder might return',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, String> entry in fallbacks)
              _errorTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['title', 'icon hint'],
          headerColor: _errorStart,
          rowColor: _errorSoft,
          rows: <List<String>>[
            for (final Map<String, String> entry in fallbacks)
              <String>[entry['title']!, entry['iconCode']!],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: friendly fallback',
    recipeBody:
        'errorBuilder: (ctx, error, stack) => ErrorTile(title: \'Failed\', '
            'message: error.toString());',
  );
}

Widget _errorTile(Map<String, String> entry) {
  final IconData icon = _resolveErrorIcon(entry['iconCode']!);
  return Container(
    width: 180.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _errorSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 70.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _errorEnd, width: 1.0),
          ),
          child: Center(
            child: Icon(icon, size: 32.0, color: _errorStart),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          entry['title']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.5,
            color: _errorStart,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          entry['message']!,
          style: const TextStyle(fontSize: 10.5, height: 1.3),
        ),
      ],
    ),
  );
}

IconData _resolveErrorIcon(String code) {
  switch (code) {
    case 'image_not_supported':
      return Icons.image_not_supported;
    case 'broken_image':
      return Icons.broken_image;
    case 'hourglass_disabled':
      return Icons.hourglass_disabled;
    case 'wifi_off':
      return Icons.wifi_off;
    default:
      return Icons.error_outline;
  }
}

// =============================================================================
// SECTION 7: LOADING BUILDER INDICATORS
// =============================================================================

Widget _section7LoadingBuilder(List<Map<String, dynamic>> fragments) {
  return _benchCard(
    headerColorStart: _loadingStart,
    headerColorEnd: _loadingEnd,
    softColor: _loadingSoft,
    accentColor: _loadingEnd,
    sectionNumber: '7',
    title: 'loadingBuilder indicators',
    subtitle: 'Placeholders shown while bytes stream in',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final Map<String, dynamic> entry in fragments)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _loadingTile(entry),
          ),
        const SizedBox(height: 4.0),
        _comparisonTable(
          columns: const <String>['title', 'kind', 'progress'],
          headerColor: _loadingStart,
          rowColor: _loadingSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in fragments)
              <String>[
                entry['title'] as String,
                entry['kind'] as String,
                (entry['progress'] as double) < 0.0
                    ? 'indeterminate'
                    : (entry['progress'] as double).toStringAsFixed(2),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: progress-aware placeholder',
    recipeBody:
        'loadingBuilder: (ctx, child, progress) => progress == null ? child : '
            'LinearProgressIndicator(value: progress.cumulativeBytesLoaded / '
            'progress.expectedTotalBytes!);',
  );
}

Widget _loadingTile(Map<String, dynamic> entry) {
  final String kind = entry['kind'] as String;
  final double progress = entry['progress'] as double;
  Widget indicator;
  switch (kind) {
    case 'linear':
      indicator = _linearProgress(progress);
      break;
    case 'spinner':
      indicator = _spinnerStill();
      break;
    case 'skeleton':
      indicator = _skeletonShimmer();
      break;
    default:
      indicator = const SizedBox.shrink();
  }
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _loadingSoft, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(width: 220.0, child: indicator),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            entry['title'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: _loadingStart,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _linearProgress(double value) {
  return Stack(
    children: <Widget>[
      Container(
        height: 14.0,
        decoration: BoxDecoration(
          color: _loadingSoft,
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      FractionallySizedBox(
        widthFactor: value.clamp(0.0, 1.0),
        child: Container(
          height: 14.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_loadingStart, _loadingEnd],
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    ],
  );
}

Widget _spinnerStill() {
  return SizedBox(
    height: 50.0,
    child: Center(
      child: SizedBox(
        width: 30.0,
        height: 30.0,
        child: CustomPaint(painter: _SpinnerPainter()),
      ),
    ),
  );
}

Widget _skeletonShimmer() {
  return Container(
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      gradient: const LinearGradient(
        colors: <Color>[_loadingSoft, _loadingEnd, _loadingSoft],
        stops: <double>[0.1, 0.5, 0.9],
      ),
    ),
  );
}

// =============================================================================
// SECTION 8: FRAME BUILDER STAGES
// =============================================================================

Widget _section8FrameBuilder(List<Map<String, dynamic>> stages) {
  return _benchCard(
    headerColorStart: _frameStart,
    headerColorEnd: _frameEnd,
    softColor: _frameSoft,
    accentColor: _frameEnd,
    sectionNumber: '8',
    title: 'frameBuilder stages',
    subtitle: 'How a frameBuilder sees the image arrive',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in stages)
              _frameStageTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['stage', 'state', 'opacity'],
          headerColor: _frameStart,
          rowColor: _frameSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in stages)
              <String>[
                entry['stage'] as String,
                entry['title'] as String,
                (entry['opacity'] as double).toStringAsFixed(2),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: custom fade-in',
    recipeBody:
        'frameBuilder: (ctx, child, frame, sync) => AnimatedOpacity(opacity: '
            'frame == null && !sync ? 0.0 : 1.0, duration: dur, child: child);',
  );
}

Widget _frameStageTile(Map<String, dynamic> entry) {
  final double opacity = entry['opacity'] as double;
  return Container(
    width: 200.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _frameSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CustomPaint(
                    painter: _FrameStagePainter(opacity: opacity),
                    size: Size.infinite,
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xCC4527A0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'frame ${entry['stage']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          entry['title'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            color: _frameStart,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          entry['desc'] as String,
          style: const TextStyle(fontSize: 10.5, height: 1.3),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9: DECORATION IMAGE COMPOSITIONS
// =============================================================================

Widget _section9DecorationImage(List<Map<String, dynamic>> comps) {
  return _benchCard(
    headerColorStart: _decoStart,
    headerColorEnd: _decoEnd,
    softColor: _decoSoft,
    accentColor: _decoEnd,
    sectionNumber: '9',
    title: 'DecorationImage compositions',
    subtitle: 'The property salad inside BoxDecoration.image',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in comps)
              _decorationTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['title', 'fit', 'align', 'blend'],
          headerColor: _decoStart,
          rowColor: _decoSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in comps)
              <String>[
                entry['title'] as String,
                entry['fitName'] as String,
                entry['alignName'] as String,
                entry['blendName'] as String,
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: hero banner background',
    recipeBody:
        'BoxDecoration(image: DecorationImage(image: NetworkImage(url), '
            'fit: BoxFit.cover, colorFilter: ColorFilter.mode('
            'Colors.black54, BlendMode.darken)));',
  );
}

Widget _decorationTile(Map<String, dynamic> entry) {
  final List<Color> grad = entry['gradient'] as List<Color>;
  final double opacity = entry['opacity'] as double;
  return Container(
    width: 200.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _decoSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              colors: grad,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Opacity(
            opacity: opacity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CustomPaint(
                painter: _DecorationPainter(
                  fit: entry['fitName'] as String,
                  align: entry['alignName'] as String,
                  repeat: entry['repeatName'] as String,
                ),
                size: Size.infinite,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          entry['title'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: _decoStart,
          ),
        ),
        const SizedBox(height: 4.0),
        _decoBadge('fit: ${entry['fitName']}'),
        _decoBadge('align: ${entry['alignName']}'),
        _decoBadge('repeat: ${entry['repeatName']}'),
        _decoBadge('blend: ${entry['blendName']}'),
        _decoBadge('opacity: ${opacity.toStringAsFixed(2)}'),
      ],
    ),
  );
}

Widget _decoBadge(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 2.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: _decoSoft,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10.0,
          fontFamily: 'monospace',
          color: _decoStart,
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 10: FADE IN IMAGE PHASES
// =============================================================================

Widget _section10FadeIn(List<Map<String, dynamic>> phases) {
  return _benchCard(
    headerColorStart: _fadeStart,
    headerColorEnd: _fadeEnd,
    softColor: _fadeSoft,
    accentColor: _fadeEnd,
    sectionNumber: '10',
    title: 'FadeInImage phases',
    subtitle: 'Five snapshots of a placeholder-to-target cross-fade',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in phases)
              _fadePhaseTile(entry),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['phase', 'placeholder', 'target'],
          headerColor: _fadeStart,
          rowColor: _fadeSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> entry in phases)
              <String>[
                entry['name'] as String,
                (entry['placeholderOpacity'] as double).toStringAsFixed(2),
                (entry['imageOpacity'] as double).toStringAsFixed(2),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: smooth target reveal',
    recipeBody:
        'FadeInImage(placeholder: AssetImage(low), image: NetworkImage(hi), '
            'fadeInDuration: Duration(milliseconds: 350), '
            'fadeOutDuration: Duration(milliseconds: 200));',
  );
}

Widget _fadePhaseTile(Map<String, dynamic> entry) {
  final double pOp = entry['placeholderOpacity'] as double;
  final double iOp = entry['imageOpacity'] as double;
  return Container(
    width: 160.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _fadeSoft, width: 1.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 90.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Opacity(
                  opacity: pOp,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _fadeSoft,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Icon(Icons.blur_on,
                          color: _fadeStart, size: 28.0),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: iOp,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[_fadeStart, _fadeEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Icon(Icons.landscape,
                          color: Colors.white, size: 30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          entry['name'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: _fadeStart,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          entry['note'] as String,
          style: const TextStyle(fontSize: 10.5, height: 1.3),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11: IMAGE.MEMORY RECIPE
// =============================================================================

Widget _section11ImageMemory(
  List<Map<String, String>> recipe,
  int tinyPngLength,
) {
  return _benchCard(
    headerColorStart: _memoryStart,
    headerColorEnd: _memoryEnd,
    softColor: _memorySoft,
    accentColor: _memoryEnd,
    sectionNumber: '11',
    title: 'Image.memory recipe',
    subtitle: 'Constructor arguments and a synthetic bytes preview',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _memoryEnd, width: 1.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: CustomPaint(
                  painter: _MemoryPreviewPainter(),
                  size: Size.infinite,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Image.memory(bytes, ...)',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: _memoryStart,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'Synthetic PNG bytes available: $tinyPngLength bytes '
                    '(minimum valid PNG with 1x1 transparent pixel). In real '
                    'code these come from rootBundle.load, dart:io File.read, '
                    'or an HTTP client.',
                    style: const TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _memorySoft,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: const Text(
                      'final bytes = await rootBundle.load(path);\n'
                      'Image.memory(bytes.buffer.asUint8List(),\n'
                      '  fit: BoxFit.cover,\n'
                      '  filterQuality: FilterQuality.high,\n'
                      '  errorBuilder: (c, e, s) => Text(\'broken\'));',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: _memoryStart,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(
          columns: const <String>['arg', 'type', 'note'],
          headerColor: _memoryStart,
          rowColor: _memorySoft,
          rows: <List<String>>[
            for (final Map<String, String> entry in recipe)
              <String>[entry['arg']!, entry['type']!, entry['note']!],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: bytes -> widget',
    recipeBody:
        'final Uint8List bytes = ...; '
            'Image.memory(bytes, fit: BoxFit.contain, scale: 2.0);',
  );
}

// =============================================================================
// SECTION 12: ENUM ATLAS
// =============================================================================

Widget _section12Enums(
  List<Map<String, dynamic>> boxFit,
  List<Map<String, dynamic>> repeat,
  List<Map<String, dynamic>> filter,
  List<Map<String, dynamic>> blend,
) {
  return _benchCard(
    headerColorStart: _atelierDeep,
    headerColorEnd: _atelierMid,
    softColor: _atelierPale,
    accentColor: _atelierSoft,
    sectionNumber: '12',
    title: 'Enum atlas',
    subtitle: 'BoxFit, ImageRepeat, FilterQuality, selected BlendModes',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _enumGroupTitle('BoxFit'),
        _enumChips(boxFit, _fitStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('ImageRepeat'),
        _enumChips(repeat, _repeatStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('FilterQuality'),
        _enumChips(filter, _qualityStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('Selected BlendModes'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final Map<String, dynamic> entry in blend)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: _blendStart,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        entry['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        entry['use'] as String,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: enum tour',
    recipeBody:
        'for (final v in BoxFit.values) { print(v.name); print(v.index); }',
  );
}

Widget _enumGroupTitle(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
        color: _atelierDeep,
      ),
    ),
  );
}

Widget _enumChips(List<Map<String, dynamic>> roster, Color color) {
  return Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: <Widget>[
      for (final Map<String, dynamic> entry in roster)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '${entry['name']} (${entry['index']})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
    ],
  );
}

// =============================================================================
// SECTION 13: RECIPE CARDS
// =============================================================================

Widget _section13Recipes(List<Map<String, String>> recipes) {
  return _benchCard(
    headerColorStart: _memoryStart,
    headerColorEnd: _memoryEnd,
    softColor: _memorySoft,
    accentColor: _memoryEnd,
    sectionNumber: '13',
    title: 'Recipe cards',
    subtitle: 'Six hand-rolled how-to snippets for Image scenarios',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final Map<String, String> entry in recipes)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _memorySoft, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.menu_book,
                          size: 16.0, color: _memoryStart),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          entry['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: _memoryStart,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _memorySoft,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      entry['body']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: read the recipes',
    recipeBody:
        'Treat each card as a starting point. Compose properties to match '
            'your domain - the Image widget tolerates a wide variety of '
            'configurations.',
  );
}

// =============================================================================
// SECTION 14: GLOSSARY
// =============================================================================

Widget _section14Glossary(List<Map<String, String>> glossary) {
  return _benchCard(
    headerColorStart: _atelierMid,
    headerColorEnd: _atelierDeep,
    softColor: _atelierPale,
    accentColor: _atelierSoft,
    sectionNumber: '14',
    title: 'Glossary',
    subtitle: 'Vocabulary of the Image widget family',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final Map<String, String> entry in glossary)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _atelierSoft, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry['term']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: _atelierDeep,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    entry['definition']!,
                    style: const TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: keep this nearby',
    recipeBody:
        'When in doubt, look up the term. The Flutter Image family is '
            'small but each name carries weight.',
  );
}

// =============================================================================
// EPILOGUE
// =============================================================================

Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_atelierMid, _atelierDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Atelier wrap-up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'You have now toured every major dimension of the Image widget. '
          'Combine providers, BoxFit, Alignment, ImageRepeat, ColorBlendMode, '
          'FilterQuality and the three builder hooks to compose any image '
          'experience your design system needs.',
          style: TextStyle(color: _atelierSoft, fontSize: 12.5, height: 1.5),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Sandbox note: Image.network and Image.asset are not exercised here '
          'because the D4rt sandbox cannot fetch bytes. Every preview is a '
          'hand-painted stand-in via Container / CustomPaint so you can SEE '
          'each property\'s effect on the layout.',
          style: TextStyle(color: _atelierSoft, fontSize: 11.5, height: 1.5),
        ),
      ],
    ),
  );
}

// =============================================================================
// REUSABLE BENCH CARD + COMPARISON TABLE
// =============================================================================

Widget _benchCard({
  required Color headerColorStart,
  required Color headerColorEnd,
  required Color softColor,
  required Color accentColor,
  required String sectionNumber,
  required String title,
  required String subtitle,
  required Widget body,
  required String recipeTitle,
  required String recipeBody,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: softColor, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x16000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[headerColorStart, headerColorEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Text(
                    sectionNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(14.0), child: body),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: softColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accentColor, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                recipeTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: headerColorStart,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                recipeBody,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonTable({
  required List<String> columns,
  required Color headerColor,
  required Color rowColor,
  required List<List<String>> rows,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: headerColor, width: 1.0),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              for (final String col in columns)
                Expanded(
                  child: Text(
                    col,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: i.isEven ? rowColor : Colors.white,
            ),
            child: Row(
              children: <Widget>[
                for (final String cell in rows[i])
                  Expanded(
                    child: Text(
                      cell,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
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

String _formatColor(Color c) {
  final int v = c.value;
  return '0x${v.toRadixString(16).toUpperCase().padLeft(8, '0')}';
}

// =============================================================================
// CUSTOM PAINTERS - top-level subclasses (not Stateful/Stateless widgets)
// Each painter renders a stand-in graphic that visually communicates the
// associated Image-widget property. We deliberately favour bright, blocky
// shapes so the contrast against the frame edges is high.
// =============================================================================

// -----------------------------------------------------------------------------
// _BoxFitPainter - paints a coloured "image" with the given scale factors
// inside the frame, simulating how BoxFit would scale the bitmap.
// -----------------------------------------------------------------------------

class _BoxFitPainter extends CustomPainter {
  _BoxFitPainter({
    required this.sx,
    required this.sy,
    required this.crop,
  });

  final double sx;
  final double sy;
  final bool crop;

  @override
  void paint(Canvas canvas, Size size) {
    // Backdrop letterbox to emphasise empty space
    final Paint bg = Paint()..color = const Color(0xFFFBE9E7);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    // "Image" geometry - a brand-coloured rectangle plus a diagonal stripe.
    final double w = size.width * sx;
    final double h = size.height * sy;
    final double dx = (size.width - w) * 0.5;
    final double dy = (size.height - h) * 0.5;

    canvas.save();
    if (crop) {
      // mimic that cover crops outside the frame by clipping to the frame
      canvas.clipRect(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      );
    }
    final Rect imageRect = Rect.fromLTWH(dx, dy, w, h);

    final Paint fill = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[_fitStart, _fitEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(imageRect);
    canvas.drawRect(imageRect, fill);

    // diagonal stripe to visually encode aspect ratio
    final Paint stripe = Paint()
      ..color = const Color(0xCCFFFFFF)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(imageRect.left, imageRect.bottom),
      Offset(imageRect.right, imageRect.top),
      stripe,
    );

    // tiny anchor cross at center
    final Paint anchor = Paint()
      ..color = const Color(0xFF311B92)
      ..strokeWidth = 2.0;
    final double cx = imageRect.center.dx;
    final double cy = imageRect.center.dy;
    canvas.drawLine(Offset(cx - 6.0, cy), Offset(cx + 6.0, cy), anchor);
    canvas.drawLine(Offset(cx, cy - 6.0), Offset(cx, cy + 6.0), anchor);
    canvas.restore();

    // Frame border to show the layout slot edges
    final Paint border = Paint()
      ..color = const Color(0xFFBF360C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _BoxFitPainter old) {
    return old.sx != sx || old.sy != sy || old.crop != crop;
  }
}

// -----------------------------------------------------------------------------
// _AlignmentPainter - paints a small square anchored at the given Alignment.
// -----------------------------------------------------------------------------

class _AlignmentPainter extends CustomPainter {
  _AlignmentPainter({required this.ax, required this.ay});

  final double ax;
  final double ay;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    // Faint center cross to give a reference for the alignment offset
    final Paint center = Paint()
      ..color = const Color(0xFFA5D6A7)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(size.width * 0.5, 0.0),
      Offset(size.width * 0.5, size.height),
      center,
    );
    canvas.drawLine(
      Offset(0.0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      center,
    );

    // The "image" itself - a small square that uses Alignment(ax, ay)
    const double tileW = 30.0;
    const double tileH = 24.0;
    final double px = (size.width - tileW) * 0.5 * (1.0 + ax);
    final double py = (size.height - tileH) * 0.5 * (1.0 + ay);

    final Paint tile = Paint()
      ..shader = LinearGradient(
        colors: const <Color>[_alignStart, _alignEnd],
      ).createShader(Rect.fromLTWH(px, py, tileW, tileH));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(px, py, tileW, tileH),
        const Radius.circular(4.0),
      ),
      tile,
    );

    // A subtle outline so the anchored tile stays visible against the bg
    final Paint outline = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(px, py, tileW, tileH),
        const Radius.circular(4.0),
      ),
      outline,
    );

    // Frame border
    final Paint border = Paint()
      ..color = const Color(0xFF1B5E20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _AlignmentPainter old) {
    return old.ax != ax || old.ay != ay;
  }
}

// -----------------------------------------------------------------------------
// _RepeatPainter - tiles a small motif across the frame following the given
// tile counts to simulate ImageRepeat.
// -----------------------------------------------------------------------------

class _RepeatPainter extends CustomPainter {
  _RepeatPainter({required this.tileX, required this.tileY});

  final int tileX;
  final int tileY;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE3F2FD);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    final double tw = size.width / math.max(tileX, 1);
    final double th = size.height / math.max(tileY, 1);

    for (int j = 0; j < tileY; j++) {
      for (int i = 0; i < tileX; i++) {
        final Rect r = Rect.fromLTWH(
          i * tw + 4.0,
          j * th + 4.0,
          tw - 8.0,
          th - 8.0,
        );
        final Paint p = Paint()
          ..shader = LinearGradient(
            colors: (i + j).isEven
                ? const <Color>[_repeatStart, _repeatEnd]
                : const <Color>[_repeatEnd, _repeatStart],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(r);
        canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(3.0)),
          p,
        );
        // little dot in the centre to make each tile visually distinct
        final Paint dot = Paint()..color = Colors.white;
        canvas.drawCircle(r.center, 2.0, dot);
      }
    }

    final Paint border = Paint()
      ..color = const Color(0xFF0D47A1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _RepeatPainter old) {
    return old.tileX != tileX || old.tileY != tileY;
  }
}

// -----------------------------------------------------------------------------
// _BlendPainter - paints overlapping shapes with a tinted top shape using the
// given BlendMode so the visual effect of the blend is observable.
// -----------------------------------------------------------------------------

class _BlendPainter extends CustomPainter {
  _BlendPainter({required this.tint, required this.mode});

  final Color tint;
  final BlendMode mode;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFCE4EC);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    // Base "image" - a rainbow ramp inside a rounded rectangle
    final Rect baseRect = Rect.fromLTWH(
      10.0,
      10.0,
      size.width - 20.0,
      size.height - 20.0,
    );
    final Paint base = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[
          Color(0xFFFFEB3B),
          Color(0xFFFF9800),
          Color(0xFFE91E63),
          Color(0xFF9C27B0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(baseRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(baseRect, const Radius.circular(6.0)),
      base,
    );

    // Tint layer using the requested blend mode
    final Paint tintPaint = Paint()
      ..color = tint
      ..blendMode = mode;
    canvas.drawRRect(
      RRect.fromRectAndRadius(baseRect, const Radius.circular(6.0)),
      tintPaint,
    );

    // Outline to keep the tile crisp
    final Paint outline = Paint()
      ..color = const Color(0xFFAD1457)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(baseRect, const Radius.circular(6.0)),
      outline,
    );
  }

  @override
  bool shouldRepaint(covariant _BlendPainter old) {
    return old.tint != tint || old.mode != mode;
  }
}

// -----------------------------------------------------------------------------
// _FilterQualityPainter - simulates sampling fidelity by drawing a checker
// pattern at the given pixel step. Smaller step = higher fidelity.
// -----------------------------------------------------------------------------

class _FilterQualityPainter extends CustomPainter {
  _FilterQualityPainter({required this.pixelStep, required this.jitter});

  final double pixelStep;
  final double jitter;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFECEFF1);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    // We mimic sampling by painting alternating coloured squares of pixelStep
    // size. Lower jitter = perfectly aligned (high quality), higher jitter
    // adds a small misalignment to make rough sampling visible.
    final math.Random rng = math.Random(42);
    int row = 0;
    for (double y = 0.0; y < size.height; y += pixelStep) {
      int col = 0;
      for (double x = 0.0; x < size.width; x += pixelStep) {
        final double jx = (rng.nextDouble() - 0.5) * jitter * pixelStep;
        final double jy = (rng.nextDouble() - 0.5) * jitter * pixelStep;
        final bool isDark = (row + col).isEven;
        final Paint cell = Paint()
          ..color = isDark ? _qualityStart : _qualityEnd;
        canvas.drawRect(
          Rect.fromLTWH(x + jx, y + jy, pixelStep, pixelStep),
          cell,
        );
        col++;
      }
      row++;
    }

    // A diagonal highlight to show the smoothing intent
    final Paint diag = Paint()
      ..color = const Color(0x66FFFFFF)
      ..strokeWidth = 4.0;
    canvas.drawLine(
      Offset(0.0, size.height),
      Offset(size.width, 0.0),
      diag,
    );

    // Border
    final Paint border = Paint()
      ..color = const Color(0xFF263238)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _FilterQualityPainter old) {
    return old.pixelStep != pixelStep || old.jitter != jitter;
  }
}

// -----------------------------------------------------------------------------
// _SpinnerPainter - draws a static spinner arc as a stand-in for a
// CircularProgressIndicator in a loadingBuilder.
// -----------------------------------------------------------------------------

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint track = Paint()
      ..color = _loadingSoft
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.45,
      track,
    );

    final Paint arc = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[_loadingStart, _loadingEnd],
      ).createShader(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromLTWH(
        size.width * 0.05,
        size.height * 0.05,
        size.width * 0.9,
        size.height * 0.9,
      ),
      -1.5708,
      4.0,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _SpinnerPainter old) => false;
}

// -----------------------------------------------------------------------------
// _FrameStagePainter - paints a backdrop whose alpha matches the conceptual
// frame opacity. Combined with the badge above it, this communicates frame
// progression.
// -----------------------------------------------------------------------------

class _FrameStagePainter extends CustomPainter {
  _FrameStagePainter({required this.opacity});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFEDE7F6);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    // The "image" content as a multi-stop gradient with the requested opacity
    final Paint content = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          _frameStart.withOpacity(opacity),
          _frameEnd.withOpacity(opacity),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      content,
    );

    // Vertical scan-bars to give the impression of decoding progress
    final Paint scan = Paint()
      ..color = Colors.white.withOpacity(0.2 + 0.4 * opacity)
      ..strokeWidth = 1.0;
    for (double x = 0.0; x < size.width; x += 8.0) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), scan);
    }
  }

  @override
  bool shouldRepaint(covariant _FrameStagePainter old) =>
      old.opacity != opacity;
}

// -----------------------------------------------------------------------------
// _DecorationPainter - paints a stand-in motif respecting the fit/align/repeat
// names given as strings. Not pixel-accurate, but visually communicates the
// configuration.
// -----------------------------------------------------------------------------

class _DecorationPainter extends CustomPainter {
  _DecorationPainter({
    required this.fit,
    required this.align,
    required this.repeat,
  });

  final String fit;
  final String align;
  final String repeat;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dimmer = Paint()..color = const Color(0x55000000);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      dimmer,
    );

    if (repeat == 'repeat') {
      const double tileW = 18.0;
      const double tileH = 14.0;
      for (double y = 4.0; y < size.height - 4.0; y += tileH + 2.0) {
        for (double x = 4.0; x < size.width - 4.0; x += tileW + 2.0) {
          final Paint p = Paint()
            ..color = Colors.white.withOpacity(0.85)
            ..style = PaintingStyle.fill;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, y, tileW, tileH),
              const Radius.circular(2.0),
            ),
            p,
          );
        }
      }
    } else {
      // single motif positioned by alignment
      double tileW = size.width * 0.55;
      double tileH = size.height * 0.55;
      if (fit == 'cover') {
        tileW = size.width;
        tileH = size.height;
      } else if (fit == 'contain') {
        tileW = size.width * 0.7;
        tileH = size.height * 0.7;
      }
      double ax = 0.0;
      double ay = 0.0;
      switch (align) {
        case 'topLeft':
          ax = -1.0;
          ay = -1.0;
          break;
        case 'topCenter':
          ax = 0.0;
          ay = -1.0;
          break;
        case 'topRight':
          ax = 1.0;
          ay = -1.0;
          break;
        case 'centerLeft':
          ax = -1.0;
          ay = 0.0;
          break;
        case 'centerRight':
          ax = 1.0;
          ay = 0.0;
          break;
        case 'bottomLeft':
          ax = -1.0;
          ay = 1.0;
          break;
        case 'bottomCenter':
          ax = 0.0;
          ay = 1.0;
          break;
        case 'bottomRight':
          ax = 1.0;
          ay = 1.0;
          break;
        default:
          ax = 0.0;
          ay = 0.0;
      }
      final double px = (size.width - tileW) * 0.5 * (1.0 + ax);
      final double py = (size.height - tileH) * 0.5 * (1.0 + ay);

      final Rect tileRect = Rect.fromLTWH(px, py, tileW, tileH);
      final Paint motif = Paint()
        ..shader = const LinearGradient(
          colors: <Color>[Colors.white, Color(0xFFE0F2F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(tileRect);
      canvas.drawRRect(
        RRect.fromRectAndRadius(tileRect, const Radius.circular(6.0)),
        motif,
      );

      // Inner highlight
      final Paint inner = Paint()
        ..color = _decoStart
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          tileRect.deflate(4.0),
          const Radius.circular(4.0),
        ),
        inner,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DecorationPainter old) {
    return old.fit != fit || old.align != align || old.repeat != repeat;
  }
}

// -----------------------------------------------------------------------------
// _MemoryPreviewPainter - paints a checkerboard alpha pattern with the bytes
// label baked in, suggesting what a 1x1 PNG would look like upscaled.
// -----------------------------------------------------------------------------

class _MemoryPreviewPainter extends CustomPainter {
  _MemoryPreviewPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      bg,
    );

    // Alpha checkerboard
    const double step = 14.0;
    int row = 0;
    for (double y = 0.0; y < size.height; y += step) {
      int col = 0;
      for (double x = 0.0; x < size.width; x += step) {
        final Paint p = Paint()
          ..color = (row + col).isEven
              ? const Color(0xFFE0F7FA)
              : const Color(0xFFB2EBF2);
        canvas.drawRect(Rect.fromLTWH(x, y, step, step), p);
        col++;
      }
      row++;
    }

    // Center medallion to represent the decoded pixel
    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;
    final Paint medal = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[_memoryStart, _memoryEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 28.0));
    canvas.drawCircle(Offset(cx, cy), 28.0, medal);

    final Paint ring = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(Offset(cx, cy), 28.0, ring);

    // Tiny tick mark to evoke a "decoded ok" badge
    final Path tick = Path()
      ..moveTo(cx - 10.0, cy)
      ..lineTo(cx - 2.0, cy + 8.0)
      ..lineTo(cx + 12.0, cy - 8.0);
    final Paint tickPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(tick, tickPaint);

    final Paint border = Paint()
      ..color = _memoryStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _MemoryPreviewPainter old) => false;
}

// =============================================================================
// END OF FILE - Image Pipeline Atelier
// =============================================================================
