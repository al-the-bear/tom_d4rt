// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - Sliver Delegate Workshop
// Theme: "Sliver Delegate Workshop" - a richly visual showcase of the
// SliverChildBuilderDelegate, SliverChildListDelegate, SliverGridDelegate
// family (FixedCrossAxisCount + MaxCrossAxisExtent), SliverFixedExtentList,
// SliverPrototypeExtentList, and SliverPersistentHeader patterns. Each
// section displays captioned mini CustomScrollViews so the bridged
// interpreter exercises delegate construction, parameter wiring, and
// composition inside a CustomScrollView viewport.
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// ============================================================================
// WORKSHOP PALETTE - the set of color recipes used throughout the demo
// ============================================================================

const List<Map<String, dynamic>> _workshopPalettes = <Map<String, dynamic>>[
  {
    'name': 'Indigo Loom',
    'primary': 0xFF1A237E,
    'accent': 0xFF7986CB,
    'surface': 0xFFE8EAF6,
    'ink': 0xFF0D1142,
  },
  {
    'name': 'Copper Forge',
    'primary': 0xFFBF360C,
    'accent': 0xFFFF8A65,
    'surface': 0xFFFBE9E7,
    'ink': 0xFF4E1500,
  },
  {
    'name': 'Moss Bench',
    'primary': 0xFF1B5E20,
    'accent': 0xFF81C784,
    'surface': 0xFFE8F5E9,
    'ink': 0xFF0A2D0D,
  },
  {
    'name': 'Plum Atelier',
    'primary': 0xFF4A148C,
    'accent': 0xFFBA68C8,
    'surface': 0xFFF3E5F5,
    'ink': 0xFF1B0033,
  },
  {
    'name': 'Cobalt Plate',
    'primary': 0xFF0D47A1,
    'accent': 0xFF64B5F6,
    'surface': 0xFFE3F2FD,
    'ink': 0xFF051E48,
  },
  {
    'name': 'Saffron Bay',
    'primary': 0xFFEF6C00,
    'accent': 0xFFFFB74D,
    'surface': 0xFFFFF3E0,
    'ink': 0xFF5B2A00,
  },
  {
    'name': 'Teal Quarry',
    'primary': 0xFF004D40,
    'accent': 0xFF4DB6AC,
    'surface': 0xFFE0F2F1,
    'ink': 0xFF002019,
  },
  {
    'name': 'Crimson Press',
    'primary': 0xFFB71C1C,
    'accent': 0xFFE57373,
    'surface': 0xFFFFEBEE,
    'ink': 0xFF4A0608,
  },
  {
    'name': 'Slate Press',
    'primary': 0xFF263238,
    'accent': 0xFF90A4AE,
    'surface': 0xFFECEFF1,
    'ink': 0xFF0A1115,
  },
  {
    'name': 'Lemon Atelier',
    'primary': 0xFFF9A825,
    'accent': 0xFFFFD54F,
    'surface': 0xFFFFFDE7,
    'ink': 0xFF5C3B00,
  },
];

// ============================================================================
// SAMPLE CATALOG - data shown in the various delegate demos
// ============================================================================

const List<Map<String, dynamic>> _workshopCatalog = <Map<String, dynamic>>[
  {
    'title': 'Loom A1',
    'subtitle': 'warp thread, indigo',
    'weight': 0.42,
    'tag': 'L',
  },
  {
    'title': 'Loom A2',
    'subtitle': 'weft thread, ecru',
    'weight': 0.61,
    'tag': 'L',
  },
  {
    'title': 'Forge B1',
    'subtitle': 'copper rivet',
    'weight': 0.83,
    'tag': 'F',
  },
  {
    'title': 'Forge B2',
    'subtitle': 'iron hinge',
    'weight': 0.27,
    'tag': 'F',
  },
  {
    'title': 'Bench C1',
    'subtitle': 'oak plank',
    'weight': 0.55,
    'tag': 'B',
  },
  {
    'title': 'Bench C2',
    'subtitle': 'birch shelf',
    'weight': 0.34,
    'tag': 'B',
  },
  {
    'title': 'Quarry D1',
    'subtitle': 'tumbled stone',
    'weight': 0.72,
    'tag': 'Q',
  },
  {
    'title': 'Quarry D2',
    'subtitle': 'slate slab',
    'weight': 0.19,
    'tag': 'Q',
  },
  {
    'title': 'Press E1',
    'subtitle': 'letterpress tray',
    'weight': 0.66,
    'tag': 'P',
  },
  {
    'title': 'Press E2',
    'subtitle': 'foil block',
    'weight': 0.48,
    'tag': 'P',
  },
  {
    'title': 'Atelier F1',
    'subtitle': 'paint jar',
    'weight': 0.91,
    'tag': 'A',
  },
  {
    'title': 'Atelier F2',
    'subtitle': 'brush set',
    'weight': 0.38,
    'tag': 'A',
  },
];

const List<String> _glossaryEntries = <String>[
  'SliverChildBuilderDelegate: lazy, index-based children with optional childCount.',
  'SliverChildListDelegate: eager list of pre-built widgets.',
  'SliverFixedExtentList: list whose every item has the same main-axis extent.',
  'SliverPrototypeExtentList: list where extent is taken from the prototype widget.',
  'SliverGridDelegateWithFixedCrossAxisCount: grid with a fixed number of columns.',
  'SliverGridDelegateWithMaxCrossAxisExtent: grid that fits as many columns as possible.',
  'SliverPersistentHeader (concept): a header that may pin, float, or stretch.',
  'SliverPadding: applies edge insets around an inner sliver.',
  'SliverToBoxAdapter: hosts a single non-sliver widget inside a CustomScrollView.',
  'SliverFillRemaining: fills the remaining viewport space with one child.',
];

// ============================================================================
// HELPERS
// ============================================================================

Widget _sectionBanner(String label, String number, Map<String, dynamic> palette) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(palette['primary'] as int),
          Color(palette['accent'] as int),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(palette['ink'] as int).withOpacity(0.25),
          offset: const Offset(0.0, 6.0),
          blurRadius: 12.0,
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: Color(palette['primary'] as int),
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'SECTION',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10.0,
                  letterSpacing: 2.0,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 14.0,
          height: 38.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ],
    ),
  );
}

Widget _captionCard(String caption, String hint, Map<String, dynamic> palette) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(palette['surface'] as int),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(palette['accent'] as int), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 8.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: Color(palette['primary'] as int),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                caption,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(palette['ink'] as int),
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(palette['primary'] as int),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard(String title, String body, Map<String, dynamic> palette) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBF0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(palette['primary'] as int), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(palette['primary'] as int).withOpacity(0.15),
          offset: const Offset(0.0, 4.0),
          blurRadius: 8.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Color(palette['primary'] as int),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'RECIPE',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 9.0,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(palette['ink'] as int),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            body,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _demoChromeBox(Widget scrollView, Map<String, dynamic> palette) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(palette['accent'] as int), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(palette['ink'] as int).withOpacity(0.10),
          offset: const Offset(0.0, 3.0),
          blurRadius: 6.0,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(height: 280.0, child: scrollView),
    ),
  );
}

Widget _miniTag(String text, Color background, Color foreground) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: foreground,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _itemTile(int index, Map<String, dynamic> palette, {String label = 'item'}) {
  final Map<String, dynamic> entry =
      _workshopCatalog[index % _workshopCatalog.length];
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(palette['surface'] as int),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(palette['accent'] as int), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(palette['primary'] as int),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            entry['tag'] as String,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${entry['title']} ($label #${index + 1})',
                style: TextStyle(
                  color: Color(palette['ink'] as int),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Text(
                entry['subtitle'] as String,
                style: TextStyle(
                  color: Color(palette['primary'] as int),
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
        _miniTag(
          'w ${((entry['weight'] as double) * 100).toStringAsFixed(0)}',
          Color(palette['accent'] as int),
          Color(palette['ink'] as int),
        ),
      ],
    ),
  );
}

Widget _gridCell(int index, Map<String, dynamic> palette) {
  final Map<String, dynamic> entry =
      _workshopCatalog[index % _workshopCatalog.length];
  return Container(
    margin: const EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(palette['surface'] as int),
          Color(palette['accent'] as int).withOpacity(0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(palette['primary'] as int), width: 1.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(palette['primary'] as int),
            shape: BoxShape.circle,
          ),
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          entry['tag'] as String,
          style: TextStyle(
            color: Color(palette['ink'] as int),
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _stripCell(int index, Map<String, dynamic> palette) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(palette['primary'] as int),
          Color(palette['accent'] as int),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 24.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Color(palette['primary'] as int),
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'fixed-extent row #${index + 1}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String left, String right, Map<String, dynamic> palette) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(palette['surface'] as int),
            border: Border.all(color: Color(palette['accent'] as int)),
          ),
          child: Text(
            left,
            style: TextStyle(
              fontSize: 11.0,
              color: Color(palette['ink'] as int),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF0),
            border: Border.all(color: Color(palette['primary'] as int)),
          ),
          child: Text(
            right,
            style: TextStyle(
              fontSize: 11.0,
              color: Color(palette['ink'] as int),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _glossaryItem(int index, String entry, Map<String, dynamic> palette) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(palette['surface'] as int),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(palette['accent'] as int)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(palette['primary'] as int),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            entry,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(palette['ink'] as int),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('Sliver Delegate Workshop deep demo executing');
  final math.Random rng = math.Random(20260516);
  final double prepRandom = rng.nextDouble();
  print('seeded random draw: $prepRandom');
  final ui.TextDirection scriptDirection = ui.TextDirection.ltr;
  print('script direction: $scriptDirection');

  // ==========================================================================
  // HERO HEADER BANNER
  // ==========================================================================
  final Map<String, dynamic> heroPalette = _workshopPalettes[0];
  final Widget heroHeader = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(heroPalette['primary'] as int),
          Color(heroPalette['accent'] as int),
          Color(_workshopPalettes[3]['primary'] as int),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(heroPalette['ink'] as int).withOpacity(0.30),
          offset: const Offset(0.0, 10.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'WORKSHOP',
                style: TextStyle(
                  color: Color(heroPalette['primary'] as int),
                  fontSize: 10.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Sliver Delegate Workshop',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A captioned tour of the sliver delegate family: builder vs list, '
          'fixed-extent vs prototype-extent, fixed cross-axis count vs max '
          'cross-axis extent. Each demo is a bounded CustomScrollView so the '
          'bridged interpreter sees the slivers laid out under real '
          'constraints.',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            _miniTag(
              'DELEGATES',
              const Color(0xFFFFFFFF),
              Color(heroPalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'GRID',
              const Color(0xFFFFFFFF),
              Color(heroPalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'EXTENT',
              const Color(0xFFFFFFFF),
              Color(heroPalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'PROTOTYPE',
              const Color(0xFFFFFFFF),
              Color(heroPalette['primary'] as int),
            ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 1: SliverChildBuilderDelegate Patterns
  // ==========================================================================
  final Map<String, dynamic> palette1 = _workshopPalettes[0];
  final Widget section1Banner =
      _sectionBanner('SliverChildBuilderDelegate Patterns', '1', palette1);

  final Widget section1Caption1 = _captionCard(
    'Bounded builder, childCount = 12',
    'Each tile produced lazily; only visible indices materialise.',
    palette1,
  );
  final CustomScrollView section1Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index, palette1, label: 'builder');
          },
          childCount: 12,
        ),
      ),
    ],
  );

  final Widget section1Caption2 = _captionCard(
    'Builder with addAutomaticKeepAlives = false',
    'Disables AutomaticKeepAlive wrappers - cheaper for fully stateless tiles.',
    palette1,
  );
  final CustomScrollView section1Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index + 4, _workshopPalettes[4], label: 'noKeep');
          },
          childCount: 10,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: true,
        ),
      ),
    ],
  );

  final Widget section1Caption3 = _captionCard(
    'Builder with childCount null (infinite-ish, capped by viewport)',
    'When childCount is null, the builder is consulted until null is returned.',
    palette1,
  );
  final CustomScrollView section1Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index >= 14) {
              return null;
            }
            return _itemTile(index, _workshopPalettes[2], label: 'lazy');
          },
        ),
      ),
    ],
  );

  final Widget section1Recipe = _recipeCard(
    'Builder delegate, recipe',
    'SliverList(\n  delegate: SliverChildBuilderDelegate(\n'
    '    (ctx, i) => Tile(i),\n    childCount: 12,\n'
    '    addAutomaticKeepAlives: false,\n  ),\n)',
    palette1,
  );

  // ==========================================================================
  // SECTION 2: SliverChildListDelegate Catalog
  // ==========================================================================
  final Map<String, dynamic> palette2 = _workshopPalettes[1];
  final Widget section2Banner =
      _sectionBanner('SliverChildListDelegate Catalog', '2', palette2);

  final Widget section2Caption1 = _captionCard(
    'List delegate with eager children',
    'All eight tiles are built up-front - good for small fixed lists.',
    palette2,
  );
  final CustomScrollView section2Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          _itemTile(0, palette2, label: 'list'),
          _itemTile(1, palette2, label: 'list'),
          _itemTile(2, palette2, label: 'list'),
          _itemTile(3, palette2, label: 'list'),
          _itemTile(4, palette2, label: 'list'),
          _itemTile(5, palette2, label: 'list'),
          _itemTile(6, palette2, label: 'list'),
          _itemTile(7, palette2, label: 'list'),
        ]),
      ),
    ],
  );

  final Widget section2Caption2 = _captionCard(
    'List delegate inside SliverPadding',
    'SliverPadding wraps a sliver to add edge insets around the whole strip.',
    palette2,
  );
  final CustomScrollView section2Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            _itemTile(2, _workshopPalettes[5], label: 'pad'),
            _itemTile(3, _workshopPalettes[5], label: 'pad'),
            _itemTile(4, _workshopPalettes[5], label: 'pad'),
            _itemTile(5, _workshopPalettes[5], label: 'pad'),
            _itemTile(6, _workshopPalettes[5], label: 'pad'),
          ]),
        ),
      ),
    ],
  );

  final Widget section2Caption3 = _captionCard(
    'SliverChildListDelegate.fixed - immutable list, no keys',
    'Use .fixed when widget identity will never change for an index.',
    palette2,
  );
  final CustomScrollView section2Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate.fixed(<Widget>[
          _itemTile(7, _workshopPalettes[7], label: 'fixed'),
          _itemTile(8, _workshopPalettes[7], label: 'fixed'),
          _itemTile(9, _workshopPalettes[7], label: 'fixed'),
          _itemTile(10, _workshopPalettes[7], label: 'fixed'),
        ]),
      ),
    ],
  );

  final Widget section2Recipe = _recipeCard(
    'List delegate, recipe',
    'SliverList(\n  delegate: SliverChildListDelegate(<Widget>[\n'
    '    Tile(0), Tile(1), Tile(2),\n  ]),\n)',
    palette2,
  );

  // ==========================================================================
  // SECTION 3: SliverFixedExtentList Strips
  // ==========================================================================
  final Map<String, dynamic> palette3 = _workshopPalettes[2];
  final Widget section3Banner =
      _sectionBanner('SliverFixedExtentList Strips', '3', palette3);

  final Widget section3Caption1 = _captionCard(
    'itemExtent: 44 - identical row height',
    'No measurement happens per child - extent is taken as truth.',
    palette3,
  );
  final CustomScrollView section3Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverFixedExtentList(
        itemExtent: 44.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _stripCell(index, palette3);
          },
          childCount: 14,
        ),
      ),
    ],
  );

  final Widget section3Caption2 = _captionCard(
    'itemExtent: 64 - taller strip, same delegate',
    'Switching extent gives a different visual rhythm without changing children.',
    palette3,
  );
  final CustomScrollView section3Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverFixedExtentList(
        itemExtent: 64.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _stripCell(index + 4, _workshopPalettes[8]);
          },
          childCount: 10,
        ),
      ),
    ],
  );

  final Widget section3Caption3 = _captionCard(
    'FixedExtentList with list delegate, extent 32',
    'Eager children also benefit from extent - lays out at constant cost.',
    palette3,
  );
  final CustomScrollView section3Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverFixedExtentList(
        itemExtent: 32.0,
        delegate: SliverChildListDelegate(<Widget>[
          _stripCell(0, _workshopPalettes[6]),
          _stripCell(1, _workshopPalettes[6]),
          _stripCell(2, _workshopPalettes[6]),
          _stripCell(3, _workshopPalettes[6]),
          _stripCell(4, _workshopPalettes[6]),
          _stripCell(5, _workshopPalettes[6]),
          _stripCell(6, _workshopPalettes[6]),
          _stripCell(7, _workshopPalettes[6]),
          _stripCell(8, _workshopPalettes[6]),
          _stripCell(9, _workshopPalettes[6]),
        ]),
      ),
    ],
  );

  final Widget section3Recipe = _recipeCard(
    'Fixed extent, recipe',
    'SliverFixedExtentList(\n  itemExtent: 44.0,\n'
    '  delegate: SliverChildBuilderDelegate(\n'
    '    (ctx, i) => StripCell(i),\n    childCount: 14,\n  ),\n)',
    palette3,
  );

  // ==========================================================================
  // SECTION 4: SliverPrototypeExtentList
  // ==========================================================================
  final Map<String, dynamic> palette4 = _workshopPalettes[3];
  final Widget section4Banner =
      _sectionBanner('SliverPrototypeExtentList', '4', palette4);

  final Widget section4Caption1 = _captionCard(
    'Prototype is a 56-px chunky tile',
    'Every visible child gets the prototype\'s measured main-axis extent.',
    palette4,
  );
  final Widget prototypeChunky = Container(
    height: 56.0,
    color: Color(palette4['accent'] as int),
  );
  final CustomScrollView section4Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPrototypeExtentList(
        prototypeItem: prototypeChunky,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _stripCell(index, palette4);
          },
          childCount: 12,
        ),
      ),
    ],
  );

  final Widget section4Caption2 = _captionCard(
    'Slim prototype (height 28)',
    'Same children, slimmer prototype - dense compact list.',
    palette4,
  );
  final Widget prototypeSlim = SizedBox(
    height: 28.0,
    child: Container(color: Color(palette4['primary'] as int)),
  );
  final CustomScrollView section4Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPrototypeExtentList(
        prototypeItem: prototypeSlim,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _stripCell(index, _workshopPalettes[9]);
          },
          childCount: 16,
        ),
      ),
    ],
  );

  final Widget section4Recipe = _recipeCard(
    'Prototype extent, recipe',
    'SliverPrototypeExtentList(\n  prototypeItem: SizedBox(height: 56),\n'
    '  delegate: SliverChildBuilderDelegate(\n'
    '    (ctx, i) => StripCell(i),\n    childCount: 12,\n  ),\n)',
    palette4,
  );

  // ==========================================================================
  // SECTION 5: SliverGridDelegateWithFixedCrossAxisCount Grids
  // ==========================================================================
  final Map<String, dynamic> palette5 = _workshopPalettes[4];
  final Widget section5Banner =
      _sectionBanner('FixedCrossAxisCount Grids', '5', palette5);

  final Widget section5Caption1 = _captionCard(
    'crossAxisCount: 2, square ratio',
    'Two columns - aspect 1.0 means each cell is as tall as it is wide.',
    palette5,
  );
  final CustomScrollView section5Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, palette5);
          },
          childCount: 12,
        ),
      ),
    ],
  );

  final Widget section5Caption2 = _captionCard(
    'crossAxisCount: 3, wide cells (1.5 ratio)',
    'Three columns - cells are 1.5x wider than tall.',
    palette5,
  );
  final CustomScrollView section5Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index + 1, _workshopPalettes[5]);
          },
          childCount: 18,
        ),
      ),
    ],
  );

  final Widget section5Caption3 = _captionCard(
    'crossAxisCount: 4, mainAxisExtent: 60',
    'When mainAxisExtent is set, childAspectRatio is ignored.',
    palette5,
  );
  final CustomScrollView section5Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 60.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index + 2, _workshopPalettes[6]);
          },
          childCount: 16,
        ),
      ),
    ],
  );

  final Widget section5Caption4 = _captionCard(
    'crossAxisCount: 5, tall cells (0.7 ratio)',
    'Many narrow columns produce a postage-stamp grid.',
    palette5,
  );
  final CustomScrollView section5Demo4 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.7,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index + 3, _workshopPalettes[9]);
          },
          childCount: 20,
        ),
      ),
    ],
  );

  final Widget section5Recipe = _recipeCard(
    'FixedCrossAxisCount, recipe',
    'SliverGrid(\n  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(\n'
    '    crossAxisCount: 3,\n    childAspectRatio: 1.5,\n  ),\n'
    '  delegate: SliverChildBuilderDelegate((ctx, i) => Cell(i)),\n)',
    palette5,
  );

  // ==========================================================================
  // SECTION 6: SliverGridDelegateWithMaxCrossAxisExtent Grids
  // ==========================================================================
  final Map<String, dynamic> palette6 = _workshopPalettes[5];
  final Widget section6Banner =
      _sectionBanner('MaxCrossAxisExtent Grids', '6', palette6);

  final Widget section6Caption1 = _captionCard(
    'maxCrossAxisExtent: 80, ratio 1.0',
    'Pack as many ~80-wide cells as fit - responsive without breakpoints.',
    palette6,
  );
  final CustomScrollView section6Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80.0,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, palette6);
          },
          childCount: 18,
        ),
      ),
    ],
  );

  final Widget section6Caption2 = _captionCard(
    'maxCrossAxisExtent: 120, ratio 1.4',
    'Larger cells, wider ratio - dashboard-style tiles.',
    palette6,
  );
  final CustomScrollView section6Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120.0,
          childAspectRatio: 1.4,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index + 1, _workshopPalettes[7]);
          },
          childCount: 12,
        ),
      ),
    ],
  );

  final Widget section6Caption3 = _captionCard(
    'maxCrossAxisExtent: 60, mainAxisExtent: 50',
    'Combine max-cross with mainAxisExtent for postage stamps.',
    palette6,
  );
  final CustomScrollView section6Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 60.0,
          mainAxisExtent: 50.0,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index + 2, _workshopPalettes[1]);
          },
          childCount: 24,
        ),
      ),
    ],
  );

  final Widget section6Recipe = _recipeCard(
    'MaxCrossAxisExtent, recipe',
    'SliverGrid(\n  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(\n'
    '    maxCrossAxisExtent: 120.0,\n    childAspectRatio: 1.4,\n  ),\n'
    '  delegate: SliverChildBuilderDelegate((ctx, i) => Cell(i)),\n)',
    palette6,
  );

  // ==========================================================================
  // SECTION 7: Mixed Composition
  // ==========================================================================
  final Map<String, dynamic> palette7 = _workshopPalettes[6];
  final Widget section7Banner =
      _sectionBanner('Mixed Composition', '7', palette7);

  final Widget section7Caption1 = _captionCard(
    'List + Grid + List in one CustomScrollView',
    'Three slivers stacked - the delegate per-sliver decides children layout.',
    palette7,
  );
  final CustomScrollView section7Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 30.0,
          alignment: Alignment.center,
          color: Color(palette7['primary'] as int),
          child: const Text(
            'BUILDER LIST',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 11.0,
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index, palette7, label: 'mix');
          },
          childCount: 4,
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 30.0,
          alignment: Alignment.center,
          color: Color(palette7['accent'] as int),
          child: Text(
            'GRID 3 COLS',
            style: TextStyle(
              color: Color(palette7['ink'] as int),
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 11.0,
            ),
          ),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.2,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, palette7);
          },
          childCount: 6,
        ),
      ),
    ],
  );

  final Widget section7Caption2 = _captionCard(
    'Grid + FixedExtent strip composition',
    'Grid header followed by a fixed-extent strip - hybrid layouts.',
    palette7,
  );
  final CustomScrollView section7Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, _workshopPalettes[3]);
          },
          childCount: 6,
        ),
      ),
      SliverFixedExtentList(
        itemExtent: 40.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _stripCell(index, _workshopPalettes[5]);
          },
          childCount: 6,
        ),
      ),
    ],
  );

  final Widget section7Caption3 = _captionCard(
    'List delegate sandwiching a grid',
    'Top list, middle grid, bottom list - common feed layout.',
    palette7,
  );
  final CustomScrollView section7Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          _itemTile(0, _workshopPalettes[0], label: 'top'),
          _itemTile(1, _workshopPalettes[0], label: 'top'),
        ]),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, _workshopPalettes[8]);
          },
          childCount: 8,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          _itemTile(2, _workshopPalettes[0], label: 'btm'),
          _itemTile(3, _workshopPalettes[0], label: 'btm'),
        ]),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 8: SliverPadding / SliverFillRemaining
  // ==========================================================================
  final Map<String, dynamic> palette8 = _workshopPalettes[7];
  final Widget section8Banner =
      _sectionBanner('SliverPadding / SliverFillRemaining', '8', palette8);

  final Widget section8Caption1 = _captionCard(
    'SliverPadding wraps another sliver',
    'The padded sliver retains its delegate - padding affects the outer extent.',
    palette8,
  );
  final CustomScrollView section8Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(12.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _itemTile(index, palette8, label: 'pad');
            },
            childCount: 6,
          ),
        ),
      ),
    ],
  );

  final Widget section8Caption2 = _captionCard(
    'SliverFillRemaining hosts a single billboard',
    'Useful as the last sliver to fill any remaining viewport space.',
    palette8,
  );
  final CustomScrollView section8Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          _itemTile(0, palette8, label: 'fill'),
          _itemTile(1, palette8, label: 'fill'),
        ]),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(palette8['primary'] as int),
                Color(palette8['accent'] as int),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Text(
            'fill remaining',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    ],
  );

  final Widget section8Caption3 = _captionCard(
    'SliverPadding with grid - inset gallery',
    'Inset a grid for a card-like gallery look.',
    palette8,
  );
  final CustomScrollView section8Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.1,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _gridCell(index, palette8);
            },
            childCount: 9,
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 9: SliverPersistentHeader patterns (visual)
  // ==========================================================================
  final Map<String, dynamic> palette9 = _workshopPalettes[8];
  final Widget section9Banner =
      _sectionBanner('SliverPersistentHeader patterns', '9', palette9);

  final Widget section9Caption1 = _captionCard(
    'SliverAppBar pinned - stays at top',
    'SliverAppBar is the concrete persistent header most apps use.',
    palette9,
  );
  final CustomScrollView section9Demo1 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        title: const Text('Pinned header'),
        backgroundColor: Color(palette9['primary'] as int),
        foregroundColor: const Color(0xFFFFFFFF),
        pinned: true,
        expandedHeight: 80.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(palette9['primary'] as int),
                  Color(palette9['accent'] as int),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index, palette9, label: 'pinned');
          },
          childCount: 8,
        ),
      ),
    ],
  );

  final Widget section9Caption2 = _captionCard(
    'SliverAppBar floating - reappears on scroll up',
    'Floating + snap behaviour comes from the persistent-header machinery.',
    palette9,
  );
  final CustomScrollView section9Demo2 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        title: const Text('Floating header'),
        backgroundColor: Color(_workshopPalettes[1]['primary'] as int),
        foregroundColor: const Color(0xFFFFFFFF),
        floating: true,
        snap: true,
        expandedHeight: 64.0,
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index + 2, _workshopPalettes[1], label: 'float');
          },
          childCount: 8,
        ),
      ),
    ],
  );

  final Widget section9Caption3 = _captionCard(
    'SliverToBoxAdapter as a static header',
    'For non-pinning headers, a SliverToBoxAdapter is the simplest option.',
    palette9,
  );
  final CustomScrollView section9Demo3 = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(palette9['primary'] as int),
                Color(palette9['accent'] as int),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: const Text(
            'static header',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 3.0,
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index + 4, palette9, label: 'static');
          },
          childCount: 8,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 10: SliverGridDelegate comparisons
  // ==========================================================================
  final Map<String, dynamic> palette10 = _workshopPalettes[9];
  final Widget section10Banner =
      _sectionBanner('SliverGridDelegate comparisons', '10', palette10);

  final Widget section10Caption1 = _captionCard(
    'Side-by-side: Fixed (3 cols) vs Max (90px)',
    'Same children, two different delegate strategies, in two scroll views.',
    palette10,
  );
  final CustomScrollView section10DemoLeft = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 28.0,
          alignment: Alignment.center,
          color: Color(palette10['primary'] as int),
          child: const Text(
            'FIXED COUNT 3',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, palette10);
          },
          childCount: 12,
        ),
      ),
    ],
  );
  final CustomScrollView section10DemoRight = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 28.0,
          alignment: Alignment.center,
          color: Color(palette10['accent'] as int),
          child: Text(
            'MAX EXTENT 90',
            style: TextStyle(
              color: Color(palette10['ink'] as int),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90.0,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _gridCell(index, palette10);
          },
          childCount: 12,
        ),
      ),
    ],
  );

  final Widget section10Caption2 = _captionCard(
    'Side-by-side: Builder vs List delegate',
    'Same content, different delegate construction strategy.',
    palette10,
  );
  final CustomScrollView section10DemoBuilder = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 28.0,
          alignment: Alignment.center,
          color: Color(palette10['primary'] as int),
          child: const Text(
            'BUILDER',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemTile(index, palette10, label: 'builder');
          },
          childCount: 8,
        ),
      ),
    ],
  );
  final CustomScrollView section10DemoList = CustomScrollView(
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 28.0,
          alignment: Alignment.center,
          color: Color(palette10['accent'] as int),
          child: Text(
            'LIST',
            style: TextStyle(
              color: Color(palette10['ink'] as int),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          _itemTile(0, palette10, label: 'list'),
          _itemTile(1, palette10, label: 'list'),
          _itemTile(2, palette10, label: 'list'),
          _itemTile(3, palette10, label: 'list'),
          _itemTile(4, palette10, label: 'list'),
          _itemTile(5, palette10, label: 'list'),
          _itemTile(6, palette10, label: 'list'),
          _itemTile(7, palette10, label: 'list'),
        ]),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 11: Comparison table
  // ==========================================================================
  final Map<String, dynamic> palette11 = _workshopPalettes[0];
  final Widget section11Banner =
      _sectionBanner('Comparison Table', '11', palette11);

  final Widget comparisonTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(palette11['primary'] as int), width: 1.5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Column(
        children: <Widget>[
          Container(
            color: Color(palette11['primary'] as int),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'BUILDER DELEGATE',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'LIST DELEGATE',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _comparisonRow(
            'Lazy: children built on demand',
            'Eager: every child built up-front',
            palette11,
          ),
          _comparisonRow(
            'childCount may be null',
            'List length defines the count',
            palette11,
          ),
          _comparisonRow(
            'Good for very long feeds',
            'Good for small fixed lists',
            palette11,
          ),
          _comparisonRow(
            'Index-based identity',
            'Widget-based identity',
            palette11,
          ),
          _comparisonRow(
            'Builder may return null to stop',
            'No null entries permitted',
            palette11,
          ),
          Container(
            color: Color(palette11['primary'] as int),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'FIXED CROSS AXIS',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'MAX CROSS AXIS',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _comparisonRow(
            'crossAxisCount: fixed number of columns',
            'maxCrossAxisExtent: max width per cell',
            palette11,
          ),
          _comparisonRow(
            'Cell width = viewport / count',
            'Column count grows with viewport',
            palette11,
          ),
          _comparisonRow(
            'Predictable column count',
            'Responsive without breakpoints',
            palette11,
          ),
          _comparisonRow(
            'Good for forms and dashboards',
            'Good for galleries and photo grids',
            palette11,
          ),
          _comparisonRow(
            'childAspectRatio or mainAxisExtent',
            'childAspectRatio or mainAxisExtent',
            palette11,
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 12: Glossary
  // ==========================================================================
  final Map<String, dynamic> palette12 = _workshopPalettes[3];
  final Widget section12Banner =
      _sectionBanner('Glossary', '12', palette12);

  final List<Widget> glossaryItems = <Widget>[];
  for (int i = 0; i < _glossaryEntries.length; i++) {
    glossaryItems.add(_glossaryItem(i, _glossaryEntries[i], palette12));
  }

  // ==========================================================================
  // EPILOGUE
  // ==========================================================================
  final Map<String, dynamic> epiloguePalette = _workshopPalettes[2];
  final Widget epilogue = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(epiloguePalette['primary'] as int),
          Color(epiloguePalette['accent'] as int),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'EPILOGUE',
                style: TextStyle(
                  color: Color(epiloguePalette['primary'] as int),
                  fontSize: 10.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Choosing a delegate',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Builder delegates pay only for visible indices and scale to '
          'unbounded feeds. List delegates are simpler and fine for short, '
          'fixed content. Fixed-cross-axis grids give predictable column '
          'counts; max-cross-axis grids fluidly adapt to any viewport width. '
          'Fixed-extent and prototype-extent lists short-circuit per-child '
          'measurement for the cheapest possible vertical scrolling.',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            _miniTag(
              'LAZY',
              const Color(0xFFFFFFFF),
              Color(epiloguePalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'EAGER',
              const Color(0xFFFFFFFF),
              Color(epiloguePalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'FIXED',
              const Color(0xFFFFFFFF),
              Color(epiloguePalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'MAX',
              const Color(0xFFFFFFFF),
              Color(epiloguePalette['primary'] as int),
            ),
            const SizedBox(width: 6.0),
            _miniTag(
              'PROTO',
              const Color(0xFFFFFFFF),
              Color(epiloguePalette['primary'] as int),
            ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // ASSEMBLE THE OUTER SCROLLVIEW
  // ==========================================================================
  return MaterialApp(
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            heroHeader,

            // SECTION 1
            section1Banner,
            section1Caption1,
            _demoChromeBox(section1Demo1, palette1),
            section1Caption2,
            _demoChromeBox(section1Demo2, palette1),
            section1Caption3,
            _demoChromeBox(section1Demo3, palette1),
            section1Recipe,

            // SECTION 2
            section2Banner,
            section2Caption1,
            _demoChromeBox(section2Demo1, palette2),
            section2Caption2,
            _demoChromeBox(section2Demo2, palette2),
            section2Caption3,
            _demoChromeBox(section2Demo3, palette2),
            section2Recipe,

            // SECTION 3
            section3Banner,
            section3Caption1,
            _demoChromeBox(section3Demo1, palette3),
            section3Caption2,
            _demoChromeBox(section3Demo2, palette3),
            section3Caption3,
            _demoChromeBox(section3Demo3, palette3),
            section3Recipe,

            // SECTION 4
            section4Banner,
            section4Caption1,
            _demoChromeBox(section4Demo1, palette4),
            section4Caption2,
            _demoChromeBox(section4Demo2, palette4),
            section4Recipe,

            // SECTION 5
            section5Banner,
            section5Caption1,
            _demoChromeBox(section5Demo1, palette5),
            section5Caption2,
            _demoChromeBox(section5Demo2, palette5),
            section5Caption3,
            _demoChromeBox(section5Demo3, palette5),
            section5Caption4,
            _demoChromeBox(section5Demo4, palette5),
            section5Recipe,

            // SECTION 6
            section6Banner,
            section6Caption1,
            _demoChromeBox(section6Demo1, palette6),
            section6Caption2,
            _demoChromeBox(section6Demo2, palette6),
            section6Caption3,
            _demoChromeBox(section6Demo3, palette6),
            section6Recipe,

            // SECTION 7
            section7Banner,
            section7Caption1,
            _demoChromeBox(section7Demo1, palette7),
            section7Caption2,
            _demoChromeBox(section7Demo2, palette7),
            section7Caption3,
            _demoChromeBox(section7Demo3, palette7),

            // SECTION 8
            section8Banner,
            section8Caption1,
            _demoChromeBox(section8Demo1, palette8),
            section8Caption2,
            _demoChromeBox(section8Demo2, palette8),
            section8Caption3,
            _demoChromeBox(section8Demo3, palette8),

            // SECTION 9
            section9Banner,
            section9Caption1,
            _demoChromeBox(section9Demo1, palette9),
            section9Caption2,
            _demoChromeBox(section9Demo2, palette9),
            section9Caption3,
            _demoChromeBox(section9Demo3, palette9),

            // SECTION 10
            section10Banner,
            section10Caption1,
            Row(
              children: <Widget>[
                Expanded(child: _demoChromeBox(section10DemoLeft, palette10)),
                Expanded(child: _demoChromeBox(section10DemoRight, palette10)),
              ],
            ),
            section10Caption2,
            Row(
              children: <Widget>[
                Expanded(child: _demoChromeBox(section10DemoBuilder, palette10)),
                Expanded(child: _demoChromeBox(section10DemoList, palette10)),
              ],
            ),

            // SECTION 11
            section11Banner,
            comparisonTable,

            // SECTION 12
            section12Banner,
            Column(children: glossaryItems),

            // EPILOGUE
            epilogue,
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}
