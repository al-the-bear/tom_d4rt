// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for ListView, ListView.builder,
// ListView.separated, ListView.custom and the surrounding sliver family
// Visual coverage of constructors, physics, axes, padding, cacheExtent, and slivers.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette and shared style helpers used across the script. Held as top-level
// const data so the same colours appear in every section without re-allocation
// inside builder callbacks (which would otherwise be invoked per index).
// ---------------------------------------------------------------------------
const Color kBgInk = Color(0xFF101424);
const Color kBgCard = Color(0xFF1A2236);
const Color kBgPanel = Color(0xFF202B45);
const Color kAccentCyan = Color(0xFF5AC8FA);
const Color kAccentLime = Color(0xFFB4F26B);
const Color kAccentRose = Color(0xFFFF6680);
const Color kAccentAmber = Color(0xFFF7B500);
const Color kAccentViolet = Color(0xFFB388FF);
const Color kTextHi = Color(0xFFF3F6FF);
const Color kTextLo = Color(0xFFA9B4CC);
const Color kDivider = Color(0xFF2A375A);

// Sample data for the various galleries. Kept as plain const lists so each
// builder reads stable input.
const List<String> kTopics = <String>[
  'Default ListView',
  'ListView.builder',
  'ListView.separated',
  'ListView.custom',
  'SliverList',
  'SliverFixedExtentList',
  'SliverPrototypeExtentList',
  'ScrollPhysics variants',
  'cacheExtent semantics',
  'Axis.horizontal strips',
  'AutomaticKeepAliveClientMixin',
  'addRepaintBoundaries flag',
];

const List<String> kCharacters = <String>[
  'Argo, the navigator droid',
  'Belle, courier and field medic',
  'Cassius, archive keeper',
  'Daphne, scout pilot',
  'Eitan, signal cartographer',
  'Fenris, salvage chief',
  'Gala, glass-forge artisan',
  'Holt, deep-current diver',
  'Imani, ledger auditor',
  'Jiro, lantern-bearer of the dawn',
  'Kestrel, stratosphere ranger',
  'Lior, runeglass etcher',
  'Mira, frostfield surveyor',
  'Noor, observatory archivist',
  'Orin, tideline librarian',
];

const List<String> kCities = <String>[
  'Anchorhold',
  'Brassgate',
  'Cinderwell',
  'Driftport',
  'Emberkeep',
  'Foxbarrow',
  'Glasshelm',
  'Hollowmire',
  'Ironvale',
  'Junebrook',
];

const List<IconData> kSectionIcons = <IconData>[
  Icons.list_alt,
  Icons.view_list,
  Icons.horizontal_split,
  Icons.layers_outlined,
  Icons.swap_vert,
  Icons.cached,
  Icons.swap_horiz,
  Icons.info_outline,
];

// ---------------------------------------------------------------------------
// Generic helper widgets — written once, reused everywhere. Each is pure
// function-of-parameters with no captured state.
// ---------------------------------------------------------------------------

Widget sectionTitle(String index, String title, String subtitle, IconData icon,
    Color tint) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 28, 16, 12),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border(left: BorderSide(color: tint, width: 4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: tint.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: tint, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: tint.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      index,
                      style: TextStyle(
                        color: tint,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: kTextHi,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: kTextLo, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget infoCard(String heading, String body, Color tint) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withOpacity(0.35), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bookmark_outline, color: tint, size: 16),
            const SizedBox(width: 6),
            Text(
              heading,
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
              color: kTextHi, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

Widget pill(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: tint.withOpacity(0.45)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tint,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget paramRow(String name, String value, String note) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            name,
            style: const TextStyle(
              color: kAccentCyan,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            value,
            style: const TextStyle(
              color: kAccentAmber,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: const TextStyle(color: kTextLo, fontSize: 11.5),
          ),
        ),
      ],
    ),
  );
}

Widget galleryItem(int index, String title, IconData icon, Color tint) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kDivider),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint.withOpacity(0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: tint, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Item #${index.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: kTextLo,
                  fontSize: 10.5,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  color: kTextHi,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: kTextLo.withOpacity(0.7), size: 18),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — Default ListView (children: <Widget>[...])
// ---------------------------------------------------------------------------
Widget buildDefaultListViewSection() {
  // A controller is constructed for descriptive purposes only. The script does
  // not call jumpTo/animateTo on it — those would require Future/Timer-driven
  // animation that the interpreter does not support.
  final ScrollController descriptionOnlyController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
    debugLabel: 'description-only-default',
  );

  final Widget body = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 280,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentCyan.withOpacity(0.25)),
    ),
    child: ListView(
      controller: descriptionOnlyController,
      padding: const EdgeInsets.all(12),
      shrinkWrap: false,
      reverse: false,
      primary: false,
      physics: const ClampingScrollPhysics(),
      cacheExtent: 250.0,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      children: <Widget>[
        const Text(
          'Default ListView accepts a finite list of widgets directly via '
          'the `children` parameter. It is convenient for small, fixed lists '
          'because every child is constructed eagerly when the ListView is '
          'built.',
          style: TextStyle(color: kTextHi, height: 1.4),
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < 6; i++)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kBgPanel,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: kAccentCyan,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Eager child $i — ${kCharacters[i]}',
                    style: const TextStyle(color: kTextHi, fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('01', 'Default ListView constructor',
          'Eagerly built `children`, ideal for small fixed lists.',
          kSectionIcons[0], kAccentCyan),
      infoCard(
        'When to use',
        'The default constructor (`ListView(children: [...])`) is the right '
            'tool for a handful of pre-known widgets. Every child is created '
            'up-front, so memory cost is O(N). For long lists you should '
            'switch to `ListView.builder`.',
        kAccentCyan,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Wrap(
          children: <Widget>[
            pill('children: List<Widget>', kAccentCyan),
            pill('padding: EdgeInsetsGeometry', kAccentLime),
            pill('shrinkWrap: bool', kAccentRose),
            pill('reverse: bool', kAccentAmber),
            pill('primary: bool?', kAccentViolet),
            pill('physics: ScrollPhysics?', kAccentCyan),
            pill('cacheExtent: double?', kAccentLime),
            pill('addAutomaticKeepAlives', kAccentRose),
            pill('addRepaintBoundaries', kAccentAmber),
            pill('addSemanticIndexes', kAccentViolet),
          ],
        ),
      ),
      body,
      Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kBgCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Anatomy',
              style: TextStyle(
                color: kAccentCyan,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            paramRow('padding', 'all(12)',
                'Insets the entire viewport content — outside the scrollable.'),
            paramRow('shrinkWrap', 'false',
                'When false the ListView fills the viewport. true wraps content.'),
            paramRow('reverse', 'false',
                'When true index 0 is at the bottom (or right in horizontal).'),
            paramRow('cacheExtent', '250.0',
                'Logical pixels of off-screen content to keep mounted.'),
            paramRow('physics', 'Clamping',
                'No overscroll glow — used as a Material reference here.'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — ListView.builder gallery with diverse item shapes
// ---------------------------------------------------------------------------
Widget buildBuilderGallerySection() {
  // Builder callbacks must be free of captured mutable state. The function
  // below is a pure index→widget mapping. The interpreter rebuilds the
  // closure cleanly per visible item.
  Widget itemAt(BuildContext c, int index) {
    final String name = kCharacters[index % kCharacters.length];
    final List<Color> ringPalette = <Color>[
      kAccentCyan,
      kAccentLime,
      kAccentRose,
      kAccentAmber,
      kAccentViolet,
    ];
    final Color tint = ringPalette[index % ringPalette.length];
    final List<IconData> icons = <IconData>[
      Icons.bolt_outlined,
      Icons.shield_outlined,
      Icons.terrain_outlined,
      Icons.water_outlined,
      Icons.local_fire_department_outlined,
    ];
    final IconData icon = icons[index % icons.length];
    // Animation snapshot via AlwaysStoppedAnimation — no Ticker, no
    // controller. Used here only to colour scale by a fixed factor.
    final Animation<double> fixedScale = AlwaysStoppedAnimation<double>(
      0.85 + 0.03 * (index % 5),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ScaleTransition(
        scale: fixedScale,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                kBgPanel,
                Color.lerp(kBgPanel, tint, 0.18) ?? kBgPanel,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tint.withOpacity(0.4)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tint.withOpacity(0.2),
                  border: Border.all(color: tint, width: 1.5),
                ),
                child: Icon(icon, color: tint, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                        color: kTextHi,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lazily built at index $index — itemBuilder invoked '
                      'when the slot enters the cacheExtent.',
                      style:
                          const TextStyle(color: kTextLo, fontSize: 11.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tint.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '#$index',
                  style: TextStyle(
                    color: tint,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget body = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 360,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentLime.withOpacity(0.25)),
    ),
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 18,
      itemBuilder: itemAt,
      physics: const BouncingScrollPhysics(),
      cacheExtent: 320.0,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('02', 'ListView.builder',
          'Lazy on-demand construction via `itemBuilder`.',
          kSectionIcons[1], kAccentLime),
      infoCard(
        'Why builder',
        'When the list is long or virtually infinite, `ListView.builder` '
            'creates widgets on demand. Only the visible slice plus the '
            '`cacheExtent` margin is mounted, which keeps the widget tree '
            'shallow.',
        kAccentLime,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Wrap(
          children: <Widget>[
            pill('itemBuilder: IndexedWidgetBuilder', kAccentLime),
            pill('itemCount: int?', kAccentCyan),
            pill('findChildIndexCallback?', kAccentRose),
            pill('itemExtent: double?', kAccentAmber),
            pill('prototypeItem: Widget?', kAccentViolet),
            pill('cacheExtent: 320.0', kAccentCyan),
            pill('addAutomaticKeepAlives: false', kAccentLime),
          ],
        ),
      ),
      body,
      Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kBgCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Builder anatomy',
              style: TextStyle(
                color: kAccentLime,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            paramRow('itemCount', '18',
                'Exact known count — pass null for infinite scrolling.'),
            paramRow('itemBuilder', 'fn(c,i)',
                'Pure function from index to widget. No setState capture.'),
            paramRow('cacheExtent', '320.0',
                'Slightly larger than default for smoother scroll on tall items.'),
            paramRow('physics', 'Bouncing',
                'iOS-style overscroll for the demonstration.'),
            paramRow('addAutomaticKeepAlives', 'false',
                'Items rebuild after leaving cacheExtent — saves memory.'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — ListView.separated with custom separators
// ---------------------------------------------------------------------------
Widget buildSeparatedSection() {
  Widget separatorAt(BuildContext c, int index) {
    // Alternates between a thin line and a labelled chip separator.
    if (index % 3 == 2) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: <Widget>[
            const Expanded(child: Divider(color: kDivider, thickness: 1)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: kAccentRose.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'group break ${index ~/ 3 + 1}',
                style: const TextStyle(
                  color: kAccentRose,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const Expanded(child: Divider(color: kDivider, thickness: 1)),
          ],
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 1,
      color: kDivider,
    );
  }

  Widget itemAt(BuildContext c, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kAccentRose.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              String.fromCharCode(65 + (index % 26)),
              style: const TextStyle(
                color: kAccentRose,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  kCities[index % kCities.length],
                  style: const TextStyle(
                    color: kTextHi,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Row $index — separator builder controls inter-item space',
                  style: const TextStyle(color: kTextLo, fontSize: 11.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget body = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 320,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentRose.withOpacity(0.25)),
    ),
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 10,
      itemBuilder: itemAt,
      separatorBuilder: separatorAt,
      physics: const AlwaysScrollableScrollPhysics(),
      cacheExtent: 200.0,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('03', 'ListView.separated',
          'Two builders: items and the gap widget between them.',
          kSectionIcons[2], kAccentRose),
      infoCard(
        'Mechanics',
        'Internally a `ListView.separated` produces `2 * itemCount - 1` '
            'slivers: items at even sliver indices, separators at odd ones. '
            'Both callbacks receive a 0-based index into the items list. '
            'Separators are not allocated past the last item.',
        kAccentRose,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Wrap(
          children: <Widget>[
            pill('itemBuilder', kAccentRose),
            pill('separatorBuilder', kAccentCyan),
            pill('itemCount', kAccentLime),
            pill('addAutomaticKeepAlives', kAccentAmber),
            pill('physics: AlwaysScrollable', kAccentViolet),
          ],
        ),
      ),
      body,
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — Horizontal ListView strip and reverse variant
// ---------------------------------------------------------------------------
Widget buildHorizontalStripsSection() {
  Widget stripCard(int index, String label, Color tint, IconData icon) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            tint.withOpacity(0.22),
            tint.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(icon, color: tint, size: 18),
              Text(
                '#${index.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: tint,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: kTextHi,
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Horizontal axis, fixed-width card.',
            style: const TextStyle(color: kTextLo, fontSize: 11),
          ),
        ],
      ),
    );
  }

  final List<Color> palette = <Color>[
    kAccentCyan,
    kAccentLime,
    kAccentRose,
    kAccentAmber,
    kAccentViolet,
  ];
  final List<IconData> icons = <IconData>[
    Icons.air,
    Icons.brightness_2_outlined,
    Icons.cloud_outlined,
    Icons.bolt,
    Icons.spa_outlined,
  ];

  final Widget horizontalRow = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 160,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
    ),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: 12,
      physics: const BouncingScrollPhysics(),
      cacheExtent: 320,
      itemBuilder: (BuildContext c, int i) {
        return stripCard(
          i,
          kCities[i % kCities.length],
          palette[i % palette.length],
          icons[i % icons.length],
        );
      },
    ),
  );

  final Widget reverseRow = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 110,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
    ),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext c, int i) {
        return Container(
          width: 84,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kBgPanel,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kAccentAmber.withOpacity(0.4)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'rev $i',
                style: const TextStyle(
                  color: kAccentAmber,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              const Icon(Icons.swap_horiz, color: kTextLo, size: 14),
            ],
          ),
        );
      },
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('04', 'Horizontal & reverse',
          '`scrollDirection: Axis.horizontal` and `reverse: true` flips.',
          kSectionIcons[6], kAccentAmber),
      infoCard(
        'Two axes',
        'A ListView lays out children along the `scrollDirection`. The '
            'cross-axis is determined by the parent constraints, which is '
            'why horizontal lists are typically wrapped in a fixed-height '
            'SizedBox or Container. Setting `reverse: true` flips the '
            'origin: index 0 becomes the right-most (or bottom-most) item.',
        kAccentAmber,
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Text(
          'Forward horizontal (Axis.horizontal, reverse: false)',
          style: TextStyle(
              color: kTextLo, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      horizontalRow,
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 14, 16, 4),
        child: Text(
          'Reverse horizontal (Axis.horizontal, reverse: true)',
          style: TextStyle(
              color: kTextLo, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      reverseRow,
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — Sliver family inside a CustomScrollView
// ---------------------------------------------------------------------------
Widget buildSliverFamilySection() {
  Widget sliverItem(int index, String tag, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kBgPanel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withOpacity(0.4)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$tag · ${kCharacters[index % kCharacters.length]}',
              style: const TextStyle(color: kTextHi, fontSize: 12.5),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // SliverList — variable-height children.
  final Widget sliverList = SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext c, int index) => sliverItem(index, 'SliverList', kAccentCyan),
      childCount: 6,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
    ),
  );

  // SliverFixedExtentList — every child guaranteed the same main-axis extent.
  final Widget sliverFixed = SliverFixedExtentList(
    itemExtent: 56.0,
    delegate: SliverChildBuilderDelegate(
      (BuildContext c, int index) =>
          sliverItem(index, 'FixedExtent(56)', kAccentLime),
      childCount: 5,
    ),
  );

  // SliverPrototypeExtentList — extent dictated by a prototype widget.
  final Widget sliverProto = SliverPrototypeExtentList(
    prototypeItem: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: const Text('Prototype row', style: TextStyle(fontSize: 14)),
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext c, int index) =>
          sliverItem(index, 'PrototypeExtent', kAccentRose),
      childCount: 5,
    ),
  );

  // Header sliver — describes the next group.
  Widget header(String label, Color tint) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 16, 12, 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: tint.withOpacity(0.18),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: tint,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  final Widget body = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 420,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentViolet.withOpacity(0.3)),
    ),
    child: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      cacheExtent: 250.0,
      slivers: <Widget>[
        header('SLIVERLIST — variable extent', kAccentCyan),
        sliverList,
        header('SLIVERFIXEDEXTENTLIST — itemExtent 56', kAccentLime),
        sliverFixed,
        header('SLIVERPROTOTYPEEXTENTLIST — measured prototype',
            kAccentRose),
        sliverProto,
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kBgPanel,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kDivider),
              ),
              child: const Text(
                'A `CustomScrollView` composes multiple slivers along one '
                'viewport. ListView itself is sugar over a single sliver '
                'inside a `Scrollable`; slivers are the layer where the '
                'real scroll geometry lives.',
                style: TextStyle(color: kTextHi, fontSize: 12.5, height: 1.45),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('05', 'Sliver family inside CustomScrollView',
          'SliverList, SliverFixedExtentList, SliverPrototypeExtentList.',
          kSectionIcons[3], kAccentViolet),
      infoCard(
        'Three list slivers',
        'SliverList grows children to their natural extent. '
            'SliverFixedExtentList enforces a constant main-axis extent for '
            'cheap layout. SliverPrototypeExtentList measures a single '
            'prototype widget and applies that extent to every child — '
            'useful when items should match a typical row size without '
            'pinning a literal number.',
        kAccentViolet,
      ),
      body,
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — ScrollPhysics comparison cards
// ---------------------------------------------------------------------------
Widget buildScrollPhysicsSection() {
  Widget physicsCard(
      String title, String description, Color tint, ScrollPhysics physics) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: kBgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: tint.withOpacity(0.18),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.tune, color: tint, size: 16),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              description,
              style: const TextStyle(
                  color: kTextHi, fontSize: 12.5, height: 1.45),
            ),
          ),
          Container(
            height: 90,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: BoxDecoration(
              color: kBgInk,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: physics,
              padding: const EdgeInsets.all(6),
              itemCount: 18,
              itemBuilder: (BuildContext c, int i) {
                return Container(
                  width: 36,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: tint.withOpacity(0.12 + 0.04 * (i % 5)),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: tint.withOpacity(0.4)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$i',
                    style: TextStyle(
                      color: tint,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('06', 'ScrollPhysics variants',
          'Bouncing, Clamping, NeverScrollable, AlwaysScrollable, PageScroll.',
          kSectionIcons[5], kAccentCyan),
      infoCard(
        'What physics decide',
        'A `ScrollPhysics` object decides how the viewport responds to '
            'flings, overscroll, and gesture release. The Material-default '
            '(`ClampingScrollPhysics`) shows an overscroll glow; the '
            'iOS-default (`BouncingScrollPhysics`) lets content rubber-band. '
            '`NeverScrollableScrollPhysics` disables user scroll entirely, '
            'while `AlwaysScrollableScrollPhysics` keeps the gesture even on '
            'short content.',
        kAccentCyan,
      ),
      physicsCard(
        'BouncingScrollPhysics',
        'iOS-style elastic overscroll. Drag past the edge and the content '
            'rubber-bands back into place.',
        kAccentCyan,
        const BouncingScrollPhysics(),
      ),
      physicsCard(
        'ClampingScrollPhysics',
        'Android default. Stops at the edges and surfaces an overscroll '
            'glow via the GlowingOverscrollIndicator.',
        kAccentLime,
        const ClampingScrollPhysics(),
      ),
      physicsCard(
        'NeverScrollableScrollPhysics',
        'Locks the viewport. Useful inside a parent that owns scrolling '
            '(e.g. `ListView` nested in a `CustomScrollView`).',
        kAccentRose,
        const NeverScrollableScrollPhysics(),
      ),
      physicsCard(
        'AlwaysScrollableScrollPhysics',
        'Forces gesture detection even when content fits the viewport — '
            'pair with a `RefreshIndicator` to keep pull-to-refresh active.',
        kAccentAmber,
        const AlwaysScrollableScrollPhysics(),
      ),
      physicsCard(
        'PageScrollPhysics',
        'Snaps to integer page offsets. Commonly used as the implicit '
            'physics inside `PageView`, but works for any horizontal strip.',
        kAccentViolet,
        const PageScrollPhysics(),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — ListView.custom with SliverChildBuilderDelegate
// ---------------------------------------------------------------------------
Widget buildListViewCustomSection() {
  // SliverChildBuilderDelegate gives full control of keepAlive flags and
  // semantic index callbacks. ListView.custom forwards directly to it.
  final SliverChildBuilderDelegate delegate = SliverChildBuilderDelegate(
    (BuildContext c, int i) {
      final IconData icon = kSectionIcons[i % kSectionIcons.length];
      final Color tint = i.isEven ? kAccentCyan : kAccentAmber;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kBgPanel,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tint.withOpacity(0.4)),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: tint, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'custom row $i',
                    style: TextStyle(
                      color: tint,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Custom delegate controls keepAlives, semantic indexes, '
                    'and lifecycle flags.',
                    style: TextStyle(color: kTextHi, fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
    childCount: 8,
    addAutomaticKeepAlives: false,
    addRepaintBoundaries: true,
    addSemanticIndexes: true,
  );

  final Widget body = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 280,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentLime.withOpacity(0.3)),
    ),
    child: ListView.custom(
      padding: const EdgeInsets.symmetric(vertical: 6),
      childrenDelegate: delegate,
      physics: const BouncingScrollPhysics(),
      cacheExtent: 220,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('07', 'ListView.custom',
          'Direct `SliverChildDelegate` access for full control.',
          kSectionIcons[3], kAccentLime),
      infoCard(
        'When custom helps',
        '`ListView.custom` is the escape hatch when the convenience '
            'constructors do not expose what you need. You provide a '
            '`SliverChildDelegate` (builder or list flavour) and tune flags '
            'like `addAutomaticKeepAlives`, `findChildIndexCallback`, and '
            '`semanticIndexCallback` directly.',
        kAccentLime,
      ),
      body,
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — KeepAlive, RepaintBoundaries, cacheExtent reference card
// ---------------------------------------------------------------------------
Widget buildKeepAliveReferenceSection() {
  Widget bulletRow(IconData icon, Color tint, String head, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: tint, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  head,
                  style: TextStyle(
                    color: tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                      color: kTextHi, fontSize: 12.2, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('08', 'Lifecycle flags & cacheExtent',
          'AutomaticKeepAliveClientMixin, addRepaintBoundaries, cacheExtent.',
          kSectionIcons[7], kAccentRose),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kBgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: kAccentRose.withOpacity(0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'These three knobs control what happens at the boundary of the '
              'visible viewport.',
              style: TextStyle(color: kTextHi, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 10),
            bulletRow(
              Icons.repeat_outlined,
              kAccentCyan,
              'AutomaticKeepAliveClientMixin',
              'Stateful children can mix in this helper, override '
                  '`wantKeepAlive` to return true, and call `super.build` so '
                  'the framework wraps them in a KeepAlive. The element stays '
                  'in the tree even when scrolled out of the cacheExtent. '
                  'Useful for forms or scroll-restoring sub-lists. Not used in '
                  'this script — included as a descriptive reference only '
                  'because the demo is stateless.',
            ),
            bulletRow(
              Icons.brush_outlined,
              kAccentLime,
              'addRepaintBoundaries: true (default)',
              'Wraps every produced child in a `RepaintBoundary`. Each row '
                  'paints onto its own layer so scrolling does not invalidate '
                  'neighbours. Set it to false for lightweight rows where the '
                  'extra layer is wasteful.',
            ),
            bulletRow(
              Icons.auto_awesome_motion_outlined,
              kAccentAmber,
              'addAutomaticKeepAlives: true (default)',
              'When false the ListView skips wrapping children in '
                  '`AutomaticKeepAlive`. This is faster but means any '
                  'KeepAlive notifications children try to send (for example '
                  'a `TextField` keeping its IME state) will be ignored.',
            ),
            bulletRow(
              Icons.memory_outlined,
              kAccentViolet,
              'cacheExtent (logical pixels)',
              'Distance beyond the viewport that the framework still mounts '
                  'children. Larger values cushion scrolling but cost memory; '
                  'smaller values tighten the working set at the cost of '
                  'janky jump-to-index.',
            ),
            bulletRow(
              Icons.label_important_outline,
              kAccentRose,
              'addSemanticIndexes: true (default)',
              'Tags each child with an `IndexedSemantics` annotation so '
                  'TalkBack/VoiceOver reads `"item N of M"`. Turn off only '
                  'when you supply richer semantics yourself.',
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kBgCard,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Padding & primary scroll view',
              style: TextStyle(
                color: kAccentAmber,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            paramRow('padding', 'EdgeInsets',
                'Inset inside the viewport — affects the scrollable area.'),
            paramRow('primary', 'bool?',
                'Auto-true when scrollDirection is vertical and no controller is supplied.'),
            paramRow('controller', 'ScrollController?',
                'Supply your own to read offset/extent; mutually exclusive with primary: true.'),
            paramRow('itemExtent', 'double?',
                'Constant child extent. Cheaper layout than measuring each child.'),
            paramRow('prototypeItem', 'Widget?',
                'Cheap alternative to itemExtent — extent inferred from a single prototype.'),
            paramRow('clipBehavior', 'Clip.hardEdge',
                'Default clip mode of the viewport — pass Clip.none to allow overflow.'),
            paramRow('dragStartBehavior', 'DragStartBehavior.start',
                'Whether drags begin from down-event or move-event timing.'),
            paramRow('restorationId', 'String?',
                'Optional state-restoration key for scroll offset persistence.'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — itemExtent & prototypeItem demonstration on ListView.builder
// ---------------------------------------------------------------------------
Widget buildItemExtentSection() {
  final Widget fixedExtentList = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 200,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentCyan.withOpacity(0.35)),
    ),
    child: ListView.builder(
      itemExtent: 48,
      itemCount: 20,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemBuilder: (BuildContext c, int i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kBgPanel,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            'itemExtent 48 — row $i',
            style: const TextStyle(color: kTextHi, fontSize: 12.5),
          ),
        );
      },
    ),
  );

  final Widget prototypeList = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 200,
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentViolet.withOpacity(0.35)),
    ),
    child: ListView.builder(
      prototypeItem: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: const Text(
          'prototype row — height drives the constant extent',
          style: TextStyle(fontSize: 13.5),
        ),
      ),
      itemCount: 16,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemBuilder: (BuildContext c, int i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: kBgPanel,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kAccentViolet.withOpacity(0.4)),
          ),
          child: Text(
            'prototypeItem row $i — ${kCities[i % kCities.length]}',
            style: const TextStyle(color: kTextHi, fontSize: 13),
          ),
        );
      },
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle('09', 'itemExtent vs prototypeItem',
          'Two ways to skip per-child measurement.',
          kSectionIcons[4], kAccentCyan),
      infoCard(
        'Why pre-size matters',
        'Telling the framework that every row has the same extent skips '
            'an expensive intrinsic measurement pass. Use `itemExtent` when '
            'the size is a literal constant, or `prototypeItem` when the '
            'size is naturally defined by a template widget (e.g. a row '
            'that adapts to text scale).',
        kAccentCyan,
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Text(
          'itemExtent: 48',
          style: TextStyle(
              color: kAccentCyan,
              fontSize: 12,
              fontWeight: FontWeight.w700),
        ),
      ),
      fixedExtentList,
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(
          'prototypeItem: Container(text)',
          style: TextStyle(
              color: kAccentViolet,
              fontSize: 12,
              fontWeight: FontWeight.w700),
        ),
      ),
      prototypeList,
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 — Closing anatomy summary
// ---------------------------------------------------------------------------
Widget buildSummarySection() {
  Widget bigParam(String label, String value, Color tint, String note) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kBgPanel,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: tint, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: tint,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: tint.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: tint,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            note,
            style: const TextStyle(color: kTextHi, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kAccentLime.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.summarize_outlined, color: kAccentLime, size: 22),
            SizedBox(width: 8),
            Text(
              'ListView parameter cheat sheet',
              style: TextStyle(
                color: kAccentLime,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        bigParam('scrollDirection', 'Axis.vertical', kAccentCyan,
            'The primary axis the children scroll along.'),
        bigParam('reverse', 'false', kAccentLime,
            'When true the first item is at the end of the viewport.'),
        bigParam('controller', 'ScrollController?', kAccentRose,
            'Read offsets, attach refresh logic, animate to indexes.'),
        bigParam('primary', 'true (vertical default)', kAccentAmber,
            'Controls whether the list is the surface PageView/PullToRefresh attach to.'),
        bigParam('physics', 'ScrollPhysics?', kAccentViolet,
            'Bouncing, Clamping, Never, Always, Page, or a custom subclass.'),
        bigParam('shrinkWrap', 'false', kAccentCyan,
            'When true the ListView measures its intrinsic extent — slower but useful inside other scrollables.'),
        bigParam('padding', 'EdgeInsetsGeometry?', kAccentLime,
            'Insets inside the viewport — does not consume scrollable extent past the edges.'),
        bigParam('itemExtent', 'double?', kAccentRose,
            'Constant child extent — skips per-child layout measurement.'),
        bigParam('prototypeItem', 'Widget?', kAccentAmber,
            'Use this widget to infer the constant extent of every child.'),
        bigParam('cacheExtent', 'double?', kAccentViolet,
            'Logical pixels to mount above/below the viewport.'),
        bigParam('addAutomaticKeepAlives', 'true', kAccentCyan,
            'Wraps each child in AutomaticKeepAlive — required for KeepAliveNotification.'),
        bigParam('addRepaintBoundaries', 'true', kAccentLime,
            'Wraps each child in a RepaintBoundary so scrolling does not dirty neighbours.'),
        bigParam('addSemanticIndexes', 'true', kAccentRose,
            'Annotates each child with IndexedSemantics for assistive tech.'),
        bigParam('dragStartBehavior', 'DragStartBehavior.start', kAccentAmber,
            'down-event vs move-event drag start timing.'),
        bigParam('keyboardDismissBehavior', 'manual / onDrag', kAccentViolet,
            'Whether scroll gestures dismiss the on-screen keyboard.'),
        bigParam('restorationId', 'String?', kAccentCyan,
            'Persists scroll offset across state restoration.'),
        bigParam('clipBehavior', 'Clip.hardEdge', kAccentLime,
            'Clip mode of the viewport — Clip.none allows overflow drawings.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('listview_test executing — deep visual demo entry');

  final Widget header = Container(
    padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0E2440),
          Color(0xFF1B355A),
        ],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kAccentCyan.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kAccentCyan.withOpacity(0.45)),
              ),
              child: const Text(
                'd4rt · visual demo',
                style: TextStyle(
                  color: kAccentCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kAccentLime.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Flutter widget · ListView',
                style: TextStyle(
                  color: kAccentLime,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'ListView, end to end',
          style: TextStyle(
            color: kTextHi,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Default, builder, separated and custom constructors — plus the '
          'sliver family they desugar into, the physics that drive them, '
          'and the lifecycle flags that govern their children.',
          style: TextStyle(color: kTextLo, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 16),
        Wrap(
          children: <Widget>[
            for (int i = 0; i < kTopics.length; i++)
              pill(kTopics[i],
                  <Color>[
                    kAccentCyan,
                    kAccentLime,
                    kAccentRose,
                    kAccentAmber,
                    kAccentViolet,
                  ][i % 5]),
          ],
        ),
      ],
    ),
  );

  print('Section 01 — default ListView');
  final Widget section1 = buildDefaultListViewSection();
  print('Section 02 — ListView.builder gallery');
  final Widget section2 = buildBuilderGallerySection();
  print('Section 03 — ListView.separated');
  final Widget section3 = buildSeparatedSection();
  print('Section 04 — horizontal & reverse');
  final Widget section4 = buildHorizontalStripsSection();
  print('Section 05 — sliver family');
  final Widget section5 = buildSliverFamilySection();
  print('Section 06 — scroll physics comparison');
  final Widget section6 = buildScrollPhysicsSection();
  print('Section 07 — ListView.custom');
  final Widget section7 = buildListViewCustomSection();
  print('Section 08 — keepAlive / cacheExtent reference');
  final Widget section8 = buildKeepAliveReferenceSection();
  print('Section 09 — itemExtent vs prototypeItem');
  final Widget section9 = buildItemExtentSection();
  print('Section 10 — parameter cheat sheet');
  final Widget section10 = buildSummarySection();

  // A descriptive gallery list rendered inside the body so consumers can see
  // a flat overview of every covered concept inside the scrollable.
  final Widget conceptGallery = Container(
    margin: const EdgeInsets.fromLTRB(16, 18, 16, 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.list, color: kAccentAmber, size: 18),
            SizedBox(width: 6),
            Text(
              'Concept gallery',
              style: TextStyle(
                color: kAccentAmber,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        for (int i = 0; i < kTopics.length; i++)
          galleryItem(
            i,
            kTopics[i],
            kSectionIcons[i % kSectionIcons.length],
            <Color>[
              kAccentCyan,
              kAccentLime,
              kAccentRose,
              kAccentAmber,
              kAccentViolet,
            ][i % 5],
          ),
      ],
    ),
  );

  // Wrap the entire walkthrough in an outer ListView so the page scrolls.
  // This is the script's primary "return Widget" — the entry point produces
  // a single Material scaffold with a vertical ListView body composed of
  // every other ListView demo above.
  final Widget page = Scaffold(
    backgroundColor: kBgInk,
    body: ScrollConfiguration(
      // Suppress the default Material overscroll glow so the section-local
      // physics demos can show their own behaviour cleanly.
      behavior: const _NoGlowBehavior(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        cacheExtent: 600,
        padding: EdgeInsets.zero,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        children: <Widget>[
          header,
          conceptGallery,
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          section10,
        ],
      ),
    ),
  );

  print('listview_test executing — finished composing demo tree');
  return page;
}

// A `ScrollBehavior` subclass that removes the Material overscroll glow on
// the outer container. Declared at top level so the script does not have to
// instantiate an anonymous subclass inline.
class _NoGlowBehavior extends ScrollBehavior {
  const _NoGlowBehavior();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
