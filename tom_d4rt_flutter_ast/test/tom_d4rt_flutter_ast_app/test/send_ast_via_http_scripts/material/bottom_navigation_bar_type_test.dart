// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - BottomNavigationBarType (fixed vs shifting)
// Comprehensive demonstration of BottomNavigationBarType with real
// BottomNavigationBar widgets across multiple realistic scenarios.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BottomNavigationBarType Deep Demo ===');
  print('values: ${BottomNavigationBarType.values.length}');
  for (final type in BottomNavigationBarType.values) {
    print('  ${type.index}: ${type.name}');
  }
  print('foundation kReleaseMode: $kReleaseMode');

  // ==========================================================================
  // Scenario 1 / 2: top-level state for the canonical "fixed vs shifting"
  // pair of phone-frames.  Each frame manages its own currentIndex via a
  // StatefulBuilder so that real taps drive the BottomNavigationBar and you
  // can see the shifting animation visually move between items.
  // ==========================================================================

  final canonicalState = <String, int>{
    'fixed': 0,
    'shifting': 1,
  };

  // Scenario 3: auto-typed bars (3 items vs 5 items).
  final autoState = <String, int>{
    'three': 0,
    'five': 0,
  };

  // Scenario 5: customised colour palette bars all set to shifting.
  final paletteState = <String, int>{
    'palette_a': 0,
    'palette_b': 1,
    'palette_c': 2,
  };

  // Scenario 6: theme-driven bar.
  int themeIndex = 1;

  // Scenario 7: recipe gallery state.
  final recipeState = <String, int>{
    'news': 0,
    'music': 1,
    'productivity': 2,
  };

  // ==========================================================================
  // Shared helpers used by the scenario builders below.  These are inlined
  // closures so that the file remains a single self-contained build()
  // function with no external statefulness.
  // ==========================================================================

  Widget phoneFrame({
    required String title,
    required Color frameColour,
    required Color bodyColour,
    required Widget body,
    required BottomNavigationBar bar,
  }) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: frameColour,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF263238), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Fake AppBar inside the phone frame.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: frameColour,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.notifications_none,
                  color: Color(0xFFFFFFFF),
                  size: 18,
                ),
              ],
            ),
          ),
          // Body of the fake scaffold.
          Container(
            height: 160,
            color: bodyColour,
            padding: const EdgeInsets.all(12),
            child: body,
          ),
          // Real BottomNavigationBar at the bottom of the phone frame.
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            child: bar,
          ),
        ],
      ),
    );
  }

  Widget pageContent({
    required String label,
    required IconData icon,
    required Color colour,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colour.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colour.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: colour),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: colour,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String label, Color colour) {
    return Container(
      margin: const EdgeInsets.only(right: 4, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget sectionHeader({
    required String number,
    required String title,
    required String subtitle,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // Scenario 1 / 2: side-by-side fixed vs shifting (canonical) wrapped in
  // StatefulBuilders so the bar truly responds to taps.
  // ==========================================================================

  final canonicalItemsFixed = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Color(0xFF1565C0),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Explore',
      backgroundColor: Color(0xFF6A1B9A),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.library_music),
      label: 'Library',
      backgroundColor: Color(0xFF2E7D32),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      backgroundColor: Color(0xFFC62828),
    ),
  ];

  final canonicalItemsShifting = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Color(0xFF1565C0),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Explore',
      backgroundColor: Color(0xFF6A1B9A),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.library_music),
      label: 'Library',
      backgroundColor: Color(0xFF2E7D32),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      backgroundColor: Color(0xFFC62828),
    ),
  ];

  const canonicalLabels = ['Home', 'Explore', 'Library', 'Profile'];
  const canonicalIcons = [
    Icons.home,
    Icons.explore,
    Icons.library_music,
    Icons.person,
  ];
  const canonicalColours = [
    Color(0xFF1565C0),
    Color(0xFF6A1B9A),
    Color(0xFF2E7D32),
    Color(0xFFC62828),
  ];

  Widget canonicalFixedFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = canonicalState['fixed']!;
        return phoneFrame(
          title: 'type: fixed',
          frameColour: const Color(0xFF263238),
          bodyColour: const Color(0xFFECEFF1),
          body: pageContent(
            label: canonicalLabels[idx],
            icon: canonicalIcons[idx],
            colour: canonicalColours[idx],
          ),
          bar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: idx,
            backgroundColor: const Color(0xFFFFFFFF),
            selectedItemColor: const Color(0xFF1565C0),
            unselectedItemColor: const Color(0xFF90A4AE),
            selectedFontSize: 12,
            unselectedFontSize: 11,
            iconSize: 22,
            items: canonicalItemsFixed,
            onTap: (newIdx) {
              setLocal(() {
                canonicalState['fixed'] = newIdx;
              });
              print('canonical/fixed tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  Widget canonicalShiftingFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = canonicalState['shifting']!;
        return phoneFrame(
          title: 'type: shifting',
          frameColour: const Color(0xFF1A237E),
          bodyColour: const Color(0xFFE8EAF6),
          body: pageContent(
            label: canonicalLabels[idx],
            icon: canonicalIcons[idx],
            colour: canonicalColours[idx],
          ),
          bar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: idx,
            // backgroundColor is overridden by per-item backgroundColor when
            // type is shifting, so we keep the default white here.
            selectedItemColor: const Color(0xFFFFFFFF),
            unselectedItemColor: const Color(0xCCFFFFFF),
            selectedFontSize: 12,
            unselectedFontSize: 11,
            iconSize: 22,
            items: canonicalItemsShifting,
            onTap: (newIdx) {
              setLocal(() {
                canonicalState['shifting'] = newIdx;
              });
              print('canonical/shifting tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  // ==========================================================================
  // Scenario 3: 3-item vs 5-item bars with type: null (auto behaviour).
  // ==========================================================================

  final autoThreeItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Overview',
      backgroundColor: Color(0xFF00695C),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Reports',
      backgroundColor: Color(0xFF4527A0),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
      backgroundColor: Color(0xFFAD1457),
    ),
  ];

  final autoFiveItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.flash_on),
      label: 'Quick',
      backgroundColor: Color(0xFFE65100),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Calendar',
      backgroundColor: Color(0xFF1565C0),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'Chat',
      backgroundColor: Color(0xFF2E7D32),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.attach_money),
      label: 'Money',
      backgroundColor: Color(0xFF6A1B9A),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'More',
      backgroundColor: Color(0xFF424242),
    ),
  ];

  Widget autoThreeFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = autoState['three']!;
        return phoneFrame(
          title: '3 items / type: null',
          frameColour: const Color(0xFF00695C),
          bodyColour: const Color(0xFFE0F2F1),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome,
                  size: 28, color: Color(0xFF00695C)),
              const SizedBox(height: 6),
              Text(
                'Auto picks fixed (≤ 3 items)',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'currentIndex = $idx',
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
          bar: BottomNavigationBar(
            // type intentionally left null to demonstrate auto selection.
            currentIndex: idx,
            selectedItemColor: const Color(0xFF00695C),
            unselectedItemColor: const Color(0xFF80CBC4),
            items: autoThreeItems,
            onTap: (newIdx) {
              setLocal(() {
                autoState['three'] = newIdx;
              });
              print('auto/three tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  Widget autoFiveFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = autoState['five']!;
        return phoneFrame(
          title: '5 items / type: null',
          frameColour: const Color(0xFFE65100),
          bodyColour: const Color(0xFFFFF3E0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome,
                  size: 28, color: Color(0xFFE65100)),
              const SizedBox(height: 6),
              const Text(
                'Auto picks shifting (≥ 4 items)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBF360C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'currentIndex = $idx',
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
          bar: BottomNavigationBar(
            currentIndex: idx,
            selectedItemColor: const Color(0xFFFFFFFF),
            unselectedItemColor: const Color(0xCCFFFFFF),
            items: autoFiveItems,
            onTap: (newIdx) {
              setLocal(() {
                autoState['five'] = newIdx;
              });
              print('auto/five tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  // ==========================================================================
  // Scenario 4: visual difference matrix (static reference table).
  // ==========================================================================

  final differenceRows = <Map<String, dynamic>>[
    {
      'property': 'Background colour respect',
      'fixed': const ['Single bar bg only', Color(0xFF455A64)],
      'shifting': const ['Per-item bg fades in', Color(0xFFAD1457)],
    },
    {
      'property': 'Icon shifts on select?',
      'fixed': const ['No shift', Color(0xFF455A64)],
      'shifting': const ['Selected slides up', Color(0xFFAD1457)],
    },
    {
      'property': 'Label always visible?',
      'fixed': const ['Yes (all items)', Color(0xFF455A64)],
      'shifting': const ['Only selected', Color(0xFFAD1457)],
    },
    {
      'property': 'Per-item background',
      'fixed': const ['Ignored', Color(0xFF455A64)],
      'shifting': const ['Active', Color(0xFFAD1457)],
    },
    {
      'property': 'Used when',
      'fixed': const ['≤ 3 items', Color(0xFF455A64)],
      'shifting': const ['≥ 4 items', Color(0xFFAD1457)],
    },
    {
      'property': 'Selected item emphasis',
      'fixed': const ['Colour change only', Color(0xFF455A64)],
      'shifting': const ['Colour + size + slide', Color(0xFFAD1457)],
    },
    {
      'property': 'Designer intent',
      'fixed': const ['Equal weight tabs', Color(0xFF455A64)],
      'shifting': const ['Spotlight current', Color(0xFFAD1457)],
    },
  ];

  // ==========================================================================
  // Scenario 5: customised colour palettes, all type: shifting.
  // ==========================================================================

  final paletteAItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.spa),
      label: 'Calm',
      backgroundColor: Color(0xFF80DEEA),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.local_florist),
      label: 'Bloom',
      backgroundColor: Color(0xFFB2EBF2),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.water_drop),
      label: 'Hydrate',
      backgroundColor: Color(0xFF4DD0E1),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.cloud_queue),
      label: 'Float',
      backgroundColor: Color(0xFF26C6DA),
    ),
  ];

  final paletteBItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.local_fire_department),
      label: 'Fire',
      backgroundColor: Color(0xFFD84315),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bolt),
      label: 'Spark',
      backgroundColor: Color(0xFFE64A19),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.flash_on),
      label: 'Flash',
      backgroundColor: Color(0xFFFF7043),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.local_cafe),
      label: 'Brew',
      backgroundColor: Color(0xFFFF8A65),
    ),
  ];

  final paletteCItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.eco),
      label: 'Leaf',
      backgroundColor: Color(0xFF2E7D32),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.park),
      label: 'Tree',
      backgroundColor: Color(0xFF388E3C),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.grass),
      label: 'Grass',
      backgroundColor: Color(0xFF43A047),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.forest),
      label: 'Forest',
      backgroundColor: Color(0xFF66BB6A),
    ),
  ];

  Widget paletteFrame({
    required String key,
    required String title,
    required Color frame,
    required Color body,
    required Color selected,
    required Color unselected,
    required List<BottomNavigationBarItem> items,
  }) {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = paletteState[key]!;
        return phoneFrame(
          title: title,
          frameColour: frame,
          bodyColour: body,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: selected.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(items[idx].icon is Icon
                      ? (items[idx].icon as Icon).icon ?? Icons.circle
                      : Icons.circle, size: 32, color: selected),
                ),
                const SizedBox(height: 8),
                Text(
                  items[idx].label ?? '',
                  style: TextStyle(
                    color: selected,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          bar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: idx,
            selectedItemColor: selected,
            unselectedItemColor: unselected,
            items: items,
            onTap: (newIdx) {
              setLocal(() {
                paletteState[key] = newIdx;
              });
              print('palette/$key tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  // ==========================================================================
  // Scenario 6: BottomNavigationBarTheme integration.
  // ==========================================================================

  final themeBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_customize),
      label: 'Dashboard',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.insights),
      label: 'Insights',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_suggest),
      label: 'Settings',
    ),
  ];

  Widget themeFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        return Theme(
          data: ThemeData(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF311B92),
              selectedItemColor: Color(0xFFFFEE58),
              unselectedItemColor: Color(0xFFB39DDB),
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 8,
            ),
          ),
          child: phoneFrame(
            title: 'Theme-driven bar',
            frameColour: const Color(0xFF311B92),
            bodyColour: const Color(0xFFEDE7F6),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.palette,
                      size: 28, color: Color(0xFF311B92)),
                  const SizedBox(height: 6),
                  const Text(
                    'BottomNavigationBarTheme',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF311B92),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'currentIndex = $themeIndex',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            bar: BottomNavigationBar(
              currentIndex: themeIndex,
              items: themeBarItems,
              onTap: (newIdx) {
                setLocal(() {
                  themeIndex = newIdx;
                });
                print('theme bar tapped -> $newIdx');
              },
            ),
          ),
        );
      },
    );
  }

  // ==========================================================================
  // Scenario 7: recipe gallery with three "real product" examples.
  // ==========================================================================

  // Recipe A — News reader (4 items, fixed, muted palette).
  final newsItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.trending_up),
      label: 'Top',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: 'World',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.location_city),
      label: 'Local',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ];

  const newsHeadlines = [
    'Top — Markets steady ahead of central bank decision',
    'World — Coastal cities convene on climate cooperation',
    'Local — New tram line opens with free first week',
    'Profile — Reading streak 14 days, 28 saved articles',
  ];

  Widget newsFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = recipeState['news']!;
        return phoneFrame(
          title: 'News Reader (fixed)',
          frameColour: const Color(0xFF37474F),
          bodyColour: const Color(0xFFECEFF1),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF37474F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'BREAKING',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                newsHeadlines[idx],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Continue reading →',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF546E7A),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          bar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: idx,
            backgroundColor: const Color(0xFFFFFFFF),
            selectedItemColor: const Color(0xFF37474F),
            unselectedItemColor: const Color(0xFFB0BEC5),
            selectedFontSize: 11,
            unselectedFontSize: 10,
            iconSize: 20,
            items: newsItems,
            onTap: (newIdx) {
              setLocal(() {
                recipeState['news'] = newIdx;
              });
              print('news tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  // Recipe B — Music app (4 items, shifting, vibrant per-item palette).
  final musicItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'Home',
      backgroundColor: Color(0xFFE91E63),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
      backgroundColor: Color(0xFF9C27B0),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.library_music),
      label: 'Library',
      backgroundColor: Color(0xFF3F51B5),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.play_circle_fill),
      label: 'Player',
      backgroundColor: Color(0xFF00BCD4),
    ),
  ];

  const musicTracks = [
    'Home — Daily Mix 1',
    'Search — Trending: Lo-fi beats',
    'Library — Playlist: Focus',
    'Player — Now playing: Aurora',
  ];

  Widget musicFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = recipeState['music']!;
        return phoneFrame(
          title: 'Music App (shifting)',
          frameColour: const Color(0xFF6A1B9A),
          bodyColour: const Color(0xFFF3E5F5),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE91E63),
                          Color(0xFF9C27B0),
                          Color(0xFF3F51B5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.album,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicTracks[idx],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A148C),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Aurora — feat. Indigo',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF7B1FA2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1BEE7),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.42,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6A1B9A),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.skip_previous,
                      color: Color(0xFF6A1B9A), size: 22),
                  Icon(Icons.play_circle_fill,
                      color: Color(0xFF6A1B9A), size: 32),
                  Icon(Icons.skip_next,
                      color: Color(0xFF6A1B9A), size: 22),
                ],
              ),
            ],
          ),
          bar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: idx,
            selectedItemColor: const Color(0xFFFFFFFF),
            unselectedItemColor: const Color(0xCCFFFFFF),
            iconSize: 22,
            items: musicItems,
            onTap: (newIdx) {
              setLocal(() {
                recipeState['music'] = newIdx;
              });
              print('music tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  // Recipe C — Productivity (5 items, shifting, monochrome).
  final productivityItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.today),
      label: 'Today',
      backgroundColor: Color(0xFF212121),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.inbox),
      label: 'Inbox',
      backgroundColor: Color(0xFF424242),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.check_box),
      label: 'Tasks',
      backgroundColor: Color(0xFF616161),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Calendar',
      backgroundColor: Color(0xFF757575),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'More',
      backgroundColor: Color(0xFF9E9E9E),
    ),
  ];

  const productivityScreens = [
    'Today — 4 tasks due, 2 meetings',
    'Inbox — 17 unread, 3 flagged',
    'Tasks — Backlog: 23, Doing: 4, Done: 11',
    'Calendar — Week 18: 12 events',
    'More — Profile, Settings, About',
  ];

  Widget productivityFrame() {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final idx = recipeState['productivity']!;
        return phoneFrame(
          title: 'Productivity (shifting)',
          frameColour: const Color(0xFF212121),
          bodyColour: const Color(0xFFFAFAFA),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productivityScreens[idx].split('—').first.trim(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                productivityScreens[idx].split('—').last.trim(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF424242),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Quarterly review — 14:00',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9E9E9E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '1:1 with Lena — 16:30',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: idx,
            selectedItemColor: const Color(0xFFFFFFFF),
            unselectedItemColor: const Color(0xCCFFFFFF),
            iconSize: 20,
            selectedFontSize: 11,
            unselectedFontSize: 10,
            items: productivityItems,
            onTap: (newIdx) {
              setLocal(() {
                recipeState['productivity'] = newIdx;
              });
              print('productivity tapped -> $newIdx');
            },
          ),
        );
      },
    );
  }

  // ==========================================================================
  // ROOT BUILD
  // ==========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BottomNavigationBarType Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('BottomNavigationBarType — Deep Demo'),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================================================================
              // HERO HEADER
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BottomNavigationBarType',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'fixed vs shifting — controls layout/behaviour of '
                      'BottomNavigationBar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFC5CAE9),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: [
                        chip('values: 2', const Color(0x33FFFFFF)),
                        chip('fixed', const Color(0xFF455A64)),
                        chip('shifting', const Color(0xFFAD1457)),
                        chip('auto by item count',
                            const Color(0xFF00897B)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 1 + 2: CANONICAL FIXED VS SHIFTING
              // ================================================================
              sectionHeader(
                number: '1',
                title: 'Canonical fixed vs shifting (interactive)',
                subtitle:
                    'Side-by-side phone frames. Tap items in either bar to '
                    'see the difference. Shifting animates the selected item; '
                    'fixed keeps every label visible at equal width.',
                accent: const Color(0xFF1A237E),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  canonicalFixedFrame(),
                  canonicalShiftingFrame(),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF9FA8DA)),
                ),
                child: const Text(
                  'Both frames render real BottomNavigationBar widgets and '
                  'use StatefulBuilder so taps drive currentIndex. Use the '
                  'fixed bar when you want every label to remain visible '
                  '(typical "tabs" feel). Use shifting when you want the '
                  'selected destination to feel highlighted with motion.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF1A237E)),
                ),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 3: ITEM-COUNT BEHAVIOUR
              // ================================================================
              sectionHeader(
                number: '3',
                title: 'Item-count behaviour (type: null)',
                subtitle:
                    'When you do not pass a type, Flutter picks one for you '
                    'based on the number of items.',
                accent: const Color(0xFF00695C),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  autoThreeFrame(),
                  autoFiveFrame(),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2F1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '≤ 3 items → Flutter automatically picks fixed.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF004D40),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '≥ 4 items → Flutter automatically picks shifting.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFBF360C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 4: VISUAL DIFFERENCE MATRIX
              // ================================================================
              sectionHeader(
                number: '4',
                title: 'Visual difference matrix',
                subtitle:
                    'Static side-by-side reference of fixed vs shifting.',
                accent: const Color(0xFF455A64),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCFD8DC)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Property',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'fixed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color(0xFF455A64),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'shifting',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color(0xFFAD1457),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 18),
                    for (final row in differenceRows)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                row['property'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF263238),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: (row['fixed'] as List)[1] as Color,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    (row['fixed'] as List)[0] as String,
                                    style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: (row['shifting'] as List)[1]
                                        as Color,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    (row['shifting'] as List)[0] as String,
                                    style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 5: CUSTOMISED COLOUR PALETTE
              // ================================================================
              sectionHeader(
                number: '5',
                title: 'Customised colour palettes (all shifting)',
                subtitle:
                    'Three shifting bars sharing the same enum value, but '
                    'each with its own selected/unselected/per-item colours. '
                    'Demonstrates how the enum interacts with theming.',
                accent: const Color(0xFFAD1457),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  paletteFrame(
                    key: 'palette_a',
                    title: 'Wellness — cool palette',
                    frame: const Color(0xFF00838F),
                    body: const Color(0xFFE0F7FA),
                    selected: const Color(0xFFFFFFFF),
                    unselected: const Color(0xCCFFFFFF),
                    items: paletteAItems,
                  ),
                  paletteFrame(
                    key: 'palette_b',
                    title: 'Energy — warm palette',
                    frame: const Color(0xFFD84315),
                    body: const Color(0xFFFFF3E0),
                    selected: const Color(0xFFFFFFFF),
                    unselected: const Color(0xCCFFFFFF),
                    items: paletteBItems,
                  ),
                  paletteFrame(
                    key: 'palette_c',
                    title: 'Nature — greens',
                    frame: const Color(0xFF2E7D32),
                    body: const Color(0xFFE8F5E9),
                    selected: const Color(0xFFFFFFFF),
                    unselected: const Color(0xCCFFFFFF),
                    items: paletteCItems,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 6: BottomNavigationBarTheme INTEGRATION
              // ================================================================
              sectionHeader(
                number: '6',
                title: 'BottomNavigationBarTheme integration',
                subtitle:
                    'A Theme override sets type, colours and label style. '
                    'The widget itself does not pass any of those, so the '
                    'theme wins.',
                accent: const Color(0xFF311B92),
              ),
              const SizedBox(height: 12),
              Center(child: themeFrame()),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF9575CD)),
                ),
                child: const Text(
                  'BottomNavigationBarThemeData(type: fixed) is set on the '
                  'enclosing Theme, so this BottomNavigationBar runs in '
                  'fixed mode even with no `type:` argument on the widget.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF311B92)),
                ),
              ),

              const SizedBox(height: 24),

              // ================================================================
              // SECTION 7: RECIPE GALLERY
              // ================================================================
              sectionHeader(
                number: '7',
                title: 'Recipe gallery — three real product designs',
                subtitle:
                    'News reader (fixed, muted), Music app (shifting, '
                    'vibrant), Productivity (shifting, monochrome).',
                accent: const Color(0xFF6A1B9A),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Column(
                    children: [
                      newsFrame(),
                      Container(
                        width: 280,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECEFF1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'News: fixed keeps every section a tap away with '
                          'equal visual weight — readers care about access, '
                          'not motion.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF37474F),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      musicFrame(),
                      Container(
                        width: 280,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Music: shifting plus per-item backgroundColor '
                          'creates a playful colour transition matching the '
                          'expressive brand.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      productivityFrame(),
                      Container(
                        width: 280,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: const Color(0xFFBDBDBD)),
                        ),
                        child: const Text(
                          'Productivity: 5 destinations need shifting; the '
                          'monochrome palette keeps focus on the content '
                          'and the active section subtle.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================================================================
              // ENUM REFERENCE
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF263238),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BottomNavigationBarType.values',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final t in BottomNavigationBarType.values)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: t == BottomNavigationBarType.fixed
                                    ? const Color(0xFF455A64)
                                    : const Color(0xFFAD1457),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '${t.index}',
                                  style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'BottomNavigationBarType.${t.name}',
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ================================================================
              // SUMMARY
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF311B92)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Summary',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• fixed → equal-width items, all labels visible, no '
                      'motion on selection. Best for ≤ 3 destinations.',
                      style: TextStyle(
                          color: Color(0xFFE8EAF6), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• shifting → selected item is emphasised with '
                      'motion and uses per-item backgroundColor. Best for '
                      '≥ 4 destinations or expressive brands.',
                      style: TextStyle(
                          color: Color(0xFFE8EAF6), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• type: null → Flutter auto-selects fixed for ≤ 3, '
                      'shifting for ≥ 4 items.',
                      style: TextStyle(
                          color: Color(0xFFE8EAF6), fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• BottomNavigationBarTheme can set the type globally '
                      'so widgets do not need to pass it explicitly.',
                      style: TextStyle(
                          color: Color(0xFFE8EAF6), fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Deep Demo • BottomNavigationBarType • Material',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}
