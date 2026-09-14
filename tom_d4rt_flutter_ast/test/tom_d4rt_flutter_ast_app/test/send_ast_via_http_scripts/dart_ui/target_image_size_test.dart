// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element, unnecessary_import

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// dart:ui — TargetImageSize deep-demo script.
//
// TargetImageSize is the tiny value object the Flutter image pipeline consults
// during the resize-decode step. When you call `instantiateImageCodec` (or the
// higher-level `instantiateImageCodecWithSize`) you can hand it a callback
// returning a TargetImageSize. The decoder honours that hint by emitting a
// decoded bitmap whose pixels are already at (or close to) the requested
// width/height — instead of decoding the source at full intrinsic resolution
// and resizing later in the engine. This is the single most effective lever
// you have to keep image memory under control on a real device.
//
// This script does not perform any decoding. It constructs the
// `ui.TargetImageSize` value objects, reads back their `width` / `height`
// fields, and renders a richly visual "manual" that explains the API: the
// anatomy of a resize-decode, a resize ladder of common preset sizes, a
// memory savings table, an aspect-ratio gallery, a DPR-aware sizing recipe,
// a comparison panel, a footgun panel and a practical recipe gallery.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Brand palette and shared visual tokens.
// ---------------------------------------------------------------------------

const Color _kPageBg = Color(0xFF101A2A);
const Color _kSurface = Color(0xFF182640);
const Color _kSurfaceAlt = Color(0xFF1F2F4D);
const Color _kSurfaceDeep = Color(0xFF0C1424);
const Color _kAccent = Color(0xFF66E1FF);
const Color _kAccentB = Color(0xFFB388FF);
const Color _kAccentC = Color(0xFFFFB74D);
const Color _kAccentD = Color(0xFF80E27E);
const Color _kAccentE = Color(0xFFFF8A80);
const Color _kAccentF = Color(0xFFFFE082);
const Color _kInk = Color(0xFFE6F0FF);
const Color _kInkSoft = Color(0xFFAEC0DA);
const Color _kInkMute = Color(0xFF6F86A8);
const Color _kRule = Color(0xFF2C3E62);

// Six gradient palettes (≥6 LinearGradients required).
const LinearGradient _kHeaderGradientA = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF1A3A6B), Color(0xFF66E1FF)],
);
const LinearGradient _kHeaderGradientB = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF3B1E72), Color(0xFFB388FF)],
);
const LinearGradient _kHeaderGradientC = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF7A4A12), Color(0xFFFFB74D)],
);
const LinearGradient _kHeaderGradientD = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF1F5E2C), Color(0xFF80E27E)],
);
const LinearGradient _kHeaderGradientE = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF6E1F1A), Color(0xFFFF8A80)],
);
const LinearGradient _kHeaderGradientF = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF6A4A00), Color(0xFFFFE082)],
);
const LinearGradient _kHeaderGradientG = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF112B4A), Color(0xFF2C3E62)],
);
const LinearGradient _kHeaderGradientH = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF223A66), Color(0xFF66E1FF)],
);

// Reusable shadow palette (≥6 BoxShadows).
const List<BoxShadow> _kCardShadow = <BoxShadow>[
  BoxShadow(color: Color(0x66000000), blurRadius: 24, offset: Offset(0, 12)),
  BoxShadow(color: Color(0x22000000), blurRadius: 4, offset: Offset(0, 2)),
];
const List<BoxShadow> _kHeaderShadow = <BoxShadow>[
  BoxShadow(color: Color(0x55000000), blurRadius: 18, offset: Offset(0, 8)),
];
const List<BoxShadow> _kChipShadow = <BoxShadow>[
  BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 3)),
];
const List<BoxShadow> _kInsetShadow = <BoxShadow>[
  BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 6)),
];
const List<BoxShadow> _kGlowAccent = <BoxShadow>[
  BoxShadow(color: Color(0x6666E1FF), blurRadius: 22, offset: Offset(0, 0)),
];
const List<BoxShadow> _kGlowWarn = <BoxShadow>[
  BoxShadow(color: Color(0x66FF8A80), blurRadius: 22, offset: Offset(0, 0)),
];
const List<BoxShadow> _kGlowOk = <BoxShadow>[
  BoxShadow(color: Color(0x6680E27E), blurRadius: 22, offset: Offset(0, 0)),
];

// Border radii.
const BorderRadius _kRadiusXs = BorderRadius.all(Radius.circular(6));
const BorderRadius _kRadiusSm = BorderRadius.all(Radius.circular(10));
const BorderRadius _kRadiusMd = BorderRadius.all(Radius.circular(14));
const BorderRadius _kRadiusLg = BorderRadius.all(Radius.circular(20));
const BorderRadius _kRadiusXl = BorderRadius.all(Radius.circular(28));

// ---------------------------------------------------------------------------
// Catalogue of TargetImageSize instances (≥10 distinct values).
// All const-constructible because the constructor is `const`.
// ---------------------------------------------------------------------------

const ui.TargetImageSize _tisThumbXs = ui.TargetImageSize(width: 64, height: 48);
const ui.TargetImageSize _tisThumbSm =
    ui.TargetImageSize(width: 128, height: 96);
const ui.TargetImageSize _tisThumbMd =
    ui.TargetImageSize(width: 256, height: 192);
const ui.TargetImageSize _tisCard =
    ui.TargetImageSize(width: 512, height: 384);
const ui.TargetImageSize _tisHero =
    ui.TargetImageSize(width: 1024, height: 768);
const ui.TargetImageSize _tisFull =
    ui.TargetImageSize(width: 2048, height: 1536);

// Aspect ratio buckets.
const ui.TargetImageSize _tisSquareAvatar =
    ui.TargetImageSize(width: 64, height: 64);
const ui.TargetImageSize _tisSquareList =
    ui.TargetImageSize(width: 88, height: 88);
const ui.TargetImageSize _tis43Photo =
    ui.TargetImageSize(width: 800, height: 600);
const ui.TargetImageSize _tis169Banner =
    ui.TargetImageSize(width: 1080, height: 608);
const ui.TargetImageSize _tisPortrait34 =
    ui.TargetImageSize(width: 600, height: 800);
const ui.TargetImageSize _tisUltrawide219 =
    ui.TargetImageSize(width: 1680, height: 720);

// DPR-aware sizes for a logical 100×100 widget.
const ui.TargetImageSize _tisDpr1 =
    ui.TargetImageSize(width: 100, height: 100);
const ui.TargetImageSize _tisDpr1_5 =
    ui.TargetImageSize(width: 150, height: 150);
const ui.TargetImageSize _tisDpr2 =
    ui.TargetImageSize(width: 200, height: 200);
const ui.TargetImageSize _tisDpr2_5 =
    ui.TargetImageSize(width: 250, height: 250);
const ui.TargetImageSize _tisDpr3 =
    ui.TargetImageSize(width: 300, height: 300);

// Single-axis (preserve aspect ratio) hints.
const ui.TargetImageSize _tisOnlyWidth = ui.TargetImageSize(width: 480);
const ui.TargetImageSize _tisOnlyHeight = ui.TargetImageSize(height: 360);
const ui.TargetImageSize _tisIntrinsic = ui.TargetImageSize();

// Practical recipe sizes.
const ui.TargetImageSize _tisRecipeAvatar =
    ui.TargetImageSize(width: 64, height: 64);
const ui.TargetImageSize _tisRecipeListThumb =
    ui.TargetImageSize(width: 88, height: 88);
const ui.TargetImageSize _tisRecipeHeroBanner =
    ui.TargetImageSize(width: 1080, height: 608);
const ui.TargetImageSize _tisRecipeFullScreen =
    ui.TargetImageSize(width: 1440, height: 2960);
const ui.TargetImageSize _tisRecipeChatBubble =
    ui.TargetImageSize(width: 360, height: 360);
const ui.TargetImageSize _tisRecipeProductCard =
    ui.TargetImageSize(width: 512, height: 512);

// Comparison panel.
const ui.TargetImageSize _tisCompareSourceish =
    ui.TargetImageSize(width: 4032, height: 3024);
const ui.TargetImageSize _tisCompareHinted =
    ui.TargetImageSize(width: 1080, height: 810);

// Footgun examples.
const ui.TargetImageSize _tisFootgunAspectMismatch =
    ui.TargetImageSize(width: 600, height: 200);
const ui.TargetImageSize _tisFootgunLogicalNotPhysical =
    ui.TargetImageSize(width: 100, height: 100);
const ui.TargetImageSize _tisFootgunForgotOn4K =
    ui.TargetImageSize(width: 3840, height: 2160);

// ---------------------------------------------------------------------------
// Entrypoint expected by the bridge.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF101A2A),
      appBar: AppBar(title: const Text('dart:ui TargetImageSize')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildIntroSection(),
            _kGap32,
            _buildAnatomySection(),
            _kGap32,
            _buildResizeLadderSection(),
            _kGap32,
            _buildMemorySavingsSection(),
            _kGap32,
            _buildAspectRatioGallerySection(),
            _kGap32,
            _buildDprRecipeSection(),
            _kGap32,
            _buildComparisonSection(),
            _kGap32,
            _buildFootgunSection(),
            _kGap32,
            _buildPracticalRecipeSection(),
            _kGap32,
            _buildApiSummarySection(),
            _kGap32,
            _buildClosingSection(),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Layout primitives.
// ---------------------------------------------------------------------------

const SizedBox _kGap4 = SizedBox(height: 4);
const SizedBox _kGap8 = SizedBox(height: 8);
const SizedBox _kGap12 = SizedBox(height: 12);
const SizedBox _kGap16 = SizedBox(height: 16);
const SizedBox _kGap20 = SizedBox(height: 20);
const SizedBox _kGap24 = SizedBox(height: 24);
const SizedBox _kGap32 = SizedBox(height: 32);
const SizedBox _kHGap8 = SizedBox(width: 8);
const SizedBox _kHGap12 = SizedBox(width: 12);
const SizedBox _kHGap16 = SizedBox(width: 16);

Widget _sectionHeader({
  required String overline,
  required String title,
  required String subtitle,
  required LinearGradient gradient,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: _kRadiusLg,
      boxShadow: _kHeaderShadow,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: _kRadiusMd,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: _kInk, size: 28),
        ),
        _kHGap16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                overline.toUpperCase(),
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 11,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(color: _kInk, fontSize: 13, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _prose(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkSoft,
        fontSize: 14,
        height: 1.55,
      ),
    ),
  );
}

Widget _surface({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: _kRadiusLg,
      boxShadow: _kCardShadow,
      border: Border.all(color: _kRule, width: 1),
    ),
    child: child,
  );
}

Widget _chip(String text, {Color? bg, Color? fg, IconData? icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg ?? _kSurfaceAlt,
      borderRadius: _kRadiusXs,
      boxShadow: _kChipShadow,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: 14, color: fg ?? _kInk),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: TextStyle(
            color: fg ?? _kInk,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            key,
            style: const TextStyle(
              color: _kInkMute,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _kInk,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helpers that read back from a TargetImageSize.
// ---------------------------------------------------------------------------

String _tisLabel(ui.TargetImageSize tis) {
  final int? w = tis.width;
  final int? h = tis.height;
  if (w == null && h == null) {
    return 'intrinsic (no hint)';
  }
  if (w == null) {
    return 'auto × $h';
  }
  if (h == null) {
    return '$w × auto';
  }
  return '$w × $h';
}

int _tisBytes(ui.TargetImageSize tis) {
  final int w = tis.width ?? 0;
  final int h = tis.height ?? 0;
  return w * h * 4;
}

String _bytesHuman(int bytes) {
  if (bytes <= 0) {
    return 'unknown';
  }
  if (bytes >= 1024 * 1024) {
    final double mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(2)} MB';
  }
  if (bytes >= 1024) {
    final double kb = bytes / 1024;
    return '${kb.toStringAsFixed(1)} KB';
  }
  return '$bytes B';
}

double _tisAspect(ui.TargetImageSize tis) {
  final int? w = tis.width;
  final int? h = tis.height;
  if (w == null || h == null || h == 0) {
    return 1;
  }
  return w / h;
}

String _aspectLabel(ui.TargetImageSize tis) {
  final double a = _tisAspect(tis);
  if ((a - 1).abs() < 0.01) {
    return '1:1';
  }
  if ((a - 4 / 3).abs() < 0.02) {
    return '4:3';
  }
  if ((a - 16 / 9).abs() < 0.02) {
    return '16:9';
  }
  if ((a - 3 / 4).abs() < 0.02) {
    return '3:4';
  }
  if ((a - 21 / 9).abs() < 0.05) {
    return '21:9';
  }
  return a.toStringAsFixed(2);
}

// ===========================================================================
// SECTION 1 — Intro.
// ===========================================================================

Widget _buildIntroSection() {
  return _surface(
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'dart:ui · resize-decode',
          title: 'TargetImageSize at a glance',
          subtitle:
              'A two-field hint that tells the image decoder how big the decoded bitmap should be.',
          gradient: _kHeaderGradientA,
          icon: Icons.aspect_ratio,
        ),
        _kGap20,
        _prose(
          'TargetImageSize is intentionally tiny: it carries an optional `width` and an optional `height`, both nullable positive integers. '
          'When the image pipeline is about to decode a frame it asks your callback for one of these values, then decodes directly into a bitmap of that exact size. '
          'You never allocate the full source resolution in memory, which is the whole point of the API.',
        ),
        _kGap16,
        _prose(
          'If you leave both fields null you opt out of resizing and the decoder produces the intrinsic-size bitmap. '
          'If you provide only one of width or height the decoder preserves the source aspect ratio and computes the missing axis. '
          'If you provide both you take full responsibility for the aspect ratio — the decoder will not letterbox or stretch, it will simply emit pixels at exactly that size.',
        ),
        _kGap16,
        _prose(
          'On a phone with a 3.0 device pixel ratio, a logical 100×100 widget needs a 300×300 bitmap to look crisp. '
          'A 4K source image is 8.3 megapixels and roughly 33 megabytes of RGBA after decode; the same image hinted to 300×300 is 360 KB. '
          'TargetImageSize is the lever that turns those two numbers into the same outcome.',
        ),
        _kGap20,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _chip('width: int?', icon: Icons.swap_horiz, fg: _kAccent),
            _chip('height: int?', icon: Icons.swap_vert, fg: _kAccentB),
            _chip('const ctor', icon: Icons.bolt, fg: _kAccentC),
            _chip('decode-time hint', icon: Icons.memory, fg: _kAccentD),
            _chip('value object', icon: Icons.label_important, fg: _kAccentE),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 — Anatomy diagram.
// ===========================================================================

Widget _buildAnatomySection() {
  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 1 · anatomy',
          title: 'Anatomy of a resize-decode',
          subtitle:
              'Source → decoder → decoded bitmap, with TargetImageSize sitting on the arrow.',
          gradient: _kHeaderGradientB,
          icon: Icons.account_tree,
        ),
        _kGap20,
        _prose(
          'A resize-decode is a three-station pipeline. The source is whatever the asset bundle, network, or memory buffer hands you — typically a JPEG or PNG with a fixed intrinsic resolution. '
          'The decoder is `instantiateImageCodec` (or its higher-level wrapper). The decoded bitmap is the RGBA pixel buffer that ends up in the GPU and your widget. '
          'TargetImageSize controls only the third stop: it does not change the source bytes, only the size of the bitmap that the decoder hands to Skia.',
        ),
        _kGap20,
        _anatomyDiagram(
          source: 'Source JPEG\n4032 × 3024',
          target: const ui.TargetImageSize(width: 1080, height: 810),
          accentSource: _kAccentB,
          accentTarget: _kAccent,
        ),
        _kGap20,
        _anatomyDiagram(
          source: 'Source PNG\n2048 × 2048',
          target: const ui.TargetImageSize(width: 256, height: 256),
          accentSource: _kAccentC,
          accentTarget: _kAccentD,
        ),
        _kGap20,
        _anatomyDiagram(
          source: 'Source HEIC\n5712 × 4284',
          target: const ui.TargetImageSize(width: 1440),
          accentSource: _kAccentE,
          accentTarget: _kAccentF,
        ),
        _kGap16,
        _prose(
          'The middle arrow is the only thing that changes between an app that quietly OOMs on a photo gallery and one that scrolls smoothly. '
          'When the arrow carries a TargetImageSize, the decoded bitmap is small. When it does not, the decoded bitmap is whatever the photographer happened to capture.',
        ),
      ],
    ),
  );
}

Widget _anatomyDiagram({
  required String source,
  required ui.TargetImageSize target,
  required Color accentSource,
  required Color accentTarget,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kSurfaceDeep,
      borderRadius: _kRadiusMd,
      border: Border.all(color: _kRule, width: 1),
      boxShadow: _kInsetShadow,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _anatomyBlock(
            label: source,
            color: accentSource,
            heightLogical: 92,
          ),
        ),
        _kHGap12,
        _anatomyArrow(target: target),
        _kHGap12,
        Expanded(
          child: _anatomyBlock(
            label:
                'Decoded bitmap\n${_tisLabel(target)}\n${_bytesHuman(_tisBytes(target))}',
            color: accentTarget,
            heightLogical: 72,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyBlock({
  required String label,
  required Color color,
  required double heightLogical,
}) {
  return Container(
    height: heightLogical,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.16),
      borderRadius: _kRadiusSm,
      border: Border.all(color: color, width: 1.4),
    ),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        height: 1.35,
      ),
    ),
  );
}

Widget _anatomyArrow({required ui.TargetImageSize target}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _kSurfaceAlt,
          borderRadius: _kRadiusXs,
          border: Border.all(color: _kAccent, width: 1),
        ),
        child: Text(
          _tisLabel(target),
          style: const TextStyle(
            color: _kAccent,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 4),
      const Icon(Icons.arrow_forward, color: _kAccent, size: 24),
      const SizedBox(height: 2),
      const Text(
        'decode',
        style: TextStyle(color: _kInkMute, fontSize: 10),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 3 — Resize ladder.
// ===========================================================================

Widget _buildResizeLadderSection() {
  const List<ui.TargetImageSize> ladder = <ui.TargetImageSize>[
    _tisThumbXs,
    _tisThumbSm,
    _tisThumbMd,
    _tisCard,
    _tisHero,
    _tisFull,
  ];
  const List<String> usage = <String>[
    'Tiny inline avatar / badge',
    'List thumbnail / chip',
    'Card cover, grid tile',
    'Detail page hero (small)',
    'Hero banner, lightbox preview',
    'Full-screen photo, AR Sheet',
  ];
  const List<Color> accents = <Color>[
    _kAccent,
    _kAccentB,
    _kAccentC,
    _kAccentD,
    _kAccentE,
    _kAccentF,
  ];

  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 2 · ladder',
          title: 'A six-rung resize ladder',
          subtitle:
              'Six TargetImageSize presets covering 64×48 thumbnails through 2048×1536 full-screen.',
          gradient: _kHeaderGradientC,
          icon: Icons.stacked_bar_chart,
        ),
        _kGap20,
        _prose(
          'The ladder is the mental model most teams converge on. You pick a small set of "intents" — avatar, list thumb, card, hero, lightbox, full-screen — and assign a fixed TargetImageSize to each. '
          'Multiplying width × height × 4 gives you the decoded RGBA bytes, which is the single most useful number to keep in your head when you reason about image memory. '
          'Each rung roughly quadruples the byte cost: doubling both axes is a 4× area increase.',
        ),
        _kGap20,
        Column(
          children: List<Widget>.generate(
            ladder.length,
            (int i) => Padding(
              padding: EdgeInsets.only(bottom: i == ladder.length - 1 ? 0 : 12),
              child: _resizeLadderCard(
                index: i,
                tis: ladder[i],
                usage: usage[i],
                accent: accents[i],
              ),
            ),
          ),
        ),
        _kGap16,
        _prose(
          'The visual width of each thumbnail rectangle in this ladder reflects the relative pixel width of its TargetImageSize, capped to fit the card. '
          'The byte cost grows quadratically with each rung, while the perceived "size" only grows linearly — that is the optical illusion that lures developers into shipping unhinted decodes.',
        ),
      ],
    ),
  );
}

Widget _resizeLadderCard({
  required int index,
  required ui.TargetImageSize tis,
  required String usage,
  required Color accent,
}) {
  // Translate width to a logical bar width (capped) for the visual ratio.
  final int w = tis.width ?? 0;
  final int h = tis.height ?? 0;
  // Map the largest preset (2048) to the maximum logical width 240.
  final double scale = 240.0 / 2048.0;
  final double barW = (w * scale).clamp(20.0, 240.0);
  final double barH = h == 0 ? 16.0 : (barW * h / w).clamp(8.0, 200.0);

  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: _kRadiusMd,
      boxShadow: _kInsetShadow,
      border: Border.all(color: _kRule, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: _kRadiusXs,
            border: Border.all(color: accent, width: 1.2),
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
        _kHGap16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _tisLabel(tis),
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                usage,
                style: const TextStyle(color: _kInkSoft, fontSize: 12),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: <Widget>[
                  _chip(
                    'aspect ${_aspectLabel(tis)}',
                    icon: Icons.crop_din,
                    fg: _kInk,
                  ),
                  _chip(
                    _bytesHuman(_tisBytes(tis)),
                    icon: Icons.memory,
                    fg: accent,
                  ),
                ],
              ),
            ],
          ),
        ),
        _kHGap16,
        Container(
          width: barW,
          height: barH,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.22),
            borderRadius: _kRadiusXs,
            border: Border.all(color: accent, width: 1.5),
            boxShadow: _kChipShadow,
          ),
          alignment: Alignment.center,
          child: Text(
            _tisLabel(tis),
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — Memory savings table.
// ===========================================================================

Widget _buildMemorySavingsSection() {
  const List<ui.TargetImageSize> rows = <ui.TargetImageSize>[
    _tisThumbXs,
    _tisThumbSm,
    _tisSquareList,
    _tisThumbMd,
    _tisCard,
    _tisHero,
    _tis43Photo,
    _tis169Banner,
    _tisFull,
  ];
  const int sourceBytes = 4032 * 3024 * 4; // approx 46.5 MB.

  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 3 · memory',
          title: 'Decoded bytes per TargetImageSize',
          subtitle:
              'Width × height × 4 (RGBA) is the only formula you ever need.',
          gradient: _kHeaderGradientD,
          icon: Icons.memory,
        ),
        _kGap20,
        _prose(
          'Every decoded pixel is four bytes — red, green, blue and alpha. The decoded bitmap therefore costs `width × height × 4` bytes regardless of the source format. '
          'A 12 MP phone photo is around 46 MB after decode; a 256×192 thumbnail of the same photo is 196 KB. '
          'The table below pretends the source is a single 4032×3024 photo and compares it to each preset TargetImageSize.',
        ),
        _kGap16,
        Container(
          decoration: BoxDecoration(
            color: _kSurfaceDeep,
            borderRadius: _kRadiusMd,
            border: Border.all(color: _kRule, width: 1),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              _memoryHeaderRow(),
              const Divider(color: _kRule, height: 16),
              Column(
                children: List<Widget>.generate(
                  rows.length,
                  (int i) => _memoryRow(
                    rows[i],
                    sourceBytes: sourceBytes,
                    striped: i.isOdd,
                  ),
                ),
              ),
            ],
          ),
        ),
        _kGap16,
        _prose(
          'The "savings" column is the ratio of source-decoded bytes to hinted-decoded bytes. '
          'A 256×192 thumbnail saves more than 99% of the bytes a naive decode of a 12 MP photo would consume; even a generous 1024×768 hero saves 96%. '
          'These ratios compound linearly across an image-heavy screen, which is why a single missing TargetImageSize on a list page can dominate the entire frame budget.',
        ),
      ],
    ),
  );
}

Widget _memoryHeaderRow() {
  return Row(
    children: <Widget>[
      Expanded(flex: 5, child: _memoryHeaderCell('TargetImageSize')),
      Expanded(flex: 3, child: _memoryHeaderCell('Bytes (RGBA)')),
      Expanded(flex: 3, child: _memoryHeaderCell('Human')),
      Expanded(flex: 3, child: _memoryHeaderCell('Savings')),
    ],
  );
}

Widget _memoryHeaderCell(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: _kInkMute,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
    ),
  );
}

Widget _memoryRow(
  ui.TargetImageSize tis, {
  required int sourceBytes,
  required bool striped,
}) {
  final int bytes = _tisBytes(tis);
  final double savings =
      sourceBytes <= 0 ? 0 : (1.0 - (bytes / sourceBytes)) * 100.0;
  final Color savingsColor = savings >= 95
      ? _kAccentD
      : savings >= 80
          ? _kAccentC
          : _kAccentE;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    decoration: BoxDecoration(
      color: striped ? _kSurfaceAlt.withValues(alpha: 0.4) : null,
      borderRadius: _kRadiusXs,
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            _tisLabel(tis),
            style: const TextStyle(color: _kInk, fontSize: 13),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '$bytes',
            style: const TextStyle(color: _kInkSoft, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            _bytesHuman(bytes),
            style: const TextStyle(color: _kInk, fontSize: 13),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '${savings.toStringAsFixed(1)}%',
            style: TextStyle(
              color: savingsColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 — Aspect ratio gallery.
// ===========================================================================

Widget _buildAspectRatioGallerySection() {
  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 4 · aspect ratios',
          title: 'Aspect ratios that survive decode',
          subtitle:
              'Group your TargetImageSize presets by the ratio your widget actually paints.',
          gradient: _kHeaderGradientE,
          icon: Icons.crop_din,
        ),
        _kGap20,
        _prose(
          'The decoder will not reshape your image. If you ask for 600×200 and the source is a 4:3 photograph the result is a 600×200 bitmap that has been squashed. '
          'It is your job to choose a TargetImageSize whose aspect ratio matches the slot in your layout. '
          'The cards below render the actual aspect ratio of each preset using `AspectRatio`, so you can see at a glance whether a square avatar, a 4:3 photo or a 16:9 banner is what you want.',
        ),
        _kGap20,
        _aspectGroup(
          title: '1:1 — Avatars and tiles',
          accent: _kAccent,
          tisList: const <ui.TargetImageSize>[
            _tisSquareAvatar,
            _tisSquareList,
            _tisRecipeChatBubble,
            _tisRecipeProductCard,
          ],
        ),
        _kGap16,
        _aspectGroup(
          title: '4:3 — Classic photo',
          accent: _kAccentB,
          tisList: const <ui.TargetImageSize>[
            _tisThumbMd,
            _tisCard,
            _tisHero,
            _tis43Photo,
          ],
        ),
        _kGap16,
        _aspectGroup(
          title: '16:9 — Modern banner',
          accent: _kAccentC,
          tisList: const <ui.TargetImageSize>[
            _tis169Banner,
            ui.TargetImageSize(width: 640, height: 360),
            ui.TargetImageSize(width: 1280, height: 720),
            ui.TargetImageSize(width: 1920, height: 1080),
          ],
        ),
        _kGap16,
        _aspectGroup(
          title: '3:4 — Portrait',
          accent: _kAccentD,
          tisList: const <ui.TargetImageSize>[
            _tisPortrait34,
            ui.TargetImageSize(width: 300, height: 400),
            ui.TargetImageSize(width: 450, height: 600),
          ],
        ),
        _kGap16,
        _aspectGroup(
          title: '21:9 — Ultrawide',
          accent: _kAccentE,
          tisList: const <ui.TargetImageSize>[
            _tisUltrawide219,
            ui.TargetImageSize(width: 2520, height: 1080),
            ui.TargetImageSize(width: 1260, height: 540),
          ],
        ),
      ],
    ),
  );
}

Widget _aspectGroup({
  required String title,
  required Color accent,
  required List<ui.TargetImageSize> tisList,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurfaceDeep,
      borderRadius: _kRadiusMd,
      border: Border.all(color: _kRule, width: 1),
      boxShadow: _kInsetShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            _kHGap8,
            Text(
              title,
              style: const TextStyle(
                color: _kInk,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        _kGap12,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List<Widget>.generate(
            tisList.length,
            (int i) => _aspectCard(tisList[i], accent),
          ),
        ),
      ],
    ),
  );
}

Widget _aspectCard(ui.TargetImageSize tis, Color accent) {
  final double aspect = _tisAspect(tis);
  return Container(
    width: 150,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: _kRadiusSm,
      border: Border.all(color: _kRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: aspect == 0 ? 1 : aspect,
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: _kRadiusXs,
              border: Border.all(color: accent, width: 1.4),
            ),
            alignment: Alignment.center,
            child: Text(
              _aspectLabel(tis),
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _tisLabel(tis),
          style: const TextStyle(
            color: _kInk,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          _bytesHuman(_tisBytes(tis)),
          style: const TextStyle(color: _kInkSoft, fontSize: 10),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 — DPR-aware sizing recipe.
// ===========================================================================

Widget _buildDprRecipeSection() {
  const List<double> dprs = <double>[1.0, 1.5, 2.0, 2.5, 3.0];
  const List<ui.TargetImageSize> tisPerDpr = <ui.TargetImageSize>[
    _tisDpr1,
    _tisDpr1_5,
    _tisDpr2,
    _tisDpr2_5,
    _tisDpr3,
  ];
  const List<String> notes = <String>[
    'Old Android tablets, Web on Linux desktop.',
    'Mid-range Android phones, some Chromebooks.',
    'Most iPhones, retina iPads, retina MacBooks.',
    'Pixel high-DPI variants, some foldables.',
    'Flagship phones (Pixel 8 Pro, S24 Ultra, iPhone Pro Max).',
  ];

  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 5 · density',
          title: 'DPR-aware TargetImageSize',
          subtitle:
              'Multiply your logical widget size by the device pixel ratio before you hand it to the decoder.',
          gradient: _kHeaderGradientF,
          icon: Icons.tablet_android,
        ),
        _kGap20,
        _prose(
          'Flutter widgets are laid out in logical pixels, but the framebuffer is in physical pixels. '
          'The conversion factor is `MediaQuery.of(context).devicePixelRatio`. '
          'For a logical 100×100 widget you should hand the decoder a TargetImageSize whose width and height equal 100 × DPR — anything smaller and the bitmap upscales (blurry); anything larger and you waste memory.',
        ),
        _kGap16,
        _prose(
          'The five rows below show the same logical 100×100 widget at five common device pixel ratios. '
          'Notice how the byte cost moves from 40 KB at DPR 1.0 to 360 KB at DPR 3.0 — a 9× change for the same on-screen size. '
          'When you skip the multiplication and always decode at 100×100 you ship a soft, low-res image to your highest-end users; when you always decode at 300×300 you triple the bytes for low-DPR users who will never see the difference.',
        ),
        _kGap16,
        Column(
          children: List<Widget>.generate(
            dprs.length,
            (int i) => Padding(
              padding: EdgeInsets.only(bottom: i == dprs.length - 1 ? 0 : 10),
              child: _dprRow(
                dpr: dprs[i],
                tis: tisPerDpr[i],
                note: notes[i],
              ),
            ),
          ),
        ),
        _kGap16,
        _prose(
          'A common pattern in production codebases is a top-level helper that takes a logical Size and returns a TargetImageSize: '
          '`TargetImageSize(width: (size.width * dpr).round(), height: (size.height * dpr).round())`. '
          'The helper is small enough to be inlined, but the discipline of always going through it eliminates the entire class of "blurry on retina" bugs.',
        ),
      ],
    ),
  );
}

Widget _dprRow({
  required double dpr,
  required ui.TargetImageSize tis,
  required String note,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: _kRadiusMd,
      border: Border.all(color: _kRule, width: 1),
      boxShadow: _kInsetShadow,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: _kHeaderGradientH,
            borderRadius: _kRadiusSm,
            boxShadow: _kGlowAccent,
          ),
          alignment: Alignment.center,
          child: Text(
            'DPR\n${dpr.toStringAsFixed(1)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ),
        _kHGap16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'logical 100 × 100  →  ${_tisLabel(tis)}',
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note,
                style: const TextStyle(color: _kInkSoft, fontSize: 12),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: <Widget>[
                  _chip(
                    'bytes ${_bytesHuman(_tisBytes(tis))}',
                    icon: Icons.memory,
                    fg: _kAccent,
                  ),
                  _chip(
                    'aspect ${_aspectLabel(tis)}',
                    icon: Icons.crop_din,
                    fg: _kAccentB,
                  ),
                ],
              ),
            ],
          ),
        ),
        _kHGap12,
        // Visual: a 100x100 logical box, scaled physically by dpr.
        SizedBox(
          width: 96,
          height: 96,
          child: Stack(
            children: <Widget>[
              // Logical box (always 32x32)
              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _kAccent.withValues(alpha: 0.2),
                    borderRadius: _kRadiusXs,
                    border: Border.all(color: _kAccent, width: 1.2),
                  ),
                ),
              ),
              // Physical box scaled by dpr (cap so it fits in 96x96).
              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  width: (32.0 * dpr).clamp(32.0, 96.0),
                  height: (32.0 * dpr).clamp(32.0, 96.0),
                  decoration: BoxDecoration(
                    color: _kAccentB.withValues(alpha: 0.12),
                    borderRadius: _kRadiusXs,
                    border: Border.all(color: _kAccentB, width: 1.4),
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

// ===========================================================================
// SECTION 7 — Comparison vs no resize.
// ===========================================================================

Widget _buildComparisonSection() {
  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 6 · before / after',
          title: 'With and without TargetImageSize',
          subtitle:
              'A side-by-side panel that turns the API into bytes you can feel.',
          gradient: _kHeaderGradientG,
          icon: Icons.compare,
        ),
        _kGap20,
        _prose(
          'Both panels below describe the same source image — a 4032×3024 photograph that comes off a modern phone camera. '
          'On the left, the decoder is given no TargetImageSize and emits a full-resolution RGBA bitmap of about 46 MB. '
          'On the right, the decoder is given a 1080×810 TargetImageSize tuned to a 16:9 hero slot at 1.5× DPR and emits a roughly 3.3 MB bitmap. '
          'The widget tree is identical; the only thing that changes is the hint.',
        ),
        _kGap20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _comparisonCard(
                title: 'No TargetImageSize',
                tis: _tisCompareSourceish,
                accent: _kAccentE,
                glow: _kGlowWarn,
                bullet:
                    'Decoder emits full source resolution (4032×3024 ≈ 46 MB).',
              ),
            ),
            _kHGap16,
            Expanded(
              child: _comparisonCard(
                title: 'TargetImageSize(1080×810)',
                tis: _tisCompareHinted,
                accent: _kAccentD,
                glow: _kGlowOk,
                bullet:
                    'Decoder emits a hero-sized bitmap (1080×810 ≈ 3.3 MB).',
              ),
            ),
          ],
        ),
        _kGap20,
        _comparisonDelta(),
        _kGap16,
        _prose(
          'The delta is roughly 13× — the same screen, the same widget, the same source. '
          'On a phone with 4 GB of RAM and a half-dozen images on screen, the difference between "works" and "OOM" can come down to whether someone remembered to add a TargetImageSize callback.',
        ),
      ],
    ),
  );
}

Widget _comparisonCard({
  required String title,
  required ui.TargetImageSize tis,
  required Color accent,
  required List<BoxShadow> glow,
  required String bullet,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: _kRadiusMd,
      border: Border.all(color: accent, width: 1.4),
      boxShadow: glow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: _tisAspect(tis) == 0 ? 1 : _tisAspect(tis),
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              borderRadius: _kRadiusXs,
              border: Border.all(color: accent, width: 1.2),
            ),
            alignment: Alignment.center,
            child: Text(
              _tisLabel(tis),
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _kvRow('Width', '${tis.width}'),
        _kvRow('Height', '${tis.height}'),
        _kvRow('Bytes', _bytesHuman(_tisBytes(tis)), valueColor: accent),
        _kvRow('Aspect', _aspectLabel(tis)),
        const SizedBox(height: 6),
        Text(
          bullet,
          style: const TextStyle(color: _kInkSoft, fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _comparisonDelta() {
  final int leftBytes = _tisBytes(_tisCompareSourceish);
  final int rightBytes = _tisBytes(_tisCompareHinted);
  final double ratio = rightBytes == 0 ? 0 : leftBytes / rightBytes;
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: _kHeaderGradientA,
      borderRadius: _kRadiusMd,
      boxShadow: _kHeaderShadow,
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.compare_arrows, color: _kInk, size: 28),
        _kHGap12,
        Expanded(
          child: Text(
            'Memory delta: ${_bytesHuman(leftBytes)} → ${_bytesHuman(rightBytes)}  '
            '(${ratio.toStringAsFixed(1)}× smaller)',
            style: const TextStyle(
              color: _kInk,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — Footgun panel.
// ===========================================================================

Widget _buildFootgunSection() {
  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 7 · footguns',
          title: 'Common TargetImageSize mistakes',
          subtitle:
              'Four classic ways to misuse the API — each illustrated and labelled.',
          gradient: _kHeaderGradientB,
          icon: Icons.warning_amber,
        ),
        _kGap20,
        _prose(
          'TargetImageSize is small enough that misuse comes from the surrounding code rather than the API itself. '
          'The four footguns below cover the bulk of real-world mistakes: invalid arguments, aspect-ratio mismatch, the logical-vs-physical confusion, and the silent forget on hero images. '
          'Each panel shows the wrong sizing, the visual symptom, and the right fix.',
        ),
        _kGap20,
        _footgunCard(
          title: 'FOOTGUN 1 — Zero or negative arguments',
          accent: _kAccentE,
          headline: 'TargetImageSize(width: 0, height: -10)',
          symptom:
              'The constructor asserts in debug; in release the decoder may produce zero-sized output that fails downstream.',
          fix:
              'Always validate user-derived sizes before constructing TargetImageSize. Width and height, if non-null, must be strictly positive integers.',
          visualBuilder: _footgunVisualInvalid,
        ),
        _kGap16,
        _footgunCard(
          title: 'FOOTGUN 2 — Aspect-ratio mismatch',
          accent: _kAccentC,
          headline:
              'TargetImageSize(width: 600, height: 200)  for a 4:3 photo',
          symptom:
              'The decoded bitmap is squashed: the photo gets a 3:1 frame so faces and skylines look distorted.',
          fix:
              'Either match the source aspect ratio in the TargetImageSize, or pass only one axis (width or height) and let the decoder preserve the source ratio.',
          visualBuilder: _footgunVisualSquashed,
        ),
        _kGap16,
        _footgunCard(
          title: 'FOOTGUN 3 — Logical instead of physical pixels',
          accent: _kAccentB,
          headline:
              'TargetImageSize(width: 100, height: 100) on a 3.0 DPR phone',
          symptom:
              'The bitmap is upscaled by Skia to fill 300 physical pixels — the result is visibly soft and blurry.',
          fix:
              'Multiply the logical Size by `MediaQuery.of(context).devicePixelRatio` before constructing TargetImageSize. That gives you 300×300 on a flagship.',
          visualBuilder: _footgunVisualBlurry,
        ),
        _kGap16,
        _footgunCard(
          title: 'FOOTGUN 4 — Forgetting the hint on hero images',
          accent: _kAccentD,
          headline: 'No TargetImageSize on a 4K source',
          symptom:
              'A single 3840×2160 image consumes 33 MB of RGBA after decode. Three of them and the GPU stutters or the OS kills the process.',
          fix:
              'Always pass at least a coarse TargetImageSize on hero images, even if you guess slightly wrong. Anything is better than the unhinted full decode.',
          visualBuilder: _footgunVisualGiant,
        ),
      ],
    ),
  );
}

Widget _footgunCard({
  required String title,
  required Color accent,
  required String headline,
  required String symptom,
  required String fix,
  required Widget Function(Color) visualBuilder,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: _kRadiusMd,
      boxShadow: _kInsetShadow,
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: _kRadiusXs,
                border: Border.all(color: accent, width: 1),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        _kGap12,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    headline,
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _kvRow('Symptom', symptom),
                  _kvRow('Fix', fix, valueColor: _kAccentD),
                ],
              ),
            ),
            _kHGap16,
            Expanded(child: visualBuilder(accent)),
          ],
        ),
      ],
    ),
  );
}

Widget _footgunVisualInvalid(Color accent) {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _kSurfaceDeep,
      borderRadius: _kRadiusSm,
      border: Border.all(color: accent, width: 1),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.error_outline, color: accent, size: 28),
        const SizedBox(height: 6),
        Text(
          'assertion failure\nwidth > 0 && height > 0',
          textAlign: TextAlign.center,
          style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget _footgunVisualSquashed(Color accent) {
  // Draw a 3:1 box on top of a 4:3 dashed box to convey distortion.
  return SizedBox(
    height: 110,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: _kRadiusXs,
              border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              'source 4:3',
              style: TextStyle(color: accent, fontSize: 10),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.22),
              borderRadius: _kRadiusXs,
              border: Border.all(color: accent, width: 1.4),
            ),
            alignment: Alignment.center,
            child: Text(
              '600×200 hint',
              style: TextStyle(color: _kInk, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footgunVisualBlurry(Color accent) {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _kSurfaceDeep,
      borderRadius: _kRadiusSm,
      border: Border.all(color: accent, width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              borderRadius: _kRadiusXs,
              border: Border.all(color: accent, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              'logical\n100×100',
              textAlign: TextAlign.center,
              style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const Icon(Icons.arrow_forward, color: _kInkMute, size: 18),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: _kRadiusXs,
              border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              'physical\n300×300',
              textAlign: TextAlign.center,
              style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footgunVisualGiant(Color accent) {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _kSurfaceDeep,
      borderRadius: _kRadiusSm,
      border: Border.all(color: accent, width: 1),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.memory, color: accent, size: 28),
        const SizedBox(height: 6),
        Text(
          '${_bytesHuman(_tisBytes(_tisFootgunForgotOn4K))} per image',
          style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        const Text(
          '×3 on screen → OOM',
          style: TextStyle(color: _kInkSoft, fontSize: 10),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 — Practical recipe gallery.
// ===========================================================================

Widget _buildPracticalRecipeSection() {
  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 8 · recipes',
          title: 'Real-world TargetImageSize recipes',
          subtitle:
              'Six concrete slots and the TargetImageSize you should use for each.',
          gradient: _kHeaderGradientC,
          icon: Icons.menu_book,
        ),
        _kGap20,
        _prose(
          'These recipes assume a high-DPR target (the multiplier is already baked in). '
          'They cover the slots that appear on almost every product: avatar, list thumbnail, hero banner, full-screen photo viewer, chat bubble image, and product card. '
          'Pick the closest one as a starting point and tune from there with measured byte counts in DevTools.',
        ),
        _kGap20,
        _recipeCard(
          accent: _kAccent,
          slot: 'Avatar (header, comments)',
          tis: _tisRecipeAvatar,
          notes:
              'Square 1:1, ~64 logical px on a 1×–2× device (so 64 × 64 ≈ 16 KB). '
              'Bump to 96 × 96 if you also use the same image as a profile peek.',
          gradient: _kHeaderGradientA,
        ),
        _kGap12,
        _recipeCard(
          accent: _kAccentB,
          slot: 'List thumbnail (chat list, search results)',
          tis: _tisRecipeListThumb,
          notes:
              '88 × 88 is the sweet spot: large enough for retina at 1×, small enough that 100 visible rows still fit a couple of MB of bitmaps in cache.',
          gradient: _kHeaderGradientB,
        ),
        _kGap12,
        _recipeCard(
          accent: _kAccentC,
          slot: 'Hero banner (16:9 article header)',
          tis: _tisRecipeHeroBanner,
          notes:
              '1080 × 608 covers a 360 logical px wide phone at 3× DPR. '
              'Roughly 2.6 MB after decode — well within budget for a single screen.',
          gradient: _kHeaderGradientC,
        ),
        _kGap12,
        _recipeCard(
          accent: _kAccentD,
          slot: 'Full-screen photo viewer',
          tis: _tisRecipeFullScreen,
          notes:
              'Match the physical resolution of a flagship phone. '
              'Use only when the user has explicitly opened the photo for inspection — the bytes are not free.',
          gradient: _kHeaderGradientD,
        ),
        _kGap12,
        _recipeCard(
          accent: _kAccentE,
          slot: 'Chat-bubble image preview',
          tis: _tisRecipeChatBubble,
          notes:
              '360 × 360 is enough for tap-to-expand thumbnails inside a 70 % wide bubble. '
              'Tap-to-expand transitions to the full-screen viewer recipe above.',
          gradient: _kHeaderGradientE,
        ),
        _kGap12,
        _recipeCard(
          accent: _kAccentF,
          slot: 'Product card (e-commerce grid)',
          tis: _tisRecipeProductCard,
          notes:
              '512 × 512 hits the spot for a 2-column grid on tablets at 2× DPR. '
              'Keep it square; clients always change their crop policy.',
          gradient: _kHeaderGradientF,
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required Color accent,
  required String slot,
  required ui.TargetImageSize tis,
  required String notes,
  required LinearGradient gradient,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: _kRadiusMd,
      boxShadow: _kInsetShadow,
      border: Border.all(color: _kRule, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: _kRadiusSm,
            boxShadow: _kHeaderShadow,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.image, color: _kInk, size: 28),
        ),
        _kHGap16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                slot,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'TargetImageSize ${_tisLabel(tis)}  ·  ${_bytesHuman(_tisBytes(tis))}  ·  ${_aspectLabel(tis)}',
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notes,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
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

// ===========================================================================
// SECTION 10 — API summary table.
// ===========================================================================

Widget _buildApiSummarySection() {
  return _surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionHeader(
          overline: 'section 9 · API reference',
          title: 'TargetImageSize API summary',
          subtitle:
              'Constructor, fields, related callbacks and where they sit in the dart:ui pipeline.',
          gradient: _kHeaderGradientH,
          icon: Icons.code,
        ),
        _kGap20,
        _apiRow(
          name: 'TargetImageSize({width, height})',
          summary:
              'Const constructor. Both arguments are nullable named ints. Asserts non-null arguments are positive.',
          accent: _kAccent,
        ),
        _apiRow(
          name: 'final int? width',
          summary:
              'Decoded bitmap width. Null means "match aspect ratio to height" or, if both are null, decode at intrinsic size.',
          accent: _kAccentB,
        ),
        _apiRow(
          name: 'final int? height',
          summary:
              'Decoded bitmap height. Same rules as width — null means "follow the source aspect ratio relative to width".',
          accent: _kAccentC,
        ),
        _apiRow(
          name: 'TargetImageSizeCallback',
          summary:
              'typedef TargetImageSize Function(int intrinsicWidth, int intrinsicHeight). The callback you pass to instantiateImageCodecWithSize.',
          accent: _kAccentD,
        ),
        _apiRow(
          name: 'instantiateImageCodecWithSize',
          summary:
              'Top-level dart:ui function. Calls your TargetImageSizeCallback with the source intrinsic size and decodes into the returned hint.',
          accent: _kAccentE,
        ),
        _apiRow(
          name: 'ImageDescriptor',
          summary:
              'Lower-level entry point exposing intrinsic size. Use this if you need to inspect EXIF / colour space before sizing.',
          accent: _kAccentF,
        ),
        _kGap16,
        _prose(
          'TargetImageSize is the leaf of a small but important graph: ImageDescriptor knows the intrinsic size, '
          'TargetImageSizeCallback decides what to ask for, instantiateImageCodecWithSize wires them together, '
          'and the resulting Codec yields a single decoded ImageInfo with a properly-sized Image. '
          'You almost never construct TargetImageSize from application code directly — the value usually flows through ImageProvider.resolve and ResizeImage. '
          'Knowing the leaf still matters because every higher-level abstraction reduces to it.',
        ),
      ],
    ),
  );
}

Widget _apiRow({
  required String name,
  required String summary,
  required Color accent,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: _kRadiusSm,
        border: Border.all(color: _kRule, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 36,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          _kHGap12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  summary,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 11 — Closing.
// ===========================================================================

Widget _buildClosingSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: _kHeaderGradientA,
      borderRadius: _kRadiusLg,
      boxShadow: _kHeaderShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.check_circle, color: _kInk, size: 28),
            _kHGap12,
            const Expanded(
              child: Text(
                'TargetImageSize, in three sentences',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        _kGap12,
        const Text(
          'It is the size hint passed to instantiateImageCodec. '
          'It is two nullable positive integers. '
          'It is the difference between an app that scrolls and an app that crashes.',
          style: TextStyle(
            color: _kInk,
            fontSize: 14,
            height: 1.55,
            fontWeight: FontWeight.w500,
          ),
        ),
        _kGap16,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _chip('width × height × 4', icon: Icons.functions, fg: _kInk),
            _chip('match DPR', icon: Icons.tablet_android, fg: _kInk),
            _chip('match aspect', icon: Icons.crop_din, fg: _kInk),
            _chip('always hint hero images', icon: Icons.image, fg: _kInk),
          ],
        ),
      ],
    ),
  );
}
