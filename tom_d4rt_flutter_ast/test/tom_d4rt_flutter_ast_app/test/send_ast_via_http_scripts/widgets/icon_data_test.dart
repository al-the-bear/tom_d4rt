// Deep visual demo: IconData — the immutable value class describing a glyph
// in an icon font. Icons.* constants are all IconData instances that point
// into the bundled MaterialIcons font. Constructor:
//   IconData(int codePoint, {String? fontFamily, String? fontPackage,
//            bool matchTextDirection = false,
//            List<String>? fontFamilyFallback})
//
// This demo is deliberately stateless. It uses only top-level ValueNotifiers
// to drive the interactive surfaces through ValueListenableBuilder so the
// overall widget tree can remain a StatelessWidget. The demo is intended to
// run under the tom_d4rt_flutter_ast harness.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers. The demo is stateless, so interactive surfaces
// are powered by these shared notifiers plus ValueListenableBuilder.
// ---------------------------------------------------------------------------

/// Drives the codePoint inspector dropdown (section 3).
final ValueNotifier<IconData> kInspectorIcon =
    ValueNotifier<IconData>(Icons.favorite);

/// Drives the interactive size slider (section 4).
final ValueNotifier<double> kPlaygroundSize = ValueNotifier<double>(48.0);

/// Drives the interactive color chip selection (section 4).
final ValueNotifier<Color> kPlaygroundColor =
    ValueNotifier<Color>(const Color(0xFF6750A4));

/// Drives the playground icon selection (section 4).
final ValueNotifier<IconData> kPlaygroundIcon =
    ValueNotifier<IconData>(Icons.star);

/// Drives the custom IconData preview (section 6). The user can flip through
/// a short list of "simulated" custom glyphs that in reality reuse an existing
/// codepoint from the MaterialIcons font.
final ValueNotifier<int> kCustomIconIndex = ValueNotifier<int>(0);

/// Drives the fontFamilyFallback diagram highlight (section 8).
final ValueNotifier<int> kFallbackHighlight = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Constants / shared data used across multiple sections.
// ---------------------------------------------------------------------------

const Color _seedColor = Color(0xFF6750A4);

const List<_GalleryEntry> _galleryEntries = <_GalleryEntry>[
  _GalleryEntry(Icons.home, 'Icons.home'),
  _GalleryEntry(Icons.search, 'Icons.search'),
  _GalleryEntry(Icons.favorite, 'Icons.favorite'),
  _GalleryEntry(Icons.star, 'Icons.star'),
  _GalleryEntry(Icons.settings, 'Icons.settings'),
  _GalleryEntry(Icons.person, 'Icons.person'),
  _GalleryEntry(Icons.mail, 'Icons.mail'),
  _GalleryEntry(Icons.phone, 'Icons.phone'),
  _GalleryEntry(Icons.camera_alt, 'Icons.camera_alt'),
  _GalleryEntry(Icons.map, 'Icons.map'),
  _GalleryEntry(Icons.music_note, 'Icons.music_note'),
  _GalleryEntry(Icons.movie, 'Icons.movie'),
  _GalleryEntry(Icons.shopping_cart, 'Icons.shopping_cart'),
  _GalleryEntry(Icons.lightbulb, 'Icons.lightbulb'),
  _GalleryEntry(Icons.cloud, 'Icons.cloud'),
  _GalleryEntry(Icons.wifi, 'Icons.wifi'),
  _GalleryEntry(Icons.bluetooth, 'Icons.bluetooth'),
  _GalleryEntry(Icons.battery_full, 'Icons.battery_full'),
  _GalleryEntry(Icons.alarm, 'Icons.alarm'),
  _GalleryEntry(Icons.timer, 'Icons.timer'),
  _GalleryEntry(Icons.flight, 'Icons.flight'),
  _GalleryEntry(Icons.directions_car, 'Icons.directions_car'),
  _GalleryEntry(Icons.train, 'Icons.train'),
  _GalleryEntry(Icons.pets, 'Icons.pets'),
  _GalleryEntry(Icons.local_cafe, 'Icons.local_cafe'),
  _GalleryEntry(Icons.restaurant, 'Icons.restaurant'),
  _GalleryEntry(Icons.beach_access, 'Icons.beach_access'),
  _GalleryEntry(Icons.flash_on, 'Icons.flash_on'),
  _GalleryEntry(Icons.brush, 'Icons.brush'),
  _GalleryEntry(Icons.code, 'Icons.code'),
];

const List<_InspectorOption> _inspectorOptions = <_InspectorOption>[
  _InspectorOption(Icons.favorite, 'Icons.favorite'),
  _InspectorOption(Icons.star, 'Icons.star'),
  _InspectorOption(Icons.home, 'Icons.home'),
  _InspectorOption(Icons.bolt, 'Icons.bolt'),
  _InspectorOption(Icons.cake, 'Icons.cake'),
  _InspectorOption(Icons.public, 'Icons.public'),
  _InspectorOption(Icons.rocket_launch, 'Icons.rocket_launch'),
  _InspectorOption(Icons.self_improvement, 'Icons.self_improvement'),
];

const List<_IconChoice> _playgroundChoices = <_IconChoice>[
  _IconChoice(Icons.star, 'star'),
  _IconChoice(Icons.favorite, 'favorite'),
  _IconChoice(Icons.bolt, 'bolt'),
  _IconChoice(Icons.cloud, 'cloud'),
  _IconChoice(Icons.light_mode, 'light_mode'),
  _IconChoice(Icons.dark_mode, 'dark_mode'),
];

const List<Color> _playgroundColors = <Color>[
  Color(0xFF6750A4),
  Color(0xFFB3261E),
  Color(0xFF2E7D32),
  Color(0xFF1565C0),
  Color(0xFFEF6C00),
  Color(0xFF00838F),
  Color(0xFF7B1FA2),
  Color(0xFF455A64),
];

const List<_CustomIcon> _customIcons = <_CustomIcon>[
  _CustomIcon('brand_logo', 'com.acme.brand_icons', Icons.diamond),
  _CustomIcon('brand_pulse', 'com.acme.brand_icons', Icons.graphic_eq),
  _CustomIcon('brand_shield', 'com.acme.brand_icons', Icons.shield_moon),
  _CustomIcon('brand_planet', 'com.acme.brand_icons', Icons.travel_explore),
];

const List<_CategoryGroup> _categoryGroups = <_CategoryGroup>[
  _CategoryGroup('Navigation', <_CategoryIcon>[
    _CategoryIcon(Icons.arrow_back, 'arrow_back'),
    _CategoryIcon(Icons.arrow_forward, 'arrow_forward'),
    _CategoryIcon(Icons.menu, 'menu'),
    _CategoryIcon(Icons.close, 'close'),
    _CategoryIcon(Icons.home, 'home'),
    _CategoryIcon(Icons.chevron_left, 'chevron_left'),
    _CategoryIcon(Icons.chevron_right, 'chevron_right'),
    _CategoryIcon(Icons.more_vert, 'more_vert'),
    _CategoryIcon(Icons.more_horiz, 'more_horiz'),
    _CategoryIcon(Icons.search, 'search'),
  ]),
  _CategoryGroup('Actions', <_CategoryIcon>[
    _CategoryIcon(Icons.add, 'add'),
    _CategoryIcon(Icons.remove, 'remove'),
    _CategoryIcon(Icons.edit, 'edit'),
    _CategoryIcon(Icons.delete, 'delete'),
    _CategoryIcon(Icons.save, 'save'),
    _CategoryIcon(Icons.share, 'share'),
    _CategoryIcon(Icons.copy, 'copy'),
    _CategoryIcon(Icons.download, 'download'),
    _CategoryIcon(Icons.upload, 'upload'),
    _CategoryIcon(Icons.refresh, 'refresh'),
  ]),
  _CategoryGroup('Content', <_CategoryIcon>[
    _CategoryIcon(Icons.image, 'image'),
    _CategoryIcon(Icons.video_library, 'video_library'),
    _CategoryIcon(Icons.music_note, 'music_note'),
    _CategoryIcon(Icons.description, 'description'),
    _CategoryIcon(Icons.article, 'article'),
    _CategoryIcon(Icons.book, 'book'),
    _CategoryIcon(Icons.folder, 'folder'),
    _CategoryIcon(Icons.insert_drive_file, 'insert_drive_file'),
    _CategoryIcon(Icons.link, 'link'),
    _CategoryIcon(Icons.attach_file, 'attach_file'),
  ]),
  _CategoryGroup('Toggle', <_CategoryIcon>[
    _CategoryIcon(Icons.check_box, 'check_box'),
    _CategoryIcon(Icons.check_box_outline_blank, 'check_box_outline_blank'),
    _CategoryIcon(Icons.radio_button_checked, 'radio_button_checked'),
    _CategoryIcon(Icons.radio_button_unchecked, 'radio_button_unchecked'),
    _CategoryIcon(Icons.toggle_on, 'toggle_on'),
    _CategoryIcon(Icons.toggle_off, 'toggle_off'),
    _CategoryIcon(Icons.star, 'star'),
    _CategoryIcon(Icons.star_border, 'star_border'),
    _CategoryIcon(Icons.visibility, 'visibility'),
    _CategoryIcon(Icons.visibility_off, 'visibility_off'),
  ]),
];

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
    ),
    home: const _IconDataDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold — nine-tab DefaultTabController.
// ---------------------------------------------------------------------------

class _IconDataDemo extends StatelessWidget {
  const _IconDataDemo();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IconData — Deep Visual Demo'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.flag), text: 'Hero'),
              Tab(icon: Icon(Icons.grid_view), text: 'Gallery'),
              Tab(icon: Icon(Icons.search), text: 'Inspector'),
              Tab(icon: Icon(Icons.tune), text: 'Playground'),
              Tab(icon: Icon(Icons.swap_horiz), text: 'RTL'),
              Tab(icon: Icon(Icons.code), text: 'Custom'),
              Tab(icon: Icon(Icons.category), text: 'Catalog'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Compare'),
              Tab(icon: Icon(Icons.warning_amber), text: 'Pitfalls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _GalleryTab(),
            _InspectorTab(),
            _PlaygroundTab(),
            _DirectionalTab(),
            _CustomTab(),
            _CatalogTab(),
            _CompareTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — Hero banner.
// ---------------------------------------------------------------------------

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeroBanner(scheme: scheme),
        const SizedBox(height: 24),
        _HeroFacts(scheme: scheme),
        const SizedBox(height: 24),
        _HeroAnatomy(scheme: scheme),
        const SizedBox(height: 24),
        _HeroSummary(scheme: scheme),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.font_download, size: 72, color: scheme.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'IconData',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'An immutable value that addresses a single glyph in an '
                  'icon font. Icons you render every day — Icons.home, '
                  'Icons.favorite, Icons.settings — are all IconData '
                  'instances pointing into the bundled MaterialIcons font.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroFacts extends StatelessWidget {
  const _HeroFacts({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const List<_HeroFact> facts = <_HeroFact>[
      _HeroFact(
        Icons.looks_one,
        'It is data, not a widget.',
        'IconData describes the glyph. The Icon widget is responsible for '
            'rendering that glyph at a requested size and color.',
      ),
      _HeroFact(
        Icons.looks_two,
        'Glyphs are just code points.',
        'Each IconData holds a single codePoint (an int). The glyph you see '
            'is the corresponding character rendered with the icon font.',
      ),
      _HeroFact(
        Icons.looks_3,
        'Fonts are bundled assets.',
        'The Material icon font is bundled inside Flutter. Custom IconData '
            'values can point at fonts you ship in your own package.',
      ),
      _HeroFact(
        Icons.looks_4,
        'IconData is @immutable.',
        'All fields are final. Two IconData instances are equal when their '
            'codePoint and fontFamily match.',
      ),
    ];
    return Column(
      children: <Widget>[
        for (final _HeroFact fact in facts) ...<Widget>[
          _HeroFactCard(fact: fact, scheme: scheme),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _HeroFactCard extends StatelessWidget {
  const _HeroFactCard({required this.fact, required this.scheme});

  final _HeroFact fact;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              child: Icon(fact.icon, color: scheme.onPrimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fact.title,
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 4),
                  Text(fact.body,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroAnatomy extends StatelessWidget {
  const _HeroAnatomy({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.architecture, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Anatomy of an IconData',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            const _AnatomyRow(
              field: 'codePoint',
              type: 'int',
              note:
                  'The character code inside the icon font. For Icons.home '
                  'this is 0xe88a.',
            ),
            const Divider(),
            const _AnatomyRow(
              field: 'fontFamily',
              type: 'String?',
              note:
                  'The font family to look up the glyph in. Defaults to '
                  "'MaterialIcons' for all Icons.*",
            ),
            const Divider(),
            const _AnatomyRow(
              field: 'fontPackage',
              type: 'String?',
              note:
                  'Pub package that owns the font. Mandatory when the font '
                  'ships from a package other than your app.',
            ),
            const Divider(),
            const _AnatomyRow(
              field: 'matchTextDirection',
              type: 'bool',
              note:
                  'Mirror the glyph under Directionality.rtl. Useful for '
                  'directional arrows and chevrons.',
            ),
            const Divider(),
            const _AnatomyRow(
              field: 'fontFamilyFallback',
              type: 'List<String>?',
              note:
                  'Ordered list of fallback families. The first family that '
                  'contains the codePoint is used.',
            ),
          ],
        ),
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.field,
    required this.type,
    required this.note,
  });

  final String field;
  final String type;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              field,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              type,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
          Expanded(child: Text(note)),
        ],
      ),
    );
  }
}

class _HeroSummary extends StatelessWidget {
  const _HeroSummary({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Icon(Icons.info, color: scheme.onTertiaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'The tabs above each explore a facet of IconData: a rendered '
                'gallery, live inspection of the codePoint and fontFamily, '
                'size/color playgrounds, directional mirroring, custom '
                'fonts, categorical browsing, fallback lookup, comparison '
                'with other glyph sources, and common pitfalls.',
                style: TextStyle(color: scheme.onTertiaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — Gallery.
// ---------------------------------------------------------------------------

class _GalleryTab extends StatelessWidget {
  const _GalleryTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns =
            constraints.maxWidth > 900 ? 5 : constraints.maxWidth > 600 ? 4 : 3;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _galleryEntries.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (BuildContext context, int index) {
            final _GalleryEntry entry = _galleryEntries[index];
            final double size = 28.0 + (index % 5) * 6.0;
            final Color color = _galleryPaletteFor(index, scheme);
            return _GalleryCard(entry: entry, size: size, color: color);
          },
        );
      },
    );
  }

  static Color _galleryPaletteFor(int index, ColorScheme scheme) {
    switch (index % 6) {
      case 0:
        return scheme.primary;
      case 1:
        return scheme.secondary;
      case 2:
        return scheme.tertiary;
      case 3:
        return scheme.error;
      case 4:
        return scheme.primary.withValues(alpha: 0.7);
      default:
        return scheme.secondary.withValues(alpha: 0.8);
    }
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({
    required this.entry,
    required this.size,
    required this.color,
  });

  final _GalleryEntry entry;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Icon(entry.icon, size: size, color: color),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              entry.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${size.toInt()}px',
              style: TextStyle(
                fontSize: 10,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 — codePoint inspector.
// ---------------------------------------------------------------------------

class _InspectorTab extends StatelessWidget {
  const _InspectorTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InspectorIntro(scheme: scheme),
        const SizedBox(height: 16),
        _InspectorDropdown(scheme: scheme),
        const SizedBox(height: 24),
        _InspectorDisplay(scheme: scheme),
        const SizedBox(height: 24),
        _InspectorFields(scheme: scheme),
        const SizedBox(height: 24),
        _InspectorHexBreakdown(scheme: scheme),
      ],
    );
  }
}

class _InspectorIntro extends StatelessWidget {
  const _InspectorIntro({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(Icons.search, color: scheme.onSecondaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pick an icon to inspect its raw IconData fields: the '
                'codePoint in hex, and the font family it points at.',
                style: TextStyle(color: scheme.onSecondaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InspectorDropdown extends StatelessWidget {
  const _InspectorDropdown({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IconData>(
      valueListenable: kInspectorIcon,
      builder: (BuildContext context, IconData current, Widget? _) {
        return Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(current, size: 40, color: scheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<IconData>(
                    initialValue: current,
                    decoration: const InputDecoration(
                      labelText: 'Inspect icon',
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem<IconData>>[
                      for (final _InspectorOption option in _inspectorOptions)
                        DropdownMenuItem<IconData>(
                          value: option.icon,
                          child: Row(
                            children: <Widget>[
                              Icon(option.icon, size: 18),
                              const SizedBox(width: 8),
                              Text(option.label),
                            ],
                          ),
                        ),
                    ],
                    onChanged: (IconData? next) {
                      if (next != null) {
                        kInspectorIcon.value = next;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InspectorDisplay extends StatelessWidget {
  const _InspectorDisplay({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IconData>(
      valueListenable: kInspectorIcon,
      builder: (BuildContext context, IconData current, Widget? _) {
        final String hex = current.codePoint
            .toRadixString(16)
            .toUpperCase()
            .padLeft(4, '0');
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: scheme.inverseSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(current, size: 96, color: scheme.inversePrimary),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '0x$hex',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: scheme.onInverseSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'decimal: ${current.codePoint}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: scheme.onInverseSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'fontFamily: ${current.fontFamily ?? '(null)'}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: scheme.onInverseSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'fontPackage: ${current.fontPackage ?? '(null)'}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: scheme.onInverseSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InspectorFields extends StatelessWidget {
  const _InspectorFields({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IconData>(
      valueListenable: kInspectorIcon,
      builder: (BuildContext context, IconData current, Widget? _) {
        return Card(
          elevation: 0,
          color: scheme.surfaceContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _FieldRow(
                  label: 'codePoint (hex)',
                  value: '0x${current.codePoint.toRadixString(16).toUpperCase()}',
                ),
                const Divider(),
                _FieldRow(
                  label: 'codePoint (dec)',
                  value: current.codePoint.toString(),
                ),
                const Divider(),
                _FieldRow(
                  label: 'fontFamily',
                  value: current.fontFamily ?? '(null)',
                ),
                const Divider(),
                _FieldRow(
                  label: 'fontPackage',
                  value: current.fontPackage ?? '(null)',
                ),
                const Divider(),
                _FieldRow(
                  label: 'matchTextDirection',
                  value: current.matchTextDirection.toString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InspectorHexBreakdown extends StatelessWidget {
  const _InspectorHexBreakdown({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IconData>(
      valueListenable: kInspectorIcon,
      builder: (BuildContext context, IconData current, Widget? _) {
        final String hex = current.codePoint
            .toRadixString(16)
            .toUpperCase()
            .padLeft(4, '0');
        return Card(
          elevation: 0,
          color: scheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Hex breakdown',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    for (int i = 0; i < hex.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: scheme.primary
                                .withValues(alpha: 0.12 + i * 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            hex[i],
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Each nibble above represents 4 bits of the codePoint. '
                  'Material icons all live in the Private Use Area of '
                  'Unicode (0xE000..0xF8FF), which is why every hex value '
                  'starts with E or F.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — Size & color playground.
// ---------------------------------------------------------------------------

class _PlaygroundTab extends StatelessWidget {
  const _PlaygroundTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _PlaygroundPreview(scheme: scheme),
        const SizedBox(height: 20),
        _PlaygroundSizeSlider(scheme: scheme),
        const SizedBox(height: 20),
        _PlaygroundColorChips(scheme: scheme),
        const SizedBox(height: 20),
        _PlaygroundIconChoice(scheme: scheme),
        const SizedBox(height: 20),
        _PlaygroundSnippet(scheme: scheme),
      ],
    );
  }
}

class _PlaygroundPreview extends StatelessWidget {
  const _PlaygroundPreview({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: kPlaygroundSize,
      builder: (BuildContext context, double size, Widget? _) {
        return ValueListenableBuilder<Color>(
          valueListenable: kPlaygroundColor,
          builder: (BuildContext context, Color color, Widget? _) {
            return ValueListenableBuilder<IconData>(
              valueListenable: kPlaygroundIcon,
              builder: (BuildContext context, IconData icon, Widget? _) {
                return Container(
                  height: 180,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        scheme.primaryContainer,
                        scheme.tertiaryContainer,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: size, color: color),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _PlaygroundSizeSlider extends StatelessWidget {
  const _PlaygroundSizeSlider({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: kPlaygroundSize,
      builder: (BuildContext context, double size, Widget? _) {
        return Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.straighten, color: scheme.primary),
                    const SizedBox(width: 8),
                    const Text('size'),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${size.toInt()} px',
                        style: TextStyle(
                          color: scheme.onPrimary,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                Slider(
                  min: 16,
                  max: 96,
                  divisions: 80,
                  value: size,
                  label: '${size.toInt()} px',
                  onChanged: (double v) => kPlaygroundSize.value = v,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('16', style: TextStyle(fontFamily: 'monospace')),
                    Text('56', style: TextStyle(fontFamily: 'monospace')),
                    Text('96', style: TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlaygroundColorChips extends StatelessWidget {
  const _PlaygroundColorChips({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: kPlaygroundColor,
      builder: (BuildContext context, Color selected, Widget? _) {
        return Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.palette, color: scheme.primary),
                    const SizedBox(width: 8),
                    const Text('color'),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final Color color in _playgroundColors)
                      ChoiceChip(
                        selected: selected == color,
                        onSelected: (_) => kPlaygroundColor.value = color,
                        avatar: CircleAvatar(backgroundColor: color),
                        label: Text(
                          '#${_toHex(color)}',
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static String _toHex(Color c) {
    final int argb = c.toARGB32();
    return (argb & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0');
  }
}

class _PlaygroundIconChoice extends StatelessWidget {
  const _PlaygroundIconChoice({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IconData>(
      valueListenable: kPlaygroundIcon,
      builder: (BuildContext context, IconData current, Widget? _) {
        return Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.widgets, color: scheme.primary),
                    const SizedBox(width: 8),
                    const Text('icon'),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _IconChoice choice in _playgroundChoices)
                      FilterChip(
                        selected: current == choice.icon,
                        onSelected: (_) => kPlaygroundIcon.value = choice.icon,
                        avatar: Icon(choice.icon, size: 18),
                        label: Text(choice.label),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlaygroundSnippet extends StatelessWidget {
  const _PlaygroundSnippet({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: kPlaygroundSize,
      builder: (BuildContext context, double size, Widget? _) {
        return ValueListenableBuilder<Color>(
          valueListenable: kPlaygroundColor,
          builder: (BuildContext context, Color color, Widget? _) {
            return ValueListenableBuilder<IconData>(
              valueListenable: kPlaygroundIcon,
              builder: (BuildContext context, IconData icon, Widget? _) {
                final String iconName = _playgroundChoices
                    .firstWhere((_IconChoice c) => c.icon == icon)
                    .label;
                final String hexColor =
                    '#${_PlaygroundColorChips._toHex(color)}';
                final String code =
                    'Icon(\n  Icons.$iconName,\n  size: ${size.toInt()},\n'
                    '  color: Color(0xFF$hexColor),\n)';
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: scheme.inverseSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    code,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: scheme.onInverseSurface,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — matchTextDirection / directionality.
// ---------------------------------------------------------------------------

class _DirectionalTab extends StatelessWidget {
  const _DirectionalTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _DirectionalIntro(scheme: scheme),
        const SizedBox(height: 20),
        _DirectionalSideBySide(scheme: scheme),
        const SizedBox(height: 20),
        _DirectionalConstruction(scheme: scheme),
        const SizedBox(height: 20),
        _DirectionalUseCases(scheme: scheme),
      ],
    );
  }
}

class _DirectionalIntro extends StatelessWidget {
  const _DirectionalIntro({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(Icons.swap_horiz, color: scheme.onSecondaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'matchTextDirection tells the Icon widget to horizontally '
                'mirror the glyph when the ambient Directionality is RTL. '
                'This matters for arrows, chevrons, and any asymmetric glyph '
                'whose meaning depends on reading order.',
                style: TextStyle(color: scheme.onSecondaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionalSideBySide extends StatelessWidget {
  const _DirectionalSideBySide({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final IconData mirrored = IconData(
      Icons.arrow_back.codePoint,
      fontFamily: Icons.arrow_back.fontFamily,
      fontPackage: Icons.arrow_back.fontPackage,
      matchTextDirection: true,
    );
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _DirectionCell(
                title: 'LTR • matchTextDirection: false',
                direction: TextDirection.ltr,
                icon: Icons.arrow_back,
                scheme: scheme,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DirectionCell(
                title: 'LTR • matchTextDirection: true',
                direction: TextDirection.ltr,
                icon: mirrored,
                scheme: scheme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
              child: _DirectionCell(
                title: 'RTL • matchTextDirection: false',
                direction: TextDirection.rtl,
                icon: Icons.arrow_back,
                scheme: scheme,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DirectionCell(
                title: 'RTL • matchTextDirection: true (mirrors!)',
                direction: TextDirection.rtl,
                icon: mirrored,
                scheme: scheme,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DirectionCell extends StatelessWidget {
  const _DirectionCell({
    required this.title,
    required this.direction,
    required this.icon,
    required this.scheme,
  });

  final String title;
  final TextDirection direction;
  final IconData icon;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Directionality(
              textDirection: direction,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(icon, size: 48, color: scheme.onPrimaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionalConstruction extends StatelessWidget {
  const _DirectionalConstruction({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const String code = '''
final IconData mirroredBack = IconData(
  Icons.arrow_back.codePoint,
  fontFamily: Icons.arrow_back.fontFamily,
  fontPackage: Icons.arrow_back.fontPackage,
  matchTextDirection: true,
);

// Renders as an arrow pointing LEFT in LTR contexts and
// RIGHT in RTL contexts automatically.
Icon(mirroredBack);''';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.inverseSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: scheme.onInverseSurface,
        ),
      ),
    );
  }
}

class _DirectionalUseCases extends StatelessWidget {
  const _DirectionalUseCases({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const List<_UseCase> useCases = <_UseCase>[
      _UseCase(Icons.arrow_back, 'Back navigation',
          'Back arrows should always point toward the start of the reading '
              'direction, so they flip in RTL.'),
      _UseCase(Icons.chevron_right, 'Disclosure chevrons',
          'Chevrons used to expand a row should follow text direction so the '
              'user reads into them naturally.'),
      _UseCase(Icons.send, 'Send affordance',
          'Send icons that show a paper airplane pointing forward look wrong '
              'in RTL unless mirrored.'),
      _UseCase(Icons.reply, 'Reply / forward',
          'Reply icons literally indicate direction of motion and must be '
              'mirrored to preserve meaning.'),
    ];
    return Column(
      children: <Widget>[
        for (final _UseCase u in useCases) ...<Widget>[
          Card(
            elevation: 0,
            color: scheme.surfaceContainer,
            child: ListTile(
              leading: Icon(u.icon, color: scheme.primary),
              title: Text(u.title),
              subtitle: Text(u.body),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — Custom IconData.
// ---------------------------------------------------------------------------

class _CustomTab extends StatelessWidget {
  const _CustomTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _CustomIntro(scheme: scheme),
        const SizedBox(height: 20),
        _CustomPreview(scheme: scheme),
        const SizedBox(height: 20),
        _CustomSnippet(scheme: scheme),
        const SizedBox(height: 20),
        _CustomYamlSnippet(scheme: scheme),
      ],
    );
  }
}

class _CustomIntro extends StatelessWidget {
  const _CustomIntro({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(Icons.extension, color: scheme.onTertiaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Declaring a custom IconData means pointing at a font you '
                'ship yourself. The preview below reuses Material glyphs to '
                'simulate what such custom icons would look like.',
                style: TextStyle(color: scheme.onTertiaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomPreview extends StatelessWidget {
  const _CustomPreview({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kCustomIconIndex,
      builder: (BuildContext context, int index, Widget? _) {
        final _CustomIcon current = _customIcons[index];
        return Column(
          children: <Widget>[
            Container(
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(current.simulated, size: 96, color: scheme.primary),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (int i = 0; i < _customIcons.length; i++)
                  ChoiceChip(
                    selected: i == index,
                    onSelected: (_) => kCustomIconIndex.value = i,
                    avatar: Icon(_customIcons[i].simulated, size: 18),
                    label: Text(_customIcons[i].name),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _CustomSnippet extends StatelessWidget {
  const _CustomSnippet({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kCustomIconIndex,
      builder: (BuildContext context, int index, Widget? _) {
        final _CustomIcon current = _customIcons[index];
        final String code =
            'class BrandIcons {\n'
            "  static const String _family = 'BrandIcons';\n"
            "  static const String _package = '${current.fontPackage}';\n\n"
            '  static const IconData ${current.name} = IconData(\n'
            '    0xe900,\n'
            '    fontFamily: _family,\n'
            '    fontPackage: _package,\n'
            '  );\n'
            '}';
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.inverseSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SelectableText(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: scheme.onInverseSurface,
            ),
          ),
        );
      },
    );
  }
}

class _CustomYamlSnippet extends StatelessWidget {
  const _CustomYamlSnippet({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const String yaml = '''
# pubspec.yaml of the package shipping the custom font
flutter:
  fonts:
    - family: BrandIcons
      fonts:
        - asset: fonts/BrandIcons.ttf''';
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Font asset declaration',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.inverseSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                yaml,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: scheme.onInverseSurface,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The fontPackage must match the name: field of the package '
              'shipping the font, so assets resolve when consumers depend '
              'on the package transitively.',
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — Category catalog.
// ---------------------------------------------------------------------------

class _CatalogTab extends StatelessWidget {
  const _CatalogTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        for (final _CategoryGroup group in _categoryGroups) ...<Widget>[
          _CategorySection(group: group, scheme: scheme),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.group, required this.scheme});

  final _CategoryGroup group;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _accentFor(group.name, scheme),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Text(group.name,
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final _CategoryIcon icon in group.icons)
                  _CategoryPill(icon: icon, scheme: scheme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Color _accentFor(String name, ColorScheme scheme) {
    switch (name) {
      case 'Navigation':
        return scheme.primary;
      case 'Actions':
        return scheme.secondary;
      case 'Content':
        return scheme.tertiary;
      default:
        return scheme.error;
    }
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.icon, required this.scheme});

  final _CategoryIcon icon;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon.icon, size: 18, color: scheme.primary),
          const SizedBox(width: 8),
          Text(
            icon.name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — fontFamilyFallback (folded into the "Compare" tab as a leading
// block). Implemented via dedicated widgets.
// ---------------------------------------------------------------------------

class _FallbackExplainer extends StatelessWidget {
  const _FallbackExplainer({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.format_list_numbered, color: scheme.primary),
                const SizedBox(width: 8),
                Text('fontFamilyFallback lookup order',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'fontFamilyFallback is an ordered list of font family names '
              'consulted when the primary fontFamily does not contain the '
              'requested codePoint. The first family that contains the glyph '
              'wins. Typical usage is for icon fonts that have been split by '
              'weight or platform.',
            ),
            const SizedBox(height: 16),
            _FallbackDiagram(scheme: scheme),
          ],
        ),
      ),
    );
  }
}

class _FallbackDiagram extends StatelessWidget {
  const _FallbackDiagram({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const List<String> fallbackChain = <String>[
      'BrandIcons',
      'MaterialIconsRounded',
      'MaterialIcons',
      'NotoSansSymbols2',
    ];
    return ValueListenableBuilder<int>(
      valueListenable: kFallbackHighlight,
      builder: (BuildContext context, int highlight, Widget? _) {
        return Column(
          children: <Widget>[
            for (int i = 0; i < fallbackChain.length; i++) ...<Widget>[
              _FallbackStep(
                index: i,
                name: fallbackChain[i],
                highlighted: highlight == i,
                isMatch: i == 2,
                scheme: scheme,
              ),
              if (i < fallbackChain.length - 1)
                Icon(Icons.arrow_downward,
                    color: scheme.onSurfaceVariant, size: 20),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: <Widget>[
                for (int i = 0; i < fallbackChain.length; i++)
                  ChoiceChip(
                    selected: highlight == i,
                    onSelected: (_) => kFallbackHighlight.value = i,
                    label: Text('step ${i + 1}'),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _FallbackStep extends StatelessWidget {
  const _FallbackStep({
    required this.index,
    required this.name,
    required this.highlighted,
    required this.isMatch,
    required this.scheme,
  });

  final int index;
  final String name;
  final bool highlighted;
  final bool isMatch;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final Color background = highlighted
        ? scheme.primaryContainer
        : scheme.surfaceContainerHigh;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlighted ? scheme.primary : scheme.outlineVariant,
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            child: Text('${index + 1}'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (isMatch)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: scheme.tertiary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'glyph found',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: scheme.onTertiary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — Compare (IconData vs ImageIcon vs SvgIcon vs Text glyph).
// ---------------------------------------------------------------------------

class _CompareTab extends StatelessWidget {
  const _CompareTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _FallbackExplainer(scheme: scheme),
        const SizedBox(height: 20),
        Text('Comparison — four ways to render a glyph',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        _CompareRow(
          title: 'IconData + Icon',
          description:
              'Vector glyph drawn from a font. Scales to any size without '
              'loss. Colorable by a single Color. The default and preferred '
              'option for Material-style iconography.',
          preview: const Icon(Icons.star, size: 48),
          scheme: scheme,
          pros: const <String>[
            'Resolution-independent',
            'Tiny size on disk',
            'Easy to tint',
          ],
          cons: const <String>[
            'Single-color',
            'Tree-shaking can drop unused codepoints',
            'Needs a font asset',
          ],
        ),
        const SizedBox(height: 12),
        _CompareRow(
          title: 'ImageIcon',
          description:
              'Uses an ImageProvider (usually an AssetImage) and tints it '
              'with the current IconTheme color. Handy when you only have a '
              'PNG or an SVG already rasterized.',
          preview: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, size: 32, color: scheme.primary),
          ),
          scheme: scheme,
          pros: const <String>[
            'Works with raster assets',
            'Respects IconTheme color',
          ],
          cons: const <String>[
            'Not vector-scalable',
            'Larger on disk per-asset',
            'One image per size',
          ],
        ),
        const SizedBox(height: 12),
        _CompareRow(
          title: 'SvgIcon (e.g. flutter_svg)',
          description:
              'Third-party packages render SVG files to a widget that obeys '
              'the ambient IconTheme size and color. Good when you already '
              'have an SVG icon set.',
          preview: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.brush, size: 32, color: scheme.secondary),
          ),
          scheme: scheme,
          pros: const <String>[
            'True vector from source SVG',
            'No font tooling required',
          ],
          cons: const <String>[
            'Needs an SVG runtime package',
            'Parsing cost per render',
          ],
        ),
        const SizedBox(height: 12),
        _CompareRow(
          title: 'Text("★")',
          description:
              'For a single Unicode glyph, a Text widget with the desired '
              'character works in a pinch. The result depends on the '
              'platform system font and does not respect IconTheme.',
          preview: const Text(
            '★',
            style: TextStyle(fontSize: 42, color: Color(0xFFEF6C00)),
          ),
          scheme: scheme,
          pros: const <String>[
            'Zero assets',
            'Trivially scalable',
          ],
          cons: const <String>[
            'Font-dependent appearance',
            'No IconTheme integration',
            'Semantics are "text"',
          ],
        ),
      ],
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.title,
    required this.description,
    required this.preview,
    required this.pros,
    required this.cons,
    required this.scheme,
  });

  final String title;
  final String description;
  final Widget preview;
  final List<String> pros;
  final List<String> cons;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: preview,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style:
                              Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(description,
                          style:
                              Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _ProsCons(
                    title: 'Pros',
                    items: pros,
                    positive: true,
                    scheme: scheme,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ProsCons(
                    title: 'Cons',
                    items: cons,
                    positive: false,
                    scheme: scheme,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProsCons extends StatelessWidget {
  const _ProsCons({
    required this.title,
    required this.items,
    required this.positive,
    required this.scheme,
  });

  final String title;
  final List<String> items;
  final bool positive;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final Color accent =
        positive ? const Color(0xFF2E7D32) : const Color(0xFFB3261E);
    final IconData marker = positive ? Icons.check_circle : Icons.cancel;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: accent),
          ),
          const SizedBox(height: 4),
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(marker, size: 14, color: accent),
                  const SizedBox(width: 6),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 10 — Pitfalls & section 11 — API cheat sheet.
// ---------------------------------------------------------------------------

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _PitfallTile(
          icon: Icons.content_cut,
          title: 'Tree-shaking drops unused icons',
          body:
              'Release builds tree-shake the MaterialIcons font, keeping '
              'only codePoints Flutter can statically prove are referenced '
              'from Icons.* constants. Dynamically constructed IconData may '
              'render as a tofu rectangle because their glyph was shaken '
              'away. Build with --no-tree-shake-icons when this is needed.',
          scheme: scheme,
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          icon: Icons.code_off,
          title: "Dynamic IconData(codePoint, fontFamily: 'MaterialIcons')",
          body:
              'Constructing IconData from a runtime integer is legal, but '
              'because tree-shaking runs at compile time the codePoint must '
              'still survive. Pair dynamic construction with '
              '--no-tree-shake-icons and an explicit list of reserved '
              'glyphs.',
          scheme: scheme,
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          icon: Icons.swap_calls,
          title: 'Equality is codePoint + fontFamily (+ fontPackage)',
          body:
              'Two IconData values are == when their codePoint, fontFamily, '
              'fontPackage and matchTextDirection match. Two constants that '
              'map to the same glyph but ship from different fonts are not '
              'equal — use Icons.foo == someIcon carefully.',
          scheme: scheme,
        ),
        const SizedBox(height: 24),
        _ApiCheatSheet(scheme: scheme),
      ],
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.scheme,
  });

  final IconData icon;
  final String title;
  final String body;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: scheme.error,
              foregroundColor: scheme.onError,
              child: Icon(icon, color: scheme.onError),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: scheme.onErrorContainer,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(body,
                      style: TextStyle(color: scheme.onErrorContainer)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const String constructor = '''
const IconData(
  int codePoint, {
  String? fontFamily,
  String? fontPackage,
  bool matchTextDirection = false,
  List<String>? fontFamilyFallback,
})''';
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.menu_book, color: scheme.primary),
                const SizedBox(width: 8),
                Text('API cheat sheet',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.inverseSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                constructor,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: scheme.onInverseSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Fields',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            const _FieldDoc(
              name: 'codePoint',
              type: 'int',
              note: 'Unicode code point of the glyph in the icon font.',
            ),
            const _FieldDoc(
              name: 'fontFamily',
              type: 'String?',
              note:
                  'Name of the font family. Defaults to MaterialIcons for '
                  'Icons.* constants.',
            ),
            const _FieldDoc(
              name: 'fontPackage',
              type: 'String?',
              note:
                  'Pub package that provides the font. Required when a '
                  'package ships its own icon font.',
            ),
            const _FieldDoc(
              name: 'matchTextDirection',
              type: 'bool',
              note:
                  'If true, horizontally mirror the glyph under RTL '
                  'directionality.',
            ),
            const _FieldDoc(
              name: 'fontFamilyFallback',
              type: 'List<String>?',
              note:
                  'Ordered list of fallback families used if the glyph is '
                  'missing from fontFamily.',
            ),
            const SizedBox(height: 12),
            Text('Operators and overrides',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            const _FieldDoc(
              name: 'operator ==',
              type: 'bool',
              note:
                  'Equal when codePoint, fontFamily, fontPackage and '
                  'matchTextDirection all match.',
            ),
            const _FieldDoc(
              name: 'hashCode',
              type: 'int',
              note: 'Combines all fields into a stable hash.',
            ),
            const _FieldDoc(
              name: 'toString',
              type: 'String',
              note: "Returns 'IconData(U+XXXX)' where XXXX is the code point in hex.",
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldDoc extends StatelessWidget {
  const _FieldDoc({
    required this.name,
    required this.type,
    required this.note,
  });

  final String name;
  final String type;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              type,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
          Expanded(child: Text(note)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small immutable data holders used in several places above.
// ---------------------------------------------------------------------------

class _GalleryEntry {
  const _GalleryEntry(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _InspectorOption {
  const _InspectorOption(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _IconChoice {
  const _IconChoice(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _CustomIcon {
  const _CustomIcon(this.name, this.fontPackage, this.simulated);
  final String name;
  final String fontPackage;
  final IconData simulated;
}

class _CategoryGroup {
  const _CategoryGroup(this.name, this.icons);
  final String name;
  final List<_CategoryIcon> icons;
}

class _CategoryIcon {
  const _CategoryIcon(this.icon, this.name);
  final IconData icon;
  final String name;
}

class _HeroFact {
  const _HeroFact(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

class _UseCase {
  const _UseCase(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}
