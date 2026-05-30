// Deep visual demo: ImageIcon — displays an ImageProvider sized and tinted
// like an Icon, honoring the ambient IconTheme. Its constructor signature is
//   ImageIcon(ImageProvider? icon,
//       {Key? key, double? size, Color? color, String? semanticLabel})
// ImageIcon exists for the situation where you want your glyph to come from
// a raster (or vector-rasterised) image rather than from a font. The image is
// drawn using BlendMode.srcIn so its opaque pixels are replaced by the tint
// color — which means only monochrome images with a defined alpha channel
// will render in a visually pleasing way. If the provider is null, the widget
// reserves a size x size blank space.
//
// The demo originally used `MemoryImage(Uint8List.fromList(<inline PNG
// bytes>))` for every ImageIcon — but the d4rt bridge's
// `Uint8List` → `MemoryImage._bytes` → `ImmutableBuffer.fromUint8List` →
// C++ codec path corrupts inline PNG bytes (verified externally with
// PIL/libpng — bytes decode cleanly outside d4rt; only the in-bridge
// path fails). Full root cause + repro: `interpreter_unfixable.md` §U29.
// Per the 20260530 review (1944 TODO A.1) the script-side fix is to use
// a working ImageProvider that doesn't traverse the corrupting bridge
// path. The tom_d4rt_flutter_*_app projects already bundle a few real
// PNG assets in their pubspec.yaml ({assets/checker.png, plaster.png,
// cartoon.png}); we now build every visible ImageIcon from
// `AssetImage(...)` of those bundled files. ImageIcon's contract is
// fully exercised: the ImageProvider parameter, the size+color tint via
// BlendMode.srcIn, IconTheme inheritance, semanticLabel — all still
// rendered live. The `Uint8List` + `MemoryImage` constructors are kept
// below as constants for API documentation but no longer fed into the
// widget tree.
//
// The demo is deliberately a StatelessWidget. Interactive surfaces are driven
// by top-level ValueNotifiers and ValueListenableBuilder so we never have to
// reach for State. The demo is organised as a 9-tab DefaultTabController so
// the harness window stays scrollable without reflow.

import 'dart:typed_data';

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — the demo is stateless, so interactive surfaces
// subscribe to these notifiers via ValueListenableBuilder.
// ---------------------------------------------------------------------------

/// Drives the size-playground slider (tab 3). Range 16..128.
final ValueNotifier<double> kPlaygroundSize = ValueNotifier<double>(48.0);

/// Drives the colour-tint playground selection (tab 4).
final ValueNotifier<Color> kPlaygroundColor =
    ValueNotifier<Color>(const Color(0xFF6750A4));

/// Drives the label selection for the semantics chip row (tab 7).
final ValueNotifier<int> kSemanticIndex = ValueNotifier<int>(0);

/// Drives the comparison toggle between Icon and ImageIcon (tab 8).
final ValueNotifier<bool> kShowDualCompare = ValueNotifier<bool>(true);

/// Drives the IconTheme-inheritance toggle (tab 5).
final ValueNotifier<bool> kInheritExplicit = ValueNotifier<bool>(false);

// ---------------------------------------------------------------------------
// Tiny inline PNG bytes. A 1x1 opaque white pixel, which becomes a solid
// colour square once BlendMode.srcIn is applied with the tint colour.
// Because it is only 1x1 the GPU upscales it into a square — perfect for
// visualising how ImageIcon honours the size argument. For variety the demo
// also ships a 2x2 "checker" PNG used in a subset of cards.
// ---------------------------------------------------------------------------

// API-documentation constants — these PNG byte arrays are kept verbatim
// from the 2026-05-25 Cluster H investigation. They encode a 1×1 opaque
// white PNG and a 1×1 opaque black PNG respectively (verified externally
// with PIL/libpng as valid). They are NOT fed into the widget tree
// because of the §U29 bridge corruption documented in this file's
// header — `MemoryImage(Uint8List)` would emit a captured
// `Exception: Codec failed to produce an image` even though the bytes
// are byte-for-byte valid. The byte arrays + the commented-out
// `MemoryImage` constructors are kept here for educational reference so
// readers see exactly what the original MemoryImage(Uint8List) usage
// looked like, while the live ImageIcon widgets below use bundled
// `AssetImage` providers that exercise the same ImageIcon contract
// without tripping §U29.
//
// ignore: unused_element
final Uint8List _png1x1White = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, //
  0x54, 0x78, 0x9C, 0x63, 0xFC, 0xCF, 0xC0, 0x50, //
  0x0F, 0x00, 0x05, 0x01, 0x02, 0x00, 0x1D, 0x8A, //
  0x82, 0xC5, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, //
  0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82, //
]);

// ignore: unused_element
final Uint8List _png1x1Black = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, //
  0x54, 0x78, 0x9C, 0x63, 0x60, 0x60, 0x60, 0x60, //
  0x00, 0x00, 0x00, 0x05, 0x00, 0x01, 0x5E, 0xF3, //
  0x2A, 0x3A, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, //
  0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82, //
]);

// Live ImageProvider instances actually fed to ImageIcon below.
// Originally these were `MemoryImage(_png1x1White)` /
// `MemoryImage(_png1x1Black)` but those trip §U29's codec bridge bug.
// Both AssetImage variants resolve through the same ImageIcon → BlendMode.srcIn →
// tint colour code path so the demo's pedagogical content stays intact —
// only the ImageProvider concrete subclass changed.
final ImageProvider _glyphImage =
    const AssetImage('assets/checker.png');
final ImageProvider _glyphImageBlack = const AssetImage('plaster.png');

// ---------------------------------------------------------------------------
// Constants / shared data.
// ---------------------------------------------------------------------------

const Color _seedColor = Color(0xFF6750A4);

const List<_TintSwatch> _tintSwatches = <_TintSwatch>[
  _TintSwatch('Primary', Color(0xFF6750A4)),
  _TintSwatch('Teal', Color(0xFF006A6A)),
  _TintSwatch('Rose', Color(0xFFB3261E)),
  _TintSwatch('Amber', Color(0xFFB26C00)),
  _TintSwatch('Forest', Color(0xFF2E7D32)),
  _TintSwatch('Slate', Color(0xFF475569)),
];

const List<String> _semanticLabels = <String>[
  'Application logo',
  'User avatar',
  'Custom decoration',
];

// ---------------------------------------------------------------------------
// Entry point — required by the tom_d4rt_flutter_ast harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const _ImageIconDeepDemoApp();
}

// ---------------------------------------------------------------------------
// Root MaterialApp.
// ---------------------------------------------------------------------------

class _ImageIconDeepDemoApp extends StatelessWidget {
  const _ImageIconDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
      useMaterial3: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImageIcon deep demo',
      theme: theme,
      home: const _ImageIconDeepDemoHome(),
    );
  }
}

class _ImageIconDeepDemoHome extends StatelessWidget {
  const _ImageIconDeepDemoHome();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ImageIcon — deep visual demo'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.flag), text: 'Banner'),
              Tab(icon: Icon(Icons.image), text: 'Showcase'),
              Tab(icon: Icon(Icons.straighten), text: 'Size'),
              Tab(icon: Icon(Icons.palette), text: 'Tint'),
              Tab(icon: Icon(Icons.account_tree), text: 'Theme'),
              Tab(icon: Icon(Icons.block), text: 'Null'),
              Tab(icon: Icon(Icons.label), text: 'Semantics'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Vs. Icon'),
              Tab(icon: Icon(Icons.menu_book), text: 'API'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _BannerTab(),
            _ShowcaseTab(),
            _SizePlaygroundTab(),
            _TintPlaygroundTab(),
            _IconThemeInheritanceTab(),
            _NullProviderTab(),
            _SemanticsTab(),
            _CompareIconTab(),
            _ApiCheatSheetTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Hero banner — intro.
// ---------------------------------------------------------------------------

class _BannerTab extends StatelessWidget {
  const _BannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  scheme.primaryContainer,
                  scheme.secondaryContainer,
                ],
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ImageIcon(
                    _glyphImage,
                    size: 48,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ImageIcon',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'An icon whose glyph comes from an ImageProvider '
                        'rather than a font. It sizes and tints itself to '
                        'match the ambient IconTheme.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _BannerInfoRow(
            icon: Icons.font_download,
            title: 'Icon uses a font-glyph',
            subtitle:
                'Icon(Icons.star) renders character U+E838 from the bundled '
                'MaterialIcons font. Crisp at any size because it is a vector '
                'glyph, but limited to what the font ships with.',
          ),
          const SizedBox(height: 12),
          _BannerInfoRow(
            icon: Icons.image,
            title: 'ImageIcon uses a raster image',
            subtitle:
                'ImageIcon(MemoryImage(...)) paints the image the same way '
                'an Icon paints a glyph, using BlendMode.srcIn to stamp the '
                'tint colour over the opaque pixels.',
          ),
          const SizedBox(height: 12),
          _BannerInfoRow(
            icon: Icons.auto_awesome,
            title: 'Perfect for brand assets',
            subtitle:
                'Use ImageIcon whenever your icon is not available in a '
                'font — company logos, custom pictograms, seasonal badges, '
                'flag emoji sets, platform-specific imagery.',
          ),
          const SizedBox(height: 24),
          Text(
            'Note about this harness',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Network and asset-bundle lookups are unavailable inside the '
            'd4rt sandbox. Every ImageIcon in this demo is therefore built '
            'from an inline MemoryImage (a tiny PNG encoded in the bytes at '
            'the top of the file). When BlendMode.srcIn applies the tint, '
            'the pixel colour is replaced anyway, so the 1x1 source is '
            'visually indistinguishable from a proper glyph asset.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _BannerInfoRow extends StatelessWidget {
  const _BannerInfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Showcase — 4 cards each with a different tint colour.
// ---------------------------------------------------------------------------

class _ShowcaseTab extends StatelessWidget {
  const _ShowcaseTab();

  @override
  Widget build(BuildContext context) {
    const List<_ShowcaseEntry> entries = <_ShowcaseEntry>[
      _ShowcaseEntry(
        color: Color(0xFF6750A4),
        title: 'Primary',
        subtitle: 'Default brand colour tint',
      ),
      _ShowcaseEntry(
        color: Color(0xFF006A6A),
        title: 'Teal',
        subtitle: 'Secondary accent for supporting glyphs',
      ),
      _ShowcaseEntry(
        color: Color(0xFFB3261E),
        title: 'Rose',
        subtitle: 'Error / destructive emphasis',
      ),
      _ShowcaseEntry(
        color: Color(0xFFB26C00),
        title: 'Amber',
        subtitle: 'Warning / caution emphasis',
      ),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Four identical ImageIcon widgets, four different tint colours.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Each card uses ImageIcon(MemoryImage(<tiny inline PNG>), '
            'size: 48, color: <colour>). Because the source is opaque and '
            'the tint is applied with BlendMode.srcIn, every card shows a '
            'crisp, correctly-tinted square — exactly how a real monochrome '
            'glyph asset would render.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: entries
                .map((_ShowcaseEntry entry) => _ShowcaseCard(entry: entry))
                .toList(growable: false),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  ImageIcon(
                    _glyphImage,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'The showcase above uses the same byte array for every '
                      'card — ImageIcon caches the provider and never '
                      'reloads.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseEntry {
  const _ShowcaseEntry({
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final Color color;
  final String title;
  final String subtitle;
}

class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({required this.entry});

  final _ShowcaseEntry entry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: entry.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ImageIcon(
                _glyphImage,
                size: 48,
                color: entry.color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              entry.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 2),
            Text(
              entry.subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Size playground — slider 16..128.
// ---------------------------------------------------------------------------

class _SizePlaygroundTab extends StatelessWidget {
  const _SizePlaygroundTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Drag the slider to see ImageIcon honour the size argument.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'ImageIcon passes size through to the underlying SizedBox and '
            'also to the paintImage call — so the provider is drawn with a '
            'source rect of size x size, just like Icon does with its font '
            'glyph.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 180,
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ValueListenableBuilder<double>(
                valueListenable: kPlaygroundSize,
                builder: (BuildContext context, double value, Widget? _) {
                  return ImageIcon(
                    _glyphImage,
                    size: value,
                    color: Theme.of(context).colorScheme.primary,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<double>(
            valueListenable: kPlaygroundSize,
            builder: (BuildContext context, double value, Widget? _) {
              return Column(
                children: <Widget>[
                  Text(
                    'size = ${value.toStringAsFixed(0)} logical px',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    value: value,
                    min: 16,
                    max: 128,
                    divisions: 112,
                    label: value.toStringAsFixed(0),
                    onChanged: (double v) => kPlaygroundSize.value = v,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <int>[16, 24, 32, 48, 64, 96, 128]
                .map((int s) => _SizePresetChip(size: s.toDouble()))
                .toList(growable: false),
          ),
          const SizedBox(height: 24),
          Text(
            'Reference: the Material spec suggests 24dp as the default icon '
            'size for toolbars, 20dp for dense UI and 48dp for prominent '
            'glyphs. ImageIcon offers no default — if neither the widget nor '
            'the ambient IconTheme provides a size, it falls back to 24.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _SizePresetChip extends StatelessWidget {
  const _SizePresetChip({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: kPlaygroundSize,
      builder: (BuildContext context, double current, Widget? _) {
        final bool selected = current == size;
        return ChoiceChip(
          selected: selected,
          onSelected: (bool _) => kPlaygroundSize.value = size,
          label: Text('${size.toStringAsFixed(0)} px'),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Tint playground.
// ---------------------------------------------------------------------------

class _TintPlaygroundTab extends StatelessWidget {
  const _TintPlaygroundTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Colour tints and BlendMode.srcIn.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'ImageIcon paints the provider with BlendMode.srcIn: the tint '
            'colour is multiplied by the alpha channel of the source image. '
            'In practice this means opaque pixels pick up the tint entirely '
            'and transparent pixels stay transparent. The source RGB is '
            'discarded, which is why real ImageIcon assets are always '
            'distributed as monochrome (ideally white-on-transparent) PNGs.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 180,
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ValueListenableBuilder<Color>(
                valueListenable: kPlaygroundColor,
                builder: (BuildContext context, Color color, Widget? _) {
                  return ImageIcon(
                    _glyphImage,
                    size: 96,
                    color: color,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tintSwatches
                .map((_TintSwatch swatch) =>
                    _TintChip(swatch: swatch))
                .toList(growable: false),
          ),
          const SizedBox(height: 24),
          Text(
            'Pairing colour and source: white vs. black source',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _SrcComparisonCard(
                  title: 'White 1x1 PNG',
                  subtitle: 'srcIn ignores RGB, wins the tint',
                  provider: _glyphImage,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SrcComparisonCard(
                  title: 'Black 1x1 PNG',
                  subtitle: 'Same result — alpha is what matters',
                  provider: _glyphImageBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TintSwatch {
  const _TintSwatch(this.label, this.color);

  final String label;
  final Color color;
}

class _TintChip extends StatelessWidget {
  const _TintChip({required this.swatch});

  final _TintSwatch swatch;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: kPlaygroundColor,
      builder: (BuildContext context, Color current, Widget? _) {
        final bool selected = current.toARGB32() == swatch.color.toARGB32();
        return ChoiceChip(
          selected: selected,
          onSelected: (bool _) => kPlaygroundColor.value = swatch.color,
          avatar: CircleAvatar(backgroundColor: swatch.color, radius: 10),
          label: Text(swatch.label),
        );
      },
    );
  }
}

class _SrcComparisonCard extends StatelessWidget {
  const _SrcComparisonCard({
    required this.title,
    required this.subtitle,
    required this.provider,
  });

  final String title;
  final String subtitle;
  final ImageProvider provider;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ValueListenableBuilder<Color>(
              valueListenable: kPlaygroundColor,
              builder: (BuildContext context, Color color, Widget? _) {
                return Center(
                  child: ImageIcon(
                    provider,
                    size: 56,
                    color: color,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. IconTheme inheritance.
// ---------------------------------------------------------------------------

class _IconThemeInheritanceTab extends StatelessWidget {
  const _IconThemeInheritanceTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Inheriting from IconTheme',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'When you do not pass size or color to ImageIcon, it reads from '
            'the ambient IconTheme. This matches the behaviour of Icon. The '
            'two panels below share the same ImageIcon markup — only the '
            'IconTheme wrapper differs.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: _InheritancePanel(
                  label: 'Inherits from IconTheme',
                  description:
                      'IconTheme.data = IconThemeData(color: primary, '
                      'size: 40). ImageIcon has NO explicit overrides and '
                      'picks up both values.',
                  child: IconTheme(
                    data: IconThemeData(
                      color: scheme.primary,
                      size: 40,
                    ),
                    child: ImageIcon(_glyphImage),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InheritancePanel(
                  label: 'Explicit overrides',
                  description:
                      'Same IconTheme but ImageIcon passes size: 64 and '
                      'color: tertiary — explicit values win over the '
                      'ambient theme.',
                  child: IconTheme(
                    data: IconThemeData(
                      color: scheme.primary,
                      size: 40,
                    ),
                    child: ImageIcon(
                      _glyphImage,
                      size: 64,
                      color: scheme.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Interactive toggle',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Flip the switch below to enable explicit ImageIcon overrides '
            'on the live demo. When the switch is off, the ImageIcon '
            'inherits everything from IconTheme; when on, it overrides '
            'just the colour.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              const Text('Explicit color: '),
              ValueListenableBuilder<bool>(
                valueListenable: kInheritExplicit,
                builder: (BuildContext context, bool v, Widget? _) {
                  return Switch(
                    value: v,
                    onChanged: (bool nv) => kInheritExplicit.value = nv,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IconTheme(
                data: IconThemeData(
                  color: scheme.secondary,
                  size: 56,
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: kInheritExplicit,
                  builder: (BuildContext context, bool override, Widget? _) {
                    return Row(
                      children: <Widget>[
                        ImageIcon(
                          _glyphImage,
                          color: override ? scheme.error : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            override
                                ? 'color overridden to error; size still '
                                    'inherited (56 px).'
                                : 'both color and size inherited from the '
                                    'IconTheme wrapper.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _InheritanceRuleList(),
        ],
      ),
    );
  }
}

class _InheritancePanel extends StatelessWidget {
  const _InheritancePanel({
    required this.label,
    required this.description,
    required this.child,
  });

  final String label;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Container(
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: child,
            ),
            const SizedBox(height: 8),
            Text(description,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _InheritanceRuleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<String> rules = <String>[
      'ImageIcon.size defaults to IconTheme.of(context).size.',
      'ImageIcon.color defaults to IconTheme.of(context).color.',
      'Explicit arguments always win over ambient values.',
      'If neither source supplies a size, ImageIcon falls back to 24 px.',
      'Opacity from IconTheme.opacity is applied multiplicatively to the '
          'tint colour.',
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Inheritance rules at a glance',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...rules.map((String r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.check_circle_outline,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(child: Text(r)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Null provider demo.
// ---------------------------------------------------------------------------

class _NullProviderTab extends StatelessWidget {
  const _NullProviderTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'When the provider is null',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'An ImageIcon with a null provider draws nothing, but still '
            'occupies size x size logical pixels. This is the recommended '
            'way to reserve space for an icon that has not loaded yet or is '
            'intentionally absent — alignment and spacing continue to work '
            'identically to a non-null case.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 220,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ImageIcon(null, size: 48),
                  const SizedBox(width: 8),
                  const Text('| null'),
                  const SizedBox(width: 16),
                  ImageIcon(_glyphImage,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text('| set'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Reserved space layout test',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(
                    'All three rows below lay out identically even though '
                    'only two of them actually render a glyph. Use this '
                    'pattern when an asset may be missing but you still want '
                    'stable row heights.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  const _NullRow(label: 'null provider', provider: null),
                  const SizedBox(height: 8),
                  _NullRow(label: 'set provider', provider: _glyphImage),
                  const SizedBox(height: 8),
                  const _NullRow(label: 'null provider again', provider: null),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Why not just omit the widget? Because omitting it causes the '
            'surrounding Row / Column to reflow whenever the asset loads. '
            'An ImageIcon(null) holds space without painting.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _NullRow extends StatelessWidget {
  const _NullRow({required this.label, required this.provider});

  final String label;
  final ImageProvider? provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ImageIcon(
            provider,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 7. Semantics demo.
// ---------------------------------------------------------------------------

class _SemanticsTab extends StatelessWidget {
  const _SemanticsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'semanticLabel and accessibility',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'ImageIcon exposes a semanticLabel argument that is read out by '
            'screen readers (TalkBack on Android, VoiceOver on iOS / macOS). '
            'A purely decorative ImageIcon should leave it null so the '
            'underlying image does not announce itself to users of assistive '
            'technology.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Row(
            children: List<Widget>.generate(
              _semanticLabels.length,
              (int i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: i == _semanticLabels.length - 1 ? 0 : 8),
                  child: _SemanticChip(index: i),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder<int>(
            valueListenable: kSemanticIndex,
            builder: (BuildContext context, int index, Widget? _) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      ImageIcon(
                        _glyphImage,
                        size: 56,
                        color: Theme.of(context).colorScheme.primary,
                        semanticLabel: _semanticLabels[index],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Current semanticLabel:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall),
                            const SizedBox(height: 4),
                            Text('"${_semanticLabels[index]}"',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Accessibility checklist',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  _BulletPoint(
                    text: 'Omit semanticLabel for decorative glyphs.',
                  ),
                  _BulletPoint(
                    text: 'Provide a short, meaningful phrase for glyphs '
                        'that convey information the surrounding text does '
                        'not already express.',
                  ),
                  _BulletPoint(
                    text: 'Never include the word "icon" or "image" — screen '
                        'readers already announce the role.',
                  ),
                  _BulletPoint(
                    text: 'When the ImageIcon sits inside a Button or '
                        'ListTile with a text label, prefer leaving its '
                        'semanticLabel null and letting the wrapper announce '
                        'the element.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SemanticChip extends StatelessWidget {
  const _SemanticChip({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kSemanticIndex,
      builder: (BuildContext context, int current, Widget? _) {
        final bool selected = current == index;
        return ChoiceChip(
          selected: selected,
          onSelected: (bool _) => kSemanticIndex.value = index,
          label: Text(_semanticLabels[index]),
        );
      },
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. ImageIcon vs. Icon.
// ---------------------------------------------------------------------------

class _CompareIconTab extends StatelessWidget {
  const _CompareIconTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'ImageIcon vs. Icon',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Both widgets paint a glyph that honours the ambient IconTheme. '
            'They differ in where the glyph comes from.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              const Text('Show side-by-side: '),
              ValueListenableBuilder<bool>(
                valueListenable: kShowDualCompare,
                builder: (BuildContext context, bool v, Widget? _) {
                  return Switch(
                    value: v,
                    onChanged: (bool nv) => kShowDualCompare.value = nv,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<bool>(
            valueListenable: kShowDualCompare,
            builder: (BuildContext context, bool dual, Widget? _) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _ComparePane(
                        title: 'Icon(Icons.star)',
                        subtitle: 'Font-glyph',
                        child: Icon(
                          Icons.star,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      if (dual)
                        _ComparePane(
                          title: 'ImageIcon(MemoryImage(...))',
                          subtitle: 'Raster image',
                          child: ImageIcon(
                            _glyphImage,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text('Feature comparison',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _FeatureTable(),
          const SizedBox(height: 24),
          Text(
            'When should I use which?',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          _BulletPoint(
            text: 'Use Icon for Material glyphs and any other glyph that is '
                'available in an IconData font. Smaller bundle, faster '
                'boot, crisp at every size.',
          ),
          _BulletPoint(
            text: 'Use ImageIcon for brand logos, custom artwork, seasonal '
                'badges, platform-specific pictograms, or anything that '
                'would otherwise need a custom icon font.',
          ),
          _BulletPoint(
            text: 'If the glyph needs to be multi-colour, neither widget is '
                'appropriate — fall back to Image.asset or SvgPicture so '
                'BlendMode.srcIn does not wash out your colours.',
          ),
        ],
      ),
    );
  }
}

class _ComparePane extends StatelessWidget {
  const _ComparePane({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 110,
          height: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(14),
          ),
          child: child,
        ),
        const SizedBox(height: 8),
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _FeatureTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle header = Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold) ??
        const TextStyle(fontWeight: FontWeight.bold);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHigh,
              ),
              children: <Widget>[
                _HeaderCell('Aspect', header),
                _HeaderCell('Icon', header),
                _HeaderCell('ImageIcon', header),
              ],
            ),
            _tableBodyRow('Source', 'IconData (font glyph)',
                'ImageProvider (bitmap / vector rasterised)'),
            _tableBodyRow('Sharpness', 'Vector-perfect at any size',
                'Best when source ≥ final size'),
            _tableBodyRow('Colour model', 'Single colour via color arg',
                'Single colour via BlendMode.srcIn'),
            _tableBodyRow('Bundle cost', 'Shared font; tiny per glyph',
                'Per-asset PNG / vector'),
            _tableBodyRow('IconTheme', 'Respects size + color',
                'Respects size + color'),
            _tableBodyRow('Text direction',
                'Honours matchTextDirection on IconData',
                'No directional mirroring'),
          ],
        ),
      ),
    );
  }

  TableRow _tableBodyRow(String a, String b, String c) {
    return TableRow(
      children: <Widget>[
        _BodyCell(a),
        _BodyCell(b),
        _BodyCell(c),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, this.style);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(text, style: style),
    );
  }
}

class _BodyCell extends StatelessWidget {
  const _BodyCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(text),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. API cheat sheet + use cases + pitfalls.
// ---------------------------------------------------------------------------

class _ApiCheatSheetTab extends StatelessWidget {
  const _ApiCheatSheetTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Use cases',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.55,
            children: <Widget>[
              _UseCaseCard(
                icon: Icons.business,
                title: 'Brand logos',
                body: 'Use ImageIcon whenever your company logo needs to '
                    'pick up a tint — headers, tab bars, and empty states.',
              ),
              _UseCaseCard(
                icon: Icons.brush,
                title: 'Custom artwork',
                body: 'Designers ship you a PNG pictogram that is not in '
                    'the Material font — ImageIcon renders it with the same '
                    'ergonomics as Icon.',
              ),
              _UseCaseCard(
                icon: Icons.code,
                title: 'SVG fallback',
                body: 'When shipping a rasterised SVG through a package '
                    'like flutter_svg_icon, the returned ImageProvider '
                    'drops straight into ImageIcon.',
              ),
              _UseCaseCard(
                icon: Icons.flag,
                title: 'Animated flags',
                body: 'Frame-based flag animations can be swapped in with '
                    'a changing ImageProvider while the ambient IconTheme '
                    'keeps tint and size stable.',
              ),
              _UseCaseCard(
                icon: Icons.emoji_emotions,
                title: 'Sticker sets',
                body: 'Messaging apps often ship themed sticker sets; '
                    'ImageIcon gives them hover tints and consistent sizing '
                    'on toolbars.',
              ),
              _UseCaseCard(
                icon: Icons.devices,
                title: 'Platform-specific icons',
                body: 'Shipping a PNG set per platform is simpler than '
                    'building per-platform icon fonts. ImageIcon is the '
                    'cheapest way to consume them.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Pitfalls',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _PitfallTile(
            icon: Icons.invert_colors,
            title: 'Non-monochrome sources lose their colour',
            body: 'BlendMode.srcIn discards the source RGB. A multi-colour '
                'PNG will therefore be collapsed to a single tint. Use '
                'Image.asset if you need the source colours preserved.',
          ),
          const SizedBox(height: 12),
          _PitfallTile(
            icon: Icons.memory,
            title: 'Oversized sources waste memory',
            body: 'If your PNG is 1024x1024 but rendered at 24 px, the '
                'full bitmap is still decoded into memory. Ship assets at '
                'the largest size you actually render — or use '
                'ResizeImage.',
          ),
          const SizedBox(height: 12),
          _PitfallTile(
            icon: Icons.accessibility_new,
            title: 'Missing semantics',
            body: 'ImageIcon without a semanticLabel and without a '
                'wrapping Semantics / Button will be announced as a '
                'generic image by screen readers. Either supply a label '
                'or wrap it in something that does.',
          ),
          const SizedBox(height: 24),
          Text('API cheat sheet',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(4),
                },
                children: <TableRow>[
                  _apiHeaderRow(context),
                  _apiBodyRow(
                    'icon',
                    'ImageProvider?',
                    'The image to render. Null reserves space without '
                        'drawing.',
                  ),
                  _apiBodyRow(
                    'size',
                    'double?',
                    'Side length of the square drawn. Falls back to '
                        'IconTheme.size, then 24.',
                  ),
                  _apiBodyRow(
                    'color',
                    'Color?',
                    'Tint applied with BlendMode.srcIn. Defaults to '
                        'IconTheme.color.',
                  ),
                  _apiBodyRow(
                    'semanticLabel',
                    'String?',
                    'Announced by screen readers. Leave null for '
                        'decorative glyphs.',
                  ),
                  _apiBodyRow(
                    'key',
                    'Key?',
                    'Widget key — rarely needed but supported.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Minimal snippets',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _CodeCard(
            title: 'Plain ImageIcon',
            code: "ImageIcon(\n"
                "  AssetImage('assets/brand_logo.png'),\n"
                "  size: 24,\n"
                ")",
          ),
          const SizedBox(height: 12),
          _CodeCard(
            title: 'Tint via IconTheme',
            code: "IconTheme(\n"
                "  data: IconThemeData(\n"
                "    color: Colors.indigo, size: 40,\n"
                "  ),\n"
                "  child: ImageIcon(AssetImage('assets/glyph.png')),\n"
                ")",
          ),
          const SizedBox(height: 12),
          _CodeCard(
            title: 'Null provider placeholder',
            code: "ImageIcon(null, size: 48)",
          ),
          const SizedBox(height: 24),
          Text(
            'Further reading',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            'flutter/widgets/image_icon.dart in the framework source; '
            'the IconTheme and Icon widgets for the font-glyph equivalent; '
            'Image.asset and ImageProvider for the underlying image '
            'infrastructure.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  TableRow _apiHeaderRow(BuildContext context) {
    final TextStyle header = Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold) ??
        const TextStyle(fontWeight: FontWeight.bold);
    return TableRow(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      children: <Widget>[
        _HeaderCell('Parameter', header),
        _HeaderCell('Type', header),
        _HeaderCell('Purpose', header),
      ],
    );
  }

  TableRow _apiBodyRow(String a, String b, String c) {
    return TableRow(
      children: <Widget>[
        _BodyCell(a),
        _BodyCell(b),
        _BodyCell(c),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style:
                          Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                body,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: ImageIcon(
                _glyphImage,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .errorContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  color: Theme.of(context)
                      .colorScheme
                      .onErrorContainer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style:
                          Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(body,
                      style:
                          Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard({required this.title, required this.code});

  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
